``ubos-admin listsites``
========================

This command lists the sites, apps and accessories currently installed on this
device. For example::

   > ubos-admin listsites
   Site: example.com (s20da71ce7a6da5500abd338984217cdc8a61f8de)
       Context:           /guestbook (ab274f22ba2bcab61c84e78d944f6cdd7239a999e): gladiwashere
       Context:           /blog (a9eef9bbf4ba932baa1b500cf520da91ca4703e26): wordpress
   Site: example.net (s7ad346408fed73628fcbe01d777515fdd9b1bcd2)
       Context:           /foobar (a6e51ea98c23bc701fb10339c5991224e2c75ff3b): gladiwashere

On this device, two sites (aka virtual hosts) are hosted. The first site, responding
to ``example.com``, runs two apps: the Glad-I-Was-Here guestbook, and Wordpress, at the
URLs ``http://example.com/guestbook`` and ``http://example.com/blog``,
respectively. The second site at ``example.net``, runs a second, independent instance
of Glad-I-Was-Here at ``http://example.net/foobar``.

By default, the output is intended for human consumptions. but JSON output is supported
as well.

This command can also be used to show the sites, apps and accessories whose data
is contained in an :doc:`/developers/ubos-backup` file.

See also :doc:`showsite` and :doc:`showappconfig`.

