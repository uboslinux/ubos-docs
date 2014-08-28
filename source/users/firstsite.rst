Setting up your first web app
=============================

.. note:: Currently, you need to set up your own DNS.

   For example, if you create a site called ``foo.example.com``, you are responsible
   for making sure that ``foo.example.com`` resolves the the IP address of your
   UBOS device. You may be able to do this by editing your client machine's ``/etc/host``,
   or by configuring your home router or public DNS server.

   We'll do better, but not yet; bear with us.

Follow these steps:

#. Decide which web app to install. In this example, we'll use Wordpress.

#. Decide at which URL the web app will be installed. In this example, we'll
   use host ``family``.

#. Execute the following command::

      > sudo ubos-admin createsite

   This command will ask a number of questions, and once you have answered them, it will
   set up your new app. Here is an example transcript::

      > sudo ubos-admin createsite
      App to run: wordpress
      Hostname for app: family
      App wordpress suggests context path /blog
      Enter context path: /blog
      Any accessories for wordpress? Enter list:
      Site admin user id (e.g. admin): admin
      Site admin user name (e.g. John Doe): admin
      Site admin user password (e.g. s3cr3t):
      Site admin user e-mail (e.g. foo@bar.com): root@localhost

#. Access your new app. You can reach it directly by visiting ``http://family/blog/``, or
   you can see the list of apps installed at host ``http://family/``, and select Wordpress
   from there.
