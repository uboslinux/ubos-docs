Backup and Restore
==================

UBOS backup files
-----------------

To make backup and restore easy, UBOS uses standard ZIP files, with certain additional
conventions. To distinguish them from arbitrary other ZIP files, UBOS backup files
typically use the extension ``.ubos-backup``.

With a single command, you can backup all the data of all the apps installed on your device
to a single UBOS backup file. Or, you can use separate backup files for each site on your devices.
You can also back up just a single app at a site to a backup file. Similarly, given
a ``.ubos-backup`` file, you can restore an entire site (same hostname, same
TLS credentials, same apps with all of their data at the same context paths) or
or only parts. You can also change hostnames and context paths during restore.

UBOS keeps track inside the backup file what apps you backed up, and how they were
configured at the time they were backed up. This makes UBOS backup files essentially
self-documenting, and makes it possible that backups can be interpreted even at some
considerable time in the future: all information required to restore an app to the state
is was in at the time the backup was created is contained in the UBOS backup file.

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
For your convenience, the expression with the ``$`` and the ``date`` will create
a filename that contains the current date.

To create a local backup of all the data of only the apps and accessories installed at a
particular site with a :term:`siteid` and save that data to file ``<backupfile>``, execute::

   > sudo ubos-admin backup --siteid <siteid> --out <backupfile>

Alternatively, you can specify the hostname of the site::

   > sudo ubos-admin backup --hostname <hostname> --out <backupfile>

To create a local backup of all the data of only a single installed app and accessories
at a single site with a given :term:`appconfigid` and save that data to file
``<backupfile>``, execute::

   > sudo ubos-admin backup --appconfigid <appconfigid> --out <backupfile>

To determine the correct ``appconfigid``, use ``ubos-admin listsites``.

If your site uses TLS, and you do not want to store your TLS key material in the
backup, execute the backup command with the ``--notls`` option.

Determining what a backup file contains
---------------------------------------

To determine the contents of a ``.ubos-backup`` file, execute::

   > ubos-admin backupinfo --in <backupfile>

This will show information about the backup, such as when it was created,
as well as which sites and apps were backed up.

Restoring from backup
---------------------

You can restore data either by specifying a local ``.ubos-backup`` file
(using the ``--in <backupfile>`` command-line options) or by specifying an
http URL from which the backupfile will first be downloaded (using the
``--url <backupurl>`` command-line options). In this section, we will assume
your backup file is local but all commands should work equally with remote
files.

To restore an entire site (or several, if several have been backed up into
the same ``.ubos-backup`` file), execute::

   > sudo ubos-admin restore --in <backupfile>

This command will refuse to work if restoring the backup would cause a
conflict with a site that is already installed. Possible conflicts include
the following:
* a currently deployed site runs at the same hostname as one to be restored
* a currently deployed site has the same site identifier as one to be restored
* a currently deployed app has the same app config identifier as one to be restored
* a currently deployed app runs at the same context as one to be restored

If you wish to restore a previous version of a currently deployed site from
backup, either back up and then undeploy the current site first, or restore
the site at a new hostname and with new identifiers, using the ``--createnew``
options described below.

To restore a site with a certain siteid from a backup file ``<backupfile>`` to the
current device, but leave all other sites unchanged, specify the :term:`siteid`::

   > sudo ubos-admin restore --siteid <siteid> --in <backupfile>

Alternatively, you can use the hostname of the site that was used at the time
of the backup:

   > sudo ubos-admin restore --hostname <hostname> --in <backupfile>

To restore only one app, instead of all apps at a site, specify the :term:`appconfigid`
and the hostname of the site to which the app shall be added::

   > ubos-admin restore --appconfigid <appconfigid> --tohostname <tohostname> --in <backupfile>

Alternatively you can use the site id of the site to which the app shall be added::

   > ubos-admin restore --appconfigid <appconfigid> --tositeid <tositeid> --in <backupfile>

Finally, to copy a site or app configuration and use new identifiers and a new hostname,
use one of the following::

   > ubos-admin restore --siteid <fromsiteid> --createnew --newhostname <newhostname> --in <backupfile>

To see the full set of options, invoke::

   > ubos-admin restore --help
