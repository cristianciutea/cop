#!/bin/bash

source ./../conf.sh

docker run -d \
    -e CASSANDRA_IS_SEED=true \
    -v ./../data/cassandra:/var/lib/cassandra \
    --net=host \
    --name test_cassandra $REGISTRY/coscale/test_cassandra:$VERSION

