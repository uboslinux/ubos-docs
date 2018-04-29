---
layout: page
title: Apps on UBOS
---

<p>Status: beta 14</p>

Here's the current list of apps available on UBOS (alphabetically):

<img src="/images/docroot-72x72.png" alt="[Docroot]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Docroot**: Static file hosting with SSH-based upload<br>
   Install with `sudo ubos-admin createsite`, specify app `docroot`

<img src="/images/known-72x72.png" alt="[Known]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Known**: Indieweb publishing platform for everyone<br>
   Install with `sudo ubos-admin createsite`, specify app `known`

<img src="/images/mastodon-72x72.png" alt="[Mastodon]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Mastodon**: Free, open-source, decentralized microblogging network<br>
   Install with `sudo ubos-admin createsite`, specify app `mastodon`

<img src="/images/mattermost-72x72.png" alt="[Mattermost]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Mattermost**: Open source, self-hosted Slack-alternative<br>
   Install with `sudo ubos-admin createsite`, specify app `mattermost`

<img src="/images/mediawiki-72x72.png" alt="[Mediawiki]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Mediawiki**: The wiki that Wikipedia runs on<br>
   Install with `sudo ubos-admin createsite`, specify app `mediawiki`

<img src="/images/nextcloud-72x72.png" alt="[Nextcloud]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Nextcloud**: A safe home for all your data<br>
   Install with `sudo ubos-admin createsite`, specify app `nextcloud`

<img src="/images/phpbb-72x72.png" alt="[phpBB]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **phpBB**: Bulletin-board<br>
   Install with `sudo ubos-admin createsite`, specify app `phpbb`

<img src="/images/redirect-72x72.png" alt="[Redirect]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Redirect**: Redirects to another site<br>
   Install with `sudo ubos-admin createsite`, specify app `redirect`

<img src="/images/river-72x72.png" alt="[River5]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **River5**: A river-of-news RSS aggregator<br>
   Install with `sudo ubos-admin createsite`, specify app `river`

<img src="/images/selfoss-72x72.png" alt="[Selfoss]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Selfoss**: Multipurpose rss reader, live stream, mashup, aggregation web application<br>
   Install with `sudo ubos-admin createsite`, specify app `selfoss`

<img src="/images/shaarli-72x72.png" alt="[Shaarli]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Shaarli**: Personal, minimalist, super-fast, bookmarking service<br>
   Install with `sudo ubos-admin createsite`, specify app `shaarli`

<img src="/images/webtrees-72x72.png" alt="[Webtrees]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Webtrees**: Full-featured web genealogy app<br>
   Install with `sudo ubos-admin createsite`, specify app `webtrees`

<img src="/images/wordpress-72x72.png" alt="[Wordpress]" style="float: left; width: 36px; margin: 5px 32px 0 5px">

   **Wordpress**: Blog tools, publishing platform, and CMS<br>
   Install with `sudo ubos-admin createsite`, specify app `wordpress`

<br>

Some apps already have some accessories, which you may or may not want to install:

 * **Known plugins**: `known-plugin-linkedin` and `known-plugin-wordpress` for integration with
   social networks;

 * **Mediawiki extension**: `mediawiki-ext-confirmaccount` to cut down on wiki spam;

 * **Nextcloud "apps"**: `nextcloud-calendar` (calendar), `nextcloud-contacts` (contacts),
   `nextcloud-mail` (mail), `nextcloud-news` (news), `nextcloud-notes` (note taking),
   `nextcloud-spreed` (video conferencing) and `nextcloud-tasks` (task management);

 * **phpBB extension**: `phpbb-extension-shareon` for sharing posts on social media, and
   `phpbb-extension-googleanalytics` for Google Analytics support;

 * **Wordpress plugins**: `wordpress-plugin-bridgy-publish`, `wordpress-plugin-indieauth`,
   `wordpress-plugin-indieweb`, `wordpress-plugin-indieweb-post-kinds`,
   `wordpress-plugin-micropub`, `wordpress-plugin-semantic-linkbacks`,
   `wordpress-plugin-syndication-links`,
   `wordpress-plugin-social-networks-auto-posted-facebook-twitter-g`,
   `wordpress-plugin-webmention` and `wordpress-plugin-wp-uf2` for
   [Indie Web](http://indiewebcamp.com/) support; `wordpress-plugin-photo-dropper` to
   easily find and add pictures to posts; themes `wordpress-theme-independent-publisher`,
   `wordpress-theme-p2`, `wordpress-theme-pinboard`, `wordpress-theme-sempress` and
   the default themes starting with `wordpress-theme-twentyfourteen`.

The following blockchain-related servers are also available on all all platform except
for ``armv6h`` (no user interface, connect with API):

* **Bitcoin daemon**: Run your own Bitcoin blockchain<br>
  Install with `sudo pacman -S bitcoin` and start with `systemctl start bitcoind`

* **Ethereum daemon**: Run your own Ethereum blockchain<br>
  Install with `sudo pacman -S geth` and start with `systemctl start geth`

* **Monero daemon**: Run your own Monero blockchain<br>
  Install with `sudo pacman -S monero` and start with `systemctl start monerod`
