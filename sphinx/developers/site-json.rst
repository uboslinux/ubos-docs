Site JSON
=========

A Site JSON file describes the structure of a site, aka virtual hostname. Generally,
a Site:

* has a certain hostname, such as ``family.example.com``;
* has a single administrator, for which username, e-mail address etc. are given;
* may or may not have SSL information (key, certificate etc.) so the site can be
  served over HTTPS;
* runs one or more apps at different context paths, such as Wordpress at ``/blog``,
  and a wiki at ``/wiki``.
* each of those apps may be configured with any number of accessories (for example,
  Wordpress plugins or themes)
* may also define certain well-known files, such as ``robots.txt``.

UBOS captures all of this information in a single JSON file with a particular structure,
called the Site JSON file. You can usually interact with Site JSON files as opaque
blobs, but if you like to see the Site JSON file a site you have currently deployed, run::

   > sudo ubos-admin showsite --json --siteid <siteid>

The easiest way of creating a Site JSON file is with the ``createsite`` command::

   > sudo ubos-admin createsite -n

(The ``-n`` flag will only generate and print the Site JSON and not deploy the site)

The Site JSON file is a JSON hash with the following entries:

``siteid`` (required)
   A unique identifier for the site. This is generally an ``s`` followed by
   40 hex characters. E.g. ``s054257e710d12d7d06957d8c91ab2dc1b22d7b4c``.

``hostname`` (required)
   The hostname for the site. E.g. ``family.example.org``.

``admin`` (required)
   The admin section defines the administrator for the site. It has the following
   entries:

   ``userid`` (required)
      User identifier for the administrator. Example: ``admin``.

   ``username`` (required)
      Human-readable name for the administrator. Example: ``John Smith``.

   ``credential`` (required)
      Credential for the administrator account. Example: ``s3cr3t``.

   ``email`` (required)
      Contact e-mail for the administrator. Example: ``admin@family.example.org``.

``ssl`` (optional)
   This section is optional. If provided, UBOS will set up the site to be only
   accessible via HTTPS. UBOS will also automatically redirect incoming HTTP requests
   to their HTTPS equivalent. (See also :doc:`/users/ssl-site`.)

   ``key`` (required)
      The key for the ssl site.

   ``crt`` (required)
      The certificate for the ssl site as issued by your certificate authority.

   ``crtchain`` (required)
      The certificate chain of your certificate authority, which provides
      credibility not to you, but to your certificate authority, which signed
      your certificate.

   ``cacrt`` (optional)
      If you use SSL client authentication (not common), the certificate chain
      of the certificate authorities that your SSL clients are using.

``wellknown`` (optional)
   This section is optional. It contains the data for well-known files that your
   site may be using.

   ``robotstxt`` (optional)
      The content of this field will be served as ``robots.txt`` at the root
      of your site.

   ``sitemapxml`` (optional)
      The content of this field will be served as ``sitemap.xml`` at the root
      of your site.

   ``faviconicobase64`` (optional)
      This contains the base64-encoded favicon for your site. UBOS will decode
      the base64, and serve the result as ``favicon.ico`` at the root of your
      site.

``appconfigs``:
   A JSON array of the AppConfigurations at this site. There is no significance to
   the order of the elements in the array. An AppConfiguration is
   the installation of an app at a particular context path at a particular site,
   together with any accessories and/or customization parameters that are
   specific to this installation of the app.

Each member of the ``appconfigs`` array is a JSON hash with the following entries:

``appconfigid`` (required)
   A unique identifier for the AppConfiguration. This is generally an ``a`` followed by
   40 hex characters. E.g. ``a7d74fb881d43d12ff0ba4bd2ed39a98e107eab8c``.

``context`` (optional)
   The context path, from the root of the site, where the AppConfiguration will run.
   For example, if you want to run Wordpress at ``http://example.org/blog``, the
   context path would be ``/blog`` (no trailing slash). If you want to run an app
   at the root of the site, specify an empty string. If this field is not provided,
   UBOS will use the default context from the :doc:`ubos-manifest`.

``isdefault`` (optional)
   If provided, the value must be boolean ``true``. This instructs UBOS to automatically
   redirect clients from the root page of the site to this AppConfiguration. If not
   provided, UBOS will show the installed apps at the root page of the site.

``appid`` (required)
   The package identifier of the app to be run. For example: ``wordpress``.

``accessoryids`` (optional)
   If provided, this entry must be a JSON array, containing one or more package
   identifiers of the accessories to be run for this installation of the app.
   For example: ``[ 'wordpress-plugin-webmention' ]``

``customizationpoints`` (optional)
   If provided, this entry must be a JSON hash, providing values for
   :doc:`customization points <manifest/customizationpoints>` of the app and/or
   accessories at this AppConfiguration. They keys in this
   JSON hash are the package names of the packages installed at this AppConfiguration,
   i.e. the package name of the app, and any additional accessories. (By doing this,
   there cannot be any namespace collisions between customization points defined
   in the app and the accessories).

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
