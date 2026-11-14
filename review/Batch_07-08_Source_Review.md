# Batch 07–08 source-fidelity review

**Review date:** 14 November 2026  
**Primary and only theoretical source for this batch:** Sumers, Yao, Narasimhan, and Griffiths, *Cognitive Architectures for Language Agents*, Transactions on Machine Learning Research (2024), original preprint arXiv:2309.02427.

## Primary source map

| Chapter | Planned coverage | Primary source location | Important boundary |
|---|---|---|---|
| 7 — Evaluation and Selection | Candidate values; value sources; selection methods; selection rejection | §4.6, pp. 12–13 | Evaluation assigns values; selection chooses or rejects. Do not place the reject-and-return control under evaluation. |
| 8 — Interleaving, Iteration and the Complete CoALA Decision Process | Planning/execution; flexible use of reasoning and retrieval; interleaving/iteration; candidate simulation and improvement; rejection loop; execution and next cycle | §4.6, Figure 4B, pp. 9 and 12–13 | Do not impose a universal order or schedule. Distinguish internal simulation from actual environmental observations. Preserve “an observation can be made,” not “every action produces an observation.” |

Source URL: https://openreview.net/forum?id=1i6ZCyf1QJ

## Chapter 7 claim map

- **Evaluation role:** If multiple actions are proposed, the evaluation sub-stage assigns a value to each. Source: §4.6, evaluation paragraph, pp. 12–13.
- **Value sources:** The paper names heuristic rules, LLM/perplexity values, learned values, LLM reasoning, and combinations. Source: §4.6, evaluation paragraph, p. 13.
- **Simulation during evaluation:** LLM reasoning may internally simulate possible grounding feedback. The outline distinguishes this from an actual observation received after execution. Source: §4.6, p. 13.
- **Selection role:** Given actions and their values, selection either selects one to execute or rejects the proposals and loops to proposal. Source: §4.6, selection paragraph, p. 13.
- **Selection methods:** argmax, softmax, majority vote, or another alternative depending on the form of action values. Source: §4.6, p. 13.

**Explicit teaching boundaries:** A value is not presented as a universal probability, calibrated confidence, truth value, or safety guarantee. Product X scores and criteria, if used in the eventual chapter, must be labelled as book-created illustrations. Selection is not execution, human authorization, or a complete production safety policy. Chapter 8 owns the full rejection/interleaving/iteration process.

## Chapter 8 claim map

- **Decision procedure and cycle:** The decision-making procedure is the top-level or “main” agent program, organized into decision cycles. Source: §4.6 and Figure 4B, pp. 9 and 12.
- **Planning/execution:** Planning uses reasoning and retrieval to propose and evaluate alternatives; execution applies the selected action through the agent's source-code procedures. Source: §4.6, pp. 12–13.
- **Flexible planning:** Reasoning and retrieval may be flexibly applied to proposal, evaluation, and selection; those sub-stages could interleave or iterate to build multi-step simulations before an external action. Source: §4.6, p. 12.
- **Candidate improvement:** The paper describes using the LLM to simulate candidate solutions, identify defects, and propose modifications. Source: §4.6, p. 12.
- **Rejection:** The explicit option to reject proposed actions and return to proposal is located in selection. Source: §4.6, p. 13.
- **Execution outcomes:** Execution may apply an external grounding action or an internal learning action. An observation can be made from the environment, and the cycle loops again. Source: §4.6, p. 13.

**Interpretive boundary:** The outline distinguishes “interleaving” (activities mixed/woven within planning) from “iteration” (planning activity revisited/repeated) only as a beginner-friendly teaching interpretation of the paper's wording. It explicitly avoids presenting either as a formal CoALA operator or inventing a mandatory schedule, retry threshold, iteration budget, stopping rule, or universal algorithm.

## Cross-chapter boundaries

- Chapter 6 covers candidate generation only. Chapter 7 begins when candidates exist.
- Chapter 7 covers evaluation and selection roles. Chapter 8 revisits them within the complete process.
- Chapter 8 integrates Chapters 3–7 but does not repeat their full explanations.
- Chapter 5 grounding is referenced only to distinguish internal simulation from real interaction and observations.
- Fan & Lan is not used to reinterpret CoALA. No additional theoretical foundation is introduced.
- Product X remains a book-created teaching example, not a source example or empirical result from the paper.

## Approval status and repository placement

Both outline versions are v1.0 and await explicit author approval. The editable LaTeX source and PDF are stored inside their corresponding chapter folders:

- `Tex/part1/chapter07/outline/Chapter_07_Outline_Review_v1.tex`
- `Tex/part1/chapter07/outline/Chapter_07_Outline_Review_v1.pdf`
- `Tex/part1/chapter08/outline/Chapter_08_Outline_Review_v1.tex`
- `Tex/part1/chapter08/outline/Chapter_08_Outline_Review_v1.pdf`

The chapter prose files remain placeholders. No Chapter 7 or Chapter 8 prose is authorized until each outline is approved.


## Final outline review and approval (14 November 2026)

The author approved both outline v1.0 documents after one final minor-issue review. The review reconfirmed:

- Chapter 7's distinction between evaluation and selection, and the placement of rejection/return-to-proposal under selection.
- Chapter 8's use of interleaving and iteration as careful teaching interpretations, not formal operators or a prescribed scheduling algorithm.
- The separation between simulation and actual environmental observation.
- The planning/execution distinction and the possibility that execution applies either a grounding action or a learning action.
- The use of Product X strictly as a book-created example.

The approved outlines were updated to record their approval and retained inside their corresponding chapter folders. Drafting proceeded only after the author's explicit approval.
