Run UBOS in a virtual machine (64bit)
=====================================

To run UBOS in a VirtualBox virtual machine, follow these instructions. Not counting
download times, this should take no more than 10 minutes to set up.

While we don't have separate instructions for VMware, the process should be quite similar.

Note: UBOS is a 64bit operating system, for which VirtualBox requires hardware virtualization
support. This is generally available on all reasonably modern processors, but may have to
be switched on in the BIOS first. See `VirtualBox documentation <https://www.virtualbox.org/manual/ch10.html#hwvirt>`_.

#. `Download VirtualBox <https://www.virtualbox.org/wiki/Downloads>`_ from virtualbox.org
   and install it if you haven't already.

#. Download the UBOS boot image for VirtualBox from `depot.ubos.net`.
   Beta images for Virtualbox (64bit) are at
   `http://depot.ubos.net/yellow/x86_64/images <http://depot.ubos.net/yellow/x86_64/images>`_.
   Look for a file named ``ubos_yellow_vbox-pc_LATEST.vmdk.xz``.
   This file **should contain** the letters ``vbox-pc``, indicating that it contains
   VirtualBox-supporting code.

#. Optionally, you may now verify that your image downloaded correctly by following the instructions
   at :doc:`verifying`.

#. Uncompress the downloaded file. This depends on your operating system, but might be as easy as
   double-clicking it, or executing

   .. code-block:: none

      > xz -d ubos_yellow_vbox-pc_LATEST.vmdk.xz

   on the command line.

#. In VirtualBox, create a new virtual machine:

   * Click "New".

   * Enter a name for the virtual machine, such as "UBOS (yellow)".
     Select Type: "Linux", and Version: "Other Linux (64 bit)". Click "Continue".

   * Select the amount of RAM you want to give it. 1024MB is a good start, and you can change
     that later. Click "Continue".

   * Select "Use an existing virtual hard drive file" and pick the downloaded boot image file
     in the popup. You may need to select the little icon there to get a file selection dialog.
     Click "Create".

#. By default, VirtualBox will put your virtual machine behind a special VirtualBox NAT on
   your local host. That means you wouldn't be able to access it with a web browser.
   To avoid this, either:

   * Set your networking mode to "bridged": Click on "Network". In the pop-up,
     select tab "Adapter 1", and choose "Bridged Adapter", and in the "Name" field choose the
     host system's network adapter that connects to your Ethernet or Wifi network.
     Click "Ok". (This should work
     unless your Ethernet or Wifi network isn't willing to hand out more than one DHCP address
     to the same machine; it happens on some tightly managed networks). Or:

   * Activate two virtual networking interfaces, one as "NAT", and one as "Host-only Adapter":
     Click on "Network" in the right pane. In the pop-up, first select tab "Adapter 1", and choose "NAT".
     Then, select tab "Adapter 2", make sure that "Enable Network Adapter" is checked,
     and choose "Host-only Adapter". Click "Ok".

#. In the main window, click "Start". The virtual machine should now be booting.

#. When the boot process is finished, log in as user ``root``. By default, there is no
   password on the console.

#. Wait until UBOS is ready. You can tell by executing:

   .. code-block:: none

      > systemctl is-system-running

   On the first boot, this may take a while, because UBOS has to generate some cryptographic
   keys, and Linux is trying very hard to use good random numbers for that purpose. On VirtualBox,
   UBOS cheats by generating random numbers using the ``haveged`` package. Virtual machines are
   notorious for having little available entropy, and without ``haveged``, you'd have to wait
   far too long until the keys are generated. The downside is that the generated random numbers
   may be a bit less random; that should only matter to you if you are truly paranoid, however.

   Wait until the output has changed from ``starting`` to ``running``. If it is anything else, consult
   :doc:`troubleshooting<../troubleshooting>`.

   If you are on VMWare, the VirtualBox kernel extension is going to fail. This is no cause
   for concern, simply disable them by removing file ``/etc/modules-load.d/virtualbox.conf``.

#. If you have not changed the VirtualBox default network configuration, and your host computer
   has internet connectivity, your virtual UBOS computer should automatically acquire an IP
   address. You can check with

   .. code-block:: none

      > ip addr

   Make sure you are connected to the internet before attempting to proceed.
   For more information, refer to VirtualBox's
   `Virtual networking <http://www.virtualbox.org/manual/ch06.html>`_ documentation.

#. Update UBOS to the latest and greatest:

   .. code-block:: none

      > ubos-admin update

#. You are now ready to :doc:`set up your first app and site </users/firstsite>`.
