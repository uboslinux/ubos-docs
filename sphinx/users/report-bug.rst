How to report a bug or issue
=============================

You faithfully followed the instructions, but UBOS does not do what you think it should
be doing? You might have encountered a genuine bug. Sorry about that.

But unless you tell us about it, we can't fix it! So we encourage you to file bugs and
issues.

If you are not sure it is a bug or issue
----------------------------------------

Go to the `UBOS Forum <https://forum.ubos.net/>`_, select the forum that corresponds to
the platform that you are running UBOS on, and post your observations there. Even if
you aren't sure you have run into a bug, or just have a question, please continue reading
"What to put into a good bug report" on this page. If you follow these guidelines, it
makes our life easier and you are more likely going to get useful help.

Where to report a bug or issue
------------------------------

UBOS source code and related issues are managed at
`github.com/uboslinux <https://github.com/uboslinux>`_. Go there, then select the most
appropriate UBOS sub-project for your bug, and then click on "Issues". If you are uncertain
which is the most appropriate project, file your issue in the
`ubos-admin project <https://github.com/uboslinux/ubos-admin/issues>`_.

Before you do that, however, it would be nice if you first read through the already-filed
open issues, so we have to spend less time weeding out duplicates and can spend more time
actually fixing bugs.

What to put into a good bug report
----------------------------------

The goal of a good bug report is to make it crystal clear to the developer what exact
series of steps they need to take so they can reproduce your bug. If developers have to guess
what exactly you did to experience the problem, it costs them lots of time and makes them
unhappy. It also makes it more likely that your bug will closed as invalid with
"cannot reproduce" as a comment.

Here is an example for a really bad bug report for a hypothetical calculator app: "Your
calculator app is broken, it sometimes miscalculates!". It's completely unclear what
the user did, or what calculation went wrong. There is nothing the developer can do in response
than to close the bug as invalid.

Here's an example for a better bug report for the same hypothetical calculator app:
"Running your calculator app in version 2.3.4a9 on a MacBook Pro 15in 2015, OSX 10.2.3,
8G RAM, with no other apps running at the time, I enter AC, 1, +, 1, and =. The calculator
prints 3. I was expecting 2." See the difference? Here, developers know exactly what they
need to the reproduce the problem, and if they can reproduce the problem, they can starting
fixing it immediately.

Suggested reporting template for UBOS issues
--------------------------------------------

When you file an issue on Github, it would be nice if you could fill out as much as
possible of the information shown below:

* **Title**: a concise title for your issue

* **Device**: PC, or Raspberry Pi Zero W, or ... the more specific you can be the better

* If you have any peripherals attached to your device (like an external disk or WiFi
  dongle, please report those, too)

* **Booting from**: on some devices (like a PC), you can boot UBOS from a USB stick or
  an internal disk. Please tell us which you are using.

* If you run UBOS in a Linux container, tell us about:

  * **Host device**: e.g. Acer xyz laptop, 16G RAM, ...

  * **Host operating system**: e.g. Ubuntu 17.10

  * **The exact command** you used to start your container.

* **The exact command** you invoked, or the exact action you took that caused the problem.

* **What happened** that you think is a problem. If, for example, you invoked a command
  and its output looks wrong, paste the actual command output into the report.

* **What should have happened** in your opinion. Sometimes, for example, there is bug in
  the documentation, rather than in the code. So tell us what you thought should have
  happened as well, not just what did happen.

* If there is any chance that your issue is caused by something you did before, please
  do tell what that was.

* Provide as much contextual info as possible. For example, if the problem occurred right
  after you booted a freshly installed system, say so. Or, if a command that you executed
  dozens of times before on a long-running device suddenly starts misbehave, tell us that,
  too.

* If there is any particular data we might need to have to reproduce the issue, please
  attach that data (assuming you are willing to publicly share that data, as all UBOS
  issues filed on Github are public).

* For almost all issues, it is useful to attach the output of the following command to
  the report. Note: do not invoke this as root, so it will not print passwords:

  ``ubos-admin listsites --json``
