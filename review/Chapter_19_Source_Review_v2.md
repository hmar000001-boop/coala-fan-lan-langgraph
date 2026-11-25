# Chapter 19 Source Review — v2

**Date:** 25 November 2026  
**Chapter:** Engineering Foundations for Request-Driven Enterprise Agentic Systems  
**Implementation source:** `supply-chain-agent-main (9).zip`  
**Source archive SHA-256:** `cf300670b0bca3082400b5711fa3d1db1ea9c280625720834ace0332129512f4`  
**Review scope:** code fidelity, test semantics, package/module references, persistence and runtime boundaries, and claims made in the revised Chapter 19.

This review supersedes the factual conclusions of `Chapter_19_Source_Review_v1.md` where this version is more precise. In particular, v1 incorrectly described the capacity-reduction test as directly asserting immutability of its original input snapshot. The test actually calls `ScenarioFixtures.world()` again in the version-zero assertion; it does not retain and compare the exact input instance. The simulator code is pure and builds a new snapshot from the input, but that specific assertion is not a same-instance before/after test.

## 1. Domain model and simulator

Verified against the supplied Java source:

- The root Maven reactor contains eleven modules: `supply-chain-agent-domain`, `supply-chain-agent-simulator`, `supply-chain-agent-core`, `supply-chain-agent-memory`, `supply-chain-agent-actions`, `supply-chain-agent-mechanisms`, `supply-chain-agent-planning`, `supply-chain-agent-runtime`, `supply-chain-agent-infrastructure-postgres`, `supply-chain-agent-app`, and `supply-chain-agent-evaluation`.
- `SupplyChainSnapshot` is an immutable, versioned view of the modeled world. Its constructor uses `Map.copyOf` for its record maps and invokes `validateReferencesAndBalances`. `toBuilder()` copies the current snapshot values into a new builder.
- `Quantity` is a non-negative, unit-bearing value object. Addition and comparison reject unit mismatch; subtraction rejects underflow. `Money` couples a non-negative amount with a Java `Currency` and rejects cross-currency addition/comparison.
- Snapshot-level rules check product and SKU uniqueness; product/unit consistency for supplier capabilities, lots, order lines, purchase orders and shipment quantities; reference integrity for inventory locations, carriers, routes, shipments and recovery objectives; substitution validity and overlapping approved windows; reservation balances; and the combined fulfilled/reserved/in-flight quantities against order demand. A fulfilled order must have each line fully fulfilled.
- `availableInventory` derives stock after active reservations and the lot's quality/expiry eligibility. `openSupplierCommitment` sums open quantities for capacity-consuming purchase orders and the selected supplier/product.
- Purchase-order placement checks an active supplier, product capability, quality qualification, matching quantity unit, lead time, and aggregate open commitment against capability capacity. This is a rule for new placement; a later capacity reduction can leave an existing confirmed commitment represented and at risk.
- `SupplyChainSimulator` is a pure deterministic transition engine. Its sealed `SimulationCommand` vocabulary covers capacity reduction, purchase-order placement, quality hold, shipment delay/reroute, inventory reservation/release, demand change, and disruption recording. A successful transition creates a new snapshot whose version is exactly one greater and returns typed `SimulationEffect` values. It does not call databases, suppliers, carriers, or warehouse systems.
- `SimulatorBackedPlanningWorldModel` applies candidate commands to a `PlanningState` branch and returns `Applied` or `Rejected`; it does not commit the current `SupplyChainSimulationWorld`.
- `SupplyChainSimulationWorld` exposes `currentSnapshot()` and `apply(expectedVersion, command)`. The only main-source implementation is `InMemorySupplyChainSimulationWorld`, which checks the expected version, calls the simulator, and uses `AtomicReference.compareAndSet` to commit the returned snapshot. Its source comment limits it to tests/local scenarios rather than a transactional production repository.

## 2. Fixture and capacity example

`ScenarioFixtures.world()` in the simulator test source contains the Precision valve product (`SKU-100`), its substitute (`SKU-100A`), the Northstar supplier (`SUP-1`) with 100 EACH capacity and a two-day lead time, an open confirmed purchase order for 30 EACH, a 40-EACH customer order line, two inventory lots, a carrier, routes, an in-transit shipment, a time-bounded approved substitution, and a recovery objective/candidate.

`SupplyChainSimulatorTest.supplierCapacityReductionFlagsExistingOpenCommitmentsAtRisk` reduces capacity to 20 EACH and asserts the returned snapshot version, updated supplier capacity/version, and `OPEN_PURCHASE_ORDERS_AT_RISK` effect. Its final version-zero assertion calls `ScenarioFixtures.world()` again; it does **not** capture the original `SupplyChainSnapshot` passed to `simulate`. The code's builder-copy and immutable-map path supports the statement that the input view is not mutated, but the test as currently written does not independently assert that property for the exact input instance. Chapter 19 now discloses this distinction.

## 3. Action dispatch and authority boundaries

Verified from `ActionDispatcher` and the supply-chain action handlers:

- The dispatcher resolves the registered handler and validates the registered input/output types.
- It extracts resource references and asks `CapabilityAuthorizer` to authorize the principal for the descriptor's capability and those resources.
- For an idempotent descriptor, it requires a key, fingerprints the request, and inspects the ledger for an earlier result. This read-only inspection occurs before the handler precondition so an already-completed duplicate can be acknowledged even if the prior action changed the state.
- It then evaluates the handler precondition. If allowed, it obtains the idempotency claim and only then invokes execution.
- `SupplyChainGroundingActions` handlers describe domain writes and required capabilities. The reserve-inventory handler scopes its authorization to the customer order and inventory lot, checks the expected snapshot version in its precondition, then creates a typed `ReserveInventory` simulator command using the operation identifier.
- `SupplyChainPerceptionActions` descriptors are read-only and non-idempotent. They return `Observation<T>` records carrying value, entity/evidence references, provenance, and source snapshot version.
- Workflow-level approval is separate from capability authorization. The application graph may require approval before the state-changing dispatcher call; neither approval nor a capability grant substitutes for the other. The world adapter's expected-version check is a further concurrency precondition.

## 4. Framework, host, and persistence boundaries

- `CognitiveCycleGraph` uses LangGraph4j `StateGraph`/`CompiledGraph`; its source documentation assigns sequencing, routing, interruption, and checkpointing to LangGraph4j. Planner strategies and application services remain Java components.
- LangChain4j adapters implement application-owned request-interpreter and reasoning-provider ports. The reasoning provider is not itself a tool executor or action-authority component.
- `DurableCognitiveApplicationHost` constructs PostgreSQL memory/runtime persistence and the PostgreSQL LangGraph4j checkpoint saver. Its `Ports` record accepts the application-specific `SupplyChainSimulationWorld` adapter from its caller.
- The PostgreSQL module does not contain a main-source adapter persisting `SupplyChainSnapshot`. The current in-memory world adapter must not be conflated with the PostgreSQL stores or graph checkpoint saver.
- `Phase0Application` is the only `main` method in the supplied app module. It compiles `SupplyChainIntakeGraph`, uses `FixedResponseChatModel("READY")` and `MemorySaver`, and prints a deterministic intake result. It is not the complete cognitive-cycle graph or a full user-facing application.

## 5. Five distinct simulation, persistence, and restart test boundaries

The reviewed chapter describes five tests, and the claims remain deliberately non-interchangeable:

1. `DurableCognitiveApplicationHostPostgresIntegrationTest.durableHostPersistsMemoryRestoresInterruptedCycleAndAcceptsANewTopLevelCycle` opens the actual durable application host, persists a working-memory marker, pauses a cycle at clarification, closes the host, then opens a new host instance against the same PostgreSQL database. The replacement host reads the marker and resumes the same graph thread; the deterministic interpreter pauses again before planning or external effects. It also accepts a second top-level cycle. This is same-JVM host-instance reconstruction, not a process restart or business-effect test.
2. `DurableCognitiveApplicationHostEndToEndPostgresIntegrationTest.durableHostApprovesDispatchesReconcilesRestartsAndConsumesPriorCycleMemory` tests two top-level cycles, exact approval binding, a simulated committed effect with a lost acknowledgement, host-instance reconstruction, reconciliation without redispatch, and later consumption of the first cycle's observation. Its Javadoc expressly says it is not a forked-JVM process-restart test. The simulator/authority adapters remain alive during host reconstruction. Some selected artifact codecs are same-process token registries, not cross-process serializers. The test uses deterministic test interpreter/reasoning providers, not a live LangChain4j model.
3. `M8B4CRestartReconciliationIntegrationTest.interruptedWorkflowReloadsApprovalIntentionBudgetAndReconcilesAmbiguousWriteAfterPoolReplacement` closes one Hikari pool and builds a replacement pool, repositories, saver and focused workflow graph in the same test JVM. A simulated provider object remains outside the two host configurations. The test restores approval, intention, budget and operation-ledger state and reconciles an ambiguous provider result. It is not a child-JVM process test and its graph is not the full cognitive application graph.
4. `M8B4ForkedJvmProcessRestartIntegrationTest.independentJvmRestartRestoresWorkflowAuthorityBudgetAndExternalOutcome` launches two child JVMs. The first checkpoints an interrupted focused workflow after the deterministic provider has committed a marker-file effect and the operation outcome is unknown. The second starts with fresh process-local host objects, reconnects to PostgreSQL, reloads the checkpoint and workflow authority/budget/operation state, reconciles the provider result, and verifies no duplicate dispatch. This proves a process boundary for the focused workflow/provider probe; it is not the full supply-chain application or a persisted simulator snapshot.
5. `M8B4FullGraphWorkflowTest.completeApplicationGraphResumesFromPostgresCheckpointInFreshJvmAfterAbruptDeath` launches child JVMs and tests full-graph PostgreSQL checkpoint resume at a clarification boundary before approval and simulated external effects. The test harness uses its own in-memory supply-chain world/effect adapters and resumes the full cognitive-cycle graph. It does not demonstrate restart after a committed supply-chain world transition, and it does not restart `DurableCognitiveApplicationHost` itself.

Across all five tests, no current test proves that `SupplyChainSnapshot` is stored in PostgreSQL and restored across a fresh-JVM restart. The current main-source world adapter is in-memory. The revised chapter keeps these claims separate and avoids presenting any one test as proof of all restart or persistence properties.

## 6. Review outcome

**No blocking source-fidelity defect remains in the revised Chapter 19 within its stated scope.** The chapter deliberately describes a simulated teaching/reference application, not a deployed integration or an exhaustive supply-chain model. Its code and test claims are attached to the exact boundaries verified above. Independent experimental validation remains outside Chapter 19's implementation/CI evidence and is not represented as completed.
