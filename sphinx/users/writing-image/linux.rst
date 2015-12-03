Writing an image to a USB stick or SD card on Linux
===================================================

The instructions are the same, regardless of whether you write the image to a
USB stick, or to an SD card.

If you are writing to an SD card, you can use your computer's built-in SD card
reader (if it has one), or use a USB adapter.

To write the image:

* Determine the device name of your USB stick or SD card. That is easiest if you
  run ``lsblk`` before you insert the USB stick or SD card, and then after. The
  device that has shown up is the device that you just inserted, minus the partition
  number (if any).

  For example, the device name may be ``/dev/sdx``.

  .. warning:: Make sure you get the device name right, otherwise you might accidentally
     destroy the data on some other hard drive!

     Also make sure your USB stick or SD card does not contain any valuable data; it
     will be mercilessly overwritten.

* Determine the file name of the image you downloaded. Let's assume it is
  ``~/Downloads/ubos_yellow_pc_LATEST.img``. If you downloaded a compressed
  version, uncompress the file first.

* Write the image using ``dd``, such as::

     > dd if=~/Downloads/ubos_yellow_pc_LATEST.img of=/dev/sdx bs=1M

  replacing ``/dev/sdx`` with the device name of your USB stick or SD card.

  This may take 10min or longer, depending on the speed of your USB stick or
  SD card, so be patient.

* When done, for good measure::

     > sync

  and wait for a little bit. Rumor has it some flash drives keep writing for some
  time after the OS thinks they are done. If that is true for your device, and you
  remove the device prematurely, you may end up with a corrupted image without a good
  way of telling that it happened.
