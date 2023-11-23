FROM mvance/unbound:1.19.0

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# https://github.com/MatthewVance/unbound-docker/blob/master/1.16.0/Dockerfile#L149
CMD ["/unbound.sh"]
