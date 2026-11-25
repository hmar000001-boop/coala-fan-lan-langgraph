# Chapter 20 architecture-review patch — changes only

This patch updates the previously delivered Chapter 20 draft after a deep source, architecture, and cross-chapter review.

## Apply

Overlay the files in this ZIP onto the book repository. The ZIP intentionally contains only files changed since the previous `Chapter_20_source_changes_only.zip`, plus this patch note and the review record. It is not a complete book archive.

The four revised Mermaid files are authoritative sources. Do not add locally generated PNG previews from the proof environment; the book's diagram-rendering workflow generates those assets.

## Files included

- `Tex/part3/chapter20/chapter.tex` — corrected architecture semantics, temporal behavior, caller-managed memory handoffs, strategy/evaluator boundaries, and recap layout.
- `Tex/part3/chapter20/outline/Chapter_20_Outline.md` — aligned with the final reviewed content and evidence boundaries.
- Four revised Mermaid sources under `Tex/diagrams/source/part3/chapter20/`.
- `review/Chapter_20_Architecture_Review.md` — findings, applied changes, cross-chapter audit, and validation qualifications.
- `DELETE_THESE_FILES.txt` — cleanup instruction for the superseded v1 outline path from the preceding Chapter 20 patch.

## Explicitly not included

No complete project, generated PNGs, temporary proof wrapper, substitute-font preamble, PDF build artifacts, Java source, Java tests, Maven files, scripts, or CI workflows are included.
