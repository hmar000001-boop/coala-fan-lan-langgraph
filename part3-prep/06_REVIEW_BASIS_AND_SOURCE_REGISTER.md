# Review basis, validation limits and source register

## 1. Primary book-project source archives

### Latest complete-project checkpoint inspected

- Filename: `batch09-chapter18-complete-project.zip`
- Size: 2,870,820 bytes
- SHA-256: `1638be9c6a86ee05d389cc558a0e66f87413e1fe50310d029e338d201f9b1602`
- Library path: `/batch09-chapter18-complete-project.zip`
- Library file ID: `file_000000001bf081f59b528372cedcc476`
- Contents: LaTeX source for Parts I–II, Chapter 18 integrated source checkpoint, bibliography, shared macros, diagrams/source, build scripts, glossary/index configuration, project documentation and review files. It did not contain the claimed combined 597-page `book.pdf`.

### Additional Chapters 1–11 checkpoint

- Filename: `cognitive-architectures-to-production-agents-chapters-01-11(1).zip`
- Size: 1,605,154 bytes
- SHA-256: `12b6e77df13f1cdf5acbc1f1b06b6cb86cd1025b4f4c7dd21112432e4c56789c`
- Library file ID: `file_00000000ffac81f5b9b05b7f02347f2c`

The latest Chapter 18 archive was treated as the source checkpoint for the review. The second archive was used to corroborate Chapter 1–11 content availability and version history.

## 2. Source-level checks performed

- Inspected `Tex/part1` Chapter 1 body and Chapters 2–8 chapter source.
- Inspected `Tex/part2` Chapters 9–18 chapter source.
- Inspected `Tex/shared-macros.tex`; confirmed `\FanLanCite` macro definition.
- Inspected Chapter 12 equation/objective/event model and final source note.
- Inspected Chapter 11 CLARION cross-reference.
- Inspected Chapter 15/17/18 engineering-provenance statements and Chapter 13–16 implementation bridges.
- Checked the current chapter source for the quoted "familys" and "one or more candidate action" strings; did not reproduce them.
- Checked the exact Chapter 12 `\\FanLanCite` source-note typo; reproduced.
- Counted source words in the extracted chapter files: approximately 35,253 Part I words and 95,343 Part II words by a direct source-file count. These are not the same counting method as a PDF text-extraction count.
- Counted 184 `\index{...}` commands across the extracted Part I/II chapter sources. Chapter 1, 9 and 10 have no direct index commands in their chapter bodies.
- Checked the bibliography entries for CoALA, Fan and Lan and the ACT-R reference manual.

The repository's full combined-book build was not run as a final-PDF validation. The build script requires the pinned Mermaid CLI under `tools/mermaid/node_modules/.bin/mmdc` and generated PNGs; those outputs were absent from the archive. The combined 597-page PDF was not available to render and inspect.

## 3. Primary theoretical sources checked

### CoALA

Sumers, Theodore R., Shunyu Yao, Karthik Narasimhan and Thomas L. Griffiths. “Cognitive Architectures for Language Agents.” *Transactions on Machine Learning Research*, 2024.

- Published paper: https://openreview.net/forum?id=1i6ZCyf1QJ
- PDF: https://openreview.net/pdf/07475727a2787df12052196b9f2624497ef3c3bd.pdf
- Relevant checks: the three CoALA dimensions (information storage, action space, decision-making procedure), internal/external actions, planning and execution cycle, and the paper's case-study placement of Tree of Thoughts.

### Fan and Lan

Fan, Haodi and Zucong Lan. “From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps.” arXiv:2607.23942 (version 1 submitted 27 July 2026).

- arXiv: https://arxiv.org/abs/2607.23942
- PDF: https://arxiv.org/pdf/2607.23942
- Relevant checks: bounded frozen corpus; ten historical architecture families; eight general runtime families; forty-two mechanism-focused modern records; seven-field mechanism representation; separate E1–E4 and D0–D4 coding axes; provisional single-coder/validity boundaries; B1, B2, B3, B4 and B6 residual bundles; B5 closure through closest-baseline screening against GraSP; cross-bundle dependencies and implementation order.

### Decision-procedure method references (not additional theoretical foundations)

- Wei et al. “Chain-of-Thought Prompting Elicits Reasoning in Large Language Models.” NeurIPS 2022. https://arxiv.org/abs/2201.11903
- Yao et al. “Tree of Thoughts: Deliberate Problem Solving with Large Language Models.” NeurIPS 2023. https://arxiv.org/abs/2305.10601
- Hao et al. “Reasoning with Language Model is Planning with World Model.” EMNLP 2023. https://aclanthology.org/2023.emnlp-main.507/

RAP's original proposal uses the LLM as both reasoning agent and world model, with MCTS and task-specific rewards. A production supply-chain planner that uses a structured operational simulator is an adaptation. The book must identify it as RAP-inspired/domain-grounded MCTS rather than an exact RAP reproduction.

### ACT-R reference used in Chapter 12

Bothell, Dan. *ACT-R 7.30+ Reference Manual*. ACT-R Research Group, Carnegie Mellon University. https://act-r.psy.cmu.edu/actr7.x/reference-manual.pdf

This review did not re-derive every ACT-R equation or independently audit all pinpoint citations against every manual section. Chapter 12's equations and short citations should receive a dedicated final source/citation proof before release.

## 4. What this review does not certify

- It does not certify all factual claims against every external reference in the 18 chapters.
- It does not certify all tables, diagrams or citation pinpoints visually in the final combined PDF.
- It does not certify the reported 597-page pagination or final index length.
- It does not claim an exhaustive spelling/grammar check of the entire PDF.
- It does not validate or reproduce the five residual bundles experimentally.
- It does not build or test the supply-chain pilot; the pilot plan and requirements are proposals.

## 5. Interpretation rule for Part III

CoALA and Fan and Lan remain the only formal theoretical foundations. CoT, ToT and RAP/MCTS may be used as algorithm/method references and experimental comparators. They must not be introduced as new overarching theories. Every implementation design must distinguish the mechanism described by a source from the code and policy proposed by the book.
