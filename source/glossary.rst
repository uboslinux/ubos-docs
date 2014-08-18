Terms
=====

To avoid confusion, here is a glossary of terms that we use for UBOS.

.. glossary::

   Arch Linux
      A rolling-release GNU/Linux distribution developed at
      http://archlinux.org/ and ported to various ARM architectures at
      http://archlinuxarm.org/

   Channel
      A maturity level for an UBOS release. See also :doc:`developers/buildrelease`.
      UBOS is developed on channel ``red``, which contains bleeding-edge,
      untested "alpha" quality code. Channel ``yellow`` corresponds to
      traditional "beta" code, while ``green`` is the production channel.
      End users almost always will subscribe to ``green``, while
      developers will do most of their work on ``red`` and ``yellow``.

   Device
      Any physical or virtualized computer running UBOS. This could be
      a Raspberry PI, an x86 server, or an instance on Amazon EC2 or
      locally on your desktop running VirtualBox.

   Repository
      A collection of :term:`packages <Package>`. For example, the UBOS
      ``tools`` repository contains tools useful to the developer, but
      not to the end user. By default, system do not use the ``tools``
      repository, but developers can easily add it to take advantage
      of the provided development tools.

   Package
      A set of code components that logically belong together.

