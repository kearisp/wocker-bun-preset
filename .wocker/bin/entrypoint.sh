#!/bin/sh

set -e

run_init_scripts() {
    local scripts_dir="$1"

    if [ -d "$scripts_dir" ]; then
        echo "Running initialization scripts from $scripts_dir"

        find "$scripts_dir" -type f -name "*.sh" | sort | while read -r script; do
            if [ -x "$script" ]; then
                echo "Executing $script"
                "$script"
            else
                echo "Executing $script with sh"
                sh "$script"
            fi

            if [ $? -ne 0 ]; then
                echo "Warning: Script $script exited with non-zero status"
            fi
        done

        echo "Initialization scripts completed"
    else
        echo "No initialization scripts directory found at $scripts_dir"
    fi
}

if [ ! -d "node_modules" ] || [ "package.json" -nt "node_modules" ]; then
    echo "Installing dependencies..."
    bun install
fi

run_init_scripts "/etc/wocker-init.d"

exec "$@"
