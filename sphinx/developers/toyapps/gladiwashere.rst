Glad-I-Was-Here (PHP)
=====================

Glad-I-Was-Here is a slightly more complex "guestbook" web application that uses a MySQL database
to store the guestbook entries. We use it to illustrate how to package web apps
that use a database for UBOS. Here is a screen shot:

.. image:: /images/gladiwashere-screenshot.png

To obtain the source code::

   > git clone https://github.com/indiebox/ubos-toyapps

Go to subdirectory ``gladiwashere``.

Package lifecycle
-----------------

This app can, obviously, be built and deployed with a similar set of commands as
:doc:`helloworld` above::

   > makepkg -f
   > sudo pacman -U gladiwashere-*-any.pkg.tar.xz
   > sudo ubos-admin createsite

Specify ``gladiwashere`` as the name of the app.

Manifest JSON
-------------


Let's examine this app's :term:`UBOS Manifest JSON` file. It is very similar to
``helloworld``'s, but has several more entries:

.. code-block:: json

   {
     "type" : "app",

     "roles" : {
       "apache2" : {
         "defaultcontext" : "/guestbook",
         "depends" : [
           "php",
           "php-apache",
           "php-gd"
         ],
         "apache2modules" : [
           "php5"
         ],
         "phpmodules" : [
           "mysql",
           "mysqli"
         ],
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
       },
       "mysql" : {
         "appconfigitems" : [
           {
             "type"             : "mysql-database",
             "name"             : "maindb",
             "retentionpolicy"  : "keep",
             "retentionbucket"  : "maindb",
             "privileges"       : "select, insert"
           }
         ],
         "installers" : [
           {
             "name"   : "maindb",
             "type"   : "sqlscript",
             "source" : "sql/create.sql"
           }
         ]
       }
     }
   }

* ``phpmodules`` lists the PHP modules that the app requires. In this case, it needs
  mysql drivers.

* The second ``appconfigitem`` in the ``apache2`` role specifies a template file,
  instead of a source. Together with a ``templatelang``, this specifies that
  variable substitution should be performed during installation when copying the file.

  In this case, this will replace symbolic database information with the actually
  provisioned database information. For example, ``ubos-admin deploy`` might
  transform this template file text::

     <?php
     $dbName   = '${appconfig.mysql.dbname.maindb}';
     $dbUser   = '${appconfig.mysql.dbuser.maindb}';
     $dbPass   = '${escapeSquote( appconfig.mysql.dbusercredential.maindb )}';
     $dbServer = '${appconfig.mysql.dbhost.maindb}';

  to::

     <?php
     $dbName   = 'somedbname';
     $dbUser   = 'somedbuser';
     $dbPass   = 'somedbpass';
     $dbServer = 'localhost';

  which gives the application the ability to find its database.

* The third item creates a symbolic link, which is also possible.

* This app also uses role ``mysql``. It requires a database (an ``appconfigitem`` of
  type ``mysql-database`` whose symbolic name is ``maindb``. This symbolic name will
  be replaced with an actual provisioned database name; in the previous bullet it
  was replaced with ``somedbname``. A user will be provisioned for the database
  automatically, with the specified privileges.

* The ``rententionbucket`` and ``retentionpolicy`` fields express that this database
  contains precious information that needs to be backed up when a backup is run, and
  kept during software upgrades.

* And finally, after the database has been provisioned for the first time (but not
  after upgrades), a script of type ``sqlscript`` needs to be run whose source can
  be found at ``/usr/share/gladiwashere/sql/create.sql``. This script initializes
  the schema of the database.
