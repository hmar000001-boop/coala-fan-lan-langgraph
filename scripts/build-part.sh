#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PART="${1:-}"
case "$PART" in part0|part1|part2|part3) ;; *) echo "Usage: $0 part0|part1|part2|part3" >&2; exit 2 ;; esac
cd "$ROOT"
mkdir -p "Tex/Output/${PART}"
latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode \
  -output-directory="Tex/Output/${PART}" "Tex/${PART}/main.tex"
if [[ -s "Tex/Output/${PART}/main.glo" ]]; then
  makeglossaries -d "Tex/Output/${PART}" main
fi
if [[ -s "Tex/Output/${PART}/main.idx" ]]; then
  makeindex -o "Tex/Output/${PART}/main.ind" "Tex/Output/${PART}/main.idx"
fi
latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode \
  -output-directory="Tex/Output/${PART}" "Tex/${PART}/main.tex"
printf 'Built part output under %s\n' "$ROOT/Tex/Output/${PART}/"
