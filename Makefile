PROG := open
PREFIX := /usr/local/bin

.PHONY: install uninstall

install:
	chmod +x index.sh && sudo ln -fs $(shell pwd)/index.sh ${PREFIX}/${PROG}

uninstall:
	sudo rm ${PREFIX}/${PROG}
