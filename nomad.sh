#!/bin/bash

CMD="docker run \
       --rm \
       --name nomad \
       --net "host" \
       --user 1000:1000 \
       --volume $HOME:/home/developer \
       --volume $(pwd):/pwd \
       kurron/docker-nomad:latest"

#echo $CMD
eval $CMD $*
