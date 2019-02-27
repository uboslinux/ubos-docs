Beta 17 Release Notes
=====================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file:

* ``sudo ubos-admin backup --out ~/XXX.ubos-backup``

Then, update your device:

* ``sudo ubos-admin update -v``

What's new
----------

* A new design for backups has been implemented. This means that the command syntax
  for backups has changed slightly. It also means backups have become much more
  flexible, powerful and open to new protocols. In more detail:

  * The command ``ubos-admin backup`` now either takes the argument ``--backuptofile <file>``
    or ``--backuptodir <dir>``. If a file is specified, the backup will be written
    to the file with that name. If a directory is specified, UBOS generates a
    filename for the backup, and saves the backup with that file name in the specified
    directory.

  * ``<file>`` and ``<directory>`` can be specified as local files and directories,
    but they can also have a URL-style protocol in front. So for example,
    ``scp://user@example.com/mybackup.ubos-backup`` will upload the backup to file
    ``mybackup.ubos-backup`` on host ``example.com``, written using ``scp`` as user
    ``user``.

  * To see which URL-style protocols are available on your device, run (new) command
    ``ubos-admin list-data-transfer-protocols``. The following protocols have been
    implemented so far: ``file`` (local files), ``ftp`` (traditional ftp), ``http``
    (upload by HTTP POST or PUT), ``https`` (upload by HTTPS POST or PUT), ``scp``
    (secure remote file copy), and ``sftp`` (secure ftp).

  * In addition, if you installed optional package ``ubos-datatransfer-rsync``, you
    will also get ``rsync+ssh`` (rsync over ssh transport). If you install optional
    package ``amazons3``, you will also get ``s3`` (upload to Amazon Web Services
    S3).

  * The command ``ubos-admin backup-to-amazon-s3`` has been removed, as the
    functionality is now handled by the normal ``ubos-admin backup`` with an
    ``s3:`` protocol.

  * If credentials are required for uploading a backup, UBOS will ask you for those
    credentials on the first time you run backup with a particular protocol to a
    particular destination.
    When you run the backup the second time, by default, UBOS will reuse the
    credentials you provided earlier. The same applies to many protocol-specific
    options, such as the "passive" option for ``ftp``. These options are stored by
    destination, so if you regularly back up to two different destinations but with
    the same protocol (e.g. two different S3 buckets, or two ftp sites), UBOS
    will use the flags for that specific destination. This makes regular backups
    much simpler because you don't have to remember the options that are needed for
    upload, or the specific credentials.

  * Regardless of destination or protocol, backups can now be encrypted simply
    by specifying the GPG encryption key to use with ``--encryptid <id>``.
    By default, the GPG key chain of the ``shepherd`` user is used, but you can
    specify an alternate GPG home directory.

  * As you probably guessed from the above, under the hood, UBOS now implements
    a plugin architecture for "data transfer protocols" and knows how to
    perform backup over any such provided plugin. This makes it easy for us
    (and for you!) to plug-in additional data transfer protocols.

* The command-line arguments for ``ubos-admin backupinfo`` and ``ubos-admin listsites``
  have been made consistent.

* ``ubos-admin createsite`` now requires that the administrator e-mail address
  uses a fully-qualified domain name (well, it needs to have at least one dot).
  This seemed to be the easiest solution to the problem that some apps (like
  Nextcloud) do not accept user e-mail addresses that refer to local hostnames
  without domain names.

* ``ubos-admin createsite`` now requires administrator passwords that are at
  least 8 characters long.

* During ``ubos-admin update``, UBOS will now temporarily store exported database
  content in compressed form. This reduces the need for extra disk space during
  upgrades. Also, the restore algorithm was improved for higher speed in case
  of large databases.

* During system upgrades with ``ubos-admin update``, it is unavailable that sites
  are temporarily unavailable. However, the duration during which they are
  unavailable has been reduced.

* If you have a separate ``/ubos`` partition and it is formatted with ``btrfs``,
  ``ubos-admin update`` will now also automatically snapshot that partition.

* ``ubos-admin status`` output is now more readable.

* There were a set of intermittent issues related to
  :doc:`Letsencrypt certificates </users/create-ssl-site>`,
  either with or without running :doc:`Pagekite </users/howto-pagekite>`.
  The provisioning of Letsencrypt certificates has been rewritten. Among
  other changes, UBOS now keeps valid Letsencrypt certificates around, even if
  a site at the corresponding hostname has been undeployed. This avoids running
  into throttling problems with Letsencrypt during certain system administration
  tasks.

* Various other bug fixes and extensions. For the gory details, go to
  `uboslinux on Github <https://github.com/uboslinux>`_ and query for issues
  that have assigned milestone ``beta17``.

* Various package upgrades.

Release channel and documentation update-
----------------------------------------

* Going forward, the ``green`` release channel will be updated only some time
  after software updates have been published to the ``yellow`` release channel.
  This will allow for additional testing of the update in the field on those
  devices that run "production"-style sites on ``yellow``.

* To support this, the UBOS website now hosts documentation for the ``yellow``
  and the ``green`` release channels separately at
  `ubos.net/docs <https://ubos.net/docs/>`_.

Removed functionality
---------------------

* Nextcloud has been removed from the ``armv6h`` architecture. The Raspberry Pi
  Zero and One are simply not powerful enough to run Nextcloud, so there is no
  point.

Known issues
------------

* Currently none.
