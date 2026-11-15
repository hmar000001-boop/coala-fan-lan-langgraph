# Content Competition, Workspace and Broadcast: B3

**Part II:** From Cognitive Architectures to Mechanism-Level Understanding  
**Outline version:** 1.0  
**Status:** Approved by the author on 15 November 2026; Chapter 14 prose authorized.  
**Batch:** 5 of 9 — standalone Chapter 14.  
**Primary source:** Haodi Fan and Zucong Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps* (2026), especially §§ III-B, IV-B–IV-C, V-B, V-D, VI-B–VI-D; Tables III–VI and VII–XIII; Appendices C-E, C-F and D.  
**Historical cross-check:** Franklin, Strain, Snaider, McCall and Faghihi (2012), the LIDA/global-workspace paper cited by Fan & Lan as reference [11].  
**Modern examples:** Global Workspace Agents / *Theater of Mind for LLMs*, DyLAN, and Adaptive Graph Pruning, all explicitly included in Fan & Lan's frozen corpus.  

---

## 0. Executive outline decision and theory-to-practice bridge audit

### 0.1 The chapter's central question

How should an agent runtime decide which heterogeneous pieces of content deserve scarce shared workspace capacity, make the selected content available to the processes that need it, and learn from the downstream consequences so that later admission decisions improve?

The chapter is not a general introduction to attention, consciousness, multi-agent collaboration, or message passing. It studies the narrower B3 residual control bundle: **outcome-dependent admission of typed content coalitions inside a bounded broadcast cycle**.

### 0.2 The B3 hypothesis in the source's terms

Fan & Lan describe typed candidates from memory, agents, tools, monitors, and plans competing for a bounded shared workspace. A winning coalition becomes globally available for one cycle. Downstream utility then updates later admission. The paper identifies Global Workspace Agents (GWA) as the structural broadcast baseline, and DyLAN plus adaptive graph pruning as learned-admission baselines. B3 is unsupported if outcome-trained content admission adds no value over GWA's selection or a simpler top-k retrieval baseline.

The chapter must preserve all parts of this claim. It must not reduce B3 to any one of the following:

- ordinary top-k context retrieval;
- a message bus or shared conversation transcript;
- selecting which agents participate in a team;
- pruning edges from an agent communication graph;
- a global store in which all content persists indefinitely;
- a claim that a selected or broadcast item necessarily influenced the result.

### 0.3 The implementation bridge is necessary

**Audit result: a substantial bridge from theory to implementation is required.** The historical description and residual hypothesis explain the intended control relation, but they do not specify an implementation-ready candidate schema, coalition representation, workspace lifecycle, broadcast contract, consumer interface, outcome-attribution protocol, concurrency model, or learning deployment policy. Those omissions are appropriate for a research hypothesis; the book should make them explicit and then develop a clearly labelled engineering proposal.

The chapter's practical bridge will therefore include:

1. a reference architecture with candidate producers, normalization and provenance checks, coalition construction, a competition/admission governor, a bounded workspace, a broadcast router, downstream consumers, an outcome-attribution service, and an admission-policy learner;
2. typed candidate and coalition records, a cycle-scoped workspace lease, a broadcast snapshot, consumer receipts, and an outcome-attribution record;
3. a state machine from candidate collection through competition, admission, broadcast, downstream processing, outcome recording, policy update, and expiry;
4. explicit separation between the decision to broadcast a tool-related candidate and authorization to execute a tool or external action;
5. a concurrency and persistence plan that keeps the active workspace bounded and cycle-scoped while retaining a durable audit/outcome ledger;
6. safeguards for provenance, untrusted candidate content, sensitive information, stale evidence, rare-evidence suppression, source monopolization, and feedback loops;
7. a Product X worked example, an incremental implementation sequence, Java-like contracts/pseudocode, and tests that can be implemented by a reader;
8. an evaluation protocol aligned with Fan & Lan Appendix D, including the required state trace, baselines, ablations, outcome metrics, safety/efficiency measures, and falsification conditions.

These implementation details are **book-level engineering proposals**, not mechanisms that Fan & Lan claim to have implemented or exact algorithms supplied by LIDA. The chapter must repeatedly mark that boundary.

### 0.4 Teaching sequence

Follow the established sequence: problem first → concrete intuition → term → precise mechanism → worked example → boundary. Introduce each new term at the point where it becomes necessary. Do not begin with an abstract glossary or an ungrounded survey of global-workspace theories.

---

## 1. Opening: why shared context is not yet a workspace

### 1.1 Opening situation

Use a [Book example] based on the established Product X support-agent scenario. A payment incident generates several competing pieces of information at nearly the same time: a read-only payment-ledger observation, a monitor alert about delayed processor notifications, an older memory item about idempotency, a proposed retry plan, and an agent's tentative explanation. The next reasoning cycle cannot consume every candidate at full detail. The runtime must decide what should become common working content now.

The opening should ask:

- Is a shared transcript enough to make these items compete?
- Does storing every observation in a shared database make it available to action selection at the right time?
- Is choosing the most similar three items equivalent to selecting a coherent coalition?
- What does it mean for selected content to be broadcast rather than merely retrievable?
- How can the runtime tell later whether the admitted content helped?

### 1.2 A first intuitive distinction

A message bus moves content between components. A shared store makes content addressable. A top-k retriever ranks candidates against a query. A workspace mechanism adds a bounded admission decision with control consequences: candidates compete for scarce capacity, a winning coalition is made broadly available to relevant processes for a bounded cycle, and later outcomes can alter future admission.

The chapter must not imply that message transport, retrieval, or shared state is useless. They are possible infrastructure for a workspace; they are not the complete mechanism.

### 1.3 Chapter outcomes

By the end of the chapter, the reader should be able to:

- explain the LIDA workspace competition/broadcast cycle as reconstructed by Fan & Lan;
- distinguish a codelet coalition, a typed content coalition, an agent team, a communication edge, and a message;
- state exactly what B3 adds beyond GWA, DyLAN, graph pruning, and top-k retrieval;
- reconstruct B3 through the seven fields introduced in Chapter 10;
- design a cycle-bounded workspace and broadcast protocol with typed data contracts;
- separate selection, broadcast, consumption, use, and causal contribution;
- define an outcome-dependent learning signal without claiming that B3 supplies a universal scoring equation;
- evaluate the mechanism against the closest baselines and reject it when the added coupling does not help.

---

## 2. Locating B3 in Fan & Lan's mechanism map

### 2.1 What the paper calls the residual bundle

Explain the source's B3 phrase in full:

- **Content competition:** candidate content items or coalitions are considered against limited capacity.
- **Workspace:** a bounded, shared working stage, not the whole persistent memory store and not an unrestricted message archive.
- **Broadcast:** the selected coalition becomes available to the relevant downstream processes for one cycle.
- **Admission learning:** downstream utility/outcome evidence updates future admission decisions.

Describe the insertion point as **pre-inference admission** in Fan & Lan's Table VI. Explain that the control effect occurs before a subsequent inference/decision cycle consumes the selected content.

### 2.2 Why Fan & Lan keep B3 separate from B1

B1 selects existing memory items for a task context and couples accessibility, latency, downstream action utility, and maintenance cost. B3's candidate domain is broader: memory, agent proposals, tool observations, monitor signals, and plan fragments can all compete. Its core question concerns capacity and common availability within a bounded broadcast cycle. Mention the dependency: B1 and a migrated skill governor may supply candidates to B3, but B3 is not a memory-ranking algorithm.

### 2.3 Why B3 is not B5

B5 is the closed skill-governance case that Fan & Lan attribute to GraSP. B3 concerns which typed content coalition enters a workspace, not whether an executable skill is retrieved, verified, repaired, or routed to fallback. A skill may emit candidate content; its execution governance remains a separate matter.

### 2.4 The hypothesis is not a completed control algorithm

State explicitly that Fan & Lan identify the missing coupling and provide an insertion point, baselines, measurement requirements, and rejection criteria. They do not provide a universal B3 score formula, a canonical coalition-construction algorithm, a learned admission model, a production-ready schema, or experimental evidence that B3 improves performance. The chapter's proposed design is one way to make the hypothesis testable, not a claim about what the paper already built.

### 2.5 Evidence and migration codes

Preserve the paper's case-specific classifications and their scope:

- LIDA to Global Workspace Agents: E2/D3 for bounded workspace, attention selection, broadcast, and proposal write-back.
- LIDA-like learned competition to DyLAN and adaptive graph pruning: E3/D4 for agent-team or communication-edge admission, not typed content admission.

Explain why E2/E3 describe the evidence relation and D3/D4 describe the implementation depth of the particular mapped mechanism. Do not collapse the axes into a single score or describe a higher D level as complete migration.

---

## 3. Historical anchor: LIDA's competition and broadcast mechanism

### 3.1 The problem LIDA addresses in the source's reconstruction

Many specialized codelets can produce or recognize content, but not all content can enter a limited global workspace at once. The architecture needs competition to determine which coalition gains access. A winner then becomes available to memory, action-selection, and learning processes, changing what those processes can do in the next cycle.

Keep the discussion at the mechanism level reconstructed by Fan & Lan. The book is not a comprehensive treatment of consciousness or a full neuroscience account of global workspace theory.

### 3.2 Codelets and coalitions

Introduce codelets as the small specialized processes named in Fan & Lan's LIDA reconstruction. Explain that multiple codelets can form a coalition around related content. The coalition, rather than every codelet independently receiving unlimited access, is the unit that competes for the constrained workspace opportunity in the account used by the paper.

Cross-check the historical description against Franklin et al. (2012), which Fan & Lan cite as reference [11]. Use that source narrowly for terminology and LIDA's described organization; do not elevate it into a third overarching book foundation.

### 3.3 The cycle, step by step

Explain the following source-grounded progression:

1. specialized codelets process available content and produce candidate contributions;
2. related contributions participate in coalition formation;
3. coalitions compete for limited global-workspace access;
4. a winner gains workspace access;
5. the selected content is broadcast to memory, action-selection, and learning processes;
6. downstream processes operate on the newly available content;
7. consequences of the cycle can affect later admission and action.

Do not add an unsupported numeric threshold, exact competitive equation, fixed number of slots, or claim that every LIDA variant uses an identical implementation.

### 3.4 What persists, and what is cycle-bound

Distinguish the transient workspace opportunity from memory and other longer-lived state. The active content is available for the relevant cycle; it does not follow that every broadcast item becomes permanent memory. This lifetime distinction will become important in the modern design.

### 3.5 A small illustrative cycle

Use a simple non-Product-X example only if it clarifies the historic mechanism, and label it as a book teaching illustration. Prefer to reuse the Product X case in the implementation bridge so that the chapter does not accumulate unrelated fictional examples.

### 3.6 Historical boundary

Do not claim that LIDA's codelet coalition is identical to Fan & Lan's proposed modern typed content coalition. The source uses the historical mechanism to motivate a modern residual; the candidate objects and runtime boundaries change in translation. This semantic shift is one of the chapter's central teaching points.

---

## 4. Blackboard control as a neighboring mechanism, not a substitute

### 4.1 Hearsay-II in Fan & Lan's catalog

Briefly explain the Hearsay-II blackboard as a shared representation containing layered partial hypotheses. A change on the blackboard can enable knowledge sources, and an agenda scheduler selects which enabled source acts next. The distinctive object is an evolving partial solution rather than a message channel.

### 4.2 Compare blackboard scheduling and workspace broadcast

Use a concise comparison:

- Blackboard: contributors post or refine partial hypotheses in a shared problem representation; enabled knowledge sources compete for the next scheduling opportunity.
- B3/LIDA-inspired workspace: typed content coalitions compete for bounded workspace access; a winner is broadly broadcast for a cycle; downstream outcome feeds later admission.

A blackboard may serve as an implementation substrate, and a workspace could include a partial-solution representation. They are not equivalent merely because both are shared. Fan & Lan's modern mapping places AutoGen and AgentScope at E4/D2 for shared message/state boundaries, while identifying the missing common partial-solution value model and opportunistic agenda law for Hearsay-II. This chapter should use that comparison only to clarify the distinction, not reopen Chapter 11's full historical-to-modern catalog.

---

## 5. Modern baselines and what each one does—and does not—establish

### 5.1 Global Workspace Agents (GWA)

Fan & Lan identify GWA, described in *Theater of Mind for LLMs*, as the closest structural broadcast baseline. The reviewed implementation includes a limited working stage, attention selection, global broadcast, specialized proposal write-back, and an entropy-conditioned drive. Fan & Lan code the LIDA-like workspace correspondence E2/D3 and identify outcome-trained content admission as the remaining breakpoint.

The chapter should explain the preserved properties and missing learning edge without claiming that the authors' proposal has been independently validated as a complete B3 implementation. Mention that the cited work is an arXiv preprint in the frozen corpus, and give its status accurately.

### 5.2 DyLAN

Fan & Lan use DyLAN as a learned-admission baseline. Its candidates are agents: preliminary contribution evidence supports selection of an active team, followed by task solving with a dynamic communication structure. This is important evidence that outcome/contribution-aware competition can change who participates, but it does not establish admission of typed content coalitions into a shared broadcast workspace.

### 5.3 Adaptive Graph Pruning

Fan & Lan use adaptive graph pruning as a learned edge/topology-admission baseline. The primary paper's abstract describes hard-pruning of agent quantity and soft-pruning of communication topology. This changes which agents or communication links remain active; it does not select the typed content coalition that becomes globally available in a bounded cycle.

### 5.4 Comparative table

Include a source-faithful table with columns:

- system/case;
- object that competes or is selected;
- bounded shared-workspace broadcast present in the reviewed description?;
- what experience changes;
- what it establishes;
- what B3 property remains absent.

Rows: LIDA, GWA, DyLAN, adaptive graph pruning, Hearsay-II/blackboard, and simple top-k retrieval. Top-k is an experimental baseline, not a mechanism record that Fan & Lan classify as E/D.

### 5.5 Do not rank unlike systems on one axis

Avoid an overall leaderboard. Compare each case against the exact B3 component it preserves. An E3/D4 result for agent admission is not automatically stronger than an E2/D3 result for workspace broadcast; the candidate objects and control edges differ.

---

## 6. The critical semantic distinctions

### 6.1 Five different things that are often called “shared context”

Define and contrast:

1. **Message:** a transport unit sent from one component to another.
2. **Shared store/blackboard:** a persistent or semi-persistent representation that components can read or update.
3. **Agent team:** the set of agents allowed to participate in a collaboration.
4. **Communication topology:** which agents can exchange messages and through which edges.
5. **Workspace coalition:** a typed bundle of content selected for bounded, cycle-scoped broadcast to relevant processes.

### 6.2 Historical codelet coalition versus modern content coalition

This subsection is mandatory. LIDA's historical coalitions are coalitions of specialized codelets in the architectural account. Fan & Lan's B3 proposal speaks of typed content candidates originating from memory, agents, tools, monitors, and plans, and of a coalition of such content competing for the workspace. These objects are related by a workspace-competition pattern but should not be treated as literally identical data structures or processes.

### 6.3 Selected, admitted, broadcast, consumed, used, and helpful

These are different events:

- **Selected:** the governor chose a candidate/coalition.
- **Admitted:** it was granted workspace capacity.
- **Broadcast:** the selected snapshot was made available to eligible consumers.
- **Consumed/read:** a consumer actually accessed it.
- **Used:** the consumer incorporated it into a proposal, decision, or action.
- **Helpful:** evidence indicates that it improved the downstream result.

The learning process must not infer helpfulness merely from selection or broadcast. This distinction drives the implementation's event model and evaluation.

### 6.4 Global does not mean unbounded or universally visible

In the source's bounded-cycle sense, a selected coalition is made available broadly to relevant processes. The implementation proposal will define the eligible consumer set and enforce data permissions. It does not mean cross-user, cross-session, or unrestricted global disclosure. Workspace scope and privacy scope are separate dimensions.

---

## 7. Reconstructing B3 through the seven mechanism fields

Use the analytical vocabulary from Chapter 10 without reteaching the entire chapter.

### 7.1 State (S)

The operative state includes typed candidate content, candidate provenance and validity, coalition membership, workspace capacity, the current winning coalition, consumer availability, downstream observations, and the history used by future admission learning. Separate the ephemeral active workspace from the persistent event/outcome ledger.

### 7.2 Control (C)

The competition/admission governor controls which coalition enters the workspace. The language model and specialized agents may generate candidate proposals, but their proposals do not themselves authorize admission or external actions. Broadcast routing controls which eligible consumers receive the selected snapshot.

### 7.3 Transition (T)

Candidate arrival and a workspace-cycle boundary trigger collection and competition. Admission changes the workspace state and causes broadcast. Downstream outcome events trigger the learning update for later cycles. Define the cycle boundary rather than assuming all systems operate in synchronous wall-clock rounds.

### 7.4 Persistence (P)

The active workspace is bounded and cycle-scoped. Candidate provenance, event traces, feedback, and the learned admission policy may persist longer. The chapter must explicitly ask what expires and what is retained for audit or future policy updates.

### 7.5 Failure (F)

Address missed decisive evidence, high-volume distractors, redundant or incoherent coalitions, stale or contradictory candidates, over-broadcast, source monopolization, rare-evidence suppression, broadcast feedback loops, consumer disagreement, and incorrect attribution of outcome to a selected coalition.

### 7.6 Learning (L)

A downstream utility/outcome signal changes later admission. The source does not prescribe an exact learning algorithm. Explain the engineering alternatives as proposals: offline supervised/ranking updates, contextual-bandit-style updates, or a conservative rule update. Do not present any one as Fan & Lan's B3 equation.

### 7.7 Resources and governance (R)

The workspace is capacity-limited. Resource constraints can include token/context budget, item or coalition count, attention/inference time, candidate-generation cost, broadcast fan-out, and policy-update overhead. Distinguish the workspace budget from system-wide tool/action authorization, which belongs to other control mechanisms and later B6 treatment.

### 7.8 Summary mechanism chain

Present the complete chain in prose and diagram form:

candidate generation → typed normalization/provenance → coalition formation → bounded competition → admission → broadcast → downstream processing → outcome attribution → later admission update.

Explain which edges are directly stated by Fan & Lan and which internal components are engineering elaborations used to make the hypothesis implementable.

---

## 8. Worked [Book example]: Product X and the payment-timeout incident

### 8.1 Incident context

Continue the same Product X support scenario used in Chapters 12–13. The agent must respond to a payment incident where the processor's settlement status is initially uncertain. A read-only ledger observation, a monitoring alert, a memory note about idempotency, an agent's suggested retry, and a plan fragment arrive close together.

### 8.2 Typed candidates

The candidate set should include representative types without inventing a production product specification:

- `MemoryEvidence`: a prior, versioned note about idempotency behavior;
- `ToolObservation`: a read-only payment-ledger result showing the current settlement status is not yet conclusive;
- `MonitorAlert`: a processor notification-delay signal with timestamp and provenance;
- `AgentProposal`: a tentative interpretation or recommendation;
- `PlanFragment`: a proposed next step, such as checking settlement status before any retry.

The outline should show candidate provenance, freshness, scope, confidence/validation state, estimated token cost, and sensitivity metadata. These fields are proposed for the worked implementation; Fan & Lan do not prescribe this schema.

### 8.3 Forming candidate coalitions

Demonstrate two competing content coalitions:

- a diagnostic/evidence coalition containing the current ledger observation, monitor alert, and applicable idempotency evidence;
- an action-oriented coalition containing the unsupported retry proposal and its plan fragment.

The exercise is to show that a coalition can be more informative than an isolated item, but that coalition formation must not smuggle an unsupported conclusion into a bundle merely because one member is useful. Every member retains its own provenance and validity.

### 8.4 Competition and admission

A bounded workspace governor evaluates the candidate coalitions under the current cycle's capacity. The outline must not invent a canonical B3 scoring formula. It may show one transparent illustrative policy, but must label it as an engineering baseline and compare it against top-k and GWA selection. The diagnostic coalition wins in the teaching scenario because its combined evidence is better supported and more relevant to the current decision, not because the source paper supplies a particular numeric weight.

### 8.5 Broadcast and consumer responses

The winning snapshot is made available to eligible memory, reasoning/action-planning, monitoring, and learning consumers for that cycle. A consumer receipt records access. A later proposal can request a further read-only settlement check. Broadcast itself does not authorize a payment retry, capture, refund, or other external side effect.

### 8.6 Outcome attribution

The read-only check resolves settlement status; the agent then gives a correct explanation and avoids an unnecessary duplicate retry. The outcome record captures which coalition was selected, which consumers read it, what downstream proposal/action referenced it, and what result followed. It must distinguish correlation from causal contribution.

### 8.7 Counterexample

Show how a popularity-driven admission policy might repeatedly select generic troubleshooting notes while suppressing a rare but decisive monitor event. This illustrates why simple frequency or repeated broadcast is not a safe proxy for downstream utility.

---

## 9. Theory-to-practice bridge: a reference workspace subsystem

This is a major chapter section, not an appendix or a short “future work” paragraph.

### 9.1 Reference architecture

The proposed architecture should contain these cooperating roles:

1. **Candidate producers:** memory retriever, agent workers, tool adapters, monitors, and planners emit typed candidate envelopes.
2. **Candidate registry/normalizer:** validates schema, provenance, scope, expiry, trust, sensitivity, and resource estimates.
3. **Coalition builder:** groups related candidates where their joint meaning is useful; records membership and dependencies. It must preserve each member's identity and source.
4. **Competition/admission governor:** evaluates eligible coalitions against workspace capacity and policy constraints; selects a winner or admits none.
5. **Workspace store:** holds the active cycle's selected snapshot under an explicit lease/cycle ID and a hard capacity limit.
6. **Broadcast router:** publishes the same versioned snapshot to the allowed downstream consumers.
7. **Consumers:** memory, reasoning/action selection, monitoring, and learning read the broadcast; they do not mutate the active snapshot.
8. **Outcome/attribution service:** records consumer receipts, actual use evidence, decisions, and task outcomes.
9. **Admission-policy learner:** updates future policy versions from attributed outcome data, with offline evaluation and guarded promotion.

Mark this entire architecture as an `[Engineering decision]` proposal built to operationalize B3, not a diagram copied from Fan & Lan.

### 9.2 Typed data contracts

The chapter should show Java-like records or language-neutral contracts for at least:

**CandidateEnvelope**
- stable candidate ID and version;
- candidate type (`MEMORY_EVIDENCE`, `AGENT_PROPOSAL`, `TOOL_OBSERVATION`, `MONITOR_ALERT`, `PLAN_FRAGMENT`);
- payload/content reference rather than an unbounded inline blob;
- source identity and provenance evidence;
- task/goal scope and validity interval;
- trust/confidence/validation metadata;
- sensitivity/authorization scope;
- creation/observation time;
- token/resource estimate;
- dependency and contradiction references.

**ContentCoalition**
- coalition ID/version;
- member candidate IDs and versions;
- why the members belong together (a typed relation or explicit assembly rationale);
- joint scope, validity, and token cost;
- unresolved conflicts or missing evidence;
- provenance preserved at member level.

**WorkspaceLease / WorkspaceSnapshot**
- cycle ID and version;
- winning coalition ID;
- capacity consumed and remaining;
- eligible consumer set;
- admission policy version;
- admitted, broadcast, expiry, and closure timestamps;
- immutable digest/snapshot reference.

**ConsumerReceipt**
- cycle and snapshot version;
- consumer identity;
- read/access time;
- whether content was used in a proposal or decision;
- referenced member candidates;
- rejection/ignore reason when relevant.

**OutcomeAttribution**
- task/episode ID and outcome;
- coalition and member candidate versions;
- selected/broadcast/read/used markers;
- observed task-quality, safety, latency and resource signals;
- attribution confidence and known confounders;
- evaluator/policy version.

**AdmissionPolicySnapshot**
- version and training window;
- feature/normalization contract;
- objective and constraints;
- source/type coverage statistics;
- calibration/validation results;
- rollout and rollback status.

The chapter should explicitly distinguish the candidate's content version from the workspace snapshot version and from the learned policy version.

### 9.3 Interfaces and authority

Use a compact set of conceptual interfaces, for example:

- `propose(context) -> CandidateEnvelope[]` (candidate producer)
- `validate(candidate, scope) -> ValidationResult`
- `form(candidates) -> ContentCoalition[]`
- `select(coalitions, budget) -> AdmissionDecision`
- `openLease(decision) -> WorkspaceLease`
- `publish(snapshot, recipients) -> BroadcastReceipt[]`
- `attribute(trace, outcome) -> OutcomeAttribution`
- `update(policy, feedback) -> PolicyCandidate`

These are proposed contracts for the chapter's worked design, not APIs claimed to exist in GWA or Fan & Lan. Make the authority rule explicit: model-generated proposals may enter the candidate pool, but only the governor can admit; broadcast is read-only; downstream external actions are separately authorized.

### 9.4 The cycle state machine

Specify and diagram the states:

The normal lifecycle has these states, in order:

- `COLLECTING`
- `VALIDATING`
- `COALITION_FORMATION`
- `COMPETING`
- `ADMITTED`
- `BROADCAST`
- `CONSUMING`
- `OUTCOME_RECORDED`
- `POLICY_UPDATE`
- `EXPIRED`

The chapter will show the legal transition edges and failure exits in a state-machine diagram.

Include failure/side transitions:

- invalid or expired candidates are rejected before competition;
- no admissible coalition yields an empty workspace or a safe fallback, not fabricated content;
- budget exhaustion is explicit;
- broadcast delivery failure is recorded without silently changing the selected coalition;
- a consumer cannot mutate the broadcast snapshot;
- a late consumer or outcome must refer to the exact cycle and snapshot version;
- after expiry, content is no longer implicitly active, even if its audit record persists.

Discuss whether a runtime runs cycles synchronously or event-triggered. A cycle ID and admission deadline are needed in either case; the design should not assume a single global clock across all producers.

### 9.5 Coalition formation and competition policy

Explain the engineering problem of grouping interdependent items without creating artificial confidence. The coalition builder may use typed relations, shared task scope, source dependencies, contradiction links, and joint evidence rationale. A single high-confidence member must not make every other member appear high-confidence.

Describe policy options without claiming that the source defines a score:

- deterministic rule-based admission as the first baseline;
- top-k/score ranking as a baseline;
- learned outcome-dependent admission as the B3 intervention;
- a conservative no-admission path when all candidates fail hard validity or safety constraints.

The chapter may show a sample decision API and an illustrative score only if the score is explicitly identified as a proposed baseline. It must not present a new formula as “the B3 equation.”

### 9.6 Broadcast and read semantics

Explain snapshot publication, consumer eligibility, read-only semantics, receipts, and expiry. The winning coalition is available to the relevant consumers for the bounded cycle; this should not silently become durable long-term memory. Persistent learning comes from a separate event/outcome pipeline.

### 9.7 Outcome attribution and the learning loop

Define the event distinctions: selected, admitted, broadcast, read, used, helpful. Explain the attribution problem when several candidates work together or when a model cites content without relying on it. Proposed methods can include consumer receipts, explicit evidence references, controlled holdout/ablation, and delayed outcome windows. State their limitations.

The learner updates a future admission policy only after a quality-controlled feedback batch is available. The outline should compare conservative offline updates, shadow evaluation, canary release, and rollback. It must avoid claiming the Fan & Lan paper mandates any specific optimizer or exploration policy.

### 9.8 Concurrency, persistence, and reproducibility

Cover:

- one authoritative admission decision per workspace cycle;
- immutable snapshots and versioned policy parameters;
- deduplication/idempotency for duplicate candidate events and consumer receipts;
- event ordering and late arrivals;
- handling parallel candidate producers;
- preventing a new cycle from mutating a prior cycle's broadcast;
- reproducible replays from candidate, policy and outcome snapshots;
- what is transient (active workspace) and what is durable (candidate provenance, decisions, receipts, outcomes, policy versions).

### 9.9 Security, privacy, and safety boundaries

Discuss the workspace as a data-sharing boundary. Before broadcast, enforce candidate provenance, source trust, task scope, confidentiality and consumer authorization. Treat untrusted candidate payloads as data, not instructions. Preserve source labels and avoid dropping warnings during coalition assembly. Do not send sensitive candidates to consumers without permission.

A tool result or plan fragment in the workspace is not an execution authorization. Payment actions and other external side effects still pass through their own policy and approval controls. Preview B6 only to locate this boundary; do not teach B6's complete uncertainty/resource governor here.

### 9.10 Failure modes and operational safeguards

Required failure modes:

- top-k or popularity bias hides rare, decisive content;
- frequent sources monopolize the workspace;
- coalition assembly merges conflicting claims and masks disagreement;
- a candidate is stale or invalidated during the cycle;
- broadcast fan-out exceeds capacity or leaks content;
- a consumer mistakes a proposal for verified evidence;
- outcome learning rewards exposure or correlation rather than contribution;
- model-generated content creates a self-reinforcing feedback loop;
- candidate or coalition count grows beyond the admission deadline;
- policy updates regress under distribution shift.

For each, identify a detection signal, a safe default, and a test. Include diversity or coverage constraints only as candidate engineering controls to be evaluated, not as source-specified B3 invariants.

### 9.11 Incremental implementation plan

An implementable vertical slice should proceed in stages:

1. **Typed candidates and provenance:** collect from two producers and preserve type/version/source evidence.
2. **Static bounded workspace:** enforce a hard budget and deterministic admission; no learning yet.
3. **Read-only broadcast:** publish an immutable cycle snapshot to at least two independent consumers.
4. **Event instrumentation:** record selection, broadcast, receipt, use references, outcomes, costs, and expiry.
5. **Baseline comparisons:** top-k and GWA-style attention/broadcast behavior under matched budgets.
6. **Outcome-dependent update:** train or update an admission policy offline from validated attribution data.
7. **Shadow/canary and rollback:** evaluate new policy against a frozen baseline before it controls admission.
8. **Expanded candidate types and cross-bundle integration:** add B1 memory candidates and, in later synthesis, B6 resource/uncertainty context.

At each step, specify what can be tested before moving forward. The chapter should give at least one Java-like pseudocode listing for the control loop and a separate record/interface listing. Avoid a full production framework implementation; Part III will provide the broader Java runtime build.

---

## 10. Evaluation: does B3 add value beyond selection and broadcast baselines?

### 10.1 Preserve Fan & Lan Appendix D's protocol

The source requires a matched comparison with the base model, prompt, tools, environment and task budget held fixed. Internal-state instrumentation is necessary; outcome scores alone cannot show that the proposed control edge caused a difference.

For B3, preserve the paper's required trace:

- candidate type;
- score/decision evidence used by the selected policy;
- winner;
- broadcast recipients;
- admission update.

Preserve the paper's primary outcomes:

- relevant-evidence density;
- distractor robustness.

Preserve the paper's safety/efficiency outcomes:

- context cost;
- rare-evidence suppression;
- workspace turnover.

The primary source rejection condition is that top-k retrieval matches the results or decisive evidence is suppressed. Explain exactly how each is operationalized in the proposed experiment, while noting that numeric thresholds and sample sizes belong in a future task-specific preregistration.

### 10.2 Baselines

At minimum compare:

1. native/top-k retrieval or simple score-based selection;
2. GWA-style bounded attention and broadcast without outcome-trained typed-content admission;
3. a learned admission baseline adapted from the relevant idea in DyLAN/graph pruning, while clearly noting that these choose agents/edges, not content coalitions;
4. the proposed B3 cycle with outcome-dependent typed-coalition admission.

Do not claim that an adapted baseline is the original system. Label any adaptation as experimental translation.

### 10.3 Required ablations

Keep the three source-required ablations explicit:

- remove the new state object while preserving a comparable interface;
- remove the authoritative admission/broadcast edge but retain logging;
- remove the learning update while preserving the runtime transition.

Additional B3-specific ablations:

- no coalition grouping (individual candidates compete);
- no broadcast (selected content remains queryable only);
- no outcome attribution (selection counts alone update policy);
- no fairness/coverage guard, if such a guard is included in the proposed implementation;
- no B1 memory candidates versus B1 candidates included;
- baseline B1 plus B3 versus B1 plus B3 and B6 uncertainty/resource signals.

These must be used to distinguish the value of content competition, broadcast, coalition formation, and outcome-dependent learning.

### 10.4 Metrics and measurement design

The outline should develop concrete definitions for:

- task success and correctness;
- relevant-evidence density in the active context;
- distractor robustness under controlled noise;
- decisive-evidence recall/suppression;
- context tokens and workspace occupancy;
- candidate-to-admission and admission-to-broadcast latency;
- workspace turnover and repeated displacement;
- source/type coverage and starvation;
- outcome attribution coverage and confidence;
- policy stability and regression rate;
- cost per completed task.

Distinguish metrics reported by the source from additional book-proposed diagnostics.

### 10.5 Threats to validity

Discuss attribution confounding, exposure bias, source imbalance, coalition interaction effects, model stochasticity, task mix, delayed outcomes, and the risk that a learned policy memorizes the evaluation distribution. The original paper explicitly states that no experiment yet compares B3 against the D3/D4 baselines; the chapter must not imply experimental validation.

### 10.6 Falsification and stopping rule

B3 should be rejected or narrowed when a simpler top-k or GWA-like policy is non-inferior within the preregistered margin and no more costly; when rare decisive evidence is suppressed; when the learning update does not improve later admission; when broadcast is not used by the downstream processes; or when the benefit depends on unbounded context or excessive fan-out.

---

## 11. The seven-field analysis and the boundary to the remaining bundles

### 11.1 Seven-field summary table

Close the analytical core with a compact S/C/T/P/F/L/R table. Explicitly mark each field as:

- source-described B3 content;
- book interpretation of that source description;
- proposed runtime representation.

### 11.2 B1, B2, B4, B5 and B6 boundaries

- B1 supplies memory candidates and memory-specific accessibility/value policy; B3 decides whether broader typed content coalitions enter shared context.
- B2 can provide verified results or candidate evidence, but a recovery branch is not a workspace.
- B4 may scope the goal and can be affected by workspace evidence, but commitment authority is not B3.
- B5/GraSP may produce executable skills or skill results that become candidates; workspace admission is not skill invocation governance.
- B6 may govern resource/risk signals, verification budget, interruption and stopping across a workspace cycle; this chapter does not claim to implement the full B6 governor.

### 11.3 Cross-bundle dependency preview

Use Fan & Lan Figure 8 and §VI-D to explain only the dependencies relevant to B3: B1 and the migrated skill governor supply candidates; B3 controls bounded workspace admission; B6 governs resources/risk across the mechanisms; workspace evidence may trigger reconsideration in B4. Defer the complete dependency synthesis to Chapter 18.

---

## 12. Recap, questions and exercises

### 12.1 Chapter recap

Restate the distinction between content competition, bounded workspace, broadcast and outcome-dependent admission learning. Emphasize that message transport, top-k retrieval, agent-team selection and topology pruning preserve useful but different control edges.

### 12.2 Review questions

Include questions that require the reader to:

- explain why a message bus is not a global workspace;
- distinguish LIDA codelet coalitions from B3 typed content coalitions;
- explain the exact modern baseline gap left by GWA;
- identify why DyLAN and graph pruning are admission precedents but not B3 implementations;
- reconstruct B3 using S/C/T/P/F/L/R;
- distinguish selection, broadcast, use and helpfulness;
- identify the correct authority boundary for a tool-related candidate;
- explain why the source does not prescribe a universal B3 scoring equation.

### 12.3 Practical exercises

1. **Candidate typing:** classify at least eight candidates from a multi-agent task and retain provenance, validity, scope and cost.
2. **Coalition design:** build two competing content coalitions and identify which relationships justify bundling their members.
3. **Protocol design:** define the workspace state machine, the broadcast snapshot and consumer receipt for an event-driven runtime.
4. **Failure analysis:** create a rare-evidence suppression and feedback-loop counterexample; propose tests and safe fallbacks.
5. **Ablation plan:** specify how to compare top-k, GWA-style selection, learned agent/edge admission and B3 content admission under matched budgets.

---

## 13. Figures and diagrams planned for the chapter

All diagrams will be editable Mermaid sources in the Chapter 14 directory under `Tex/diagrams/source/part2/`, with `accTitle`, `accDescr`, shared theme and accessible captions. CI generates PNGs; no TikZ, ASCII diagrams, hand-positioned LaTeX nodes or unpinned renderer calls.

1. **LIDA competition and broadcast cycle:** specialized codelets → coalition competition → bounded workspace winner → broadcast to memory/action/learning → next-cycle effects.
2. **What exactly competes?:** contrast codelet coalitions, typed content coalitions, agent teams, communication edges and individual retrieved items.
3. **Modern baseline map:** GWA's broadcast/attention structure versus DyLAN team admission and adaptive graph topology pruning; highlight the remaining typed-content outcome-learning gap.
4. **B3 reference implementation:** candidate producers, validation, coalition builder, admission governor, cycle workspace, broadcast router, consumers, outcome attribution, policy learner.
5. **Workspace state machine:** collection through expiry, including rejection, no-winner and delivery-failure paths.
6. **Product X worked coalition:** incident evidence coalition versus unsupported retry coalition, with the winner broadcast to read-only consumers and outcome recorded.
7. **Evaluation and learning loop:** state trace, downstream outcome, attribution and a versioned future admission policy; show where ablations cut the loop.

The final number may be reduced if two diagrams duplicate the same teaching point. No illustration will be kept merely to increase figure count.

---

## 14. Planned glossary and index integration

### 14.1 Glossary candidates

Add only terms that are used repeatedly and merit book-wide reuse. Candidate entries:

- global workspace;
- workspace competition;
- broadcast;
- content coalition;
- candidate admission;
- workspace cycle;
- consumer receipt;
- outcome attribution;
- admission policy;
- workspace turnover.

The chapter must define each term in prose on first use. Do not overload the glossary with temporary field names or every record property.

### 14.2 Index candidates

Plan entries for attention competition, blackboard, broadcast, candidate content, content coalition, DyLAN, Global Workspace Agents, Hearsay-II, LIDA, message bus, outcome attribution, top-k retrieval, workspace capacity, workspace cycle, and workspace admission.

---

## 15. Source-fidelity and drafting rules for Chapter 14

### 15.1 Fan & Lan source map

The chapter's main claims must be traceable to:

- § III-B: LIDA and Hearsay-II mechanism descriptions;
- § IV-B–IV-C: Global Workspace Agents, DyLAN, adaptive graph pruning, and implementation/equivalence boundaries;
- § V-B, “Workspace changes candidate type and broadcast semantics”;
- § V-D: remaining B3 breakpoint and Hearsay-II boundary;
- § VI-B: why B3 remains separate from B1 and other bundles;
- § VI-C, B3 and Table VI: B3 hypothesis, insertion point, baselines and falsifier;
- § VI-D and Figure 8: candidate dependencies and B1/B6 cross-bundle experiments;
- § VII-C: no experiment has yet compared B3 against the D3/D4 baselines;
- Appendix A, Tables VII–VIII: LIDA and Hearsay-II S/C/T/P/F/L/R entries;
- Appendix B, Table IX: specific migration breakpoints;
- Appendix C-E/C-F: GWA and learned competition claim packets;
- Appendix D, Table X: required B3 trace, outcomes, resource measures, rejection rule, and ablations;
- Appendix F, Table XIII: included modern cases and status.

### 15.2 Historical source cross-check

Use Franklin et al. (2012), already cited by Fan & Lan as reference [11], only to verify the historical LIDA/global-workspace account and terminology. Keep Fan & Lan as the formal Part II source and avoid presenting a new third theory foundation.

### 15.3 Modern source use

The chapter may name and briefly explain Global Workspace Agents, DyLAN and adaptive graph pruning because Fan & Lan explicitly include them in the frozen corpus. The chapter should cite the original papers, state their publication/preprint status accurately, and avoid adding features beyond what the primary source and Fan & Lan description establish.

### 15.4 Claim categories

Use clear prose distinctions:

- **[Fan & Lan]:** review's explicit mechanism reconstruction, mapping codes, residual hypothesis, baselines, metrics and limitations;
- **[Historical source]:** a LIDA fact checked in Franklin et al. (2012), which Fan & Lan cite;
- **[Modern source]:** an explicitly included GWA/DyLAN/AGP feature;
- **[Book interpretation]:** an explanation of why the distinction matters;
- **[Book example]:** Product X scenario;
- **[Engineering decision]:** proposed records, interfaces, state machine, attribution approach, safety rules, deployment sequence and tests.

### 15.5 Explicit limitations

Do not claim:

- a universal B3 equation or trained admission model is already specified by Fan & Lan;
- LIDA codelet coalitions and modern typed content coalitions are the same data structure;
- DyLAN or graph pruning performs content-level workspace broadcast;
- GWA includes the outcome-trained typed-content admission edge that B3 proposes;
- a broadcast or prompt inclusion proves use or causal helpfulness;
- B3 has already been experimentally validated;
- a selected tool candidate authorizes tool execution;
- higher E/D codes mean complete migration or overall system quality.

---

## 16. Chapter completion criteria

The chapter draft will be considered complete only when:

1. the historical LIDA account follows Fan & Lan § III-B and the cited Franklin et al. source;
2. B3 is reconstructed using all four linked elements: typed content competition, bounded workspace, one-cycle broadcast, and outcome-dependent future admission;
3. the semantic gap between codelet coalitions, typed content coalitions, agent teams and communication edges is explicit;
4. GWA, DyLAN and adaptive graph pruning are compared at the level of what each actually selects and controls;
5. the source's E/D values and Appendix D measurements/falsifier are preserved without being collapsed or upgraded;
6. the theory-to-practice bridge includes architecture, typed records, interfaces, lifecycle, state machine, concurrency, persistence, safety, worked example, implementation sequence and tests;
7. the chapter distinguishes source-derived claims from engineering proposals and book-created examples;
8. at least the three source-required ablations are explained and a practical evaluation protocol is specified;
9. glossary, index, citations, figure captions, labels and all cross-references resolve;
10. every Mermaid figure is rendered by the pinned CI tool and visually inspected at print size;
11. the standalone chapter PDF and full-book build pass XeLaTeX/Biber, quality checks and visual inspection;
12. the source review and delivery status are recorded in the repository.

**Approval status:** This outline is ready for author review. No Chapter 14 prose should be drafted until the author approves this outline.
