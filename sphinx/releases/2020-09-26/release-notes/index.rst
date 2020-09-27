Release Notes: UBOS update 2020-09-26
=====================================

To upgrade
----------

To be safe, first create a backup of all your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

What's new
----------

New features
^^^^^^^^^^^^

* ``ubos-install`` has largely been rewritten, for more options and easier extensibility
  in the future. It is now also able to handle a larger variety of external flash disks and
  controllers and won't fail if the disk controller reports a "strange" geometry.
* ``ubos-install`` now will refuse to start if it does not appear an internet connection
  is available, and downloading of UBOS packages would fail.
* The device class ``odroid-xu3`` enables UBOS to run on ODROID devices XU3, XU4, as
  well as HC1 and HC2. :doc:`More details </users/installation/odroid-xu3>`.
* On a Raspberry Pi 4, UBOS can now boot directly from an external USB disk. This means
  SD cards are not needed any more for UBOS on the Pi 4, which translates into faster
  speeds and higher reliability. (Depending on the version of the boot loader that your
  Pi 4 has, you may need to temporarily use an SD card to upgrade the bootloader, but that
  is a one-time operation.) :doc:`More details </users/installation/raspberrypi4>`.
* Logging on as the ``root`` user now requires a password.
  :doc:`More details </users/faq>`.

Notable new packages:
^^^^^^^^^^^^^^^^^^^^^

* Package ``rpi-eeprom`` lets you update your Raspberry Pi 4's bootloader, so you can
  boot entirely without SD card from a USB stick or disk.
  :doc:`More details </users/devices/raspberrypi>`.
* Package ``pi-bluetooth`` are Bluetooth drivers for the Raspberry Pi 3.
* Package ``ntfs-3g`` for mounting NTFS disks

Package upgrades:
^^^^^^^^^^^^^^^^^

Over 700 packages were upgraded.

Bug fixes
^^^^^^^^^

The usual: fixed bugs and made improvements. You can find the closed issues
`on Github <https://github.com/uboslinux/>`_ tagged with milestone ``ubos-23``.

Known problems
--------------

Note: You may receive a message that says "Failed to refresh some expired keys".
This is harmless and you can ignore it. As part of this update, we have switched to
different key servers that are less likely to have this problem.

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
