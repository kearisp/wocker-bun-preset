#!/bin/sh

set -e

if [ ! -d "node_modules" ] || [ "package.json" -nt "node_modules" ]; then
    echo "Installing dependencies..."

    if [ -f "bun.lockb" ]; then
        bun install --lockfile-only;
    else
        bun install;
    fi
fi
