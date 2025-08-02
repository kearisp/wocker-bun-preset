#!/bin/sh

set -e

if ! getent group ${GID} > /dev/null; then
    GROUP_NAME=$USER;

    if grep -q "Alpine" /etc/os-release; then
        addgroup -g ${GID} $GROUP_NAME;
    else
        groupadd -g ${GID} $GROUP_NAME;
    fi
else
    GROUP_NAME=$(getent group ${GID} | cut -d: -f1);
    echo "Group ${GID} already exists as ${GROUP_NAME}";
fi

if ! getent passwd ${UID} > /dev/null; then
    if grep -q "Alpine" /etc/os-release; then
        adduser -u ${UID} -G ${GROUP_NAME} -s /bin/sh -D $USER;
    else
        useradd -u ${UID} -g ${GROUP_NAME} -s /bin/bash -m $USER;
    fi
else
    USER_NAME=$(getent passwd ${UID} | cut -d: -f1);
    echo "User ${UID} already exists as ${USER_NAME}";
fi
