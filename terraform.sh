#!/bin/bash

CMD="docker run \
       --rm \
       --name terraform \
       --net "host" \
       --user 1000:1000 \
       --volume $HOME:/home/developer \
       --volume $(pwd):/pwd \
       --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
       --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
       --env AWS_REGION=$AWS_REGION \
       kurron/docker-terraform:latest"

#echo $CMD
eval $CMD $*
