# Chapter 19 Source Review — v1

**Date:** 25 November 2026  
**Chapter:** Engineering Foundations for Request-Driven Enterprise Agentic Systems  
**Implementation source:** supplied `supply-chain-agent-main` repository snapshot  
**Review scope:** factual claims, class/package references, tests, chapter boundaries, and Part I/II alignment.

## Verified implementation claims

- The Maven reactor contains eleven modules: domain, memory, actions, mechanisms, core, simulator, planning, runtime, PostgreSQL infrastructure, app, and evaluation.
- `SupplyChainSnapshot` is a versioned immutable aggregate view that copies collection maps and validates references/balances when built.
- `Quantity` is a non-negative value object with a `UnitOfMeasure`; arithmetic and comparison reject mismatched units, and subtraction rejects underflow.
- Snapshot/domain validation covers product/SKU references, supplier capability/product units, inventory/lot references and units, substitution references and overlapping approved windows, order-line product/quantity references, purchase-order references, carrier/route/shipment relationships, and order commitment/fulfilment relationships.
- Available inventory accounts for active reservations and excludes lots that are not available or have expired.
- `SupplyChainSimulator` accepts typed sealed `SimulationCommand` variants and returns a `SimulationResult` with a new snapshot and typed effects; it is deterministic and does not perform network/database/business-world I/O.
- `InMemorySupplyChainSimulationWorld` checks the expected snapshot version, invokes the simulator, then commits the resulting snapshot through `AtomicReference.compareAndSet`; its source comment explicitly limits it to tests/local scenarios rather than a transactional production repository.
- Perception actions expose observations with entity/evidence/provenance/source-version metadata; grounding actions expose typed state-changing handlers and required capability metadata.
- The `supply-chain-agent-runtime` module contains `CognitiveCycleGraph`; LangGraph4j handles application graph sequencing/routing/interruption/checkpoint integration, while cognitive operations and planner strategies remain separate Java components.
- Runtime adapters include LangChain4j request-interpreter and reasoning-provider adapters; the reasoning service's contract is structured assessment, not tool access or operational authority.
- PostgreSQL stores and the LangGraph4j checkpoint saver are distinct persistence concerns.

## Test anchors verified

- `QuantityTest` checks same-unit arithmetic, mismatched units, underflow, and negative values.
- `SupplyChainSnapshotInvariantTest` checks stock/order/substitution/shipment invariants and duplicate product SKU handling.
- `SupplyChainSimulatorTest.supplierCapacityReductionFlagsExistingOpenCommitmentsAtRisk` tests reducing modeled capacity while existing open commitments remain; it asserts version advancement, capacity change, typed at-risk effect, and immutability of the original snapshot.
- `SupplyChainSimulatorTest` additionally covers purchase-order qualification/lead time/capacity, reservation and substitution behavior, expired/quality-held inventory, shipment delay/reroute constraints, demand changes, disruption recording, and deterministic simulation.

## Accuracy and evidence boundaries retained in the chapter

- The application is a teaching/reference demonstration using a deterministic supply-chain simulator; no live supplier, carrier, warehouse, or ERP integration is claimed.
- CI and tests support only the assertions they exercise; they do not demonstrate optimality or independently validate causal mechanism effectiveness.
- The eleven Maven modules are source/dependency boundaries, not eleven deployable services.
- `InMemorySupplyChainSimulationWorld` is not described as distributed persistence or a production repository.
- CoALA is used as the architectural vocabulary; the module architecture, simulator and framework choices are engineering decisions, not prescriptions from CoALA.
- Fan & Lan's five residual bundles are B1/B2/B3/B4/B6. B5/GraSP is identified as the closed-candidate boundary, not as an implemented skill-DAG subsystem.

## Known scope limits and items deferred

- The chapter does not claim that the selected domain model is an exhaustive supply-chain ontology.
- The chapter does not describe the full durable host as an interactive console or UI. The app module's `Phase0Application` is an intake smoke program; full composition is taught in Chapter 24 through application host and integration-test evidence.
- Same-process host reconstruction, replacement-pool recovery and fresh-JVM recovery are distinct test boundaries. Chapter 19 does not claim that the two-cycle end-to-end test is a fresh-JVM restart.
- B1 selection's maintenance-cost signal is not the same thing as a standalone maintenance-accounting service being fully wired into the durable host; this distinction is deferred to Chapter 21.
- Planner implementation details, B1-B6 service internals, and full request-to-approval-to-simulation trace are deferred to Chapters 20-24.

## Review outcome

**No blocking source-fidelity issue identified for Chapter 19's current scope.** The chapter is suitable as an introductory engineering-foundation chapter, subject to final LaTeX/PDF visual inspection and the usual copy-editing pass.
