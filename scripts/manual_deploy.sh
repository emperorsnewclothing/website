#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

export DOCKER_REGISTRY=gcr.io
export GCP_PROJECT_ID=webkit-servers
export GCP_ZONE=europe-west1-b
export GCP_CLUSTER_ID=appcluster
export NAMESPACE=enc
export IMAGE_FRONTEND_NAME=enc-frontend
export CI_COMMIT_SHA=$(git rev-parse HEAD)
export IMAGE_FRONTEND=$DOCKER_REGISTRY/$GCP_PROJECT_ID/$IMAGE_FRONTEND_NAME:$CI_COMMIT_SHA

docker build -t $IMAGE_FRONTEND .
docker push $IMAGE_FRONTEND

cat deploy/deployment.yaml | envsubst
cat deploy/deployment.yaml | envsubst | kubectl apply -f -