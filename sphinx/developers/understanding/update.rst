``ubos-admin update``
=====================

See also :doc:`../../users/ubos-admin`.

Invoking this command will:

#. Suspend all currently deployed sites and all apps and accessories on them, and
   replace them with a placeholder "Upgrade in progress" page.

#. Create a temporary backup of all data of all currently deployed apps and accessories
   on all sites on the device.

#. Undeploy all site, and all the apps and accessories on the device.

#. Upgrade the code on the device. There are two modes:

   * If one or more ``--pkgfile <pkgfile>`` arguments were given, only the specified
     package files will be installed. This uses ``pacman -U <pkgfile>``.

   * If no ``--pkgfile`` argument was given, UBOS will download and install all available
     upgraded packages on the the device. This includes operating-system packages, middleware
     packages and application packages. This step is equivalent to (and in fact uses)
     ``pacman -Syu``.

#. Apply a heuristic whether or not the device should be rebooted. For example, if the
   Linux kernel has been upgraded, a reboot is typically necessary. This heuristic can
   be overridden with command-line flags to ``ubos-admin update``. If the device is to
   be rebooted, it will be rebooted in this step. The remaining steps will be executed
   automatically after the reboot.

#. Restore all sites with all apps and accessories from the previously made backup,
   but with the most recent code version.

#. Run any necessary data migrations.

#. Replaces the placeholder pages with the applications again.

The individual steps are largely the same as documented in :doc:`backup`, :doc:`deploy`,
:doc:`restore`, and :doc:`undeploy`.

Note that UBOS never upgrades "in-place" but performs a new installation of the application
again, with subsequent restore-from-backup. This makes it less likely that "leftover" files
get in the way of smooth operation of the new version of the app.
