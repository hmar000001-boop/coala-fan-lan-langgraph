# Preface reliability wording update

## Scope

This is a one-file, changes-only update to the book repository.

Changed file:
- `Tex/part0/frontmatter/preface.tex`

The paragraph about production and reliability has been rewritten to state the book's objective positively: designing and engineering reliable, stateful AI agents for production use. It identifies reliability as an engineering objective, names the engineering practices developed in the book, and retains the boundary that the Part III supply-chain environment is deterministic and simulated rather than a live enterprise deployment.

## Explicitly unchanged

- Book title and subtitle
- PDF metadata and title page
- Copyright page and content/code licences
- All chapters, appendices, source code, tests, and CI configuration

Those are separate publishing decisions and were not included in this approval.

## Validation

- The repository's source-only diagram validation passed for all 131 Mermaid sources, including accessibility descriptions, sequence-diagram syntax guards, and Chapter 1–24 references.
- The edited preface compiled in an isolated XeLaTeX check and produced a two-page US Letter proof. The check used temporary DejaVu font substitutions because the environment does not have the repository's configured TeX Gyre fonts installed; this verifies the edited text and its basic LaTeX layout, not the final book typography.
- The full book build was not completed. `scripts/build-book.sh` stopped because Mermaid CLI 12.2.0 was not installed. An attempt to install the pinned npm dependency timed out. The configured TeX Gyre fonts were also unavailable in this environment.

No final full-book PDF is included in this changeset.

## Apply

Extract this ZIP at the root of the book repository, allowing the included path to overwrite the existing `Tex/part0/frontmatter/preface.tex`.
