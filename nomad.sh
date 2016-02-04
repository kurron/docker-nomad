#!/bin/bash

CMD="docker run \
       --rm \
       --interactive \
       --tty \
       --net "host" \
       --user=$(id -u $(whoami)):$(id -g $(whoami)) \
       --volume $(pwd):/pwd \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       kurron/docker-nomad:0.2.3"

#echo $CMD
eval $CMD $*
