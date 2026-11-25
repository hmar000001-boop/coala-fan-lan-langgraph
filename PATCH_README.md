# Chapter 20 source patch

Apply these files to the existing LaTeX book repository, preserving paths. This is a changes-only package, not a complete book project.

## Deletion

Delete the obsolete duplicate outline: `Tex/part3/chapter20/outline/Chapter_20_Outline_v1.md`. The canonical approved outline is `Chapter_20_Outline.md`.

## Generated files

Generated PNGs and `Tex/Output` build artifacts are intentionally excluded. Run `bash scripts/render-diagrams.sh` before building the combined book; CI uses the pinned Mermaid CLI 12.2.0.

## Build and proof notes

The standalone entry point is `Tex/standalone/chapter20.tex`. The PDF proof supplied separately was built in a disposable copy with temporary Liberation font substitutions and Graphviz diagram previews because the prescribed TeX Gyre OpenType fonts and pinned Mermaid CLI were not available in the authoring container. The repository's font configuration is unchanged. Use the configured CI build for canonical fonts and Mermaid PNGs.

No Java application source, tests, Maven files, database migrations, or application workflows are included or changed.
