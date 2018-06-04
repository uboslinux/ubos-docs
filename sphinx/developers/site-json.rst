Site JSON
=========

Overview
--------

A Site JSON file describes the structure of a :term:`Site`, aka virtual host. Generally,
a :term:`Site`:

* has a certain hostname, such as ``family.example.com``, or ``*`` if the :term:`Site`
  should respond to all requests regardless of HTTP host header;
* has a single administrator, for which username, e-mail address etc. are given;
* may or may not have SSL/TLS information (key, certificate etc.) so the :term:`Site` can be
  served over HTTPS;
* runs one or more :term:`Apps <App>` at different context paths, such as Wordpress at ``/blog``,
  and a wiki at ``/wiki``.
* each of those :term:`Apps <App>` may be configured with any number of
  :term:`Accessories <Accessory>` (for example, Wordpress plugins or themes)
* may also define certain well-known files, such as ``robots.txt``.

UBOS captures all of this information in a single JSON file with a particular structure,
called the Site JSON file. You can usually interact with Site JSON files as opaque
blobs, but if you like to see the Site JSON file for a :term:`Site` you have currently deployed,
determine its :term:`SiteId` and run:

.. code-block:: none

   % sudo ubos-admin showsite --json --siteid <siteid>

If you run this command as a user other than root, no credential information will be
included.

The easiest way of creating a Site JSON file is with the ``createsite`` command:

.. code-block:: none

   % sudo ubos-admin createsite -n -o newsite.json

(The ``-n`` flag will only generate the Site JSON and not deploy the :term:`Site`; the
``-o newsite.json`` flag will save the generated Site JSON to file ``newsite.json``.)

Structure
---------

The Site JSON file is a JSON hash with the following entries:

``admin`` (required)
   The admin section defines the administrator for the :term:`Site`. It has the following
   entries:

   ``userid`` (required)
      User identifier for the administrator. Example: ``admin``.

   ``username`` (required)
      Human-readable name for the administrator. Example: ``John Smith``.

   ``credential`` (required)
      Credential for the administrator account. Example: ``s3cr3t``. Only shown to the
      root user.

   ``email`` (required)
      Contact e-mail for the administrator. Example: ``admin@family.example.org``.

``appconfigs`` (optional)
   A JSON array of the AppConfigurations at this :term:`Site`. There is no significance to
   the order of the elements in the array. An :term:`AppConfiguration` is
   the installation of an :term:`App` at a particular context path at a particular :term:`Site`,
   together with any :term:`Accessories <Accessory>` and/or customization parameters that are
   specific to this installation of the :term:`App`.

``hostname`` (required)
   The hostname for the :term:`Site`, or ``*``. E.g. ``family.example.org``.

``lastupdated`` (optional)
   A timestamp for when this Site JSON file was last deployed to the current device. This
   data element gets inserted or updated by UBOS in the Site JSON held on the device,
   when a site is deployed.

``siteid`` (required)
   A unique identifier for the :term:`Site`. This is generally an ``s`` followed by
   40 hex characters. E.g. ``s054257e710d12d7d06957d8c91ab2dc1b22d7b4c``.

``tls`` (optional)
   This section is optional. If provided, UBOS will set up the :term:`Site` to be only
   accessible via HTTPS. UBOS will also automatically redirect incoming HTTP requests
   to their HTTPS equivalent.

   ``letsencrypt`` (mutually exclusive with ``key`` and ``crt``)
      If ``true``, obtain a certificate from letsencrypt.org, and set up the :term:`Site`
      with it. Also start an automatic renewal process.

   ``key`` (required unless ``letsencrypt`` is provided)
      The key for the tls :term:`Site`. Only shown to the root user.

   ``crt`` (required unless ``letsencrypt`` is provided)
      The certificate for the tls :term:`Site` as issued by your certificate authority,
      plus the certificate chain of your certificate authority, concatenated into
      one file.  Only shown to the root user.

   ``cacrt`` (optional)
      If you use TLS client authentication (not common), the certificate chain
      of the certificate authorities that your TLS clients are using.
      Only shown to the root user.

``tor`` (optional)
  This section is optional. If it is given, this :term:`Site` is intended to be run as a Tor hidden
  service.

  ``privatekey`` (optional)
     Contains the Tor private key, if it has been allocated already.

``wellknown`` (optional)
   This section is optional. It contains the data for well-known files that your
   :term:`Site` may be using.

   ``robotstxt`` (optional)
      The content of this field will be served as ``robots.txt`` at the root
      of your :term:`Site`.

   ``sitemapxml`` (optional)
      The content of this field will be served as ``sitemap.xml`` at the root
      of your :term:`Site`.

   ``faviconicobase64`` (optional)
      This contains the base64-encoded favicon for your :term:`Site`. UBOS will decode
      the base64, and serve the result as ``favicon.ico`` at the root of your
      :term:`Site`.

AppConfigs
----------

Each member of the ``appconfigs`` array is a JSON hash with the following entries:

``appconfigid`` (required)
   A unique identifier for the :term:`AppConfiguration`. This is generally an ``a`` followed by
   40 hex characters. E.g. ``a7d74fb881d43d12ff0ba4bd2ed39a98e107eab8c``.

``context`` (optional)
   The context path, from the root of the :term:`Site`, where the :term:`AppConfiguration` will run.
   For example, if you want to run Wordpress at ``http://example.org/blog``, the
   context path would be ``/blog`` (no trailing slash). If you want to run an :term:`App`
   at the root of the :term:`Site`, specify an empty string. If this field is not provided,
   UBOS will use the :term:`App`'s default context from the :doc:`ubos-manifest`.

``isdefault`` (optional)
   If provided, the value must be boolean ``true``. This instructs UBOS to automatically
   redirect clients from the root page of the :term:`Site` to this :term:`AppConfiguration`. If not
   provided, UBOS will show the installed :term:`Apps <App>` at the root page of the :term:`Site`.

``appid`` (required)
   The package identifier of the :term:`App` to be run. For example: ``wordpress``.

``accessoryids`` (optional)
   If provided, this entry must be a JSON array, containing one or more package
   identifiers of the :term:`Accessories <Accessory>` to be run for this installation of the :term:`App`.
   For example: ``[ 'wordpress-plugin-webmention' ]``

``customizationpoints`` (optional)
   If provided, this entry must be a JSON hash, providing values for
   :doc:`customization points <manifest/customizationpoints>` of the :term:`App` and/or
   :term:`Accessories <Accessory>` at this :term:`AppConfiguration`. They keys in this
   JSON hash are the package names of the packages installed at this :term:`AppConfiguration`,
   i.e. the package name of the :term:`App`, and any additional :term:`Accessories <Accessory>`. (By doing this,
   there cannot be any namespace collisions between customization points defined
   in the :term:`App` and the :term:`Accessories <Accessory>`).

   The value for each package is again a JSON hash, with the name of the customization
   point as the key, and a JSON hash as a value. Typically, this last JSON hash
   only has a single entry named ``value``, whose value is the value of the
   customization point. For example:

   .. code-block:: json

      "customizationpoints" : {
        "wordpress" : {
          "title" : {
            "value" : "My blog"
          }
        }
      }
