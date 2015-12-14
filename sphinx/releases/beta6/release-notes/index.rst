Beta 6 Release Notes
====================

New features
------------

* New platforms:

  * The $5 Raspberry Pi Zero is confirmed to run UBOS out of the box.

  * UBOS images are now available on the Docker hub.

* Security:

  * All images uploaded to ``depot.ubos.net`` are now digitally signed by
    ``buildmaster@ubos.net``. All packages had been signed previously.

* New network configuration:

  * New network configuration ``public-gateway`` sets up UBOS in "home router" mode with
    masquerading etc just like network configuration ``gateway``, except that installed apps
    are accessible not only from the local network but also from the public internet.

* New packages:

  * Package ``netatalk`` (Apple file sharing protocols) is now available. So far, it requires
    manual configuration and is off by default.

Bug fixes and improvements
--------------------------

* Application upgrades:

  * ownCloud upgraded to 8.2.1.

* Tool and build improvements:

  * ``webapptest``, when running with the ``container`` scaffold, names its containers and
    associated virtual ethernet interfaces differently to avoid name collisions if more
    than one test is being run concurrently on the same host.

  * ``webapptest``, when running with the ``container`` scaffold, will now automatically
    generate a new ssh keypair for container communication if none is given. This makes
    setup a lot easier.

  * Logging and error reporting improvements.

  * ``macrobuild`` parameters can now be overridden from the command-line.

* Bug fixes:

  * The ``gateway`` network configuration now configures the DNS firewall rule correctly
    for devices on the local network.

  * No more manual package installations are required for ``ubos-install`` and ``mDNS``.
    mDNS resolution works out of the box.

* Other changes:

  * The home directory of the shepherd is now being created on ``/var``.

To upgrade
----------

All you need to do, as usual, is::

   > sudo ubos-admin update


Known problems
--------------

* The BeagleBone Black boot process may not work correctly in all configurations.
  We are currently reconsidering support for this device, as there have been far
  fewer downloads than for other devices.

Other than that, nothing should get in your way. If you encounter something that does,
file a bug `on GitHub <https://github.com/uboslinux/>`_.
