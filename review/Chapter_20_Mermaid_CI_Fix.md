# Chapter 20 Mermaid CI fix

**Date:** 2026-11-25  
**Scope:** Repair the first Mermaid parser failure reported by the Chapter 20 update CI.

## Root cause

The renderer stopped in `Tex/diagrams/source/part3/chapter20/evaluation-selection-authority.mmd`, line 10:

```mermaid
RETAIN --> PROPOSAL[PlanCandidate proposal(s)]
```

The pinned Mermaid parser treated the unquoted parenthesis in this square-bracket node label as syntax and raised a parse error (`got 'PS'`). This is a diagram-source syntax defect, not a LaTeX or Java issue.

## Correction

The node label is now:

```mermaid
RETAIN --> PROPOSAL[PlanCandidate proposals]
```

The intended meaning is unchanged: the strategy-specific retention stage emits one or more `PlanCandidate` proposals, which remain separate from downstream authorization and grounding execution.

## Validation performed

- `bash scripts/check-diagrams.sh --sources-only` **passed** on the supplied repository snapshot: 107 Mermaid sources, accessibility metadata, sequence-diagram guard, and all Chapter 1–20 figure references.
- The other Chapter 20 diagram sources were manually inspected. The previous CI log had rendered `coala-implementation-map.mmd` and then stopped at this file, so the later Chapter 20 diagrams had not yet been exercised by CI.
- Local rendering with the repository-pinned Mermaid CLI 12.2.0 was **not verified**: `npm install --prefix tools/mermaid --no-audit --no-fund --no-progress` timed out in this environment before installing the CLI. No substitute renderer was used.

## Separate scaffold observation

The supplied repository snapshot contains `Tex/standalone/chapter19.tex`; the earlier report that this file was missing does not match this snapshot. Running the optional `bash scripts/check-scaffold.sh` now fails earlier on its Part III chapter-count assertion (`Part III=12`, while the script expects `6`). That script is not invoked by the current `.github/workflows/build-book.yml` workflow and was not changed in this focused Mermaid fix.

## Change boundary

Only the Mermaid label was changed in the book source. No prose, diagrams other than this source, generated PNGs, Java code, tests, Maven files, npm dependencies, CI workflow, or build scripts were modified.
