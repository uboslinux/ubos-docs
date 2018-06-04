---
layout: post
title:  "UBOS Beta 14: support for data disks and more"
date:   2018-04-28 14:00:00
author: Johannes Ernst
categories: front release beta
---

Just in time for the
<a href="https://linuxfestnorthwest.org/conferences/lfnw18/program/proposals/77">Let's
Self-host Installathon</a> at Linuxfest NorthWest in Bellingham, WA,
UBOS beta 14 is out!

As usual, we have a mix of new features that make users' lives easier, new features
that make developers' lives easier, bug fixes and package upgrades. Here are the
highlights:

* It's now easy to use a separate "big data disk" (like an external USB disk on a Raspberry Pi,
  or an extra big volume on Amazon EC2). This makes it much simpler for UBOS users that
  have a lot of data on their device.

* Perform backup and system upgrade in a single step for even less work and worry
  when upgrading everything from OS to apps.

* Create sites from templates files, and only fill in the information that wasn't provided
  already in the template.

* There's a new command for concisely displaying the networking configuration.

* Developers can now write installation scriptlets in any language; there is no more need to
  write Perl wrappers.

* ... plus the usual hundreds of package upgrades, feature improvements and bug fixes.


To upgrade:

* If you always wished to have an extra disk on which to store your data, don't upgrade yet,
  but set that up first. <a href="/docs/users/running-out-of-disk-space.html">Here is how to</a>.
  You can also set this disk up after the upgrade, but it's less work if you do it first.

* To be safe, create a backup of all your data first, then update and reboot:

  <pre>% sudo ubos-admin backup --out ~/XXX.ubos-backup
% sudo ubos-admin update --noreboot
% sudo systemctl reboot</pre>

For more info, read the detailed release notes <a href="/docs/releases/beta14/release-notes/">here</a>.

As always, we love your <a href="/community/">feedback</a>.

== Known problems ==

* A few Nextcloud accessories initially were not rebuilt with the new paths. We
  have fixed this.

* On the Raspberry Pi, the `gpio` executable is missing its required `suid root` bit.
  We have submitted a pull request to the Arch Linux ARM project. In the meantime,
  to fix, become root and execute `chmod 4755 /usr/bin/gpio`.
