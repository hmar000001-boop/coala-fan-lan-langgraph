# Chapter 16 Outline v1.0

## Uncertainty, Resources, Interruption and Stopping: B6

**Part:** II — From Cognitive Architectures to Mechanism-Level Understanding  
**Primary source:** Fan and Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps*, arXiv:2607.23942v1 (27 July 2026)  
**Review status:** Conformance audit complete; this is the sole active review outline  
**Drafting status:** Authorized by the author on 15 November 2026 after confirming conformance with the nine-batch Part II plan  
**Outline format:** One canonical Markdown review file. No outline PDF or LaTeX outline wrapper/body will be generated.

---

## 1. Chapter decision and scope

Chapter 16 is the next chapter after the completed B4 chapter. It will examine B6, Fan and Lan's residual bundle **uncertainty–resources–interruption–stopping**. The chapter is deliberately a single-chapter unit rather than part of a two-chapter outline batch: its central claim depends on the causal coupling of uncertainty propagation, multi-resource allocation, preemption, interruption and stopping. Splitting these pieces into independent treatments would obscure the very control edge that defines B6.

Chapter 17 remains the separate treatment of B5 as the closed candidate screened against GraSP. Chapter 18 remains the cross-bundle synthesis. This outline does not authorize either later chapter.

### 1.1 Why B6 is not merely an uncertainty chapter

A confidence score at one model or tool boundary is not enough. A runtime can have a calibrated classifier, a tool scheduler, a token budget, a human-escalation route and a stop condition as separate features while still lacking the mechanism Fan and Lan identify. B6 asks whether uncertainty is carried with consequential proposals and changes the runtime's resource allocation and action authority as execution moves through memory admission, planning, tool authorization, monitoring and stopping.

The chapter's central teaching claim is therefore:

> **Uncertainty becomes a runtime control mechanism only when its calibrated, evidence-linked state propagates across stages and changes what the agent is permitted and resourced to do, including when it must yield, interrupt or stop.**

This is a statement of Fan and Lan's residual hypothesis, not a claim that the reviewed systems contain no useful uncertainty estimation or resource scheduling. Those systems implement substantial partial controls; the missing object is the coupling across them.

### 1.2 Implementation-bridge decision

**Recommendation: include a substantial theory-to-implementation bridge, comparable in depth to Chapter 15 and with especially careful treatment of runtime boundaries.** The bridge is necessary for four reasons:

1. B6 is defined by an operational control edge, not by a vocabulary term. The reader must see how uncertainty changes an actual schedule, permission decision, interruption and stop transition.
2. The closest modern cases are distributed across two groups: resource schedulers and uncertainty-conditioned action systems. Their individual strengths and boundaries must be made concrete before the residual coupling is credible.
3. The historical contrast is also a coupling: EPIC makes processor timing, parallelism and bottlenecks explicit; Sigma maintains uncertainty within a shared representational substrate that supports inference and decision. A list of resource managers plus a list of confidence estimators would miss this relationship.
4. The proposed design has safety implications. A system must distinguish uncertainty from permission, budget exhaustion from goal failure, interruption from cancellation, and a request for help from a verified stop. These cannot be left as vague implementation details.

The bridge will include proposed Java-like contracts, a resource-vector model, an uncertainty-provenance record, scheduler and authorization boundaries, interruption and stopping semantics, persistence and concurrency rules, a Product X walkthrough, and an evaluation plan. **These are book-level engineering proposals. They are not implementations prescribed by EPIC, Sigma, Fan and Lan, AIOS, AgentRM or the other cited systems.**

### 1.3 Primary scope

The chapter will explain:

- EPIC's timing, parallel processors and bottlenecks as the historical resource-control reference used by Fan and Lan;
- Sigma's factor-graph substrate and cross-stage uncertainty propagation as the historical uncertainty-control reference;
- the distinction between isolated modern resource controls and isolated uncertainty-conditioned action controls;
- the B6 residual hypothesis and its E3/D3 coding as two independent coordinates;
- the runtime state, event and authority boundaries needed to test the coupling;
- one calibrated uncertainty lineage that follows consequential proposals across stages;
- multi-resource budgets and scheduling decisions;
- tool authorization, risk-sensitive verification, preemption, interruption, resumption and stopping;
- a book-created Product X production-incident example;
- tests, metrics, ablations and falsification criteria.

### 1.4 Explicit exclusions

The chapter will not:

- claim that every modern agent lacks uncertainty estimation, calibration, scheduling, budgets, tool controls or stop decisions;
- treat a model's self-reported confidence as calibrated uncertainty;
- treat one scalar confidence value as a complete uncertainty model for unrelated propositions or action classes;
- invent a calibration equation, scheduler objective or learning law and attribute it to Fan and Lan;
- assume that all resources can be converted into one fungible scalar cost;
- imply that low uncertainty itself grants permission for a financial, destructive, externally visible or otherwise consequential action;
- treat a timeout, cancellation request or missing response as proof that a side effect did not occur;
- equate preemption, interruption, cancellation, suspension, abstention, stopping and successful completion;
- expand into a general survey of decision theory, Bayesian inference, reinforcement learning, operating systems or safety engineering;
- re-teach B1, B2, B3 or B4 in detail, or pre-empt Chapter 17's GraSP analysis and Chapter 18's synthesis;
- reinterpret CoALA using Fan and Lan.

---

## 2. Source map and claim discipline

The chapter has one formal theoretical source: **[Fan & Lan]**. The historical and modern works below are included only as the examples Fan and Lan discuss and cite. Their role is to explain the review's mechanism reconstruction, not to establish additional formal foundations for the book.

| Claim or content | Exact source anchor | Intended treatment |
|---|---|---|
| EPIC models perceptual, cognitive and motor processors with processing times, parallel pathways and bottlenecks. | [Fan & Lan] §III-D, EPIC; reference [18] | Historical mechanism explanation. Emphasize resource contention and the consequences for latency, interference, scheduling and preemption. |
| Sigma uses a factor graph as a shared substrate for symbolic, probabilistic and decision computations; message passing updates beliefs used for action selection, with learning able to update parameters or structures. | [Fan & Lan] §III-D, Sigma; reference [19] | Historical mechanism explanation. Emphasize persistent uncertainty across inference and decision, not a confidence number attached to one tool call. |
| General runtimes expose scheduling, state, tool, approval, interruption and cancellation boundaries, but the interface alone does not determine how uncertainty reallocates resources. | [Fan & Lan] §IV-A; Appendix E-A | Runtime insertion points only. Do not equate a framework API with a calibrated control law. |
| AIOS, AgentRM and budget-aware value search establish resource-related controls. | [Fan & Lan] §IV-B; §V-A; Appendix C-Q; Appendix F-B, references [30], [68], [69] | Explain the specific resource edge each case contributes and its limit relative to the whole B6 chain. |
| UALA, KnowNo and Calibrate-Then-Act establish uncertainty-conditioned tool, help, exploration or stopping decisions. | [Fan & Lan] §IV-B; §V-A; Appendix C-Q; Appendix F-B, references [70]–[72] | Explain the action boundary each case controls; do not generalize one task-specific uncertainty policy to the full runtime. |
| Utility-Guided Agent Orchestration selects among responding, retrieving, using a tool, verifying and stopping, but its uncertainty signal is heuristic/uncalibrated and it lacks cross-stage propagation and interruption authority. | [Fan & Lan] §VI-C, B6; Appendix C-Q; Appendix F-B, reference [73] | Closest cost-sensitive action baseline and central boundary case. Preserve the exact criticism; do not say it has no resource or action control. |
| B6's residual bundle is propagated uncertainty, multi-resource allocation, preemption, interruption and stopping. The initial merge is justified because uncertainty becomes control only when it changes resource/action authority across stages. | [Fan & Lan] §VI-B, Table V | Explain the merge rule and why scheduling and uncertainty are not split into unrelated bundles. |
| One calibrated uncertainty object should accompany each consequential proposal and propagate through memory admission, planning, tool authorization, execution monitoring and stopping. | [Fan & Lan] §VI-C, B6 | Core residual hypothesis. Distinguish it from the book's proposed concrete record and lifecycle. |
| B6 insertion point, control law, closest baselines and principal falsifier. | [Fan & Lan] §VI-C, Table VI | Reproduce faithfully in prose and a compact comparison table. |
| B6 depends on the shared runtime state and on cross-bundle composition; B6 governs verification, tool authorization, interruption and stopping across the other controls. | [Fan & Lan] §§VI-A, VI-D; Figures 8–9 | Explain the relationship to B1–B4 and the migrated skill-governance baseline without writing the synthesis chapter early. |
| B6's record: EPIC/Sigma, budget/queue/context/uncertainty/step cost, scheduling/help/retrieve/tool/verify/stop decisions, preserved resource/uncertainty state, missing calibrated cross-stage propagation and cognitive preemption/interruption; provisional E3/D3. | [Fan & Lan] Appendix C-Q; Appendix B, Table VIII; Appendix F | Preserve the record's known and unknown fields. Do not infer unspecified persistence or learning details. |
| Required trace, outcomes, efficiency/safety outcomes and rejection criterion. | [Fan & Lan] Appendix D, Table X, B6 row | Preserve all specified observables and the specific falsification condition. |
| Versioned runtime evidence is separated from mechanism evidence. | [Fan & Lan] Appendix E-A | Any mention of a general runtime's current interface must remain version-bounded and subordinate to the paper's analysis. |
| The corpus and search are bounded; no universal absence claim follows from failure to find a complete coupling. | [Fan & Lan] §§II-A–II-E, VII-C; Appendix F-C | Keep the conclusion within the frozen corpus and the paper's stated validity boundary. |

### 2.1 E/D coding boundary

B6's provisional record is **E3/D3**. The chapter will not turn these into a combined maturity score or a rank. It will refer the reader to Chapter 11 for the formal definitions and coding precedence. The discussion will explain only what matters to the B6 comparison: the mapping is a convergence claim at the stated evidence relation, and the reviewed modern controls reach substantial but incomplete operational depth. D3 is not “almost complete” and does not establish that the whole bundle is implemented.

The chapter must not upgrade or downgrade the record based on a framework's popularity, an unversioned product page or a speculative analogy. It must not treat the highest observed D level as a universal maximum.

### 2.2 Seven-field record: known facts and deliberate unknowns

The outline uses Chapter 10's exact seven-field representation, in the original order. It will not create new fields or fill undocumented values with plausible engineering assumptions.

| Field | What the B6 record supports | What must remain explicit or unknown |
|---|---|---|
| **S — Operative state substrate** | Budget, queue, context, uncertainty and step cost are named in Appendix C-Q. The common runtime state in §VI-A also contains uncertainty and resource budget. | The chapter's Java objects and database layout are proposals, not the paper's documented state representation. |
| **C — Control locus** | Scheduler and tool-authorization boundaries are named in §VI-C/Table VI; control decisions span the listed runtime stages. | The paper does not prescribe a universal process boundary or a single scheduler implementation. |
| **T — Transition trigger** | Scheduling/help/retrieve/tool/verify/stop choices are explicit in Appendix C-Q; consequential proposals carry uncertainty; monitoring may trigger interruption. | Exact thresholds, event taxonomy and tie-breaking policy are not specified by the review. |
| **P — Persistence boundary** | Uncertainty is expected to propagate across stages; the common runtime state retains uncertainty and budget during execution. | A durable schema, cross-session retention rule, expiry model, and restart-recovery protocol are not specified for B6. Do not invent a source-level value. |
| **F — Failure semantics** | Sequential miscalibration, excessive abstention, verification cost without risk reduction, and interruption that prevents correct completion are explicit failure modes. | Detailed exception types and recovery states are engineering proposals. |
| **L — Learning operator** | Sigma's historical mechanism can update parameters/structures; §VI-A defines a generic observed-outcome learning edge for the synthesis runtime. | Appendix C-Q does not give a B6-specific online calibration algorithm or prove that all reviewed modern B6 cases learn calibration parameters. Keep the exact B6 learning law open. |
| **R — Resource/governance policy** | Multi-resource allocation, budget, scheduling, verification, tool authorization, preemption, interruption and stopping are the core control concern. §V-B explicitly names token, time, tool and verification resources. | The review does not provide one universal objective function, resource conversion rate or policy threshold. Any concrete allocator is a labelled engineering proposal. |

---

## 3. Learning objectives

By the end of the chapter, the reader should be able to:

1. Explain why a local confidence score is not equivalent to uncertainty propagated through an agent runtime.
2. Reconstruct EPIC's contribution as explicit processor timing, concurrency and bottleneck control.
3. Reconstruct Sigma's contribution as uncertainty-bearing state that flows through inference and decision.
4. Distinguish resource scheduling systems from uncertainty-conditioned action systems and explain what each contributes to B6.
5. Explain why B6 is one coupled residual bundle rather than two independent features called “uncertainty” and “budgeting.”
6. Interpret E3/D3 without treating it as a scalar system score or a universal statement about the research field.
7. Explain why uncertainty must be calibrated for a defined prediction target and context, and why model self-confidence is not sufficient evidence.
8. Trace a single uncertainty lineage across memory admission, planning, authorization, execution monitoring and stopping.
9. Distinguish a multi-resource budget vector from a single scalar cost and explain the trade-offs created by scarce resources.
10. Distinguish scheduling, preemption, interruption, cancellation, suspension, resumption, abstention and terminal stopping.
11. Explain why risk/uncertainty and permission are separate: uncertainty informs governance but never grants authority on its own.
12. Evaluate a proposed B6 runtime using its state trace, outcome measures, three ablations and the paper's falsification criteria.

---

## 4. Chapter-at-a-glance and opening problem

### 4.1 Opening scenario: Product X under a production incident

Open with a book-created scenario. Product X's payment service begins returning intermittent HTTP 500 responses. The agent has several possible investigative paths: inspect recent deployment events, query read-only service health, inspect a bounded log window, or run a more expensive diagnostic. It also has possible actions with very different consequences: continue observing, request another verification, notify an operator, roll back a deployment, restart a service, or stop and report that the evidence is insufficient.

The example begins with competing hypotheses and incomplete evidence. It will not invent a “confidence score” and treat it as truth. The outline's eventual worked example will state that any numeric estimates and budget limits are hypothetical teaching values; any calibrated estimate must identify the prediction target, calibration slice and evidence provenance. The agent has a finite vector of resources, not just one token limit: time, model calls, tool calls and verification capacity are all relevant.

The reader sees the problem before learning the vocabulary:

- More investigation may reduce uncertainty but consume time while production remains degraded.
- A cheaper tool call may have little diagnostic value.
- A high-impact write action may remain unauthorized even when a model reports high confidence.
- A new high-severity event may justify preempting low-priority work.
- A long-running tool may not be safely cancellable once a side effect has started.
- Exhausting a budget must not be misreported as successful diagnosis or proof that the intended goal is impossible.

### 4.2 Intuition before terminology

Use the analogy of a control room with parallel workstations and limited shared capacity. A dispatcher does not assign unlimited time to every investigation. A risk estimate is useful only if it follows the decision and changes the allocation or permission. If the estimate disappears after the planner call, downstream authorization cannot use it. If the scheduler ignores the estimate, the confidence record has no control effect. If interruption loses the task state, the system cannot safely resume.

The analogy will be explicitly labelled as an explanation, not a claim that EPIC or Sigma implements a modern LLM-agent runtime.

### 4.3 Learning map

The chapter-at-a-glance box will preview two historical contributions, the partial modern implementations, the B6 coupling, the proposed runtime, and how the chapter tests it.

---

## 5. Historical foundation I: EPIC and explicit resource control

### 5.1 Why timing belongs inside the architecture

Explain that EPIC is not merely a list of perceptual, cognitive and motor modules. Its processors have explicit processing times; pathways can operate in parallel; shared bottlenecks determine which operations may overlap and which must wait. A perceptual event initiates activity, but resource contention shapes the effective temporal path.

### 5.2 Resource demand, overlap and bottlenecks

Use a small timeline example to show:

- independent work can overlap when resources are available;
- two operations that require the same bottleneck cannot both proceed as if they were independent;
- waiting time and interference are consequences of resource allocation;
- a scheduler must reason about demand and task state, not merely count modules.

The chapter will not recreate EPIC's complete processor model or claim that a proposed agent scheduler is an EPIC implementation. It will use only the mechanism that Fan and Lan cite: explicit timing, parallel pathways and bottlenecks.

### 5.3 The bridge to modern agents

Make the migration test concrete: a modern runtime must expose resource demand and scheduling decisions in a way that changes execution. A semaphore, thread pool or task queue alone is infrastructure, not a cognitive resource law. A scheduler becomes relevant to the mechanism when task state and resource demand affect overlap, priority, preemption or waiting.

### 5.4 Boundary

EPIC explains resource contention and timing. It does not supply the complete calibrated-uncertainty propagation chain in B6. That complementary historical contribution is Sigma.

---

## 6. Historical foundation II: Sigma and uncertainty propagation

### 6.1 A shared substrate for inference and decision

Explain Sigma's factor-graph representation at the level needed for the chapter. It provides a shared substrate for symbolic, probabilistic and decision computations. Evidence triggers message passing; updated beliefs support action selection; learning can update parameters or structures.

### 6.2 Local confidence versus propagated uncertainty

Use the distinction emphasized by Fan and Lan: a confidence value attached to one tool boundary is local. Sigma's stronger historical invariant is that uncertainty remains part of the state as evidence moves through inference and decision. The chapter will explain why the same evidence and uncertainty lineage must remain interpretable downstream.

### 6.3 Avoiding an overclaim

Do not state that Sigma's factor graph is a portable LLM confidence object or that Fan and Lan provide a ready-made uncertainty schema. The book's proposed record is an engineering bridge that preserves the propagation property, not a reproduction of Sigma's complete architecture.

### 6.4 Combining the historical lessons

Summarize the two complementary contributions:

- EPIC makes resource demand, timing, overlap and contention explicit.
- Sigma makes uncertainty-bearing state part of inference and decision.
- B6 asks for a modern runtime that couples these: uncertainty influences resource allocation and action authority, while resource decisions and observed outcomes remain visible to later stages.

---

## 7. Modern landscape: substantive controls, incomplete coupling

The chapter will distinguish general runtime boundaries from the mechanism-focused modern cases. A runtime interface may expose scheduling, tools, approvals, cancellation, interruption or resumption; that does not by itself demonstrate calibrated uncertainty propagation or an effective learned control law.

### 7.1 Resource-side systems

| Case | Role in Fan and Lan's account | Boundary to preserve |
|---|---|---|
| **AIOS** | Operating-system-inspired agent runtime with scheduling and managers for context, memory, storage, tools and access. Resource-control evidence. | A scheduler/control surface is not, by itself, cross-stage calibrated uncertainty propagation. |
| **AgentRM** | Feedback-driven resource management including admission, compaction, hibernation and scheduling. Adaptive resource precedent. | It is a substantive resource-management case, not proof of the entire B6 uncertainty/action/interruption chain. |
| **Budget-aware value search** | Remaining budget changes value-tree search selection. D3 budget-control evidence. | Budget-sensitive search is narrower than uncertainty propagation through memory, tool authorization, execution monitoring and stopping. |

### 7.2 Uncertainty-side systems

| Case | Role in Fan and Lan's account | Boundary to preserve |
|---|---|---|
| **UALA** | Uncertainty arbitrates external-tool interaction. | Tool arbitration is one stage, not a complete lifecycle. |
| **KnowNo** | Calibrated uncertainty triggers help seeking. | Help seeking is one control decision; it does not establish multi-resource allocation or interruption authority across stages. |
| **Calibrate-Then-Act** | Cost–uncertainty trade-offs influence exploration and stopping. | The mapped action/stopping edge does not establish a persistent uncertainty object across every stage. |
| **Utility-Guided Agent Orchestration** | Gain, cost, heuristic uncertainty and redundancy select among respond, retrieve, tool, verify and stop. | Fan and Lan identify its uncertainty signal as heuristic/uncalibrated and note the absence of cross-stage propagation and interruption authority. Do not describe it as lacking action or cost control. |

### 7.3 What general runtimes contribute

Use the paper's version-bounded runtime examples to identify practical insertion points for scheduler state, tool approval, interruption, cancellation and resumption. LangGraph and the OpenAI Agents SDK may be used as interface examples because Fan and Lan record those interfaces in Appendix E-A. They are not treated as implementations of B6's proposed control law.

The chapter must not update the paper's frozen evidence codes based on a newer framework interface. If a current product interface is mentioned, it must be separately verified during drafting and clearly separated from the paper's corpus claim.

### 7.4 The comparison result

The modern evidence is not empty. It contains D3 resource controls, calibrated help-seeking, tool arbitration and cost-sensitive action selection. The residual is the composition and authority relationship: one calibrated uncertainty object follows consequential proposals and changes resource/action control across stages, with cognitive preemption and interruption.

---

## 8. The migration gap and the meaning of E3/D3

### 8.1 The record is a bounded mapping result

State B6's provisional E3/D3 coding as separate axes, refer to Chapter 11 for definitions, and explain that the coding describes the reviewed mechanism evidence and its operational depth. Do not turn it into a score for the overall quality of an agent.

### 8.2 From isolated edges to a causal chain

Show the difference between a sequence of disconnected capabilities and one control mechanism:

1. a consequential proposal is associated with an uncertainty estimate;
2. the estimate is calibrated for a defined prediction target and context;
3. provenance and uncertainty state follow the proposal into planning;
4. resource allocation uses both the uncertainty and the action's resource demand;
5. authorization uses uncertainty, consequence, reversibility and policy;
6. execution monitoring incorporates new observations and updates the estimate lineage;
7. a scheduler can continue, verify, ask for help, preempt, interrupt, resume or stop;
8. the verified outcome contributes to later calibration/control evaluation.

The chapter should be explicit that this is a teaching reconstruction of the residual causal chain, not an already implemented system described by Fan and Lan.

### 8.3 Why B6 is one bundle

Revisit Table V's merge rule: resource scheduling and uncertainty can be ablated separately, but splitting them would remove the causal allocation edge under test. Uncertainty without resource/action control is an advisory value. A scheduler without uncertainty is a resource manager blind to the uncertainty that motivates verification or help. B6 asks whether the coupled mechanism changes execution in a measurable way.

### 8.4 Exact failure modes

Preserve Fan and Lan's failure modes:

- sequential miscalibration;
- excessive abstention;
- verification cost without risk reduction;
- interruption that prevents correct completion.

Do not replace these with only generic “bad confidence” or “wasted tokens” language.

---

## 9. Reconstructing B6 with the seven-field lens

This section will apply Chapter 10's seven fields to the exact Appendix C-Q record. The table in §2.2 is the reference and should be adapted into readable prose, not copied mechanically. In particular, persistence and learning details remain unspecified where the source does not provide them.

The chapter will then compare the source-level record with the book's proposed implementation records. The distinction must be visually and verbally clear: the first is the paper's mechanism mapping; the second is the author's engineering proposal.

---

## 10. The proposed runtime control loop

### 10.1 State before model output

Introduce the runtime state in which the model is only one proposal source. The book's proposal will keep authoritative state outside the model call:

- active intention and scope (owned by the B4 boundary);
- bounded workspace and admitted memory candidates (B1/B3 boundaries);
- current uncertainty lineage for consequential propositions;
- resource budget and reservations;
- active execution and tool state;
- failure/recovery substate (B2 boundary);
- current skill or workflow execution (Chapter 17's B5 boundary).

The model may propose an action, a diagnosis or an interpretation. It does not itself allocate authoritative budget, approve a tool, interrupt a task or declare a successful stop.

### 10.2 Consequential proposal and uncertainty object

Propose one versioned uncertainty record per consequential proposition/proposal lineage, rather than one undifferentiated confidence score for the entire agent. The object should identify:

- the proposition or event being estimated;
- the target outcome definition and action/context to which the estimate applies;
- the probability, interval or other calibrated representation appropriate to that target;
- the calibration model and version;
- the calibration domain or task slice and known coverage limitations;
- the evidence/provenance references and derivation links;
- the observation time, freshness/expiry rule and stage/version identifier;
- whether the value is calibrated, out-of-domain, stale or unknown.

These fields are proposed engineering contracts. The paper states the propagation requirement but does not prescribe this schema, probability representation, calibration technique or retention period.

### 10.3 Calibration is a property of a defined prediction task

Explain that calibration must be evaluated against a well-defined event and a relevant evaluation population. A language model's verbal claim that it is “90% confident” is not calibration evidence. A calibrated estimate for a retrieval decision is not automatically calibrated for a financial write, a security-sensitive action or a different tool/domain.

The chapter will distinguish:

- per-proposal uncertainty estimate;
- calibration evidence for a defined model/task slice;
- evidence provenance and freshness;
- policy thresholds for action authorization.

It will not claim that a calibration metric alone guarantees correctness, safety or permission.

### 10.4 Propagation without losing identity or lying about independence

Show how the record moves from memory admission to planning, tool authorization, monitoring and stopping. Each new observation creates a linked revision or derivation; it does not silently overwrite its history. If evidence changes the target proposition, model version or task domain, the runtime must not pretend that the old calibration applies unchanged.

Do not multiply probabilities or add confidence values as though all observations were independent. Any aggregation rule requires explicit assumptions and evaluation. The chapter may show a conservative engineering policy when calibration or dependence is unknown, but it must label that policy as a proposal.

### 10.5 Resource-vector budget

Propose a budget vector rather than a single scalar:

- model tokens or equivalent inference capacity;
- model calls/round trips;
- external tool calls;
- wall-clock time/deadline;
- compute or execution capacity;
- bounded context/memory capacity;
- verification and human-review capacity where the application models it explicitly.

Each resource needs a unit, a reservation rule, a consumption record and a remaining amount. The scheduler must not assume that a spare token budget can compensate for an expired deadline or an unavailable privileged tool.

### 10.6 Budget allocation and scheduling

Propose a decision over candidate actions that takes account of expected information or task value, uncertainty, consequence, resource demand and hard constraints. The source does not prescribe one utility equation; any illustrative formula must be labelled as a book proposal and evaluated against simpler alternatives.

The engineering plan should address:

- initial allocation and reserved verification capacity;
- per-stage and global caps;
- concurrent tasks and shared bottlenecks;
- deadlines and priority;
- resource reservation before dispatch;
- actual usage reconciliation after completion;
- denial or deferral when the required budget cannot be reserved;
- starvation/fairness and priority inversion;
- emergency preemption without corrupting unrelated task state.

### 10.7 Tool authorization is not confidence thresholding alone

The policy must evaluate uncertainty together with action type, consequence, reversibility, data exposure, scope and the user's authorization. Read-only diagnostics and write-capable operations do not share the same gate. A high-confidence proposal can still be forbidden; low uncertainty does not grant a tool permission that the principal did not authorize.

Propose an authorization decision that records the policy version, subject, exact action scope, risk/uncertainty inputs, required verifier or human approval, decision and expiry. Separate the model proposal from the authorization authority.

### 10.8 Monitoring, preemption, interruption and stopping

Define the terms separately:

- **Scheduling:** decide which eligible work receives resources next.
- **Preemption:** temporarily yield a lower-priority activity at an agreed safe boundary so another activity can use a constrained resource; preserve a resumable state where possible.
- **Interruption:** an authoritative event asks the current activity to stop at the earliest safe/defined boundary because risk, policy, priority or a new observation changed.
- **Cancellation:** a request to terminate an executing tool/task. It is not proof that the remote operation stopped or that its side effect was rolled back.
- **Suspension:** preserve state while no execution is active, pending a condition, resource or human decision.
- **Resumption:** continue from a validated checkpoint only after checking that assumptions, permissions, uncertainty and budget remain current.
- **Stopping:** terminally end this run or decision process with an explicit reason; distinguish verified success, safe refusal/abstention, infeasibility, deadline/budget exhaustion and escalation.

The proposed state machine must make cancellation capability and side-effect uncertainty explicit. A non-idempotent external action cannot be treated as safely rolled back merely because a local timeout fired.

### 10.9 Learning and calibration updates

Describe the learning boundary carefully. Observed outcomes can be used to evaluate or update calibration and resource estimates, but the B6 record does not specify a complete online learning algorithm. Propose a conservative learning path:

- only verified outcomes enter calibration feedback;
- preserve the prediction, model/calibrator version, evidence and outcome label;
- separate training/update data from evaluation data;
- monitor drift by domain and action class;
- version every calibration policy;
- allow rollback or disable adaptive updates if calibration deteriorates;
- keep the runtime control path testable with learning disabled.

Do not present the generic learning edge in §VI-A or Sigma's parameter learning as evidence that every modern B6 comparator implements this exact update.

---

## 11. Proposed Java-like contracts and persistence

The implementation bridge will use short Java-like records/interfaces to make authority and lifecycle boundaries inspectable. They are not claimed as code from the source paper.

### 11.1 Core contracts

Proposed types:

- `UncertaintyEstimate` / `UncertaintyLineage` — target event, calibrated value, calibration domain/version, provenance and linked revisions;
- `ResourceVector` — typed resource amounts with explicit units;
- `BudgetState` — limits, allocated reservations, consumed resources, remaining resources and deadline;
- `ActionProposal` — goal reference, action contract, consequence, reversibility, estimated resource demand and uncertainty lineage;
- `AuthorizationRequest` / `AuthorizationDecision` — tool/action scope, policy result, verifier/human requirement and expiry;
- `ExecutionObservation` — evidence observed during tool or task execution;
- `InterruptionRequest` — cause, priority, target activity, deadline and safe-boundary policy;
- `GovernorDecision` — continue, allocate, verify, seek help, preempt, interrupt, suspend, resume, stop or escalate;
- `OutcomeRecord` — verified result linked to the prior estimate and decision.

### 11.2 Contract invariants

- Every decision references the exact uncertainty revision it consumed.
- No action executes without a valid budget reservation and authorization decision.
- A model proposal cannot self-authorize a tool, enlarge a budget or erase an interruption.
- Budget reservations cannot drive any resource below zero under concurrent dispatch.
- A budget reservation is reconciled once, even if retries or duplicate events occur.
- Interruption and cancellation requests are idempotent; their acknowledgements do not imply side-effect reversal.
- Resume revalidates deadline, budget, tool authorization, uncertainty freshness and checkpoint identity.
- Stop reason and evidence are durable and machine-auditable.
- Only verified outcome labels update calibration records.

### 11.3 Persistence and concurrency

Propose transactional reservation and decision commits, optimistic version checks or equivalent concurrency control, event identity and deduplication, an append-only execution/governance ledger, and an outbox or equivalent reliable-dispatch boundary. The chapter must explain why a scheduler cannot write a reservation, dispatch a tool and record the result as unrelated operations without handling crash windows.

Consider these failure windows:

1. budget reserved but dispatch never occurs;
2. tool dispatch occurs but the process crashes before recording it;
3. interruption races with a new tool dispatch;
4. two workers reserve the last remaining tool call concurrently;
5. a remote cancellation returns late after a side effect may already have happened;
6. a suspended run resumes after the calibration or policy version has changed.

The chapter will not prescribe one database or queue vendor. It will define the consistency requirements and show a relational/event-ledger design as one possible implementation.

### 11.4 State-machine contract

The state machine will include at least `READY`, `RESERVED`, `RUNNING`, `PREEMPT_REQUESTED`, `INTERRUPT_REQUESTED`, `SUSPENDED`, `RESUME_CHECK`, `STOPPED`, and `COMPLETED`. The final chapter may merge states only if the invariants remain explicit. Every transition must specify:

- trigger and evidence;
- authority responsible for the transition;
- budget reservation/consumption effect;
- uncertainty revision consumed or produced;
- tool cancellation capability and side-effect status;
- persistence and resume behavior;
- whether the state is terminal.

### 11.5 Vertical-slice implementation sequence

1. Define the event/uncertainty identity and resource units.
2. Add budget reservation and accounting with deterministic tests.
3. Add calibrated estimate ingestion and provenance validation.
4. Propagate the estimate lineage through one read-only diagnostic path.
5. Add a scheduler decision over two resource-constrained candidates.
6. Add tool authorization that keeps policy authority separate from model confidence.
7. Add monitoring and a safe interruption boundary.
8. Add suspension/resume with revalidation.
9. Add stop reasons and evidence-ledger integrity.
10. Add verified-outcome calibration evaluation and optional updates.

---

## 12. Product X worked example: investigate without overspending or overstepping

This will be a book-created example and will not be presented as Fan and Lan's own example.

### 12.1 Initial conditions

Product X's payment service is returning intermittent HTTP 500 responses. The agent receives service metrics and a bounded incident window, but the root cause is uncertain. The principal authorizes read-only diagnostics and evidence collection. A service restart, deployment rollback or payment write is outside the agent's current authority and requires a separate gate.

The example records a finite budget vector. Any numeric values are clearly marked as hypothetical teaching values. A calibrated estimate is shown only with its target, domain and calibrator provenance; a model-generated verbal confidence statement is not used as a substitute.

### 12.2 Candidate investigation paths

The agent can inspect deployment metadata, query read-only health endpoints, retrieve a bounded log sample or perform a more expensive diagnostic. Each proposal has a resource demand and an evidence value. The scheduler reserves enough capacity for a final verification step rather than allowing low-value exploration to consume the whole budget.

### 12.3 New evidence changes allocation

A new observation changes the probability/risk estimate and its linked revision. The scheduler re-evaluates which investigation is worth its remaining cost. It does not assume evidence independence and does not silently replace the calibration context when the prediction target changes.

### 12.4 A higher-priority event preempts work

A second alert reports that the incident is affecting a wider portion of production. The scheduler preempts a lower-priority documentation or summarization activity at a safe boundary. Its checkpoint, uncertainty lineage and remaining budget remain intact. The chapter will distinguish this from aborting an external tool call already in progress.

### 12.5 An unsafe action is rejected

A model proposes a restart because it believes the service is likely stuck. Even if the estimate were well calibrated for a related event, the restart is not authorized by the existing read-only scope. The gate denies it or requests the required operator approval. Uncertainty informs the decision; it does not create authority.

### 12.6 Correct stopping or escalation

If read-only evidence verifies a root cause sufficiently for the authorized task, the agent stops investigation and reports the verified findings, uncertainty and evidence. If the budget is exhausted while material uncertainty remains, it suspends/escalates with an explicit “insufficient evidence” reason. It does not claim success, impossibility or incident resolution merely because its budget ended.

### 12.7 What the example demonstrates

The same uncertainty lineage affects candidate admission, planning, resource allocation, action authorization, execution monitoring and stopping. The example demonstrates B6 without duplicating Chapter 15's focus on preserving an authorized intention while changing its method.

---

## 13. Evaluation and falsification

### 13.1 Required trace

Preserve Appendix D, Table X's trace requirements:

- uncertainty provenance at every stage;
- allocated budget;
- interruption events;
- stop events.

For the implementation proposal, also record the exact uncertainty revision consumed by each decision, resource reservations and reconciliations, tool authorization, cancellation result, resumption checks, and verified outcome.

### 13.2 Primary outcomes

Preserve the source's primary outcomes:

- selective risk;
- calibration;
- irreversible-action errors.

The chapter may explain appropriate measurement concepts, but any additional metric must be labelled as a proposed operational measure rather than a Fan and Lan requirement.

### 13.3 Safety and efficiency outcomes

Preserve the source's named safety/efficiency outcomes:

- help precision;
- verification cost;
- interruption latency.

The practical evaluation may also report resource use by dimension, correct stop rate, false interruption rate, missed interruption rate, task completion after preemption, stale-estimate use, and budget-accounting correctness. These are engineering extensions and should not replace the source's specified measures.

### 13.4 Closest baselines

Compare the full coupled controller against:

1. the strongest uncertainty-conditioned baseline available for the target task;
2. the strongest resource scheduler without cross-stage uncertainty propagation;
3. a simple fixed-budget/fixed-threshold policy;
4. an uncalibrated heuristic controller;
5. the full B6 coupling.

The study must state exactly what each baseline has and lacks. It must not set up straw-man baselines that intentionally ignore existing controls.

### 13.5 Three required ablations

Keep the paper's three ablations separate:

1. **Remove the new state object:** remove the propagated uncertainty object while leaving other baseline behavior intact. This measures the cost/value of the representation and its continuity.
2. **Remove the authoritative control edge but retain logging:** continue recording uncertainty and budget events but prevent the governor from using them to alter scheduling/authorization/interruption. This isolates whether authority changes execution.
3. **Remove the learning update while retaining the runtime transition:** preserve immediate resource/action control but freeze calibration or adaptive policy updates. This isolates the value of adaptation from the value of the runtime transition.

Do not collapse these into one “remove uncertainty” test.

### 13.6 Task suite and experimental controls

Vary uncertainty quality and drift, consequence severity, action reversibility, resource scarcity, task duration, parallel contention, cost of verification, availability of human help, interrupt timing, safe cancellation capability and deadline pressure. Include cases where additional verification reduces risk, cases where it adds cost without reducing risk, cases where a help request is correct, and cases where excessive abstention prevents a correct completion.

Hold the base model, prompt, tools, environment and task budget fixed when comparing the new controller with the relevant baseline. Use matched seeds and controlled event injection where feasible. Preregister task population, experimental unit, model/dependency versions, stochastic replications, sample size, metric formulas, equivalence/non-inferiority margin, uncertainty intervals/statistical tests, exclusions and stopping rule, following Appendix D.

### 13.7 Falsification criteria

Reject or narrow B6 if:

- uncertainty does not remain traceable and appropriately calibrated across stages;
- propagated uncertainty does not change resource allocation or action authority;
- the full coupling does not improve selective risk, calibration or irreversible-action outcomes over strong simpler baselines;
- verification cost rises without a corresponding risk reduction;
- help-seeking becomes excessively abstention-prone or has poor precision;
- interruption prevents correct completion or causes unacceptable state loss;
- preemption/resumption corrupts budget or execution state;
- a simpler scheduler or uncertainty policy is non-inferior while using no more resources;
- the mechanism adds complexity and cost without measurable benefit.

Preserve the four source failure modes as the central falsifiers: sequential miscalibration, excessive abstention, verification cost without risk reduction, and interruption that prevents correct completion.

---

## 14. Cross-bundle boundaries and Chapter 18 handoff

| Neighbor | Relationship to B6 | Boundary for Chapter 16 |
|---|---|---|
| **B1 — Chapter 12** | Memory admission may consume uncertainty and resource budgets. | B1 owns activation/latency/action-utility memory control; B6 supplies cross-stage uncertainty/resource governance. |
| **B2 — Chapter 13** | Recovery branches consume resources and may create new uncertainty; B6 governs wider budget and interruption. | B2 owns typed in-episode recovery, protected substates and resolution compilation; B6 does not re-teach it. |
| **B3 — Chapter 14** | Candidate admission into a bounded workspace can be risk/resource aware. | B3 owns content competition, workspace and broadcast; B6 governs resource and uncertainty constraints across the execution path. |
| **B4 — Chapter 15** | B4 preserves the intention/goal boundary; B6 governs risk, resource limits, tool authorization, interruption and stopping around it. | B6 interruption or exhaustion must not silently rewrite B4's goal or mark its intention abandoned. |
| **B5 — Chapter 17** | A skill governor may provide candidate execution paths; B6 governs resources and uncertainty around their use. | Chapter 17 owns the GraSP closure analysis. Chapter 16 only names the skill-governor boundary where needed. |
| **Chapter 18** | B6 participates in the integrated runtime state and governs verification, authorization, interruption and stopping across mechanisms. | Defer full composition and the synthesis architecture to Chapter 18. |

The handoff will explain that B6 is not a substitute for local bounds in B2, the commitment lifecycle in B4 or the skill governance case in B5. It is the wider governor that makes uncertainty and scarce resources consequential across their boundaries.

---

## 15. Planned chapter structure

The final chapter prose should follow this sequence:

1. **The problem: an agent can be confident and still act badly** — Product X opening, limited resources and consequential actions.
2. **B6 in the Fan & Lan review** — residual status, merged atoms and the actual hypothesis.
3. **EPIC: time, parallelism and bottlenecks** — the historical resource-control contribution.
4. **Sigma: uncertainty that survives inference** — the historical propagation contribution.
5. **What modern systems already do** — resource and uncertainty baselines with bounded claims.
6. **Where migration remains incomplete** — E3/D3, the cross-stage causal edge and the four failure modes.
7. **Reconstructing the B6 record** — seven fields, including deliberate unknowns.
8. **The proposed B6 runtime loop** — uncertainty lineage, budget vector and stage propagation.
9. **Scheduling and resource allocation** — reservations, contention, priorities and verification reserve.
10. **Authorization, preemption and interruption** — policy authority, safe boundaries and cancellation semantics.
11. **Stopping, resumption and outcome learning** — explicit terminal reasons, revalidation and calibration feedback.
12. **Java-like contracts and durable execution** — typed records, interfaces, state machine and transactions.
13. **Product X walkthrough** — end-to-end propagation and a correct escalation/stop.
14. **Evaluation and falsification** — trace, outcomes, baselines, three ablations and failure conditions.
15. **What B6 does not solve** — cross-bundle boundaries, summary and handoff to Chapter 17/18.

---

## 16. Planned figures and Mermaid sources

The following sources will be authored only after outline approval, under `Tex/diagrams/source/part2/chapter16/`. Every source will contain `accTitle` and `accDescr`, use the shared theme, and be referenced from the chapter with the shared `\BookDiagram` macro. No PNGs or mock figures will be created for outline review.

1. `epic-resource-bottlenecks.mmd` — EPIC processor paths, processing times, parallel activity and shared bottleneck; historical teaching reconstruction.
2. `sigma-uncertainty-propagation.mmd` — factor-graph evidence/message propagation into belief, decision and learning; historical teaching reconstruction.
3. `b6-modern-baseline-map.mmd` — resource-side and uncertainty-side systems, their implemented edges, and the unclosed coupling.
4. `b6-cross-stage-control-loop.mmd` — proposal, uncertainty lineage, memory, planning, scheduler, authorization, monitoring, interruption and stopping.
5. `b6-resource-vector-scheduler.mmd` — resource-vector reservation, contention, priority, verification reserve and budget reconciliation.
6. `b6-authorization-and-interruption.mmd` — separate policy authorization from uncertainty, and show safe-boundary preemption/interruption paths.
7. `productx-b6-incident-sequence.mmd` — Product X incident from uncertain evidence through bounded diagnostics, preemption, denied write action and correct stop/escalation.
8. `b6-evaluation-ablation.mmd` — trace, primary/safety outcomes, baseline comparison and the three distinct ablations.

The final figure set may be reduced only if the same conceptual distinctions remain clear and the outline's core coverage is preserved. A diagram must not replace explanatory prose.

---

## 17. Glossary and index plan

Check for existing definitions before adding entries. Likely glossary candidates:

- calibrated uncertainty;
- uncertainty provenance;
- resource vector;
- resource reservation;
- resource contention;
- bottleneck;
- preemption;
- interruption;
- cancellation semantics;
- abstention;
- selective risk;
- verification budget;
- safe point / safe boundary;
- resume validation;
- terminal stop reason.

Likely index concepts: calibration, cancellation, cost-sensitive action, EPIC, help seeking, interruption, KnowNo, preemption, resource allocation, resource contention, resource vector, Sigma, stopping, tool authorization, UALA, uncertainty propagation, verification cost.

Avoid adding glossary entries for generic programming terms or duplicating stable definitions from Chapters 10–15. Add only concepts the chapter teaches or materially deepens.

---

## 18. Review questions and exercises

The chapter should conclude with questions that test mechanisms rather than vocabulary recall:

1. Why is one model confidence score insufficient to establish B6?
2. What does EPIC contribute that an ordinary list of parallel workers does not?
3. What does Sigma contribute that a confidence value attached to one tool response does not?
4. Why are resource scheduling and uncertainty-conditioned tool use not enough separately?
5. Which B6 fields are explicitly present in Appendix C-Q, and which persistence/learning details must remain unknown?
6. How can two tasks compete for tokens, tool calls, compute and a shared deadline without treating those resources as interchangeable?
7. Why can a high-confidence proposal still be denied authorization?
8. What is the difference between preemption, interruption, cancellation, suspension and stopping?
9. Why does a cancellation acknowledgement not prove that a remote side effect was reversed?
10. What do the three B6 ablations isolate?
11. Give one result that would falsify the claim that cross-stage uncertainty propagation adds value.
12. Explain how B6 complements B4 without taking over the authority to abandon or change the goal.

A practical exercise may ask the reader to trace a hypothetical uncertainty record and resource ledger across two competing diagnostics, a high-priority interruption and a resume decision. The task should require explicit stop reason and evidence provenance.

---

## 19. Acceptance criteria for the authored chapter

The chapter will be considered complete only when:

- EPIC and Sigma are reconstructed according to the narrow mechanisms Fan and Lan describe, with no broader architecture survey.
- Resource-side and uncertainty-side modern cases are compared accurately and their source status is not overstated.
- Utility-Guided Agent Orchestration's actual contributions and limitations are both preserved.
- B6 is correctly described as the residual cross-stage coupling, not as the absence of all existing uncertainty or resource control.
- E3 and D3 remain independent codes, with their formal definitions delegated to Chapter 11.
- The seven-field record preserves explicit unknowns in persistence and learning rather than filling gaps by inference.
- The implementation bridge distinguishes every source claim from each book-level design proposal.
- The proposed uncertainty object is evidence-linked and calibrated for a defined prediction target; self-reported model confidence is not substituted for calibration.
- The resource model uses explicit units and reservations; no unsupported single scalar is passed off as the source's policy.
- Tool authorization is separated from model proposal and uncertainty score.
- Preemption, interruption, cancellation, suspension, resumption and stopping have distinct semantics and tested transitions.
- Product X illustrates B6 without duplicating Chapter 15's goal-versus-method case.
- Evaluation preserves the Appendix D trace, outcomes, safety/efficiency measures, three ablations and falsification logic.
- The cross-bundle boundaries to B1–B5 and Chapter 18 remain intact.
- Chapter-specific Mermaid sources use accessibility metadata and the shared renderer; no mock render is represented as real.
- The prose uses the shared LaTeX preamble/macros, semantic teaching boxes and citation macros, and passes source-fidelity, consistency, compile, visual and PDF text checks.

---

## 20. Source and research record for drafting

### Primary source

**Fan, Haodi, and Zucong Lan.** “From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps.” arXiv:2607.23942v1, submitted 27 July 2026. <https://arxiv.org/abs/2607.23942>.

Principal B6 anchors: §III-D (EPIC and Sigma); §IV-A–IV-B (runtime insertion points and modern controls); §V-A (EPIC/Sigma migration); §V-B (resource and uncertainty control); §VI-A (common runtime semantics); §VI-B and Table V (candidate merge rule); §VI-C, B6 and Table VI (residual hypothesis, baselines and falsifier); §VI-D and Figures 8–9 (dependencies and synthesis); Appendix C-Q (R8 record); Appendix D, Table X (evaluation); Appendix E-A (versioned runtime evidence); Appendix F-B and F-C (modern evidence and validity boundaries).

### Historical sources cited by Fan and Lan

- **Kieras, David E., and David E. Meyer.** “An Overview of the EPIC Architecture for Cognition and Performance with Application to Human-Computer Interaction.” *Human-Computer Interaction* 12, no. 4 (1997): 391–438. Fan and Lan reference [18]. The chapter uses only the processor timing, parallel-pathway and bottleneck mechanism summarized in [Fan & Lan].
- **Rosenbloom, Paul S., Andrew Demski, and Vadim Ustun.** “The Sigma Cognitive Architecture and System: Toward Functionally Elegant Grand Unification.” (2016). Fan and Lan reference [19]. The chapter uses the factor-graph and uncertainty-propagation description in [Fan & Lan].

### Modern mechanism-focused records cited by Fan and Lan

- **Mei et al.** “AIOS: LLM Agent Operating System.” arXiv:2403.16971 (2024). Reference [30].
- **She, J.** “AgentRM: An OS-Inspired Resource Manager for LLM Agent Systems.” arXiv:2603.13110 (2026). Reference [68].
- **Li et al.** “Spend Less, Reason Better: Budget-Aware Value Tree Search for LLM Agents.” arXiv:2603.12634 (2026). Reference [69].
- **Han, Buntine, and Shareghi.** “Towards Uncertainty-Aware Language Agent.” arXiv:2401.14016 (2024). UALA; reference [70].
- **Ren et al.** “Robots That Ask for Help: Uncertainty Alignment for Large Language Model Planners.” arXiv:2307.01928 (2023). KnowNo; reference [71].
- **Ding, Tomlin, and Durrett.** “Calibrate-Then-Act: Cost-Aware Exploration in LLM Agents.” arXiv:2602.16699 (2026). Reference [72].
- **Liu, Zhao, and Xu.** “Utility-Guided Agent Orchestration for Efficient LLM Tool Use.” arXiv:2603.19896 (2026). Reference [73].

These are the cases and bibliographic identities used in Fan and Lan's frozen corpus. Their source status should be rechecked during chapter drafting only to avoid misstating publication status; the chapter must not silently replace Fan and Lan's historical review result with a different corpus or new E/D codes.

### Research boundary

The paper describes a bounded mechanism-level mapping review with a frozen analytical corpus. The chapter must preserve the stated validity limitations: it does not claim PRISMA completeness, systematic-search recall, pooled or causal performance evidence, or independent inter-rater reliability. Its conclusion is conditional on the documented source codes and screening rules. A missing complete coupling in the reviewed corpus is not proof that no such system exists anywhere.

---

## 21. Outline decision and conformance record

**Current decision:** Chapter 16 remains a standalone Batch 7 chapter under the author-approved nine-batch Part II plan. Its scope is B6 only; it does not absorb the closed B5 case assigned to Chapter 17 or the cross-bundle synthesis reserved for Chapter 18.

**Conformance audit:** The outline conforms to the approved plan. It reconstructs EPIC and Sigma, compares the resource-side and uncertainty-side modern controls, preserves B6 as E3/D3 on independent axes, and includes a substantial theory-to-implementation bridge. It preserves the source-required B6 trace, primary outcomes, safety/efficiency outcomes, three separate ablations, baseline discipline and falsification conditions. The explicit unknowns in persistence and learning remain unknown rather than being filled with conjecture. No structural revision was required.

**Drafting authorization:** The author instructed on 15 November 2026 that the outline be checked for conformance and that Chapter 16 writing begin immediately thereafter. This instruction authorizes the present draft.

**Next action:** Write the complete Chapter 16 prose directly in `Tex/part2/chapter16/chapter.tex` (LaTeX). Keep this as the only active outline Markdown file; do not generate outline alternatives, outline PDFs or outline LaTeX files.
