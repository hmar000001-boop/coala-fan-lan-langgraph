# Chapter 22 — Typed Impasses and Protected Recovery: B2

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** III — Engineering a Simulated Supply-Chain Agentic Application with Java  
**Outline status:** approved by the author; Chapter 22 prose drafted and integrated for review  
**Implementation baseline:** accepted, CI-green supply-chain application; this chapter documents existing B2 behavior and does not authorize application-code changes  
**Chapter role:** trace one bounded recovery episode from a host-supplied typed impasse through child investigation, parent return, and the separately governed path by which an eligible result may become a reusable procedural-memory item.

---

## 1. Purpose and teaching contract

Chapter 22 is the implementation counterpart to Part II Chapter 13. Chapter 13 explains Fan & Lan's B2 hypothesis, its Soar lineage, the proposed parent/substate/result/compilation coupling, and the broader evaluation problem. Chapter 22 must not repeat that theoretical exposition or imply that the Java repository reproduces Soar's native substate, goal-dependency-set regeneration, or chunking.

The implementation story is narrower and more concrete. It follows a typed `ImpasseSignal` supplied by the application/domain lifecycle adapter; a versioned `ImpasseResolutionCase` bound to a parent request and working-memory version; a bounded child investigation using a small read-oriented capability allow-list; a typed `ChildResolutionResult`; a return check against the current parent snapshot; and, optionally, a governed procedure-draft and procedural-memory lifecycle.

The chapter must hold these boundaries throughout:

1. **A typed signal is not the same as an automatically classified raw failure.** The active lifecycle obtains an `ImpasseOpenRequest` from the host/domain port. Its `signal` is already typed. `DeterministicImpasseDetector` consolidates typed signals; it does not infer an impasse from free text or independently classify raw business facts in the active `openImpasse` path.
2. **The child is bounded and parent-linked, not an unrestricted second agent.** Its case records exact parent identity, delegated capabilities, a deadline and an action budget. Its fixed capability allow-list is read-oriented; the child result contains findings and assumptions, not a replacement parent objective, capability grant, or domain mutation.
3. **Parent-return validation is not a universal fact-verification pass.** The return path checks the parent scope, request, working-memory version and objective fingerprint, plus case/result identity and result timing. The dedicated `RecoveryDraftEvidenceVerifier` is invoked when a procedure draft is created and again at approval/staging/retrieval boundaries; do not move that responsibility backward into `validateImpasseReturn` in the prose.
4. **A resolved case is not automatically a proven business resolution or a reusable rule.** Current tests exercise `EVIDENCE_CONFIRMED` and `UNRESOLVED`. `HYPOTHESIS_PROPOSED` exists in the enum but is not exercised by the current tests; the case state maps every non-`UNRESOLVED` disposition to `RESOLVED`, and the draft service's eligibility check also treats every non-`UNRESOLVED` result as eligible. This semantic edge must be disclosed, not silently interpreted as verification.
5. **Drafting, approval, staging, validation, activation and retrieval are distinct transitions.** The host supplies the typed draft request. The procedure service uses registered action descriptors, opaque condition keys and evidence references; it does not parse narrative findings into executable action instructions. B2 approval permits staging only. Independent procedural validation and activation remain required. Retrieved procedures are planning knowledge, not dispatched actions.
6. **The application is a bounded engineering realization.** No claim of full Soar reproduction, automatic chunking, GraSP-style skill-DAG compilation, or generalizable learning follows from a successful child investigation.

Use one continuous supply-chain incident as a teaching thread, but identify book-created details as **[Book example]** unless an exact fixture/test demonstrates them. Do not reuse Product X or its payment-timeout example from Part II Chapter 13.

## 2. Learning outcomes

By the end of Chapter 22, readers should be able to:

1. Explain why a blocked decision may require a typed, bounded child investigation rather than a blind retry, exception log, or generic reflection.
2. Distinguish an application-supplied `ImpasseSignal` from the `DeterministicImpasseDetector`'s typed-signal consolidation function.
3. Trace how `CognitiveCycleLifecycleServices.openImpasse` binds an impasse case to a `ParentContextSnapshot` and coordinates it with B4 intention delegation.
4. Explain the B2 case's parent identity, lifecycle status, fixed child capability allow-list, deadline and maximum child-action budget.
5. Trace the four-node `B2ResolutionSubgraph` and the host/domain ports that plan and execute child investigation steps.
6. Explain the difference between child-step receipt/fencing states, the case's action budget, and the outer LangGraph checkpoint.
7. State exactly what `validateImpasseReturn` validates—and what it does not verify at that point.
8. Distinguish `ResolutionDisposition` from `ImpasseCaseStatus`, including the untested `HYPOTHESIS_PROPOSED` edge.
9. Follow an optional typed recovery-procedure draft through evidence verification, trusted approval, immutable artifact staging, independent procedural validation/activation, and active retrieval.
10. Identify the B2/B4 authority boundary, the B6 uncertainty-refresh seam, the CoALA procedural-memory boundary, and the later full-graph composition boundary.
11. Read the relevant tests without overstating their coverage or treating CI success as evidence of causal improvement.

## 3. Continuity with the surrounding chapters

### 3.1 What Chapters 19–21 have already established

- **Chapter 19** has established the supply-chain domain vocabulary, deterministic simulator, typed perception/grounding actions, module boundaries and action-dispatch/authorization boundary. Chapter 22 must not re-explain inventory/order/supplier domain modeling, simulator transitions, or the general dispatcher.
- **Chapter 20** has established the CoALA memory responsibilities and internal/external action contracts. It also explains the general procedural-memory lifecycle and the distinction between an artifact reference and an executable action. Chapter 22 should discuss only the B2-specific draft-to-procedure bridge and cross-reference Chapter 20 for the underlying CoALA memory model.
- **Chapter 21** has established B1 memory selection and B3 workspace competition/broadcast, including the fact that an approved recovery procedure can later become a B1 retrieval candidate. Chapter 22 should not re-teach B1 feature learning, B3 coalition selection, receipts, or feedback attribution. Use one short cross-reference when the B2 procedure reaches procedural memory and later retrieval.

The closing sentence of Chapter 21 is tightened to describe the actual B2 parent-return identity checks and the separate evidence checks performed when a reusable procedure is proposed. This is a one-sentence continuity edit; no Chapter 20 content is changed.

### 3.2 What Part II has already established

- **Chapter 10:** use S/C/T/P/F/L/R as a disciplined analytical lens. Do not redefine all seven fields.
- **Chapter 13:** owns the Soar historical account, its typed operator-selection impasses, substates/results/dependencies/chunking, modern baseline analysis, the general B2 hypothesis, Product X, proposed reference contracts, and the broader experiment protocol. Chapter 22 should state only the implementation correspondences and deviations needed to read the Java system.
- **Chapter 15:** owns B4's persistent intention and method authority. Chapter 22 should show only the B2 delegation/return seam.
- **Chapter 18:** owns the proposed cross-bundle composition and its research-level dependency/ablation questions. Chapter 22 should not claim the presence of connected services proves the proposed composition hypothesis.

Do not repeat the Soar four-impasse taxonomy, modern-system survey, Product X payment scenario, or Chapter 13's proposed implementation blueprint. The Part III contribution is source-level implementation detail and honest limits.

### 3.3 What Chapters 23–24 reserve

- **Chapter 23 (outline only at this stage)** owns B4 intention state/method authority and B6 uncertainty/resource/interruption governance. Chapter 22 may explain how B2 delegates to and returns from the active B4 intention, and that the B2 subgraph refreshes uncertainty after investigation. It must defer the full B4 and B6 service/graph treatment to Chapter 23.
- **Chapter 24 (outline only at this stage)** owns full `CognitiveCycleGraph` routing, `CognitiveCycleApplicationGraph`, durable-host assembly, PostgreSQL/checkpoint composition, and the end-to-end simulated workflow. Chapter 22 may show the B2 subgraph and its B2-specific persistence ports, but must defer the whole-agent graph and complete business trace to Chapter 24.

The Chapter 23 and 24 documents reviewed for this outline are proposals, not drafted chapters. They define planned boundaries; they are not evidence that their prose or future implementations already exist.

## 4. Detailed section outline

### Opening — Chapter at a glance

State the chapter's central question: how can the application investigate a local blocker while preserving the parent request and preventing a child result from silently acquiring broader authority? Preview the vertical slice: typed signal → case bound to parent snapshot → B4 delegation and child start → bounded read investigation → uncertainty refresh → parent-return validation → optional recovery-procedure draft → separately governed procedural lifecycle.

Use a compact note that this is an implementation walk-through, not an additional theoretical model. Keep terminology consistent with Part II Chapter 13, but immediately distinguish the implemented Java contracts from the Soar mechanism.

### 22.1 A blocked decision is not yet a recovery policy

**Teaching question:** what does the runtime need beyond a failure message or another attempt?

- Use a supply-chain example in which a planning/evaluation step cannot proceed because a required supplier, inventory, shipment, quality or feasibility fact is unresolved. Keep the parent fulfilment request unchanged while a local read-only investigation is opened.
- Contrast a blind retry, a generic failure log, and a B2-style typed child investigation. Do not claim that B2 replaces every retry; known transient, idempotent operations can still use ordinary retry policies.
- State the parent-child invariant: the child investigates a bounded subproblem for the existing parent. It does not own the parent objective, add capabilities to itself, or dispatch a supply-chain write.
- Make the difference from Part II explicit: Chapter 13's Soar impasse is an operator-selection condition in Soar; this application uses its own typed failure vocabulary and runtime trigger. The analogy is useful but not identity.

**Boundary:** no Soar history, Product X, generic recovery framework tutorial, or simulator recap.

### 22.2 Typed signal, versioned case and the parent snapshot

**Teaching question:** what data makes a recovery episode identifiable and safe to return?

Introduce the actual contracts:

- `ImpasseType`: `CONFLICTING_EVIDENCE`, `MISSING_CONFIRMATION`, `NO_FEASIBLE_CANDIDATE`, `MISSING_DEPENDENCY`, `QUALIFICATION_MISMATCH`, `STALE_ASSUMPTION`, and `UNRESOLVED_PRECONDITION`.
- `ImpasseSeverity`: `LOW`, `MEDIUM`, `HIGH`, `CRITICAL`.
- `ImpasseSignal`: type, severity, subject reference, summary, evidence references and detection time; its stable key is the type plus subject reference.
- `ImpasseResolutionCase`: case ID, scope, execution ID, parent request ID, parent working-memory version, objective fingerprint, signal, delegated child capabilities, opened/deadline times, maximum/used child actions, status, optimistic version, optional result and terminal reason.
- `ParentContextSnapshot`: exactly scope ID, request ID, working-memory version and objective fingerprint. It is an identity/version record, not a copy of the parent objective, working-memory contents or capability grant.
- `ChildResolutionResult`: case ID, parent request/version/fingerprint, disposition, findings, assumptions and produced-at time. It deliberately contains no parent objective, capability set or domain mutation.

Explain the case states `OPEN`, `INVESTIGATING`, `RESOLVED`, `REJECTED`, `ESCALATED`, `EXPIRED`, and distinguish them from the result dispositions `EVIDENCE_CONFIRMED`, `HYPOTHESIS_PROPOSED`, `UNRESOLVED`.

**Important detector boundary:** `DeterministicImpasseDetector.consolidate` accepts already typed signals. It groups by stable key, combines evidence, retains the higher-severity signal's descriptive fields, keeps the latest detection time, and sorts the result. It does not infer a type from free text. `ImpasseResolutionService.detect` exposes this consolidation. In the active runtime open path, the lifecycle calls `domain.impasseOpenRequest(...)` and uses the request's typed signal directly; do not write that the detector is automatically invoked to classify every live impasse.

**Code anchors:**
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ImpasseSignal.java`
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ImpasseType.java`, `ImpasseSeverity.java`, `ImpasseCaseStatus.java`
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ParentContextSnapshot.java`, `ImpasseResolutionCase.java`, `ChildResolutionResult.java`, `ResolutionDisposition.java`
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/DeterministicImpasseDetector.java`, `ImpasseResolutionService.java`

**Tests:**
- `ImpasseResolutionServiceTest.detectorConsolidatesDuplicateSignalsAndKeepsHighestSeverity`
- `ImpasseResolutionServiceTest.childScopeMustMatchParentScope`
- `ImpasseResolutionServiceTest.childCapabilitiesMustBeSubsetOfParent`
- `ImpasseResolutionServiceTest.childCapabilitiesCannotContainAnyWriteCapability`

**Boundary:** do not imply a full temporal/dependency engine or a Soar-style goal dependency set; the parent snapshot contains four identifiers/versions only.

### 22.3 Opening B2 and delegating the parent intention to a child

**Teaching question:** how are the B2 case transition and B4 delegation coordinated?

Trace `CognitiveCycleLifecycleServices.openImpasse` in source order:

1. require the current uncertainty reference and load the current working-memory snapshot and intention;
2. call the host/domain `impasseOpenRequest(context, now)` port to obtain a typed signal, parent and child capability sets, deadline and maximum child actions;
3. capture `ParentContextSnapshot` from the active memory scope/version, current request ID and host/domain objective fingerprint;
4. open the B2 case after enforcing same-scope binding, child-capability subset of parent grant, and the case's fixed child allow-list;
5. require the current B4 intention to be `ACTIVE` at the expected version;
6. delegate the intention to the opened B2 case, then start the case as `INVESTIGATING`;
7. if the coordinated start fails, attempt compensating transitions: reject an open/investigating case and return the intention from delegation with `NO_METHOD_CHANGE` when the exact delegation is still active.

Be exact about atomicity: these are separate service/repository transitions with explicit compensation, not a single cross-repository transaction. Compensation itself can fail; failures are attached/surfaced rather than proving that the two records are globally atomic.

Introduce the control handoff without teaching B4: B2 owns the child investigation; B4 remains the authority over the parent intention/objective. Chapter 23 will explain B4 transitions and authority in full.

**Code anchors:**
- `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/lifecycle/CognitiveCycleLifecycleServices.java` — `openImpasse`
- `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/lifecycle/CognitiveCycleLifecyclePort.java` — `ImpasseOpenRequest` and `impasseOpenRequest` port
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b4/RecoveryIntentionService.java` — `delegate` and `returnFromDelegation` (short excerpts only)
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ImpasseResolutionService.java` — `open` and `start`

**Tests:**
- `CognitiveCycleLifecycleServicesTest.b2ResolutionRunsOnlyDeclaredChildCapabilitiesAndReturnsToParentIntention`
- `CognitiveCycleLifecycleServicesTest.b2ChildCannotExecuteACapabilityOutsideItsDelegatedScope`
- `ImpasseResolutionServiceTest.childScopeMustMatchParentScope`

**Boundary:** do not reproduce the B4 state machine, planner method authority, or the full graph's conditional routing; these belong to Chapters 23 and 24.

### 22.4 Investigating inside the bounded child boundary

**Teaching question:** what does the child actually receive and what can it do?

Explain the restrictions encoded in `ImpasseResolutionCase`:

- the child capability set must be a subset of the parent grant;
- the fixed allow-list contains `MEMORY_RETRIEVE`, `REASONING_INVOKE`, `SUPPLIER_READ`, `INVENTORY_READ`, `ORDER_READ`, `SHIPMENT_READ`, and `QUALITY_READ`;
- each case has a deadline and maximum child-action count;
- `recordAction` is legal only while `INVESTIGATING`, within the delegated set and before the budget is exhausted.

Then trace `CognitiveCycleLifecycleServices.investigateImpasse`:

1. load the case and verify that its execution and parent request match the active cycle;
2. ask the host/domain `planChildInvestigation` port for a typed `ChildInvestigationPlan` containing explicit `ChildInvestigationStep` records, intended disposition, assumptions and an intention return;
3. reject duplicate step IDs and any step capability not present in the case;
4. when the optional child-step store is configured, claim the step using a fingerprint bound to case/execution/parent version/objective and step definition;
5. reuse findings from `COMPLETED`; reject `IN_PROGRESS`; reject `UNKNOWN_OUTCOME` until explicit reconciliation; use the acquired fencing token for the step;
6. record the B2 child-action budget before invoking the domain's read-only `executeChildInvestigationStep` port; then complete or fail the step receipt;
7. if no findings were returned, downgrade the disposition to `UNRESOLVED`; findings paired with an `UNRESOLVED` plan are rejected; save the typed result and intention-return artifact.

Explain the two separate limits: the B2 case's maximum child action count is the mechanism-level allowance, while the step store's claim/fencing lifecycle prevents duplicate/reordered work when that store is wired. Do not conflate either with LangGraph graph recursion limits or the outer checkpoint.

**Subgraph sequence:** `B2ResolutionSubgraph` has four linear nodes: `open-child` → `investigate-child` → `refresh-uncertainty-after-investigation` → `validate-parent-return`. It validates that the uncertainty assessment advances exactly one revision for the same execution and scope. Its state carries parent-context references and IDs, not a copy of the parent objective, full memory contents, or capability set. Capability authority remains in the B2 case/services. The subgraph uses a fresh generated thread ID and the source's shown compile path does not attach a separate dedicated B2 checkpointer; distinguish this graph state from the durable B2 case/step/artifact stores and the outer graph checkpoint discussed in Chapter 24.

**Code anchors:**
- `CognitiveCycleLifecycleServices.java` — `investigateImpasse`
- `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/lifecycle/CognitiveCycleLifecyclePort.java` — `ChildInvestigationStep`, `ChildInvestigationPlan`, planning/execution ports
- `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/B2ResolutionSubgraph.java`, `B2ResolutionGraphState.java`
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ImpasseResolutionCase.java` — allow-list, deadline and action budget
- `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/lifecycle/ChildInvestigationStepStore.java`
- `supply-chain-agent-infrastructure-postgres/src/main/java/dev/supplychain/agent/infrastructure/postgres/runtime/PostgresB2ChildStepReceiptStore.java`

**Tests:**
- `ImpasseResolutionServiceTest.childActionBudgetAndCapabilityAreEnforced`
- `ImpasseResolutionServiceTest.childCannotExceedActionBudget`
- `PostgresM7B2CoreIntegrationTest.childStepReceiptsResumeCompletedWorkAndFenceExpiredClaims`
- lifecycle test `b2ResolutionRunsOnlyDeclaredChildCapabilitiesAndReturnsToParentIntention`

**Boundary:** no child write actions, no claim that the subgraph is a separately durable agent, and no claim that a checkpoint by itself gives B2 typed semantics.

### 22.5 Returning a result: parent identity, disposition and verification are different

**Teaching question:** what is established when the child finishes, and what remains unproven?

Trace `CognitiveCycleLifecycleServices.validateImpasseReturn` and `ImpasseResolutionCase.resolve`:

- require the saved child artifact;
- reload the current B2 case and current working-memory snapshot;
- ask the domain for a `ParentContextSnapshot` and verify that it agrees with the authoritative working-memory scope/version and current request/objective fingerprint;
- call `ImpasseResolutionService.resolve`, which checks the case's parent scope/request/working-memory version/objective fingerprint against the current parent; checks result case/request/version/fingerprint identity; checks the result timestamp lies within the case interval; and uses an optimistic case-version update;
- return the delegated B4 intention with the artifact's `DelegationReturn` only if the case ID matches the active delegation.

Make the distinction explicit:

- **Parent-return identity validation:** protects against returning a child result to a changed/different parent snapshot.
- **Result structural checks:** ensure the result is bound to the expected case and includes findings for a positive disposition; unresolved results cannot claim findings.
- **Evidence verification for reuse:** the return method does not itself call `RecoveryDraftEvidenceVerifier`. Evidence scope/freshness checks are applied in `RecoveryProcedureDraftService.createDraft`, approval and later promotion/retrieval paths.
- **Business truth:** the code's parent/version checks do not independently prove every narrative finding correct. Findings remain evidence references and assumptions from the host/domain child investigation.

Discuss `ResolutionDisposition` versus `ImpasseCaseStatus`. `ImpasseResolutionCase.resolve` maps `UNRESOLVED` to `ESCALATED`; every non-`UNRESOLVED` disposition maps to `RESOLVED`. `HYPOTHESIS_PROPOSED` is declared but is not used by current B2 tests or production call sites found in the source snapshot. `RecoveryProcedureDraftService.createDraft` excludes `UNRESOLVED` but does not separately exclude `HYPOTHESIS_PROPOSED`. Therefore the chapter must not equate the status label `RESOLVED` with verified fact or say that the hypothesis disposition has a tested safe promotion path. State this as an explicit implementation limitation/test gap, not as an assumed behavior.

**Code anchors:**
- `CognitiveCycleLifecycleServices.java` — `validateImpasseReturn`
- `ImpasseResolutionCase.java` — `resolve`
- `ChildResolutionResult.java`, `ResolutionDisposition.java`, `ImpasseCaseStatus.java`
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/RecoveryDraftEvidenceVerifier.java` — mention only as a later procedure-lifecycle boundary

**Tests:**
- `ImpasseResolutionServiceTest.evidenceBackedChildResultCompletesOnlyTheSubstate`
- `ImpasseResolutionServiceTest.staleParentVersionRejectsChildResult`
- `ImpasseResolutionServiceTest.unresolvedChildEscalatesInsteadOfClaimingResolution`
- `ImpasseResolutionServiceTest.caseExpiresAtDeadlineAndCannotContinue`
- `ImpasseResolutionServiceTest.optimisticVersionConflictIsRejected`

**Boundary:** do not state that the parent-return method validates generic dependencies/postconditions or that every finding has just been independently reverified.

### 22.6 A recovery-procedure draft is a proposal, not an executable skill

**Teaching question:** what additional contracts are required before a case result can become a reusable procedure proposal?

Explain that `RecoveryProcedureDraftRequestFactory` is a host-owned port. It may return no proposal at all; a resolved episode does not force procedure drafting. When a request is supplied, `RecoveryProcedureDraftService.createDraft`:

- checks the exact B2 case version and `RESOLVED` status;
- checks exact scope, parent request, working-memory version and objective fingerprint;
- checks the draft expiry against the case interval;
- extracts distinct evidence references from findings and calls `RecoveryDraftEvidenceVerifier` to reject missing, stale or foreign-scope evidence;
- maps requested action IDs to current registered action descriptors;
- preserves opaque condition/precondition/expected-postcondition/failure-condition keys, evidence references, source fingerprint and parent identity in a typed draft;
- enforces idempotency for an exact source and rejects reuse of a draft ID for a different proposal.

Explain the negative design rule: findings' narrative summaries are not parsed into action IDs, parameters or executable instructions. The request factory and trusted action registry supply the typed proposal structure. The draft is a non-executable proposal artifact.

**Code anchors:**
- `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/lifecycle/RecoveryProcedureDraftRequestFactory.java` — host-owned proposal port
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/RecoveryProcedureDraftRequest.java`, `RecoveryProcedureDraft.java`
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/RecoveryProcedureDraftService.java` — `createDraft`
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/RecoveryProcedureActionReferences.java`, `RegisteredRecoveryActionReference.java`
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/RecoveryDraftEvidenceVerifier.java`

**Tests:**
- `RecoveryProcedureDraftServiceTest.createsAnEvidenceBoundNonExecutableDraftFromResolvedCaseAndRegisteredActions`
- `RecoveryProcedureDraftServiceTest.createIsIdempotentForTheExactSourceAndRejectsConflictingReuse`
- `RecoveryProcedureDraftServiceTest.unknownOrUnregisteredActionsCannotBecomeProcedureSteps`
- `RecoveryProcedureDraftServiceTest.freeFormNarrativeIsNotAcceptedAsAnExecutableConditionKey`

**Boundary:** do not call draft creation automatic chunking, a compiled policy, a production skill, or GraSP.

### 22.7 Approval, staging, validation and activation are separate

**Teaching question:** why does a draft not become active procedural memory immediately?

Trace the two distinct governance layers:

1. `RecoveryProcedureDraftService.approve` checks current draft version, current parent identity, fresh evidence, unchanged registered action descriptors, approval timestamp and injected `RecoveryProcedureApprovalAuthority`; it changes review state only and does not execute actions.
2. `RecoveryProcedurePromotionService.stageApprovedDraft` accepts only an approved, unexpired, exact-scope draft at the expected version; re-verifies evidence and action descriptors; publishes an immutable recovery artifact; then stages a CoALA `ProcedureVersion` of kind `RUNBOOK` and status `DRAFT` in procedural memory. Exact retries are idempotent; concurrent version appends are retried only within the service's fixed bound.
3. `validate` requires a reviewer independent of the draft creator/approver and transitions the procedure through the procedural-memory lifecycle.
4. `activate` requires `VALIDATED` status and an actor independent of both the draft approver and reviewer.
5. `retrieveActive` returns only an `ACTIVE` runbook for the exact memory scope and opaque condition key; it rechecks artifact identity/provenance, evidence freshness and current action descriptors. It returns planning knowledge and never dispatches an action.

Cross-reference Chapter 20 for CoALA's general procedural-memory semantics and Chapter 21 for the test showing an approved recovery procedure later becomes a standard B1 retrieval candidate. Do not re-explain either mechanism.

**Code anchors:**
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/RecoveryProcedureDraftService.java` — `approve`
- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/RecoveryProcedurePromotionService.java` — `stageApprovedDraft`, `validate`, `activate`, `retrieveActive`
- `supply-chain-agent-infrastructure-postgres/src/main/java/dev/supplychain/agent/infrastructure/postgres/runtime/PostgresRecoveryProcedureDraftRepository.java`
- `supply-chain-agent-infrastructure-postgres/src/main/java/dev/supplychain/agent/infrastructure/postgres/memory/PostgresRecoveryProcedureArtifactStore.java`
- `supply-chain-agent-memory/src/main/java/dev/supplychain/agent/memory/procedural/ProceduralMemoryService.java`, relevant `ProcedureVersion` status transitions (short cross-reference to Chapter 20)

**Tests:**
- `RecoveryProcedureDraftServiceTest.approvalRequiresCurrentParentEvidenceAndTrustedOperatorAuthority`
- `RecoveryProcedureDraftServiceTest.unauthorizedApprovalFailsClosed`
- `RecoveryProcedureDraftServiceTest.approvalCannotCrossParentVersionOrObjectiveChange`
- `RecoveryProcedurePromotionServiceTest.b2ApprovalStagesOnlyADraftAndIndependentProceduralLifecycleIsRequired`
- `RecoveryProcedurePromotionServiceTest.repeatedPromotionOfTheSameApprovedDraftIsIdempotent`
- `RecoveryProcedurePromotionServiceTest.unapprovedExpiredOrForeignScopeDraftCannotBePromoted`
- `RecoveryProcedurePromotionServiceTest.staleEvidenceOrChangedActionDescriptorBlocksPromotion`
- `RecoveryProcedurePromotionServiceTest.laterRetrievalRejectsChangedActionDescriptorAndForeignScope`
- `RecoveryProcedurePromotionServiceTest.approvedRecoveryProcedureBecomesAStandardCoalaB1RetrievalCandidate`
- `RecoveryProcedurePromotionServiceTest.proceduralReviewerAndApproverMustBeIndependentActors`

**Boundary:** no autoactivation, no direct action execution, and no claim that a B2 draft is equivalent to Soar chunking or GraSP skill-DAG compilation.

### 22.8 Persistence and the seven-field reading of B2

**Teaching question:** which state is durable, which state is a graph reference, and where do the seven analytical fields land?

First, describe only B2-specific persistence:

- `PostgresImpasseCaseRepository` persists versioned cases and compare-and-set transitions.
- `PostgresB2ChildStepReceiptStore` persists child-step claim/completion/fencing records.
- `PostgresImpasseChildArtifactStore` persists the typed child result and intention-return artifact.
- `PostgresRecoveryProcedureDraftRepository` persists draft/approval state.
- `PostgresRecoveryProcedureArtifactStore` persists immutable procedure artifacts.
- CoALA procedural-memory persistence stores the staged/validated/active `ProcedureVersion` through the memory infrastructure.

Use `PostgresM7B2CoreIntegrationTest` to establish that child-step receipts resume completed work/fence expired claims, and that child artifacts/cases survive repository replacement and compare-and-set. Do not expand into a full PostgreSQL schema tutorial; Chapter 24 owns the whole persistence map.

Then provide a concise S/C/T/P/F/L/R table:

| Field | B2 implementation reading | Qualification |
|---|---|---|
| S — state substrate | typed signal, parent snapshot, versioned impasse case, child-step receipts/artifact, optional draft/artifact and procedural version | parent snapshot is an identity tuple, not a full copy of parent state |
| C — control locus | host/domain supplies typed signal and child plan; lifecycle/services enforce case/return invariants; B4 owns the parent intention; subgraph sequences the calls | detector consolidates typed signals; active open path consumes the supplied typed signal |
| T — trigger | graph routes a blocked cycle into the B2 subgraph; lifecycle opens the case | full graph routing belongs to Chapter 24 |
| P — persistence | PostgreSQL-backed B2 records plus outer graph checkpoint references | no separate B2 subgraph checkpointer is shown; do not conflate graph state with B2 authoritative records |
| F — failure semantics | stale/wrong parent, wrong case, forbidden capability, exhausted budget, expired case, duplicate/in-progress/unknown step, unresolved escalation, CAS conflict | B2/B4 startup uses compensating transitions, not a distributed atomic transaction |
| L — learning operator | optional typed draft, trusted approval, immutable artifact, separate procedure validation/activation, active retrieval | no automatic chunking; a successful episode may produce no draft and a draft is not active memory |
| R — resource/governance | fixed child allow-list, parent capability subset, deadline, child-action limit, step fencing, same-scope checks, uncertainty refresh | B2 local limits are not a substitute for B6's broader resource/interrupt authority, taught in Chapter 23 |

**Code anchors:**
- `supply-chain-agent-infrastructure-postgres/src/main/java/dev/supplychain/agent/infrastructure/postgres/runtime/PostgresImpasseCaseRepository.java`
- `supply-chain-agent-infrastructure-postgres/src/main/java/dev/supplychain/agent/infrastructure/postgres/runtime/PostgresB2ChildStepReceiptStore.java`
- `supply-chain-agent-infrastructure-postgres/src/main/java/dev/supplychain/agent/infrastructure/postgres/runtime/PostgresImpasseChildArtifactStore.java`
- `supply-chain-agent-infrastructure-postgres/src/main/java/dev/supplychain/agent/infrastructure/postgres/runtime/PostgresRecoveryProcedureDraftRepository.java`
- `supply-chain-agent-infrastructure-postgres/src/main/java/dev/supplychain/agent/infrastructure/postgres/memory/PostgresRecoveryProcedureArtifactStore.java`
- `supply-chain-agent-app/src/main/java/dev/supplychain/agent/app/durable/DurableCognitiveApplicationHost.java` — wiring only, not a full host tutorial
- `supply-chain-agent-runtime/src/main/java/dev/supplychain/agent/runtime/cognitive/B2ResolutionSubgraph.java`
- `supply-chain-agent-infrastructure-postgres/src/test/java/dev/supplychain/agent/infrastructure/postgres/runtime/PostgresM7B2CoreIntegrationTest.java`

**Tests:**
- `PostgresM7B2CoreIntegrationTest.childStepReceiptsResumeCompletedWorkAndFenceExpiredClaims`
- `PostgresM7B2CoreIntegrationTest.childArtifactsAndImpasseCasesSurviveRepositoryReplacementAndCas`

**Boundary:** Chapter 24 owns the complete host/checkpoint/memory/runtime persistence topology. Keep this section to B2's own records and the distinction between those records and graph state.

### 22.9 Failure semantics, implementation limits and open edges

Organize this as an evidence-based table with columns: condition, current control, observable result, what the code/test does not establish.

Required cases:

- a duplicate typed signal is consolidated by stable key; this is not raw failure diagnosis;
- a child capability exceeds parent grant or fixed allow-list: case opening/step validation rejects it;
- child action budget exhausted or deadline reached: case methods reject/expire; no automatic extension;
- parent scope/request/working-memory version/objective fingerprint changes: return fails closed;
- wrong case/result identity or timestamp interval: typed return is rejected;
- child step duplicate: duplicate plan ID rejected; durable store can reuse completed findings, reject in-progress, or require reconciliation for unknown outcome;
- B2 case opens but B4 delegation/start fails: compensation is attempted; no cross-store atomic guarantee;
- child returns no findings: result is `UNRESOLVED` and case escalates;
- finding evidence stale/foreign: rejected when a recovery draft is requested and at later governance stages, not by the bare parent identity check alone;
- action descriptor changes after draft: approval/promotion/retrieval revalidation rejects it;
- `HYPOTHESIS_PROPOSED`: declared but untested and currently mapped to `RESOLVED` by the case transition; do not present as an exercised safe path to a reusable procedure;
- host factories and verifiers are injected/optional at composition boundaries: a missing draft service or empty factory proposal means no draft is produced.

Close with implementation limits that matter for the B2 comparison:

- no claim of Soar's full superstate/substate architecture or Goal Dependency Set regeneration;
- no parent objective or full memory copy inside `B2ResolutionGraphState`;
- no state-changing child action in the fixed allow-list;
- no automatic business-fact truth verification at parent return;
- no automatic procedure compilation/chunking or promotion;
- no current test of the `HYPOTHESIS_PROPOSED` positive-result path;
- no experiment in this chapter establishing that B2 improves success, recovery time, or generalization.

### 22.10 Tests, recap and practical exercises

Use a compact test-to-claim table. Each test row must say what it demonstrates and one boundary.

**Core mechanism and case tests**
- `ImpasseResolutionServiceTest.detectorConsolidatesDuplicateSignalsAndKeepsHighestSeverity` — typed-signal consolidation only, not classification of raw facts.
- `ImpasseResolutionServiceTest.childCapabilitiesMustBeSubsetOfParent` — no authority expansion.
- `ImpasseResolutionServiceTest.childCapabilitiesCannotContainAnyWriteCapability` — fixed no-write boundary.
- `ImpasseResolutionServiceTest.childActionBudgetAndCapabilityAreEnforced` and `childCannotExceedActionBudget` — per-case child action limit.
- `ImpasseResolutionServiceTest.evidenceBackedChildResultCompletesOnlyTheSubstate` — case/substate transition, not proof that parent business objective completed.
- `ImpasseResolutionServiceTest.staleParentVersionRejectsChildResult` — parent version protection.
- `ImpasseResolutionServiceTest.unresolvedChildEscalatesInsteadOfClaimingResolution` — unresolved is explicit.
- `ImpasseResolutionServiceTest.caseExpiresAtDeadlineAndCannotContinue` — deadline.
- `ImpasseResolutionServiceTest.optimisticVersionConflictIsRejected` — case CAS.

**Lifecycle, procedure and persistence tests**
- `CognitiveCycleLifecycleServicesTest.b2ResolutionRunsOnlyDeclaredChildCapabilitiesAndReturnsToParentIntention` — read-only delegated investigation and B4 return; not the full B4 chapter.
- `CognitiveCycleLifecycleServicesTest.b2ChildCannotExecuteACapabilityOutsideItsDelegatedScope` — undelegated action rejected.
- `RecoveryProcedureDraftServiceTest` methods listed in Sections 22.6–22.7 — evidence-bound typed proposal, idempotency and approval gate; not active procedure execution.
- `RecoveryProcedurePromotionServiceTest` methods listed in Section 22.7 — staged/validated/activated/retrieved lifecycle; not automatic chunking or a generalized skill learner.
- `PostgresM7B2CoreIntegrationTest.childStepReceiptsResumeCompletedWorkAndFenceExpiredClaims` and `childArtifactsAndImpasseCasesSurviveRepositoryReplacementAndCas` — targeted PostgreSQL persistence/CAS; not the full application graph restart.
- `supply-chain-agent-evaluation/src/test/java/dev/supplychain/agent/evaluation/M8B4FullGraphWorkflowTest.java` — `fullGraphResolvedB2ReturnCreatesTypedRecoveryDraftAndCarriesReference` reaches a typed recovery draft and carries its reference; it does not approve, stage, validate or activate that draft.

The other focused test classes are located at:
- `supply-chain-agent-mechanisms/src/test/java/dev/supplychain/agent/mechanisms/b2/ImpasseResolutionServiceTest.java`
- `supply-chain-agent-runtime/src/test/java/dev/supplychain/agent/runtime/cognitive/lifecycle/CognitiveCycleLifecycleServicesTest.java`
- `supply-chain-agent-mechanisms/src/test/java/dev/supplychain/agent/mechanisms/b2/RecoveryProcedureDraftServiceTest.java`
- `supply-chain-agent-mechanisms/src/test/java/dev/supplychain/agent/mechanisms/b2/RecoveryProcedurePromotionServiceTest.java`
- `supply-chain-agent-infrastructure-postgres/src/test/java/dev/supplychain/agent/infrastructure/postgres/runtime/PostgresM7B2CoreIntegrationTest.java`

CI green confirms the tested source/build contracts for the accepted application baseline. It does not independently establish experimental benefit or validate untested disposition paths.

**Review questions** should ask readers to:
1. distinguish raw failure, typed signal and consolidated signal;
2. list the fields in `ParentContextSnapshot` and explain why they do not constitute a full state snapshot;
3. trace the B4 delegation/compensation sequence;
4. enumerate the child allow-list and explain the separate action-count/deadline limits;
5. explain what `UNKNOWN_OUTCOME` means for a claimed child step;
6. distinguish `ResolutionDisposition` and `ImpasseCaseStatus`;
7. explain precisely which checks happen at parent return versus draft creation/approval;
8. explain why a `DRAFT` recovery item is not active CoALA procedural memory;
9. explain why active retrieval yields planning knowledge but does not execute actions;
10. identify what evidence is missing for `HYPOTHESIS_PROPOSED`.

**Practical exercise [Book example]:** create a typed `MISSING_CONFIRMATION` or `NO_FEASIBLE_CANDIDATE` signal for a supply-chain planning blocker. Define its parent snapshot, parent capability set, child subset, deadline and action budget. Propose two read-only child steps, one supported by a completed receipt and one with an unknown outcome. Walk through the result and parent-return checks. Then specify whether the findings justify no procedure, a draft proposal, or escalation. If drafting, provide registered action IDs, opaque condition keys and evidence references; explain which verifier/authority boundaries still need to pass before activation.

## 5. Recommended diagrams

1. **Parent and child ownership map:** parent objective/intention remains authoritative; child case stores a parent identity snapshot and delegated capability subset. Avoid drawing the child as a copy of the full parent state.
2. **Actual B2 subgraph sequence:** `open-child` → `investigate-child` → `refresh-uncertainty-after-investigation` → `validate-parent-return`; show B4 delegation/return at the lifecycle boundary.
3. **Child-step governance sequence:** plan → claim → budget record → read-only execution → complete/fail receipt; distinguish `COMPLETED`, `IN_PROGRESS`, `UNKNOWN_OUTCOME`, and acquired/fenced states.
4. **Two validation boundaries:** parent identity/result checks at return, then evidence freshness/scope and action-descriptor checks during procedure draft/approval/promotion/retrieval.
5. **Recovery reuse lifecycle:** resolved case → optional typed draft → authorized draft approval → immutable artifact + CoALA procedural `DRAFT` → independent validation → independent activation → exact-scope/condition retrieval as planning knowledge.

Each diagram must be sourced to the exact implementation classes and not visually imply full Soar substate equivalence, automatic compilation, or child write authority.

## 6. Code presentation standards

- Present one vertical slice: contracts → lifecycle open → child investigation → return → optional draft/governance.
- Keep code blocks short and include repository-relative path, exact method name, the invariant the excerpt demonstrates, and one exact test assertion.
- Do not reproduce the full B2 case class, lifecycle service, SQL migration, or procedural-memory service.
- Use one successful evidence-backed path and one unresolved/stale/forbidden-capability path.
- When code is host-supplied through a port, label it as an adapter input rather than claiming that the mechanism service generates the typed request itself.
- Distinguish the LangGraph4j subgraph state from `ImpasseResolutionCase`, child-step receipts, child artifact and outer cognitive-cycle checkpoint.

## 7. Source and theory boundary

Use Fan & Lan for the B2 residual mechanism and its proposed coupling, especially Part II Chapter 13's source map: typed diagnosis, protected recovery substate, typed result and guarded reuse; use Chapter 10 only for the seven-field analytical vocabulary and Chapter 18 only for cross-bundle dependency context. Use CoALA only for procedural memory concepts already introduced in Part I/Chapter 20. The Java class layout, fixed capability allow-list, status enum, host ports, LangGraph4j node sequence, PostgreSQL repositories, action descriptors and approval services are application engineering choices, not prescriptions from CoALA or Fan & Lan.

Use the formal book labels `[CoALA]` and `[Fan & Lan]`; do not introduce a third theoretical foundation. Do not cite Part II's Product X example as if it were the Part III supply-chain scenario.

## 8. Chapter acceptance criteria and author decision

The author approved this outline. The completed Chapter 22 prose must:

- match the accepted, CI-green supply-chain implementation without proposing application changes;
- avoid repeating Chapter 13's theory or Chapters 19–21's domain/memory/B1/B3 content;
- coordinate the B2/B4 boundary with Chapter 23 and defer full graph/persistence composition to Chapter 24;
- correctly distinguish typed-signal consolidation from classification, parent identity validation from evidence verification, and current-episode resolution from procedure reuse;
- disclose the untested `HYPOTHESIS_PROPOSED` semantic edge;
- use exact source paths and existing test method names;
- include the recommended diagrams, short listings, failure analysis, recap and exercises;
- make no claims of causal improvement, production deployment, Soar reproduction or GraSP implementation.

**Drafting status:** complete. Chapter 22 has been drafted against this approved outline and is integrated for review.
