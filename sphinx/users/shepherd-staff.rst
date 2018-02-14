The UBOS Staff
==============

Overview
--------

The UBOS Staff allows the secure installation and configuration of UBOS devices without
ever having to attach a keyboard or monitor to the device. This is particularly convenient
for physical hardware that is "hidden away" somewhere from a desk where a monitor and
keyboard can be easily connected.

In particular, the UBOS Staff can be used:

* to provision an administrator account on the device called the :term:`Shepherd` account,
  into which the user can ``ssh`` over the network. Either existing ssh credentials provided by
  the user can be used, or UBOS can generate a new key pair automatically.

* to connect to a WiFi access point with credentials provided by the user on the UBOS Staff;

* to automatically install and configure a site upon boot.

The UBOS Staff is simply a standard USB flash drive whose name and directory layout follows
certain conventions. A similar mechanism is available for virtualized machines.

See also `blog post <http://upon2020.com/blog/2015/03/ubos-shepherd-rules-their-iot-device-flock-with-a-staff/>`_
with a longer discussion.

UBOS Staff device format and name
---------------------------------

Any standard USB flash drive can be used as the UBOS staff. It is recommended that such a
USB flash drive only be used as UBOS staff, and not for other purposes at the same time.

The drive must have a "VFAT" ("Windows") partition called ``UBOS-STAFF`` -- otherwise
UBOS will not recognize the device as a UBOS staff. This can often be accomplished simply by
inserting a new USB flash drive in a computer, and renaming the device to ``UBOS-STAFF``.

The USB flash drive can have any size; the amount of storage required for
use as UBOS staff is minimal. Speed is also largely irrelevant.

The UBOS Staff device uses the following directory layout. For details, see below:

+------------------------------------+-------------------------+---------------------------------------------------------------------------------+
| Directory                          | File                    | Description                                                                     |
+====================================+=========================+=================================================================================+
| ``shepherd/ssh/``                  | ``id_rsa.pub``          | SSH public key for the ``shepherd`` account                                     |
|                                    +-------------------------+---------------------------------------------------------------------------------+
|                                    | ``id_rsa``              | SSH private key for the ``shepherd`` account. Delete as soon as possible.       |
+------------------------------------+-------------------------+---------------------------------------------------------------------------------+
| ``wifi/``                          | ``<ssid>.conf``         | This directory may contain several files, one for each to-be-configured WiFi    |
|                                    |                         | SSID. Each file must be named based on the SSID it configures.                  |
+------------------------------------+-------------------------+---------------------------------------------------------------------------------+
| ``site-templates/``                | ``<name>.json``         | This directory may contain several Site JSON template files. Each of them will  |
|                                    |                         | be instantiated and deployed to any device that reads this Staff unless a site  |
|                                    |                         | with the same hostname exists already on the device.                            |
+------------------------------------+-------------------------+---------------------------------------------------------------------------------+
| ``flock/<HOSTID>/device-info/``    | ``device.json``         | A JSON file containing information about the device.                            |
+------------------------------------+-------------------------+---------------------------------------------------------------------------------+
| ``flock/<HOSTID>/site-templates/`` | ``<name>.json``         | This directory may contain several Site JSON files or Site JSON template files. |
|                                    |                         | Each of them will be instantiated (if a template) and deployed to the device    |
|                                    |                         | with host id ``<HOSTID>``, but ignored on other devices.                        |
+------------------------------------+-------------------------+---------------------------------------------------------------------------------+
| ``flock/<HOSTID>/sites/``          | ``<name>.json``         | This directory may contain several Site JSON files, which represent the site(s) |
|                                    |                         | as deployed on the device at the time the Staff was written last.               |
+------------------------------------+-------------------------+---------------------------------------------------------------------------------+
| ``flock/<HOSTID>/ssh/``            | ``ssh_host_<type>_key`` | This directory may contain one or more of the device's SSH host keys of         |
|                                    |                         | different types, such as ``rsa`` or ``ecdsa``. This can be used, in addition to |
|                                    |                         | ``shepherd`` SSH key pair, to authenticate the host (not just the client) over  |
|                                    |                         | the network.                                                                    |
+------------------------------------+-------------------------+---------------------------------------------------------------------------------+

Note: all files and directories are optional and may not be present on a given UBOS Staff:
an empty drive called ``UBOS-STAFF`` is entirely valid.

Virtual UBOS Staff devices
--------------------------

In the cloud
^^^^^^^^^^^^

When booting an UBOS image on Amazon EC2, UBOS instead will take
the key pair specified by the user in the instance creation wizard on the
Amazon website, and configure the Shepherd account with it. No actual
Staff device is required.

UBOS will never auto-generate a new key pair in the cloud.

In a Linux container
^^^^^^^^^^^^^^^^^^^^

When booting UBOS in a Linux container, UBOS will treat the directory
``/UBOS-STAFF`` as the UBOS Staff, assuming it is present in the container (not the host).

It may be advantageous to bind a suitable directory into the container with
the ``--bind`` flag to ``systemd-nspawn``.

UBOS will never auto-generate a new key pair when running UBOS in a container.

Provisioning a shepherd account
-------------------------------

An automatically provisioned shepherd account can be used as the primary administration
account on a UBOS device. By default, it has the rights to invoke    ``sudo ubos-admin``,
``sudo systemctl`` and the like. It can also become root with ``su`` without password.

If the device is booted a second time with the Staff present, the ssh key will be
updated. (We work under the assumption that if an attacker has the ability to
physically insert a USB device into the USB port and reboot the device, the device
should be considered compromised in any case.)

Provision a shepherd account with an existing ssh public key
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you would like to use an existing ssh public key to log into your UBOS device(s) over
the network as user ``shepherd``, create the following file system layout::

   shepherd/
       ssh/
           id_rsa.pub

where the file ``id_rsa.pub`` contains a valid ``ssh`` public key. You can use any existing
``ssh`` public key for which you have the corresponding private key.

I.e., the file called ``id_rsa.pub`` must be contained in a directory named ``ssh``, which
in turn must be contained in a directory called ``shepherd`` at the root level of the
directory hierarchy.

Provision a shepherd account with a newly generated ssh key pair
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you don't have an ssh key pair yet, and would like UBOS to generate one for you,
simply use a UBOS Staff device that is empty or at least does not have the ``shepherd``
directory yet at the root of the device.

During boot, will automatically generate the key pair, save it to the UBOS Staff, and
create the ``shepherd`` account on the device. (This behavior only occurs with a physical
Staff device; not with a virtual Staff device in case of running UBOS in the cloud or in a
Linux container.)

Once UBOS has booted and generated the ssh keys, you can unplug the Staff device and insert
it into the computer from which you want to log into your UBOS device. Copy the file
``shepherd/ssh/id_rsa`` from the Staff device into a secure place on your computer, as
anybody who has access to this file can use it to log into your UBOS device. Also, delete
the ``id_rsa`` file from the UBOS Staff for the same reason. (The file ``id_rsa.pub`` is
the public key which can be shared without harm.)

Assuming you have saved the private key to file ``~/private/my-ubos-shepherd-key`` and
the hostname of your UBOS device is ``ubos-device.local``, you can now ssh into your
UBOS device with the command:

.. code-block:: none

   ssh -i ~/private/my-ubos-shepherd-key shepherd@ubos-device.local

To log into a remote UBOS device as the shepherd
------------------------------------------------

On the computer that has the private ``id_rsa`` file, execute the following command:

.. code-block:: none

   > ssh -i <id_rsa> shepherd@1.2.3.4

where ``<id_rsa>`` is the name of the file containing the private key from above,
and ``1.2.3.4`` is replaced with the IP address or
hostname of your device, such as ``ubos-pc.local`` (see :doc:`networking`).

You must have copied the ``id_rsa`` file to your computer. You cannot use ``id_rsa``
directly from the UBOS Staff, as ssh will refuse to use the file directly from
the UBOS Staff.

To setup WiFi
-------------

If you would like your device to be able to connect to WiFi immediately after its boots,
you can provide information about one or more WiFi networks on on the UBOS Staff, and
UBOS will configure your device as a WiFi client. Of course, this assumes that your
device has WiFi support and all relevant drivers have been installed (if not, this will do
nothing).

To provide information on a WiFi network called ``ExampleWiFi``, create file
``wifi/ExampleWiFi.conf`` with the following content:

.. code-block:: none

   ssid="ExampleWiFi"
   psk="MySecret"

``ssid`` must be the WiFi network's SSID (here: ``ExampleWiFi``) and ``psk`` must be the
corresponding WiFi passphrase.

You can specify more than one file in directory ``wifi/``, and your device will be able
to connect to any of those networks. If your network needs more configuration, you can
add additional settings accepted by ``wpa_supplicant`` into these files: UBOS simply
inserts the content of those files into the ``network={ ... }`` section of a generated
``wpa_supplicant.conf`` file, and so you can add any settings there acceptable to
``wpa_supplicant``.

You should also create a file in directory ``wifi/`` called ``wireless-regdom``. Allowed
WiFi frequencies are different in different countries, and this allows you to conform
to radio emission regulations in your country. This file should contain a single line
that, if you are based in the United States, looks like this:

.. code-block:: none

   WIRELESS_REGDOM="US"</pre>

If you are based in another country, use your two-letter country code instead of ``US``.

To auto-deploy sites upon boot
------------------------------

If you place one or more Site JSON files, or Site JSON template files in the correct
place on the UBOS Staff, UBOS will automatically deploy those sites. There are two
places where those Site JSON template files may be located:

* If placed in top-level directory ``site-templates/``, any UBOS device booting with the
  UBOS Staff will deploy the corresponding sites. It is highly recommended that the
  files be Site JSON template files that do not contain site ids or app configuration ids
  in order to generate unique identifiers on different devices.
* If placed in directory ``flock/<HOSTID>/site-templates/``, where ``<HOSTID>`` is the
  host identifier of a particular device, UBOS will only deploy the sites on that device.

Sites or site templates will not be deployed if the device already as a site with either
the same hostname or the same site or app config id.

The Site JSON files of the Sites deployed through this mechanism will, once the site
has been deployed, stored in ``flock/<HOSTID>/sites/<SITEID>.json``. This gives the user
a way of knowing automatically-generated credentials, for example.

UBOS boot behavior with Staff present
-------------------------------------

When UBOS boots, UBOS checks for the presence of a disk with a partition named
``UBOS-STAFF``. If it detects such a disk, it looks for the ``id_rsa.pub`` file in the
location described above.

If UBOS finds such a file, UBOS:

1. Creates a Linux user called ``shepherd`` unless it exists already.

2. Saves the content of ``id_rsa.pub`` verbatim as ``~shepherd/.ssh/id_rsa.pub``. This
   means that the user can log into the device over the network, as user ``shepherd``,
   as long as the user uses the corresponding private key for authentication.


UBOS also looks for two further directories:

* one directory called ``site-templates`` below the ``shepherd`` directory
* one directory called ``site-templates`` below the host directory below the ``flock``
  directory, where the host directory is named after the host identifier of the current
  device.

UBOS looks for site template files in both of those directories. If those exist, UBOS
will deploy the specified sites when booting has completed.

Disabling Staff functionality
-----------------------------

To disable reading the Staff device on boot at all, change the setting ``host.readstaffonboot``
to ``false`` in ``/etc/ubos/config.json``.

To disable modifying the Staff device on boot, such as by generating a new SSH keypair,
change the setting ``host.initializestaffonboot`` to ``false`` in ``/etc/ubos/config.json``.
