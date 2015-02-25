Upgrading and keeping your device current
=========================================

UBOS makes this really simple::

   > sudo ubos-admin update

This single command will perform all necessary steps. This includes:

#. Checking whether software upgrades are available.
#. Displaying an "upgrade in progress" message to users who attempt to access your
   device over the web during the upgrade.
#. Temporarily backing up the data of all installed apps.
#. Uninstalling all installed apps.
#. Downloading and installing upgraded packages.
#. Installing the new versions of the same apps with otherwise the same configuration.
#. Restoring all data from the previously-made backup.
#. Performing whatever data migration is necessary to use the data with the new versions
   of the apps.
#. Removing the "upgrade in progress" message.

How long an update takes depends on many factors, including the number and size of the
updated packages, the amount of data that needs to be backed up, restored, and migrated,
the number of installed apps, as well as processor, hard drive and network speed.
