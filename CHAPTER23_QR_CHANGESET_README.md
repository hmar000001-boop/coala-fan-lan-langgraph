# Part III Chapter 23 — QR changeset only

This archive contains only the changes required to add/revise Chapter 23 in the LaTeX book repository. It is not a complete book project and contains no application source code.

## Contents

- Revised Chapter 23 LaTeX source and its Markdown outline.
- Chapter 23 standalone XeLaTeX driver.
- Six accessible Mermaid diagram source files (`.mmd`).
- Seven QR source files and their vector PDF assets for primary implementation listings.
- Updated `CODE-PRESENTATION-PLAN.md` source register.
- Updated diagram-source and chapter-build scripts.
- Updated scaffold validation so Chapter 23 is treated as drafted and Chapter 24 remains the placeholder.
- A source review, manifest and SHA-256 inventory.

## QR policy in this chapter

Eleven listings have source references. Seven primary implementations receive QR codes: `C23-S02`, `C23-S03`, `C23-S04`, `C23-S06`, `C23-S07`, `C23-S09` and `C23-S10`. Four supporting declarations/adapters (`C23-S01`, `C23-S05`, `C23-S08` and `C23-S11`) have readable, clickable source/test references but no QR.

The QR, source ID, printed source path and **Open exact source** link use the same immutable GitHub source permalink pinned to application commit `fa8cd5ec0742d7010dbba2c3646852e95062a419`. Test links point to the corresponding test file at that same commit.

## Apply

Extract this ZIP at the root of the book repository, after the accepted Chapter 19–22 changesets. The canonical Part III structure must already reflect the Chapter 19 deletion list for obsolete placeholder directories `Tex/part3/chapter25` through `chapter30`; those deletions are not repeated in this Chapter 23 archive.

## Checks after applying

```bash
python3 scripts/check-source-qrs.py
bash scripts/check-diagrams.sh --sources-only
bash scripts/check-scaffold.sh
```

For a complete local build, install the repository-pinned Mermaid CLI first, then run:

```bash
npm install --prefix tools/mermaid --no-audit --no-fund
bash scripts/build-chapters.sh
```

The updated chapter build driver regenerates the vector QR assets and checks their URLs before rendering the Mermaid diagrams and compiling Chapters 1–23.

## Validation note

The Chapter 23 standalone proof compiled to 35 pages with substitute DejaVu fonts and temporary Graphviz images used only for layout inspection. The seven QR symbols decoded at 300-DPI rendering, and all eleven listing/source-reference groups remained on the same page with their source and test links. Official Mermaid PNG rendering, production-font compilation and physical-print scanning remain local release checks; this archive carries the Mermaid `.mmd` sources rather than generated PNG build outputs.

The application Maven tests were not rerun during this book-editing pass. Test paths and named methods were checked against the supplied source archive.
