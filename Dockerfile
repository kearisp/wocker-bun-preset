ARG VERSION='alpine'

FROM oven/bun:${VERSION}

LABEL org.wocker.preset="bun" \
      org.wocker.version="1.0.1" \
      org.wocker.description="Preset for bun projects"

ARG USER_ID=1000
ARG GROUP_ID=1000

WORKDIR /usr/app

RUN set -e; \
    if grep -q "Alpine" /etc/os-release; then \
        if ! getent group ${GROUP_ID} > /dev/null; then \
            addgroup -g ${GROUP_ID} wocker; \
        else \
            GROUP_NAME=$(getent group ${GROUP_ID} | cut -d: -f1); \
            echo "Group ${GROUP_ID} already exists as ${GROUP_NAME}"; \
        fi; \
        if ! getent passwd ${USER_ID} > /dev/null; then \
            GROUP_NAME=$(getent group ${GROUP_ID} | cut -d: -f1); \
            adduser -u ${USER_ID} -G ${GROUP_NAME} -s /bin/sh -D wocker; \
        else \
            USER_NAME=$(getent passwd ${USER_ID} | cut -d: -f1); \
            echo "User ${USER_ID} already exists as ${USER_NAME}"; \
        fi; \
    else \
        if ! getent group ${GROUP_ID} > /dev/null; then \
            groupadd -g ${GROUP_ID} wocker; \
        else \
            GROUP_NAME=$(getent group ${GROUP_ID} | cut -d: -f1); \
            echo "Group ${GROUP_ID} already exists as ${GROUP_NAME}"; \
        fi; \
        if ! getent passwd ${USER_ID} > /dev/null; then \
            GROUP_NAME=$(getent group ${GROUP_ID} | cut -d: -f1); \
            useradd -u ${USER_ID} -g ${GROUP_NAME} -s /bin/bash -m wocker; \
        else \
            USER_NAME=$(getent passwd ${USER_ID} | cut -d: -f1); \
            echo "User ${USER_ID} already exists as ${USER_NAME}"; \
        fi; \
    fi

COPY ./.wocker/bin/entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh && \
    mkdir -p /etc/wocker-init.d

USER ${USER_ID}

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
CMD ["bun", "start"]
