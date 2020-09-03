Hello World
===========

Our version of Hello World is an extremely simple Web applications that that just displays
"Hello World" in a user's web browser. We use it to give you a taste for what is involved
to package a real web application
for UBOS. Here is a complete :-) screen shot:

.. image:: /images/helloworld-screenshot.png

To obtain the source code:

.. code-block:: none

   % git clone https://github.com/uboslinux/ubos-toyapps

Go to subdirectory ``helloworld``.

Package lifecycle and App deployment
------------------------------------

The first thing to understand about how UBOS :term:`Apps <App>` are packaged and deployed is the
lifecycle of a package from the developer's perspective, and then how a user deploys
and undeploys the :term:`App` contained in the package to their website:

#. The developer creates the files for the package. If you have cloned the git repository above,
   you find the files for ``helloworld`` in directory ``helloworld``; or you can browse
   them `on github <https://github.com/uboslinux/ubos-toyapps/tree/master/helloworld>`_. They
   are:

   * ``index.php``: minimalistic PHP file printing "Hello World";
   * ``htaccess``: Apache configuration file fragment that makes Apache default to
     ``index.php`` when the :term:`App` is installed;
   * ``PKGBUILD``: script used to create the package (see below);
   * ``ubos-manifest.json``: UBOS meta-data file (see below);
   * ``appicons``: icon files (optional) that will be used for the icon the user can click
     on to visit the :term:`App`.

#. The developer creates the package by executing, in its root directory:

   .. code-block:: none

      % makepkg -f

   This will create the package file named ``helloworld-*-any.pkg.tar.xz`` (where
   ``*`` is a particular version number defined in the ``PKGBUILD`` file).
   ``makepkg`` is the packaging command for ``pacman`` packages, the types of
   packages we use in UBOS. (You can read more about ``pacman`` on the
   `Arch Linux Wiki <https://wiki.archlinux.org/index.php/Pacman>`_.)

#. Once the package has been created, the developer makes the package available to the user.
   In the general case, this involves uploading the package to the UBOS depot, UBOS quality
   assurance etc etc, but for our purposes here, ignore all that and simply assume that the
   package file created by the developer has somehow arrived on the user's UBOS device,
   such as by file transfer.

#. The user installs the package on the target device:

   .. code-block:: none

      % sudo pacman -U helloworld-*-any.pkg.tar.xz

   This command will install a locally built package locally, but it is equivalent to
   what happens when a user obtains the same :term:`App` via the UBOS :term:`Depot`.

   Note that this unpacks the package on the hard drive and runs whatever installation
   scripts that the package specifies (the latter is rare, e.g. Hello World does not
   have such scripts). However, installing the package does not deploy the :term:`App` at any
   :term:`Site` or virtual host. To do that, see the next step:

#. The user deploys the web :term:`App` defined by the package at a particular virtual host:

   .. code-block:: none

      % sudo ubos-admin createsite

   Answer the questions it asks, and use the :term:`App` name ``helloworld`` (see also
   :doc:`/users/firstsite`)

   This will put all the right files in the right web server directories, activate
   needed Apache modules, restart servers, and the like. When this command completes,
   the :term:`App` is ready for use.

#. The user can now visit the fully deployed :term:`App` at the respective URL at which it
   was installed.

#. Now assume that a new version of the package is available. If the new package is available
   locally, the user can perform a software upgrade of the ``helloworld`` package (only):

   .. code-block:: none

      % sudo ubos-admin update --pkgfile <pkgfile>

   where ``<pkgfile>`` is a new version of the package file created as shown above.
   If distributed through the UBOS :term:`Depot`, the argument ``--pkgfile`` will be
   omitted, and UBOS will upgrade all software on the host to the most recent version.

#. Undeploy the :term:`App` by undeploying the entire virtual host. This will keeps the
   package installed:

   .. code-block:: none

      % sudo ubos-admin undeploy --siteid <siteid>

   where ``<siteid>`` is the identifier of the installed :term:`Site`.

#. If the user wishes to remove the package entirely:

   .. code-block:: none

      % sudo pacman -R helloworld

Anatomy of the package
----------------------

The ``PKGBUILD`` script's ``package`` method puts the package together:

.. code-block:: none

   package() {
   # Manifest
       install -D -m0644 ${startdir}/ubos-manifest.json ${pkgdir}/ubos/lib/ubos/manifests/${pkgname}.json

   # Icons
       install -D -m0644 ${startdir}/appicons/{72x72,144x144}.png -t ${pkgdir}/ubos/http/_appicons/${pkgname}/
       install -D -m0644 ${startdir}/appicons/license.txt         -t ${pkgdir}/ubos/http/_appicons/${pkgname}/

   # Code
       install -D -m0644 ${startdir}/index.php -t ${pkgdir}/ubos/share/${pkgname}/
       install -D -m0644 ${startdir}/htaccess  -t ${pkgdir}/ubos/share/${pkgname}/
   }

You can see that this script creates installs a few files in subdirectories of ``${pkgdir}``,
which is a staging directory for creating a ``tar`` file. The Arch Linux wiki
`describes PKGBUILD <https://wiki.archlinux.org/index.php/Creating_packages>`_;
there is nothing UBOS-specific about this.

This corresponds to what the package file contains after ``makepkg`` has completed:

.. code-block:: none

   % tar tfJ helloworld-*-any.pkg.tar.xz
   .PKGINFO
   .BUILDINFO
   .MTREE
   ubos/
   ubos/lib/
   ubos/http/
   ubos/share/
   ubos/share/helloworld/
   ubos/share/helloworld/index.php
   ubos/share/helloworld/htaccess
   ubos/http/_appicons/
   ubos/http/_appicons/helloworld/
   ubos/http/_appicons/helloworld/72x72.png
   ubos/http/_appicons/helloworld/144x144.png
   ubos/http/_appicons/helloworld/license.txt
   ubos/lib/ubos/
   ubos/lib/ubos/manifests/
   ubos/lib/ubos/manifests/helloworld.json

The first three files, ``.PKGINFO``, ``.BUILDINFO`` and ``.MTREE`` contain metadata that is
automatically generated by ``makepkg``.

Directory ``ubos/share/helloworld`` contains the files that constitute the application. For this
extremely simple :term:`App`, there are only two: the PHP code that emits the "Hello World" HTML,
and an Apache ``htaccess`` file so this HTML is emitted even if the path ends
with a slash instead of ``index.php``. More complex web :term:`Apps <App>` would put the bulk of their
code and auxiliary files there.

In a typical Linux distro, these files would be located at ``/usr/share/helloworld`` or
perhaps at ``/srv/http/helloworld``. In UBOS, these files are located below ``/ubos``, which
is the place where users can mount a large data disk.

.. image:: /images/helloworld-icon.png
   :class: right

The files below ``ubos/http/_appicons/`` are simply graphics files that can be used
by UBOS to show to the user a logo for the application. This image is shown to the right.
They are optional and are added in the ``package()`` section of ``PGKBUILD``.

Finally, ``ubos/lib/ubos/manifests/`` contains the :term:`UBOS Manifest JSON` file for this
application, which describes what needs to happen upon ``ubos-admin deploy`` and when
other ``ubos-admin`` commands are executed.

App manifest
------------

For this :term:`App`, the UBOS Manifest JSON file looks as follows:

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
           "php7"
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

* ``"type" : "app"`` declares this to be an :term:`App`, not an :term:`Accessory`.

* This :term:`App` only uses a single role: ``apache2``. :term:`Apps <App>` could also specify other roles,
  such as ``mysql`` if they make use of MySQL in addition to Apache.

* By default, this :term:`App` wants to be deployed at the relative path ``/hello`` of a
  virtual host. This can be overridden by the user in the :term:`Site JSON` file or when
  entering a different path during execution of ``ubos-admin createsite``.

* For the ``apache2`` role, this :term:`App` requires packages ``php`` and ``php-apache``, as it
  is a PHP :term:`App`. It requires that the Apache module ``php7`` has been enabled before it
  can be run.

* Finally, each installation of this :term:`App` requires two files to be installed in the
  web server's document directory tree: a file called ``index.php``, which is simply copied,
  and a file called ``.htaccess`` which is copied from a slightly different name. By
  convention, the "source" path is relative to the package installation directory
  ``/ubos/share/helloworld``; and the destination path is relative to the correct directory
  from which Apache serves files, given the virtual host and context at which the :term:`App` runs.
  Here, this may be ``/ubos/http/sites/sa6e789f5d919c464d2422f6620eaf9cba789c4a5/hello/``
  (auto-provisioned by UBOS).

When the user invokes ``ubos-admin deploy``, UBOS processes the manifest and "makes it so".
We recommend you package and then ``helloworld`` with the example commands above, and
then examine how UBOS made the :term:`App` appear.

When the user invokes ``ubos-admin undeploy``, UBOS processes the manifest in reverse
sequence, and restores the system to its previous state.
