PROG := wslopen
PREFIX := /usr/local/bin

.PHONY: install uninstall test

test: 
	bash test.sh

install:
	ln -fs $(shell pwd)/wslopen.sh ${PREFIX}/${PROG}

uninstall:
	rm ${PREFIX}/${PROG}
