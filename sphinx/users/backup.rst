Backup and restore
==================

UBOS backup files
-----------------

To make backup and restore easy, UBOS uses standard ZIP files, with certain additional
conventions. To distinguish them from arbitrary other ZIP files, UBOS backup files
typically use the extension ``.ubos-backup``.

With a single command, you can backup all the data of all the :term:`Apps <App>` installed
on your device to a single UBOS backup file. Or, you can use separate backup files for each
:term:`Site` on your devices. You can also back up just a single :term:`App` at a
:term:`Site` to a backup file.

Similarly, given a ``.ubos-backup`` file, you can restore an entire :term:`Site` (same
hostname, same TLS credentials, same :term:`Apps <App>` with all of their data at the same
context paths) or or only parts. You can also change hostnames and context paths during
restore.

UBOS keeps track inside the backup file what :term:`Apps <App>` you backed up, and how they
were configured at the time they were backed up. This makes UBOS backup files essentially
self-documenting, and makes it possible that backups can be interpreted even at some
considerable time in the future: all information required to restore an :term:`App` to the
state is was in at the time the backup was created is contained in the UBOS backup file.

The details of the UBOS backup format are
:doc:`documented for developers </developers/ubos-backup>`.

Creating a local backup
-----------------------

To create a local backup of all the data of all the :term:`Apps <App>` on the device
and save that data to file ``<backupfile>``, execute:

.. code-block:: none

   % sudo ubos-admin backup --tobackupfile <backupfile>

If you like UBOS to pick a suitable filename in your home directory that includes the
current date, use:

.. code-block:: none

   % sudo ubos-admin backup --tobackupdir ~

This will create a backup file containing all installed :term:`Apps <App>` at all
:term:`Sites <Site>` on the local host.

To create a local backup of all the data of only the :term:`Apps <App>` and
:term:`Accessories <Accessory>` installed at a particular :term:`Site` with a
:term:`SiteId` and save that data to file ``<backupfile>``, execute:

.. code-block:: none

   % sudo ubos-admin backup --siteid <siteid> --tobackupfile <backupfile>

Alternatively, you can specify the hostname of the :term:`Site`:

.. code-block:: none

   % sudo ubos-admin backup --hostname <hostname> --tobackupfile <backupfile>

To create a local backup of all the data of only a single installed :term:`App` and
:term:`Accessories <Accessory>` at a single :term:`Site` with a given :term:`AppConfigId`
and save that data to file ``<backupfile>``, execute:

.. code-block:: none

   % sudo ubos-admin backup --appconfigid <appconfigid> --tobackupfile <backupfile>

To determine the correct ``appconfigid``, use ``ubos-admin listsites``.

If your :term:`Site` uses TLS, and you do not want to store your TLS key material in the
backup, execute the backup command with the ``--notls`` option.

You can also create a backup as a side effect of a ``deploy``,
``undeploy`` or ``update`` operation: simply add ``--backup <backupfile>`` to
the command.

Creating a backup that is stored on a remote host
-------------------------------------------------

You can use backup destinations that contain a data transfer protocol as part of their
name. Here are some examples:

* ``file:/tmp/my.ubos-backup``: the local file ``/tmp/my.ubos-backup``. For convenience,
  you don't need the prefix ``file:``.
* ``https://example.com/my.ubos-backup``: use HTTPS to HTTP "POST" the backup file to
  this URL. (This requires you have to have suitable software running at ``example.com``
  that knows what to do with the arriving file!)
* ``s3://mybucket/my.ubos-backup``: the file ``my.ubos-backup`` in Amazon Web Services'
  Simple Storage Service (S3), bucket ``mybucket``. This requires the ``amazons3`` package
  to be installed.
* ``rsync+ssh://user@example.com/my.ubos-backup``: the file ``my.ubos-backup`` uploaded
  to host ``example.com`` as user ``user``, using the ``rsync`` protocol over ``ssh``.
  This requires the ``ubos-datatransfer-rsync`` package to be installed.

You can find all data transfer protocols available on your device by executing
``ubos-admin list-data-transfer-protocols``.

Each of those data transfer protocols may have its own options and particularities.
For example, if you use ``ftp``, you may or may not have to turn on "passive mode" (which
is a command-line option shown with ``ubos-admin list-data-transfer-protocols``). Some
may require usernames, passwords or other credentials. ``ubos-admin backup`` will either
complain that a necessary option was not provided, or interactively ask you for it. For
some data transfer protocols, like ``ftp`` for example, it may not be obvious what
options are needed for your particular situation; try out different ones until it works.

UBOS will, by default, remember the options and credentials you used for backing up
to remote locations. This makes it easier to run the same backup on a regular basis
-- something we'd like to encourage.

Example: creating a backup that is stored on Amazon S3
------------------------------------------------------

As an example, let's see how UBOS can automatically upload a backup file to your account
at Amazon Web Services and store it in its Simple Storage Service (S3).

First, install the ``amazons3`` package:

.. code-block:: none

   % sudo pacman -S amazons3

This makes the ``s3`` data transfer protocol available.

You need to have an existing "bucket" on S3 that you are permitted to write to. Let's
assume it is called ``mybucket``. Then, you could invoke the backup to S3 as follows:

.. code-block:: none

   % sudo ubos-admin backup --backuptodir s3://mybucket

or:

.. code-block:: none

   % sudo ubos-admin backup --backuptofile s3://mybucket/my.ubos-backup

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


Encrypting a backup
-------------------

To automatically encrypt a backup before delivering it to its final (local or remote)
location, specify ``--encryptid <id>`` as an argument to ``ubos-admin backup``. UBOS
will look in the GPG keychain of the ``shepherd`` user for a GPG public key with
identifier ``<id>``, and encrypt the backup file with it.

If you generate the GPG keypair off your UBOS :term:`Device`, importing the public
key into the ``shepherd``'s key ring can be as simple as executing:

.. code-block:: none

   % gpg --import

and copy-pasting the public key into the terminal, followed by a ``^D`` (for end of file).

Note: Please make sure you understand public and private keys before you do this.
Backups are useless if they are encrypted and you can't decrypt them when you need to!
In particular, if you make backups to be able to recover your data if your UBOS
device is lost, stolen, or destroyed, be sure you have the private key needed to decrypt
your backups in a safe place that won't be lost, stolen or destroyed at the same time!


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
