---
layout: post
title:  "UBOS Beta 3 is out: added Raspberry Pi 2, Beagle Bone Black, and the UBOS Staff"
date:   2015-03-13 09:00:00
author: Johannes Ernst
categories: release beta
---

We are proud that UBOS beta 3 has been released this morning.

<img src="/images/pc-79x100.png"     alt="[PC]"           style="float: right; margin: 5px 20px">
<img src="/images/vbox-82x100.png"   alt="[Virtual Box]"  style="float: right; margin: 5px 20px">
<img src="/images/rpi-83x100.png"    alt="[Raspberry Pi]" style="float: right; margin: 5px 20px">
<img src="/images/beagle-100x100.png" alt="[Beagle Bone Black]" style="float: right; margin: 5px 20px">
There are two major new features:

1. UBOS now also supports the quad-core
   Raspberry Pi 2, and the Beagle Bone Black. These two new platforms join the original Raspberry Pi and
   the x86 (64bit) platform for physical and virtualized computers, for more options to run UBOS.

2. The UBOS Staff makes secure configuration of UBOS devices without keyboard and monitor a snap.
   See <a href="http://upon2020.com/blog/2015/03/ubos-shepherd-rules-their-iot-device-flock-with-a-staff/">blog post</a>
   and <a href="/docs/users/shepherd-staff.html">documentation</a>.

For more details, refer to the <a href="/docs/releases/beta3/release-notes/">release notes</a>.

<h2>How to upgrade</h2>

If you are an existing UBOS user and want to upgrade, log into your UBOS device.
First, you might want to make a backup of your sites:
<pre>
> sudo ubos-admin backup --out ~/backup-$(date +%Y%m%d%H%M).ubos-backup
</pre>

Then, to upgrade UBOS and all apps on your device, all you need to do is:

<pre>
> sudo ubos-admin update
</pre>

<h2>For new users</h2>

<a href="/quickstart/" class="get-started-button">Get started!</a>
