Beta 12 Release Notes
=====================

This release has been focused on:

* improving the way how UBOS is built and tested;

* making it possible to release app upgrades and OS upgrades independently of each other;

* making it easier for developers to package their applications for UBOS.

Compared to those changes, there is less new end-user visible functionality. Note that
application packages have not been upgraded in this release; however, as we are now able
to release apps independently of the OS, app upgrades will follow shortly.

Note that the naming scheme of the downloadable UBOS images has changed.

For users
---------

* New features:

  * The ESPRESSObin can now be used as a router with firewall, and is in fact pre-configured
    that way. It runs a firewall, IP address translation, a DHCP and a local DNS server.

  * The ESPRESSObin can now boot from disk without needing an SD card at all.

  * UBOS now uses its own HTTP error pages, such as for a 404 Not Found page. This makes
    UBOS look more consistent.

  * Databases can now be "pinned" to particular names. If, for whatever reason, it is
    important to you that your blog's database is always called ``blog``, you can do so now.
    More on `pinning resources </docs/users/pinning-resources.html>`_.

  * UBOS now contains the packages needed to use the official camera on the Raspberry PI.
    Here's a `description how to </docs/users/devices/raspberrypi.html>`_.

  * By popular demand, the ``shepherd`` user can now become root by executing ``sudo su``.
    (As always: be careful, it's easy to disrupt UBOS -- and anything else -- if you
    are root.)

* Hundreds of upgraded packages.

* Major bug fixes and improvements:

  * The UBOS device automatically reboots now during an update when it notices that there
    is a new kernel version. It will continue the second part of the update after the
    device is back up. Options on ``ubos-admin update`` allow an override over this
    behavior.

  * Nextcloud and Mediawiki can now restore from a larger variety of older backups.

  * The consistency between the documentation of the various ``ubos-admin`` subcommands
    and their actual implementation has been improved.

  * When being asked for values of customization points marked ``private`` in
    ``ubos-admin createsite``, the keyboard input is not echoed to the screen any more.

  * When running an app that is not a web app at a site that also runs other webapps,
    the crazy formatting on the overview web page was fixed.

* All images have been updated.

For developers
--------------

* There is now a Python version of the "Glad-I-Was-Here" guestbook example application. It
  joins its colleagues in PHP and Java. See the `Glad-I-Was-Here Python developer
  documentation </docs/developers/toyapps/gladiwashere-python-mysql.html>`_.

* The gladiwashere family of example applications has been refactored.
  The various apps now use consistent naming (``gladiwashere-php-mysql``,
  ``gladiwashere-python-mysql`` etc.) and they have moved into a separate ``toyapps``
  repository. Note that this repository is not active by default.

* An example blogging app using Ruby-on-Rails is now also available in the ``toyapps`` repo,
  illustrating how to make an existing Rails app manageable by UBOS.

* UBOS can now also manage TCP and UDP port allocations, similarly to how it manages
  databases. An app's UBOS manifest may state that the app would like to use a
  (non-standard) port, and UBOS will allocate one such port for each installation of
  the app. UBOS will make sure there are no port conflicts between different apps, or
  multiple installations of the same app on the same device. See the
  `roles section </docs/developers/manifest/roles.html>`_ in the
  developer documentation.

* Apps and accessories can now require that values for customization points match a
  regular expression, enabling developers to be more confident that user-entered values
  will actually make sense for a given customization point. See the
  `customization points section </docs/developers/manifest/customizationpoints.html>`_
  in the developer documentation.

* Accessories can now specify that they depend on another :term:`Accessory` being present at the
  same :term:`AppConfiguration`. Example: some Wordpress plugins can only function if some other
  plugin is installed and active at the same time. UBOS can now manage these dependencies
  automatically as well. See the
  `accessory info section </docs/developers/manifest/accessoryinfo.html>`_
  in the developer documentation.

* More information about the :term:`AppConfiguration` and the Site is now available to deploy and
  undeploy scripts. See the updated
  `list of variables </docs/developers/manifest/variables.html>`_.

* The new ``ubos-rsync-server`` package makes it easy for developers to support secure
  file upload and download via ``rsync`` over ``ssh``. It supports :term:`AppConfiguration`-specific
  SSH keys, which means that if a UBOS device runs two copies of the same app (e.g. at
  different virtual hostnames), these two copies of the app do not (need to) share the
  same SSH credentials, and one cannot be used to access data from the other.
  See `documentation </docs/developers/ubos-rsync-server.html>`_.

* Experimental packages have been moved to separate repositories ``os-experimental``,
  ``hl-experimental`` and so forth.

UBOS build and release process
------------------------------

* Using two newly built (early-stage, but functional) tools, called ``taligen`` ("Task List
  Generator") and ``taliwodo`` ("Task List Work Down"), we now create and manage task lists
  that track the activities necessary to build, test and release a new release. They are
  available in the ``hl-experimental`` repository.

* The UBOS build tool, ``macrobuild``, has had its guts rewritten.

* We systematically improved test coverage of various UBOS functionality prior to a release.

* The new ``wollmilchsau`` app and two accessories gives us much broader insight into
  correct (or incorrect!) UBOS application installation and update functions than was
  possible before.

Known issues
------------

* When upgrading from a previous version, you first must invoke:
  ``pacman -Sy && pacman -S archlinux-keyring`` (on ``x86_64``) and
  ``pacman -Sy && pacman -S archlinuxarm-keyring`` (on all ARM architectures). Also, if
  there is an error message that certain files "already exist" in the filesystem, manually
  remove those. Then you can invoke ``ubos-admin update``.

* Mattermost requires the user to invoke ``ubos-admin setnetconfig`` after install. This
  is because Mattermost opens up a non-standard port, and UBOS currently only reconfigures
  its firewall when ``ubos-admin setnetconfig`` is invoked.

* The original Raspberry Pi may time out when attempting to set up a Tor site, and
  not complete the setup.  We are currently considering to end-of-life this device.
  The other Raspberry Pi's will not be affected.

Dropped support
---------------

* Due to far fewer downloads for the BeagleBone Black compared to other devices, we have
  suspended support for this device.

Other than that, nothing should get in your way. If you encounter something that does,
file a bug `on GitHub <https://github.com/uboslinux/>`_.
