``ubos-admin showappconfig``
============================

This command lists information about one single AppConfiguration on this device.

It is useful to determine, for example, information about a particular AppConfiguration,
given a hostname and a context. For example::

   > ubos-admin showappconfig --host example.com --context /blog
   AppConfiguration: /foobar (a9eef9bbf4ba932baa1b500cf520da91ca4703e26)
       app:      wordpress

By default, the output is intended for human consumptions. but JSON output is supported
as well.

See also :doc:`showsite` and :doc:`listsites`.

