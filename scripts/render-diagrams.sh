#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
mapfile -t diagrams < <(find Tex/diagrams -maxdepth 1 -type f -name '*.mmd' -print | sort)
if (( ${#diagrams[@]} == 0 )); then
  echo "No Mermaid sources yet; skipping diagram rendering."
  exit 0
fi
mkdir -p Tex/diagrams/generated
for source in "${diagrams[@]}"; do
  base="$(basename "$source" .mmd)"
  npx --yes @mermaid-js/mermaid-cli@latest \
    -i "$source" -o "Tex/diagrams/generated/${base}.svg" -b transparent
  npx --yes @mermaid-js/mermaid-cli@latest \
    -i "$source" -o "Tex/diagrams/generated/${base}.pdf" -b white
 done
