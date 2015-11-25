Key Concepts
============

UBOS is built around a small number of key concepts, which are essential for understanding
how application management works in UBOS, and how apps have to behave so they can be
managed. These concepts are:

* apps
* accessories
* sites
* app configurations, and
* app configuration items.

They are described below:

Apps
----

For UBOS purposes, an app is a software application that provides direct value to the
user without any further additions, integrations or customizations. Apps generally have
software dependencies only on infrastructure and platform software such as databases,
web servers, middleware, operating system etc.

UBOS is mostly focused on web apps, i.e. apps whose primary user interface is presented
using a web browser. Some examples for what UBOS would call apps are:

* ​Wordpress (blogging and publishing)
* ​Mediawiki (collaborative knowledge management)
* OwnCloud (file sharing).

Accessories
-----------

UBOS also supports what we call accessories. An accessory is a software module that adds
to or modifies the functionality of an app. Accessories cannot be used on their own, without
an app that they belong to.

Outside of UBOS, accessories have a variety of names including plugins, themes, skins, extensions,
add-ons and the like. We use the term "accessory" as a consistent, common term for all of those.

Examples for what UBOS would call accessories are:

* Themes or skins that change the graphic layout of Wordpress
* A module that requires users to fill out a captcha before they can register for a wiki
* A module that adds a Facebook Like button to some web pages in an app.

The UBOS repositories contains both apps and accessories. The process for creating
an installable UBOS package is largely the same for apps and accessories.

Sites and AppConfigurations
---------------------------

In UBOS terminology, a "site" is the collection of apps (and, optionally, accessories) that
run at the same DNS hostname. Several such sites may run on the same device. We call each
installation of an app (and, optionally, its accessories and values for customization points)
an AppConfiguration.

The following table shows the relationship between a device, the sites running on the device,
and the apps and AppConfigurations on each site. (It leaves out accessories.)

.. table:: Device, sites and AppConfigurations

   +-----------------------------------------------------+
   | Apache (listening on either port 80 or 443)         |
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

AppConfigurationItems
---------------------

An AppConfigurationItem is a file, directory, database or other item that needs to exist
before an AppConfiguration is functional. Most apps and accessories require a number of
AppConfigurationItems.

For example, an installation of Wordpress (aka an AppConfiguration of Wordpress) requires
the following AppConfigurationItems:

* File ``index.php`` in the web server directory
* Directory ``wp-admin`` in the web server directory
* Many other files and directories in a similar manner
* A MySQL database

Apps and accessories declare which AppConfigurationItems they require, and some of their
properties in the app's or accessory's :doc:`ubos-manifest`. When an AppConfiguration is deployed, UBOS
automatically installs the declared AppConfigurationItems, and removes them again when
the AppConfiguration is undeployed.
