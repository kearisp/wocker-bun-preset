#!/bin/sh

set -e

ws-run-hook init

exec "$@"
