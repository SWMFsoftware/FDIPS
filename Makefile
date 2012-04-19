include Makefile.def

help:
	@echo ' You can "make" the following:'
	@echo ' '
	@echo '   help        -- show this help message'
	@echo '   FDIPS       -- parallel version of FDIPS'
	@echo '   FDIPS1      -- serial version of FDIPS'
	@echo '   test        -- run FDIPS1 and FDIPS tests'
	@echo '   test_fdips1 -- run FDIPS1 test'
	@echo '   test_fdips  -- run FDIPS test'
	@echo '   run         -- create run directory'
	@echo '   clean       -- remove object files'
	@echo ' '

install:
	@echo 'FDIPS is installed'

bin:
	mkdir -p bin

run:
	mkdir -p run
	cd run; \
		cp ../input/FDIPS.in .; \
		ln -s ${BINDIR}/FDIPS.exe .; \
		ln -s ${BINDIR}/FDIPS1.exe .; \
		cp ${SCRIPTDIR}/redistribute.pl .

FDIPS:	bin run
	cd ${SHAREDIR}; make LIB
	cd src; make FDIPS

FDIPS1: bin run
	cd ${SHAREDIR}; make LIB
	cd src; make FDIPS1

NOMPI:
	cd util/NOMPI/src; make LIB

test:
	rm -rf run
	-@make test_fdips1
	-@make test_fdips
	ls -l *.diff

###############################################################################

run/fdips_ref.out:
	gunzip -c output/fdips_ref.out.gz > run/fdips_ref.out

test_fdips1:
	@echo "test_fdips1_compile..." > test_fdips1.diff
	make FDIPS1
	@echo "test_fdips1_run..." >> test_fdips1.diff
	gunzip -c input/fitsfile.dat.gz > run/fitsfile.dat
	cd run; ./FDIPS1.exe > fdips1.log
	@echo "test_fdips1_check..." >> test_fdips1.diff
	make test_fdips1_check

test_fdips1_check: run/fdips_ref.out
	${SCRIPTDIR}/DiffNum.pl -t -r=1e-5 -a=1e-12 \
		run/fdips1.log \
		output/fdips1.ref > test_fdips1.diff
	${SCRIPTDIR}/DiffNum.pl -t -r=1e-9 -a=1e-9 \
		run/fdips_field.out \
		run/fdips_ref.out >> test_fdips1.diff
	ls -l test_fdips1.diff

###############################################################################

test_fdips:
	@echo "test_fdips_compile..." > test_fdips.diff
	make FDIPS
	@echo "test_fdips_run..." >> test_fdips.diff
	gunzip -c input/fitsfile.dat.gz > run/fitsfile.dat
	cd run;	mpirun -np 4 ./FDIPS.exe > fdips.log
	cd run; ./redistribute.pl fdips_field_np010202.out fdips_field.out
	@echo "test_fdips_check..." >> test_fdips.diff
	make test_fdips_check

test_fdips_check: run/fdips_ref.out
	${SCRIPTDIR}/DiffNum.pl -t -r=1e-5 -a=1e-12 \
		run/fdips.log \
		output/fdips.ref > test_fdips.diff
	${SCRIPTDIR}/DiffNum.pl -t -r=1e-9 -a=1e-9 \
		run/fdips_field.out \
		run/fdips_ref.out >> test_fdips.diff
	ls -l test_fdips.diff

clean:
	cd doc/Tex; make clean
	cd share; make clean
	cd util;  make clean
	cd src; make clean

allclean:
	rm -f doc/Tex/FDIPS.dvi
	cd src; make distclean
	rm -rf run bin *.diff *~ *.html *.php

