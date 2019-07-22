.PHONY: all clean dev build download

all: clean download build

clean:
	rm elm.js

dev: clean
	elm-live src/Main.elm --open --start-page=index.html -- --output=elm.js --debug

download:
	scripts/get_card_art.rb

build:
	elm make --optimize src/Main.elm --output elm.js
