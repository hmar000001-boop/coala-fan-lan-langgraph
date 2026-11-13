#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
mapfile -t diagrams < <(find diagrams -maxdepth 1 -type f -name '*.mmd' -print | sort)
if (( ${#diagrams[@]} == 0 )); then
  echo "No Mermaid sources yet; skipping diagram rendering."
  exit 0
fi
mkdir -p build/diagrams
for source in "${diagrams[@]}"; do
  base="$(basename "$source" .mmd)"
  npx --yes @mermaid-js/mermaid-cli@latest \
    -i "$source" -o "build/diagrams/${base}.svg" -b transparent
  npx --yes @mermaid-js/mermaid-cli@latest \
    -i "$source" -o "build/diagrams/${base}.pdf" -b white
 done
