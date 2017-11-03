---
layout: post
title:  UBOS Beta 2 is here!
date:   2015-02-09 17:00:00
author: Johannes Ernst
categories: release beta
---

We're proud to announce that UBOS is now available in its second beta release.

You can run UBOS:

<img src="/images/pc-79x100.png"   alt="[PC]"           style="float: right; margin: 5px 20px">
<img src="/images/vbox-82x100.png" alt="[Virtual Box]"  style="float: right; margin: 5px 20px">
<img src="/images/rpi-83x100.png"  alt="[Raspberry Pi]" style="float: right; margin: 5px 20px">

 * on standard PCs, as their primary operating system
 * on standard PCs and Macs, in VirtualBox
 * on your Raspberry Pi Model B and Model B+.

<a href="/quickstart/">Get started!</a>

<h2>Highlights</h2>

 * Many bug fixes and reliability improvements from beta 1, as to be expected.

 * UBOS has an installer that makes it easy to install UBOS on a new
   computer. Download the the image for a bootstick, boot in the boot stick and
   run ``ubos-install /dev/sda`` to install UBOS on your first hard drive. RAID1
   is also no problem, simply say ``ubos-install /dev/sda /dev/sdb``. More options
   are available.

 * UBOS now makes it just as easy to create TLS-secured websites as it is to create
   non-secure ones. Just say ``ubos-admin createsite --tls --selfsigned``. You can
   also bring an official certificate.

 * Hosts running UBOS now advertise themselves on the local network using mDNS/zeroconf.
   This solves the problem of "but what IP address does my box have"? Look for
   ``ubos-pc.local``, ``ubos-raspberry-pi.local`` etc. on your local network.

 * Many improvements that make packaging and testing apps for UBOS easier and more
   reliable.

<h2>Apps</h2>

<img src="/images/owncloud-72x72.png" alt="[Owncloud]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Owncloud**: Your Cloud, Your Data, Your Way!<br>
   Upgraded from 7.0.x to 8.0.0.

<img src="/images/idno-72x72.png" alt="[Known]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Known**: Publishing Platform for Everyone<br>
   Upgraded from 0.6.4 to 0.7.1

<img src="/images/wordpress-72x72.png" alt="[Wordpress]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Wordpress**: Blog tools, publishing platform, and CMS<br>
   Upgraded from 4.0 to 4.1

<img src="/images/jenkins-72x72.png" alt="[Jenkins]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Jenkins**, the continuous integration app we use to build UBOS itself on UBOS.<br>
   Upgraded from 1.580.1 to 1.580.3

<img src="/images/mediawiki-72x72.png" alt="[Mediawiki]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Mediawiki**: The wiki that Wikipedia runs on<br>
   Upgraded from 1.23.x to 1.24

<img src="/images/selfoss-72x72.png" alt="[Selfoss]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Selfoss**: The multipurpose RSS reader, live stream, mashup, aggregation web application<br>
   Kept at same version.

<img src="/images/shaarli-72x72.png" alt="[Shaarli]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Shaarli**: Your Own URL Shortener<br>
   Kept at same version.

For more details, refer to the <a href="/docs/releases/beta2/release-notes/">release notes</a>.
