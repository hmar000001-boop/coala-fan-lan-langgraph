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
  Tex/part2/chapter09/chapter.tex Tex/part2/chapter10/chapter.tex Tex/part2/chapter11/chapter.tex Tex/part2/chapter12/chapter.tex Tex/part2/chapter13/chapter.tex Tex/part2/chapter14/chapter.tex Tex/part2/chapter15/chapter.tex Tex/part2/chapter16/chapter.tex Tex/part2/chapter17/chapter.tex Tex/part2/chapter18/chapter.tex \
  Tex/part3/chapter19/chapter.tex Tex/part3/chapter20/chapter.tex Tex/part3/chapter21/chapter.tex Tex/part3/chapter22/chapter.tex Tex/part3/chapter23/chapter.tex Tex/part3/chapter24/chapter.tex Tex/standalone/chapter19.tex Tex/standalone/chapter20.tex Tex/standalone/chapter21.tex Tex/standalone/chapter22.tex Tex/standalone/chapter09.tex Tex/standalone/chapter10.tex Tex/standalone/chapter11.tex Tex/standalone/chapter12.tex Tex/standalone/chapter13.tex Tex/standalone/chapter14.tex Tex/standalone/chapter15.tex Tex/standalone/chapter16.tex Tex/standalone/chapter17.tex Tex/standalone/chapter18.tex \
  Tex/bibliography/references.bib \
  .github/workflows/build-book.yml; do
  test -s "$ROOT/$required" || { echo "Missing required file: $required" >&2; exit 1; }
done
count=$(find "$ROOT/Tex/part1" -maxdepth 2 -path '*/chapter*/chapter.tex' | wc -l)
count2=$(find "$ROOT/Tex/part2" -maxdepth 2 -path '*/chapter*/chapter.tex' | wc -l)
count3=$(find "$ROOT/Tex/part3" -maxdepth 2 -path '*/chapter*/chapter.tex' | wc -l)
[[ "$count" -eq 8 && "$count2" -eq 10 && "$count3" -eq 6 ]] || {
  echo "Unexpected chapter scaffold counts: Part I=$count Part II=$count2 Part III=$count3 (expected 8, 10, and 6)" >&2; exit 1;
}
for n in 01 02 03 04 05 06 07 08; do test -s "$ROOT/Tex/part1/chapter$n/chapter.tex"; done
# Part III must remain exactly six canonical build chapters: 19-24.
# Chapters 19-22 are drafted from individually approved outlines; Chapters 23-24 remain placeholders.
for n in 23 24; do
  chapter="$ROOT/Tex/part3/chapter$n/chapter.tex"
  test -s "$chapter" || { echo "Missing Part III chapter scaffold: chapter$n" >&2; exit 1; }
  grep -q 'Chapter placeholder' "$chapter" || {
    echo "Part III Chapter $n must remain a placeholder until its outline is individually approved." >&2; exit 1;
  }
done
! grep -q 'Chapter placeholder' "$ROOT/Tex/part3/chapter19/chapter.tex" || {
  echo "Part III Chapter 19 must contain drafted prose." >&2; exit 1;
}
grep -Fq '\chapter{Engineering Foundations for Request-Driven Enterprise Agentic Systems}' "$ROOT/Tex/part3/chapter19/chapter.tex" || {
  echo "Part III Chapter 19 title does not match the approved scope." >&2; exit 1;
}
! grep -q 'Chapter placeholder' "$ROOT/Tex/part3/chapter20/chapter.tex" || {
  echo "Part III Chapter 20 must contain drafted prose." >&2; exit 1;
}
grep -Fq '\chapter{CoALA in Code: Memory, Actions, and Planning}' "$ROOT/Tex/part3/chapter20/chapter.tex" || {
  echo "Part III Chapter 20 title does not match the approved scope." >&2; exit 1;
}
test -s "$ROOT/Tex/part3/chapter20/outline/Chapter_20_Outline.md" || {
  echo "Missing approved Chapter 20 Markdown outline." >&2; exit 1;
}
grep -q 'Outline status:.*approved by the author' "$ROOT/Tex/part3/chapter20/outline/Chapter_20_Outline.md" || {
  echo "Chapter 20 outline must record author approval." >&2; exit 1;
}
test -s "$ROOT/Tex/standalone/chapter20.tex" || {
  echo "Missing Chapter 20 standalone build entry." >&2; exit 1;
}
! grep -q 'Chapter placeholder' "$ROOT/Tex/part3/chapter21/chapter.tex" || {
  echo "Part III Chapter 21 must contain drafted prose." >&2; exit 1;
}
grep -Fq '\chapter{Memory Selection and Workspace Competition: B1 and B3}' "$ROOT/Tex/part3/chapter21/chapter.tex" || {
  echo "Part III Chapter 21 title does not match the approved scope." >&2; exit 1;
}
test -s "$ROOT/Tex/part3/chapter21/outline/Chapter_21_Outline.md" || {
  echo "Missing Chapter 21 Markdown outline." >&2; exit 1;
}
grep -q 'Outline status:.*approved by the author' "$ROOT/Tex/part3/chapter21/outline/Chapter_21_Outline.md" || {
  echo "Chapter 21 outline must record author approval." >&2; exit 1;
}
test -s "$ROOT/Tex/standalone/chapter21.tex" || {
  echo "Missing Chapter 21 standalone build entry." >&2; exit 1;
}
for diagram in b1-selection-sequence evidence-states-overview b1-b3-explicit-handoff b3-admission-competition b3-receipt-outcome-loop complete-b1-b3-evidence-path; do
  source="$ROOT/Tex/diagrams/source/part3/chapter21/$diagram.mmd"
  test -s "$source" || { echo "Missing Chapter 21 Mermaid source: $source" >&2; exit 1; }
  grep -q 'accTitle:' "$source" || { echo "Missing Chapter 21 Mermaid accTitle: $source" >&2; exit 1; }
  grep -q 'accDescr:' "$source" || { echo "Missing Chapter 21 Mermaid accDescr: $source" >&2; exit 1; }
  grep -q "$diagram.png" "$ROOT/Tex/part3/chapter21/chapter.tex" || { echo "Chapter 21 does not reference $diagram.png" >&2; exit 1; }
done
! grep -q 'Chapter placeholder' "$ROOT/Tex/part3/chapter22/chapter.tex" || {
  echo "Part III Chapter 22 must contain drafted prose." >&2; exit 1;
}
grep -Fq '\chapter{Typed Impasses and Protected Recovery: B2}' "$ROOT/Tex/part3/chapter22/chapter.tex" || {
  echo "Part III Chapter 22 title does not match the approved scope." >&2; exit 1;
}
test -s "$ROOT/Tex/part3/chapter22/outline/Chapter_22_Outline_v2.md" || {
  echo "Missing Chapter 22 approved outline v2." >&2; exit 1;
}
grep -q 'Outline status:.*approved by the author' "$ROOT/Tex/part3/chapter22/outline/Chapter_22_Outline_v2.md" || {
  echo "Chapter 22 outline must record author approval." >&2; exit 1;
}
test -s "$ROOT/Tex/standalone/chapter22.tex" || {
  echo "Missing Chapter 22 standalone build entry." >&2; exit 1;
}
for diagram in b2-parent-child-ownership b2-subgraph-sequence b2-child-step-receipts b2-return-and-draft-checks b2-procedure-reuse-lifecycle; do
  source="$ROOT/Tex/diagrams/source/part3/chapter22/$diagram.mmd"
  test -s "$source" || { echo "Missing Chapter 22 Mermaid source: $source" >&2; exit 1; }
  grep -q 'accTitle:' "$source" || { echo "Missing Chapter 22 Mermaid accTitle: $source" >&2; exit 1; }
  grep -q 'accDescr:' "$source" || { echo "Missing Chapter 22 Mermaid accDescr: $source" >&2; exit 1; }
  grep -q "$diagram.png" "$ROOT/Tex/part3/chapter22/chapter.tex" || { echo "Chapter 22 does not reference $diagram.png" >&2; exit 1; }
done
for spec in \
  '20|CoALA in Code: Memory, Actions, and Planning' \
  '21|Memory Selection and Workspace Competition: B1 and B3' \
  '22|Typed Impasses and Protected Recovery: B2' \
  '23|Persistent Intention and Resource Governance: B4 and B6' \
  '24|Composing the Supply-Chain Agent: Graph Orchestration, Persistence, and Simulated Execution'; do
  n="${spec%%|*}"
  title="${spec#*|}"
  grep -Fq "\\chapter{$title}" "$ROOT/Tex/part3/chapter$n/chapter.tex" || {
    echo "Part III Chapter $n title does not match the approved scope." >&2; exit 1;
  }
done
# Chapter 20's accessible Mermaid sources must all be present and referenced.
for diagram in coala-implementation-map four-memory-responsibilities internal-actions-memory-write perception-versus-grounding planning-branch-boundary planner-strategy-contrast evaluation-selection-authority; do
  source="$ROOT/Tex/diagrams/source/part3/chapter20/$diagram.mmd"
  test -s "$source" || { echo "Missing Chapter 20 Mermaid source: $source" >&2; exit 1; }
  grep -q '^flowchart ' "$source" || { echo "Chapter 20 Mermaid declaration must precede accessibility metadata: $source" >&2; exit 1; }
  grep -q 'accTitle:' "$source" || { echo "Missing Mermaid accTitle: $source" >&2; exit 1; }
  grep -q 'accDescr:' "$source" || { echo "Missing Mermaid accDescr: $source" >&2; exit 1; }
  grep -q "$diagram.png" "$ROOT/Tex/part3/chapter20/chapter.tex" || { echo "Chapter 20 does not reference $diagram.png" >&2; exit 1; }
done

for n in $(seq 25 30); do
  if [[ -e "$ROOT/Tex/part3/chapter$n" ]]; then
    echo "Obsolete Part III case-study scaffold remains: chapter$n" >&2; exit 1;
  fi
done
for n in 19 20 21 22 23 24; do
  grep -Fq "Tex/part3/chapter$n/chapter.tex" "$ROOT/Tex/part3/content.tex" || {
    echo "Part III does not include Chapter $n." >&2; exit 1;
  }
done
for n in 19 20 21 22 23 24; do
  outline="$ROOT/Tex/part3/chapter$n/outline"
  test -d "$outline" && find "$outline" -maxdepth 1 -type f -name '*.md' -print -quit | grep -q . || {
    echo "Missing chapter-local Markdown outline for Part III Chapter $n." >&2; exit 1;
  }
done
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
# Chapters 16 and 17 use the current Markdown-only outline review convention and are authorized/drafted.
chapter16_outline="$ROOT/Tex/part2/chapter16/outline/Chapter_16_Outline_v1.md"
test -s "$chapter16_outline" || { echo "Missing Chapter 16 Markdown outline: $chapter16_outline" >&2; exit 1; }
grep -q '^\*\*Drafting status:\*\* Authorized' "$chapter16_outline" || {
  echo "Chapter 16 outline must record the author's drafting authorization." >&2; exit 1;
}
! grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter16/chapter.tex" || {
  echo "Chapter 16 prose source still contains a placeholder." >&2; exit 1;
}
grep -q '\\chapter{Uncertainty, Resources, Interruption and Stopping: B6}' "$ROOT/Tex/part2/chapter16/chapter.tex" || {
  echo "Chapter 16 title is missing from the LaTeX source." >&2; exit 1;
}
test -s "$ROOT/Tex/standalone/chapter16.tex" || { echo "Missing Chapter 16 standalone build entry." >&2; exit 1; }
for key in fanlan2026mechanisms kieras1997epic rosenbloom2016sigma meiaiOS2024 she2026agentrm li2026bavt han2024uala ren2023knowno ding2026calibratethenact liu2026utilityorchestration langgraph2026repo openaiagents2026repo; do
  grep -q "{$key," "$ROOT/Tex/bibliography/references.bib" || {
    echo "Missing Chapter 16 bibliography entry: $key" >&2; exit 1;
  }
done
for diagram in epic-resource-bottlenecks sigma-uncertainty-propagation b6-modern-baseline-map b6-cross-stage-control-loop b6-resource-vector-scheduler b6-authorization-and-interruption b6-state-machine productx-b6-incident-sequence b6-evaluation-ablation; do
  source="$ROOT/Tex/diagrams/source/part2/chapter16/$diagram.mmd"
  test -s "$source" || { echo "Missing Chapter 16 Mermaid source: $source" >&2; exit 1; }
  grep -q 'accTitle:' "$source" || { echo "Missing Mermaid accTitle: $source" >&2; exit 1; }
  grep -q 'accDescr:' "$source" || { echo "Missing Mermaid accDescr: $source" >&2; exit 1; }
  grep -q "$diagram.png" "$ROOT/Tex/part2/chapter16/chapter.tex" || { echo "Chapter 16 does not reference $diagram.png" >&2; exit 1; }
done
for term in epic sigma uncertaintyestimate calibration uncertaintylineage resourcevector resourcecontention preemption interruption cancellation selectiverisk abstention verificationcost; do
  grep -Fq "\\newglossaryentry{$term}" "$ROOT/Tex/glossary/terms.tex" || { echo "Missing Chapter 16 glossary entry: $term" >&2; exit 1; }
done
for artifact in \
  "$ROOT/review/Chapter_16_Source_Review_v1.md" \
  "$ROOT/review/Chapter_16_Drafting_Review_v1.md" \
  "$ROOT/review/Batch_07_Chapter_16_Authoring_Status_v1.md"; do
  test -s "$artifact" || { echo "Missing Chapter 16 review artifact: $artifact" >&2; exit 1; }
done
if find "$ROOT/Tex/part2/chapter16/outline" -maxdepth 1 -type f \( -name '*.pdf' -o -name '*.tex' \) | grep -q .; then
  echo "Chapter 16 outline review must be Markdown-only; found PDF or LaTeX outline artifacts." >&2; exit 1;
fi
# Chapter 17 is the approved Batch 8 closed-candidate case and has completed prose.
chapter17_outline="$ROOT/Tex/part2/chapter17/outline/Chapter_17_Outline_v1.md"
test -s "$chapter17_outline" || { echo "Missing Chapter 17 Markdown outline: $chapter17_outline" >&2; exit 1; }
grep -q '^\*\*Drafting status:\*\* Authorized' "$chapter17_outline" || {
  echo "Chapter 17 outline must record the author's drafting authorization." >&2; exit 1;
}
! grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter17/chapter.tex" || {
  echo "Chapter 17 prose source still contains a placeholder." >&2; exit 1;
}
grep -q '\\chapter{The Closed Candidate B5 and GraSP}' "$ROOT/Tex/part2/chapter17/chapter.tex" || {
  echo "Chapter 17 title is missing from the LaTeX source." >&2; exit 1;
}
test -s "$ROOT/Tex/standalone/chapter17.tex" || { echo "Missing Chapter 17 standalone build entry." >&2; exit 1; }
for key in fanlan2026mechanisms xia2026grasp choi2018icarus; do
  grep -q "{$key," "$ROOT/Tex/bibliography/references.bib" || {
    echo "Missing Chapter 17 bibliography entry: $key" >&2; exit 1;
  }
done
for diagram in b5-candidate-to-closure grasp-four-stage-pipeline grasp-retrieval-confidence grasp-typed-dag-edges grasp-node-execution-and-failure grasp-five-repair-operators grasp-escalation-lifecycle b5-evidence-depth-packet grasp-evaluation-and-ablations; do
  source="$ROOT/Tex/diagrams/source/part2/chapter17/$diagram.mmd"
  test -s "$source" || { echo "Missing Chapter 17 Mermaid source: $source" >&2; exit 1; }
  grep -q 'accTitle:' "$source" || { echo "Missing Mermaid accTitle: $source" >&2; exit 1; }
  grep -q 'accDescr:' "$source" || { echo "Missing Mermaid accDescr: $source" >&2; exit 1; }
  grep -q "$diagram.png" "$ROOT/Tex/part2/chapter17/chapter.tex" || { echo "Chapter 17 does not reference $diagram.png" >&2; exit 1; }
done
for term in skill skilllibrary skillgraph skillnode skillverifier stateedge dataedge orderedge repairoperator retrievalconfidence graphcompilation; do
  grep -Fq "\\newglossaryentry{$term}" "$ROOT/Tex/glossary/terms.tex" || { echo "Missing Chapter 17 glossary entry: $term" >&2; exit 1; }
done
for artifact in \
  "$ROOT/review/Chapter_17_Source_Review_v1.md" \
  "$ROOT/review/Chapter_17_Drafting_Review_v1.md" \
  "$ROOT/review/Batch_08_Chapter_17_Authoring_Status_v1.md"; do
  test -s "$artifact" || { echo "Missing Chapter 17 review artifact: $artifact" >&2; exit 1; }
done
if find "$ROOT/Tex/part2/chapter17/outline" -maxdepth 1 -type f \( -name '*.pdf' -o -name '*.tex' \) | grep -q .; then
  echo "Chapter 17 outline review must be Markdown-only; found PDF or LaTeX outline artifacts." >&2; exit 1;
fi
# Chapter 18 is the approved Batch 9 synthesis and must contain prose, not a placeholder.
chapter18_outline="$ROOT/Tex/part2/chapter18/outline/Chapter_18_Outline_v1.md"
test -s "$chapter18_outline" || { echo "Missing Chapter 18 Markdown outline: $chapter18_outline" >&2; exit 1; }
grep -q '^\*\*Status:\*\* Approved' "$chapter18_outline" || {
  echo "Chapter 18 outline must record author approval." >&2; exit 1;
}
grep -q '^\*\*Prose drafting:\*\* Authorized' "$chapter18_outline" || {
  echo "Chapter 18 outline must record drafting authorization." >&2; exit 1;
}
! grep -q 'Chapter placeholder' "$ROOT/Tex/part2/chapter18/chapter.tex" || {
  echo "Chapter 18 prose source still contains a placeholder." >&2; exit 1;
}
grep -q '\\chapter{How the Mechanisms Work Together}' "$ROOT/Tex/part2/chapter18/chapter.tex" || {
  echo "Chapter 18 title is missing from the LaTeX source." >&2; exit 1;
}
test -s "$ROOT/Tex/standalone/chapter18.tex" || { echo "Missing Chapter 18 standalone build entry." >&2; exit 1; }
for artifact in \
  "$ROOT/review/Chapter_18_Source_Review_v1.md" \
  "$ROOT/review/Chapter_18_Drafting_Review_v1.md" \
  "$ROOT/review/Batch_09_Chapter_18_Authoring_Status_v1.md"; do
  test -s "$artifact" || { echo "Missing Chapter 18 review artifact: $artifact" >&2; exit 1; }
done
if find "$ROOT/Tex/part2/chapter18/outline" -maxdepth 1 -type f \( -name '*.pdf' -o -name '*.tex' \) | grep -q .; then
  echo "Chapter 18 outline review must be Markdown-only; found PDF or LaTeX outline artifacts." >&2; exit 1;
fi
for diagram in five-residuals-one-closed-case shared-state-and-authority-boundaries authority-responsibility-map cross-bundle-dependencies implementation-order-and-stage-gates bounded-synthesis-runtime productx-composed-run compositional-ablation-matrix cross-bundle-state-handoffs; do
  source="$ROOT/Tex/diagrams/source/part2/chapter18/$diagram.mmd"
  test -s "$source" || { echo "Missing Chapter 18 Mermaid source: $source" >&2; exit 1; }
  grep -q 'accTitle:' "$source" || { echo "Missing Mermaid accTitle: $source" >&2; exit 1; }
  grep -q 'accDescr:' "$source" || { echo "Missing Mermaid accDescr: $source" >&2; exit 1; }
  grep -q "$diagram.png" "$ROOT/Tex/part2/chapter18/chapter.tex" || { echo "Chapter 18 does not reference $diagram.png" >&2; exit 1; }
done
for term in compositionalcontrol crossbundledependency boundedsynthesisruntime authorityboundary outcomeattribution compositionalablation partialcomposition resourcereservation; do
  grep -Fq "\\newglossaryentry{$term}" "$ROOT/Tex/glossary/terms.tex" || { echo "Missing Chapter 18 glossary entry: $term" >&2; exit 1; }
done
echo "Repository structure verified: Part I $count chapters; Part II $count2; Part III $count3. Chapters 1-22 contain drafted prose; Chapters 23-24 remain outline-gated; Chapters 16-18 retain one canonical Markdown-only outline each; Chapter 18 has nine accessible Mermaid sources."
