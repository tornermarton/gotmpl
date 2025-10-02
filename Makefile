.DEFAULT_GOAL := help
.PHONY : context clean dependencies test build install docs docs-watch changelog snapshot push

VERSION 		:= $(shell git describe --tags --abbrev=0 --exact-match 2> /dev/null)
THREADS 		:= $(shell nproc 2>/dev/null || echo 1)

LDFLAGS     := -w -s -X main.version=$(VERSION)
GO111MODULE := on

REPOSITORY 	:= gotmpl/gotmpl-test

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

context: ## Print context information.
	@echo "Version:     ${VERSION}"
	@echo "Threads:     ${THREADS}"
	@echo "Flags:       ${LDFLAGS}"
	@echo "Repository:  ${REPOSITORY}"

clean: ## Clean up working directory.
	rm -rf dist
	rm -f gotmpl

dependencies: ## Install dependencies.
	go mod tidy

test: clean ## Run tests.
	go test

build: clean ## Build gotmpl binary.
	go build -ldflags "$(LDFLAGS)" -o ./dist/gotmpl

install: clean ## Install gotmpl binary.
	go install -ldflags "$(LDFLAGS)"

docs: ## Generate docs.
	mkdocs build -f .mkdocs.yaml

docs-watch: ## Serve docs for development.
	mkdocs serve -f .mkdocs.yaml

changelog: ## Generate changelog.
	git cliff -c .cliff.yaml -o CHANGELOG.md --tag "$(TAG)"

snapshot: clean ## Create a snapshot release (locally without publishing).
	goreleaser release --clean --snapshot --skip=publish

push: ## Push the built binaries to the remote distribution repository.
	find . -type f -name "*.apk" | xargs -P $(THREADS) -n 1 -I{} sh -c 'cloudsmith push alpine --republish $(REPOSITORY)/alpine/any-version "$1"' _ {}
	find . -type f -name "*.deb" | xargs -P $(THREADS) -n 1 -I{} sh -c 'cloudsmith push deb --republish $(REPOSITORY)/any-distro/any-version "$1"' _ {}
	find . -type f -name "*.rpm" | xargs -P $(THREADS) -n 1 -I{} sh -c 'cloudsmith push rpm --republish $(REPOSITORY)/any-distro/any-version "$1"' _ {}
