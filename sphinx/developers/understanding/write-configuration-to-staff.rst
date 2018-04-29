``ubos-admin write-configuration-to-staff``
===========================================

See also :doc:`../../users/ubos-admin` and :doc:`read-configuration-from-staff`.

This command will attempt to write the device's current configuration to an attached
:doc:`UBOS staff </users/shepherd-staff>`.

Based on the provided options, the command may write to a particular device, or to
attempt to automatically determine which attached device is a suitable UBOS staff.

The following information is currently written to the UBOS staff:

* in directory ``flock/<hostid>/ssh``, file ``ssh_host_key.pub`` will contain the
  device's SSH host key, where ``<hostid>`` is the device's host id (i.e. the fingerprint
  of the device's public GPG key)

Additional information may be written to the UBOS staff in the future.

This command must be run as root (``sudo ubos-admin write-configuration-to-staff``).
