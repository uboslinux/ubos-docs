Run UBOS on Raspberry Pi 4
==========================

You can run UBOS on your Raspberry Pi 4 by downloading an image, writing
it to an SD card, and booting your Raspberry Pi with that card. (Alternatively you can keep
running your existing Linux distro on your Raspberry Pi, and run UBOS in a Linux container.
This is :doc:`described here <armv7h_container>`.)

All Raspberry Pi 4 models should work out of the box.

If you are not sure which model you have, consult
`this page <http://www.raspberrypi.org/products/>`_.

If you have the original Raspberry Pi or the Raspberry Pi Zero, go to :doc:`this page <raspberrypi>`.
For the Raspberry Pi 2 or 3, go to :doc:`this page <raspberrypi2>`.

#. Download a UBOS boot image from ``depot.ubos.net``.
   Images for the Raspberry Pi 4 are at
   `http://depot.ubos.net/green/armv7h/images <http://depot.ubos.net/green/armv7h/images>`_.
   Look for a file named ``ubos_green_armv7h-rpi4_LATEST.img.xz``.

#. Optionally, you may now verify that your image downloaded correctly by following the instructions
   at :doc:`verifying`.

#. Uncompress the downloaded file. This depends on your operating system, but might be as easy as
   double-clicking it, or executing

   .. code-block:: none

      % sudo xz -d ubos_green_armv7h-rpi4_LATEST.img.xz

   on the command line.

#. Write this image file "raw" to a micro-SD card. This operation depends on your operating system:

   * :doc:`/users/writing-image/windows`
   * :doc:`/users/writing-image/macosx`
   * :doc:`/users/writing-image/linux`

#. On first boot, it is recommended you have a monitor and keyboard connected to your
   Raspberry Pi 4. If this is impractical, create a :doc:`UBOS staff <../shepherd-staff>`
   so you can securely log in over the network without the need for monitor or keyboard.

#. Remove the micro-SD card and insert it into your Raspberry Pi 4. If you created a UBOS staff,
   insert the staff into the USB port. Then, plug in the Raspberry Pi 4's USB power.

#. When the boot process is finished, log in as user ``root`` from the attached keyboard
   and monitor. By default, there is no password on the console. If you used a UBOS staff,
   you can log in over the network instead as described :doc:`here <../shepherd-staff>`.

#. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take a few minutes.
   To determine whether UBOS ready, execute:

   .. code-block:: none

      % systemctl is-system-running

   Wait until the output has changed from ``starting`` to ``running``. If it is anything else, consult
   :doc:`troubleshooting<../troubleshooting>`.

#. If you have Ethernet plugged in, and your network has a DHCP server (most networks do),
   your computer should automatically acquire an IP address. You can check with:

   .. code-block:: none

      % ip addr

   Make sure you are connected to the internet before attempting to proceed.

#. Update UBOS to the latest and greatest:

   .. code-block:: none

      % sudo ubos-admin update

#. Optionally, upgrade your Raspberry Pi 4's EEPROM boot loader to the latest version.
   Depending on when your Raspberry Pi 4 was manufactured, it may or may not have been
   shipped with a recent version. More recent versions know how to boot from USB disks,
   for example, while previous ones don't.

   To check for the current version of your Raspberry Pi 4's bootloader:

   .. code-block:: none

      % /opt/vc/bin/vcgencmd bootloader_version

   For example, it may output:

   .. code-block:: none

      May 10 2019 19:40:36
      version d2402c53cdeb0f072ff05d52987b1b6b6d474691 (release)
      timestamp 0

   If the date is older than June 15, 2020, we recommend you upgrade. First, install
   the EEPROM update package:

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
       LATEST: Thu Apr 16 05:11:26 PM UTC 2020 (1587057086)
       FW DIR: /lib/firmware/raspberrypi/bootloader/critical
      VL805: update available
      CURRENT: 00013701
       LATEST: 000137ad
      BOOTFS /boot
      EEPROM updates pending. Please reboot to apply the update.

   and reboot:

   .. code-block:: none

      % sudo systemctl reboot


#. You are now ready to :doc:`set up your first app and site </users/firstsite>`.
