# Makefile for ubos.net/docs and ubos/docs/yellow (depending on branch)

BRANCH=$(shell git rev-parse --abbrev-ref HEAD)

ifeq "$(BRANCH)" 'master'
    STAGEDIR              = ../ubos-website/stage/docs
    THIS_RELEASE_CHANNEL  = green
    THIS_CONTEXT          = /docs
    OTHER_RELEASE_CHANNEL = yellow
    OTHER_CONTEXT         = /docs-yellow
else ifeq "$(BRANCH)" 'yellow'
    STAGEDIR              = ../ubos-website/stage/docs-yellow
    THIS_RELEASE_CHANNEL  = yellow
    THIS_CONTEXT          = /docs-yellow
    OTHER_RELEASE_CHANNEL = green
    OTHER_CONTEXT         = /docs
else
    $(error 'Cannot determine branch')
endif

CACHEDIR = cache

# I can't figure out how to use sphinx-native ways of inserting the release channel
# here, so we do it my way
SPHINXOPTS = -v
DOCTREEDIR = $(CACHEDIR)/doctrees

.PHONY: all clean sphinx open

all: sphinx

clean:
	rm -rf $(STAGEDIR)/* $(CACHEDIR)/* sphinx/_templates.processed sphinx/themes.processed

sphinx:
	cp -rf sphinx/_templates sphinx/_templates.processed
	cp -rf sphinx/themes     sphinx/themes.processed
	perl -pi -e 's!THIS_RELEASE_CHANNEL!'$(THIS_RELEASE_CHANNEL)'!g ; s!THIS_CONTEXT!'$(THIS_CONTEXT)'!g ; s!OTHER_RELEASE_CHANNEL!'$(OTHER_RELEASE_CHANNEL)'!g ; s!OTHER_CONTEXT!'$(OTHER_CONTEXT)'!g' sphinx/_templates.processed/* sphinx/themes.processed/ubos/*
	sphinx-build -b html -d $(DOCTREEDIR) $(SPHINXOPTS) sphinx $(STAGEDIR)

open:
	open -a Firefox http://ubos$(THIS_CONTEXT)/
