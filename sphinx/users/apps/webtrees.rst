Notes on Webtrees (App ``webtrees``)
====================================

Must used named host, wildcard is unsupported
---------------------------------------------

Webtrees' configuration requires a hostname. It cannot run on "wildcard" (``*``)
hosts.

UBOS currently does not have any mechanisms to prevent the user from installing
Webtrees at the wildcard host, nor is there any error message.

See also `this issue <https://github.com/uboslinux/ubos-app-webtrees/issues/13>`_.
