FROM alpine:3.10

ENV KUSTOMIZE_VERSION 2.1.0
ENV YQ_VERSION 2.4.0

RUN addgroup -S builder && \
    adduser -S builder -G builder

RUN apk --no-cache add ca-certificates curl jq

RUN curl -fLSs https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 > /usr/local/bin/kustomize && \
    chmod +x /usr/local/bin/kustomize

RUN curl -fLSs https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 > /usr/local/bin/yq
    chmod +x /usr/local/bin/yqi

USER builder
