include Makefile.def

install:
	@echo 'FDIPS is installed'

bin:
	mkdir -p bin

run:
	mkdir -p run
	cd run; \
		cp ../input/FDIPS.in .; \
		cp ../input/POTENTIAL.in .; \
		ln -s ${BINDIR}/FDIPS.exe .; \
		ln -s ${BINDIR}/POTENTIAL.exe .; \
		cp ${SCRIPTDIR}/redistribute.pl .

FDIPS:	bin run
	cd ${SHAREDIR}; make LIB
	cd src; make FDIPS

POTENTIAL: bin run
	cd ${SHAREDIR}; make LIB
	cd src; make POTENTIAL

test:	test_fdips test_potential
	ls -l *.diff

###############################################################################

test_potential:
	@echo "test_potential_compile..." > test_potential.diff
	make POTENTIAL
	@echo "test_potential_run..." >> test_potential.diff
	gunzip -c input/fitsfile.dat.gz > run/fitsfile.dat
	cd run; ./POTENTIAL.exe > potential.log
	@echo "test_potential_check..." >> test_potential.diff
	make test_potential_check

test_potential_check:
	${SCRIPTDIR}/DiffNum.pl -t -r=1e-5 -a=1e-12 \
		run/potential.log \
		output/potential.ref > test_potential.diff
	ls -l test_potential.diff

###############################################################################

test_fdips:
	@echo "test_fdips_compile..." > test_fdips.diff
	make FDIPS
	@echo "test_fdips_run..." >> test_fdips.diff
	gunzip -c input/fitsfile.dat.gz > run/fitsfile.dat
	cd run;	mpirun -np 4 ./FDIPS.exe > fdips.log
	cd run; ./redistribute.pl fdips_field_np010202.out fdips.out
	@echo "test_fdips_check..." >> test_fdips.diff
	make test_fdips_check

test_fdips_check:
	${SCRIPTDIR}/DiffNum.pl -t -r=1e-5 -a=1e-12 \
		run/fdips.log \
		output/fdips.ref > test_fdips.diff
	gunzip -c output/fdips_ref.out.gz > run/fdips_ref.out
	${SCRIPTDIR}/DiffNum.pl -t -r=1e-9 -a=1e-9 \
		run/fdips.out \
		run/fdips_ref.out >> test_fdips.diff
	ls -l test_fdips.diff

clean:
	cd share; make clean
	cd src; make clean

allclean:
	touch src/Makefile.DEPEND
	cd src; make distclean
	rm -rf run bin *.diff *~
