``ubos-admin restore``
======================

See also :doc:`../../users/ubos-admin`.

This command::

   > ubos-admin restore <arguments>

supports a number of different use cases:

* Restore all sites and all apps contained in the backup to the same
  configuration as at the time of the backup. This includes hostnames,
  context paths, other customization, and even TLS keys and certificates
  (assuming the backup file contains all of those)

* Restore only some sites or apps contained in the backup.

* Restore sites or apps to different hostnames and/or context paths than
  they had been deployed to at the time the backup was created.

* Restore an app and its data, installed at one site, to a different site.

To see the supported options, invoke ``ubos-admin restore --help``.

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
  the apps and accessories. This supports the situation where the backup was created
  with an older version of an app than it currently installed on the device.

* The site is resumed, and the placeholder is removed.

This command internally uses a plug-in architecture, which allows the support of
alternate backup formats without changing the invocation by the user.

See also: :doc:`backup`.
