PROG := browser
PREFIX := /usr/local/bin

.PHONY: clean

install:
	chmod +X index.sh && sudo ln -s $(shell pwd)/index.sh ${PREFIX}/${PROG}

uninstall:
	sudo rm ${PREFIX}/${PROG}
