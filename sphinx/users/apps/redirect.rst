Notes on utility app Redirect (App ``redirect``)
================================================

App Redirect sends the user's browser to some other URL that is
specified as a :term:`Customization Point`.

Two approaches to using Redirect can be taken. Assume that Redirect is deployed to
:term:`Site` ``example.com``:

* If the ``target`` :term:`Customization Point` is set to ``http://example.net/path``,
  all URLs below ``example.com`` will be redirected to the same target
  ``http://example.net/path``.

  For example, ``http://example.com/`` and ``http://example.com/somewhere``
  will both be redirected to ``http://example.net/path``.

* If the ``target`` :term:`Customization Point` is set to ``http://example.net/path/$1``,
  all URLs below ``example.com`` will be redirected to the corresponding relative
  URL below the target ``http://example.net/path/``.

  For example, ``http://example.com/`` will be redirected to ``http://example.net/path/``, but
  ``http://example.com/somewhere`` will be redirected to ``http://example.net/path/somewhere``.

