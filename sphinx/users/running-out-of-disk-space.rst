I'm running out of disk space, what now?
========================================

Overview
--------

The default images for UBOS aren't very large, so they can fit onto cheap SD cards, USB
sticks and small Amazon EC2 root volumes. That works fine if you don't have a lot of
data on your device. But what if you do?

There are two ways to solve this issue:

* Pick a new disk that has the size you need, install UBOS on that disk and also keep
  your data on that disk.
* Keep running UBOS on one disk, and add a new disk that has the size you need as a
  "data" disk.

It's easiest to get set up correctly for either alternative before you install any :term:`Apps <App>` on
your device. However, we also have instructions for how to migrate once you have.

Using a large, single disk that contains both operating system and data
-----------------------------------------------------------------------

The best way to do that is to run ``ubos-install`` on the new disk, using a device
that runs UBOS already. Here are the steps:

If you are starting from scratch:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Download a UBOS image for your platform, and boot your device with it.
#. Attach your big future root disk to the device. If it's an SD card, that requires
   a USB-SD card adapter.
#. Identify which block device corresponds to your disk. This is easiest by executing
   ``lsblk`` once before you attach the disk, and again right after. The change in
   output tells you the name of the block device, such as ``/dev/sdb``.
#. Run ``ubos-install`` with the block device you identified.
#. Shut down your device.
#. Remove your old boot disk, and attach your new boot disk in its place.
#. Reboot from the new disk.

If you have Apps and data on your device already:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Boot your device.
#. Attach your big future root disk to the device. If it's an SD card, that requires
   a USB-SD card adapter.
#. Identify which block device corresponds to your disk. This is easiest by executing
   ``lsblk`` once before you attach the disk, and again right after. The change in
   output tells you the name of the block device, such as ``/dev/sdb``.
#. Run ``ubos-install`` with the block device you identified.
#. Mount the root partition of your new disk. Assuming
   the new root partition is ``/dev/sdb2``, execute:

   .. code-block:: none

      % sudo mount /dev/sdb2 /mnt

#. Back up your :term:`Sites <Site>` to a suitable directory of the mounted disk, such as:

   .. code-block:: none

      % sudo ubos-admin backup --out /mnt/root/from-small-disk.ubos-backup

#. Unmount your new disk, and shut down your device:

   .. code-block:: none

      % sudo umount /mnt
      % sudo systemctl poweroff

#. Remove your old boot disk, and attach your new boot disk in its place.
#. Boot with the new disk.
#. Restore your data from backup:

   .. code-block:: none

      % sudo ubos-admin restore --in /root/from-small-disk.ubos-backup

Using an additional "data" disk
-------------------------------

If you are starting from scratch:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Boot your device.
#. Attach your big data disk to the device.
#. Identify which block device corresponds to your data disk. This is easiest by executing
   ``lsblk`` once before you attach the disk, and again right after. The change in
   output tells you the name of the block device, such as ``/dev/sdb``.
#. Make sure your data disk is formatted with either ``ext4`` or ``btrfs``. We recommend
   ``btrfs`` as UBOS takes advantage of copy-on-write features, thereby saving disk space
   and speeding up some operations. You can use your entire disk, or just one partition.
#. Mount your data disk at ``/ubos`` by executing:

   .. code-block:: none

      % sudo mount /dev/sdb2 /ubos

#. Update ``/etc/fstab`` so that the disk will be automatically mounted after a reboot.
   This is important. If your data disk is not available at boot time, your device will
   likely hang instead of booting. An easy way to determine what to add to ``/etc/fstab``
   comes courtesy of the Arch Linux install scripts:

   .. code-block:: none

      % sudo pacman -S arch-install-scripts
      % genfstab /

#. Compare the output of this script, with the content of ``/etc/fstab``. Ignore the lines
   that start with a ``#``. You will likely find a single line that's different. Add this
   line to the end of ``/etc/fstab``. It probably looks something like this:

   .. code-block:: none

      /dev/sdb2     /ubos     btrfs     rw,relatime,space_cache,subvolid=5,subvol=/     0 0

#. Reboot and check that the data disk is property mounted.

If you have Apps and data on your device already:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If *and only if* you are currently on beta13, and about to upgrade to beta14, you can
follow the same procedure as in "If you are starting from scratch" in the previous section,
and then upgrade your device as described in the :doc:`release notes </releases/beta14/release-notes/index>`.

In all other cases, it's a bit more involved:

#. Boot your device.
#. Backup all data on your device with ``ubos-admin backup`` and store the backup file on a
   disk that you then remove from the device before continuing. Just to be safe :-)
#. Disable all system services that access your ``/ubos`` directory. Which services that
   are depend highly on what :term:`Apps <App>` you currently run on the device. You can find all
   running services with:

   .. code-block:: none

      % systemctl

   To find processes that access ``/ubos``, you can use ``lsof``. Most importantly,
   make sure no databases are running:

   .. code-block:: none

      % sudo systemctl stop mysqld postgresql

#. Attach your big data disk to the device.
#. Identify which block device corresponds to your data disk. This is easiest by executing
   ``lsblk`` once before you attach the disk, and again right after. The change in
   output tells you the name of the block device, such as ``/dev/sdb``.
#. Make sure your data disk is formatted with either ``ext4`` or ``btrfs``. We recommend
   ``btrfs`` as UBOS takes advantage of copy-on-write features, thereby saving disk space
   and speeding up some operations. You can use your entire disk, or just one partition.
#. Move your old ``/ubos`` out of the way, and create a new one, as root:

   .. code-block:: none

      % sudo su
      # mv /ubos /ubos.too-small
      # mkdir /ubos

#. Mount your data disk at ``/ubos`` by executing:

   .. code-block:: none

      % sudo mount /dev/sdb2 /ubos/

#. Update ``/etc/fstab`` so that the disk will be automatically mounted after reboots.
   This is important. If your data disk is not available at boot time, your device will
   likely hang instead of booting. An easy way to determine what to add to ``/etc/fstab``
   comes courtesy of the Arch Linux install scripts:

   .. code-block:: none

      % sudo pacman -S arch-install-scripts
      % genfstab /

#. Compare the output of this script, with the content of ``/etc/fstab``. Ignore the lines
   that start with a ``#``. You will likely find a single line that's different. Add this
   line to the end of ``/etc/fstab``. It probably looks something like this:

   .. code-block:: none

      /dev/sdb2     /ubos     btrfs     rw,relatime,space_cache,subvolid=5,subvol=/     0 0

#. Copy your data over, as root:

   .. code-block:: none

      % sudo su
      # cp -a /ubos.too-small/* /ubos

#. Reboot and check that the data disk is property mounted and all :term:`Apps <App>` are functional again.

#. Delete ``/ubos.too-small``

