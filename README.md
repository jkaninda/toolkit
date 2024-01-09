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
- k6

```yaml
version: '3.7'
services:
  toolkit:
    image: jkaninda/toolkit:latest
    container_name: toolkit
    command: ["/bin/bash", "sh"]
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ~/.kube:/root/.kube
      - ~/.ssh:/root/.ssh # If you use private CVS
```