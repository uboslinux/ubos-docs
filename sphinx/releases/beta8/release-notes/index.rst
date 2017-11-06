Beta 8 Release Notes
====================

This release mostly contains incremental improvements and bug fixes.

For users
---------

* App upgrades:

  * Nextcloud 9.0.52

* New features:

  * ``ubos-admin createsite`` can now be used to configure more than one app at the
    same site. So for example, if you would like to run Wordpress at ``example.com/blog``
    and Nextcloud at ``example.com/files``, you can do this easily now with
    ``ubos-admin createsite``.

  * When restoring from backup, an alternate app can be specified. For example, given
    the recent `fork of ownCloud into NextCloud <http://karlitschek.de/2016/06/nextcloud/>`_,
    this allows users to easily migrate from
    ownCloud to Nextcloud on UBOS. Simply create a UBOS backup, undeploy your ownCloud site,
    and restore the backup with the extra flag ``--migratefrom owncloud --migrateto nextcloud``.
    Voila, your data will be restore into Nextcloud, which will run at the same host and
    with the same path as ownCloud used to. This new UBOS feature has been implemented as
    a generic mechanism and is not specific to ownCloud or Nextcloud.

  * The beginnings of IP version 6 support. So far, almost all of it is blocked in the
    firewall, however.

  * ``ubos-install`` now also knows how to set up swap partitions.

  * ``ubos-admin status`` now also reports on when the device was last updated.

  * All ``ubos-admin`` administration command invocations are now logged in the system journal.
    That helps with analyzing "how the heck did I get the system into this state?"

* Documentation

  * The netconfig JSON file is now documented
    (:doc:`/developers/networking`)

  * How to be the UBOS shepherd on Amazon EC2 or in a Linux container is now documented
    (:doc:`/users/shepherd-staff`)

  * Removed / added / improved a number of annoying / missing / wrong messages to the console.

* Fixes:

  * Site administrator passwords may now contain spaces.

  * When a reboot is necessary as part of a system upgrade, UBOS now correctly restores
    the apps and their configurations.

  * On Raspberry Pi, the obsoleted kernel module was removed that kept Pis from booting
    cleanly in the previous beta.

  * ``sudo ubos-install`` can now be run directly by the UBOS shepherd.

  * The missing Nextcloud icons have been added.

  * Rasptimer now works again with PHP7 on the Raspberry Pi.

  * Mediawiki installation had several issues in the last beta. It should work fine again.

* New packages now available on UBOS:

  * ``arp-scan`` for those users who like to now what's going on their network.

  * ``openvpn``: allows the creating or use of virtual private networks on UBOS. So far,
    manual setup is required.

* Deprecated for the time being:

  * Jenkins. Will reconsider if there is demand for it.

  * Mediagoblin. We will consider updating it again in UBOS once the Mediagoblin
    project matures further (see also issues
    `5 <https://github.com/uboslinux/ubos-mediagoblin/issues/5>`_ and
    `6 <https://github.com/uboslinux/ubos-mediagoblin/issues/6>`_).

For developers
--------------

* New features:

  * ``webapptest`` now can run on Arch Linux development machines and does not require
    UBOS to run.

  * The ``gladiwashere`` example toy app now has a (trivial) plug-in mechanism, and
    there's a simple plugin (``gladiwashere-footer``) for it. This helps explain how apps
    and accessories on UBOS work together to deliver customized experiences to users.

* New packages:

  * Apache ``mod_xsendfile`` for optimized file downloads to web clients.

  * ``nodejs``: first steps to allow Node-based apps on UBOS.

  * ``ruby-mysql``: MySQL driver for Ruby apps.

* Documentation:

  * Documentation for the ``names`` field in the UBOS manifest has been added
    `here </docs/developers/manifest/roles.html>`_.

Want to help?
-------------

Would you like to help out? Some issues `on Github <https://github.com/uboslinux/>`_
are now marked as "starter issues", i.e. bug or requested extensions to UBOS that are
likely easier to implement than others.

This is a great idea inspired by `up-for-grabs.net <http://up-for-grabs.net/>`_.

To upgrade
----------

All you need to do, as usual, is::

   > sudo ubos-admin update

Known problems
--------------

* The BeagleBone Black boot process may not work correctly in all configurations.
  We are currently reconsidering support for this device, as there have been far
  fewer downloads for it than for other devices.

* On Amazon EC2 instances, UBOS may boot into the "degraded" state because systemd
  service ``cloud-final`` failed during boot. This is a cosmetic issue only. To
  fix, log on and execute ``sudo systemctl restart cloud-final``.

Other than that, nothing should get in your way. If you encounter something that does,
file a bug `on GitHub <https://github.com/uboslinux/>`_.
