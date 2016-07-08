Tips and tricks for development
===============================

This sections collects a few tips and tricks for development of apps on UBOS
that we have found useful.

Rapid create/test cycle for UBOS packages
-----------------------------------------

It's important to be able to test UBOS packages in development quickly. Here's
the setup we use:

* As recommended, use an Arch Linux development host with the UBOS Arch tools
  installed (see :doc:`install-arch`)

* Run UBOS in a container started from the development host (see
  :doc:`../users/installation/x86_container`). It may be advantageous to
  bind your home directory into the container, for example by adding
  ``--bind /home/joe`` to the ``systemd-nspawn`` command that starts the
  container.

* Determine the container's IP address and point a friendly hostname to it.
  In the container::

     > ip addr

  On the host, add a line like this::

     10.0.0.2 testhost

  to your ``/etc/hosts`` file, assuming the container has IP address
  ``10.0.0.2``.

* Install your in-development package in the container. If you have used the
  ``--bind`` option described above, in the container::

     > sudo pacman -U --noconfirm /home/joe/path/to/your/package.pkg.xz

* Create a site with the hostname you picked, in the container that runs your app.
  In the container::

     > sudo ubos-admin createsite

  Specify the test host you picked above, and the name of your package.

* Use a browser on your host to access your app, e.g. at ``http://testhost/``.

* When you make changes to your package on the host, update that installed app
  in the container by repackaging, and deploying. On the host::

     > makepkg -f

  In the container::

     > sudo ubos-admin update --pkg /home/joe/path/to/your/package.pkg.xz

  Alternatively, you can use ``ubos-push`` if you set up ssh access for
  the ``shepherd`` account in the container. Then, on the host::

     > ubos-push -h testhost package.pkg.xz

Debugging a Java/Tomcat app
---------------------------

If you test your Java/Tomcat web app by running it in a UBOS container, the
following setup has proven to be useful:

1. In the container, have ``systemd`` start Tomcat with the debug flags on. To do
   so, say::

      > systemctl edit tomcat8

   and enter the following content::

      [Service]
      Environment='CATALINA_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,address=8888,server=y,suspend=n'

   Note the quotes.

   Then invoke ``systemctl restart tomcat8``. This will restart Tomcat and your app,
   but instead of running normally, it will wait for your IDE's debugger to connect on
   port 8888 before proceeding.

2. In the container, open port 8888 in the firewall so the debugger running on the
   host can connect to Tomcat::

      > vi /etc/iptables/iptables.rules

   Add the following line where similar lines are::

      -A OPEN-PORTS -p tcp --dport 8888 -j ACCEPT

   Restart the firewall: ``systemctl restart iptables``. Note that this setting
   will be overridden as soon as you invoke ``ubos-admin setnetconfig``, but that
   should not be an issue in a debug scenario.

3. On your host, attach your debugger to the container's port 8888. In NetBeans,
   for example, select "Debug / Attach Debugger", select "JDPA", "SocketAttach",
   "dt_socket", enter the IP address of your container and port 8888. For
   good measure, increase the timeout to 60000msec.
