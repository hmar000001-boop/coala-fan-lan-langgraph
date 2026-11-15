# Chapter 16 — Source-fidelity review (B6)

**Primary source:** Fan and Lan, *From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps*, arXiv:2607.23942v1.

## Source map used in the chapter

| Chapter claim | Primary-paper anchor | Treatment |
|---|---|---|
| EPIC models perceptual, cognitive and motor processing with timing, parallel pathways and resource bottlenecks | §III-D, EPIC; Figure 4; Appendix F-A | Historical architecture reconstruction; not described as a contemporary LLM runtime |
| Sigma uses a shared factor-graph representation for symbolic and probabilistic processing, inference, decisions and learning | §III-D, Sigma; Figure 4; Appendix F-A | Historical architecture reconstruction; the chapter explicitly says its Java record is not a Sigma factor graph |
| Current modern baselines include resource governance and uncertainty-conditioned action controls | §IV-A–§IV-C; §V-A–§V-B; Appendix E-A; Appendix F-B | Each system is described by its documented control and its specific boundary; no claim that an interface equals an implementation |
| B6 proposes calibrated uncertainty to accompany consequential proposals and propagate through memory admission, planning, tool authorization, monitoring and stopping | §VI-C, B6; Appendix C-Q | Reported as the residual hypothesis of the paper's reviewed corpus, not as a theorem about all systems |
| B6 insertion point and cross-bundle relationship | §V-A–§V-B; §VI-C; Appendix C-Q | Scheduler/tool authorization and cognitive decision boundary; B4 scopes recovery while B6 governs risk/resources across relevant bundles |
| Evidence and depth labels | §II-A–§II-E; §VI-C; Table VI; Appendix D, Table X | E3 and D3 are kept as independent axes, not combined into a score |
| Required trace, outcomes, ablations and falsification conditions | §VI-C, B6; Table VI; Appendix D, Table X | Trace includes uncertainty provenance, budget, interrupt and stop events; three ablations remain distinct |

## Modern baseline scope

The chapter discusses AIOS, AgentRM and budget-aware value search as resource-side controls; UALA, KnowNo, Calibrate-Then-Act and Utility-Guided Agent Orchestration as uncertainty- or cost-conditioned controls; and LangGraph/OpenAI Agents SDK interfaces as possible insertion boundaries. It does not attribute a complete B6 mechanism to any of them. Where a primary-system source is an arXiv preprint, the chapter identifies it as such rather than implying peer review.

## Explicit source boundaries

- The seven-field mechanism tuple is an analytical vocabulary defined earlier in Part II; the chapter maps B6 into it rather than claiming Fan and Lan prescribe one implementation schema.
- EPIC and Sigma are historical reference architectures. The chapter's `ResourceVector`, `UncertaintyEstimate`, scheduler, authorization gate, lifecycle, and persistence protocol are book-level proposals.
- The chapter does not invent a B6 learning rule. It proposes a versioned, separately ablatable calibration-feedback path and states that the paper leaves the specific update algorithm open.
- The chapter preserves the paper's failure modes and independent E/D labels. It does not claim B6 is validated or that the bounded review proves no other system has the coupling.
- Chapter 17 owns the B5/GraSP closed-candidate case. Chapter 18 owns cross-bundle synthesis and is not previewed as a conclusion here.

## Review outcome

No source claim is intentionally promoted beyond the cited paper. Engineering material is explicitly labelled as a book proposal. Final review should recheck citations after the LaTeX/Biber build and compare the rendered source-note and references pages.
