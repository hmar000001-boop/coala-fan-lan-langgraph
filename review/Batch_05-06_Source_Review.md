# Batch 05–06 Source Review

**Book:** *From Cognitive Architectures to Production Agentic Systems*  
**Batch:** Chapter 5 — External Actions and Grounding; Chapter 6 — Planning: From a Problem to Candidate Actions  
**Review date:** 14 November 2026  
**Status:** Both outlines explicitly approved by the author on 14 November 2026; chapter drafts now integrated.

## Primary source reviewed

Sumers, Theodore R., Shunyu Yao, Karthik R. Narasimhan, and Thomas L. Griffiths. “Cognitive Architectures for Language Agents.” *Transactions on Machine Learning Research* (2024). Published version and original arXiv manuscript 2309.02427.

- Published paper PDF: https://openreview.net/pdf/07475727a2787df12052196b9f2624497ef3c3bd.pdf
- Original arXiv record: https://arxiv.org/abs/2309.02427

The published paper was reviewed around §4.2 (printed p. 10), §4.6 (printed pp. 12–13), Figure 4B, Figure 5, Table 2, and the Section 6 discussion of action-space safety. The arXiv/TMLR source is the only theoretical foundation for these Part I outlines. Fan & Lan is not used to interpret or extend CoALA.

## Chapter 5 — source map

| Outline topic | Primary support | Fidelity constraint |
|---|---|---|
| Grounding definition | CoALA §4.2 | Grounding procedures execute external actions and process environmental feedback into working memory as text. Do not invent one mandatory transport or serialization protocol. |
| Physical environments | CoALA §4.2 | Cover perceptual inputs (visual, audio, tactile), textual observations/captioning, and language-based robotic actions at the framework level only. |
| Dialogue environments | CoALA §4.2 | Cover instructions, learning from people, requests for help/clarification, and interaction with other agents as external dialogue. |
| Digital environments | CoALA §4.2 | Cover games, APIs, websites, and code execution. Preserve the paper's specific statement that stateless APIs are special “single-use” digital environments; do not call all digital environments stateless. |
| Common observation representation | CoALA §§4 and 4.2 | Explain the text-oriented abstraction while acknowledging other modalities and vision-language models. Do not claim all inputs pass through an identical conversion algorithm. |
| Action-space safety | CoALA §6 | Mention only the paper's concern and examples. Do not attribute a complete production authorization or policy system to CoALA. |

## Chapter 6 — source map

| Outline topic | Primary support | Fidelity constraint |
|---|---|---|
| Planning's position in the decision cycle | CoALA §4.6 and Figure 4B | Use the cycle as context. Do not teach the full decision process in this chapter. |
| Proposal | CoALA §4.6, “Proposal” | The proposal sub-stage generates one or more action candidates. The paper's usual description uses reasoning and optionally retrieval to sample one or more external grounding actions from the LLM. |
| Limited action sets | CoALA §4.6 and §5 SayCan case study | For simple domains with limited actions, the proposal stage may simply include all actions. Mention SayCan only as the paper's example, not as a separate theory. |
| Program structures | CoALA §4.6 | The paper mentions `if-else` and `while-if` code structures as ways more sophisticated agents may propose actions. Do not prescribe a universal structure. |
| Structured simulators | CoALA §4.6 | The paper says well-defined domains may use structured simulators to generate plausible rollouts. Do not expand this into a general planning-language or search tutorial. |
| Boundaries with evaluation and selection | CoALA §4.6 | Candidate generation is not evaluation, selection, or execution. Details and rejection behavior belong to Chapter 7. |
| Boundaries with interleaving and iteration | CoALA §4.6 | Acknowledge that planning sub-stages may interleave or iterate, but leave the explanation to Chapter 8. |

## Cross-chapter boundary review

- Chapter 2 supplies the full architecture map; neither outline repeats it as a new chapter topic.
- Chapter 3 supplies the memory taxonomy; Chapter 5 only recalls working memory to explain where grounding feedback is represented.
- Chapter 4 supplies retrieval and reasoning; Chapter 6 uses them as supporting operations without re-teaching their full mechanics.
- Chapter 5 explains grounding and external environments; Chapter 6 may name grounding actions as candidate types but does not repeat the environment taxonomy.
- Chapter 7 remains responsible for evaluation and selection. Chapter 8 remains responsible for interleaving, iteration, and the complete decision process.
- Product X is always a book-created illustration, never a claim or example attributed to the CoALA authors unless explicitly identified as such.

## Figure plan

All proposed diagrams will be authored as `.mmd` files under `Tex/diagrams/source/part1/chapter05/` or `Tex/diagrams/source/part1/chapter06/`. CI will render them to PNG using the shared Mermaid CLI and configuration before XeLaTeX. Figures will be placed with the shared `\BookDiagram` macro. No TikZ, ASCII diagrams, custom LaTeX drawing, or manually positioned diagram nodes are planned.

## Review outcome

Both outline PDFs compile at 7 × 10 inches and have been visually inspected as outline documents. The local preview environment does not have the specified TeX Gyre OpenType faces installed, so the preview build used temporary Liberation font substitutions in a disposable build copy. The repository's actual `Tex/preamble.tex` was not changed. A full-font build remains available through the repository's TeX Live GitHub Actions workflow.

**Approval record:** The author approved both outlines on 14 November 2026. Chapter prose was then written and integrated under the scope and source constraints recorded above.
