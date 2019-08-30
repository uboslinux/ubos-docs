Release Notes: Update 2019-04-03 (green channel)
================================================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file, with a
command such as:

* ``sudo ubos-admin backup --out ~/XXX.ubos-backup``

If you have any of the following packages installed, remove them:

* ``sudo pacman -R smespath botocore amazons3``

Then, update your device:

* ``sudo ubos-admin update -v``

.. warning:: Before upgrading on Amazon EC2, you need to update your instance's
   kernel command line, otherwise the instance will fail to connect to the network
   upon reboot. Details see below.

What's new
----------

New functionality:
^^^^^^^^^^^^^^^^^^

* ``ubos-admin`` is now in color! (On terminals that support it.) That makes entering
  the correct information in commands such as ``ubos-admin createsite`` visually much
  simpler. It also makes it easier to distinguish between informational messages and
  errors emitted by ``ubos-admin``.

* A new design for backups has been implemented. This means that the command syntax
  for backups has changed slightly. It also means backups have become much more
  flexible, powerful and open to new protocols. In more detail:

  * The command ``ubos-admin backup`` now either takes the argument ``--backuptofile <file>``
    or ``--backuptodir <dir>``. The argument ``--out <file>`` has been removed.
    If a file is specified, the backup will be written to the file with that name. If a
    directory is specified, UBOS generates a filename for the backup, and saves the backup
    with that file name in the specified directory.

  * ``<file>`` and ``<directory>`` can be specified as local files and directories,
    but they can also have a URL-style protocol in front. For example, using
    ``--backuptofile`` with ``scp://user@example.com/mybackup.ubos-backup`` will cause
    UBOS to upload the backup to file ``mybackup.ubos-backup`` on host ``example.com``,
    transferred using the ``scp`` protocol as remote user ``user``.

  * To see which URL-style protocols are available on your device, run the (new) command
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

* During system upgrades with ``ubos-admin update``, it is unavoidable that sites
  are temporarily unavailable. However, the duration during which they are
  unavailable has been reduced.

* If you have a separate ``/ubos`` partition and it is formatted with ``btrfs``,
  ``ubos-admin update`` will now also automatically snapshot that partition.

* ``ubos-admin status`` output is now more readable.

* There were a set of intermittent issues related to
  :doc:`LetsEncrypt certificates </users/create-ssl-site>`,
  either with or without running :doc:`Pagekite </users/howto-pagekite>`.
  The provisioning of LetsEncrypt certificates has been rewritten. Among
  other changes, UBOS now keeps valid LetsEncrypt certificates around, even if
  a site at the corresponding hostname has been undeployed. This avoids running
  into throttling problems with LetsEncrypt during certain system administration
  tasks.

Notable new packages:
^^^^^^^^^^^^^^^^^^^^^

New apps:

* `Matomo <https://matomo.org/>`_, an analytics application (formerly named Piwik)
* `Decko <https://decko.org/>`_, an innovative Wiki platform (formerly named Wagn)

New accessories for Nextcloud:

* ``nextcloud-bruteforcesettings``: protect Nextcloud servers from attempts to guess user
  passwords in various ways
* ``nextcloud-deck``: kanban style organization tool aimed at personal planning and project
  organization for teams integrated with Nextcloud
* ``nextcloud-files-rightclick``: allows users and developers to have a right click menu
* ``nextcloud-group-everyone``: adds a virtual "Everyone" group.
* ``nextcloud-groupfolders``: admin configured folders shared by everyone in a group
* ``nextcloud-passwords``: allows you to store your passwords safely with Nextcloud
* ``nextcloud-socialsharing-email``: enable direct sharing of files via email, using shared links
* ``nextcloud-socialsharing-facebook``: enable direct sharing of files via Facebook, using shared links
* ``nextcloud-socialsharing-twitter``: enable direct sharing of files via Twitter, using shared links.

New accessories for Wordpress:

* Pterotype and SEO

Other packages;

* The GNU debugger: gdb
* The PHP debugger: xdebug
* The Node version manager: nvm
* IPFS: go-ipfs

Notable package upgrades:
^^^^^^^^^^^^^^^^^^^^^^^^^

* Docroot
* Mediawiki and accessories
* Nextcloud and accessories
* Wordpress and accessories

There were approx 400 new or upgraded packages in total.

Fixes and improvements:
^^^^^^^^^^^^^^^^^^^^^^^

* Various backup/restore issues were fixed. These had impacted primarily sites running
  Shaarli and Selfoss.
* Nextcloud installations now set the admin e-mail address automatically
* Nextcloud now shows memory info
* DNSSEC is turned off by default for new installations, as it appears to be incompatible
  with many deployed DNS servers that don't support it.
* Resolves a character-set issue sporadically producing errors in the Nextcloud user
  interface.

Changes for developers:
^^^^^^^^^^^^^^^^^^^^^^^

* Apps based on Node now need to package their own node runtime. More info is in
  the `documentation </docs-yellow/developers/middleware-notes/nodejs.html>`_.

Removed functionality
---------------------

* Nextcloud has been removed from the ``armv6h`` architecture. The Raspberry Pi
  Zero and One are simply not powerful enough to run Nextcloud, so there is no
  point.

Known issues
------------

* ``ubos-admin status`` emits some (harmless) errors under some circumstances.

* If upgrading, if some packages are installed, they need to be uninstalled first:
  ``sudo pacman -R smespath botocore amazons3``

* Running Pagekite with ``ubos-admin start-pagekite`` on a device that runs a wildcard
  site (ie a site whose hostname was specified as ``*``) may not forward the traffic
  correctly. Redeploy the site with its public hostname instead.

* On Amazon EC2, the kernel command-line needs to be updated **prior** to an upgrade.
  Here are the steps:

  #. As root, edit file ``/etc/default/grub``. Look for the line (towards the beginning
     of the file) that starts with ``GRUB_CMDLINE_LINUX_DEFAULT``. Change the line
     to read:

     .. code-block:: none

        GRUB_CMDLINE_LINUX_DEFAULT="nomodeset console=ttyS0,9600n8 earlyprintk=serial,ttyS0,9600,verbose loglevel=7 init=/usr/lib/systemd/systemd"

     Save the file.

  #. As root, execute: ``grub-install --recheck /dev/xvda``

  #. As root, execute: ``grub-mkconfig -o /boot/grub/grub.cfg``

  #. Now perform the update with: ``sudo ubos-admin update``

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
