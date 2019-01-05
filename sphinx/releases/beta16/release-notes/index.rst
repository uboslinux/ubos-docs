Beta 16 Release Notes
=====================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file:

* ``sudo ubos-admin backup --out ~/XXX.ubos-backup``

Then, update your device:

* ``sudo ubos-admin update -v``

What's new
----------

Beta 16 had been intended to be a big release, but it turned out to be too big :-)
so we broke it into two parts:

* This Beta 16 is the first part, which focuses on Linux package upgrades. In this
  release, about 500 operating system packages were upgraded.
* Beta 17 will then provide new features.

Notable package upgrades in this release:

* Bitcoin
* Certbot
* Ethereum
* Gcc
* Go
* Java
* Linux kernel
* Mariadb
* Nodejs
* Postgresql
* Python
* Redis
* Ruby
* Snapper
* Virtualbox

Known issues
------------

* On x86_64 after the upgrade, ``ubos-admin update`` may trigger unnecessary reboots.
  To avoid those, run the command as:
  ``ubos-admin update --noreboot``.
