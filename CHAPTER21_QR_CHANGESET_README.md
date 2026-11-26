# Part III — Chapter 21 incremental changeset

This archive contains **Chapter 21 changes only**. It is not a copy of the LaTeX project and does not contain the supply-chain application repository.

## Prerequisites

Apply this changeset on top of the book repository after the previously accepted changesets:

1. `Part_III_Chapter19_QR_SCAFFOLD_CHANGESET_ONLY.zip`
2. `Part_III_Chapter20_QR_CHANGESET_ONLY.zip`

Chapter 21 uses the shared source-reference macros, QR inclusion pattern, and validation tooling introduced by the Chapter 19 changeset. Those shared files and all Chapter 19/20 chapter files are intentionally not duplicated here.

The Chapter 19 scaffold changeset also supplied `DELETE_THESE_PATHS.txt` for obsolete Chapter 25–30 directories. Ensure those six legacy directories have been removed as instructed by that earlier patch before running the scaffold checks. ZIP extraction by itself does not perform deletions.

## Apply

1. Extract this ZIP at the root of `coala-fan-lan-langgraph-main` (the archive preserves the repository-root folder prefix).
2. Allow the modified `CODE-PRESENTATION-PLAN.md` and `Tex/part3/chapter21/chapter.tex` to overwrite their existing versions.
3. No additional file deletions are required by this Chapter 21 changeset.
4. From the repository root, run:

   ```bash
   python3 scripts/check-source-qrs.py
   bash scripts/check-scaffold.sh
   bash check-scaffold.sh
   bash scripts/check-diagrams.sh --sources-only
   ```

5. Build the standalone Chapter 21 proof or the complete book in the normal production environment.

## Contents

- Modified: `Tex/part3/chapter21/chapter.tex`
- Modified: `CODE-PRESENTATION-PLAN.md`
- Added: `review/Chapter_21_QR_Source_Review_v3.md`
- Added: six vector QR PDFs and their standalone LaTeX sources for C21-S01, C21-S02, C21-S03, C21-S05, C21-S06, and C21-S07.
- Added: this README, `CHAPTER21_CHANGESET_MANIFEST.txt`, and `CHAPTER21_CHANGESET_SHA256SUMS.txt`.

C21-S04 is a supporting attribution helper. It intentionally has clickable source and test references without a QR code. C21-S05/S06/S07 identify the mandatory-first workspace admission, bounded coalition enumeration, and verified B3 outcome evidence paths.

## Validation evidence

- Source QR validator: **14 QR assets** across Chapters 19–21 match their commit-pinned source URLs and PDF link payloads.
- Scaffold: both the canonical script and root wrapper pass; Part III contains exactly **six chapters (19–24)**.
- Diagram source checks: **118 Mermaid sources**, accessible descriptions, sequence syntax guard, and Chapter 1–22 figure references pass.
- Standalone Chapter 21 proof: **40 pages**; all seven listing/source-reference pairs remain on the same page; six QR codes decoded at 220 DPI and each decoded destination matched its clickable PDF link.

The standalone proof was built in a temporary validation copy using DejaVu font substitutes and placeholder artwork for generated Mermaid images absent from the supplied archive. It is a source/layout and digital-link check, not a production-font full-book build or physical-print certification. The proof PDF and temporary proof assets are not included in this changeset.

The application repository was inspected read-only. No application source, tests, Maven files, migrations, or CI files are included or modified by this changeset.
