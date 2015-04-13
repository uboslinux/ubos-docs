Installing UBOS on a PC (64bit)
===============================

To install UBOS on a PC's hard drive, first create a UBOS boot stick as
described in :doc:`x86_bootstick`. Boot your PC with that boot stick, and
log on as root. Then:

#. Make sure you have an internet connection. You can check with:

   .. code-block:: none

      > ip addr

   This may take a little bit, in particular on the first boot.

#. Identify the hard drive that you would like to install UBOS on. UBOS supports
   several configurations (see below). In the simplest case, your PC has only
   one hard drive, and you will wipe that hard drive and install UBOS instead.

   Often, the name of your hard drive is ``/dev/sda``. To find the list of
   available drives, execute:

   .. code-block:: none

      > lsblk

#. To install, execute:

   .. code-block:: none

      > ubos-install /dev/sda

   and wait for a bit.

   .. warning:: Make sure you get the device name right, otherwise you might accidentally
      destroy the data on some other hard drive!

      Also make sure your hard drive does not contain any valuable data; it will be
      mercilessly overwritten.

#. When complete, execute:

   .. code-block:: none

      > shutdown -r now

   and remove your boot stick. UBOS should now be booting.

#. If your screen goes blank during the boot, please refer to
   `../troubleshooting`.

#. When the boot process is finished, log in as user ``root``. By default, there is no
   password on the console.

#. Wait until UBOS is ready. You can tell by executing:

   .. code-block:: none

      > systemctl is-system-running

   On the first boot, this may take a while, because UBOS has to generate some cryptographic
   keys, and Linux is trying very hard to use good random numbers for that purpose. To
   speed up the process, generate lots of random activity, such as looking through the
   file system, and typing lots on the keyboard. You only need to do that once, on the
   first boot.

   To speed up the key generation process, at the potential loss of some entropy,
   execute:

   .. code-block:: none

      > systemctl start haveged

   Once the system is running, continue.

#. If you have Ethernet plugged in, and your network runs DHCP (most networks do), your
   computer should automatically acquire an IP address. You can check with:

   .. code-block:: none

      > ip addr

   Make sure you are connected to the internet before attempting to proceed.

#. Update UBOS to the latest and greatest:

   .. code-block:: none

      > ubos-admin update

#. You are now ready to :doc:`set up your first app and site </users/firstsite>`.

Alternate configurations
------------------------

If you have two hard drives and would like to use them in a RAID1 configuration,
simply add the second device name to the ``ubos-install`` command:

.. code-block:: none

   > ubos-install /dev/sda /dev/sdb

If you do not want to erase your entire hard drive, but instead want to install UBOS
on a partition, you can specify the partition device name instead of the drive device
name, such as:

.. code-block:: none

   > ubos-install --rootpartition /dev/sda3 --bootpartition /dev/sda1

In this case, you need to also specify a partition that is used as boot partition.

You can also install UBOS on a disk image. First, create an image of sufficient size, e.g.:

.. code-block:: none

   > dd if=/dev/zero of=ubos-image.img bs=1024 count=0 seek=2M

and then specify the image file instead of the device:

.. code-block:: none

   > ubos-install ubos-image.img

If your screen goes blank during the
