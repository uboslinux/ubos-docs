Backup and Restore
==================

UBOS backup files
-----------------

To make backup and restore easy, UBOS uses standard ZIP files, with certain additional
conventions. To distinguish them from arbitrary other ZIP files, UBOS backup files
typically use the extension ``.ubos-backup``.

You can backup all the data of all the apps installed on your device to a single
UBOS backup file. Or, you can use separate backup files for each site on your devices.
You can also back up just a single app at a site to a backup file, and backup all
other apps at the same site to a different backup file.

UBOS keeps track inside the backup file what apps you backed up, and how they were
configured at the time they were backed up. This makes UBOS backup files essentially
self-documenting, and makes it possible that backups can be interpreted even at some
considerable time in the future.

The details of the UBOS backup format are
:doc:`documented for developers </developers/ubos-backup>`.

Creating a local backup
-----------------------

To create a local backup of all the data of all the apps on the device
and save that data to file ``<backupfile>``, execute::

   > sudo ubos-admin backup --out <backupfile>

For example::

   > sudo ubos-admin backup --out ~/backup-$(date +%Y%m%d%H%M).ubos-backup

will create a backup file containing all installed apps at all sites on the local host.
For your convenience, this command will create a file whose filename contains the current date.

To create a local backup of all the data of only the apps and accessories installed at a
particular site with a :term:`siteid` and save that data to file ``<backupfile>``, execute::

   > sudo ubos-admin backup --siteid <siteid> --out <backupfile>

To create a local backup of all the data of only a single installed app and accessories
at a single site with a given :term:`appconfigid` and save that data to file
``<backupfile>``, execute::

   > sudo ubos-admin backup --appconfigid <appconfigid> --out <backupfile>


Restoring from backup
---------------------

To restore all data from a backup file ``<backupfile>`` to the current device::

   > sudo ubos-admin restore --in <backupfile>

This command will refuse to work if a site, or app configuration, with the same
identifier(s) is already deployed. If you wish to restore a previous version of
a currently deployed site from backup, undeploy the current site first.

To restore a site with a certain siteid from a backup file ``<backupfile>`` to the
current device, but leave all other sites unchanged, specify the :term:`siteid`::

   > sudo ubos-admin restore --siteid <siteid> --in <backupfile>

To restore only one app, instead of all apps at a site, specify the :term:`appconfigid`
and the hostname of the site to which the app shall be added::

   > ubos-admin restore --appconfigid <appconfigid> --tohostname <tohostname> --in <backupfile>

Alternatively you can use the site id of the site to which the app shall be added::

   > ubos-admin restore --appconfigid <appconfigid> --tositeid <tositeid> --in <backupfile>

Finally, to copy a site or app configuration and use new identifiers and a new hostname,
use one of the following::

   > ubos-admin restore --siteid <fromsiteid> --createnew --hostname <newhostname> --in <backupfile>

or::

   > ubos-admin restore --siteid <fromsiteid> --createnew --newsiteid <tositeid> --hostname <newhostname> --in <backupfile>

To see the full set of options, invoke::

   > ubos-admin restore --help
