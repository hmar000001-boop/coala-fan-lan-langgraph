#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
mkdir -p Tex/Output

# Render and validate committed Mermaid sources before XeLaTeX.
bash scripts/render-diagrams.sh
bash scripts/check-diagrams.sh

# imakeidx invokes MakeIndex relative to the working directory, while the
# selected build command places all generated files in Tex/Output. These
# temporary links keep both paths consistent without polluting the repo.
ln -sfn Tex/Output/main.idx main.idx
ln -sfn Tex/Output/main.ind main.ind
cleanup() { rm -f main.idx main.ind; }
trap cleanup EXIT

latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode \
  -output-directory=Tex/Output Tex/main.tex

makeglossaries -d Tex/Output main
if [[ -s Tex/Output/main.idx ]]; then
  makeindex -o Tex/Output/main.ind Tex/Output/main.idx
fi

latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode \
  -output-directory=Tex/Output Tex/main.tex

cp Tex/Output/main.pdf Tex/Output/book.pdf
bash scripts/quality-checks.sh Tex/Output/main.pdf Tex/Output/main.log
printf 'Built %s\n' "$ROOT/Tex/Output/book.pdf"
