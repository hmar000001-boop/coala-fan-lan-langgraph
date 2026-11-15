# Chapter 13 (B2) — Source Review v1

**Purpose:** Source-fidelity record supporting the proposed outline.  
**Status:** Completed for outline preparation; not a prose-draft approval.  
**Primary paper:** Fan & Lan (2026), arXiv:2607.23942v1.

## 1. Primary-source map

| Planned claim | Exact location in Fan & Lan | Treatment in outline |
|---|---|---|
| Soar's working-memory/operator/preference decision and typed impasse | §III-A, “Soar”; Figure 2(b); Table VIII; Appendix A | Historical mechanism, taught before B2 translation. |
| Typed failure → scoped recovery → reusable control knowledge | §III-A, Soar | Main teaching chain. |
| Soar-to-modern control mapping | §V-A, “Soar to typed recovery and experience learning”; Table IV | Separate modern edges from the integrated historical chain. |
| Modern systems cover separate parts | §V-A; §V-B, “Failure changes from a control state to recovery content” | Diagnosis, recovery, reversible branching and cross-episode learning are not collapsed. |
| B2's four residual invariants | §VI-B, Table V, B2 row | Typed diagnosis, protected substate, typed return and resolution compilation. |
| B2's proposed runtime sequence | §VI-C, B2 | Execution ledger, parent-state freeze, bounded recovery subgraph, typed resolution and reusable rule. |
| B2's failure conditions | §VI-C, B2; Table VI, B2 row | Misdiagnosis, unsafe compilation, parent-state corruption and no reduction in repeated failure. |
| Modern runtime insertion boundaries | §VI-C, B2 | LangGraph, OpenHands, Magentic-One and Shepherd are boundaries, not complete B2 implementations. |
| Specific modern mechanism baselines | §V-A; Appendix C-B, C-C, C-D; Appendix F-B/Table XIII | PALADIN, AgentDebugX, Shepherd, AgentHER and Reflexion are described only as the review reports. |
| Checkpoint is not typed impasse | Appendix E-B, “Checkpoint versus typed impasse” | Explicit warning: checkpoint/persistence at D2 is not a Soar-related D3 transition without typed trigger, bounded child state and controlled return. |
| B2 vs. B5 | §VI-B, Table V | Kept separate because B2 is an in-episode recovery transition while B5 concerns general skill invocation across episodes/tasks. |
| B2 dependencies | §VI-D, Figure 8 | B4 scopes recovery; B6 governs risk/resources; B2 may produce verified resolutions for a GraSP-like governor. |
| Evaluation traces and outcomes | Appendix D, Table X, B2 row | Failure type, parent hash, substate trace, returned resolution and compiled rule; recovery by type, repeated failure, transfer; diagnosis latency, state corruption, unsafe reuse. |
| Required ablations and preregistration | Appendix D, general protocol | Remove state object; remove authoritative control edge but keep logging; remove learning update while keeping runtime transition. Hold model/prompt/tools/environment/task budget fixed. |
| Research status/limitations | §VII-C; Appendix F-C | B2 remains a proposed/falsifiable residual hypothesis; no completed experiment validates the five bundles. |

## 2. Soar mechanism cross-check

Fan & Lan cite the Soar Architecture documentation as a historical source. The outline uses that source only to verify details of the mechanism already present in Fan & Lan's historical reconstruction:

- Soar identifies tie, conflict, constraint-failure and no-change impasses; no-change is described as state no-change or operator no-change.
- An impasse can create a child state/subgoal that contains information about the cause and a link to its superstate.
- Results are working-memory elements or preferences created in a substate and linked to a superstate; these can remain when the substate is removed.
- A resolved operator impasse enables learning through chunking; the chunk's conditions summarize necessary higher-state dependencies and its action is the result that resolved the impasse. Conditions/actions are variablized to match future similar states.
- A substate can be eliminated when its problem becomes irrelevant, and it can be regenerated when higher-level dependencies change. Those are not equivalent to a successfully resolved impasse and should not be described as the same learning event.
- The Goal Dependency Set records relevant superstate working-memory dependencies for subgoal results and supports regeneration when those dependencies change.

Cross-check: Soar Research Group, *The Soar Architecture*, University of Michigan documentation, sections “Impasse Types,” “Creating New States,” “Results,” “Chunking: Learning Procedural Knowledge,” “Removing Substates: Impasse Resolution,” and “Goal Dependency Set.” URL: https://soar.eecs.umich.edu/soar_manual/02_TheSoarArchitecture/ . The document is included as reference [9] in Fan & Lan.

## 3. Critical source boundary decisions

1. A Soar impasse is tied to operator selection; a modern tool error is not automatically a Soar impasse. B2's execution-ledger trigger is a proposed translation.
2. Soar's superstate/substate and dependency semantics are not literally an immutable state snapshot and recovery subprocess. Fan & Lan's “freeze the relevant parent state” is the proposed runtime design requirement; snapshot/version mechanics in the outline are marked as engineering proposals.
3. The returned Soar result is not arbitrary child text. The outline distinguishes native result linkage from a proposed typed resolution envelope.
4. Chunking is tied to successfully resolved operator impasses and compiles dependency conditions plus the result action. The outline does not say that every failure, retry or reflection note creates a chunk.
5. The systems named in the modern comparison are only described at the level Fan & Lan report. No additional claims about their implementations are inferred from names or marketing descriptions.
6. E/D codes are individual provisional correspondence codes. They are not a single score for Soar, a framework, or B2 as a whole.
7. B2 remains an unvalidated research hypothesis. Appendix D gives a proposed experimental protocol, not results.

## 4. Planned attribution

- Use `\FanLanCite{...}` for the review's historical mapping, residual hypothesis, modern comparisons, E/D records, falsifiers and research status.
- Use `\autocite{soar2025architecture}` for the detailed Soar type/semantics cross-check, alongside Fan & Lan citations.
- Keep Product X scenario details marked `[Book example]` and runtime schema/controller design marked `[Engineering decision]`.

## 5. Outline-stage limitations

This review authorizes only the accuracy and structure of the proposed outline. The full source-fidelity review of prose, line-by-line citation placement, figure semantics and rendered chapter remains required after the outline is approved and the chapter is drafted.
