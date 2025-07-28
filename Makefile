# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
.PHONY : deps build install dist release release-docker

VERSION := $(shell git describe --tags --abbrev=0 --exact-match 2>/dev/null)

LDFLAGS     = -w -s -X main.version=$(VERSION)
GO111MODULE = on

context: ## Print context information.
	@echo "Version: ${VERSION}"

deps: ## Install dependencies.
	go mod tidy

clean: ## Clean up working directory.
	rm -rf dist
	rm -f gotmpl

build: clean ## Build gotmpl binary.
	go build -ldflags "$(LDFLAGS)"

install: clean ## Install gotmpl binary.
	go install -ldflags "$(LDFLAGS)"

changelog: ## Generate changelog.
	git cliff -c .cliff/cliff.yaml -o CHANGELOG.md
