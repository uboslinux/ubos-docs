A more complex deployment example
=================================

In the real world, apps and sites tend to be more complex than the ones discussed
in :doc:`toyapps`. Let's look at one such example, and dissect what happens in
detail when such a site is deployed.

In this example, we deploy a TLS-encrypted site as it might be used by a small
business: it runs a public website, using Wordpress, with an additional plugin. It
also runs Nextcloud for the company's filesharing and calendaring needs,
with the Redis cache and calendar accessories. The main site is going
to be at ``https://example.com/``. In the real world, we would probably also set up a
site at ``https://www.example.com/`` that runs the Redirect app to redirect to the
main site, but we won't discuss this here.

The :term:`Site JSON` file for ``example.com`` might look as follows:

.. code-block:: json

   {
       "hostname" : "example.com",
       "siteid" : "s6641ad1b780d2330247896c0fe74438fb1e19a33",
       "tls" : {
           "letsencrypt" : true
       },
       "appconfigs" : [
           {
              "appid" : "wordpress",
              "context" : "/blog",
              "appconfigid" : "a5830f84d072d95001a272ab7a5ee2866f93972d0",
              "accessoryids" : [
                  "wordpress-plugin-photo-dropper"
              ]
           },
           {
               "appid" : "nextcloud",
               "context" : "/nextcloud",
               "appconfigid" : "a3e2e73410ad9a09fa82794783cd76eb602276736",
               "accessoryids" : [
                   "nextcloud-calendar",
                   "nextcloud-cache-redis"
               ]
           }
       ]
   }

Some observations about this site:

* UBOS needs to obtain a TLS certificate from LetsEncrypt. Because letsencrypt.org
  performs a callback to the website, UBOS needs to temporarily stage certain files
  with the web server that, obviously, should not conflict with any apps installed
  at the same site.
* After the files for Wordpress and the Wordpress plugin have been put in the right
  places, the Wordpress plugin needs to be automatically activated by Wordpress.
* Similarly, after the files for Nextcloud and the Nextcloud accessories have been
  put in the right places, the accessories need to be activated in Nextcloud as
  Nextcloud apps.
* The Redis cache accessory just provides a connector a running Redis daemon (Redis).
  This deamon needs to be started and stopped at the right times.
* A unique password needs to be generated that's used to communicate between
  the Nextcloud Redis cache extension, and the Redis daemon.

Let's assume we have the above :term:`Site JSON` file saved to ``example.com.json``.
Then we deploy the site with:

.. code-block:: none

   > sudo ubos-admin deploy --file example.com.json

Here is what happens in detail:

#. Check the :term:`Site JSON` file:

   #. It is syntactically correct.

   #. It contains all required fields with syntactically valid values.

   #. It can be deployed to the device:

      #. The ``hostname`` of the new site does not conflict with existing ones.

      #. None of the :term:`AppConfigIds <AppConfigId>` conflicts with an existing one
         (the :term:`SiteId` is not checked for conflicts, as it is perfectly valid to
         redeploy an already-deployed :term:`Site`, potentially with a different
         configuration).

   #. Whether it is a new :term:`Site`, or an update of an already-existing
      :term:`Site`. We won't discuss the latter here as it makes things even more
      complex.

#. Set a flag that prevents other, concurrent invocations of ``ubos-admin``.

#. Download and install needed packages:

   #. Download and install the :term:`App` and :term:`Accessory` :term:`Packages <Package>`
      referenced in the :term:`Site JSON` file, and their package dependencies. In our
      example, they are: ``wordpress``, ``wordpress-plugin-photo-dropper``, ``nextcloud``,
      ``nextcloud-calendar``, ``nextcloud-cache-redis``, and dependencies such as
      ``php`` and ``redis``.

   #. Now that the :term:`Apps <App>` and :term:`Accessories <Accessory>` have been
      downloaded and installed, UBOS can examine their respective
      :term:`UBOS Manifests <UBOS Manifest>`. First, UBOS downloads and installs the
      :term:`Packages <Package>` (and their package dependencies)
      listed as dependencies in the various (applicable) roles sections in the
      :term:`UBOS Manifests <UBOS Manifest>` of all the :term:`Apps <App>` and
      :term:`Accessories <Accessory>`. Here: from Wordpress: ``php``, ``php-apache``;
      nothing from the Photo Dropper :term:`Accessory`; from Nextcloud: ``php-apache``,
      ``php-apcu``, ``php-gd``, ``sudo``, ``php-systemd``; from the Redis cache
      :term:`Accessory`: ``php-redis``.

#. Check the semantics of the intended configuration. This can only be done now that
   the :term:`UBOS Manifests <UBOS Manifest>` are available:

   #. The :term:`AppConfigurations <AppConfiguration>` at the same :term:`Site` may not
      be deployed to conflicting :term:`Context Paths <Context Path>`. Here we have
      ``/blog`` (for Wordpress) and ``/nextcloud`` (for Nextcloud), which is fine.

   #. Values for all required :term:`customization points <Customization Point>`
      have been provided, or have defaults. Here, the value for the Wordpress blog's
      title is taken from the default specified in the :term:`UBOS Manifest` of
      :term:`App` Wordpress, and the Redis password for the Nextcloud Redis cache
      is automatically generated because a random password generation expression has
      been specified  in the :term:`UBOS Manifest` of the Redis cache :term:`Accessory`.

   #. Values of the :term:`Customization Points <Customization Point>` are valid
      according to the constraints specified in the respective :term:`UBOS Manifest`.

   #. The :term:`Accessories <Accessory>` specified in the :term:`AppConfiguration` can be
      used with the :term:`App` in that same :term:`AppConfiguration`. This would catch,
      for example, if the :term:`Site JSON` file specified that the Nextcloud Redis cache
      was supposed to be used with Wordpress instead of Nextcloud.

   #. The :term:`UBOS Manifest` of all :term:`Apps <App>` and :term:`Accessories <Accessory>`
      is valid. This includes checks for:

      #. Syntactic correctness.

      #. Semantic correctnes.

      #. The files mentioned in the :term:`UBOS Manifest` actually exist in the
         file system. This would catch, for example, if the script to activate a Wordpress
         plugin, contained in the Wordpress package, had been renamed in a recent package
         update, but an :term:`Accessory` depending on it hadn't been updated and was still
         referencing the old location.

      #. If an :term:`Accessory` requires the presence of another :term:`Accessory` at the
         same :term:`AppConfiguration` per its :term:`UBOS Manifest`, check that it
         is actually present (this does not apply in our example and is rare; an
         example would we a Wordpress theme, packaged as an :term:`Accessory` that is a
         child theme of another Wordpress theme, packaged as a separate
         :term:`Accessory`).

#. As this is the deployment of a new :term:`Site`, no existing :term:`Site` needs to be
   suspended.

#. Set up a placeholder :term:`Site` at the same hostname:

   #. Create an Apache configuration file for this virtual host whose document directory
      is the "maintenance" document directory

   #. Restart Apache.

#. Obtain the LetsEncrypt certificate:

   * Invoke the ``certbot`` program to create a TLS keypair, and have LetsEncrypt issue
     a certificate for it.

#. Deploy the :term:`Site`:

   #. Create the directories needed by Apache2 for this :term:`Site`.

   #. Process all :term:`AppConfigurations <AppConfiguration>`:

      #. For the Wordpress :term:`AppConfiguration`:

         #. Create the directory ``blog`` below the :term:`Site`'s Apache document root
            directory.

         #. First process :term:`App` Wordpress:

            #. Save the ``title`` :term:`Customization Point` to a file with a well-known
               location so the ``${installable.customizationpoints.title.file}`` variable
               can be resolved later.

            #. Process all :term:`AppConfigItems <AppConfigItem>` for the ``mysql``
               :term:`Role`: of :term:`App` Wordpress:

               #. Provision a new MySQL database.

               #. Provision a new MySQL database user and give it all privileges to the
                  newly provisioned MySQL database.

            #. Create a symbolic link in the Apache modules directory so Apache will
               load the ``ssl`` Apache module upon restart.

            #. Create a symbolic link each in the Apache modules directory so Apache will
               load all Apache modules upon restart that are specified in Wordpress's
               :term:`UBOS Manifest`: ``php7`` and ``rewrite``.

            #. Create a file each in the PHP modules directory so Apache's PHP module
               will load all PHP modules specified in Wordpress's
               :term:`UBOS Manifest`: ``gd``, ``iconv``, ``mysqli`` and ``pdo_mysql``.

            #. Process all :term:`AppConfigItems <AppConfigItem>` for the ``apache2``
               :term:`Role`: of :term:`App` Wordpress, in sequence. This includes:

               * Recursively copy directory trees to the ``/blog`` subdirectory of the
                 :term:`Site`'s Apache document root.

               * Create directories relative to the ``/blog`` subdirectory of the
                 :term:`Site`'s Apache document root.

               * Run the ``wp-config.pl`` file that generates the ``wp-config.php`` file
                 below the ``/blog`` subdirectory of the :term:`Site`'s Apache document root.

               * Copy the two ``htaccess`` files to below the ``/blog`` subdirectory of the
                 :term:`Site`'s Apache document root, while replacing the variables contained
                 in them.

         #. Now process :term:`Accessory` Photo Dropper:

            #. Process the single :term:`AppConfigItem` for the ``apache2``
               :term:`Role`: of :term:`Accessory` Photo Dropper:

               #. Recursively copy its files into ``wp-plugins`` subdirectory below the
                  Wordpress installation

      #. For the Nextcloud :term:`AppConfiguration`:

         #. Create the directory ``nextcloud`` below the :term:`Site`'s Apache document
            root directory.

         #. First process :term:`App` Nextcloud:

            #. Process all :term:`AppConfigItems <AppConfigItem>` for the ``mysql``
               :term:`Role`: of :term:`App` Nextcloud:

               #. Provision a new MySQL database.

               #. Provision a new MySQL database user and give it all privileges to the
                  newly provisioned MySQL database.

            #. Create a symbolic link each in the Apache modules directory so Apache will
               load all Apache modules upon restart that are specified in Nextcloud's
               :term:`UBOS Manifest`: ``php7``, ``rewrite``, ``headers``, ``env`` and
               ``setenvif``.

            #. Create a file each in the PHP modules directory so Apache's PHP module
               will load all PHP modules specified in Nextcloud's
               :term:`UBOS Manifest`: ``apcu``, ``gd``, ``iconv``, ``mysqli``,
               ``pdo_mysql`` and ``systemd``.

            #. Process all :term:`AppConfigItems <AppConfigItem>` for the ``apache2``
               :term:`Role`: of :term:`App` Nextcloud, in sequence. This includes:

               * Recursively copy directory trees to the ``/nextcloud`` subdirectory of the
                 :term:`Site`'s Apache document root.

               * Create directories relative to the ``/nextcloud`` subdirectory of the
                 :term:`Site`'s Apache document root.

               * Copy files while replacing the variables contained in them.

               * Run the Perl script ``fix-permissions.pl``

               * Start the Systemd timer that runs the Nextcloud background process.

         #. Now process :term:`Accessory` Nextcloud Calendar:

            #. Process the single :term:`AppConfigItem` for the ``apache2``
               :term:`Role`: of :term:`Accessory` Nextcloud Calendar:

               * Recursively copy its files into ``apps`` subdirectory below the
                 Nextcloud installation.

         #. Now process :term:`Accessory` Nextcloud Redis Cache:

            #. Create a file each in the PHP modules directory so Apache's PHP module
               will load all PHP modules specified in Nextcloud Redis Cache's
               :term:`UBOS Manifest`: ``redis`` and ``igbinary``.

            #. Process all :term:`AppConfigItems <AppConfigItem>` for the ``apache2``
               :term:`Role`: of :term:`Accessory` Nextcloud Redis Cache, in sequence.
               This includes:

               * Create directories below the :term:`AppConfiguration`'s data directory.

               * Copy the Redis configuration file into the right place, while
                 replacing the variables contained in them (e.g.
                 ``${appconfig.appconfigid}``, which uniquely identifies this Nextcloud
                 installation from any other running on the same :term:`Device`, thus
                 allowing multiple Redis daemons to coexist on the same machine)

               * Start a :term:`AppConfiguration`-specific Redis Systemd service.

   #. Save the :term:`Site JSON` file so ``ubos-admin`` can find the configuration again.

   #. Invoke the hostname callbacks for this :term:`Site`. This depends on which are
      installed on the :term:`Device`, but always includes:

      * Add the hostname of the :term:`Site` to the ``/etc/hostname`` file, resolving
        to the local IP address.

#. Run the installers:

   #. Run the installers for the Wordpress installation:

      #. According to Wordpress's :term:`UBOS Manifest`, run ``initialize.pl``,
         which in turn invokes Wordpress's installer script, so the user does not have to
         run it from the browser.

      #. According to Photo Dropper's :term:`UBOS Manifest`, run ``activate-plugin.pl``
         (which is actually contained in the Wordpress :term:`Package`) in order to
         activate the installed plugin, so the user does not have run it from the browser.
         As this script is invoked with the context of the :term:`Accessory`'s variables,
         no arguments need to be specified.

   #. Run the installers for the Nextcloud installation:

      #. According to Nextcloud's :term:`UBOS Manifest`, run ``install.pl``, which in
         turn runs various Nextcloud command-line commands to initialize the Nextcloud
         installation correctly. For example, it sets up logging to the system journal
         instead of the default log file.

      #. According to Nextcloud Calendar's :term:`UBOS Manifest`, run ``activate-app.pl``
         (which is actually contained in the Nextcloud :term:`Package`) in order to
         activate the installed :term:`Accessory` (called "app" by the Nextcloud
         project), so the user does not have run it from the browser.

      #. According to Nextcloud Redis Cache's :term:`UBOS Manifest`, run
         ``activate-deactivate.pl``, which in turn runs various Nextcloud command-line
         commands to configure the Nextcloud installation to use the correct Redis
         instance.

#. Update the open ports if needed. Neither Wordpress nor Nextcloud open any non-standard
   ports, but if an :term:`App` or :term:`Accessory` requested to open up a port,
   UBOS would reconfigure its firewall to permit this.

#. Resume the :term:`Site`:

   #. Update the Apache virtual host configuration:

      #. Save "well-known" files, like ``robots.txt`` (none specified in the example).

      #. Create the Apache virtual host configuration file.

      #. Restart Apache.

Perhaps a good time to state that as a developer, you very rarely really have to
know all of this :-)

