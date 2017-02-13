Beta 10 Release Notes
=====================

For users
---------

* New features:

  * Create a Tor hidden service instead of a regular website by adding ``--tor`` to the
    ``ubos-admin createsite`` command.

* Major app upgrades:

  * Nextcloud 11
  * Selfoss 2.16

* Hundreds of upgraded packages.

* Major bug fixes:

  * Improved build process so packages without signatures aren't accidentally published.

  * VirtualBox image now has the proper package support, and uses btrfs

  * Automatic renewal of expiring Letsencrypt certificate

  * Whether btrfs snapshots are created before and after ubos-admin update is now configurable.
    A number of issues was fixed relating to brtfs snapshots.

  * The shepherd user may now perform ``sudo snapper``.

  * The mDNS hostname for UBOS on VirtualBox is now ``ubos-vbox-pc.local``

* Improved documentation.

* All images for all platforms have been updated.


For developers
--------------

* The repositories have been split into mainstream and experimental parts. For example,
  repository ``hl`` continues to contain "headless" applications; it has been joined
  by new repository ``hl-experimental`` that also contains "headless" applications,
  but whose support is tentative and may be removed in the future.

  By default, the experimental repositories are not active and must be enabled manually.
  To do so, copy ``/etc/pacman.d/repositories.d/hl`` to
  ``/etc/pacman.d/repositories.d/hl-experimental`` and edit the contained path
  to reference ``hl-experimental`` instead of ``hl``.

Known issues
------------

* Mattermost requires the user invoke ``ubos-admin setnetconfig`` after install. This
  is because Mattermost opens up a non-standard port, and UBOS currently only reconfigures
  its firewall when ``ubos-admin setnetconfig`` is invoked.

* When running UBOS in a VirtualBox virtual machine, and using the (default) Intel Pro/1000
  MT Desktop (82540EM) virtual ethernet interface, UBOS may not be able to obtain a
  network connection, and messages containing "Reset adapter" may be continuously
  written the control. To avoid this, shut down the virtual machine, and from the
  VirtualBox toolbar select "Machine", then "Settings", click on the "Network" tab.
  For the active "Adapter 1", click on "Advanced" and select Adapter Type
  "PCnet-PCI II". Click "OK" and start the virtual machine again.

* The original Raspberry Pi 1 may time out when attempting to set up a Tor site, and
  not complete the setup.  We are currently considering to end-of-life for this device.
  The other Raspberry Pi's will not be affected.

* The BeagleBone Black boot process may not work correctly in all configurations.
  We are currently reconsidering support for this device, as there have been far
  fewer downloads for it than for other devices.

Other than that, nothing should get in your way. If you encounter something that does,
file a bug `on GitHub <https://github.com/uboslinux/>`_.

Thanks to contributors `Julian Foad <https://github.com/julianfoad>`_ and
`pyj677 <https://github.com/pyj677>`_.
