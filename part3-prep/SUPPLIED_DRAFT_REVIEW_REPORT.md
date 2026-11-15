# Supplied draft review report (preserved input)

The following report was supplied by the author as a draft review. It is preserved as input material, not adopted as a final verdict. Its findings are independently assessed in `02_TRIAGE_OF_SUPPLIED_REVIEW.md`.

---

Review of Parts I–II — From Cognitive Architectures to Production Agentic Systems  
Reviewer notes on book.pdf (build of 15 Nov 2026, 597 pp.). Scope: Part I (Ch. 1–8, pp. 33–172) and Part II (Ch. 9–18, pp. 173–518).

## 1. Verdict

Part I is clear and faithful to its source but about 20–25% longer than it needs to be, and it has no formula or code for a programmer audience. Part II is rigorous in method and honest about provenance, but it has one visible bug (Ch. 12), a template that drifts from Ch. 12 onward, and engineering sections that overlap with the still-empty Part III. Mechanical quality is high: one misspelling in 163,000 words.

## 2. Scope and limits

- Size: Part I ≈ 37,600 words; Part II ≈ 103,700 words (2.8× Part I). Part III (Ch. 19–30), the preface, the dedication and Appendix A are placeholders and were not reviewed.
- Read in full: Ch. 1–7, Ch. 8 except the middle of §8.9, Ch. 9, Ch. 12.
- Read in part: Ch. 10 (definitions), Ch. 11 (counts, Table 11.2, bridges), Ch. 13 (intro, §13.2–13.4, recap), Ch. 14 and 18 (intro, recap), Ch. 15 (opening, BDI), Ch. 16 (EPIC), Ch. 17 (intro, GraSP stages and operators).
- Scripted over the whole book: numbering, cross-references, typography, spelling, template, code listings.
- Not verified: claims against Sumers et al. (CoALA) or Fan and Lan; no external source was consulted. Items marked "confirm" need a check against those papers.

## 3. What works

- Source discipline. About 210 [FAN & LAN] tags plus [BOOK EXAMPLE] / [ENGINEERING DECISION] keep paper claims apart from book proposals. Every chapter ends with a source note.
- Part I pedagogy. Strong motivation (Ch. 1), the "prompt is not the memory" box (Ch. 3), the retrieve/reason/learn/ground triage (Ch. 4–5), the four statuses candidate/evaluated/selected/executed (Ch. 6).
- Part II method. Mechanism = state, trigger, control, transition; E1–E4 and D0–D4 on separate axes; node–edge–invariant test. Counts (10 historical families, 8 runtimes, 42 records) are consistent across Ch. 9, 11, 17, 18, and Table 11.2 sums to 42 (7+5+3+6+3+11+3+4).
- Technical accuracy where checked. Eq. 12.2–12.8 (base-level, approximation, spreading, fan, RT = F·e^(−f·A), utility update) match ACT-R as I know them. Ch. 13's Soar semantics (four impasse types, substate results, goal dependency set, chunking) are consistent with Soar documentation as I know it. Rao & Georgeff (1991, 1995) and Kieras & Meyer (1997) citations match my recollection.
- Intellectual honesty. Closing B5 as a negative case (Ch. 17) and "state ≠ authority, visibility ≠ permission" (Ch. 18).
- Clean mechanics. Figures (95), tables (28) and listings (21) are numbered without gaps or duplicates.

## 4. Defects

### 4.1 High — fix before release

| ID | Location | Issue | Fix |
|---|---|---|---|
| H1 | Ch. 12, source note (p. 246) | Unexpanded LaTeX macro prints as "FanLanCite§ V-A; § V-B; § VI-C, B1; …". The line duplicates the sentence above it. | Repair the macro; remove the duplicate sentence. |
| H2 | Ch. 12 §12.5.3, Eq. 12.22 | Objective is V̂(S\|q,a) − λr·C_retrieval − λc·C_context − λl·C_latency. It has no activation term, so B1's activation–latency–utility coupling is implicit at best. Maintenance cost is one of B1's four signals (§12.1, §12.5.1) but is absent. Latency is both penalised (12.22) and constrained (12.24). | Define V̂ as a function of Aᵢ, or state that activation is delegated to V̂. Add a maintenance term or explain its exclusion in §12.1. Note the dual role of latency. |
| H3 | Ch. 12 | No seven-field (S/C/T/P/F/L/R) reconstruction of B1 and no E/D coding. Ch. 13–16 have them (§13.8, 14.7, 15.7, 16.7) and Ch. 18 composes B1 through those fields. | Add a section in the Ch. 13–16 pattern. |
| H4 | Ch. 12 §12.4 | MemoryBank, MemoryOS, Generative Agents, Zep, Chen & Cheng, MMR and Personalized PageRank are discussed, but none is among the 42 records in Table 11.2 (adaptive memory there: AgeMem, Memory-R1, MemCon, DeltaMem, DAM, A-MAC, CURATOR). The source note attributes the baseline set to Fan and Lan. | Confirm which are in Fan and Lan's corpus; tag the rest as book additions. |
| H5 | Ch. 11 (CLARION passage, p. 183) | "Chapter 16 will revisit … skill and method authority". Ch. 16 is B6 (uncertainty, resources). | Probably Ch. 15 (method authority, B4) or Ch. 17 (skills, GraSP). Confirm and correct. |
| H6 | Ch. 15, 17, 18 | Zero inline [BOOK EXAMPLE] / [ENGINEERING DECISION] tags, though most of their Java-like contracts are book-authored. Ch. 13 (2/2), 14 (2/2), 16 (1/3) tag inline. | Tag inline, or state once at chapter start that the whole section is a book proposal. |

### 4.2 Medium

| ID | Location | Issue | Fix |
|---|---|---|---|
| M1 | Ch. 15–18 and Ch. 14 | Template drift: no "Chapter at a glance" in Ch. 15, 16, 18. Ch. 17 puts the glance text under the "Learning Objective" heading with no real objective. Ch. 14 has objective text without the label. "Looking ahead" is absent in Ch. 9–11. Ch. 1 has no review questions (Ch. 2–8 do). | Apply one template to all chapters. |
| M2 | Ch. 6 §6.3; Ch. 7 review Q3 | "Section 4.6" collides with the book's own §4.6 (Common confusions). | Write "CoALA §4.6". |
| M3 | Ch. 2 §2.7, Ch. 3 §3.1, Ch. 4 §4.1, … | Product X "deployment 4.7" reads as a section number. | Use "v4.7" or a build ID. |
| M4 | Part I (esp. §7.6, Ch. 8) | No formula or code, though the stated reader is a programmer. Softmax appears only in prose. | Add the formula and the §7.7 example: values 0.80/0.60/0.45 give ≈ 0.40/0.32/0.28 at τ=1 and ≈ 0.86/0.12/0.03 at τ=0.1. Add 15-line decision-loop pseudocode in Ch. 8, labelled as a book example. |
| M5 | Part I | Redundancy: §1.7 ≈ §2.2 ≈ §2.4–2.5 ≈ §4.1; the classification test recurs in §4.6 and §5.9; "enumeration is not evaluation" appears three times in Ch. 6. About 50 disclaimers ("does not prescribe / not a claim"; rough regex count) concentrate in Ch. 3, 7, 8. | State each caveat once per chapter (Warning box or source note). A 20–25% cut looks feasible (my estimate). |
| M6 | Ch. 13–18 | 21 Java-like listings. A scan of numbered code lines finds ≈ 100 types defined and ≈ 80 names used but never defined (approximate; includes pseudocode words). Example: VerificationRule in Listing 15.1 is never defined. They cannot compile as printed. | Label uniformly as pseudocode, or ship a compiled companion repo. |
| M7 | Ch. 1 §1.8.3, Ch. 5 §5.8, Ch. 18 "Looking ahead" | Promises of Java 21 / Maven / LangGraph4j / LangChain4j case studies and "later Java case studies" point to Part III, where Ch. 19–30 are 2-page placeholders. Part II's reference subsystems (state machines, persistence tables, concurrency, tests) already cover similar ground. | Decide what lives in Part II vs Part III; soften promises until Part III exists. |
| M8 | Ch. 15–18 | Length: Ch. 15 13.2k words, Ch. 16 13.8k, Ch. 17 14.3k (48–52 pp. each); Ch. 18 12.7k words, 14 sections, 15 review questions. Ch. 12 is 10.0k. | Check that the second halves (engineering) justify their length. |

### 4.3 Low

| ID | Location | Issue |
|---|---|---|
| L1 | Typography | Lowercase sentence starts: §2.3.4, §2.5.2 ("grounding procedures…"), §5.1, Ch. 7 glance ("evaluation…", "selection…"), §7.6.1–7.6.2 ("argmax", "softmax"), §8.2 ("execution applies"), §15.3 ("beliefs represent"). Quote glitch ‘main‘ in §2.6.1. Ch. 15 has 8 quotations opened with a closing ” (e.g. §15.3.1 "”the payment request was submitted,"). |
| L2 | Ch. 6 glance; §11.4 | "one or more candidate action" → "actions"; "familys" → "families". |
| L3 | Terminology | "Fan & Lan" (12 occurrences) vs "Fan and Lan" (424). Standardise. |
| L4 | Ch. 12 §12.2 | Footnotes 5–9 all read "Bothell, see n. 4". Cite manual sections per equation. |
| L5 | References | Fan & Lan entry reads "In: (2026)". Mark as arXiv preprint (2607.23942), like other preprints. Date formats vary ("26 July 2026", "June 22, 2026", "11/14/2026"). |
| L6 | Back matter | Index ≈ 3 pages for 597 and looks partial. Blank page 590. Order is Glossary, Index, References. |

## 5. Priority order

1. Quick fixes (about an hour): H1, H5, M2, M3, L1–L3.
2. Ch. 12 integrity: H2, H3, H4.
3. Template and provenance: M1, H6.
4. Part I rewrite pass: M4, M5.
5. Part II/III boundary and code policy: M6, M7, M8.

## 6. Open items to confirm against the papers

- H4 (which Ch. 12 baselines are in Fan and Lan's corpus) and H5 (intended target of the Ch. 11 cross-reference).
- All §/Figure/Table pinpoints to CoALA and Fan and Lan. They look internally consistent but were not checked against those papers.
- Bodies of Ch. 14–17 beyond the sampled sections were not read line by line; the defect list for those chapters rests on structure, counts and scripted checks.
