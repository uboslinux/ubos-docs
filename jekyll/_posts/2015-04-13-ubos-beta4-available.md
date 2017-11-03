---
layout: post
title:  "UBOS Beta 4: support for Mediagoblin, Webtrees and PostgreSQL"
date:   2015-04-13 18:00:00
author: Johannes Ernst
categories: release beta
---

We are proud that UBOS beta 4 has been released:

<img src="/images/2015-04-13/postgresql-144x144.png"  alt="[PostgreSQL]"  style="float: right; margin: 5px 20px">
<img src="/images/webtrees-144x144.png"    alt="[Webtrees]"    style="float: right; margin: 5px 20px">
<img src="/images/mediagoblin-144x144.png" alt="[Mediagoblin]" style="float: right; margin: 5px 20px">
There are three major new features:

1. <a href="http://mediagoblin.org/">Mediagoblin</a>, the GNU Project's photo and media
   sharing application, now installs, backs up, restores and upgrades with a single command,
   like all the other apps on UBOS.

2. <a href="http://webtrees.net/">Webtrees</a>, a full-featured web genealogy app, allows you
   to collaborate with your relatives on your ancestors over the internet, without spilling
   the family secrets to the general public because you keep them on your UBOS device.

3. As an alternative to MySQL/mariadb, UBOS apps can now use
   <a href="http://postgresql.org/">PostgreSQL</a>, and Mediagoblin
   makes use of that already. Of course, as a user, you don't have to worry about that because
   UBOS never makes you touch a database directly.

In addition, there have been application upgrades, a number of new packages, substantial
improvements to the UBOS Staff so you don't need generate SSH keys yourself, and a number
of bug fixes.

For more details, refer to the <a href="/docs/releases/beta4/release-notes/">release notes</a>.

<h2>How to upgrade</h2>

If you are an existing UBOS user and want to upgrade, log into your UBOS device.
First, you might want to make a backup of all your apps installed on your device:
<pre>
> sudo ubos-admin backup --out ~/backup.ubos-backup
</pre>

Then, to upgrade UBOS and all apps on your device, all you need to do is:

<pre>
> sudo ubos-admin update
</pre>

<h2>For new users</h2>

<a href="/quickstart/" class="get-started-button">Get started!</a>
