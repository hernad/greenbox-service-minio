#!/bin/bash

docker pull minio/minio

MINIO_NAME=${1:-minio-1}
MINIO_ACCESS_KEY=${2:-$MINIO_ACCESS_KEY}
MINIO_SECRET_KEY=${3:-$MINIO_SECRET_KEY}

if [ -z "${MINIO_ACCESS_KEY}" ] || [ -z "${MINIO_SECRET_KEY}" ] ; then
    echo " define env vars: MINIO_ACCESS_KEY, MINIO_SECRET_KEY, or run as:"
    echo " $0 <MINIO_NAME> <MINIO_ACCESS_KEY> <MINIO_SECRET_KEY>"
    exit 1
fi

docker rm -f $MINIO_NAME
docker run -p 9000:9000 --name $MINIO_NAME \
   -d \
   --restart=always \
   -e MINIO_ACCESS_KEY=$MINIO_ACCESS_KEY \
   -e MINIO_SECRET_KEY=$MINIO_SECRET_KEY \
  -v $(pwd)/minio:/export \
  -v $(pwd)/conf:/root/.minio \
  minio/minio server /export


echo "waiting 5 sec ..."
sleep 5

docker logs $MINIO_NAME
