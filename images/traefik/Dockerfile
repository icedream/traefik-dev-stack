FROM traefik:2.11.0

COPY entrypoint.sh /usr/local/bin/custom-entrypoint
RUN chmod +x /usr/local/bin/custom-entrypoint

COPY traefik_config.toml /

VOLUME [ "/data", "/usr/local/share/ca-certificates" ]

ENTRYPOINT [ "custom-entrypoint" ]
CMD [ "traefik", "--configfile=/traefik_config.toml" ]
