# Chapter 21 — LaTeX project changes only

**Base project:** `coala-fan-lan-langgraph-main (1).zip`  
**Base archive SHA-256:** `57ad1dc0ab694e7818b62a05a40a876b50313296cd6947b0a3b582572e144143`  
**Package type:** changes-only patch. This ZIP is **not** the complete book project.

## Archive layout

All project files are stored directly at their original repository-relative paths. For example:

- `Tex/part3/chapter21/chapter.tex`
- `Tex/diagrams/source/part3/chapter21/*.mmd`
- `Tex/standalone/chapter21.tex`
- `scripts/check-scaffold.sh`
- `review/Chapter_21_*.md`

There is no `book_overlay/` directory and no top-level project directory. Extract this ZIP into the root of the existing original LaTeX repository, preserving paths and allowing the four modified files to be replaced.

## Contents

- 19 new project files (including the deletion instruction list).
- 4 modified project files.
- 6 deletion targets listed in `CHAPTER21_DELETE_THESE_PATHS.txt`; ZIP extraction does not delete them automatically.
- No unchanged source files, generated PDFs, complete project copy, or supply-chain application files.

## Integration

1. Keep a backup/branch of the original book repository.
2. Extract this ZIP at the existing repository root, preserving the `Tex/`, `scripts/`, `review/`, and `README.md` paths.
3. Manually delete only the six paths listed in `CHAPTER21_DELETE_THESE_PATHS.txt`.
4. Run `bash scripts/render-diagrams.sh` with the repository-pinned Mermaid CLI.
5. Run `bash scripts/check-diagrams.sh --sources-only` and `bash scripts/check-scaffold.sh`.
6. Build Chapter 21 using `Tex/standalone/chapter21.tex` or the configured book CI workflow.

## Scope

The only substantive chapter added in this patch is Chapter 21. Chapter 20 and Parts I–II are not modified. The application project is frozen and no supply-chain Java, tests, Maven files, migrations, or application CI files are included.

## Patch metadata

- `CHAPTER21_CHANGE_MANIFEST.csv` records each added/modified repository file and the six intended deletions.
- `CHAPTER21_SHA256SUMS.txt` records hashes for every project payload file in this patch.
