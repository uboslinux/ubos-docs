---
layout: post
title:  "User Story: How I set up ownCloud on UBOS with VirtualBox behind a firewall"
date:   2015-03-18 09:00:00
author: Emmanual Arthur
categories: userstory owncloud virtualbox
---

UBOS user Emmanual Arthur wrote us with this experience report. You can often find him
on <a href="http://webchat.freenode.net/?channels=%23ubos">#ubos</a>.

"I wanted to use <a href="http://owncloud.org/">ownCloud</a> Server, but to set it up on
Windows 8.1 wasn't trivial. So the UBOS solution is more appealing to me. I also wanted
to be able to use my ownCloud server if I am out of range of my local network. I didn't
want to use Dropbox, OneDrive, GoogleDrive and such. I also want to sync my calendar,
contact and the photo folder on my smartphone with my ownCloud server. I accomplished
this without the need to configure everything in Linux and then the ownCloud server.

My motivation to use UBOS is that I "can use it out of the box".
Either on Rasperry Pi, on PC or on Virtualbox, it is always a quick installation.

My configuration:

* UBOS version is Beta 2 yellow (note: should work with any later version in the same way)
* ownCloud Server version 8.0
* Oracle VirtualBox version VirtualBox-4.3.24-98716-Win
* My host for VirtualBox is Windows 8.1

After setting up UBOS with the guide
<a href="/docs/users/installation/virtualbox.html">here</a>,
I installed ownCloud with the video tutorial
<a href="/blog/2015/02/10/owncloud8-on-ubos.html">Installing ownCloud 8
on UBOS with TLS</a>.

When asked for hostname, I chose ``*``. We will need that for connecting from the
public internet.

If you do the same, to use ownCloud on your local network you are done. Just connect
to the assigned IP address to your VirtualBox VM running UBOS.

If you want to connect to your ownCloud Server from a public WiFi or your smartphone,
internet cafe etc. you have to configure your home router to portforwarding. ownCloud
server over TLS listens on port 443 per default. If your router is also using the port
443 or another device in your local network, you have to reconfigure them to other ports.
On your router set the IP address to your VirtualBox to listen on the incoming port
like 1234 and redirect it to the port 443. Here is a screen shot from my router:

<img src="/images/2015-03-18/portforwarding.jpg">

You then want to have a dynamic name resolver from e.g. ``dyndns.org`` or ``no-ip.com``
like ``yourdnsname.net``.

From public network type ``https://yourdnsname.net:1234`` and you can connect to your
ownCloud installation on VirtualBox behind your firewall:

<img src="/images/2015-03-18/yourdnsname.jpg">
