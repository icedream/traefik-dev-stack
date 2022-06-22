#!/bin/sh -e

echo "Waiting for CA certificates to be generated…" >&2
# allow other containers to write to this volume
chmod a+wX /usr/local/share/ca-certificates || true
until [ $(find /usr/local/share/ca-certificates -name '*.crt' | wc -l) -gt 0 ]; do
    sleep 1
done

echo "Installing CA certificates…" >&2
update-ca-certificates

exec /entrypoint.sh "$@"
