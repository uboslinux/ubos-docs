Beta 9 Release Notes
====================

For users
---------

* New apps and accessories:

  * Nextcloud 10 is now available. To install, specify ``nextcloud10`` as the name of the app
    when you invoke ``ubos-admin createsite``. To upgrade from Nextcloud 9, follow the
    instructions :doc:`here <../../../users/migrating-to-a-new-app>`.
  * The Wordpress themes "Pinboard", "P2" and "Responsive" join the "Google
    analytics" plugin. When installing ``wordpress``, specify one or more of
    ``wordpress-theme-pinboard``, ``wordpress-theme-p2``, ``wordpress-theme-responsive``, or
    ``wordpress-plugin-google-analytics-for-wordpress`` as the :term:`Accessory`.

* Upgraded apps:

  * Mattermost 3.4.0
  * Mediawiki 1.27.1
  * Nextcloud9 9.0.54
  * Shaarli 0.8.0
  * Webtrees 1.7.8
  * Wordpress 4.6.1

* New packages available:

  * ``smbclient`` for those users who like to mount their PC's or NAS's hard drive on UBOS.
  * ``crda`` for correct frequency selection when running WiFi.

* New features:

  * It's now easy to migrate from one app to another (assuming the apps support it). For
    example, to migrate from ownCloud to Nextcloud, all you need to do is to tell
    the UBOS restore command to use ``nextcloud9`` instead of ``owncloud``.

  * ``btrfs`` is now the default filesystem on all platforms for new UBOS installations.

  * To be extra safe, before and after UBOS upgrades, UBOS now takes snapshots of the
    file system with a tool called ``snapper``. Should something have failed during the
    upgrade, restoring the previous state of affairs is now simple. Note: filesystem
    snapshots are not a replacement for backups, as they do nothing against disk failure.

  * New command ``ubos-admin setup-shepherd`` makes it easy to set up a UBOS shepherd
    account even if no Staff is used, such as when running UBOS in a Linux container during
    development.

  * A site can now be automatically deployed from the UBOS Staff: if a UBOS device boots
    with the Staff present, and the Staff defines a suitable site template, the device
    will automatically deploy the site once booting has fininshed.

* Hundreds of upgraded packages.

* All images for all platforms have been updated.

* Major bug fixes:

  * Known: image upload now works.
  * Mattermost: password salts are now generated specific to each installation.
  * Boolean customizationpoints can now be entered when running ``ubos-admin createsite``.
  * ``ubos-admin createsite`` has become more tolerant when mistyping the name of apps
    and other input.
  * Backups containing TLS secrets can now be restored with and without restoring the
    TLS.
  * Sites using LetsEncrypt TLS now correctly back up and restore.

For developers
--------------

* Default values of customization points can now refer to parameters such as
  ``${site.hostname}``. This is particularly useful for instance-specific secrets
  such as password salts.

* UBOS images can now be created so that one or more sites and apps are automatically
  deployed upon first boot of the image. This makes the creation of UBOS-based
  appliances running specific apps much simpler.

Known issues
------------

* Mattermost requires the user invoke ``ubos-admin setnetconfig`` after install. This
  is because Mattermost opens up a non-standard port, and UBOS currently only reconfigures
  its firewall when ``ubos-admin setnetconfig`` is invoked.

* The BeagleBone Black boot process may not work correctly in all configurations.
  We are currently reconsidering support for this device, as there have been far
  fewer downloads for it than for other devices.

* On Amazon EC2, if you upgrade an existing virtual server to beta9, you may need to
  first execute the following commands to update package signing keys:

  .. code-block:: none

     % sudo pacman -Sy
     % sudo pacman -S archlinux-keyring ec2-keyring

Other than that, nothing should get in your way. If you encounter something that does,
file a bug `on GitHub <https://github.com/uboslinux/>`_.
