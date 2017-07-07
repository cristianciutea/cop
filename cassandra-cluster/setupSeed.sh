#!/bin/bash

source ./../conf.sh

VOLUME=$(dirname `pwd`)/data/cassandra

docker run -d \
    -e CASSANDRA_IS_SEED=true \
    -v ${VOLUME}:/var/lib/cassandra \
    --net=host \
    --name coscale_cassandra $REGISTRY/coscale/coscale_cassandra:$VERSION

