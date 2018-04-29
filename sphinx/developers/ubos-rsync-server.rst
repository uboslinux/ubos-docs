The UBOS rsync server
=====================

``ubos-rsync-server`` is a package that makes it easy for developers to support secure
file upload/download from UBOS-deployed applications via ``rsync`` over ``ssh``. Using
this package is often very convenient for developers of :term:`Apps <App>` whose data should be
uploadable or downloadable from the command-line, not just via a web browser.

To do discuss it, we will use the ``docroot`` :term:`App` available on UBOS that makes use
of ``ubos-rsync-server``. ``docroot`` is a simple web :term:`App` for static web site hosting.
You may want to review its :doc:`end user documentation </users/apps/docroot>` first.

To examine ``docroot``, please refer to its source code
`on Github <https://github.com/uboslinux/ubos-utilapps>`_.

You notice that ``docroot`` consists of only a handful of files:

* ``tmpl/htaccess.tmpl`` is the (template for the) Apache configuration fragment for this :term:`App`.
  Other than setting up permissions, PHP and some useful PHP environment variables, all this
  does is map the root of the installation URL (symbolically:
  ``${appconfig.context}/`` to a specific subdirectory called ``rsyncdir`` of the
  AppConfigurations's data directory: ``/ubos/lib/docroot/${appconfig.appconfigid}/rsyncsubdir/``.)
  In other words, the files in this directory will be presented to the user by the web server.

* ``install`` only makes sure that the UBOS device has a local user called ``docroot``.

* ``ubos-manifest.json`` is more interesting. First, it makes sure that the :term:`AppConfiguration`'s
  data directory and the ``rsyncdir`` subdirectory exist (the latter is marked as "to be
  backed up"). Then, it makes sure the ``htaccess`` file is instantiated in put in the right place.
  Finally, it runs a script, which, as you can see from its full path, has been provided by
  ``ubos-rsync-server``; we get to that in a second. It ends with the declaration of the
  customization point that enables the user to specify the public key used to upload
  during ``ubos-admin createsite``.

What does this ``provision-appconfig`` script do? (You can look at its source code
`here <https://github.com/uboslinux/ubos-packages/>`_.)

In short, it edits the ``authorized_keys`` file of the ``docroot`` user. Recall, this
``docroot`` user was created by and specifically for the ``docroot`` application. This
user has no password, so password-based authentication or login is not possible. And
``provision-appconfig`` now edits its ``authorized_keys`` file in a way that it permits
the permitted uploads, but disallows the not permitted ones. (It also prevents SSH-based
login.)

This setup is a little tricky -- which is why we created this package, so you don't have to --
but the essence of the ``authorized_keys`` edits is the following:

* each installation of ``docroot`` on the same device adds an addition authorized key to
  the ``authorized_keys`` file. This means that if you have five installations of ``docroot``
  on the same device, the ``authorized_keys`` file will contain five upload keys.

* incoming rsync-over-ssh connections will be examined by which :term:`AppConfigId` they specify.
  Only if the correct combination of SSH key and :term:`AppConfigId` is presented does the
  upload succeed. This prevents attackers who do not have the correct combination from
  accessing AppConfigurations they should not be able to access.

* Also, :term:`AppConfigId` gets translated into the correct directory for the AppConfig, which
  happens to be the ``rsyncdir`` that goes with the :term:`AppConfiguration`.

The result: The user can securely upload via ``rsync`` over ``ssh`` to their own
``docroot`` :term:`Sites <Site>`, but no others, even if others have ``docroot`` :term:`Sites <Site>` on the same
UBOS device.

``ubos-rsync-server`` can be used by any other :term:`App` the same way: setup a user that goes
with the :term:`App`, and have the :term:`App`'s ``ubos-manifest.json`` invoke ``provision-appconfig`` just
like ``docroot`` does.
