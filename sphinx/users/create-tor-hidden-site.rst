How to set up a website as a Tor hidden service
===============================================

Introduction
------------

`Tor <https://www.torproject.org/>`_ is generally known as a way to
browse the web anonymously. That requires a special browser, but the user's web
traffic is heavily encrypted and bounced between several countries, so it
becomes rather difficult even for well-resourced adversaries (oppressive governments,
for example), to track a user around the web.

Less well-known is that Tor also enables people to publish websites whose location
is very hard to find and whose users are hard to track. These "hidden sites" have
strange URLs consisting of seemingly random letters, and end in ``.onion``. While
some major companies publish sites as hidden services (for example,
`Pro Publica <https://www.propublica.org/nerds/item/a-more-secure-and-anonymous-propublica-using-tor-hidden-services>`_
and `Facebook <https://www.wired.com/2014/10/facebook-tor-dark-site/>`_),
the webserver configuration involved so far has been out of reach for most people.

With UBOS, it is simple.


Why you might consider publishing your site as a Tor hidden service
-------------------------------------------------------------------

First the downsides:

* Only the (small) number of people using a Tor-aware browser will be able to access
  your site.

* Because of all the bouncing around of traffic, your site will be much slower than
  a comparable, normal website.

* You can't pick a nice URL for your site; the URL will contain gibberish.

The upside:

* You can publish your site from behind your home's firewall without needing to
  make any configuration changes to your router, or needing your internet service
  provider's permission to run a web server from home.

* You can pack up the computer that runs your site, and plug it into any network
  anywhere, and the site will re-appear on the internet, without needing any
  configuration changes, DNS changes or the like.

And yes, there are `other things <https://en.wikipedia.org/wiki/Dark_web>`_ you can
do with Tor hidden services. Note that we make no warranties whatsoever that the
Tor configuration created by UBOS is safe to embark on any of those activities;
you should not rely on UBOS for your security, whether your motives are noble or not.

Setting up the Tor site
-----------------------

When you create the site, you simply add ``--tor`` to the ``ubos-admin createsite``
command. That's all. For example::

   ubos-admin createsite --tor

Then, answer the questions as usual about the web app or web apps you want to run at
that site. After UBOS is done, it will print out the Onion URL at which the site
will be accessible.

Note that:

* You can only access the site with a Tor-aware browser, such as the
  `Tor browser <https://www.torproject.org/projects/torbrowser.html.en>`_.

* You may need to wait for a few minutes from the time UBOS completes its work,
  until your Tor browser is able to find the site on the Tor network: securely
  advertising your site on the Tor network takes a little bit.

Privacy note
------------

Tor "onion" hostnames usually do not have DNS entries and cannot be resolved outside
of the Tor network. However, if somebody were to manually create such an entry that points
to your device's IP address (e.g. by adding it to your home router, to ``/etc/hosts``,
executing ``curl --resolve`` etc.), your device running the Tor site will serve the site
directly as well, without going through Tor.

This is not usually a problem if you run your Tor site from behind a firewall, like on
a typical home network. However, anybody who can send HTTP requests directly to your
device, such as anybody who can connect to your (typically configured) home WiFi network
can use this to test whether or not your device runs a specific Onion hidden service
by performing a direct HTTP request on your device with its dot-onion hostname.
