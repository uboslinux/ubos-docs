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
  In the container:

  .. code-block:: none

     > ip addr

  On the host, add a line like this:

  .. code-block:: none

     10.0.0.2 testhost

  to your ``/etc/hosts`` file, assuming the container has IP address
  ``10.0.0.2``.

* Install your in-development package in the container. If you have used the
  ``--bind`` option described above, in the container:

  .. code-block:: none

     > sudo pacman -U --noconfirm /home/joe/path/to/your/package.pkg.xz

* Create a site with the hostname you picked, in the container that runs your app.
  In the container:

  .. code-block:: none

     > sudo ubos-admin createsite

  Specify the test host you picked above, and the name of your package.

* Use a browser on your host to access your app, e.g. at ``http://testhost/``.

* When you make changes to your package on the host, update that installed app
  in the container by repackaging, and deploying. On the host:

  .. code-block:: none

     > makepkg -f

  In the container:

  .. code-block:: none

     > sudo ubos-admin update --pkg /home/joe/path/to/your/package.pkg.xz

  Alternatively, you can use ``ubos-push`` if you set up ssh access for
  the ``shepherd`` account in the container. Then, on the host:

  .. code-block:: none

     > ubos-push -h testhost package.pkg.xz

Debugging a Java/Tomcat app
---------------------------

If you test your Java/Tomcat web app by running it in a UBOS container, the
following setup has proven to be useful:

1. In the container, have ``systemd`` start Tomcat with the debug flags on. To do
   so, say:

   .. code-block:: none

      > systemctl edit tomcat8

   and enter the following content:

   .. code-block:: none

      [Service]
      Environment='CATALINA_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,address=8888,server=y,suspend=n'

   Note the quotes.

   Then invoke ``systemctl restart tomcat8``. This will restart Tomcat and your app,
   but instead of running normally, it will wait for your IDE's debugger to connect on
   port 8888 before proceeding.

2. In the container, open port 8888 in the firewall so the debugger running on the
   host can connect to Tomcat:

   .. code-block:: none

      > vi /etc/iptables/iptables.rules

   Add the following line where similar lines are:

   .. code-block:: none

      -A OPEN-PORTS -p tcp --dport 8888 -j ACCEPT

   Restart the firewall: ``systemctl restart iptables``. Note that this setting
   will be overridden as soon as you invoke ``ubos-admin setnetconfig``, but that
   should not be an issue in a debug scenario.

3. On your host, attach your debugger to the container's port 8888. In NetBeans,
   for example, select "Debug / Attach Debugger", select "JDPA", "SocketAttach",
   "dt_socket", enter the IP address of your container and port 8888. For
   good measure, increase the timeout to 60000msec.

Using up a local depot
----------------------

Usually, a UBOS installation pulls software packages from ``http://depot.ubos.net/``.
However, during development and testing, it may be advantageous to run a local
depot on a build machine.

Setting up a depot container
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To set this up, follow these steps:

#. Go to the ``ubos-buildconfig`` directory.

#. Create an ssh keypair you will use to upload new packages to the depot, e.g.:

   .. code-block:: none

      mkdir local.ssh
      ssh-keygen

   Enter a filename such as ``local.ssh/id_rsa`` and no passphrase.

#. Create a systemd service file that will start the ``depot`` container correctly.
   Depending on your needs, you may use different values. Here is an example that
   uses the host's ``/home/buildmaster/UBOS-STAFF-DEPOT`` as the container's UBOS Staff, so
   you can log in via ssh afterwards. We save it as
   ``/etc/systemd/system/systemd-nspawn@depot.service``:

   .. code-block:: none

      # systemd .service file for starting a UBOS depot container, modify as needed
      # compare with /usr/lib/systemd/system/systemd-nspawn@.service

      [Unit]
      Description=Local UBOS depot
      Documentation=man:systemd-nspawn(1)
      PartOf=machines.target
      Before=machines.target
      After=network.target

      [Service]
      ExecStart=/usr/bin/systemd-nspawn --quiet --keep-unit --boot \
              --link-journal=try-guest --network-veth --machine=%I \
              --bind /home/buildmaster/UBOS-STAFF-DEPOT:/UBOS-STAFF
      KillMode=mixed
      Type=notify
      RestartForceExitStatus=133
      SuccessExitStatus=133
      Slice=machine.slice
      Delegate=yes

      # Enforce a strict device policy, similar to the one nspawn configures
      # when it allocates its own scope unit. Make sure to keep these
      # policies in sync if you change them!
      DevicePolicy=strict
      DeviceAllow=/dev/null rwm
      DeviceAllow=/dev/zero rwm
      DeviceAllow=/dev/full rwm
      DeviceAllow=/dev/random rwm
      DeviceAllow=/dev/urandom rwm
      DeviceAllow=/dev/tty rwm
      DeviceAllow=/dev/net/tun rwm
      DeviceAllow=/dev/pts/ptmx rw
      DeviceAllow=char-pts rw

      [Install]
      WantedBy=machines.target

#. Make sure the ``/home/buildmaster/UBOS-STAFF-DEPOT`` directory exists (if you chose the
   above configuration) and contains the following information:

   .. code-block:: none

       mkdir -p /home/buildmaster/UBOS-STAFF-DEPOT/shepherd/ssh
       ssh-keygen

   Specify ``/home/buildmaster/UBOS-STAFF-DEPOT/shepherd/ssh/id_rsa`` as the filename,
   and no password. You could reuse the above keypair, too, if you'd like to, but the
   ``id_rsa.pub`` file needs to be in that directory, so UBOS can configure the
   ``shepherd`` account correctly. (The private key doesn't need to be there.)

#. Boot a UBOS container that will become the local depot. This requires that you have
   a UBOS tarball available that you have downloaded. Let's assume we use
   ``ubos_dev_container-pc_LATEST.tar``:

   .. code-block:: none

      sudo machinectl import-tar ubos_dev_container-pc_LATEST.tar depot
      sudo machinectl start depot

#. Login as shepherd with the private key of the keypair whose public key ended up
   in the ``UBOS-STAFF`` directory:

   .. code-block:: none

      ssh shepherd@depot -i /home/buildmaster/UBOS-STAFF-DEPOT/shepherd/ssh/id_rsa

   and install a locally built ``ubos-depot`` package, unless you want the default from
   the default UBOS depot at ``http://depot.ubos.net/``. You may want a locally built version
   if the container you are booting uses an image you built yourself; otherwise version
   inconsistencies between standard UBOS and your build may occur.

   You can copy the package file from the host to the container with ``scp``, or
   ``machinectl copy-to``. Then, in the container:

   .. code-block:: none

      sudo pacman -U --noconfirm ...path...to.../ubos-repo...pkg.tar.xz

#. Set up the depot website:

   .. code-block:: none

      sudo ubos-admin createsite

   Enter ``ubos-repo`` as the name of the app, ``depot`` as the hostname, and paste the
   content of the host's ``local.ssh/id_rsa.pub`` (that you created earlier) into the
   field where it asks for a public upload ssh key. Pick whatever admin account information,
   it does not matter in this case.

#. You should now be able to reach ``http://depot/`` from the host. (Note: by default, the front
   page redirects to ``http://ubos.net/``) If you cannot reach it, check your container setup.
   On the host, as root:

   .. code-block:: none

      echo 0 > /proc/sys/net/ipv4/ip_forward
      echo 1 > /proc/sys/net/ipv4/ip_forward

   and make sure ``/etc/nsswitch.conf`` contains ``mymachines`` in the ``hosts`` section.

Uploading built packages to the local depot
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

On your Arch build machine, go back to the ``ubos-buildconfig`` directory. Edit (or create)
the ``local.mk`` file, so it has these lines:

.. code-block:: none

   UPLOADDEST=ubos-repo@depot:
   UPLOADSSHKEY=local.ssh/id_rsa

This will instruct make's ``upload`` target to upload packages and images to the host
``depot`` (i.e. the container you created above), using ``ubos-repo`` as the username, and
and the ssh key you created earlier. User ``ubos-repo`` was automatically created when you
installed package ``ubos-repo`` on the ``depot`` container. The upload will be performed
using ``rsync`` over ``ssh``; hence the syntax for ``UPLOADDEST``.
