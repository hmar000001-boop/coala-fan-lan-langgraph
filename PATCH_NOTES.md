# Chapter 19 change-only patch

This archive contains only new or modified book-project source/documentation files for the approved Part III structure and the drafted Chapter 19. It is intended to be extracted over the existing `coala-fan-lan-langgraph-main` book repository.

- Java repository/source code is not included or modified.
- Generated LaTeX outputs and generated diagram PNGs are intentionally excluded.
- The authoritative diagrams are the five Mermaid `.mmd` sources under `Tex/diagrams/source/part3/chapter19/`.
- Chapters 20–24 remain outline-gated placeholders; their outline files are included as the agreed Part III planning baseline.

## Diagram and chapter build

From the book repository root, install the pinned renderer and render diagrams:

```bash
npm install --prefix tools/mermaid --no-audit --no-fund
bash scripts/render-diagrams.sh
bash scripts/check-diagrams.sh
```

Then build the standalone Chapter 19 proof PDF using the repository's TeX environment:

```bash
latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode \
  -jobname=Chapter_19 -output-directory=Tex/Output Tex/standalone/chapter19.tex
makeglossaries -d Tex/Output Chapter_19
latexmk -xelatex -halt-on-error -file-line-error -interaction=nonstopmode \
  -jobname=Chapter_19 -output-directory=Tex/Output Tex/standalone/chapter19.tex
```

## Explicit removals

The following six obsolete alternative-case-study placeholders were removed from the active Part III scaffold because the approved Part III now develops one supply-chain application across Chapters 19–24:
- `Tex/part3/chapter25/chapter.tex`
- `Tex/part3/chapter26/chapter.tex`
- `Tex/part3/chapter27/chapter.tex`
- `Tex/part3/chapter28/chapter.tex`
- `Tex/part3/chapter29/chapter.tex`
- `Tex/part3/chapter30/chapter.tex`

The removed chapter ideas are not integrated into the new Part III content sequence. The current Part III includes only Chapters 19–24.
