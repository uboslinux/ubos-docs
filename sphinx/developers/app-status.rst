Format of the App Status JSON
=============================

:term:`Apps <App>` may optionally declare an executable or script that, when invoked, reports
status information of the :term:`AppConfiguration` on which it is applied. This is
further described in the UBOS Manifest JSON's :doc:`manifest/roles`.

The format of the emitted JSON, for now, is very simple. The :term:`App` currently
can only convey whether it is operational or not, by emitting:

.. code-block:: json

   {
     "status" : "operational"
   }

or

.. code-block:: json

   {
     "status" : "failed"
   }

