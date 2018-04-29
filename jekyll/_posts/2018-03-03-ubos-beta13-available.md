---
layout: post
title:  "UBOS Beta 13: new apps and lots of new features"
date:   2018-03-03 15:00:00
author: Johannes Ernst
categories: front release beta
---

IMPORTANT: The upgrade is more complicated this time (and this time only -- we hope!).
Please follow the instructions in the
<a href="/docs/releases/beta13/release-notes/">release notes</a>. The short version:

<pre>% sudo pacman -Sy
% yes y | sudo pacman -S ubos-admin
% sudo ubos-admin update
% sudo ubos-admin setnetconfig &lt;your-config-name&gt;</pre>

UBOS beta 13 is out, and what a release it is! There are lots of new things. Here are
some of the highlights:

* WiFi configuration has become really simple, by means of the UBOS Staff USB stick:
  save a file with your WiFi network name and credentials to your UBOS Staff, and next
  time you boot your Raspberry Pi or PC, UBOS will automatically and securely connect it
  to your WiFi network.

* More apps!

  * Installing a full-fledged <a href="https://joinmastodon.org/">Mastodon</a> server
    and running your own version of Twitter, with up to 500 characters, and federating
    with other decentralized microblogging services, just takes one command. Note:
    Mastodon requires TLS, so you need to specify ``--tls`` when creating your site.

  * <a href="https://www.phpbb.com/">phpBB</a> lets you run your own discussion boards
    on a site you control. No more need for Google Groups or the like.

  * <a href="http://scripting.com/river.html">River5</a> is the latest river-of-news RSS
    reader from RSS godfather <a href="http://scripting.com/">Dave Winer</a>.

* UBOS can now easily run Bitcoin, Ethereum and Monero daemons. This is great for
  development of blockchain-related applications, and for those users who'd like to
  connect their cryptocurrency wallets to servers they control.

* UBOS now supports UEFI-only PCs, such as the Intel Compute Stick (probably the
  cheapest way to run UBOS on PC hardware).

* The ``ubos-admin`` packages are now licensed using what we call the
  "Personal Public License". See <a href="/blog/2018/03/02/ubos-license.html">separate
  blog post</a> explaining how it better fits the UBOS values.

* ... plus the usual hundreds of package upgrades, feature improvements and bug fixes.


For more info, read the detailed release notes <a href="/docs/releases/beta13/release-notes/">here</a>.

As always, we love your <a href="/community/">feedback</a>.
