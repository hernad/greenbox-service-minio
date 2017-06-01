#!/bin/bash

ACCESS_KEY=$MINIO_ACCESS_KEY
SECRET_KEY=$MINIO_HOST_KEY
HOST="http://${MINIO_HOST}:9000"


#HOST="http://45.76.84.237:9000"


ACCESS_KEY_2=$MINIO_ACCESS_KEY_2
SECRET_KEY_2=$MINIO_SECRET_KEY_2
HOST_2="http://${MINIO_HOST_2}:9000"

if [ -z "$MINIO_ACCESSS_KEY" ] || [ -z "$MINIO_SECRET_KEY" ] || [ -z "$MINIO_HOST" ] ; then
  echo "envars MINIO_ACCESSS_KEY, MINIO_SECRET_KEY, MINIO_HOST undefined STOP"
  exit 1
fi


if [ -z "$MINIO_ACCESSS_KEY_2" ] || [ -z "$MINIO_SECRET_KEY_2" ] || [ -z "$MINIO_HOST_2" ] ; then
  echo "envars MINIO_ACCESSS_KEY_2, MINIO_SECRET_KEY_2, MINIO_HOST_2 STOP"
  exit 1
fi

MC=mc

#mc config host add myminio http://localhost:9000 OMQAGGOL63D7UNVQFY8X GcY5RHNmnEWvD/1QxD3spEIGj+Vt9L7eHaAaBTkJ

CMD="$MC config host add minio1 $HOST $ACCESS_KEY $SECRET_KEY"
echo $CMD
eval $CMD

CMD="$MC config host add minio2 $HOST_2 $ACCESS_KEY_2 $SECRET_KEY_2"
echo $CMD
eval $CMD

$MC mb minio2/f18.db
$MC mb minio2/test

$MC mirror minio1 minio2
