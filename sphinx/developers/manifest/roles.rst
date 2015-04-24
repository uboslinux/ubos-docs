Roles section
=============

The roles section in an UBOS Manifest defines how the app or accessory needs to be deployed
and related information. For example, the roles section defines:

* which files or directories need to be created in the file system;
* which databases need to be provisioned with which permissions;
* which directories or databases need to be backed up;
* which scripts to run after installation, before uninstallation, or for a version
  upgrade.

The roles section is structured by roles. Currently supported roles are:

* ``apache2``: information related to the web tier;
* ``tomcat7``: information related to the Java apps running on Tomcat (if applicable);
* ``mysql``: information related to MySQL databases (if applicable).
* ``postgresql``: information related to Postgresql databases (if applicable).

Generally, upon installation of an app or accessory, the roles are processed in this sequence:

#. ``mysql`` or ``postgresql`` (if applicable)
#. ``tomcat7`` (if applicable)
#. ``apache2``

Upon uninstallation of an app or accessory, the roles are processed in the opposite sequence.

Here are common fields for all roles:

Common fields
-------------

Depends
^^^^^^^

When the app or accessory is deployed for this role, the field
``depends`` identifies required packages. Often, these dependencies could also be listed
in the package's :term:`PKGBUILD` file, but this additional field allows the declaration of
dependencies that are only required if this role is used.

Example:

.. code-block:: json

   "apache2" : {
     "depends" : [ "php-apache", "php-gd" ],
     ...

App Config Items
^^^^^^^^^^^^^^^^

This section captures the items that need to be put in place before a deployment of
an app or accessory is functional. These items can be things such as files, directories,
symbolic links, or databases; but also scripts that need to be run.

For example, in the ``apache2`` role of an app the following ``appconfigitems`` section
may be found:

.. code-block:: json

   "appconfigitems" : [
     {
       "type"         : "file",
       "name"         : "index.php",
       "source"       : "web/index.php",
     },
     {
       "type"         : "file",
       "name"         : "config.php",
       "template"     : "tmpl/config.php.tmpl",
       "templatelang" : "varsubst"
     },
     {
       "type"         : "symlink",
       "name"         : "gladiwashere.php",
       "source"       : "web/gladiwashere.php"
     }
   ]

Here, three items need to be put in place: two files, and a symbolic link. The following
App Config Item types are currently supported:

* ``directory``: a directory to be created;
* ``directorytree`` : a recursive directory tree, copied from somewhere else;
* ``file``: a file, created by copying another file, or processing another file (see below);
* ``database``: a database that needs to be created (only use this for database roles such
  as the ``mysql`` role);
* ``perlscript``: a Perl script that needs to be run;
* ``sqlscript``: A SQL script that needs to be run (only use this for the ``mysql`` role);
* ``symlink``: A symbolic link.
* ``systemd-service``: A systemd service to be running while the AppConfiguration is deployed
* ``systemd-timer``: A systemd timer to be active while the AppConfiguration is deployed

The field ``name`` is the name of the file, directory, database, systemd service or timer to
be created or operated on.

The field ``template`` identifies a file or directory that is to be used as a template for
creating the new item. The corresponding field ``templatelang`` states how the template
should be used to create the item. In the example above, the ``varsubst`` ("variable
substitution") algorithm is to be applied. (See :doc:`variables` and :doc:`perlscript`.)

The field ``source`` refers to a file that is the source code for the script to be run,
or the destination of the symbolic link.

The following table shows all attributes of AppConfigurationItems:

+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| JSON Entry          | Description 	                             | Relative path context         | Mutually exclusive with |
+=====================+==============================================+===============================+=========================+
| ``delimiter``       | SQL delimiter for sql scripts                | N/A                           | N/A                     |
|                     | (default: ``;``)                             |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``dirpermissions``  | a string containing the octal number for the | N/A                           | N/A                     |
|                     | chmod permissions for directories in this    |                               |                         |
|                     | directory hierarchy (default: ``"0755"``)    |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``filepermissions`` | a string containing the octal number for the | N/A                           | N/A                     |
|                     | chmod permissions for files in this          |                               |                         |
|                     | directory hierarchy (default: ``"0644"``)    |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``gname``           | the name of the Linux group that this item   | N/A                           | N/A                     |
|                     | should belong to (default: ``root``).        |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``name``            | the name of the created file, directory,     | ``${appconfig.apache2.dir}``  | ``names``               |
|                     | symlink, or root of the directory tree       |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``names``           | the names of the created files, directories, | ``${appconfig.apache2.dir}``  | ``name``                |
|                     | symlinks, or roots of the directory trees if |                               |                         |
|                     | more than one item supposed to be processed  |                               |                         |
|                     | with the same rule                           |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``permissions``     | a string containing the octal number for the | N/A                           | N/A                     |
|                     | chmod permissions for this file or directory |                               |                         |
|                     | (default: ``"0644"`` for files, ``"0755"``   |                               |                         |
|                     | for directories)                             |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``privileges``      | SQL privileges for the a database            | N/A                           | N/A                     |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``retentionbucket`` | if given, captures that this item contains   | N/A                           | N/A                     |
|                     | valuable data that needs to be preserved,    |                               |                         |
|                     | e.g. when a backup is performed              |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``source``          | the file to copy (or execute) without change | ``${package.codedir}``        | ``template``            |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``template``        | a template file that will be copied after    | ``${package.codedir}``        | ``source``              |
|                     | being processed according to                 |                               |                         |
|                     | ``templatelang``                             |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``templatelang``    | specifies the type of template processing to | N/A                           | ``source``              |
|                     | be performed if template is given            |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+
| ``uname``           | the name of the Linux user account that      | N/A                           | N/A                     |
|                     | should own the created item (default:        |                               |                         |
|                     | ``root``)                                    |                               |                         |
+---------------------+----------------------------------------------+-------------------------------+-------------------------+

This table shows which attributes apply to which types of AppConfigurationItem:

+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| JSON Entry          | ``directory`` | ``directory`` | ``file``  | ``database`` | ``perl``   | ``sql``    | ``symlink`` | ``systemd-`` | ``systemd-`` |
|                     |               | ``tree``      |           |              | ``script`` | ``script`` |             | ``service``  | ``timer``    |
+=====================+===============+===============+===========+==============+============+============+=============+==============+==============+
| ``delimiter``       |               |               |           |              |            | Y          |             |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``dirpermissions``  |               | Y             |           |              |            |            |             |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``filepermissions`` |               | Y             |           |              |            |            |             |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``gname``           | Y             | Y             | Y         |              |            |            | Y           |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``name``            | Y             | Y             | Y         | Y            | Y          | Y          | Y           | Y            | Y            |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``names``           | Y             | Y             | Y         |              |            |            | Y           |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``permissions``     | Y             |               | Y         |              |            |            |             |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``privileges``      |               |               |           | Y            |            |            |             |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``retentionbucket`` | Y             |               | Y         | Y            |            |            |             |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``source``          |               | Y             | Y         |              | Y          | Y          | Y           |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``template``        |               |               | Y         |              |            | Y          |             |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``templatelang``    |               |               | Y         |              |            | Y          |             |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+
| ``uname``           | Y             | Y             | Y         |              |            |            | Y           |              |              |
+---------------------+---------------+---------------+-----------+--------------+------------+------------+-------------+--------------+--------------+


Installers, Uninstallers, Upgraders
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

These fields identify scripts to be run when certain events occur:

* field ``installers`` is processed when the app or accessory is deployed;
* field ``uninstallers`` is processed when the app or accessory is undeployed;
* field ``upgraders`` is processed after an app or accessory has been deployed and
  data has been restored that potentially must be migrated to work with the current
  version of the app or accessory.

Note that during software upgrades, deployment and undeployment may occur as well.

Each of these fields points to an array. Each of the elements in the array is a separate
script that will be run in the sequence listed.

Here is an example for ``installers`` in the ``mysql`` role of an app that uses MySQL:

.. code-block:: json

   "installers" : [
     {
       "name"   : "maindb",
       "type"   : "sqlscript",
       "source" : "mediawiki/maintenance/tables.sql"
     }
   ]

When this section is processed, UBOS will run the script ``mediawiki/maintenance/tables.sql``
of type ``sqlscript`` against the database whose symbolic name is ``maindb``.

Supported types are:

* ``sqlscript``: a SQL script (but only for the ``mysql`` role)
* ``perlscript``: a Perl script


Apache2 role
------------

The ``apache2`` role knows additional fields.

Context
^^^^^^^

Web apps must specify one of the following two fields:

* ``defaultcontext``: the relative URL path at which the app is installed by default.
  For example, Wordpress may have a defaultcontext of ``/blog``, i.e. if the user installs
  Wordpress at ``example.com``, by default Wordpress will be accessible at
  ``http://example.com/blog``. This field is to be used if the app is able to be installed
  at any relative URL, but this is the default.
* ``fixedcontext``: some web apps can only be installed at a particular relative URL,
  or only at the root of a site. Use ``fixedcontext`` to declare that relative URL.

Apache modules
^^^^^^^^^^^^^^

``apache2modules`` is a list of names of Apache2 modules that need to be activated before
the app or accessory can be successfully run. Here is an example:

.. code-block:: json

   "apache2modules" : [
     "php5"
   ]

This declaration will make sure that the ``php5`` module is active in Apache2; if not yet,
UBOS will activate it and restart Apache2 without any further work by the app or accessory.

Note that the ``apache2`` role still needs to declare a dependency on ``php5``;
``apache2modules`` does not attempt to infer which packages might be needed.

PHP modules
^^^^^^^^^^^

``phpmodules`` is a list of names of PHP modules that need to be activated before
the app or accessory can be successfully run. Here is an example:

.. code-block:: json

   "phpmodules" : [
     "gd"
   ]

This declaration will make sure that the PHP module ``gd`` has been
activated; if not, UBOS will activate it and restart Apache2.

Note that the ``apache2`` role still needs to declare a dependency on ``php-gd``;
``apache2modules`` does not attempt to infer which packages might be needed.

Robots.txt contribution
^^^^^^^^^^^^^^^^^^^^^^^

The optional ``robotstxt`` section can be used by apps to insert allowed and disallowed
paths into a site's ``robots.txt``. The site's ``robots.txt`` file is being generated
automatically by assembling such fragments, unless a complete ``robots.txt`` has been
provided by the user in the Site JSON.

The ``robotstxt`` section in the manifest may contain fields ``allow`` and ``disallow``,
both JSON arrays, which hold the exact string values that will be inserted into the
generated ``robots.txt`` file.

For example, if an app had this fragment in the ``apache2`` role in its UBOS Manifest JSON:

.. code-block:: json

   "wellknown" : {
     "robotstxt" : {
       "disallow" : [
         "/wp-admin/"
       ]
     }
   }

and if the app was installed at ``http://example.com/blog``, and no other apps at the
same site had contributions to the generated ``robots.txt`` file, then the generated
``robots.txt`` file would look like this:

.. code-block:: none

   User-Agent: *
   Disallow: /blog/wp-admin/

