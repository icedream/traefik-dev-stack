FROM traefik:2.7.1

COPY entrypoint.sh /usr/local/bin/custom-entrypoint
RUN chmod +x /usr/local/bin/custom-entrypoint

VOLUME [ "/data", "/usr/local/share/ca-certificates" ]

ENTRYPOINT [ "custom-entrypoint" ]
CMD [ "traefik" ]
