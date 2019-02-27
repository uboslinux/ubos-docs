``ubos-admin list-data-transfer-protocols``
===========================================

See also :doc:`../../users/ubos-admin`.

UBOS supports an open-ended list of "data transfer protocols", implemented as subclasses
of ``UBOS::AbstractDataTransferProtocol``, and found in Perl package
``UBOS::DataTransferProtocols``. Each one knows how to transfer a local file to
a (local, or more likely, remote) destination.

This command discovers which of those data transfer protocols are available on the
:term:`Device` and shows them to the user with some descriptive text.

The same mechanism is used by ``ubos-admin backup`` to determine whether a given
backup destination is valid.

See also: :doc:`backup`.
