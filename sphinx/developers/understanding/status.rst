``ubos-admin status``
=====================

See also :doc:`../../users/ubos-admin`.

This command is intended as a general-purpose device status command. Eventually it
will emit "everything that's worth knowing about the state of the device".

Right now, it only knows how to emit one thing: the list of configuration files that
were manually modified on the device, and need to be manually reconciled due to an
upgrade.
