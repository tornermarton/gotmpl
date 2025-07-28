# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
.PHONY : context clean dependencies build install test snapshot changelog push

VERSION := $(shell git describe --tags --abbrev=0 --exact-match 2> /dev/null)
REPOSITORY := gotmpl/gotmpl-test
THREADS := $(shell nproc 2>/dev/null || echo 1)

LDFLAGS     = -w -s -X main.version=$(VERSION)
GO111MODULE = on

context: ## Print context information.
	@echo "Version: ${VERSION}"

clean: ## Clean up working directory.
	rm -rf dist
	rm -f gotmpl

dependencies: ## Install dependencies.
	go mod tidy

build: clean ## Build gotmpl binary.
	go build -ldflags "$(LDFLAGS)"

install: clean ## Install gotmpl binary.
	go install -ldflags "$(LDFLAGS)"

test: clean ## Run tests.
	go test

snapshot: clean ## Create a (local) snapshot release with goreleaser CLI (without publishing).
	goreleaser release --clean --snapshot --skip=publish

changelog: ## Generate changelog with cliff CLI.
	git cliff -c .cliff/cliff.yaml -o CHANGELOG.md

push: ## Push the built binaries with the cloudsmith CLI tool.
	find . -type f -name "*.apk" | xargs -P $(THREADS) -n 1 -I{} sh -c 'cloudsmith push alpine --republish $(REPOSITORY)/alpine/any-version "$1"' _ {}
	find . -type f -name "*.deb" | xargs -P $(THREADS) -n 1 -I{} sh -c 'cloudsmith push deb --republish $(REPOSITORY)/any-distro/any-version "$1"' _ {}
	find . -type f -name "*.rpm" | xargs -P $(THREADS) -n 1 -I{} sh -c 'cloudsmith push rpm --republish $(REPOSITORY)/any-distro/any-version "$1"' _ {}
