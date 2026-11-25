# Chapter 22 Outline — Typed Impasses and Protected Recovery: B2

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Part:** III — approved six-chapter structure (Chapters 19–24)  
**Outline status:** proposed for individual author approval; no chapter prose drafted  
**Implementation baseline:** supplied `supply-chain-agent-main` Java repository snapshot  
**Teaching role:** explain B2 as a bounded, parent-linked recovery process with typed failure, child investigation, protected return and separately governed reuse.

## 1. Purpose and teaching contract

Part II Chapter 13 explains the B2 research mechanism and its Soar lineage; Chapter 18 explains how B2 depends on and is constrained by the other bundles. This chapter should make the implementation understandable by following one typed impasse from detection to a validated return. B2 deserves a dedicated chapter because it is not merely a retry policy: it introduces a child problem with explicit ownership, parent state/version, delegated capability, bounded investigation and a typed result.

The implementation must be explained as an engineering realization, not as a full reproduction of Soar. In particular, a local recovery result is not automatically a compiled rule, reusable skill or GraSP skill graph.

## 2. Learning outcomes

Readers should be able to:

1. Explain why a failure label or retry loop is not sufficient to represent B2.
2. Identify the typed impasse, parent-context and child-investigation state.
3. Trace the trigger from the cognitive graph into B2's nested resolution subgraph.
4. Explain how B4 retains authority over the parent intention while B2 owns the bounded child recovery.
5. Follow child capability restrictions, case ownership, duplicate-step protection and typed return validation.
6. Distinguish resolving the current episode, drafting a reusable procedure and promoting a procedure into procedural memory.
7. Identify the persistence, idempotency/fencing and failure boundaries demonstrated by the tests.

## 3. Relationship to earlier chapters

- **Part II Chapter 13:** the B2 mechanism, Soar impasse/substate concepts and the source's proposed migration problem. Do not repeat the historical Soar explanation; use only enough to explain the code's parent/child structure.
- **Part II Chapter 10:** the seven fields S/C/T/P/F/L/R used to inspect mechanism state and authority.
- **Part II Chapter 15 and Chapter 18:** B4's persistent intention and the parent-goal boundary around recovery.
- **Part III Chapter 20:** internal/external action contracts and the CoALA application context.
- **Part III Chapter 23:** B4 intention governance and method authority. Coordinate on the B2/B4 handoff rather than repeating the B4 implementation.

## 4. Detailed section outline

### 22.1 Why a failed step should open a bounded child problem

Begin with a supply-chain recovery method that reaches a typed impasse: the parent request remains meaningful, but a local subproblem cannot proceed under the available evidence or capability. Contrast:

- a blind retry, which repeats an action without diagnosing or bounding the cause;
- a generic exception/log, which records failure but does not define a recovery process;
- B2-style protected recovery, which opens a child investigation linked to the parent task and returns a typed result under an explicit scope.

State the central invariant: recovery may solve the local impasse, but it cannot silently replace the parent's committed objective or expand its authority.

### 22.2 The B2 state model: impasse, parent and child

Introduce the types before the service calls:

- `ImpasseCase` and its typed failure/impasse classification;
- parent reference with execution/scope, request and working-memory version/objective identity;
- child investigation identity and bounded delegated capability;
- child-step claims/fencing and step/result records;
- typed resolution/findings reference and postconditions;
- failure, unresolved and rejection outcomes.

Explain why the parent reference/version is part of the recovery contract: a result derived from a stale parent state must not be applied as if it were still current.

**Code anchors:**

- `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ImpasseResolutionService.java`
- `DeterministicImpasseDetector.java` and B2 case/parent/child/result records
- typed child-step contracts and delegated capability types.

### 22.3 Detect and open the impasse

Walk through the code path:

1. the current cycle reaches a typed impasse condition;
2. `DeterministicImpasseDetector` classifies it using explicit application rules;
3. `ImpasseResolutionService` opens the case against the captured parent state;
4. the runtime lifecycle checks the active intention and coordinates B4 delegation with B2 opening;
5. if the combined start fails, compensating transitions prevent an intention from being stranded in a delegated status.

Do not imply that the LLM is the sole or authoritative impasse classifier when the implementation uses typed deterministic detection/validation.

**Runtime anchors:**

- `supply-chain-agent-runtime/.../cognitive/lifecycle/CognitiveCycleLifecycleServices.java` — `openImpasse`.
- `CognitiveCycleOperations.openImpasse` and the `B2ResolutionSubgraph` caller.
- `RecoveryIntentionService.delegate` and its return path (detailed B4 state semantics remain in Chapter 23).

### 22.4 Investigate within the child boundary

Explain the B2 child investigation sequence:

- validate that the case and child belong to the expected parent/execution/scope;
- check delegated capabilities and resource/authority restrictions;
- claim child steps with duplicate protection/fencing where configured;
- execute only permitted investigation actions;
- record evidence/findings and unresolved causes without inventing a resolution;
- re-check parent version and dependencies before return.

Show a small successful path and a failure path. Make clear that B2 investigates a bounded local problem; it is not a second unrestricted agent with all parent capabilities.

**Code anchors:**

- `ImpasseResolutionService` child-step and validation methods;
- `CognitiveCycleLifecycleServices.investigateImpasse`;
- `B2ResolutionSubgraph` in `supply-chain-agent-runtime/.../cognitive/`;
- PostgreSQL child-step, case and artifact adapters under `supply-chain-agent-infrastructure-postgres`.

### 22.5 Validate and return a typed result to the parent

Follow `validateImpasseReturn` and the typed return path:

1. load the current parent reference/version;
2. validate child/case ownership and completion state;
3. validate evidence, dependencies and typed postconditions;
4. reject stale or malformed returns;
5. return a bounded resolution/findings reference to the parent cycle;
6. let B4 decide what the returned evidence means for the parent intention/method.

Explain the different outcomes: resolved, unresolved, rejected/stale and failed are not interchangeable. The parent intention remains the governing reference; B2 does not own parent-goal changes.

**Code anchor:** `CognitiveCycleLifecycleServices.validateImpasseReturn`, `B2ResolutionSubgraph` and the result contracts.

### 22.6 Recovery-procedure drafting and promotion are separate lifecycle steps

Explain the implementation's reuse boundary:

- `RecoveryProcedureDraftService` may create a typed draft from an eligible recovery result;
- the draft preserves the origin/parent, applicability conditions, dependencies and verification status;
- `RecoveryProcedurePromotionService` is a separate governed operation that controls promotion into CoALA procedural memory;
- apparent success is not enough: no automatic promotion merely because the child episode returned a result.

Distinguish CoALA procedural memory, a B2 recovery-procedure artifact, and GraSP's skill-DAG execution mechanism. These concepts are related but not equivalent.

**Code anchors:** `RecoveryProcedureDraftService.java`, `RecoveryProcedurePromotionService.java`, procedural-memory records/services and PostgreSQL artifact adapters.

### 22.7 B2 through the seven mechanism fields

Provide a table for S/C/T/P/F/L/R. Make status judgments explicit:

- **State:** typed impasse case, parent version, child state/steps and typed return.
- **Control:** application detector/service/subgraph plus B4-owned parent intention boundary.
- **Trigger:** graph's impasse route and lifecycle `openImpasse` call.
- **Persistence:** case/child-step/draft records and checkpoint references, with the graph checkpoint distinct from B2 records.
- **Failure:** typed unresolved/rejected outcomes, stale-parent rejection, duplicate-step protection and compensating transitions where implemented.
- **Learning:** draft and governed promotion are explicit; current recovery success does not automatically change future procedural memory.
- **Resource/governance:** bounded delegated capability and shared runtime resource/authorization boundaries; do not attribute B6's global resource policy to B2.

Do not use Part II D3/D4 migration depth as a Java coverage grade.

### 22.8 Failure cases, safety boundaries and implementation limits

Discuss only cases supported by code/tests:

- impasse classification that lacks adequate typed evidence;
- stale parent version or wrong case ownership;
- duplicate child-step attempt;
- child action outside delegated capability;
- child result without valid evidence/postconditions;
- failure to coordinate B2 open with B4 delegation;
- draft that is never approved/promoted.

For each case explain the expected typed denial/failure or compensating behavior; do not invent behavior not present in the source.

### 22.9 Tests and what each one proves

Use focused tests:

- `ImpasseResolutionServiceTest` — core typed case/child investigation and return invariants;
- `RecoveryProcedureDraftServiceTest` — draft creation and eligibility constraints;
- `RecoveryProcedurePromotionServiceTest` — governed promotion boundary;
- `PostgresM7B2CoreIntegrationTest` — PostgreSQL-backed B2 cases/steps/artifacts;
- `M8B4FullGraphWorkflowTest.fullGraphResolvedB2ReturnCreatesTypedRecoveryDraftAndCarriesReference` — integrated full-graph B2 return path.

For every excerpt, name the tested behavior and one limit. CI acceptance is evidence that the tested contracts/build pass; it is not proof that B2 improves task success or that the B2/B4 composition is experimentally superior.

## 5. Recommended diagrams

1. Parent intention and bounded B2 child impasse subgraph.
2. Typed impasse-open → investigate → validate-return sequence.
3. Parent version/delegated capability boundary, including stale-parent rejection.
4. Current-episode resolution → procedure draft → governed promotion → procedural memory.
5. B2/B4 authority split: B2 owns the child investigation; B4 owns parent intention and method authority.

## 6. Code presentation standards

Present B2 in a vertical slice: state/typed contracts → detector → service → lifecycle/graph caller → persistence boundary → focused test. Use one detailed happy-path trace and one rejection/failure trace. Keep code extracts short; point to repository-relative paths instead of reproducing entire classes or SQL migrations.

## 7. Boundaries to preserve

- B2 is not a generic retry loop or unrestricted sub-agent.
- A child result cannot silently change the parent objective or enlarge delegated authority.
- A typed return is not automatically a successful parent task.
- Drafting a recovery procedure is not promotion; promotion is not automatic.
- CoALA procedural memory and B2 recovery artifacts are not GraSP skill-DAG execution.
- B2 is an engineering realization inspired by Fan & Lan's B2 mechanism analysis, not a full reproduction of Soar or a paper-prescribed Java architecture.
