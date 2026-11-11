#!/usr/bin/env bash
# Builds a Codex upload zip for every plugin (folders with a top-level plugin.json).
# Usage: scripts/build-zips.sh [plugin-folder ...]   e.g. scripts/build-zips.sh kd-power
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p dist

plugins=("$@")
if [ ${#plugins[@]} -eq 0 ]; then
  for manifest in */plugin.json; do plugins+=("$(dirname "$manifest")"); done
fi

for plugin in "${plugins[@]}"; do
  version=$(python3 -c "import json,sys; print(json.load(open(sys.argv[1]))['version'])" "$plugin/plugin.json")
  out="dist/$plugin-$version.zip"
  rm -f "$out"
  files=(plugin.json)
  for extra in mcp.json skills assets; do
    [ -e "$plugin/$extra" ] && files+=("$extra")
  done
  (cd "$plugin" && zip -rqX "../$out" "${files[@]}" -x "*.DS_Store" "__MACOSX*")
  echo "Built $out"
done
