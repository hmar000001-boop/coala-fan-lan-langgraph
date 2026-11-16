# Review fixes — change-only package

This is a **change-only** package. It does not include the full source repository or unchanged files.

## Apply
1. Use the canonical source repository version that includes the accepted Phase 2–5 changes.
2. Copy every file from this archive to the repository root, preserving the directory structure.
3. Delete `Tex/part0/frontmatter/dedication.tex` (the deletion is also recorded in `CHANGE_MANIFEST.csv`).
4. Regenerate the derived diagram PNGs from `Tex/diagrams/source/` using the repository's diagram-rendering script.
5. Build the book with the repository's pinned XeLaTeX/Biber toolchain and visually inspect the affected chapters.

## Contents
- 11 modified source files (Chapter 10, 11, 13–18, front-matter/appendix input, and the Chapter 15 Mermaid source).
- 4 added documentation files: this README, the change log, findings disposition, and manifest.
- 1 deleted placeholder file recorded in the manifest; its bytes are not included.

## Important
- The Chapter 15 Mermaid PNG is derived and is intentionally not included; regenerate it from the modified `.mmd` source.
- No complete repository, baseline PDF, or unchanged file is included.
- No complete PDF rebuild is included or claimed.
- The Java snippets remain intentionally illustrative fragments; Part III is the planned complete application.
