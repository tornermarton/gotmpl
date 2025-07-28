# Install

TODO: TOC


## Package Managers

https://www.debian.org/ports/

https://wiki.alpinelinux.org/wiki/Architecture

### apk (Alpine)

```shell
apk add --no-cache bash curl && curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl-test/setup.alpine.sh' | bash
apk add --no-cache gotmpl
```

### apt (Debian)

### yum (RHEL)

## Go

```shell
go install github.com/gotmpl/gotmpl@latest
```

Requires Go 1.24.

## GitHub

Linux:

```shell
VERSION=1.0.0 ARCH=amd64; wget -O - https://github.com/gotmpl/gotmpl/releases/download/$VERSION/gotmpl-$VERSION-linux-$ARCH.tar.gz | tar xzf - -C /usr/local/bin
```

Linux (alpine):

```shell
VERSION=1.0.0 ARCH=amd64; wget -O - https://github.com/gotmpl/gotmpl/releases/download/$VERSION/gotmpl-$VERSION-linux-$ARCH-musl.tar.gz | tar xzf - -C /usr/local/bin
```

## Build from Source
