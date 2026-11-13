#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
export SOURCE_DATE_EPOCH="${SOURCE_DATE_EPOCH:-1704067200}"
mkdir -p build
latexmk -xelatex -interaction=nonstopmode -halt-on-error -file-line-error \
  -outdir=build main.tex

# Generate glossary and index files explicitly. This keeps auxiliary paths inside build/.
if [[ -f build/main.glo ]]; then
  makeglossaries -d build main
fi
if [[ -f build/main.idx ]]; then
  makeindex -o build/main.ind build/main.idx
fi

latexmk -xelatex -interaction=nonstopmode -halt-on-error -file-line-error \
  -outdir=build main.tex
if [[ ! -s build/main.pdf ]]; then
  echo "Expected build/main.pdf was not produced." >&2
  exit 1
fi
cp build/main.pdf build/book.pdf
printf 'Built %s\n' "$ROOT/build/book.pdf"
