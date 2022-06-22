# Traefik development stack

Allows publishing HTTP and HTTPS services on port 80 and 443 in a way that projects do not conflict with each other.

It uses [Traefik](https://traefik.io) as the proxy server and [Smallstep CA](https://smallstep.com/certificates/) to provide HTTPS connections without throwing error warnings.

## Setup

    docker network create web
    cp .env.example .env
    # … edit .env to your likings …
    docker-compose up -d

This will also implicitly generate a new CA certificate for HTTPS connections.

To make your system trust it (requires root access via `sudo`):

    ./install_ca_certificate.sh
