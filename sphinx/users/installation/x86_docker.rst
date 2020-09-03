Run UBOS with Docker
====================

UBOS is available on the Docker hub. To run UBOS using Docker:

#. Make sure you have a reasonably recent Docker installation on your machine.

#. Boot UBOS with a command such as this:

   .. code-block:: none

      % docker run \
          -i -t \
          --cap-add NET_ADMIN --cap-add NET_BIND_SERVICE --cap-add NET_BROADCAST \
          --cap-add NET_RAW --cap-add SYS_ADMIN \
          -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
          -e container=docker \
          ubos/ubos-yellow \
          /usr/lib/systemd/systemd

   While that looks somewhat intimidating, all this command really says is: "Boot the image called
   ``ubos/ubos-yellow``, keep the terminal around, and give it the privileges it needs."

#. When the boot process is finished, login as root or  execute
   ``docker exec -i -t <name> /bin/bash`` or such in a separate terminal to obtain a root shell
   in the container.

#. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take 5 or 10 minutes
   on slower platforms. To determine whether UBOS ready, execute:

   .. code-block:: none

      % systemctl is-system-running

   The Docker container takes entropy from the host computer, so make sure the host Linux system
   provides enough. Depending your Linux distro, you may be able to generate more by
   typing on the keyboard, moving the mouse, generating hard drive activity etc. You can
   also run:

   .. code-block:: none

      % sudo systemctl start haveged

   on your host (not Docker container).

   Wait until the output of

   .. code-block:: none

      % systemctl is-system-running

   has changed from ``starting`` to ``running``. If it is anything else, consult
   :doc:`troubleshooting<../troubleshooting>`.

#. Your Docker container should automatically acquire an IP address. You can check with:

   .. code-block:: none

      % ip addr

   Make sure you are connected to the internet before attempting to proceed. If you
   have difficulties reaching the internet from your container, consult
   :doc:`troubleshooting<../troubleshooting>`.

#. Update UBOS to the latest and greatest:

   .. code-block:: none

      % sudo ubos-admin update

#. You are now ready to :doc:`set up your first app and site </users/firstsite>`. Note
   that with the private networking setup described on this page, you will only be able
   to access :term:`Apps <App>` installed in your UBOS container from the host computer. If you like to
   access them from anywhere else, you either need to give your container a non-private
   IP address, or port forward from the host to the container.

#. To shut down your Docker container, execute

   .. code-block:: none

      % systemctl poweroff

About that run command
-----------------------

If you are interested in the details of the complicated run command, let's unpack it:

+------------------------------------------+----------------------------------------------------------------+
| ``docker run``                           | Run a Docker image.                                            |
| ``-i -t``                                | Keep a terminal open on the command-line, so you can           |
|                                          | log into UBOS.                                                 |
+------------------------------------------+----------------------------------------------------------------+
| ``--cap-add NET_ADMIN ...``              | Grant certain needed capabilities to the container             |
|                                          | running UBOS. These are required so UBOS can manage            |
|                                          | networking using ``systemd-networkd`` and its firewall         |
|                                          | using ``iptables``.                                            |
+------------------------------------------+----------------------------------------------------------------+
| ``--v /sys/fs/cgroup:/sys/fs/cgroup:ro`` | Make the "cgroup" device hierarchy available to the            |
|                                          | container in read-only mode. This is needed so Docker          |
|                                          | can successfully boot an entire operating system like          |
|                                          | UBOS.                                                          |
+------------------------------------------+----------------------------------------------------------------+
| ``-e container=docker``                  | Tell UBOS that it is running under Docker.                     |
| ``ubos/ubos-yellow``                     | The UBOS version to download and to run. Here we run           |
|                                          | the most recent release of UBOS on the "yellow"                |
|                                          | `release channel </docs/glossary.html#term-release-channel>`_. |
|                                          | To see what UBOS versions are available via Docker,            |
|                                          | go to the                                                      |
|                                          | `Docker hub <https://hub.docker.com/u/ubos/>`_.                |
+------------------------------------------+----------------------------------------------------------------+
| ``/bin/init``                            | Boot the UBOS operating system, instead of running             |
|                                          | some other kind of command.                                    |
+------------------------------------------+----------------------------------------------------------------+

P.S. If you understand Docker better than we do, and there is a way of making the above
command-line shorter, please do `let us know </community/>`_. Thank you!
