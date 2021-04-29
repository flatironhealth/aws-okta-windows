REPOSITORY := https://github.com/segmentio/aws-okta
LATEST := $(shell basename $(shell curl -fs -o/dev/null -w %{redirect_url} $(REPOSITORY)/releases/latest))
VERSION := $(LATEST)
VERSION_NO_V := $(patsubst v%,%,$(VERSION))

INSTALLER := $(abspath $(shell pwd)/../installer)
WIXIMG := dactiv/wix

BINARY := aws-okta-$(VERSION)-windows-amd64.exe

clean:
	rm -rf ./src
	rm -rf $(INSTALLER)/out
	rm -rf $(INSRALLER)/src/bin

src:
	mkdir -p src

clone: | src/.git
build: src/dist/$(BINARY)
installer: $(INSTALLER)/out/aws-okta-$(VERSION_NO_V).msi

src/.git: | src
	git clone $(REPOSITORY) src

checkout: clone
	cd src && git checkout $(VERSION)

src/dist/$(BINARY): | checkout
	cat Makefile.fragment >> src/Makefile
	cd src && make VERSION=$(VERSION) windows

$(INSTALLER)/out/aws-okta-$(VERSION_NO_V).msi: build
	mkdir -p $(INSTALLER)/src/bin
	cp  src/dist/$(BINARY) $(INSTALLER)/src/bin/
	cat $(INSTALLER)/wix.sh | docker run --rm -i -e VER=$(VERSION_NO_V) -v $(INSTALLER):/wix $(WIXIMG) /bin/sh
