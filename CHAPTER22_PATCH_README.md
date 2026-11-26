# Chapter 22 — LaTeX project changes only

This archive is a **changes-only package** for the original LaTeX book repository. It is not a complete project.

## Apply

1. Start from the last CI-green LaTeX repository version that already contains the accepted Chapter 21 integration.
2. Extract this ZIP at the repository root, preserving paths. Files are placed directly under `Tex/`, `scripts/`, `review/`, and the project root; there is no overlay subdirectory.
3. Review `CHAPTER22_CHANGE_MANIFEST.csv` and verify the files with `sha256sum -c CHAPTER22_SHA256SUMS.txt` from the extracted repository root (the checksum file paths are relative to the repository root).
4. Run `bash scripts/check-scaffold.sh` and `bash scripts/check-diagrams.sh --sources-only` before the configured book CI.

## Contents

- 8 added source/review files.
- 6 modified project files, including the Chapter 22 placeholder replaced by the approved manuscript.
- 14 source payload files total.
- No file deletions are required.
- The five new Mermaid sources are canonical; generated PNG previews are intentionally excluded because CI renders them with the pinned Mermaid CLI.
- The standalone proof PDF is delivered separately and is not included in the source patch.

## Scope

Only the original LaTeX book repository is changed. No supply-chain application source, tests, Maven files, migrations, application documentation, or application CI files are included.

## Local proof limitations

The Chapter 22 standalone PDF was compiled on 22 US Letter pages using temporary Liberation font substitutions in a proof copy because the TeX Gyre families declared by the canonical preamble were unavailable to local XeTeX. The canonical preamble was not modified. Local diagram previews were temporary Graphviz renderings; the pinned Mermaid CLI 12.2.0 render and canonical book build remain for the configured CI environment.
