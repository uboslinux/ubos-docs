---
layout: post
title:  "UBOS Beta 6: now supporting Raspberry Pi Zero, Docker and more"
date:   2015-12-13 15:00:00
author: Johannes Ernst
categories: front release beta
---

<div style="float: right; margin: 0 0 10px 20px">
 <p><a href="https://www.raspberrypi.org/"><img src="/images/rpi-zero.jpg"></a></p>
 <p><a href="https://hub.docker.com/r/ubos/ubos-yellow/"><img src="/images/docker.png"></a></p>
</div>

Hot on the heels of beta 5, here is beta 6 already. It was intended only as a bug fix
release, but those bugs got squashed faster than expected, and so UBOS also got a few new
features while we were at it.

Here are the highlights:

* It's hard to believe, but $5 buys you a gigahertz processor, half a gig of RAM, HDMI video
  and lots of programmable I/O pins; in other words, a Raspberry Pi Zero. We are proud to
  announce that UBOS now runs on the Raspberry Pi Zero, in addition to the original one
  and version 2. (Go to <a href="/docs/users/installation/raspberrypi.html">installation
  instructions.</a>)

* What else is hot in the computing universe? Docker, of course. And as of now, UBOS
  also runs on Docker. (<a href="/docs/users/installation/x86_docker.html">Here is how.</a>)

* Want to run web applications at home, but also access them over the internet? The new
  UBOS network configuration ``public-gateway`` lets you set up your UBOS device as a router
  for your home network, and access your apps on your public IP address. Just say
  ``ubos-admin setnetconfig public-gateway``.
  (<a href="/docs/users/networking.html">More info.</a>)

* And of course the usual: some packages have been upgraded, bugs have been fixed etc.

And as you probably know: to upgrade <b>everything</b> on your device, all you need to say is
``ubos-admin update``.

The more detailed release notes are <a href="/docs/releases/beta6/release-notes/">here</a>.
We'd love your <a href="/community/">feedback</a>.
