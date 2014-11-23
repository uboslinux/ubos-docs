Running UBOS on Raspberry Pi
============================

You can run UBOS on your Raspberry Pi by downloading an image, writing it to an SD card,
and booting your Raspberry Pi with that card.

Both Raspberry Pi "Model B" and "Model B Plus" are supported out of the box. ("Model A"
and "Model A Plus" do not have built-in networking, which UBOS requires to install
new apps.) If you are not sure which model you have, consult
`this page <http://www.raspberrypi.org/products/>`_.

#. Download a UBOS boot image from `depot.ubos.net`.
   Beta 1 images for the Raspberry Pi are at
   `http://depot.ubos.net/yellow/armv6h/images <http://depot.ubos.net/yellow/armv6h/images>`_.
   Look for a file named ``ubos_yellow_armv6h_LATEST.img``
   or ``ubos_yellow_armv6h_LATEST.img.xz`` (the same, compressed).

#. Write this image file "raw" to an SD card appropriate for your Raspberry Pi. This
   operation depends on your operating system, and there are many excellent guides on-line
   for all sorts of operating systems.

   If you are on Linux, this should work:

   * Determine the device name of your SD card. For example, run ``lsblk`` before
     you insert the SD card, and then after. The device that has shown up is
     the device that you just inserted, minus the partition number (if any). For
     example, the device name may be ``/dev/sdx``.

     .. warning:: Make sure you get the device name right, otherwise you might accidentally
        destroy the data on some other hard drive!

        Also make sure your SD card does not contain any valuable data; it will be
        mercilessly overwritten.

   * Determine the file name of the image you downloaded. Let's assume it is
     ``~/Downloads/ubos_yellow_x86_64_LATEST.img``. If you downloaded a compressed
     version, uncompress the file first.

   * Write the image using ``dd``, such as::

         > dd if=~/Downloads/ubos_yellow_armv6h_LATEST.img of=/dev/sdx bs=1M

     replacing ``/dev/sdx`` with the device name of your SD card.

     This may take 10min or longer, depending on the speed of your SD card, so be
     patient.

   * When done, for good measure::

        > sync

     and wait for a little bit. Rumor has it some flash drives keep writing for some
     time after the OS thinks they are done. If that is true for your device, and you
     remove the device prematurely, you may end up with a corrupted image without a good
     way of telling that it happened.

#. Remove the SD card, insert it into your Raspberry PI, connect an Ethernet cable,
   and plug in the Raspberry Pi power chord.

   It is recommended you connect a monitor and keyboard to your Raspberry Pi for your
   first boot.

#. When the boot process is finished, log in as user ``root`` from the console. By
   default, there is no password on the console.

#. Now: wait. The Raspberry Pi is not a very fast computer, and UBOS needs to generate
   a few cryptographic keys before it is ready to use. That might take 5 or 10 minutes.
   To determine whether UBOS ready, execute:

   .. code-block:: none

      systemctl is-system-running

#. If you have Ethernet plugged in, and your network runs DHCP (most networks do), your
   computer should automatically acquire an IP address. You can check with::

      > ip addr

   Make sure you are connected to the internet before attempting to proceed.

#. Update the code to the latest and greatest::

      > ubos-admin update

#. You are now ready to :doc:`set up your first app and site </users/firstsite>`.



