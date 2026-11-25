# Chapter 23 Outline — Persistent Intention and Resource Governance: B4 and B6

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** III — approved six-chapter structure (Chapters 19–24)  
**Outline status:** proposed for individual author approval; no chapter prose drafted  
**Implementation baseline:** supplied `supply-chain-agent-main` Java repository snapshot  
**Teaching role:** show how the application preserves an authorized task objective while changing methods, and how uncertainty/resource governance constrains the work without taking over goal authority.

## 1. Purpose and teaching contract

Part II Chapters 15–16 and 18 already establish B4, B6 and their distinct authority responsibilities. This chapter's purpose is to follow those responsibilities through real Java state, services, graph decisions and tests. It must not repeat the historical BDI/MIDCA or EPIC/Sigma chapters. It must make the implementation's actual boundaries explicit:

- B4 preserves the committed objective and governs the active method/intention lifecycle.
- B6 assesses uncertainty and controls resource consequences, downshifts, interruption and stopping decisions.
- The action capability/approval boundary remains separately enforced. Neither B4 nor B6 alone authorizes a specific state-changing simulator operation.

## 2. Learning outcomes

Readers should be able to:

1. Explain the difference between a persistent intention, its objective fingerprint and the current method reference.
2. Trace B4 reconsideration and method change through the next planner invocation.
3. Explain versioned intention transitions and the authorization boundary for termination/delegation.
4. Trace uncertainty assessment references and explain why they are tied to execution/scope/version context.
5. Explain the resource vector, budget ledger/guard and the difference between planner budget downshift and shared execution ceilings.
6. Explain the separate roles of B4, B6 and the external action authorization/approval gate.
7. Identify which parts of the B6 implementation are conditional/adapter-dependent and what the tests demonstrate.

## 3. Relationship to earlier chapters

- **B4:** Part II Chapter 15, with Chapter 11's MIDCA discussion and Chapter 18's responsibility/authority composition.
- **B6:** Part II Chapter 16, with Chapter 11's EPIC/Sigma discussion and Chapter 18's cross-stage control boundaries.
- **B5/GraSP:** Part II Chapter 17 established B5 as closed in Fan & Lan's bounded review. This chapter may state that the Java repository does not implement GraSP, but must not present that as an unfinished B4/B6 requirement.

## 4. Detailed section outline

### 23.1 The task can remain valid when the current method no longer is

Begin with a concrete supply-chain situation: the system has an authorized recovery objective, but new evidence, a failed method, resource pressure or changing feasibility makes the current method unsuitable. Ask two distinct questions:

- Does the intention/objective remain valid, and what method should now pursue it? (B4)
- Under current uncertainty, risk and resource constraints, what work may continue, be reduced, interrupted or stopped? (B6)

Preview the independent action-authorization check: a method decision does not grant permission to execute a state-changing operation.

### 23.2 B4 state: persistent objective, method reference and intention lifecycle

Introduce the state before the service:

- `RecoveryIntentionId`, `RecoveryIntention` and `RecoveryIntentionRepository`;
- `ObjectiveFingerprint` as a stable identity for the committed objective;
- `RecoveryMethodReference` as the selected/active method binding;
- intention version and lifecycle status;
- reconsideration trigger and termination reason.

Show why goal/objective identity must not be silently mutated when a method changes. Explain the typed transitions exposed by `RecoveryIntentionService`: continue/active binding, request reconsideration, change method, suspend, delegate/return from delegation, complete/terminate under the required authority. Use only transitions that exist in the current source.

**Code anchors:**

- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b4/RecoveryIntention.java`
- `RecoveryIntentionService.java`, `ObjectiveFingerprint.java`, `RecoveryMethodReference.java`, `ReconsiderationTrigger.java`, `IntentionStatus.java`
- `supply-chain-agent-infrastructure-postgres/...` recovery-intention repository
- `supply-chain-agent-runtime/.../lifecycle/CognitiveCycleLifecycleServices.java` — intention governance and B2 delegation handoff.

### 23.3 B4 control: diagnosis and method authority

Trace the runtime's B4 step:

1. load the current intention and version;
2. bind or validate the active plan reference;
3. obtain the domain's intention directive and objective identity;
4. evaluate continuation/reconsideration conditions;
5. apply the permitted transition using the service/repository;
6. expose a method reference to the planner-routing boundary without replacing the committed objective.

Explain the result in terms of observable behavior: a method change must affect the next planning request, otherwise the system merely logs a reflection. Avoid claiming that every possible intention transition is exercised by one scenario.

**Graph anchor:** `CognitiveCycleGraph.NODE_INTENTION` (`b4-intention-governance`) and its conditional routing. **Planner anchor:** `PlannerRouter` and `PlannerMethodResolver` consume the permitted method choice.

**Test anchor:** `M8B4FullGraphWorkflowTest.b4MethodChangeControlsTheNextFullGraphPlannerWithoutChangingTheCommittedObjective`.

### 23.4 B4's authority boundary with B2 and the human host

Explain the B2/B4 handoff: an active intention may delegate a bounded impasse investigation; B2 owns the child problem, while B4 retains the parent objective. If B2/B4 startup fails, the lifecycle service attempts compensating transitions rather than leaving the intention indefinitely delegated.

Explain termination authority separately: the service checks the authorized actor/host boundary before a terminal transition. A model-generated reflection or child finding is not permission to rewrite or terminate the intention.

**Code anchors:** `CognitiveCycleLifecycleServices.openImpasse`, `RecoveryIntentionService.delegate`, `returnFromDelegation`, and authorized termination methods. Coordinate with Chapter 22's detailed B2 discussion; do not repeat the full B2 implementation.

### 23.5 B6 state: uncertainty is versioned, scoped and triggered

Start with why a single free-floating confidence number is not enough. Explain the application's uncertainty assessment reference and the events that cause new assessments (before/after retrieval, after planning, before impasse, after human input as represented in the graph).

Show:

- `UncertaintyAssessment` and its versioned reference/identity;
- uncertainty target, evidence/provenance and calibration-version boundary where represented;
- the idempotent trigger/reference path in `CognitiveCycleLifecycleServices.assessUncertainty`;
- `UncertaintyCalibrationService`, trainer and PostgreSQL repository when configured.

Be careful: the durable host creates `UncertaintyCalibrationService` conditionally when the optional uncertainty-calibration codec is supplied. Do not state that every host composition necessarily has the calibration store enabled or that a score is empirically calibrated unless calibration evidence for the relevant target/domain is present.

### 23.6 B6 resources: budget, reservation, enforcement and downshift

Explain that resources are a vector, not one interchangeable number. Follow the code through:

- resource units/usage/budget records;
- `ResourceBudgetLedger` and durable budget reservations/leases in runtime persistence;
- `ResourceBudgetExecutionGuard` as the shared runtime enforcement boundary;
- `ResourceBudgetedActionExecution` and `BudgetedReasoningProvider` as callers subject to the same guard;
- `PlannerBudgetDownshift` as a way to lower the next planner request's computational allowance without silently raising or changing the shared execution ceiling.

Use one small example from the B6 full-graph test where the next planning request is downshifted. Explain the difference between reducing the planner budget and increasing the global permission/resource envelope.

**Code anchors:**

- `supply-chain-agent-mechanisms/.../b6/MetaControlGovernor.java`
- `UncertaintyCalibrationService.java`, `ResourceBudgetLedger.java`, `PlannerBudgetDownshift.java`, resource/uncertainty records and policies
- `supply-chain-agent-runtime/.../ResourceBudgetExecutionGuard.java`
- `ResourceBudgetedActionExecution.java`
- `supply-chain-agent-runtime/.../langchain4j/BudgetedReasoningProvider.java`
- `supply-chain-agent-infrastructure-postgres/...` runtime budget/uncertainty persistence adapters.

### 23.7 B6 meta-control: continue, reduce, ask, interrupt or stop

Show how the `MetaControlGovernor` consumes uncertainty and resource state to produce a bounded control decision. Explain graph routes to human control, replanning/downshift, authorization or escalation/stop. Explain interruption and resume as lifecycle behavior, not as a cancellation that magically undoes an already-dispatched external operation.

Use the exact actions/statuses in source, not a generic policy list. If a behavior is handled by a separate host/authority port rather than the governor, attribute it correctly.

### 23.8 Separate B4, B6 and action authorization

This is a core section, not a footnote. Present a three-column authority map:

| Decision | Owner | What it cannot do |
|---|---|---|
| Keep/change/suspend/terminate the committed objective's method/intention | B4 intention authority plus required human/host authorization for terminal/delegation-sensitive transitions | Cannot grant capability or bypass approval |
| Permit work under uncertainty/resource/deadline constraints | B6 governance and shared resource guard | Cannot silently redefine the goal/objective |
| Authorize a particular state-changing action and bind approval to its exact plan/version | Action capability/approval services and trusted host authority | Cannot change the intention's objective or increase resource limits |

Tie this back to Part II Chapter 18. In the code, identify `CapabilityAuthorizer`, `ActionDispatcher`, approved-action plan/approval lifecycle and the final revalidation boundary as distinct from B6. Do not claim B6 itself authenticates the human approver.

### 23.9 B5/GraSP: a boundary, not a missing implementation task

State briefly and accurately:

- Part II Chapter 17 explains why B5 is closed within Fan & Lan's reviewed corpus by the GraSP closest-baseline case.
- The supplied Java source does not implement GraSP's typed skill-DAG retrieval, compilation, node-level verification, five local repair operators and global fallback chain.
- CoALA procedural memory and B2's governed recovery-procedure draft/promotion are not substitutes for GraSP.
- This application does not need to add a new B5 bundle to demonstrate the five residual bundles.

Do not turn this into a second explanation of the GraSP paper; point back to Chapter 17.

### 23.10 B4 and B6 as complementary controls in one cycle

Walk through the specific full-graph test where B4 method authority and B6 downshift both affect the subsequent planner call. Show the separate decisions and the shared next-planner observation. Do not merge their authority or claim they use the same signal.

**Test anchors:**

- `M8B4FullGraphWorkflowTest.b4MethodAuthorityAndB6DownshiftComposeOnTheSameSubsequentPlannerCall`
- `M8B4FullGraphWorkflowTest.b6LowMarginDownshiftsTheNextPlannerRequestWithoutChangingTheSharedExecutionCeiling`
- `M8B4DPostgresBudgetExecutionIntegrationTest.m5PlanningAndM3ReasoningConsumeOneSharedPostgresBudgetAccount` — focused PostgreSQL integration evidence that planning and reasoning consume the same budget account.
- `M8B4DPostgresBudgetExecutionIntegrationTest.closedPostgresBudgetStoreBlocksReasoningBeforeProviderInvocation` — the budget-store outage path fails closed before provider invocation.
- `RecoveryIntentionServiceTest`, `MetaControlGovernorTest`, `UncertaintyCalibrationTrainerTest`, `ResourceBudgetExecutionGuardTest`.

### 23.11 Seven-field implementation map, recap and exercises

Provide one table for B4 and one for B6 with S/C/T/P/F/L/R and implementation status. Distinguish state and control that are durable from graph checkpoint data and transient local values. State where optional calibration is configured. Finish with an exercise: the goal remains valid but one route is too risky/expensive—identify which component may change the method, which may interrupt it and which authorizes a proposed inventory write.

## 5. Recommended diagrams

1. B4 intention: fixed objective fingerprint with versioned method changes.
2. B4 lifecycle and delegated B2 child branch.
3. B6 uncertainty assessment revisions and triggering points.
4. Resource vector, budget guard, planner downshift and action execution enforcement.
5. Authority separation: B4 goal/method, B6 resource/risk, external capability/approval gate.
6. Combined B4/B6 decision trace before the next planner call.

## 6. Code presentation rules

Show the state record before the service method; show the graph trigger/caller after the service; then show the specific test assertion that the transition changes the subsequent behavior. Use one small Java listing for B4 method replacement, one for uncertainty/resource control, and one for the shared guard boundary. Do not reproduce all persistence codecs or framework graph syntax here; Chapter 24 explains their application-level composition.

## 7. Boundaries

- B4 method authority is not goal authority and is not external-action capability.
- B6 risk/resource governance is not a hidden goal editor or human authentication service.
- A budget downshift is not equivalent to a larger resource allowance.
- A persisted uncertainty record is not proof of calibration quality.
- A checkpoint is not an intention record.
- No Java implementation here should be called a complete BDI, MIDCA, EPIC or Sigma implementation.
- B5/GraSP remains a closed-candidate boundary from Part II, not a required sixth mechanism.
