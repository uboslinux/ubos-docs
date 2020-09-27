Raspberry Pi (any model)
========================

How to use a USB disk or stick as the primary disk
--------------------------------------------------

Some Raspberry Pi's can boot directly from a USB disk or stick without needing an SD card
at all. This appears to include some Raspberry Pi 3's and the Raspberry Pi 4. For this to
work, any of them need to have a relatively recent boot loader. For how to upgrade the boot
loader on your Raspberry Pi 4, see below.

To install UBOS to boot directly from a USB disk or stick without an SD card, you have two choices:

* either follow the normal installation instructions (for
  :doc:`Raspberry Pi 3 <../installation/raspberrypi2>`, for
  :doc:`Raspberry Pi 4 <../installation/raspberrypi4>`) and simply
  use the USB disk or stick in every place where the instructions refer to the SD card; or

* boot your Raspberry Pi from a UBOS SD card, then attach the USB disk or stick, and
  run:

  .. code-block:: none

     % sudo ubos-install /dev/sdX

  where ``/dev/sdX`` needs to be replaced with the name of your
  USB disk or stick (e.g. ``/dev/sdb``). Once this command is complete, you can shut
  down your Raspberry Pi, remove the SD card, and reboot directly from the USB disk or
  stick.

  This alternative may be preferable because ``ubos-install`` gives you more options
  in terms of disk layout and will use the memory capacity of your entire disk or stick.

  To find the name of the USB disk or stick, execute ``lsblk`` before and after you
  plug it into USB. The difference contains the name of the USB disk or stick.

How to switch boot over to a USB disk or stick as soon as possible
------------------------------------------------------------------

Some of the older Raspberry Pi's cannot directly boot from a USB disk or stick. However,
you can start the boot on an SD card and switch over to the USB disk or stick as soon
as possible. This will use the SD card only at the very beginning of the boot process,
and not at all during regular operation, bringing many of the benefits of booting from
a USB disk or stick to older devices.

To do that:

#. Boot your Raspberry Pi from an SD card that has UBOS installed as described
   in :doc:`../installation/raspberrypi` or :doc:`../installation/raspberrypi2`.

#. Connect your external USB disk to your Raspberry Pi and turn it on.

#. Verify that UBOS has recognized the external disk by executing ``lsblk``. It should show your
   drive with a name such as ``/dev/sda``. It might be helpful to compare the output of the
   command with the drive turned off and turned on.

#. Install UBOS on the USB disk with a command such as ``ubos-install /dev/sda``.

   .. warning:: Make sure you get the device name right, otherwise you might accidentally
      destroy the data on some other hard drive!

   .. warning:: This will destroy all existing data on your
      USB disk, so make sure you want to do this.

#. After the command completes, edit file ``/boot/cmdline.txt``. Look for where it currently
   says something like ``/dev/mmcblk0p2`` (identifying the root partition on the SD Card) and
   change it to ``/dev/sda2`` (the root partition on the USB disk). Note: depending how
   exactly you installed UBOS on the SD card and the USB disk, the device names might be
   different; this page reflects the default.

#. Execute ``systemctl reboot``.

#. Once the system has rebooted, log in as ``root`` and check that your root disk is now
   ``/dev/sda2`` by executing ``lsblk``.

Bonus: edit ``/etc/fstab`` to mount the SD Card's first partition as ``/boot``. That way UBOS
updates can update the boot parameters on your SD Card in the future.

How to upgrade your Raspberry Pi 4's boot loader
------------------------------------------------

Whether such an upgrade is necessary depends on when your Raspberry Pi 4 was
manufactured. More recent versions know how to boot from USB disks,
while previous ones don't.

To check for the current version of your Raspberry Pi 4's bootloader:

.. code-block:: none

   % /opt/vc/bin/vcgencmd bootloader_version

For example, it may output:

.. code-block:: none

   May 10 2019 19:40:36
   version d2402c53cdeb0f072ff05d52987b1b6b6d474691 (release)
   timestamp 0

If the date is older than June 15, 2020, we recommend you upgrade. First, install
the Raspberry Pi EEPROM update package:

.. code-block:: none

   % sudo pacman -S rpi-eeprom

and then run the update:

.. code-block:: none

   % sudo rpi-eeprom-update -d -a

Correct output may be like:

.. code-block:: none

   BCM2711 detected
   Dedicated VL805 EEPROM detected
   BOOTFS /boot
   *** INSTALLING EEPROM UPDATES ***
   BOOTLOADER: update available
   CURRENT: Fri May 10 06:40:36 PM UTC 2019 (1557513636)
    LATEST: Fri Jul 31 01:43:39 PM UTC 2020 (1596203019)
    FW DIR: /lib/firmware/raspberrypi/bootloader/critical
   VL805: update available
   CURRENT: 00013701
    LATEST: 000138a1
   BOOTFS /boot
   EEPROM updates pending. Please reboot to apply the update.

and reboot:

.. code-block:: none

   % sudo systemctl reboot

How to use the Raspberry Pi's camera
------------------------------------

Using the Raspberry Pi's official camera while running UBOS is quite simple, as everything
you need is pre-installed on UBOS for the Raspberry Pi.

However, you need to make one change in one file, which is to allocate more of the
Pi's limited memory to graphics. We could have pre-configured that, but we figure most
people running the Pi do not use a camera, and much rather have access to all of the RAM.

To make this change, become root and open the file with your favorite editor, such as
``vi``:

.. code-block:: none

   % sudo su
   # vi /boot/config.txt

Add the very end of the file, add the following content:

.. code-block:: none

   gpu_mem_512_=128
   gpu_mem_256_=128
   start_file=start_x.elf
   fixup_file=fixup_x.dat

(In ``vi``, you would hit ``G`` to go to the end of the file, then hit ``A`` to append,
then type the above text. When done, hit Escape to leave editing mode, and ``ZZ`` to save
and quit the editor.)

Then, shutdown your Pi:

.. code-block:: none

   % sudo systemctl poweroff

and physically connect the camera to the Pi with the appropriate cable. Re-apply power,
and once the Pi has booted, you can take a picture with:

.. code-block:: none

   /opt/vc/bin/raspistill -o mypicture.jpg

or take a video with:

.. code-block:: none

   /opt/vc/bin/raspivid -o myvideo.mpg

Invoke those commands without arguments to see their many options.
