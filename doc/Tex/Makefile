#^CFG COPYRIGHT UM

include ../../Makefile.def
include ../../share/build/Makefile.doc

PDF: \
	FDIPS.pdf

FDIPS.dvi: FDIPS.tex ../../PARAM.xmltex

clean:
	rm -f *.log *.aux *~ ../../PARAM.xmltex

distclean: clean
	rm -f ../*.pdf *.dvi *.ps
