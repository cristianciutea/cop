#!/bin/bash

source ./../conf.sh

SEEDS=${1}
REPLICATION_FACTOR=${2}

if [ "$SEEDS" == "--help" ]; then
    echo "$0 : Setup cassandra node."
    echo "$0 <SeedAddress> : Sets up an additional node in the cluster."
    echo "$0 <SeedAddress> [ReplicationFactor] : Sets the replication factor, use it on the last node that is added."
    exit 0
fi

if [ "$SEEDS" == "" ]; then
    echo "error: Seed address not set." 2>&1; exit 1
fi

if  [ "$REPLICATION_FACTOR" != "" ]; then
    re='^[0-9]+$'
    if ! [[ $REPLICATION_FACTOR =~ $re ]] ; then
        echo "error: Replication Factor parameter not a number." 2>&1; exit 1
    fi
    REPLICATION_VAR=" -e CASSANDRA_REPLICATION_FACTOR=${REPLICATION_FACTOR}"
else
    REPLICATION_VAR=""
fi

VOLUME=$(dirname `pwd`)/data/cassandra

docker run -d \
    -e CASSANDRA_IS_SEED=false \
    -e CASSANDRA_SEED_ADDRESS=${SEEDS} \
    ${REPLICATION_VAR} \
    -v ${VOLUME}:/var/lib/cassandra \
    --net=host \
    --name coscale_cassandra $REGISTRY/coscale/coscale_cassandra:$VERSION


