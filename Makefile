# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
.PHONY : deps build install dist release release-docker

GIT_SHA     = $(shell git rev-parse --short HEAD)
GIT_TAG     = $(shell git describe --tags --abbrev=0 --exact-match 2>/dev/null)

VERSION     = $(shell cat VERSION)

LDFLAGS     = -w -s -X main.version=$(VERSION)
GO111MODULE = on

info:
	@echo "Git SHA: ${GIT_SHA}"
	@echo "Git Tag: ${GIT_TAG}"
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

dist: deps clean ## Build gotmpl for all platforms.
	mkdir -p dist/linux/amd64 && GOOS=linux GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o dist/linux/amd64/gotmpl
	mkdir -p dist/linux/arm64 && GOOS=linux GOARCH=arm64 go build -ldflags "$(LDFLAGS)" -o dist/linux/arm64/gotmpl
	mkdir -p dist/linux/armel && GOOS=linux GOARCH=arm GOARM=5 go build -ldflags "$(LDFLAGS)" -o dist/linux/armel/gotmpl
	mkdir -p dist/linux/armhf && GOOS=linux GOARCH=arm GOARM=6 go build -ldflags "$(LDFLAGS)" -o dist/linux/armhf/gotmpl
	mkdir -p dist/linux/i386 && GOOS=linux GOARCH=386 go build -ldflags "$(LDFLAGS)" -o dist/linux/i386/gotmpl
	mkdir -p dist/linux/ppc64el && GOOS=linux GOARCH=ppc64le go build -ldflags "$(LDFLAGS)" -o dist/linux/ppc64el/gotmpl
	mkdir -p dist/linux/riscv64 && GOOS=linux GOARCH=riscv64 go build -ldflags "$(LDFLAGS)" -o dist/linux/riscv64/gotmpl
	mkdir -p dist/linux/s390x && GOOS=linux GOARCH=s390x go build -ldflags "$(LDFLAGS)" -o dist/linux/s390x/gotmpl

	mkdir -p dist/linux/x86-musl && GOOS=linux GOARCH=386 CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -a -o dist/linux/x86-musl/gotmpl
	mkdir -p dist/linux/x86_64-musl && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -a -o dist/linux/x86_64-musl/gotmpl
	mkdir -p dist/linux/armhf-musl && GOOS=linux GOARCH=arm GOARM=6 CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -a -o dist/linux/armhf-musl/gotmpl
	mkdir -p dist/linux/armv7-musl && GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -a -o dist/linux/armv7-musl/gotmpl
	mkdir -p dist/linux/aarch64-musl && GOOS=linux GOARCH=arm64 CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -a -o dist/linux/aarch64-musl/gotmpl
	mkdir -p dist/linux/ppc64le-musl && GOOS=linux GOARCH=ppc64le CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -a -o dist/linux/ppc64le-musl/gotmpl
	mkdir -p dist/linux/s390x-musl && GOOS=linux GOARCH=s390x CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -a -o dist/linux/s390x-musl/gotmpl
	mkdir -p dist/linux/riscv64-musl && GOOS=linux GOARCH=riscv64 CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -a -o dist/linux/riscv64-musl/gotmpl
	mkdir -p dist/linux/loongarch64-musl && GOOS=linux GOARCH=loong64 CGO_ENABLED=0 go build -ldflags "$(LDFLAGS)" -a -o dist/linux/loongarch64-musl/gotmpl

	mkdir -p dist/darwin/arm64 && GOOS=darwin GOARCH=arm64 go build -ldflags "$(LDFLAGS)" -o dist/darwin/arm64/gotmpl
	mkdir -p dist/darwin/amd64 && GOOS=darwin GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o dist/darwin/amd64/gotmpl

release: ## Release for all platforms as tarballs.
	tar -cvzf dist/gotmpl-$(VERSION)-linux-amd64.tar.gz -C dist/linux/amd64 gotmpl
	tar -cvzf dist/gotmpl-$(VERSION)-linux-arm64.tar.gz -C dist/linux/arm64 gotmpl

	tar -cvzf dist/gotmpl-$(VERSION)-linux-amd64-musl.tar.gz -C dist/linux/amd64-musl gotmpl
	tar -cvzf dist/gotmpl-$(VERSION)-linux-arm64-musl.tar.gz -C dist/linux/arm64-musl gotmpl

release-docker: ## Release for linux and alpine linux platforms as a Docker image for easier containerized distribution.
	docker buildx build --push --platform linux/amd64,linux/arm64 --build-arg OS=linux -t tornermarton/gotmpl:$(VERSION) -t tornermarton/gotmpl:latest -f docker/tornermarton/gotmpl/Dockerfile .
	docker buildx build --push --platform linux/amd64,linux/arm64 --build-arg OS=alpine -t tornermarton/gotmpl:$(VERSION)-alpine -t tornermarton/gotmpl:alpine -f docker/tornermarton/gotmpl/Dockerfile .
