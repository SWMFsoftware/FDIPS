include ../Makefile.def

INSTALL_FILES = \
	Library/src/Makefile.DEPEND \
	Library/src/Makefile.RULES

install:
	touch ${INSTALL_FILES}

clean:
	cd Library/src; make clean

distclean: clean
	rm -f Library/src/mpif*.h *~ */*~ ${INSTALL_FILES}

#EOC
