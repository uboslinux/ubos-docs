Testing UBOS apps
=================

About ``webapptest``
--------------------

It's very important that apps on UBOS deploy correctly, undeploy cleanly, and that
their data can be reliably backed up, restored, and migrated when your app moves
to a new version. We do not ever want to ask a user to "fix the app installation" manually
if we can help it.

To aid in testing this, we use a test tool called ``webapptest`` (source is
`here <https://github.com/uboslinux/ubos-tools/tree/master/webapptest>`_), which has been
written specifically for this purpose. ``webapptest`` is not a regular application testing tool;
it is not intended to find out whether, say, your app runs nicely in Internet Explorer.
Instead, it focuses on testing installation, uninstallation, backup and restore; something
typical testing tools don't focus on.

Example: Testing Glad-I-Was-Here locally
----------------------------------------

To test the Glad-I-Was-Here toy application with all the default settings, run:

.. code-block:: none

   > webapptest run GladIWasHereTest1.pm

(see `GladIWasHereTest1.pm here <https://github.com/uboslinux/ubos-toyapps/blob/master/gladiwashere/tests/GladIWasHere1Test.pm>`_)

This will go through a series of steps deploying ``gladiwashere`` on your local device,
interacting with the app by filling out a guestbook entry, backing up the app data,
undeploying the app, re-deploying and restoring from backup.

The exact steps depend on the test plan you are using. To see available test plans,
execute:

.. code-block:: none

   > webapptest listtestplans
   backup-all-states  - Creates a local backup file for each State.
   default            - Walks through all States and Transitions, and attempts to backup and restore each State.
   deploy-only        - Only tests whether the application can be installed.
   deploy-update      - Tests whether the application can be installed and updated.
   redeploy           - Tests that the application can be re-deployed after install at different hostnames.
   restore-all-states - Restores from a local backup file for each State, and tests upgrade.
   simple             - Walks through all States and Transitions in sequence.
   well-known         - Walks twice through all States and Transitions in sequence, checking well-known site fields only.

To employ a test plan that is not the default, specify ``--testplan <name>`` as an argument
to ``webapptest``.

Alternate scaffolds
-------------------

``webapptest`` also knows the notion of a scaffold. To show the available scaffolds, execute:

.. code-block:: none

   > webapptest listscaffolds
   container - A scaffold that runs tests on the local machine in a Linux container.
   here      - A trivial scaffold that runs tests on the local machine without any insulation.
   ssh       - A scaffold that runs tests on the remote machine that is already set up, and accessible via ssh.
   v-box     - A scaffold that runs tests on the local machine in a VirtualBox virtual machine.

If using ``webapptest`` with the ``here`` scaffold, ``webapptest`` deploys the to-be-tested
app on the local device (which needs to run UBOS). By using the ``ssh`` scaffold, the to-be-tested
app can be tested on a remote device over ssh. This is particularly useful for cross-platform
testing. The ``v-box`` scaffold sets up and tears down an entire UBOS virtual machine for
the test. This is only available on x86_64. Finally, the ``container`` scaffold creates a
Linux container into which UBOS and the to-be-tested app will be installed, using
``systemd-nspawn``.

Some of these scaffolds need parameters (e.g. the hostname of the ssh host or the image to boot
from), which are specified by appending them to the name of the scaffold like this:

.. code-block:: none

   > webapptest run --scaffold container:directory=/build/my-ubos-image-dir


Test description
----------------

To define a test for webapptest, follow the example in
`GladIWasHereTest1.pm <https://github.com/uboslinux/ubos-toyapps/blob/master/gladiwashere/tests/GladIWasHere1Test.pm>`_.

The essence of the test description is a series of states and transitions between them. The
states are states (with different data) that the application can be in. In ``GladIWasHereTest1``,
those are:

* ``virgin``: the app has just been deployed, and nobody has filled out a guestbook entry yet
* ``comment-posted``: a single comment has been posted

Obviously, depending on the application, many more states can be defined.

Transitions capture instructions for how ``webapptest`` can move the application from one
state to another. Here, we have only one, called ``post-comment``, which contains the
code to post a guestbook entry.

The essence of the test are the ``getMustContain`` and similar statements in the states.
``getMustContain`` will perform an HTTP GET operation on the provided URL (relative to
the location at which the app was installed), and make sure that the received content
contains a certain pattern. If not, it will print the provided error message.

The full API is `here <https://github.com/uboslinux/ubos-tools/blob/master/webapptest/vendor_perl/UBOS/WebAppTest/TestContext.pm>`_.
