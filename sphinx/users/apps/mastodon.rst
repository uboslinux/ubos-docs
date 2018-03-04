Notes on Mastodon (app ``mastodon``)
====================================

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
