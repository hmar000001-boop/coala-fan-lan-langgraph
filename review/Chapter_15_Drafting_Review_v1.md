# Chapter 15 drafting and implementation-bridge review v1.0

**Chapter:** Persistent Intentions, Reconsideration and Method Authority: B4  
**Outline:** v1.0, approved by the author on 15 November 2026  
**Draft state:** Complete first substantive draft integrated in `Tex/part2/chapter15/chapter.tex`. The final illustrated PDF remains subject to pinned Mermaid rendering and production-font verification.

## 1. Minor-issue review before writing

One review pass was made against the approved outline, active project rules, prior source-fidelity checkpoint, and current bibliography. No structural blocker was found. The following points were carried into the draft as explicit clarifications:

- Commitment termination policy and reconsideration schedule remain separate axes; they are not combined into one enum or taxonomy.
- Event-sensitive reconsideration is presented as a proposed runtime trigger policy, not as a classical commitment-termination label.
- BDI and MIDCA remain distinct historical mechanisms: BDI provides the commitment structure; MIDCA supplies a meta-level monitoring/diagnosis/guidance model.
- Goal authority, method authority, and model proposal authority are three different roles. A method switch cannot silently amend the goal or its constraints.
- E (evidence relation) and D (migration depth) remain independent mapping axes; the labels apply to specific mapped mechanisms.
- The hybrid BDI–LLM paper, self-aware BDI technical report, CCA preprint, Devil's Advocate paper, goal-drift paper, and premature-commitment preprint are described according to their publication status and bounded evidence.
- The Product X example explicitly states the assumed idempotency and read-only status-query contract. A timeout is not treated as proof that payment failed.
- Local database transactions are distinguished from irreversible external side effects; authorization and reconciliation remain separate controls.
- Historical approval text in the frozen outline v1.0 PDF is not rewritten after the fact. This separate record records the author's actual approval on 15 November 2026.

## 2. Theory-to-practice bridge

The outline called for a substantial engineering bridge. The draft includes:

- A reference architecture separating goal authority, goal storage, intention registry, method registry, execution monitoring, event validation, diagnosis, governor, authorization/execution, and audit/outcome ledger.
- Typed Java-like contracts for goal, intention, method, reconsideration event, governor decision, authority, and delegated work.
- Separate commitment-policy and reconsideration-schedule fields.
- A lifecycle state machine covering proposed, authorized, active, reconsideration pending, suspended, delegated, satisfied, impossible, and abandoned states.
- Evidence-bound triggers, diagnosis, plan revision versus method switch, and goal/method/proposal authority contracts.
- Durable persistence, optimistic concurrency, duplicate-event rejection, transaction/outbox dispatch, crash recovery, and external-side-effect reconciliation.
- Bounded delegation, suspension/resumption, anti-oscillation safeguards, interfaces, orchestration pseudocode, implementation sequence, and executable test scenarios.
- Product X method-switch walkthrough with a read-only reconciliation path.
- Evaluation instrumentation, baselines, the three required ablations, controlled task suite, preregistration, and falsification criteria.

These are explicitly framed as book engineering proposals, not mechanisms already implemented by the source systems.

## 3. Figure/source coverage

Seven original Mermaid sources are included under `Tex/diagrams/source/part2/chapter15/`, each with `accTitle` and `accDescr`, and each referenced exactly once through the shared `\BookDiagram` macro:

1. `bdi-intention-cycle.mmd`
2. `commitment-versus-reconsideration.mmd`
3. `midca-dual-cycle.mmd`
4. `b4-authority-architecture.mmd`
5. `b4-intention-lifecycle.mmd`
6. `productx-method-switch-sequence.mmd`
7. `b4-outcome-evaluation.mmd`

The source files use the shared Mermaid theme. No placeholder PNGs are created or represented as real renders. The pinned CLI installation attempt timed out in the current local environment, so the actual renderer and PNG validation remain CI-dependent.

## 4. Repository integration

- `Tex/part2/chapter15/chapter.tex` contains the drafted prose.
- `Tex/standalone/chapter15.tex` provides the independent chapter build with chapter counter 15, glossary, bibliography, and index.
- `Tex/part2/content.tex` already included Chapter 15; no order change was needed.
- `scripts/build-chapters.sh` includes Chapter 15.
- `scripts/check-scaffold.sh` now expects Chapter 15 prose, standalone build, review records, bibliography references, glossary terms, and seven Mermaid sources; the previous placeholder assertion has been removed.
- `scripts/check-diagrams.sh` now validates source references across Chapters 1–15 without weakening PNG integrity checks.
- `scripts/quality-checks.sh` checks the Chapter 15 heading during PDF text extraction.
- The shared `Tex/preamble.tex` remains unchanged; its SHA-256 must match the recorded baseline after local layout work.

## 5. Validation status and known limitations

The final delivery report distinguishes these checks:

- Static repository and shell checks: run locally.
- Mermaid source/accessibility/reference checks: run locally with a source parser; full PNG validation requires the pinned Mermaid CLI and generated high-resolution PNGs.
- XeLaTeX/Biber chapter compilation: a 61-page standalone layout preview compiled successfully after temporary Noto Serif/Sans/Mono font substitution because the configured TeX Gyre OpenType fonts are unavailable locally. Biber resolved all 14 citation keys; the 15 glossary entries and 16 index entries were generated. No citation/reference errors or overfull boxes remain in the final preview log; the remaining local warnings are a missing italic face in Noto Sans Mono and a glossary PDF-bookmark token warning.
- LaTeX issues found during the first pass were corrected: a plain-text enum identifier with an underscore, long transition labels that overran the measure, uneven justified table columns, and duplicate punctuation in the new glossary descriptions.
- Visual PDF review: all 61 pages were rendered at 150 dpi. The complete contact sheet and representative prose, table, code-listing, glossary, and index pages were inspected. The seven diagram positions contain conspicuously labelled temporary layout cards only; these are not real Mermaid images and were removed from the repository after the preview was copied out.
- Preamble integrity: the temporary font substitution was restored byte-for-byte. `Tex/preamble.tex` SHA-256 is `99a73ba8204130f4eba6f5a9e9874a8be0cf61ea9a62a0546b57c96de833c18b`, matching the base repository.
- CI: actual GitHub Actions rendering with the pinned Mermaid CLI 12.2.0, PNG integrity/dimension checks, printed-size figure inspection, and the production-font build remain authoritative. The local npm install timed out; no real Mermaid PNG is included or claimed as validated.

No result is described as a final illustrated production PDF unless all required diagrams are rendered and inspected with the production font setup.
