# Toolkit
DevOps Portable toolkit

[![Build](https://github.com/jkaninda/toolkit/actions/workflows/build.yml/badge.svg)](https://github.com/jkaninda/toolkit/actions/workflows/build.yml)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/jkaninda/toolkit?style=flat-square)

- [Docker Hub](https://hub.docker.com/r/jkaninda/toolkit)
- [Github](https://github.com/jkaninda/toolkit)

## Tools:
- docker client
- helm
- kustomize
- jq
- yq
- k6
- pre-commit
- cosign

```yaml
services:
  toolkit:
    image: jkaninda/toolkit
    container_name: toolkit
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ~/.kube:/root/.kube
```