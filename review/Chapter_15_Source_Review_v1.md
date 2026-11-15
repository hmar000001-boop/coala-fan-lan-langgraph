# Chapter 15 B4 source-fidelity review v1

**Status:** Source review supporting proposed outline v1.0; prose not yet authorized.

## Primary Fan & Lan record

The outline is anchored in Fan and Lan (2026), B4 intention-reconsideration-method-authority, including the historical BDI/MIDCA reconstruction, the residual intervention agenda, Table VI, Figure 8, Appendix D, and the R5a-R5c/R6 case records.

The source's B4 statement is retained: an intention record stores committed goal, rationale, plan, continuation condition, reconsideration triggers, authority, and termination status; a governor chooses whether to continue, delegate, suspend, abandon, or change method. Named failure conditions include stale commitment, oscillation, premature stopping, and method changes without diagnostic value.

The outline does not claim that Fan and Lan provide a complete production schema or a validated B4 implementation.

## Historical BDI

- Rao and Georgeff (1991): formal treatment of intention as an element of agent mental state, on equal status with beliefs and desires.
- Rao and Georgeff (1995): practical BDI architecture and commitment termination conditions.
- Kinny and Georgeff (1991): empirical comparison of bold and cautious reconsideration schedules, intermediate commitment lengths, planning cost, and event-sensitive reactions to world changes.

Critical distinction preserved: blind, single-minded, and open-minded describe commitment termination conditions; bold and cautious describe reconsideration frequency/scheduling. The outline explicitly teaches these as separate axes.

## Historical MIDCA

Cox et al. (2016) is used to explain dual cognitive/meta cycles and note-assess-guide: detect a discrepancy, assess its cause, and guide a response. The outline does not collapse MIDCA into BDI. BDI provides the commitment foundation; MIDCA provides the historical meta-control analogy for live method adaptation.

## Modern cases and Fan & Lan classifications

| Case | Fan & Lan label | What is preserved | Boundary retained |
|---|---|---|---|
| Hybrid and self-aware BDI-LLM | E1/D3 (R5a) | Explicit structured commitment and BDI control | No portable cross-domain reconsideration lifecycle |
| Devil's Advocate | E3/D3 (R5b) | Reflection-triggered alignment, backtracking, and plan revision | No durable authoritative intention with full lifecycle actions |
| Cognitive Control Architecture | E2/D3 (R5c) | Intent-graph and deviation-triggered adjudication | Security-specific; not a general commitment lifecycle |
| ADAS, AFlow, MetaReflection | E3/D4 (R6) | Method/workflow improvement at design time or across trials | Not live in-run authority over a persistent intention |

Goal-drift and premature-commitment work are treated as diagnostic evidence, not as completed intention governors. The outline preserves the limit that trajectory stability or hidden-state convergence is not proof of correctness.

## Implementation bridge audit

A substantial bridge is justified. The outline labels the architecture, schema, state machine, authority matrix, concurrency model, idempotency, delegation contract, method-switch transaction, anti-oscillation measures, Java-like contracts, implementation sequence, and tests as book-level engineering proposals. No unsupported claim attributes those details to BDI, MIDCA, or Fan and Lan.

## Scope boundaries

- B1 can provide evidence but does not own intention termination.
- B2 owns isolated typed recovery; B4 retains the parent goal and decides whether its method continues.
- B3 may surface/broadcast signals; B4 owns the commitment decision.
- B5 may supply an approved skill or fallback method; B4 governs its use under the goal.
- B6 owns uncertainty/resource governance, interruption, tool authorization, and stopping; Chapter 15 previews but does not teach B6.

## Open drafting checks

1. Verify the exact current publication status of the 2026 self-aware BDI technical report, CCA preprint, and premature-commitment preprint at the time of chapter drafting.
2. Recheck all detailed claims against the original modern papers before prose drafting.
3. Preserve the B4 Appendix D trace and three ablations exactly.
4. Ensure no modern system is represented as implementing the complete B4 bundle unless Fan and Lan explicitly make that claim.
