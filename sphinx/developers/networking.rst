UBOS Networking
===============

Preserving the details of the netconfig
---------------------------------------

When the user invokes:

.. code-block:: none

   % sudo ubos-admin setnetconfig <name>

UBOS will set a networking configuration, such as ``client``, and save the details of
that configuration at ``/etc/ubos/netconfig-<name>.json``.

When the user temporarily changes from one networking configuration to another, and then
back, those saved settings will be picked up and restored. This is important to re-assign
the same role to the same interface. For example, if a UBOS device has two network
interfaces and is used as a home router, the role of the respective interfaces as
LAN vs WAN interfaces should not randomly change, just because the user turned off the
network temporarily.

Changing the details of the netconfig
-------------------------------------

By editing a netconfig file directly, a user can manipulate the networking settings in
more detail than is possible with the relative crudeness of ``ubos-admin setnetconfig``
only.

To do so:

1. Select a netconfig that is close to the desired end configuration, and activate it
   with ``ubos-admin setnetconfig <name>``.

2. Edit the netconfig file at ``/etc/ubos/netconfig-<name>.json`` and make the desired changes.

3. Activate the netconfig again, by executing ``ubos-admin setnetconfig <name>``.


Syntax of the netconfig files: Structure
----------------------------------------

Note: The syntax of netconfig files may change at any time.

A netconfig file is a JSON file that has a Hash as its top-level element. The
keys of the hash are the names of network interfaces (such as Ethernet interface,
WiFi adapter etc.) and the values are settings for this particular interface.

For example:

.. code-block:: json

   {
     "eth0" : {
        # contains settings for Ethernet adapter eth0
     },
     "wlan0" : {
        # contains settings for WiFi adapter wlan0
     }
   }

The netconfig file may contain entries for interfaces that are not currently present
on the system. Those entries are silently ignored. For example, the above netconfig
file fragment specifies an entry for a WiFi adapter which may have been removed from
its USB port.

Syntax of the per-interface settings in a netconfig file
--------------------------------------------------------

Note: The syntax of netconfig files may change at any time.

Within an interface-specific section (explained above), a variety of settings may
be given. All settings are optional. If settings are provided that conflict with each
other, the results are undefined.

``address``:
   A static IP address to be assigned to the interface.

``dhcp``:
   If set to ``true``, the UBOS device should obtain an IP address for this interface via
   DHCP.

``dhcp-lease``:
   If this interface runs a DHCP server, use this setting as the default lease duration
   for DHCP leases. The syntax of this string is the same as used for the corresponding
   setting of ``dnsmasq`` (see "lease time" in option ``--dhcp-range`` at the
   `dnsmasq man page <http://www.thekelleys.org.uk/dnsmasq/docs/dnsmasq-man.html>`_).

``dhcpserver``:
   If set to ``true``, the UBOS device should run a DHCP server, listening to DHCP requests
   coming in at this interface, and responding by handing out suitable IP addresses.

``forward``:
   If set to ``true``, the UBOS device should forward IP packets over this interface.

``masquerade``:
   If set to ``true``, masquerade the IP addresses behind this interface. This usually
   also requires ``forward`` to be set.

``mdns``:
   If set to ``true``, the UBOS device should advertise itself via mDNS through this
   interface.

``ports``:
   If set to ``true``, the ports specified by :term:`Apps <App>` installed on the device will be
   opened. For example, UBOS itself specifies that ports 80 and 443 should be open.
   However, these ports are only accessible through interfaces that have their
   ``ports`` field set to ``true``. This enables running applications on a UBOS
   router that are only accessible from the LAN, and not from the public internet.

``prefixsize``:
   If an interface as a static IP address, and runs a DHCP server, ``prefixsize`` is
   used to determine the range of IP addresses that may be issued. For example, if
   ``address`` is ``192.168.10.1`` and ``prefixsize`` is ``24``, the DHCP server
   would issue addresses between ``192.168.10.1`` and ``192.168.10.255``.

``state``:
   If set to ``off``, the interface is disabled.

``ssh``:
   If set to ``true``, logins into the device are permitted via this interface.

``sshratelimit``:
   If set to ``true``, limit the rate at which ssh connections may be made at this
   interface. This can be used to slow down brute-force login attempts.

``sshratelimitseconds``:
   If ``sshratelimit`` is given, indicates the time window in which ssh connection
   attempts are counted.

``sshratelimitcount``:
   If ``sshratelimit`` is given, indicates the maximum number of permitted ssh
   connection attempts within the time window.

