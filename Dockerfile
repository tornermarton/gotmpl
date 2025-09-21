FROM scratch

ARG TARGETOS
ARG TARGETARCH

COPY ./dist/${TARGETOS}_${TARGETOS}_${TARGETARCH}_*/gotmpl /usr/local/bin/gotmpl

ENTRYPOINT ["/usr/local/bin/gotmpl"]
