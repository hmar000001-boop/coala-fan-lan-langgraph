# Part III — Chapter 20 incremental changeset

This archive contains **Chapter 20 changes only**. It is not a copy of the LaTeX project.

## Prerequisite

Apply this changeset on top of the book repository after the previously accepted `Part_III_Chapter19_QR_SCAFFOLD_CHANGESET_ONLY.zip`. Chapter 20 uses the shared source-reference macros, QR inclusion pattern, and QR validation tooling introduced by that Chapter 19 changeset. Those shared files are intentionally not duplicated here.

## Apply

1. Extract this ZIP at the root of `coala-fan-lan-langgraph-main`.
2. Allow the modified `CODE-PRESENTATION-PLAN.md` and Chapter 20 source to overwrite their existing versions.
3. No file deletions are required for this chapter-only changeset.
4. Run `bash scripts/check-scaffold.sh` and `python3 scripts/check-source-qrs.py` from the repository root.
5. Build the standalone Chapter 20 proof or the full book in the normal production environment.

## Contents

- Modified: `Tex/part3/chapter20/chapter.tex`
- Modified: `CODE-PRESENTATION-PLAN.md`
- Added: `review/Chapter_20_Source_Review_v2.md`
- Added: five vector QR PDFs and their standalone LaTeX source files for C20-S01, C20-S02, C20-S03, C20-S04, and C20-S07.
- Added: this README and `CHAPTER20_CHANGESET_MANIFEST.txt`.

C20-S05 (`Observation<T>`) and C20-S06 (`PlanningState.advance(...)`) are supporting excerpts. They intentionally have clickable source and test references without QR codes.

## Validation boundary

The standalone Chapter 20 LaTeX proof compiled to 29 pages using temporary DejaVu fonts and diagram placeholders because production TeX Gyre fonts and generated Mermaid artwork were absent in the supplied archive. All seven source-reference strips remained on the page of their listings; five QR codes decoded at 220 DPI and matched their PDF hyperlink targets. This is a digital layout check, not a physical print certification or a production-font full-book build.

The application repository was inspected read-only. No application source, tests, build files, migrations, or CI files are included or changed by this changeset.
