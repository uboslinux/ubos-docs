``ubos-admin listsites``
========================

See also :doc:`../../users/ubos-admin`.

This command iterates over all :doc:`../site-json` files for all sites currently
deployed on the device, and prints them in various formats and levels of detail,
as specified in the command-line options.

By default, the output is intended for human consumptions, but JSON output is supported
as well.

If invoked as root, all information available can be printed. If invoked as a non-root
user, credential information (such as passwords and TLS keys) are not printed.

See also :doc:`showsite` and :doc:`showappconfig`.
