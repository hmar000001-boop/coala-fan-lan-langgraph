# Chapter 14 — B3 source-fidelity review (outline v1.0)

**Status:** Prepared for individual author review. No Chapter 14 prose has been drafted.

## Primary source and scope

The governing source is Fan and Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps*, arXiv:2607.23942v1 (27 July 2026). The review is the Part II analytical backbone. The chapter is limited to the B3 residual bundle: **outcome-dependent admission over typed coalitions inside a bounded broadcast cycle**.

## Source trace map

| Chapter coverage | Fan & Lan location | Fidelity note |
|---|---|---|
| LIDA codelets, coalitions, bounded workspace, winner broadcast to memory/action selection/learning | §III-B; Appendix A Table VIII; reference [11] | Preserve the historical codelet-coalition candidate type; do not silently rename it as modern content coalition. |
| Hearsay-II blackboard and agenda scheduling | §III-B; Appendix A Table VIII; reference [12] | Treat as a neighboring shared partial-solution/control mechanism, not as a synonym for LIDA broadcast. |
| GWA limited working state, attention selection, broadcast and proposal write-back | §IV-B; §V-D; Appendix C-E | The source explicitly identifies missing outcome-trained content admission. |
| DyLAN and adaptive graph pruning | §IV-B; §V-B; §V-D; Appendix C-F | Their learned candidates are agent teams/agents or communication edges, not typed content coalitions. |
| Candidate-type/broadcast semantic shift | §V-B | This distinction is a central teaching point, not a terminology preference. |
| Residual B3 and separation from B1 | §VI-B and §VI-C | B3 candidates include memory, agents, tools, monitors and plans; do not reduce B3 to memory ranking. |
| Insertion point, baselines and falsifier | §VI-C and Table VI | Pre-inference admission; compare with GWA and top-k; reject if outcome-trained content admission adds no value or suppresses decisive evidence. |
| Cross-bundle dependencies | §VI-D and Figure 8 | B1 and migrated skills supply candidates; B6 governs resources/risk; B3 evidence may trigger B4 reconsideration. |
| No current validation against D3/D4 baselines | §VII-C | No claim that the B3 hypothesis is experimentally established. |
| Required state trace, outcomes, cost/safety metrics and three ablations | Appendix D, Table X | Candidate type, score, winner, broadcast recipients and admission update; relevant-evidence density and distractor robustness; context cost, rare-evidence suppression and turnover; remove state object, authoritative edge, learning update. |
| E/D case classifications | §V-D; Appendices C-E and C-F | GWA E2/D3; DyLAN and graph pruning E3/D4. Evidence relation and migration depth remain separate axes. |

## Historical source check

Franklin, Strain, Snaider, McCall and Faghihi (2012), *Global Workspace Theory, Its LIDA Model and the Underlying Neuroscience*, is included narrowly as a historical cross-check because Fan and Lan cite it as reference [11]. It is not introduced as another overarching theory foundation.

## Modern works

The outline includes only modern works already named in Fan and Lan's frozen corpus for this B3 comparison:

- Global Workspace Agents / Shang, *Theater of Mind for LLMs: A Cognitive Architecture Based on Global Workspace Theory* (arXiv 2604.08206).
- Liu et al., DyLAN, *A Dynamic LLM-Powered Agent Network for Task-Oriented Agent Collaboration* (arXiv 2310.02170; COLM 2024 as identified in the source record).
- Li et al., *Adaptive Graph Pruning for Multi-Agent Communication* (arXiv 2506.02951; ECAI 2025 as identified in the source record).

No feature, score, or experimental result beyond what Fan and Lan report is attributed to these systems in the outline. Their primary papers are cited in the bibliography for traceability.

## Theory-to-implementation bridge assessment

A substantial bridge is necessary. Fan and Lan specify a residual control coupling and experimental intervention, not a production data model or full executable admission algorithm. The outline therefore proposes, as explicitly labelled book-level engineering work:

1. typed candidate, coalition, workspace lease, broadcast snapshot, consumer receipt, outcome-attribution and policy-version records;
2. producer/normalizer, coalition builder, admission governor, bounded workspace, broadcast router, consumers, attribution service and policy learner;
3. a state machine covering collection, validation, coalition formation, competition, admission/rejection, broadcast, processing, outcome recording, policy update and expiry;
4. authority separation between admitting tool-related evidence and authorizing tool execution;
5. concurrency, expiry, versioning, bounded retention, provenance, privacy and rare-evidence protection;
6. a worked Product X scenario, implementation sequence, failure cases and executable tests;
7. the Appendix D experiment protocol, baselines, measurements, ablations and falsification conditions.

These are not claims that Fan and Lan, LIDA, GWA, DyLAN or adaptive graph pruning already implement the proposed reference architecture. No universal B3 scoring equation is attributed to the source.

## Claims explicitly excluded

The outline does not claim that a message bus is a workspace; that top-k retrieval equals coalition competition; that selecting agents/edges selects content; that broadcast proves downstream use or helpfulness; that tool-candidate admission grants execution authority; or that B3 has been experimentally validated. It does not combine E/D into one quality score.

## Review outcome

Source scope and the implementation-bridge requirement are sufficiently explicit for an author outline review. Prose drafting remains blocked pending approval of `Tex/part2/chapter14/outline/Chapter_14_Outline_v1.md`.
