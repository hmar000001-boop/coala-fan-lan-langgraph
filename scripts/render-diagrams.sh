#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
SOURCE_ROOT="Tex/diagrams/source"
OUTPUT_ROOT="Tex/diagrams/generated"
MMDC="$ROOT/tools/mermaid/node_modules/.bin/mmdc"
CONFIG="Tex/diagrams/mermaid.config.json"
PUPPETEER="Tex/diagrams/puppeteer.config.json"
[[ -d "$SOURCE_ROOT" ]] || { echo "Mermaid source directory is missing: $SOURCE_ROOT" >&2; exit 1; }
[[ -s "$CONFIG" ]] || { echo "Mermaid theme configuration is missing: $CONFIG" >&2; exit 1; }
[[ -s "$PUPPETEER" ]] || { echo "Puppeteer configuration is missing: $PUPPETEER" >&2; exit 1; }
[[ -x "$MMDC" ]] || { echo "Mermaid CLI is not installed. Run: npm install --prefix tools/mermaid --no-audit --no-fund" >&2; exit 1; }
CLI_VERSION="$("$MMDC" --version)"
[[ "$CLI_VERSION" == *"12.2.0"* ]] || { echo "Expected Mermaid CLI 12.2.0, found: $CLI_VERSION" >&2; exit 1; }
mapfile -d '' diagrams < <(find "$SOURCE_ROOT" -type f -name '*.mmd' -print0 | sort -z)
(( ${#diagrams[@]} > 0 )) || { echo "No Mermaid .mmd sources found under $SOURCE_ROOT" >&2; exit 1; }
for source in "${diagrams[@]}"; do
  relative="${source#"$SOURCE_ROOT"/}"
  output="$OUTPUT_ROOT/${relative%.mmd}.png"
  mkdir -p "$(dirname "$output")"
  echo "Rendering $source -> $output"
  "$MMDC" --input "$source" --output "$output" --configFile "$CONFIG" --puppeteerConfigFile "$PUPPETEER" --backgroundColor '#FFFFFF' --size 3200
  [[ -s "$output" ]] || { echo "Mermaid did not create a non-empty PNG: $output" >&2; exit 1; }
done
printf 'Rendered %d Mermaid diagram(s) to PNG.\n' "${#diagrams[@]}"
