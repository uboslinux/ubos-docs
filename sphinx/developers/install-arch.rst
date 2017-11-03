Continuing the Arch Linux installation on a PC or virtual machine
=================================================================

This section assumes that you have prepared your PC or virtual machine as
described in :doc:`prepare-arch-pc` or :doc:`prepare-arch-virtualbox`.

#. Once the boot process has finished and you get a root shell, you are not done: you only
   managed to boot from the install disk image, you do not have a runnable system yet. In
   this respect, ArchLinux is different from other Linux distros.

#. In the shell that came up, perform the actual installation. The following steps should
   work. If you need more information, consult the
   `Arch Linux installation guide <https://wiki.archlinux.org/index.php/Installation_Guide>`_:

   #. Partition your root disk ``/dev/sda`` in a way that makes sense to you, e.g.
      using a single partition::

         > fdisk /dev/sda

      Select ``n`` and the defaults. Then select ``w`` to write changes to disk.

   #. Create a filesystem for your partition. While you can use any filesystem, we recommend
      ``btrfs`` as it is tightly integrated with ``systemd-nspawn``, the ``systemd``
      container tool. This may save you a substantial amount of disk space if you might
      run several UBOS instances in containers later on, e.g. for testing::

         > mkfs.btrfs /dev/sda1

   #. Mount your future root partition in a place where you can install software::

         > mount /dev/sda1 /mnt

   #. Make sure you have a network connection::

         > ip addr

      will show whether you have an IP address, and which networking devices
      are available. If you are in VirtualBox and have trouble, here is `more information on
      VirtualBox networking modes <http://www.virtualbox.org/manual/ch06.html>`_.
      By default, your machine is looking for a DHCP server to obtain an
      IP address from on all available network interfaces.

   #. Perform the actual install. This will download and install a lot of packages and
      thus may take a while, depending on your network speed::

         > pacstrap /mnt base

   #. Create the right ``fstab`` by executing::

         > genfstab -p /mnt >> /mnt/etc/fstab

   #. Chroot into your future root disk and finish the installation::

         > arch-chroot /mnt

      * If you chose btrfs, install the btrfs tools::

         >   pacman -S btrfs-progs

      * You also need a boot loader and sudo::

         >   pacman -S grub sudo

      * If you are on VirtualBox, also install the VirtualBox client tools::

         >   pacman -S virtualbox-guest-modules-arch virtualbox-guest-utils

      * Create a Ramdisk::

         >   mkinitcpio -p linux

      * Configure the boot loader::

         >   grub-install --recheck /dev/sda
         >   grub-mkconfig -o /boot/grub/grub.cfg

      * Install a Locale. Edit ``/etc/locale.gen``, and uncomment this line::

         #en_US.UTF-8 UTF-8

        so it looks like this::

         en_US.UTF-8 UTF-8

        You can also uncomment whatever other locales you might want. Then run::

         >   locale-gen

      * Exit from the chroot shell with ctrl-d.

   #. Set up networking. There are many options. We recommend using ``systemd-networkd``
      and ``systemd-resolved`` in the way UBOS does it so UBOS containers and the Arch
      Linux host play nicely::

         > rm /mnt/etc/resolv.conf
         > ln -s /run/systemd/resolve/resolv.conf /mnt/etc/resolv.conf
         > arch-chroot /mnt systemctl enable systemd-networkd systemd-resolved

      Also create file ``/mnt/etc/systemd/network/wired.network`` with the following
      content::

         [Match]
         Name=en*

         [Network]
         DHCP=ipv4
         IPForward=1

      The ``IPForward`` setting is necessary if you plan to run or test UBOS in a
      Linux container, so it can reach the internet.

   #. Shut down the machine::

         > shutdown -h now

   #. While the machine is shut down, remove the installation medium from the drive. If
      you are on VirtualBox, remove the ISO file from the virtual CD/DVD drive. To do that:

      * Select the virtual machine in the sidebar.

      * Click "Settings".

      * Pick the "Storage" tab.

      * In the "Storage Tree", select the virtual CD/DVD drive.

      * In the right pane, click the little CD icon and select
        "Remove disk from virtual drive" in the pop-up that comes up.

      * Click OK.

   #. Then, start the machine again and log on as root. There is no password by
      default. You might want to change that, by saying::

         passwd

   #. Create a non-root user (example: ``joe``, change as needed). Use this user when
      developing instead of doing everything as ``root``. Also allow the user to become
      ``root`` with ``sudo`` as needed, and set a password for it::

         useradd -m joe
         passwd joe
         cat > /etc/sudoers.d/joe
         joe ALL = NOPASSWD: ALL
         ^D
         chmod 600 /etc/sudoers.d/joe

   #. Install the desktop environment you might want to use. For example, to use
      KDE with the plasma desktop::

         pacman -S xorg-server sddm plasma-meta konsole
         systemctl enable sddm

   #. If you are on VirtualBox, enable the VirtualBox client tools::

         systemctl enable vboxservice

Continue to :doc:`install-ubos-tools`.
