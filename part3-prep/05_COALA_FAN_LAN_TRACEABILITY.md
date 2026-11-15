# CoALA and Fan & Lan — supply-chain pilot traceability

This document is the traceability contract between Parts I–II and the one Part III pilot. A row counts as implemented only when the relevant state, control, transition and persistence behavior exists in code and is tested. A conceptual description, interface with no runtime authority or successful happy-path prompt is not enough.

## 1. CoALA dimensions and decision procedure

| CoALA concept | Supply-chain implementation | Persistent/authoritative data | Required evidence/test |
|---|---|---|---|
| Working memory | Current request, objective, entities, evidence, hypotheses, candidates, active substate, intention and current plan | Versioned execution context; model prompt is only a derived view | Different model calls see appropriate subsets; context updates after observations |
| Episodic memory | Prior disruptions, previous plans, outcomes, failed methods and verified learnings | Append-only episode/outcome records with provenance | Retrieval of a similar historical disruption without assuming it is identical |
| Semantic memory | Supplier/product/route/contract/dependency facts | Domain master data with owner and validity times | Temporal update and stale-fact rejection |
| Procedural memory | Approved runbooks, skills and validated procedures | Versioned procedure/skill catalog with preconditions and postconditions | Procedure invocation validates applicability and authority |
| Internal retrieval | Search memory, supplier history, constraints, policy and dependency relationships | Retrieval event and candidates | Measure relevance, freshness, latency and subsequent value |
| Internal reasoning | Interpret ambiguous request/evidence and update working hypotheses | Reasoning result as typed proposal, not authoritative fact | Conflicting-evidence and unsupported-claim tests |
| Internal learning | Store verified episode/outcome and update a bounded policy after attribution/review | Versioned learning/admission state | Show that outcomes, not mere presence or logging, change policy; test rollback |
| External grounding | Read supplier/inventory/shipment systems; send authorized communications and updates | Capability contracts, command/receipt records | Read-only vs write capability tests; result verification |
| Proposal | Candidate investigation or recovery actions | Immutable candidate records | Candidate set includes alternatives and provenance |
| Evaluation | Feasibility, service impact, cost, risk and resource evaluation | Evaluation trace and policy version | Constraint rejection and calibrated/uncertain values |
| Selection | Choose one candidate or reject the set and return to information gathering | Selection decision separate from approval | Reject when no candidate passes; do not force a choice |
| Execution | Apply approved external action and record result | Authorization, idempotency key and execution record | Approval, duplicate, timeout and uncertain-outcome tests |
| Observation | Incorporate actual supplier/carrier/inventory response | Observation with source/time validity | New observation can trigger a fresh decision cycle |
| Iteration/interleaving | Retrieve, reason, propose, evaluate, execute and observe in non-fixed patterns | Durable execution lifecycle | At least one trace that branches and returns to prior stages |

## 2. Fan and Lan's seven-field reconstruction

Use this seven-field schema for every relevant implementation. The field values below are proposed engineering interpretations for the pilot, not claims that Fan and Lan prescribe these Java components.

| Field | Engineering question | Supply-chain representation | Test focus |
|---|---|---|---|
| S — Operative state substrate | What state does the mechanism consume? | Typed request, working context, domain snapshot, memory/evidence candidates, workspace snapshot, intention, substate, plan and resource vector | State versioning, completeness, temporal validity and ownership |
| C — Control locus | Who decides the transition? | Request router, retrieval/context governor, impasse governor, workspace admission controller, intention governor, planner, authorization service, execution coordinator | Authority tests; model output cannot commit a transition by itself |
| T — Transition trigger | What activates the mechanism? | New request, new/contradictory evidence, failed feasibility check, plan invalidation, resource threshold, deadline, approval result, execution result | Event-condition coverage and false-trigger tests |
| P — Persistence boundary | What survives? | Durable request/intention/plan/approval/execution/evidence/history; cycle-scoped workspace; ephemeral prompt/rollout state | Restart, resume, replay, stale-version tests |
| F — Failure semantics | What happens when it cannot proceed? | Typed impasse, retrieval miss, invalid plan, uncertain supplier outcome, simulator unknown state, model/tool failure, budget/deadline exhaustion | Recovery, escalation, abstention, parent-state integrity and no unsafe fallback |
| L — Learning operator | What changes future behavior? | Evidence-attributed updates to memory usefulness/admission, validated runbook/procedure improvements, policy-version proposal | Attribution, minimum evidence, review, offline evaluation and rollback |
| R — Resource/governance policy | What limits or authority apply? | Inventory/capacity/time/cost constraints; search/model budgets; approval matrix; privacy and supplier permissions | Resource exhaustion, approval denial, unauthorized action and policy-version tests |

## 3. Residual mechanism bundles

### B1 — Activation/accessibility, latency, downstream utility and maintenance cost

**Supply-chain use:** retrieve a small, useful evidence/context set for the current disruption and candidate recovery action. Potential candidates include supplier reliability history, lead-time deviations, inventory freshness, route closures, previous similar disruptions and relevant procedures.

**Required implementation elements:**
- candidate memory/evidence record with source, type, temporal validity, confidence/reliability, privacy scope and size;
- task/action-conditioned accessibility or activation estimate;
- predicted retrieval latency distinguished from infrastructure wall-clock latency;
- estimated downstream contribution under current plan/query;
- lifecycle costs for storage, validation, refresh and maintenance, charged at the appropriate boundary rather than blindly per prompt;
- bounded context admission and outcome events distinguishing retrieved, admitted, used and attributable;
- selector version, policy trace and measurable budgets.

**Required tests:** stale supplier fact rejected; a rare decisive contract constraint survives context compression; redundant low-value records do not crowd out critical evidence; changing the request changes retrieval/admission; downstream outcome feedback does not update memory value merely because a record appeared in the prompt.

### B2 — Typed impasse, isolated substate and resolution compilation

**Supply-chain use:** a plan cannot proceed because evidence is contradictory or a hard constraint is unresolved—for example, a supplier commitment is ambiguous, the available inventory is unknown, a substitute is incompatible or every route is infeasible.

**Required implementation elements:**
- typed impasse and failure reason;
- immutable parent request/goal/version;
- child investigation/resolution substate with bounded capabilities, budget and deadline;
- typed resolution result with evidence references and preconditions;
- parent-version validation before applying the result;
- explicit state transition for resolved, rejected, timed out or escalated substates;
- candidate procedure/skill learning only after verification and applicability checking.

**Required tests:** child cannot alter parent objective; stale child result rejected; child budget exhaustion leaves parent intact; invalid result does not make an infeasible plan appear feasible; successful resolution is not automatically generalized to all suppliers/routes/products.

### B3 — Content competition, bounded workspace, broadcast and admission learning

**Supply-chain use:** many heterogeneous information sources compete for limited next-cycle context: current inventory, supplier promise, carrier event, contract clause, quality alert, previous episode, hypothesis and candidate plan fragment.

**Required implementation elements:**
- typed content candidates and optional coalitions of complementary evidence;
- bounded capacity and explicit admission/rejection governor;
- immutable cycle-scoped workspace snapshot;
- broadcast to defined consumers (reasoner, planner, constraint evaluator, monitor) and consumer receipts;
- outcome attribution to later plan/action results;
- versioned admission-policy update based on validated outcomes.

**Required tests:** critical but rare evidence is not systematically suppressed; stale source cannot displace fresh authoritative data without declared policy; broadcast changes what downstream consumers see; a generic message bus/top-k baseline is compared fairly; admission updates are tested for overfitting and rollback.

### B4 — Persistent intentions, reconsideration and method authority

**Supply-chain use:** the authorized objective remains to fulfill affected orders under constraints, while the chosen supplier, route, allocation or shipment sequence may need to change.

**Required implementation elements:**
- persistent goal/objective, rationale and continuation conditions;
- current plan/method with version and preconditions;
- explicit reconsideration triggers;
- governor decisions: continue, delegate, suspend, change method, escalate or terminate;
- principal/authorized owner retains goal authority;
- method governor has only bounded method authority;
- versioned audit trail and anti-oscillation policy.

**Required tests:** supplier outage changes method but not objective; changed demand can require authorized objective amendment; stale plan cannot execute; concurrent observation cannot silently overwrite a newer intention; repeated reconsideration does not oscillate without bounds.

### B6 — Uncertainty, resources, interruption and stopping

**Supply-chain use:** uncertain lead times, stock counts, supplier promises and shipment forecasts influence verification effort, resource allocation, action risk and whether the system should continue.

**Required implementation elements:**
- uncertainty/confidence attached to evidence, hypotheses and simulated transitions;
- separate business-resource vector and agent-computation budget;
- policy for allocating verification/search budget according to uncertainty and consequence;
- interruption requests distinct from external cancellation results;
- durable suspension/resumption state;
- explicit stopping/abstention/escalation conditions.

**Required tests:** uncertainty propagates to downstream plan evaluation; budget exhaustion stops safely; high-risk proposals receive verification; interruption preserves enough state to resume; stopping does not misreport an unresolved order as fulfilled.

### B5 / GraSP — closed candidate boundary

B5 should be treated as a closed negative case within Fan and Lan's bounded, provisionally coded corpus. The pilot may use typed procedures or validated skill graphs as ordinary engineering capabilities, and may compare relevant execution/verification ideas with GraSP. It must not claim that the pilot implements a new residual B5 mechanism or that GraSP universally solves every skill-governance problem.

## 4. Decision-procedure mapping

| Decision approach | Implementation object | Supply-chain suitability | Evaluation |
|---|---|---|---|
| CoT-style sequential reasoning | One trajectory of intermediate analysis and next-step proposal | Low-branching request interpretation, straightforward explanation and baseline | Cost, correctness, completeness and failure on branching tasks |
| ToT-inspired search | Tree of typed hypotheses/partial plans with evaluation and pruning | Multiple alternative explanations or recovery plan branches | Search cost, candidate diversity, backtracking quality, feasibility and solution quality |
| RAP-inspired MCTS | Tree over explicit states/actions, rollouts and reward/cost | Multi-step recovery with delayed consequences and resource trade-offs | Plan quality, constraint safety, search budget, robustness and simulator bias |
| Deterministic rule/constraint engine | Hard predicates, invariants, constraint evaluation | Every request before approval/execution | Zero hard-constraint violations in test environment |
| Custom hybrid | Selects the least expensive appropriate procedure and combines it with governance | General system behavior | Compare to all baselines on matched cases and budgets |

## 5. Source/engineering distinction

Every chapter section and code artifact should identify one of:

- **[CoALA]** — a claim supported by Sumers et al.'s CoALA paper;
- **[Fan & Lan]** — a claim or mechanism reconstruction supported by Fan and Lan's review;
- **[METHOD REFERENCE]** — CoT, ToT, RAP/MCTS or another algorithmic method used as an implementation comparator, not a third theoretical foundation;
- **[ENGINEERING DECISION]** — a Java architecture, algorithm adaptation, contract, policy, state machine or safety boundary created for the book;
- **[PILOT RESULT]** — a result actually measured by the implemented supply-chain system and reported with task, model, simulator, budget and limitation details.

No pilot result may be used to claim that a historical mechanism has migrated or that Fan and Lan's residual hypothesis is universally validated. It can establish only the behavior measured in the pilot environment and evaluation design.
