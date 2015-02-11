Installing UBOS on a PC
=======================

To install UBOS on a PC's hard drive, first create a UBOS boot stick as
described in :doc:`x86_bootstick`. Boot your PC with that boot stick, and
log on as root. Then:

#. Make sure you have an internet connection. You can check with::

      > ip addr

   This may take a little bit, in particular on the first boot.

#. Identify the hard drive that you would like to install UBOS on. UBOS supports
   several configurations (see below). In the simplest case, your PC has only
   one hard drive, and you will wipe that hard drive and install UBOS instead.

   Often, the name of your hard drive is ``/dev/sda``. To find the list of
   available drives, execute::

      > lsblk

#. To install, execute::

      > ubos-install /dev/sda

   and wait for a bit. WARNING: THIS WILL FORMAT THE DRIVE AND DESTROY ALL DATA ON /dev/sda.
   MAKE SURE YOU WANT THIS BEFORE YOU CONTINUE.

#. When complete, execute::

      > shutdown -r now

   and remove your boot stick. UBOS should now be booting.

Alternate configurations
------------------------

If you have two hard drives and would like to use them in a RAID1 configuration,
simply add the second device name to the ``ubos-install`` command::

   > ubos-install /dev/sda /dev/sdb

If you do not want to erase your entire hard drive, but instead want to install UBOS
on a partition, you can specify the partition device name instead of the drive device
name, such as::

   > ubos-install --rootpartition /dev/sda3 --bootpartition /dev/sda1

In this case, you need to also specify a partition that is used as boot partition.

You can also install UBOS on a disk image. First, create an image of sufficient size, e.g.::

   > dd if=/dev/zero of=ubos-image.img bs=1024 count=0 seek=2M

and then specify the image file instead of the device::

   > ubos-install ubos-image.img


