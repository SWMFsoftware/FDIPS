INSTALLFILE = \
	NOMPI/src/Makefile.RULES \

install:
	touch ${INSTALLFILE}

clean:
	touch ${INSTALLFILE}
	cd NOMPI/src;                 make clean

distclean:
	touch ${INSTALLFILE}
	cd NOMPI/src;                 make distclean
	rm -f *~
	rm -f ${INSTALLFILE}
