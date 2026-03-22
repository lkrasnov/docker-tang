FROM alpine:3.23

ENV SUMMARY="Network Presence Binding Daemon." \
    DESCRIPTION="Tang is a small daemon for binding data to the presence of a third party. This is a containerized Tang server." \
    VERSION=1 \
    TANG_LISTEN_PORT=80

LABEL name="lkrasnov/tang" \
      summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      version="${VERSION}" \
      usage="podman run -d -p 8080:80 -v tang-keys:/var/db/tang --name tang lkrasnov/tang"

# Add testing repo
RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update && \
    apk add --no-cache tang@testing socat@testing

# Cleanup testing repo
RUN sed -i "/testing/d" /etc/apk/repositories    

COPY root /

VOLUME ["/var/db/tang"]
EXPOSE "${TANG_LISTEN_PORT}"

HEALTHCHECK CMD ["/usr/bin/tangd-healthcheck"]
CMD ["/usr/bin/tangd-entrypoint"]
