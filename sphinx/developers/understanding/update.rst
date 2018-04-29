``ubos-admin update``
=====================

See also :doc:`../../users/ubos-admin`.

Invoking this command will:

#. Suspend all currently deployed :term:`Sites <Site>` and all :term:`Apps <App>` and :term:`Accessories <Accessory>` on them, and
   replace them with a placeholder "Upgrade in progress" page.

#. Create a temporary backup of all data of all currently deployed :term:`Apps <App>` and :term:`Accessories <Accessory>`
   on all :term:`Sites <Site>` on the device.

#. Undeploy all :term:`Sites <Site>`, and all the :term:`Apps <App>` and :term:`Accessories <Accessory>` on the device.

#. If a backup was requested, the backup will be created.

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
   automatically after the reboot. This is performed by writing a file with after-boot
   commands that will be executed as soon as the rebooting process is complete.

#. Restore all :term:`Sites <Site>` with all :term:`Apps <App>` and :term:`Accessories <Accessory>` from the previously made backup,
   but with the most recent code version.

#. Run any necessary data migrations.

#. Replaces the placeholder pages with the applications again.

The individual steps are largely the same as documented in :doc:`backup`, :doc:`deploy`,
:doc:`restore`, and :doc:`undeploy`.

Note that UBOS never upgrades "in-place" but performs a new installation of the application
again, with subsequent restore-from-backup. This makes it less likely that "leftover" files
get in the way of smooth operation of the new version of the :term:`App`.

This command must be run as root (``sudo ubos-admin update``).
