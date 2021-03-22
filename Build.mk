build_dir := ../pdf
cls_dir := ../cls

vpath %.pdf $(build_dir)

cls = $(wildcard $(cls_dir)/*.cls)

latexmk := latexmk
latexmk_args := -pdflua -interaction=nonstopmode -f -outdir=$(build_dir)

all: $(main_pdf)

watch: $(cls) | $(build_dir)
	$(latexmk) $(latexmk_args) -pvc $(main_tex)

$(main_pdf): $(cls) $(tex) | $(build_dir)
	$(latexmk) $(latexmk_args) $(main_tex)

$(build_dir):
	@echo "Build directory not found, creating directory..."
	mkdir -p $@

.PHONY: all watch
