declare -a ALL_NODES=(node-1 node-2 node-3 node-4 node-5 node-6)

bold() {
    printf "$(tput bold)%s$(tput sgr0)" "$(cat)"
}

all_nodes() {
    echo -n "${ALL_NODES[*]}"
}

bash_in() {
    docker compose exec -T "${1}" bash
}

ip_for() {
    bash_in "${1}" <<'EOF'
getent hosts | grep node | awk '{ print $1 }'
EOF
}

internal_address_for() {
    echo -n "$(ip_for "${1}"):$(get_cluster_node_port)"
}
