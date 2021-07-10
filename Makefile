whitepaper_dir := whitepaper

svg_dir := svg
build_dir := pdf

vpath %.pdf $(build_dir)
vpath %.pdf_tex $(build_dir)
vpath %.svg $(svg_dir)

svg = $(notdir $(wildcard $(svg_dir)/*.svg))
pdf_tex = $(patsubst %.svg,%.pdf_tex,$(svg))
inkscape = inkscape -D $(1) -o $(2) --export-latex

all: whitepaper

help:
	@echo "all:		compile all documents."
	@echo "watch:		run continuous compilation of the whitepaper."
	@echo "whitepaper:	compile the whitepaper."
	@echo "clean:		remove build files."

watch: $(pdf_tex) | $(build_dir)
	cd $(whitepaper_dir) && $(MAKE) watch

whitepaper: $(pdf_tex) | $(build_dir)
	cd $(whitepaper_dir) && $(MAKE)

%.pdf_tex: %.svg
	$(call inkscape,$<,$(build_dir)/$(patsubst %.pdf_tex,%.pdf,$@))

clean:
	rm -rf $(build_dir)

$(build_dir):
	@echo "Build directory not found, creating directory..."
	mkdir -p $@

.PHONY: all help watch clean
