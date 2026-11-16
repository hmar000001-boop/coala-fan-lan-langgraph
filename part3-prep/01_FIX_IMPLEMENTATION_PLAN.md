---
title: "LaTeX Correction Implementation Plan — Parts I and II"
subtitle: "From Cognitive Architectures to Production Agentic Systems"
author: "Editorial and technical correction plan"
date: "16 November 2026"
toc: true
toc-depth: 2
numbersections: false
geometry: margin=0.78in
fontsize: 10pt
colorlinks: true
linkcolor: teal
urlcolor: teal
---

# LaTeX Correction Implementation Plan — Parts I and II

**Book:** *From Cognitive Architectures to Production Agentic Systems*  
**Baseline artifact:** user-provided `book.pdf`, 597 pages, dated 15 November 2026  
**Source baseline:** latest available complete-project archive, Chapters 1–18  
**Status:** Proposed plan; no corrections have been applied  
**Objective:** correct confirmed defects and reduce unnecessary repetition without weakening the book's ideas, evidence, explanations or teaching progression.

## 1. Recommendation

Apply the corrections in **five controlled phases**. Five phases are enough to isolate source/build discovery, technical correctness, Part I editing, Part II editing, and final consistency/release validation. Fewer phases would mix risky source repairs with large editorial transformations; more phases would create unnecessary hand-offs and repeated full-book rebuilds.

The plan is deliberately not a word-count reduction exercise. The review's estimated 7–10% selective compression is a planning estimate, not a target. Each proposed deletion must pass one test:

> Is the idea already explained completely and more usefully elsewhere in this chapter or in an earlier/later chapter? If not, retain it, shorten it, or merge it rather than deleting it.

No chapter, mechanism study, historical evidence set, central worked example, or substantial implementation bridge is scheduled for deletion.

## 2. Editing principles and safeguards

1. **Preserve every distinct idea.** Delete duplicated presentation, not unique explanation, source evidence, counterexamples, design constraints, evaluation criteria or failure analysis.
2. **One authoritative explanation.** Each concept should have a primary home. Later chapters may refer back to it and apply it, but should not re-teach the same definition at equal length.
3. **Worked examples have a purpose.** Keep the full worked example where it teaches the chapter's specific mechanism. Shorten repeated scenario setup around it; do not remove the state transitions or evidence trace that make the example useful.
4. **Boxes must earn their space.** A box remains only when it adds a distinct warning, source boundary, diagnostic, worked result or reference. A takeaway that paraphrases the next paragraph or recap is removed or merged.
5. **Do not flatten Part II.** The historical mechanism, seven-field analysis, modern comparison, engineering proposal, failure model and evaluation are different layers. Compress only where the same layer is repeated.
6. **Preserve provenance.** Source claims, book examples and engineering decisions must remain distinguishable. Chapter-level source/example notes are retained; local attribution is added where a Java-like contract could be mistaken for a source-paper implementation.
7. **Part III boundary is revised explicitly.** The old promise of ten framework-based systems is replaced by the currently selected plan: one Java, framework-independent, request-driven supply-chain system preceded by an engineering-foundation chapter. No LangGraph4j or LangChain4j implementation is introduced.
8. **No silent mathematical or theoretical changes.** Equations, claims about ACT-R, Soar, GraSP, CoALA and Fan & Lan are not altered merely to make them shorter. Technical changes require source verification and an explanatory note where needed.
9. **Every phase has a build checkpoint.** Preserve a source diff, build log, PDF, and issue disposition before moving to the next phase.

## 3. Five-phase execution plan

## Phase 1 — Source inventory, baseline reproduction and audit map

**Purpose:** establish exactly which LaTeX sources produce the reviewed PDF before making edits. This prevents changing a stale chapter file, overlooking a separately included body, or breaking shared macros.

### Work

- Extract the latest complete source archive into a clean working directory; record archive name, checksum and Git commit if available.
- Inventory the master document, Part I/II `content.tex` files, all chapter source files, standalone chapter entry points, shared style/preamble files, bibliography, glossary, index, diagrams and build scripts.
- Build an include graph from the root document to each of Chapters 1–18. Confirm Chapter 1's body/source arrangement and any chapter-local input fragments.
- Map each reviewed PDF chapter span and printed page range to the corresponding LaTeX source and included assets.
- Search the entire source tree for: `\\FanLanCite`, `\\CoALACite`, citation commands, `\\label`, `\\ref`, `\\autoref`, glossary commands, index commands, custom environments, chapter-opening/recap environments, and code-listing captions.
- Run the repository's intended XeLaTeX/Biber/index/glossary/diagram build in a clean environment. Capture the exact command, tool versions, warnings and output checksums.
- If a build dependency is unavailable, record it as a blocker; do not substitute placeholder figures and call the PDF final.
- Create a correction ledger keyed to the review IDs and exact source file/section. Mark each candidate fix as confirmed, source-dependent, or editorial-only.

### Outputs

- Source inventory and include map.
- Baseline build log and PDF checksum.
- Full-source diagnostic report: undefined references/citations, overfull boxes, missing figures, glossary/index warnings and macro anomalies.
- A no-edit baseline checkpoint.

### Acceptance gate

All 18 chapter sources and shared dependencies are mapped. The baseline builds reproducibly or every environmental blocker is documented. No content edits begin before this gate.

## Phase 2 — P0 correctness, B1 completion and provenance repairs

**Purpose:** repair defects that affect correctness, source attribution or reader interpretation before editorial compression changes the surrounding text.

### Chapter 12 — B1 and citation repair

- Repair the broken `\\FanLanCite` source-note invocation so the printed page contains a valid citation/footnote, not the literal macro name. Verify the compiled output at the former printed p. 246 location.
- Make activation/accessibility an explicit input to the B1 value/selection objective or explicitly define the estimator/selector contract as conditioned on activation. Do not invent an equation and attribute it to Fan & Lan.
- Make maintenance cost explicit. Decide and state whether it is a per-item objective term, an amortized lifecycle cost, or a separate hard maintenance budget. Explain why the chosen treatment still accounts for the B1 relationship among activation/accessibility, retrieval latency, downstream action utility and maintenance cost.
- Explain the different purposes of the soft latency penalty and hard deadline: ranking feasible choices versus excluding deadline-infeasible choices. Check that the formulation does not accidentally count the same cost twice.
- Add a concise seven-field B1 reconstruction: S/C/T/P/F/L/R. Preserve the distinctions among unknown, absent and not applicable; do not infer fields not documented by Fan & Lan.
- Label supplementary comparisons (e.g., additional memory systems) separately from the frozen Fan & Lan corpus/baseline records. Preserve useful comparisons; correct only attribution ambiguity.
- Retain the ACT-R equations unless primary-source checking finds an actual error. Add exact ACT-R manual section/page references during the source pass.

### Other source/cross-reference corrections

- Chapter 11: correct the CLARION forward reference. Method authority/B4 belongs to Chapter 15; GraSP/skill governance belongs to Chapter 17. Choose the target matching the sentence's intended subject.
- Chapter 11: correct the glossary plural `familys` to `families`, including the glossary entry or pluralization rule that generated it.
- Chapter 6: correct `one or more candidate action` to `one or more candidate actions`.
- Product X wording: change `deployment 4.7` to `deployment v4.7` or `release 4.7` consistently.
- Chapter 15: repair reversed opening quotation marks and malformed quotation pairs.
- Chapter 12: clarify local source/example attribution for supplementary system comparisons.
- Chapters 15, 17 and 18: add local `[BOOK EXAMPLE]` / `[ENGINEERING DECISION]` attribution only to passages where a reader could reasonably mistake a book-authored contract or policy for a source mechanism. Do not mechanically tag every paragraph.
- Bibliography: render Fan & Lan as the identified arXiv preprint with `arXiv:2607.23942` and version/date. Verify the exact record against the bibliography source and paper metadata.
- ACT-R short citations: add precise manual section references at equation discussions where they improve traceability; retain valid short-form citations where appropriate.

### Part I mathematical addition

- Add the standard softmax equation in Chapter 7 §7.6, with a compact numerical example using the existing illustrative values. Label the equation and example as the book's mathematical explanation of a selection method named by CoALA, not as a CoALA-prescribed formula.
- Do not add a long Java tutorial to Part I. A short pseudocode decision loop in Chapter 8 is optional and should be added only if it clarifies a control distinction not already clear from the existing multi-cycle walkthrough.

### Outputs and acceptance

- Chapter 12 corrected source and rendered page proof.
- Corrected Chapter 11 cross-reference and copy defects.
- Updated bibliography and provenance labels.
- Tests/checks for all affected macro calls, citation keys, references and glossary terms.
- Review each mathematical change against the original paper/manual before accepting it.

No compression is done in this phase beyond the minimal edits needed to make the repaired passages coherent.

## Phase 3 — Part I compression and pedagogy consistency (Chapters 1–8)

**Purpose:** remove repeated explanations while preserving the progressive introduction to CoALA and the Product X running example.

### Chapter-by-chapter changes

| Chapter | Keep | Planned compression / box action | Why it is safe |
|---|---|---|---|
| 1 — Why agents need cognitive architectures | Model-call → agent → cognitive-agent progression; production-system history; Soar illustration; Product X incident; first CoALA introduction | Shorten repeated definitions across §§1.1–1.2; reduce §1.7 to a preview after §1.6.4's question mapping; shorten §1.8.2 caveats; make §1.9 a short handoff. Keep the action-description-versus-execution warning. Update §1.8.3's Part III promise. | Chapter 1 motivates and previews; Chapter 2 owns the full map and Chapters 3–8 own the details. The running example and historical motivation are not duplicates. |
| 2 — Architecture of CoALA | Structural map, relationships, working/long-term memory, internal/external action boundary, main procedure | Use §2.2 as a compact map; merge repeated memory-location material in §2.4 into §§2.3.2–2.3.3; convert repeated Product X narration in §2.7 to a concise dimension-mapping table; shorten §2.9 and §2.10. Remove takeaway boxes that repeat the three-dimension definition or the example conclusion. Keep diagram-reading guidance. | The detailed component sections already explain what the overview introduces; the Product X mapping remains but is not narrated twice. |
| 3 — Understanding Memory | Four memory categories and their cooperation; procedural-memory safety distinction | Keep §3.1.1 as the definitive prompt-versus-memory explanation; shorten duplicate previews in earlier chapters only. Condense §3.8 into a short paragraph. Remove the takeaway box that repeats §3.1.1 and the recap. Keep the procedural-memory warning. | Memory categories are foundational and are not candidates for deletion; only the same context-window caveat is repeated. |
| 4 — Internal Actions | Retrieve/reason/learn distinctions; different learning destinations and modes | Compress §4.6 into a short diagnostic table; shorten §4.5 where it repeats the full worked example/diagram; reduce Chapter 3 callback. Remove the standalone box saying reasoning does not automatically persist; integrate the sentence into §4.3/§4.4. Keep retrieval diagnostic and fine-tuning warning. | Definitions remain in their dedicated sections; the synthesis and distinct safety diagnostic are preserved. |
| 5 — External Actions and Grounding | Grounding as action plus feedback; physical, dialogue and digital environments; observations entering working information | Remove the four-part note box if its definitions are already fully in §5.2; compress §5.9 to unique contrasts only; shorten repeated incident chronology in §5.7. Keep examples of all three environment types and the action-space safety warning. | The taxonomy and grounding walkthrough remain; only definitions repeated verbatim in box and prose are consolidated. |
| 6 — Planning | Candidate actions; reasoning/retrieval as proposal support; enumeration; structured programs/simulators | Reduce §6.4.2 to a preview and keep §6.7 as the full candidate walkthrough; shorten §6.8. Merge candidate-not-selected/approved/executed tip and warning into one callout; remove a separate scope note if §6.2 already provides the handoff. | Candidate-generation approaches remain complete, while the Product X candidate set receives one full explanation. |
| 7 — Evaluation and Selection | Evaluation versus selection; value sources; argmax, softmax, majority vote; numerical example | Add the softmax formula/example from Phase 2; shorten §7.8; merge the two value-scale warnings; remove the rejection-outcome box if §7.5 already explains it; remove the takeaway box duplicated by the recap. Keep the value-calibration note and simulated-versus-real observation warning. | The selection methods and numerical explanation remain, while repeated caveats and conclusions are stated once. |
| 8 — Complete CoALA decision process | Planning/execution; interleaving versus iteration; simulation; rejected proposals; multi-cycle trace | Combine overlapping introduction in §§8.1–8.2; shorten §8.9 to distinctions not already taught in Chapters 6–7; compare overview diagrams and retain one high-level cycle diagram plus the multi-cycle trace. Remove takeaway box duplicated by recap; consolidate invented-observation warning into source/example note. | Chapter 8 remains the capstone. The multi-cycle worked example carries the detailed sequence; overview prose does not repeat it. |

### Part I box policy

- Keep one concise recap per chapter.
- Remove standalone takeaways that repeat the recap or a nearby paragraph.
- Retain warnings that introduce distinct safety, authorization, source-boundary or learning risks.
- Merge tip/warning boxes only when they express the same distinction.
- Do not remove review questions or exercises merely to shorten the chapter.

### Outputs and acceptance

- Edited Chapters 1–8 sources.
- A chapter-level deletion/merge ledger showing original block, action, surviving location and reason.
- Part I XeLaTeX build and rendered PDF.
- Before/after word counts as descriptive evidence only, not a quota.
- Content check confirming all memory categories, environment types, proposal/evaluation/selection distinctions and worked examples remain.

## Phase 4 — Part II compression, template normalization and mechanism integrity (Chapters 9–18)

**Purpose:** preserve the evidence base and deep engineering bridges while reducing repeated framing, repeated limitations and duplicated summary packaging.

### Chapter-by-chapter changes

| Chapter | Keep | Planned compression / box action | Why it is safe |
|---|---|---|---|
| 9 — Feature-level descriptions | Feature/mechanism distinction; state/trigger/control/transition; similarity/lineage/depth; bounded-review limits | Keep §9.7 as the authoritative validity statement; shorten §9.9 to a handoff and unique misreadings; remove repeated prevalence/causality caveat from boxes/source note/recap. Remove takeaway box; keep searchable-store versus ACT-R note. | One authoritative scope statement prevents the same validity disclaimer appearing four times. The key methodological distinction remains. |
| 10 — Seven fields | All S/C/T/P/F/L/R fields; unknown/absent/not-applicable distinction; ACT-R worked reading | Shorten §10.13 where it repeats §§10.10–10.11; retain only unique comparison-claim reminders. Remove second takeaway box if recap remains; keep state-versus-control box. | The seven-field method is not shortened; only its explanation is not repeated in the same chapter. |
| 11 — Historical architectures and modern agents | Layered corpora; all ten historical families; eight runtime families; 42 modern records; E1–E4 and D0–D4; evidence packets | Retain §11.11 validity limits; compress §11.12 to unique misconceptions; keep §11.3.5 and §11.10 only as distinct historical-family and migration-landscape views; remove label-versus-mechanism takeaway duplicated by Chapters 9–10. Keep bounded-residual/interface warnings. Correct Chapter 16 forward reference and `families`. | The catalog and evidence model are the basis of Part II; the safe reduction is in repeated interpretation, not in the evidence. |
| 12 — B1 | ACT-R equations; difference between activation and action value; lifecycle decisions; comparisons; events/contracts; evaluation | Complete all Phase 2 B1 fixes. Compress supplementary system comparisons into a table where descriptions repeat the same decision; keep rows that demonstrate distinct lifecycle behavior. Remove two takeaway boxes only if their ideas remain in main text and recap. | This reduces repeated comparison prose while preserving the systems that illuminate different memory decisions. The B1 addition is more important than raw reduction. |
| 13 — B2 | Soar impasses; parent/substate; typed results; chunking; modern hypothesis; reference subsystem; failure/evaluation | Make §13.5 the concise conceptual mapping; let §13.6 own the full architecture/state/persistence contracts; remove duplicated five-step exposition after the summary. Keep §13.7 worked example. Shorten §13.11 only where §13.9 already owns the same failure/authority point. Remove recap-duplicating takeaway; retain side-effect and causal-evaluation warnings. | Conceptual mapping, implementation architecture and worked execution remain distinct; only repeated narration between them is removed. |
| 14 — B3 | LIDA mechanism; distinction from blackboard and B1/B5; seven fields; workspace contracts; competition/broadcast; evaluation | Remove or fold the first central-question box into the opening; keep the note that Fan & Lan provide no canonical B3 score. Consolidate B1/B3/B5 boundary explanations in §14.2, then cross-reference in §14.11. Remove the LIDA takeaway duplicated by body/recap. Put review questions and practical exercises in one enclosing block with two subheadings. Standardize learning-objective formatting. | Distinct mechanism boundaries and exercise content remain; redundant packaging and repeated boundary lists are reduced. |
| 15 — B4 | BDI intentions and commitment; reconsideration schedules; MIDCA method authority; seven fields; reference subsystem and tests | Reduce §15.1 to a short motivation; let §15.8 carry the full Product X timeout/method-switch trace. Keep the theoretical intention definition in §15.3.5 and authority analysis in §15.5.3; shorten repeated definitions in between. Keep §15.9 contracts/state model. Merge design-principle takeaway into recap. Combine review questions/exercises in one block. Add a concise “Chapter at a glance” distinct from learning outcomes; add local provenance labels selectively. | The historical concepts, authority model and implementation bridge are unique; the full scenario has one authoritative home. |
| 16 — B6 | EPIC/Sigma; uncertainty-bearing state; resources; interruption/stopping; governance; reference subsystem and evaluation | Shorten opening incident to a one-page problem statement; let later Product X trace carry detailed execution. Avoid repeating the B6 coupling list in §16.2 and §16.7. Remove central-problem box if opening states it. Keep uncertainty-propagation tip, calibration/authorization and exactly-once warnings. Mention E3/D3 warning once, not again in recap. | Resource and failure semantics remain intact; repeated setup and recap-only repetition are removed. |
| 17 — B5/GraSP | Negative-case scope; GraSP's actual stages/operators; skill governance; evidence and migration limits; implementation boundary | Consolidate repeated limitations in one evaluation/validity section; shorten the recap to a reminder. Preserve the distinction between GraSP's original mechanism and the book's Java-like reconstruction. Correct title-page structure: put overview under “Chapter at a glance” and true learning outcomes at the start. Keep bounded-safety and negative-case scope notes. | The negative case is important; reducing it must not imply B5 reopened or that the book reproduced GraSP. |
| 18 — Mechanisms together | Dependency model; authority matrix; implementation order; runtime/contract model; composition trace; failures/evaluation and limitations | Use Table 18.1 as the compact map and shorten §18.1 prose. Keep authority matrix, dependencies, implementation order, runtime and contracts; remove only repeated owner/transition statements. Keep full §18.8 composition trace and failure/evaluation sections. Remove standalone takeaway that duplicates §18.12–18.13; standardize recap box and add short overview. | This is a synthesis chapter, not a brief conclusion. The unique composition and authority evidence remains. |

### Part II box and template policy

- Retain source notes and provenance distinctions.
- Retain warnings that describe different failure, authority, security or evaluation risks.
- Delete/merge only takeaways and central-question boxes that restate adjacent prose or recaps.
- Keep the seven-field analyses and implementation contracts; they are not summary boxes.
- Normalize “Chapter at a glance,” learning objectives, recap, review questions and practical exercises. Do not add extra content simply to satisfy a visual template.
- Do not impose a literal “Looking ahead” heading on Chapters 9–11 just for uniformity; their existing handoff text is adequate. Add headings only where navigation materially benefits.

### Outputs and acceptance

- Edited Chapters 9–18 sources.
- A chapter-level deletion/merge/provenance ledger.
- Part II XeLaTeX/Biber/glossary/index build.
- Source-fidelity checklist for B1–B6/GraSP and E/D claims.
- Before/after word counts by chapter, interpreted against preserved content.

## Phase 5 — Book-wide scope consistency, copy-edit, final build and acceptance

**Purpose:** ensure the corrected chapters read as one book and the revised Part III promise is consistent everywhere.

### Book-wide scope and navigation

- Update “How to Read This Book” (front matter) so it no longer promises ten framework-based case studies.
- Update Chapter 1 §1.8.3 and any other forward references to Part III.
- Replace the obsolete Part III TOC and placeholders with the approved staged scope: Chapter 19 engineering foundations and Chapter 20 one general, request-driven supply-chain disruption management system. State that the application accepts many valid request types; a chapter walkthrough is only one execution trace.
- Remove LangGraph4j/LangChain4j implementation promises and framework-specific dependency/case-study wording. Retain Java 21/Maven only where it reflects the actual approved project decisions.
- Do not expand Part III implementation in this phase. It is a scope and navigation correction only.

### Global copy-edit and technical validation

- Run capitalization, punctuation, quotation-mark, apostrophe, hyphenation and glossary pluralization checks across all 18 chapters.
- Normalize prose naming and formal citation labels without mechanically changing grammatically correct “Fan and Lan” prose to “[Fan & Lan]”.
- Verify the arXiv bibliography record and ACT-R reference precision.
- Run a complete citation-key audit, label/reference audit, glossary/index audit, figure/table/listing numbering audit, macro scan and source-note audit.
- Verify all diagrams are real rendered assets, not placeholders; inspect them at print size.
- Run clean full-book XeLaTeX/Biber/makeglossaries/makeindex build using the repository's pinned/declared toolchain.
- Inspect the new PDF page sequence, front matter, chapter openings/endings, equations, code listings, tables, footnotes, bibliography, glossary and index.
- Compare PDF text and page counts with the baseline; investigate unexplained omissions, duplicated pages or broken references.
- Produce a final correction ledger with each review item marked fixed, intentionally retained, not applicable, or deferred with rationale.

### Acceptance gate

- Full book builds cleanly from a clean checkout.
- No undefined references/citations, missing figures, broken custom macros or unintended placeholder chapter promises.
- All confirmed P0 defects are fixed and rendered correctly.
- Every proposed deletion is documented with a surviving location for its idea or a reason it was genuinely redundant.
- No unique CoALA concept, Fan & Lan mechanism, historical evidence, worked example, implementation bridge, failure analysis or exercise has been removed merely to reduce length.
- Final PDF passes content and visual review.

## 4. Cross-chapter deletion policy: what to do with boxes

The book should not adopt a blanket rule to delete all boxes at chapter endings. Use this decision rule for each box:

| Box function | Action | Reason |
|---|---|---|
| Takeaway paraphrases a paragraph and the chapter recap | Remove or merge into recap | It adds no distinct learning value. |
| Central question repeats the chapter opening | Fold into opening or remove | The opening already performs that job. |
| Warning introduces a distinct safety, authority, source-fidelity or evaluation risk | Keep | It changes how the reader should interpret or implement the concept. |
| Note clarifies a difficult source distinction or a common misconception not stated elsewhere | Keep | It adds a useful interpretive boundary. |
| Tip repeats a definition immediately explained in prose | Integrate sentence into prose | The box interrupts flow without adding another layer. |
| Review questions and practical exercises use separate adjacent boxes | Merge into one container with two headings | Preserve every question/exercise while reducing visual fragmentation. |
| Source/example note | Keep, concise | It records provenance and prevents source claims from being confused with book examples. |
| Recap | Keep one per chapter | It is the single authoritative end-of-chapter synthesis. |

A box should not be deleted because it is short, decorative or near the end. It should be removed only when its function is already fulfilled more clearly elsewhere.

## 5. Commit, checkpoint and review workflow

For each phase:

1. Start from the latest approved source checkpoint.
2. Make only the changes assigned to that phase.
3. Keep edits localized; avoid unrelated reformatting of whole chapter files.
4. Build the affected chapter/part and run source diagnostics.
5. Inspect the changed PDF pages visually and read the surrounding text for continuity.
6. Update the correction ledger and phase changelog.
7. Create a checkpoint archive and preserve the previous checkpoint.
8. Run the full-book build at the phase gates specified above.

The author reviews the phase output before the next phase is accepted. A successful LaTeX build proves compilation, not conceptual correctness; editorial and source-fidelity checks remain separate.

## 6. What is intentionally not planned

- No blanket 20–25% cut.
- No target page count used as a deletion quota. The previous approximately 400-page target is already superseded by the current manuscript's 597-page state and expanded scope; revisit total length after Part III is outlined and written.
- No deletion of entire chapters or Fan & Lan mechanism studies.
- No removal of detailed state, control, persistence, failure, learning or resource/governance analysis simply because it resembles Part III engineering.
- No conversion of Part I into a Java tutorial.
- No claim that every Java-like listing in Part II is a complete compilable program; captions and provenance will state whether it is pseudocode/reference contract. Compiled implementation belongs in Part III.
- No start of Part III code or prose before the Parts I/II correction baseline is accepted.

## 7. Proposed phase sequence at a glance

| Phase | Scope | Main output | Gate |
|---|---|---|---|
| 1 | Source inventory and baseline | Audited include map, clean baseline build and correction ledger | All 18 sources mapped; build reproducible or blockers recorded |
| 2 | P0 technical correctness and provenance | Corrected B1, macros, references, citations and visible copy defects | Corrected chapter pages and source checks pass |
| 3 | Part I (Ch. 1–8) | Selectively compressed and consistent Part I | CoALA progression and examples preserved; Part I builds |
| 4 | Part II (Ch. 9–18) | Selectively compressed and consistent Part II | Mechanism/evidence bridges preserved; Part II builds |
| 5 | Scope, copy-edit and final release | Consistent full book and final PDF | Full clean build, source checks, content and visual acceptance |

## 8. Final recommendation

Proceed with the five phases in order. The most technically sensitive work is Chapter 12 and should be completed before compression. Part I should be edited before Part II because Chapter 1's revised Part III promise and the Part I concept ownership set the book-wide boundaries. Part II should then be compressed without weakening its unique comparative and engineering content. The final phase aligns navigation and copy-edit across the whole volume and provides a clean release gate.

The intended result is a clearer book, not a smaller book at any cost: each important idea should be explained once at full depth, then applied where needed without repeatedly reintroducing it.
