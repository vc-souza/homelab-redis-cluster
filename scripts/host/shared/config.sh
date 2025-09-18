CONFIG_FILE="config.json"
CLUSTER_CONFIG_FILE="conf/templates/redis.conf"

get_cluster_name() {
    cat "$CONFIG_FILE" | jq -rc '.["cluster"]'
}

get_cluster_node_port() {
    cat conf/templates/redis.conf | grep port | awk '{ print $2 }'
}
