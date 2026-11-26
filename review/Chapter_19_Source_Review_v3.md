# Chapter 19 Source Review — v3

> **Historical intermediate review — superseded.** Use `Chapter_19_Source_Review_v4.md` for the verified GitHub repository identity, commit-pinned links, QR implementation, and PDF-link proof. The repository-identity statement below was incomplete and is not the current source of truth.

**Date:** 25 November 2026  
**Chapter:** Engineering Foundations for Request-Driven Enterprise Agentic Systems  
**Implementation source:** `supply-chain-agent-main (10).zip`  
**Source archive SHA-256:** `8d2fd8eb0aef0ea65704349469619d789351ec7b085dd55a23d5041153f62d4c`  
**Source commit from ZIP archive comment:** `fa8cd5ec0742d7010dbba2c3646852e95062a419`  
**Review scope:** source fidelity, listing accuracy, complete source references, test semantics, persistence/restart boundaries, and QR/source-navigation readiness.

This review supersedes the source-baseline conclusions in `Chapter_19_Source_Review_v2.md` where the supplied application snapshot has changed. The earlier review was based on a different archive (`supply-chain-agent-main (9).zip`, SHA-256 `cf300670b0bca3082400b5711fa3d1db1ea9c280625720834ace0332129512f4`). The source review v2 remains preserved as historical evidence; it is not silently rewritten.

## 1. Source baseline and repository identity

The uploaded application ZIP identifies commit `fa8cd5ec0742d7010dbba2c3646852e95062a419` in its archive comment. Its SHA-256 is recorded above. The archive contains the repository tree and source, but it does not provide a verified Git remote URL, GitHub owner, or repository name. The book revision therefore uses the exact full commit SHA and repository-relative source paths, but does not invent GitHub permalinks, clickable source URLs, or QR payloads.

The Maven reactor declares eleven modules: `supply-chain-agent-domain`, `supply-chain-agent-memory`, `supply-chain-agent-actions`, `supply-chain-agent-mechanisms`, `supply-chain-agent-core`, `supply-chain-agent-simulator`, `supply-chain-agent-planning`, `supply-chain-agent-runtime`, `supply-chain-agent-infrastructure-postgres`, `supply-chain-agent-app`, and `supply-chain-agent-evaluation`. The Java compiler release is 21.

## 2. Chapter 19 listing audit

The revised chapter now has four traceable listings. Each source ID is paired with the full repository-relative implementation path, exact member, and test evidence. IDs are stable within Chapter 19 and do not depend on source line numbers.

| Source ID | Implementation path and member | Classification | Verification reference |
| --- | --- | --- | --- |
| `C19-S01` | `supply-chain-agent-domain/src/main/java/dev/supplychain/agent/domain/common/Quantity.java`; `Quantity.plus()` and `requireSameUnit()` | Supporting value-object excerpt | `supply-chain-agent-domain/src/test/java/dev/supplychain/agent/domain/common/QuantityTest.java`; `arithmeticRejectsUnitMismatchAndUnderflow()` and `arithmeticPreservesUnitAndNormalizesScale()` |
| `C19-S02` | `supply-chain-agent-simulator/src/main/java/dev/supplychain/agent/simulator/command/SimulationCommand.java`; `SimulationCommand.ReserveInventory` constructor | Supporting typed-command excerpt | `supply-chain-agent-simulator/src/test/java/dev/supplychain/agent/simulator/SupplyChainSimulatorTest.java`; `exactProductReservationReducesAvailableInventoryAndIsImmutable()` and `approvedSubstitutionUsesItsDeclaredPhysicalQuantityRatio()` |
| `C19-S03` | `supply-chain-agent-simulator/src/main/java/dev/supplychain/agent/simulator/SupplyChainSimulator.java`; `reduceSupplierCapacity()` | Primary business transition | `SupplyChainSimulatorTest.supplierCapacityReductionFlagsExistingOpenCommitmentsAtRisk()`; invalid increases are covered by `capacityCommandRejectsAnIncrease()` |
| `C19-S04` | `supply-chain-agent-actions/src/main/java/dev/supplychain/agent/actions/external/grounding/InMemorySupplyChainSimulationWorld.java`; `apply(long, SimulationCommand)` | Critical expected-version/compare-and-set gate | `supply-chain-agent-actions/src/test/java/dev/supplychain/agent/actions/SupplyChainExternalActionsTest.java`; `staleWorldVersionIsRejectedBeforeClaimAndSameKeyCanBeUsedAfterRefresh()` and `reservationMutatesOnlyTheSimulationWorldAndDuplicateDoesNotApplyAgain()` |

### C19-S01 — Quantity

The excerpt of `Quantity.plus()` and `requireSameUnit()` matches the source statements. The tests verify arithmetic with the same unit, scale normalization, mismatch rejection, underflow rejection, and negative-value rejection. The chapter's claim remains limited to the typed-value boundary; it does not imply automatic unit conversion.

### C19-S02 — ReserveInventory command record

The listing was reformatted to match the current `ReserveInventory` record constructor in the supplied `SimulationCommand.java`. It validates the command ID, required identifiers, positive fulfillment quantity, and occurrence time. The constructor establishes structural validity; it does not establish inventory availability or order-line feasibility. Those depend on the current snapshot and simulator validation.

### C19-S03 — Supplier capacity reduction

The revision adds the actual `SupplyChainSimulator.reduceSupplierCapacity()` method, which was previously discussed in prose but not shown. The excerpt was checked against source lines 71–102 in this snapshot. It:

- resolves the supplier and the requested product capability;
- rejects a unit mismatch;
- requires the requested capacity to be strictly lower;
- derives existing open supplier commitment;
- records the capacity-reduction effect;
- when the existing commitment exceeds the new capacity, adds references to qualifying open purchase orders and emits `OPEN_PURCHASE_ORDERS_AT_RISK`;
- advances the snapshot by replacing the changed supplier.

`SupplyChainSimulatorTest.supplierCapacityReductionFlagsExistingOpenCommitmentsAtRisk()` asserts new snapshot version 1, revised capability capacity, supplier version increment, and presence of the at-risk effect. `capacityCommandRejectsAnIncrease()` checks rejection of an attempted increase. Important precision retained from v2: the capacity test's final version-zero assertion calls `ScenarioFixtures.world()` again; it does not compare the exact input snapshot object. By contrast, `exactProductReservationReducesAvailableInventoryAndIsImmutable()` captures `before` and directly asserts that the original snapshot still reports 50 EACH after the result snapshot reports 40 EACH.

### C19-S04 — In-memory world apply and concurrency gate

The excerpt now reproduces the current `apply(long, SimulationCommand)` source fragment, including the exact conflict message: `World snapshot changed concurrently; reload and reconsider the action`. The earlier Chapter 19 draft omitted the final words `the action`; this has been corrected.

The source comment describes `InMemorySupplyChainSimulationWorld` as an adapter for tests/local scenarios, not as a transactional production repository. It first rejects a stale expected version, simulates against the read snapshot, and attempts an `AtomicReference.compareAndSet` commit. The two named action tests verify stale-version rejection before the execution claim (with retry after refresh) and idempotent duplicate handling after a successful simulated reservation. They do not constitute a dedicated concurrent-thread stress test of the CAS race itself; the chapter describes the implementation mechanism without overstating those test methods.

## 3. Fixture and business rules

The previous source review's domain findings remain applicable after checking the current snapshot. `ScenarioFixtures.world()` contains the Precision valve product (`SKU-100`), substitute (`SKU-100A`), Northstar supplier (`SUP-1`) with 100 EACH capacity and a two-day lead time, a 30-EACH open confirmed purchase order, a 40-EACH customer order line, two inventory lots, carrier and routes, an in-transit shipment, a time-bounded approved substitution, and a recovery objective/candidate.

The current simulator remains a deterministic, pure transition engine. It validates typed commands and returns a new immutable snapshot plus typed effects; it performs no database, network, supplier, carrier, or warehouse operation. The chapter correctly distinguishes the `PlanningState` branch used by `SimulatorBackedPlanningWorldModel` from a transition committed to the current `SupplyChainSimulationWorld`.

## 4. Application and persistence boundaries

The following boundaries remain accurate in the supplied snapshot:

- `CognitiveCycleGraph` uses LangGraph4j `StateGraph`/`CompiledGraph` for sequencing, routing, interruption, and graph checkpointing.
- LangChain4j adapters implement application-owned request-interpreter and reasoning-provider ports; LangChain4j is not the outer workflow engine.
- `DurableCognitiveApplicationHost` assembles PostgreSQL-backed memory/runtime stores and the LangGraph4j checkpoint saver while receiving the `SupplyChainSimulationWorld` port through its `Ports` record.
- No main-source PostgreSQL adapter persists `SupplyChainSnapshot`; the only current main-source `SupplyChainSimulationWorld` implementation is the in-memory adapter.
- `Phase0Application` is the only `main` method in `supply-chain-agent-app`; it runs the intake smoke path, not the full cognitive-cycle host as a user-facing application.

The application archive was inspected read-only. No application source, test, build, migration, CI, or documentation file was modified as part of this book revision.

## 5. Representative host, workflow, and restart tests

The five persistence/restart paths already described in Chapter 19 remain accurate and intentionally distinguish different boundaries:

1. `DurableCognitiveApplicationHostPostgresIntegrationTest`: same-JVM host-instance replacement at a clarification boundary, before planning or external effects.
2. `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest`: a two-cycle simulated business flow with deterministic test providers, a committed simulated effect/lost acknowledgement, host reconstruction, reconciliation without redispatch, and later observation use. The in-memory simulator-world and approval adapters remain alive outside the replaced host; selected same-process artifact-codec registries are not fresh-JVM serializers.
3. `M8B4CRestartReconciliationIntegrationTest`: Hikari pool/repository/workflow replacement in the same JVM and reconciliation of an ambiguous provider write; not the full cognitive graph or a child-process test.
4. `M8B4ForkedJvmProcessRestartIntegrationTest`: a focused workflow/provider probe across independent JVMs, with PostgreSQL-restored authority/budget/ledger/checkpoint state and a marker-file provider effect; not the full supply-chain application or its snapshot.
5. `M8B4FullGraphWorkflowTest`: full cognitive-cycle graph checkpoint resume across JVMs at a clarification boundary before approval or simulated external effects; test-owned in-memory adapters remain in use.

The chapter now labels these five as **representative**, not exhaustive. That distinction is required by the current supplied source.

## 6. Newly identified B6 reliability and lease-recovery coverage

The current application archive includes additional test classes that were not enumerated in the previous review:

- `supply-chain-agent-infrastructure-postgres/src/test/java/dev/supplychain/agent/infrastructure/postgres/runtime/M8B4ReliabilityIntegrationTest.java` includes `b6BudgetReservationsAndActualUsageSurviveRepositoryReplacement()`, `independentBudgetLedgerInstancesCannotOversubscribeOneExecution()`, `actualUsageOverrunRemainsVisibleAndBlocksFurtherReservations()`, `releasedReservationCannotBeReusedAndDeadlineIsEnforcedAfterRestart()`, `persistentIntentionResumesAfterRepositoryAndServiceReplacementWithoutObjectiveDrift()`, `approvalBindingRevocationAndExpiryRemainAuthoritativeAfterHostReplacement()`, and `ambiguousExternalWriteIsNotRedispatchedAfterDispatcherReplacement()`. These are focused PostgreSQL reliability checks across repository/service/host replacements, not all fresh-process tests.
- `supply-chain-agent-infrastructure-postgres/src/test/java/dev/supplychain/agent/infrastructure/postgres/runtime/R1DefBudgetLeaseRecoveryIntegrationTest.java` covers fenced resource-budget execution leases. `expiredUnstartedReservationIsReclaimedWithANewFenceAndCanRunOnce()` verifies a reservation that expired before operation start can be reclaimed with a new fencing token and run once. `expiredStartedReservationIsFencedAndChargedConservativelyWithoutReplay()` verifies that an expired operation that had started is conservatively charged and is not replayed. `abruptJvmDeathAtBothSidesOfOperationStartUsesDistinctRecoveryRules()` launches child JVMs for the reserved-before-start and started cases and checks their different recovery rules.

These are B6 resource-budget/lease-fencing and reliability boundaries. They must not be conflated with the B2 parent/child context-version fence covered in Chapter 22. Chapter 19 now names the additional tests in a short qualification and reserves detailed explanation for the B4/B6 chapters.

## 7. QR/source-navigation readiness

The book archive did not contain `CODE-PRESENTATION-PLAN.md`; the revision creates the first version at repository root. It defines one QR per primary implementation listing, full source identity, commit-pinned `blob` URLs, quiet-zone/size requirements, a clickable PDF source link, clickable test references, print validation, and the three-listing pilot in Chapters 21 and 22.

Chapter 19 currently prints source IDs C19-S01 through C19-S04, full repository-relative paths, exact members, and proof-test names. C19-S01 and C19-S02 are supporting excerpts and are not QR candidates. C19-S03 (the main capacity transition) and C19-S04 (the expected-version/CAS gate) are primary/critical candidates under the adopted policy, but their QR rollout is deferred until the author's three-listing pilot has been reviewed.

No QR is embedded and no clickable GitHub source URL is emitted because the supplied archive does not identify a verified GitHub owner/repository. The plan records this as a publication gate rather than inventing a destination. The `qrcode` v1.51 and `hvqrurl` v0.09 packages are installed in the build environment; `qrcode` defaults to tight rendering, so the explicit `padding` option is required to retain its four-module quiet zone. The package's configured matrix height must not be confused with the total outside size after padding. Any print-size or QR-scanning claim still requires the final rendered PDF and a physical proof.

## 8. Review outcome

**Chapter 19 source fidelity is acceptable for the reviewed scope after this revision.** The new primary simulator listing and source IDs improve the link between the business example and the code. The concurrency error string is now exact. The five runtime/restart examples are accurately marked as representative, and the B6 reliability/lease tests present in the latest supplied snapshot are called out without conflating B6 fencing with B2.

**QR publication remains blocked only by missing repository-origin metadata and the intentionally staged pilot.** This review does not claim a generated QR, successful final-PDF scan, or physical-print certification. No application repository files were changed.
