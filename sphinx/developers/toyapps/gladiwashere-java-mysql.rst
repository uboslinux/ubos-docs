Glad-I-Was-Here (Java, MySQL)
=============================

The Java version of Glad-I-Was-Here is functionally equivalent to the
:doc:`PHP/MySQL version <gladiwashere-php-mysql>`. However, it is implemented using Java
servlets and runs under Tomcat. It also uses `diet4j <http://diet4j.org/>`_ for
module management.

If you have not already read through the :doc:`PHP/MySQL version <gladiwashere-php-mysql>`
of Glad-I-Was-Here, we recommend you do so first as we'll only discuss things in this
section that were not covered before.

This :term:`App` runs using Tomcat. If you like to try it, it is recommended to try it
on a PC, and not an ARM device, as Tomcat requires substantial computing resources.

To obtain the source code:

.. code-block:: none

   % git clone https://github.com/uboslinux/ubos-toyapps

Go to subdirectory ``gladiwashere-java-mysql``.

Reverse proxy
-------------

From a user perspective, the technology used to implement a particular application that
runs on UBOS is totally irrelevant. We cannot require the user to access, say, Java :term:`Apps <App>`
at a different port number than other :term:`Apps <App>` installed on the same device, because this
makes no sense to the user.

Because of that, Java :term:`Apps <App>` on UBOS are usually configured with Apache as a reverse
proxy in front of the Tomcat application server. Apache takes incoming requests at
port 80 or 443, and forwards them to Tomcat. This is what this :term:`App` does as
well.

Package lifecycle and App deployment
------------------------------------

Like all other :term:`Apps <App>` on UBOS including :doc:`helloworld`, ``gladiwashere-java-mysql`` is built
with ``makepkg``, installed with ``pacman`` and deployed with ``ubos-admin``.

.. code-block:: none

   % makepkg -f
   % sudo pacman -U gladiwashere-java-mysql-*-any.pkg.tar.xz
   % sudo ubos-admin createsite

Specify ``gladiwashere-java-mysql`` as the name of the :term:`App`.

Manifest JSON
-------------

Let's examine this :term:`App`'s :term:`UBOS Manifest JSON` file. It is very similar to
``gladiwashere-php-mysql``'s, but has an additional role entry for Tomcat:

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
  :term:`AppConfiguration` (see below).

* There's a new ``tomcat8`` section which configures Tomcat. All that's needed here is
  a Tomcat "context file", which again is parameterized (see below).

Note that there are no commands required to install or start Tomcat; UBOS does this
automatically when it notices that a Java :term:`App` is about to be deployed.

Apache reverse proxy configuration
----------------------------------

The Apache reverse proxy configuration is quite straightforward:

.. code-block:: none

   ProxyPass /robots.txt !
   ProxyPass /favicon.ico !
   ProxyPass /sitemap.xml !
   ProxyPass /.well-known !
   ProxyPass /_common !
   ProxyPass /_errors !

   ProxyPass ${appconfig.contextorslash} ajp://127.0.0.1:8009${appconfig.contextorslash}
   ProxyPassReverse ${appconfig.contextorslash} ajp://127.0.0.1:8009${appconfig.contextorslash}

At deployment time, UBOS will replace the variables in this template and save the
resulting file as ``.htaccess`` in the web server directory, such as:

.. code-block:: none

   ProxyPass /robots.txt !
   ProxyPass /favicon.ico !
   ProxyPass /sitemap.xml !
   ProxyPass /.well-known !
   ProxyPass /_common !
   ProxyPass /_errors !

   ProxyPass /guestbook ajp://127.0.0.1:8009/guestbook
   ProxyPassReverse /guestbook ajp://127.0.0.1:8009/guestbook

Apache requires both of those statements, see the
`Apache documentation <https://httpd.apache.org/docs/2.2/mod/mod_proxy.html>`_.

The four lines at the beginning declare that ``robots.txt``, ``favicon.ico``, ``sitemap.xml``
and ``.well-known`` shall not be mapped to the application if the application runs at the root of
the :term:`Site`. This allows the Site JSON entries for the content of those files to continue to be used.

Similarly, line 5 and 6 keep UBOS' HTTP error pages instead of delegating them to the
application. For example, if I user were to access a URL that does not exist, the UBOS
404 error page will be shown.

Tomcat context file
-------------------

Tomcat also needs to be told which :term:`App` to run, and which parameters to pass to it.
This is accomplished with the following template:

.. code-block:: xml

   <?xml version="1.0" encoding="UTF-8"?>
   <Context path="${appconfig.context}"
            antiResourceLocking="true"
            cookies="false"
            docBase="${package.codedir}/lib/gladiwashere-java-mysql.war">

     <Loader className="org.diet4j.tomcat.TomcatModuleLoader"
                        rootmodule="gladiwashere-java-mysql"/>

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

.. code-block:: xml

   <?xml version="1.0" encoding="UTF-8"?>
   <Context path="/guestbook"
            antiResourceLocking="true"
            cookies="false"
            docBase="/ubos/share/gladiwashere-java-mysql/lib/gladiwashere-java-mysql.war">

    <Loader className="org.diet4j.tomcat.TomcatModuleLoader"
                       rootmodule="gladiwashere-java-mysql"/>

     <Resource auth="Container"
               type="javax.sql.DataSource"
               driverClassName="com.mysql.jdbc.Driver"
               name="jdbc/maindb"
               url="jdbc:mysql://127.0.0.1/somedb"
               username="someuser"
               password="somepass"
               maxTotal="20"
               maxIdle="10"
               maxWaitMillis="-1"/>
   </Context>

For details on how to configure Tomcat, see the
`Tomcat documentation <https://tomcat.apache.org/tomcat-8.0-doc/config/context.html>`_.

This :term:`App` is now using the `diet4j module management framework <http://diet4j.org/>`_
so Java :term:`Apps <App>` fit more nicely into UBOS package management. As a result, this
Tomcat :term:`App` uses the diet4j ``TomcatModuleLoader`` to load its code, instead of
the default Tomcat loader.

Instead of a giant WAR containing all dependencies, this :term:`App` only ships its own
code and installs it into ``/usr/lib/java`` where diet4j can find it and its
dependent modules at run-time. See this line in the ``PKGBUILD`` file:

.. code-block:: none

   # Code
   install -D -m0644 ${startdir}/maven/target/${pkgname}-${pkgver}.war \
                     ${pkgdir}/ubos/lib/java/${_groupId//.//}/${pkgname}/${pkgver}/${pkgname}-${pkgver}.war

which basically says: take the generated (thin) ``.war`` file, and put it into
``/ubos/lib/java/net/ubos/ubos-toyapps/gladiwashere-java-mysql/<version>/gladiwashere-java-mysql-<version>.war``.
