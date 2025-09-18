CONFIG_FILE="config.json"
CLUSTER_CONFIG_FILE="conf/templates/redis.conf"

get_cluster_name() {
    cat "$CONFIG_FILE" | jq -rc '.["cluster"]'
}

get_host_ip() {
    for i in {1..100}; do
        ping -c1 www.google.com &> /dev/null && break
        sleep 2
    done

    ip route get 1 | awk '{print $(NF-2);exit}'
}
