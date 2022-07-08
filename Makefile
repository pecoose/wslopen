PROG := wslopen
PREFIX := /usr/local/bin

.PHONY: install uninstall

install:
	ln -fs $(shell pwd)/wslopen.sh ${PREFIX}/${PROG}

uninstall:
	rm ${PREFIX}/${PROG}
