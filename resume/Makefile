# Modular resume build
# Run from this directory: make all

VARIANTS := master backend ai robotics product
LATEXMK  := latexmk -pdf -interaction=nonstopmode -halt-on-error

.PHONY: all clean $(VARIANTS)

all: $(VARIANTS)

$(VARIANTS):
	$(LATEXMK) -jobname=$@ variants/$@.tex

clean:
	latexmk -C
	rm -f $(addsuffix .pdf,$(VARIANTS)) \
	      $(addsuffix .aux,$(VARIANTS)) \
	      $(addsuffix .log,$(VARIANTS)) \
	      $(addsuffix .out,$(VARIANTS)) \
	      $(addsuffix .fls,$(VARIANTS)) \
	      $(addsuffix .fdb_latexmk,$(VARIANTS)) \
	      $(addsuffix .synctex.gz,$(VARIANTS))
