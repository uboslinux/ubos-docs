How to set up an SSL site
=========================

Running any kind of SSL site generally requires three steps:

#. Generating SSL keys;
#. Having a certificate authority (such as your domain name registrar) sign
   a certificate request you send them;
#. Configuring your site's web server with the SSL keys, the certificate you got
   back from the certificate authority, and the certificate chain they also sent you.

This process can be rather intimidating, but UBOS automates step 3, which is the most
confusing. Here are the steps you still need to do yourself:

Let's assume you want to run ``example.org`` with SSL. First, generate SSL keys::

   > openssl genrsa -out example.org.key 4096

Then, generate the certificate request::

   > openssl req -new -key example.org.key -out example.org.csr

This will ask you a few questions, and the generate ``example.org.csr``. Send
``example.org.csr`` to your certificate authority.

Once your certificate authority has approved your request, they typically send you
two files:

* the actual certificate. This file typically ends with ``.crt``, such as
  ``example.org.crt``.

* a file containing their certificate chain. This is the same for all of their
  customers, and might be called ``gd_bundle.crt`` (for GoDaddy, for example).

Unfortunately, different certificate authorities tend to call their files by
different names, and many are not exactly very good at explaining which is which.

Keep all of those files in a safe place. When you are ready to set up your new site,
invoke::

   > sudo ubos-admin createsite --ssl

and provide the location of the SSL files when asked.
( `FIXME <https://github.com/indiebox/ubos-admin/issues/6>`_ )
