---
layout: page
title: Apps on UBOS
---

<p>Status: beta 13</p>

Here's the current list of apps available on UBOS (alphabetically):

<img src="/images/known-72x72.png" alt="[Known]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Known**: Publishing Platform for Everyone<br>
   Install with `ubos-admin createsite`, specify app `known`

<img src="/images/mattermost-72x72.png" alt="[Mattermost]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Mattermost**: Open source, self-hosted Slack-alternative<br>
   Install with `ubos-admin createsite`, specify app `mattermost`

<img src="/images/mediawiki-72x72.png" alt="[Mediawiki]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Mediawiki**: The wiki that Wikipedia runs on<br>
   Install with `ubos-admin createsite`, specify app `mediawiki`

<img src="/images/nextcloud-72x72.png" alt="[Nextcloud]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Nextcloud**: A safe home for all your data<br>
   Install with `ubos-admin createsite`, specify app `nextcloud`

<img src="/images/phpbb-72x72.png" alt="[phpBB]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **phpBB**: Bulletin-board<br>
   Install with `ubos-admin createsite`, specify app `phpbb`

<img src="/images/river-72x72.png" alt="[River5]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **River5**: A river-of-news RSS aggregator<br>
   Install with `ubos-admin createsite`, specify app `river`

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
  `wordpress-plugin-webmention` for [Indie Web](http://indiewebcamp.com/) support; themes
  ``wordpress-theme-p2``, ``wordpress-theme-pinboard`` and ``wordpress-theme-responsive``
  and plugin ``wordpress-plugin-google-analytics-for-wordpress``.

 * **Mediawiki extension**: `mediawiki-ext-confirmaccount` to cut down on wiki spam;

<br>

The following blockchain-related servers are also available (no user interface, connect with API):

* **Bitcoin daemon**: Run your own Bitcoin blockchain<br>
  Install with `pacman -S bitcoin` and start with `systemctl start bitcoind`

* **Ethereum daemon**: Run your own Ethereum blockchain<br>
  Install with `pacman -S geth` and start with `systemctl start geth`

* **Monero daemon**: Run your own Monero blockchain<br>
  Install with `pacman -S monero` and start with `systemctl start monerod`

<br>

Apps redeclared as experimental and currently unmaintained:

<img src="/images/jenkins-72x72.png" alt="[Jenkins]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Jenkins**, a continuous integration app.<br>
   Install with `ubos-admin createsite`, specify app `jenkins`.

<img src="/images/jenkins-72x72.png" alt="[Jenkins]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Jenkins plugins**: `jenkins-plugin-git`, `jenkins-plugin-git-client`, and `jenkins-plugin-scm-api`
   for Git integration.

<img src="/images/owncloud-72x72.png" alt="[Owncloud]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Owncloud**: Your Cloud, Your Data, Your Way!<br>
  Install with `ubos-admin createsite`, specify app `owncloud`

<img src="/images/mediagoblin-72x72.png" alt="[Mediagoblin]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Mediagoblin**: The GNU project's photo and media sharing app<br>
   Install with `ubos-admin createsite`, specify app `mediagoblin`

<br>

And there are a few toy/demo and utility apps as well, including an app that simply redirects
(app `redirect`), which sometime is handy.
