Running UBOS in a VirtualBox virtual machine
============================================

To run UBOS in a VirtualBox virtual machine, follow these instructions. Not counting
download times, this should take no more than 10 minutes to set up.

Note: UBOS is a 64bit operating system, for which VirtualBox requires hardware virtualization
support. This is generally available on all reasonably modern processors, but may have to
be switched on in the BIOS first. See `VirtualBox documentation <https://www.virtualbox.org/manual/ch10.html#hwvirt>`_.

#. `Download VirtualBox <https://www.virtualbox.org/wiki/Downloads>`_ from virtualbox.org
   and install it if you haven't already.

#. Download the UBOS boot image for VirtualBox from `depot.ubos.net`.
   Beta 1 images for x86 are at
   `http://depot.ubos.net/yellow/x86_64/images <http://depot.ubos.net/yellow/x86_64/images>`_.
   Look for a file named ``ubos_yellow_x86_64_LATEST-vbox.vmdk`` or
   ``ubos_yellow_x86_64_LATEST-vbox.vmdk.xz`` (the same, compressed). This file
   **should contain** the letters ``-vbox``, indicating that it contains VirtualBox-supporting
   code.

#. In VirtualBox, create a new virtual machine:

   * Click "New".

   * Enter a name for the virtual machine, such as "UBOS (yellow) 1".
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
   (For now, ignore that the boot loader says "Arch Linux". See
   `this issue <https://github.com/indiebox/macrobuild-ubos/issues/2>`_.)

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
