Verify your downloaded UBOS image
=================================

You can verify that your UBOS image downloaded correctly.

#. Download the sig file corresponding to your image ``ubos_whatever.img.gz.sig``.

#. Import the UBOS GnuPG public key.

   .. code-block:: none

      > wget -O - https://github.com/uboslinux/ubos-admin/raw/master/ubos-keyring/ubos.gpg | gpg --no-default-keyring --keyring vendor.gpg --import

#. Verify the download.

   .. code-block:: none

      > gpg --no-default-keyring --keyring vendor.gpg --verify ubos_whatever.img.xz.sig ubos_whatever.img.xz
