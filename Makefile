# change this to the file name of the paper
PRJ = main

# Small cheat to allow synchronization between PDF and .tex for supported editors (run `make S=1`)
ifdef S
EXTRA = -synctex=1
endif

PYTHON3 := $(shell type -P python3 || echo "")

ifeq ($(PYTHON3),)
BUILD = pdflatex ${EXTRA} ${PRJ} && (ls ${PRJ}.aux | xargs -n 1 bibtex) && pdflatex ${EXTRA} ${PRJ} && pdflatex ${EXTRA} ${PRJ}
else
BUILD = python3 .build/latexrun.py -O . --latex-args="${EXTRA}" ${PRJ}
endif

all: ${PRJ}.pdf

${PRJ}.pdf: *.tex references.bib 
	${BUILD}

view: ${PRJ}.pdf
	open ${PRJ}.pdf &

.PHONY: figure
figure:
	make -C Figures

clean:
	/bin/rm -rf *.toc *.aux ${PRJ}.bbl *.blg *.log *~* *.bak *.out ${PRJ}.pdf cut.sh .latexrun.db* *.fls *.rel _region_.*

