#!/bin/bash

# Will launch a quick and dirty Nomad agent in dual client/server mode. This is for
# development purposes only! 
CMD="docker run \
       --rm \
       --net "host" \
       --volume $(pwd):/pwd \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       kurron/docker-nomad:latest agent -dev -dc=my-datacenter -region=USA"

#echo $CMD
eval $CMD $*
