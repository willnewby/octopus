include build/makelib.mk

# Entering/Leaving directory messages are annoying and not very useful
MAKEFLAGS += --no-print-directory

GO_IMPORT_ROOT ?= github.com/BlaineEXE/octopus
GO_BUILD_TARGET := $(GO_IMPORT_ROOT)/cmd/octopus
OUTPUT_DIR ?= _output

BUILDFLAGS ?= -buildmode pie
LDFLAGS ?=

# Version is automatically set by getting tag info from git; can be set manually if desired
VERSION ?= $(shell git describe --dirty --always --tags | sed 's/-/./2' | sed 's/-/./2' )

# inject the version number into the golang version package using the -X linker flag
LDFLAGS += -X $(GO_IMPORT_ROOT)/internal/version.Version=$(VERSION)

ALL_BUILDFLAGS := $(BUILDFLAGS) -ldflags '$(LDFLAGS)'

.PHONY: vendor
vendor: $(DEP)
	@ $(DEP) ensure

build: vendor $(GO)
	$(GO) build $(ALL_BUILDFLAGS) -o $(OUTPUT_DIR)/octopus $(GO_BUILD_TARGET)
	@ echo "Binary size: $$(ls -sh $(OUTPUT_DIR)/octopus | cut -d' ' -f 1)"

test: vendor $(GO)
	$(GO) test -cover ./cmd/... ./internal/...

test.integration: vendor build
	@ mkdir -p test/_output
	@ cp _output/octopus test/_output/octopus
	@ $(MAKE) --directory test all

install: vendor $(GO)
	$(GO) install $(ALL_BUILDFLAGS) $(GO_BUILD_TARGET)

clean:
	rm -rf $(OUTPUT_DIR)
	rm -rf vendor/
	@ $(MAKE) --directory test teardown
