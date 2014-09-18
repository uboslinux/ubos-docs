Installation
============

You can currently either :ref:`run UBOS from a boot stick <running-from-boot-stick>` or
:ref:`run UBOS in a VirtualBox virtual machine <running-in-virtualbox>` on an Intel
x86 platform.

These instructions assume the UBOS production version in the ``green`` channel. If you
are a developer and would like to access pre-production software, you can also replace
``green`` with one of the other channels ``red`` (alpha-quality) or ``yellow`` (beta-quality).
For more information about channels, refer to the :doc:`/developers/buildrelease`.

.. _running-from-boot-stick:

Running UBOS from a boot stick
------------------------------

You can install UBOS on a USB flash drive, and boot a standard PC directly from it.
This will leave your PC's hard drive unchanged and lets you try out UBOS easily:

#. Download a UBOS boot image from `depot.ubos.net`. Production images are at
   `http://depot.ubos.net/green/x86_64/images <http://depot.ubos.net/green/x86_64/images>`_.
   Look for a file named ``ubos_green_x86_64_LATEST-1part.img``
   or ``ubos_green_x86_64_LATEST-1part.img.xz`` (the same, compressed; this will download
   more quickly and more cheaply). This file should **not** contain the letters
   ``-vbox``.

#. Write this image file "raw" to a USB flash drive. This operation depends on your
   operating system, and there are many excellent guides on-line for all sorts of
   operating systems.

   If you are on Linux, this should work:

   * Determine the device name of your USB flash drive. For example, run ``lsblk`` before
     you insert the USB flash drive, and then after. The device that has shown up is
     the device that you just inserted, minus the partition number (if any). For
     example, the device name may be ``/dev/sdx``.

     .. warning:: Make sure you get the device name right, otherwise you might accidentally
        destroy the data on some other hard drive!

        Also make sure your boot stick does not contain any valuable data; it will be
        mercilessly overwritten.

   * Determine the file name of the image you downloaded. Let's assume it is
     ``~/Downloads/ubos_green_x86_64_LATEST-1part.img``. If you downloaded a compressed
     version, uncompress the file first.

   * Write the image using ``dd``, such as::

         > dd if=~/Downloads/ubos_green_x86_64_LATEST-1part.img of=/dev/sdx bs=1M

     replacing ``/dev/sdx`` with the device name of your USB flash drive.

     This may take 10min or longer, depending on the speed of your USB drive, so be
     patient.

   * When done, for good measure::

        > sync

     and wait for a little bit. Rumor has it some flash drives keep writing for some
     time after the OS thinks they are done. If that is true for your device, and you
     remove the device prematurely, you may end up with a corrupted image without a good
     way of telling it happened.

#. Remove the USB flash drive, insert it into a spare x86 computer that is currently off,
   and boot that computer from the USB flash drive. Depending on that computer's BIOS,
   you may have to set it to allow booting from USB first, or change the boot order, so the
   computer actually boots from the USB flash drive and not some other drive. Some BIOSs
   are less than friendly about this, and you may need to experiment some.

#. When the boot process is finished, log in as user ``root``. By default, there is no
   password on the console.

#. If you have Ethernet plugged in, and your network runs DHCP (most networks do), your
   computer should automatically acquire an IP address. You can check with::

      > ip addr

   Make sure you are connected to the internet before attempting to proceed.

#. Update the code to the latest and greatest::

      > ubos-admin update

#. You are now ready to :doc:`set up your first app and site <firstsite>`.

.. _running-in-virtualbox:

Running UBOS in a VirtualBox virtual machine
--------------------------------------------

To run UBOS in a VirtualBox virtual machine, follow these instructions:

#. Download VirtualBox `from virtualbox.org <https://www.virtualbox.org/wiki/Downloads>`_ and install it
   if you haven't already.

#. Download the UBOS boot image for VirtualBox from `depot.ubos.net`. Production images are at
   `http://depot.ubos.net/green/x86_64/images <http://depot.ubos.net/green/x86_64/images>`_.
   Look for a file named ``ubos_green_x86_64_LATEST-1part-vbox.vmdk`` or
   ``ubos_green_x86_64_LATEST-1part-vbox.vmdk.xz`` (the same, compressed; this will download
   more quickly and more cheaply).
   This file **should contain** the letters ``-vbox``.

#. In VirtualBox, create a new virtual machine:

   * Click "New".

   * Enter a name for the virtual machine, such as "UBOS (green) 1".
     Select Type: "Linux", and Version: "Arch Linux (64 bit)". Click "Continue".

   * Select the amount of RAM you want to give it. 1024MB is a good start, and you can change
     that later. Click "Continue".

   * Select "Use an existing virtual hard drive file" and pick the downloaded boot image file
     in the popup. You may need to select the little icon there to get a file selection dialog.

   * In the main window, click "Start". The virtual machine should now be booting.

#. When the boot process is finished, log in as user ``root``. By default, there is no
   password on the console.

#. If you have not changed the VirtualBox default network configuration, and your host computer
   has internet connectivity, your virtual UBOS computer should automatically acquire an IP
   address. You can check with::

      > ip addr

   Make sure you are connected to the internet before attempting to proceed.
   For more information, refer to VirtualBox's
   `Virtual networking <http://www.virtualbox.org/manual/ch06.html>`_ documentation.

#. Update the code to the latest and greatest::

      > ubos-admin update

#. You are now ready to :doc:`set up your first app and site <firstsite>`.
