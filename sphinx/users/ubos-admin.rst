Command reference
=================

``ubos-admin`` is the central administration command for UBOS.  When invoked without arguments,
it lists available sub-commands.

To invoke an ``ubos-admin`` sub-command, execute:

.. code-block:: none

   % sudo ubos-admin <subcommand> <arguments>

To obtain help on a particular sub-command, execute:

.. code-block:: none

   % sudo ubos-admin <subcommand> --help

For technical details how these sub-commands work, refer to :doc:`../developers/understanding-ubos-admin`
in :doc:`../developers/index`.

``ubos-admin backup``
---------------------

To create a backup of all :term:`Sites <Site>` on your device and save it to ``all.ubos-backup``:

.. code-block:: none

   % sudo ubos-admin backup --out all.ubos-backup

To create a backup of all :term:`Sites <Site>` on your device and save it to a file in your home directory
whose name contains the current timestamp:

.. code-block:: none

   % sudo ubos-admin backup --out ~/all-$(date +%Y%m%d%H%M).ubos-backup

To create a backup of a single :term:`Site` and save it to a file:

.. code-block:: none

   % sudo ubos-admin backup --hostname <hostname> --out <backupfile>

or

.. code-block:: none

   % sudo ubos-admin backup --siteid <siteid> --out <backupfile>

To create a backup or a single :term:`AppConfiguration` at a :term:`Site` and save it to a file:

.. code-block:: none

   % sudo ubos-admin backup --appconfigid <siteid> --out <backupfile>

You can determine the :term:`SiteId` or :term:`AppConfigId` with ``ubos-admin listsites``.

``ubos-admin backup-to-amazon-s3``
----------------------------------

Make sure package ``amazons3`` is installed:

.. code-block:: none

   % sudo pacman -S amazons3

To create a backup and automatically upload it to Amazon S3, use the same
options as for ``ubos-admin backup``. In addition, you can use:

* ``--encryptid <keyid>``: encrypt the backup before uploading with a GPG
  key with that id found in your GPG key store. Make sure you have access
  to the private key even once your device has died, otherwise your backup
  will be useless. WARNING: There are no recovery options other than you
  protecting your private key.

* ``--bucket <bucket>``: specify the name of the S3 bucket to store the
  backup to.

If you do not specify those options, UBOS will use the ones you used the last time you
ran this command on this device. If you have never run it before, UBOS will ask you.

For more details, refer to :doc:`../users/backup`.

``ubos-admin backupinfo``
-------------------------

To determine the content of a ``.ubos-backup`` file:

.. code-block:: none

   % ubos-admin backupinfo --in <backupfile>

``ubos-admin createsite``
-------------------------

To create and deploy a new :term:`Site` running one :term:`App`:

.. code-block:: none

   % sudo ubos-admin createsite

and answer the questions at the terminal.

To create and deploy a new :term:`Site`, running one :term:`App` and secured by a self-signed SSL/TLS certificate:

.. code-block:: none

   % sudo ubos-admin createsite --tls --selfsigned

and answer the questions at the terminal.

To create and deploy a new :term:`Site`, running one :term:`App` and secured by a
`letsencrypt.org <https://letsencrypt.org/>`_ SSL/TLS certificate:

.. code-block:: none

   % sudo ubos-admin createsite --tls --letsencrypt

and answer the questions at the terminal.

To create and deploy a new :term:`Site`, running one :term:`App` and secured by an official SSL/TLS certificate,
make sure you have private key and certificate files on the UBOS device, then:

.. code-block:: none

   % sudo ubos-admin createsite --tls

and answer the questions at the terminal.

To only create a :doc:`../developers/site-json` file, append a ``-n`` or ``--dry-run``
argument. To save the :doc:`../developers/site-json` file to a file, instead of
emitting it on the console, append ``--out <filename>`` with a suitable filename.

To create a :term:`Site` from a :term:`Site` template file:

.. code-block:: none

   % sudo ubos-admin createsite --from-template <template>

``ubos-admin deploy``
---------------------

If you have a Site JSON file for a :term:`Site`, you can deploy the :term:`Site` and all :term:`Apps <App>` defined
for this :term:`Site` with:

.. code-block:: none

   % sudo ubos-admin deploy --file <site.json>

To obtain a Site JSON file, either:

* export the Site JSON file for an existing :term:`Site` with ``ubos-admin showsite --json --site <siteid>``
* create (but do not deploy) a Site JSON file with ``ubos-admin createsite --dry-run``
* manually create a Site JSON file; see :doc:`../developers/site-json`.

You can take an existing Site JSON file, and edit it by, for example:

* changing the hostname
* adding or removing :term:`Apps <App>` running at the :term:`Site`
* changing some of the :term:`AppConfiguration`, such as the path at which the :term:`App` runs, or
  some of its customization points.

Currently, this needs to be performed using a text editor.

Then, deploy it again with ``ubos-admin deploy --file <site.json>``. UBOS will find out
what changed, and make appropriate adjustments.

.. warning:: If you remove an :term:`App` from a Site JSON file, and redeploy the Site JSON,
   the data of the removed :term:`App` at this :term:`Site` will be deleted. There will be no warning.
   So save the data with ``ubos-admin backup`` first.

If you redeploy an existing :term:`Site` with an existing, or new Site JSON file, you can create
a backup of the old :term:`Site` configuration and content with:

.. code-block:: none

   % sudo ubos-admin deploy --file <site.json> --backup <backupfile>

``ubos-admin hostid``
---------------------

Displays a unique identifier for the device. It is is the fingerprint of the device's
GPG public key. This hostid is used to identify the device in the ``flock`` directory
on the :doc:`UBOS staff <shepherd-staff>`.

Note: this is a different key than the one used by the shepherd to log into the device.

``ubos-admin init-staff``
-------------------------

Turns a USB disk device into a :doc:`UBOS Staff <shepherd-staff>`. This erases all
existing content on the USB disk, so do not use a UBOS Staff device for any other
purpose. Invoke as:

.. code-block:: none

   % sudo ubos-admin init-staff <device>


``ubos-admin listnetconfigs``
-----------------------------

This command shows all network configurations that UBOS could activate for the current
device. For example, if your device has two Ethernet interfaces, your device could be
used as a router, while this would be impossible if the device had only one Ethernet
interface. Invoke:

.. code-block:: none

   % ubos-admin listnetconfigs

To set one of these netconfigs, execute ``ubos-admin setnetconfig``.

More network configurations may be available in packages not currently installed.

``ubos-admin listsites``
------------------------

To see all :term:`Sites <Site>` and :term:`Apps <App>` currently deployed on the device, invoke:

.. code-block:: none

   % sudo ubos-admin listsites

This will list hostnames, siteids, whether or not the :term:`Site` has SSL/TLS enabled,
:term:`Apps <App>` installed at the various :term:`Sites <Site>`, their appconfigids, and the relative context
paths.

For example:

.. code-block:: none

   % ubos-admin listsites
   Site: example.com (s20da71ce7a6da5500abd338984217cdc8a61f8de)
       Context:           /guestbook (ab274f22ba2bcab61c84e78d944f6cdd7239a999e): gladiwashere
       Context:           /blog (a9eef9bbf4ba932baa1b500cf520da91ca4703e26): wordpress
   Site: example.net (s7ad346408fed73628fcbe01d777515fdd9b1bcd2)
       Context:           /foobar (a6e51ea98c23bc701fb10339c5991224e2c75ff3b): gladiwashere

On this device, two :term:`Sites <Site>` (aka virtual hosts) are hosted. The first :term:`Site`, responding
to ``example.com``, runs two :term:`Apps <App>`: the Glad-I-Was-Here guestbook, and Wordpress, at the
URLs ``http://example.com/guestbook`` and ``http://example.com/blog``,
respectively. The second :term:`Site` at ``example.net``, runs a second, independent instance
of Glad-I-Was-Here at ``http://example.net/foobar``.

``ubos-admin read-configuration-from-staff``
--------------------------------------------

Performs the same operations without rebooting that the UBOS device would perform during
boot when a :doc:`UBOS staff <shepherd-staff>` is present, such as setting up a shepherd
account.

Invoke as:

.. code-block:: none

   % sudo ubos-admin read-configuration-from-staff <device>

``ubos-admin restore``
----------------------

To restore all :term:`Sites <Site>` and :term:`Apps <App>` contained in a previously created backup file that
you have on your device, invoke:

.. code-block:: none

   % sudo ubos-admin restore --in <backupfile>

If your backup is available on-line at a URL instead, invoke:

.. code-block:: none

   % sudo ubos-admin restore --url <url-to-backupfile>

Either command will not overwrite existing :term:`Sites <Site>` or :term:`Apps <App>`; if you wish to replace them, you
need to undeploy them first with ``ubos-admin undeploy``.

To only restore a single :term:`Site` (of several) contained in the same backup file, specify
the ``--siteid`` or ``--hostname`` as an argument:

.. code-block:: none

   % sudo ubos-admin restore --siteid <siteid> --in <backupfile>

If one or more :term:`Apps <App>` were upgraded since the backup was created, UBOS attempts to
transparently upgrade the data during the restore operation.

This command has many other ways of invocation; please refer to:

.. code-block:: none

   % sudo ubos-admin restore --help

``ubos-admin setnetconfig``
---------------------------

Sets a network configuration for your device. Some of these networking configurations
require the installation of additional ``ubos-networking-XXX`` packages. To determine
the currently installed and available networking configurations, execute
``ubos-admin listnetconfigs``.

To switch networking off:

.. code-block:: none

   % sudo ubos-admin setnetconfig off

To configure all network interfaces to automatically obtain IP addresses via DHCP, if
possible:

.. code-block:: none

   % sudo ubos-admin setnetconfig client

To assign static IP addresses to all network interfaces:

.. code-block:: none

   % sudo ubos-admin setnetconfig standalone

If your device has two Ethernet interfaces and you would like to use it as a home
gateway/router:

.. code-block:: none

   % sudo ubos-admin setnetconfig gateway


``ubos-admin setup-shepherd``
-----------------------------

This command is particularly useful if you run UBOS in a Linux container.

.. code-block:: none

   % sudo ubos-admin setup-shepherd '<public-ssh-key>'

will create the :doc:`UBOS shepherd <shepherd-staff>`, and allow ssh login with the provided public ssh key.
The ssh key, although long, needs to be provided on the command-line, and in quotes.

.. code-block:: none

   % sudo ubos-admin setup-shepherd --add-key '<public-ssh-key>'

will add a public ssh key and not overwrite any public ssh key already on the shepherd's
account.

``ubos-admin showappconfig``
----------------------------

To see information about a currently deployed single :term:`AppConfiguration`, invoke:

.. code-block:: none

   % sudo ubos-admin showappconfig --host <hostname> --context <path>

such as:

.. code-block:: none

   % sudo ubos-admin showappconfig --host example.com --context /blog

``ubos-admin shownetconfig``
----------------------------

To see information about the current network configuration, run:

.. code-block:: none

   % ubos-admin shownetconfig

This lists all attached network interfaces, and various attributes such as whether
the interface uses DHCP, allows :term:`App` access etc.

``ubos-admin showsite``
-----------------------

To see information about a currently deployed :term:`Site` and its :term:`Apps <App>`, invoke:

.. code-block:: none

   % ubos-admin showsite --siteid <siteid>

or

.. code-block:: none

   % ubos-admin showsite --host <hostname>

For example:

.. code-block:: none

   % ubos-admin showsite --siteid s20...
   Site: example.com (s20da71ce7a6da5500abd338984217cdc8a61f8de)
       Context:           /guestbook (ab274f22ba2bcab61c84e78d944f6cdd7239a999e): gladiwashere
       Context:           /blog (a9eef9bbf4ba932baa1b500cf520da91ca4703e26): wordpress

This :term:`Site` responds to ``example.com`` and runs two :term:`Apps <App>`: the Glad-I-Was-Here guestbook, and
Wordpress, at the URLs ``http://example.com/guestbook`` and ``http://example.com/blog``,
respectively. Nothing is being said about other :term:`Sites <Site>` that may or may not run on the same
device.

``ubos-admin start-pagekite``
-----------------------------

To allow access from the public internet to one or more of the sites on your device using
the pagekite.net service, install package ``pagekite`` and execute:

.. code-block:: none

   % sudo ubos-admin start-pagekite --kitesecret <SSS> <NNN>

where ``<NNN>`` is the name of your primary kite (e.g. ``johndoe.pagekite.me``)
and ``<SSS>`` is the secret for the name. You can find both of them on the
pagekite.net website after you have logged into your account there.

``ubos-admin status``
---------------------

To print interesting information about the device, such as available disk and memory,
invoke:

.. code-block:: none

   % sudo ubos-admin status --all


``ubos-admin status-pagekite``
------------------------------

Shows you the status of pagekite on your device if you have installed it. See
``ubos-admin start-pagekite`` above.

``ubos-admin stop-pagekite``
----------------------------

Stops pagekite on your device if you have installed and activated it it. See
``ubos-admin start-pagekite`` above.

``ubos-admin undeploy``
-----------------------

To undeploy an existing :term:`Site` and all :term:`Apps <App>` running at this :term:`Site` as if they had never
existed, invoke:

.. code-block:: none

   % sudo ubos-admin undeploy --siteid <siteid>

or:

.. code-block:: none

   % sudo ubos-admin undeploy --host <hostname>

.. warning:: Undeploying a :term:`Site` is like ``rm -rf``. All the data at the :term:`Site` will be lost.
   To retain the data, first run ``ubos-admin backup`` before undeploying (see :doc:`backup`)

If you want to create a backup of the :term:`Site` before it is undeployed:

.. code-block:: none

   % sudo ubos-admin undeploy ... --backup <backupfile>


``ubos-admin update``
---------------------

To upgrade all code on your device to the latest version, invoke:

.. code-block:: none

   % sudo ubos-admin update

This may cause your device to reboot, depending on what code is being updated.

If you would like to create a backup of all :term:`Sites <Site>` on the device as they were before the
update:

.. code-block:: none

   % sudo ubos-admin update ... --backup <backupfile>

``ubos-admin write-configuration-to-staff``
-------------------------------------------

Saves information about the current device to the :doc:`UBOS Staff <shepherd-staff>` in
directory ``flock/<HOSTID>`` where ``<HOSTID>`` is a unique identifier for the current device
(the same as printed by ``ubos-admin hostid``).

The saved information includes current IP address, device class, SSH server-side keys
and others.
