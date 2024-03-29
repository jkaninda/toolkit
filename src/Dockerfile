FROM ubuntu:22.04
ENV BUCKETNAME=""
ENV ACCESS_KEY=""
ENV SECRET_KEY=""
ENV S3_ENDPOINT=https://s3.amazonaws.com
ARG DEBIAN_FRONTEND=noninteractive
ENV VERSION="0.1"
ARG TEMP_DIR=/temp
RUN apt-get update -qq \
    && apt-get install curl gnupg2 jq git wget supervisor s3fs -y
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN curl https://get.docker.com/ > dockerinstall && chmod 777 dockerinstall && ./dockerinstall


RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && chmod +x /usr/bin/yq

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

## Install K6
RUN curl https://github.com/grafana/k6/releases/download/v0.48.0/k6-v0.48.0-linux-amd64.tar.gz -L | tar xvz --strip-components 1
RUN mv k6 /usr/local/bin/
RUN chmod +x /usr/local/bin/k6

RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
RUN mv kustomize /usr/local/bin/kustomize

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

RUN curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/kubectl

RUN mkdir $TEMP_DIR && \
 chmod 777 $TEMP_DIR && \
 mkdir $TEMP_DIR/s3cache && \
 chmod 777 $TEMP_DIR/s3cache

COPY src/scripts/backup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/backup.sh
COPY src/scripts/s3-mount.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/s3-mount.sh

RUN ln -s /usr/local/bin/s3-mount.sh /usr/local/bin/s3-mount
RUN ln -s /usr/local/bin/backup.sh /usr/local/bin/backup

ADD src/supervisord.conf /etc/supervisor/supervisord.conf

CMD ["/usr/bin/supervisord"]