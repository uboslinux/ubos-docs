How to use SSH
==============

SSH is a widely used software package to securely log into other computers anywhere on
the internet, to securely transfer files back and forth, and a few other things.

It is used by UBOS for remote systems administration, and for secure file upload or
download.

Installation
------------

Linux
^^^^^

SSH is typically pre-installed on Linux, regardless which distribution you are using.
If not, it should definitely be in your distro's package repositories and can be installed
like any other optional package.

On the terminal, type: ``ssh``

MacOS
^^^^^

SSH is pre-installed on the Mac.

On the terminal, type: ``ssh``

Windows
^^^^^^^

Various implementations of SSH exist on Windows, for example `Putty <http://www.putty.org/>`_.
A web search may find others.

Basic usage
-----------

To use SSH to log into a remote computer, such as a UBOS device, you need to know the
device's hostname or IP address.

You also need a credential that only you know, to prevent others from logging into the UBOS
device. While SSH supports logins with usernames and passwords, this functionality is disabled
in UBOS by default for security reasons. Instead, you need to use an SSH key pair. If you
do not have an SSH key pair yet, see below.

To log on to the UBOS device with the default SSH key pair, assuming ``<HOST>`` is the
hostname or IP address of the UBOS device:

.. code-block:: none

   % ssh shepherd@<HOST>

To log on to the UBOS device with a non-default SSH key pair, assuming ``<KEYFILE>`` is
the name of the SSH private key file (the one that does NOT end in ``.pub``:

.. code-block:: none

   % ssh -i <KEYFILE> shepherd@<HOST>

Once you are logged on, your can execute the various UBOS administration commands over
the network, such as ``ubos-admin listsites``.

How to generate an SSH key pair
-------------------------------

If you use the :doc:`shepherd-staff`, UBOS can generate an SSH key pair automatically upon
the boot of your UBOS device. This is documented there. If you do so and copy the private
key to your computer, make sure you secure access to the private key file (usually
called ``id_rsa``). This is important because anybody who has access to this file can
access your UBOS device just as well as you can. It is also important because SSH does
not let you use the file if it is not properly secured. On Mac or Linux, you want to
execute:

.. code-block:: none

   % chmod 600 id_rsa

To manually generate a new SSH key pair, on Linux or macOS, execute:

.. code-block:: none

   % ssh-keygen

and answer the questions that program asks. Make a note where you saved your new key
pair, so you can enter the correct filename when you need it.

What is an SSH key pair?
------------------------

An SSH key pair consists of two files, usually called ``id_rsa`` and ``id_rsa.pub``.
The first one of these files contains the "private key" and the second one the "public key".
Together, they form an SSH key pair.

The "private key" is your key to the kingdom. Anybody who has access to the private key
can log on to a remote UBOS device that uses this key pair.

The "public key", on the other hand, can be freely shared. You can post it on the internet
and your UBOS device will still be secure.

It is the magic of public key cryptography that you can prove to anybody who has access
to the public key, that you are in possession of the private key. Conversely, anybody
who does not have access to the private key cannot impersonate you because they cannot
prove they have possession of the private key. This all occurs without anybody other than
you ever having access to the private key.

So the UBOS device, to which you want to log on, has access to the public key, but not
the private key. Only you have access to the private key. This way, the UBOS device can
make sure only you can log on via SSH, and nobody else.
