``ubos-admin restore``
======================

This command allows users to restore a previously made backup in the
:doc:`/developers/ubos-backup` format.

It is important that backups can be restored, even if:

* the site configuration has changed since the site was backed up. For example, the
  user might have added another app to the site, removed one, changed relative URLs
  of the app at the site, changed customization points, or even changed the host name
  of the site.

* the app version currently running on the device is more recent than the version of
  the app that was running at the time the backup was made. This is common.

* the data needs to be restored to a different site than the site that was backed up.

* only some of the data in a backup should be restored. For example, a backup might
  contain data of three apps, installed at two sites, but only the data of one of those
  apps should be restored.

To address these use cases, the command::

   > ubos-admin restore <arguments>

provides a number of different options. To see them, invoke ``ubos-admin restore --help``.

Generally, UBOS performs the following actions:

* It examines the meta-data contained in the backup file, to determine which apps
  and accessories are required to use the to-be-restored data.

* It installs those apps and accessories. Depending on the command-line options, this
  may involve creating an entirely new site, or modifying an existing site.

* While a new site is created or an existing site is modified, UBOS suspends the site
  and replaces it with a placeholder page.

* UBOS walks through the :doc:`/developers/ubos-manifest` of the involved apps and
  accessories, and restores each of the AppConfigurationItems whose retention
  fields have been set. (See also :doc:`backup`.)

* The actual restore performed depends on the type of AppConfigurationItem. For example,
  a MySQL database will be created and imported, while files and directories are simply
  copied into the right place.

* The app's and accessories' ``upgraders`` are run (see :doc:`/developers/manifest/roles`),
  so the imported data can be migrated to the structure needed by the current versions of
  the apps and accessories.

* The site is resumed, and the placeholder is removed.

See also: :doc:`backup`.
