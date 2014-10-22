Setting up a UBOS development machine in VirtualBox
===================================================

To develop on UBOS, it is easiest to set up a suitable development machine that runs
UBOS, plus development tools from Arch Linux (of which UBOS is a derivative).

It might be easiest, and cheapest, to set up such a development machine using VirtualBox,
free virtualization software available on many platforms from Oracle. It works great on
our Macs, and takes only about 15 minutes to set up (not counting download times).

To create a UBOS development machine in VirtualBox, follow these steps:

#. `Download VirtualBox <https://www.virtualbox.org/wiki/Downloads>`_ and install it
   if you haven't already.

#. `Download an Arch Linux boot image <https://www.archlinux.org/download/>`_ and
   save it in a convenient place.

#. In VirtualBox, create a new virtual machine:

   * Click "New".

   * Enter a name for the virtual machine, such as "UBOS (red)" if you are planning to
     develop on the UBOS red channel. Select Type: "Linux", and Version:
     "Arch Linux (64 bit)". Click "Continue".

   * Select the amount of RAM you want to give it. 2048MB is a good start, and you can change
     that later. Click "Continue".

   * Select "Create a virtual hard drive now", and click "Create".

   * Select any of the types available for the new virtual hard drive. The default ("VDI")
     is fine. Click "Continue".

   * Select either "Dynamically allocated" or "Fixed size". "Dynamically allocated" often
     uses significantly less space on your hard drive. Click "Continue".

   * Accept the default name for the virtual hard drive file. Pick a size that is sufficient
     for what you want to do. 16GB or more is recommended, particularly if you are planning
     to run a Linux desktop environment in your development virtual machine.

     If you selected
     "Dynamically allocated" in the previous step, the file containing your virtual hard drive
     will only grow to that size if you actually fill it with that much data. Click "Create".

#. Now start the virtual machine by selecting it in the sidebar, and clicking "Start".
   When it asks you, select the Arch Linux boot image ISO file that you downloaded earlier
   as the start-up disk. You may need to select the little icon there to get a file
   selection dialog. Click "Start". The virtual machine should now be booting.

#. The Arch Linux boot loader has several options. The first one (``Boot Arch Linux (x86_64)``)
   is the one you want to select. Press the Return key.

#. Once the boot process has finished and you get a root
   shell, you are not done: you only managed to boot from the install disk image, you do not
   have a runnable system yet. In this respect, ArchLinux is different from other Linux distros.

#. In the shell that came up, perform the actual installation. The following steps should
   work. If you need more information, consult the
   `Arch Linux installation guide <https://wiki.archlinux.org/index.php/Installation_Guide>`_:

   #. Partition the virtual root disk ``/dev/sda`` that VirtualBox allocated for you, e.g.::

         fdisk /dev/sda

      Select ``n`` and the defaults. Then select ``w`` to write changes to disk.

   #. Create a filesystem for your partition. UBOS uses btrfs by default::

         mkfs.btrfs /dev/sda1

      Ignore the warning about btrfs being experimental. (Wondering when they will finally
      remove that one.)

   #. Mount your future root partition in a place where you can install software::

         mount /dev/sda1 /mnt

   #. Make sure you have a network connection::

         ip addr

      will show whether you have an IP address, and which virtual networking devices
      are available. If you do not have an IP address, here is `more information on
      VirtualBox networking modes <http://www.virtualbox.org/manual/ch06.html>`_.
      The virtual machine is looking for a DHCP server to assign one automatically.

   #. Perform the actual install. This will download and install a lot of packages and
      thus may take a while, depending on your network speed::

         pacstrap /mnt base

   #. Create the right ``fstab`` by executing::

         genfstab -p /mnt >> /mnt/etc/fstab

   #. Chroot into your future root disk and finish the installation::

         arch-chroot /mnt

      * Install the btrfs tools::

            pacman -S btrfs-progs

      * Create a Ramdisk::

            mkinitcpio -p linux

      * Install a boot loader::

            pacman -S grub
            grub-install --recheck /dev/sda
            grub-mkconfig -o /boot/grub/grub.cfg

      * Install a Locale. Edit ``/etc/locale.gen``, and uncomment this line::

            #en_US.UTF-8 UTF-8

        so it looks like this::

            en_US.UTF-8 UTF-8

        You can also uncomment whatever other locales you might want. Then run::

            locale-gen

      * Make sure your virtual machine gets an IP address after reboot::

            systemctl enable dhcpcd

      * Exit from the chroot shell with ctrl-d.

   #. Shut down the virtual machine::

           shutdown -h now

   #. When the guest virtual machine is shut down, remove the ISO file from the
      virtual CD/DVD drive. To do that:

      * Select the virtual machine in the sidebar.

      * Click "Settings".

      * Pick the "Storage" tab.

      * In the "Storage Tree", select the virtual CD/DVD drive.

      * In the right pane, click the little CD icon and select
        "Remove disk from virtual drive" in the pop-up that comes up.

      * Click OK.

   #. Then, start the virtual machine again and log on as root. There is no password by
      default. (You might want to change that.)

   #. Add the UBOS repositories. Add the following lines to ``/etc/pacman.conf``::

         [os]
         Server = http://depot.ubos.net/red/$arch/os
         [hl]
         Server = http://depot.ubos.net/red/$arch/hl
         [tools]
         Server = http://depot.ubos.net/red/$arch/tools
         [virt]
         Server = http://depot.ubos.net/red/$arch/virt

      Note the ``red`` in these URLs, which reflects the :term:`Release channel` on
      which you will be developing. ``red`` is recommended for development.

   #. Add the UBOS buildmaster as a trusted source of packages::

         pacman-key -r F55B8552153EC14D
         pacman-key --lsign-key F55B8552153EC14D

   #. Install the packages that you intend to use. Typically that is at least:

      * ``base-devel``: Basic tools to create UBOS/Arch Linux packages
      * ``ubos-admin``: UBOS administration commands
      * ``virtualbox-guest``: Makes VirtualBox behave more nicely by allowing drag-and-drop
        and the like with your host operating system. Unfortunately that will pull in a
        significant number of X-Windows packages as well.

      To install those::

         pacman -Syu
         pacman -S base-devel ubos-admin virtualbox-guest

      If it asks you whether you'd like only a selection of some packages
      instead of all, we recommend you say "all" so you won't miss stuff later.
      If you are asked which "providers" you'd like to use for packages that are
      available in more than one repository, select the UBOS ones (``os``, ``hl``,
      ``tools`` and ``virt``).

      Then, enable the UBOS and VirtualBox services::

         systemctl enable ubos-admin vboxservice
         systemctl start ubos-admin vboxservice

   #. Install whatever other development tools you might want or need. For example::

         pacman -S git

   #. If you like to use a graphical environment such as KDE, you should create a
      non-root user (example: ``joe``) before you enable the graphical environment::

         useradd -m joe
         passwd joe

         pacman -S kde
         systemctl enable kdm.service

   #. Reboot, and you are done! You should now be able to log in graphically with the
      user you created, and develop on UBOS!
