Key design principles
=====================

Hardware
--------

* UBOS should be able to run on a wide variety of hardware.
* UBOS should be fully functional and usable in headless mode (without attached
  keyboard, mouse and monitor)
* UBOS should expose a consistent set of core conventions and APIs to application developers
  that does not depend on the underlying hardware.
* UBOS should not require WiFi, Bluetooth, or other wireless hardware. If available,
  UBOS should be able to take advantage of it.

Software
--------

* Provide a simple set of high-level administration commands in the shell that is
  structured around what the user wants to accomplish, not around how to do that.
* The same commands can maintain apps built with a wide variety of technologies
  (e.g. PHP vs Ruby vs Java vs Python etc., databases etc.)
* Fully support virtual hosting, and multiple apps at the same virtual host. Let users
  pick hostnames and context paths to the maximum extent possible.
* Make sure developers of different apps do not step of each other's feet, even if
  they aren't aware of each other.
* Users expect port 80 and port 443. Don't use other ports where users can see them.
* Administration via ssh instead of device agents. It's easier to bootstrap and maintain.
* The primary user interface is shell commands.
* Use Linux package management (i.e. ``pacman``) wherever possible.
* Can be pre-installed on boot medium (e.g. SD Card)
* Use good defaults which can be overridden if/when needed.
* Make automated testing possible / simple.

Economics of administration
---------------------------

* The larger cost is in ongoing maintenance, not in initial installation of apps,
  so automate maintenance as much as possible.

User centricity
---------------

* No backdoors.
* Free and libre to the maximum extent possible.
* No mandatory dependencies on "somebody else's website".
