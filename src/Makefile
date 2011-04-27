include ../Makefile.def
include ../Makefile.conf

POTENTIAL: potential_field.o ${LIBDIR}/libSHARE.a
	${LINK.f90} -o ${BINDIR}/POTENTIAL.exe potential_field.o \
		-L${LIBDIR} -lSHARE ${Lflag1}

FDIPS: FDIPS.o ${LIBDIR}/libSHARE.a
	${LINK.f90} -o ${BINDIR}/FDIPS.exe fdips.o \
		-L${LIBDIR} -lSHARE ${Lflag1}

distclean: clean


