#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PART="${1:-}"
case "$PART" in part0|part1|part2|part3) ;; *) echo "Usage: $0 part0|part1|part2|part3" >&2; exit 2 ;; esac
cd "$ROOT"
export SOURCE_DATE_EPOCH="${SOURCE_DATE_EPOCH:-1704067200}"
mkdir -p "build/${PART}"
latexmk -xelatex -interaction=nonstopmode -halt-on-error -file-line-error \
  -outdir="build/${PART}" "${PART}/main.tex"
if [[ -f "build/${PART}/main.glo" ]]; then
  makeglossaries -d "build/${PART}" main
fi
if [[ -f "build/${PART}/main.idx" ]]; then
  makeindex -o "build/${PART}/main.ind" "build/${PART}/main.idx"
fi
latexmk -xelatex -interaction=nonstopmode -halt-on-error -file-line-error \
  -outdir="build/${PART}" "${PART}/main.tex"
printf 'Built part output under %s\n' "$ROOT/build/${PART}/"
