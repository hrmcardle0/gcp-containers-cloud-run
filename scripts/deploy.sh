#!/usr/bin/env bash

set -e

echo "Deploying containers to a cloudrun service"

# Parse args:
# $1 - service name
# $2 - main main name
# $3 - port
# $4 - sidecar container
# $5 - sidecar image

if [ "$#" -ne 7 ]; then
    echo "Usage: deploy.sh <service-name> <main-container-name> <main-container-image> <port> <sidecar-container-name> <sidecar-image> <region>"
    exit 1
fi

SERVICE_NAME=$1
MAIN_CONTAINER_NAME=$2
MAIN_CONTAINER_IMAGE=$3
PORT=$4
SIDECAR_CONTAINER_NAME=$5
SIDECAR_IMAGE=$6
REGION=$7

# Deploy service
gcloud run deploy $SERVICE_NAME \
    --container $MAIN_CONTAINER_NAME \
    --image $MAIN_CONTAINER_NAME \
    --port $PORT \
    --container $SIDECAR_CONTAINER_NAME \
    --image $SIDECAR_IMAGE 
    --region $REGION

# Watch deployment for successfull rollout
while true; do
  echo "Checking service status..."
  STATUS=$(gcloud run services describe $SERVICE_NAME --region us-east1 --format='value(status.url)' | grep -c "https")
  if [ $STATUS -eq 0 ]; then
    break
  fi
  sleep 5
done

trap "exit" INT TERM
