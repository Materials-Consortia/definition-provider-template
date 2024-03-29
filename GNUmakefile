#---*- Makefile -*-------------------------------------------------------

# Use "make schemas schemas_html_pretty=true" to apply OPTIMADE styling to the html pages

# Use "make schemas schemas_html_ext=true" to generate html files with .html extensions also for files meant to be served
# without extensions, which is useful for hosting, e.g., on github that automatically redirects URLs without extensions.

.PHONY: all
all: schemas

###############################
# Basic configuration options #
###############################

# Path to the process_schemas program
PROCESS_SCHEMAS=dependencies/submodules/optimade-property-tools/bin/process_schemas
# The base of the URI for the generated property definitions
BASEID=https://example.org/schemas/v0.1/
# The versioned directory being processed
BASEDIR=src/v0.1.0
# The versions of the meta-schemas to use
META_SCHEMA_VER=v1.2

#################################
# Advanced configuation options #
#################################

# Path to the OPTIMADE schemas repo
OPTIMADE_SCHEMAS_DIR=dependencies/submodules/schemas
# Path to the meta-schemas to use
META_SCHEMA_PATH=$(OPTIMADE_SCHEMAS_DIR)/meta/$(META_SCHEMA_VER)
# Add the OPTIMADE schemas repo as a path relative to which resolve $$inherit
RESOLVE_PATHS_ARGS=--resolve-path $(OPTIMADE_SCHEMAS_DIR)


ifeq ($(origin schemas_html_pretty), undefined)
	OPTIMADE_HTML_HEADER ?=
	OPTIMADE_HTML_TOP ?=
else
	OPTIMADE_HTML_HEADER = <link rel="stylesheet" type="text/css" media="screen" href="https://www.optimade.org/assets/css/style.css" /><style>body {background: \#f2f2f2;} html {margin: 0 auto; max-width: 900px;}</style>
	OPTIMADE_HTML_TOP = <a href="https://www.optimade.org/"><img style="margin: 0.5em; float: left" src="https://avatars0.githubusercontent.com/u/23107754" width="10%" /></a><div style="width: 100%; clear: both"></div>
endif

SCHEMAS := $(wildcard src/*/*/*/*/*/*.yaml src/*/*/*/*/*.yaml src/*/*/*/*.yaml src/*/*/*.yaml src/*/*.yaml)
SCHEMAS_JSON = $(patsubst src/%.yaml,output/%.json,$(SCHEMAS))
SCHEMAS_MD = $(patsubst src/%.yaml,output/%.md,$(SCHEMAS))

ifeq ($(origin schemas_html_ext), undefined)
	SCHEMAS_HTML := $(patsubst src/%.yaml,output/%,$(SCHEMAS))
	SCHEMAS_HTML_EXT =
else
	SCHEMAS_HTML := $(patsubst src/%.yaml,output/%.html,$(SCHEMAS))
	SCHEMAS_HTML_EXT = .html
endif

EXT_SCHEMAS := $(filter-out dependencies/submodules/optimade-property-tools/external/json-schema/LICENSE, $(wildcard dependencies/submodules/optimade-property-tools/external/json-schema/*))
EXT_SCHEMAS_ARGS := $(foreach schema,$(EXT_SCHEMAS),--schema $(schema))

META_SCHEMAS_JSON := $(wildcard $(META_SCHEMA_PATH)/optimade/*.json)
META_SCHEMAS_ARGS := $(foreach schema,$(META_SCHEMAS_JSON),--schema $(schema))

INDEXES := $(wildcard src/*)
INDEXES_HTML := $(patsubst src/%,output/%/index.html,$(INDEXES))

.PHONY: schemas

schemas: $(SCHEMAS_JSON) $(SCHEMAS_MD) $(SCHEMAS_HTML) $(INDEXES_HTML)

output/%.json: src/%.yaml $(META_SCHEMAS_JSON)
	mkdir -p "$(dir $@)"
	$(PROCESS_SCHEMAS) --remove-null $(RESOLVE_PATHS_ARGS) --basedir "$(BASEDIR)" --baseid "$(BASEID)" $(META_SCHEMAS_ARGS) $(EXT_SCHEMAS_ARGS) --output "$@" "$<"

output/%.md: src/%.yaml
	mkdir -p "$(dir $@)"
	$(PROCESS_SCHEMAS) --remove-null -f md $(RESOLVE_PATHS_ARGS) --basedir "$(BASEDIR)" --baseid "$(BASEID)" --output "$@" "$<"

$(SCHEMAS_HTML): output/%$(SCHEMAS_HTML_EXT): src/%.yaml
	mkdir -p "$(dir $@)"
	$(PROCESS_SCHEMAS) --remove-null -f html $(RESOLVE_PATHS_ARGS) --basedir "$(BASEDIR)" --baseid "$(BASEID)" --html-header '$(OPTIMADE_HTML_HEADER)' --html-top '$(OPTIMADE_HTML_TOP)' --output "$@" "$<"

output/%/index.html: src/% $(SCHEMAS)
	mkdir -p "$(dir $@)"
	$(PROCESS_SCHEMAS) --index --basedir "$(BASEDIR)" --baseid "$(BASEID)" $(RESOLVE_PATHS_ARGS) -f html --html-header '$(OPTIMADE_HTML_HEADER)' --html-top '$(OPTIMADE_HTML_TOP)' $(EXT_SCHEMAS_ARGS) --output "$@" "$<"

.PHONY: clean clean_schemas

clean: clean_schemas

clean_schemas:
	rm -rf output
