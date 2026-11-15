#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
for pair in \
  "part1 03" "part1 04" "part1 05" "part1 06" "part1 07" "part1 08" \
  "part2 09" "part2 10" "part2 11"; do
  read -r part n <<< "$pair"
  source="Tex/${part}/chapter${n}/outline/Chapter_${n}_Outline_Review_v1.tex"
  out="Tex/${part}/chapter${n}/outline"
  test -s "$source" || { echo "Missing chapter-local outline source: $source" >&2; exit 1; }
  latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode \
    -output-directory="$out" "$source"
done
source=Tex/part2/chapter12/outline/Chapter_12_Outline_Review_v3.tex
out=Tex/part2/chapter12/outline
test -s "$source" || { echo "Missing chapter-local outline source: $source" >&2; exit 1; }
latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode -output-directory="$out" "$source"

source=Tex/part2/chapter13/outline/Chapter_13_Outline_Review_v2.tex
out=Tex/part2/chapter13/outline
test -s "$source" || { echo "Missing chapter-local outline source: $source" >&2; exit 1; }
test -s Tex/part2/chapter13/outline/Chapter_13_Outline_v2_body.tex || { echo "Missing generated LaTeX outline body." >&2; exit 1; }
latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode -output-directory="$out" "$source"
printf 'Chapter-local outline PDFs for Chapters 3–13 were built in their matching chapter folders.\n'
