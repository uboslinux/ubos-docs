``ubos-admin update``
=====================

With this single command, users can update and upgrade all aspects of their device.
Invoke as follows::

   > ubos-admin update

This will:

* Suspend all currently deployed sites and all apps and accessories on them, and
  replace them with a placeholder "Upgrade in progress" page.

* Create a temporary backup of all data of all currently deployed apps and accessories
  on all sites on the device.

* Undeploy all site, and all the apps and accessories on the,

* Download and install all upgraded packages one device. This includes operating-system
  packages, middleware packages and application packages. This step is equivalent (and
  in fact uses ``pacman -Syu``)

* Restore all sites with all apps and accessories from the previously made backup,
  but with the most recent code version.

* Run any necessary data migrations.

* Replaces the placeholder pages with the applications again.

UBOS never upgrades "in-place" but performs a new installation of the application again,
with subsequent restore-from-backup. This makes it less likely that "leftover" files
get in the way of smooth operation of the new version of the app.
