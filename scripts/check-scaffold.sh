#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for required in \
  Tex/main.tex Tex/preamble.tex Tex/shared-macros.tex \
  Tex/part0/main.tex Tex/part1/main.tex Tex/part2/main.tex Tex/part3/main.tex \
  Tex/part1/chapter01/chapter.tex Tex/part1/chapter02/chapter.tex \
  Tex/part1/chapter03/chapter.tex Tex/part1/chapter04/chapter.tex \
  Tex/part1/chapter05/chapter.tex Tex/part1/chapter06/chapter.tex \
  Tex/part1/chapter07/chapter.tex Tex/part1/chapter08/chapter.tex \
  Tex/part2/chapter09/chapter.tex Tex/part2/chapter10/chapter.tex Tex/part2/chapter11/chapter.tex Tex/part2/chapter12/chapter.tex Tex/part2/chapter13/chapter.tex \
  Tex/part3/chapter30/chapter.tex Tex/standalone/chapter09.tex Tex/standalone/chapter10.tex Tex/standalone/chapter11.tex Tex/standalone/chapter12.tex Tex/standalone/chapter13.tex \
  Tex/bibliography/references.bib \
  .github/workflows/build-book.yml; do
  test -s "$ROOT/$required" || { echo "Missing required file: $required" >&2; exit 1; }
done
count=$(find "$ROOT/Tex/part1" -maxdepth 2 -path '*/chapter*/chapter.tex' | wc -l)
count2=$(find "$ROOT/Tex/part2" -maxdepth 2 -path '*/chapter*/chapter.tex' | wc -l)
count3=$(find "$ROOT/Tex/part3" -maxdepth 2 -path '*/chapter*/chapter.tex' | wc -l)
[[ "$count" -eq 8 && "$count2" -eq 10 && "$count3" -eq 12 ]] || {
  echo "Unexpected chapter scaffold counts: Part I=$count Part II=$count2 Part III=$count3" >&2; exit 1;
}
for n in 01 02 03 04 05 06 07 08; do test -s "$ROOT/Tex/part1/chapter$n/chapter.tex"; done
# Legacy outline artifacts for Chapters 1–2 are preserved in their chapter folders.
test -s "$ROOT/Tex/part1/chapter01/outline/Chapter_01_Outline_Review_v2.md" || {
  echo "Missing legacy Chapter 1 outline source." >&2; exit 1;
}
test -s "$ROOT/Tex/part1/chapter02/outline/Chapter_02_Outline_Review_v1.pdf" || {
  echo "Missing legacy Chapter 2 outline PDF." >&2; exit 1;
}
# Chapters 3–8 have editable, chapter-local outline sources and approved review PDFs.
for n in 03 04 05 06 07 08; do
  outline="$ROOT/Tex/part1/chapter$n/outline/Chapter_${n}_Outline_Review_v1"
  test -s "$outline.tex" || { echo "Missing chapter-local outline source: $outline.tex" >&2; exit 1; }
  test -s "$outline.pdf" || { echo "Missing chapter-local outline PDF: $outline.pdf" >&2; exit 1; }
  ! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter$n/chapter.tex" || {
    echo "Chapter $n has an approved outline but still contains a prose placeholder." >&2; exit 1;
  }
done
for n in 01 02 03 04 05 06 07 08; do
  ! grep -q 'Chapter placeholder' "$ROOT/Tex/part1/chapter$n/chapter.tex" || {
    echo "Chapter $n does not contain prose." >&2; exit 1;
  }
done
# Part II Chapters 9-10 have approved outlines and drafted prose.
for n in 09 10; do
  outline="$ROOT/Tex/part2/chapter$n/outline/Chapter_${n}_Outline_Review_v1"
  test -s "$outline.tex" || { echo "Missing Part II chapter-local outline source: $outline.tex" >&2; exit 1; }
  test -s "$outline.pdf" || { echo "Missing Part II chapter-local outline PDF: $outline.pdf" >&2; exit 1; }
  ! grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter$n/chapter.tex" || {
    echo "Chapter $n has an approved outline but still contains a prose placeholder." >&2; exit 1;
  }
done
# Chapter 11 has an approved, chapter-local outline and drafted prose.
outline="$ROOT/Tex/part2/chapter11/outline/Chapter_11_Outline_Review_v1"
test -s "$outline.tex" || { echo "Missing Chapter 11 outline source: $outline.tex" >&2; exit 1; }
test -s "$outline.pdf" || { echo "Missing Chapter 11 outline PDF: $outline.pdf" >&2; exit 1; }
! grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter11/chapter.tex" || {
  echo "Chapter 11 has an approved outline but still contains a prose placeholder." >&2; exit 1;
}
# Chapter 13 has an author-directed revised outline and drafted prose.
for artifact in \
  "$ROOT/Tex/part2/chapter13/outline/Chapter_13_Outline_v2.md" \
  "$ROOT/Tex/part2/chapter13/outline/Chapter_13_Outline_Review_v2.tex" \
  "$ROOT/Tex/part2/chapter13/outline/Chapter_13_Outline_v2_body.tex" \
  "$ROOT/Tex/part2/chapter13/outline/Chapter_13_Outline_Review_v2.pdf" \
  "$ROOT/review/Chapter_13_Source_Review_v2.md" \
  "$ROOT/review/Chapter_13_Drafting_Review_v1.md" \
  "$ROOT/review/Batch_04_Chapter_13_Outline_Status_v2.md"; do
  test -s "$artifact" || { echo "Missing Chapter 13 outline/draft artifact: $artifact" >&2; exit 1; }
done
for key in soar2025architecture soar2025procedural fanlan2026mechanisms; do
  grep -q "{$key," "$ROOT/Tex/bibliography/references.bib" || {
    echo "Missing Chapter 13 bibliography entry: $key" >&2; exit 1;
  }
done
! grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter13/chapter.tex" || {
  echo "Chapter 13 prose source still contains a placeholder." >&2; exit 1;
}
grep -q '\\chapter{Understanding Typed Impasses, Substates and Compilation: B2}' "$ROOT/Tex/part2/chapter13/chapter.tex" || {
  echo "Chapter 13 title is missing from the LaTeX source." >&2; exit 1;
}
# Chapter 13's five Mermaid sources are required and must be referenced by the chapter.
for diagram in soar-impasse-substate-cycle b2-four-invariants b2-modern-baseline-map b2-reference-implementation productx-b2-recovery-example; do
  source="$ROOT/Tex/diagrams/source/part2/chapter13/$diagram.mmd"
  test -s "$source" || { echo "Missing Chapter 13 Mermaid source: $source" >&2; exit 1; }
  grep -q 'accTitle:' "$source" || { echo "Missing Mermaid accTitle: $source" >&2; exit 1; }
  grep -q 'accDescr:' "$source" || { echo "Missing Mermaid accDescr: $source" >&2; exit 1; }
  grep -q "$diagram.png" "$ROOT/Tex/part2/chapter13/chapter.tex" || { echo "Chapter 13 does not reference $diagram.png" >&2; exit 1; }
done
# Every authored chapter in Part II has a standalone build entry.
for n in 09 10 11 12 13; do test -s "$ROOT/Tex/standalone/chapter$n.tex" || { echo "Missing standalone build entry for Chapter $n." >&2; exit 1; }; done
# Chapter 12 retains its Markdown outline and has a chapter-local editable LaTeX outline and review PDF.
for artifact in \
  "$ROOT/Tex/part2/chapter12/outline/Chapter_12_Outline_v3.md" \
  "$ROOT/Tex/part2/chapter12/outline/Chapter_12_Outline_Review_v3.tex" \
  "$ROOT/Tex/part2/chapter12/outline/Chapter_12_Outline_Review_v3.pdf"; do
  test -s "$artifact" || { echo "Missing Chapter 12 outline artifact: $artifact" >&2; exit 1; }
done
! grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter12/chapter.tex" || { echo "Chapter 12 still contains a prose placeholder." >&2; exit 1; }
echo "Repository structure verified: Part I $count chapters; Part II $count2; Part III $count3. Chapters 1-13 contain prose; Chapter 13 has an author-directed revised Markdown/LaTeX/PDF outline, a standalone build entry, and five accessible Mermaid sources."
