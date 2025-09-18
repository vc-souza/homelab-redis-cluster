#!/usr/bin/env bash

. ./scripts/host/shared/config.sh
. ./scripts/host/shared/utils.sh

declare -a NODES=($(all_nodes))

ENTRYPOINT=${NODES[0]}

log() {
    printf "[bootstrap] %s\n" "$1"
}

log "Setting up Redis Cluster \"$(get_cluster_name | bold)\""
log "Starting all nodes"

docker compose up -d

log "Waiting for all nodes to be up and running..."

sleep 10

declare -a ADDRESSES=()

for node in ${NODES[@]}; do
    address="$(internal_address_for $node)"
    ADDRESSES+=($address)

    log "$(bold <<< "${node}") --> $(bold <<< "${address}")"
done

log "Entrypoint $(bold <<< "${ENTRYPOINT}") will create a cluster with members: ${ADDRESSES[*]}"

bash_in "${ENTRYPOINT}" <<EOF
redis-cli --cluster create ${ADDRESSES[@]} --cluster-replicas 1 --cluster-yes
EOF

sleep 10

log "Shutting down all nodes"

docker compose down

log "Done"
