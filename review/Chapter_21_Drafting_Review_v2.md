# Chapter 21 drafting review — v2 (accepted frozen application baseline)

**Date:** 25 November 2026  
**Status:** Final source reconciliation complete; standalone proof rebuilt and visually inspected.  
**Chapter:** `Tex/part3/chapter21/chapter.tex`  
**Approved outline:** `Tex/part3/chapter21/outline/Chapter_21_Outline.md`  
**Application baseline:** supplied `supply-chain-agent-main (9).zip` plus the accepted B1 utility-scale patch (author-confirmed green CI).

## Outline adherence and chapter shape

The chapter retains the approved implementation-led progression:

1. Two different selection problems after M2 retrieval.
2. The exact runtime handoff from M2 retrieval through B1 candidate construction, feature enrichment, selection, evidence persistence, reference projection and access-history recording.
3. The implemented B1 score: accessibility, cognitive latency, infrastructure latency, provider-supplied task-scale utility, maintenance estimate and bounded optional outcome adjustment.
4. Projection of selected long-term memory references into working memory without moving authoritative source records.
5. The separation of selection access, verified downstream use, normalized outcome bookkeeping and maintenance-event accounting.
6. A separately prepared B3 candidate set and explicit optional B1 attribution.
7. Mandatory-content protection, singleton/coalition competition, the configured complete-combination evaluation budget and incomplete-admission behavior.
8. Synchronous consumer broadcast, receipt identity/consumption evidence and separately verified downstream outcomes.
9. The durable-host persistence split and the limitations of the current integration-test evidence.
10. The S/C/T/P/L/R analytical reading, deterministic fixture interpretation, recap, questions and practical exercise.

Six accessible Mermaid diagrams and focused Java listings remain. Listings are selective; they expose the call sequence and decision contracts without reproducing whole source files.

## Accepted B1 correction reflected accurately

- The accepted two-file application patch preserves provider-supplied `B1MemoryCandidate.expectedDownstreamUtility` when the learning service enriches access/verified-use history and cue associations.
- The persisted `B1MemoryFeatureState.expectedDownstreamUtility` component remains a legacy-named normalized [0,1] outcome statistic. The first verified outcome maps USEFUL/HARMFUL/NEUTRAL to 1.0/0.0/0.5; later updates use `0.8 × old + 0.2 × reward`.
- The chapter does not conflate those scales or claim that the normalized statistic is a calibrated task-scale utility learner. It also does not claim selector-weight adaptation.
- The archived M8-B3 fixture results predate the accepted correction; their B1 results are explicitly historical and are not presented as evaluation of the accepted patch.

## Rejected application proposals not represented as implementation

- No maintenance-profile redesign was accepted. Chapter 21 reports the existing five-field `MaintenanceProfile` and exact `estimateCost(evaluatedAt, horizon)` calculation. It flags that the source does not disambiguate whether `admissionValidationCost` is recurring selection-time work or a historical sunk cost. It does not claim marginal/amortized accounting is implemented.
- No B3 search-expansion/input-candidate cap was accepted. Chapter 21 reports the actual standard policy (maximum coalition size 3; 512 evaluated complete combinations per workspace admission), when the counter increments, which earlier-pruned partial branches are not counted, and the absence of an independent input-candidate cap or hard total-CPU bound.
- Test references from the rejected B3 proposal were removed. The current outline's 49 unique test names resolve to exact methods in the accepted source tree.

## Cross-chapter consistency

- Chapter 19 remains responsible for domain facts, simulator transitions, action authorization/dispatch and the module map.
- Chapter 20 remains unchanged and covers CoALA memory, typed actions, planning and M2 retrieval. It already states that M2 does not perform B1 scoring or B3 admission.
- Part II Chapters 12, 14 and 18 remain unchanged. Chapter 21 distinguishes their theory/design account from the actual Java implementation.
- Chapter 21 introduces no B2 recovery mechanics, B4 intention authority, or full LangGraph4j composition; those remain reserved for Chapters 22–24.

## Claims and limits

- A receipt is not a positive outcome; only separately verified evidence tied to an accepted receipt and exact consumed candidate can enter the described learning path.
- Workspace snapshot persistence remains in memory in the durable host; receipts/outcomes and B1 feature state use PostgreSQL adapters.
- The focused B1 feature-state PostgreSQL round-trip test remains absent.
- Deterministic M8-B3 results are fixture-level descriptive evidence, not population benchmarks or causal/production claims.

## Final review outcome

Chapter 21 is aligned to the accepted frozen application baseline. Chapter 20 and the neighboring chapters require no source-fidelity edits for this B1 patch. Future project work is confined to the LaTeX book; the application remains frozen.
