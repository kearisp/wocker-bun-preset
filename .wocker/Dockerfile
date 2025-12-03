ARG VERSION="alpine"
ARG IMAGE_VERSION="${VERSION}"

FROM oven/bun:${IMAGE_VERSION}

LABEL org.wocker.preset="bun" \
      org.wocker.version="1.0.4" \
      org.wocker.description="Preset for bun projects"

ARG UID=1000
ARG GID=1000
ARG USER=wocker

ENV TZ=Etc/UTC

COPY --chown=${UID}:${GID} ./.wocker/bin/ws-run-hook.sh /usr/local/bin/ws-run-hook
COPY --chown=${UID}:${GID} ./.wocker/bin/entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY ./.wocker/etc/wocker /etc/wocker

WORKDIR /usr/app

RUN UID=${UID} && \
    GID=${GID} && \
    USER=${USER} && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    chmod +x /usr/local/bin/ws-run-hook && \
    ws-run-hook build

USER ${UID}

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bun", "start"]
