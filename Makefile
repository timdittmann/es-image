# Makefile for convenience
.PHONY: base-image coessing-notebook
TESTDIR=/srv/test

base-image :
	docker pull pangeo/base-image:master

coessing-notebook : base-image
	cd coessing-notebook ; \
	../update_lockfile.sh; \
	../list_packages.sh | sort > packages.txt; \
	docker build -t sgibson91/coessing-notebook:master . ; \
	docker run -w $(TESTDIR) -v $(PWD):$(TESTDIR) sgibson91/coessing-notebook:master ./run_tests.sh coessing-notebook
