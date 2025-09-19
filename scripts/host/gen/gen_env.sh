#!/usr/bin/env bash

. ./scripts/host/shared/config.sh

cp .env.template .env

sed -i 's/<CLUSTER>/'"$(get_cluster_name)"'/g' .env
sed -i 's/<HOST_NAME>/'"$(hostname)"'/g' .env
sed -i 's/<HOST_IP>/'"$(get_host_ip)"'/g' .env
