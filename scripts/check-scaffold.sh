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
for n in 01 02 03 04 05 06; do test -s "$ROOT/Tex/part1/chapter$n/chapter.tex"; done
for n in 07 08; do
  outline="$ROOT/Tex/part1/chapter$n/outline/Chapter_${n}_Outline_Review_v1"
  test -s "$outline.tex" || { echo "Missing chapter-local outline source: $outline.tex" >&2; exit 1; }
  test -s "$outline.pdf" || { echo "Missing chapter-local outline PDF: $outline.pdf" >&2; exit 1; }
  grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter$n/chapter.tex" || {
    echo "Chapter $n must remain a prose placeholder until its outline is approved." >&2; exit 1;
  }
done
! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter01/chapter.tex"
! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter02/chapter.tex"
! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter03/chapter.tex"
! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter04/chapter.tex"
! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter05/chapter.tex"
! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter06/chapter.tex"
echo "Repository structure verified: Part I $count chapters; Part II $count2; Part III $count3. Chapters 1-6 contain prose; Chapter 7-8 outlines are stored in their chapter folders and remain approval-gated."
