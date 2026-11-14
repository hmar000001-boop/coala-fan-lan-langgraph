# Chapter 11 — Source and outline review

**Title:** From Historical Cognitive Architectures to Modern Agents  
**Primary source:** Fan, H., and Lan, Z. (2026), *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps*, arXiv:2607.23942v1.  
**Source reviewed:** arXiv HTML and the project's source-grounded study notes.  
**Corpus date:** 26 July 2026, as stated in Fan & Lan §II-A.

## Section map

- §I and §II-A–B: motivation, bounded review protocol, three corpus strata, frozen corpus, bridge records.
- §II-C: seven-field mechanism representation (introduced in Chapter 10; reused only as a common analysis frame).
- §II-D–E: E1–E4 evidence relations, D0–D4 migration depth, precedence, claim-adjudication test and limitations.
- §III-A–D, Figures 2–4, Table III and Appendix A: ten historical architecture families and their distinctive mechanisms.
- §IV-A–C, Figure 5 and Appendix E-A: eight general runtime families, supporting cases, and implementation-status distinctions.
- §IV-B, Table IV and Appendix F-B/Table XIII: 42 mechanism-focused modern records and their role in mapping.
- §V, Figure 6 and Table IV: migration-depth ledger and residual breakpoints; B1–B6 are previewed only.
- §VII-C, Appendix E and Appendix F: bounded evidence and validity limitations.

## Corpus counts and role boundaries

The outline preserves the paper's categories: ten historical architectures (Corpus H), eight general runtime families (Corpus M-A), and 42 mechanism-focused modern records (Corpus M-B). Explicit bridges (Corpus B) are recorded separately. These analytical roles are not mutually exclusive: AIOS is cross-indexed as a general runtime and resource mechanism case; hybrid BDI–LLM is both an explicit bridge and a mechanism-focused record. Magentic-One and Agent Spec are supporting cases, not additions to the eight general runtime families.

The outline includes all ten historical families: ACT-R, Soar, CLARION, LIDA, Hearsay-II/blackboard, BDI, MIDCA, ICARUS, EPIC, and Sigma.

The eight general runtime families are: Letta/MemGPT, LangGraph, AutoGen, AgentScope, OpenHands, Microsoft Agent Framework, OpenAI Agents SDK, and AIOS.

The 42 mechanism-focused records are grouped as in the paper into adaptive memory; failure/execution recovery; competition/workspace; BDI/commitment; meta-level adaptation; skill induction/composition/governance; resource governance; and uncertainty-conditioned control. The chapter gives the categories and representative cases without claiming every record is a mature runtime.

## Core accuracy rules

1. E-codes classify the evidence relation for a specific correspondence; they are not a maturity scale. Each correspondence gets one E-code.
2. D-codes classify the implementation depth of the specific mapped mechanism, never an entire architecture or framework.
3. E and D are independent. An E1 claim can be shallow; a D4 implementation can converge independently.
4. D4 means an outcome-dependent update to future invocation, selection, or control policy. Logging or storing text is insufficient.
5. A correspondence requires node/state evidence, edge/control evidence, and at least one preserved invariant. Missing invariants must be explicit.
6. The paper's reported depth is the highest-depth instance admitted by its bounded screening process, not prevalence or a universal maximum.
7. The paper discloses single-coder provisional coding, no independent second-author recoding, no frozen search-recall estimate, no PRISMA completeness claim, and no experiments validating the five residual bundles.
8. Chapter 11 will not teach B1/B2/B3/B4/B5/B6 in detail; it maps the landscape and hands the reader to Chapters 12–17.

## Planned figures

1. Corpus strata and bridge records (including overlap/cross-index notes).
2. Ten historical architecture families grouped by distinctive control problem.
3. Eight general runtime families and their documented control surfaces.
4. E1–E4 evidence relations as categories, not a ladder.
5. D0–D4 migration depth as mechanism-specific thresholds.
6. Evidence packet and independent E/D classification.

All figures will be authored as Mermaid `.mmd` sources in `Tex/diagrams/source/part2/chapter11/`, rendered by CI to PNG, and embedded using `\BookDiagram`.

## Status

Outline v1.0 was approved by the author on 14 November 2026. Chapter 11 prose is now drafted in `Tex/part2/chapter11/chapter.tex`; the source and drafting review records the chapter-level accuracy checks and remaining render gate.
