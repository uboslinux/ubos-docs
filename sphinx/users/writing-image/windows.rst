Writing an image to a USB stick or SD card on Windows
=====================================================

The instructions are the same, regardless of whether you write the image to a
USB stick, or to an SD card.

If you are writing to an SD card, you can use your computer's built-in SD card
reader (if it has one), or use a USB adapter.

To write the image:

* Download Disk Imager from
  http://sourceforge.net/projects/win32diskimager/files/
  and extract that ZIP file to a new folder. Open up that folder, then double-click
  ``Win32DiskImager`` in the folder.

* Insert your USB stick or SD card. Note the drive letter that Windows assigns to
  your stick or card.

  .. warning:: Make sure you get the driver letter right, otherwise you might accidentally
     destroy the data on some other hard drive!

     Also make sure your USB stick or SD card does not contain any valuable data; it
     will be mercilessly overwritten.

* In Disk Imager, select the image file you downloaded, and the drive letter you
  noted earlier. Click "Write".

  This may take 10min or longer, depending on the speed of your USB stick or
  SD card, so be patient.

* When done, for good measure wait for a little bit. Rumor has it some flash drives keep
  writing for some time after the OS thinks they are done. If that is true for your device,
  and you remove the device prematurely, you may end up with a corrupted image without a good
  way of telling that it happened.

Thanks to the Ubuntu project whose
`description <https://help.ubuntu.com/community/Installation/FromImgFiles#Windows>`_
helped when creating this page.
