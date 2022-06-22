#!/bin/sh

set -e
set -u
set -o pipefail

update_authority_claim() {
    local claim
    local value
    claim="$(echo "$1" | jq -R .)"
    value="$(echo "$2" | jq -R .)"
    jq ".authority.claims.$claim |= $value" config/ca.json >config/ca.json.new
    mv config/ca.json.new config/ca.json
}

# create acme provisioner
grep acme -q config/ca.json || step ca provisioner add acme --type ACME

# export acme root certificate
install -m644 certs/root_ca.crt /export/ca-certificates.crt

# configure 30 day validity time
update_authority_claim maxTLSCertDuration 720h
update_authority_claim defaultTLSCertDuration 720h

set -- /usr/local/bin/step-ca --password-file "$PWDPATH" "$CONFIGPATH"

exec "$@"
