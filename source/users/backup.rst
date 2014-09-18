Backup and Restore
==================

UBOS backup files
-----------------

To make backup and restore easy, UBOS uses standard ZIP files, with certain additional
conventions. To distinguish them from
arbitrary other ZIP files, UBOS backup files typically use the extension ``.ubos-backup``.

You can backup all the data of all the apps installed on your device to a single
UBOS backup file. Or, you can use separate backup files for each site on your devices.
You can also back up just a single app at a site to a backup file, and backup all
other apps at the same site to a different backup file.

UBOS keeps track inside the backup file what apps
you backed up, and how they were configured. This makes UBOS backup
files essentially self-documenting, and makes it possible that backups can be interpreted
even at some considerable time in the future.

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
The filename will contain the current date.

To create a local backup of all the data of only the apps installed at a particular site
with a given :term:`siteid` and save that data to file ``<backupfile>``, execute::

   > sudo ubos-admin backup --siteid <siteid> --out <backupfile>

To create a local backup of all the data of only a single installed app at a single site
with a given :term:`appconfigid` and save that data to file ``<backupfile>``, execute::

   > sudo ubos-admin backup --appconfigid <appconfigid> --out <backupfile>


Restoring from backup
---------------------

To restore all data from a backup file ``<backupfile>`` to the current device::

   > sudo ubos-admin restore --in <backupfile>

.. warning::

   This command will mercilessly overwrite current data of currently installed apps
   on the local device. For example, if the backup
   contains a site with a certain siteid, and there is a site with the same siteid
   active on the device, the current site will be replaced by the site defined in and
   with the data contained in the backup file. The previous data at the site will be
   irretrievably lost.

To restore a site with a certain siteid from a backup file ``<backupfile>`` to the
current device, but leave all other sites unchanged, specify the :term:`siteid`::

   > sudo ubos-admin restore --siteid <siteid> --in <backupfile>

To restore only one app, instead of all apps at a site, specify the :term:`appconfigid`::

   > ubos-admin restore --appconfigid <appconfigid> --in <backupfile>

Finally, if you want to import the data from one site, or just one installed app to
a site with a different siteid or appconfigid from the one in the backup file, use the
``--translate`` option. For example::

   > sudo ubos-admin restore --siteid s1 --translate 's1=>s2' --in /tmp/backup.ubos-backup

This command will look for a site whose siteid starts with ``s1`` in the backup file
``/tmp/backup.ubos-backup``, and restore all data to a site currently installed on the
local device whose siteid starts with ``s2``. Note the arrow in the ``--translate``
argument: make sure you escape the ``>`` character in your shell.

This latter form of the restore command allows you to quickly restore data to a different
site, or -- when used with ``ubos-admin backup`` -- to quickly make copies of a
currently installed site.
