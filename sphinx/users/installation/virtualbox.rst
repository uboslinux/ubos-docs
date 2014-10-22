Running UBOS in a VirtualBox virtual machine
============================================

To run UBOS in a VirtualBox virtual machine, follow these instructions. Not counting
download times, this should take no more than 10 minutes to set up.

#. Download VirtualBox `from virtualbox.org <https://www.virtualbox.org/wiki/Downloads>`_ and install it
   if you haven't already.

#. Download the UBOS boot image for VirtualBox from `depot.ubos.net`.
   Alpha images are at
   `http://depot.ubos.net/red/x86_64/images <http://depot.ubos.net/red/x86_64/images>`_.
   Look for a file named ``ubos_red_x86_64_LATEST-1part-vbox.vmdk`` or
   ``ubos_red_x86_64_LATEST-1part-vbox.vmdk.xz`` (the same, compressed; this will download
   more quickly and more cheaply).
   This file **should contain** the letters ``-vbox``.

#. In VirtualBox, create a new virtual machine:

   * Click "New".

   * Enter a name for the virtual machine, such as "UBOS (red) 1".
     Select Type: "Linux", and Version: "Arch Linux (64 bit)". Click "Continue".

   * Select the amount of RAM you want to give it. 1024MB is a good start, and you can change
     that later. Click "Continue".

   * Select "Use an existing virtual hard drive file" and pick the downloaded boot image file
     in the popup. You may need to select the little icon there to get a file selection dialog.
     Click "Create".

#. By default, VirtualBox will put your virtual machine behind a special VirtualBox NAT on
   your local host. That means you wouldn't be able to access it with a web browser.
   To avoid this, either:

   * Set your networking mode to "bridged": Click on "Network". In the pop-up,
     select tab "Adapter 1", and choose "Bridged Adapter". Click "Ok". (This should work
     unless your Ethernet or Wifi network isn't willing to hand out more than one DHCP address
     to the same machine; it happens on some tightly managed networks). Or:

   * Activate two virtual networking interfaces, one as "NAT", and one as "Host-only Adapter":
     Click on "Network" in the right pane. In the pop-up, first select tab "Adapter 1", and choose "NAT".
     Then, select tab "Adapter 2", make sure that "Enable Network Adapter" is checked,
     and choose "Host-only Adapter". Click "Ok".

#. In the main window, click "Start". The virtual machine should now be booting.
   (For now, ignore that the boot loader says "Arch Linux". As we said, UBOS is an
   Arch Linux derivative.)

#. When the boot process is finished, UBOS should announce itself on the console.
   Log in as user ``root``. By default, there is no password on the console.

#. If you have not changed the VirtualBox default network configuration, and your host computer
   has internet connectivity, your virtual UBOS computer should automatically acquire an IP
   address. You can check with::

      > ip addr

   Make sure you are connected to the internet before attempting to proceed.
   For more information, refer to VirtualBox's
   `Virtual networking <http://www.virtualbox.org/manual/ch06.html>`_ documentation.

#. Update the code to the latest and greatest::

      > ubos-admin update

#. You are now ready to :doc:`set up your first app and site </users/firstsite>`.
