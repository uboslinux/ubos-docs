Beta 7 Release Notes
====================

This release contains an unusually large number of new features and
improvements.

For users
---------

* New platforms:

  * The new, quad-core Raspberry Pi 3 is now a supported UBOS platform.

  * Pre-built UBOS images are available for Amazon EC2.

* New apps:

  * Nextcloud 9.0.52: the "reboot" of ownCloud by the members of the ownCloud
    development team.

  * Mattermost 3.1.0: an open-source Slack clone for team communications

* App upgrades:

  * Known 0.9.2. It is now in package ``known``, instead of previous code name ``idno``.

  * Mediawiki 1.26.3

  * Selfoss 2.15

  * Changed to a better-maintained branch of Shaarli, version 0.7.0

  * Webtrees 1.7.5

  * Wordpress 4.5.2

* New features:

  * Easily and reliably send outgoing e-mail via Amazon Simple E-mail Service
    (SES). This makes it possible for devices behind a firewall or forced to use
    an uncooperative ISP to get email out.

    Simply install app ``amazonses`` as an additional app on the same site. This will
    route all e-mail originating at the hostname of the site to be routed via Amazon
    SES, and leave other e-mail routes untouched. That way, fine-grained control
    over which e-mail gets routed how is possible.

  * Automatic setup of SSL/TLS-secured sites using Letsencrypt. Simply specify
    an additional flag when creating a new site:

    .. code-block:: none

       % sudo ubos-admin createsite --tls --letsencrypt

  * A command for off-site backup to Amazon S3 in one step. Optionally the backup
    may be encrypted using GPG public-key cryptography. Example:

    .. code-block:: none

       % sudo ubos-admin backup-to-amazon-s3

  * Downloading a backup file, and restoring an entire site from backup can now
    be done in a single command:

    .. code-block:: none

       % sudo ubos-admin restore --url http://example.com/example.ubos-backup

  * SSH rate limiting is enabled by default to make the job of attackers just
    a bit more frustrating.

  * New command ``ubos-admin backupinfo`` enables users to easily determine what
    sites and apps a given UBOS backup file contains, and when it was made.

  * Single-command undeploy of all sites on a device:

    .. code-block:: none

       % sudo ubos-admin undeploy -a

    This is a dangerous command, but very useful during development.

  * Significant extension of the ``ubos-admin status`` command. It now also reports
    on disk usage, memory usage, uptime and the like.

  * ``ubos-admin`` now accepts a ``hostname`` instead of a ``siteid`` in almost
    all places where it is necessary to identify a particular site on the device.
    This makes the command somewhat easier to use in many circumstances.

  * We now always run ``haveged`` to provide more entropy faster. Nobody has
    the patience to wait for (sometimes) hours for even-better random numbers.

  * ``smartmontools`` are pre-installed on all devices. This allows users to check
    the health of their hard drives even if the device is unable to connect
    to the network or install new software.

  * ``ubos-install -l`` shows the list of available device types for installation.

* Deprecated for the time being:

  * Jenkins. Will reconsider if there is demand for it.

  * Mediagoblin. We will consider updating it again in UBOS once the Mediagoblin
    project matures further (see also issues
    `5 <https://github.com/uboslinux/ubos-mediagoblin/issues/5>`_ and
    `6 <https://github.com/uboslinux/ubos-mediagoblin/issues/6>`_).

* Fixes:

  * The device will now ask its own DNS name server (if it runs one) instead of
    the upstream name server. This fixes a bug where all devices on a LAN would
    get the correct DNS resolution from a UBOS device acting as the router,
    except applications installed on the UBOS router itself.

  * ``setnetconfig -f`` recreates a clean networking reconfiguration and discards
    user changes to the configuration files.

  * Setting no-copy-on-write (``nocow``) attributes is now performed on some
    directories that should have that (e.g. ``/var/lib/mysql``).

  * When an app that uses a database gets uninstalled, not only are the tables
    and the database dropped, but also the user that was created for that database
    and app.

  * PHP execution times on ARM devices have been extended before a timeout occurs.
    Sometimes those little Raspberry Pi's are just simply overwhelmed and need
    extra time.

  * Better error messages, more reliability, and bug fixes; the usual.

* New packages now available on UBOS:

  * ``nfs-utils`` for those users who like to mount NFS drives.

  * ``postfix`` for sending mail.

  * ``zerotier-one`` for virtual networking; so far, it's in the repository but
    requires manual activation.

  * ``snapper`` for making btrfs snapshots easier; it's in the repository but so
    far requires manual activation.

  * ``wireshark-cli``, so users can easily analyze their network traffic.

  * ``wpa_supplicant`` for common WiFi setups. It is pre-installed on ARM devices
    so Raspberry Pi's can install apps without ever having to be connected via
    Ethernet. The ``wpa_supplicant`` setup is still manual, however.

More than 1000 package upgrades mostly inherited from Arch Linux upstream.

For developers
--------------

* Important package upgrades:

  * UBOS has migrated to PHP7. All apps now use PHP7.

* New features:

  * ``ubos-push`` is a simple, but effective hot-deploy script for upgrading a small number
    of packages on a running device without having to go through a full upgrade
    cycle: just specify the hostname/IP address of the device, and the packages
    files to be uploaded and upgraded.

* New packages:

  * ``ruby`` and ``passenger`` are now in the repositories, to enable Ruby-based apps
    to run on UBOS

  * Several Java infrastructure packages, like MySQL driver and log4j
    appender for the system journal.

  * diet4j Java module management.

* Bug fixes:

  * Apps using a reverse proxy (e.g. apps bundling their own HTTP server, and
    Java/Tomcat apps) now won't interfere with ``robots.txt``, and well-known files
    like it, even if installed at the root of the site.

* Tool and build improvements:

  * Some build tasks renamed for consistency

  * Better build reporting

To upgrade
----------

All you need to do, as usual, is:

.. code-block:: none

   % sudo ubos-admin update

Known problems
--------------

* The BeagleBone Black boot process may not work correctly in all configurations.
  We are currently reconsidering support for this device, as there have been far
  fewer downloads for it than for other devices.

* On the Raspberry Pi, ``systemctl`` will report a system status of ``degraded``.
  That's because UBOS is attempting load a kernel module that cannot be found.
  The system is otherwise okay, however. To fix this cosmetic error, as root,
  edit ``/etc/modules-load.d/devicemodules.conf`` and remove the line that reads
  ``bcm2708-rng``. Then, execute ``systemctl restart systemd-modules-load``
  (`issue report <https://github.com/uboslinux/ubos-admin/issues>`_).

* Rasptimer currently fails; we missed the update to PHP7. It has been updated upstream,
  however. If you need it, clone its `Github repo <https://github.com/jernst/rasptimer>`_,
  ``makepkg`` and ``ubos-admin update --pkg rasptimer*.pkg*``.

Other than that, nothing should get in your way. If you encounter something that does,
file a bug `on GitHub <https://github.com/uboslinux/>`_.
