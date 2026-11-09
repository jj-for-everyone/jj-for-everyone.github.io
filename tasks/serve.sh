#!/usr/bin/env bash
set -euo pipefail # enable strict error handling

exec ./bin/mdbook serve --port 3210
