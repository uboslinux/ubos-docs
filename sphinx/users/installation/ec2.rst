Run UBOS on an Amazon Web Services EC2 virtual server
=====================================================

To run UBOS on EC2, click on
`this link <https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-6cdb417b>`_
and follow the Amazon wizard.

Here are some recommended values for the parameters that Amazon wants you to specify.
However, UBOS is not very picky, so many different values should work as well.

* Choose an instance type based on your budget and requirements. To try out UBOS
  and for personal sites, a "Free Tier" server should be sufficient.

* Keep the root disk at 16GB. Magnetic is cheapest and fine for most personal sites.

* Name it whatever you like.

* You need to open the SSH, HTTP and HTTPS ports, otherwise you won't be able
  to log into your server or access web apps it runs. Create a security rule
  that reflects that.

* Create a new key pair unless you have a suitable one already. Name it
  "UBOS shepherd" if you like. Download the private key and save it on your
  local machine in a secure place. If you are on a Mac or a Linux box,

  .. code-block:: none

     chmod 400 <your-key-file>

  is a good idea.

Once your server has booted:

#. Determine its public IP address. Then ssh into it as user ``shepherd``:

   .. code-block:: none

      > ssh -i <your-key-file> -l shepherd <ip>

#. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready
   to use and initialize a few other things on the first boot. That might a little bit.
   To determine whether UBOS ready, execute:

   .. code-block:: none

      > systemctl is-system-running

#. Update UBOS to the latest and greatest:

   .. code-block:: none

      > sudo ubos-admin update

#. You are now ready to :doc:`set up your first app and site </users/firstsite>`.
