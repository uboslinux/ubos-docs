Notes on Wordpress (App ``wordpress``)
======================================

How to install plugins and themes
---------------------------------

When you run Wordpress, you usually install Wordpress plugins and themes by
logging into your Wordpress installation as administrator, navigating to the plugins
and themes pages, and pick install new ones from there.

This is not how it works on UBOS.

When you run Wordpress on UBOS, you need to specify your :term:`Accessories <Accessory>` at the time
you create your :term:`Site`, or by redeploying the :term:`Site` later with an updated configuration.

Example: let's say you want to use the Wordpress "Pinboard" theme for your :term:`Site`. When
you create the :term:`Site` with ``ubos-admin createsite``, you specify ``wordpress`` as your
:term:`App`, and ``wordpress-theme-pinboard`` as an :term:`Accessory`. You can specify multiple
:term:`Accessories <Accessory>`.

Here's the reason why: UBOS cannot manage :term:`Apps <App>` that change their code base without
UBOS knowing, and that's what would be happening if Wordpress got to add themes or
plugins to itself. And: UBOS curates plugins and themes, so you can be fairly certain
that the ones provided through UBOS actually work.
