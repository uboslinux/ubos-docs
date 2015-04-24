---
layout: page
title: Apps on UBOS
---

<p>Status: beta 4</p>

Here's the current list of apps available on UBOS (alphabetically)::

<img src="/images/jenkins-72x72.png" alt="[Jenkins]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Jenkins**, the continuous integration app we use to build UBOS itself on UBOS.<br>
   Install with `ubos-admin createsite`, specify app `jenkins`.

<img src="/images/idno-72x72.png" alt="[Known]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Known**: Publishing Platform for Everyone<br>
   Install with `ubos-admin createsite`, specify app `idno`

<img src="/images/mediagoblin-72x72.png" alt="[Mediagoblin]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Mediagoblin**: The GNU project's photo and media sharing app<br>
   Install with `ubos-admin createsite`, specify app `mediagoblin`

<img src="/images/mediawiki-72x72.png" alt="[Mediawiki]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Mediawiki**: The wiki that Wikipedia runs on<br>
   Install with `ubos-admin createsite`, specify app `mediawiki`

<img src="/images/owncloud-72x72.png" alt="[Owncloud]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Owncloud**: Your Cloud, Your Data, Your Way!<br>
   Install with `ubos-admin createsite`, specify app `owncloud`

<img src="/images/selfoss-72x72.png" alt="[Selfoss]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Selfoss**: The new multipurpose rss reader, live stream, mashup, aggregation web application<br>
   Install with `ubos-admin createsite`, specify app `selfoss`

<img src="/images/shaarli-72x72.png" alt="[Shaarli]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Shaarli**: Your Own URL Shortener<br>
   Install with `ubos-admin createsite`, specify app `shaarli`

<img src="/images/webtrees-72x72.png" alt="[Webtrees]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Webtrees**: Full-featured web genealogy app<br>
   Install with `ubos-admin createsite`, specify app `webtrees`

<img src="/images/wordpress-72x72.png" alt="[Wordpress]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Wordpress**: Blog tools, publishing platform, and CMS<br>
   Install with `ubos-admin createsite`, specify app `wordpress`

<br>

Some apps already have some accessories, which you may or may not want to install:

 * **Wordpress plugins**: `wordpress-plugin-semantic-linkbacks`, `wordpress-plugin-social` and
  `wordpress-plugin-webmention` for [Indie Web](http://indiewebcamp.com/) support;

 * **Mediawiki extension**: `mediawiki-ext-confirmaccount` to cut down on wiki spam;

 * **Jenkins plugins**: `jenkins-plugin-git`, `jenkins-plugin-git-client`, and `jenkins-plugin-scm-api`
   for Git integration.

<br>

And there are a few toy/demo and utility apps as well, including an app that simply redirects
(app `redirect`), which sometime is handy.
