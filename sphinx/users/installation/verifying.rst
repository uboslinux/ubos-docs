Verify your downloaded UBOS image
=================================

You can verify that your UBOS image downloaded correctly by verifying its digital signature.

#. Download the sig file corresponding to your image.  For example, If you downloaded your image from
     ``http://depot.ubos.net/yellow/x86_64/images/ubos_yellow_vbox-x86_64_20161109-220216.vmdk.xz``,
     then you can download the signature file from
     ``http://depot.ubos.net/yellow/x86_64/images/ubos_yellow_vbox-x86_64_20161109-220216.vmdk.xz.sig``.

#. Import the UBOS GnuPG public key.

   .. code-block:: none

      > wget -O - https://github.com/uboslinux/ubos-admin/raw/master/ubos-keyring/ubos.gpg | gpg --no-default-keyring --keyring vendor.gpg --import

#. Verify the download.

   .. code-block:: none

      > gpg --no-default-keyring --keyring vendor.gpg --verify ubos_whatever.img.xz.sig ubos_whatever.img.xz

   If everything checks out, this will print

   .. code-block:: none

      gpg: Signature made ...
      gpg: Good signature from "UBOS buildmaster <buildmaster@ubos.net>"
      gpg: ...

   If there was a problem, it will print

   .. code-block:: none

      gpg: Signature made ...
      gpg: BAD signature from "UBOS buildmaster <buildmaster@ubos.net>"
