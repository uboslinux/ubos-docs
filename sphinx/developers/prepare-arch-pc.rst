Prepare a PC to develop for UBOS using Arch Linux
=================================================

To set up an Arch Linux system for UBOS development, first prepare
a suitable x86_64 PC:

#. On a different computer, download a 64bit Arch Linux boot image from
   `here <https://www.archlinux.org/download/>`_ and save it in a convenient
   place. You only need it for the installation and you can delete it later.

#. Write the downloaded image to a medium (like a USB boot stick) from which you can boot
   your PC. Other than the filename being different, it works just the same as writing a
   UBOS image to a boot stick, which is documented
   :doc:`here <../users/writing-image>` or on the
   `Arch Linux wiki <https://wiki.archlinux.org/index.php/USB_flash_installation_media>`_.

#. Insert your boot medium, and boot your PC from that medium. Depending on that computer's BIOS,
   you may have to set its BIOS to allow booting from USB first, or change the boot order, so the
   computer actually boots from the USB flash drive and not some other drive. Some BIOSs
   are less than friendly about this and hide this setting in very strange places, and
   you may need to experiment some.

#. The Arch Linux boot loader has several options. The first one (``Boot Arch Linux (x86_64)``)
   is the one you want to select. Press the Return key.

Continue with :doc:`install-arch`.
