<p align="center">
  <img src="assets/logo.png" alt="gotmpl-logo" width="240px" height="240px"/>
  <br>
  <em>Minimal, zero-dependency CLI tool to utilize the power of Go templates in your configuration files.</em>
</p>

<p align="center">
  <a href="https://github.com/gotmpl/gotmpl/releases"><img src="https://img.shields.io/github/v/release/gotmpl/gotmpl?logo=semver&label=Release" alt="Releases" align="center" /></a>
  &nbsp
  <a href="https://github.com/gotmpl/gotmpl/actions"><img src="https://img.shields.io/github/check-runs/gotmpl/gotmpl/master?logo=github&label=CI" alt="CI" align="center" /></a>
  &nbsp
  <a href="https://go.dev"><img src="https://img.shields.io/github/go-mod/go-version/gotmpl/gotmpl?logo=go" alt="Go Version" align="center" /></a>
</p>

<p align="center">
  <a href="https://github.com/gotmpl/gotmpl/stargazers"><img src="https://img.shields.io/github/stars/gotmpl/gotmpl" alt="Stars" align="center" /></a>
  &nbsp
  <a href="https://github.com/gotmpl/gotmpl/forks"><img src="https://img.shields.io/github/forks/gotmpl/gotmpl" alt="Forks" align="center" /></a>
  &nbsp
  <a href="https://github.com/gotmpl/gotmpl/graphs/contributors"><img src="https://img.shields.io/github/contributors/gotmpl/gotmpl?logo=github&style=social" alt="Contributors" align="center" /></a>
</p>

<p align="center">
  <a href="https://www.contributor-covenant.org"><img src="https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg?logo=contributorcovenant" alt="Contributor Covenant Code of Conduct" align="center" /></a>
  &nbsp
  <a href="./LICENSE"><img src="https://img.shields.io/github/license/gotmpl/gotmpl?label=License" alt="License" align="center" /></a>
  &nbsp
  <a href="https://cloudsmith.com"><img src="https://img.shields.io/badge/OSS%20hosting%20by-cloudsmith-blue?logo=cloudsmith" alt="Hosted By: Cloudsmith" align="center" /></a>
</p>

<br>

## Features

TODO

```shell
goreleaser release --clean --snapshot --skip=publish

find . -type f -name "*.apk" | while IFS= read -r file; do
  CLOUDSMITH_API_KEY=[redacted] cloudsmith push alpine gotmpl/gotmpl-test/alpine/any-version "$file"
done

find . -type f -name "*.deb" | while IFS= read -r file; do
  CLOUDSMITH_API_KEY=[redacted] cloudsmith push deb gotmpl/gotmpl-test/any-distro/any-version "$file"
done

find . -type f -name "*.rpm" | while IFS= read -r file; do
  CLOUDSMITH_API_KEY=[redacted] cloudsmith push rpm gotmpl/gotmpl-test/any-distro/any-version "$file"
done
```

## Installation

### Install from Package Managers

#### apk (Alpine)

```shell
apk add --no-cache bash curl && curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl-test/setup.alpine.sh' | bash
apk add --no-cache gotmpl
```

TODO: add command without curl???

#### apt (Debian)

TODO

#### yum (RHEL)

TODO

### Install from GitHub

Linux:

```shell
VERSION=1.0.0 ARCH=amd64; wget -O - https://github.com/gotmpl/gotmpl/releases/download/$VERSION/gotmpl-$VERSION-linux-$ARCH.tar.gz | tar xzf - -C /usr/local/bin
```

Linux (alpine):

```shell
VERSION=1.0.0 ARCH=amd64; wget -O - https://github.com/gotmpl/gotmpl/releases/download/$VERSION/gotmpl-$VERSION-linux-$ARCH-musl.tar.gz | tar xzf - -C /usr/local/bin
```

### Install from Docker

TODO

## Usage

TODO

### Examples

TODO

## Platforms

https://www.debian.org/ports/

https://wiki.alpinelinux.org/wiki/Architecture
TODO

## Changelog

Check out the latest improvements in our [release notes][changelog].

## Contributing

Before creating your changes please read through our [contributing guidelines][contributing] to learn about our submission process, coding rules, and more.

<br>

<p align="center">
  :star: Love the tool? Give this repo a star :star:
</p>

[changelog]: CHANGELOG.md
[contributing]: CONTRIBUTING.md
