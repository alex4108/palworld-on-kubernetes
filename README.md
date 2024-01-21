# Palworld on Kubernetes

[![GitHub issues](https://img.shields.io/github/issues/alex4108/palworld-on-kubernetes)](https://github.com/alex4108/palworld-on-kubernetes/issues)

Shoutout to the docker container contributor, [thijsvanloef](https://github.com/thijsvanloef/palworld-server-docker)

## Deployment Guide

1. Read over `render-template.sh` and fill in the variables to suit your needs

### "Easy" Way

2. `bash build-and-apply.sh`

### Hard Way:

2. `bash render-template.sh` to get a yml formatted manifest
3. Apply the manifest, eg `kubectl apply -f manifest-123.yml`

