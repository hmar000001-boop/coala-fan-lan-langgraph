# Independent technical and editorial review of Parts I and II

**Book:** *From Cognitive Architectures to Production Agentic Systems*  
**Review date:** 15 November 2026  
**Review posture:** Independent, evidence-led and non-final  
**Source checkpoint:** `batch09-chapter18-complete-project.zip` (2,870,820 bytes; SHA-256 `1638be9c6a86ee05d389cc558a0e66f87413e1fe50310d029e338d201f9b1602`).  
**Additional checkpoint:** `cognitive-architectures-to-production-agents-chapters-01-11(1).zip` (1,605,154 bytes; SHA-256 `12b6e77df13f1cdf5acbc1f1b06b6cb86cd1025b4f4c7dd21112432e4c56789c`).

## 1. Executive verdict

**Overall assessment: strong conceptual foundation and unusually careful mechanism-level treatment, with a small number of concrete corrections and several editorial/architectural improvements still needed before Part III.** I found no basis, from the inspected material, to reject the overall CoALA account in Part I or the core mechanism-analysis method in Part II. The supplied review is directionally useful, but its individual claims need different dispositions. In particular, some alleged defects are real, some are only partly defects, and at least one corpus objection is not supported by the source structure.

The work's strongest feature is its separation of three things that are often conflated:

1. what CoALA says about the organization of language agents;
2. what Fan and Lan identify at the level of documented mechanisms, evidence relation and migration depth; and
3. what the book itself proposes as an engineering reconstruction.

The most important correction is in Chapter 12: the B1 chapter has a real source-note macro error and lacks the seven-field mechanism reconstruction used in the other residual-bundle chapters. The B1 integration equation also needs a more explicit relationship to activation and lifecycle maintenance cost. Chapter 11 contains a wrong forward reference from CLARION to Chapter 16. These should be fixed before Part III writing relies on them.

Part I is intentionally conceptual. Its lack of full Java source is not, by itself, a defect: the original editorial architecture places implementation in Part III. Nevertheless, a small mathematical example and a short language-neutral decision-loop illustration would make the transition to programming clearer without turning Part I into a code tutorial.

Part II is long, but the later chapters do more than repeat theory: they reconstruct mechanisms, state explicit gaps, propose typed contracts and state machines, and define evaluation and falsification conditions. The answer is not to cut 20–25% wholesale. The better editorial task is to remove repeated explanations while protecting the distinct mechanism-level analysis and the practical bridge.

## 2. Review scope and evidence limits

### 2.1 Material inspected

The latest complete-project archive was extracted and inspected. It contains the LaTeX chapter sources for Chapters 1–18, the Part I/II structure, bibliography, shared macros, diagram source directories, build/quality scripts, outline/review artifacts, and the Part III placeholder structure. I inspected:

- the full source text for Chapters 1–8 and 9–18 at the chapter-file level;
- all chapter headings and section structure;
- the full B1 source around the activation, latency, utility, objective, event model, and source note;
- the Chapter 11 CLARION forward reference;
- the opening and implementation-boundary statements in Chapters 13–18;
- the shared `\FanLanCite` macro and citation usage;
- source and drafting review notes included in the repository;
- word counts from the chapter source files and selected scripted checks;
- the bibliography entries for CoALA, Fan and Lan, and the ACT-R manual.

I also checked selected primary-source material: the CoALA paper's abstract and architecture statement, its case-study discussion of ToT, and Fan and Lan's paper for the corpus scope, seven-field/evidence coding, five residual bundles, B5 closure and validity boundary.

### 2.2 What was not available or not completed

The supplied draft refers to `book.pdf`, a 15 November 2026 build of 597 pages. That exact combined PDF was **not present in the inspected complete-project ZIP**, and I did not locate an exact matching `book.pdf` in the available Library search. The archive contains source and chapter-level outline/review PDFs, not the claimed combined book PDF. Therefore:

- page-number-specific observations such as p. 246, p. 183 or blank page 590 are not independently verified against that exact PDF;
- final rendered typography, page breaks, figure rendering, index length and full-PDF visual defects are not certified here;
- the final 597-page word counts cannot be reproduced from the TeX source using the same counting method as the supplied report;
- no combined-book PDF build is claimed. The repository build script requires the pinned Mermaid CLI and rendered diagrams; those dependencies/output images were not included in the extracted checkpoint.

This review is therefore a source-level review, not a final typeset-PDF certification. It is broad, but it is not a line-by-line re-audit of every cited external paper or all 163,000 words against every primary source.

## 3. Part I — CoALA: assessment

### 3.1 What is accurate and effective

The core organization is consistent with the primary CoALA account: information storage, action space and decision-making procedure are distinct but related dimensions. The manuscript correctly places working and long-term memory under information storage; internal and external actions under action space; and planning/execution within a repeated decision cycle. This matches the paper's explicit description of CoALA as a conceptual framework rather than a prescribed software architecture. See Sumers et al., TMLR 2024, abstract and introduction, especially the three-dimension statement: https://openreview.net/pdf/07475727a2787df12052196b9f2624497ef3c3bd.pdf.

The progression from Chapter 1's motivation to Chapter 2's structural map, Chapters 3–5's memory/action distinctions, Chapters 6–7's planning/evaluation/selection and Chapter 8's iterative process is pedagogically sensible. In particular:

- The distinction between a prompt and a memory system is useful and correctly prevents the context window from being treated as the complete memory architecture.
- The retrieval/reasoning/learning distinctions in Chapter 4 are useful operational categories for internal actions.
- Chapter 5's grounding treatment correctly emphasizes the external environment and feedback rather than presenting every tool invocation as merely another generated sentence.
- Chapter 6's candidate/evaluation distinction is a useful preparation for implementation. The chapter appropriately treats candidate enumeration as a proposal method, not as evaluation.
- Chapter 7 correctly separates candidate evaluation from selection, and selection from execution and human authorization.
- Chapter 8's iterative, interleaved treatment protects against a misleading rigid one-pass pipeline.

The manuscript is also appropriately cautious about the boundaries of CoALA. It does not generally attribute a universal database, workflow engine, access-control system, retry policy or production safety policy to the conceptual framework.

### 3.2 Decision-procedure coverage is broader than the current narrative makes visible

The primary CoALA paper itself places Tree of Thoughts in its case-study discussion as a special language-agent configuration with reasoning-only internal actions, tree search, proposal/evaluation/selection of thoughts and lookahead/backtracking. See CoALA PDF, case studies, around pp. 13–14: https://openreview.net/pdf/07475727a2787df12052196b9f2624497ef3c3bd.pdf.

The current Part I does a good job explaining CoALA's generic decision-cycle responsibilities, but does not give readers a sufficiently concrete comparison of distinct algorithm families that can realize them. This is not a CoALA accuracy defect; it is an opportunity for the book's bridge to implementation. Part III should make explicit that CoALA does not prescribe one planning/search algorithm. A system may use sequential reasoning, branching search, enumeration, a simulator, an optimizer, a rule-based policy or a hybrid.

The concepts CoT, ToT and RAP should be introduced only as method-level examples or comparison baselines, not as replacements for CoALA's architecture. CoT is a prompting/reasoning pattern; ToT adds branching over intermediate thought states and search/backtracking; RAP combines an LLM reasoning agent and LLM world model with MCTS and task-specific rewards. RAP's original design explicitly uses the LLM as both world model and reasoning agent: Hao et al., EMNLP 2023, https://aclanthology.org/2023.emnlp-main.507/.

### 3.3 What could be improved without changing Part I's scope

1. Add a compact softmax equation and one worked numerical example in Chapter 7. The current prose explains softmax, but a programmer audience would benefit from seeing the mapping from values to normalized selection weights. The supplied review's rounded values are acceptable: for 0.80, 0.60 and 0.45, the standard softmax distribution is approximately 0.396/0.324/0.279 at temperature 1.0 (rounding to 0.40/0.32/0.28), and approximately 0.858/0.116/0.026 at temperature 0.1 (rounding to 0.86/0.12/0.03). These are teaching values, not CoALA results.
2. Add a short, clearly labelled illustrative decision-loop pseudocode in Chapter 8. It should show the main loop and the proposal/evaluation/selection/execution/observation boundary without implying that CoALA prescribes the exact code.
3. Reduce repeated overview material. Chapter 1's preview and Chapter 2's detailed architecture are both useful, but their repeated three-dimension descriptions can be made progressively additive rather than restating near-identical definitions.
4. Preserve the source caveats, but consolidate recurring disclaimers within each chapter. A chapter-level source-boundary note can carry the common caveat while local paragraphs retain only the limitation necessary for the immediate claim.
5. Revisit the Product X terminology/version example. "Deployment 4.7" is understandable in context but looks like a section reference. Write "deployment v4.7" or use a build identifier.

### 3.4 What I would not change

I would not move the detailed Java data models, graph persistence, database schema, vector index configuration, workflow runtime, concurrency controls or full application code into Part I. Part I's role is to establish the conceptual architecture and the distinctions that later implementation must preserve.

## 4. Part II — Fan and Lan: assessment

### 4.1 The review method is a strong contribution of the book

Part II correctly distinguishes a feature label from an operational mechanism. The seven-field tuple—operative state substrate, control locus, transition trigger, persistence boundary, failure semantics, learning operator and resource/governance policy—is treated as an analytical representation, not as a mandatory seven-component software architecture. E1–E4 (evidence relation) and D0–D4 (migration depth) are kept as independent axes.

This follows Fan and Lan's own presentation. The primary paper defines a mechanism as an operation consuming explicit state, activated by an identifiable trigger, exercising control over a transition and potentially changing later behavior. It separately defines E and D coding and warns that high implementation depth does not mean full migration. The paper also states that its coding did not claim independent inter-rater reliability and that the residual partition is conditional on a bounded corpus and provisional coding. See https://arxiv.org/abs/2607.23942, especially Sections II-C–II-E and VII.

The book's use of node/edge correspondence and at least one preserved invariant is a useful way to prevent superficial similarity from becoming a lineage claim. The manuscript is also right to retain the bounded-review limitations: no PRISMA completeness, no search-recall estimate, no claim of prevalence and no causal performance claim for the residual bundles.

### 4.2 The five residual bundles and closed B5 case are represented correctly at the high level

The five residual bundles correspond to the primary paper's stated agenda:

- B1: activation/accessibility, retrieval latency, downstream action utility and maintenance cost;
- B2: typed impasse, isolated substate, typed resolution and safe resolution compilation;
- B3: bounded content competition/workspace, broadcast and outcome-dependent admission learning;
- B4: persistent intention, reconsideration and method authority;
- B6: uncertainty, resource allocation, interruption and stopping.

B5 is treated separately as a closed candidate after the paper's closest-baseline screening identifies GraSP's selection/verification/repair/fallback chain. The book correctly avoids presenting B5 as a sixth surviving residual or claiming that GraSP solves every skill-governance problem in every domain. Fan and Lan explicitly describe the five residuals and B5 closure in their abstract and Section VI; see https://arxiv.org/abs/2607.23942.

Chapter 18's cross-bundle boundaries are particularly valuable: B2 recovery must not take ownership of the parent goal; B3 broadcast is not execution permission; B4 owns commitment/method authority; B6 governs resource and risk constraints; GraSP-like skill execution remains separate from authorization. This is exactly the kind of control/authority separation that should be carried into Part III.

### 4.3 Chapter-by-chapter observations

- **Chapters 9–11:** The move from feature labels to mechanism reconstruction and then to the catalog/coding procedure is sound. The book appropriately explains the bounded and provisional status of the corpus. A forward-reference error remains in the CLARION paragraph in Chapter 11.
- **Chapter 12 (B1):** The historical ACT-R exposition and lifecycle distinctions are careful. The distinction among persistent-memory admission, retrieval and query-time context admission is useful. However, B1 lacks the same seven-field reconstruction used later, and its proposed objective does not expose the activation relationship explicitly. Maintenance cost is discussed and intentionally separated from a per-prompt objective, but the lifecycle accounting should be made explicit so that the four B1 dimensions do not appear to disappear from the synthesis.
- **Chapter 13 (B2):** The Soar impasse/substate treatment and protected-parent-state design form a strong bridge. The book distinguishes source-described semantics from its own reference records and orchestration proposal. The implementation pseudocode is labelled illustrative, which is appropriate.
- **Chapter 14 (B3):** The chapter correctly distinguishes a workspace from a message bus, blackboard, shared store, top-k retriever or agent-team selector. It makes the competition, bounded admission, broadcast and outcome-feedback coupling visible. The proposed interfaces and lifecycle need not be attributed to LIDA or Fan and Lan.
- **Chapter 15 (B4):** The persistent-intention distinction between goal and method is strong. The chapter's opening example is a clear case of the objective remaining stable while a method changes. It is correctly identified as a book-level engineering proposal.
- **Chapter 16 (B6):** The coupling of uncertainty, resource budgets, interruption, preemption, resumption and stopping is a useful production bridge. It correctly separates tool authorization from resource scheduling.
- **Chapter 17 (B5/GraSP):** The negative-case treatment is valuable. It distinguishes the primary GraSP description from Fan and Lan's mapping and from the book's Java-like reconstruction.
- **Chapter 18:** The synthesis is a substantial chapter rather than a short recap. It distinguishes shared runtime state from shared authority, gives cross-bundle dependencies, proposes typed handoffs and defines compositional ablations. It explicitly says the complete five-bundle runtime has not been validated by the source paper.

### 4.4 Main Part II improvements

1. Repair Chapter 12's source-note macro, add B1's seven-field/evidence-depth treatment, and make the objective/accounting boundary explicit.
2. Fix Chapter 11's CLARION forward reference.
3. Apply a consistent top-level chapter template, but do not force identical labels where the content is already clear and the chapter's unique role requires a different opening. A "Chapter at a glance" and explicit learning outcomes are useful; the exact heading label is less important than consistency of function.
4. Label Java-like listings consistently as illustrative, non-standalone contract fragments or pseudocode unless they are compiled in a companion sample. They are not currently a runnable application. Part III should supply the compiled implementation.
5. Do not shorten the Part II implementation bridges merely because Part III will contain code. Part II answers what mechanism-level properties should be represented and tested; Part III must demonstrate an integrated domain implementation. Prevent duplication by linking back to the relevant mechanism contracts and then implementing their domain-specific realization.

## 5. Length and balance

A direct count of the chapter source files in the extracted archive gives approximately:

- Part I: 35,253 source words (Chapter 1 body plus Chapters 2–8);
- Part II: 95,343 source words (Chapters 9–18).

These values differ from the supplied report's PDF-derived word counts, likely because the counting methods and included material differ. They support the broad observation that Part II is much larger—about 2.7 times Part I by this source count.

That ratio deserves editorial attention, but not an automatic 20–25% cut. Part II contains ten chapters, including five distinct mechanism studies, a closed-case study and an integration chapter. It carries more original analytical and engineering-bridge material than Part I. Its size is therefore not inherently disproportionate. The real test is whether every long section contributes one of: source reconstruction, evidence comparison, a distinct mechanism boundary, a practical implementation contract, or a falsifiable evaluation plan. Repeated general caveats and repeated explanations can be trimmed; unique state/control semantics and worked traces should be protected.

## 6. Implications for Part III

Part III should not merely re-explain the generic contracts from Part II. It should **instantiate and integrate** them in a single, sufficiently rich domain-bounded system.

For the selected supply-chain pilot:

- use CoALA to organize information, action space and decision-making;
- use Fan and Lan's seven fields to inspect relevant mechanism implementations;
- implement B1, B2, B3, B4 and B6 where they materially solve supply-chain problems;
- treat B5/GraSP as a closest-baseline/closed-case reference, not a new missing mechanism;
- compare sequential reasoning, branching search and MCTS-based planning as decision-procedure methods;
- preserve a deterministic domain authority for inventory, capacity, route, shipment and order invariants;
- write complete Java 21 modules, integration tests, failure tests, evaluation protocols and CI rather than presenting Java-like fragments.

CoT, ToT and RAP should be cited as method-level prior art and experimental comparators, not added as third, fourth and fifth theoretical foundations. RAP's original use of an LLM as both reasoning agent and world model must be distinguished from a supply-chain production planner that uses an authoritative structured simulator. The latter is a RAP-inspired adaptation, not an exact reproduction.

## 7. Final independent judgement

Parts I and II provide a sound foundation for a practical implementation book. The central ideas are coherent, the source/engineering distinction is a genuine strength, and the later mechanism chapters have already started the transition from theory to implementation. Before Part III, fix the concrete Chapter 12 and Chapter 11 defects; clarify the scope of illustrative Java-like fragments; and establish a precise boundary between the generic reference designs in Part II and the executable domain system in Part III.

I recommend proceeding with a **single supply-chain pilot** after these corrections are registered. Do not implement the other use cases yet. The pilot's success should be judged by whether a reader can see the CoALA dimensions and the relevant Fan & Lan mechanisms operating in tested Java code across a family of requests—not by the number of agents or frameworks used.
