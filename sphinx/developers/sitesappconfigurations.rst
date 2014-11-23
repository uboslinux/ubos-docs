Sites and AppConfigurations
===========================

In UBOS terminology, a site is the collection of apps (and, optionally, accessories) that
run at the same DNS hostname. Several sites may run on the same device. We call each
installation of an app (and, optionally, its accessories and values for customization points)
an AppConfiguration.

The following table shows the relationship between a device, the sites running on the device,
and the apps and AppConfigurations on each site. (It ignores accessories.)

.. table:: Device, sites and AppConfigurations

   +-----------------------------------------------------+
   | Apache (listening on port 80 and 443)               |
   +========================+============================+
   | Site 1: example.com    | Site 2: example.net        |
   +------------------------+----------------------------+
   | AppConfiguration 1a:   | AppConfiguration 2a:       |
   | Wordpress at ``/blog`` | Wordpress at ``/blog``     |
   +------------------------+----------------------------+
   | AppConfiguration 2a:   | AppConfiguration 2b:       |
   | Mediawiki at ``/wiki`` | Wordpress at ``/news``     |
   +------------------------+----------------------------+

In this example, DNS has been configured to resolve several distinct DNS hostnames to the
(same) IP address of the device, including ``example.com`` and ``example.net``. UBOS
has automatically configured Apache virtual hosts ``example.com`` and ``example.net``.

At each site aka virtual host, one or more apps may be installed. Each of those installations
of an app at a site is called an AppConfiguration in UBOS terminology. In this example:

* Site 1 runs Wordpress at ``http://example.com/blog`` (AppConfiguration 1a), while Mediawiki runs
  at ``http://example.com/mediawiki`` (AppConfiguration 1b).
* Site 2 runs two Wordpress installations at ``http://example.net/blog`` and
  ``http://example.net/news``.

Note that in this (contrived) example, the device runs three entirely separate Wordpress
installations, each of which has its own database/content, and configuration in terms of
title, customizations, installed accessories etc. Two of them share a hostname, but otherwise
they are entirely distinct. UBOS web applications are generally encouraged to be able to run
in multiple instances on the same device; however, that is not a requirement.

In other words, UBOS fully supports virtual hosting.
