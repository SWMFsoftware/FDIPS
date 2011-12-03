include ../Makefile.def

Library/src/mpif.h:
	cd Library/src; cat precision.h mpif90.h > mpif.h

INSTALL_FILES = \
	Library/src/Makefile.DEPEND \
	Library/src/Makefile.RULES

install: Library/src/mpif.h
	touch ${INSTALL_FILES}

clean:
	cd Library/src; make clean

distclean: clean
	rm -f Library/src/mpif*.h *~ */*~ ${INSTALL_FILES}

#EOC
