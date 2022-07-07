FROM smallstep/step-ca:0.21.0

USER root

# install our custom command
COPY custom.sh /usr/local/bin/custom-launcher
RUN chmod +x /usr/local/bin/custom-launcher

# install jq so we can update ca.json
RUN apk add --no-cache jq

USER step

# create certs volume as step user so it will not be owned by root later
RUN mkdir -p /home/step/certs
VOLUME ["/home/step", "/export"]

# https://github.com/smallstep/certificates/blob/master/docker/Dockerfile.step-ca#L30
CMD [ "custom-launcher" ]
