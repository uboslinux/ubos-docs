``ubos-admin setup-shepherd``
=============================

See also :doc:`../../users/ubos-admin`.

This command makes it easier to set up a UBOS shepherd account without using the UBOS
staff. This may be advantageous when running UBOS in a Linux container.

This command:

* creates the ``shepherd`` account if it does not exist yet (see
  :doc:`../../users/shepherd-staff`) and gives it system administration capabilities
  to be invoked via ``sudo``.
* If one or more public ``ssh`` keys are provided, either adds or replaces them on
  the ``shepherd`` account so the user can log in over the
  network (``~shepherd/.ssh/authorized_keys``).

This command must be run as root (``sudo ubos-admin setup-shepherd``).
