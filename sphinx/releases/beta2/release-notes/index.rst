Beta 2 Release Notes
====================

New features
------------

* UBOS has an installer now: ``ubos-install`` can install UBOS in a single command on a new
  system. It defaults to a suitable partitioning scheme for the type of device it is run on. It can also
  easily install in a RAID1 configuration on two or more drives, for better
  data protection.

* One-command setup of secure web sites using TLS. When invoking ``ubos-admin createsite``
  with arguments ``--tls --selfsigned``,
  UBOS will generate and install a self-signed certificate automatically; alternatively
  the user can provide keys and certificates from an official certificate authority.

* Hosts running UBOS now advertise themselves on the local network using mDNS/zeroconf.
  This solves the problem of "but what IP address does my box have"? Look for
  ``ubos-pc.local``, ``ubos-raspberry-pi.local`` on your local network.

* All apps that have newer versions have been upgraded, including:

  * Mediawiki 1.23.x -> 1.24

  * Jenkins 1.580.1 -> 1.580.3

  * Known 0.6.4 -> 0.7.1

  * Wordpress 4.0 -> 4.1

  * ownCloud 7.0.x -> 8.0.0. Also comes with automatic invocation of their data
    migration tool upon upgrades.

* Lots of more pre-release tests, including a
  `suite of workouts <https://github.com/uboslinux/ubos-workout>`_, more tests for the
  apps, and more test plans including tests for the correct generation of things such
  as ``robots.txt``.

* Apps can now contribute fragments to a :term:`Site`-wide ``robots.txt`` file. This allows each
  app at a :term:`Site` to exclude those URLs from search engine indexing that are within
  their domain.

* Wildcard sites -- sites that respond to any incoming virtual host name -- have been
  improved substantially.

* TLS key material can now be excluded from backups.

* Size of the system journal now limited.

* UBOS now uses btrfs as its default file system.

* User can now run some ``ubos-admin`` subcommands without needing to be root.

* Better error and warning messages.

New packages
------------

* On the Raspberry Pi, ``wiring-pi`` is now available for easy communications with
  the Raspberry Pi's GPIO pins.

* ``snapper``: takes periodic snapshots of the file system. Must be activated manually
  at this time. (``systemctl start snapper``)

* ``smartmontools``: tools for hard drive health monitoring. Must be activated manually
  at this time.

* Php archive (phar) support

* and some others.

Bug fixes from beta 1
---------------------

* Invoking ``ubos-admin`` more than once simultaneously is now being prevented.

* ``ubos-admin`` now advises the user to wait if the system isn't fully running yet.
  This is particularly useful right after the first boot when UBOS is still busy generating
  various cryptographic keys.

* The grub bootloader now reports UBOS, not Arch.

* Credentials for :term:`Site` administrators can now include special characters.

* Directories restored from backup now have correct permissions. Permissions for files
  and directories can be set separately right in the manifest.

* Confidential aspects of Site JSON files are only accessible by root.

* ``ubos-admin`` enforces fixed paths for those apps that required it (e.g. Known)

* Fixed errors during upgrade of Java-based apps

* Fixed Database permission errors when restoring selfoss data from backup


For developers
--------------
* There's a new example app for how to run a Java webapp under Tomcat, with an Apache
  reverse proxy in front so users don't have to use a different port number. (It's real easy!)
  This example app is called
  `gladiwashere-java <https://github.com/uboslinux/ubos-toyapps/tree/master/gladiwashere-java>`_
  and is a direct port of the equivalent php example app
  `gladiwashere <https://github.com/uboslinux/ubos-toyapps/tree/master/gladiwashere>`_.

* ``ubos-admin update`` now can limits its updates to a list of local packages. This is
  very convenient for the developer of a package.

* ``webapptest`` using the VirtualBox scaffold can now run against a local UBOS repo and
  does not need to run against ``depot.ubos.net``. This saves time and bandwidth.

* ``webapptest`` has become more versatile through additional command-line options, e.g.
  the hostname and context path at which to deploy the app.

* ``webapptest`` can now run multiple test plans during the same invocation. There are also
   more test plans.

Known issues
------------
* There is still no command that can show which :term:`Apps <App>` and :term:`Accessories <Accessory>` are available
  for install. For now, refer to the
  `UBOS Beta 2 is here blog post </blog/2015/02/09/ubos-beta2-is-here/>`_.

* Some sections in the documentation are still placeholders.

* On VirtualBox, ``cloud-init`` produces many messages (including apparent errors and
  warnings) on the console. These are harmless, but annoying. See
  https://github.com/uboslinux/ubos-admin/issues/22.

* Wildcard sites incorrectly redirect to https when TLS is used, see
  `bug report <https://github.com/uboslinux/ubos-admin/issues/42>`_.

`Last updated: 2015-02-09 16:30 PST`
