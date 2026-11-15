# Chapter 17 — Source-fidelity review

**Chapter:** The Closed Candidate B5 and GraSP  
**Batch:** 8 — standalone special methodological case  
**Outline:** v1.0, approved 15 November 2026  
**Review purpose:** Trace the principal mechanism claims to their primary sources and keep the closed-candidate result separate from engineering reconstruction.

## 1. Primary sources and roles

### Fan and Lan (2026)

Haodi Fan and Zucong Lan, “From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps,” arXiv:2607.23942v1, submitted 27 July 2026.

Chapter anchors: §§ II-A–II-E (bounded corpus, coding, and candidate extraction); § III-C (ICARUS); §§ IV-B–IV-C and V-A–V-B (modern skill systems and mapping); § VI-B–VI-D (residual bundles, B5 closure, and cross-bundle relations); Table V (candidate definition and closest-baseline screening); Table VI (residual bundle status); Table IX and Appendix C-O (claim packet and B5 evidence); Appendix F (coding and review limits).

Use in chapter: B5's initial definition; the closest-baseline screening decision; its removal from the residual count; ICARUS comparison context; E3/D4 classification; bounded corpus and coding limitations.

### Xia et al. (2026)

Tianle Xia, Lingxiang Hu, Yiding Sun, Ming Xu, Lan Xu, Siying Wang, Wei Xu, and Jie Jiang, “GraSP: Graph-Structured Skill Compositions for LLM Agents,” arXiv:2604.17870v1, submitted 20 April 2026.

Chapter anchors: § 1 (motivation and contribution); §§ 2.1–2.5 (definition, four-stage architecture, retrieval, confidence, DAG compilation, execution, local repair, and routing); § 3 (experimental setup and main results); § 4 (ablation and analysis); Appendix C.2 (full five-condition ablation specification); Appendix E (illustrative ALFWorld case study); discussion/limitations section.

Use in chapter: the technical reconstruction of GraSP, all graph/node/edge/repair details, experimental conditions, results, and limitations.

### Choi and Langley (2018)

Dongkyu Choi and Pat Langley, “Evolution of the ICARUS Cognitive Architecture,” *Cognitive Systems Research* 48 (May 2018), 25–38, DOI 10.1016/j.cogsys.2017.05.005.

Use in chapter: historical cross-check only, restricted to the ICARUS mechanism described by Fan and Lan. It is not introduced as a third formal theory foundation.

## 2. Claim-to-source trace

| Chapter claim | Primary support | Boundary preserved |
|---|---|---|
| B5 originally couples calibrated multi-skill routing, typed verification, bounded repair, and planner fallback | Fan & Lan, Table V; § VI-C, B5 | Candidate definition is attributed to Fan & Lan. |
| GraSP closes B5 within the reviewed corpus | Fan & Lan, §§ II-D–II-E, VI-B–VI-C; Table V; Appendix C-O | Does not prove universal absence across all literature or future systems. |
| Four stages: memory-conditioned retrieval, DAG compilation, verified execution/local repair, confidence routing | Xia et al., §§ 2.1–2.5 | Reconstructed from GraSP, not a Fan & Lan invention. |
| Retrieval mixes semantic skill distribution and memory-induced successful-trajectory distribution | Xia et al., § 2.2 | Symbols and normalization follow the paper's formulation. |
| Confidence features: memory similarity, distribution agreement, top-skill margin, goal coverage | Xia et al., § 2.2 | Do not infer calibration guarantees absent from the paper. |
| Graph is an executable typed DAG with source/skill/sink nodes and four validity conditions | Xia et al., §§ 2.1, 2.3 | Validity conditions are not generalized to cyclic plans. |
| State/data edges are hard; order edges are soft | Xia et al., § 2.3 | Do not describe all edge types as interchangeable. |
| Node tuple includes schema, arguments, preconditions/effects, verifier, status, confidence, repair budget | Xia et al., § 2.3 | Java records are book-level representations. |
| Five repair operators: Rebind, InsertPrereq, Substitute, Rewire, Bypass | Xia et al., § 2.4 and repair-algebra description | Keep operators semantically distinct. |
| Repair must satisfy structural and locality bounds, preserving unaffected verified ancestors | Xia et al., § 2.4 | Additional transaction/version/side-effect guards are explicitly book proposals. |
| Low confidence, failed compilation, exhausted local repair, and exhausted global replanning trigger separate fallback routes | Xia et al., §§ 2.4–2.5 and algorithm | Entry confidence routing is not the same as post-failure escalation. |
| GraSP's mapped mechanism is E3/D4 | Fan & Lan, § VI-C, B5; Table IX; Appendix C-O | E3 and D4 remain independent axes; not E4 and not documented lineage. |
| Main benchmark results across four environments and eight model backbones | Xia et al., § 3 and main results tables | Results remain limited to the tested settings. |
| Main component table and Appendix C.2 have different presentation scopes | Xia et al., component table and Appendix C.2 | Do not claim that all five appendix ablations appear as five separate main-table rows. |
| DAG expressiveness and evaluated-domain limitations | Xia et al., limitations/discussion | Multimodal, GUI, API, cyclic, and multi-agent extensions are future work, not demonstrated results. |

## 3. Explicit separation of claim types

- **Source-described GraSP mechanisms:** retrieval fusion; confidence features and routing; typed DAG; source/sink and validity; node attributes; hard state/data and soft order edges; topological execution; precondition/postcondition verification; five repair operators; bounded escalation; benchmark design and reported results.
- **Fan & Lan review findings:** the bounded mechanism corpus; E/D coding framework; B5 candidate derivation; closest-baseline screening; B5 closure; E3/D4 code; cross-bundle mapping.
- **Book explanations:** flat-list scenario, diagram annotations, step-by-step exposition, and the illustrative “heating a potato” task trace. It is not represented as an exact experimental trajectory.
- **Book-level engineering proposals:** Java records/interfaces; graph compiler and validator contracts; immutable version identifiers; explicit lifecycle enums; concurrency and persistence model; transactional patch acceptance; idempotency; event/trace schema; test suite and implementation sequence.

## 4. Limits and non-claims

1. The B5 closure is conditional on Fan and Lan's frozen corpus, source search, and provisional coding. It is not a proof that every relevant publication was found.
2. E3 describes functional convergence without a claim of documented ICARUS inheritance. D4 describes experience-dependent adaptation of future control; it does not mean complete migration of ICARUS.
3. GraSP's benchmark outcomes do not validate every verifier, repair, domain, or deployment setting.
4. The book's Java mapping is not GraSP's official implementation and is not an independent reproduction of its results.
5. The DAG cannot directly represent arbitrary cycles or repeated iterative refinement without an explicit extension.
6. The detailed potato example is book-authored, inspired by the paper's named case study, and not claimed to reproduce an exact hidden trace.

## 5. Review result

The chapter's principal statements have an identified source anchor. The prose keeps the published GraSP mechanism separate from Fan and Lan's closure/coding decision and from the book's implementation proposals. Experimental numbers are attributed to Xia et al. and are not described as evidence from Fan and Lan's review. No third formal theoretical foundation is introduced.
