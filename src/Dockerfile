FROM gcr.io/projectsigstore/cosign:v2.2.4 as cosign-bin

FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
ENV VERSION="0.3.0"
ARG TEMP_DIR=/temp
LABEL auth="Jonas Kaninda"
LABEL github="https://github.com/jkaninda/toolkit"
RUN apt-get update -qq \
    && apt-get install -qqy curl gnupg2 jq tar supervisor git wget python3 python3-pip -y
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
WORKDIR /temp

RUN curl https://get.docker.com/ > dockerinstall
#RUN chmod 777 dockerinstall && ./dockerinstall
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&\
chmod +x /usr/bin/yq

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

## Copy cosign
COPY --from=cosign-bin /ko-app/cosign /usr/local/bin/cosign

## Install Pre-commit
RUN pip install pre-commit

## Install K6
RUN curl https://github.com/grafana/k6/releases/download/v0.48.0/k6-v0.48.0-linux-amd64.tar.gz -L | tar xvz --strip-components 1
RUN mv k6 /usr/local/bin/
RUN chmod +x /usr/local/bin/k6
## Install kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
RUN mv kustomize /usr/local/bin/kustomize
## Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh
## Install kubectl
RUN curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/kubectl
RUN ln -s /usr/local/bin/kubectl /usr/local/bin/k
RUN mkdir -p $TEMP_DIR && \
 chmod 777 $TEMP_DIR && \
 mkdir -p $TEMP_DIR/s3cache && \
 chmod 777 $TEMP_DIR/s3cache

 RUN curl -L -o notifier-0.1.0-linux-amd64.tar.gz https://github.com/jkaninda/notifier/releases/download/0.1.0/notifier-0.1.0-linux-amd64.tar.gz
 RUN tar -xzf notifier-0.1.0-linux-amd64.tar.gz && rm notifier-0.1.0-linux-amd64.tar.gz

RUN mv notifier /usr/local/bin/notifier && \
chmod +x /usr/local/bin/notifier

ADD src/supervisord.conf /etc/supervisor/supervisord.conf
CMD ["/usr/bin/supervisord"]
