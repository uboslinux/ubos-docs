Variables available at deploy or undeploy
=========================================

When an app or accessory is deployed or undeployed, the involved scripts, templates
and the Manifest JSON may refer to certain symbolic names.

See also :doc:`functions`.

Commonly-used variables
-----------------------

The following symbolic names are currently defined and commonly used by developers when
packaging their apps or accessories for UBOS:

``${apache2.gname}``
   Name of the Linux group used for running the Apache web server.
   This is convenient for setting ownership of files.

   Example: ``http``

``${apache2.uname}``
   Name of the Linux user account used for running the Apache web server.
   This is convenient for setting ownership of files.

   Example: ``http``

``${appconfig.apache2.appconfigfragmentfile}``
   The name of the Apache2 configuration fragment which may be written
   by this app configuration.

   Example: ``/etc/httpd/ubos/appconfigs/s753ca4a344f56c38aad05172dee6a53f6647af62/a9f52884fef255d617981fb0a94916bf67bcf64b5.conf``

``${appconfig.apache2.dir}``
   The directory in which Apache requires this app configuration's web server files.
   No trailing slash.

   Example: ``/srv/http/sites/s753ca4a344f56c38aad05172dee6a53f6647af62/blog`` (if the app configuration
   is at relative path ``/blog`` on a site with siteid ``s753ca4a344f56c38aad05172dee6a53f6647af62``)

``${appconfig.appconfigid}``
   The identifier of the app configuration as specified in the site JSON file.

   Example: ``a9f52884fef255d617981fb0a94916bf67bcf64b5``

``${appconfig.context}``
   Context path for this app configuration as specified in the site JSON file
   (or, if not given, the default from the manifest JSON).
   No trailing slash. The root context is a zero-length string.

   Examples: ``/blog`` or (empty string)

``${appconfig.contextnoslashorroot}``
   Context path for this app configuration as specified in the site JSON file.
   (or, if not given, the default from the manifest JSON), but without either
   leading or trailing slash. If root context, the string is ``ROOT``.
   This variable makes some Tomcat configuration statements easier.

   Examples: ``blog`` or ``ROOT``

``${appconfig.contextorslash}``
   Context path for this app configuration as specified in the site JSON file.
   (or, if not given, the default from the manifest JSON).
   No trailing slash. However, the root context is a single slash.
   This variable makes some Apache configuration statements easier that
   usually take a context path without trailing slash, but require a single
   slash when the context path would otherwise be empty.

   Examples: ``/blog`` or ``/``

``${appconfig.cronjobfile}``
   If this app configuration needs to define one or more cron jobs, this is
   the preferred filename it should use for this purpose.

   Example: ``/etc/cron.d/50-a9f52884fef255d617981fb0a94916bf67bcf64b5``

``${appconfig.datadir}``
   A directory in which this app configuration should preferably store data (outside of
   the webserver's DocumentRoot). No trailing slash. While this variable is pre-defined,
   the app is responsible for actually creating the directory in its Manifest JSON.

   Example: ``/var/lib/wordpress/a9f52884fef255d617981fb0a94916bf67bcf64b5``

``${appconfig.mysql.dbhost.maindb}``
   Database host for the MySQL database whose symbolic name in the Manifest JSON is ``maindb``.
   Replace ``maindb`` with the symbolic name you used in the Manifest JSON.

   Example: ``localhost``

``${appconfig.mysql.dbname.maindb}``
   Actual name of the MySQL database whose symbolic name in the manifest JSON
   is ``maindb``. Replace ``maindb`` with the symbolic name you used in the Manifest JSON.

   Example: ``database477``

``${appconfig.mysql.dbport.maindb}``
   Database port for the MySQL database whose symbolic name in the Manifest JSON is ``maindb``.
   Replace ``maindb`` with the symbolic name you used in the Manifest JSON.

   Example: ``3306``

``${appconfig.mysql.dbuser.maindb}``
   Database user for the MySQL database whose symbolic name in the Manifest JSON is ``maindb``.
   Replace ``maindb`` with the symbolic name you used in the Manifest JSON.

   Example: ``fred``

``${appconfig.mysql.dbusercredential.maindb}``
   Database password for the MySQL database whose symbolic name in the Manifest JSON is ``maindb``.
   Replace ``maindb`` with the symbolic name you used in the Manifest JSON.

   Example: ``n0ts0s3cr3t``

``${appconfig.postgresql.dbhost.maindb}``
   Database host for the Postgresql database whose symbolic name in the Manifest JSON is ``maindb``.
   Replace ``maindb`` with the symbolic name you used in the Manifest JSON.

   Example: ``localhost``

``${appconfig.postgresql.dbname.maindb}``
   Actual name of the Postgresql database whose symbolic name in the manifest JSON
   is ``maindb``. Replace ``maindb`` with the symbolic name you used in the Manifest JSON.

   Example: ``database477``

``${appconfig.postgresql.dbport.maindb}``
   Database port for the Postgresql database whose symbolic name in the Manifest JSON is ``maindb``.
   Replace ``maindb`` with the symbolic name you used in the Manifest JSON.

   Example: ``3306``

``${appconfig.postgresql.dbuser.maindb}``
   Database user for the Postgresql database whose symbolic name in the Manifest JSON is ``maindb``.
   Replace ``maindb`` with the symbolic name you used in the Manifest JSON.

   Example: ``fred``

``${appconfig.postgresql.dbusercredential.maindb}``
   Database password for the Postgresql database whose symbolic name in the Manifest JSON is ``maindb``.
   Replace ``maindb`` with the symbolic name you used in the Manifest JSON.

   Example: ``n0ts0s3cr3t``

``${appconfig.tomcat8.contextfile}``
   The name of the Tomcat8 context configuration file which may be written
   by this app configuration.

   Example: ``/etc/tomcat8/Catalina/example.com/ROOT.xml``

``${appconfig.tomcat8.dir}``
   The directory in which Tomcat requires this app configuration's application server
   files. No trailing slash.

   Example: ``/var/lib/tomcat8/sites/s753ca4a344f56c38aad05172dee6a53f6647af62/a9f52884fef255d617981fb0a94916bf67bcf64b5``

``${host.tmpdir}``
   Name of a directory in which to create temporary files. By using this symbolic
   name, the location of temporarily files can be moved to a partition that has
   sufficient space (say ``/var/tmp`` vs ``/tmp``) without impacting apps.

   Example: ``/var/tmp``

``${hostname}``
   Name of the current host as returned by the OS. This is often
   different from ``${site.hostname}``, which is a virtual host name
   for a site.

   Example: ``host-1-2-3-4.example.org``

``${installable.customizationpoints.foo.filename}``
   Name of a file that contains the value of customization point ``foo``
   for the app or accessory in this
   app configuration, as determined from the Manifest JSON file and the Site JSON file.

   Example: ``/var/lib/ubos/appconfigpars/a12345678901234567890/mypackage/foo``

``${installable.customizationpoints.foo.value}``
   The value of customization point ``foo``
   for the app or accessory in this
   app configuration, as determined from the Manifest JSON file and the Site JSON file.

   Example: ``My daily musings``

``${now.tstamp}``
   Timestamp when the current deployment or undeployment run started,
   in a human-readable, but consistently sortable string. Uses UTC time zone.

   Example: ``20140923-202018``

``${now.unixtime}``
   Timestamp when the current deployment or undeployment run started,
   in UNIX timestamp format.

   Example: ``1411503618``

``${package.codedir}``
  Directory in which the package's code should be installed. No trailing slash.

  Example: ``/usr/share/wordpress``

``${package.name}``
   Name of the package currently being installed.

   Example: ``wordpress``

``${site.admin.credential}``
   Password for the site's administrator account.

   Example: ``s3cr3t``

``${site.admin.email}``
   E-mail address of the site's administrator.

   Example: ``foo@bar.com``

``${site.admin.userid}``
   Identifier of the site's administrator account. This identifier does not contain
   spaces or special characters.

   Example: ``admin``

``${site.admin.username}``
   Human-readable name of the site's administrator account.

   Example: ``Site administrator (John Smith)``

``${site.apache2.authgroupfile}``
   The groups file for HTTP authentication for this site.

   Example: ``/etc/httpd/ubos/sites/s753ca4a344f56c38aad05172dee6a53f6647af62.groups``

``${site.apache2.htdigestauthuserfile}``
   The digest-based user file for HTTP authentication for this site.

   Example: ``/etc/httpd/ubos/sites/s753ca4a344f56c38aad05172dee6a53f6647af62.htdigest``

``${site.hostname}``
   The virtual hostname of the site to which this app configuration
   belongs. This is often different from ``${hostname}``, which is
   the current host as returned by the OS.

   Example: ``indiebox.example.org``

``${site.protocol}``
   The protocol by which this site is accessed. Valid values are
   ``http`` and ``https``.

   Example: ``http``

``${site.siteid}``
   The site identifier of this site per the Site JSON file.

   Example: ``s753ca4a344f56c38aad05172dee6a53f6647af62``

``${site.tomcat8.contextdir}``
   The Tomcat context directory for this site. No trailing slash.

   Example: ``/etc/tomcat8/Catalina/ubos.example.org``

``${tomcat8.gname}``
    Name of the Linux group used for running the Tomcat application server.
    This is convenient for setting ownership of files.

    Example: ``tomcat8``

``${tomcat8.uname}``
    Name of the Linux user account used for running the Tomcat application server.
    This is convenient for setting ownership of files.

    Example: ``tomcat8``

Other variables
---------------

While these symbolic names are defined, their use by developers is not usually required
and thus discouraged.

``${apache2.appconfigfragmentdir}``
   Directory that contains Apache configuration file fragments, one per app
   configuration. You may want to use ``${appconfig.apache2.appconfigfragmentfile}``
   instead.

   Example: ``/etc/httpd/ubos/appconfigs``

``${apache2.sitefragmentdir}``
   Directory that contains Apache configuration file fragments, one per site
   (aka virtual host). You may want to use ``${site.apache2.sitefragmentfile}``
   instead.

   Example: ``/etc/httpd/ubos/sites``

``${apache2.sitesdir}``
   Directory that contains the Apache DocumentRoots of the various sites installed on
   the host. You may want to use ``${site.apache2.sitedocumentdir}`` or
   ``${appconfig.apache2.dir}`` instead.

   Example: ``/srv/http/sites``

``${apache2.ssldir}``
   Directory that contains SSL information.

   Example: ``/etc/httpd/ubos/ssl``

``${package.datadir}``
   Directory in which the package can store data. No trailing slash.
   You may want to use ``${appconfig.datadir}`` instead.

   Example: ``/var/lib/wordpress``

``${package.manifestdir}``
   Directory in which packages write their manifests. No trailing slash. You should
   not need to use this.

   Value: ``/var/lib/ubos/manifests``

``${site.apache2.sitedocumentdir}``
   The Apache DocumentRoot for this site. No trailing slash.

   Example: ``/srv/http/sites/s753ca4a344f56c38aad05172dee6a53f6647af62``

``${site.apache2.sitefragmentfile}``
   The Apache configuration file fragment for this site. No trailing slash.
   You should not have to use this.

   Example: ``/etc/httpd/ubos/sites/s753ca4a344f56c38aad05172dee6a53f6647af62.conf``

``${site.tomcat8.sitedocumentdir}``
   The Tomcat DocumentRoot for this site. No trailing slash.

   Example: ``/var/lib/tomcat8/sites/s753ca4a344f56c38aad05172dee6a53f6647af62``

``${tomcat8.sitesdir}``
    Directory that contains the Tomcat DocumentRoots of the various sites installed on
    the host. You may want to use ``${site.tomcat8.sitedocumentdir}`` instead.

    Example: ``/var/lib/tomcat8/sites``
