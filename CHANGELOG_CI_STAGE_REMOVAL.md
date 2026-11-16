# CI workflow change — scaffold validation stage removed

## Modified
- `.github/workflows/build-book.yml`
  - Removed the entire `Check repository structure` step, including its invocation of `bash scripts/check-scaffold.sh`.
  - No replacement step was added.

## Unchanged
- `scripts/check-scaffold.sh` remains in the repository but is no longer invoked by this workflow.
- Diagram rendering and validation, XeLaTeX/Biber compilation, PDF quality checks, artifact upload, and release steps remain unchanged.

## Added
- `CHANGELOG_CI_STAGE_REMOVAL.md` (this file).

## Deleted
- None.
