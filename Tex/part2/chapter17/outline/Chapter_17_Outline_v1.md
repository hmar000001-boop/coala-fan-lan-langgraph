# Chapter 17 Outline v1.0

## The Closed Candidate B5 and GraSP

**Part II — From Cognitive Architectures to Mechanism-Level Understanding**  
**Writing plan:** Batch 8 — Chapter 17 only (special methodological case)  
**Status:** Approved outline v1.0; minor-issue review completed on 15 November 2026.  
**Drafting status:** Authorized by the author on 15 November 2026.  
**Primary theoretical source:** Fan and Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps* (2026), arXiv:2607.23942v1.  
**Primary system case:** Xia et al., *GraSP: Graph-Structured Skill Compositions for LLM Agents* (2026), arXiv:2604.17870v1.

---

## 0. Executive decision and special-case assessment

### 0.1 Why Chapter 17 is not a sixth residual-mechanism chapter

The author-approved Part II plan assigns Chapter 17 to the closed B5 candidate and GraSP. B5 began as one of six candidate bundles in Fan and Lan's residual-extraction process. It proposed a coupled control chain involving calibrated multi-skill routing, typed verification, bounded repair, and planner fallback. Closest-baseline screening then identified GraSP as already composing that chain. Fan and Lan therefore remove B5 from the residual intervention count and retain it as a closed negative case.

This chapter must not present B5 as another open research gap, a sixth surviving bundle, or a proposed mechanism awaiting implementation. Its intellectual purpose is methodological: show how a candidate gap is constructed, challenged against the strongest relevant implementation, and closed when the evidence contradicts the absence claim.

The chapter's central thesis is:

> A mechanism-level research agenda must be willing to remove a candidate when a reviewed system already composes the claimed control edges. GraSP is not merely a skill library or a flat planner: it provides the calibrated selection, typed graph compilation, node verification, bounded local repair, and escalation chain that B5 proposed. The closure is meaningful, but conditional on the evidence, coding, and corpus Fan and Lan actually reviewed.

### 0.2 Batch and table-of-contents conformance

This is the standalone Chapter 17 in Batch 8 of the approved nine-batch Part II plan:

- Chapter 16 (Batch 7) owns B6: uncertainty, resources, interruption, and stopping.
- Chapter 17 (Batch 8) owns the B5/GraSP closed-candidate analysis.
- Chapter 18 (Batch 9) owns synthesis only after Chapters 9–17 have been completed and reviewed.

Chapter 17 will not revise the Part II table of contents, expand into a general survey of all skill systems, or begin Chapter 18's compositional synthesis.

### 0.3 Theory-to-practice / implementation-bridge assessment

A substantial practical bridge is warranted, but its form differs from Chapters 12–16. Those chapters study residual mechanisms and can propose a new runtime invariant. Chapter 17 studies a mechanism chain that the source review says is already implemented. Therefore the practical bridge must be a **faithful technical reconstruction and reproducibility/portability assessment of GraSP**, not a newly invented B5 architecture.

The chapter should make the actual executable chain understandable to a Java-oriented reader:

1. memory-conditioned retrieval and calibrated retrieval confidence;
2. compilation of selected skills into a typed, validated directed acyclic graph (DAG);
3. typed precondition/effect and data dependencies;
4. topological execution with precondition and postcondition verification;
5. typed, locality-bounded repair using five named operators;
6. escalation to bounded global replanning and then ReAct fallback; and
7. component ablations, resource bounds, measurements, and failure criteria.

It should include Java-like contracts, state/data invariants, a guarded lifecycle, a vertical-slice reproduction sequence, and executable test ideas. These are **book-created engineering representations of the published GraSP description**. They must not be presented as GraSP's original source code, as an implementation mandated by Fan and Lan, or as evidence that the book has independently reproduced the reported experiments.

### 0.4 Key distinctions that govern the chapter

- **Closed candidate vs. residual hypothesis:** B5 is a closed negative case in the frozen corpus; B1–B4 and B6 remain the five residual bundles.
- **E-code vs. D-code:** E3 and D4 answer separate questions. The exact Fan and Lan classification for GraSP's composed B5 mechanism is **E3/D4**, not a combined score and not E4 merely because the paper uses the language of convergence.
- **Functional convergence vs. historical lineage:** GraSP functionally solves the relevant control problem through its own skill-graph organization. Fan and Lan make no source-lineage claim from ICARUS to GraSP.
- **D4 vs. complete historical migration:** D4 concerns outcome-dependent change to future control; it does not establish complete ICARUS fidelity, universal transfer, or correctness in all domains.
- **Retrieval vs. compilation vs. execution:** selecting relevant skills is not the same as deriving their causal dependencies, and neither is the same as executing and verifying them.
- **Local repair vs. global replanning vs. reactive fallback:** they are distinct escalation layers, not synonyms for retry.
- **Paper result vs. book proposal:** published GraSP mechanics and reported results must be separated from the book's Java-like mapping and additional production-hardening suggestions.

### 0.5 Teaching sequence

The chapter begins with the methodological question of whether a plausible gap survives comparison with the strongest baseline. It then reconstructs B5's original claim, the closest-baseline decision, and the historical ICARUS context. It teaches GraSP from retrieval through routing, explains why Fan and Lan classify the chain as E3/D4, inspects the experiments and their limits, and finally translates the published design into a reproducible engineering map without claiming independent implementation.

---

## 1. Opening: the candidate gap that disappeared

### 1.1 Opening scenario: a flat skill list is not an execution plan

Use a concise, book-created scenario in which an agent retrieves several potentially useful skills for a multi-step task. A flat list leaves the model to infer which skill must precede another, which output feeds a later input, what happens when an intermediate precondition fails, and whether previously verified work can be retained. A failure in a long flat sequence can force broad replanning even when only a small downstream region is affected.

The opening should introduce the difference between having reusable skills and governing their composition. It should not imply that all skills are executable programs or that every skill library has the same schema.

### 1.2 The research question

Pose the question that matters for a negative case: after a candidate control gap has been specified, what evidence would show that a current system already implements the complete chain? The answer cannot be a feature-name match. It must identify state, trigger, authority, transition, preserved invariants, and the consequences of failure.

### 1.3 Learning objectives

By the end of the chapter, the reader should be able to:

- explain why B5 was initially proposed and why it was later closed;
- reconstruct GraSP's retrieval, compilation, verification, repair, and fallback stages;
- distinguish its three typed edge kinds and five repair operators;
- explain calibrated retrieval confidence and confidence-based routing without confusing it with a generic model confidence score;
- interpret the E3/D4 classification using the two independent coding axes;
- read the experiment and ablation design without overgeneralizing its results;
- identify what the negative case establishes and what it leaves open; and
- map the published design into a reproducible implementation/evaluation plan without claiming to have reproduced the system.

### 1.4 The chapter's promise and non-promise

The chapter explains why the paper's B5 absence condition is not supported after GraSP is considered. It does not claim that GraSP solves every skill-governance problem, that it descends historically from ICARUS, that it has been validated across every domain, or that all open issues in reusable agent skills have disappeared.

---

## 2. Source map, evidence discipline, and claim boundaries

### 2.1 Primary source: Fan & Lan

Use the following anchors for the B5 closure and its methodology:

| Source location | Chapter use |
|---|---|
| §II-D | Separate definitions and precedence rules for evidence relation E1–E4 and migration depth D0–D4. |
| §II-E | Bounded review and validity limitations; provisional coding and no completeness claim. |
| §III-C, ICARUS subsection; Table VIII; Appendix A | Historical context for applicability-governed skills and the mechanism from which the modern comparison is drawn. |
| §IV-B | Modern skill induction, composition, governance, compilation, and GraSP record. |
| §IV-C | Implementation-status categories and equivalence discipline. |
| §V-A, skill-governance mapping; Figure 7 | The GraSP control-edge mapping and the visual closure case. |
| §V-B, skill-migration discussion | Why skill induction/compilation evidence alone is not enough and how GraSP completes the composed chain. |
| §VI-B | Six initial candidates and the closest-baseline screening that closes B5. |
| §VI-C, B5 subsection; Table VI | Exact closed-candidate statement and B5's place beside the five surviving residual bundles. |
| Appendix C-O (R7e); Appendix F-B, Table XIII | Detailed state, trigger, control-edge, preserved invariant, missing invariant, code, and record-level evidence. |
| §VII and §VII-C | Interpretation, transfer boundaries, and review limitations. |

### 2.2 Primary implementation case: GraSP

Use the arXiv v1 paper as the primary technical description:

**Xia, Tianle; Hu, Lingxiang; Sun, Yiding; Xu, Ming; Xu, Lan; Wang, Siying; Xu, Wei; and Jiang, Jie.** “GraSP: Graph-Structured Skill Compositions for LLM Agents.” arXiv:2604.17870v1 (submitted 20 April 2026).

Relevant locations:

- §1: motivation and contributions;
- §2.1: problem setting, GraSP definition, graph validity, and overview;
- §2.2: memory-conditioned retrieval and retrieval confidence;
- §2.3: typed DAG compilation;
- §2.4: verified execution, failure events, and five local repair operators;
- §2.5: confidence-based routing;
- §3.1–§3.4: benchmarks, baselines, backbone models, main results, ablations, task complexity, failure recovery, and skill volume/quality;
- §6: limitations and discussion;
- Appendix A: formal failure-event and repair-validity definitions;
- Appendix B: main loop, memory-conditioned retrieval, DAG compilation, and local repair algorithms;
- Appendix C: default hyperparameters, five component ablations, and sensitivity analyses;
- Appendix D: per-task breakdowns;
- Appendix E: the ALFWorld heating-a-potato case-study title and example context; and
- Appendix F: prompts.

### 2.3 Claim categories

The prose must visibly separate:

1. **Fan and Lan's explicit review result:** B5 is closed in the frozen corpus because GraSP implements the complete proposed chain; the mechanism is coded E3/D4.
2. **GraSP authors' explicit design and experiment claims:** typed DAGs, memory-conditioned retrieval, verification, bounded repair operators, confidence-based routing, benchmark configuration, reported metrics, ablations, and limitations.
3. **Fan and Lan's interpretation/coding:** GraSP is compared with ICARUS's applicability-governed skills; E3/D4 describes the reviewed correspondence, not historical descent or total architectural migration.
4. **Book-created explanations and engineering representations:** the worked task trace, Java-like contracts, validation invariants as code-level interfaces, test harness, and production-readiness questions. Label these as explanatory or proposed engineering material.

### 2.4 Frozen-corpus and publication-status boundary

Fan and Lan freeze their corpus on 26 July 2026. GraSP was submitted to arXiv on 20 April 2026 and is included in that corpus as a research paper. The chapter should use the version and evidentiary role Fan and Lan cite; it should not silently imply a later peer-reviewed venue or substitute later online information for the frozen review record.

The chapter should state that Fan and Lan describe a bounded mechanism-level mapping review, not an exhaustive systematic review. Their own paper says the codes are provisional and does not claim independent inter-rater reliability or a search-recall estimate. These limitations qualify the scope of the closure; they do not nullify the fact that GraSP is a strong closest baseline within the reviewed corpus.

### 2.5 Explicit exclusions

- Do not reinterpret CoALA or revisit its decision procedure.
- Do not turn ICARUS into a separate historical theory chapter; Chapter 11 already owns the ten-family catalog and historical mapping.
- Do not re-survey every skill system in the corpus. Other predecessors are mentioned only to explain the evidence chain.
- Do not describe B5 as a sixth surviving residual bundle.
- Do not assign E4 to GraSP where Fan and Lan explicitly code the correspondence E3/D4.
- Do not imply E3 is a weaker maturity level than E4, or D4 means the entire historical architecture has migrated.
- Do not invent additional ablations or attribute the GraSP paper's results to Fan and Lan.
- Do not claim that the chapter independently reproduces GraSP's source code or experiments.
- Do not call the paper's confidence a universally calibrated probability of task success; it is a defined retrieval-confidence construction.
- Do not treat its particular thresholds and budgets as production defaults.

---

## 3. From historical applicability to the initial B5 candidate

### 3.1 Minimal ICARUS context

Explain only what is needed to understand the comparison: Fan and Lan use ICARUS's applicability-governed skills as the historical object. The relevant question is not merely whether a skill can be stored or executed, but how the agent determines when a skill is applicable and governs its invocation and execution.

The explanation should remain anchored to Fan and Lan's historical reconstruction and their cited ICARUS source. Do not expand into a broad tutorial on all ICARUS architecture components.

### 3.2 The predecessor chain in the modern corpus

Fan and Lan's skill-related records span several adjacent capabilities:

- specification and skill induction;
- reusable procedure and workflow learning;
- selection and composition of skills;
- typed preconditions, effects, artifacts, and validators;
- local repair and substitution;
- adaptive compilation, rollback, and fast-path fallback; and
- skill-graph composition and runtime escalation.

Mention the reviewed systems only to show how evidence accumulates around the candidate. The outline should avoid turning this section into a second Chapter 11 catalog.

### 3.3 The original candidate B5

Reconstruct the initial B5 candidate as the paper states it:

**Calibrated multi-skill routing + typed verification + bounded repair + planner fallback.**

Explain each edge:

- a calibrated signal decides whether a retrieved skill set is suitable for structured execution;
- selected skills are represented with types and dependencies that can be checked;
- verification determines whether a node may be treated as successful;
- failure triggers a bounded repair of the affected region rather than blind continuation; and
- repair exhaustion transfers control to a broader planner or a reactive fallback.

The candidate is a composition claim, not a request for another skill store, another tool catalog, or another generic retry loop.

### 3.4 Why the candidate was plausible before screening

Explain the fragmentation visible in the predecessor chain: adaptive retrieval, typed contracts, workflow composition, local repair, and fallback existed in related systems, but the authors initially treated their full connection as a candidate residual. A feature label such as “skills” or “workflow” would not establish the whole chain.

### 3.5 The closure decision

Closest-baseline screening identifies GraSP as implementing the complete chain. The chapter should show the logical consequence step by step:

1. state the exact proposed absence condition;
2. inspect the strongest relevant baseline rather than a convenient weak comparator;
3. map each proposed B5 edge to an implemented GraSP state object and trigger;
4. check whether the mapped edge has operative control consequences;
5. assign E and D separately; and
6. remove B5 from the residual intervention count.

The lesson is not “a paper used the same words.” The lesson is that the reviewed system exposes the relevant chain in enough detail to invalidate the proposed absence claim.

---

## 4. What GraSP is solving: retrieval is not orchestration

### 4.1 Skill volume is not skill composition

Present the motivation from GraSP: skill repositories can contain many reusable procedures, but adding more retrieved skills does not monotonically improve task performance. A flat list consumes context and leaves ordering, applicability, causal dependencies, and recovery to implicit model reasoning.

Use GraSP's distinction:

- retrieval answers which skills may be relevant;
- compilation answers how the selected skills depend on one another and what executable path they form; and
- execution answers which verified node can run now and how a failure changes the remaining graph.

### 4.2 Flat sequence failure propagation

Explain the paper's problem formulation: if a sequential plan of N skills fails at step k, flat execution may force replanning over the remaining sequence, even when only a local set of descendants depends on the failed node. A typed DAG can localize affected work to a bounded neighborhood.

The complexity comparison O(N) versus O(d^h) should be explained as the authors' locality argument for bounded out-degree d and repair radius h. It is not a universal measured runtime guarantee for arbitrary graphs, workloads, or implementation environments.

### 4.3 Why GraSP belongs in the skill-governance discussion

The system's contribution is not graph visualization alone. The graph is an executable intermediate representation with typed dependencies, node schemas, bound arguments, preconditions, effects, verifiers, confidence, execution status, and repair budget. Those objects participate in the runtime control loop.

---

## 5. GraSP reconstructed: retrieval, compilation, verified execution, and routing

### 5.1 System overview

Introduce the four architectural stages named by the GraSP paper:

1. memory-conditioned skill retrieval;
2. typed DAG compilation;
3. verified execution with local repair; and
4. confidence-based routing between structured skill execution and reactive control.

Clarify that routing is an entry decision around the retrieval/compilation boundary, while global replanning and ReAct fallback are also used later when graph construction or bounded repair fails. A diagram should place these decisions in their actual control locations rather than suggesting a single end-of-pipeline switch.

### 5.2 Stage 1 — memory-conditioned skill retrieval

Explain why semantic retrieval alone can return skills that are topically related but operationally inappropriate for the current state. GraSP combines direct task/state-conditioned retrieval with an episodic-memory prior derived from successful trajectories.

The paper's retrieval description includes:

- top-k successful memory records;
- normalized similarity weights;
- distilled experience summary;
- a direct skill distribution;
- a memory-induced skill distribution;
- a mixture controlled by lambda; and
- top-M skill selection for compilation.

The chapter should display and explain the fusion equation from GraSP §2.2 and Appendix B.2, define every symbol, and state that the mixture weight is an experimental hyperparameter rather than a universal constant.

### 5.3 Retrieval confidence is specifically defined

Reconstruct the paper's confidence features:

- mean similarity of retrieved memories;
- agreement between the direct and memory-induced distributions, expressed through Jensen–Shannon divergence;
- the margin between the top two skill scores; and
- coverage of the task goal by the selected skill set.

Explain the confidence formula, including the learned feature score and historical success rate in a confidence bin. Clarify that this is **retrieval confidence for routing**, not a generic probability emitted by an LLM and not automatically a calibrated probability for every future task or domain.

### 5.4 Stage 2 — compile a typed skill DAG

Define the graph G=(V,E), with source and sink nodes and executable skill nodes. The paper requires a valid graph to be acyclic, reachable from source to sink, goal-complete, and executable: every skill node must have a bound schema, arguments, and verifier.

Explain the node attributes from GraSP §2.3:

- skill schema;
- bound arguments;
- preconditions;
- effects/postconditions;
- verifier;
- execution status;
- confidence; and
- repair budget.

The LLM can propose node invocations and candidate dependencies, but compilation also validates arguments against the library, infers dependencies, resolves cycles, checks graph validity, and attaches verifiers. If compilation fails, the system falls back to reactive control.

### 5.5 The three edge types are not interchangeable

| Edge kind | Meaning | Status in GraSP |
|---|---|---|
| State | An effect of one node satisfies a precondition of another. | Hard dependency. |
| Data | An output from one node binds an input to another. | Hard dependency. |
| Order | A precedence preference from experience or resource conflicts. | Soft dependency; can be rewired or removed during repair. |

Make the difference operational. A state edge records a condition required by a later skill; a data edge carries a produced value into a later input; an order edge specifies a preferred sequence without asserting the same causal relation. The compiler may resolve cycles by removing low-confidence soft order edges; it must not casually remove hard state or data edges.

### 5.6 Stage 3 — verified execution

Explain topological traversal of ready graph nodes. For each node, the executor:

1. checks the precondition against the current environment state;
2. invokes the skill implementation with schema-bound arguments;
3. checks the postcondition through the node verifier; and
4. marks the node verified and advances state only when the checks pass.

The graph can express branches, but do not claim the paper's executor executes independent nodes concurrently unless the source explicitly demonstrates that behavior. The described algorithm traverses ready nodes in topological order. This distinction prevents a graph representation from being mistaken for proof of parallel runtime execution.

### 5.7 Failure events are typed state, not just error text

Define the paper's failure event as a tuple containing the failed node, failure type, structured message, and current environment state. The four failure types are:

- precondition failure;
- execution failure;
- postcondition failure; and
- timeout.

Explain why retaining the failed node and current state matters: repair must know which node failed, what kind of failure occurred, and which dependencies may have been affected.

### 5.8 Stage 4 — five typed local repair operators

Teach all five named operators precisely:

1. **Rebind:** update arguments when the skill is appropriate but its current bindings are wrong.
2. **InsertPrereq:** insert a subgraph that establishes missing preconditions for the failed node.
3. **Substitute:** replace the skill schema while preserving downstream interface compatibility.
4. **Rewire:** edit edges locally by adding, removing, or retyping dependencies in the failed node's neighborhood.
5. **Bypass:** skip the failed node only when the current state already satisfies the downstream requirements that the node would have supplied.

The chapter should show a small worked example of at least three different operators and explain why each is type- and dependency-aware rather than an unconstrained “try another prompt” step.

### 5.9 Repair validity and hard bounds

Explain the formal conditions in GraSP Appendix A:

- the repaired graph remains acyclic;
- every newly inserted node corresponds to an available skill;
- argument schemas type-check;
- every affected node has a verifier;
- unaffected verified ancestors remain unchanged; and
- changes remain within the node and edge patch budgets.

Explain the h-hop repair neighborhood, maximum patch nodes, maximum patch edges, per-node repair attempts, and global replan limit. Values from the paper's default hyperparameter table belong in a clearly marked experimental-default box, not in a production recommendation.

### 5.10 Bounded escalation: local repair, global replan, ReAct

Trace the three-layer failure response:

- attempt a locality-bounded repair;
- if local repair fails and the global replan budget remains, update the residual task and rebuild a graph; and
- if the replan budget is exhausted, or confidence/compilation makes graph execution unsuitable, fall back to ReAct.

Explain why the fallback is not a failure of the architecture: GraSP explicitly includes reactive execution as a lower-structure path. However, do not equate fallback with guaranteed task success or a formal safety guarantee.

### 5.11 Confidence routing at entry

Explain the low and high retrieval-confidence thresholds:

- below the lower threshold, use ReAct rather than run unreliable retrieved skills;
- above the upper threshold, use the full DAG with the normal repair budget; and
- between thresholds, increase repair budgets as a precaution.

Clarify that the thresholds and interpolation policy are experimental design choices. They must be tuned and evaluated against a defined domain, not treated as universal confidence cutoffs.

---

## 6. Why Fan & Lan close B5: reconstructing the claim packet

### 6.1 The seven-field representation as an analysis lens

Use the seven-field tuple exactly as defined in Fan and Lan §II-C. This is an analytical reconstruction of GraSP, not a claim that GraSP uses a runtime object with these seven fields.

| Field | GraSP evidence to reconstruct | Deliberate boundary |
|---|---|---|
| State (S) | Skill library, episodic memory, selected skill set, retrieval confidence, typed DAG, node arguments, preconditions/effects, verifier, execution status, repair budget, current environment state. | Do not fill undocumented fields with imagined framework internals. |
| Control (C) | Retrieval/calibration logic, DAG compiler, node verifier, local repair procedure, routing policy, replanner, ReAct fallback. | The model proposes nodes, but validated runtime transitions are not merely free-form model text. |
| Transition (T) | Task arrival, confidence threshold crossing, graph compilation result, node readiness, precondition/execution/postcondition/timeout failure, repair success/failure, goal completion. | Distinguish a proposed node/edge from a validated graph transition. |
| Persistence (P) | Skill library and episodic success memory inform later retrieval; current graph and verified execution state govern the active episode. | Do not claim the paper defines a production-grade durable transaction or cross-process recovery protocol. |
| Failure (F) | Typed node failure event; invalid compilation; invalid repair; bounded repair exhaustion; global replan exhaustion; reactive fallback. | Fallback is a control route, not proof that the goal will be achieved. |
| Learning (L) | Episodic success history contributes to the memory-induced skill prior and historical confidence calibration. | Do not claim every repair or every graph execution trains a new skill policy; describe only documented feedback paths. |
| Resources/governance (R) | Top-k and top-M retrieval, confidence thresholds, repair neighborhood and patch budgets, per-node repair count, global replan count, per-episode environment-step budgets. | These are explicit experimental bounds, not a unified operating-system resource manager or general security policy. |

### 6.2 The exact E3/D4 result

Define the two axes in the terms established in Chapter 11:

- **E3 — functional approximation:** a comparable control problem and observable function are implemented through materially different internal organization. There is no documented historical source-lineage claim for GraSP's implementation of the mapped ICARUS mechanism.
- **D4 — adaptive control law:** experience changes a future invocation, selection, or control policy. Fan and Lan assign D4 to GraSP's composed skill-governance correspondence because retrieval confidence incorporates historical-success calibration and causally governs skill routing/selection.

Do not present E3 and D4 as an additive score, a fraction, a maturity ladder, or a single “E3-to-D4” level. They answer different questions. E3 does not mean “partially implemented,” and D4 does not mean “fully migrated from ICARUS.”

### 6.3 The Appendix C-O claim packet

Reconstruct Fan and Lan's Appendix C-O in the ordered form:

**Historical object → modern evidence → state → trigger → control edge → preserved invariant → missing invariant → E-code → D-code → disposition.**

For the GraSP record:

- historical object: ICARUS applicability-governed skills;
- modern evidence: GraSP;
- state: retrieval confidence, typed DAG nodes, pre/postconditions, verifier, and repair budget;
- trigger: task arrival or node failure;
- control edge: confidence routes to DAG or ReAct; verification gates progress; typed repair preserves valid state; failure escalates to replanning/ReAct;
- preserved invariant: applicability and execution evidence govern selection, continuation, repair, and fallback;
- missing: no source-lineage claim and no universal cross-domain validation;
- code: E3/D4; and
- disposition: closes candidate B5.

### 6.4 Why “convergence” must not be read as E4

Fan and Lan use convergence language to describe independently arriving at a functionally comparable control solution. Their actual assigned evidence code for the GraSP mapping is E3. E4 has a separate operational definition for structural convergence inferred from comparable node/edge organization without transfer evidence. The chapter must use the explicit B5 code E3/D4 and explain the distinction instead of recoding it from informal wording.

### 6.5 D4 does not erase missing invariants

Explain that D4 indicates an outcome-dependent policy edge for the mapped mechanism. It does not imply source lineage, total architectural equivalence, unrestricted task-domain transfer, complete security, or absence of all skill-governance research questions. This is a central teaching example for why high migration depth and complete migration are different claims.

---

## 7. GraSP experiments: what supports the closure and what does not

### 7.1 Experimental scope

Reconstruct the GraSP paper's reported setting:

- four interactive benchmarks: ALFWorld, ScienceWorld, WebShop, and InterCode;
- eight LLM backbones;
- ReAct, Reflexion, ExpeL, and ReAct + Skills as principal baselines;
- shared skill library and episodic memory for skill-augmented comparisons; and
- three runs per reported model/benchmark cell.

Name the backbones only as needed for interpreting model diversity. Do not turn the model list into a current model leaderboard.

### 7.2 Metrics and comparison fairness

Keep distinct:

- reward/score or task success, depending on benchmark;
- environment steps; and
- model calls where the paper uses environment steps as a proxy under its setup.

Explain the controlled comparison: methods using skills receive the same skill library and episodic memory, while their organization and execution differ. The question is whether structured graph composition improves over flat skill provision and other agent baselines, not whether GraSP simply receives more resources.

### 7.3 Main results worth teaching

Present a compact selection of results, with exact benchmark/model/split labels and source citations. Candidate figures/claims include:

- the paper's reported mean gains over ExpeL and the strongest per-cell baseline;
- reduced environment steps relative to ReAct and ReAct + Skills;
- the component ablation table on ALFWorld (seen) and ScienceWorld (seen) with DeepSeek V3.2;
- the larger advantage on longer tasks;
- typed precondition-repair success compared with global replanning; and
- the local-repair → global-replan → ReAct escalation distribution.

The outline should require the author to label reported averages and selected cells exactly. Avoid reconstructing an average from rounded cells or mixing reward and success-rate scales.

### 7.4 Component ablations — preserve all five

GraSP Appendix C.2 describes five ablation conditions. The chapter must include them as separate interventions:

1. **Without experience memory:** remove the memory-induced skill distribution and experience summary, using the direct retrieval distribution only.
2. **Without DAG structure:** execute retrieved skills as a flat sequence in the LLM-proposed order.
3. **Without local repair:** disable repair operators and escalate failures directly to global replan or ReAct.
4. **Without confidence routing:** always execute the GraSP structure regardless of retrieval confidence.
5. **Global replan instead of local repair:** discard the graph and recompile from scratch on each failure, under a comparable replan budget.

Explain the distinct causal contribution each condition is intended to isolate. The book must distinguish the full five-condition experimental design in Appendix C.2 from the subset of ablation comparisons displayed in the main Table 2. Do not imply that every condition appears as a separate row in that table.

### 7.5 Selected component results

The outline should retain the exact source-reported values needed to show why the authors emphasize DAG compilation and locality-bounded repair. The final chapter can present a compact table for the reported ALFWorld/ScienceWorld pair and explain the progressive additions: experience memory, DAG compilation, local repair, and routing. It should also compare the local-repair configuration with global replanning and distinguish the incremental component effect from the overall baseline difference.

### 7.6 Robustness to skill quantity and quality

Explain the two tests:

- as the number of retrieved skills rises, flat execution is increasingly distracted, while DAG compilation filters skills that cannot be connected through required dependencies;
- as skill quality degrades, GraSP's reported performance degrades less than flat execution, supported by compilation-time checks and typed repair.

State the benchmark and experimental setting. These findings are not universal proof that graph structure always beats every skill-selection policy.

### 7.7 What the experiments actually establish

The reported evidence supports that GraSP's selected architecture outperforms the tested baselines under its four benchmark settings and eight backbones, with component analyses supporting the contribution of graph compilation, local repair, and routing. It also supports Fan and Lan's conclusion that the B5 chain is not absent from their frozen corpus.

The chapter must not infer that:

- all tasks should be expressed as DAGs;
- every node verifier is correct or independent;
- confidence calibration transfers unchanged to unseen domains;
- the method is production-safe for arbitrary external APIs;
- a small number of benchmark runs proves universal statistical significance; or
- the B5 closure makes further work on skill governance unnecessary.

---

## 8. Limitations, negative-case interpretation, and remaining questions

### 8.1 GraSP's stated limitations

Preserve the limitations section of the GraSP paper:

- DAGs do not directly represent cyclic execution patterns; iterative refinement tasks may require loop constructs or graph unrolling; and
- the paper demonstrates the approach on four text-based interactive environments, while multimodal, real-world API, and multi-agent transfer are stated as future directions rather than already demonstrated results.

### 8.2 Additional replication and engineering questions

As book-level analysis, identify questions that a reader should test rather than claim they were answered by GraSP:

- How stable is retrieval calibration under distribution shift or a changing skill library?
- How reliable are skill preconditions, effects, and verifiers when descriptions are ambiguous or incorrect?
- Can a graph compiler create a plausible but semantically invalid dependency?
- How should concurrent independent branches be scheduled when the paper's executor description uses topological traversal?
- What happens when a tool call has external side effects but the verifier cannot determine whether it completed?
- How are episodic memories updated, versioned, or invalidated after skill changes?
- What are the latency, token, and repair costs beyond environment-step counts?
- Which properties survive transfer to APIs, GUI tasks, or multi-agent workflows?

Mark each as an extension question or engineering validation need, not as a defect demonstrated by the published experiments.

### 8.3 Negative case is not negative experimental outcome

Explain the methodological meaning carefully. “Negative case” means the proposed B5 residual does not survive the closest-baseline screen in the frozen corpus. It does not mean GraSP performed poorly, that B5 was disproved as an undesirable design, or that skill governance is no longer worth studying.

### 8.4 Closure remains conditional

Fan and Lan explicitly bound the result by their frozen corpus, provisional evidence codes, and review procedure. The chapter should retain the qualification “closed in the reviewed corpus” rather than write “solved in general” or “no gap exists anywhere.”

### 8.5 What remains open after B5 closes

Return to the five surviving residual bundles only as a compact handoff:

- B1 — activation, retrieval latency, action utility;
- B2 — typed impasse, isolated substate, resolution compilation;
- B3 — content competition, bounded workspace, broadcast and admission learning;
- B4 — persistent intention, reconsideration, method authority; and
- B6 — propagated uncertainty, resources, interruption, stopping.

Do not restate their full technical designs. Chapter 18 will examine their dependencies and the role of the closed GraSP capability after all six mechanism case chapters have been reviewed.

---

## 9. Theory-to-practice bridge: a faithful GraSP implementation map

### 9.1 Why the practical bridge is a reproduction map, not a new B5 proposal

State that the source result is already an implemented convergence case. The chapter's practical purpose is to let a Java-oriented reader understand the state, control, and contracts that make the claim auditable. The book may propose Java-like interfaces and tests, but must label them as a faithful mapping of published behavior, not the original GraSP implementation.

### 9.2 Proposed type model

The chapter should present concise Java-like contracts for:

- `SkillDefinition`: stable skill identity, input schema, preconditions, effects, and verifier specification;
- `SkillInvocation`: a selected schema plus bound arguments;
- `SkillNode`: invocation, preconditions/effects, verifier, execution status, confidence, and repair budget;
- `SkillEdge`: source node, target node, and one of `STATE`, `DATA`, or `ORDER`;
- `SkillGraph`: source/sink, nodes, typed edges, goal coverage, and graph validity;
- `RetrievalEvidence`: direct scores, memory records, similarity weights, distribution agreement, top-skill margin, and goal coverage;
- `RetrievalConfidence`: calibrated retrieval estimate plus calibration-bin/version provenance;
- `FailureEvent`: failed node, typed failure, structured evidence, and observed environment state;
- `RepairPatch`: transformed graph plus declared node/edge delta and affected region;
- `RepairBudget`: neighborhood radius, node/edge patch limits, per-node attempts, and global replans; and
- `ExecutionTrace`: verified nodes, failures, repairs, replans, fallback, final goal check, and cost.

Each type must be traced back to the GraSP paper where possible. Fields introduced for auditability or production implementation must be marked as book-level engineering additions.

### 9.3 Invariants for a faithful implementation

Translate the source's formal definitions into checkable invariants:

- graph is acyclic;
- source reaches sink and selected path is goal-complete;
- every executable node has a registered skill schema, valid arguments, and verifier;
- state and data edges satisfy their typed dependency semantics;
- soft order edges do not override hard dependencies;
- every repair leaves a valid graph;
- unaffected verified ancestors remain unchanged;
- every added/changed node and edge remains inside the repair bounds;
- repair attempts and global replans are bounded; and
- fallback routes are reachable when confidence is low, compilation fails, or escalation budgets are exhausted.

### 9.4 Lifecycle state machine

Show a proposed implementation state machine:

`TASK_RECEIVED → MEMORY_RETRIEVAL → CONFIDENCE_ROUTE → DAG_COMPILATION → GRAPH_VALIDATION → NODE_READY → PRECONDITION_CHECK → EXECUTION → POSTCONDITION_VERIFICATION → NODE_VERIFIED`.

Failure branches route to `FAILURE_CLASSIFIED → LOCAL_REPAIR → PATCH_VALIDATION`. A valid patch returns to the affected subgraph; an invalid or exhausted patch may enter `GLOBAL_REPLAN`; exhausted replanning or low confidence enters `REACT_FALLBACK`. Goal satisfaction enters `COMPLETED`; terminal fallback exhaustion enters a typed unsuccessful/abstained result.

The state names and terminal result contract are book-level implementation abstractions. They should not be misquoted as literal GraSP enum values.

### 9.5 Repair-operator contracts

For each operator, specify:

- required failure evidence;
- target node and neighborhood;
- graph transformation allowed;
- hard invariants that must remain true;
- verifier/check required after transformation; and
- budget consumed.

Give particular attention to `Bypass`: it is legal only if the current state already satisfies the downstream requirements. It is not a generic skip-on-error action.

### 9.6 Verification is a control gate, not a guarantee of truth

Explain that a verifier gates node continuation. The chapter's engineering discussion should distinguish schema validation, precondition checks, postcondition checks, and domain-level truth. A passing schema or local verifier does not automatically establish external correctness, legal permission, transaction completion, or safety. Any proposal to use independent or stronger verifiers must be marked as production hardening beyond the paper's explicit claims.

### 9.7 Persistence and transaction boundary

Map the paper's episodic memory and skill library to the long-lived side, and the per-task DAG/execution state to the episode side. Then identify what the paper does not fully specify for a production runtime: durable checkpoint format, crash recovery, concurrency control, idempotent external execution, skill-library version migration, and atomic promotion of memory records. These should be presented as open engineering questions, not as features that GraSP demonstrably implements.

### 9.8 Observability and reproducibility trace

Propose a trace that records:

- task and goal identifier;
- skill-library and memory versions;
- direct and memory-induced retrieval distributions;
- calibration features, bin, and confidence;
- selected skill set;
- graph nodes and typed edges;
- graph-validation results;
- precondition/execution/postcondition checks;
- typed failure event;
- repair operator and graph diff;
- affected and preserved verified nodes;
- local repair and global replan counters;
- route/fallback decision;
- final goal check; and
- per-stage tokens, latency, environment steps, and other measurable resource use.

This trace is a book-level auditability recommendation. It should support an independent evaluator in determining whether the claimed control edge actually caused the transition.

### 9.9 Vertical-slice implementation sequence

Offer an incremental reproduction plan:

1. define a typed skill library and schema validator;
2. implement deterministic graph validation and typed edges;
3. implement direct retrieval and a separate episodic-memory prior;
4. reproduce retrieval-confidence features and threshold routing;
5. implement a DAG compiler with source/sink, goal-completeness, and cycle checks;
6. implement topological execution with pre/postcondition verifiers;
7. add the five typed local repair operators;
8. enforce neighborhood, patch, per-node, and global replan bounds;
9. implement ReAct fallback and residual-task handling; and
10. instrument the complete experiment and ablation harness.

At each step, compare against the GraSP paper's algorithm descriptions and published configuration. Do not silently replace one of the five repair operators with generic model regeneration.

### 9.10 Test categories

The chapter should distinguish unit, property, state-machine, fault-injection, integration, and experimental tests. Examples:

- state/data/order edge semantics;
- graph cycles and source/sink reachability;
- invalid schema binding rejected before execution;
- verifier rejection prevents downstream node release;
- each repair operator changes only its permitted graph region;
- verified unaffected ancestors survive repair;
- patch bounds and attempt limits are enforced;
- low-confidence routing never enters DAG execution;
- compilation failure routes to fallback;
- local-repair exhaustion triggers bounded global replanning;
- global-replan exhaustion triggers ReAct;
- false postcondition success is caught by an independent task-goal check; and
- a task with necessary cyclic refinement is flagged as outside the DAG-only assumption unless unrolling is explicitly supported.

---

## 10. Worked example: compiling and repairing a multi-step skill graph

### 10.1 Example choice and source boundary

Use the ALFWorld task family discussed by GraSP, with the paper's Appendix E title “heating a potato” as the motivating task context. The detailed node names, conditions, and repair sequence in the chapter should be explicitly marked as a **book-created illustrative trace**, not as a reconstruction of an unpublished or unavailable exact experimental trajectory.

### 10.2 Initial task and retrieved skills

Show a candidate skill library that may include locating an object, picking it up, locating a heating appliance, placing the object, activating the appliance, and confirming the goal. Demonstrate that the retriever returns more skills than are needed and that episodic memory changes the distribution relative to semantic similarity alone.

### 10.3 Confidence and route selection

Illustrate a retrieval-confidence value and explain which branch the example takes. Use symbolic confidence or a clearly illustrative number; do not present invented numeric values as measured GraSP results. State whether the illustrative value falls below, between, or above the paper's thresholds.

### 10.4 Compile a typed DAG

Draw a small graph with:

- a state edge where a completed effect satisfies a later precondition;
- a data edge where a produced object/location value becomes a later argument; and
- an order edge expressing a preferred sequence not reducible to those hard dependencies.

Show the graph validation checks before execution.

### 10.5 Execute and verify

Walk through ready nodes, precondition checks, invocation, postcondition checks, and verified status. Explain what evidence is retained when the first few nodes pass.

### 10.6 Inject a failure and repair locally

Use a specific book-created failure, such as a missing appliance precondition or an incorrect argument binding. Select the appropriate typed operator (`InsertPrereq` or `Rebind`) and show why the rest of the verified graph remains intact.

### 10.7 Demonstrate escalation

Add a second failure for which local repair is invalid or exceeds its limit. Show the transition to global replanning; then show a separate branch where low retrieval confidence or exhausted replanning uses ReAct. Do not conflate the entry threshold route and the post-failure escalation route.

### 10.8 What the worked example proves — and does not prove

It demonstrates how typed state, verifiers, bounded repair, and fallback form an executable control chain. It does not establish empirical success rates or reproduce the paper's experimental numbers.

---

## 11. Evaluation and methodological lessons

### 11.1 Closest-baseline screening as a required research procedure

Turn the B5 closure into a reusable research method:

1. formulate a candidate as a set of explicit control edges;
2. search for the strongest system likely to implement the whole chain;
3. inspect primary papers and versioned artifacts rather than capability summaries;
4. map the candidate and baseline using the same state/control/transition vocabulary;
5. identify exactly which edge is present, partial, or absent;
6. apply E/D coding independently; and
7. close, narrow, or retain the candidate based on the evidence.

Explain why a baseline must be selected for mechanism proximity rather than convenience or familiarity.

### 11.2 Reproducibility protocol for a GraSP-style implementation

The book's reproduction study should hold constant, where the design permits:

- base model and model version;
- prompts and decoding configuration;
- task split and environment version;
- skill library and episodic memory;
- tool interfaces and observation format;
- episode budget; and
- stochastic replication and seed policy.

Record the exact configuration and all internal transitions. The final chapter should distinguish a source-faithful replication from a simplified teaching implementation.

### 11.3 Outcome measures

Preserve the GraSP paper's principal outcomes: benchmark reward/score or success, environment steps, and the reported efficiency/cost measures. A book reproduction may add compile validity, verifier precision/recall against labelled conditions, repair success by failure type, nodes/edges changed, fraction of verified work preserved, fallback frequency, calibration error, graph validity rate, latency, token use, and repair cost. Added measures must be labelled as book-level extensions.

### 11.4 Falsification and narrowing criteria

A reproduction or transfer study should question the claimed advantage if:

- DAG compilation does not improve outcome or cost over a matched flat-skill baseline;
- local repair does not preserve verified work or reduce recovery cost compared with global replanning;
- confidence routing fails to improve the relevant robustness measure over always-DAG or always-ReAct controls;
- graph compilation often produces invalid or unverifiable dependencies;
- verifiers accept incorrect states or reject valid ones at rates that erase the gain;
- more skills degrade GraSP in the same way as flat execution despite compilation filtering;
- the results disappear under a matched model, memory, and skill library; or
- the claimed transfer fails in the new domain.

These criteria test the implementation or transfer. They do not retroactively alter what Fan and Lan reported about the frozen corpus unless new evidence is incorporated through a revised review.

### 11.5 Three distinct research conclusions

The chapter should end this section by separating:

1. **B5 closure in Fan and Lan's corpus:** the candidate absence condition is falsified by GraSP.
2. **GraSP's reported experimental performance:** positive evidence in four evaluated interactive benchmarks and the reported model/baseline setup.
3. **External validity and production transfer:** still open beyond the paper's stated domains and limitations.

---

## 12. Cross-chapter boundaries and Chapter 18 handoff

### 12.1 Relationship to Chapter 11

Chapter 11 already owns the historical and modern landscape, the ICARUS mapping, and the E/D coding framework. Chapter 17 applies those tools to the single B5 negative case; it must not reproduce the full 10-family/8-runtime/42-record catalog.

### 12.2 Relationship to Chapters 12–16

- B1–B4 and B6 are residual bundles examined in their own mechanism chapters.
- B5 is not parallel to those surviving hypotheses: GraSP closes it in the frozen review corpus.
- B2 may produce verified recovery outcomes, and those could be supplied to a skill-governance system; this does not make B2 and B5 the same mechanism.
- B6 may govern resources and uncertainty during GraSP-like execution; Chapter 17 should not repeat B6's analysis.

### 12.3 What Chapter 18 may take from this chapter

Chapter 18 may treat a GraSP-like skill-governance chain as an existing/closed capability in the source review's bounded corpus and discuss its dependencies with B1–B4/B6. It must not reclassify B5 as a new residual or infer that the other bundles have already been validated because they can connect to GraSP.

### 12.4 Transition to the synthesis

Conclude that the reader has now seen both types of result in Part II: residual hypotheses that remain to be tested, and a candidate removed by closest-baseline evidence. Chapter 18 will integrate the dependencies among the five survivors while keeping the B5 closed case as a methodological and implementation reference.

---

## 13. Planned authored chapter structure

The prose is expected to follow this sequence:

1. Opening: the candidate gap that disappeared.
2. B5's original chain and the closest-baseline question.
3. ICARUS context and the predecessor chain, briefly.
4. Why skill retrieval alone is not orchestration.
5. GraSP's four stages: memory-conditioned retrieval, typed DAG compilation, verified execution/local repair, and confidence-based routing.
6. The five repair operators and bounded escalation.
7. The seven-field analytical reconstruction.
8. The E3/D4 coding packet and why it closes B5.
9. Experiments, ablations, and reported results.
10. Limitations and the correct interpretation of a negative case.
11. Faithful Java-oriented implementation/reproduction map.
12. Worked task trace.
13. Evaluation and research-method lessons.
14. Part II synthesis handoff.

---

## 14. Planned figures and Mermaid source files

All diagrams will be authored as Mermaid `.mmd` sources under `Tex/diagrams/source/part2/chapter17/`, rendered by the shared CI pipeline, and included through the shared `\BookDiagram` macro. No hand-authored TikZ or committed fake PNGs are permitted.

1. `b5-candidate-to-closure.mmd` — six initial candidates, closest-baseline screening, GraSP evidence, B5 closed, five residuals remain.
2. `grasp-four-stage-pipeline.mmd` — memory-conditioned retrieval, typed DAG compilation, verified execution/local repair, confidence routing and fallback points.
3. `grasp-retrieval-confidence.mmd` — direct and memory distributions, four confidence features, historical-success calibration, thresholds and route decisions.
4. `grasp-typed-dag-edges.mmd` — state, data, and order edges with hard/soft semantics and a small executable graph.
5. `grasp-node-execution-and-failure.mmd` — ready node, precondition, invocation, postcondition verifier, typed failure event, and preserved verified state.
6. `grasp-five-repair-operators.mmd` — Rebind, InsertPrereq, Substitute, Rewire, and Bypass, including patch-bound gate.
7. `grasp-escalation-lifecycle.mmd` — local repair, global replan, ReAct fallback, success and terminal failure routes.
8. `b5-evidence-depth-packet.mmd` — ICARUS comparison, preserved/missing invariant, independent E3 and D4 axes, closed disposition.
9. `grasp-evaluation-and-ablations.mmd` — baselines, benchmarks, metrics, the five ablations, and the distinction between main-table rows and appendix conditions.

Each diagram source must include `accTitle` and `accDescr`, use the shared theme, and be checked by the repository's source validator. The actual PNGs are generated build artifacts, not source files.

---

## 15. Glossary and index plan

Check `Tex/glossary/terms.tex` before adding anything. Reuse terms already present for state, control, transition, evidence relation, migration depth, skill, precondition, postcondition, DAG, fallback, and verifier wherever they exist.

Potential new entries, only if not already defined:

- skill composition;
- typed dependency edge;
- episodic skill memory;
- retrieval confidence;
- confidence calibration bin;
- local graph repair;
- repair operator;
- graph compilation; and
- closest-baseline screening.

Potential index terms:

- B5 (closed candidate);
- GraSP;
- ICARUS (applicability-governed skills);
- closest-baseline screening;
- negative case;
- typed DAG;
- state edge, data edge, order edge;
- Rebind, InsertPrereq, Substitute, Rewire, Bypass;
- retrieval confidence;
- local repair, global replanning, ReAct fallback; and
- E3/D4.

Do not duplicate existing glossary entries or use glossary definitions to imply that GraSP guarantees security, truth, or universal transfer.

---

## 16. Review questions and exercises

1. Why is B5 not one of the five residual bundles retained after Fan and Lan's closest-baseline screen?
2. What control chain did the original B5 candidate propose?
3. Why does skill retrieval not by itself establish a valid execution plan?
4. What is the difference between a state edge, a data edge, and an order edge in GraSP?
5. Why must a node pass both its precondition and postcondition checks?
6. What information belongs in a typed failure event?
7. Give one appropriate use case for each of the five repair operators.
8. Why is `Bypass` more restrictive than skipping a failed node?
9. How does GraSP decide between structured execution and ReAct at the entry boundary?
10. How is post-failure escalation different from initial confidence routing?
11. What does E3 say about the relationship between GraSP and ICARUS? What does D4 say about the implemented control?
12. Why does E3/D4 not mean complete historical migration?
13. Which five ablations are described in GraSP Appendix C.2, and which subset is shown in the main component table?
14. What do the GraSP experiments establish, and what remains an external-validity question?
15. Why is a negative case methodologically valuable in a research review?

Practical exercise: Given a five-node skill graph and one failed precondition, choose a repair operator, state the typed invariants that must remain true, specify which verified ancestors must be preserved, and explain when the runtime must escalate instead of applying a patch.

---

## 17. Acceptance criteria for the authored chapter

The chapter will be accepted only when all of the following are satisfied:

### Source and methodological fidelity

- B5 is consistently described as a closed candidate/negative case, never as a sixth residual hypothesis.
- The original candidate is stated as calibrated multi-skill routing, typed verification, bounded repair, and planner fallback.
- Fan and Lan's closest-baseline screening and closure reasoning are traced to the exact sections, tables, and appendices.
- The GraSP paper's actual stages, graph definition, edge types, failure event, five repair operators, repair validity, routing, hyperparameters, and ablations are accurately represented.
- E3 and D4 remain separate axes; the GraSP mapping is recorded as E3/D4, not E4 or a combined maturity score.
- E3/D4 is not described as complete ICARUS migration, direct historical lineage, or universal transfer.
- The bounded-corpus, provisional-coding, and single-coder/review validity limits are preserved.
- Claims in the GraSP results section use the correct benchmark/model/split/metric context.
- Main Table 2 ablation rows are distinguished from all five Appendix C.2 conditions.
- GraSP's DAG and evaluated-domain limitations are explicit.

### Theory-to-practice bridge

- The bridge is a faithful reconstruction/reproduction map, not a new residual B5 proposal.
- Java-like contracts are clearly labelled as book-created engineering representations.
- Graph invariants, typed failure, repair bounds, verified-node preservation, fallback routes, persistence limits, and observability are concrete and testable.
- No unsupported concurrency, transaction, security, or online-learning capability is attributed to GraSP.
- The worked example is labelled illustrative and does not invent experimental measurements.

### Production integration

- The chapter uses the shared preamble, shared macros, semantic teaching boxes, and footnote citation macros.
- The bibliography includes the exact GraSP arXiv reference and reuses the existing Fan & Lan entry.
- Glossary and index additions avoid duplication.
- All planned Mermaid sources have accessible descriptions, use the shared theme, and are referenced from the prose.
- The standalone chapter entry point and normal build scripts include Chapter 17.
- Scaffold, Mermaid, PDF text-quality, citation, and build checks pass, with unresolved environment/CI dependencies disclosed.
- The chapter PDF is visually inspected after actual diagram rendering; mock panels are not represented as real diagram output.
- The repository preamble remains unchanged unless an explicitly approved shared change is required.

---

## 18. Source and research record for drafting

### 18.1 Primary theoretical review

Fan, Haodi, and Zucong Lan. “From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps.” arXiv:2607.23942v1, 27 July 2026. Primary anchors: §§II-D–II-E, III-C (ICARUS), IV-B–IV-C, V-A–V-B, VI-B–VI-C (B5), Figure 7, Tables IV–VI, Appendix C-O, and Appendix F-B/Table XIII.

### 18.2 Primary GraSP implementation paper

Xia, Tianle, Lingxiang Hu, Yiding Sun, Ming Xu, Lan Xu, Siying Wang, Wei Xu, and Jie Jiang. “GraSP: Graph-Structured Skill Compositions for LLM Agents.” arXiv:2604.17870v1, submitted 20 April 2026. Primary anchors: §§1–3.4, §6, Appendices A–F, especially B.1–B.4 and C.1–C.3.

### 18.3 Historical comparator

Choi, Dongkyu, and Pat Langley. “Evolution of the ICARUS Cognitive Architecture.” (2018). Use only for the ICARUS mechanism explicitly reconstructed by Fan and Lan, not as an independent additional theoretical foundation for Part II.

### 18.4 Research boundary

No separate survey of skill-learning literature is planned. Other works are cited only when they are part of the predecessor chain or direct comparative baselines discussed by Fan and Lan or GraSP. Do not add external frameworks as a third formal theory foundation. If the author requests a current-status update beyond the papers' stated corpus/version, record it separately and do not rewrite the papers' historical claims.

---

## 19. Outline decision and approval record

**Outline version:** 1.0  
**Status:** Approved for drafting on 15 November 2026.  
**Drafting authorization:** Granted by the author on 15 November 2026.  
**Planned chapter source:** `Tex/part2/chapter17/chapter.tex`  
**Planned figure source directory:** `Tex/diagrams/source/part2/chapter17/`  
**Review format:** One canonical Markdown outline only. No outline PDF, LaTeX outline wrapper, or parallel review version will be generated.

Chapter 17 drafting is authorized. The completed LaTeX chapter will be integrated into the repository and reviewed against the acceptance criteria above. Chapter 18 remains reserved for Batch 9 and will not begin until Chapters 9–17 have been completed and reviewed.
