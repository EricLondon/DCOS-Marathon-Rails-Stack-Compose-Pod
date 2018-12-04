#!/usr/bin/env bash

DOCKER_USER=$1
if [ -z "$DOCKER_USER" ]; then echo "ERROR: DOCKER_USER arg required."; exit 1; fi

APP_PREFIX="dcos-stack-"
docker_directories=(api nginx postgres)
for docker_directory in "${docker_directories[@]}"
do
  cd $docker_directory
  docker build -t ${DOCKER_USER}/${APP_PREFIX}${docker_directory}:latest .
  docker push ${DOCKER_USER}/${APP_PREFIX}${docker_directory}:latest
  cd ..
done
