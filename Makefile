PANDOC = pandoc
WKHTMLTOPDF = wkhtmltopdf
DOCX_REFERENCE_DOC = default_styles.docx
HTML_CSS = normalize.css

# Input files

MARKDOWN_RESUME = resume.md

# Output files
BUILD_DIR = ./tmp
DOCX_RESUME = resume.docx
HTML_RESUME = resume.html
PDF_RESUME = resume.pdf

ARTIFACTS = \
	resume.docx \
	resume.html \
	resume.pdf

DOWNLOADS_PREFIX = balfanz_

# typing 'make' will invoke the first target entry in the makefile 
all: build

build: resume
	mkdir -p $(BUILD_DIR)

resume: $(ARTIFACTS)

clean:
	$(RM) $(ARTIFACTS)
	$(RM) -r ./tmp/*
	$(RM) ./docs/static/*
	$(RM) -r ./site/*

resume.docx: resume.md $(DOCX_REFERENCE_DOC)
	$(PANDOC) --output $(BUILD_DIR)/$(DOCX_RESUME)  --reference-doc=$(DOCX_REFERENCE_DOC) $(MARKDOWN_RESUME)

resume.html: resume.md
	$(PANDOC) --output $(BUILD_DIR)/$(HTML_RESUME) --css $(HTML_CSS) $(MARKDOWN_RESUME)

resume.pdf: resume.html
	$(WKHTMLTOPDF) $(BUILD_DIR)/$(HTML_RESUME) $(BUILD_DIR)/$(PDF_RESUME)

docs: resume
	mkdir -p ./docs/static
	cp $(MARKDOWN_RESUME) ./docs/static/$(DOWNLOADS_PREFIX)$(MARKDOWN_RESUME)
	cp $(BUILD_DIR)/$(DOCX_RESUME) ./docs/static/$(DOWNLOADS_PREFIX)$(DOCX_RESUME)
	cp $(BUILD_DIR)/$(HTML_RESUME) ./docs/static/$(DOWNLOADS_PREFIX)$(HTML_RESUME)
	cp $(BUILD_DIR)/$(PDF_RESUME) ./docs/static/$(DOWNLOADS_PREFIX)$(PDF_RESUME)
	pipenv run mkdocs build --clean --verbose

docs_deploy: docs
	pipenv run mkdocs gh-deploy --clean --verbose
