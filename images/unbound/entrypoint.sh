#!/bin/sh -e

: "${BASE_DNS_NAME:=localhost}"

# set up handling of requests to stuff Traefik publishes
rm -f /opt/unbound/etc/unbound/a-records.conf
while true; do
  traefik_ip=$(getent hosts traefik | awk '{print $1}')
  if [ -z "$traefik_ip" ]; then
    continue
  fi
  break
done
for domain in "${BASE_DNS_NAME}" ${ADDITIONAL_BASE_DNS_NAMES}; do
  cat <<EOF >>/opt/unbound/etc/unbound/a-records.conf
local-zone: "${domain}" redirect
local-data: "${domain} 3600 IN A ${traefik_ip}"
EOF
done

# forward all other requests to Docker's main DNS
MAIN_DNS_SERVER=$(cat /etc/resolv.conf | grep '^nameserver' | head -n1 | awk '{print $2}')
cat <<EOF >/opt/unbound/etc/unbound/forward-records.conf
forward-zone:
  name: "."
  forward-addr: ${MAIN_DNS_SERVER}
EOF

exec "$@"
