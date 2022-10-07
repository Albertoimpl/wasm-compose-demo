#!/usr/bin/env bash

set -euo pipefail

main() {
  pushd "$(dirname "$0")/wasm-tools/crates/wasm-compose/example/backend" >/dev/null
    cargo component build --release
  popd >/dev/null
  pushd "$(dirname "$0")/wasm-tools/crates/wasm-compose/example/middleware" >/dev/null
    cargo component build --release
  popd >/dev/null
  pushd "$(dirname "$0")/wasm-tools/crates/wasm-compose/example/service" >/dev/null
    cargo component build --release
  popd >/dev/null

  pushd "$(dirname "$0")/wasm-tools/crates/wasm-compose/example/server" >/dev/null
    wasm-tools compose -c config.yml -o service.wasm ../service/target/wasm32-unknown-unknown/release/svc.wasm
    cargo run  --release -- service.wasm
  popd >/dev/null
}

main "$@"
