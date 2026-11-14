# Mermaid diagrams

All book diagrams are authored as editable Mermaid text (`.mmd`) under `source/partN/chapterNN/`. CI renders every source recursively to a PNG with Mermaid CLI 12.2.0. Chapters include generated PNGs through the shared `\BookDiagram` macro; LaTeX only places each completed image, caption, and reference.

## Workflow

1. Edit or add a `.mmd` source under the matching part/chapter directory.
2. Install the pinned CLI dependency: `npm install --prefix tools/mermaid --no-audit --no-fund`.
3. Render: `bash scripts/render-diagrams.sh`.
4. Validate generated PNGs and chapter references: `bash scripts/check-diagrams.sh`.
5. Build: `bash scripts/build-book.sh`.

Generated PNGs mirror the source directory structure under `generated/` and are ignored by Git. CI regenerates all images before XeLaTeX. Include meaningful accessible descriptions in each Mermaid source and informative captions in the chapter. The export target is 3200 pixels; validation requires a minimum 2200-pixel longest edge. Final legibility must be reviewed at printed size.
