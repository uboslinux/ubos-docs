Creating random values
======================

Some apps require random, or secret values that need to be different for
each installation. For example, such a value may be used to salt the
cookies of a web application.

UBOS provides the following mechanisms to create random values. All of them
take a single integer number as an argument, which specifies the desired length.

For example, ``${randomHex(8)}`` might generate ``4f218aab``.

``randomHex``
   Generates a random hexadecimal number.

   Example: ``4f218aab``

``randomIdentifier``
   Generates a random identifier consisting of lower-case letters.

   Example: ``fokhngly``

``randomPassword``
   Generates a random password consisting of letters and numbers
   (but not special characters).

   Example: ``GGs5PCMK``

If you need to generate different kinds of random values, you can always
do that in an :doc:`Perl script <perlscript>`.
