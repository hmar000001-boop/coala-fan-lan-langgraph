# Chapter 15 source-fidelity review v2.0

**Chapter:** Persistent Intentions, Reconsideration and Method Authority: B4  
**Primary mechanism source:** Fan and Lan, arXiv:2607.23942v1 (27 July 2026)  
**Review state:** Checked for drafting on 15 November 2026  
**Supersedes:** `Chapter_15_Source_Review_v1.md` as the active drafting review; v1 is preserved as the earlier research checkpoint.

## 1. Primary residual claim and exact anchors

Fan and Lan define B4 as intention persistence, explicit reconsideration, and live method-switch authority. The central statement appears in §VI-C, B4: a persistent intention record stores the committed goal, rationale, plan, continuation condition, reconsideration triggers, authority, and termination status; a governor decides whether to continue, delegate, suspend, abandon, or change method. The stated failure modes are stale commitment, oscillation, premature stopping, and method changes without diagnostic value.

The chapter cites the exact source anchors:

- §II-D for the independent evidence-relation and migration-depth axes.
- §III-C for the historical BDI and MIDCA mechanisms.
- §VI-C, B4 and Table VI for the residual hypothesis, decision set, baselines, and failure modes.
- Appendix C-D / Appendix F R5a–R5c and R6 for the modern mapped cases and their boundaries.
- Appendix D, Table X for the trace, outcomes, safety/efficiency measures, rejection condition, and three ablations.
- §VI-D and Figure 8 for cross-bundle dependencies.

The implementation artifacts in this chapter are deliberately labelled as book-level proposals. Fan and Lan do not provide the Java records, SQL schema, transition implementation, compare-and-swap logic, outbox, authorization contracts, or anti-oscillation algorithm authored here.

## 2. Historical foundations checked

### BDI

Rao and Georgeff (1991) present a formalization of intentions and explicitly position intention alongside belief and desire in the agent's mental state. Rao and Georgeff (1995) provide the practical BDI architecture reference used by the book. The chapter does not attempt a complete survey of intention philosophy.

### Commitment policy versus reconsideration schedule

Kinny and Georgeff (1991), *Commitment and Effectiveness of Situated Agents*, §2.3 and following analysis, distinguish a bold agent that executes its current plan before reconsidering from a cautious agent that reconsiders after each step; they parameterize intermediate values by a maximum number of steps before replanning. Their experiments also discuss event-sensitive reaction strategies. The chapter therefore keeps two questions separate:

1. Blind, single-minded, and open-minded are treated as commitment termination conditions.
2. Bold, cautious, and intermediate are treated as reconsideration schedules/cadences.

Event-sensitive reconsideration is presented as a runtime trigger design, not as a fourth classical termination policy. Neither axis is claimed to be universally optimal.

### MIDCA

Cox et al. (2016) describe the dual-cycle architecture and Note–Assess–Guide procedure. The Note phase detects discrepancies, Assess hypothesizes causes, and Guide performs a suitable response. The chapter distinguishes MIDCA's meta-level control from BDI's commitment structure and does not merge the two into one historical architecture.

## 3. Modern cases and publication-status check

| Case | Source status checked | Bounded claim used in Chapter 15 |
|---|---|---|
| Hybrid BDI–LLM child-helpline training | Published IVA 2025 conference paper | LLM functions are integrated into a rule-based BDI framework; not a general portable B4 lifecycle |
| Self-aware BDI-LLM | University of Utah technical report UUCS-26-001, May 2026; preliminary work | Explicit BDI-oriented deliberation loop; not represented as a peer-reviewed production system |
| Devil's Advocate | Findings of EMNLP 2024 | Anticipatory reflection, post-action alignment/backtracking, and plan review; not a durable intention governor |
| Cognitive Control Architecture | arXiv preprint 2512.06716 in the reviewed corpus | Intent graph and tiered deviation adjudication, primarily security-oriented; not domain-general B4 |
| Goal-drift evaluation | Published AIES 2025 paper | Diagnostic evidence about goal adherence over long interactions, not a controller |
| Premature commitment | arXiv preprint 2606.22936 (22 June 2026) | Hidden-state convergence is a trajectory-consistency diagnostic, not proof of correctness |
| ADAS, AFlow, MetaReflection | Published/preprint states as recorded in the bibliography | Design-time or cross-trial adaptation; not live in-run method authority over an active intention |

The draft does not overstate publication status or convert a preprint/technical report into a production validation claim. AFlow is represented as a workflow-search comparator, not a runtime governor. MetaReflection is treated as cross-trial instruction improvement.

## 4. E/D mapping boundaries

The chapter preserves the B4 mappings from Fan and Lan's reviewed records:

- R5a hybrid and self-aware BDI–LLM: E1/D3.
- R5b Devil's Advocate: E3/D3.
- R5c Cognitive Control Architecture: E2/D3.
- R6 ADAS, AFlow, and MetaReflection: E3/D4 for the mapped design-time/cross-trial method-adaptation edge.

The codes are kept as separate coordinates and are not presented as an overall system ranking. The chapter does not imply that a higher D value resolves the live B4 authority problem.

## 5. Product X assumptions and source boundary

The Product X example is a book-created scenario. It explicitly assumes that the provider offers a stable idempotency key and an authoritative read-only status lookup. The timeout is treated as an unknown outcome, not evidence of payment failure. The example changes the method from submit-and-poll to read-only reconciliation while preserving the goal identity and no-duplicate-charge invariant. Provider-specific behavior must be verified against the actual provider contract in a real implementation.

## 6. Appendix D evaluation fidelity

The draft keeps all required elements:

- Trace: intention record, reconsideration event, diagnosis, method switch, termination.
- Primary outcomes: goal drift, completion, correct stopping.
- Safety/efficiency outcomes: oscillation, replans, escalation precision, cost.
- Three separate ablations: remove the persistent intention state object; remove the authoritative control edge while retaining monitoring/logging; remove the learning update while retaining the runtime transition.
- Rejection: stale commitments or method changes without diagnostic/causal value, along with the source-listed failure conditions.
- Experimental controls: hold base model, prompt, tools, environment, and task budget fixed; preregister the task population, experimental unit, versions, replications, sample size, metric formulas, margins, intervals/tests, exclusions, and stopping rule.

No experimental results are claimed for the book's proposed architecture.

## 7. Cross-bundle boundary

B1 supplies evidence; B2 handles typed recovery substates; B3 provides content admission/broadcast; B4 preserves the parent intention and bounded method authority; B5 supplies reusable skills and verification/fallback; B6 governs broader uncertainty, resources, interruption, tool authorization, and stopping. Chapter 15 does not pre-write B6 or the full cross-bundle composition in Chapter 18.
