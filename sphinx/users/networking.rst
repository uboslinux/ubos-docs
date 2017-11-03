Setting up networking and DNS
=============================

Introduction
------------

UBOS can be run on many different hardware configurations. For example, a device running
UBOS may or may not have an Ethernet port; or it may have several. It may or may not have a
WiFi antenna, which may be on board or be a separate USB dongle. Networks that a UBOS device
connects to might also be very different, from typical home networks to virtual networks
on host machines running UBOS in Linux containers.

Because of all these differences, networking for Linux server devices is usually complex to
set up and requires substantial expertise.

With UBOS, as usual, we try to simplify things. We do this by pre-defining some common
network configurations, and automatically install the one most likely to work "out of the box"
for a new UBOS device without further configuration. If you wish to use the device in a
different setting, we provide a single command to switch to a different network configuration.

Unlike other network management tools, UBOS network configurations manage all necessary
layers of the networking stack including:

* individual network interfaces such as Ethernet interfaces
* IP addresses
* DHCP
* DNS
* zeroconf/mDNS
* Firewall
* Masquerading
* open ports for applications.

.. warning:: Connecting to a wireless network is not yet automated. See
   `WiFi on UBOS <http://ubos.net/blog/2016/08/18/wifi.html>`_.

Currently available network configurations
------------------------------------------

The following network configurations are currently available:

Network configuration: ``client``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For most devices, this is the default network configuration after UBOS installation.

If your UBOS device has an Ethernet port, and you connect the Ethernet port to your network,
the UBOS device will automatically connect.

If your UBOS device has more than one network interface, it should not matter
which you use to connect to a network.

In this mode:

* **network interfaces**: All network interfaces are active, and looking to obtain an
  IP address, default gateway and DNS server information via
  `DHCP <https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol>`_.
* **mDNS**: The device will advertise itself on all interfaces.
* **ports**: Application-level ports (such as HTTP and HTTPS ports 80 and 443) will be
  accessible from all interfaces.
* **ssh**: ssh connections are accepted on all interfaces.
* **firewall**: All other ports are firewalled.

If you'd like to have a predictable IP address for your UBOS device in this network configuration,
we recommend that you configure your DHCP server to always hand out the same IP address to
your UBOS device. This tends to be an easier, and typically more maintainable process than maintaining
static IP addresses on all the devices on your network. For example, depending on the model
of your home router, you may be able to do this:

* Log into the administrative interface of your home router, and look for a page
  that lists all currently connected devices on your network.
* Look for your UBOS device, and note its MAC address.
* In some part of the administrative interface of your home router, you may be
  able to assign a consistent IP address for the device with this MAC address.

Network configuration: ``standalone``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This network configuration is useful to set up a network that is disconnected from
the public internet. In this configuration, the UBOS device assumes the role of network
manager and manages the network by running a DHCP server, and a DNS server.

Other devices connected to the UBOS device will be able to receive an IP address
and use network services as if they were connected to a typical home network, but
without upstream connection.

If your UBOS device has more than one network interface, UBOS will create separate subnets
for each network interface.

In this mode:

* **network interfaces**: All network interfaces are active and have a static IP address
  assigned. Other connected devices can obtain IP address, default gateway and DNS server
  information from a DHCP server and a DNS server running on the UBOS device.
* **mDNS**: The device will advertise itself on all interfaces.
* **ports**: application-level ports (such as HTTP and HTTPS ports 80 and 443) will be
  accessible from all interfaces.
* **ssh**: ssh connections are accepted on all interfaces.
* **firewall**: All other ports are firewalled.

Network configuration: ``gateway``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This network configuration was created to make it easy to use UBOS for home routers.
In this configuration, UBOS will connect to the public internet via broadband through
one network interface, and obtain an IP address from the ISP via DHCP. All other network
interfaces will have statically allocated, private IP addresses that connect to the
public internet via Network Address Translation (NAT).

This configuration requires the UBOS device to have at least two network interfaces:
one for the upstream connection to the public internet via the ISP, and one for the
local network. Devices connecting to the local network can obtain local IP addresses
from the UBOS device via DHCP. The UBOS device also provides DNS for the local network,
with delegation to the ISP's DNS server.

If the UBOS device has more than two network interfaces, additional interfaces will be
created as separate local networks on different subnets.

Applications running on the UBOS device are accessible from the local network ("downstream")
but not from the public internet ("upstream").

In this mode:

* **network interfaces**: All network interfaces are active.

  * The first ("upstream") interface (which one that is depends on the hardware; trial and
    error helps) connects to the upstream broadband connection. It obtains IP address,
    default gateway and upstream DNS server information via DHCP.
  * All other ("downstream") interfaces have static IP addresses assigned. Devices connecting
    to those interfaces can obtain a local area network IP address, default gateway and DNS server
    information from a DHCP server and a DNS server running on the UBOS device.

* **masquerade**: Devices connected to a "downstream" interface are masqueraded behind the
  IP address of the "upstream" interface.
* **mDNS**: The device will advertise itself on the "downstream" interfaces only.
* **ports**: Application-level ports (such as HTTP and HTTPS ports 80 and 443) will be
  accessible from devices connected to the "downstream" interfaces only.
* **ssh**: ssh connections are accepted on all interfaces.
* **firewall**: All parts other than ``ssh`` are firewalled on the "upstream" interface.
  Application ports are accessible from the "downstream" interfaces.

Network configuration: ``public-gateway``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This network configuration is identical to ``gateway``, except that applications running on
the UBOS device are accessible btoh from the local network ("downstream") and from the public
internet ("upstream").

Network configuration: ``container``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This network configuration is used by UBOS when run in a Linux container started by
``systemd-nspawn``, by Docker or the like. It is very similar to ``client`` but there are
no mDNS advertisements.

Network configuration: ``off``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In this network configuration, UBOS has turned off all networking. This is useful as an
emergency setting.

mDNS hostnames
--------------

By default, UBOS devices announce themselves on the local-area network with the
following names:

=========================== ===============================
UBOS installed on:          Hostname
=========================== ===============================
PC                          ``ubos-pc.local``
Virtual PC in VirtualBox    ``ubos-vbox-pc.local``
Raspberry Pi Zero or 1      ``ubos-raspberry-pi.local``
Raspberry Pi 2 or 3         ``ubos-raspberry-pi2.local``
EspressoBIN                 ``ubos-espressobin.local``
=========================== ===============================

So for example, if you run UBOS on a Raspberry Pi, after the Raspberry Pi has booted,
you should be able to access your Raspberry Pi on your local network at ``http://ubos-rpi.local/``.

Access should work on all operating systems and types of devices, **except on older versions
of Windows** if you do not have iTunes installed. (Yes, this sounds strange. Basically, Microsoft
in the past has not supported mDNS, but Apple does, and Apple adds it to your Windows PC as
soon as you install iTunes. Apple calls this feature Bonjour.) So if you are unlucky enough to
run an older version of Windows, please install iTunes there and mDNS resolution should work.

The advantage of using these mDNS hostnames is that no DNS setup is required, and you do
not need to assign a static IP address to your device.

The disadvantage of using these hostnames is that they only work on the local network,
and that you cannot run more than one site on the same UBOS device. There may also be
collisions if you run more than one UBOS device of the same type on the same network.

If you wish to change your device's mDNS hostname, change its Linux hostname, and restart
the Avahi daemon. Assuming you would like the new name to be ``mydevice``, you can do this
by executing the following commands as ``root``:

.. code-block:: none

   > hostname mydevice
   > hostname > /etc/hostname
   > systemctl restart avahi-daemon

Non-mDNS (regular) hostnames
----------------------------

If you would like to use more than one site on the same device, or you would like to
use a hostname of your choosing (say, ``family.example.com``) you need to set up
DNS yourself. This can sometimes be performed in the administration interface of
your home router.

For example, depending on the model of your home router, you may be able to do this:

* Log into the administrative interface of your home router, and look for a page
  that lists all currently connected devices on your network.
* Look for your UBOS device, and note its MAC address.
* In some part of the administrative interface of your home router, you may be
  able to assign a consistent hostnamefor the device with this MAC address.

Unfortunately, this entirely depends on the features of your home router, and is outside
of UBOS's control.

Persistence of network configuration settings
---------------------------------------------

When a network configuration is set with::

   > ubos-admin setnetconfig <name>

it will survive a reboot. Furthermore, when a network configuration is
restored -- for example because temporarily another network configuration was activated
-- the previous settings will be restored as much as possible. Consider this
sequence::

   > ubos-admin setnetconfig standalone
   > ubos-admin setnetconfig off
   > ubos-admin setnetconfig standalone

In the ``standalone`` network configuration, UBOS assigns static IP addresses to all
network interfaces found. Which IP address is assigned to which network interface is
basically random. However, it would be desirable if the same IP address was assigned to the same
interface when the ``standalone`` network configuration was restored after temporarily
being ``off``. UBOS accomplishes this by saving the actual assignments in file
``/etc/ubos/netconfig-standalone.json`` (replace ``standalone`` with the name of the
network configuration). If such a file exists, UBOS will restore its settings as much
as possible.

This enables a user not scared of editing JSON file to override the standard settings
of a particular network configuration. For example, if a device has two network
interfaces and is used in the ``client`` network configuration, but editing
``/etc/ubos/netconfig-client.json`` and executing ``ubos-admin setnetconfig client`` again,
the user could, for example, keep one of those interfaces off, or have different ports open.

