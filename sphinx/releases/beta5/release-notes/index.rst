Beta 5 Release Notes
====================

New features and improvements
-----------------------------

* Containerization now supported:

  * UBOS can now run in Linux containers not just on x86_64, but also ARM v6 and ARM v7,
    i.e. on PCs and devices such as Raspberry Pi's and Beagle Bone Black's.

* Major networking improvements:

  * Firewall: by default, UBOS now runs a stateful firewall that denies all incoming traffic
    other than traffic specifically allowed. What traffic is allowed depends on the
    network configuration in effect.

  * Added netconfig ``gateway``: single-command configuration of a home gateway/router with
    private LAN, DHCP, local DNS, and a masquerading firewall. Allows app access from
    the LAN but not from the public internet.

  * Added netconfig ``standalone``: single-command configuration of a network controller with
    DHCP and local DNS for disconnected networks.

  * Due to internal refactoring, adding netconfigs is now cleanly possible.

  * Moved to ``systemd-networkd`` for all networking; removed ``dhcpcd``.

  * Now always runs ``systemd-timesyncd`` for system clock synchronization.

* Better tools for app developers:

  * No more hybrid Arch/UBOS installation required for UBOS development: instead, UBOS now
    provides a separate package repository containing UBOS tools for Arch that can be cleanly
    added to an Arch installation.

  * ``webapptest`` now knows how to run tests in a ``systemd-nspawn`` container; this makes
    tests much faster, and consistent between x86 and ARM platforms. This is now the default.

  * ``webapptest`` options can be specified in a separate JSON file. Command-line options
    override. It also automatically generates any Shepherd ssh keys it needs for tests.
    This makes ``webapptest`` much simpler to use.

  * ``ubos-repo``: protocol change for upload now using ``rsync``. Also, cleanly supports
    multiple instances of ``ubos-repo`` on same host.

  * added ``ubos-misc-tools``: ``git-360`` and ``git-commits-since`` report on status of
    several git repositories at once.

* Better Java support:

  * Upgraded to Java 8

  * diet4j Java package management available

  * Tomcat now always uses ``tomcat-native`` for improved performance

* Application upgrades:

  * Jenkins, with a new patch that turns off Jenkins mDNS advertisements

  * Known

  * Mediagoblin. Also fixed installation issue on Raspberry Pi 2.

  * Mediawiki

  * Wordpress and plugins

  * and others.

* Management infrastructure:

  * ``ubos-admin createsite`` now orders the questions about customization points in
    a way that can be specified by the developer with a new ``index`` field.

  * Consistently use ``deploy``/``undeploy`` vs ``install``/``uninstall`` operations
    names for Perl scripts in UBOS manifests.

  * Allow to add non-UBOS repositories that are consulted equally during the
    ``ubos-admin update`` process.

* Major beauty surgery on the UBOS build process:

  * No more ``make`` involved.

  * All settings are in a global ``settings.pl`` file, which can optionally be overwritten
    with a ``local.pl`` file.

  * Tasks can be shortcutted in settings files, e.g. ``macrobuild build-dev``.

  * More predictable build sequence even for tasks specified as parallel.

  * Added ``--print-vars`` argument to ``macrobuild`` for easier build debugging.

  * Now setting the ``packager`` field on packages.

  * Now can build Java packages using maven as part of the process.

* Documentation:

  * More detailed description of network configurations.

  * Updated to track all the other changes from beta 4.

* Removed ``jenkins`` from ARM. It takes too many resources to run it.

To upgrade
----------

All you need to do, as usual, is:

.. code-block:: none

   % sudo ubos-admin update

Your network configuration should not change. To use the new functionality, invoke:

.. code-block:: none

   % sudo ubos-admin setnetconfig <name>

where ``name`` is the name of the configuration you want, such as ``client``.

If you have Java installed on your UBOS device, you must manually invoke:

.. code-block:: none

   % sudo archlinux-java set java-8-openjdk

Once we are out of beta, this kind of thing would be automated, of course, but for
the time being this manual step is probably acceptable.

Known problems
--------------

* The BeagleBone Black boot process may not work correctly in all configurations.
  We are currently reconsidering support for this device, as there have been far
  fewer downloads than for other devices.

* The ``gateway`` network configuration adds a DNS rule to the wrong network interface.
  This prevents devices on the LAN from accessing the gateway's DNS server.

* ``ubos-install`` under some circumstances will fail due to missing a missing ``mkfs``
  command. Workaround: ``pacman -S dosfstools`` and try again.

* mDNS lookup is not automatically enabled. To enable, ``pacman -S nss-mdns``.


Questions? Need help?
---------------------

Select "Documentation" or "Community" from the top of the page.

`Last updated: 2015-12-07 08:33 PST`
