#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
for n in 03 04 05 06 07 08; do
  source="Tex/part1/chapter${n}/outline/Chapter_${n}_Outline_Review_v1.tex"
  out="Tex/part1/chapter${n}/outline"
  test -s "$source" || { echo "Missing chapter-local outline source: $source" >&2; exit 1; }
  latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode \
    -output-directory="$out" "$source"
done
printf 'Approved outline PDFs for Chapters 3–8 were built in their chapter folders.\n'
