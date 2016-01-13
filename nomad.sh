#!/bin/bash

CMD="docker run \
       --rm \
       --name nomad \
       --net "host" \
       --volume $(pwd):/pwd \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       kurron/docker-nomad:latest"

#echo $CMD
eval $CMD $*
