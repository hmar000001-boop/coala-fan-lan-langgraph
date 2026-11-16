# Review basis, validation limits and source register

**Review date:** 16 November 2026  
**Primary artifact:** user-uploaded `book.pdf` (597 pages)

## 1. Primary book artifact

- Filename: `book.pdf`
- SHA-256: `afdee56e95075def422da97d563176e48b21809396ce100b925a118db6029384`
- PDF creator: XeLaTeX via the book's production toolchain
- PDF creation date in metadata: 15 November 2026, 17:31 UTC
- Length: 597 pages, US Letter (8.5 × 11 in)
- Review scope: Part I, Chapters 1–8 (approximately 37,980 extracted words); Part II, Chapters 9–18 (approximately 107,094 extracted words)
- Printed page spans: Part I approximately pp. 3–138; Part II approximately pp. 143–518.

The uploaded PDF was used as the definitive rendered artifact for chapter content and layout review. All 597 pages were included in a thumbnail-level visual scan; representative pages containing the Chapter 12 source note, B1 equations, selected listings, the index and the references transition were inspected at higher resolution. The blank page 590 is consistent with the two-sided/open-right layout because the references begin on the following recto page.

## 2. Source archives and targeted source inspection

### Latest complete-project checkpoint

- Filename: `batch09-chapter18-complete-project.zip`
- Size: 2,870,820 bytes
- SHA-256: `1638be9c6a86ee05d389cc558a0e66f87413e1fe50310d029e338d201f9b1602`
- Library file ID: `file_000000001bf081f59b528372cedcc476`
- Contents: LaTeX source for Parts I–II, Chapter 18 integrated source checkpoint, bibliography, shared macros, diagrams/source, build scripts, glossary/index configuration, project documentation and review files.

### Additional Chapters 1–11 checkpoint

- Filename: `cognitive-architectures-to-production-agents-chapters-01-11(1).zip`
- Size: 1,605,154 bytes
- SHA-256: `12b6e77df13f1cdf5acbc1f1b06b6cb86cd1025b4f4c7dd21112432e4c56789c`
- Library file ID: `file_00000000ffac81f5b9b05b7f02347f2c`

The source archives were used to corroborate chapter organization and perform targeted source checks around defects visible in the PDF. Specifically, the review checked the Chapter 12 broken `\FanLanCite` invocation, the Chapter 11 forward reference, the glossary plural that produces “familys,” the “candidate action” wording, chapter box/template use, selected source/example labels, and representative Java-like listings.

**Important limit:** this was not a forensic line-by-line audit of every line in all 18 LaTeX chapter files. Nor was the full XeLaTeX build rerun from the source archive. A dedicated source/build audit remains a correction-stage gate: validate all citation keys, `\label`/`\ref` pairs, macro invocations, glossary forms, figure/table/listing numbering, source labels, bibliography output and the final build log.

## 3. Primary theoretical sources checked

### CoALA — Part I

Sumers, Theodore R., Shunyu Yao, Karthik Narasimhan and Thomas L. Griffiths. “Cognitive Architectures for Language Agents.” *Transactions on Machine Learning Research*, 2024.

- OpenReview: https://openreview.net/forum?id=1i6ZCyf1QJ
- PDF: https://openreview.net/pdf/07475727a2787df12052196b9f2624497ef3c3bd.pdf
- Representative checks: information storage, action space, decision-making procedure; working/episodic/semantic/procedural memory; internal actions; grounding; planning/proposal/evaluation/selection/execution; iteration and the use of ToT/RAP as examples in the decision-process discussion.

### Fan & Lan — Part II

Fan, Haodi and Zucong Lan. “From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps.” arXiv:2607.23942v1 (2026; version 1 dated 27 July 2026).

- arXiv: https://arxiv.org/abs/2607.23942
- PDF: https://arxiv.org/pdf/2607.23942
- Representative checks: bounded frozen corpus; ten historical architecture families; eight general runtime families; forty-two mechanism-focused modern records; seven-field mechanism representation; separate E1–E4 and D0–D4 coding axes; provisional single-coder/validity boundaries; B1, B2, B3, B4 and B6 residual bundles; B5 closure through closest-baseline screening against GraSP; cross-bundle dependencies and implementation order.

### ACT-R reference used in Chapter 12

Bothell, Dan. *ACT-R 7.30+ Reference Manual*. ACT-R Research Group, Carnegie Mellon University.

- Manual: https://act-r.psy.cmu.edu/actr7.x/reference-manual.pdf
- Representative check: the activation decomposition and declarative-memory equation family (base-level, spreading activation, partial matching/noise), retrieval probability/latency and production utility. The basic ACT-R forms reviewed are broadly consistent with the manual.
- Limit: this review did not re-derive every equation or independently audit every pinpoint citation to a manual page. Add exact manual sections/pages during the correction-stage citation proof.

### GraSP reference used in Chapter 17

Xia, Tianle, et al. “GraSP: Graph-Structured Skill Compositions for LLM Agents.” arXiv:2604.17870v1 (2026).

- PDF: https://arxiv.org/pdf/2604.17870v1
- Representative check: broad correspondence of the described staged control path, typed DAG/skill execution, local repair operators and confidence-based fallback. The book's Java-like contracts remain an engineering reconstruction, not a reproduction of the original implementation.

## 4. What this review certifies—and what it does not

- **Certified for this review:** a chapter-by-chapter editorial/content assessment of the rendered Part I and Part II PDF; chapter-level duplication and safe-trim recommendations; visible PDF defects listed in the review; a targeted cross-check of important claims against the named primary sources.
- **Not certified:** exhaustive source-code review of all `.tex` lines; independent verification of every citation/footnote in the bibliography; full CI or clean XeLaTeX rebuild; exhaustive visual inspection of every figure/table at print-size resolution; final accessibility/tagged-PDF conformance; experimental reproduction of B1–B6.
- **Not part of this review:** the placeholder Part III chapters, appendices, dedication and preface, except that the outdated promise of ten framework-based Part III cases must be updated to the revised single supply-chain pilot.

## 5. Part III interpretation

CoALA and Fan & Lan remain the book's only formal theoretical foundations. CoT, ToT and RAP/MCTS can be treated as method-level prior art, implementation alternatives and experimental comparators; they must not become additional overarching theories. The pilot plan uses RAP-inspired/domain-grounded MCTS against a structured supply-chain simulator and explicitly distinguishes that adaptation from original RAP's LLM-as-world-model design.

The revised Part III baseline in this package is:

- Chapter 19 — Engineering Foundations for Request-Driven Cognitive and Agentic Systems.
- Chapter 20 — Enterprise Supply-Chain Disruption Management Agent.

The system must accept a family of supply-chain requests and support multiple execution paths. A single worked scenario is illustrative, not the fixed workflow encoded by the implementation. LangGraph4j and LangChain4j are out of scope.
