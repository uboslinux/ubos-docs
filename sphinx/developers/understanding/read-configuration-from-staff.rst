``ubos-admin read-configuration-from-staff``
============================================

See also :doc:`../../users/ubos-admin` and :doc:`write-configuration-to-staff`.

This command will attempt to read an attached :doc:`UBOS staff </users/shepherd-staff>`
and configure the device based on information found there.

Based on the provided options, the command may read from a particular device, or to
attempt to automatically determine which attached device is a suitable UBOS staff.

This command is also performed automatically upon boot, unless disabled by setting
``ubos.readstaffonboot`` to false like this in file ``/etc/ubos/config.json``:

.. code-block:: json

   "ubos" : {
        "readstaffonboot" : false
    }

The following information is currently read from the UBOS staff:

* from directory ``shepherd/ssh/id_rsa.pub``, file ``id_rsa.pub`` will be used as the
  an authorized key for remote ssh access by the ``shepherd`` Linux user on the device.

Additional information may be read from the UBOS staff in the future.
