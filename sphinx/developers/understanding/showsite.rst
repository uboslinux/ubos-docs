``ubos-admin showsite``
=======================

This command lists information about one single site on this device.

It is useful to determine, for example, the set of all applications installed
at a particular site. For example::

   > ubos-admin showsite --host example.com
   Site: foobar (s20da71ce7a6da5500abd338984217cdc8a61f8de)
       Context:           /blog (a9eef9bbf4ba932baa1b500cf520da91ca4703e26): wordpress

By default, the output is intended for human consumptions. but JSON output is supported
as well.

See also :doc:`showappconfig` and :doc:`listsites`.

