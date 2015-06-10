# Get the version info for later
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION)

all: docs check clean

docs:
	R -q -e 'library("roxygen2"); roxygenise(".")'

build: docs
	cd ..;\
	R CMD build roxcal

check: build
	cd ..;\
	R CMD check roxcal_$(PKGVERS).tar.gz

check-cran: build
	cd ..;\
	R CMD check --as-cran roxcal_$(PKGVERS).tar.gz

install: build
	cd ..;\
	R CMD INSTALL roxcal_$(PKGVERS).tar.gz

move: check
	cp ../roxcal.Rcheck/roxcal-Ex.Rout ./tests/Examples/roxcal-Ex.Rout.save

clean:
	cd ..;\
	rm -r roxcal.Rcheck/

purl:
	cd ..;\
	R -q -e 'library("knitr"); purl("./roxcal/vignettes/roxcal.Rnw")'
