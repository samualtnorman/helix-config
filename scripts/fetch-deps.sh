#!/bin/sh
set -eux
mkdir --parents deps
curl https://raw.githubusercontent.com/helix-editor/helix/refs/tags/25.07.1/languages.toml | toml2json > deps/languages.json
curl https://www.schemastore.org/api/json/catalog.json | jq .schemas > deps/schemastore.json
