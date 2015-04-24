Glad-I-Was-Here (PHP, Postgresql)
=================================

This version of the Glad-I-Was-Here guestbook app uses Postgresql instead of MySQL as its
database. If you have not already read through the
:doc:`PHP/MySQL version <gladiwashere>` of Glad-I-Was-Here, we recommend you do so first.

We use this version of Glad-I-Was-Here to illustrate how to package web apps for UBOS that use
a Postgresql database. Its functionality and appearance is identical to the
:doc:`PHP/MySQL version <gladiwashere>`.

To obtain the source code::

   > git clone https://github.com/uboslinux/ubos-toyapps

Go to subdirectory ``gladiwashere-postgresql``.

Package lifecycle and app deployment
------------------------------------

To build the app::

   > makepkg -f
   > sudo pacman -U gladiwashere-postgresql-*-any.pkg.tar.xz
   > sudo ubos-admin createsite

Specify ``gladiwashere-postgresql`` as the name of the app.

Manifest JSON
-------------

Let's examine this app's :term:`UBOS Manifest JSON` file. It is identical to
``gladiwashere``'s, with the following differences:

* It declares a different ``defaultcontext`` so you can run both the MySQL and the
  Postgresql version of this app at the same time on the same device with the defaults.

* It specifies the ``postgresql`` role instead of the ``mysql`` role, to use
  Postgresql instead of MySQL.

* It uses Postgresql database drivers to access Postgresql from PHP.

.. code-block:: json

   {
     "type" : "app",

     "roles" : {
       "apache2" : {
         "defaultcontext" : "/guestbook-postgresql",
         "depends" : [
           "php",
           "php-apache",
           "php-pgsql"
         ],
         "apache2modules" : [
           "php5"
         ],
         "phpmodules" : [
           "pgsql"
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
       "postgresql" : {
         "appconfigitems" : [
           {
             "type"             : "database",
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
  Postgresql drivers, and not MySQL drivers.

* By specifying the role ``postgresql`` instead of ``mysql`` in the lower part of
  the manifest file, UBOS knows that the database to be provisioned (and backed up,
  restored etc.) is supposed to be a Postgresql database.

* Correspondingly, in the ``config.php.tmpl`` the variables refer to Postgresql::

     <?php
     $dbName   = '${appconfig.postgresql.dbname.maindb}';
     $dbUser   = '${appconfig.postgresql.dbuser.maindb}';
     $dbPass   = '${escapeSquote( appconfig.postgresql.dbusercredential.maindb )}';
     $dbServer = '${appconfig.postgresql.dbhost.maindb}';
