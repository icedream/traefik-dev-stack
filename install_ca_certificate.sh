#!/bin/sh -e
target_crt_name=./local_dev_root_ca.crt

docker cp $(docker-compose ps -q stepca):/home/step/certs/root_ca.crt "$target_crt_name"

echo "Will install CA certificate now, may ask for sudo to do system-wide installation…" >&2
if command -v trust >/dev/null; then
    sudo trust anchor "$target_crt_name"
elif command -v update-ca-trust >/dev/null; then
    sudo install -vm0644 "$target_crt_name" /etc/pki/ca-trust/source/anchors/
    sudo update-ca-trust
elif command -v update-ca-certificates >/dev/null; then
    sudo install -vdm0755 /usr/local/share/ca-certificates
    sudo install -vm0644 "$target_crt_name" /usr/local/share/ca-certificates
    sudo update-ca-certificates
fi
