---
layout: post
title:  "UBOS Beta 11 released with support for Marvell ESPRESSObin"
date:   2017-06-11 23:00:00
author: Johannes Ernst
categories: front release beta
---

<div style="float: right; margin: 0 0 10px 20px">
 <p><a href="http://espressobin.net/"><img src="/images/espressobin-350x43.png" width="350" height="43"></a></p>
</div>

UBOS Beta 11 is here, and we are proud to add the <b>Marvell
<a href="http://espressobin.net/">ESPRESSObin</a></b> to the list of supported devices.

Launched <a href="https://www.kickstarter.com/projects/874883570/marvell-espressobin-board">on Kickstarter</a>
earlier this year, the ESPRESSObin is an interesting board: it doesn't have any graphics (which is
fine with us because most UBOS devices are used as headless servers) but instead it has three
Ethernet ports and a SATA connector. The currently available 1GB version costs
only <a href="https://www.amazon.com/Globalscale-Technologies-Inc-SBUD102-ESPRESSObin/dp/B06Y3V2FBK/ref=sr_1_1">$49 on Amazon</a>. So it's
perfect for running UBOS.


<div style="float: right; margin: 0 0 10px 20px">
 <p><a href="https://www.raspberrypi.org/products/pi-zero-w/"><img src="/images/rpi-zero-w.png" width="256" height="123"></a></p>
</div>
We have also verified that the <b>Raspberry Pi Zero W</b> (the $10 version that has WiFi)
also works out of the box with UBOS.

As usual, there have also been many upgrades, bug fixes and new functionality has been
added. Here are the highlights:

 * The `smartctld` daemon is now running by default. You can use this to get e-mails when your disk
   is about to fail.

 * Nextcloud has been upgraded to current version 12, and we have added a number of
   frequently-used Nextcloud "apps": calendar, contacts, mail, news, notes, spreed and tasks.
   Not only can you now bring your calendar and contact info home, you can also start video
   conferences right from your UBOS home server.

 * UBOS can now run Python/Django apps, just as easily as other types of apps.

 * Hundreds of other package upgrades.

and more! More details are in the <a href="/docs/releases/beta11/release-notes/">release notes here</a>.

This time, upgrading a device that is running a previous UBOS version is a teensy bit more complicated.
Due to some changes in Arch Linux (our upstream distro), the command ``sudo ubos-admin update`` may fail on
the first try. To proceed, execute ``sudo rm /etc/ssl/certs/ca-certificates.crt`` to delete
that file, and then say ``ubos-admin update`` again. The upgrade should work then.

We'd love your <a href="/community/">feedback</a>.

