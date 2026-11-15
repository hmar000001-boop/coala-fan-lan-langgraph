# Chapter 13 Outline v2.0

## Understanding Typed Impasses, Substates and Compilation: B2

**Part II — From Cognitive Architectures to Mechanism-Level Understanding**  
**Batch 4 — Standalone mechanism study**  
**Outline status:** Revised v2.0 after the author requested a stronger theory-to-implementation bridge; the same instruction authorized drafting. Chapter 13 prose has now been drafted against this outline; final illustrated-PDF validation remains dependent on CI Mermaid rendering.  
**Primary theoretical source:** Haodi Fan and Zucong Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps* (2026), arXiv:2607.23942v1.  
**Historical mechanism:** Soar's operator-selection impasses, substates, result return, dependency tracking and chunking, as reconstructed by Fan & Lan and cross-checked against the Soar Architecture manual cited by that review.

---

## 1. Chapter purpose and role in the book

Chapter 12 examined how memory accessibility, retrieval latency, downstream utility and cost might be coupled at context assembly. Chapter 13 turns to a different control problem: what should happen when an agent cannot continue a decision or execution path safely, and how can the system recover without corrupting the state that made the original task meaningful?

The chapter is a standalone deep-dive into **B2**, the typed impasse–substate–compilation bundle. Its historical anchor is Soar. Soar does not treat every difficulty as an undifferentiated error message. Its operator-selection process can expose a typed impasse; the architecture creates a child substate whose purpose is to resolve that impasse; the substate produces a result that allows the parent state to proceed; and, when the impasse is successfully resolved, chunking can compile the dependency conditions and result into a reusable production.

Fan & Lan use that historical chain to formulate a bounded agent-runtime hypothesis. An execution ledger should classify a failure, preserve the relevant parent state, open a bounded recovery subgraph, return a typed resolution, and compile a reusable recovery rule only when the conditions that made the resolution valid are known. The chapter must distinguish the historical Soar mechanism from this proposed modern translation. In particular, a Soar superstate is not simply an immutable snapshot copied into a child process, and a Soar impasse is not synonymous with every failed tool call or exception.

The objective is to teach the reader why **failure representation, recovery scope, parent-state integrity, result return, and learning from a resolved recovery** must be understood as one control chain. A retry loop may recover once; a reflection note may influence a later prompt; a checkpoint may preserve state; and a repair policy may be selected by an error classifier. None of those pieces alone establishes the complete B2 coupling.

### Chapter thesis

> A safe recovery mechanism must preserve the authority and relevant context of the parent task while it investigates a typed failure in a scoped child process. It must return a result whose type and applicability can be checked, and it should compile reusable knowledge only from the dependencies that made the resolution valid.

### Learning outcomes

By the end of the chapter, a technically curious reader should be able to:

1. Explain how Soar represents operator-selection impasses and why an impasse is a typed control condition rather than a generic exception.
2. Distinguish tie, conflict, constraint-failure, and no-change impasses, including the state-level and operator-level no-change cases.
3. Explain the relationship between a parent state (superstate), a child substate, subgoal processing, results, resolution, elimination, regeneration and dependency tracking.
4. Describe how Soar chunking uses the dependency conditions and result of a successfully resolved impasse to construct a production that can match a later similar state.
5. Distinguish Soar's native substate semantics from Fan & Lan's proposed protected recovery subgraph for modern agent runtimes.
6. Compare the partial B2 baselines—PALADIN, AgentDebugX, Shepherd, AgentHER and Reflexion—without implying that any one of them implements the complete residual bundle.
7. Explain why a checkpoint, retry, recovery action, reversible branch, reflection record or learned feedback item is not by itself an implementation of B2.
8. Design a language-neutral recovery contract with a versioned parent state, bounded child recovery scope, typed resolution, explicit return validation and dependency-aware compilation.
9. Identify the safety risks of misdiagnosis, parent-state corruption, stale dependencies, irreversible side effects, overgeneralized compilation and repeated failure.
10. Reconstruct the B2 experimental protocol and its falsifiers, including state traces, outcome metrics, safety/efficiency measures and the required ablations.
11. State the boundaries between B2 and B1, B3, B4, B5 and B6 without teaching those later mechanism studies prematurely.

## 2. Organizing distinctions

The chapter must repeatedly preserve the following distinctions. They are not stylistic details; they prevent the reader from equating mechanisms that have different triggers or control authority.

| Distinction | Correct treatment |
|---|---|
| **Soar impasse vs. generic execution error** | A Soar impasse arises in operator selection when the current decision cannot proceed under the preference structure. A modern tool failure may be classified as a recovery trigger in the proposed B2 execution ledger, but it is not automatically a Soar impasse. |
| **Impasse detection vs. recovery content** | The typed impasse identifies why the parent decision is blocked. Recovery operators or actions are generated and evaluated inside the child substate; they are not the impasse itself. |
| **Superstate vs. immutable snapshot** | Soar represents the parent as the superstate and tracks dependencies between child results and superstate working-memory elements. Fan & Lan's proposed runtime says to freeze the relevant parent state. A versioned, immutable snapshot is an engineering translation, not a literal claim about Soar's implementation. |
| **Substate vs. ordinary checkpoint** | A checkpoint may preserve data for resume. A Soar-like substate additionally has a typed reason for creation, a parent/child relation, a local decision process and controlled result return. |
| **Resolved vs. eliminated vs. regenerated impasse** | A resolved impasse produces results that let the parent proceed and creates an opportunity for chunking. An impasse may instead become irrelevant because the situation changes, or be regenerated when dependencies change. Those outcomes do not license the same learning conclusion. |
| **Result vs. arbitrary child output** | A Soar result is a working-memory element or preference linked to a superstate and survives removal of the child state. A proposed agent result envelope should make its type, evidence, parent version and applicability conditions explicit. |
| **Chunking vs. reflection or replay** | Soar chunking compiles dependencies that were necessary for a resolved subgoal into a generalized production. Storing a failure summary, replaying a trajectory or writing a reflection may influence later behavior but does not automatically reproduce this dependency-based compilation. |
| **In-episode recovery vs. general skill governance** | B2 is an in-episode recovery transition whose outcome may yield a reusable rule. B5 concerns general skill invocation/governance across tasks and is handled as the closed candidate in Chapter 17. |
| **Runtime insertion point vs. complete implementation** | A state graph, checkpoint, interrupt, fork or replay boundary can host a B2 design. Its presence alone does not demonstrate typed diagnosis, protected recovery, typed return and safe compilation. |

## 3. Proposed chapter structure

### Opening — Chapter at a glance

- Start with a familiar but dangerous situation: an agent encounters a failed operation and can either retry blindly, abandon the task, or stop the parent task while it diagnoses the failure.
- Use the Product X payment-service incident as the running **[Book example]**. The known starting fact is simply that a payment retry failed. Further details—such as a timeout with an uncertain settlement outcome—must be visibly identified as illustrative assumptions, not paper evidence.
- State the central risk: a recovery attempt can be locally plausible and still violate the parent's goal, repeat an irreversible action, overwrite important state, or create a reusable rule that is unsafe in a different situation.
- Preview the historical Soar chain, the modern partial baselines, and the B2 residual.
- Present learning outcomes in the shared `learningbox`.

### 13.1 The problem: failure is not yet a recovery policy

#### 13.1.1 A failed operation does not tell the agent what to do next

- Explain why a raw exception such as `timeout`, `not found`, `permission denied` or `invalid state` is only evidence about an event, not a complete recovery decision.
- Show how the same outward failure can have different causes and consequences. A timeout after a payment request, for example, may leave the settlement state unknown; automatically repeating the request could be unsafe.
- Distinguish detection, attribution, selection of recovery, execution of recovery, validation of outcome and learning from the episode.

#### 13.1.2 The parent task must remain meaningful while recovery is attempted

- State the parent goal and its invariants before opening a recovery branch.
- Explain the difference between preserving a record of what happened and preserving the state/authority needed to resume coherently.
- Introduce the parent/child recovery analogy as an intuition only; defer exact terms until the Soar mechanism is taught.

#### 13.1.3 From retry loops to a control chain

- Compare a blind retry, diagnosis followed by retry, reversible branch, reflection memory and scoped substate at a high level.
- Preview the five operations that B2 connects: classify, isolate, recover, return and compile.
- Explain that the goal is not maximal automation. Some failure types should lead to escalation, abstention or human review rather than another tool call.

### 13.2 Soar: the historical mechanism behind B2

This is the chapter's central historical teaching section. It should be developed slowly from the operator decision process rather than beginning with a list of terminology. The Soar-specific descriptions below are checked against the architecture manual cited by Fan & Lan and the separate procedural-learning chapter in the same official manual.\autocite{soar2025architecture,soar2025procedural}

#### 13.2.1 Working memory, operators and preferences

- Introduce Soar's current problem representation in working memory.
- Explain operators as candidate state transitions: an operator proposes how the current state might change.
- Explain preferences as the information used to select among proposed operators.
- Show the decision point where one operator may be selected, or the preference structure may fail to determine a valid next step.
- Do not re-teach the entire Soar architecture; explain only the state and control elements needed to understand impasses and substates.

#### 13.2.2 What makes an impasse typed?

- Define the impasse as a state in the decision process, not just a descriptive label attached to a failed action.
- Explain the Soar categories reported in the architecture documentation cited by Fan & Lan:
  - **Tie impasse:** multiple acceptable operators remain tied because the preferences do not distinguish them.
  - **Conflict impasse:** conflicting better/worse preferences prevent a consistent choice.
  - **Constraint-failure impasse:** required/prohibited constraints conflict, leaving no legal selection under the current preference structure.
  - **No-change impasse:** no new operator is selected during the decision procedure. Distinguish state no-change (no acceptable or required preference suggests an operator, or all acceptable candidates have been rejected) from operator no-change (an operator is selected but no additional productions match during application, or no operator is selected in the next decision phase).
- Explain that the type constrains what kind of problem the child process must solve. Do not suggest that all types are repaired by generating another preference; constraint failure and no-change conditions have different resolution paths.
- Keep a short source note: Fan & Lan's own summary emphasizes tie, conflict, rejection and missing choice; the fuller type distinctions are drawn from the Soar Architecture source it cites.

#### 13.2.3 The substate: a child problem with a parent relation

- Explain that an impasse creates a new state/subgoal whose purpose is to resolve the impasse.
- Introduce **substate** and **superstate** only after the reader understands the parent problem and the need for a child problem.
- Explain that the initial child state includes a description of the impasse cause and a reference to the superstate.
- Explain that the child can select and apply its own operators; additional impasses can create nested subgoals.
- Explain that the top-level and nested states form a subgoal stack. Problem solving can remain active at multiple levels, even though attention tends to focus on the newest subgoal.
- Clarify that the child is not an independent agent with an unrelated goal: its purpose is scoped by the parent impasse.

#### 13.2.4 Results: what crosses back to the parent?

- Define a subgoal result as a working-memory element or preference created in the substate and linked directly or indirectly to a superstate.
- Explain why such results are not simply any text or arbitrary value returned by a child process.
- Explain the role of support and persistence at a conceptual level: some results remain because they are connected to the higher-level problem; unrelated child-local structures disappear when the substate is removed.
- Explain that an impasse is resolved when child processing creates results that allow the parent state to select a new operator.
- Show the return path: the child contributes a result; the parent decision can proceed; the child state and its local non-result contents are removed.

#### 13.2.5 Resolution is not the only way an impasse can disappear

- Distinguish **resolved**, **eliminated** and **regenerated** impasses.
- Resolved: a child result enables progress in the parent; this is the learning-relevant path.
- Eliminated: a higher-level change or new external input makes the old subgoal irrelevant; no chunking opportunity should be claimed from this event.
- Regenerated: a dependency used by the child changes in the superstate; the old substate is removed and a new one is created so that child reasoning is consistent with the changed parent context.
- Explain the Goal Dependency Set (GDS) as the source mechanism that records relevant superstate working-memory dependencies for substate results and supports regeneration when those dependencies change.
- Emphasize that dependency tracking protects semantic validity; it is not simply a general-purpose version number or transaction log.

#### 13.2.6 Chunking: compiling the conditions that made the resolution possible

- Explain chunking as result/dependency-based procedural learning arising from subgoal processing. The Soar procedural-learning manual states that a chunk can be created as soon as a subgoal creates a result in a superstate; it need not wait until the impasse has fully terminated. The architecture chapter also explains the learning opportunity in the context of resolved operator impasses. Present these descriptions together rather than asserting a universal “only after final resolution” timing rule.
- Describe how Soar's chunking mechanism summarizes processing in the substate.
- Explain the two sides of the learned production:
  - conditions: the relevant state elements from the higher-level context that, through the production/dependency chain, support the generated result;
  - action: the working-memory element or preference that constitutes the result.
- Explain variablization/generalization: conditions and action are expressed so that the new chunk can match a similar future situation, rather than memorizing only the original concrete state.
- Explain why this can prevent the same impasse from requiring the same deliberate subgoal work again.
- Distinguish chunking from caching the entire trace, storing a natural-language lesson, or memorizing a successful action without its applicability conditions. Note that Soar documentation distinguishes chunks from justifications and describes later extensions (including EBBS) separately; do not silently treat every modern guarded rule candidate as a faithful implementation of all Soar learning details.
- Discuss overgeneralization as a risk that motivates careful dependency conditions; keep the focus on the source mechanism, not a complete theory of Soar learning.

#### 13.2.7 Worked Soar cycle

- Walk through a small decision: the parent state has two candidate operators whose preferences do not distinguish them; a tie impasse is created; the child substate evaluates a relevant condition; it produces a result linked to the parent; the parent can now select an operator; chunking can compile the relevant parent conditions and result action.
- Use a second short counterexample where the parent context changes during subgoal processing and the child must be regenerated rather than returning a stale result.
- Keep the illustration simple and explicitly label it a **[Book example]** unless the exact domain example is directly present in a cited Soar source.

### 13.3 What changes when the mechanism moves into a language-agent runtime?

#### 13.3.1 From operator-selection impasse to execution failure classification

- Explain Fan & Lan's translation: an execution ledger classifies a failure or attributed root cause and uses that type to choose a recovery transition.
- State explicitly that a modern tool error is not literally a Soar impasse. The commonality is typed failure-specific control, not identical trigger semantics.
- Explain why an untyped `failed` flag cannot choose safe recovery scope or compilation conditions.

#### 13.3.2 From superstate/substate to protected parent and bounded recovery subgraph

- Translate the parent/child relation into a proposed runtime structure: a versioned parent-state reference or snapshot, a child recovery scope, and a boundary around which mutations the child may make.
- Mark the difference: Fan & Lan's proposal says to freeze the relevant parent state; Soar's native semantics use a superstate relation and dependency tracking rather than a literal immutable cloned snapshot.
- Explain why a generic fork or checkpoint is only a substrate. A B2-like branch needs a reason for its creation, a defined scope, an allowed mutation set and a return condition.

#### 13.3.3 From Soar results to typed resolution contracts

- Translate the returned result into an explicit resolution object with a result type, evidence/provenance, parent version, relevant dependency set, postconditions and applicability boundary.
- Explain why the parent should validate the resolution before resuming the original task.
- Present the contract fields as **[Engineering decision]**, not as a schema prescribed by Fan & Lan.

#### 13.3.4 From chunking to condition-safe recovery-rule compilation

- Explain the proposed compilation target: a narrow reusable recovery rule whose guard records the failure type and dependency conditions that made the original resolution valid.
- Explain why a rule must not be generalized from an accidental correlation or a failed trajectory with ambiguous attribution.
- Explain compile gating: only a successfully resolved and validated recovery can become a compilation candidate; unresolved, eliminated, regenerated or externally invalidated cases do not justify the same inference.
- Explain versioning, provenance and invalidation as **[Engineering decision]** needed to keep a rule safe as tools, APIs, policies and environments change.

### 13.4 Modern systems: the closest pieces are distributed

The purpose of this section is not to write mini-surveys of every named system. It is to show which edge each system contributes to Fan & Lan's comparison and what remains absent.

#### 13.4.1 Runtime boundaries that could host recovery

- LangGraph: state graph, checkpoint, interrupt and resume boundary.
- OpenHands: execution/workflow state and agent-execution boundary.
- Magentic-One: orchestration boundary relevant to multi-agent task execution.
- Shepherd: reversible first-class execution traces, including inspect, transform, fork and replay.
- These are candidate insertion boundaries, not proof of B2. A checkpoint by itself is persistence at most; it becomes a Soar-related D3 control correspondence only when a typed failure trigger opens a bounded child state and controlled return semantics are present.

#### 13.4.2 Diagnosis and recovery baselines

- **PALADIN:** Fan & Lan describe it as classifying tool errors and retrieving recovery actions. The preserved edge is that failure type changes which recovery action is selected.
- **AgentDebugX:** Fan & Lan describe a Detect–Attribute–Recover–Rerun loop. The preserved edge links failure observability and attribution to repair and rerun.
- Explain that these are diagnostic/recovery baselines and should not be presented as implementing the protected substate, typed return and safe compilation chain unless the source says so.

#### 13.4.3 Reversible execution and cross-episode learning baselines

- **Shepherd:** reversible, forkable and replayable first-class execution traces; useful as the closest protected-branch baseline.
- **AgentHER and Reflexion:** failure experience can affect later behavior; useful as learning baselines, but not equivalent to compiling the dependency structure of a scoped Soar substate.
- Distinguish in-run recovery and branching from cross-episode feedback.

#### 13.4.4 A source-faithful comparison table

Planned table columns: system/case; state object; trigger; preserved edge; what is not established; Fan & Lan's provisional E/D record where the paper gives one.

- PALADIN and AgentDebugX: functional recovery/diagnosis baselines; Fan & Lan's Appendix C-B reports the typed-recovery records as provisional E3/D3.
- Shepherd: protected-branch record; Appendix C-C reports E2/D3.
- AgentHER and Reflexion: failure-learning records; Appendix C-D reports E3/D4 for the narrow feedback edge.
- Do not assign one E/D code to the entire Soar-to-modern mapping or to B2 as a bundle.
- Refer back to Chapter 11 for the definitions of E1–E4 and D0–D4. Only explain what is needed to interpret these particular record labels.

### 13.5 B2 as a composed runtime hypothesis

This section reconstructs the five-step proposal in Fan & Lan and then makes the dependencies visible. It must not pretend the proposal is already a validated architecture.

#### 13.5.1 Step 1 — classify the failure

- An execution event crosses a monitored boundary: a tool call, agent action, validation step or workflow transition fails or cannot establish a required postcondition.
- The execution ledger records the event and classifies the failure type; root-cause attribution is recorded separately from the raw symptom.
- Classification includes evidence and uncertainty. Where the type cannot be established, the safe result may be abstention or escalation rather than speculative recovery.

#### 13.5.2 Step 2 — preserve the parent state

- Record the parent task/state identifier, version or hash, goal, relevant invariants, completed verified work, pending action and dependencies.
- Freeze or otherwise protect the relevant parent view while recovery proceeds.
- Define which observations may be added, which state changes are local to the child, and which external side effects cannot be rolled back by restoring an internal snapshot.
- Explicitly label the concrete schema and snapshot policy as a book-level engineering proposal.

#### 13.5.3 Step 3 — open a bounded recovery subgraph

- Create a child recovery scope carrying the typed failure, parent reference, evidence and allowed recovery operations.
- Let the child have its own local decision process, but do not let it silently rewrite the parent goal or treat unverified proposals as parent results.
- Bound attempts and permitted operations. Mention deadline/token/tool limits only as local guardrails; defer cross-stage resource allocation and interruption policy to Chapter 16 (B6).
- Record nested recovery only when a new, separately typed impasse warrants it; avoid unbounded recursive retries.

#### 13.5.4 Step 4 — return and validate a typed resolution

- Return a typed outcome, not an unstructured assistant paragraph.
- The resolution should carry: outcome type; evidence; affected resources; parent version; dependency references; completed/failed operations; postconditions; and whether the result is safe to apply.
- The parent checks that it is still the same relevant state, that dependencies remain valid, and that the result satisfies the expected contract.
- If the parent has changed or the evidence is stale, the result is rejected, re-evaluated or the branch regenerated; it is not silently merged.

#### 13.5.5 Step 5 — compile a reusable recovery rule

- Extract only the conditions that made the resolution valid and the validated recovery action/result.
- Express those conditions as explicit guards or typed preconditions, not merely a semantic similarity to a past failure.
- Store provenance, confidence/validation status, source versions, tool/environment identity, rule version and invalidation conditions.
- Run candidate rules in a controlled validation path before promotion; demote or disable them after counterexamples or dependency changes.
- Clarify that this is a proposed modern analogue of dependency-based chunking, not a claim that Fan & Lan supply a complete compiler algorithm or that all failed runs should be compiled.

#### 13.5.6 The complete lifecycle and its authority boundaries

- Show the chain from parent operation to typed detection, parent preservation, child recovery, typed return, parent validation and optional compilation.
- Identify the authoritative controller at every transition. Model-generated hypotheses may propose a diagnosis or recovery action; the runtime governor decides whether the branch opens, whether a result is accepted and whether a rule is promoted.

### 13.6 From the B2 hypothesis to an implementable recovery subsystem

This section is the explicit bridge from historical theory and the residual hypothesis to production engineering. It must be at least as concrete as Chapter 12's memory-record, event, policy, and operational-contract treatment. The chapter should not stop after naming a parent snapshot, child graph, typed result, and compiler. The original v1 already described these concepts; v2 strengthens the bridge into concrete contracts, legal transitions, persistence semantics, side-effect boundaries, a rule lifecycle, and a testable implementation sequence.

#### 13.6.1 The smallest useful component architecture

Present a language-neutral component architecture, with a clear distinction between proposal components and authoritative runtime components:

- `ExecutionAdapter`: wraps each tool/action boundary and emits a normalized success, failure, timeout, or ambiguous-outcome event.
- `FailureClassifier`: maps observations to a versioned `FailureFinding` containing type, evidence references, confidence/uncertainty, and attribution status. A model may suggest a type; deterministic validators and the runtime governor own the transition.
- `ParentStateStore`: stores an immutable/versioned parent view, goal and invariant references, completed verified work, pending action, dependency versions, and side-effect ledger reference.
- `RecoveryGovernor`: checks whether the failure is eligible for local recovery, opens and bounds the child scope, and authorizes the allowed operation set.
- `RecoveryRunner`: executes a recovery subgraph in an isolated namespace with explicit capabilities and no direct parent mutation.
- `ResolutionValidator`: checks result type, evidence, parent version, dependency freshness, postconditions, and side-effect claims.
- `ParentCommitter`: applies an accepted state delta using compare-and-swap against the expected parent version; it rejects stale results rather than silently merging them.
- `RecoveryRuleCompiler` and `RuleRegistry`: extract guarded candidates from validated traces, test them, keep them quarantined or shadowed before promotion, and support invalidation/rollback.
- `RecoveryLedger`: append-only event history connecting the failure, parent, branch, tool calls, resolution, commit, and learning candidate.

A component diagram should show the model as a proposer/analyst, not as the authority that can unilaterally mutate parent state or promote a compiled rule.

#### 13.6.2 Proposed typed data contracts

Provide implementable schemas (clearly `[Engineering decision]`) and explain required versus optional fields:

- `ExecutionFailure`: `event_id`, `parent_id`, `observed_at`, `operation_id`, `raw_error`, `outcome_certainty`, `tool_name`, `tool_version`, `evidence_refs`.
- `FailureFinding`: `failure_id`, `type`, `phase`, `evidence_refs`, `attribution`, `confidence_or_uncertainty`, `classifier_version`, `retryability`, `side_effect_risk`.
- `ParentSnapshot`: `parent_id`, `version`, `state_digest`, `goal_ref`, `invariant_refs`, `verified_facts`, `pending_operation`, `dependency_versions`, `side_effect_ledger_ref`, `captured_at`.
- `RecoveryScope`: `recovery_id`, `parent_id`, `parent_version`, `failure_id`, `scope_status`, `allowed_capabilities`, `denied_capabilities`, `attempt_budget`, `deadline`, `local_state_ref`, `dependency_set`, `opened_at`.
- `Resolution`: `resolution_id`, `kind` (for example `RESOLVED`, `STILL_UNKNOWN`, `BLOCKED`, `PARENT_STALE`, `ESCALATE`), `parent_version`, `evidence_refs`, `dependency_versions`, `proposed_delta`, `postconditions`, `side_effect_summary`, `created_at`.
- `RecoveryRuleCandidate`: `rule_id`, `guard`, `action_or_plan_ref`, `dependency_set`, `source_trace_refs`, `tool/API/model versions`, `validation_suite`, `promotion_status`, `expiry_or_invalidation_conditions`, `rollback_target`.

Explain why raw symptoms, classified causes, a recovery action, a returned resolution, and a compiled rule are separate objects. Include a compact JSON-like or Java-record example for the payment timeout, but do not imply that these exact schemas appear in Fan & Lan or Soar.

#### 13.6.3 Runtime state machine and legal transitions

Specify the proposed states and transitions: `RUNNING → FAILURE_CAPTURED → CLASSIFIED → PARENT_PROTECTED → RECOVERY_OPEN → RECOVERING → RESULT_PROPOSED → RESULT_VALIDATED → PARENT_COMMITTED`. Include terminal or alternate paths `ESCALATED`, `ABORTED`, `ELIMINATED`, and `REGENERATED`; define the guard for each. Clarify that these names are modern runtime states, not Soar's native state labels. No transition may skip validation before parent commit. Compilation is a separate side path after a valid result and required outcome evidence, not part of every immediate recovery.

Show transition preconditions, emitted events, allowed writes, and postconditions in a table. Explain how an unchanged parent can accept a child result, a changed dependency can invalidate/regenerate the child, and a changed external situation can eliminate a now-irrelevant recovery branch.

#### 13.6.4 Persistence, transactions, concurrency and external side effects

- Use an append-only recovery event ledger for audit/replay; keep branch-local mutable working state separately namespaced.
- Capture a parent version/hash at branch creation. Validate the same relevant version at return. Apply parent updates through compare-and-swap or an equivalent optimistic concurrency check; reject stale results and recompute rather than silently merge.
- Track dependencies at field/resource granularity when possible. A whole-parent hash is a safe but coarse fallback; it can cause unnecessary regeneration. Explain the trade-off.
- Distinguish internal state rollback from external side-effect compensation. Restoring a checkpoint does not reverse a payment, email, deletion, or API mutation.
- Require idempotency keys and read-after-write/status checks where the external API supports them. For uncertain outcomes, query the original operation before issuing a new side effect. A saga/compensation is a separate explicitly authorized operation, not an automatic implication of branch rollback.
- Explain retries, at-least-once delivery and duplicate events; make event handling idempotent but do not promise universal exactly-once external execution.
- State concurrency rule: only one accepted parent transition may commit against a given version; concurrent child branches must be serialized, arbitrated, or validated against updated state.

#### 13.6.5 Typed resolution validation and safe parent return

Give a checklist or contract: recognized outcome type; required evidence present; provenance/source version valid; parent identity and expected version match; dependencies unchanged; postconditions verified; proposed delta is inside the child capability boundary; no forbidden or unaccounted side effect; uncertainty is explicit; and a rejection/escalation path exists. Distinguish a successful local diagnosis from a safe state transition.

#### 13.6.6 Dependency-aware compilation and governance

Turn Soar chunking's dependency/result relationship into a carefully labelled engineering analogue:

1. collect the trace from a validated recovery episode;
2. identify the smallest parent facts and environment/tool constraints required for the resolution;
3. derive a guard and a bounded action plan, not an unconstrained code block;
4. add negative/absence conditions only when they were observed and are semantically meaningful;
5. run the candidate against held-out traces, counterexamples, and current tool contracts;
6. keep it in quarantine/shadow mode and compare with the baseline path;
7. promote only after preregistered acceptance criteria; version, expire, disable, or roll back when dependencies change or harmful reuse is observed.

Explain specialization versus overgeneralization, rule conflict, candidate proliferation and maintenance burden. A validated result does not automatically imply that a reusable rule should be compiled. Some recoveries are one-off, externally contingent, unsafe to generalize, or too weakly attributed.

#### 13.6.7 A vertical-slice implementation plan

Give a practical build sequence that can be implemented and tested incrementally:

1. instrument tool boundaries and persist raw execution events;
2. introduce a small typed failure taxonomy and explicit `UNKNOWN`/`AMBIGUOUS` outcomes;
3. store parent version and goal invariants before every state-changing action;
4. open isolated child scopes with a read-only allowlist first;
5. return a typed resolution envelope and validate it before parent resume;
6. implement version-checked parent commit and stale-result rejection;
7. add dependency capture/invalidation;
8. store compilation candidates but initially keep them disabled;
9. test candidates in replay/shadow mode, then promote under an explicit rule-governance policy;
10. evaluate with the B2 trace and ablations before claiming the full coupling.

This sequence avoids implementing automatic compilation before parent-state and failure boundaries are observable. It is a practical proposal, not an implementation sequence prescribed by the source paper.

#### 13.6.8 Reference pseudocode and implementation tests

Include language-neutral pseudocode (Java-like interfaces/records are acceptable) for `onFailure`, `openRecovery`, `validateAndCommit`, and `proposeRule`. Show that the model can return suggestions but cannot directly call `ParentCommitter` or `RuleRegistry.promote`. Include unit/integration/property tests for stale parent versions, dependency changes, duplicated failure events, timeout with unknown external outcome, forbidden capability use, child branch loops, and a rule that overgeneralizes to a new API version.

The implementation section must conclude with an explicit statement of what is still research: whether the composed B2 mechanism improves recovery and transfer over simpler baselines, and whether dependency-safe rule compilation is reliable enough to justify its cost.

### 13.7 Product X worked example: a payment retry with an unknown outcome

**[Book example]** Reuse Product X from Chapter 12 to maintain continuity, while marking every added scenario detail as illustrative.

- Parent goal: resolve the payment attempt without creating a duplicate charge; preserve the customer request and verified transaction facts.
- Event: the payment retry returns a timeout. A timeout alone does not prove that the provider rejected the transaction.
- Typed classification: `payment_outcome_unknown`, supported by the timeout event and the absence of a confirmed status response.
- Parent preservation: record the parent task version and invariant that no second charge may be initiated until the first attempt's status is known.
- Child recovery: perform only allowed status checks using the original idempotency/transaction reference; do not initiate a fresh payment in the recovery branch.
- Typed resolution alternatives:
  - `settled`: return verified provider evidence; parent records completion and does not retry.
  - `not_settled`: return verified evidence; parent may consider the permitted retry path.
  - `still_unknown`: return uncertainty; parent escalates or waits rather than guessing.
- Compilation candidate: after repeated validated episodes, a narrow rule may be proposed: when the same provider/API version reports the same timeout class and a status query proves the original attempt is not settled, use the verified retry procedure with the same idempotency reference.
- Guard against unsafe overgeneralization: a timeout with unknown settlement is not equivalent to a confirmed failed transaction; provider version, idempotency semantics and postconditions matter.
- Include a counterexample where the provider's status result changes while the branch is open. The child result must be invalidated/rechecked rather than returned as though its parent context were unchanged.
- Make the reader identify which parts are source mechanism, which are Fan & Lan's B2 proposal, and which are the book's engineering example.

### 13.8 Apply the seven-field mechanism representation to B2

Use the exact tuple from Chapter 10, with no new fields and no redefinition. The purpose is to summarize the proposal, not to repeat the entire Chapter 10 lesson.

| Field | Soar historical mechanism | B2 runtime hypothesis / proposed design |
|---|---|---|
| State substrate (S) | Working-memory states, operators, preferences, substates/superstates, results and dependency information. | Execution ledger, parent-state version, typed failure, recovery subgraph trace, typed result and compiled recovery rule. |
| Control locus (C) | Soar's decision procedure and production/operator-selection machinery. | A runtime recovery governor with authority to classify, fork, accept/reject results and promote/reject compilation candidates. |
| Transition trigger (T) | Operator-selection impasse; successful resolution or dependency/context change. | Typed execution failure or attributed cause; child resolution; parent validation; later matching invocation. |
| Persistence boundary (P) | Child-local state is removed on resolution; linked results survive; learned chunks persist as productions. | Child branch is scoped to the recovery episode; parent state remains authoritative; validated rules persist with versions and provenance. |
| Failure semantics (F) | Typed impasse, resolution, elimination and regeneration. | Misclassification, unresolved recovery, stale parent/dependency, rejected result or unsafe compiled rule. |
| Learning operator (L) | Chunking compiles dependency conditions and result into a production after successful impasse resolution. | Proposed condition-safe compilation and later outcome-based rule validation/update. Keep AgentHER/Reflexion's separate learning edge distinct. |
| Resource/governance policy (R) | Only report what the source documents; do not fill unknown architectural resource details. | Bound recovery attempts/operations locally; cross-stage budget, risk and interruption authority belong to B6. |

### 13.9 Failure modes, safety and authority

#### 13.9.1 Diagnosis errors

- False diagnosis opens the wrong recovery path; missed diagnosis falls back to generic retries; ambiguous cause should not be promoted to a durable type without evidence.
- Measure per-type precision/recall and the cost of wrong recovery selection.

#### 13.9.2 Parent-state corruption and stale context

- A child mutates parent data, merges speculative state, or returns a result calculated against an outdated parent version.
- Use parent-version checks and dependency-aware invalidation as the proposed control response.
- Explain that an internal snapshot cannot reverse an external side effect already performed by a tool.

#### 13.9.3 Unsafe compilation and overgeneralization

- A recovery rule is learned from a one-off incident, an incorrect attribution, missing dependencies or a context-specific result.
- The learned guard is too broad, the tool contract changes, or the rule remains active after a dependency changes.
- Require provenance, narrow applicability, validation, expiry/invalidation and rollback as engineering safeguards.

#### 13.9.4 Endless recovery, retry storms and authority confusion

- A recovery branch recursively opens new branches without a termination condition.
- The model both proposes and authorizes a state-changing recovery.
- A branch crosses the permitted scope or repeats an external side effect.
- Keep these concerns distinct from B6's full resource/uncertainty/interruption control policy, but show why B2 still needs a local maximum depth and escalation path.

### 13.10 Evaluation: test the full coupling, not only whether a retry worked

#### 13.10.1 Required trace and event record

Use the fields specified by Fan & Lan's Appendix D:

- failure type;
- parent hash or stable parent-state reference;
- substate/recovery-branch trace;
- returned resolution;
- compiled rule and its applicability record.

Add proposed diagnostic fields only when clearly labelled as engineering additions: classifier evidence, parent version, dependency set, branch budget, side-effect ledger, result validation and rule version.

#### 13.10.2 Baselines and controlled comparisons

- Simple retry / generic retry loop.
- Typed diagnosis with recovery selection but no protected child state.
- Reversible branch/replay without typed impasse and typed return.
- Cross-episode reflection or hindsight learning without dependency-safe compilation.
- Full B2 composition.
- A human-supervised or conservative escalation path where the task's risk makes automatic recovery inappropriate.

Keep each comparison tied to the specific edge it isolates; do not imply every baseline is directly implemented by a single named product.

#### 13.10.3 Primary, safety and efficiency measures

- Recovery success by failure type.
- Repeated-failure rate and transfer to a later similar case.
- Parent-state corruption/invariant-violation rate.
- Unsafe rule-reuse rate and harmful compilation rate.
- Diagnosis/recovery latency.
- Recovery operations, tool calls and cost.
- Rejection/escalation precision for unresolved or ambiguous cases.

Fan & Lan's explicit Table X measures include recovery by type, repeated-failure rate and transfer as primary outcomes; diagnosis latency, state corruption and unsafe reuse as safety/efficiency outcomes. The chapter should preserve those labels and may add operational definitions as book-level measurement design.

#### 13.10.4 Required ablations and rejection conditions

- Remove the new state object while retaining the rest of the controller.
- Remove the authoritative control edge but retain logging, to test whether the runtime transition rather than instrumentation produces the effect.
- Remove the learning update while retaining the immediate runtime recovery transition, to separate D3 control value from D4 adaptation.
- Reject the B2 claim if the retry baseline is non-inferior under the preregistered margin, if parent-state corruption increases, if compilation causes harmful reuse, or if repeated failures/transfer do not improve.
- Follow Fan & Lan's Appendix D discipline: hold base model, prompt, tools, environment and task budget fixed; preregister task population, experimental unit, versions, stochastic replications, sample size, metrics, margins/tests, exclusions and stopping rule.

### 13.11 Boundaries with other bundles and handoff

- **B1 (Chapter 12):** memory-item accessibility and context selection; it may supply prior information to recovery but does not define the failure transition.
- **B2 (this chapter):** typed failure, protected substate, typed return and resolution compilation inside an execution episode.
- **B3 (Chapter 14):** competition for a bounded workspace and broadcast/admission learning; it may receive recovery outputs as candidate content but is not the recovery protocol.
- **B4 (Chapter 15):** intention and reconsideration authority; it supplies the goal boundary that recovery must not silently rewrite.
- **B5 (Chapter 17):** general skill governance. Fan & Lan keep B2 separate because B2 is an in-episode recovery transition while B5 concerns general skill invocation across episodes/tasks; the compilation of a narrow recovery rule does not turn B2 into the entire skill-governance problem.
- **B6 (Chapter 16):** uncertainty, resources, interruption and stopping. B6 governs wider risk/budget authority; B2 retains local recovery bounds and escalation.
- **Chapter 18:** integrates the dependencies after the five residual bundles and closed B5 case have been examined individually.

### Closing — Recap and review questions

The recap should return to the core sequence: typed impasse/failure → scoped child recovery → validated result return → dependency-safe compilation. It should emphasize the boundary between the native Soar semantics, Fan & Lan's B2 proposal, and the book's proposed engineering contract.

Suggested review questions:

1. Why is a Soar impasse not the same thing as a tool exception?
2. What distinguishes a tie impasse from a conflict or constraint-failure impasse?
3. What does the `superstate` relationship contribute to a substate?
4. What is a result in Soar, and why is it different from arbitrary child output?
5. Explain the difference between resolving, eliminating and regenerating an impasse.
6. What does the Goal Dependency Set track, and why can a dependency change invalidate child reasoning?
7. Which conditions and action are used in a chunk, and why are they variablized?
8. Why does a checkpoint alone not establish a typed substate?
9. What do PALADIN, AgentDebugX, Shepherd, AgentHER and Reflexion contribute to the B2 comparison, and what does each leave unestablished?
10. Why must a modern recovery branch return a typed result tied to the parent version?
11. Give an example of an unsafe generalization from a successful recovery episode.
12. Which B2 metrics test immediate recovery, which test state safety, and which test learning/transfer?
13. Explain why B2 and B5 remain separate even though B2 may compile a reusable recovery rule.
14. Which parts of B2 depend on the intention authority in B4 or the resource/uncertainty controls in B6?

## 4. Planned figures and diagrams

All conceptual diagrams are to be authored as Mermaid `.mmd` files under `Tex/diagrams/source/part2/chapter13/`, rendered by the shared pinned Mermaid CLI in CI, and normally placed with the shared `\BookDiagram` macro. Where a float would interrupt a multi-page code listing, a local in-place figure environment may use the same shared caption and width conventions. Every `.mmd` file must include `accTitle` and `accDescr`, use the shared theme and have a matching caption and nearby explanatory prose. No TikZ, ASCII diagrams, hand-positioned LaTeX nodes or chapter-specific drawing packages.

1. **Figure 13.1 — Soar operator decision and typed impasse cycle.** Show the parent state, operator proposals/preferences, selection and the normal operator branch versus a typed impasse branch; show child substate processing, a result linked to the parent, resolution and optional chunking. Include separate paths for elimination/regeneration so the diagram does not imply every disappearing impasse is learned.

   Source file: \path{soar-impasse-substate-cycle.mmd}.
2. **Figure 13.2 — The four B2 invariants and their dependency chain.** Show typed diagnosis establishing recovery scope; protected parent state and bounded child substate; typed result return and parent validation; dependency-aware compilation into a reusable recovery rule. Mark this as Fan & Lan's proposed bundle, not an already implemented standard.

   Source file: \path{b2-four-invariants.mmd}.
3. **Figure 13.3 — Current evidence covers separate B2 edges.** Map PALADIN/AgentDebugX to diagnosis and recovery selection, Shepherd to reversible execution branches, and AgentHER/Reflexion to later behavior change. Show that the integrated typed impasse–protected substate–typed return–safe compilation chain remains the residual.

   Source file: \path{b2-modern-baseline-map.mmd}.
4. **Figure 13.4 — B2 reference implementation architecture.** Show the failure adapter, classifier, parent-state store, recovery governor, isolated child runner, resolution validator, compare-and-swap committer, append-only ledger, compiler candidate store and rule registry. Draw model-generated proposals as dashed inputs and runtime authorization/commit edges as solid control paths.

   Source file: \path{b2-reference-implementation.mmd}.
5. **Figure 13.5 — Product X recovery contract.** Trace a timeout through an unknown-payment classification, preserved parent, read-only child status check, typed status alternatives, parent validation and a narrowly guarded compilation candidate. Caption and prose must mark this as a book-created illustration.

   Source file: \path{productx-b2-recovery-example.mmd}.

## 5. Shared glossary and index plan

Do not create duplicate glossary entries. Before drafting, check the shared glossary and add only missing entries. Candidate entries for Chapter 13:

- impasse;
- tie impasse;
- conflict impasse;
- constraint-failure impasse;
- no-change impasse;
- operator;
- preference;
- substate;
- superstate;
- subgoal result;
- Goal Dependency Set (GDS);
- chunking;
- parent-state snapshot;
- typed resolution;
- recovery subgraph;
- dependency condition;
- recovery governor;
- parent-state version;
- idempotency key;
- compare-and-swap;
- rule candidate;
- capability allowlist.

Use `\gls` on first meaningful use in the chapter and `\index{...}` consistently for Soar, operator selection, impasses, substates, superstates, subgoal results, GDS, chunking, recovery branches, typed results, compilation and transfer. Definitions should explain the term at the level needed by a beginner and must not imply that modern design terms are native Soar terminology.

## 6. Teaching boxes and running example plan

Use the shared semantic boxes selectively:

- `learningbox`: learning outcomes.
- `takeawaybox`: B2 thesis / the full typed-failure-to-safe-compilation chain.
- `notebox`: the distinction between Soar's superstate dependency model and a modern immutable parent snapshot.
- `warningbox`: a tool timeout is not proof that an external side effect did not occur; restoring an internal checkpoint does not undo external effects.
- `tipbox`: how to read the modern-baseline comparison as separate preserved edges, not as system rankings.
- `chapterrecap`: concise mechanism recap.
- `reviewquestions`: exercises and conceptual questions.

Keep ordinary prose out of teaching boxes. Use the Product X payment incident for continuity with Chapter 12 and mark all invented incident details `[Book example]`; mark proposed schemas and controller rules `[Engineering decision]`.

## 7. Source and attribution plan

### Primary theoretical source — Fan & Lan (2026)

- **B2 hypothesis and exact proposed chain:** §VI-C, B2; quote/paraphrase the execution ledger, parent freeze, bounded recovery subgraph, typed resolution and reusable recovery rule.
- **Why the bundle consists of these four residual invariants:** §VI-B, Table V, B2 row: typed diagnosis, protected substate, typed return and resolution compilation; explain why B2 remains separate from B5.
- **Historical Soar mechanism:** §III-A, Soar; Figure 2(b); historical architecture ledger/Table VIII and Appendix A where applicable.
- **Historical-to-modern mapping:** §V-A, “Soar to typed recovery and experience learning”; §V-B, “Failure changes from a control state to recovery content”; Table IV.
- **Modern baseline descriptions:** §IV-B–IV-C; §V-A Soar mapping; Appendix C-B (R2a), C-C (R2b), C-D (R3); Appendix F-B/Table XIII.
- **E/D status for the particular records:** Appendix C-B reports typed recovery as provisional E3/D3; Appendix C-C reports Shepherd's protected-branch mapping as E2/D3; Appendix C-D reports the AgentHER/Reflexion learning edge as E3/D4. Refer to Chapter 11 for full definitions and do not create a B2-wide combined code.
- **Checkpoint boundary:** Appendix E-B, “Checkpoint versus typed impasse”; a checkpoint is persistence at D2, while a Soar-related D3 claim needs a typed failure trigger, bounded child state and controlled return semantics.
- **Experiment protocol and falsification:** Appendix D, Table X, B2 row and general preregistration/ablation requirements; §VI-C, B2 failure conditions; §VI-C Table VI, B2 row.
- **Cross-bundle dependencies:** §VI-D and Figure 8; B4 scopes recovery, B6 governs risk/resources, and B2 can produce verified resolutions for a GraSP-like governor.
- **Validity boundary:** §VII-C and Appendix F-C. The paper reports no completed experiment comparing the residual bundles against their baselines; present B2 as a hypothesis/research agenda, not a demonstrated performance result.

### Historical mechanism cross-check

The Soar Architecture manual cited by Fan & Lan as reference [9] is used to verify the named impasse types, creation of substates, result semantics, resolution/elimination/regeneration, Goal Dependency Set and chunking. Cite these source-specific details with \autocite{soar2025architecture,soar2025procedural}, alongside \FanLanCite{...} for Fan & Lan's reconstruction and B2 analysis. This is not a third theoretical foundation; it is the historical architecture source already cited within the primary paper.

### Citation discipline

Use the shared `\FanLanCite{...}` macro for the review's framing, mapping, hypothesis and validity claims. Use `\autocite{soar2025architecture,soar2025procedural}` only for the Soar-specific facts checked in that manual. Other named modern systems may appear only as cases that Fan & Lan explicitly include; do not turn them into separate theory chapters or assert mechanisms beyond the review's stated descriptions. Keep claims from the book-created Product X scenario and proposed runtime contracts labelled as such.

## 8. Explicit exclusions and chapter boundaries

- Do not treat every failed tool call, timeout or validation error as a Soar impasse.
- Do not suggest that Soar substates are simply OS processes, agent forks or immutable snapshots.
- Do not claim that the superstate is literally frozen in the same implementation sense as Fan & Lan's proposed parent-state freeze.
- Do not imply that a child result is any arbitrary text returned from a model; explain Soar's result linkage and the proposed typed-resolution contract separately.
- Do not say that an impasse always resolves. Preserve elimination and regeneration as distinct outcomes.
- Do not claim chunking occurs after every failed attempt or after impasse elimination/regeneration. Explain the manual nuance: the procedural-learning chapter says a chunk can be created as soon as a subgoal result is created, rather than waiting for final substate removal; relate this to the resolved-impasse learning opportunity without flattening the two descriptions.
- Do not equate Soar chunking with reflection memories, trajectory replay, retrieval-augmented prompting or generic skill storage.
- Do not claim PALADIN, AgentDebugX, Shepherd, AgentHER or Reflexion independently implements the full B2 chain.
- Do not treat E/D codes as one score or assign a single code to the whole B2 bundle; Chapter 11 owns their definitions.
- Do not turn the book's proposed resolution fields, controller authority, compile guards or Product X incident into statements attributed to Soar or Fan & Lan.
- Do not teach B3 workspace control, B4 intention governance, B5 skill governance or B6 global uncertainty/resource control in depth; point to Chapters 14–17.
- Do not claim B2 has been experimentally validated. The primary paper describes a research hypothesis and a proposed falsification protocol, not a completed comparative intervention.

## 9. Proposed depth and acceptance criteria

**Expected finished-chapter depth:** approximately 30–40 pages, with no fixed page-count target. The chapter should be long enough to explain the Soar mechanism accurately, reconstruct the B2 hypothesis, compare partial modern baselines, develop one worked example and teach the evaluation protocol without compressing the distinctions.

The chapter draft will be ready for review only when it:

1. Starts from the problem of safe recovery and introduces terms only when they are needed.
2. Teaches Soar's operator/preferences decision point before explaining typed impasses.
3. Describes the four impasse types and does not conflate them with generic execution exceptions.
4. Explains the substate/superstate relationship, result semantics and the distinction between resolution, elimination and regeneration.
5. Explains GDS dependency tracking and the dependency basis of chunking accurately.
6. Separates native Soar behavior from Fan & Lan's proposed modern execution-ledger design.
7. Reconstructs all four B2 invariants and their dependencies without changing the hypothesis into an asserted implementation standard.
8. Compares PALADIN, AgentDebugX, Shepherd, AgentHER and Reflexion only at the level supported by Fan & Lan.
9. Treats LangGraph, OpenHands, Magentic-One and Shepherd as insertion/state/branching boundaries rather than proof of complete B2.
10. Uses source-specific E/D statuses without redefining or collapsing the axes from Chapter 11.
11. Provides an internally coherent Product X example with an explicit `[Book example]` label.
12. Applies the seven-field tuple exactly as introduced in Chapter 10.
13. Preserves Fan & Lan's B2 trace, metrics, ablations and falsification conditions.
14. Distinguishes B2 from the in-scope/out-of-scope neighboring bundles, especially B5 and B6.
15. Includes a concrete theory-to-practice bridge with named component boundaries, typed contracts, a state machine, persistence/concurrency rules, external-side-effect safeguards, validation, dependency-aware rule compilation, and a vertical-slice build sequence.
16. Includes reference pseudocode and implementation-level tests; model output is not treated as runtime authority.
17. Uses the shared preamble, macros, semantic box policy, footnote citations, glossary/index, Mermaid sources and chapter-local artifact conventions.
18. Is built with XeLaTeX/Biber, passes scaffold/diagram/PDF checks and has its rendered pages and actual CI-generated diagrams visually inspected before final chapter PDF release.

## 10. Revision and drafting authorization

**Status: Revised to v2.0; chapter draft completed under the author-directed instruction.** The author directed that the outline be revised if the bridge was incomplete and that prose drafting begin immediately afterward, without another approval checkpoint. The chapter has been drafted against this active writing specification. It remains subject to real Mermaid rendering, CI XeLaTeX/Biber build, final PDF/figure inspection and repository integration before release.

---

## Primary reference

Fan, H., & Lan, Z. (2026). *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps*. arXiv:2607.23942v1, submitted 27 July 2026. Principal anchors: §III-A (Soar); §V-A (Soar mapping); §V-B (failure translation); §VI-B, Table V; §VI-C, B2 and Table VI; §VI-D; Figure 8; Appendices C-B, C-C, C-D, D, E-B and F-B/F-C.

\FanLanCite{\S III-A, Soar; \S V-A--V-B; \S VI-B, Table V; \S VI-C, B2 and Table VI; \S VI-D, Figure 8; Appendices C-B--C-D, D, E-B and F-B--F-C}
