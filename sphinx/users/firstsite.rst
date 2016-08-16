Setting up your first web app
=============================

Follow these steps:

#. Decide which web app to install. You can find the current set of available apps
   `here <http:/apps/>`_. In this example, we'll use Wordpress.

#. Decide at which URL you'd like to run the app.  In this example, we'll
   use host ``*`` and run Wordpress at relative path ``/blog``. By specifying ``*``,
   meaning "any", you have the most choices for which URL will work in your browser
   to access your new Wordpress installation:

   * you can use the IP address of your UBOS device. For example, if the IP address
     is ``192.168.1.10``, Wordpress will be reachable at ``http://192.168.1.10/blog/``

   * UBOS devices (not containers or cloud) use mDNS to advertise themselves on the
     local network. The name depends on the type of device:

     * if installed on a PC, Wordpress will be reachable at ``http://ubos-pc.local/blog/``

     * if installed on a Raspberry Pi Zero or 1, Wordpress will be reachable at
       ``http://ubos-raspberry-pi.local/blog/``

     * if installed on a Raspberry Pi 2 or 3, Wordpress will be reachable at
       ``http://ubos-raspberry-pi2.local/blog/``

     Unfortunately that only works on older versions of Windows if you have iTunes installed.
     It should work on all other devices out of the box, including Macs, Linux PCs, iOS and
     Android devices. Again, this option does not exist for running UBOS in a
     a Linux container or on Amazon EC2.

   * If your UBOS device has an official DNS entry on its own, you should use this one, because
     if gives you the opportunity to run multiple sites (with their own distinct apps) on
     the same device, like web hosting companies do with virtual hosting. This is the
     recommended option for running UBOS in the cloud.

   * If you are just trying out UBOS, you can fake DNS entry by editing your
     ``/etc/hosts`` file.

   See also :doc:`networking`.

#. As root, execute the following command:

   .. code-block:: none

      > ubos-admin createsite

   This command will ask a number of questions. Once you have answered them, it will
   appear to think for a while and then set up your new app. Here is an example transcript
   for beta8 (earlier betas asked questions in a different sequence):

   .. code-block:: none

      > sudo ubos-admin createsite
      ** First a few questions about the website that you are about to create:
      Hostname (or * for any): *
      Site admin user id (e.g. admin): admin
      Site admin user name (e.g. John Doe): admin
      Site admin user password (e.g. s3cr3t):
      Site admin user e-mail (e.g. foo@bar.com): root@localhost
      ** Now a few questions about the app(s) you are going to deploy to this site:
      First app to run (or leave empty when no more apps): wordpress
      Downloading packages...
      App wordpress suggests context path /blog
      Enter context path: /blog
      Any accessories for wordpress? Enter list:
      Next app to run (or leave empty when no more apps):
      Downloading packages...
      Deploying...
      Installed site sebbab46f26af24d677c955aabed8ae4e0186d4fc at http://*/

#. Access your new app. You can reach it directly by visiting the correct URL as described above.
   If you leave out the trailing ``/blog/``, you will see the list of apps installed at this
   site. Currently that is only Wordpress at path ``/blog/``. If you had continued entering
   additional apps in response to the question "Next app to run", UBOS would have installed
   more apps.

If you are curious what UBOS just did under the hood, please refer to
:doc:`/developers/understanding/createsite`.
