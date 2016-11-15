Glad-I-Was-Here (Java)
======================

The Java version of Glad-I-Was-Here is functionally equivalent to the
:doc:`PHP version <gladiwashere>`. However, it is implemented as Java servlets and
runs under Tomcat. If you have not already read through the :doc:`PHP version <gladiwashere>`
of Glad-I-Was-Here, we recommend you do so first.

This app runs using Tomcat. If you like to try it, it is recommended to try it
on a PC, and not an ARM device, as Tomcat requires substantial computing resources.

To obtain the source code:

.. code-block:: none

   > git clone https://github.com/uboslinux/ubos-toyapps

Go to subdirectory ``gladiwashere-java``.

Reverse proxy
-------------

From a user perspective, the technology used to implement a particular application that runs
on UBOS is totally irrelevant. We cannot require the user to access, say, Java apps at
a different port number than other apps installed on the same device, because this
makes no sense to the user.

Because of that, Java apps on UBOS are usually configured with Apache as a reverse
proxy in front of the Tomcat application server. Apache takes incoming requests at
port 80 or 443, and forwards them to Tomcat. This is what this app does as
well.

Package lifecycle and app deployment
------------------------------------

This app can, obviously, be built and deployed with a similar set of commands as
:doc:`helloworld` above:

.. code-block:: none

   > makepkg -f
   > sudo pacman -U gladiwashere-java-*-any.pkg.tar.xz
   > sudo ubos-admin createsite

Specify ``gladiwashere-java`` as the name of the app.

Manifest JSON
-------------

Let's examine this app's :term:`UBOS Manifest JSON` file. It is very similar to
``gladiwashere``'s, but has an additional entry for Tomcat:

.. code-block:: json

   {
       "type" : "app",

       "roles" : {
           "apache2" : {
               "defaultcontext" : "/guestbook",
               "apache2modules" : [
                   "proxy",
                   "proxy_ajp"
               ],
               "appconfigitems" : [
                   {
                       "type" : "file",
                       "name" : "${appconfig.apache2.appconfigfragmentfile}",
                       "template"     : "tmpl/htaccess.tmpl",
                       "templatelang" : "varsubst"
                   }
               ]
           },
           "tomcat8" : {
               "defaultcontext" : "/guestbook",
               "appconfigitems" : [
                   {
                       "type"         : "file",
                       "name"         : "${appconfig.tomcat8.contextfile}",
                       "template"     : "tmpl/context.xml.tmpl",
                       "templatelang" : "varsubst"
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

Let's first note what is the same as in the PHP version:

* The ``type`` is ``app`` for both, of course.

* The ``defaultcontext`` is the same.

* The entire ``mysql`` section is the same, including database permissions and
  database initialization.

Here are the differences:

* Apache now needs to use modules ``proxy`` and ``proxy_ajp``, which allow Apache to
  talk to Tomcat using the `AJP protocol <https://en.wikipedia.org/wiki/Apache_JServ_Protocol>`_.
  Because there is no more PHP involved, the Apache PHP modules are not needed any more.

* Instead of having the PHP files as ``appconfigitems``, there is only one Apache
  configuration fragment file that configures Apache as a reverse proxy. This file is
  in the package as a template, so UBOS can correctly parameterize it for the particular
  AppConfiguration (see below).

* There's a new ``tomcat8`` section which configures Tomcat. All that's needed here is
  a Tomcat "context file", which again is parameterized (see below).

Note that there are no commands required to install or start Tomcat; UBOS does this
automatically when it notices that a Java app is about to be deployed.

Apache reverse proxy configuration
----------------------------------

The Apache reverse proxy configuration is quite straightforward:

.. code-block:: none

   ProxyPass /robots.txt !
   ProxyPass /favicon.ico !
   ProxyPass /sitemap.xml !
   ProxyPass /.well-known !

   ProxyPass ${appconfig.contextorslash} ajp://127.0.0.1:8009${appconfig.contextorslash}
   ProxyPassReverse ${appconfig.contextorslash} ajp://127.0.0.1:8009${appconfig.contextorslash}

At deployment time, UBOS will replace the variables in this template and save the
resulting file as ``.htaccess`` in the web server directory, such as:

.. code-block:: none

   ProxyPass /guestbook ajp://127.0.0.1:8009/guestbook
   ProxyPassReverse /guestbook ajp://127.0.0.1:8009/guestbook

Apache requires both of those statements, see the
`Apache documentation <https://httpd.apache.org/docs/2.2/mod/mod_proxy.html>`_.

The four lines at the beginning declare that ``robots.txt``, ``favicon.ico``, ``sitemap.xml``
and ``.well-known`` shall not be mapped to the application if the application runs at the root of
the site. This allows the Site JSON entries for the content of those files to continue to be used.

Tomcat context file
-------------------

Tomcat also needs to be told which app to run, and which parameters to pass to it.
This is accomplished with the following template:

.. code-block:: none

   <?xml version="1.0" encoding="UTF-8"?>
   <Context path="${appconfig.context}"
            antiResourceLocking="true"
            cookies="false"
            docBase="${package.codedir}/lib/gladiwashere-java.war">

     <Loader className="org.diet4j.tomcat.TomcatModuleLoader"
                        rootmodule="gladiwashere-java"/>

     <Resource auth="Container"
               type="javax.sql.DataSource"
               driverClassName="com.mysql.jdbc.Driver"
               name="jdbc/maindb"
               url="jdbc:mysql://${appconfig.mysql.dbhost.maindb}/${appconfig.mysql.dbname.maindb}"
               username="${appconfig.mysql.dbuser.maindb}"
               password="${escapeDquote( appconfig.mysql.dbusercredential.maindb )}"
               maxActive="20"
               maxIdle="10"
               maxWait="-1"/>
   </Context>

Upon deployment, UBOS will have replaced the variables, and provided it to Tomcat, for
example:

.. code-block:: none

   <?xml version="1.0" encoding="UTF-8"?>
   <Context path="/guestbook"
            antiResourceLocking="true"
            cookies="false"
            docBase="/usr/share/gladiwashere-java/lib/gladiwashere-java.war">

    <Loader className="org.diet4j.tomcat.TomcatModuleLoader"
                       rootmodule="gladiwashere-java"/>

     <Resource auth="Container"
               type="javax.sql.DataSource"
               driverClassName="com.mysql.jdbc.Driver"
               name="jdbc/maindb"
               url="jdbc:mysql://127.0.0.1/somedb"
               username="someuser"
               password="somepass"
               maxActive="20"
               maxIdle="10"
               maxWait="-1"/>
   </Context>

For details on how to configure Tomcat, see the
`Tomcat documentation <https://tomcat.apache.org/tomcat-8.0-doc/config/context.html>`_.

This app is now using the `diet4j module management framework <http://diet4j.org/>`_
so Java apps fit more nicely into UBOS package management. As a result, this
Tomcat app uses the diet4j ``TomcatModuleLoader`` to load its code, instead of
the default Tomcat loader.

Instead of a giant WAR containing all dependencies, this app only ships its own
code and installs it into ``/usr/lib/java`` where diet4j can find it and its
dependent modules at run-time. See this line in the ``PKGBUILD`` file:

.. code-block:: none

   # Code
     install -m644 -D ${startdir}/maven/target/${pkgname}-${pkgver}.war \
                      ${pkgdir}/usr/lib/java/${_groupId//.//}/${pkgname}/${pkgver}/${pkgname}-${pkgver}.war

which basically says: take the generated (thin) ``.war`` file, and put it into
``/usr/lib/java/net/ubos/ubos-toyapps/gladiwashere-java/<version>/gladiwashere-java-<version>.war``.
