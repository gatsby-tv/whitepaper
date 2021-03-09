svg_dir := svg
build_dir := pdf

vpath %.pdf $(build_dir)
vpath %.pdf_tex $(build_dir)
vpath %.svg $(svg_dir)

tex = $(wildcard *.tex)
svg = $(notdir $(wildcard $(svg_dir)/*.svg))
pdf_tex = $(patsubst %.svg,%.pdf_tex,$(svg))

main_tex := whitepaper.tex
main_pdf := whitepaper.pdf
latexmk := latexmk
latexmk_args := -pdflua -f -outdir=$(build_dir)
inkscape = inkscape -D $(1) -o $(2) --export-latex

all: $(main_pdf)

watch: $(pdf_tex) | $(build_dir)
	$(latexmk) $(latexmk_args) -pvc $(main_tex)

$(main_pdf): $(pdf_tex) $(tex) | $(build_dir)
	$(latexmk) $(latexmk_args) $(main_tex)

%.pdf_tex: %.svg
	$(call inkscape,$<,$(build_dir)/$(patsubst %.pdf_tex,%.pdf,$@))

clean:
	rm -rf $(build_dir)

$(build_dir):
	@echo "Build directory not found, creating directory..."
	mkdir -p $@

.PHONY: all watch clean
