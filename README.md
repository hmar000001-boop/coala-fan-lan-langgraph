# Chapter 20 Mermaid CI fix — changes only

This package contains only the Chapter 20 Mermaid source correction and its review record. It is not a complete book repository.

## Files

- **Modified** `Tex/diagrams/source/part3/chapter20/evaluation-selection-authority.mmd`
- **Added** `review/Chapter_20_Mermaid_CI_Fix.md`

## Apply

Extract this ZIP at the root of the book repository, preserving the directory structure, and commit the two files.

## Validation

- `bash scripts/check-diagrams.sh --sources-only`: passed against the supplied repository snapshot (107 sources and all Chapter 1–20 figure references).
- Mermaid CLI 12.2.0 rendering: not locally verified. Installing the repository-pinned CLI timed out in this environment. Re-run the existing GitHub Actions workflow to verify rendering and PDF compilation.

No generated PNGs are included; the existing CI render step regenerates them from the `.mmd` sources.
