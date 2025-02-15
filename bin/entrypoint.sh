#!/bin/sh

if [ ! -d "node_modules" ]; then
    bun install
fi

exec "$@"
