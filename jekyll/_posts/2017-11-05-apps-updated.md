---
layout: post
title:  "Apps have been upgraded, and some new additions"
date:   2017-11-05 04:00:00
author: Johannes Ernst
categories: front release beta
---

Following the now independent release of UBOS beta 12, here's the first application
upgrate. The following apps and accessories were upgraded to the indicated version:

* Mattermost: 4.3.1

* Mediawiki: 1.29.1

* Nextcloud: 12.0.3
  * Calendar: 1.5.6
  * Contacts: 2.0.1
  * Mail: 0.7.4
  * News: 11.0.5
  * Notes: 2.3.1

* Shaarli: 0.9.2

* Wordpress:4.8.3
  * Bridgy: 1.3.1
  * Analytics for Wordpress: 6.2.4
  * Indieweb: 3.3.1
  * Indieweb Post Kinds: 2.6.6
  * Photo dropper: 2.3.4
  * Semantic linkbacks: 3.5.1
  * Social network auto-poster: 4.0.7
  * Syndication links: 3.2.2
  * Webmention: 3.4.1
  * Responsive theme: 3.6

Some of these Wordpress plugins are new on the `yellow` release channel.

There's also:

* `docroot`: A simple app for static file web hosting with secure, rsync/ssh-based upload
  (see <a href="/docs/users/apps/docroot.html">documentation</a>);

* `taligen` and `taliwodo`, currently only in the "experimental" repositories. That's because
  they are not ready for prime time. Except that we have been using them "for reals" already,
  to help with getting the most recent UBOS release out. Such a UBOS release takes many steps,
  including hundreds of steps of manual testing. It's really hard to not lose track!
  `taligen` allows the generation of task lists from modular components, and `taliwodo`
  can render these lists in a web browser and track which ones were done successfully, which
  failed, and which weren't done.
