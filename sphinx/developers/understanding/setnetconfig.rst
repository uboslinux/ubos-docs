``ubos-admin setnetconfig``
===========================

See also :doc:`../../users/ubos-admin`.

In UBOS, a :term:`network configuration <Network Configuration>` is a set of active
network interfaces, their configuration, and the configuration of associated services
such as DNS, firewall, and the like.

The purpose of this command is to make network configuration as simple as app installation
is in UBOS. For example, to run UBOS on a home router, typically one network interface has
to obtain an IP address from the ISP, network address translation and a firewall needs
to be set up, a DHCP servers needs to be run, and so forth. With ``ubos-admin setnetconfig``
all of this configuration can be performed in a single command.

The command::

   ubos-admin setnetconfig <name>

deactivates the current network configuration, and activates the named network
configuration instead.

Depending on the network configuration, this command may perform one or more of the
following actions:

* activate or deactivate certain network interfaces, such as ethernet ports or
  WiFi dongles
* assign IP addresses or network interfaces
* run DHCP clients on certain network interfaces, so the device can automatically
  obtain an IP address from the network
* run DHCP servers on certain network interfaces, so the device can issue valid
  IP addresses to other devices on the network
* set up, or turn off, firewall functionality at one or more network interfaces
* run, or cease to run, a local DNS server
* set up, or tear down, network masquerading (aka network address translation)
  services at certain interfaces.

To show all available network configurations, execute
:doc:`listnetconfigs`. The set of currently available network configurations is
work in progress.
