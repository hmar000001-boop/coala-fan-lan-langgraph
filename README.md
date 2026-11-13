# From Cognitive Architectures to Production Agentic Systems

**Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java**

This repository is the LaTeX/GitHub Actions scaffold for the book. It is intentionally a **structure-only baseline**: every part and chapter has a placeholder file, and no chapter prose has been included. Chapter outlines and chapter contents will be added and approved in later stages.

## Repository identity and working model

- Repository name: `cognitive-architectures-to-production-agents`
- Visibility target: public
- Repository creation and pushing are manual; this archive does not create a remote repository or push anything.
- The root `main.tex` builds the combined book to `build/book.pdf`.
- `part0/main.tex` through `part3/main.tex` are independent part-level entry points. `part0` is front matter; `part1`–`part3` correspond to the three book parts.
- Each chapter lives in its own directory and is included as a content fragment by its part's `content.tex`.
- Only the combined book PDF is the configured primary output. Version tags (`v*`) publish it as a GitHub Release asset.

## Directory layout

```text
.
├── .github/
│   ├── workflows/build-book.yml
│   ├── texlive.profile
│   └── texlive.packages
├── bibliography/references.bib
├── diagrams/README.md
├── glossary/terms.tex
├── index/README.md
├── part0/
│   ├── main.tex
│   ├── content.tex
│   └── frontmatter/
│       ├── title-page.tex
│       ├── copyright.tex
│       ├── dedication.tex
│       ├── acknowledgements.tex
│       ├── preface.tex
│       └── reading-guide.tex
├── part1/
│   ├── main.tex
│   ├── content.tex
│   ├── chapter01/chapter.tex
│   └── ... chapter08/...
├── part2/                           # chapter09 through chapter18
├── part3/                           # chapter19 through chapter30
├── scripts/
│   ├── install-texlive.sh
│   ├── build-book.sh
│   ├── build-part.sh
│   ├── render-diagrams.sh
│   └── quality-checks.sh
├── styles/bookstyle.sty
├── appendices/content.tex
├── backmatter.tex
├── main.tex
├── .latexmkrc
├── .gitignore
├── cspell.json
├── CONTRIBUTING.md
├── LICENSE-CODE
└── LICENSE-CONTENT.md
```

## Selected build configuration

- XeLaTeX with the `book` document class
- Latest TeX Live distribution installed on the GitHub-hosted Ubuntu runner
- CI-only build workflow, triggered on every push
- US Letter paper, two-sided layout, mirrored margins and binding gutter
- Source Serif Pro / Source Sans Pro font packages
- Editorial palette with ink, teal and rust accents
- Shared semantic LaTeX environments and source citation commands in `styles/bookstyle.sty`
- `listings` for code; Mermaid source files can be rendered to SVG/PDF
- `biblatex` with Biber and footnote-style citations
- Glossary and alphabetical index infrastructure
- Standard PDF output (no claim of PDF/UA or tagged-PDF conformance)

The CI workflow pins GitHub Actions to full commit SHAs. The TeX Live distribution is intentionally not pinned to a yearly release, per the selected latest-version policy. The workflow records the installed TeX Live version in its log.

## Build and publish

The workflow builds on every push. For version-tag pushes (`v*`), the already validated `build/book.pdf` is passed between jobs as a short-lived workflow artifact and attached to a GitHub Release. The release job does not rebuild the PDF, so it publishes the exact bytes that passed CI. Release creation uses the GitHub CLI and a job-scoped `contents: write` permission; the ordinary build job has read-only repository permissions.

The book build uses `latexmk` with XeLaTeX, allowing it to orchestrate the required LaTeX/Biber/index passes. The CI quality stage checks the scaffold structure, generated PDF, unresolved references/citations, duplicate labels, missing bibliography entries, overfull boxes, text extraction, metadata/URL extraction/font embedding, spelling, and rendered page previews. It also runs a repeat-build comparison within the same CI environment. A visual preview is generated for every page; pixel-diff regression is deferred until an approved visual baseline exists for authored chapter layouts.

### Local commands

A local TeX Live installation with the packages listed in `.github/texlive.packages` is required. The user selected CI-only support, so local setup is documented as optional and is not provisioned automatically.

```bash
# Build the complete book (from repository root)
./scripts/build-book.sh

# Build an individual part (part0, part1, part2 or part3)
./scripts/build-part.sh part1

# Run the PDF/source quality checks
./scripts/quality-checks.sh
```

The main output is `build/book.pdf`. Part PDFs, when built explicitly, are placed under `build/<part>/`.

## Shared semantic environments

Reusable environments are centralized in `styles/bookstyle.sty`. They are intentionally defined once for reuse across all chapter fragments:

- Concepts: `concept`, `definition`, `intuition`, `principle`, `distinction`
- Teaching: `workedexample`, `walkthrough`, `scenario`, `takeaway`, `reviewquestions`, `exercise`, `chapterrecap`
- Source fidelity: `paperclaim`, `paperboundary`, `sourceinterpretation`, `evidence`
- Engineering: `engineeringdecision`, `implementationnote`, `tradeoff`
- Operations and assurance: `failuremode`, `securitynote`, `testingnote`, `operationalnote`
- Technical presentation: `codeexample`, `pseudocode`, `algorithm`, `diagramnote`

Most semantic boxes accept a short title argument. The source citation helpers are `\CoALACite{bib-key}` and `\FanLanCite{bib-key}`. They produce labelled footnotes for the two formal theoretical source families. Bibliographic records are intentionally empty until references are added and verified.

## Content governance

1. The current scaffold contains no chapter prose.
2. A chapter outline must be approved before its chapter is drafted.
3. Chapter files are the placeholders to replace when approved content is ready.
4. Claims explicitly from the papers must be distinguished from book-authored interpretation and engineering decisions.
5. Future part/chapter placeholders are not authorization to draft them.

## Licensing

- Book text: CC BY-NC-SA 4.0 (`LICENSE-CONTENT.md`)
- Repository code and build scripts: Apache-2.0 (`LICENSE-CODE`)
- Author attribution is deliberately left unset until supplied.

Third-party papers, quotations, diagrams and other incorporated materials retain their own rights and must be handled separately.

## Manual GitHub setup

1. Create a public repository named `cognitive-architectures-to-production-agents`.
2. Extract this ZIP into the repository working directory.
3. Review repository metadata and licenses, then initialize Git.
4. Commit and push manually.
5. Open the Actions tab and confirm the first build succeeds.
6. When a release PDF is ready, push a version tag such as `v0.1.0`.
