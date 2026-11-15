# Persistent Intentions, Reconsideration and Method Authority: B4

**Part II:** From Cognitive Architectures to Mechanism-Level Understanding  
**Outline version:** 1.0  
**Status:** Proposed; awaiting individual author approval. No Chapter 15 prose has been drafted.  
**Batch:** 6 of 9 — standalone Chapter 15.  
**Primary source:** Haodi Fan and Zucong Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps* (2026), especially the BDI/MIDCA historical reconstruction, B4 residual bundle, Table VI, the R5a-R5c and R6 migration records, Figure 8, Appendix D, and Appendix F.  
**Historical sources:** Rao and Georgeff (1991, 1995); Kinny and Georgeff (1991); Cox et al. (2016), all cited by Fan & Lan.  
**Modern comparison set:** hybrid BDI-LLM, self-aware BDI, Devil's Advocate, Cognitive Control Architecture (CCA), goal-drift diagnostics, premature-commitment diagnostics, ADAS, AFlow, and MetaReflection, as cited and classified by Fan & Lan.

---

## 0. Executive decision and theory-to-implementation bridge audit

### 0.1 Central question

How can an agent preserve an authorized goal as a durable commitment across many execution cycles while still reconsidering whether the current method remains appropriate, and who has authority to continue, delegate, suspend, abandon, or change that method?

The chapter studies B4: **persistent intention, explicit reconsideration, and live method-switch authority**. It is not a generic chapter about planning, reflection, memory, goal setting, or prompt injection. Those topics appear only where they illuminate the B4 control relation.

### 0.2 The B4 claim in Fan & Lan's terms

Fan & Lan propose that a persistent intention record should retain the committed goal, rationale, plan, continuation condition, reconsideration triggers, authority, and termination status. A governor should decide whether to continue, delegate, suspend, abandon, or change method. The closest reviewed baselines include hybrid and self-aware BDI-LLM systems, CCA, Devil's Advocate, ADAS, and AFlow. B4 is weakened or rejected if commitments become stale, reconsideration oscillates, the agent stops prematurely, or method changes have no diagnostic value.

The chapter must distinguish what Fan & Lan state from what the book designs. The paper proposes a residual control bundle and identifies evidence and failure conditions; it does not prescribe a complete production schema, transition table, authorization protocol, concurrency model, or universal reconsideration score.\FanLanCite{\S VI-C; Table VI; Figure 8; Appendix D, Table X; Appendix F, R5a--R5c and R6}

### 0.3 Theory-to-practice assessment

**Assessment: a substantial implementation bridge is necessary.** The historical theories identify distinct state and control relationships, but a reader still needs to know how a modern runtime represents an intention, preserves it between model calls, detects a justified reconsideration trigger, authorizes a method change, and prevents that change from silently rewriting the goal.

The outline therefore requires the following implementation material:

1. A reference architecture with a principal/task interface, immutable goal specification, persistent intention registry, belief/evidence store, execution monitor, reconsideration detector, diagnosis component, method registry, method-authority governor, authorization gate, executor, delegation boundary, and append-only decision ledger.
2. Typed contracts for `GoalSpec`, `IntentionRecord`, `MethodDescriptor`, `MethodAssignment`, `ReconsiderationEvent`, `GovernorDecision`, `DelegationContract`, and `AuthorityPolicy`.
3. A lifecycle state machine covering proposal, authorization, active execution, reconsideration, continuation, method switch, delegation, suspension, satisfaction, impossibility, and abandonment.
4. Explicit authority separation: the principal controls the goal; the governor may choose only among permitted methods; a model may propose but cannot commit; the monitor diagnoses; safety and authorization controls may veto; external side-effect permission remains a separate boundary.
5. Persistence and consistency rules: versioned intention records, append-only events, optimistic concurrency, deduplication, restart recovery, method-switch transactions, stale-evidence checks, and audit reconstruction.
6. Reconsideration controls: evidence-gated triggers, hysteresis, cooldowns, switch budgets, escalation, and a distinction between a new plan under the same method and an explicit method switch.
7. Delegation and suspension contracts, including scope, expiry, return conditions, and the requirement that delegated work does not acquire authority to amend the parent goal.
8. A worked Product X payment-status example, a vertical-slice implementation sequence, Java-like contracts/pseudocode, and executable tests.
9. An evaluation design faithful to Fan & Lan Appendix D: required state trace, primary and safety/efficiency outcomes, baselines, three specified ablations, and falsification criteria.

These are **book-level engineering proposals**. They must not be attributed to BDI, MIDCA, CCA, or Fan & Lan unless the cited source explicitly provides the mechanism.

### 0.4 A distinction that governs the entire chapter

The chapter must keep three authority domains separate:

- **Goal authority:** who may define or amend the intended outcome and its constraints.
- **Method authority:** who may continue, delegate, suspend, abandon, or replace the method used to pursue the authorized outcome.
- **Proposal authority:** what the model or another component may suggest, without thereby authorizing or committing the change.

A method can change while the goal remains invariant. A goal change is not a method change and must follow the principal's authorization path.

### 0.5 Teaching sequence

Use problem first, concrete intuition, term, precise mechanism, worked example, and boundary. Teach BDI commitment before MIDCA meta-control; then compare modern systems; only after that derive the proposed runtime contracts. Do not start with a list of fields or an implementation diagram without first establishing the problem those fields solve.

---

## 1. Opening: the agent that remembers the task but forgets why it is committed

### 1.1 [Book example] Product X payment-status incident

A user asks an agent to determine whether a payment has settled and report the verified status. A prior action times out. The model proposes a retry, but the external processor may already have accepted the first request. The agent must continue pursuing the same user-authorized goal while reconsidering the unsafe method.

The opening will make the constraints concrete:

- the goal is to establish and communicate the verified payment status;
- the agent must not create a duplicate payment;
- no refund, cancellation, or new payment may be initiated without its own authorization;
- a timeout is evidence about an execution attempt, not proof that the goal is impossible or achieved;
- the runtime may switch from retry-oriented execution to read-only reconciliation without changing the goal;
- if the evidence remains ambiguous, the intention may be suspended or escalated rather than silently abandoned.

### 1.2 The failure of a task label

A task label or prompt fragment may preserve wording but does not necessarily preserve a commitment's authority, rationale, continuation conditions, or termination rules across process restarts and model calls. Repeating the user request in the prompt is not equivalent to a persistent intention record.

### 1.3 The failure of reflection alone

A model can notice that a plan is failing and propose another plan. Unless a runtime component owns the committed goal and has authority to accept or reject the proposal, reflection can remain commentary. A persuasive self-critique is not itself a control transition.

### 1.4 Learning outcomes

By the end of the chapter, the reader should be able to:

- explain what BDI intentions add beyond beliefs, desires, plans, and task text;
- distinguish commitment termination policies from the timing of reconsideration;
- reconstruct MIDCA's object-level and meta-level relation and explain why diagnosis must have a consequential control path;
- describe the B4 hypothesis without inflating its scope;
- distinguish a new plan, a new method, a delegated method, a suspended intention, and an amended goal;
- design a persistent intention subsystem with typed contracts and explicit authority boundaries;
- implement a method switch while preserving the authorized goal;
- evaluate goal drift, stale commitment, oscillation, premature stopping, and the causal value of method changes.

---

## 2. Locate B4 in the Fan & Lan review

### 2.1 Runtime insertion point

Fan & Lan locate B4 at the **workflow/governor boundary**. The proposed control law is that an intention persists until explicit reconsideration, while diagnosis may switch methods. Explain why this is neither merely a planner feature nor merely an execution monitor.

### 2.2 What the persistent intention record contains

Teach the source's stated fields without silently replacing them:

- committed goal;
- rationale;
- plan;
- continuation condition;
- reconsideration triggers;
- authority;
- termination status.

Explain the meaning of each field and the type of question it answers. Do not imply that Fan & Lan specify a database schema or exact serialization format.

### 2.3 The governor's decision set

Teach the five actions explicitly named in the B4 description:

- continue;
- delegate;
- suspend;
- abandon;
- change method.

Relate these to intention lifecycle semantics, but do not make them look like an exhaustive universal policy language. Additional terminal statuses such as achieved or impossible may be used in the book's implementation proposal where their provenance is explicit.

### 2.4 Why B4 is not simply BDI relabelled

BDI supplies the historical commitment structure. B4 asks for a portable runtime lifecycle plus explicit live method authority in contemporary agents. It therefore combines persistent normative state with an operative reconsideration and control edge.

### 2.5 Why B4 is not simply reflection

Reflection can detect a problem, assess a plan, or propose a replacement. B4 additionally needs an authoritative object representing what remains committed and a governor that can make a permitted state transition.

### 2.6 Why B4 is not just CCA or an intent graph

CCA is a security-oriented lifecycle supervision baseline in Fan & Lan's review. It contributes intent-graph and deviation-adjudication ideas, but the review identifies its domain-specific scope and the missing general intention lifecycle actions. Do not claim that an intent graph alone implements the complete B4 commitment policy.

### 2.7 B4 dependencies and boundaries

- B1 can supply memories and evidence relevant to reconsideration; it does not own the intention or decide that it should be abandoned.
- B2 can recover from a typed failure within a bounded substate; B4 supplies the parent goal and commitment boundary that recovery must preserve.
- B3 can broadcast evidence or monitor signals that trigger reconsideration; workspace admission does not itself grant method authority.
- B5/GraSP can provide a verified skill or fallback method; B4 determines whether the method remains authorized for the committed goal.
- B6 controls uncertainty, resource allocation, interruption, tool authorization, and stopping; B4 controls persistence and reconsideration of the intention. Avoid teaching B6 prematurely.

### 2.8 Evidence and migration depth remain separate

Explain E1-E4 and D0-D4 only as defined in Chapter 11. In this chapter, report the B4 case labels as two separate coordinates, not a composite score:

- **R5a: hybrid and self-aware BDI-LLM - E1/D3.** Beliefs, goals, intentions, plans, and explicit BDI control are preserved; a portable cross-domain reconsideration lifecycle remains missing.
- **R5b: Devil's Advocate - E3/D3.** Plan/subtask state, reflection, backtracking, and strategy revision are preserved; a durable authoritative intention and explicit continuation/suspension/abandonment rules remain missing.
- **R5c: Cognitive Control Architecture - E2/D3.** Intent graph, trajectory deviation, and tiered adjudication are preserved; general-purpose lifecycle authority beyond the security-specific setting remains missing.
- **R6: ADAS, AFlow, and MetaReflection - E3/D4.** Candidate or learned methods/workflows are informed by design-time or cross-trial experience; live in-run diagnosis and method-switch authority over a persistent intention remain missing.

The labels reproduce Fan & Lan's reviewed records. They are not a judgement of overall system quality, and a higher D value does not mean that the system has solved B4.\FanLanCite{Appendix F, R5a--R5c and R6; Table VI}

---

## 3. Historical foundation I: what BDI means by intention and commitment

### 3.1 Beliefs, desires, and intentions as distinct attitudes

Explain the distinction in the historical BDI account:

- beliefs represent what the agent takes to be the case;
- desires represent states of affairs the agent is motivated to bring about;
- intentions represent selected commitments that constrain subsequent practical reasoning.

Do not teach intentions as synonyms for a to-do list, arbitrary plan text, or all goals the user has expressed. A BDI intention has a role in the agent's ongoing deliberation and action selection.

### 3.2 The practical reasoning loop

Reconstruct the simplified BDI sequence from the cited BDI work:

1. update beliefs from observations and events;
2. generate options in relation to desires;
3. deliberate and filter options into intentions;
4. execute plans associated with intentions;
5. update beliefs and intention state after new observations;
6. release intentions when their applicable commitment conditions are met.

The chapter must state that this is a teaching reconstruction of the practical loop, not a universal runtime API or a requirement that every modern agent implement the same internal data structures.

### 3.3 Why intention matters under bounded deliberation

Commitment reduces the need to reconsider every alternative at every step. It supports coherent multi-step behavior, but it can also keep an agent pursuing an obsolete or impossible plan. The mechanism therefore manages a tension between stability and responsiveness.

### 3.4 Ends and means must not collapse

An intention is associated with an intended end and may be pursued through plans or means. The chapter should distinguish preserving the authorized outcome from preserving one specific plan. A change in means does not necessarily imply a change in end; silently changing the end is a different and higher-authority operation.

### 3.5 Historical boundary

The chapter should explain the BDI contribution as Fan & Lan reconstruct it and use Rao and Georgeff as a historical cross-check. It should not expand into a full survey of philosophical theories of intention or introduce additional theoretical frameworks outside the primary paper's cited examples.

---

## 4. Historical foundation II: commitment policies and reconsideration schedules are different axes

### 4.1 Why the distinction matters

A common teaching error is to list blind, single-minded, open-minded, bold, and cautious as if they were five members of one interchangeable taxonomy. The chapter must separate **when an intention may be terminated** from **how often the agent reconsiders its current options**.

### 4.2 Commitment termination policies

Explain the three familiar BDI commitment policies with their conditions:

- **Blind commitment:** retain the intention until the agent believes the intended state has been achieved; conflicting changes in beliefs or desires do not ordinarily release the commitment under this policy.
- **Single-minded commitment:** retain the intention until the goal is achieved or the agent no longer believes it can be achieved; belief changes can therefore make the commitment terminable.
- **Open-minded commitment:** retain the intention until achievement or until the relevant belief/desire conditions no longer support continuing to pursue it; the exact condition should follow the formalization being explained.

Use Rao and Georgeff's formal/practical explanation to qualify the exact termination conditions. Avoid treating the labels as natural-language personality traits.\autocite{rao1991modelingbdi,rao1995bdi}

### 4.3 Reconsideration schedules: bold and cautious

Kinny and Georgeff use bold and cautious to describe how frequently options are reconsidered during execution:

- a bold agent does not reconsider options until the current plan has been executed in its entirety;
- a cautious agent reconsiders after each new option/step;
- intermediate schedules can limit the number of plan steps before reconsideration.

These describe a schedule or frequency of reconsideration, not the same thing as the three commitment termination conditions in Section 4.2.\autocite{kinny1991commitment}

### 4.4 Why neither extreme is universally best

Use Kinny and Georgeff's Tileworld experiment to show the cost/benefit trade-off. Frequent replanning consumes deliberation time; infrequent replanning can pursue vanished targets or miss useful changes. The right behavior depends on environmental dynamism, planning cost, the event, and the plan being executed.

### 4.5 Event-sensitive reconsideration

The historical results support selective response to relevant environmental events rather than reacting to every change. Teach the distinction among:

- a change that makes the goal impossible;
- a change that invalidates the current plan or method;
- a change that merely presents a tempting alternative;
- a change that is irrelevant to the current commitment.

The chapter should not invent a universal reconsideration threshold. It should explain why relevance and deliberation cost belong in the policy decision.

### 4.6 What B4 adds to the classical distinction

B4 must persist the commitment record and expose explicit, inspectable reconsideration triggers and authority in a modern runtime. It also adds live method switching as a consequential control action, not just an internal decision to think again.

---

## 5. Historical foundation III: MIDCA and authority over the method

### 5.1 Object-level and meta-level cycles

Explain MIDCA's dual-cycle organization:

- the object-level cycle performs ordinary task reasoning and action;
- the meta-level cycle observes traces of object-level activity and reasons about how the object-level process is working.

Use the source's note-assess-guide structure:

1. note detects a discrepancy or unexpected condition;
2. assess hypothesizes a cause;
3. guide selects a response.

### 5.2 What the meta-controller may change

Fan & Lan summarize MIDCA's meta-controller as potentially changing the planner, strategy, goal handling, or another object-level method. The important architectural property is not that a system logs its reasoning; it is that diagnosis can select a different method during execution.

### 5.3 Method authority is not goal authority

Teach the key distinction:

- changing the method changes how an authorized goal will be pursued;
- changing the goal changes what outcome the agent is committed to;
- the latter must not be smuggled into the former.

The B4 implementation proposal will give the method governor a bounded authority to select an approved alternative, while goal amendment remains with the principal or another explicitly authorized actor.

### 5.4 Monitoring without authority is not meta-control

A dashboard, trace, evaluator, reflection prompt, or guardrail can identify a problem. It does not implement method authority unless its output can trigger a governed state transition. Conversely, an unconstrained model rewrite is not safe meta-control merely because it changes a plan.

### 5.5 Historical boundary

Do not collapse BDI and MIDCA into one historical architecture. BDI explains intention commitment; MIDCA contributes a meta-level model of diagnosing and changing methods. B4's proposed combination is an analytical synthesis in Fan & Lan, not a claim that BDI alone already provides MIDCA's meta-controller.\autocite{cox2016midca}\FanLanCite{\S III-C; Figure 3; Appendix A, MIDCA}

---

## 6. Modern evidence: what contemporary systems preserve and what they omit

### 6.1 Hybrid BDI-LLM systems (R5a)

Use the child-helpline training agent as a domain-specific example. Explain the BDI control framework and the LLM's role in intent recognition, response generation, and bypass behavior as reported in its source. State Fan & Lan's assessment: explicit BDI control and persistent structured commitment are preserved, but a portable cross-domain reconsideration lifecycle remains missing. Label E1/D3 as the paper's record.\autocite{owayyed2025controlled,lawton2026selfawarebdi}\FanLanCite{Appendix F, R5a}

### 6.2 Self-aware BDI-LLM (R5a)

Describe the 2026 University of Utah technical report at the level relevant to B4: a BDI deliberation loop, machine-consumable schemas, plan matching, verification tiers, parameterized plans, and a preliminary evaluation. Clearly identify it as a technical report with preliminary results rather than a settled production standard. Explain what it contributes to structured intention handling and what still needs a general method-governance lifecycle.

### 6.3 Devil's Advocate (R5b)

Explain the three interventions in the cited paper:

- anticipatory reflection before action, considering failure and alternatives;
- post-action alignment with subtask objectives and backtracking/remedy;
- overall plan review after completion.

This is a meaningful plan-revision baseline. It must not be misrepresented as a durable, authoritative intention registry with explicit continue/delegate/suspend/abandon policy. Preserve Fan & Lan's E3/D3 record.\autocite{wang2024devilsadvocate}\FanLanCite{Appendix F, R5b}

### 6.4 Cognitive Control Architecture (R5c)

Explain the intent graph and tiered adjudicator at a high level, only to the extent needed for B4 comparison. It is security-oriented: a deviation from an expected action trajectory triggers additional adjudication. Preserve Fan & Lan's E2/D3 record and its boundary: security-specific trajectory integrity does not automatically supply a domain-general intention lifecycle.\autocite{liang2025cca}\FanLanCite{Appendix F, R5c}

### 6.5 Goal-drift evidence

Use the goal-drift study as a diagnostic warning that initially specified objectives can drift during long-horizon interactions under competing pressures. Do not present a diagnostic study as a persistence controller or claim that a B4 governor is already validated by it.\autocite{arike2025goaldrift}

### 6.6 Premature-commitment evidence

Use the 2026 premature-commitment study to distinguish settling on a trajectory from being correct. Its signal is diagnostic; the reported work explicitly does not establish that hidden-state convergence is a correctness signal. Do not turn this metric into the proposed B4 governor's sole trigger.\autocite{mehta2026premature}

### 6.7 ADAS, AFlow, and MetaReflection (R6)

Explain their relation to redesigning or improving agent/workflow methods across design time or trials. Preserve Fan & Lan's E3/D4 classification and the boundary: learning better methods across trials is not the same as an in-run governor having authority to change the method for a persistent intention while the goal remains fixed.\autocite{hu2024adas,zhang2024aflow,gupta2024metareflection}\FanLanCite{Appendix F, R6}

### 6.8 Comparative table

Compare each system by its actual state object, trigger, control action, persistence boundary, what it contributes to B4, and the missing lifecycle edge. Keep E and D as separate columns. Do not infer unspecified internals from a system's name or popularity.

### 6.9 What the comparison establishes - and what it does not

The reviewed systems demonstrate important pieces: explicit BDI commitments, reflection-triggered revision, intent-graph adjudication, goal-drift diagnostics, premature-commitment diagnostics, and cross-trial method improvement. They do not, as a set, establish the full portable B4 coupling. The chapter should avoid claiming that no existing system has any relevant feature or that B4 is validated merely because its components have precedents.\FanLanCite{Appendix F, R5a--R5c and R6}

---

## 7. B4 reconstructed through the seven mechanism fields

Use Chapter 10's field names and order exactly. Do not add an eighth field or reinterpret the E/D labels as part of the tuple.

### 7.1 State (S)

Persistent intention, committed goal, rationale, active plan/method, continuation conditions, reconsideration triggers, authority, termination status, beliefs/evidence relevant to goal achievement, and method execution trace. Mark details not specified by Fan & Lan as unspecified in the source and reserve schema elaboration for Section 9.

### 7.2 Control (C)

Commitment policy, deliberation/option filtering, reconsideration governor, MIDCA-like meta-controller, and the authority boundary between proposal and commitment. Identify which actor is documented in the historical sources and which proposed runtime component is book-designed.

### 7.3 Transition (T)

Observation, goal success, perceived impossibility, material belief change, plan/method failure, goal relevance change, discrepancy diagnosis, or an explicit authority event can trigger reconsideration. Do not imply every event must cause a method change.

### 7.4 Persistence (P)

The intention record survives individual model calls, planning steps, tool invocations, and process restarts as long as its commitment conditions remain valid. Method assignment may change while the authorized goal identity and constraints remain stable.

### 7.5 Failure (F)

Stale commitment, goal drift, method thrashing/oscillation, premature stopping, false impossibility, plan/method change without diagnostic value, authority confusion, and silent goal substitution.

### 7.6 Learning (L)

Separate runtime reconsideration from across-trial policy or method learning. Explain which reviewed systems update future workflow designs or instructions, and why that is not automatically live B4 authority. Any proposed learned reconsideration policy must be audited, versioned, and gated.

### 7.7 Resources and governance (R)

Deliberation cost, replanning cost, time, resource budgets, delegated scope, authorization, auditability, and safe interruption. Defer the full cross-stage uncertainty and resource governor to Chapter 16 (B6).

---

## 8. [Book example] Product X: preserve the payment-status goal, change the method

### 8.1 Authorized goal and invariants

The user asks for verified payment status. The immutable goal specification states the outcome, acceptable evidence, no-duplicate-payment constraint, and the fact that a refund or new payment requires separate authorization.

### 8.2 Initial intention and method

Create an intention to reconcile the ledger and payment processor. The initial method may inspect the local ledger, query the processor status, and compare transaction identifiers. The intention record stores why the goal remains active and what events warrant review.

### 8.3 A timeout is not a terminal result

A request timeout does not establish whether a side effect occurred. The method may have failed; the goal has not necessarily become impossible or satisfied. The model's suggestion to retry is only a proposal.

### 8.4 Trigger and diagnosis

The execution monitor records an unknown external result. The reconsideration detector identifies a material method failure and evidence ambiguity. The diagnosis component determines which facts are known, unknown, or stale and whether the current method can safely proceed.

### 8.5 Governor decision: switch method, not goal

The governor rejects an unguarded retry, preserves the goal specification, and switches to read-only reconciliation using a processor idempotency lookup or settlement query. If authoritative status cannot be obtained, the intention is suspended or escalated. The governor records why this method is permitted and what evidence would permit resumption.

### 8.6 Delegation without goal transfer

A bounded read-only reconciliation task may be delegated to a payment-operations agent or human. The delegation contract carries parent intention ID, scope, permitted observations, prohibited actions, expiry, required evidence, and a return schema. The delegate does not acquire permission to amend the user's goal or initiate an external financial operation.

### 8.7 Completion and audit

When authoritative evidence resolves the status, the runtime records whether the goal is satisfied and how. The history makes the original commitment, trigger, diagnosis, method switch, delegation, evidence, and termination decision reconstructable.

### 8.8 Counterexamples

Show at least four failure variants: blind retry creates duplicate payment; agent changes the goal to “attempt another payment”; reflection proposes a switch but nothing authorizes it; or governor switches repeatedly between methods without new evidence.

---

## 9. Theory-to-practice bridge: a reference intention and method-governance subsystem

This section is mandatory and must be one of the chapter's major sections. It translates the B4 control relation into a proposed implementation without claiming that the source paper provides these software interfaces.

### 9.1 Reference architecture

Describe the roles and their trust boundaries:

1. Principal/Goal API: accepts and authenticates the user-authorized goal and later goal amendments.
2. Goal specification store: persists the immutable, versioned goal and its constraints.
3. Intention registry: persists active intention records and lifecycle state.
4. Belief/evidence store: records observations, provenance, timestamps, and confidence/verification state.
5. Execution monitor: observes plan and tool outcomes without deciding policy by itself.
6. Reconsideration detector: converts configured triggers into structured events.
7. Diagnosis service: examines evidence and proposes a cause/impact assessment; model reasoning is advisory.
8. Method registry: lists permitted methods with version, capabilities, preconditions, postconditions, cost, risk class, and supported goal types.
9. Method-authority governor: selects among allowed lifecycle actions under the intention's authority policy.
10. Authorization and safety gate: checks principal consent, tool permissions, external effects, and prohibited transitions independently.
11. Executor/delegation adapter: invokes the current method or scoped delegate.
12. Append-only event and decision ledger: records proposals, diagnoses, approvals, state transitions, outcomes, and version references.

### 9.2 Typed data contracts

The chapter should specify fields and invariants for each contract:

- `GoalSpec`: goal ID, principal/owner, authorized outcome, immutable constraints, acceptance criteria, permitted side effects, version, content hash, and authorization evidence.
- `IntentionRecord`: intention ID, goal reference/hash, rationale and evidence references, plan reference, active method assignment, continuation condition, reconsideration triggers, authority policy reference, termination status, timestamps, and version.
- `MethodDescriptor`: method ID/version, eligible goal types, capabilities, prerequisites, preconditions, postconditions, expected side effects, cost/risk classification, and required authority.
- `MethodAssignment`: intention ID, method descriptor/version, invocation ID, plan state, assignment reason, validity interval, and status.
- `ReconsiderationEvent`: event ID, intention/version, trigger type, evidence IDs, provenance, observation time, goal-relevance result, and diagnosis reference.
- `GovernorDecision`: decision ID, action, prior and next lifecycle state, prior and next method, rationale/evidence, authority path, goal hash, expected state version, and timestamp.
- `DelegationContract`: parent intention ID, delegated objective within the parent goal, scope, allowed/prohibited capabilities, evidence obligations, expiry, cancellation rule, and return contract.
- `AuthorityPolicy`: principal, governor permissions, model proposal-only permissions, human approval requirements, safety vetoes, and audit requirements.

Explain which fields are source-derived abstractions from B4 and which are implementation-specific additions. Do not store model-generated rationale as if it were the principal's authorization evidence.

### 9.3 Separate goal, method, and proposal authorities

Define the proposed permission matrix:

- **Principal/user:** may define or amend the goal through authenticated authorization; may pre-authorize a bounded set of method choices; external side effects remain subject to explicit consent and action policy.
- **Language model:** may propose methods or diagnoses; cannot commit a proposal, amend the goal, or authorize an external side effect.
- **Reconsideration governor:** may select only from the intention's permitted method set and may request alternatives; its method authority does not include goal amendment or external-action approval.
- **Safety/authorization gate:** may block, require review, or enforce the separate policy for external side effects; it does not invent a new goal.
- **Executor/delegate:** may execute only the assigned method and scoped capabilities; it may return evidence and proposals but cannot enlarge its authority.

The exact matrix is a book-level design proposal. It should be related to the B4 requirement that reconsideration authority be explicit, while noting that external-action authorization is also a B6 concern.

### 9.4 Intention lifecycle state machine

Propose a versioned state machine with:

- `PROPOSED`: candidate intention exists but is not committed;
- `AUTHORIZED`: principal/policy has accepted the goal and allowed scope;
- `ACTIVE`: the intention is being pursued through a current method;
- `RECONSIDERATION_PENDING`: a trigger requires diagnosis and a governor decision;
- `METHOD_SWITCH_PENDING`: a replacement method is being checked and committed;
- `DELEGATED`: a child assignment is active under a contract;
- `SUSPENDED`: no method may proceed until a defined resume condition/authority event;
- `SATISFIED`, `IMPOSSIBLE`, and `ABANDONED`: terminal outcomes, with evidence and authority requirements.

Define legal transitions and guards. A method switch changes the method assignment but preserves the `GoalSpec` ID/hash and immutable goal constraints. Goal amendment is a separate principal-authorized operation that creates a new goal version and a recorded relationship to the previous intention. A terminal intention is not silently reopened by changing a prompt; a new or explicitly reauthorized intention is required.

### 9.5 Reconsideration trigger taxonomy

Cover success evidence, impossibility evidence, material belief/world change, goal-relevance change, method precondition failure, repeated lack of progress, unexpected side-effect evidence, delegate return, and explicit principal instruction. Separate hard invalidators from soft reconsideration signals. A low-value alternative appearing is not sufficient by itself to abandon a commitment.

### 9.6 Diagnosis and decision semantics

A diagnosis should report observed evidence, provenance, current method assumptions, what changed, which conditions remain valid, goal feasibility, goal relevance, and uncertainty. The governor then chooses a permitted action. The LLM may generate candidate explanations or methods, but it cannot label an intention satisfied/impossible or amend the goal without the designated authority and evidence checks.

### 9.7 Distinguish plan revision from method switch

A plan may be revised within the same method family while preserving the method authority contract. A method switch changes the mechanism or strategy used to pursue the goal and should be logged as such. The chapter must define the distinction operationally and explain why otherwise every minor plan edit could look like a B4 transition.

### 9.8 Persistence, transactions, and concurrency

Propose:

- append-only intention and reconsideration events;
- versioned snapshots for fast recovery;
- compare-and-swap or optimistic concurrency on intention versions;
- event IDs and idempotent processing for repeated triggers;
- transactional updates for method assignment and state transition;
- outbox/inbox patterns or equivalent durable delivery for asynchronous method/delegate calls;
- revalidation of evidence and method preconditions before commit;
- restart recovery that reconstructs the active commitment and pending work;
- conflict handling when two monitor events race to reconsider the same intention.

Explain the invariant: a stale governor decision cannot overwrite a newer intention version or change its goal hash.

### 9.9 Method switch and external side effects

Changing a method does not reverse actions already performed. A payment submission, message, file write, or external API mutation must be reconciled or compensated through its own authorized procedure. Do not describe method switch as rollback of real-world effects. Require idempotency and operation IDs where supported, record uncertain results, and route compensation through the external-action authorization policy.

### 9.10 Delegation and suspension

A delegate receives bounded work, not the entire parent authority. Define scope, tool allowlist, deadlines, expected evidence, return format, cancellation behavior, escalation path, and how the parent intention resumes. Suspension must specify what is paused, what events can resume it, and whether a human decision is required.

### 9.11 Anti-oscillation and commitment safeguards

Propose evidence thresholds, hysteresis, cooldowns, switch budgets, minimum expected diagnostic value, and a record of rejected alternatives. These safeguards must not prevent immediate suspension for hard safety violations or falsely keep an impossible method alive. Distinguish a stable goal from a frozen plan.

### 9.12 Java-like interfaces and orchestration pseudocode

Provide implementation-oriented but non-framework-specific Java records/interfaces. The chapter should show, at minimum:

- immutable `GoalSpec` and versioned `IntentionRecord`;
- `ReconsiderationEvent` and typed `GovernorDecision`;
- `MethodDescriptor` and `DelegationContract`;
- `IntentionRepository` with compare-and-swap semantics;
- `MethodRegistry` and `MethodExecutor` interfaces;
- a `ReconsiderationGovernor` that returns a typed decision rather than mutating state implicitly.

Pseudocode should show: load current version, validate trigger, gather evidence, diagnose, ask/obtain proposal, validate against authority, commit the permitted transition atomically, dispatch the method/delegate, and append outcomes. Keep the goal hash invariant explicit.

### 9.13 Incremental implementation sequence

1. Persist the principal-authorized goal separately from prompt text.
2. Add a minimal intention record and lifecycle with explicit completion/impossibility rules.
3. Instrument execution and reconsideration events.
4. Add an allowlisted method registry and versioned assignments.
5. Implement the governor and separate authorization gate.
6. Add suspension and bounded delegation.
7. Add append-only audit, restart recovery, concurrency and idempotency.
8. Introduce anti-oscillation policy and learned method recommendations only after the non-learning control path is measurable.

Each step should have a demonstrable acceptance test. Do not begin with an unconstrained self-modifying planner.

### 9.14 Testable implementation scenarios

Include tests for: goal hash unchanged after method switch; model cannot amend goal; principal amendment produces new goal version; satisfied intention terminates; method precondition invalidation triggers review; stale diagnosis loses compare-and-swap; duplicate trigger is idempotent; delegate exceeds scope and is blocked; suspension halts the method; a delegate result resumes only after validation; method switch does not erase prior external side effects; repeated low-value alternatives do not cause oscillation; impossible goal is not kept active indefinitely.

---

## 10. Failure modes, safety boundaries, and operational guidance

### 10.1 Stale commitment

The agent continues a method even after key assumptions or the goal's feasibility have changed. Show how a continuation condition and event-sensitive reconsideration address it.

### 10.2 Goal drift and silent substitution

The runtime's declared goal remains one thing while execution increasingly optimizes another. Require goal identity/hash, acceptance criteria, provenance, and principal-authorized amendment records.

### 10.3 Method oscillation

The governor switches repeatedly without new evidence or improved expected outcome. Use event relevance, hysteresis, cooldown, switch budgets, and review metrics.

### 10.4 Premature stopping

The agent treats uncertainty, one failure, or one negative signal as proof that the goal is impossible. Require typed diagnosis and evidence appropriate to the termination condition.

### 10.5 Premature commitment to a wrong interpretation

The agent settles early and then defends a mistaken reading. A stability/convergence signal can be a reason to inspect the trajectory, but the cited premature-commitment diagnostic does not establish correctness; it must not be a sole method-switch trigger.

### 10.6 Reflection without control

The system produces a critique but has no authoritative state transition. Add a test proving that the governor decision changes the active method only through a valid state transition.

### 10.7 Method authority becomes goal authority

An LLM or subagent proposes a new goal under the guise of selecting a method. Enforce the immutable goal reference and separate principal authorization path.

### 10.8 External side-effect confusion

A method switch, cancellation, or delegation cannot erase or reverse an already executed external action. Preserve operation IDs and require separate compensation authority.

### 10.9 Over-monitoring and excessive deliberation

Reconsidering on every message can consume the resources needed to act. Use event-sensitive triggers and measure replan/deliberation cost.

### 10.10 Cross-bundle safety boundaries

- B2 owns typed recovery substates and resolution return; B4 retains the parent intention and decides whether its method should continue after the resolution.
- B3 may broadcast relevant evidence; B4 owns the commitment decision.
- B6 owns uncertainty propagation, budgets, interruption, tool authorization, and stopping. B4 must not duplicate B6's governor.
- B5 provides eligible skill/fallback methods but does not own the parent goal.

---

## 11. Evaluation: does explicit intention and method authority improve long-horizon behavior?

### 11.1 Preserve Fan & Lan Appendix D

The chapter must reproduce the required B4 trace:

1. intention record;
2. reconsideration event;
3. diagnosis;
4. method switch;
5. termination.

The study should hold base model, prompt, tools, environment, and task budget constant across controlled conditions. Preregister the task population, model/dependency versions, experimental unit, stochastic replications, sample size, metrics, non-inferiority/equivalence margin, uncertainty intervals/tests, exclusions, and stopping rule. Do not invent sample-size numbers in advance of a real power analysis.\FanLanCite{Appendix D; Appendix F, B4 record}

### 11.2 Primary outcomes

- goal drift / adherence to the originally authorized goal;
- task completion under the stated acceptance criteria;
- correct stopping or continuation decision, including justified impossibility and suspension.

### 11.3 Safety and efficiency outcomes

- method-switch and replan frequency;
- oscillation rate and repeated switch-back;
- escalation precision;
- stale-intention rate;
- unauthorized goal-change attempts;
- cost and elapsed time attributable to reconsideration;
- method-switch diagnostic value and post-switch performance.

Treat any additional metric definitions as book-proposed operationalizations, not as values already reported by Fan & Lan.

### 11.4 Baselines

Compare against: a prompt-only agent with no persistent intention record; a static plan that never reconsiders; a BDI-like commitment baseline without live meta-method authority; reflection-triggered plan revision; and the relevant reviewed modern examples (hybrid/self-aware BDI-LLM, Devil's Advocate, CCA). Use ADAS/AFlow/MetaReflection only as design-time or cross-trial learning comparators, not as direct live-governor equivalents.

### 11.5 Required ablations

Preserve the three source-specified B4 ablations:

1. remove the explicit persistent intention state object;
2. remove the authoritative control edge while retaining monitoring/logging;
3. remove the learning update while retaining the runtime transition.

Explain what each ablation isolates. Do not merge the three into one generic “remove memory” condition.

### 11.6 Controlled task suite

Propose tasks that vary environmental dynamism, method reliability, plan cost, feasibility changes, goal relevance, distractor pressure, and delegated work. Include long-horizon tasks where the same goal remains valid but the original method becomes invalid, and tasks where the goal itself becomes impossible or is explicitly amended. Use matched seeds and deterministic event injection where possible.

### 11.7 Falsification criteria

Reject or narrow B4 if: explicit intention state does not reduce goal drift; method switching does not improve outcomes over the strongest simpler baseline; reconsideration oscillates; completion or correct stopping worsens; method changes lack diagnostic value; or the lifecycle adds cost without measurable benefit. Preserve Fan & Lan's named failure modes: stale commitment, oscillation, premature stopping, and method changes without diagnostic value.\FanLanCite{Table VI; Appendix D, Table X}

### 11.8 Threats to validity

Discuss model and environment confounds, goal-drift measurement ambiguity, evaluator bias, false diagnosis labels, benchmark overfitting, domain-specific authority policies, and the difference between method change and plan editing. Keep results bounded to the tested tasks and versions.

---

## 12. Relationship to the other bundles and chapter handoff

### 12.1 Dependency summary

Fan & Lan identify B4 as the commitment boundary that scopes recovery and helps preserve the parent goal during B2. Workspace evidence may trigger B4 reconsideration. B6 governs risk, resources, tool authorization, interruption, and stopping. This chapter should use those relations to explain compositional control without pre-writing Chapters 16 or 18.\FanLanCite{Figure 8; Appendix D, cross-bundle dependencies}

### 12.2 What Chapter 15 does not solve

B4 does not itself supply a typed recovery substate, workspace admission policy, learned memory selector, skill verification DAG, or calibrated cross-stage uncertainty governor. It decides how a persistent intention remains active and how a method may be reconsidered under authority.

### 12.3 Handoff to Chapter 16 (B6)

Chapter 16 will address how uncertainty and resource budgets influence verification, interruption, tool authorization, and stopping across the execution process. Chapter 15 should flag that boundary and stop before teaching B6.

---

## 13. Recap, review questions, and practical exercises

### 13.1 Chapter recap

The recap should return to the central distinction: stable commitment to an authorized end does not require rigid commitment to one means; method flexibility is safe only when a durable intention and explicit authority structure govern it.

### 13.2 Review questions

1. Why is a prompt containing the user goal not equivalent to a persistent intention record?
2. How do blind, single-minded, and open-minded commitment differ?
3. Why are bold and cautious reconsideration schedules a separate axis?
4. What does MIDCA add beyond object-level planning and an execution log?
5. What authority must a governor possess to make reflection consequential?
6. Why must goal authority be separated from method authority and model proposal authority?
7. What does Fan & Lan's E1/D3 record for BDI-LLM preserve and omit?
8. Why is CCA not a complete general B4 implementation?
9. How can a method switch preserve a payment-status goal after an uncertain timeout?
10. Which ablation tests whether logging alone explains the improvement?

### 13.3 Practical exercises

- Design an intention record for a travel-booking goal and identify which fields remain stable when the booking method changes.
- Write a transition table that separates method change, suspension, delegation, impossibility, abandonment, and goal amendment.
- Implement a compare-and-swap method-switch operation and test stale-event handling.
- Create an event sequence where reacting to every new option is worse than selective reconsideration.
- Design a goal-drift experiment with a matched prompt-only baseline and an authoritative intention governor.
- Review a hypothetical model-generated proposal that changes the goal and identify the authority check that must reject it.

---

## 14. Planned figures and Mermaid source files

All figures will be authored as Mermaid sources in the chapter-specific source folder and included with `\BookDiagram` in the chapter. The following list is a drafting plan, not a claim that PNGs already exist.

1. `bdi-intention-cycle.mmd` — beliefs, desires, option filtering, intention, plan execution, observation, and commitment release; historical teaching reconstruction.
2. `commitment-versus-reconsideration.mmd` — two separate axes: termination conditions (blind/single-minded/open-minded) and reconsideration schedule (bold/cautious/intermediate).
3. `midca-dual-cycle.mmd` — object-level cognitive cycle and meta-level note-assess-guide control.
4. `b4-authority-architecture.mmd` — principal, goal store, intention registry, monitor, diagnosis, method governor, model proposals, method registry, safety gate, executor, delegation, and ledger.
5. `b4-intention-lifecycle.mmd` — proposed intention states and guarded transitions.
6. `productx-method-switch-sequence.mmd` — payment timeout, event, diagnosis, method switch, read-only reconciliation, possible suspension/delegation, verified completion.
7. `b4-outcome-evaluation.mmd` — required trace, outcomes, baselines, and the three source-specified ablations.

Every source must include `accTitle` and `accDescr`, use the shared theme, have a concise label set, and be referenced exactly once from the corresponding chapter figure placement unless a documented repeat is required.

---

## 15. Planned glossary and index integration

### 15.1 Glossary candidates

Before adding entries, check the shared glossary for duplicates and reuse stable terms. Candidate entries:

- belief;
- desire;
- intention;
- intention commitment;
- commitment strategy;
- intention reconsideration;
- reconsideration trigger;
- bold reconsideration;
- cautious reconsideration;
- object-level cycle;
- meta-level cycle;
- meta-control;
- method authority;
- method switch;
- goal drift;
- premature commitment;
- continuation condition;
- delegation contract;
- intention lifecycle.

Only add terms actually taught in the final chapter. Do not create synonyms for existing glossary entries.

### 15.2 Index candidates

BDI; belief; desire; intention; commitment; commitment policy; blind commitment; single-minded commitment; open-minded commitment; bold reconsideration; cautious reconsideration; goal drift; method authority; method switch; delegation; suspension; abandonment; MIDCA; meta-control; note-assess-guide; persistent intention; premature commitment; goal authority.

---

## 16. Source-fidelity and attribution plan

### 16.1 Fan & Lan (2026)

Primary source for the chapter's B4 residual, historical-to-modern comparison, E/D case labels, insertion point, closest baselines, failure conditions, cross-bundle dependencies, and Appendix D experiment template. Cite the relevant BDI/MIDCA historical reconstruction, B4 subsection, Table VI, Figure 8, R5a-R5c/R6 records, Table X, and Appendix D directly. Do not imply that the authors report a completed B4 implementation or an experiment validating the bundle.

### 16.2 Historical BDI sources

Use Rao and Georgeff (1991) for formal intention and mental-attitude framing; Rao and Georgeff (1995) for the practical BDI agent architecture and commitment termination conditions; Kinny and Georgeff (1991) for experimental distinctions among bold, cautious, intermediate reconsideration schedules and event-sensitive reaction. These historical sources are cited by Fan & Lan. Keep commitment termination and reconsideration frequency separate.

### 16.3 Historical MIDCA source

Use Cox et al. (2016) to explain the dual-cycle architecture and note-assess-guide procedure. The meta-level cycle can monitor and guide object-level method changes. Do not claim that MIDCA is identical to BDI or that the book's proposed intention schema appears in MIDCA.

### 16.4 Modern sources

Use only the specific systems and studies cited or discussed by Fan & Lan. Attribute each described mechanism to its own source; use Fan & Lan for the E/D mapping. Record publication status accurately: peer-reviewed proceedings/journal papers versus arXiv preprints and technical reports. In particular, the self-aware BDI work is a 2026 technical report with preliminary evaluation; CCA and the premature-commitment work are arXiv preprints unless a newer published version is verified at drafting time.

### 16.5 Claim categories

Use explicit wording to distinguish:

- **[Fan & Lan]** what the review directly reports or proposes;
- **historical source reconstruction** what the cited BDI/MIDCA source describes;
- **modern system report** what the named modern paper actually implements or evaluates;
- **[Book example]** Product X and any other illustrative scenario;
- **[Engineering decision]** proposed records, contracts, state machine, transaction semantics, authority matrix, safeguards, and test plan.

Only the book's two formal paper labels `[CoALA]` and `[Fan & Lan]` may be used. Chapter 15 is Part II and should use the shared `\FanLanCite{...}` macro for the primary paper.

---

## 17. Explicit exclusions and chapter boundaries

The chapter will not:

- turn the full BDI literature into a survey beyond the sources selected by Fan & Lan;
- merge commitment termination policies with reconsideration schedules;
- claim that reflection, logging, or a plan rewrite automatically provides method authority;
- claim that a model proposal is an authorized intention transition;
- claim that CCA solves the full general-purpose B4 lifecycle;
- conflate offline or across-trial method learning with live in-run method authority;
- teach B2 recovery internals, B3 workspace selection, B5 skill verification, or B6 uncertainty/resource governance in full;
- present the proposed Java contracts or architecture as source-prescribed mechanisms;
- invent a universal reconsideration score, fixed trigger threshold, or empirical result that the sources do not report;
- equate hidden-state stability with correctness.

---

## 18. Chapter completion and acceptance criteria

The chapter will be considered ready for author review only when:

1. the historical BDI and MIDCA mechanisms are accurately reconstructed;
2. commitment termination and reconsideration scheduling are kept as distinct dimensions;
3. all B4 modern examples retain their source-specific boundaries and separate E/D codes;
4. the distinction among goal authority, method authority, and model proposal authority is explicit;
5. the implementation bridge contains typed contracts, lifecycle state machine, authority matrix, persistence/concurrency strategy, side-effect rules, delegation/suspension semantics, anti-oscillation controls, Java-like interfaces, and a vertical-slice plan;
6. the Product X example demonstrates a method switch without goal substitution;
7. evaluation preserves Fan & Lan's required trace, primary outcomes, safety/efficiency measures, three ablations, and falsification criteria;
8. cross-bundle boundaries to B1, B2, B3, B5 and B6 are clear;
9. citations, glossary, index, seven Mermaid sources, labels, and references compile without unresolved entries;
10. the final individual PDF has been compiled with the repository's XeLaTeX/Biber pipeline, rendered to images, visually inspected, and text-extracted;
11. the source-fidelity and cross-chapter reviews are recorded;
12. no placeholder, mock diagram, or temporary-font build is represented as a final release PDF.

---

## 19. Outline decision and approval record

**Current status:** Proposed outline v1.0; awaiting individual author approval.  
**Drafting status:** Not authorized yet. `Tex/part2/chapter15/chapter.tex` remains a placeholder.  
**Next action after approval:** Draft Chapter 15 against this outline, implement the seven planned Mermaid sources, add only necessary shared glossary/index entries, update chapter-specific build and QA checks, compile the individual chapter PDF, inspect all diagrams and pages, and record the Batch 6 checkpoint.

---

## Primary source

Fan, Haodi, and Zucong Lan. “From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps.” arXiv:2607.23942 (2026). https://arxiv.org/abs/2607.23942.\autocite{fanlan2026mechanisms}
