Verify your downloaded UBOS image
=================================

You can verify that your UBOS image downloaded correctly by verifying its digital signature.
To do this, you need to have Gnu Privacy Guard (``gpg``) and ``curl`` installed on the machine
to which you downloaded the UBOS image.

#. Download the file containing the digital signature for your image. The signature file
   can be found at the same URL as the image, with ``.sig`` appended.

   For example, if you downloaded your image from
   ``http://depot.ubos.net/yellow/x86_64/images/ubos_yellow_x86_64-vbox_XXX.vmdk.xz``,
   the corresponding signature file will be at
   ``http://depot.ubos.net/yellow/x86_64/images/ubos_yellow_x86_64-vbox_XXX.vmdk.xz.sig``.

#. Import the UBOS GnuPG public key into your keychain:

   .. code-block:: none

      % curl -L https://github.com/uboslinux/ubos-admin/raw/master/ubos-keyring/ubos.gpg | gpg --import

#. Verify the download by invoking ``gpg --verify`` with the downloaded signature file as
   the first argument, and the image file as the second:

   .. code-block:: none

      % gpg --verify ubos_yellow_x86_64-vbox_XXX.vmdk.xz.sig ubos_yellow_x86_64-vbox_XXX.vmdk.xz

   If everything checks out, it will print:

   .. code-block:: none

      gpg: Signature made ...
      gpg: Good signature from "UBOS buildmaster <buildmaster@ubos.net>"
      gpg: ...

   You can ignore any message about "no indication that the signature belongs to the owner".

   If there was a problem, it will print:

   .. code-block:: none

      gpg: Signature made ...
      gpg: BAD signature from "UBOS buildmaster <buildmaster@ubos.net>"

