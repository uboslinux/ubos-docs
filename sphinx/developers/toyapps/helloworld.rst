Hello World
===========

Hello World is an extremely simple Web applications that that just prints Hello World.
We use it to give you a taste for what is involved to package a real web application
for UBOS. Here is a complete :-) screen shot:

.. image:: /images/helloworld-screenshot.png

To obtain the source code::

   > git clone https://github.com/indiebox/toyapps

Go to subdirectory ``helloworld``.

Package lifecycle
-----------------

This describes the lifecycle of the package, as it is created by a developer and installed,
updated and uninstalled by a user:

#. The developer creates the files for the package. If you have cloned the git repository above,
   you find the files for ``helloworld`` in directory ``helloworld``; or you can browse
   them `on github <https://github.com/indiebox/toyapps/tree/master/helloworld>`_. They are:

   * ``appicons``: icon files (optional)
   * ``PKGBUILD``: package build script with some package meta-data (see below)
   * ``htaccess``: Apache configuration file that makes Apache default to ``index.php`` when
     the app is installed
   * ``index.php``: minimalistic PHP file printing "Hello World"
   * ``ubos-manifest.json``: UBOS meta-data file (see below)

#. The developer creates the package. In its root directory::

      > makepkg -f

   This will create the package file named ``helloworld-*-any.pkg.tar.xz`` (where
   ``*`` is a particular version number).

#. The user installs the package. This only dumps the files in the package on the
   hard drive, it does not install the app at any virtual host::

      > sudo pacman -U helloworld-*-any.pkg.tar.xz

   This command will install a locally built package locally, but it is equivalent to
   what happens when a user obtains the same app via the UBOS :term:`Depot`.

#. The user installs this web app at a particular virtual host::

      > sudo ubos-admin createsite

   (See also :doc:`/users/firstsite`: use the app name ``helloworld``
   instead of ``wordpress``)

#. Now assume that a new version of the package is available. If the new package is available
   locally, the user can perform a software upgrade of the ``helloworld`` package (only)::

      > sudo ubos-admin update --pkgfile <pkgfile>

   where ``<pkgfile>`` is a new version of the package file created as shown above.
   If distributed through the UBOS :term:`Depot`, the argument ``--pkgfile`` will be
   omitted, and UBOS will upgrade all software on the host to the most recent version.

#. Undeploy the app by undeployed the entire virtual host. This will keeps the
   package installed::

      > sudo ubos-admin undeploy --siteid <siteid>

   where ``<siteid>`` is the identifier of the installed site.

#. If the user wishes the package entirely::

      > sudo pacman -R helloworld

Anatomy of the package
----------------------

The ``PKGBUILD`` script's ``package`` method puts the package together::

   package() {
   # Manifest
       mkdir -p $pkgdir/var/lib/ubos/manifests
       install -m0644 $startdir/ubos-manifest.json $pkgdir/var/lib/ubos/manifests/${pkgname}.json
   # Icons
       mkdir -p $pkgdir/srv/http/_appicons/$pkgname
       install -m644 $startdir/appicons/{72x72,144x144}.png $pkgdir/srv/http/_appicons/$pkgname/
       install -m644 $startdir/appicons/license.txt $pkgdir/srv/http/_appicons/$pkgname/
   # Code
       mkdir -p $pkgdir/usr/share/${pkgname}
       install -m755 $startdir/index.php $pkgdir/usr/share/${pkgname}/
       install -m644 $startdir/htaccess $pkgdir/usr/share/${pkgname}/
   }

You can see that this script creates three directories, and installs a few files in them.
The Arch Linux wiki
`describes PKGBUILD <https://wiki.archlinux.org/index.php/Creating_packages>`_;
there is nothing UBOS-specific about this.

This corresponds to what the package file contains after ``makepkg`` has completed::

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
application, which describes what needs to happen upon ``ubos-admin deploy`` and when
other ``ubos-admin`` commands are executed.

App manifest
------------

For this app, the manifest file looks as follows:

.. code-block:: json

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
  virtual host. This can be overridden by the user in the :term:`Site JSON` file.

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
