PREFIX?=/usr/local

debug:
	swift build

release:
	swift build -c release

install:
	mkdir -p "$(PREFIX)/bin"
	cp -f ".build/release/Inaba" "$(PREFIX)/bin/Inaba"