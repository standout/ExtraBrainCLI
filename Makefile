prefix ?= /usr/local
bindir = $(prefix)/bin

build:
	swift build -c release --product eb --disable-sandbox

install: build
	mkdir -p "$(bindir)"
	install ".build/x86_64-apple-macosx/release/eb" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/eb"

clean:
	rm -rf .build

test:
	swift test

.PHONY: build install uninstall clean test
