``ubos-admin setup-shepherd``
=============================

See also :doc:`../../users/ubos-admin`.

This command makes it easier to set up a UBOS shepherd account without using the UBOS
staff. This may be advantageous when running UBOS in a Linux container.

This command:

* creates the ``shepherd`` account if it does not exist yet (see
  :doc:`../../users/shepherd-staff`)
* either adds or replaces ``ssh`` public keys with which the user can log in over the
  network (``~shepherd/.ssh/authorized_keys``).

