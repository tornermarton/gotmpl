FROM mcr.microsoft.com/devcontainers/go:1-1.24-bookworm

RUN go install github.com/anchore/syft/cmd/syft@latest
RUN go install github.com/sigstore/cosign/v2/cmd/cosign@latest
RUN go install github.com/goreleaser/goreleaser/v2@latest
RUN go install github.com/git-chglog/git-chglog/cmd/git-chglog@latest
