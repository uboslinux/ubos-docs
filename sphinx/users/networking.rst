Setting up networking
=====================

UBOS today knows two networking configurations; there may be more in the future.

To show all available networking configurations::

   > ubos-admin listnetconfigs

To completely turn off networking::

   > ubos-admin setnetconfig off

To turn on networking, pick a networking configuration and activate it with::

   > ubos-admin setnetconfig <name-of-netconfig>

Client networking configuration
-------------------------------

By default, UBOS is in the ``client`` networking configuration. This this configuration,
UBOS activates all network interfaces that it can find, and looks to receive an IP
address through DHCP on any of them. It also advertises itself through mDNS/zeroconf.

For example, if you run UBOS on a board that has two Ethernet ports, you can connect
an Ethernet cable to either one of them (or both), and UBOS will attempt to obtain an
IP address as soon as it is connected.

This is the default networking configuration, so a device running UBOS can immediately
connect to the internet without any further setup.

Standalone networking configuration
-----------------------------------

In the ``standalone`` networking configuration, UBOS assigns static IP addresses to all of the
network interfaces that it can find. This mode is intended for situations in which
no network management infrastructure (like DHCP servers) are available, but where
the UBOS device still needs to be reachable via IP networking.
