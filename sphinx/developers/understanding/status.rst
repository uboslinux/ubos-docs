``ubos-admin status``
=====================

See also :doc:`../../users/ubos-admin`.

This command is intended as a general-purpose device status command. Eventually it
will emit "everything that's worth knowing about the state of the device".

Right now, this command knows how to report on the following topics:

* disk usage on the device
* memory usage on the device
* device uptime
* the list of configuration files that were manually modified on the device, and need
  to be manually reconciled, e.g. due to an upgrade.
