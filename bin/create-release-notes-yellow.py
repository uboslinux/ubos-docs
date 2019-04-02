#!/usr/bin/python
#
# This should run on Python2 and 3, so we can run this on the Mac

import os
import re
import sys
from time import gmtime, strftime

cwd = os.getcwd()

if not cwd.endswith( '/ubos-docs-yellow'):
    print( "ERROR: invoked in wrong directory: " + cwd )
    exit( 1 )

print( "Create release notes for the yellow channel. Paste in promotion report:")
promotion = sys.stdin.read()

ds = strftime("%Y-%m-%d", gmtime())

packagePattern = re.compile( "^\s*(\S+):\s+(\S+)$" )
packages       = []
for line in promotion.splitlines():
    match = packagePattern.match( line )
    if match and match.group(2) is not '{':
        package = match.group(1)
        packages.append( package )

notes = """Release Notes: Update %s
================================

To upgrade
----------

To be safe, first create a backup of all your sites to a suitable file, with a
command such as:

* ``sudo ubos-admin backup --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

What's new
----------

New functionality:
^^^^^^^^^^^^^^^^^^

* FIXME

Package upgrades:
^^^^^^^^^^^^^^^^^

FIXME: this list contains upgrades as well as new packages. Manually fix!

""" % ( ds )

for package in packages:
    notes += "* " + package + "\n"

notes +="""
There were %d new or upgraded packages in total.

Notable new packages:
^^^^^^^^^^^^^^^^^^^^^

* FIXME

Fixes and improvements:
^^^^^^^^^^^^^^^^^^^^^^^

* FIXME

Changes for developers:
^^^^^^^^^^^^^^^^^^^^^^^

* FIXME

Removed functionality
---------------------

* FIXME

Known issues
------------

* FIXME

Need help?
----------

Post to the `UBOS forum <https://forum.ubos.net/>`_.
""" % ( len( packages ))

notesDir     = cwd + "/sphinx/releases/" + ds + "/release-notes"
notesFile    = notesDir + "/index.rst"
releasesFile = cwd + "/sphinx/releases/index.rst"

if not os.path.exists( notesDir ):
    os.makedirs( notesDir )

with open( notesFile, 'w') as notesFh:
    notesFh.write( notes )

# Update the directory
releases = None
with open( releasesFile, 'r' ) as releasesFh:
    releases = releasesFh.read()

# We are looking for something like this and insert before:
#     .. toctree::
#        :maxdepth: 1
#
#        2019-03-29/release-notes/index

releasesLines = releases.splitlines()
if len(releasesLines) < 3:
    print( "ERROR: release directory file too short, something's wrong: " + releasesFile )
    exit( 2 )

releasesContentToAdd = ds + "/release-notes/index"

insertIndex = -1

for i in range(2,len(releasesLines)):
    if      releasesLines[i].strip() != '' \
            and releasesLines[i-1].strip() == '' \
            and releasesLines[i-2].strip().startswith( ":maxdepth" ):
        if releasesLines[i].strip().startswith( releasesContentToAdd ):
            # Got it already -- regenerated
            insertIndex = -2
        else:
            insertIndex = i
        break

if insertIndex == -1:
    print( "ERROR: cannot find where to insert release notes, do it manually: " + releasesFile )
elif insertIndex > 0:
    with open( releasesFile, 'w' ) as releasesFh:
        for i in range(0,insertIndex):
            releasesFh.write( releasesLines[i] + "\n" )

        releasesFh.write( "   " + releasesContentToAdd + "\n" )
        for i in range(insertIndex,len(releasesLines)):
            releasesFh.write( releasesLines[i] + "\n" )
# else: nothing needs to be done

print( "NOTE: now manually edit: " + notesDir + "/index.rst" )
