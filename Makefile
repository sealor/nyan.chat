.PHONY: dev build clean

TAGS := $(if $(shell grep 24.04 /etc/os-release),-tags webkit2_41,)

dev:
	wails dev $(TAGS)

build:
	CGO_ENABLED=0 wails build $(TAGS)

clean:
	rm -rf build/bin
