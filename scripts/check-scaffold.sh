#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for required in \
  Tex/main.tex Tex/preamble.tex Tex/shared-macros.tex \
  Tex/part0/main.tex Tex/part1/main.tex Tex/part2/main.tex Tex/part3/main.tex \
  Tex/part1/chapter01/chapter.tex Tex/part1/chapter02/chapter.tex \
  Tex/part1/chapter03/chapter.tex Tex/part1/chapter04/chapter.tex Tex/part2/chapter09/chapter.tex \
  Tex/part3/chapter30/chapter.tex Tex/bibliography/references.bib \
  .github/workflows/build-book.yml; do
  test -s "$ROOT/$required" || { echo "Missing required file: $required" >&2; exit 1; }
done
count=$(find "$ROOT/Tex/part1" -maxdepth 2 -path '*/chapter*/chapter.tex' | wc -l)
count2=$(find "$ROOT/Tex/part2" -maxdepth 2 -path '*/chapter*/chapter.tex' | wc -l)
count3=$(find "$ROOT/Tex/part3" -maxdepth 2 -path '*/chapter*/chapter.tex' | wc -l)
[[ "$count" -eq 8 && "$count2" -eq 10 && "$count3" -eq 12 ]] || {
  echo "Unexpected chapter scaffold counts: Part I=$count Part II=$count2 Part III=$count3" >&2; exit 1;
}
for n in 01 02 03 04; do test -s "$ROOT/Tex/part1/chapter$n/chapter.tex"; done
! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter01/chapter.tex"
! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter02/chapter.tex"
! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter03/chapter.tex"
! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter04/chapter.tex"
echo "Repository structure verified: Part I $count chapters; Part II $count2; Part III $count3. Chapters 1-4 contain prose."
