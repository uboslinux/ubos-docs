``ubos-admin listnics``
=======================

This command lists all network interfaces on the current device detected by UBOS.

For example::

   > ubos-admin listnics
   enp0s8 - ether

In this case, a single interface called ``enp0s8`` was detected of type Ethernet. This
list may or may not be the same that the Linux kernel detects.

More details is available with the ``--verbose`` flag.

Users do not usually need to invoke this.
