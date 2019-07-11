FROM alpine:3.10

ENV KUSTOMIZE_VERSION 2.1.0
ENV YQ_VERSION 2.4.0

RUN apk --no-cache add \
    # To trust certificates
    ca-certificates \
    # For doing external calls
    curl \
    # To manipulate JSON
    jq \
    # Works best with CircleCI (environment variable injection)
    bash

# Use kustomize for templating for k8s
RUN curl -fLSs https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 \
    > /usr/local/bin/kustomize && \
    chmod +x /usr/local/bin/kustomize

# To manipulate YAML
RUN curl -fLSs https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
    > /usr/local/bin/yq && \
    chmod +x /usr/local/bin/yq

RUN addgroup -S builder && \
    adduser -S builder -G builder -s /bin/bash

USER builder

ENTRYPOINT ["/bin/bash"]
