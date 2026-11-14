#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
mkdir -p Tex/Output
for n in 01 02; do
  job="Chapter_${n}"
  latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode \
    -jobname="$job" -output-directory=Tex/Output "Tex/standalone/chapter${n}.tex"
  if [[ -s "Tex/Output/${job}.glo" ]]; then
    makeglossaries -d Tex/Output "$job"
  fi
  if [[ -s "Tex/Output/${job}.idx" ]]; then
    makeindex -o "Tex/Output/${job}.ind" "Tex/Output/${job}.idx"
  fi
  latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode \
    -jobname="$job" -output-directory=Tex/Output "Tex/standalone/chapter${n}.tex"
done
printf 'Chapter PDFs are in Tex/Output/Chapter_01.pdf and Chapter_02.pdf\n'
