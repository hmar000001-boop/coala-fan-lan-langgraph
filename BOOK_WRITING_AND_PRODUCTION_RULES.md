# Book Writing and Production Rules

**Project:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Status:** Authoritative working specification. Read this file before outlining, drafting, revising, or packaging any chapter.

## 1. Approval and delivery workflow

1. Every chapter receives its own detailed outline and its own approval before chapter prose is written.
2. Work in batches of two chapters for drafting efficiency, but retain chapter-by-chapter outline approval. One chapter's approval does not approve the next chapter's outline.
3. For each batch: prepare the two outlines as individual review PDFs; wait for approval of each; draft only the approved chapters; perform a source-fidelity and cross-chapter consistency review; build and visually inspect individual chapter PDFs and the combined book PDF.
4. Do not silently treat a proposed outline, a prior chapter's approval, or a request to continue as approval of an unapproved outline.
5. Deliver chapter content as individual PDFs. Do not deliver Markdown chapters, ZIP archives, or combined PDFs unless the author explicitly requests those formats. Repository source files remain in the project repository.
6. Keep a durable status entry in `README.md` and preserve approved outlines, rule versions, and delivery checkpoints in `review/`.

## 2. Source discipline and theoretical scope

The book has two formal theoretical foundations only:

- **[CoALA]** Sumers, Yao, Narasimhan, and Griffiths, *Cognitive Architectures for Language Agents*, Transactions on Machine Learning Research (2024), with the original arXiv manuscript as the earlier version.
- **[Fan & Lan]** Fan and Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps* (2026).

Use only the two formal source labels `[CoALA]` and `[Fan & Lan]`. Use the shared `\CoALACite{...}` and `\FanLanCite{...}` footnote macros. Do not invent additional formal theory labels.

Part I explains CoALA on its own terms. Never use Fan & Lan to reinterpret, extend, or retroactively change what CoALA says. Part II treats Fan & Lan as a separate paper and distinguishes its explicit claims, hypotheses, analysis, and boundaries. Part III's Java systems are engineering applications, not claims that either paper prescribes those implementations.

Do not introduce Tree of Thoughts, RAP, or any other research framework as an additional theoretical foundation. Other works may be named only when they are examples explicitly discussed or cited within the primary paper being explained; do not turn those works into parallel theory chapters or claim their mechanisms as CoALA/Fan & Lan mechanisms.

For every substantive theoretical claim, identify the exact supporting paper section, figure, table, or appendix during research and preserve that trace in the prose and footnotes. If a claim is an explanation, interpretation, illustrative analogy, or engineering recommendation rather than an explicit paper statement, mark and phrase it accordingly. Do not make unsupported claims sound like quotations or direct paper statements.

## 3. Teaching style and chapter construction

- Write for a technically curious beginner with basic programming knowledge; do not assume prior knowledge of cognitive architectures or agent research.
- Use the sequence **problem first → concrete intuition → term → precise mechanism → example → boundary**. Do not dump a glossary of definitions before the reader needs the terms.
- Explain every new term at first meaningful use. Distinguish nearby concepts explicitly.
- Use complete, connected explanations, not compressed notes or lists of unexplained labels. Tables and bullets support explanations; they do not replace them.
- Develop concepts progressively. Reuse the Product X payment-service incident as the book-created running example where useful, but identify it as a **[Book example]** and never imply it comes from either paper.
- Make examples technically plausible and internally consistent. Do not add invented product details and then use them as factual evidence.
- Each chapter should have a clear chapter-at-a-glance orientation, learning outcomes, a logical section progression, selective worked examples, source/boundary notes, a recap, and review questions or exercises when pedagogically useful.
- Avoid repeating material already taught. Preview later concepts briefly and point to their chapter; do not teach later chapters prematurely.
- Keep chapters substantial enough to explain the subject properly. There is no fixed page-count ceiling; completeness, clarity, accuracy, and teaching value govern length.

## 4. Part I scope boundaries

- Chapter 1 motivates why a cognitive architecture is useful and introduces the CoALA map at a high level.
- Chapter 2 explains the architecture as a whole and the relationships among memory, action space, and the decision procedure.
- Chapter 3 explains the memory model in depth: working memory and long-term episodic, semantic, and procedural memory.
- Chapter 4 explains internal actions: retrieval, reasoning, and learning. Keep external grounding as a boundary and defer its full explanation to Chapter 5.
- Chapter 5 explains external actions and grounding.
- Chapters 6–8 develop planning, proposal/evaluation/selection, and interleaving/iteration. Do not duplicate the full decision procedure in Chapters 3 or 4.

## 5. Shared LaTeX system and preamble

- `Tex/preamble.tex` is the one shared authorial preamble. It is loaded once by `Tex/main.tex`; chapter fragments must never load it.
- The latest author-supplied preamble supersedes earlier preferences for trim size and fonts: its current specification is a 7 × 10 inch, two-sided, open-right book using TeX Gyre Termes, TeX Gyre Heros, and TeX Gyre Cursor. The author-supplied preamble is the design baseline. It may be changed only when a demonstrable improvement is needed for consistent typography, accessibility, rendering, pagination, or figure placement. Preserve existing design intent and explain nontrivial changes in the review notes.
- Use the `book` class, XeLaTeX, `fontspec`, the author's selected fonts and page layout, shared colors, heading styles, headers/footers, `listings`, `graphicx`, captions, and reusable teaching environments from the preamble.
- Use `Tex/shared-macros.tex` for book-wide commands, citations, glossary, index, and reusable macros/environments. Do not create chapter-local versions of shared commands or boxes.
- Shared environments include `learningbox`, `tipbox`, `warningbox`, `notebox`, `takeawaybox`, `chapterrecap`, and `reviewquestions`. Use them consistently and selectively. All chapters must follow the same semantic box policy. Chapters 1–4 establish the visual baseline: a chapter-at-a-glance orientation, selective learning/tip/note/warning/takeaway boxes where they serve a pedagogical purpose, a chapter recap, and review questions. Do not force boxes around ordinary prose. Boxes are for learning objectives, genuinely useful tips, important cautions, clarifications, takeaways, recaps, and questions—not decoration or wrapping ordinary paragraphs.
- Keep code examples in `listings`; use the shared language definitions and formatting. Avoid raw code screenshots.
- Use semantic macros and labels consistently. Every figure has a caption and stable label; every cross-reference resolves.

## 6. Diagrams and figures: Mermaid is authoritative

All conceptual diagrams are authored as Mermaid text and rendered to PNG by CI before LaTeX compilation.

- Store editable `.mmd` sources under `Tex/diagrams/source/partN/chapterNN/`.
- Store shared Mermaid theme and configuration in `Tex/diagrams/mermaid.config.json` (and related shared renderer configuration only when needed).
- Pin Mermaid CLI in `tools/mermaid/package.json` and its lockfile. Never use an unpinned `npx @mermaid-js/mermaid-cli@latest` in CI.
- CI uses Node.js 22.13+ (the repository currently configures Node 24), installs the exactly version-pinned Mermaid CLI from `tools/mermaid/package.json`, and renders every `.mmd` source into a high-resolution PNG under the matching path in `Tex/diagrams/generated/` before XeLaTeX starts. The direct CLI version is pinned to 12.2.0; a committed npm lockfile remains a reproducibility improvement to add once dependency resolution is available. Until then, npm resolves transitive ranges during the CI install and this limitation must be disclosed.
- The shared render script must be deterministic and recursive, handle spaces safely, fail on invalid Mermaid syntax, and generate a PNG for every source. CI validates PNG integrity, dimensions/resolution, matching LaTeX references, and missing/orphan generated files.
- Use one shared Mermaid visual theme derived from the book colors and typography. Use `accTitle` and `accDescr` in each diagram source; also provide meaningful captions and nearby explanatory prose because the book embeds PNGs.
- Use Mermaid for flowcharts, architecture maps, decision cycles, timelines, state diagrams, and other conceptual illustrations. Do not use TikZ, hand-positioned LaTeX nodes, ASCII-art diagrams, or custom LaTeX diagram libraries for book diagrams.
- LaTeX only places the generated image with `graphicx` through the shared `\BookDiagram` macro. The macro owns consistent width/height constraints, caption and label placement; Mermaid owns node arrangement, routing, spacing, and diagram layout.
- Keep diagram labels concise. If a diagram becomes too dense, split it into multiple focused diagrams rather than shrinking text until it is unreadable.
- Verify the actual CI-generated PNGs and final PDF at printed size. A mocked renderer or placeholder PNG can test the LaTeX integration layer only; it must never be reported as proof that real Mermaid output rendered correctly.
- Generated PNGs are build artifacts (not source of truth). CI uploads the generated PNG directory as a separate review artifact.

## 7. References, glossary, index, and terminology

- Bibliography is managed by `biblatex` and Biber, with footnote-style citations as selected by the author.
- Use `\CoALACite{...}` and `\FanLanCite{...}` for paper citations; do not hard-code one-off citation formats in chapter files.
- Add glossary entries to `Tex/glossary/terms.tex` and index entries consistently. Avoid duplicating terms or changing a term's meaning between chapters.
- Keep terminology stable across chapters. When a concept is revisited, deepen it rather than redefining it differently.

## 8. Quality assurance and release gates

Before delivering a chapter or batch:

1. Check all claims against the relevant primary-paper sections and figures.
2. Check no claims from one paper are attributed to the other.
3. Check the outline was explicitly approved.
4. Check chapter scope and avoid duplication with preceding/following chapters.
5. Compile with XeLaTeX through `latexmk`, using the repository's GitHub Actions TeX Live workflow.
6. Run the repository's scaffold, Mermaid, and PDF quality checks.
7. Inspect the PDF visually after rendering pages to images. Check diagrams at their printed size, box consistency, page breaks, headers, captions, references, footnotes, and overfull boxes.
8. Extract PDF text and verify chapter titles, headings, labels, metadata, and searchability.
9. Report which validation ran locally and which requires a real GitHub Actions execution. Never describe a mocked or substitute-font test as a full production build.
10. Deliver chapter PDFs individually. Include a build note for any known rendering limitation; do not claim accessibility conformance beyond the selected standard PDF target.

## 9. Current project state (2026-11-14)

- Chapters 1 and 2 have been drafted and integrated. Both use the shared semantic teaching-box system and Mermaid-to-PNG figure pipeline.
- Chapters 3 and 4 have now been drafted from their reviewed outlines. The author explicitly requested the additional review pass and drafting of this batch. The chapter drafts are ready for author review.
- Eight Mermaid sources have been added for Chapters 3 and 4. The validator now covers all figures referenced by Chapters 1–4. The CI workflow is the authoritative real-render verification point because the local environment could not resolve the npm registry.
- The latest author-supplied preamble remains the shared design baseline. It has a reusable `\BookDiagram` macro; no chapter-specific drawing package is allowed.
- Chapter 5 — External Actions and Grounding: outline v1.0 explicitly approved on 14 November 2026; chapter drafted and integrated. Source-fidelity review covers CoALA §4.2, Figure 5, and the action-space safety discussion in §6.
- Chapter 6 — Planning: From a Problem to Candidate Actions: outline v1.0 explicitly approved on 14 November 2026; chapter drafted and integrated. Source-fidelity review covers CoALA §4.6, Figure 4B, and the proposal sub-stage.
- Eight Mermaid sources have been added for Chapters 5 and 6. The diagram validator and standalone build script now cover Chapters 1–6 (22 Mermaid sources). The real Mermaid CLI render and final print-size visual verification still require a successful GitHub Actions run because the local npm registry is unreachable.
- Chapters 1–6 each have a standalone LaTeX entry point. The PDF validation script now checks Chapters 1–6.
- Chapters 7–30 remain structural placeholders until their own outlines are reviewed and the author authorizes their prose.
