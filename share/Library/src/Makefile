#^CFG COPYRIGHT UM

include ../../../Makefile.def
include ../../../Makefile.conf
include Makefile.DEPEND
include Makefile.RULES

# These modules provide the "infrastructure" for SWMF and components.
# A component does not have to use the whole library.
# The minimum reqguirement is ModIoUnit.o

# This rule is useful while modifying SWMF_MPI_routines.dat
#ModMpiInterfaces.f90: SWMF_MPI_routines.dat
#	${SCRIPTDIR}/CreateModMpi.pl

MODULES = \
	ModKind.o\
        ModNumConst.o\
	ModIoUnit.o\
	ModUtilities.o\
	${BLAS}\
	ModBlasLapack.o\
	ModMpi.o\
	ModMpiOrig.o\
	ModMpiInterfaces.o\
	ModReadParam.o\
	ModPlotFile.o\
	ModLinearSolver.o


EXTRA=	ModConst.o\
	ModCoordTransform.o\
	ModExactRS.o\
	ModFreq.o\
	ModInterpolate.o\
	ModLinearAdvection.o\
	ModLookupTable.o\
	ModPlanetConst.o\
	ModProcessVarName.o\
	ModSort.o\
	ModTimeConvert.o\
	ModTriangulate.o\
	CON_axes.o\
	CON_geopack.o\
	CON_line_extract.o\
	CON_planet.o\
	CON_planet_field.o\
	CON_ray_trace.o

DEPEND:
	@perl ${SCRIPTDIR}/depend.pl ${MODULES}

MY_LIB = ${LIBDIR}/libSHARE.a

LIB:	DEPEND
	make ${MY_LIB}
	@echo
	@echo ${MY_LIB} has been brought up to date.
	@echo

${MY_LIB}: ${MODULES}
	rm -f ${MY_LIB}
	${AR} ${MY_LIB} ${MODULES}


distclean: clean
	rm -f Makefile.DEPEND


