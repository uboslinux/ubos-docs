Backup format
=============

Idea
----

The UBOS Backup File Format defines how to store, in a single file, all data and meta-data
necessary to reconstruct the installation of one or more :term:`Apps <App>` at one or more
:term:`Sites <Site>`.
This supports use cases such as backup, restore, archival, checkpointing and many others.

This file format can be defined once in an application-independent manner, and thus can be
used by all :term:`Apps <App>`.

See also :doc:`/users/backup`.

Philosophy
----------

We use ZIP. We chose it over tar because ZIP has better random-access capabilities; tar
is intended to be read sequentially.

Each element of the ZIP file either holds :term:`Site` data or :term:`Site` meta-data. The :term:`Site` meta-data
captures the configuration of the :term:`Site` at the time of export, and other information about
the backup. The :term:`Site` data is the data maintained by the applications at the :term:`Site`, typically
held in databases or directory hierarchies.

Note that the individual items in the ZIP file generally do not directly map to files and
directories on a file system as explained below.

Files in this format generally use extension ``.ubos-backup``. Any of the entries in the
ZIP file may be deflated (aka compressed) according to standard ZIP conventions.

Meta-data
---------

``filetype``
   This file contains a fixed string to identify this ZIP file as
   a UBOS backup file in version 1.

   Fixed string: ``UBOS::Backup::ZipFileBackup;v1``

``starttime``
   This file contains the (starting) time at which this backup file was being created, in
   the UTC time zone in RFC 3339 format.

   Example: ``2014-12-31T23:59:01.234Z``

``sites/``
   This directory contains the :term:`Site JSON` files of all :term:`Sites <Site>` that have been backed up
   to this file.

   For example:

``sites/s1111111111222222222233333333334444444444.json``
   The Site JSON file for a :term:`Site` with :term:`SiteId` ``s111111111122222222223333333333334444444444``,
   indicating that this :term:`Site` has been backed up to this backup file. The name of the file must
   be the :term:`SiteId` of the :term:`Site`, plus the ``.json`` postfix. This file is only present for those
   :term:`Sites <Site>` that have been backed up as a whole.

   If additional :term:`Sites <Site>` have been backed up to this file, their site JSON files would also
   be found in this directory.

``installables/``
   This directory contains the :term:`UBOS manifest JSON` files of all installed :term:`Apps <App>`
   and :term:`Accessories <Accessory>` at the :term:`Site`, in the version that was running at the time the backup was
   created. This helps to reconcile version differences at the time of restore.

``installables/gladiwashere.json``
   The UBOS manifest file of the gladiwashere example application. The name of this file
   must be the installable's package name, plus the ``.json`` postfix.

In-ZIP hierarchical structure
-----------------------------

All other content of the ZIP file is structured by :term:`AppConfiguration`, installable, role
and retention bucket. This structure is similar to the structure of :term:`Site JSON`
files and :term:`UBOS Manifest JSON` files. This allows a backup file to contain the data
of several installations of the same application without conflicts (for example, two
Wordpress installations at different virtual hosts or relative path name).

``appconfigs/``
   Parent directory of all the backed-up data.

``appconfigs/a4444444444333333333322222222221111111111.json``
   The fragment of the Site JSON file that belongs to this :term:`AppConfiguration`. This fragment
   is present here regardless of whether the full Site JSON file is present in the meta-data
   section above.

``appconfigs/a4444444444333333333322222222221111111111/``
   This directory contains data which was backed up from the :term:`AppConfiguration` whose
   appconfigid has value ``a4444444444333333333322222222221111111111``. To determine which
   :term:`Site` this :term:`AppConfiguration` belonged to at the time of backup, consult the Site JSON files
   above. However, it may be that only the :term:`AppConfiguration` was backed up, not the entire
   :term:`Site`, so there may not be a Site JSON file that refers to this :term:`AppConfiguration`.

``appconfigs/a4444444444333333333322222222221111111111/gladiwashere/``
   This directory contains data which was backed up from the ``gladiwashere`` example
   application at this :term:`AppConfiguration`. The name of this directory is the package name
   of the application.

``appconfigs/a4444444444333333333322222222221111111111/gladiwashere/apache2/``
   This directory contains data which was backed up from role ``apache2`` of this
   application at this :term:`AppConfiguration`. Any role may have a section here.

``appconfigs/a4444444444333333333322222222221111111111/gladiwashere/apache2/uploads``
   The name of the retention bucket that was backed up. This is the same as specified in
   the UBOS :term:`UBOS Manifest JSON` file by the installable. ``gladiwashere`` doesn't
   actually define an ``uploads`` retention bucket, but if it did, the relevant part of
   the manifest JSON would look like this:

   .. code-block:: json

      {
          ...
          "retention"       : "backup",
          "retentionbucket" : "uploads"
      }

   Depending on the type of item that is being backed up, this may be a file or a directory.

Content storage
---------------

This section documents how content of various types is represented in a UBOS Backup File.
Additional types of content may be defined in the future.

File and directory content
^^^^^^^^^^^^^^^^^^^^^^^^^^

Assume that a directory
``/srv/http/sites/s1111111111222222222233333333334444444444/blog/uploads`` of some web
application needs to be backed up. Let's assume that this directory belongs to an application
that is installed at context path ``/blog`` of some :term:`Site`
(application package ``myapp``, :term:`SiteId` ``s1111111111222222222233333333334444444444``,
appconfigid ``a4444444444333333333322222222221111111111``).

Let's also assume this application has declared this directory as an :term:`AppConfiguration`
item for the ``apache2`` role like this in its UBOS Manifest JSON file:

.. code-block:: json

   {
       "type"            : "directory",
       "name"            : "uploads",
       "retention"       : "backup",
       "retentionbucket" : "uploadsdir"
       ...
   }

Then, the recursive directory tree starting with root directory
``/srv/http/sites/s1111111111222222222233333333334444444444/blog/uploads`` will be backed up to
``appconfigs/a4444444444333333333322222222221111111111/myapp/apache2/uploadsdir`` in the backup ZIP file.

Note that the filename in the ZIP file comes from the ``retentionbucket`` field in the
UBOS manifest, not from the name field or the name of the application. That way, the names
of files and directories can be easily changed from one version of the installable to
the next without impacting backups.

MySQL database content
^^^^^^^^^^^^^^^^^^^^^^

Assume that a UBOS Manifest JSON file declares a database as one of its :term:`AppConfiguration`
items in the ``mysql`` role (application package ``myapp``, :term:`SiteId`
``s1111111111222222222233333333334444444444``, appconfigid
``a4444444444333333333322222222221111111111``).
Assume also that it declares that it wishes the database to be backed up, like this:

.. code-block:: json

   {
       "type"            : "database",
       "name"            : "maindb",
       "retention"       : "backup",
       "retentionbucket" : "maindb.mysqldump",
       ...
   }

Then, upon backup, the content of the MySQL database will be exported by UBOS with the
``mysqldump`` tool to a file called ``maindb.mysqldump`` in directory
``appconfigs/a4444444444333333333322222222221111111111/myapp/mysql/`` in the backup
ZIP file.

Note that the filename in the ZIP file comes from the ``retentionbucket`` field in the
UBOS manifest, not from the name field or the name of the application.

Postgresql database content
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Assume that a UBOS Manifest JSON file declares a database as one of its :term:`AppConfiguration`
items in the ``postgresql`` role (application package ``myapp``, :term:`SiteId`
``s1111111111222222222233333333334444444444``, appconfigid
``a4444444444333333333322222222221111111111``).
Assume also that it declares that it wishes the database to be backed up, like this:

.. code-block:: json

   {
       "type"            : "database",
       "name"            : "maindb",
       "retention"       : "backup",
       "retentionbucket" : "maindb.dump",
       ...
   }

Then, upon backup, the content of the Postgresql database will be exported by UBOS with the
``pg_dump`` tool to a file called ``maindb.dump`` in directory
``appconfigs/a4444444444333333333322222222221111111111/myapp/postgresql/`` in the backup
ZIP file.

Note that the filename in the ZIP file comes from the ``retentionbucket`` field in the
UBOS manifest, not from the name field or the name of the application.
