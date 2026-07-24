# Modular resume build
# Run from this directory: make all
#
# Entry points live NEXT TO resume.cls (backend.tex, master.tex, …).
# Do not compile files under variants/ — those are legacy shims.

VARIANTS := master backend ai robotics product
LATEXMK  := latexmk -pdf -interaction=nonstopmode -halt-on-error

.PHONY: all clean $(VARIANTS)

all: $(VARIANTS)

$(VARIANTS):
	$(LATEXMK) -jobname=$@ $@.tex

clean:
	latexmk -C
	rm -f $(addsuffix .pdf,$(VARIANTS)) \
	      $(addsuffix .aux,$(VARIANTS)) \
	      $(addsuffix .log,$(VARIANTS)) \
	      $(addsuffix .out,$(VARIANTS)) \
	      $(addsuffix .fls,$(VARIANTS)) \
	      $(addsuffix .fdb_latexmk,$(VARIANTS)) \
	      $(addsuffix .synctex.gz,$(VARIANTS))
