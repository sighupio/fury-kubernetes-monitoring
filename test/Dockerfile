FROM docker:dind

RUN apk add --no-cache git make musl-dev go curl \
  && go get sigs.k8s.io/kind
RUN curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/local/bin/
RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v1.0.10/kustomize_1.0.10_linux_amd64 -o /usr/local/bin/kustomize \
  && chmod +x /usr/local/bin/kustomize && kustomize version

ENV PATH="${PATH}:/root/go/bin"
COPY kind-config /test/kind-config
COPY entrypoint_service.sh ./entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]

