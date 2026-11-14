# CI quality-check remediation — 14 November 2026

## Reported failure

The GitHub Actions excerpt showed that `scripts/quality-checks.sh Tex/Output/main.pdf Tex/Output/main.log` exited with status 1, but did not include the script's output or the LaTeX log. The exact original assertion therefore cannot be identified from that excerpt alone.

## Changes made

1. The workflow now checks for `pdfinfo` and `pdftotext` on the Ubuntu host runner and installs `poppler-utils` when either command is missing. The TeX Live action runs in its own container; PDF post-processing is performed by a later host-runner step, so these host utilities must be provisioned separately.
2. `scripts/quality-checks.sh` now prints an explicit error for missing/empty inputs, missing commands, unreadable PDFs, incorrect PDF title metadata, missing chapter headings, unresolved references/citations, LaTeX errors, or an invalid page count.
3. Chapter-title verification normalizes extracted line wrapping before matching, avoiding dependence on the PDF text extractor's line breaks.
4. Overfull boxes remain visible warnings, not build failures, as intended for the drafting stage.

## Validation performed

- `bash -n` passed for the modified shell script.
- The complete book compiled locally from the repository with a temporary substitute font configuration because this local environment does not have the OpenType TeX Gyre faces. The committed `Tex/preamble.tex` was not changed.
- The updated quality-check script passed against the 129-page combined-book PDF: metadata, text extraction, both chapter headings and log checks passed.
- A negative test with a missing PDF failed with the new explicit diagnostic rather than a silent exit.
- ZIP integrity and repository contents were checked after packaging.

## Remaining CI verification

The exact failing assertion in the original GitHub run cannot be proven from the supplied excerpt because it contains no script output, PDF metadata, or `main.log`. After this patch is pushed, a new Actions run will either pass or identify the exact remaining assertion in the step output.
