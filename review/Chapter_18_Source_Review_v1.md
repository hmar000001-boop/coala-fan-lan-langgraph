# Chapter 18 — Source-fidelity review

**Chapter:** How the Mechanisms Work Together  
**Primary theoretical source:** Fan and Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps*, arXiv:2607.23942v1, 27 July 2026.  
**Review date:** 15 November 2026  
**Scope:** Approved final synthesis chapter of Part II.

## Primary source anchors checked

- **§ II-C–II-D:** Seven-field mechanism representation and independent evidence-relation (E1–E4) and migration-depth (D0–D4) axes. The chapter does not turn E/D into one score or assign an aggregate code to the composite runtime.
- **§ II-E and § VII-C:** The review is bounded; E/D codes are provisional; the manuscript does not claim independent inter-rater reliability, systematic-search recall, or causal benefit for the complete composition.
- **§ VI-A:** The exact shared runtime state tuple is preserved as `x_t = <i_t,w_t,m_t,s_t,u_t,b_t,q_t>`, with the correct meanings. The proposal, external governor decision, runtime transition, and outcome-dependent learning update remain distinct.
- **§ VI-B and Table V:** The six initial candidates are narrowed to five residual bundles after B5 is closed. GraSP is treated as the closed B5 case and an existing skill-governance dependency, not a sixth residual.
- **§ VI-C and Table VI:** Each bundle's insertion point, control law, baseline, and falsifier are recapped without turning the summary into a replacement for Chapters 12–17.
- **§ VI-D and Figure 8:** All five dependencies are preserved: B4 scopes B2; B2 may supply verified resolutions to a GraSP-like governor; B1 and migrated skills supply candidates to B3; workspace evidence can trigger B4 reconsideration; B6 governs risk/resources across the controls.
- **§ VI-D:** The implementation order is separated from the runtime dependency graph. The order externalizes authoritative state first, then typed failure and bounded content admission, then adaptive memory and compiled-skill policies after outcome attribution.
- **§ VI-E and Figure 9:** The language model retains proposal/interpretation authority; durable state remains outside a model call; workspace admission bounds inference context; the scheduler governs external actions; typed failure creates recovery state; and attributable outcomes can update later policies.
- **Appendix D and Table X:** Matched conditions, preregistration, internal traces, non-inferiority definition for simpler baselines, and the three minimum ablation types are preserved. The dependency experiments in Chapter 18 are explicitly book-level proposals, not experiments reported by the paper.
- **Appendix F:** The bounded evidence ledger is treated as the source's corpus rather than a universal survey or prevalence estimate.

## Boundary checks against prior chapters

- Chapter 12 remains the detailed treatment of B1; Chapter 18 preserves the distinction between memory accessibility and B3 workspace admission.
- Chapter 13 remains the detailed treatment of B2; Chapter 18 preserves the parent/recovery boundary and distinguishes recovery resolution from skill promotion.
- Chapter 14 remains the detailed treatment of B3; broadcast is not treated as tool or skill permission.
- Chapter 15 remains the detailed treatment of B4; B4 owns the goal/method boundary but cannot override B6 action permissions.
- Chapter 16 remains the detailed treatment of B6; component-local capacity/attempt/repair limits are distinguished from the runtime-wide resource ledger.
- Chapter 17 remains the detailed treatment of GraSP/B5; B5 is not reopened, and the chapter separates Fan and Lan's closure, GraSP's own results, and the book's proposed composition.

## Engineering-proposal boundary

The four-plane teaching view, Java-like records and interfaces, event names, coordinator, versioned persistence, transaction/outbox strategy, Product X trace, and compositional test matrix are explicitly described as book-level engineering proposals. They are not attributed to Fan and Lan or to the GraSP implementation.

## Result

No source-fidelity blocker was found. The manuscript retains all source-defined boundaries and labels the additional implementation work as proposal or experiment. The composition remains unvalidated; the chapter does not claim a system-level E/D rating or universal transfer.
