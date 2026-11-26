# Chapter 24 — changeset only

**Project:** *From Cognitive Architectures to Production Agentic Systems*  
**Chapter:** 24 — Composing the Supply-Chain Agent: Graph Orchestration, Persistence, and Simulated Execution  
**Baseline:** the supplied book repository plus the already accepted Chapter 19–23 changesets  
**Application snapshot used for source links:** `hmar000001-boop/supply-chain-agent`, commit `fa8cd5ec0742d7010dbba2c3646852e95062a419`

## Apply

Extract this ZIP at the root of the book repository, after the accepted Chapter 19, 20, 21, 22, and 23 changesets. The package contains only Chapter 24 changes plus its small shared-macro/validation/build updates. It does not contain the full book project, application source code, old chapter QR assets, generated Mermaid PNGs, or the standalone proof PDF.

No application Java source is modified by this changeset.

## Contents

- **9 modified files:** book `README.md`, `CODE-PRESENTATION-PLAN.md`, chapter build/scaffold/diagram/QR validation scripts, shared source-reference macros, Chapter 24 LaTeX source, and the Chapter 24 outline.
- **23 added project files:** the Chapter 24 source review, standalone build entry, seven accessible Mermaid source diagrams, and seven vector QR assets (each with its `.tex` source and `.pdf` output).
- **2 package-control files:** this readme and `CHAPTER24_CHANGE_MANIFEST.csv`.

The ZIP contains 34 files total (32 project changes and these two package-control files). The manifest lists all project changes and this readme; it omits its own checksum because a manifest cannot contain a stable checksum of itself.

## Source navigation

Chapter 24 uses 14 source-reference records:

- Seven primary implementation listings have QR codes: `C24-S03`, `C24-S04`, `C24-S05`, `C24-S06`, `C24-S11`, `C24-S12`, and `C24-S13`.
- Seven supporting source references remain text-only: `C24-S01`, `C24-S02`, `C24-S07`, `C24-S08`, `C24-S09`, `C24-S10`, and `C24-S14`.
- `Phase0Application` is linked directly in the runnable-surface prose. It is explicitly described as an intake-only smoke example without a dedicated automated test; it is not misrepresented as a full application or assigned a synthetic test link.

All 14 source paths, source-line ranges, test paths, and named test methods were checked against the supplied application archive. Source URLs are commit-pinned; the QR payload and clickable PDF source link use the same exact URL.

The shared macro retains 19.5 mm for ordinary QR symbols. Only the two densest Chapter 24 payloads (`C24-S06` and `C24-S12`) use the 21 mm variant, within the agreed 18–21 mm target. Earlier chapter QR assets are left byte-for-byte unchanged.

## Verification performed

- `bash scripts/check-scaffold.sh` — PASS; Part III remains six chapters (19–24), and Chapters 1–24 are recognized as drafted.
- `bash check-scaffold.sh` — PASS.
- `bash scripts/check-diagrams.sh --sources-only` — PASS; 131 Mermaid sources, accessible descriptions, syntax guard, and Chapter 1–24 figure references.
- `python3 scripts/check-source-qrs.py` — PASS; 35 cumulative QR assets match commit-pinned PDF links.
- Standalone XeLaTeX proof — 27 pages; seven Chapter 24 QR symbols decode from the rendered PDF at 300 DPI, with exact matching clickable PDF annotations. All seven primary listing/source-reference groups remain on the same page.
- The 14 source-reference mappings and linked test methods were checked against the supplied application files.

## Proof-build limitations

The production TeX Gyre OpenType fonts are unavailable in the authoring environment, so the isolated standalone proof used DejaVu font substitutes. The repository's pinned Mermaid CLI could not be installed in this environment; temporary Graphviz stand-ins were used only in the proof copy for page-layout inspection. These stand-ins and the proof PDF are not included. The seven `.mmd` source diagrams are included, and the normal repository build should render them with its pinned Mermaid tool. A production-font full-book build, official Mermaid PNG generation, and physical print proof remain publication checks.
