---
title: "Independent Review Report — Parts I and II"
subtitle: "From Cognitive Architectures to Production Agentic Systems"
author: "Independent content, editorial and technical review"
date: "16 November 2026"
toc: true
toc-depth: 2
numbersections: false
geometry: margin=0.78in
fontsize: 10pt
colorlinks: true
linkcolor: teal
urlcolor: teal
---

# Independent Review Report — Parts I and II

**Book:** *From Cognitive Architectures to Production Agentic Systems: Understanding CoALA, Fan & Lan, and Engineering Complex Agents with Java*  
**Reviewed artifact:** `book.pdf`, 597 pages, PDF dated 15 November 2026  
**Review date:** 16 November 2026  
**Scope:** Part I, Chapters 1–8; Part II, Chapters 9–18  
**Review status:** Full PDF content review completed; targeted LaTeX/source checks completed; exhaustive source-file and citation audit remains a separate correction-stage gate.

---

## 1. Executive verdict

Parts I and II are intellectually coherent and substantially stronger than a conventional feature-oriented agent book. Part I gives the reader a useful architectural vocabulary through CoALA. Part II changes the unit of analysis from a capability label to a documented mechanism and applies that discipline to historical architectures, modern runtimes and the five residual bundles. The manuscript generally distinguishes source claims from book-created examples and engineering proposals. That distinction is one of its most important strengths and should be preserved.

**I do not recommend deleting whole chapters, entire mechanism studies, or the central implementation bridges.** The manuscript's main editorial problem is cumulative repetition: the same distinction is often explained in the prose, repeated in a callout, repeated again in a “common confusions” section, and then stated once more in the chapter recap. This is especially visible in Part I and in the closing sections of several Part II chapters.

The right correction is therefore selective compression, not a blanket 20–25% cut. Retain the ideas, mechanisms, evidence, worked examples and failure analysis. Remove duplicated explanations, merge overlapping callouts, shorten repeated scenario setup, and give each summary box one clear job.

### Overall assessment

| Area | Assessment | Review conclusion |
|---|---|---|
| Part I conceptual progression | Strong | CoALA is introduced progressively and its three dimensions are developed in a sensible order. Some early descriptions repeat before the dedicated chapters deepen them. |
| Part I source fidelity | Strong, with routine verification still needed | The central descriptions of memory, internal actions, grounding, planning, evaluation, selection and iteration are broadly faithful to CoALA. |
| Part I pedagogy and length | Good, but repetitive | The reader is helped by the running example and distinctions. Some examples, boxes and boundary lists repeat without adding another layer. |
| Part II analytical method | Strong | The mechanism-level unit, seven-field representation, E1–E4 and D0–D4 distinction, bounded corpus and negative B5 case form a coherent method. |
| Part II source discipline | Strong, with specific corrections | Provenance is generally clear. Chapter 12 has a broken citation macro and some attribution/coverage ambiguity; Chapter 11 has a wrong forward reference. |
| Part II engineering bridges | Valuable and substantial | The bridges are not filler. They should be retained, but Part III must implement selected combinations rather than re-explain all the same proposed contracts. |
| Structure and callout boxes | Inconsistent | Several “takeaway” boxes duplicate the chapter recap. Chapters 14–18 drift from the opening template; Chapters 15 and 18 also use a different recap treatment. |
| Production quality | Generally sound, with small visible defects | The PDF is readable and the full-page scan did not reveal a systemic layout failure. A small set of typography, citation and template defects needs correction. |

### Main release-blocking corrections

1. Repair the literal `FanLanCite` text in Chapter 12's source note (printed p. 246).
2. Correct Chapter 11's forward reference from Chapter 16 to Chapter 15 for B4 method authority; refer to Chapter 17 where the intended topic is GraSP/skills.
3. Complete Chapter 12's B1 treatment: make the activation input explicit in the proposed objective or selector contract, account for maintenance cost or explain its distinct budget boundary, clarify the soft-penalty/hard-deadline use of latency, and add the seven-field B1 reconstruction.
4. Correct visible copy errors: “candidate action” → “candidate actions”; “familys” → “families”; the reversed opening quotation marks in Chapter 15; and sentence-start capitalization affected by glossary commands.
5. Standardize the chapter-opening and ending conventions without adding duplicate prose.
6. Label Java-like reference contracts consistently as book-authored pseudocode/contracts unless they are compiled and tested in a companion repository.
7. Update book-wide promises about ten Part III systems and framework-specific case studies to the newly chosen Part III scope: one deep, request-driven supply-chain system, implemented in Java without LangGraph4j or LangChain4j.

---

## 2. Review basis, coverage and limits

### 2.1 The artifact reviewed

The review is based on the user-provided `book.pdf`, not on the earlier preliminary review package. The PDF contains 597 pages. Part I, Chapters 1–8, occupies approximately printed pages 3–138; Part II, Chapters 9–18, occupies approximately printed pages 143–518. Part III and the back matter remain outside the substantive review scope, except where current Part III promises in front matter or Chapter 1 need to be updated.

The full PDF text was extracted and reviewed chapter by chapter. A page-thumbnail scan covered all 597 pages, with higher-resolution inspection of pages containing the Chapter 12 source-note defect, B1 equations, selected code-like listings, and the index/references transition. The PDF metadata identifies a XeLaTeX-produced document dated 15 November 2026.

### 2.2 Quantitative baseline

The counts below are approximate tokenized word counts from the PDF text, not publisher word-processor counts. They are useful for scale comparison, not as a quota for deletion.

| Chapter | Printed pages | Approx. words |
|---|---:|---:|
| 1 | 3–26 | 7,057 |
| 2 | 27–46 | 5,557 |
| 3 | 47–62 | 4,461 |
| 4 | 63–76 | 3,951 |
| 5 | 77–90 | 4,634 |
| 6 | 93–105 | 4,422 |
| 7 | 109–122 | 3,821 |
| 8 | 125–138 | 4,077 |
| **Part I** | **about 140 pages** | **about 37,980** |
| 9 | 143–158 | 4,697 |
| 10 | 159–174 | 4,446 |
| 11 | 175–210 | 11,602 |
| 12 | 213–246 | 10,365 |
| 13 | 247–283 | 10,924 |
| 14 | 285–320 | 9,235 |
| 15 | 321–372 | 13,664 |
| 16 | 373–420 | 14,253 |
| 17 | 421–472 | 14,741 |
| 18 | 473–518 | 13,167 |
| **Part II** | **about 378 pages** | **about 107,094** |

Part II is about 2.8 times the word count of Part I. This is not automatically evidence that Part II is over-written: Chapters 12–18 include detailed mechanism histories, comparative evidence, seven-field reconstructions, proposed runtime contracts, failure semantics, persistence, testing and evaluation. Those are part of the book's distinctive contribution. The problem is not simply “Part II is longer”; it is that the same definitions and conclusions are sometimes repeated inside that substantial material.

### 2.3 What was and was not verified

- **PDF content:** all 18 chapter spans were reviewed, including the chapter structure, worked examples, boxes, recaps and major technical sections.
- **PDF layout:** all pages were scanned at overview resolution; selected pages were inspected at higher resolution. This is a useful visual review, not a full accessibility or print-production certification.
- **LaTeX source:** the corresponding source archive was used for targeted verification of the broken Chapter 12 macro, glossary pluralization, chapter template/environment use, selected cross-references, and the Java-like listings. I did **not** perform a forensic line-by-line audit of every line in all 18 `.tex` files. All citation keys, labels, references, macros and build logs still need a dedicated source/CI audit during the correction phase.
- **Primary-source fidelity:** the central CoALA decision-cycle claims, the Fan & Lan mechanism framework and B1/B2/B3/B4/B5/B6 framing, the ACT-R equations used in Chapter 12, and the GraSP stages/operators were checked against the primary or official sources at representative points. This is not a claim that every footnote in all 18 chapters has been independently revalidated.

This limitation is deliberate and explicit. The report should not be read as a completed source-code or bibliography audit.

---

## 3. Cross-chapter findings: what to preserve and what to compress

### 3.1 Preserve the progressive teaching design

Several concepts recur because the book moves through different levels of explanation. These are not necessarily bad duplications:

- Chapter 1 introduces the three CoALA dimensions; Chapter 2 gives the structural map; Chapters 3–8 develop the dimensions individually. The early definitions should be shortened, not removed from the introductory chapter.
- The Product X incident appears repeatedly in Part I. That is a deliberate running example: each chapter uses it to reveal a different architectural or decision-process aspect. Keep the running example, but avoid re-stating the same incident setup in full every time.
- Chapter 10 defines the seven-field method; Chapters 12–17 apply it to individual bundles; Chapter 18 composes the results. This is a necessary progression. Keep the field analyses, but avoid copying the same explanation of the fields into each chapter's recap.
- Chapters 12–17 each have a different engineering bridge. Those bridges should remain substantial because they show what the mechanism-level analysis leaves open for implementation.

### 3.2 Remove repetition that does not add a new level

The following recurring patterns should be corrected:

1. **Prose + warning box + common-confusions section + recap:** where all four repeat the same distinction, keep the explanation in the prose and one compact reminder at most.
2. **Takeaway box + chapter recap:** a takeaway box that merely paraphrases the recap should be deleted or merged into the recap. The reader does not need two consecutive summaries of the same claim.
3. **Repeated full scenario setup:** introduce a scenario briefly, then reserve the full step-by-step execution for the designated worked-example section.
4. **Repeated source-boundary disclaimers:** preserve source fidelity, but state the boundary clearly once per relevant section/chapter and label engineering proposals locally. Do not repeat “the paper does not prescribe…” after every example when the same point is already clear.
5. **Duplicated summary tables:** keep both tables only when they answer different questions (for example, historical architecture families versus migration depth). If a table merely restates the immediately preceding narrative and is restated again in the recap, keep the most useful representation.

### 3.3 Recommended box policy

I do **not** recommend deleting all end-of-chapter boxes. They serve different purposes, but should not all repeat the same idea.

- Keep one concise chapter recap per chapter, whether styled as a shared recap box or as a consistent plain section.
- Keep review questions and practical exercises; where they are split into adjacent boxes, combine them into one block with subheadings rather than removing the exercise content.
- Keep warning boxes for consequential distinctions (external effects, authorization, uncertainty, failure, exactly-once claims, source limits) when the warning adds a risk the surrounding prose does not already state.
- Remove standalone takeaway boxes when the chapter recap says the same thing. This is the safest and most consistent box-level reduction across the manuscript.
- Remove note boxes whose only content is a definition repeated directly above or below. Integrate the sentence into the prose instead.
- Keep source/example notes: they are provenance controls, not decorative summaries. Make them concise and accurate.
- Standardize the opening: a short “Chapter at a glance” plus a learning-objective block. A learning objective is not a substitute for a chapter overview, and vice versa.

---

## 4. Chapter-by-chapter review and safe deletion/merge recommendations

The actions below are deliberately conservative. “Delete” means remove a duplicated presentation while preserving the concept in the main text or recap. “Merge” means retain the idea once in the clearest location. No chapter is recommended for deletion.

### Chapter 1 — Why Do Language Agents Need Cognitive Architectures? (pp. 3–26)

**Keep:** the motivating distinction between a model call, a sequence of calls, an agent interacting with an environment, and a cognitive agent that also manages internal information; the production-system history; the Product X incident; the first introduction to CoALA.

**Safe trims:**
- **§§1.1–1.2:** shorten the repeated explanation of model output, external action and observation. Let §1.1 establish the problem; let §1.2 show the progression between system types without re-defining the same terms in full.
- **§1.6.4 and §1.7:** these both turn the incident into the three architectural questions and then answer them. Keep the question-to-dimension mapping, but compress §1.7.1–1.7.4 to a short preview table. Chapter 2 is the place for the full architectural explanation.
- **§1.8.2:** shorten the list of what CoALA does not prescribe. Several of these cautions recur in Chapter 2 and the dedicated memory/action chapters. Keep the four or five boundaries most important to understanding the framework.
- **§1.9:** retain the handoff, but avoid repeating the full table of contents in prose.

**Boxes:** keep the warning/tip that a generated action description is not yet an executed action; it is a useful authority boundary. Keep one recap. Chapter 1 has no review-question block; adding a small set is optional, not a release blocker.

**Book-wide update:** §1.8.3 and the “How to Read This Book” page currently promise ten Part III case studies and framework-based examples. Those promises must be rewritten to match the new Part III decision: one deep, request-driven supply-chain implementation, Java-only and framework-independent.

**Indicative safe trim:** about 5–8%, mainly from duplicated explanation, not from the historical bridge or running example.

### Chapter 2 — The Architecture of CoALA (pp. 27–46)

**Keep:** the structural map, the relationship between working and long-term memory, the internal/external action boundary, the main decision procedure, and the illustration of how the components connect.

**Safe trims:**
- **§2.2 versus §§2.3–2.6:** use §2.2 as a compact map of the three dimensions. Avoid fully explaining each dimension there and then explaining it again in the detailed sections.
- **§2.4:** merge the repeated “memory’s place in the architecture” explanation into §§2.3.2–2.3.3. The structural map already introduces working and long-term memory; preserve only the additional relationship that is not already explained.
- **§2.7:** keep the complete architectural reading of Product X, but convert repeated narrative into a concise three-dimension mapping table. The incident itself was already introduced in §1.6.
- **§2.9:** shorten the common-misreadings list to architecture-specific misconceptions. Do not restate all the boundaries already listed in §1.8.2 or those reserved for Chapters 3–5.
- **§2.10:** reduce the chapter roadmap to a short handoff; the contents page already supplies the full sequence.

**Boxes:** remove both takeaway boxes: the first paraphrases the three-dimension definition, and the second restates the conclusion of the Product X architectural example. Both ideas remain in the body and recap. Keep the diagram-reading tip. The database/schema warning can remain once; the warning about not importing Fan & Lan into CoALA can be moved to a short Part I/II boundary note rather than repeated as a chapter box. The working-memory/context-window note can be absorbed into §2.3 and developed fully in Chapter 3.

**Indicative safe trim:** about 8–12%.

### Chapter 3 — Understanding Memory (pp. 47–62)

**Keep:** the four memory categories and the way working memory interacts with episodic, semantic and procedural memory. This is a core CoALA chapter and should not be shortened by removing any memory type.

**Safe trims:**
- **§3.1.1:** keep the definitive explanation that a prompt is input to a model call, not the whole memory architecture. Shorten the previews of this idea in Chapters 1 and 2 instead of weakening this section.
- **§3.8:** condense the “what the taxonomy does not decide” list to a short paragraph. Similar implementation-boundary disclaimers appear in Chapters 1 and 2.
- Keep §3.7's cooperation example; it adds a useful integrated view rather than merely repeating the taxonomy.

**Boxes:** remove the takeaway box that repeats the prompt/working-memory distinction already explained in §3.1.1 and again in the recap. Keep the procedural-memory warning because it addresses a distinct risk: procedural changes can be unsafe and are not ordinary automatic learning. The diagram note may be shortened if the diagram caption already identifies it as a book-created redraw.

**Indicative safe trim:** about 5–8%.

### Chapter 4 — Internal Actions: Retrieval, Reasoning and Learning (pp. 63–76)

**Keep:** the retrieve/reason/learn distinction, the difference between retrieving information and using it, and the distinct ways episodic, semantic, model-parameter and explicit procedural knowledge may be updated.

**Safe trims:**
- **§4.6:** retain the diagnostic distinctions, but compress them into a short table. Several items restate definitions already fully developed in §§4.2–4.4.
- **§4.5:** keep the synthesis, but avoid repeating every step already explained in the worked example and diagram.
- Shorten the Chapter 3 callback about procedural memory; Chapter 4 is the detailed explanation.

**Boxes:** keep the retrieval diagnostic tip. Keep the warning not to collapse learning into fine-tuning. Remove the note “reasoning does not automatically persist” as a standalone box; integrate the same sentence into §4.3 or §4.4, where it belongs, because the text already explains that working-memory output is not automatically written to long-term memory.

**Indicative safe trim:** about 5–7%.

### Chapter 5 — External Actions and Grounding (pp. 77–90)

**Keep:** grounding as external action plus environmental feedback; the distinction among physical environments, dialogue, and digital environments; and the explanation that observations enter the agent's working information.

**Safe trims:**
- **§5.2 and the four-part note box:** the prose already explains environment, procedure, action and observation. Remove the note box and retain the definitions in the body.
- **§5.9:** this common-confusions section repeats many distinctions from §§5.1–5.8. Reduce it to the genuinely useful contrasts: action versus observation, procedure versus environment, internal processing versus external dialogue, and available action versus authorized action.
- **§5.7:** retain the grounding walkthrough, but avoid re-telling the full incident chronology already established in Part I.
- Keep the physical, dialogue and digital examples; they demonstrate genuinely different external environments.

**Boxes:** keep the grounding/action classification tip and the safety warning. The warning is important and should not be removed; instead, avoid restating the same safety caveat in the body, §5.9 and the recap.

**Indicative safe trim:** about 8–12%.

### Chapter 6 — Planning: From a Problem to Candidate Actions (pp. 93–105)

**Keep:** candidate actions, proposal, reasoning with optional retrieval, enumeration of small action sets, and structured program/simulator-based proposal. These are the key ways this chapter develops CoALA's proposal sub-stage.

**Safe trims:**
- **§6.4.2 and §6.7:** both revisit the Product X candidate set. Keep §6.7 as the complete walkthrough; reduce §6.4.2 to a short preview of the candidate categories.
- **§6.8:** reduce the common-confusions section because the “candidate is not selected/approved/executed” point is already repeated in the tip and warning boxes.
- The detailed overview of later evaluation/selection stages should remain a short handoff; Chapter 7 owns those topics.

**Boxes:** combine the tip and warning about a candidate not being a decision into one compact callout. The note that this chapter only locates proposal can be reduced to a sentence in §6.2; it does not need a separate box if the handoff is already explicit.

**Copy edit:** “one or more candidate action” should be “one or more candidate actions” (printed p. 93).

**Indicative safe trim:** about 8–12%.

### Chapter 7 — Evaluation and Selection (pp. 109–122)

**Keep:** the difference between assigning values and selecting what happens next; the range of value sources; the three selection methods named in CoALA; and the Product X numerical illustration.

**Useful addition:** include the standard softmax equation and a very small numerical example. CoALA names softmax as a selection method; the equation would be the book's mathematical explanation, not a claim that CoALA prescribes a specific implementation. This is a better programmer-oriented improvement than adding a large code block to Part I.

**Safe trims:**
- **§7.8:** reduce common confusions that repeat §7.4, the numerical-example warning, and the chapter recap.
- The second warning (“largest illustrative value” does not mean safest/most accurate) can be merged into the note that values have no universal scale.
- The note about rejection outcomes repeats the explanation in §7.5; remove it as a separate box.

**Boxes:** delete the takeaway box because the chapter recap already states the evaluation/selection distinction. Keep one note explaining that values are not universally calibrated and one warning distinguishing simulated outcomes from actual environmental observations.

**Indicative safe trim:** about 7–10%, with the equation as a small addition.

### Chapter 8 — Interleaving, Iteration and the Complete CoALA Decision Process (pp. 125–138)

**Keep:** the distinction between planning and execution, the flexible role of reasoning and retrieval, the difference between interleaving and iteration, simulation, rejected proposals, and the multi-cycle Product X walkthrough. This is the capstone of Part I and should remain.

**Safe trims:**
- **§§8.1–8.2:** combine the overlapping introductory explanation of the cycle into one concise orientation.
- **§8.9:** reduce the common-misreadings list; several points have already been made in Chapters 6 and 7.
- Review the overview/cycle diagrams for duplication. Retain one high-level cycle diagram and the multi-cycle worked trace; combine any second overview diagram that does not add new control information.
- The Product X walkthrough should carry the full example; the opening should not repeat the same chronology in detail.

**Boxes:** remove the takeaway box because the recap already summarizes the process. Keep the note distinguishing internal actions from planning sub-stages, but do not repeat the same point again in §8.9. Keep a single source-boundary warning for the illustrative sequence; the separate warning that the Product X observations are invented can be shortened to the source/example note.

**Indicative safe trim:** about 7–10%.

### Chapter 9 — Why Feature-Level Descriptions Are Not Enough (pp. 143–158)

**Keep:** the feature-versus-mechanism distinction, the state/trigger/control/transition chain, the difference among similarity, lineage and migration depth, and the explanation of the bounded review.

**Safe trims:**
- **§9.7 and §9.9:** keep §9.7 as the authoritative scope/validity statement. Reduce §9.9 to a short handoff and only the misconceptions not already covered.
- The limitation that corpus counts do not estimate field prevalence appears in §9.7, the warning box, the source note and the recap. Keep it fully in §9.7 and shorten the other repetitions.

**Boxes:** remove the takeaway box; the chapter thesis and recap already say not to compare labels without documented operations. Keep the notebox about searchable stores and ACT-R because it clarifies a specific example. The warning box can be integrated into §9.7 rather than repeating its limitations.

**Indicative safe trim:** about 6–8%.

### Chapter 10 — The Seven Fields of a Mechanism (pp. 159–174)

**Keep:** all seven fields and the distinctions among unknown, absent and not applicable. This is a core method chapter; do not remove fields or collapse them into a generic checklist.

**Safe trims:**
- **§10.13:** reduce common misreadings that repeat §10.10 (fields are related, not a universal sequence) and §10.11 (unknown/absent/not applicable). Keep only the unique comparison-claim reminders.
- Keep the ACT-R worked reading and the transition from field extraction to a comparison claim; they perform different teaching jobs.

**Boxes:** retain the concise state-versus-control distinction, because it is especially useful. Remove the second takeaway box if the recap is retained; it repeats the purpose and contents of a seven-field record.

**Indicative safe trim:** about 5–8%.

### Chapter 11 — From Historical Cognitive Architectures to Modern Agents (pp. 175–210)

**Keep:** the layered corpus, ten historical families, eight general runtime families, forty-two mechanism-focused modern records, the four evidence relations, the five migration-depth codes, and the worked evidence packets. The chapter is long because it carries the comparative evidence base for Part II; deleting the catalog would weaken the book.

**Safe trims:**
- **§§11.11–11.12:** retain the source's validity limits in §11.11 and shorten §11.12 to a compact list of the few common misreadings not already covered. Corpus bounds, provisional coding and non-causal interpretation are currently repeated.
- Keep §11.3.5 and §11.10 only if their tables remain distinct: one should summarize historical mechanism families; the other should summarize the migration landscape. If they repeat the same family descriptions, shorten the narrative and keep the two different analytical views.
- Do not remove the distinction among corpus H, M-A, M-B and explicit bridge cases; these layers prevent count and evidence confusion.

**Boxes and corrections:** the takeaway “compare documented operations, not labels” repeats Chapters 9–10 and the recap; remove it. Keep the warnings on bounded residuals and runtime interfaces not proving historical mechanisms. Correct the sentence that says Chapter 16 will revisit skill/method authority: B4 is Chapter 15; GraSP/skills are Chapter 17. Correct the glossary-generated plural “familys” to “families” (printed p. 178).

**Indicative safe trim:** about 4–6%; most of this chapter's length is substantive evidence rather than repetition.

### Chapter 12 — Understanding Activation, Retrieval Latency and Utility: B1 (pp. 213–246)

**Keep:** the ACT-R account, the difference between activation and downstream action value, the modern memory comparisons, the four B1 signals, the proposed context-selection integration, the event/record contracts, and the evaluation design.

**Required technical corrections:**
- **B1 objective:** the proposed $\hat{V}$ objective does not expose activation as an explicit input, even though the text says activation may estimate accessibility. Make the dependency explicit in the notation or selector contract (for example, state that the value estimate is conditioned on the activation/accessibility signal).
- **Maintenance cost:** the objective subtracts retrieval, context and latency costs but has no explicit maintenance-cost term. The prose assigns maintenance to long-horizon admission/maintenance budgets. That separation may be defensible, but B1 is framed as a joint coupling of activation, predicted retrieval latency, downstream utility and maintenance cost. State precisely whether maintenance cost enters as a per-item penalty, an amortized term, or a hard lifecycle budget—and show how the B1 coupling is still tested.
- **Latency twice:** a soft latency penalty and a hard deadline can coexist, but the text must say why: one ranks feasible sets by marginal latency cost; the other removes deadline-infeasible sets. Without that distinction, readers may infer accidental double counting.
- **Seven fields:** add a concise B1 S/C/T/P/F/L/R reconstruction, with unknown/absent/not-applicable distinctions where the paper leaves an item unspecified. Chapters 13–17 do this; Chapter 12 is the visible omission.
- **Attribution:** sections comparing Generative Agents, MemoryBank, MemoryOS, Chen & Cheng, Zep/Graphiti, HippoRAG and MMR need a clear label identifying which are book-added supplementary comparisons and which belong to Fan & Lan's frozen B1 baseline/corpus. Do not imply all supplementary systems are among the forty-two M-B records unless the paper's table/corpus explicitly supports that mapping.

**Source/build defect:** the source note prints the literal text `FanLanCite§ V-A; …` (printed p. 246). Repair the macro invocation; this is a visible citation defect, not merely a source-file concern.

**Safe trims:** compress the supplementary modern-system comparisons into a compact comparison table where several subsections make the same point about the decision each system takes. Keep comparisons that reveal a different lifecycle decision. Remove both takeaway boxes if the body and recap already state the three memory-lifecycle decisions and the limit of ACT-R activation.

**Indicative safe trim:** about 7–10%, excluding the small B1 completeness additions.

### Chapter 13 — Understanding Typed Impasses, Substates and Compilation: B2 (pp. 247–283)

**Keep:** the Soar source mechanism, the typed impasse distinctions, parent/substate relation, typed result semantics, chunking, the modern runtime hypothesis, the implementation contracts, failure modes and evaluation. This is one of the strongest theory-to-practice bridges in the manuscript.

**Safe trims:**
- **§13.5 versus §13.6:** both explain the same five-step B2 composition (classify, preserve parent, open bounded recovery, return typed result, compile guarded knowledge). Keep §13.5 as a short conceptual mapping and let §13.6 own the full component/state/persistence design. Remove the duplicated prose after the five-step summary.
- Keep §13.7's worked example; it demonstrates how the contract behaves in a concrete execution and is not interchangeable with the architecture section.
- Shorten §13.11 if it repeats all the failure/authority limitations already stated in §13.9.

**Boxes:** remove the takeaway box if the recap remains; the recap already explains why typed recovery is more than retry. Keep warnings about external side effects and causal evaluation; these are distinct safeguards.

**Indicative safe trim:** about 6–9%.

### Chapter 14 — Content Competition, Workspace and Broadcast: B3 (pp. 285–320)

**Keep:** the LIDA mechanism, its difference from blackboard control, modern comparisons, the definition of what competes, seven-field analysis, worked example, workspace subsystem, broadcast semantics and evaluation. The distinction between LIDA's codelet coalitions and the book's typed content coalitions is valuable and should remain explicit.

**Safe trims:**
- The first “central question” notebox repeats the chapter opening and B3 framing. Remove the box or reduce the opening to one question, not both.
- Keep the second note that no canonical B3 score is given; it prevents a book-authored score from being mistaken for Fan & Lan's formula.
- Reduce repeated B1/B3/B5 boundary explanations in §14.2 and §14.11; give the full distinction once, then cross-reference it.

**Boxes/template:** remove the takeaway box “LIDA supplies a historical mechanism…” because the same content is restated in the body and recap. The chapter-opening learning objective is not formatted consistently with neighboring chapters; standardize it without adding more prose. Combine the adjacent “Review questions” and “Practical exercises” blocks into one block with two subheadings, preserving all exercise content.

**Indicative safe trim:** about 5–8%.

### Chapter 15 — Persistent Intentions, Reconsideration and Method Authority: B4 (pp. 321–372)

**Keep:** BDI intentions, commitment policies, reconsideration schedules, MIDCA's method-level control, the seven-field reconstruction, the Product X method-switch example, the reference subsystem, failure semantics and tests. This is the most extensive B4 bridge and it is justified by the complexity of persistence and authority.

**Safe trims:**
- **§15.1 versus §15.8:** the opening Product X timeout/method-switch setup is repeated in a much fuller worked example in §15.8. Compress §15.1 to a short motivating problem statement and let §15.8 carry the full execution trace.
- **§15.3.5, §15.5.3 and §15.8:** “intention is not one plan” and “preserve goal/change method” are repeated. Keep the theoretical definition in §15.3.5, the authority analysis in §15.5.3, and the full applied trace in §15.8; shorten repeated definitions in between.
- Keep the reference subsystem in §15.9; do not cut its typed contracts and transition model merely because they are lengthy. They are the practical bridge.

**Boxes/template:** merge the “design principle” takeaway into the chapter recap rather than presenting two summaries. The review questions and practical exercises can share one enclosing block with subheadings. The chapter lacks a “Chapter at a glance” overview; add a short overview distinct from the learning objectives. Several book-created contracts/examples need clearer local attribution markers even though the chapter-level source note identifies the engineering proposal.

**Indicative safe trim:** about 8–12%, mainly from repeated scenario setup and repeated goal/method definitions.

### Chapter 16 — Uncertainty, Resources, Interruption and Stopping: B6 (pp. 373–420)

**Keep:** EPIC and Sigma, uncertainty-bearing state, resource governance, interruption, stopping, authorization boundaries, the reference subsystem and the failure/evaluation design. The distinctions among uncertainty, resource policy, and authority are especially valuable.

**Safe trims:**
- **Opening scenario versus later worked trace:** the introductory incident is explained in detail and the chapter later provides a more complete Product X operational trace. Compress the opening to a one-page problem statement; let the later example carry the implementation sequence.
- **§16.2 and §16.7:** keep the paper's B6 residual description and the seven-field reconstruction, but avoid repeating the same coupling list in full in both places.
- The “central problem” notebox repeats the opening question; integrate its sentence into the opening and remove the box.

**Boxes:** keep the tip about uncertainty propagation. Keep the warnings that calibration is not authorization and local idempotency does not guarantee exactly-once remote effects; they are distinct and important. The E3/D3 warning is also useful but should appear once, not be repeated in the recap. Add a short “Chapter at a glance” paragraph while retaining the learning objectives.

**Indicative safe trim:** about 6–9%.

### Chapter 17 — The Closed Candidate B5 and GraSP (pp. 421–472)

**Keep:** the negative-case reasoning, GraSP's memory-conditioned retrieval, typed DAG compilation, verified execution, the five repair operators, confidence-based fallback, comparison against the B5 residual and the explicit evidence limitations. This chapter provides an important example of how a candidate bundle can be closed within a bounded review without claiming universal completeness.

**Safe trims:**
- The “what the worked example does not show” subsection overlaps the later “conclusions that must remain separate.” Keep the more rigorous evaluation/conclusion section and shorten the worked-example caveat to one sentence.
- The evaluation, boundary/handoff and recap sections repeat that closure is conditional on the frozen corpus. State the limitation fully once in the evaluation/validity section, then use a short recap reminder.
- Keep the distinction between GraSP's original mechanism and the book's Java-like reconstruction; do not delete this provenance boundary.

**Template/boxes:** the title-page heading says “Learning Objective” but the content is “Chapter at a glance”; the actual learning objectives appear later in §17.1.1. Move the glance to the glance heading and place the true learning outcomes at the start. Keep the bounded-safety warning and the note explaining the negative-case scope.

**Indicative safe trim:** about 8–12%, primarily from repeated limitations and repeated explanation of the worked example.

### Chapter 18 — How the Mechanisms Work Together (pp. 473–518)

**Keep:** the cross-bundle dependency model, authority matrix, implementation order, bounded synthesis runtime, contracts, Product X composition example, failure analysis, evaluation and the limits of what Part II establishes. This chapter should remain a substantive synthesis, not be reduced to a short recap.

**Safe trims:**
- **§18.1 and Table 18.1:** the opening prose describes the five residual bundles and B5 closure, then the table describes them again. Keep the table as the compact map and reduce the surrounding prose to a short framing paragraph.
- **§§18.2–18.3:** the shared-state/authority distinction and the responsibility matrix are valuable. Keep the matrix; shorten the following boundary explanations where they merely repeat the same owner/transition statements. Retain the difficult, non-obvious conflicts.
- **§§18.4–18.7:** dependencies, implementation order, runtime model and contracts are distinct layers; keep all four. Remove repeated sentences where the same dependency or authority rule is restated in both the runtime model and the contract invariants.
- Keep the full worked composition in §18.8 and the failure/evaluation sections. Do not replace them with a diagram-only summary.
- **§§18.12–18.13:** the synthesis conclusion, the “useful output of Part II” takeaway and the chapter recap repeat the same outcome. Keep the substantive synthesis and one recap; remove the standalone takeaway box.

**Template:** add a concise “Chapter at a glance” distinct from the learning objectives. The chapter recap is not using the same recap-box treatment as most neighboring chapters; standardize the visual form without adding another summary.

**Indicative safe trim:** about 8–12%.

---

## 5. Triage of the supplied draft review report

The labels below evaluate the supplied report's findings against the PDF and the targeted source checks. “Correct” means the defect is confirmed. “Partial” means the concern is real but overstated, incomplete or dependent on interpretation. “Incorrect” means the proposed defect is not supported by the artifact.

### High priority findings

**H1 — Correct.** Printed p. 246 shows the literal `FanLanCite§...` rather than a citation. The source uses a broken macro invocation. Repair it and ensure the citation appears as a real footnote. The source-note prose itself should remain.

**H2 — Partial.** The objective does not show activation as an explicit variable, although the prose says the value estimator may use activation/accessibility. Maintenance cost is explicitly assigned to long-horizon admission/maintenance budgets rather than the per-query objective. That may be a defensible design choice, but the B1 integration is not clear enough: make activation and maintenance accounting explicit in the equations/contracts and tests. The soft latency penalty and hard deadline are not automatically inconsistent; explain their different roles.

**H3 — Correct.** Chapter 12 has no explicit seven-field B1 reconstruction comparable to Chapters 13–17. Add a concise S/C/T/P/F/L/R record and preserve unknown/absent/not-applicable distinctions.

**H4 — Partial.** The concern about attribution boundaries is legitimate. Chapter 12 includes supplementary memory comparisons beyond the Fan & Lan M-B baseline list. However, a supplementary comparison is not automatically a false corpus claim. Label which systems belong to the frozen B1 baseline and which are book-added comparators; update the source note so the distinction cannot be missed.

**H5 — Correct.** The CLARION passage in Chapter 11 points to Chapter 16 for skill/method authority. B4 is Chapter 15; GraSP/skill governance is Chapter 17. Correct the forward reference according to the intended topic.

**H6 — Partial.** Inline `[BOOK EXAMPLE]` / `[ENGINEERING DECISION]` markers are uneven in Chapters 15, 17 and 18. However, these chapters also contain chapter-level source/example notes and explicit prose that identifies proposals. Do not claim there is no attribution. Improve local attribution on the specific Java-like contracts and worked examples where source and engineering synthesis could be confused.

### Medium priority findings

**M1 — Partial.** There is real template drift. Chapters 15, 16 and 18 lack a distinct “Chapter at a glance”; Chapter 17 places glance content under “Learning Objective” while its actual outcomes appear later; Chapter 14's learning objective is not formatted like the others. Chapters 9–11 do have handoff content even without a separate “Looking ahead” heading. Chapter 1's missing review questions are optional, not a defect. Standardize only what improves reader orientation.

**M2 — Incorrect.** The source references are explicitly marked as CoALA citations (for example, `\CoALACite{\S 4.6...}` and `[CoALA] See ... §4.6`). The book's own §4.6 is not a real ambiguity in those citations. A uniform “CoALA §4.6” prose style is fine, but this is not a defect.

**M3 — Partial.** “Deployment 4.7” appears repeatedly in the Product X example (pp. 41, 47, 51, 63 and 68). The context suggests a release/version, but the form is awkward. Change to “deployment v4.7” or “release 4.7.”

**M4 — Partial.** Part I does not include a softmax equation or decision-loop code. The equation is a useful addition for a programmer audience, especially in §7.6. It is not a source-fidelity defect because CoALA names softmax but does not prescribe the book's specific equation/code. Add a short formula and numeric example; a longer pseudocode loop is optional and should be clearly marked as a book example. Do not turn Part I into a Java implementation tutorial.

**M5 — Partial.** Repetition exists, especially in repeated distinctions and callout boxes. The report's global 20–25% cut estimate is not established. My chapter-level assessment supports selective compression, not an across-the-board cut. A provisional 7–10% reduction across Parts I–II is a safer planning estimate; individual chapters vary.

**M6 — Partial.** The Java-like listings are not consistently compilable programs, and some names (for example, `VerificationRule`) are not defined in the same listing. Several are explicitly reference contracts or pseudocode, not standalone code. Standardize captions to say “illustrative Java-like contract/pseudocode—not a complete compilable program.” Actual compiled implementations belong in Part III's companion repository.

**M7 — Correct.** Part II already includes extensive engineering bridges: state machines, component contracts, persistence, concurrency, recovery, test designs and evaluation. Part III must not repeat those as another theoretical design exercise. It should implement and integrate selected mechanisms in a complete supply-chain system, then explain the real code and operational evidence.

**M8 — Partial.** Chapters 15–18 are long, but their second halves contain substantive engineering proposals and evaluation detail. The issue is repeated setup, repeated authority explanations and multiple summary layers, not simply that the chapters exceed 10,000 words. Preserve the unique bridge material and trim the specific duplications listed above.

### Low priority findings

**L1 — Correct, with a full copy-edit still needed.** Visible examples include a reversed opening quotation mark before “the payment request” (printed p. 326), the malformed single-quote pair around `main` (printed p. 39), a sentence-start “grounding procedures” (printed p. 34), and a sentence-start “beliefs represent” (printed p. 325) that should be capitalized. The broader list of lowercase sentence starts and quote inconsistencies should be checked in a dedicated copy-edit pass; not every example in the draft report was independently counted.

**L2 — Correct.** “One or more candidate action” should be “one or more candidate actions” (printed p. 93). “General runtime familys” should be “general runtime families” (printed p. 178). The latter likely comes from automatic glossary pluralization and should be fixed in the glossary entry.

**L3 — Incorrect.** “Fan and Lan” in prose and the formal label “[Fan & Lan]” are not inherently inconsistent; they serve different grammatical/citation roles. Standardize bibliography keys and formal labels, but do not mechanically replace normal prose.

**L4 — Partial.** Repeated short-form “Bothell, see n. 4” citations are valid short citations. More precise manual sections/pages would improve traceability for the ACT-R equations, but this is a citation-quality improvement rather than a demonstrated factual error.

**L5 — Correct.** The Fan & Lan bibliography rendering “In: (2026)” is incomplete/incorrect for an arXiv preprint. Render it explicitly as an arXiv preprint with identifier `arXiv:2607.23942` and version/date.

**L6 — Partial / mostly incorrect.** The blank PDF page 590 is consistent with a two-sided, open-right book layout: the references begin on the following recto page. It is not a defect. A three-page index may be expanded in the final book, but the current draft's index cannot be judged incomplete solely by page count. Glossary → index → references is an acceptable order; it is not intrinsically wrong.

## 6. Source-fidelity review

### 6.1 Part I — CoALA

The book's central CoALA interpretation is sound. The core architecture remains information storage, action space and decision-making procedure. The memory taxonomy and internal-action distinctions are treated as conceptual categories rather than being equated with particular databases or APIs. Grounding is correctly treated as external action plus environmental feedback. Chapters 6–8 preserve the important separation among proposal, evaluation, selection and execution.

The book also correctly treats reasoning and retrieval as possible supports within planning rather than forcing a rigid universal sequence. Its explanation that the decision process can revisit planning, use internal simulation and continue after new observations is consistent with CoALA's flexible decision procedure. The examples of argmax, softmax and majority vote are presented as selection possibilities, not as a single mandatory algorithm.

No major CoALA misattribution was found in the sampled primary-source checks. The main recommendation is pedagogical: add a concise softmax formula and numerical illustration, explicitly marked as the book's mathematical explanation. Keep the distinction between CoALA's framework and the implementation choices made later.

### 6.2 Part II — Fan & Lan

The seven-field method (S/C/T/P/F/L/R), the separation of evidence relation (E1–E4) from migration depth (D0–D4), and the bounded mapping-review limitations are handled carefully. The manuscript does not collapse the two axes into a single score. The reported layers (ten historical architecture families, eight general runtime families, forty-two mechanism-focused records, and explicit bridges) are internally coherent in the PDF; the forty-two subtotal is consistent with the chapter's table breakdown.

The book's treatment of B1, B2, B3, B4 and B6 as five residual bundles, with B5/GraSP treated as a closed candidate within the paper's bounded corpus, is a useful and appropriately qualified reading. The manuscript also correctly avoids treating a shared feature label, an API boundary or a product interface as proof that a historical mechanism has migrated.

The material needing correction is concentrated in Chapter 12's B1 equation/field coverage and the Chapter 11 forward reference. The additional Chapter 12 memory-system comparisons should be explicitly separated from the frozen corpus. This is an attribution clarity problem, not proof that the comparisons themselves are invalid.

### 6.3 ACT-R and GraSP checks

The ACT-R equation forms reviewed in Chapter 12 are broadly consistent with the ACT-R 7.30+ declarative-memory account: base-level activation, spreading activation, partial matching/noise, activation-dependent retrieval probability and retrieval latency. The manual's declarative-memory section places activation/base-level/spreading/partial matching/noise and retrieval-time treatment in the relevant sections. The remaining Chapter 12 problem is not the basic ACT-R equation family; it is whether the *book's B1 integration objective* actually accounts for all four B1 signals.

The Chapter 17 account of GraSP's four stages and five typed local-repair operators is consistent with the referenced GraSP v1 paper at the broad mechanism level. The chapter should keep distinguishing the paper's mechanism from the book's proposed Java-like representation; a reference contract is not a reproduction of the original system.

---

## 7. Part II / Part III boundary after the revised project decision

The original PDF promises ten framework-oriented Part III case studies. That promise is now obsolete because the author has chosen to begin with one deep supply-chain use case and has excluded LangGraph4j and LangChain4j from the implementation scope.

The front matter (“How to Read This Book”), Chapter 1 §1.8.3, the old Part III TOC, the companion-repository description and the dependency/framework references must be revised before Part III is drafted. This is a scope revision, not a criticism of the old PDF's internal consistency at the time it was built.

The revised relationship should be:

- **Part I:** teach CoALA's architecture and decision process.
- **Part II:** analyze Fan & Lan's mechanisms, their evidence, historical lineages and proposed engineering bridges.
- **Part III, Chapter 19:** establish the Java engineering foundation and show how the Part I/II concepts become implementation responsibilities.
- **Part III, Chapter 20:** implement one generic, request-driven supply-chain disruption management system that accepts many valid requests and follows different paths, rather than executing one predefined story.

Part III should not re-teach the full B1–B6 theory or reproduce each Part II reference subsystem in prose. It should select the mechanisms that are genuinely useful in the supply-chain domain, implement them in a coherent application, compile/test the code, and show how the mechanisms cooperate under multiple requests, changes, failures and interruptions.

---

## 8. Recommended correction order

### P0 — Correct before any Part III implementation

1. Repair Chapter 12's `\FanLanCite` invocation and verify the rendered source note.
2. Correct the Chapter 11 forward reference (Chapter 16 → Chapter 15/17 as appropriate).
3. Complete Chapter 12's B1 treatment: activation input, maintenance-cost boundary, latency objective/constraint distinction, and seven-field record.
4. Correct the confirmed grammar/glossary/quotation defects (`candidate actions`, `families`, Chapter 15 opening quote and sentence-start capitalization).
5. Update book-wide Part III promises and TOC to the one-system, framework-independent scope.

### P1 — Editorial compression and consistency

1. Remove duplicated takeaway boxes listed in the chapter-by-chapter review.
2. Merge repeated “common confusions” lists with the chapter recap where they contain no new distinction.
3. Shorten repeated Product X scenario setup while preserving the full designated worked example.
4. Standardize chapter-opening structure and recap presentation.
5. Standardize Java-like listing captions as pseudocode/reference contracts unless actual code is compiled in the repository.
6. Make local source/engineering labels consistent in Chapters 15, 17 and 18.

### P2 — Copy-edit and publication preparation

1. Run a full capitalization, quotation-mark, punctuation and glossary pluralization pass.
2. Correct the Fan & Lan bibliography entry and add precise ACT-R manual page/section references.
3. Revisit the index after Part III and the final bibliography are complete.
4. Run a full LaTeX source audit: all labels/refs, citation keys, macro calls, glossary entries, list/table/figure numbering and build log warnings.
5. Rebuild the book and inspect the newly generated PDF after corrections.

---

## 9. Length recommendation

The supplied review's 20–25% cut estimate should not be adopted as a target. My conservative estimate from the identified duplicate blocks is approximately **7–10% selective compression across Parts I and II**, with the largest reductions in Chapters 2, 5–8, 12, 15, 17 and 18. That estimate is indicative; the corrections should be driven by whether the idea is already fully present elsewhere, not by a word quota.

There is a separate planning issue: the original target was approximately 400 pages, but this PDF is already 597 pages while Part III remains placeholder material. Parts I and II alone occupy roughly 518 printed pages. The 400-page target is therefore no longer a realistic constraint for the current manuscript. Do not remove good material just to meet that superseded number. Revisit the book-length target after the Chapter 19 and supply-chain Chapter 20 outlines are approved; decide whether the book should be longer or split into volumes.

---

## 10. Final conclusion

The book does not need a conceptual rewrite. It needs a careful editorial correction pass and one important B1 completion in Chapter 12. Its strongest assets are the progressive CoALA teaching sequence, the mechanism-level discipline of Part II, the distinction between evidence and implementation depth, and the substantial engineering bridges.

The correction principle should be: **keep every distinct idea, remove repeated packaging of the same idea.** In practice, that means preserving the main explanations and worked examples, deleting redundant takeaway boxes, compressing repeated warnings and “common confusion” lists, and keeping one recap per chapter.

No Part III implementation should start until the P0 items are corrected, the revised Part III scope is reflected in the book, and a fresh compiled PDF passes content, source and layout checks.

---

## References used for this review

- Sumers, Theodore R., Shunyu Yao, Karthik Narasimhan, and Thomas L. Griffiths. “Cognitive Architectures for Language Agents.” *Transactions on Machine Learning Research* (2024). Primary reference for Part I.
- Fan, H., and Z. Lan. “From Cognitive Architectures to Language Agents: A Mechanism-Level Review of Lineage, Convergence, and Migration Gaps.” arXiv:2607.23942v1 (2026). Primary reference for Part II.
- Bothell, Dan. *ACT-R 7.30+ Reference Manual*, especially Declarative Memory, Activation, Base-level, Spreading Activation, Partial Matching, Noise and Retrieval Time.
- Xia, Tianle, et al. “GraSP: Graph-Structured Skill Compositions for LLM Agents.” arXiv:2604.17870v1 (2026).
- The source and bibliography entries already present in the reviewed `book.pdf`; this report does not claim to have independently validated every citation in that bibliography.
