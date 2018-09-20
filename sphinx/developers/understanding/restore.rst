``ubos-admin restore``
======================

See also :doc:`../../users/ubos-admin`.

This command:

.. code-block:: none

   % sudo ubos-admin restore <arguments>

supports a number of different use cases:

* Restore all :term:`Sites <Site>` and all :term:`Apps <App>` contained in the backup to
  the same configuration as at the time of the backup. This includes hostnames, context
  paths, other customization, and even TLS keys and certificates (assuming the backup file
  contains all of those)

* Restore only some :term:`Sites <Site>` or :term:`Apps <App>` contained in the backup.

* Restore :term:`Sites <Site>` or :term:`Apps <App>` to different hostnames and/or context
  paths than they had been deployed to at the time the backup was created.

* Restore an :term:`App` and its data, installed at one :term:`Site`, to a different
  :term:`Site`.

To see the supported options, invoke ``ubos-admin restore --help``.

Generally, UBOS performs the following actions:

* It examines the meta-data contained in the backup file, to determine which :term:`Apps <App>`
  and :term:`Accessories <Accessory>` are required to use the to-be-restored data.

* It installs those :term:`Apps <App>` and :term:`Accessories <Accessory>`. Depending on
  the command-line options, this may involve creating an entirely new :term:`Site`, or
  modifying an existing :term:`Site`.

* While a new :term:`Site` is created or an existing :term:`Site` is modified, UBOS suspends
  the :term:`Site` and replaces it with a placeholder page.

* UBOS walks through the :doc:`/developers/ubos-manifest` of the involved :term:`Apps <App>`
  and :term:`Accessories <Accessory>`, and restores each of the
  :term:`AppConfigItems <AppConfigItem>` whose retention fields have been set. (See also
  :doc:`backup`.)

* The actual restore performed depends on the type of :term:`AppConfigItem`. For example,
  a MySQL database will be created and imported, while files and directories are simply
  copied into the right place.

* The :term:`App`'s and :term:`Accessories <Accessory>`' ``upgraders`` are run (see
  :doc:`/developers/manifest/roles`), so the imported data can be migrated to the structure
  needed by the current versions of the :term:`Apps <App>` and :term:`Accessories <Accessory>`.
  This supports the situation where the backup was created with an older version of an
  :term:`App` than it currently installed on the device.

* The :term:`Site` is resumed, and the placeholder is removed.

This command internally uses a plug-in architecture, which allows the support of
alternate backup formats without changing the invocation by the user.

Restoring to different versions of the App or Accessory
-------------------------------------------------------

When a backup is restored, it is possible (likely?) that the version of the :term:`App` or
:term:`Accessory` currently available is different (newer) than the version of the
:term:`App` or :term:`Accessory` that ran at the time the backup was created; after all,
likely some time has passed between when a backup was created and when it needs to be
restored.

UBOS itself does not (and in fact cannot) migrate data from old versions of
:term:`Apps <App>` or :term:`Accessories <Accessory>` to new ones. This is the
responsibility of the :term:`App` or :term:`Accessory` developer. This is what the
``upgraders`` field in the :doc:`/developers/ubos-manifest` is for: run code that will
upgrade the data.

Particular care needs to be take when an :term:`App` or :term:`Accessory` changes the
numbers or names of its retention buckets. UBOS matches the content of a bucket by name,
and does NOT restore the content of buckets whose name is not specified in the
:term:`UBOS Manifest` any more. Conversely, the :term:`App` or :term:`Accessory`, when
adding an additional bucket from one version to
another, the :term:`App` or :term:`Accessory` must be tolerant of the situation that during
upgrades or restores, that bucket will be empty as UBOS cannot restore any data into it.

A good strategy for a developer is to never rename retention buckets.

This command must be run as root (``sudo ubos-admin restore``).

See also: :doc:`backup`, :doc:`backupinfo`.
