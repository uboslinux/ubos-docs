Node.js notes
=============

Node.js versions
----------------

It seems every Node.js application requires a different Node.js version. There is
the most recent version of Node.js, the most recent LTS ("long-term stable") version,
and typically several older LTS versions are also still in widespread use. Some
apps even depend on specific minor or patch releases.

UBOS provides the latest LTS version in a package but, realistically, UBOS
cannot bundle all other versions. So what is an app developer to do?

UBOS and NVM
------------

The Node Version Manager (NVM) was created to solve a variant of this problem,
but not this problem exactly: by manipulating the user's ``$PATH`` and a user-specific
configuration file (by default, ``~/.nvm``), ``nvm`` enables the user to use a
Node.js version of their choosing during development.

That's great, but it is not so obvious how to use NVM for production deployments in which
multiple Node apps from multiple vendors, using different Node.js versions have to coexist
on the same device, running as system services, rather than something individual users run
from the home directories.

So UBOS defines some additional conventions. Some apply at package build time, and
some at package runtime (i.e. on the user's UBOS :term:`Device`).

At build time
^^^^^^^^^^^^^

Apps that depend on a particular Node.js version should:

* declare a build dependency (``makedepends``) on NVM (package ``nvm``).

* in the ``prepare`` section of their ``PKGBUILD``, locally install the Node.js version
  they require, with the defaults for the current user. For example: ``nvm install 8.12.0``.

* build the package as intended, bundling any dependent modules as part of their
  own package. In other words, do not refer to Node.js modules outside of what
  is part of the installation of this version by ``nvm`` and the app itself.

* bundle the particular Node.js version as part of their own app package.

At run time
^^^^^^^^^^^

Apps that depend on a particular Node.js version should:

* run the Node.js version that they bundled as part of their own package.

Example
^^^^^^^

To see how this works in practice, consider the Mastodon package for UBOS at
`github.com/uboslinux/ubos-mastodon <https://github.com/uboslinux/ubos-mastodon/>`_.

In its ``PKGBUILD`` file, the ``prepare()`` function installs the needed Node.js
version into a local directory, using ``nvm``, like this:

.. code-block:: none

   NVM_DIR=$(pwd)/nvm nvm install ${NODE_VERSION}

where ``NODE_VERSION`` is previously defined in this file. Then, during
``package()``, this version of Node.js gets packaged with the app as part
of this command:

.. code-block:: none

   cp -a ${srcdir}/${pkgname}-${pkgver}/* ${pkgdir}/ubos/share/${pkgname}/mastodon/

And finally, the Systemd daemon invocation runs the bundled version of Node.js (see
file ``systemd/mastodon-streaming@.service``):

.. code-block:: none

   ExecStart=/ubos/share/mastodon/mastodon/nvm/versions/node/v8.15.1/bin/node /usr/bin/npm --scripts-prepend-node-path=auto run start

