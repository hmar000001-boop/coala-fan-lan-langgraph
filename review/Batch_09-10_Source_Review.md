# Part II — Batch 1 source and final outline review (Chapters 9–10)

**Project:** From Cognitive Architectures to Production Agentic Systems  
**Primary source:** Fan, H., and Lan, Z. (2026). *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps*. arXiv:2607.23942v1, 27 July 2026.  
**Author approval:** Both outlines approved on 14 November 2026 after final minor-issue review.  
**Draft status:** Chapters 9 and 10 drafted and integrated.

## Primary source consulted

- Original arXiv record: https://arxiv.org/abs/2607.23942
- Original PDF: https://arxiv.org/pdf/2607.23942
- Version reviewed: arXiv:2607.23942v1, submitted 27 July 2026.

The chapter drafts use Fan and Lan as the only formal theoretical foundation for Part II. They do not use Fan and Lan to reinterpret CoALA. No additional theory framework was introduced.

## Chapter 9 — Why Feature-Level Descriptions Are Not Enough

| Chapter subject | Primary support | Source-fidelity rule applied |
|---|---|---|
| Why feature labels hide operational differences | Abstract; §I | Labels are not called false; they are described as too coarse to explain control semantics. |
| Documented mechanism as unit of analysis | §II-A | Retain the paper's definition: consumes explicit state, identifiable trigger, control over transition, may change later behavior. |
| Searchable store versus ACT-R declarative memory | §II-C | Use only the paper's bounded contrast: activation, latency, decay, retrieval competition, utility coupling. Do not generalize about all searchable stores. |
| Evidence relation | §II-D; Table II | Introduce E1–E4 conceptually; detailed coding/preference rules deferred to Chapter 11. |
| Migration depth | §II-D; Table II | Introduce D0–D4 as a separate axis, never as a score combined with E. |
| Node/edge/invariant claim test | §II-E; Figure 1 | Require documented correspondence and a preserved invariant; record missing invariants. |
| Bounded review protocol | §§II-A–II-B | Describe the frozen corpus (10 historical families, 8 runtime families, 42 mechanism-focused modern records) without treating counts as prevalence. |
| Validity limits | §VII-C; §VIII | Preserve no PRISMA completeness, no search-recall/stable hit-count, no causal performance, and no inter-rater reliability claim in the current manuscript. |

### Chapter 9 boundaries

- The full seven-field tuple is introduced in Chapter 10, not taught here.
- Full historical catalog and migration map, including exact E/D coding rules, belong to Chapter 11.
- B1–B6 case studies remain Chapters 12–17.
- No claim of exhaustive review, prevalence, universal migration maximum, or causal benefit is made.
- Illustrative examples are explicitly marked as book-created where applicable.

## Chapter 10 — The Seven Fields of a Mechanism

The chapter preserves the exact tuple and field names from §II-C:

1. S — operative state substrate.
2. C — control locus.
3. T — transition trigger.
4. P — persistence boundary.
5. F — failure semantics.
6. L — learning operator.
7. R — resource or governance policy.

| Chapter subject | Primary support | Source-fidelity rule applied |
|---|---|---|
| Unit of analysis and analytical purpose | §II-A | Context only; no new mechanism definition is added. |
| Exact tuple | §II-C | No field renamed, reordered, merged, or added. |
| Definitions of all seven fields | §II-C | Each field is presented as a question to inspect source documentation, not as a mandatory runtime component. |
| ACT-R worked reading | §III-A; Appendix A, Tables VII–VIII | Field contents use the paper's ledger only: typed buffers/chunks/productions; production matching/conflict resolution; buffer match/module event; chunks and learned utilities persist while buffers are transient; retrieval failure/unavailable buffer/no applicable production; activation/utility updates and procedural learning; buffer capacity/module timing/central production bottleneck. |
| Relationships among fields | §II-C; Appendix A | Figure is explicitly a conceptual relationship map, not an execution sequence. |
| Unknown and undocumented fields | §II-C; §VII-C | Missing evidence is not treated as proof of absence; no values are inferred from a familiar architecture label. |
| Claim packet and E/D axes | §§II-C–II-E | Brief handoff only; detailed coding and precedence rules remain Chapter 11. |

### Chapter 10 boundaries

- The seven-field tuple is Fan and Lan's analytical representation, not a CoALA construct.
- The tuple is not a maturity score, a fixed system architecture, or a mandatory seven-component checklist.
- E1–E4 and D0–D4 are independent axes, not tuple fields.
- The historical catalog and modern mapping are deferred to Chapter 11.
- B1–B6 mechanism studies remain Chapters 12–17.
- Unknown evidence is never completed by intuition.

## Approval and integration record

Both chapter outline PDFs and editable LaTeX sources remain in their own chapter folders. Their status text has been updated to record the author's approval on 14 November 2026. The chapter files now contain prose. Four Mermaid sources per chapter are stored under the corresponding chapter directories. The repository's standalone builder, diagram validator, scaffold checker, and PDF-heading quality check have been extended through Chapter 10.
