Terms
=====

To avoid confusion, here is a glossary of terms that we use for UBOS.

.. glossary::

   appconfigid
      UBOS identifies each app installed at a particular site with a unique identifier,
      such as ``aa6b76deec72fc2e86c812372e5922b9533ca2d58``. UBOS commands that refer to a
      particular installation of an app generally require that the corresponding
      appconfigid is specified. This is particularly important if a device contains
      several installations of the same app at different virtual hostnames, for example.
      (See also :term:`siteid`.)

      To determine an appconfigid, execute::

         > sudo ubos-admin listsites

      Because this identifier is long and unwieldy, you can alternatively use
      only the first few characters in the appconfigid, as long as they are unique.
      For example, if there is no other app installed whose appconfigid starts with
      ``aa``, you can use ``aa`` as a shorthand to refer to this app installation.

   Arch Linux
      A rolling-release GNU/Linux distribution developed at
      http://archlinux.org/ and ported to various ARM architectures at
      http://archlinuxarm.org/

   Channel
      A maturity level for an UBOS release. See also :doc:`developers/buildrelease`.
      UBOS is developed on channel ``red``, which contains bleeding-edge,
      untested "alpha" quality code. Channel ``yellow`` corresponds to
      traditional "beta" code, while ``green`` is the production channel.
      End users almost always will subscribe to ``green``, while
      developers will do most of their work on ``red`` and ``yellow``.

   Device
      Any physical or virtualized computer running UBOS. This could be
      a Raspberry PI, an x86 server, an instance on Amazon EC2 or a virtual machine
      on your desktop with virtualization software such as VirtualBox.

   Repository
      A collection of :term:`packages <Package>`. For example, the UBOS
      ``tools`` repository contains tools useful to the developer, but
      not to the end user. By default, system do not use the ``tools``
      repository, but developers can easily add it to take advantage
      of the provided development tools.

   Package
      A set of code components that logically belong together. For example,
      the ``wordpress`` package contains all code specific to Wordpress.

   Rolling release
      Most operating system distros release a major release every couple of years with
      major new features, and then minor updates on a regular basis. A distro using
      rolling releases, such as UBOS, provides updates on a continuous basis without
      major jumps. This allows user devices to me more up-to-date more of the time,
      and avoids often error-prone major upgrades.

   Site
      Short for website; all the apps and functionality at the same hostname,
      e.g. virtual host. Sites are referred to by :term:`siteids <siteid>`.

   Site JSON
      A JSON file that contains all meta-data about a :term:`Site`, including
      hostname, which apps are installed at which relative URLs, and so forth.
      To obtain the Site JSON for a particular installed site with
      :term:`siteid` <siteid>, execute::

         > sudo ubos-admin showsite --json --siteid <siteid>

      To deploy or update a deployed site to the configuration contained in a
      Site JSON file called <site-json-file>, execute::

         > sudo ubos-admin deploy --file <site-json-file>

   siteid
      UBOS identifies :term:`sites <Site>` with a unique identifier, such as
      ``s4100f3ed79b845dc04a974c0144f5c5b2f81face``. UBOS commands that refer to a
      particular site generally require that the site's siteid is specified.
      (See also :term:`appconfigid`.)

      To determine a site's siteid, execute::

         > sudo ubos-admin listsites

      Because this identifier is long and unwieldy, you can alternatively use
      only the first few characters in the siteid, as long as they are unique.
      For example, if there is no other site installed whose siteid starts with
      ``s41``, you can use ``s41`` as a shorthand to refer to this site.

      Many commands also accept the hostname of the site instead of the siteid.

   UBOS manifest json
      A JSON file that contains meta-data about an app or accessory beyond the
      meta-data provided by PKGBUILD.
