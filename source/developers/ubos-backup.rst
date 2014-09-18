Backup format
=============

Idea
----

The UBOS Backup File Format defines how to store all data and meta-data necessary to
reconstruct the installation of one or more apps at one or more sites, in a single file.
This supports use cases such as backup, restore, archival, checkpointing and many others.

This file format can be defined once, and used by all apps.

See also :doc:`/users/backup`.

Philosophy
----------

We use ZIP. We chose it over tar because ZIP has better random-access capabilities; tar
is intended to be read sequentially.

Each element of the ZIP file either holds site data or site meta-data. The site meta-data
captures the configuration of the site at the time of export, and other information about
the backup. The site data is the data maintained by the applications at the site, typically
held in databases or directory hierarchies.

Note that the individual items in the ZIP file generally do not directly map to files and
directories on a file system as explained below.

Files in this format generally use extension ``.ubos-backup``. Any of the entries in the
ZIP file may be deflated (aka compressed) according to standard ZIP conventions.

Meta-data
---------

``ubos-filetype``
   This file contains the fixed string ``backup`` to identify this file as a backup file.

``starttime``
   This file contains the (starting) time at which this backup file was being created, in
   the UTC time zone in RFC 3339 format, e.g. ``2014-12-31T23:59:01.234Z``.

``sites/``
   This directory contains the :term:`Site JSON` files of all sites that have been backed up
   to this file.

``sites/s1122.json``
   The Site JSON file for a site with siteid ``s1122``, indicating that this site has been
   backed up to this backup file. The name of the file must be the siteid of the site, plus
   the ``.json`` postfix. This file is only present for those sites that have been backed
   up as a whole.

   If additional sites have been backed up to this file, their site JSON files would also
   be found in this directory.

``installables/``
   This directory contains the :term:`UBOS manifest JSON` files of all installed applications
   and accessories at the site, in the version that was running at the time the backup was
   created. This helps to reconcile version differences at the time of restore.

``installables/gladiwashere.json``
   The UBOS manifest file of the gladiwashere example application. The name of this file
   must be the installable's package name, plus the ``.json`` postfix.

In-ZIP hierarchical structure
-----------------------------

All other content of the ZIP file is structured by AppConfiguration, installable, role
and retention bucket. This structure is similar to the structure of :term:`Site JSON`
files and :term:`UBOS Manifest JSON` files. This allows a backup file to contain the data
of several installations of the same application without conflicts (for example, two
Wordpress installations at different virtual hosts or relative path name).

``appconfigs/``
   Parent directory of all the backed-up data.

``appconfigs/a2233.json``
   The fragment of the Site JSON file that belongs to this AppConfiguration. This fragment
   is present here regardless of whether the full Site JSON file is present in the meta-data
   section above.

``appconfigs/a2233/``
   This directory contains data which was backed up from the AppConfiguration whose
   appconfigid has value ``a2233``. To determine which site this AppConfiguration belonged
   to at the time of backup, consult the Site JSON files above.

``appconfigs/a2233/gladiwashere/``
   This directory contains data which was backed up from the ``gladiwashere`` example
   application at this AppConfiguration. The name of this directory is the package name
   of the application.

``appconfigs/a2233/gladiwashere/apache2/``
   This directory contains data which was backed up from role ``apache2`` of this
   application at this AppConfiguration. Any role may have a section here.

``appconfigs/a2233/gladiwashere/apache2/uploads``
   The name of the retention bucket that was backed up. This is the same as specified in
   the UBOS :term:`UBOS Manifest JSON` file by the installable. ``gladiwashere`` doesn't actually
   define such a retention bucket, but if it did, the relevant part of
   the manifest JSON would look like this::

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

Assume that a directory ``/srv/http/sites/s1122/blog/uploads`` of some web application
needs to be backed up. Let's assume that this directory belongs to an application that
is installed at context path ``/blog`` of some site
(application package ``myapp``, siteid ``s1122``, appconfigid ``a3344``).

Let's also assume this application has declared this directory as an AppConfiguration
item for the ``apache2`` role like this in its UBOS Manifest JSON file::

   {
       "type"            : "directory",
       "name"            : "uploads",
       "retention"       : "backup",
       "retentionbucket" : "uploadsdir"
       ...
   }

Then, the recursive directory tree starting with root directory
``/srv/http/sites/s1122/blog/uploads`` will be backed up to
``appconfigs/a3344/myapp/apache2/uploadsdir`` in the backup ZIP file.

Note that the filename in the ZIP file comes from the ``retentionbucket`` field in the
UBOS manifest, not from the name field or the name of the application. That way, the names
of files and directories can be easily changed from one version of the installable to
the next without impacting backups.

MySQL database content
^^^^^^^^^^^^^^^^^^^^^^

Assume that a UBOS Manifest JSON file declares a MySQL database as one of its AppConfiguration
items (application package ``myapp``, siteid ``s1122``, appconfigid ``a3344``).
Assume also that it declares that it wishes the database to be backed up, like this::

   {
       "type"            : "mysql-database",
       "name"            : "maindb",
       "retention"       : "backup",
       "retentionbucket" : "maindb.mysqldump",
       ...
   }

Then, upon backup, the content of the MySQL database will be exported by UBOS with the
``mysqldump`` tool to a file called ``maindb.mysqldump`` in directory
``appconfigs/a3344/myapp/mysql/`` in the backup ZIP file.

Note that the filename in the ZIP file comes from the ``retentionbucket`` field in the
UBOS manifest, not from the name field or the name of the application.
