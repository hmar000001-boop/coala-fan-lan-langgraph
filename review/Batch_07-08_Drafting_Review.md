# Chapters 7–8 Drafting and Final Review

**Date:** 14 November 2026  
**Status:** Drafts integrated; awaiting actual Mermaid PNG generation and final visual PDF inspection in GitHub Actions.

## Author approvals

The author approved both outline v1.0 documents on 14 November 2026 after a final review for minor issues. The outlines remain in the corresponding chapter folders:

- `Tex/part1/chapter07/outline/Chapter_07_Outline_Review_v1.tex` and `.pdf`
- `Tex/part1/chapter08/outline/Chapter_08_Outline_Review_v1.tex` and `.pdf`

The outline cover pages and approval notes were updated to record the approval.

## Chapter 7 — Evaluation and Selection

**Draft:** `Tex/part1/chapter07/chapter.tex`  
**Approximate length:** 3,560 words  
**Primary source:** CoALA §4.6, Evaluation and Selection, pp. 12–13.

### Source-fidelity checks

- Evaluation is described as assigning a value to proposed actions when multiple actions are proposed.
- The chapter does not assert that CoALA defines a universal value scale, normalization rule, calibration guarantee, or meaning for values. Numeric values appear only in one explicitly book-created teaching example.
- All value sources named by the paper are covered: heuristic rules, LLM/perplexity values, learned values, LLM reasoning, and combinations.
- Internal simulation is kept distinct from an observation returned by the external environment.
- Selection is described as acting on the proposed actions and their values. The chapter correctly places the option to reject the current set and loop back to proposal under selection, not evaluation.
- Argmax, softmax, majority vote, and other alternatives are explained as possible methods, not mandatory stages or an exhaustive list.
- Selection is not conflated with execution, human authorization, or operational safety controls.
- Product X candidates and values are identified as book-created, and no root cause is asserted.
- No Fan & Lan mechanism is imported into CoALA.

### Figures

Four Mermaid sources were added under `Tex/diagrams/source/part1/chapter07/`:

1. `evaluation-value-sources.mmd`
2. `evaluation-versus-selection.mmd`
3. `selection-methods.mmd`
4. `productx-evaluation-selection.mmd`

Each includes `accTitle` and `accDescr`, has a corresponding `\BookDiagram` reference, caption, and stable label.

## Chapter 8 — Interleaving, Iteration and the Complete CoALA Decision Process

**Draft:** `Tex/part1/chapter08/chapter.tex`  
**Approximate length:** 3,726 words  
**Primary source:** CoALA §4.6 and Figure 4B, pp. 12–13. Sections 4.3–4.5 are recalled only to explain retrieval, reasoning, and learning roles.

### Source-fidelity checks

- The decision procedure is described as the top-level or main agent program coordinating repeated decision cycles.
- The two broad stages are planning and execution.
- Reasoning and retrieval are described as internal actions that can flexibly support proposal, evaluation, and selection; they are not equated with those planning responsibilities.
- Interleaving and iteration are explicitly marked as ordinary-language teaching interpretations of the paper's wording. The chapter does not claim that CoALA defines formal operators, a fixed schedule, a universal loop order, retry limits, or stopping rules.
- Multi-step simulation and candidate improvement are kept inside planning. Simulated consequences are not described as external observations.
- The explicit reject-and-return-to-proposal option remains located at selection.
- Execution applies the selected procedure and may be an external grounding action or an internal learning action.
- The paper's modal wording is preserved: an observation can be made after an external interaction; it is not guaranteed after every execution.
- The Product X walkthrough includes only hypothetical/book-created facts and does not assert a root cause.
- No Fan & Lan mechanism is imported into CoALA.

### Figures

Five Mermaid sources were added under `Tex/diagrams/source/part1/chapter08/`:

1. `complete-decision-cycle.mmd`
2. `flexible-planning-support.mmd`
3. `candidate-improvement.mmd`
4. `selection-rejection-loop.mmd`
5. `productx-multiple-cycles.mmd`

Each includes `accTitle` and `accDescr`, has a corresponding `\BookDiagram` reference, caption, and stable label.

## Shared integration changes

- Added Chapters 7 and 8 to the recursive Mermaid reference validator.
- Added standalone LaTeX entry points for Chapters 7 and 8.
- Extended `scripts/build-chapters.sh` to build individual PDFs for Chapters 1–8.
- Extended PDF heading checks to include Chapter 7 and Chapter 8.
- Updated the scaffold check so the approved Chapters 7 and 8 must contain prose and their outline sources/PDFs must remain in the chapter-local folders.
- Added shared glossary entries for evaluation, evaluation value, selection, execution, decision cycle, interleaving, iteration, argmax, softmax, and majority vote.
- Updated README and writing/production rules.

## Verification status and limitation

- Source files, chapter-local outline assets, Mermaid-to-LaTeX references, shell scripts, and workflow configuration are checked locally.
- `npm install --prefix tools/mermaid` was retried on 14 November 2026 and failed with `EAI_AGAIN` while resolving `registry.npmjs.org`.
- No real Mermaid CLI render is claimed from this environment. The actual PNG generation and print-size diagram inspection remain a required GitHub Actions check.
- A disposable mock-PNG LaTeX smoke test may validate image inclusion and page layout only. Such images are not production Mermaid output and are excluded from the deliverable.


## Final minor-issue pass and updated validation (14 November 2026)

- Rechecked Chapters 7 and 8 against CoALA §4.6 and Figure 4B; no scope or attribution changes were required.
- Fixed glossary-command interword-spacing diagnostics by grouping the glossary macros at sentence positions. ChkTeX is now clean for both chapter sources (aside from its environment notice that the global resource file is not installed).
- Rebuilt both chapter-local approved outline PDFs from their current LaTeX sources; the PDFs record approval status and use the 7 × 10 inch page size.
- Re-ran the real npm installation attempt for Mermaid CLI 12.2.0. It remains blocked by DNS resolution for `registry.npmjs.org` (`EAI_AGAIN`). No real Mermaid rendering is claimed.
- The actual rendered PNGs and printed-size figures remain a required GitHub Actions verification. Any mock PNGs used for local LaTeX integration testing are disposable and are excluded from the repository archive.

- Final outline audit corrected the phrase “scalar value” to the paper’s exact “value” wording and replaced stale approval prompts with recorded approval notes.


## Layout verification (disposable smoke build)

- Standalone Chapter 7 and Chapter 8 LaTeX builds completed at 19 and 21 pages respectively, with the requested 7 × 10 inch trim.
- The builds used temporary Nimbus OpenType font substitutions and conspicuously marked mock PNGs to verify LaTeX image placement, chapter flow, teaching boxes, tables, glossary/index integration, and references. These test assets are not production diagrams and are excluded from the repository.
- Representative pages were rendered and visually inspected. The review covered chapter openings, dense text/table pages, chapter-end recap/questions, and page dimensions.
- The full combined-book compile did not complete within the local execution time limit. This is not reported as a passing full-book build.
- The final PDFs with genuine Mermaid figures must be generated after CI renders all `.mmd` sources with the pinned Mermaid CLI. The npm registry could not be resolved from this environment (`EAI_AGAIN`), so the real PNG rendering gate remains open.
