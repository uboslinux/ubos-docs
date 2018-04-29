---
layout: post
title:  "UBOS Beta 8: incremental improvements and bug fixes"
date:   2016-08-12 22:00:00
author: Johannes Ernst
categories: front release beta
---

Beta 7 was a major feature release. This time around, the improvements are
more incremental. Here are the highlights:

* When creating a new site with ``sudo ubos-admin createsite``, you can now easily
  install several apps at the same site. For example, you could run your
  Wordpress blog at ``example.com/blog`` and your Nextcloud family file sharing
  at ``example.com/files``. The command has been restructured to allow you to
  enter multiple apps.

* You can now restore old backups to new apps. For example, if you'd like to
  migrate your ownCloud installation to Nextcloud, all you need to do is to
  create a backup of your ownCloud site with ``sudo ubos-admin backup`` and then
  tell ``sudo ubos-admin restore`` that you'd like to migrate. It's really easy.

* UBOS now has the beginnings of internet protocol 6 (IPv6) support.

* Various bug fixes and improvements.

These are just some of the highlights. The more detailed release notes are
<a href="/docs/releases/beta8/release-notes/">here</a>.

And as you probably know: to upgrade <b>everything</b> on your device, all you need to say is
``sudo ubos-admin update``.

We'd love your <a href="/community/">feedback</a>.
