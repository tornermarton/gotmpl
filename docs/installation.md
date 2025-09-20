## Package Managers

This section describes the installation of `gotmpl` in a native environment.

!!! tip

    If you want to install it in a [Dockerfile](https://docs.docker.com/build/concepts/dockerfile/) follow our [Docker](#docker) instructions to create minimal images.

### apk (Alpine)

#### apk

/// tab | Latest

```shell
curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.alpine.sh' | sudo -E bash
sudo apk add gotmpl
```

///
/// tab | Specific

```shell
curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.alpine.sh' | sudo -E bash
sudo apk add gotmpl=={{version}}
```

///

### deb (Debian/Ubuntu)

#### apt

/// tab | Latest

```shell
curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.deb.sh' | sudo -E bash
sudo apt-get install gotmpl
```

///
/// tab | Specific

```shell
curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.deb.sh' | sudo -E bash
sudo apt-get install gotmpl=={{version}}
```

///

### rpm (RHEL/CentOS/Fedora)

#### dnf

/// tab | Latest

```shell
curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.rpm.sh' | sudo -E bash
sudo dnf install gotmpl
```

///
/// tab | Specific

```shell
curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.rpm.sh' | sudo -E bash
sudo dnf install gotmpl=={{version}}
```

///

#### yum

/// tab | Latest

```shell
curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.rpm.sh' | sudo -E bash
sudo yum install gotmpl
```

///
/// tab | Specific

```shell
curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.rpm.sh' | sudo -E bash
sudo yum install gotmpl=={{version}}
```

///

## Docker

If you want to install this tool to use it in a container follow these
instructions to achieve minimal images.

!!! warning

    `Compact` is preferred since it creates only one layer, `Detailed` is only for explanation.

!!! tip

    For building images we recommend pinning versions to have stable results.

#### apk

/// tab | Compact

```dockerfile
ARG GOTMPL_VERSION={{version}}

RUN curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.apk.sh' | bash && \
    apk add --no-cache gotmpl==$GOTMPL_VERSION
```

///
/// tab | Detailed

```dockerfile
# Set to install fixed fixed specific version
ARG GOTMPL_VERSION={{version}}

# Install dependencies (optional - your base image might already contain them)
RUN apk add --no-cache curl bash

# Setup our package repository
RUN curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.deb.sh' | bash

# Install gotmpl
RUN apk add --no-cache gotmpl==$GOTMPL_VERSION
```

///

#### apt

/// tab | Compact

```dockerfile
ARG GOTMPL_VERSION={{version}}

RUN curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.deb.sh' | bash && \
    apt-get update && \
    apt-get install -y --no-install-recommends gotmpl==$GOTMPL_VERSION && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

///
/// tab | Detailed

```dockerfile
# Set to install fixed fixed specific version
ARG GOTMPL_VERSION={{version}}

# Install dependencies (optional - your base image might already contain them)
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Setup our package repository
RUN curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl-test/setup.deb.sh' | bash

# Install gotmpl
RUN apt-get update && \
    apt-get install -y --no-install-recommends gotmpl==$GOTMPL_VERSION
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

///

#### dnf

/// tab | Compact

```dockerfile
ARG GOTMPL_VERSION={{version}}

RUN curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.rpm.sh' | bash && \
    dnf install -y --setopt=install_weak_deps=false gotmpl==$GOTMPL_VERSION && \
    dnf clean all && \
    rm -rf /var/cache/yum
```

///
/// tab | Detailed

```dockerfile
# Set to install fixed specific version
ARG GOTMPL_VERSION={{version}}

# Install dependencies (optional - your base image might already contain them)
RUN dnf install -y --setopt=install_weak_deps=false curl bash && \
    dnf clean all && \
    rm -rf /var/cache/yum

# Setup our package repository
RUN curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl-test/setup.rpm.sh' | bash

# Install gotmpl
RUN dnf install -y --setopt=install_weak_deps=false gotmpl==$GOTMPL_VERSION && \
    dnf clean all && \
    rm -rf /var/cache/yum
```

///

#### microdnf

/// tab | Compact

```dockerfile
ARG GOTMPL_VERSION={{version}}

RUN curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.rpm.sh' | bash && \
    microdnf install -y --setopt=install_weak_deps=false gotmpl==$GOTMPL_VERSION && \
    microdnf clean all && \
    rm -rf /var/cache/yum
```

///
/// tab | Detailed

```dockerfile
# Set to install fixed specific version
ARG GOTMPL_VERSION={{version}}

# Install dependencies (optional - your base image might already contain them)
RUN microdnf install -y --setopt=install_weak_deps=false curl bash && \
    microdnf clean all && \
    rm -rf /var/cache/yum

# Setup our package repository
RUN curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl-test/setup.rpm.sh' | bash

# Install gotmpl
RUN microdnf install -y --setopt=install_weak_deps=false gotmpl==$GOTMPL_VERSION && \
    microdnf clean all && \
    rm -rf /var/cache/yum
```

///

#### yum

/// tab | Compact

```dockerfile
ARG GOTMPL_VERSION={{version}}

RUN curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl/setup.rpm.sh' | bash && \
    yum install -y --setopt=tsflags=nodocs gotmpl==$GOTMPL_VERSION && \
    yum clean all && \
    rm -rf /var/cache/yum
```

///
/// tab | Detailed

```dockerfile
# Set to install fixed specific version
ARG GOTMPL_VERSION={{version}}

# Install dependencies (optional - your base image might already contain them)
RUN yum install -y --setopt=tsflags=nodocs curl bash && \
    yum clean all && \
    rm -rf /var/cache/yum

# Setup our package repository
RUN curl -1sLf 'https://dl.cloudsmith.io/basic/gotmpl/gotmpl-test/setup.rpm.sh' | bash

# Install gotmpl
RUN yum install -y --setopt=tsflags=nodocs gotmpl==$GOTMPL_VERSION && \
    yum clean all && \
    rm -rf /var/cache/yum
```

///

## GitHub

We release our packages via GitHub Releases and you can install them by
downloading (and validating) them directly from there.

!!! note

    This is only recommended if your operating system does not support the package managers above.

Linux:

```shell
VERSION={{version}} ARCH=amd64; wget -O - https://github.com/gotmpl/gotmpl/releases/download/$VERSION/gotmpl-$VERSION-linux-$ARCH.tar.gz | tar xzf - -C /usr/local/bin
```

Linux (alpine):

```shell
VERSION={{version}} ARCH=amd64; wget -O - https://github.com/gotmpl/gotmpl/releases/download/$VERSION/gotmpl-$VERSION-linux-$ARCH-musl.tar.gz | tar xzf - -C /usr/local/bin
```

## Go

The tool can also be installed via go CLI.

!!! warning

    This is not recommended and should typically be used for development purposes only.

!!! tip

    To build the CLI tool with Go, make sure you have **Go installed** (version {{go_version}} or newer recommended).

/// tab | Latest

```shell
go install github.com/gotmpl/gotmpl@latest
```

///
/// tab | Specific

```shell
go install github.com/gotmpl/gotmpl@v{{version}}
```

///

## Build from Source

The tool can also be installed by building it directly from source.

!!! tip

    To build the CLI tool from source, make sure you have **Go installed** (version {{go_version}} or newer recommended).

1.  Clone the repository:

    ```shell
    git clone https://github.com/gotmpl/gotmpl.git
    cd gotmpl
    ```

2.  Build the binary:

    ```shell
    go build -ldflags "-w -s"
    ```

3.  (Optional) Move the binary to a directory in your `PATH`:

    ```shell
    sudo mv gotmpl /usr/local/bin/
    ```
