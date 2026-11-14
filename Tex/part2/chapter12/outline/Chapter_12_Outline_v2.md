# Chapter 12 — Understanding Activation, Retrieval Latency, and Utility: B1

**Outline version:** 2.0  
**Status:** Revised from the Chapter 12 review report; drafting authorized by the author on 14 November 2026.  
**Primary source:** Haodi Fan and Zucong Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps* (2026), especially §VI-C, B1; Table V; Appendix C-A; Appendix B.  
**Chapter role:** Part II, B1 — activation–latency–utility coupling for adaptive memory at context assembly.

## Chapter purpose

Explain how an agent can move from the cognitive idea of memory activation to an auditable memory subsystem that selects, positions, and maintains explicit memories under task, latency, and context constraints. The chapter must not flatten admission, retention/forgetting, and query-time retrieval into one generic “memory score.” It must distinguish the established mechanisms from the B1 integration gap and make clear which equations are source mechanisms, which are prior-art baselines, and which are book-level engineering formulations.

## Reader outcomes

By the end of the chapter, the reader should be able to:

1. Explain ACT-R chunks, base-level activation, spreading activation, partial matching, retrieval thresholds, and the activation–latency relationship.
2. Distinguish ACT-R presentation events from generic reads, retrieval attempts, prompt inclusion, actual use, and observed outcome.
3. Distinguish production/action utility from the context-dependent value of a memory item or memory set.
4. Separate memory admission, retention/update/forgetting, and query-time retrieval/context assembly, and correctly classify representative systems.
5. Explain what Generative Agents, MemoryBank, MemoryOS, A-MAC, Chen and Cheng, Zep/Graphiti, HippoRAG, and MMR contribute—and what they do not establish.
6. Derive a B1-oriented selector without double-counting ACT-R activation and its predicted latency, treating infrastructure latency separately, or charging sunk storage costs at every prompt.
7. Design an event-auditable data model for memory records, access, inclusion, outcomes, attribution, costs, value estimates, and policy snapshots.
8. Evaluate memory policy with downstream task outcomes, retrieval quality, abstention, latency, resource use, stale-memory/error propagation, and controlled ablations.
9. State the chapter's boundary with parametric model memory and its handoff to later mechanisms.

## Organizing principle: three decisions, not one score

The chapter is organized around three distinct decisions:

| Decision | Question | Representative material |
|---|---|---|
| Admission / encoding | Should this observation become persistent memory, and at what depth? | A-MAC; Chen & Cheng's value model as a related valuation approach |
| Retention / update / forgetting | Should an existing memory be strengthened, updated, invalidated, consolidated, archived, or evicted? | MemoryBank; MemoryOS; temporal validity in Zep/Graphiti |
| Retrieval / context assembly | Which currently valid memories should be fetched, selected, ordered, and inserted for this query/action? | ACT-R retrieval; Generative Agents; vector/BM25/graph retrieval; MMR; B1 |

These are lifecycle boundaries, not mutually exclusive product categories. One architecture can implement more than one decision, but each mechanism must be described at the correct boundary.

## Proposed chapter structure

### Opening (unnumbered): Chapter at a glance

- State the practical problem: agents can store more information than they can retrieve, trust, fit, or use.
- Introduce the three lifecycle decisions and preview the Product X running example.
- Learning objectives.

### 12.1 What B1 claims—and what it leaves open

- Introduce B1 from Fan & Lan as a residual mechanism hypothesis, not a finished algorithm.
- State the four coupled quantities: activation/accessibility, predicted retrieval latency, downstream memory value, and maintenance cost.
- Explain the context-assembly trigger, fixed budget, working-context admission, and outcome feedback loop.
- Preserve Fan & Lan's separation between B1 memory-item accessibility and B3 workspace competition/capacity.
- Explain that modern adaptive-memory systems are executable comparators, not proof that the unified B1 law already exists.

#### 12.1.1 Three lifecycle decisions

- Define the three decisions independently.
- Show why an admission threshold is not a query-time ranking rule and why an eviction score is not an answer to which memories should enter the next prompt.
- Define a canonical journey: observe → encode/admit → retain/update → retrieve candidates → assemble context → use → observe outcome → update policy.
#### 12.1.2 A running example: Product X
- Product X support agent receives a payment incident, stores evidence selectively, checks temporal validity, retrieves related facts, and builds a constrained diagnostic context.

### 12.2 ACT-R: from declarative chunks to predicted retrieval

#### 12.2.1 Activation has several components
- Typed declarative chunks, buffers/cues, and the retrieval request.
- Activation decomposition: base-level, spreading activation, partial matching, and noise.
- Clarify activation is a model quantity, not a generic embedding similarity score.

#### 12.2.2 Base-level activation: frequency and recency
- Full time-stamped presentation-history equation.
- Define each variable and explain frequency, recency, decay, and the additive base-level constant.
- ACT-R 7 presentation-event semantics: initial entry into declarative memory or a merge/reference event as specified by the model; do not state that every read necessarily increments history.
- Optimized approximation; explain what event-history detail it compresses and when timestamps are preferable.

#### 12.2.3 Spreading activation and fan
- Give the ACT-R source-activation distribution equation and the cue-to-chunk association term.
- Explain the simplified fan penalty only under its relevant distribution assumptions.
- Bridge to graph retrieval without equating graph algorithms with ACT-R.

#### 12.2.4 Partial matching, noise, and retrieval threshold
- Explain similarity penalties and why a match can be relevant without being exact.
- Explain stochastic variation and the retrieval threshold/failed retrieval.

#### 12.2.5 Activation predicts cognitive retrieval time
- Present ACT-R's exponential activation-to-retrieval-latency relationship.
- Differentiate cognitive predicted retrieval latency from observed infrastructure latency.
- Flag activation/ACT-R-latency double counting.

#### 12.2.6 Sidebar: Rational Analysis and future demand
- Explain activation as a rationally motivated estimate of future information demand under environmental statistics.
- Explicitly state that demand likelihood is not the same as downstream action value.

### 12.3 Production utility is not memory value

- Present expected-value intuition for production/action utility, with success probability, goal value, and action cost.
- Present the ACT-R utility learning update and clarify that it updates production utility after reward feedback.
- Contrast production identity/value with memory identity/value under a query, task, and candidate action.
- Provide a compact comparison table to prevent the same `utility` field from being overloaded.

### 12.4 Modern memory systems: compare the decision they actually make

#### 12.4.1 Generative Agents: query-time retrieval score
- Recency, LLM-estimated importance, and semantic relevance; normalization and weighted sum.
- Explain the reported equal-weight configuration and recency decay factor.
- Quantify the half-life in simulated game-hours, not real time.
- Discuss the retrieval-refresh feedback loop and the difference between access and verified usefulness.

#### 12.4.2 MemoryBank: a simplified retention curve
- Exponential strength/time retention function, recall-induced strengthening and reset.
- Compare its single strength/time representation to ACT-R's accumulation over historical presentation events.
- Keep it in retention, not context admission.

#### 12.4.3 MemoryOS: lifecycle and tier management
- Explain short-, mid-, and long-term memory tiers and promotion/demotion/eviction.
- Present the heat/visit/interaction/recency approach only with the formula and variable semantics verified from the paper.
- Emphasize that heat is a lifecycle-management signal, not automatically B1 action value.

#### 12.4.4 A-MAC: explicit memory admission
- Explain utility, factual confidence, novelty, recency, and type prior as admission features.
- Present the weighted admission score and threshold as the reported policy, with the method's cross-validated weight fitting.
- State explicitly that admission into persistent memory is not identical to selecting a memory for a particular prompt.

#### 12.4.5 Chen & Cheng (2026): multi-factor memory value
- Identify the paper as an arXiv preprint, not a peer-reviewed production standard.
- Explain the seven interpretable factors and learned weighted value model.
- Compare how value informs encoding depth, forgetting, and ranking.
- Explain what it does not establish about the complete B1 activation/latency/downstream-action/cost coupling.

#### 12.4.6 Zep and Graphiti: temporal facts and hybrid retrieval
- Temporal fact fields: `created_at`, `valid_at`, `invalid_at`, and `expired_at`; distinguish system knowledge time from world validity time.
- Hybrid vector and BM25 retrieval, graph traversal, and Reciprocal Rank Fusion (RRF); do not hard-code a vendor-specific RRF constant without evidence.

#### 12.4.7 HippoRAG: graph propagation from query entities
- HippoRAG's query-entity-seeded Personalized PageRank as a graph-propagation comparison, not ACT-R spreading activation.

#### 12.4.8 MMR: relevance with redundancy control
- Present Maximal Marginal Relevance as query relevance versus redundancy reduction.
- Define set value and marginal contribution for memory combinations.
- Explain redundancy and complementarity with Product X examples.
- State that MMR is a practical diversity heuristic; it does not measure true downstream action value.

### 12.5 Constructing the B1 integration

#### 12.5.1 Four quantities, five kinds of cost
- Activation/accessibility.
- Predicted cognitive retrieval latency.
- Expected downstream contribution conditional on query/action.
- Resource/maintenance costs.
- Distinguish persistent storage/indexing, retrieval/reranking, context tokens, latency, and ongoing maintenance/privacy costs.
- Do not subtract sunk storage costs from each prompt unless converted to an explicit amortized/marginal price or shadow cost.

#### 12.5.2 Latency under real execution
- Serial retrieval versus parallel retrieval.
- Critical-path latency for mixed dependencies and bounded concurrency.
- Enforce a measured or modeled latency deadline instead of assuming all candidate latencies add.
- Keep ACT-R-predicted latency and actual infrastructure wall-clock latency in separate fields.

#### 12.5.3 A set-aware context objective
- Define expected value of a memory set conditional on query and candidate action.
- Define marginal contribution of a candidate to the already selected set.
- Explain uncertainty, redundancy, complementarity, and why a sum of independent memory values is only an approximation.
- Position MMR as a low-cost proxy, not a substitute for measured set value.

#### 12.5.4 A bounded illustrative selector
- State explicitly that this is a book-level engineering formulation, not Fan & Lan's published complete equation.
- Candidate filtering: provenance, policy, temporal validity, privacy scope, confidence, and task fit.
- Score/optimize a feasible set under token and latency budgets, with careful no-double-counting rules.
- Include an auditable fallback: retrieve fewer memories, ask for clarification, or abstain when evidence is weak.

### 12.6 Product X production design: state, events, and contracts

#### 12.6.1 Stable memory record
- Define `MemoryRecord` for stable content identity, version, source/provenance, timestamps, validity, confidence, sensitivity, privacy scope, and storage/token sizes.
#### 12.6.2 Access and prompt-inclusion events
- Define `MemoryAccessEvent` for query, candidates, activation component snapshots, model/parameter version, predicted/observed retrieval latency, and miss/success.
- Define `PromptInclusionEvent` for prompt/model/template identifiers, memory version, include/reject reason, order, token range/count, and context position.

#### 12.6.3 Outcome, attribution, and cost events
- Define `MemoryOutcomeEvent` and `OutcomeMemoryAttribution` for outcomes, attribution confidence, direction, and observable-use limits.
- Define `MemoryCostSnapshot`, `MemoryValueEstimate`, `ProductionUtilityState`, and `PolicySnapshot`.
- Dynamic activation is a query-time estimate/snapshot, not a permanent field on a memory record.
- Separate “retrieved,” “included,” “used,” and “improved the outcome.”

#### 12.6.4 Lifecycle contract and operational safeguards
- Provide a stepwise runtime lifecycle and concise implementation pseudocode/contract.
- Include policy trace and privacy/deletion/temporal invalidation requirements.

### 12.7 Failure modes and evaluation

#### 12.7.1 Failure modes to test
- Retrieval feedback loops and stale/incorrect reinforcement.
- Misaligned experience replay and error propagation (Xiong et al.).
- Prompt-position sensitivity (Lost in the Middle): log order/position and test per model/template; do not claim a universal positional law.
- Temporal conflicts, superseded facts, low-frequency decisive evidence, overconfidence, privacy scope, and attribution ambiguity.
#### 12.7.2 Benchmarks and what they measure
- Benchmarks: LoCoMo and LongMemEval, with their distinct coverage and limits.

#### 12.7.3 Metrics beyond answer quality
- Metrics: retrieval precision/recall, abstention correctness, downstream task success, contradiction/staleness/error propagation, admission/retention quality, tokens, latency p50/p95, cost per task, and robustness under changing evidence.
- Synthetic tests: single-memory effect, pairwise complementarity/redundancy, wrong-memory contamination, temporal update and deletion.

### 12.8 Boundaries, implementation notes, and handoff

- Keep GreedyDual-Size and Belady as optional cache analogies, not cognitive theories.
- Put IPS/doubly robust evaluation, FSRS, and MaRS taxonomy in a bounded advanced note / further reading rather than the main line.
- Mention Titans only to distinguish neural parametric memory from explicit declarative memory; exclude its update equations from this chapter.
- Mention Honda et al. as an ACT-R-inspired agent-memory implementation only to the extent the accessible source verifies; do not invent unavailable formula detail.
- End with B1's unanswered empirical question and a handoff to B2's separate mechanism problem.

## Required distinctions and safeguards

- **Source mechanism vs book synthesis:** label the latter explicitly; never attribute the book's proposed objective or schemas to ACT-R, B1, or an individual paper.
- **Activation vs embedding similarity:** related retrieval signals, not interchangeable quantities.
- **Predicted cognitive latency vs actual infrastructure latency:** separate quantities and measurements.
- **Production utility vs memory value:** separate state and update loops.
- **Admission vs retention vs prompt-time retrieval:** separate decisions and triggers.
- **Persistent costs vs per-query marginal costs:** do not charge sunk costs repeatedly.
- **Individual value vs set value:** test redundancy and complementarity.
- **Retrieved vs included vs used vs causally helpful:** log as separate events/evidence levels.
- **Research status:** identify preprints and vendor documentation accurately; do not present them as universal or independently validated laws.

## Source plan

Primary theoretical source: Fan & Lan (2026), B1 and associated appendices. ACT-R equations: ACT-R 7 Reference Manual (cite version/date actually consulted) and the ACT-R utility-learning description. Modern comparisons: Park et al. (Generative Agents); Zhong et al. (MemoryBank); Kang et al. (MemoryOS); Zhang et al. (A-MAC); Chen & Cheng (2026 preprint); Zep/Graphiti documentation and RRF literature; Gutierrez et al. (HippoRAG); Carbonell & Goldstein (MMR); Xiong et al. (experience-following); Liu et al. (Lost in the Middle); Maharana et al. (LoCoMo); Wu et al. (LongMemEval); Anderson et al. (Rational Analysis / environmental basis of memory). Citations will be used only for claims the cited sources support.

## Drafting and quality checks

- Follow Chapters 9–11 voice and Part II terminology; use the shared preamble/macros.
- Keep primary-source claims, comparative prior art, and book-level engineering proposals visibly distinct.
- Define each variable and assumption adjacent to its equation; no formula-only cataloguing.
- For each mechanism, answer five questions: what the source says; what it means; how related systems implement similar ideas; how a production agent should represent and operate it; and how to evaluate whether it works.
- Use compact tables and a running Product X example; avoid overloading the main narrative with general caching or neural-parametric-memory detail.
- Build the standalone chapter with XeLaTeX/Biber; inspect extracted text, references, equations, page rendering, and PDF metadata.
- Deliver the full project ZIP with the Markdown outline and chapter `.tex`; include the compiled chapter PDF and source notes. The outline itself is not required as PDF or LaTeX.
