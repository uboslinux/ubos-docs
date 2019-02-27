# Makefile for ubos.net/docs and ubos/docs/yellow (depending on branch)

BRANCH=$(shell git rev-parse --abbrev-ref HEAD)

ifeq "$(BRANCH)" 'master'
    STAGEDIR = ../ubos-website/stage/docs
else ifeq "$(BRANCH)" 'yellow'
    STAGEDIR = ../ubos-website/stage/docs-yellow
else
    $(error 'Cannot determine branch')
endif

CACHEDIR = cache

# You can set these variables from the command line.
SPHINXOPTS    = -v
DOCTREEDIR    = $(CACHEDIR)/doctrees

ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source

.PHONY: all clean sphinx open

all: sphinx

clean:
	rm -rf $(STAGEDIR)/* $(CACHEDIR)/*

sphinx:
	sphinx-build -b html -d $(DOCTREEDIR) $(PHINXOPTS) sphinx $(STAGEDIR)

open:
	open -a Firefox http://ubos/docs/
