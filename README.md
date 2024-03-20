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
- s3fs

```yaml
version: '3.7'
services:
  toolkit:
    image: jkaninda/toolkit:latest
    container_name: toolkit
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ~/.kube:/root/.kube
      - ~/.ssh:/root/.ssh # If you use private CVS
```
## Mount S3 

> Command : s3-mount

```yaml
version: '3.7'
services:
  toolkit:
    image: jkaninda/toolkit:latest
    container_name: toolkit
    privileged: true
    devices:
    - "/dev/fuse"
    volumes:
      - ./custome-volume:/custome-volume
    environment:
      - ACCESS_KEY=${ACCESS_KEY}
      - SECRET_KEY=${SECRET_KEY}
      - BUCKETNAME=${BUCKETNAME}
      - S3_ENDPOINT=https://s3.us-west-2.amazonaws.com
```