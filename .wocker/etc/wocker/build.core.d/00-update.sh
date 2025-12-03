#!/bin/sh

set -e

echo "Updating package lists..."

if grep -q "Alpine" /etc/os-release; then
    if ! command -v apk >/dev/null 2>&1; then
        echo "Error: apk package manager not found"
        exit 1
    fi

    echo "Using Alpine package manager (apk)"
    apk update || { echo "Failed to update apk packages"; exit 1; }
else
    if ! command -v apt-get >/dev/null 2>&1; then
        echo "Error: apt-get package manager not found"
        exit 1
    fi

    echo "Using Debian/Ubuntu package manager (apt-get)"
    apt-get update --fix-missing -y || { echo "Failed to update apt packages"; exit 1; }
    apt-get clean
    rm -rf /var/lib/apt/lists/*
fi

echo "Package lists updated successfully"
