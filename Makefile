PROG := open
PREFIX := /usr/local/bin

.PHONY: install uninstall

install:
	chmod +X index.sh && sudo ln -fs $(shell pwd)/index.sh ${PREFIX}/${PROG}

uninstall:
	sudo rm ${PREFIX}/${PROG}
