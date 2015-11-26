Beta 5 Release Notes
====================

New features
------------

* Development tools for app developers

  * No more hybrid Arch/UBOS installation required: instead, UBOS now provides a separate
    package repository containing UBOS tools that can be cleanly added to an Arch installation

  * ``webapptest`` now know how to run tests in a ``systemd-nspawn`` container; this
    is now the default

  * ``webapptest`` options can be specified in a separate JSON file. Command-line options
    override

  * ``webapptest`` automatically generates any Shepherd ssh keys it needs for tests

  * ``ubos-repo``: protocol change for upload now using rsync. Also, cleanly supports
    multiple instances of ``ubos-repo`` on same host

  * added ``ubos-misc-tools``: ``git-360`` and ``git-commits-since`` report on status of
    several git repositories at once

* Download images are now digitally signed, just like the packages

* Networking:

  * Moved to ``systemd-networkd`` for all networking; removed ``dhcpcd``

  * Now always runs ``systemd-timesyncd`` for system clock synchronization

  * Internal refactorying of ``ubos-admin setnetconfig``. It is now extensible and
    new netconfigs can be added easily.

  * Firewall: by default, UBOS now runs a stateful firewall that denies all incoming traffic
    other than traffic specifically allowed. What traffic is allowed depends on the
    network configuration in effect.

  * Netconfig 'gateway': single-command configuration of a home gateway/router with
    private LAN, DHCP, local DNS, and a masquerading firewall. Allows app access from
    the LAN but not from the public internet.

  * Netconfig 'standalone': single-command configuration of a network controller with
    DHCP and local DNS for disconnected networks

  * removed command ``ubos-admin listnics``: this did not turn out to be useful.

* Middleware

  * diet4j Java package management available

  * Upgraded to Java 8

  * Tomcat now always uses ``tomcat-native`` for improved performance

* Application upgrades

  * Jenkins, with a new patch that turns of Jenkins mDNS advertisements

  * Known

  * Mediagoblin. Also fixed installation issue on Raspberry Pi 2.

  * Mediawiki

  * Wordpress and plugins

* Management infrastructure

  * ``ubos-admin createsite`` now orders the questions about customization points.
    A new field
  * Consistently use ``deploy``/``undeploy`` vs ``install``/``uninstall`` operations
    names for Perl scripts in UBOS manifests

  * Allow to add non-UBOS repositories that are nevertheless used as if they were

* Major beauty surgery on the UBOS build process:

  * No more ``make`` involved

  * All settings are in a global ``settings.pl`` file, which can optionally be overwritten
    with a ``local.pl`` file.

  * Tasks can be shortcutted in settings files, e.g. ``macrobuild build-dev``

  * More predictable build sequence even for tasks specified as parallel

  * Added ``--print-vars`` argument to ``macrobuild`` for easier build debugging.

  * Now setting the "packager" field on packages

  * Now can build Java packages using maven as part of the process

* Documentation

  * More detailed description of network configurations

  * Refactored how to create a UBOS development machine

To upgrade
==========

If you have Java installed on your UBOS device, you must manually invoke

   > sudo archlinux-java set java-8-openjdk

Once we are out of beta, this kind of thing would be automated, of course, but for
the time being it wasn't important enough to automate.
