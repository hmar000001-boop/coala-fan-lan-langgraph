# Phase 1 — LaTeX Source Audit and Baseline

**Project:** *From Cognitive Architectures to Production Agentic Systems*  
**Scope:** Part I (Chapters 1–8) and Part II (Chapters 9–18)  
**Phase status:** Source audit and static validation complete; production-equivalent rebuild remains blocked by local toolchain prerequisites.  
**Date:** 16 November 2026

## 1. Executive result

The most complete source snapshot available in the Library is `batch09-chapter18-complete-project.zip`. It contains substantive LaTeX source for all 18 chapters in Parts I and II, together with the shared preamble, macros, bibliography, glossary, diagrams, build scripts, and the existing twelve Part III chapter placeholders.

The source audit and static checks passed:

- 8 Part I chapters and 10 Part II chapters are present.
- All 57 `\input`/`\include` references checked resolve to source files.
- 418 labels are unique; no duplicate labels were found.
- The 52 unique bibliography keys used by the manuscript all exist in the 52-entry `.bib` database.
- 131 glossary entries and 141 glossary uses were checked; no missing glossary keys were found.
- 182 active `\index` entries were found in Chapters 1–18.
- All 95 Mermaid sources have accessibility descriptions and map one-to-one to the 95 active chapter figure references.
- The repository scaffold and shell syntax checks pass.

No canonical `.tex` source file was edited during Phase 1.

**The exact production build has not yet been reproduced.** The local environment is missing the pinned Mermaid CLI and the OpenType TeX Gyre fonts requested by the preamble. The build script therefore stops before rendering diagrams, and a direct XeLaTeX part build fails at font loading. A separate, explicitly non-release diagnostic copy used Noto fonts and labelled diagram placeholders; Biber completed successfully and XeLaTeX reached Chapter 7/page 131 before the diagnostic run timed out. That smoke test is not a substitute for the actual 95 rendered diagrams or a full production build.

## 2. Canonical source snapshot selection

Three Library archives were compared by file presence and SHA-256 hashes of shared build files:

| Archive | Observed source state | Decision |
|---|---|---|
| `cognitive-architectures-to-production-agents-chapters-01-11(1).zip` | Complete early Chapters 1–11; later chapter files include placeholders | Not authoritative for the current 18-chapter book |
| `cognitive-architectures-to-production-agents-chapter12.zip` | Complete through Chapter 12; Chapter 18 remains a placeholder | Superseded |
| `batch09-chapter18-complete-project.zip` | Complete substantive source for Chapters 1–18; Chapters 19–30 remain placeholders | **Selected canonical Phase 1 baseline** |

The three snapshots share byte-identical `Tex/main.tex`, `Tex/preamble.tex`, `Tex/shared-macros.tex`, `Tex/backmatter.tex`, the part-content aggregators, the main workflow, and the build-book script. The bibliography and glossary were progressively extended in later snapshots. The Chapter 18 snapshot is therefore the most complete source set for the reviewed PDF.

The selected archive has SHA-256:

`1638be9c6a86ee05d389cc558a0e66f87413e1fe50310d029e338d201f9b1602`

The extracted project contains 281 files. The archive does not contain a `.git` directory or commit metadata, so no branch or commit SHA can be asserted. The archive hash and per-file manifest in this checkpoint are the reproducible source identity for this phase.

## 3. Source map

| Concern | Authoritative source |
|---|---|
| Root wrapper | `main.tex` |
| Actual combined-book entry point | `Tex/main.tex` |
| Page geometry, fonts, layout, box styles, `\BookDiagram` | `Tex/preamble.tex` |
| Citation macros, glossary setup, recap and question-box styles | `Tex/shared-macros.tex` |
| Part I aggregator | `Tex/part1/content.tex` |
| Part II aggregator | `Tex/part2/content.tex` |
| Part III aggregator (currently old twelve-placeholder plan) | `Tex/part3/content.tex` |
| Bibliography database | `Tex/bibliography/references.bib` |
| Glossary definitions | `Tex/glossary/terms.tex` |
| Glossary/index/bibliography output | `Tex/backmatter.tex` |
| Mermaid editable sources | `Tex/diagrams/source/` |
| Mermaid theme and browser settings | `Tex/diagrams/mermaid.config.json`, `Tex/diagrams/puppeteer.config.json` |
| Full book build | `scripts/build-book.sh` |
| Part build | `scripts/build-part.sh` |
| Diagram render and validation | `scripts/render-diagrams.sh`, `scripts/check-diagrams.sh` |
| GitHub Actions build | `.github/workflows/build-book.yml` |

Chapter source mapping:

| Chapter | Source file |
|---|---|
| 1 | `Tex/part1/chapter01/chapter-body.tex` (included by `chapter.tex`) |
| 2–8 | `Tex/part1/chapterNN/chapter.tex` |
| 9–18 | `Tex/part2/chapterNN/chapter.tex` |

The shared `Tex/standalone/` directory also contains independent chapter entry points for Chapters 1–18. Chapter 1 is the only chapter whose substantive body is split into `chapter-body.tex` and a short wrapper.

## 4. Build pipeline and environment

The canonical build sequence in `scripts/build-book.sh` is:

1. Render all Mermaid `.mmd` sources to PNG using the pinned Mermaid CLI.
2. Validate the generated images and the correspondence between diagrams and Chapters 1–18.
3. Run `latexmk -xelatex` against `Tex/main.tex`; `latexmk` invokes Biber for the `biblatex` database as needed.
4. Run `makeglossaries` and `makeindex`.
5. Run XeLaTeX again and execute the PDF/log quality checks.

The GitHub Actions workflow installs Node 24, TeX Gyre fonts, and the full TeX Live scheme before rendering and compiling. The Mermaid package directly pins `@mermaid-js/mermaid-cli` to 12.2.0 and requires Node >=22.13. No npm lockfile is included, so transitive Node dependency versions are not frozen.

### Local environment observed

| Tool | Version / state |
|---|---|
| XeTeX | 0.999996, TeX Live 2025/dev (Debian) |
| latexmk | 4.86 |
| Biber | 2.20 |
| makeglossaries | 4.56 |
| Node.js | 22.16.0 (meets declared minimum) |
| npm | 10.9.2 |
| Mermaid CLI `mmdc` | Not installed |
| OpenType TeX Gyre Termes/Heros/Cursor family requested by fontspec | Not available locally under the requested family names |

### Reproduction blockers

**A. Mermaid renderer.** The clean production command `bash scripts/build-book.sh` exits immediately because `tools/mermaid/node_modules/.bin/mmdc` is absent. Installing the pinned package was attempted, but npm could not resolve `registry.npmjs.org` (`EAI_AGAIN`) and the install timed out. The archive intentionally contains the 95 editable `.mmd` sources, not generated PNG build artifacts.

**B. Production fonts.** A direct XeLaTeX attempt against `Tex/part1/main.tex` exits at `Tex/preamble.tex:19` with `fontspec` reporting that `TeX Gyre Termes` cannot be found. The local fontconfig match is a Type 1 PFB font, not the OpenType face required by this fontspec setup. The GitHub workflow explicitly installs `fonts-texgyre`; that dependency is missing from this local environment.

**C. Diagnostic-only smoke test.** To test source syntax without altering the canonical snapshot, a separate disposable copy temporarily substituted Noto OpenType fonts and replaced `\BookDiagram` images with fixed labelled placeholders. Biber read the `.bcf`, found 52 citekeys, and wrote the `.bbl` without reporting missing database entries. XeLaTeX processed the front matter and Chapters 1–7 through at least page 131 before the command time limit was reached. The full diagnostic compile did not finish; no diagnostic PDF is presented as a baseline or release artifact. The temporary copy is not included in the checkpoint.

**Phase 1 gate:** run the real diagram renderer and the full XeLaTeX/Biber/glossary/index build in an environment that has the workflow's dependencies. Do not proceed by substituting placeholder diagrams in the publication output.

## 5. Baseline PDF identity and consistency observations

The Library's `book.pdf` was extracted and checked with `pdfinfo` and `pdftotext`.

| Property | Observed value |
|---|---|
| Pages | 597 |
| Page size | 504 × 720 pt = 7 × 10 inches |
| Creation date | 15 November 2026, 17:31:58 UTC |
| PDF version | 1.7 |
| SHA-256 (first half) | `afdee56e95075def422da97d563176e4` |
| SHA-256 (second half) | `8b21809396ce100b925a118db6029384` |

The PDF contains the Part I and Part II chapters and also the twelve unwritten Part III placeholders, Chapters 19–30. The source project and the PDF therefore share the same old Part III structure.

**Format decision to resolve before release:** `Tex/preamble.tex` explicitly sets `papersize={7in,10in}`, and the 597-page PDF is 7 × 10 inches. This conflicts with the previously selected US Letter production specification for this book. Phase 1 records the discrepancy; it does not silently change the page geometry.

**Part III scope decision to apply later:** the source currently titles Chapter 19 “Engineering Foundations for the Ten Systems,” followed by the old twelve-chapter outline and ten-system case-study structure. The revised approved direction is Chapter 19 engineering foundations and Chapter 20 one request-driven enterprise supply-chain disruption management system, without LangGraph4j or LangChain4j. This is a global project consistency update, not a Part I/II source correction, and is reserved for the global consistency phase.

## 6. Structural and cross-reference audit

| Check | Result |
|---|---:|
| Active compiled TeX source files inspected | 50 |
| `\input` / `\include` references | 57; 0 missing |
| Labels | 418; 0 duplicates |
| Checked `\ref`-style references | 12; 0 missing targets |
| Unique bibliography keys used | 52; 0 missing from `.bib` |
| Entries in `.bib` database | 52 |
| Glossary definitions | 131 |
| Glossary uses | 141; 0 missing keys |
| Active index commands in Chapters 1–18 | 182 |
| Mermaid source files | 95 |
| Active figure references | 95; all have matching Mermaid sources |

`check-scaffold.sh`, `check-diagrams.sh --sources-only`, and `bash -n scripts/*.sh` all passed. The full generated-PNG check was not run because no PNGs or Mermaid renderer are present.

## 7. End-box and recap baseline inventory

Counts below include only active Chapter 1–18 sources, not archived outlines or review drafts.

| Environment | Active occurrences |
|---|---:|
| `learningbox` | 17 |
| `tipbox` | 7 |
| `warningbox` | 25 |
| `notebox` | 19 |
| `takeawaybox` | 15 |
| `chapterrecap` | 16 |
| `reviewquestions` | 19 |

Chapter-level summary:

| Chapter | Diagrams | Takeaway boxes | Warning boxes | Note boxes | Recap environment | Review-question containers |
|---|---:|---:|---:|---:|---:|---:|
| 1 | 3 | 0 | 0 | 0 | Yes | 0 |
| 2 | 3 | 2 | 2 | 1 | Yes | 1 |
| 3 | 4 | 1 | 1 | 1 | Yes | 1 |
| 4 | 4 | 0 | 1 | 1 | Yes | 1 |
| 5 | 4 | 0 | 1 | 1 | Yes | 1 |
| 6 | 4 | 0 | 1 | 1 | Yes | 1 |
| 7 | 4 | 1 | 2 | 2 | Yes | 1 |
| 8 | 5 | 1 | 2 | 1 | Yes | 1 |
| 9 | 4 | 1 | 1 | 1 | Yes | 1 |
| 10 | 4 | 2 | 2 | 2 | Yes | 1 |
| 11 | 6 | 1 | 2 | 2 | Yes | 1 |
| 12 | 3 | 2 | 1 | 1 | Yes | 1 |
| 13 | 5 | 1 | 2 | 0 | Yes | 1 |
| 14 | 8 | 1 | 0 | 2 | Yes | 2 |
| 15 | 7 | 1 | 1 | 1 | **No** | 2 |
| 16 | 9 | 0 | 3 | 1 | Yes | 1 |
| 17 | 9 | 0 | 1 | 1 | Yes | 1 |
| 18 | 9 | 1 | 2 | 0 | **No** | 1 |

This inventory is a baseline, not an instruction to delete every box of a given type. The editorial decision remains purpose-based: remove takeaways only where they paraphrase the recap; preserve distinct safety, authority, provenance, uncertainty and evaluation warnings; integrate definitions into prose only where they genuinely repeat nearby explanations. Chapters 15 and 18 do not use the shared `chapterrecap` environment and should be considered during the later template-consistency phase.

## 8. Confirmed source-level defect already visible in the baseline PDF

`Tex/part2/chapter12/chapter.tex:642` contains `\\FanLanCite` with **two literal backslashes** before the macro name. TeX treats `\\` as a line break; it then typesets `FanLanCite` as ordinary text. The extracted 597-page PDF contains the visible string `FanLanCite§ V-A; ...` in the Chapter 12 source/example note. The citation macro correction belongs in the technical correction phase; it was not changed during Phase 1.

## 9. Phase 1 disposition and hand-off

**Completed in this phase:** canonical source selection; source map; archive comparison; file and dependency inventory; PDF identity; static checks for includes, labels, references, bibliography keys, glossary keys, index entries and Mermaid accessibility; active box/recap inventory; build attempts and blockers; correction ledger; checkpoint manifest.

**Not completed:** a clean production-equivalent rebuild of the full 597-page document. The canonical build requires the actual Mermaid CLI and the production OpenType fonts; the local environment could not obtain/install them. The existing Library PDF is preserved as the visual baseline, but it is not claimed to have been reproduced from this source archive in this run.

**No source corrections were applied.** The next safe action is to obtain a successful real build under the repository's documented GitHub Actions environment (or reproduce that environment locally), then freeze the output/log as the accepted build baseline. Once that gate passes, Phase 2 can correct the Chapter 12 B1/citation issues and other source-fidelity defects without mixing those changes with environment failures.
