# Makefile for ubos.net

# ubos.net variables
STAGEDIR = stage
CACHEDIR = cache

# You can set these variables from the command line.
SPHINXOPTS    = -v
DOCTREEDIR    = $(CACHEDIR)/doctrees

ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source

.PHONY: all clean jekyll sphinx open

all: jekyll sphinx static

clean:
	rm -rf $(STAGEDIR)/*

sphinx:
	sphinx-build -b html -d $(DOCTREEDIR) $(PHINXOPTS) sphinx $(STAGEDIR)/docs

jekyll:
	jekyll build -s jekyll -d $(STAGEDIR)

static:
	install -m644 images/ubos.ico $(STAGEDIR)/favicon.ico
	[ -d "$(STAGEDIR)/files" ] || mkdir "$(STAGEDIR)/files"
	install -m644 files/* $(STAGEDIR)/files/
	echo 'RedirectMatch /survey https://www.surveymonkey.com/s/FVNSNYN' > $(STAGEDIR)/.htaccess

open:
	open -a Firefox http://localhost/
