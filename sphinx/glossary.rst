Terms
=====

To avoid confusion, here is a glossary of terms that we use for UBOS.

.. glossary::

   App
      On UBOS, an App is a software application that provides direct value to the user
      without any further additions, integrations or customizations. Apps generally
      have software dependencies only on packages provided as part of UBOS.

      UBOS Apps are typically web Apps, i.e. Apps whose primary user interface is
      presented using a web browser. Some examples for UBOS Apps are:

      * ​Wordpress (blogging and publishing)
      * A house monitoring application, accessible over http or https.

      Apps can generally be installed more than one on the same device, in
      multiple :term:`AppConfigurations <AppConfiguration>`. Middleware components
      (e.g. databases) are not considered Apps because the user generally does not
      directly interact with them.

   Accessory
      An Accessory on UBOS is a software module that adds to or modifies the
      functionality of an :term:`app`. Accessories includes things such as plugins,
      themes, skins, extensions, add-ons and the like. UBOS uses the term
      "Accessory" as a consistent, common term for all of those.

      Examples for what UBOS would call Accessories are:

      * themes or skins that change the graphic layout of Wordpress;
      * a module that requires users to fill out a captcha before they can register
        for a wiki;
      * a module that adds a Facebook Like button to an :term:`App`.

   AppConfigId
      UBOS identifies each :term:`App` installed at a particular :term:`Site` with a unique identifier,
      such as ``aa6b76deec72fc2e86c812372e5922b9533ca2d58``. UBOS commands that refer to a
      particular installation of an :term:`App` generally require that the corresponding
      AppConfigId is specified. This is particularly important if a device contains
      several installations of the same :term:`App` at different virtual hostnames, for example.
      (See also :term:`SiteId`.)

      To determine an AppConfigId, execute:

      .. code-block:: none

         % sudo ubos-admin listsites

      Because the AppConfigId is long and unwieldy, you can alternatively use
      only its first few characters, as long as they are unique on your host and you
      append three periods at the end.

      For example, if there is no other :term:`App` installed on your device whose AppConfigId
      starts with ``aa``, you can use ``aa...`` as a shorthand.

   AppConfiguration
      The installation of an :term:`App` at a particular :term:`Site` (aka virtual host) with a certain
      context path. For example, if a device runs two virtual hosts ``example.com``
      and ``example.net``, and Wordpress is installed at ``example.com/blog``, at
      ``example.com/notes`` and at the root of ``example.net/``, the host runs
      three Wordpress App Configurations. If can also run several other App Configurations
      for other :term:`Apps <App>`. Each of the AppConfigurations usually has its own database,
      data storage, list of :term:`Accessories <Accessory>` and customization parameters.

      App Configurations are identified through :term:`AppConfigIds <AppConfigId>`.

   AppConfigurationItem
      A file, directory, systemd service, database or other item that needs to be provisioned
      to deploy an :term:`AppConfiguration`. AppConfigurationItems are defined in an
      :term:`App` or :term:`Accessory`'s :term:`UBOS Manifest JSON`.

   Arch Linux
      A rolling-release GNU/Linux distribution developed at
      http://archlinux.org/ and ported to various ARM architectures at
      http://archlinuxarm.org/ .

   Customization point
      A variable whose value can be customized by the user. For example, an
      :term:`App` might allow the user to configure the title of the :term:`App` upon installation.
      In this case, it declares a customization point ``title`` in its manifest
      JSON. The user can specify a value for the customization point in their
      Site JSON. That way, each installation of the :term:`App` can have a different
      title, for example.

   Depot
      The site http://depot.ubos.net/ through which UBOS packages are distributed.
      The UBOS depot hosts several :term:`repositories <Repository>` in several
      :term:`release channels <Release channel>`.

   Device
      Any physical or virtualized computer running UBOS. This could be
      a Raspberry Pi, an x86 server, an instance on Amazon EC2 or a virtual machine
      on your desktop with virtualization software such as VirtualBox or VMWare.

   Flock
      See :term:`Shepherd`.

   Indie application
      A web application that can be installed on hardware, or on a hosting provider
      of the user's choosing. Contrast with a typical website were the user does not
      have this choice.

   Indie IoT
      The part of the `Internet of Things <https://en.wikipedia.org/wiki/Internet_of_Things>`_
      that is independently owned and operated. Contrast with "Overlord IoT".
      For example, the `NEST thermostat <http://nest.com/>`_ is not part of the
      Indie IoT (Google hermetically seals the device, and siphons
      the data before the "owner" of the device sees it), while a similar
      product that kept data local and allowed the owner to modify it at will would
      be part of the Indie IoT.

   Letsencrypt
      A certificate authority that provides free SSL/TLS certificates
      accepted by most browsers. See `<https://letsencrypt.org/>`_.

   Multicast DNS (mDNS)
      The `multicast DNS system <https://en.wikipedia.org/wiki/Multicast_DNS>`_ allows
      users to use certain human-friendly hostnames (like ``ubos-pc.local``) on local-area
      networks without having to configure DNS servers.

   Network Configuration
      In UBOS, a network configuration is a set of active network interfaces, their
      configuration, and the configuration of associated services such as DNS,
      firewall, and the like.

   Package
      A set of code components that logically belong together. For example,
      the ``wordpress`` package contains all code specific to Wordpress, but no code
      that might also be used by other packages.

   Personal server
      A computer that is primarily accessed over the network, and fully owned by the
      person who purchased it. For example, a Raspberry Pi running a web application that
      allows users to control the lights in their house from a web browser would be
      a Personal Server. As a counter-example, if users could control the lights in
      their house from a web browser connecting to some vendor's website, this may
      involve a "server" in their house, but not one they control.

   PKGBUILD
      The build script for creating a UBOS or Arch Linux package. The Arch Linux wiki
      has a `good description <https://wiki.archlinux.org/index.php/PKGBUILD>`_.

   Release channel
      A maturity level for an UBOS release. See also :doc:`developers/buildrelease`.
      UBOS is developed on channel ``red``, which contains bleeding-edge,
      untested "alpha" quality code. Channel ``yellow`` corresponds to
      traditional "beta" code, while ``green`` is the production channel.
      End users almost always will subscribe to ``green``, while
      developers will do most of their work on ``red`` and ``yellow``.

   Repository
      A collection of :term:`packages <Package>`. For example, the UBOS
      ``tools`` repository contains tools useful to the developer, but
      not to the end user. By default, system do not use the ``tools``
      repository, but developers can easily add it to take advantage
      of the provided development tools.

   Rolling release
      Most operating system distros release a major release every couple of years with
      major new features, and then minor updates on a regular basis. A distro using
      rolling releases, such as UBOS, provides updates on a continuous basis without
      major jumps. This allows user devices to be more up-to-date more of the time,
      and avoids often error-prone major upgrades.

   Shepherd
      The UBOS shepherd is the person who administers one or more devices running
      UBOS. These devices are called the flock. The Shepherd uses a USB stick, called
      the UBOS Staff, to configure the devices in the flock by booting the devices
      while the Staff has been inserted into the device's USB port. Configuration
      information picked up by the UBOS device will remain valid until the Shepherd
      reboots the device with the Staff present again.

   Site
      Short for website; all the :term:`Apps <App>` and functionality at the same hostname,
      e.g. virtual host. :term:`Sites <Site>` are referred to by :term:`SiteIds <SiteId>`.

   Site JSON
      A JSON file that contains all meta-data about a :term:`Site`, including
      hostname, which :term:`Apps <App>` are installed at which relative URLs, and so forth.
      To obtain the Site JSON for a particular installed :term:`Site` with
      :term:`SiteId` ``<siteid>``, execute:

      .. code-block:: none

         % sudo ubos-admin showsite --json --siteid <siteid>

      To deploy or update a deployed :term:`Site` to the configuration contained in a
      Site JSON file called ``<site-json-file>``, execute:

      .. code-block:: none

         % sudo ubos-admin deploy --file <site-json-file>

   SiteId
      UBOS identifies :term:`sites <Site>` with a unique identifier, such as
      ``s4100f3ed79b845dc04a974c0144f5c5b2f81face``. UBOS commands that refer to a
      particular :term:`Site` generally require that the :term:`Site`'s siteid is specified.
      (See also :term:`AppConfigId`.)

      To determine a :term:`Site`'s SiteId, execute:

      .. code-block:: none

         % sudo ubos-admin listsites

      Because the SiteIds is long and unwieldy, you can alternatively use
      only its first few characters, as long as they are unique on your host and you
      append three periods at the end.

      For example, if there is no other :term:`Site` installed on your host whose SiteId starts
      with ``s41``, you can use ``s41...`` as a shorthand.

      Many commands also accept the current hostname of the :term:`Site` instead of the SiteId.

   Staff
      See :term:`Shepherd`.

   UBOS manifest JSON
      A JSON file that contains meta-data about an :term:`App` or :term:`Accessory` beyond the
      meta-data provided by :term:`PKGBUILD`.
