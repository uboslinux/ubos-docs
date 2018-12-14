---
layout: post
title:  "Installing Nextcloud 15 on UBOS versus other Linux distros"
date:   2018-12-13 23:00:00
author: Johannes Ernst
categories: front
---

<div style="float: right; margin: 0 0 10px 20px">
 <p>
  <img src="/images/nextcloud-144x144.png" width="144" height="144">
 </p>
</div>

<a href="https://nextcloud.com/blog/nextcloud-15-goes-social-enforces-2fa-and-gives-you-a-new-generation-real-time-document-editing/">Nextcloud 15</a>
was released this week, and tutorials are appearing on the web how to install it on
various operating systems. As a UBOS user, I can only marvel how complicated it is ...
compared to UBOS. Let's compare:

* on Ubuntu: <a href="https://decatec.de/home-server/nextcloud-auf-ubuntu-server-18-04-lts-mit-nginx-mariadb-php-lets-encrypt-redis-und-fail2ban/">Nextcloud
  auf Ubuntu Server 18.04 LTS mit nginx, MariaDB, PHP, Let’s Encrypt, Redis und Fail2ban</a>.
  States that the required amount of work is about 3 hours.

* on Ubuntu: <a href="https://markus-blog.de/index.php/2018/12/12/how-to-install-nextcloud-15-on-ubuntu-with-php7-3-fpm-apache2-and-http-2/">How
  to install Nextcloud 15 on Ubuntu with php7.3-fpm Apache2 and HTTP/2</a>. Admittedly UBOS
  currently does not do fpm or HTTP/2, but those only add minimally to the length of
  the instructions. About 1400+ words of instructions to follow.

* on OpenBSD: <a href="https://h3artbl33d.nl/blog/nextcloud-on-openbsd-updated">NextCloud on OpenBSD - updated</a>.
  Says: "coffee is needed". About 1800 words of instructions to follow.

* on Synology: <a href="https://hackabee.fr/2018/12/12/how-to-solve-php-7-bash-error-to-update-nextcloud-on-synology/">How
  to fix PHP 7 bash error to update Nextcloud on Synology?</a> Only deals with one possible
  error. Approx 460 words of instructions to follow.

(Words counted by copy-pasting the "meat" of the instructions from Firefox "reader view" into
BBEdit, and using their word count)

In comparison, here are the instructions for UBOS. Enter the following commands, and answer the questions:

<pre>
% <b>sudo ubos-admin update</b>
% <b>sudo ubos-admin createsite</b>
</pre>

If you'd like the Redis cache, enter "nextcloud-cache-redis" in the question about accessories.
And if you want a letsencrypt certificate for your site, append "--tls --letsencrypt" to the
second (createsite) command. This would make the setup similar to the above tutorials.

Either way, it takes, well, about 2 minutes, most of which is waiting for the computer to do its thing.
Why should you have to bother with an operating system that makes installing Nextcloud more complicated?

Upgrades are even simpler:

<pre>
% <b>sudo ubos-admin update</b>
</pre>

Strike a solid win for UBOS I would think. #ubosrocks

P.S. <a href="/quickstart/">UBOS runs</a> on PCs, cloud, and ARM devices like the Raspberry Pi,
and if you like to get it pre-installed, consider buying a
<a href="https://indiecomputing.com/products/">UBOSbox</a>.
