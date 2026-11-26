# Chapter 24 — source, QR, and composition review

**Chapter:** Composing the Supply-Chain Agent: Graph Orchestration, Persistence, and Simulated Execution  
**Review date:** 26 November 2026  
**Application snapshot:** supplied `supply-chain-agent-main` archive, ZIP comment commit `fa8cd5ec0742d7010dbba2c3646852e95062a419`  
**Repository:** `hmar000001-boop/supply-chain-agent`  
**Scope:** Chapter 24 LaTeX source, its outline, seven Mermaid source diagrams, seven primary QR assets, and the source/build/scaffold registry changes required to include Chapter 24.

## 1. Review outcome

The chapter's source references were checked against the supplied application archive and pinned to the commit recorded in that archive. Fourteen source-reference records are used in the chapter. Seven primary implementation listings carry QR codes; seven supporting ports, state projections, persistence/adapters, and test-boundary references remain text-only. The separate `Phase0Application` runnable-surface note is linked directly in prose; it is deliberately not counted as a source-reference record because it is not a primary listing and the repository supplies no dedicated automated test for that small smoke program.

All seven Chapter 24 QR payloads were decoded from the rendered, standalone PDF. Each payload matched the corresponding `Open exact source`/source-strip URL annotation on the same page. The PDF was also inspected at full-page and contact-sheet scale. All seven QR-bearing listings keep their source-reference block on the same page as the listing.

## 2. Commit and source identity

All Chapter 24 source/test links use the immutable commit:

`fa8cd5ec0742d7010dbba2c3646852e95062a419`

The application archive's ZIP comment identifies this snapshot. Its `CHANGESET_INFO` mentions `c49c543` as the base for a separate CI evidence-capture overlay; the overlay changes only evidence/fingerprint scripts, not the Java sources used by this chapter. The chapter therefore does not mix the `c49c543` overlay base with its application Java snapshot and does not use a moving branch URL.

## 3. Reference register

| ID | Source file and member | Source lines | Test evidence | QR |
|---|---|---:|---|---|
| C24-S01 | `supply-chain-agent-runtime/.../CognitiveCycleOperations.java` — typed application port | 24–98 | `CognitiveCycleGraphTest`: read-only cycle and bound-approval interruption/resumption | No |
| C24-S02 | `supply-chain-agent-runtime/.../CognitiveCycleState.java` — `SCHEMA` and typed state accessors | 18–90 | `retrievalProjectionAdvancesTheWorkingMemoryVersionInGraphState()` | No |
| C24-S03 | `supply-chain-agent-app/.../CognitiveCycleApplicationGraph.java` — `buildFull(...)`, `compileFull(...)` | 44–105 | REQ-09 durable-host integration scenario | Yes |
| C24-S04 | `supply-chain-agent-runtime/.../CognitiveCycleGraph.java` — graph builder/conditional routes | 619–735; printed excerpt 685–714 | bound-approval interruption and bounded B2 subgraph tests | Yes |
| C24-S05 | `supply-chain-agent-app/.../DurableCognitiveApplicationHost.java` — `open(...)`, `assemble(...)` | 272–364; printed excerpt 287–305 | REQ-09 durable-host integration scenario | Yes |
| C24-S06 | `supply-chain-agent-infrastructure-postgres/.../PostgresLangGraph4jCheckpointSaverFactory.java` — `create(...)`, `threadIdForExecution(...)` | 23–38 | checkpoint thread identity and pause/restart saver tests | Yes |
| C24-S07 | `supply-chain-agent-infrastructure-postgres/.../PostgresAgentPersistence.java` — persistence facade | 17–69 | `durableHostPersistsMemoryRestoresInterruptedCycleAndAcceptsANewTopLevelCycle()` | No |
| C24-S08 | `supply-chain-agent-runtime/.../LangChain4jRequestInterpreter.java` — `interpret(...)` | 17–50 | Explicitly states that REQ-09 injects a deterministic `RequestInterpreter`; it does not invoke this adapter or a live model | No |
| C24-S09 | `supply-chain-agent-runtime/.../LangChain4jReasoningProvider.java` — `assess(...)` evidence validation/fallback | 28–53 | unknown evidence key and missing-confidence tests | No |
| C24-S10 | `supply-chain-agent-runtime/.../BudgetedReasoningProvider.java` — `assess(...)` | 20–53 | durable B6 invocation accounting and fail-closed ledger outage tests | No |
| C24-S11 | `supply-chain-agent-actions/.../ActionDispatcher.java` — `dispatch(...)`, `dispatchTyped(...)` | 41–200; printed excerpt 146–166 | duplicate successful mutation and authorization-order tests | Yes |
| C24-S12 | `supply-chain-agent-evaluation/.../DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.java` — two-cycle REQ-09 scenario | 151–302; reconciliation assertions 235–261 | `durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory()` | Yes |
| C24-S13 | `supply-chain-agent-infrastructure-postgres/.../M8B4ForkedJvmProbe.java` — replacement-process path | 77–161; replacement path 133–160 | `independentJvmRestartRestoresWorkflowAuthorityBudgetAndExternalOutcome()` | Yes |
| C24-S14 | `supply-chain-agent-evaluation/.../M8B4FullGraphWorkflowTest.java` — full-graph fresh-JVM clarification test | 275–303 | `completeApplicationGraphResumesFromPostgresCheckpointInFreshJvmAfterAbruptDeath()`; terminal state `ESCALATED` | No |

The `Phase0Application` source is linked separately in Section 24.10. It is an intake-only deterministic smoke program, not a full-agent CLI, and no dedicated automated test is claimed for it.

## 4. QR and PDF hyperlink verification

The following seven vector QR symbols are included in Chapter 24:

- `C24-S03` — `CognitiveCycleApplicationGraph.java`, lines 44–105.
- `C24-S04` — `CognitiveCycleGraph.java`, lines 619–735.
- `C24-S05` — `DurableCognitiveApplicationHost.java`, lines 272–364.
- `C24-S06` — `PostgresLangGraph4jCheckpointSaverFactory.java`, lines 23–38.
- `C24-S11` — `ActionDispatcher.java`, lines 41–200.
- `C24-S12` — REQ-09 durable-host integration test, lines 151–302.
- `C24-S13` — `M8B4ForkedJvmProbe.java`, lines 77–161.

The source-reference macro uses a 21 mm printed QR asset (including the white quiet-zone area), within the agreed 18–21 mm target. The two densest payloads required enlarging the default from 19.5 mm to 21 mm; this improves scan margin while preserving the right-aligned source strip. The rendered Chapter 24 pages were scanned at 300 DPI with a QR decoder. Each of the seven payloads decoded to the expected full GitHub URL. The QR's clickable PDF annotation rectangle was compared with the decoded payload and matched exactly for all seven symbols. The scan proves that all seven generated symbols are decodable from the rendered proof at 300 DPI; it is not a physical-print certification.

## 5. Architectural and evidence boundaries retained in the chapter

The review specifically checked that the chapter does not collapse distinct mechanisms into a single “agent state” abstraction:

1. `CognitiveCycleState` is the graph's compact routing/checkpoint projection, not all CoALA working memory or the source of domain truth.
2. The LangGraph4j PostgreSQL checkpoint is distinct from CoALA memory repositories, mechanism records, the action ledger, and the simulator's authoritative supply-chain world.
3. A candidate produced by planning is not an authorization. The graph pauses for exact approval, revalidates the plan/approval binding and freshness, then dispatches through action authorization, idempotency/fencing, and receipt handling.
4. A transport/receipt ambiguity is an `UNKNOWN_OUTCOME`; it is not interpreted as business failure and does not justify blind replay.
5. The primary REQ-09 scenario uses deterministic request/reasoning adapters rather than live LangChain4j model calls.
6. REQ-09 reconstructs three host instances in one JVM. It is not the separate focused forked-JVM action-ledger probe and is not the full-graph fresh-JVM clarification test. The chapter explains those three scopes separately.
7. The full-graph fresh-JVM test resumes a clarification checkpoint and reaches `ESCALATED`; it is not evidence of a completed business mutation after process death.
8. `Phase0Application` only runs a deterministic intake smoke using `MemorySaver`; it is not a runnable front end for the full durable cognitive application.

## 6. Build and validation evidence

The following checks passed against the reconstructed book tree after applying the accepted Chapter 19–23 changesets:

- `bash scripts/check-scaffold.sh` — Part III remains exactly six chapters (19–24); chapters 1–24 are recognized as drafted.
- `bash check-scaffold.sh` — root wrapper passes with the same result.
- `bash scripts/check-diagrams.sh --sources-only` — 131 Mermaid sources, accessible descriptions, sequence syntax guard, and Chapter 1–24 figure references pass.
- `python3 scripts/check-source-qrs.py` — 35 cumulative QR assets match their commit-pinned PDF links.
- Chapter 24 PDF proof: 27 pages; all seven primary listing/source-reference pairs remain on the same page; seven QR payloads decode and exactly match their PDF hyperlink annotations.
- Fourteen source-reference paths and source/test line ranges were checked against files in the supplied application archive; named test methods were found in their cited test files.

## 7. Proof-build limitations

The standalone proof used DejaVu substitute fonts because the production TeX Gyre OpenType fonts are unavailable in the current XeLaTeX environment. The repository's pinned Mermaid CLI could not be installed in this environment within the available execution window; temporary Graphviz stand-ins were used only in the isolated proof copy for visual pagination review. Those temporary images and the standalone proof PDF are not part of the changeset. The production preamble is not modified. The Mermaid `.mmd` sources are included so the normal repository build can render them with its pinned Mermaid tooling. A production-font rebuild, Mermaid CLI PNG generation, and physical proof scan remain necessary before publication.
