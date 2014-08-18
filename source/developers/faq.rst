Developer FAQ
=============



.. _faq_arch_ubos_rel:

What is the relationship between UBOS and Arch Linux?
-----------------------------------------------------

UBOS is both a subset and a superset of Arch Linux:

 * UBOS only includes a subset of the Arch Linux packages. For example, UBOS has picked
   Apache2 as its (current) web server and thus does not provide any other web servers.
 * UBOS provides packages such as :doc:`/packages/ubos-admin` for one-command device
   administration, which are not available on Arch Linux.

UBOS also performs additional testing, and follows the :doc:`buildrelease`.
