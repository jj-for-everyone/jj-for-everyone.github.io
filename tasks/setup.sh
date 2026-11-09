#!/usr/bin/env bash
set -euo pipefail # enable strict error handling

packages=(
  mdbook@0.4.51
  mdbook-admonish@1.20.0
)
cargo binstall --no-confirm --install-path=bin "${packages[@]}"
