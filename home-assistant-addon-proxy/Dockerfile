ARG BUILD_FROM
FROM $BUILD_FROM
RUN apk add --no-cache --update nginx

# Copy root filesystem
ADD nginx.conf.gtpl /
ADD entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_VERSION

# Labels
LABEL \
    org.opencontainers.image.title="RaspberryMatic HA Proxy-Addon" \
    org.opencontainers.image.description="A web proxy to your homematicIP CCU" \
    org.opencontainers.image.vendor="RasperryMatic OpenSource Project" \
    org.opencontainers.image.authors="RaspberryMatic OpenSource Team" \
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.url="https://raspberrymatic.de" \
    org.opencontainers.image.source="https://github.com/jens-maus/RaspberyMatic" \
    org.opencontainers.image.documentation="https://github.com/jens-maus/RaspberryMatic/wiki" \
    org.opencontainers.image.version=${BUILD_VERSION} \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.url=https://github.com/jens-maus/RaspberryMatic/tree/master/home-assistant-addon-proxy \
    io.hass.arch="${BUILD_ARCH}" \
    #io.hass.arch="armhf|aarch64|i386|amd64"\
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION}

ENTRYPOINT ["/entrypoint.sh"]
