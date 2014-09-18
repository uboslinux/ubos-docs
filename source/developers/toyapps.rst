Learning from the toy apps
==========================

UBOS provides two "toy" apps that help explain how to package and distribute
real web apps on UBOS.

To obtain the source code for both apps::

   > git clone https://github.com/indiebox/toyapps


Hello World
-----------

Hello World is an extremely simple Web applications that that just prints Hello World.
We use it to give you a taste for what is involved to package a real web application
for UBOS. Here is a complete :-) screen shot:

.. image:: /images/helloworld-screenshot.png

This describes the flow for the developer of the package:

 #. Developer creates the package. In its root directory::

       > cd .../helloworld
       > makepkg -f

    This will create the package file named ``helloworld-*-any.pkg.tar.xz`` (where
    ``*`` is a particular version number).

 #. Developer installs the package. This only dumps the files in the package on the
    hard drive, it does not install the app at any virtual host::

       > sudo pacman -U helloworld-*-any.pkg.tar.xz

 #. Developer installs this web app at a particular virtual host::

       > sudo ubos-admin createsite

    (See also :doc:`/users/firstsite`: use the app name ``helloworld``
    instead of ``wordpress``)

 #. Perform a software upgrade of the ``helloworld`` package (only), keeping mind that
    the web app is currently deployed on this host at least once::

       > sudo ubos-admin update --pkgfile <pkgfile>

    where ``<pkgfile>`` is a new version of the package file created as shown above.

 #. Develop uninstalls the app from the particular virtual host, but keeps the
    package installed::

       > sudo ubos-admin undeploy --siteid <siteid>

    where ``<siteid>`` is the identifier of the installed site.

Let's look at the anatomy of the package::

   > tar tfJ helloworld-*-any.pkg.tar.xz
   .PKGINFO
   .MTREE
   srv/
   srv/http/
   srv/http/_appicons/
   srv/http/_appicons/helloworld/
   srv/http/_appicons/helloworld/72x72.png
   srv/http/_appicons/helloworld/144x144.png
   srv/http/_appicons/helloworld/license.txt
   usr/
   usr/share/
   usr/share/helloworld/
   usr/share/helloworld/index.php
   usr/share/helloworld/htaccess
   var/
   var/lib/
   var/lib/ubos/
   var/lib/ubos/manifests/
   var/lib/ubos/manifests/helloworld.json

This package was put together by the ``makepkg`` command, as seen above, based on the
information in the ``PKGBUILD`` file in the source tree. The Arch Linux wiki
`describes this process <https://wiki.archlinux.org/index.php/Creating_packages>`_;
there is nothing UBOS-specific about this.

.. image:: /images/helloworld-icon.png
   :class: right

The first two files, ``.PKGINFO`` and ``.MTREE`` are automatically-generated metadata.

Then, the files below ``srv/http/_appicons/`` are simply graphics files that can be used
by UBOS to show to the user a logo for the application. This image is shown to the right.
They are optional and are added in the ``package()`` section of ``PGKBUILD``.

``usr/share/helloworld`` contains the files that constitute the application. For this
extremely simple app, there are only two: the PHP code that emits the "Hello World" HTML,
and an Apache ``htaccess`` file so this HTML is emitted even if the path ends with a slash.
More complex web apps would put the bulk of their code and auxiliary files there.

Finally, ``var/lib/ubos/manifests/`` contains the :term:`UBOS Manifest JSON` file for this
application, which describes what needs to happen upon ``ubos-admin deploy``. For this
app, the manifest file looks as follows::

   {
     "type" : "app",

     "roles" : {
       "apache2" : {
         "defaultcontext" : "/hello",
         "depends" : [
           "php",
           "php-apache"
         ],
         "apache2modules" : [
           "php5"
         ],
         "appconfigitems" : [
           {
             "type"         : "file",
             "name"         : "index.php",
             "source"       : "index.php",
           },
           {
             "type"         : "file",
             "name"         : ".htaccess",
             "source"       : "htaccess",
           }
         ]
       }
     }
   }

Let's discuss these items in sequence:

* ``"type" : "app"`` declares this to be an app, not an accessory.

* This app only uses a single role: ``apache2``. Apps could also specify other roles,
  such as ``mysql`` if they make use of MySQL in addition to Apache.

* By default, this app wants to be deployed at the relative path ``/hello`` of a
  virtual host. This can be overridden by the user in the :term:``Site JSON file``.

* For the ``apache2`` role, this app requires packages ``php`` and ``php-apache``, as it
  is a PHP app. It requires that the Apache module ``php5`` has been enabled before it
  can be run.

* Finally, each installation of this app requires two files to be installed in the
  web server's document directory tree: a file called ``index.php``, which is simply copied,
  and a file called ``.htaccess`` which is copied from a slightly different name. By
  convention, the "source" path is relative to the package installation directory
  ``/usr/share/helloworld``; and the destination path is relative to the correct directory
  from which Apache serves files, given the virtual host and context at which the app runs.
  Here, this may be ``/srv/http/sites/sa6e789f5d919c464d2422f6620eaf9cba789c4a5/hello/``
  (auto-provisioned by UBOS).

When the user invokes ``ubos-admin deploy``, UBOS processes the manifest and "makes it so".
It may be an interesting exercise for developers to install ``helloworld`` with the
example commands above, and to examine how UBOS made the app appear.

When the user invokes ``ubos-admin undeploy``, UBOS processes the manifest in reverse
sequence, and restores the system to its previous state.


Glad-I-Was-Here
---------------

Glad-I-Was-Here is a slightly more complex "guestbook" web application that uses a MySQL database
to store the guestbook entries. We use it to illustrate how to package web apps
that use a database for UBOS. Here is a screen shot:

.. image:: /images/gladiwashere-screenshot.png


This app can, obviously, be built and deployed with a similar set of commands as
``helloworld`` above::

   > cd .../gladiwashere
   > makepkg -f
   > sudo pacman -U gladiwashere-*-any.pkg.tar.xz
   > sudo ubos-admin createsite

Specify ``gladiwashere`` as the name of the app.

Let's examine this app's :term:`UBOS Manifest JSON` file. It is very similar to
``helloworld``'s, but has several more entries::

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

