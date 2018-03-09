Notes on Mastodon (app ``mastodon``)
====================================

Publicly accessible site
------------------------

Given that Mastodon is all about interacting with other Mastodon sites on the public internet,
you very likely want to deploy Mastodon on a publicly accessible web server (i.e. not
behind a firewall) with an official domain name.

HTTPS sites only
----------------

Mastodon's developers have written Mastodon in a way that it refuses to (correctly)
work on non-secured HTTP sites. This is the only app we are aware of that requires HTTPS,
but in the interest of security, we can't really fault them.

This means that when you create a site that is intended to run Mastodon, you need
invoke ``ubos-admin createsite --tls``.

It is recommended you only run Mastodon on a site with an official hostname, and only
with an official SSL/TLS certificate from a certificate authority such as Lets Encrypt,
otherwise Mastodon may not be able to successfully communicate with other decentralized
microblogging servers.

Default setup
-------------

UBOS gives you a choice whether to set up Mastodon as a single-user site, or as a multi-user
site that allows registration of accounts beyond the initial administrator account.
``ubos-admin createsite`` will ask you which you'd like.

If you set up a multi-user site, you can limit which new users are allowed to sign up by
creating a whitelist and/or a blacklist for e-mail address domains of the new users. For
example, if you enter ``example.com|example.net`` as the value of the black list, users
whose e-mail address is at ``example.com`` or ``example.net`` are prohibited from signing
up for Mastodon at your site. To do so, you need to add the ``--askForAllCustomizationPoints``
argument to ``ubos-admin createsite`` when you create the site.

Do not use ``admin`` as the site administrator user id
------------------------------------------------------

Mastodon apparently reserves the use of user id ``admin``. As UBOS creates a Mastodon
user with the site administrator's user id, this would fail if you specified ``admin``
as the site administrator's user id during ``ubos-admin createsite``.
