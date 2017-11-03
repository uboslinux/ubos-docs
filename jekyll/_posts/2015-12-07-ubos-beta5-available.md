---
layout: post
title:  "UBOS Beta 5: single-command firewall configuration, Linux containers etc."
date:   2015-12-07 17:00:00
author: Johannes Ernst
categories: release beta
---

It's been longer since beta 4 than we would have liked, but if you work on a big chunk of
new functionality, that's sometimes what happens!

Now we proudly present: UBOS beta 5. Here are the highlights:

* In addition to being the primary operating system on a device, UBOS can alternatively now
  run in Linux containers. Not just on x86_64 PCs, but also on Raspberry Pi's!
  So if you already run Linux and don't want to remove your distro, you can
  simply run UBOS in addition! To make this easy, we are providing pre-configured images.
  Here are the <a href="/docs/users/installation.html">instructions</a> for how
  to run UBOS is a container.

* Nobody likes setting up networks, particularly complex ones. To make this much simpler,
  ``ubos-admin setnetconfig`` got even more powerful in this release. Using just a
  single command, it now knows how to setup a home gateway (with masquerading/network
  address translation, local DNS server, local DHCP server and selective port openings)
  and a standalone network. It also automatically configures a firewall with what we
  believe are reasonable, and reasonably secure defaults. For more details, go
  <a href="/docs/users/networking.html">here</a>.

* UBOS developer tools have been much improved. They can now be cleanly added to an
  Arch Linux installation that acts as a development machine. And given that UBOS can run
  in containers now, development does not need a "target" device in many circumstances.
  Developer documentation is <a href="/docs/developers/index.html">here</a>.

* In total, this release contains over 400 package upgrades!

The more detailed release notes are <a href="/docs/releases/beta5/release-notes/">here</a>.
We'd love your <a href="/community/">feedback</a>.
