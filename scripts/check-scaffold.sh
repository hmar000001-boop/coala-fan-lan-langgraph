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
  Tex/part2/chapter09/chapter.tex Tex/part2/chapter10/chapter.tex Tex/part2/chapter11/chapter.tex Tex/part2/chapter12/chapter.tex Tex/part2/chapter13/chapter.tex Tex/part2/chapter14/chapter.tex Tex/part2/chapter15/chapter.tex \
  Tex/part3/chapter30/chapter.tex Tex/standalone/chapter09.tex Tex/standalone/chapter10.tex Tex/standalone/chapter11.tex Tex/standalone/chapter12.tex Tex/standalone/chapter13.tex Tex/standalone/chapter14.tex Tex/standalone/chapter15.tex \
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
for n in 09 10 11 12 13 14 15; do test -s "$ROOT/Tex/standalone/chapter$n.tex" || { echo "Missing standalone build entry for Chapter $n." >&2; exit 1; }; done
for term in globalworkspace broadcast; do
  grep -Fq "\\newglossaryentry{$term}" "$ROOT/Tex/glossary/terms.tex" || { echo "Missing Chapter 14 glossary entry: $term" >&2; exit 1; }
done
# Chapter 12 retains its Markdown outline and has a chapter-local editable LaTeX outline and review PDF.
for artifact in \
  "$ROOT/Tex/part2/chapter12/outline/Chapter_12_Outline_v3.md" \
  "$ROOT/Tex/part2/chapter12/outline/Chapter_12_Outline_Review_v3.tex" \
  "$ROOT/Tex/part2/chapter12/outline/Chapter_12_Outline_Review_v3.pdf"; do
  test -s "$artifact" || { echo "Missing Chapter 12 outline artifact: $artifact" >&2; exit 1; }
done
! grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter12/chapter.tex" || { echo "Chapter 12 still contains a prose placeholder." >&2; exit 1; }
# Chapter 14 has an author-approved B3 outline, drafted prose, and a standalone build.
for artifact in \
  "$ROOT/Tex/part2/chapter14/outline/Chapter_14_Outline_v1.md" \
  "$ROOT/Tex/part2/chapter14/outline/Chapter_14_Outline_v1_body.tex" \
  "$ROOT/Tex/part2/chapter14/outline/Chapter_14_Outline_Review_v1.tex" \
  "$ROOT/Tex/part2/chapter14/outline/Chapter_14_Outline_Review_v1.pdf" \
  "$ROOT/Tex/standalone/chapter14.tex" \
  "$ROOT/review/Chapter_14_Source_Review_v1.md" \
  "$ROOT/review/Chapter_14_Drafting_Review_v1.md" \
  "$ROOT/review/Batch_05_Chapter_14_Outline_Status_v1.md"; do
  test -s "$artifact" || { echo "Missing Chapter 14 outline/draft artifact: $artifact" >&2; exit 1; }
done
for key in fanlan2026mechanisms franklin2012lida shang2026theaterofmind liu2024dylan li2025adaptivegraphpruning; do
  grep -q "{$key," "$ROOT/Tex/bibliography/references.bib" || {
    echo "Missing Chapter 14 bibliography entry: $key" >&2; exit 1;
  }
done
! grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter14/chapter.tex" || {
  echo "Chapter 14 prose source still contains a placeholder." >&2; exit 1;
}
grep -q '\\chapter{Content Competition, Workspace and Broadcast: B3}' "$ROOT/Tex/part2/chapter14/chapter.tex" || {
  echo "Chapter 14 title is missing from the LaTeX source." >&2; exit 1;
}
# Chapter 14's accessible Mermaid sources must each be referenced by the chapter.
for diagram in lida-competition-broadcast-cycle modern-baseline-object-map what-competes productx-workspace-coalition b3-reference-architecture b3-workspace-state-machine b3-outcome-learning-loop b3-evaluation-and-ablation; do
  source="$ROOT/Tex/diagrams/source/part2/chapter14/$diagram.mmd"
  test -s "$source" || { echo "Missing Chapter 14 Mermaid source: $source" >&2; exit 1; }
  grep -q 'accTitle:' "$source" || { echo "Missing Mermaid accTitle: $source" >&2; exit 1; }
  grep -q 'accDescr:' "$source" || { echo "Missing Mermaid accDescr: $source" >&2; exit 1; }
  grep -q "$diagram.png" "$ROOT/Tex/part2/chapter14/chapter.tex" || { echo "Chapter 14 does not reference $diagram.png" >&2; exit 1; }
done
# Every authored chapter in Part II has a standalone build entry.
for n in 09 10 11 12 13 14 15; do test -s "$ROOT/Tex/standalone/chapter$n.tex" || { echo "Missing standalone build entry for Chapter $n." >&2; exit 1; }; done
for term in globalworkspace broadcast; do
  grep -Fq "\\newglossaryentry{$term}" "$ROOT/Tex/glossary/terms.tex" || { echo "Missing Chapter 14 glossary entry: $term" >&2; exit 1; }
done
# Chapter 15 has an approved outline, drafted prose, and a standalone build.
for artifact in \
  "$ROOT/Tex/part2/chapter15/outline/Chapter_15_Outline_v1.md" \
  "$ROOT/Tex/part2/chapter15/outline/Chapter_15_Outline_Review_v1.tex" \
  "$ROOT/Tex/part2/chapter15/outline/Chapter_15_Outline_v1_body.tex" \
  "$ROOT/Tex/part2/chapter15/outline/Chapter_15_Outline_Review_v1.pdf" \
  "$ROOT/Tex/standalone/chapter15.tex" \
  "$ROOT/Tex/part2/chapter15/outline/Chapter_15_Approval_Record_v1.md" \
  "$ROOT/review/Chapter_15_Source_Review_v2.md" \
  "$ROOT/review/Chapter_15_Drafting_Review_v1.md" \
  "$ROOT/review/Batch_06_Chapter_15_Approval_and_Drafting_Status_v1.md"; do
  test -s "$artifact" || { echo "Missing Chapter 15 approval/draft artifact: $artifact" >&2; exit 1; }
done
for key in fanlan2026mechanisms rao1991modelingbdi rao1995bdi kinny1991commitment cox2016midca owayyed2025controlled lawton2026selfawarebdi wang2024devilsadvocate liang2025cca arike2025goaldrift mehta2026premature hu2024adas zhang2024aflow gupta2024metareflection; do
  grep -q "{$key," "$ROOT/Tex/bibliography/references.bib" || {
    echo "Missing Chapter 15 bibliography entry: $key" >&2; exit 1;
  }
done
! grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter15/chapter.tex" || {
  echo "Chapter 15 prose source still contains a placeholder." >&2; exit 1;
}
grep -q '\\chapter{Persistent Intentions, Reconsideration and Method Authority: B4}' "$ROOT/Tex/part2/chapter15/chapter.tex" || {
  echo "Chapter 15 title is missing from the LaTeX source." >&2; exit 1;
}
for diagram in bdi-intention-cycle commitment-versus-reconsideration midca-dual-cycle b4-authority-architecture b4-intention-lifecycle productx-method-switch-sequence b4-outcome-evaluation; do
  source="$ROOT/Tex/diagrams/source/part2/chapter15/$diagram.mmd"
  test -s "$source" || { echo "Missing Chapter 15 Mermaid source: $source" >&2; exit 1; }
  grep -q 'accTitle:' "$source" || { echo "Missing Mermaid accTitle: $source" >&2; exit 1; }
  grep -q 'accDescr:' "$source" || { echo "Missing Mermaid accDescr: $source" >&2; exit 1; }
  grep -q "$diagram.png" "$ROOT/Tex/part2/chapter15/chapter.tex" || { echo "Chapter 15 does not reference $diagram.png" >&2; exit 1; }
done
for term in belief desire intention commitmentpolicy reconsiderationschedule metacontrol methodauthority goaldrift continuationcondition delegationcontract; do
  grep -Fq "\newglossaryentry{$term}" "$ROOT/Tex/glossary/terms.tex" || { echo "Missing Chapter 15 glossary entry: $term" >&2; exit 1; }
done
# Chapter 16 is the single active Markdown-only outline review. It is not yet approved,
# so chapter16/chapter.tex must remain a placeholder and no outline PDF/TeX is generated.
chapter16_outline="$ROOT/Tex/part2/chapter16/outline/Chapter_16_Outline_v1.md"
test -s "$chapter16_outline" || { echo "Missing Chapter 16 Markdown outline: $chapter16_outline" >&2; exit 1; }
grep -q '^\*\*Drafting status:\*\* Not authorized' "$chapter16_outline" || {
  echo "Chapter 16 outline must remain pending approval." >&2; exit 1;
}
grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter16/chapter.tex" || {
  echo "Chapter 16 prose was drafted before outline approval." >&2; exit 1;
}
if find "$ROOT/Tex/part2/chapter16/outline" -maxdepth 1 -type f \( -name '*.pdf' -o -name '*.tex' \) | grep -q .; then
  echo "Chapter 16 outline review must be Markdown-only; found PDF or LaTeX outline artifacts." >&2; exit 1;
fi
echo "Repository structure verified: Part I $count chapters; Part II $count2; Part III $count3. Chapters 1-15 contain drafted prose; Chapter 15 has seven accessible Mermaid sources; Chapter 16 has one pending Markdown outline."
