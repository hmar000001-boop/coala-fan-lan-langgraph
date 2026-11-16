# Phase 5 — Global consistency and release preparation

## Scope reconciled

Part III is now defined as exactly two chapters developing one request-driven enterprise supply-chain disruption management system. The implementation is Java-only and framework-independent. The older ten-system proposal and framework-specific implementation direction are superseded. Chapters 19 and 20 remain placeholders until their separate outlines are approved; this phase does not draft either chapter.

## Modified files

- `README.md` — replaced stale rolling batch status with a current project scope, repository map, build instructions, and current manuscript status.
- `BOOK_WRITING_AND_PRODUCTION_RULES.md` — updated the current page specification and added the authoritative Part III scope update; clarified the single Java implementation is an engineering application.
- `Tex/part0/frontmatter/preface.tex` — wrote the preface to accurately describe the three-part structure and source/engineering distinction.
- `Tex/part0/frontmatter/reading-guide.tex` — replaced the ten-case-study description with the exact two-chapter supply-chain direction.
- `Tex/part1/chapter01/chapter-body.tex` — replaced the obsolete ten-system/LangGraph4j/LangChain4j promise with the single framework-independent Java application.
- `Tex/part1/chapter05/chapter.tex` — updated future-facing references from plural case studies to the one Part III system.
- `Tex/part2/chapter18/chapter.tex` — updated the Part II hand-off to the single supply-chain implementation.
- `Tex/appendices/content.tex` — aligned the appendix placeholder with the single application.
- `Tex/part3/content.tex` — reduced the active Part III contents from twelve chapter inputs to Chapters 19 and 20 only.
- `Tex/part3/chapter19/chapter.tex` — updated the title and placeholder purpose to engineering foundations for the one application.
- `Tex/part3/chapter20/chapter.tex` — updated the title and placeholder purpose to enterprise supply-chain disruption management.
- `Tex/shared-macros.tex` — updated PDF keywords; removed obsolete framework names.
- `Tex/preamble.tex` — changed the source page geometry from 7 × 10 inches to US Letter (8.5 × 11 inches), two-sided, with a 0.15-inch binding offset. The offset is the concrete implementation chosen for the previously approved gutter requirement.
- `scripts/check-scaffold.sh` — now requires exactly two Part III chapter sources, checks their titles and placeholder status, and rejects obsolete Chapters 21–30.
- `scripts/quality-checks.sh` — now checks for US Letter page dimensions and the two Part III chapter headings in the compiled book.

## Added files

- `review/Part_III_SCOPE_UPDATE_2026-11-16.md` — durable record of the superseding Part III decision.
- `CHANGELOG_PHASE_5.md`, `README_CHANGESET.md`, and `CHANGE_MANIFEST.csv` — this phase's delivery documentation.

## Deleted files

- `Tex/part3/chapter21/chapter.tex`
- `Tex/part3/chapter22/chapter.tex`
- `Tex/part3/chapter23/chapter.tex`
- `Tex/part3/chapter24/chapter.tex`
- `Tex/part3/chapter25/chapter.tex`
- `Tex/part3/chapter26/chapter.tex`
- `Tex/part3/chapter27/chapter.tex`
- `Tex/part3/chapter28/chapter.tex`
- `Tex/part3/chapter29/chapter.tex`
- `Tex/part3/chapter30/chapter.tex`

These were empty structural placeholders for the superseded multi-case-study direction, not drafted chapter content.

## Validation performed before packaging

- Shell syntax validation passed for the modified scaffold and build scripts.
- `scripts/check-scaffold.sh` passed and reported Part I = 8, Part II = 10, Part III = 2.
- A local Part III XeLaTeX build was attempted but stopped at `fontspec`: the TeX Gyre Termes OpenType font was not available to XeLaTeX in this environment.
- Installing the pinned Mermaid CLI timed out. The full source snapshot has Mermaid source files but no generated PNGs, so the complete illustrated-book build was not represented as successful.

**Release status:** the source-level global update is packaged. A production-equivalent combined PDF build, actual Mermaid rendering, and final visual inspection remain CI release gates. No new PDF is included and no placeholder diagrams were fabricated.
