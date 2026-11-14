# Batch 03–04 source and editorial review

**Date:** 14 November 2026  
**Status:** Drafts complete; author review pending.

## Primary source checked

Sumers, Yao, Narasimhan, and Griffiths, *Cognitive Architectures for Language Agents*, Transactions on Machine Learning Research (2024), official OpenReview PDF.

- Chapter 3: §4.1, “Memory,” printed pages 9–10, and Figure 4A.
- Chapter 4: §4.3 “Retrieval actions,” §4.4 “Reasoning actions,” and §4.5 “Learning actions,” printed pages 11–13; Figure 5 only for the internal/external action boundary.

## Source-fidelity checks

- Chapter 3 preserves the distinction between the model's per-call context and CoALA working memory as a data structure persisting across calls.
- Working memory examples are described as active symbolic variables; no concrete object schema or prompt framework is attributed to CoALA.
- Episodic, semantic, and procedural memory are described by the kind of information and role they represent, not by a physical storage technology.
- Procedural memory is explained as implicit knowledge in model weights and explicit knowledge in agent code. Its required bootstrap role and the risk of procedural changes are retained.
- Chapter 4 distinguishes retrieval (long-term memory → working memory), reasoning (working-memory processing and update), and learning (write to long-term memory).
- Retrieval examples used are the ones described in CoALA: Voyager, Generative Agents, and DocPrompting. Retrieval methods are presented as possible implementations, not a required stack.
- Learning is not reduced to fine-tuning. Episodic experience, semantic inferences, model-parameter updates, and agent-code updates are kept distinct.
- The paper's distinction between examples it describes and possibilities it labels underexplored or theoretical is preserved for procedural updates.
- The observation that memory modification/deletion (unlearning) is understudied is described as a research gap, not a supplied algorithm.
- Product X is labelled as a book-created example. No Fan & Lan mechanism is used in either chapter.

## Mermaid diagrams added

Chapter 3:
- `memory-landscape.mmd`
- `working-memory-call.mmd`
- `procedural-memory.mmd`
- `memory-cooperation.mmd`

Chapter 4:
- `internal-action-map.mmd`
- `retrieval-targets.mmd`
- `learning-paths.mmd`
- `productx-internal-actions.mmd`

Each file includes `accTitle` and `accDescr`, uses the shared theme, and is included by the shared `\BookDiagram` macro. Real Mermaid CLI rendering could not be run in this container because DNS resolution for `registry.npmjs.org` failed. The CI workflow is the authoritative renderer and will regenerate the PNG files before XeLaTeX compilation. No substitute or hand-drawn diagram is represented as a real Mermaid render.

## Implementation and build changes

- Added standalone LaTeX entry points for Chapters 3 and 4.
- Extended the diagram validator to check references and orphan sources across Chapters 1–4.
- Extended the standalone chapter build script and PDF heading checks to Chapters 1–4.
- Added glossary entries for retrieval, reasoning, learning, and internal action.
- Kept the shared preamble and global figure macro; no chapter-local drawing libraries were added.

## Validation limits

The real Mermaid CLI was not installed locally because the npm registry could not be resolved from this environment. For that reason, this batch is delivered as editable source and CI-ready Mermaid text, not as a claim of visually validated, final PNG-rendered chapter PDFs. GitHub Actions must run to create the real PNGs and permit final visual inspection. The selected TeX Gyre OpenType fonts are also unavailable in this local container; the repository retains the author's requested font declarations.


## LaTeX integration smoke-test results

A disposable copy of the repository was compiled with temporary layout-test PNGs and local substitute OpenType fonts, without changing the project preamble or adding those test assets to the deliverable:

- Combined book: 153 pages; PDF metadata, text extraction, and all five chapter-heading checks passed.
- Standalone Chapter 3: 19 pages, 7 × 10 inch trim.
- Standalone Chapter 4: 17 pages, 7 × 10 inch trim.
- Chapter 3 and Chapter 4 PDFs were rendered to page images and visually checked for title hierarchy, text flow, boxes, captions, references, and end matter.
- No `Overfull \hbox`, `Overfull \vbox`, unresolved references/citations, or LaTeX errors appeared in the tested logs.
- The full diagram validator passed against temporary valid PNG fixtures for all 14 sources and references. These fixtures only verified the PNG-validation and LaTeX-inclusion layers; they are not actual Mermaid output.

The real Mermaid CLI could not be installed in this execution environment because DNS lookup for `registry.npmjs.org` failed. Consequently, this batch is delivered as source plus CI generation instructions. Actual Mermaid rendering, diagram visual inspection, and final production chapter PDFs remain gated on a successful GitHub Actions run. The local font substitutions were applied only in the disposable smoke-test copy; the deliverable retains the author's TeX Gyre font configuration.
