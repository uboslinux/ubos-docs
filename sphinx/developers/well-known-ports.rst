Well-known ports for apps and accessories
=========================================

Some apps or accessories need to open up ports, such as:

* externally, e.g. for communications with the users' rich clients

* internally, e.g. so two daemons can communicate.

A further distinction is whether there needs to be:

* one port per :term:`AppConfiguration` (i.e. when the app is installed
  more than once on the same :term:`device`, each of them needs to have a
  separate port)

* one port shared by all :term:`AppConfigurations <AppConfiguration>` of the same
  app on the same :term:`device`. This is uncommon, but happens if all
  of them can talk to the same instance of a daemon like ``memcached`` without
  conflicts.

To allocate AppConfiguration-specific ports
-------------------------------------------

This is handled by :term:`AppConfigItems <AppConfigItem>` of type
``tcpport`` and ``udpport`` as documented in :doc:`manifest/roles`.

To allocate a single port used by all AppConfigurations of an app
-----------------------------------------------------------------

Please get `in touch <https://ubos.net/community/>`_ to have your port placed on
this list. The following port numbers are well-known so far:

+--------+----------+--------------------------+---------------------------------------------+
| Port   | Protocol | Name of app or accessory | Description                                 |
+========+==========+==========================+=============================================+
| 6001   | tcp      | ``decko``                | ``decko-memcached.service`` listens at this |
|        |          |                          | port for all Decko instances on this device |
+--------+----------+--------------------------+---------------------------------------------+

