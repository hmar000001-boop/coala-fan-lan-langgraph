# From Cognitive Architectures to Production Agentic Systems

A source-disciplined technical book about CoALA, the mechanism-level analysis by Fan & Lan, and production-oriented agent engineering with Java.

## Current content status

- **Chapter 1 — Why Do Language Agents Need Cognitive Architectures?** Re-reviewed and converted from the previously approved manuscript.
- **Chapter 2 — The Architecture of CoALA.** First complete draft, written from the reviewed outline and checked against the original CoALA paper.
- Chapters 3 and 4 now have detailed outline review PDFs in `review/`; both are awaiting author approval. No prose has been written for them. Chapters 5–30 remain structural placeholders only. Each chapter outline must be approved before its prose is written.

## Authoritative writing and production rules

`BOOK_WRITING_AND_PRODUCTION_RULES.md` is the controlling specification for all future chapter work. It records the source boundaries, teaching method, outline-approval workflow, shared LaTeX system, semantic box policy, Mermaid-to-PNG CI pipeline, and quality gates. Read it before continuing the book.

## Author-supplied preamble

`Tex/preamble.tex` is based on the author's supplied preamble and is loaded once by `Tex/main.tex`. It retains the `book` class, XeLaTeX/fontspec setup, 7 × 10 inch double-sided open-right page layout, TeX Gyre Termes/Heros/Cursor typography, colors, heading styles, headers/footers, code listings, reusable teaching boxes, and source-layout tree. This latest author-supplied preamble supersedes earlier trim-size/font selections. It adds a shared `\BookDiagram` figure macro and balanced figure-float settings; TikZ was removed after diagrams migrated to Mermaid-rendered PNGs. Keep this file intact until the author approves a later cleanup pass.

Book-wide citation macros, glossary setup, bibliography integration, additional reusable environments, and book-level PDF metadata are layered in `Tex/shared-macros.tex`. Chapters should use these shared definitions rather than introducing chapter-local replacements.

## Build

The authoritative entry point is `Tex/main.tex`. The repository uses the author's known-working GitHub Actions route: `xu-cheng/texlive-action@v2`, `scheme: full`, XeLaTeX through `latexmk`, and a PDF artifact. Pushes and pull requests build the full book; pushes of `v*` tags also publish the compiled PDF to GitHub Releases.

The workflow compiles only the combined book PDF. Individual first-chapter review PDFs can be built with `scripts/build-chapters.sh`; part entry points are available at `Tex/part0/main.tex` through `Tex/part3/main.tex`.

Required tools are XeLaTeX, latexmk, Biber, makeglossaries, makeindex, Node.js 22.13 or later, npm, Chromium/Puppeteer dependencies, and the TeX packages referenced by the preamble and shared macros. The GitHub workflow installs Node 24, the TeX Gyre browser fonts, the pinned Mermaid CLI, and the full TeX Live scheme.

The Mermaid CLI is pinned to version 12.2.0 in `tools/mermaid/package.json` and requires Node.js 22.13 or later. CI installs Node 24, renders all `.mmd` sources to high-resolution PNGs using the shared Mermaid theme, validates their dimensions and chapter references, and only then starts XeLaTeX. Generated PNGs are intentionally excluded from source control and are also uploaded as a separate CI artifact for visual inspection. The npm CLI package is directly version-pinned; dependency-tree lockfile generation is not yet committed.

Install the Mermaid renderer once for a local build, then render and compile:

```bash
npm install --prefix tools/mermaid --no-audit --no-fund
bash scripts/check-scaffold.sh
bash scripts/render-diagrams.sh
bash scripts/check-diagrams.sh
bash scripts/build-book.sh
```

The authoritative workflow renders Mermaid sources to PNG before LaTeX compilation. Committed `.mmd` files are editable sources; generated PNGs are build artifacts and are not committed.

To build the first two chapters separately:

```bash
bash scripts/build-chapters.sh
```

## Next batch

- Chapter 3 — `review/Chapter_03_Outline_Review_v1.pdf` (awaiting approval).
- Chapter 4 — `review/Chapter_04_Outline_Review_v1.pdf` (awaiting approval).
- Draft neither chapter until its own outline has been explicitly approved.

## Source discipline

Part I uses the original CoALA paper as its theoretical source. Part II treats Fan & Lan as a separate contribution; it is not used to reinterpret CoALA. Book-created examples and engineering decisions are identified as such, not attributed to the papers. The two formal paper labels are `[CoALA]` and `[Fan & Lan]`.

The PDF target is standard PDF; this project does not claim PDF/UA or tagged-PDF conformance.

## Repository setup

Create the public GitHub repository named `cognitive-architectures-to-production-agents`, extract this archive, and push the repository contents manually. No remote or Git history is embedded in this archive.
