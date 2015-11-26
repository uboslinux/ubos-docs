``ubos-admin listnetconfigs``
=============================

See also :doc:`../../users/ubos-admin`.

In UBOS, a :term:`network configuration <Network Configuration>` is a set of active
network interfaces, their configuration, and the configuration of associated services
such as DNS, firewall, and the like.

Some of the network configurations come with UBOS package ``ubos-networking``, which is
generally installed on all UBOS devices. Others come in other packages which need to
be installed first.

UBOS knows about a set of possible netconfigs, but in the general case, only some of
them can be applied to the current device. For example, netconfig that implements a
router requires the device to have at least two network interfaces.

This command iterates through the netconfigs defined in Perl package
``UBOS::Networking::NetConfigs``, determines which of those apply, and prints them.
Adding the ``--all`` parameter, all netconfigs will be printed, regardless of whether
they appear to applicable to the current device.

See also :doc:`setnetconfig`. The set of currently available network configurations is
documented :doc:`here <../../users/networking>`.
