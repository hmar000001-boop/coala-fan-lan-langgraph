# Chapter 22 — incremental LaTeX changeset only

**Base book archive:** `coala-fan-lan-langgraph-main (2).zip`  
**Application source baseline:** `haythemabr/supply-chain-agent` at `fa8cd5ec0742d7010dbba2c3646852e95062a419`  
**Package type:** incremental changes-only ZIP. It is **not** the complete book project.

## Archive contents

- **2 modified files:** `Tex/part3/chapter22/chapter.tex` and `CODE-PRESENTATION-PLAN.md`.
- **14 added QR assets:** one `.tex` payload source and one vector `.pdf` per primary listing `C22-S03` through `C22-S09`.
- **4 added documentation/metadata files:** the source review, this README, the change manifest, and the SHA-256 list.
- **20 files total:** 2 modified and 18 added.

The ZIP contains no unchanged book sources, no prior Chapter 19–21 files, no generated standalone proof PDF, no temporary diagram placeholders, no font substitutions, and no Supply Chain Java or test files. Shared QR macros and validation/generation scripts are already present from the accepted earlier changesets and are not duplicated here.

## Integration

1. Use the existing book repository after the accepted Chapter 19, Chapter 20, and Chapter 21 changesets have been applied.
2. Extract this ZIP at the repository root, preserving the paths as stored.
3. Run `bash scripts/generate-source-qrs.sh` only if you need to regenerate the vector QR assets from their included `.tex` payloads; the generated `.pdf` assets are already included.
4. Run `python scripts/check-source-qrs.py`, `bash scripts/check-scaffold.sh`, `bash check-scaffold.sh`, and `bash scripts/check-diagrams.sh --sources-only`.
5. Build the standalone chapter with `Tex/standalone/chapter22.tex`, then build the full book with the repository's normal CI workflow.

No manual deletions are required by this Chapter 22 patch. Keep the already accepted Chapter 19 deletion instructions applied; this incremental ZIP does not repeat them.

## Content decisions

- C22-S01 and C22-S02 are supporting Java record declarations and intentionally receive text-only references (no QR).
- C22-S03 through C22-S09 are the seven primary implementation listings and each receive a QR.
- Each QR and adjacent **Open exact source** hyperlink point to the same immutable `fa8cd5e` source permalink. Test file and method labels are separately clickable.
- Chapter 21 already describes the B1 provider-utility correction in the same source snapshot; no stale B1 text is introduced and Chapter 21 is not changed by this package.

## Proof limitations

The 34-page standalone proof used DejaVu substitutes for the production TeX Gyre fonts and temporary labelled placeholders for missing generated Mermaid PNGs. Neither is included or applied to the production book. QR scan decoding, same-page link parity, and page layout were checked at 220 DPI; the proof is not a production-font full-book build or physical-print certification.
