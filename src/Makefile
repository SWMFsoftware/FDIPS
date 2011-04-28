include ../Makefile.def
include ../Makefile.conf

FDIPS1: FDIPS1.o ${LIBDIR}/libSHARE.a
	${LINK.f90} -o ${BINDIR}/FDIPS1.exe FDIPS1.o \
		-L${LIBDIR} -lSHARE ${Lflag1}

FDIPS: FDIPS.o ${LIBDIR}/libSHARE.a
	${LINK.f90} -o ${BINDIR}/FDIPS.exe fdips.o \
		-L${LIBDIR} -lSHARE ${Lflag1}

distclean: clean


