Glad-I-Was-Here (PHP, MySQL)
============================

Compared to :doc:`helloworld`, Glad-I-Was-Here is a slightly more complex "guestbook" web
application that uses a SQL database to store guestbook entries. This application has
been implemented using several different programming languages and relational databases,
so it can act as an example how to package UBOS apps built with various common web
technologies.

This section describes the possibly simplest-to-understand implementation using PHP
and MySQL.

If you have not already read through the :doc:`helloworld` app documentation, we
recommend you do so first as we'll only discuss things in this section that were not
covered there.

Here is a screen shot of the app in action:

.. image:: /images/gladiwashere-screenshot.png

To obtain the source code:

.. code-block:: none

   > git clone https://github.com/uboslinux/ubos-toyapps

Go to subdirectory ``gladiwashere-php-mysql``.

Package lifecycle and app deployment
------------------------------------

Like all other apps on UBOS including :doc:`helloworld`, ``gladiwashere-php-mysql`` is built
with ``makepkg``, installed with ``pacman`` and deployed with ``ubos-admin``.

.. code-block:: none

   > makepkg -f
   > sudo pacman -U gladiwashere-php-mysql-*-any.pkg.tar.xz
   > sudo ubos-admin createsite

Specify ``gladiwashere-php-mysql`` as the name of the app. This will set up a website
on your UBOS device that runs ``gladiwashere-php-mysql``.

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
           "php-apache"
         ],
         "apache2modules" : [
           "php7"
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

* In addition to the ``apache2`` role, this app also has a ``mysql`` role. Like in the
  ``apache2`` role, the contained ``appconfigitems`` tell UBOS what needs to be provisioned
  so the app can be run successfully. In the ``mysql`` role, these are items all related to
  MySQL.

  Here, we tell UBOS to provision a new database for each deployment of Glad-I-Was-Here,
  together with a new database user and a unique database credential. This database
  user will have database privileges ``select`` and ``insert`` but no others, because
  that's all the Glad-I-Was-Here app needs.

  The database's symbolic name is ``maindb``. This will NOT be the actual database
  name at deployment time. Instead, UBOS will create a (random) database name. To
  understand why this is useful, consider which database name, and database username
  and password should be used by this app. If it was hardcoded, it would create a big
  security problem, and only a single installation of Hello World (or any other app
  that hardcoded its information) could run on the same device. Neither is desirable.

  So UBOS automatically generates a unique name, and uses that. To be able for you
  to refer to it, we use a symbolic name, here: ``maindb``. You will see that below
  when we discuss how the PHP code connects to the correct database with the correct
  database user and credential, using the template mechanism.

* The ``rententionbucket`` and ``retentionpolicy`` fields express that this database
  contains precious information that needs to be backed up when a backup is run, and
  kept during software upgrades. If those were not given, UBOS would discard the data
  in the database during upgrades and backups.

* The optional ``installers`` section allows the developer to specify actions to be
  taken after the database has been provisioned for the first time (but not
  after upgrades). Here, a script of type ``sqlscript`` needs to be run whose source can
  be found at ``/usr/share/gladiwashere/sql/create.sql``. As you would have guessed,
  this script initializes the tables of the database. UBOS runs this script with more
  privileges (``create``) than the app's database user has, which explains why the
  database user can get away with ``select`` and ``insert`` privileges only.

* Back above in the ``apache2`` section, ``phpmodules`` lists the PHP modules that
  the app requires. In this case, it needs MySQL drivers. These are names of PHP
  modules as found in ``/etc/php.ini`` and the like.

* The second ``appconfigitem`` in the ``apache2`` role specifies a template file,
  instead of a source. Together with a ``templatelang``, this indicates that
  variable substitution should be performed during deployment when copying the file.

  Here, the template file is the following (omitting the PHP comment for brevity):

  .. code-block:: php

     <?php
     $dbName   = '${appconfig.mysql.dbname.maindb}';
     $dbUser   = '${appconfig.mysql.dbuser.maindb}';
     $dbPass   = '${escapeSquote( appconfig.mysql.dbusercredential.maindb )}';
     $dbServer = '${appconfig.mysql.dbhost.maindb}';

  which will be transformed into the actual deployed file that looks like this:

  .. code-block:: php

     <?php
     $dbName   = 'somedbname';
     $dbUser   = 'somedbuser';
     $dbPass   = 'somedbpass';
     $dbServer = 'localhost';

  where ``somedbname`` etc are the values for the provisioned database. Above we said
  that ``maindb`` was the symbolic name of the to-be-provisioned database. This symbolic
  name allows us now to refer to various bits of information related to that database.
  For example, ``${appconfig.mysql.dbname.maindb}`` refers to the actual name of the
  MySQL database whose symbolic name is ``maindb``. You can see other such variables
  for database user, password and host.

* The third item creates a symbolic link.

Visit :doc:`gladiwashere-php-postgresql` for a version of this app that uses PHP and
Postgresql, :doc:`gladiwashere-java-mysql` for one that uses Java, and
:doc:`gladiwashere-python-mysql` that uses Python.
