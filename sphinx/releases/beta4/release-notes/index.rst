Beta 4 Release Notes
====================

New features
------------

* **New app:** Mediagoblin, the GNU Project's photo and media sharing application, is now available
  on UBOS for single-command installation and management
  (`more about Mediagoblin <http://mediagoblin.org/>`_)

* **New app:** Webtrees, a full-featured web genealogy application, is now available
  on UBOS for single-command installation and management
  (`more about Webtrees <http://www.webtrees.net/>`_)

* **Major:** Applications on UBOS can now use the Postgresql database as an alternative
  to MySQL
  (`more about Postgresql <https://en.wikipedia.org/wiki/PostgreSQL>`_)

* MySQL is not required any more for UBOS, and instead demand-installed like Postgresql or
  applications.

* UBOS now automatically generates an SSH key pair on a suitable flash drive (the
  "UBOS staff") during boot that enables password-less, secure SSH login to the UBOS device
  over the network, with minimal hassle for the user (the "UBOS shepherd"). Read
  `more about the UBOS staff <http://ubos.net/docs/users/shepherd-staff.html>`_

* Eliminate long initial boot times by activating pre-installed ``haveged``. Simply run
  ``systemctl enable haveged``.

* Automatic system reboot if an upgrade advises that. The single-command full-stack upgrade
  ``ubos-admin update`` now uses a heuristic whether a reboot is necessary (e.g. if the
  Linux kernel was updated). Options exist to override this heuristic
  (`ubos-admin issue 83 <https://github.com/uboslinux/ubos-admin/issues/83>`_,
  `ubos-admin issue 43 <https://github.com/uboslinux/ubos-admin/issues/43>`_)

* Better progress messages during long operations, e.g. generating the TLS keys for
  https websites
  (`ubos-admin issue 61 <https://github.com/uboslinux/ubos-admin/issues/61>`_)

* New command ``ubos-admin status`` is beginning to report on the device status.
  Currently it only reports on manually modified configuration files, but over time, it
  have more to say.

* Applications can now specify that they need ``systemd`` services or timers. UBOS will
  activate/enable and deactivate/disable the corresponding services or timers when
  the application is deployed and undeployed. Mediagoblin already uses this for
  running background processing tasks.

Application upgrades
--------------------

* Jenkins: upgraded to 1.596.2

* Known: upgraded to 0.7.5

* ownCloud: upgraded to 8.0.2

* Wordpress: upgraded to 4.1.1

Changes
-------

* The AppConfigItem type ``mysql-database`` has been renamed ``database``,
  and can also be applied to databases other than MySQL.

Bug fixes
---------

* The Selfoss RSS Aggregator app can now be run at a self-signed TLS site
  (`ubos-selfoss issue 2 <https://github.com/uboslinux/ubos-selfoss/issues/2>`_)

* Mediawiki can now be run correctly at a self-signed TLS site
  (`ubos-mediawiki issue 6 <https://github.com/uboslinux/ubos-mediawiki/issues/6>`_)

* Mediawiki image upload fixed
  (`ubos-mediawiki issue 5 <https://github.com/uboslinux/ubos-mediawiki/issues/5>`_)

* Mediawiki warnings removed
  (`ubos-mediawiki issue 3 <https://github.com/uboslinux/ubos-mediawiki/issues/3>`_)

* Java apps can now be run at wildcard sites
  (`ubos-toyapps issue 4 <https://github.com/uboslinux/ubos-toyapps/issues/4>`_)

* BeagleBone Black now uses btrfs, like the other UBOS platforms
  (`ubos-admin issue 71 <https://github.com/uboslinux/ubos-admin/issues/71>`_)

* Undeploy also removes TLS certs
  (`ubos-admin issue 70 <https://github.com/uboslinux/ubos-admin/issues/70>`_)

* Shepherd can now issue shutdown and reboot commands
  (`ubos-admin issue 66 <https://github.com/uboslinux/ubos-admin/issues/66>`_)

* Non-TLS site accessed via https redirects back to http
  (`ubos-admin issue 65 <https://github.com/uboslinux/ubos-admin/issues/65>`_)

* Better error detection for invalid Site JSON files
  (`ubos-admin issue 64 <https://github.com/uboslinux/ubos-admin/issues/64>`_,
  `ubos-admin issue 63 <https://github.com/uboslinux/ubos-admin/issues/63>`_)

* Console banner shows UBOS device class
  (`ubos-admin issue 59 <https://github.com/uboslinux/ubos-admin/issues/59>`_)

* Can create site JSON files with ``ubos-admin createsite`` even if
  they would conflict with an existing site, as long as they are not
  deployed
  (`ubos-admin issue 56 <https://github.com/uboslinux/ubos-admin/issues/56>`_)

* Keeping site JSON clean
  (`ubos-admin issue 53 <https://github.com/uboslinux/ubos-admin/issues/53>`_)

* Removed unnecessary console output
  (`ubos-admin issue 54 <https://github.com/uboslinux/ubos-admin/issues/54>`_)

* Shrank size of UBOS images by not shipping pacman files in ``/var/cache``
  (`ubos-admin issue 52 <https://github.com/uboslinux/ubos-admin/issues/52>`_)

New packages
------------

* ``fakeroot``, ``wpa_supplicant``, ``postgresql``, ``vim``, ``ntop``,
  ``iproute2``, ``screen``, ``lsof``, ``arp-scan`` and others.

Quality assurance and testing
-----------------------------

* UBOS automated testing now tests a larger state machine of redeploys of an application:
  deploy app to named host, redeploy, to the same named host, redeploy to a wildcard host and
  back to the named host
  (`ubos-tools issue 7 <https://github.com/uboslinux/ubos-tools/issues/7>`_)

* UBOS automated testing now tests the generation of "well-known" files such as ``robots.txt``.

* Test harness now knows how to wait until a Tomcat application running behind an Apache reverse
  proxy is available
  (`ubos-toyapps issue 2 <https://github.com/uboslinux/ubos-toyapps/issues/2>`_)

Known issues
------------

Currently none.

`Last updated: 2015-04-13 11:30 PST` with small formatting edits `2016-08-15 17:30 PST`.
