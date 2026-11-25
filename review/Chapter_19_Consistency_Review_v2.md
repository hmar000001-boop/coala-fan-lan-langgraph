# Chapter 19 Deep Consistency Review — v2

**Date:** 25 November 2026  
**Status:** Final review of the revised Chapter 19 draft  
**Chapter:** `Tex/part3/chapter19/chapter.tex`  
**Compared material:** Parts I–II, the approved Part III scope and Chapter 19 outline, the supplied Java source repository, and the five Chapter 19 Mermaid sources.

This review supersedes `Chapter_19_Consistency_Review_v1.md`. It incorporates the five-path persistence/restart review, the Mermaid CLI failure correction, and the final LaTeX layout pass.

## Overall assessment

Chapter 19 is ready as the engineering-foundations chapter that opens the approved six-chapter Part III. It establishes the selected supply-chain domain, simulator, action boundary, module map and technology roles without pre-empting the detailed CoALA and Fan & Lan implementation chapters. The remaining limitations are explicitly stated rather than disguised as guarantees.

No Java source, test, POM, migration, workflow or build script was changed.

## 1. Continuity with Parts I and II

### Part I — CoALA

- Chapter 19 uses the three CoALA dimensions as orientation, not as a second explanation of the framework. Chapter 20 owns the detailed mapping of memory, internal/external actions and planning to Java.
- It distinguishes four concepts that could otherwise be confused: (1) Chapter 6's discussion of structured simulators as a way to generate candidate rollouts; (2) Chapter 8's internal candidate simulation and iterative improvement; (3) the repository's deterministic planning-side rollout through `SimulatorBackedPlanningWorldModel`; and (4) a grounding action that applies a command to the current simulated environment.
- The planning-side rollout is explicitly identified as an engineering implementation using the pure simulator on an isolated `PlanningState` branch. It is not called a new CoALA mechanism or equated with every form of internal reasoning simulation.
- The complete CoALA action taxonomy is deferred to Chapter 20. Chapter 19 only establishes the external perception/grounding boundary needed to understand the supply-chain simulator.
- Determinism is attributed to the simulator transition function and deterministic test paths, not to every model-backed cognitive decision.

### Part II — Fan & Lan

- Product X remains the book-created payment-incident example used in Parts I–II. Chapter 18's mechanism-composition trace and Java-like contracts are explicitly illustrative proposals, not code from the supplied Java repository. Chapter 19 begins the distinct, code-backed supply-chain application.
- The chapter refers to the five residual bundles B1, B2, B3, B4 and B6. B5/GraSP remains the closed-candidate boundary; it is not presented as a sixth open mechanism requirement.
- Part III is described as implementing engineering counterparts for selected control responsibilities, not as a complete or faithful reproduction of every source mechanism.
- The six-chapter continuation remains consistent: Chapter 19 foundations; Chapter 20 CoALA; Chapter 21 B1/B3; Chapter 22 B2; Chapter 23 B4/B6; Chapter 24 integration. Pairing B1 and B3 is a teaching sequence from retrieval to workspace admission, not an order prescribed by Fan & Lan.

## 2. Continuity before and after Chapter 19

- The Preface and How to Read This Book now describe Chapters 19–24 and qualify the mechanism implementation as engineering counterparts for selected control responsibilities.
- Chapter 1's forward-looking description of Part III and Chapter 18's final handoff are consistent with the approved simulated supply-chain demonstration and framework-aware implementation.
- Chapter 19's final roadmap hands the CoALA mapping to Chapter 20, the five residual mechanisms to Chapters 21–23, and the complete graph/runtime composition to Chapter 24.
- The Part III include file contains Chapters 19–24. Chapters 20–24 remain outline-gated; this review does not draft or approve their prose.

## 3. Duplication and scope corrections

- The bounded test fixture is introduced once. The supplier-capacity reduction is analyzed once in the simulator section instead of repeating the entire setup elsewhere.
- The five persistence/restart tests are explained in the application-composition section. The later test-evidence section now concentrates on domain and simulator tests rather than restating those integration-test narratives.
- Action dispatch is explained once in its actual order. The reservation handler then illustrates resource scope and version precondition without repeating the entire dispatcher description.
- Framework and persistence details are an orientation, not a LangGraph4j/LangChain4j tutorial. Their deeper graph and host composition remains in Chapter 24.
- The chapter does not turn the supply-chain simulator into a second running case study for every cognitive mechanism. The later chapters own those mechanisms.

## 4. Terminology and implementation precision

- **Supply-chain simulator** means the deterministic model of the external business environment.
- **Planning-side structured rollout** means applying a candidate's typed command to an isolated `PlanningState` branch through `SimulatorBackedPlanningWorldModel`.
- **Internal candidate simulation** refers to the planning/reasoning discussion in Part I. It is not necessarily a simulator call and does not itself change the modeled environment.
- **Simulated-world transition** means applying a typed command against the current world through `SupplyChainSimulationWorld` and committing the resulting snapshot.
- **Observation** means evidence read from a versioned modeled snapshot with provenance; a model-generated statement is not an observation.
- Workflow-level human approval, ActionDispatcher capability/resource authorization, idempotency handling, handler expected-version precondition, and the adapter's own version/CAS check are separate controls. The request diagram now branches for workflows where approval is not required and checks the exact selected action where approval is required.
- The module diagram is a grouped application-assembly view, not a deployment diagram or literal Maven dependency graph. The table and prose state the actual module boundaries and dependency direction.
- PostgreSQL persists selected memory and runtime records and graph checkpoints. The durable host receives `SupplyChainSimulationWorld` through its ports; the only main-source implementation is `InMemorySupplyChainSimulationWorld`. The current repository has no PostgreSQL adapter for `SupplyChainSnapshot`. The text and recap say this explicitly.
- The only `main` method in `supply-chain-agent-app` is `Phase0Application`, a deterministic intake smoke program. The repository contains a full application composition API and test-backed workflows, not a finished user-facing UI/CLI for the complete cognitive agent.

## 5. Five distinct simulation, persistence and restart test boundaries

The revised chapter describes these tests separately; none is generalized into a claim that the complete simulated business world is durable across fresh-JVM restart.

1. **`DurableCognitiveApplicationHostPostgresIntegrationTest`** opens the durable host, stores a working-memory marker, pauses at clarification, closes the host, and opens a new host instance against the same PostgreSQL database. The replacement reads the marker and resumes the same graph thread; the deterministic interpreter pauses again before planning or effects. This is same-JVM host-instance reconstruction.
2. **`DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest`** runs two top-level simulated business cycles with deterministic test interpretation/reasoning providers, exact action-bound approval, a simulated effect whose acknowledgement is lost, host reconstruction, reconciliation without redispatch, and use of the first cycle's observation by the next cycle. The simulator-world and approval adapters remain alive across host reconstruction; selected artifact codecs use same-process registries behind PostgreSQL tokens. This is not a fresh-JVM serialization proof.
3. **`M8B4CRestartReconciliationIntegrationTest`** closes and replaces the Hikari pool, repositories, saver and a focused workflow graph within one test JVM; it restores workflow records and reconciles an ambiguous provider write. The provider simulator remains outside those host objects. It is not the complete cognitive graph or a child-JVM test.
4. **`M8B4ForkedJvmProcessRestartIntegrationTest`** launches two child JVMs around a focused workflow/provider probe. The first checkpoints an interrupted workflow after a deterministic provider has committed a marker-file effect and the outcome is unknown. The second creates fresh process-local objects, reconnects to PostgreSQL, restores workflow authority/budget/operation state, reconciles, and verifies no duplicate dispatch. This is a real process boundary for the focused workflow, not the full supply-chain application or a persisted simulator snapshot.
5. **`M8B4FullGraphWorkflowTest`** launches child JVMs around the full cognitive-cycle graph assembled by the evaluation host. It pauses at a clarification boundary, halts the first process, and resumes the PostgreSQL graph checkpoint in the second. The test harness uses test-owned in-memory supply-chain world/effect adapters and pauses before approval/external effects. It does not demonstrate post-effect recovery of the simulated world or restart of `DurableCognitiveApplicationHost` itself.

The separate domain and simulator tests support only the rules and transitions they assert. The capacity-reduction test's final version-zero assertion constructs a new fixture; it does not compare the exact input object. The direct before/after immutability assertion is in `exactProductReservationReducesAvailableInventoryAndIsImmutable`. Chapter 19 now states this distinction.

## 6. Mermaid/CI failure and correction

The failed CI run reported `UnknownDiagramError` for `domain-model-overview.mmd`. The root cause was that `accTitle` and `accDescr` appeared before the `flowchart` declaration in the five new sources. Mermaid CLI 12.2.0 therefore did not detect the diagram type at the start of the input.

All five Chapter 19 Mermaid files now begin with the diagram declaration (`flowchart LR`, `flowchart TB`, or `flowchart TD`), followed by `accTitle` and `accDescr`. This matches the declaration/metadata order used by existing Part I and Part II sources. The request diagram was also refined so workflow approval is conditional rather than being shown as mandatory for every state-changing action. The module map and request diagram use Mermaid HTML line breaks (`<br/>`) rather than literal backslash-n sequences.

## 7. LaTeX and validation

- `bash scripts/check-scaffold.sh` passes: Part I 8 chapters, Part II 10, Part III 6; Chapters 1–19 contain drafted prose; Chapters 20–24 remain outline-gated.
- `bash scripts/check-diagrams.sh --sources-only` passes: 100 Mermaid sources, accessible descriptions, sequence syntax guard, and all Chapter 1–19 figure references.
- The standalone Chapter 19 PDF proof is 24 pages, US Letter. The final XeLaTeX log has no overfull boxes and no unresolved references. A local font-shape warning comes from the temporary substitute font used only for proofing.
- The local environment does not have the pinned Mermaid CLI 12.2.0. `npm install --prefix tools/mermaid --no-audit --no-fund` timed out. The Mermaid CLI render therefore remains to be confirmed by hosted CI; the source syntax/order correction is verified against existing valid repository sources and the source validator.
- For the local PDF proof, the new diagrams were previewed with Graphviz using the same semantic paths as the authoritative Mermaid source. These generated PNG previews are not part of the changes-only source patch; CI must regenerate the figures from the `.mmd` files using the pinned Mermaid CLI.
- The authoritative `Tex/preamble.tex` was restored unchanged after local proofing. The prescribed TeX Gyre font configuration has not been changed.
- No Maven build was rerun because no Java source, tests, POM, migration, build script or workflow file was changed.

## Outcome

Chapter 19 has a clear and non-duplicative teaching role: establish the supply-chain domain, the simulated external world, the application boundaries and the exact implementation/test claims. It connects Parts I and II without restating their theory, and it prepares the reader for the dedicated CoALA, mechanism and runtime chapters. The only outstanding execution evidence is the hosted Mermaid CLI render using the pinned version; the prior CI autodetection defect has been corrected in all five new sources.
