Installing UBOS on a PC
=======================

You can install UBOS as the primary operating system on a standard PC. Note that UBOS is
intended for unattended, "headless" devices (i.e. without monitor, or keyboard) such as
a home server. It may be advisable to use an old PC that isn't otherwise used, which
may be perfectly sufficient for the purpose. You only need a keyboard and monitor
temporarily during installation.

To install UBOS on a standard PC:

#. Create a UBOS boot stick, and boot your PC with it as described in
   :doc:`x86_bootstick`.

#. Log in at the console as user ``root``. There is no password by default.

#. Format your hard drive(s). We recommend two drives in "RAID 1" configuration using
   the btrfs filesystem. This allows one of the drives to fail without losing data.
   However, any standard drive and file system configuration should be fine for most
   UBOS uses. For some options see
   `Partitioning <https://wiki.archlinux.org/index.php/Partitioning>`on the Arch Linux
   wiki.

   If you follow the recommendation of btrfs on one or two hard drives, do this:

   #. Determine the names of your hard drive(s)::

      > lsblk


If you'd like key generation to be faster, at the (possible) expense of less security
against determined attackers:

    > sudo pacman -S rng-tools
