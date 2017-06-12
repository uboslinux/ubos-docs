Run UBOS on EspressoBIN
=======================

You can run UBOS on your EspressoBIN by downloading an image, writing it to an SD card,
and booting your EspressoBIN with that card. (Alternatively you can keep running your
existing Linux distro on your EspressoBIN, and run UBOS in a Linux container.
This is :doc:`described here <aarch64_container>`.)

#. Download a UBOS boot image from ``depot.ubos.net``.
   Beta images for the EspressoBIN are at
   `http://depot.ubos.net/yellow/aarch64/images <http://depot.ubos.net/yellow/aarch64/images>`_.
   Look for a file named ``ubos_yellow-espressobin_LATEST.img.xz``.

#. Optionally, you may now verify that your image downloaded correctly by following the instructions
   at :doc:`verifying`.

#. Uncompress the downloaded file. This depends on your operating system, but might be as easy as
   double-clicking it, or executing

   .. code-block:: none

      > xz -d ubos_yellow-espressobin_LATEST.img.xz

   on the command line.

#. Write this image file "raw" to an SD card appropriate for your EspressoBIN. This
   operation depends on your operating system:

   * :doc:`/users/writing-image/windows`
   * :doc:`/users/writing-image/macosx`
   * :doc:`/users/writing-image/linux`

#. On first boot, you need to have a serial terminal connected to your EspressoBIN. This is
   because you likely have to change your boot loader options.

#. Remove the SD card and insert it into your EspressoBIN. If you created a UBOS staff,
   insert the staff into the USB port. Then, connect the EspressoBIN's USB power port to
   your computer.

#. From your computer, attach a serial terminal. How to do that depends on your operating
   system. The EspressoBIN site has a
   `description <http://wiki.espressobin.net/tiki-index.php?page=Serial+connection>` how to
   do this for Windows and Linux. The baudrate is 115200.

#. Connect the 12V power supply to your EspressoBIN.

#. When prompted on the serial terminal, interrupt the boot process by pressing a key. You
   get a promot that looks like:

   .. code-block:: none

      Marvell>>

#. Enter the following commands to import the new environment variables to boot from the SD card:

   .. code-block:: none

      mmc dev 0
      ext4load mmc 0 $loadaddr /uEnv-sdcard.txt
      env import -t $loadaddr $filesize
      saveenv
      boot

   If you do not want to make permanent changes to your bootloader setup, leave out the
   ``saveenv`` command.

#. When the boot process is finished, log in as user ``root`` from the attached keyboard
   and monitor. By default, there is no password on the console. If you used a UBOS staff,
   you can log in over the network instead as described :doc:`here <../shepherd-staff>`.

#. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take 5 or 10 minutes.
   To determine whether UBOS ready, execute:

   .. code-block:: none

      > systemctl is-system-running

   Wait until the output has changed from ``starting`` to ``running``. If it is anything else, consult
   :doc:`troubleshooting<../troubleshooting>`.

#. If you have Ethernet plugged in, and your network has a DHCP server (most networks do),
   your computer should automatically acquire an IP address. You can check with:

   .. code-block:: none

      > ip addr

   Make sure you are connected to the internet before attempting to proceed. In the default setup,
   all Ethernet ports on the EspressoBIN are equivalent and connected by the EspressoBIN's
   built-in switch, so you can connect using either of them.

#. Update UBOS to the latest and greatest:

   .. code-block:: none

      > ubos-admin update

#. You are now ready to :doc:`set up your first app and site </users/firstsite>`.
