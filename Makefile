whitepaper_dir := whitepaper
pitchdeck_dir := pitchdeck

svg_dir := svg
build_dir := pdf

vpath %.pdf $(build_dir)
vpath %.pdf_tex $(build_dir)
vpath %.svg $(svg_dir)

svg = $(notdir $(wildcard $(svg_dir)/*.svg))
pdf_tex = $(patsubst %.svg,%.pdf_tex,$(svg))
inkscape = inkscape -D $(1) -o $(2) --export-latex

all: build_whitepaper build_pitchdeck

help:
	@echo "all:			compile all documents."
	@echo "whitepaper:		run continuous compilation of the whitepaper."
	@echo "pitchdeck:		run continuous compilation of the pitchdeck."
	@echo "build_whitepaper:	compile the whitepaper."
	@echo "build_pitchdeck:	compile the pitchdeck."
	@echo "clean:			remove build files."

whitepaper: $(pdf_tex) | $(build_dir)
	cd $(whitepaper_dir) && $(MAKE) watch

build_whitepaper: $(pdf_tex) | $(build_dir)
	cd $(whitepaper_dir) && $(MAKE)

pitchdeck: $(pdf_tex) | $(build_dir)
	cd $(pitchdeck_dir) && $(MAKE) watch

build_pitchdeck: $(pdf_tex) | $(build_dir)
	cd $(pitchdeck_dir) && $(MAKE)

%.pdf_tex: %.svg
	$(call inkscape,$<,$(build_dir)/$(patsubst %.pdf_tex,%.pdf,$@))

clean:
	rm -rf $(build_dir)

$(build_dir):
	@echo "Build directory not found, creating directory..."
	mkdir -p $@

.PHONY: all help whitepaper pitchdeck clean
