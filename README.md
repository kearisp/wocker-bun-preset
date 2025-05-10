# Bun Preset for Wocker

[![Version](https://img.shields.io/badge/version-1.0.1-blue.svg)](https://github.com/kearisp/wocker)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)

A lightweight and efficient preset for developing Bun.js applications with the Wocker workspace.

## Installation

You can add this preset to an existing Wocker project:

```shell
ws preset:add bun
```

## Features

- 🚀 Ready-to-use Bun.js environment
- 🔄 Automatic dependencies installation
- 📁 Support for initialization scripts

## Usage

### Initialization Scripts

You can mount a directory with custom initialization scripts that will run on container startup:

```shell
ws volume:mount ./my-scripts:/etc/wocker-init.d
```

Scripts are executed in alphabetical order. Consider using numeric prefixes (e.g., `10-setup.sh`, `20-migrate.sh`) to control execution order.

### Environment Variables

The preset supports common Wocker environment variables, plus:

- `VIRTUAL_PORT`: Default port your Bun application should listen on (provided by nginx-proxy)

Example of using the environment port in your app:

```javascript
import { serve } from "bun";

serve({
    port: process.env.VIRTUAL_PORT || 3000,
    fetch(request) {
        return new Response("Hello from Bun!");
    }
});
```


### Docker Image

This preset uses the official Bun Docker image ([`oven/bun`](https://hub.docker.com/r/oven/bun)) with Alpine Linux by default. You can change the version: `oven/bun`

```textmate
ws build-args:set VERSION=latest
```

Available options: `alpine`, `latest`, `slim`, or a specific version like `1.0.11`.

For a complete list of available Bun versions, see: [https://hub.docker.com/r/oven/bun/tags](https://hub.docker.com/r/oven/bun/tags)

## Prerequisites

- Docker installed and running
- Wocker CLI installed
- Basic understanding of Bun.js

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

_This preset is part of the [Wocker](https://kearisp.github.io/wocker) ecosystem._
