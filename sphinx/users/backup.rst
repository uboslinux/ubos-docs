Backup and restore
==================

UBOS backup files
-----------------

To make backup and restore easy, UBOS uses standard ZIP files, with certain additional
conventions. To distinguish them from arbitrary other ZIP files, UBOS backup files
typically use the extension ``.ubos-backup``.

With a single command, you can backup all the data of all the :term:`Apps <App>` installed on your device
to a single UBOS backup file. Or, you can use separate backup files for each :term:`Site` on your devices.
You can also back up just a single :term:`App` at a :term:`Site` to a backup file. Similarly, given
a ``.ubos-backup`` file, you can restore an entire :term:`Site` (same hostname, same
TLS credentials, same :term:`Apps <App>` with all of their data at the same context paths) or
or only parts. You can also change hostnames and context paths during restore.

UBOS keeps track inside the backup file what :term:`Apps <App>` you backed up, and how they were
configured at the time they were backed up. This makes UBOS backup files essentially
self-documenting, and makes it possible that backups can be interpreted even at some
considerable time in the future: all information required to restore an :term:`App` to the state
is was in at the time the backup was created is contained in the UBOS backup file.

The details of the UBOS backup format are
:doc:`documented for developers </developers/ubos-backup>`.

Creating a local backup
-----------------------

To create a local backup of all the data of all the :term:`Apps <App>` on the device
and save that data to file ``<backupfile>``, execute:

.. code-block:: none

   % sudo ubos-admin backup --out <backupfile>

For example:

.. code-block:: none

   % sudo ubos-admin backup --out ~/backup-$(date +%Y%m%d%H%M).ubos-backup

will create a backup file containing all installed :term:`Apps <App>` at all :term:`Sites <Site>` on the local host.
For your convenience, the expression with the ``$`` and the ``date`` will create
a filename that contains the current date.

To create a local backup of all the data of only the :term:`Apps <App>` and :term:`Accessories <Accessory>` installed at a
particular :term:`Site` with a :term:`SiteId` and save that data to file ``<backupfile>``, execute:

.. code-block:: none

   % sudo ubos-admin backup --siteid <siteid> --out <backupfile>

Alternatively, you can specify the hostname of the :term:`Site`:

.. code-block:: none

   % sudo ubos-admin backup --hostname <hostname> --out <backupfile>

To create a local backup of all the data of only a single installed :term:`App` and :term:`Accessories <Accessory>`
at a single :term:`Site` with a given :term:`AppConfigId` and save that data to file
``<backupfile>``, execute:

.. code-block:: none

   % sudo ubos-admin backup --appconfigid <appconfigid> --out <backupfile>

To determine the correct ``appconfigid``, use ``ubos-admin listsites``.

If your :term:`Site` uses TLS, and you do not want to store your TLS key material in the
backup, execute the backup command with the ``--notls`` option.

You can also create a backup as a side effect of a ``deploy``,
``undeploy`` or ``update`` operation: simply add ``--backup <backupfile>`` to
the command.

Creating a backup that is being saved to Amazon S3
--------------------------------------------------

Instead of create a backup file that is stored on your local disk, UBOS can
automatically upload it to your account at Amazon Web Services and store it
in its Simple Storage Service (S3).

First, install the ``amazons3`` package:

.. code-block:: none

   % sudo pacman -S amazons3

This makes the ``ubos-admin backup-to-amazon-s3`` command available.

This command is being invoked in the same manner as the ``ubos-admin backup``
command described above, but has additional options for specifying the
name of the S3 bucket to use, and the name of the file to create.

When you invoke this command for the first time, it will ask you for the
necessary credential information so it can store the backup on your account
at Amazon Web Services. This credential information will be stored on your
device, so you do not need to enter it every time you run a backup.

Specifically, you need to have the Amazon "Access Key ID" and the Amazon
"Secret Access Key" for an AWS user that is permitted to create and
write the S3 bucket that you specified. Creating this may involve the following
steps:

* Sign up for an Amazon Web Services (AWS) account.

* In AWS, create an suitable Identity and Access Management (IAM) user,
  e.g. ``mybackupuser``. This is a user that will only use "programmatic"
  access.

* Add the needed permissions to this user by creating a policy, such as:

  * ``HeadBucket``
  * ``ListBucket``
  * ``CreateBucket``
  * ``PutObject``.

* Create an "Access Key ID" and "Secret Access Key" for that user. Store both
  of them securely, as Amazon will not show you the Secret Access Key again.

If you have a GPG key pair with key id ``<keyid>``, you can
optionally specify ``--encryptid <keyid>``. This will encrypt the backup
first before uploading to S3.

Creating a backup to a remote location other than Amazon S3
-----------------------------------------------------------

To store your backups somewhere other than Amazon S3 or the local device:

#. Create a local backup as described above.
#. ``scp``, ``sftp``, ``ftp`` or otherwise transfer the backup file to where you
   would like it to end up.
#. Delete the local backup file.

Determining what a backup file contains
---------------------------------------

To determine the contents of a ``.ubos-backup`` file, execute:

.. code-block:: none

   % ubos-admin backupinfo --in <backupfile>

This will show information about the backup, such as when it was created,
as well as which :term:`Sites <Site>` and :term:`Apps <App>` were backed up.

Restoring from backup
---------------------

You can restore data either by specifying a local ``.ubos-backup`` file
(using the ``--in <backupfile>`` command-line options) or by specifying an
http or https URL from which the backup file will first be downloaded (using the
``--url <backupurl>`` command-line options). In this section, we will assume
your backup file is local but all commands should work equally with remote
files.

To restore an entire :term:`Site` (or several, if several have been backed up into
the same ``.ubos-backup`` file), execute:

.. code-block:: none

   % sudo ubos-admin restore --in <backupfile>

This command will refuse to work if restoring the backup would cause a
conflict with a :term:`Site` that is already installed. Possible conflicts include
the following:

* a currently deployed :term:`Site` runs at the same hostname as one to be restored;
* a currently deployed :term:`Site` has the same :term:`Site` identifier as one to be restored;
* a currently deployed :term:`App` has the same app config identifier as one to be restored;
* a currently deployed :term:`App` runs at the same context as one to be restored.

If you wish to restore a previous version of a currently deployed :term:`Site` from
backup, either back up and then undeploy the current :term:`Site` first, or restore
the :term:`Site` at a new hostname and with new identifiers, using the ``--createnew``
options described below.

To restore a :term:`Site` with a certain :term:`SiteId` from a backup file ``<backupfile>`` to the
current device, but leave all other :term:`Sites <Site>` unchanged, specify the :term:`SiteId`:

.. code-block:: none

   % sudo ubos-admin restore --siteid <siteid> --in <backupfile>

Alternatively, you can use the hostname of the :term:`Site` that was used at the time
of the backup:

.. code-block:: none

   % sudo ubos-admin restore --hostname <hostname> --in <backupfile>

To restore only one :term:`App`, instead of all :term:`Apps <App>` at a :term:`Site`, specify the :term:`AppConfigId`
and the hostname of the :term:`Site` to which the :term:`App` shall be added:

.. code-block:: none

   % sudo ubos-admin restore --appconfigid <appconfigid> --tohostname <tohostname> --in <backupfile>

Alternatively you can use the :term:`Site` id of the :term:`Site` to which the :term:`App` shall be added:

.. code-block:: none

   % sudo ubos-admin restore --appconfigid <appconfigid> --tositeid <tositeid> --in <backupfile>

To copy a :term:`Site` or:term:`AppConfiguration` and use new identifiers and a new hostname,
use one of the following:

.. code-block:: none

   % sudo ubos-admin restore --siteid <fromsiteid> --createnew --newhostname <newhostname> --in <backupfile>

Finally, to replace one or more :term:`Apps <App>` or :term:`Accessories <Accessory>` with something else during restore, use
the ``--migratefrom <package>`` and ``--migrateto <poackage>`` options, such as:

.. code-block:: none

   % sudo ubos-admin restore --migratefrom owncloud --migrateto nextcloud --in <backupfile>

To see the full set of options, invoke:

.. code-block:: none

   % ubos-admin restore --help
