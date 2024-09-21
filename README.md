# GCP CloudRun Demo

A demo project exploring the use of deploying to cloudrun a container and sidecar. [Cloud Run Sidecars](https://cloud.google.com/blog/products/serverless/cloud-run-now-supports-multi-container-deployments) are a new feature as Google brings more standardized Kubernetes features along in the service

## Description

There are two components built here: The main application and the sidecar. Within Cloud Run, containers act similar to Kubernetes where containers as part of the same service follow a sidecar pattern, where there is one main contains that listens generally on port 8080, with subsequent contianers able to interact with the main application container, deployed as sidecars.

This pattern is very common and this project is a simple build example of a sidecar pattern. 

The main application is a simple webserver that exports it's uptime as a metric to `/metrics`, while the sidecar reads these metrics and periodically prints them out.

## Deployment

This project contains the following folders:

- . (root)
  - contains Dockerfile to build the main application
  - build tags prevent the sidecar from being included in this main application
- sidecar
  - contains the main package for the sidecar container
- scripts
  - deploy script ran with exported env vars to deploy to GCP

**Steps to deploy**
1. Build the containers locally and push via makefile -- `make build-main && make build-sidecar`
2. Export env vars as appropriate for deploy script 
2. Run the deploy script to deploy them as a service -- `./deploy.sh`
3. Watch GCP logs to ensure deployment is successful 
  