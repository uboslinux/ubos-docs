Notes on Wordpress (app ``wordpress``)
======================================

How to install plugins and themes
---------------------------------

When you run Wordpress, you usually install Wordpress plugins and themes by
logging into your Wordpress installation as administrator, navigating to the plugins
and themes pages, and pick install new ones from there.

This is not how it works on UBOS.

When you run Wordpress on UBOS, you need to specify your accessories at the time
you create your site, or by redeploying the site later with an updated configuration.

Example: let's say you want to use the Wordpress "Pinboard" theme for your site. When
you create the site with ``ubos-admin createsite``, you specify ``wordpress`` as your
app, and ``wordpress-theme-pinboard`` as an accessory. You can specify multiple
accessories.

Here's the reason why: UBOS cannot manage apps that change their code base without
UBOS knowing, and that's what would be happening if Wordpress got to add themes or
plugins to itself. And: UBOS curates plugins and themes, so you can be fairly certain
that the ones provided through UBOS actually work.
