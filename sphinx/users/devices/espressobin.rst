ESPRESSObin
===========

Use of SATA disk
----------------

To use a SATA disk with the ESPRESSObin, please refer to
:doc:`/users/installation/espressobin`.

Networking
----------

Unlike most ARM boards, the ESPRESSObin features three Ethernet ports. This opens
possibilities!

For more background on networking on UBOS, see :doc:`/users/networking`.

* By default, UBOS on the ESPRESSObin runs the ``espressobin`` network configuration.
  This configuration only exists on the ESPRESSObin. It is very similar to the ``gateway``
  network configuration: it configures the ESPRESSObin's ``wan`` port to connect to
  an upstream network (such as from an ISP) and the two ``lan`` ports to manage two
  local LANs. Any additional network interfaces, such as a WiFi USB dongle, will be treated
  like the LAN ports.

* There is also the ``public-espressobin`` network configuration, which relates to
  the ``espressobin`` configuration the same way the ``public-gateway`` network
  configuration relates to the ``gateway`` one: it's the same, but applications installed
  on the device can also be accessed from the public internet.

* Alternatively, you can run the ``client`` network configuration, which makes all
  of the ESPRESSObin's interfaces equivalent, expecting to plug into a network that has
  a DHCP server (such as your typical home network).

**NOTE ON SECURITY**: if you use your ESPRESSObin as a router (you use one port to
connect "upstream" towards the internet and another to connect to other "downstream"
devices that route through your ESPRESSObin), **DO NOT BOOT OR REBOOT** while the ESPRESSObin
is connected to an upstream network. In other words: before booting or rebooting, disconnect the
upstream Ethernet cable, and only reconnect once the ESPRESSObin has fully booted.

Explanation: it turns out that when the ESPRESSObin board starts, in the minute or two
before UBOS (or any other OS) had a chance to configure networking, the ESPRESSObin's
on-board switch is on, and does what an unconfigured switch does: it forwards traffic.
This has major unfortunate consequences:

* Any downstream device (i.e. a device that is connected to one of the "other" two ports
  of the ESPRESSObin) will obtain, or attempt to obtain, an IP address from the upstream
  provider, not the ESPRESSObin, as the ESPRESSObin's switch passes all data on directly.
  Such an upstream provider may not hand out multiple IP addresses, so this may or may not
  work. But if it works, it will conflict with the networking setup as soon as the ESPRESSObin
  is done booting, preventing the downstream device from networking right thereafter.

* During this time, any attack from the public internet will be forwarded, without change,
  to the devices on the local area network. There is no firewall or any kind of protection
  until the operating system is done booting.

This is a problem with the way the ESPRESSObin board has been created, and not something
we can fix in software -- after all, UBOS does not run yet when the problem occurs! We
have reported the problem to Globalscale, ESPRESSObin's vendor, and hope they come up
with a solution.
