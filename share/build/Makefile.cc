
# C language related part of Makefile.conf

COMPILE.c = cc

DEBUGC = 
#DEBUGC = -g

.SUFFIXES: .c

FLAGC = ${SEARCH} -c ${OPT3} ${DEBUGC}

.c.o:
	${COMPILE.c} ${FLAGC} ${SEARCH} $<
