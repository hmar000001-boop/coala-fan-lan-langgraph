# Part II — Batch 1 source and outline review (Chapters 9–10)

**Project:** From Cognitive Architectures to Production Agentic Systems  
**Review date:** 14 November 2026  
**Status:** Outline v1.0 prepared; both outlines await author approval. No chapter prose has been drafted.

## Primary source

Fan, H., and Lan, Z. (2026). *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps*. arXiv:2607.23942v1, 27 July 2026.

- Primary HTML manuscript: <https://arxiv.org/html/2607.23942>
- Abstract and version record: <https://arxiv.org/abs/2607.23942>

## Chapter 9 — Why Feature-Level Descriptions Are Not Enough

### Source map

| Outline subject | Primary support | Use in the chapter |
|---|---|---|
| Why feature labels conceal control semantics | Abstract; §I | Establish the problem and motivate mechanism-level comparison. |
| Unit of analysis: documented mechanism | §II-A | Explain the paper's definition: an operation consumes explicit state, is activated by an identifiable trigger, exercises control over a transition, and may change later behavior. |
| Review corpus and bounded scope | §§II-A–II-B | Give corpus strata and scope limits at a high level; defer detailed catalog to Chapter 11. |
| Searchable store vs ACT-R declarative memory | §II-C | Use the paper's own example to show that shared purpose does not establish equivalent mechanisms. |
| Evidence relation and migration depth are independent | §II-D, Table II | Introduce the conceptual distinction only; detailed codes and rules belong to Chapter 11. |
| Node/edge/invariant claim test | §II-E, Figure 1 | Explain why shared terms, visual similarity, or similar outputs alone are insufficient. |
| Historical operational chain | Opening of §III, Table III | Introduce state → trigger → control action → transition → learning consequence without cataloging all architectures. |
| Validity boundaries | §VII-C | Preserve limitations: bounded corpus; no PRISMA completeness, no prevalence inference, no causal performance claim, no independent inter-rater reliability claim in the current manuscript. |

### Boundaries enforced

- The chapter does not use Fan & Lan to reinterpret CoALA.
- It does not teach the seven fields in detail; Chapter 10 owns that.
- It does not fully describe the ten historical architectures or modern runtime families; Chapter 11 owns the catalog and mapping.
- It does not analyze B1–B6; Chapters 12–17 own those cases.
- It introduces E1–E4 and D0–D4 conceptually but does not teach the detailed coding rules or collapse the axes into a score.

### Planned Mermaid figure sources for the eventual chapter

1. `Tex/diagrams/source/part2/chapter09/feature-labels-to-mechanisms.mmd`
2. `Tex/diagrams/source/part2/chapter09/minimum-mechanism-chain.mmd`
3. `Tex/diagrams/source/part2/chapter09/evidence-and-depth-are-independent.mmd`
4. `Tex/diagrams/source/part2/chapter09/mechanism-evidence-admission.mmd`

These are figure plans only; no chapter Mermaid sources or prose have been created at this outline stage.

## Chapter 10 — The Seven Fields of a Mechanism

### Source map

| Outline subject | Primary support | Use in the chapter |
|---|---|---|
| Mechanism unit and analytical purpose | §II-A | Context for why a structured representation is needed. |
| Exact seven-field tuple | §II-C | Use the paper's exact tuple: K = ⟨S,C,T,P,F,L,R⟩. Do not rename, reorder, merge, or add fields. |
| State substrate (S), control locus (C), transition trigger (T), persistence boundary (P) | §II-C; Appendix A, Table VII | Explain each field and use the historical ledger examples precisely. |
| Failure semantics (F), learning operator (L), resource/governance policy (R) | §II-C; Appendix A, Table VIII | Explain each field and its operational distinction from logging, storage, or generic policy. |
| ACT-R worked seven-field record | §III-A; Appendix A, Tables VII–VIII | Use only the field contents recorded by the paper; do not fill gaps from external ACT-R sources. |
| Claim packet and evidence/depth separation | §§II-D–II-E | Briefly show how field extraction precedes comparison; defer detailed E/D coding to Chapter 11. |
| Validity of field coding | §VII-C | Explain that the representation makes judgments inspectable but does not eliminate interpretive uncertainty or establish inter-rater reliability. |

### Exact seven fields

1. **S — Operative state substrate**
2. **C — Control locus**
3. **T — Transition trigger**
4. **P — Persistence boundary**
5. **F — Failure semantics**
6. **L — Learning operator**
7. **R — Resource or governance policy**

The outline treats these as analytical questions, not mandatory software components or a maturity score. It preserves unknown or undocumented fields rather than filling them by inference.

### Boundaries enforced

- The seven-field tuple is not a CoALA construct and is not attributed to CoALA.
- E1–E4 and D0–D4 are independent axes, not tuple fields and not a combined score.
- The full historical architecture catalog, modern runtime mapping, and exact E/D code definitions are deferred to Chapter 11.
- The chapter does not begin the B1–B6 case studies.
- The ACT-R example is limited to Fan & Lan's own summary in §III-A and Appendix A; it is not a comprehensive ACT-R account.

### Planned Mermaid figure sources for the eventual chapter

1. `Tex/diagrams/source/part2/chapter10/seven-field-mechanism-tuple.mmd`
2. `Tex/diagrams/source/part2/chapter10/actr-seven-field-reading.mmd`
3. `Tex/diagrams/source/part2/chapter10/field-relationships.mmd`
4. `Tex/diagrams/source/part2/chapter10/fields-to-claim-packet.mmd`

These are figure plans only; the actual sources will be created when the chapter outline is approved and the chapter is drafted.

## Outline and build review

- Both outlines use `Tex/preamble.tex` and `Tex/shared-macros.tex`.
- The original author preamble remains unchanged in the repository.
- Local PDF previews used temporary Nimbus font substitutes because TeX Gyre OpenType faces are unavailable in this runner. The PDF files are review-layout outputs, not final print PDFs.
- Chapter 9 outline PDF: 13 pages, US 7 × 10 inch page size.
- Chapter 10 outline PDF: 15 pages, US 7 × 10 inch page size.
- Both PDFs were rendered to PNG and visually inspected at contact-sheet level.
- `scripts/build-outlines.sh` now covers Chapter 3–10 chapter-local outline sources.
- `scripts/check-scaffold.sh` verifies that Chapter 9 and 10 outline PDF/source pairs exist and that both chapter body files remain placeholders while the outlines await approval.

## Approval state

Chapter 9: **Awaiting author approval**.  
Chapter 10: **Awaiting author approval**.  
Drafting is blocked until each outline is explicitly approved.
