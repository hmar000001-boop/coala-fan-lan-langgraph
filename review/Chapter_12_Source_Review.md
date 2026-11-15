# Chapter 12 source and evidence review

**Chapter:** Understanding Activation, Retrieval Latency, and Utility: B1  
**Review date:** 14 November 2026  
**Status:** Source audit and drafting boundary record

## 1. Evidence hierarchy

The chapter preserves the book's two formal theoretical foundations. CoALA remains the foundation for Part I; Fan and Lan remains the foundation for Part II. Chapter 12 is specifically organized around Fan and Lan's B1 mechanism-level gap. The additional papers and documentation below are comparative mechanisms, implementation examples, empirical evidence, or evaluation resources. They are not treated as additional foundational theories for the book.

The chapter separates three kinds of statement:

1. **Source mechanisms:** mechanisms and equations that the cited paper or manual actually defines.
2. **Comparative prior art:** published systems that solve a related but narrower lifecycle decision.
3. **Book-level synthesis:** the proposed B1-oriented integration, data model, event schema, selection procedure, and evaluation plan. These are not attributed to any one paper.

## 2. Primary B1 source

**Fan, Haodi, and Zucong Lan.** *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps*. arXiv:2607.23942 (2026). <https://arxiv.org/abs/2607.23942>

The chapter uses §VI-C (B1), Table V, Appendix C-A (R1), and Appendix B as the source map. B1 is presented as a proposed integration question involving memory activation/accessibility, predicted retrieval latency, downstream value, and maintenance cost at context assembly, followed by outcome-sensitive updates. The paper does not provide a single experimentally validated, universal control law that resolves this full coupling. B1 is kept distinct from B3 workspace competition and capacity.


### B1 adaptive-memory baseline set (Fan & Lan classification)

Fan and Lan's §VI-C, Table V/VI, Appendix B, and Appendix C-A identify AgeMem, Memory-R1, MemCon, DeltaMem, A-MAC, and CURATOR as executable adaptive-memory comparators for the B1 discussion, while DAM is treated as a conceptual comparator. Their review describes CURATOR as fitting helpfulness online and using retrieval propensity, value, harm, and byte cost to govern keep/share/trust decisions. Chapter 12 reproduces that classification and bounded mechanism summary; it does not claim to independently reconstruct every comparator's implementation or supply equations that the review does not document. CURATOR is described as the closest value--cost comparator, while the residual B1 question remains the coupled treatment of accessibility/activation, predicted retrieval latency, downstream action utility, and maintenance cost at context assembly.

## 3. ACT-R foundation

**Bothell, Dan.** *ACT-R 7.30+ Reference Manual*. ACT-R Research Group, Carnegie Mellon University. <https://act-r.psy.cmu.edu/actr7.x/reference-manual.pdf>

The ACT-R equations and semantics were checked against this official manual, including the sections on declarative-memory activation, base-level learning, spreading activation, partial matching, retrieval time, and utility learning. The base-level section distinguishes the full event-history equation from the optimized approximation. Presentation-event semantics are not generalized to every read or failed retrieval. The spreading-activation explanation distinguishes the general source-allocation equation from the simplified fan form. Retrieval latency is taught as a prediction derived from activation, not as a database benchmark.

**Anderson, John R.** *How Can the Human Mind Occur in the Physical Universe?* Oxford University Press, 2007. This is used for ACT-R background and the separation of production utility from declarative-memory accessibility.

**Anderson, John R., Shawn Betts, Michael D. Byrne, Lael J. Schooler, and Clayton Stanley.** “The Environmental Basis of Memory.” *Psychological Review* 130(5), 1137–1166 (2023; published online 22 December 2022). DOI: <https://doi.org/10.1037/rev0000409>. Used for the bounded Rational Analysis explanation: environmental demand statistics can motivate accessibility, but demand likelihood is not downstream action value.

## 4. Modern memory systems and decision boundaries

### Query-time retrieval and relevance

**Park, Joon Sung, et al.** “Generative Agents: Interactive Simulacra of Human Behavior.” UIST 2023. DOI: <https://doi.org/10.1145/3586183.3606763>. Used for recency, importance, and relevance scoring; equal-weight reported configuration; and the simulation-hour recency-decay interpretation.

**Carbonell, Jaime, and Jade Goldstein.** “The Use of MMR, Diversity-Based Reranking for Reordering Documents and Producing Summaries.” SIGIR 1998, 335–336. DOI: <https://doi.org/10.1145/290941.291025>. Used as a diversity/redundancy heuristic, not as a direct estimate of downstream action value.

### Retention, strengthening, and tier lifecycle

**Zhong, Wanjun, et al.** “MemoryBank: Enhancing Large Language Models with Long-Term Memory.” AAAI 2024. DOI: <https://doi.org/10.1609/aaai.v38i17.29946>. Used for the simplified strength-and-time retention curve, with its lifecycle boundary explicitly separated from ACT-R base-level activation.

**Kang, Jiazheng, Mingming Ji, Zhe Zhao, and Ting Bai.** “Memory OS of AI Agent.” EMNLP 2025, 25961–25970. DOI: <https://doi.org/10.18653/v1/2025.emnlp-main.1318>. The heat/visit/interaction/recency equation and lifecycle behavior were checked against the paper PDF. It is classified as tier management, promotion, and eviction—not as a B1 context-value equation.

### Admission and memory valuation

**Zhang, Guilin, et al.** “Adaptive Memory Admission Control for LLM Agents.” arXiv:2603.04549 (2026). <https://arxiv.org/abs/2603.04549>. The five-factor admission score, normalized features, non-negative weights, threshold, and cross-validation description were checked against the arXiv paper. It is presented as an admission policy, not a query-time selector.

**Chen, Zhibao, and Qian Cheng.** “Learning What to Remember: A Cognitively Grounded Multi-Factor Value Model for Agentic Memory.” arXiv:2606.12945 (2026). <https://arxiv.org/abs/2606.12945>. The seven factors and stated uses of the learned value estimate were checked against the preprint. Its status is explicitly identified as an arXiv preprint, not an established production standard. Its value model is compared with B1 without claiming it establishes the complete activation/latency/action-value/cost coupling.

### Temporal and graph retrieval

**Zep.** *Graphiti Documentation*. <https://help.getzep.com/graphiti/>. Used for the documented distinction among system creation time and world-validity/invalidity/expiry times, plus hybrid retrieval concepts. The chapter notes that product documentation and exact fields can vary by version.

**Cormack, Gordon V., Charles L. A. Clarke, and Stefan Buettcher.** “Reciprocal Rank Fusion Outperforms Condorcet and Individual Rank Learning Methods.” SIGIR 2009, 758–759. DOI: <https://doi.org/10.1145/1571941.1572114>. Used for the general RRF equation; no undocumented vendor-specific constant is attributed to Graphiti.

**Gutiérrez, Bernal Jiménez, Yiheng Shu, Yu Gu, Michihiro Yasunaga, and Yu Su.** “HippoRAG: Neurobiologically Inspired Long-Term Memory for Large Language Models.” NeurIPS 2024. DOI: <https://doi.org/10.52202/079017-1902>. Used for query-entity-seeded Personalized PageRank over a knowledge graph. The chapter explicitly says graph PPR is not ACT-R spreading activation.

## 5. Failure evidence and benchmarks

**Liu, Nelson F., et al.** “Lost in the Middle: How Language Models Use Long Contexts.” *Transactions of the Association for Computational Linguistics* 12 (2024), 157–173. DOI: <https://doi.org/10.1162/tacl_a_00638>. Used to motivate logging prompt position and testing position effects under a specific model, task, and prompt template; not presented as a universal rule.

**Xiong, Zidi, Yuping Lin, Wenya Xie, Pengfei He, Zirui Liu, Jiliang Tang, Himabindu Lakkaraju, and Zhen Xiang.** “How Memory Management Impacts LLM Agents: An Empirical Study of Experience-Following Behavior.” ACL 2026, 623–645. DOI: <https://doi.org/10.18653/v1/2026.acl-long.27>. Used for error propagation and misaligned experience-following as empirical failure modes.

**Maharana, Adyasha, Dong-Ho Lee, Sergey Tulyakov, Mohit Bansal, Francesco Barbieri, and Yuwei Fang.** “Evaluating Very Long-Term Conversational Memory of LLM Agents.” ACL 2024, 13851–13870. DOI: <https://doi.org/10.18653/v1/2024.acl-long.747>. Used for LoCoMo's long-term, multi-session conversational-memory coverage.

**Wu, Di, Hongwei Wang, Wenhao Yu, Yuwei Zhang, Kai-Wei Chang, and Dong Yu.** “LongMemEval: Benchmarking Chat Assistants on Long-Term Interactive Memory.” ICLR 2025. <https://proceedings.iclr.cc/paper_files/paper/2025/hash/d813d324dbf0598bbdc9c8e79740ed01-Abstract-Conference.html>. Used for information extraction, multi-session reasoning, temporal reasoning, knowledge updates, and abstention coverage.

## 6. Bounded adjacent mechanisms

**Behrouz, Ali, Pei Zhong, and Vahab Mirrokni.** “Titans: Learning to Memorize at Test Time.” NeurIPS 2025; arXiv:2501.00663. <https://arxiv.org/abs/2501.00663>. Mentioned only to mark the boundary between explicit declarative memory items and neural parametric memory. Its update equations are intentionally excluded from the B1 argument.

**Honda, Yudai, Yuki Fujita, Keiichi Zempo, and Shogo Fukushima.** “Human-Like Remembering and Forgetting in LLM Agents: An ACT-R-Inspired Memory Architecture.” Proceedings of the 13th International Conference on Human-Agent Interaction, 229–237. DOI: <https://doi.org/10.1145/3765766.3765803>. The accessible abstract supports a bounded description of vector-based activation incorporating temporal decay, semantic similarity, usage frequency, and probabilistic noise. Detailed equation and timestamp semantics are not asserted without the full paper text. The conference is HAI 2025; the proceedings publication date is January 2026.

## 7. Technical safeguards applied in the chapter

- ACT-R activation is not relabelled embedding similarity.
- ACT-R-predicted cognitive retrieval time is distinguished from infrastructure wall-clock latency.
- ACT-R activation and its derived predicted latency are not independently rewarded without a double-counting analysis.
- ACT-R production utility is not stored as memory-item value.
- Admission, retention/forgetting, and query-time context assembly are separate policy decisions. Persistent-memory admission (new records entering durable storage) is distinct from B1 context admission (already-stored candidates entering the active context).
- Persistent storage/indexing costs are not charged repeatedly as prompt-time marginal costs unless explicitly amortized.
- Serial and parallel retrieval have different end-to-end latency behavior; mixed execution uses a critical path or measured latency.
- Memory-set value can include redundancy and complementarity; an additive per-memory score is treated as an approximation.
- Retrieved, included, used, and causally helpful are separate evidence levels and event records.
- Dynamic activation is computed in context and logged as a snapshot, not treated as an immutable property of a memory record.
- The proposed selector, schemas, and evaluation plan are labelled as engineering synthesis, not attributed to ACT-R or Fan and Lan.

## 8. Intentional scope exclusions

The main chapter does not derive full Belady or GreedyDual-Size cache algorithms, IPS/doubly robust policy evaluation, FSRS, the full MaRS taxonomy, or Titans' neural-memory equations. These are adjacent tools or mechanisms and would distract from B1's defined integration question. The chapter points to them as bounded advanced comparisons where appropriate.
