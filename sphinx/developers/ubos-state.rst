UBOS state
==========

State diagram
-------------

A device running UBOS can be thought of as always being in a particular state. The following
diagram shows these as a state chart:

.. image:: /images/ubos-state.png
    :align: center
    :alt: UBOS state chart

A UBOS device can either be Powered Off, or Powered On. When Powered On, initially
it is booting, until it is Booted, and in state Operational. When ``ubos-admin`` is
executed and while it is running, the device is In Maintenance. Once ``ubos-admin``
completes, the device goes back to being Operational. The device can further be
Shutting Down, going back to Powered Off, or, if it is being rebooted, back to
Booting.

State transitions
-----------------

When UBOS transitions from one state to another, it invokes callbacks defined in
``/etc/state-callbacks``. Callbacks are defined as follows:

* Each file in ``/etc/state-callbacks`` defines one callback
* Each callback file consists of a single line with the fully-qualified name of a
  Perl module with optional arguments that are passed-on verbatim, e.g.
  ``Some::Where::Callback a 17``.
* The Perl class must have a subroutine called ``stateChanged``, which will be invoked
  when the device state changes. Arguments to the subroutine are:
  * the name of the new state
  * the remaining arguments from the callback file
  So in this example, the invocation may be
  ``Some::Where::Callback::stateChanged( 'Operational', 'a', 17 );``

The values for the states are the same as the most-detailed states shown in the diagram,
except that blanks are removed: ``BootingOrShuttingDown``, ``Operational``, ``InMaintenance``.
For obvious reasons, there is no programmatic way of ever accessing state Powered Off.

Mapping to LED colors
---------------------

For devices that support this, the UBOS state is indicated by the following colors:

+-----------------------+---------------------------------------+---------------------------+
| Device                | State                                 | LED Color                 |
+=======================+=======================================+=============+=============+
| Intel NUC (x86_64 pc) | Powered Off                           | Power: red  | Ring: off   |
|                       +------------+--------------------------+-------------+-------------+
|                       | Powered On | Booting or Shutting Down | Power: blue | Ring: off   |
|                       |            +--------------------------+             +-------------+
|                       |            | Operational              |             | Ring: blue  |
|                       |            +--------------------------+             +-------------+
|                       |            | In Maintenance           |             | Ring: red   |
+-----------------------+------------+--------------------------+-------------+-------------+
| ESPRESSObin with      | Powered Off                           | Off                       |
| custom RGB LED        +------------+--------------------------+---------------------------+
| (aarch64 espressobin) | Powered On | Booting or Shutting Down | Green                     |
|                       |            +--------------------------+---------------------------+
|                       |            | Operational              | Blue                      |
|                       |            +--------------------------+---------------------------+
|                       |            | In Maintenance           | Red                       |
+-----------------------+------------+--------------------------+---------------------------+
