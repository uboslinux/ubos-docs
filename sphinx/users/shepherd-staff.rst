The UBOS Staff
==============

Overview
--------

When running UBOS on a local physical hardware, like a PC or Raspberry Pi,
any standard USB flash drive can be used during boot to securely provision a local account
called the :term:`Shepherd` account, into which the user can ``ssh`` over the
network. We call such a device the "UBOS Staff".

This also allows the secure installation and configuration of UBOS devices without
ever having to attach a keyboard or monitor to the device.

A similar mechanism is available in the cloud.

See also `blog post <http://upon2020.com/blog/2015/03/ubos-shepherd-rules-their-iot-device-flock-with-a-staff/>`_
with a longer discussion.

UBOS Staff device configuration (physical hardware)
---------------------------------------------------

Device format and name
^^^^^^^^^^^^^^^^^^^^^^

Any standard USB flash drive can be used as the UBOS staff. It is recommended that such a
USB flash drive only be used as UBOS staff, and not for other purposes at the same time.

The drive must have a "VFAT" ("Windows") partition called ``UBOS-STAFF`` -- otherwise
UBOS will ignore the drive during boot. This can often be accomplished simply by inserting
a new USB flash drive in a computer, and renaming the device to ``UBOS-STAFF``.

The USB flash drive can have any size; the amount of storage or speed required for
use as UBOS staff is minimal.

You have two choices: use an existing ssh key on the ``shepherd`` account, or have UBOS
generate you a new one:

Adding an existing ssh key to the device
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you would like to use an existing ssh public key with your UBOS device(s), UBOS expects
configuration information in the following file system layout::

   shepherd/
       ssh/
           id_rsa.pub

I.e., a file called ``id_rsa.pub`` must be contained in a directory named ``ssh``, which
in turn must be contained in a directory called ``shepherd`` at the root level of the
directory hierarchy.

This file ``id_rsa.pub`` must contain a valid ``ssh`` public key. You can use any existing
``ssh`` public key for which you have the corresponding private key.

Have UBOS auto-generate a new key pair:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To have UBOS auto-generate a new key pair, insert a USB flash drive named ``UBOS-STAFF``
during boot that does not have the ``shepherd`` directory yet. UBOS will automatically
generate the key pair, save it to the UBOS Staff, and create the ``shepherd`` account on the
device. This behavior only occurs with a physical Staff device; not with a virtual Staff
device in case of running UBOS in the cloud or in a container.

Once UBOS has booted and generated the ssh keys (check with ``systemctl is-system-running``),
you can unplug the Staff device and insert it into the computer from which you want to
log into your UBOS device. Copy the file ``shepherd/ssh/id_rsa`` from the Staff device
into a secure place on your computer, as anybody who has access to this file can use it to
log into your UBOS device. Also, delete the ``id_rsa`` file from the UBOS Staff for the same
reason. (The file ``id_rsa.pub`` is the public key to which is harmless.)

Assuming you have saved the private key to file ``~/private/my-ubos-shepherd-key`` and
the hostname of your UBOS device is ``ubos-device.local``, you can now ssh into your
UBOS device with the command::

   ssh -i ~/private/my-ubos-shepherd-key shepherd@ubos-device.local

UBOS Staff device configuration (cloud)
---------------------------------------

When booting an official UBOS image on Amazon EC2, UBOS instead will take
the key pair specified by the user in the instance creation wizard on the
Amazon website, and configure the Shepherd account with it. No actual
Staff device is required.

UBOS will never auto-generate a new key pair in the cloud.

UBOS Staff device configuration (container)
-------------------------------------------

When booting UBOS in a Linux container, UBOS will treat the directory
``/UBOS-STAFF`` as the UBOS Staff, assuming it is present in the container (not the host).

It may be advantageous to bind a suitable directory into the container with
the ``--bind`` flag to ``systemd-nspawn``.

UBOS will never auto-generate a new key pair when running UBOS in a container.

To log into a remote UBOS device as the shepherd
------------------------------------------------

On the computer that has the private ``id_rsa`` file, execute the following command::

   > ssh -i <id_rsa> shepherd@1.2.3.4

where ``<id_rsa>`` is the name of the file containing the private key from above,
and ``1.2.3.4`` is replaced with the IP address or
hostname of your device, such as ``ubos-pc.local`` (see :doc:`networking`).

You must have copied the ``id_rsa`` file to your computer. You cannot use ``id_rsa``
directly from the UBOS Staff, as ssh will refuse to use the file directly from
the UBOS Staff.

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

3. UBOS gives the ``shepherd`` account certain administration rights, such as the
   ability to invoke ``sudo ubos-admin``, ``systemctl``, ``reboot`` and the like.

4. If the device is booted a second time with the Staff present, the ssh key will be
   updated. (We work under the assumption that if an attacker has the ability to
   physically insert a USB device into the USB port and reboot the device, the device
   should be considered compromised in any case.)

UBOS also looks for two further directories:

* one directory called ``site-templates`` below the ``shepherd`` directory
* one directory called ``site-templates`` below the host directory below the ``flock``
  directory, where the host directory is named after the host identifier of the current
  device.

UBOS looks for site template files in both of those directories. If those exist, UBOS
will deploy the specified sites when booting has completed.
