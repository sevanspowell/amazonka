ifndef TOP
$(error TOP is not set)
endif

ifndef PARENT
$(error PARENT is not set)
endif

SHELL := /usr/bin/env bash
DEPS  := core amazonka $(PARENT)

CABAL_SANDBOX_CONFIG := $(TOP)/cabal.sandbox.config

export CABAL_SANDBOX_CONFIG

build:
	cabal build

install: add-sources
	cabal install -j \
 --disable-documentation \
 --disable-library-coverage \
 --only-dependencies

add-sources:
	$(foreach dir,$(DEPS),cabal sandbox add-source $(realpath $(TOP)/$(dir));)

clean:
	cabal clean

repl:
	cabal repl