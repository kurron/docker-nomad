#!/bin/bash

# Will launch a quick and dirty Nomad agent in dual client/server mode. This is for
# development purposes only! 
CMD="docker run \
       --rm \
       --net "host" \
       --user=$(id -u $(whoami)):$(id -g $(whoami)) \
       --volume $(pwd):/pwd \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       kurron/docker-nomad:0.4.0 agent -dev -dc=my-datacenter -region=USA"

#echo $CMD
eval $CMD $*
