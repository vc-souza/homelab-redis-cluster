#!/usr/bin/env bash

. ./scripts/host/shared/config.sh
. ./scripts/host/shared/utils.sh

declare -a NODES=($(all_nodes))

ENTRYPOINT=${NODES[0]}

log() {
    printf "[monitoring] %s\n" "$1"
}

log "Checking Redis Cluster \"$(get_cluster_name | bold)\", according to $(bold <<< "${ENTRYPOINT}"):"

for node in ${NODES[@]}; do
    log "$(bold <<< "${node}") --> $(bold <<< "$(advertised_address_for $node)")"
done

bash_in $ENTRYPOINT <<EOF
redis-cli --cluster check $(advertised_address_for $ENTRYPOINT)
EOF
