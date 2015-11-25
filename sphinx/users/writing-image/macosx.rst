Writing an image to a USB stick or SD card on Mac OSX
=====================================================

The instructions are the same, regardless of whether you write the image to a
USB stick, or to an SD card.

If you are writing to an SD card, you can use your computer's built-in SD card
reader (if it has one), or use a USB adapter.

To write the image:

* Determine the device name of your USB stick or SD card. That is easiest if you
  run::

      > diskutil list

  before you insert the USB stick or SD card, and then after. The
  device that has shown up is the device that you just inserted.
  For example, the device name may be ``/dev/disk8``.

  .. warning:: Make sure you get the device name right, otherwise you might accidentally
     destroy the data on some other hard drive!

     Also make sure your USB stick or SD card does not contain any valuable data; it
     will be mercilessly overwritten.

* Depending on what's on your USB stick or SD card, OSX might have automatically
  mounted it. To unmount::

     > diskutil unmountDisk /dev/diskN

  if the device name is ``/dev/diskN``.

* Determine the file name of the image you downloaded. Let's assume it is
  ``~/Downloads/ubos_yellow_pc_x86_64_LATEST.img``. If you downloaded a compressed
  version, uncompress the file first.

* Write the image using ``dd``, such as::

      > sudo dd if=~/Downloads/ubos_yellow_pc_x86_64_LATEST.img of=/dev/rdiskN bs=1m

  replacing ``/dev/rdiskN`` with the device name of your USB stick or SD card.
  You can use either ``/dev/diskN`` or ``/dev/rdiskN`` (replacing ``N`` with
  the correct number), but ``/dev/rdiskN`` is faster.

  If you see the error ``dd: Invalid number `1m'``, you are using GNU ``dd``.
  Use the same command but replace ``bs=1m`` with ``bs=1M``.

  This may take 10min or longer, depending on the speed of your USB stick or
  SD card, so be patient.

* When done, for good measure::

     > sync

  and wait for a little bit. Rumor has it some flash drives keep writing for some
  time after the OS thinks they are done. If that is true for your device, and you
  remove the device prematurely, you may end up with a corrupted image without a good
  way of telling that it happened.

Thanks to the Ubuntu project whose
`description <https://help.ubuntu.com/community/Installation/FromImgFiles#Mac_OS_X>`_
helped when creating this page.
