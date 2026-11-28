# KDP Hardcover 550-page Change Set

## Status

This is the approved source-only overlay against the exact baseline below. It implements the seven approved change groups. **It is not a verified print-ready PDF:** a full production build did not finish in this runtime, and the most recent user-supplied CI result before this patch was 579 physical pages (580 KDP-counted). Run the book's normal CI build after applying this overlay; the quality gate will reject any output over 550 KDP-counted pages.

## Baseline and protected identity

- Baseline archive: `coala-fan-lan-langgraph-main (5).zip`
- Baseline SHA-256: `0a4a86dcde745703c8c9fd105a1244a42da80e038f9fd0da88413ed8ece47a66`
- Embedded application repository: `https://github.com/haythemabr/supply-chain-agent`
- Pinned application commit: `6329aec82e1d8b4f19b68986a0d4cf0c448f697f`

The repository URL and commit are preserved exactly. No application-repository files are included or modified.

## Implemented changes

1. **KDP geometry:** 8.25 × 11 in trim; 0.90 in inside, 0.50 in outside, 0.75 in top, and 0.65 in bottom margins; zero binding offset; running-header box positioned within the top safe area.
2. **Two-sided pagination:** retain `twoside`, switch to `openany`, and make `\cleardoublepage` clear without inserting automatic blank verso pages. Explicit source page breaks remain untouched.
3. **Moderate vertical compression:** body leading 1.18 → 1.12; paragraph skip 6 pt → 4 pt; proportionate spacing reductions around headings, lists, tables, floats, captions, listings, and teaching/source-layout boxes. Body font size and code font sizes are unchanged.
4. **Targeted line wrapping:** 42 `\allowbreak{}` insertions and one existing `\linebreak[3]` strengthened to `\linebreak[4]`. The six touched chapter/appendix files compare byte-for-byte after removal of only these line-break controls; their substantive text and printed identifier strings are unchanged.
5. **Printed contents:** two columns; parts, chapters, and first-level sections retained; deeper printed TOC entries omitted. PDF bookmarks remain enabled through subsubsection depth.
6. **Glossary:** two-column layout; all 133 glossary declarations and their descriptions remain unchanged. Index and bibliography source material are not edited.
7. **KDP quality gate:** enforce 594 × 792 pt (8.25 × 11 in), calculate KDP page count by rounding an odd physical page count up to the next even count, and fail above 550. The title and chapter-content checks remain in place.

## Files in this overlay

Exactly ten existing repository files are modified. No repository files are added or deleted:

- `Tex/preamble.tex`
- `Tex/main.tex`
- `Tex/shared-macros.tex`
- `Tex/part2/chapter14/chapter.tex`
- `Tex/part3/chapter19/chapter.tex`
- `Tex/part3/chapter20/chapter.tex`
- `Tex/part3/chapter23/chapter.tex`
- `Tex/part3/chapter24/chapter.tex`
- `Tex/appendices/appendix-c-persistence.tex`
- `scripts/quality-checks.sh`

## Validation performed

- Uploaded baseline archive SHA-256 verified against the approved value above.
- Source QR check passed: 35 QR assets match their commit-pinned PDF links.
- Mermaid inventory: 131 source/reference pairs are present in the project. The local existence check relied on temporary placeholder PNGs in the diagnostic workspace; no diagram PNGs are included in this overlay, and real Mermaid rendering still requires the production CI renderer.
- Protected Part III repository URL and pinned-commit occurrence counts match the baseline; no wrong owner or wrong commit references were introduced.
- All 133 glossary declarations are retained; glossary term source is byte-identical to baseline.
- For all six chapter/appendix text files containing line-break annotations, removing only `\allowbreak{}` and `\linebreak[n]` makes the edited text exactly identical to baseline.
- `bash -n scripts/quality-checks.sh` passed.
- Quality-gate fixtures passed at 549 physical pages (550 KDP-counted) and 550 physical pages; a 551-physical-page fixture was correctly rejected as 552 KDP-counted.

## Build limitation / next validation

A full local book build was not completed: the environment does not contain the configured TeX Gyre OpenType font files, the Mermaid renderer dependencies could not be installed within the execution window, and the fallback diagnostic build was stopped before producing a complete PDF. No fallback font substitutions or placeholder diagram images are included in this overlay. Therefore, the final page count and two-column page layout must be confirmed by the repository's normal production CI build. Do not treat this source overlay as KDP-approved until that build passes the 550-page gate and the PDF is visually reviewed.
