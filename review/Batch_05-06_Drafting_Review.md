# Batch 05–06 Drafting and Source-Fidelity Review

**Book:** *From Cognitive Architectures to Production Agentic Systems*  
**Batch:** Chapters 5 and 6  
**Author approval:** Both outlines approved on 14 November 2026  
**Status:** Draft prose integrated; author review pending

## Final outline review

The approved outlines were re-read against the published CoALA paper immediately before drafting. Chapter 5 is grounded primarily in §4.2, with §4 and Figure 5 used for architectural context and §6 used only for action-space safety. Chapter 6 is grounded in §4.6 and Figure 4B, with §§4.3–4.4 recalled only to explain retrieval and reasoning as supporting operations. Neither chapter uses Fan & Lan to reinterpret CoALA.

## Chapter 5 — External Actions and Grounding

- Separates environment, grounding procedure, external action, and observation.
- Explains grounding as execution of external actions and processing of environmental feedback into working memory as text.
- Covers physical environments, dialogue with humans or other agents, and digital environments.
- Preserves the qualification that stateless APIs are special single-use digital environments; it does not describe all digital environments as stateless.
- Distinguishes external dialogue from internal reasoning about a reply.
- Explains the textual representation abstraction without claiming that all raw inputs are textual or converted by an identical algorithm.
- Uses Product X only as a book-created example; no successful external result or diagnosis is assumed.
- Mentions action-space safety only to the extent the paper does; it does not attribute a complete authorization or production safety architecture to CoALA.

## Chapter 6 — Planning: From a Problem to Candidate Actions

- Locates proposal within the decision cycle without teaching the complete decision procedure.
- Defines a candidate as a possible action generated for later consideration and distinguishes it from an evaluated, selected, or executed action.
- Preserves the paper's wording that reasoning is the usual mechanism and retrieval is optional support.
- Covers the paper's alternative proposal approaches: enumerating a limited action set, program branches/loops, and structured-simulator rollouts.
- Keeps SayCan only as the paper's brief limited-action-set example, not as an additional theoretical foundation.
- Stops at candidate generation; no candidate scoring, evaluation, selection, rejection, execution, or interleaving algorithm is taught.
- Product X candidates are unranked and unselected; no candidate is presented as a diagnosis or recommendation.

## Figures and build integration

Eight Mermaid `.mmd` sources were added: four under `chapter05/` and four under `chapter06/`. Each includes `accTitle` and `accDescr`, uses the shared book theme, and is included by the shared `\\BookDiagram` macro. No TikZ, ASCII art, or hand-positioned LaTeX drawing was added. The recursive render script already discovers all sources; the diagram validator, scaffold check, standalone build script, and PDF heading checks were extended to Chapters 1–6.

The local environment cannot resolve `registry.npmjs.org`, so the pinned Mermaid CLI could not be run locally. For that reason, no mock-rendered diagrams are represented as real Mermaid output and no final PDF claim is made from placeholder PNGs. A disposable placeholder-image build may be used only to test the LaTeX inclusion layer. The first GitHub Actions run must generate the real PNGs, and the resulting diagram artifact and final PDFs must be visually reviewed at printed size.

## Cross-chapter consistency

- Chapter 5 does not repeat the memory taxonomy (Chapter 3) or internal-action definitions (Chapter 4).
- Chapter 6 does not re-teach grounding environments (Chapter 5), retrieval/reasoning mechanisms (Chapter 4), evaluation/selection (Chapter 7), or interleaving/iteration (Chapter 8).
- Both chapters reuse the shared preamble, semantic boxes, footnote citation macros, glossary and index infrastructure.

## Batch build and QA note

The updated repository passed shell-script syntax checks, workflow YAML parsing, Mermaid configuration JSON parsing, chapter scaffold checks, and a one-to-one mapping audit for all 22 Mermaid sources and their 22 `\BookDiagram` references. `chktex` completed on both new chapter fragments without source diagnostics (the local ChkTeX installation warned that its optional global resource file was unavailable).

A disposable combined-book XeLaTeX smoke build completed at 181 pages and passed `scripts/quality-checks.sh`, including book metadata, expected Chapter 1–6 headings, text extraction, and undefined-reference/citation checks. The disposable copy used explicit placeholder PNGs marked “NOT A MERMAID RENDER” and Liberation font substitutes because the npm registry was unreachable and the local environment lacks the requested TeX Gyre OpenType faces. These placeholders and the disposable PDF are not included in the repository. The real Mermaid CLI render and final chapter PDFs remain pending a successful GitHub Actions run; the actual repository preamble and `.mmd` sources are preserved.

The first smoke build exposed an unescaped literal ampersand in each chapter's source note. Both prose occurrences were corrected to `Fan \\& Lan`; ampersands inside `tabularx` column separators remain intentional. The final source check has no raw `Fan & Lan` prose occurrence.
