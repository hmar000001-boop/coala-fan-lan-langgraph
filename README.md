# From Cognitive Architectures to Production Agentic Systems

A source-disciplined technical book connecting CoALA, Fan and Lan's mechanism-level analysis, and the engineering of one simulated supply-chain agentic application in Java.

## Current book scope

- **Part I — Chapters 1–8:** CoALA, presented on its own terms.
- **Part II — Chapters 9–18:** Fan and Lan's mechanism-level review, including its evidence boundaries and the synthesis in Chapter 18.
- **Part III — Chapters 19–24:** one request-driven supply-chain disruption-management application implemented in Java and operated against a deterministic simulated world. Chapter 19 establishes the domain and engineering foundations; Chapter 20 maps CoALA into code; Chapters 21–23 explain B1/B3, B2, and B4/B6; Chapter 24 integrates the graph runtime, persistence, and simulated workflow.

Part III is a teaching/reference demonstration, not a deployed enterprise integration. It documents the actual LangGraph4j orchestration, LangChain4j model adapters, and PostgreSQL persistence boundaries. These are implementation technologies, not additional theoretical foundations. CoALA and Fan and Lan remain the only overarching theoretical foundations. The five residual bundles are B1, B2, B3, B4 and B6; B5/GraSP remains a closed-candidate boundary and is not claimed as implemented.

## Manuscript status

Chapters 1–22 are drafted and integrated from individually approved outlines. Chapters 19–22 form the current Part III manuscript; Chapters 23–24 remain outline-gated and require individual author approval before prose drafting.

## Repository layout

- `Tex/main.tex` — authoritative combined-book entry point.
- `Tex/preamble.tex` — shared XeLaTeX preamble, typography, page geometry, and layout.
- `Tex/shared-macros.tex` — book-wide citation, glossary, recap, and metadata setup.
- `Tex/part0/` — title matter, preface, and reading guide.
- `Tex/part1/` — CoALA chapters 1–8.
- `Tex/part2/` — Fan and Lan chapters 9–18.
- `Tex/part3/` — the six-chapter simulated supply-chain engineering part (19–24), with a chapter-local outline in each chapter folder.
- `Tex/diagrams/source/` — editable Mermaid diagram sources.
- `Tex/diagrams/generated/` — generated PNG outputs (build artifacts, not committed).
- `Tex/bibliography/`, `Tex/glossary/`, and `Tex/appendices/` — shared scholarly and reference material.
- `review/` — source reviews, drafting reviews, and project checkpoints.

## Page and typography specification

The production PDF uses **US Letter (8.5 × 11 inches), two-sided book layout, and a 0.15-inch binding offset**. XeLaTeX and `fontspec` use the TeX Gyre Termes, Heros, and Cursor font families. Keep the shared preamble authoritative; do not create chapter-local typography or geometry overrides.

## Build

The authoritative entry point is `Tex/main.tex`. The CI workflow uses `xu-cheng/texlive-action@v2`, the full TeX Live scheme, XeLaTeX through `latexmk`, Biber, `makeglossaries`, and `makeindex`. CI installs Node 24 and the TeX Gyre browser fonts, installs the pinned Mermaid CLI, renders the diagrams, validates their references, compiles the PDF, and runs PDF quality checks.

Required local tools are XeLaTeX, `latexmk`, Biber, `makeglossaries`, `makeindex`, Node.js 22.13 or later, npm, Chromium/Puppeteer dependencies, and the TeX packages used by the preamble and shared macros. The Mermaid CLI is directly pinned to 12.2.0 in `tools/mermaid/package.json`.

Run from the repository root:

```bash
npm install --prefix tools/mermaid --no-audit --no-fund
bash scripts/check-scaffold.sh
bash scripts/render-diagrams.sh
bash scripts/check-diagrams.sh
bash scripts/build-book.sh
```

The build renders the editable `.mmd` sources to PNG before XeLaTeX compilation. Generated PNGs are build artifacts and should not be added to source control. The CI workflow is the production build authority.

To build the authored chapters in Parts I, II, and the drafted Chapters 19–22 separately:

```bash
bash scripts/build-chapters.sh
```

To build an individual part:

```bash
bash scripts/build-part.sh part0
bash scripts/build-part.sh part1
bash scripts/build-part.sh part2
bash scripts/build-part.sh part3
```

`quality-checks.sh` validates the generated PDF metadata, expected chapter headings, US Letter page dimensions, and unresolved citations/references. The scaffold check enforces the six-chapter Part III structure, requires drafted prose and individually approved outlines for Chapters 19–22, and keeps Chapters 23–24 as placeholders until their individual outlines are approved.

## Source discipline

Use only the two formal source labels `[CoALA]` and `[Fan & Lan]`, implemented through `\CoALACite{...}` and `\FanLanCite{...}`. Part I must not import Fan and Lan's later mechanism analysis into the original CoALA account. Part II must preserve Fan and Lan's stated evidence and validity boundaries. Part III must clearly distinguish sourced claims from book-created examples and engineering proposals.

Each chapter requires an approved outline before prose drafting. Preserve distinct ideas, source evidence, worked examples, engineering bridges, exercises, and warnings. Editorial compression removes repeated presentation only; it is not a word-count target.
