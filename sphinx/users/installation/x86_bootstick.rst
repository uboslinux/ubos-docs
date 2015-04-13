Run UBOS from a boot stick on a PC (64bit)
==========================================

You can install UBOS on a USB flash drive, and boot a standard PC directly from it.
This will leave your PC's hard drive unchanged and lets you try out UBOS easily.

Note: UBOS is a 64bit operating system. All recent PCs support 64bit; older hardware
may not.

Follow these steps:

#. Download a UBOS boot image from `depot.ubos.net`.
   Beta images for x86_64 are at
   `http://depot.ubos.net/yellow/x86_64/images <http://depot.ubos.net/yellow/x86_64/images>`_.
   Look for a file named ``ubos_yellow_pc_x86_64_LATEST.xz``. This file
   should **not** contain the letters ``vbox``, otherwise you get some unnecessary
   VirtualBox code with your image.

#. Uncompress the downloaded file. This depends on your operating system, but might be as easy as
   double-clicking it, or executing

   .. code-block:: none

      xz -d ubos_yellow_pc_x86_64_LATEST.xz

   on the command line.

#. Write this image file "raw" to a USB flash drive. This
   operation depends on your operating system:

   * :doc:`/users/writing-image/windows`
   * :doc:`/users/writing-image/macosx`
   * :doc:`/users/writing-image/linux`

#. Remove the USB flash drive, insert it into a spare PC that is currently off,
   and boot that computer from the USB flash drive. Depending on that computer's BIOS,
   you may have to set its BIOS to allow booting from USB first, or change the boot order, so the
   computer actually boots from the USB flash drive and not some other drive. Some BIOSs
   are less than friendly about this and hide this setting in very strange places, and
   you may need to experiment some.

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
