How to use Storj/Tardigrade on UBOS
===================================

About Storj and Tardigrade
--------------------------

`Storj <https://storj.io/>`_ is open-source, decentralized cloud storage technology
developed by Storj (the company). The company also operates
`Tardigrade <https://tardigrade.io/>`_, a commercial brokerage between sellers and
renters of distributed file storage space based on the Storj technology, with a
service-level agreement and a business model. In early 2020, UBOS has started to
provide Storj and Tardigrade on the "yellow" release channel (Note: the UBOS
implementation may change before a release on "green").

Tardigrade has similar functionality to the Amazon Web Services'
`Simple Storage Service (Amazon S3) <https://en.wikipedia.org/wiki/Amazon_S3>`_, but
instead of uploading all your data to a big company (Amazon), Tardigrade acts as a
mediator between lots of users who want to store data, and lots of users offering spare
hard drive capacity to other users. One could say Tardigrade is a decentralized version
of Amazon S3 with Storj as the market maker.

All data on the Tardigrade network is encrypted with a password that only the uploader
knows, so your data remains private there. Through some sophisticated algorithms, the
Tardigrade network has highly efficient redundancy, which means it's unlikely you lose
your data even if some of the servers on the Tardigrade network go down.

Three major use cases for Tardigrade are supported on UBOS today:

* using Tardigrade as an "offsite" location for backups of the valuable data on your
  UBOS device. This is functionality quite similar to when you :doc:`backup <backup>`
  your UBOS device to Amazon S3, but instead of using Amazon's servers, you use
  space on the disks of other Tardigrade users.

* using Tardigrade as Nextcloud "external storage" if you run Nextcloud on UBOS.
  That way, you can manage more data in your Nextcloud installation than you might
  have room for on your own disk.

* offering spare disk capacity to other Tardigrade users, and make some money in
  the process.

For details on Storj and Tardigrade, including cost/revenue, uptime and
other requirements, please consult `their <https://storj.io/>`_
`websites <https://tardigrade.io/>`_. Note that while we provide the code on
UBOS, Storj and Tardigrade are third-party products and services for which
Indie Computing cannot take any responsibility.

Description how to set up each of these use cases follows.

Installing Storj
----------------

As Storj is provided on UBOS, installing it is simple:

.. code-block:: none

   % sudo pacman -S storj

Note: this is currently only available on the "yellow" release channel.

About command names
-------------------

Note: The Storj documentation refers to executables such as ``uplink_linux_amd64``
(on ``x86_64``) and ``uplink_linux_arm`` (on ARM(). These are available on UBOS and you
can use them just as described in their documentation.

However, UBOS also provides commands named ``storj-xxx`` (``uplink_xxx_yyy`` becomes
``storj-uplink``, and similar for the other executables), and you are encouraged to
use them instead on UBOS. They do the same thing as the Storj executables, except that:

* You can easily run them with ``sudo``.

* Your configuration files automatically get stored in ``/etc/storj``,
  rather than the ``shepherd`` users's home directory. That makes it much simpler
  to run Storj services such as the gateway persistently as a daemon using systemd
  (see below).

* It is (somewhat) more secure.

How to sign up for Storj/Tardigrade
-----------------------------------

Note: this largely follows the
`Tardigrade documentation <https://documentation.tardigrade.io/setup/account>`_
and you are encouraged to learn more details there than are given here.

* Get an account at `tardigrade.io <https://tardigrade.io/>`_ and select
  a "Satellite" that is close to your location. Log into the Satellite website.

* On that website, create a project.

* One that website, create an API key. Store your API key in a safe place, such
  as in your password manager.

Configure Tardigrade on your UBOS device
----------------------------------------

The following command is to be executed on the UBOS device. Because it  involves long
cryptographic keys, it is recommended you ``ssh`` into your UBOS device from the computer
on which you have saved your API keys, so you can copy-paste them into the right
locations when needed. That beats typing them in on the console, one character at a time.
For ``ssh`` instructions, see :doc:`howto-ssh`.

* Run the Storj setup:

  .. code-block:: none

     % sudo storj-gateway setup

* Answer the questions that the program asks, such as for satellite and API
  key. Set an encryption passphrase and make sure you store that in a safe place
  as well (such as your password manager). In doubt, refer to the
  Tardigrade documentation.

How to run the Storj/Tardigrade gateway
---------------------------------------

Storj has a software component that lets you, and any software, interact with the Tardigrade
network as if it was Amazon S3. On UBOS, you are encouraged to run this gateway as a
systemd service. This means that it runs in the background and automatically comes
up again after you reboot your UBOS device, so everything goes back to how it was
before reboot.

First, make sure you have signed up for a Tardigrade account, and you have
configured Tardigrade as described above.

Then, run the Storj Systemd service we provide on UBOS:

.. code-block:: none

   % sudo systemctl enable --now storj-gateway.service

To check whether the gateway is working as intended, run:

.. code-block:: none

   % sudo systemctl status storj-gateway.service

There's lots of output; the important part is that it says "Active: active (running)".
To examine reasons for any errors, you can run:

.. code-block:: none

   % sudo journalctl -u storj-gateway.service

If you ever wanted to stop the Storj gateway, run:

.. code-block:: none

   % sudo systemctl disable --now storj-gateway.service


How to create a bucket on Tardigrade
------------------------------------

Like Amazon S3, Storj/Tardigrade groups data in "buckets" on its network.

To show buckets on your account, execute:

.. code-block:: none

   % sudo storj-uplink ls

To create a new bucket called ``my-backups``, execute:

.. code-block:: none

   % sudo storj-uplink mb sj://my-backups

(Use a bucket name other than ``my-backups``.)

How to determine the credentials to be used with the gateway
------------------------------------------------------------

When you want to run a backup to Tardigrade, or use Tardigrade as an external
storage for Nextcloud, you need to know the credentials to use for the gateway
(these are different from the API key above).

In the Tardigrade documentation, it states that these credentials are printed
to the console when you start the gateway. However, if you followed the
instructions here to start the gateway as a daemon in the background with
systemd, there is no terminal output. Instead, we provide an
additional command for that purpose:

.. code-block:: none

   % sudo storj-gateway-credentials

which will print them to the terminal.

How to back up your UBOS device to Tardigrade (first time)
----------------------------------------------------------

First, make sure you have a suitable "bucket" on Tardigrade to store your backup to
as described above.

Then, determine your gateway credentials as described above.

Then, run your backup using a destination URL that starts with ``sj://my-backups``
(well, the actual name you are using), specifying your access key you obtained from
the previous command. We use ``1234``` in this example:

.. code-block:: none

   % sudo ubos-admin backup --all --backuptodir sj://my-backups --access-key-id 1234

When asked for the private access key, enter that as well.

How to back up your UBOS device to Tardigrade (after the first time)
--------------------------------------------------------------------

Just like when you back up to Amazon S3 or other destinations, UBOS remembers
the credentials you used, and you do not need to specify them any more, so you
can run future backups with a command such as:

.. code-block:: none

   % sudo ubos-admin backup --all --backuptodir sj://my-backups

How to restore your backup
--------------------------

Copy the Storj file onto your local disk first, with a command such as:

.. code-block:: none

   % sudo storj-uplink cp sj://my-backups/test.ubos-backup .

and then invoke ``restore``, such as:

.. code-block:: none

   % sudo ubos-admin restore --in test.ubos-backup

How to use Tardigrade as "external storage" for Nextcloud
---------------------------------------------------------

Make sure the Storj/Tardigrade gateway is running on your UBOS device
as descrived above.

Determine your gateway credentials as described above.

Then, log into your Nextcloud installation on UBOS, select "Apps" from
the menu in the upper-right corner, and enable the "External storage
support" app.

Then, configure Nextcloud to use the gateway. Select "Settings" from
the menu in the upper-right corner, and then "External Storages" from
the "Administration" section in the sidebar on the left (not: "External
storages" from the "Personal" section).

In the form that comes up on the right:

* enter a name for the folder as you want it to show up for your
  Nextcloud users (e.g. "Tardigrade");

* select "Amazon S3" in the "External storage" column;

* select "Access key" in the "Authentication" column;

* in the "Configuration" column, enter:

  * the name of a bucket you want to use here, such as ``nextcloud``.
    This may fail if the bucket exists already, so pick a new name.

  * the Hostname must be "localhost"

  * the Port must be "7777"

  * the Region can remain empty

  * do NOT enable SSL (not needed; all happens on your UBOS device itself)

  * leave the other checkboxes unchecked

  * enter the access key and the secret key you determined earlier

* In the "Available for" column, leave the default or restrict
  access to particular users.

* Click the checkbox on the right of the row.

The icon on the left of the row should now turn green, and setup is complete.

Your Tardigrade bucket should now show up as a folder next to your other files
and folders when you browse Nextcloud files. You can use it like any other
folder, except that the data is stored on Tardigrade, not on your local disk.

How to offer spare disk capacity to other Tardigrade users
----------------------------------------------------------

Prerequisites
^^^^^^^^^^^^^

Make sure you have the following:

* An Ethereum address
* A Storj Node invitation
* Docker is installed on your UBOS device.

If you have not installed Docker before, execute:

.. code-block:: none

   % sudo pacman -S docker
   % sudo systemctl start docker.service

Creating a Storj Node identity
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can create a Storj Node identity with:

.. code-block:: none

   % sudo storj-identity create storagenode

This may take several hours, depending on the speed of your device.

Then, authorize and confirm the identity as described in the
`Tardigrade documentation here <https://documentation.storj.io/dependencies/identity#authorize-the-identity>`_
and the following sections,  but use ``storj-identity`` instead of ``identity_xxx_yyy``.

Back up the identity to an external disk as described.

Open up and forward the Storj port
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You need to tell UBOS to open up the Storj port in the firewall that
all UBOS devices run by default. To do that, become root, and then:

.. code-block:: none

   # echo 28967/tcp > /etc/ubos/open-ports.d/storj
   # ubos-admin update

In addition, iff your UBOS device is not directly connected to the internet and
behind a firewall, open up a port on the firewall that routes to the same port on your
UBOS device. This is described in the
`Tardigrade documentation on port forwarding <https://documentation.storj.io/dependencies/port-forwarding>`_.

However, we recommend using ``ddclient`` as your Dynamic DNS tool. This is described
:doc:`networking`.

Selecting a data directory for hosted files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Decide on a directory below which you will store the data you host for
other Tardigrade users. We recommend directory ``/ubos/lib/storj``, which UBOS
created for you when you installed ``storj``. Make sure that the disk containing
that directory has enough free space. If you use an external disk, follow the
Storj instructions for how to mount it correctly.

Note:  According to information provided by Storj, Storj/Tardigrade currently
does not support restoring hosted data from backups at all. Thus, you do not need to
back this directory up. UBOS backups created with ``ubos-admin backup`` also do
not include Storj/Tardigrade data that you host for other users.

Then, move the generated certificate into that directory, such as by becoming
root, and executing:

.. code-block:: none

   # mv /root/.local/share/storj/identity/storagenode/ca.key /ubos/lib/storj/identity/

Run the Docker container
^^^^^^^^^^^^^^^^^^^^^^^^

Execute:

.. code-block:: none

   % sudo docker run -d --restart unless-stopped -p 28967:28967 \
       -p 127.0.0.1:14002:14002 \
       -e WALLET="0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" \
       -e EMAIL="user@example.com" \
       -e ADDRESS="domain.ddns.net:28967" \
       -e BANDWIDTH="20TB" \
       -e STORAGE="2TB" \
       --mount type=bind,source=/ubos/lib/storj/identity,destination=/app/identity \
       --mount type=bind,source=/ubos/lib/storj/storage,destination=/app/config \
       --name storagenode storjlabs/storagenode:beta

where you replace the wallet address, e-mail address, dynamic DNS address of your
UBOS device, the parameters for maximum data transfer per month (bandwidth) and
maximum allocated storage. If you used different directories, also replace the
directory names.

Check on the status of your Storj node
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Determine the name of your Docker container, and then look at the logs:

.. code-block:: none

   % sudo docker ps -a
   xxxxxxxx
   % sudo docker logs xxxxxxxx

where you replace ``xxxxxxxx`` with what was printed to the terminal by the first
command.

To stop running your Storj node
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: none

   % sudo docker rm xxxxxxxx

where you replace ``xxxxxxxx`` with what was printed to the terminal by ``docker ps``.

Don't forget to close the port in the UBOS firewall again that you had opened earlier.
As root, delete file ``/etc/ubos/open-ports.d/storj`` and run

.. code-block:: none

   % sudo ubos-admin update

