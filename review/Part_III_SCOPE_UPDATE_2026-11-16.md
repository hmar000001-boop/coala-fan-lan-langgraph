# Part III scope update — 16 November 2026

**Status:** Authoritative scope decision for the current manuscript. This note supersedes the older Part III ten-system/case-study proposal and the archived framework-based proposal wherever they conflict.

## Approved scope

Part III contains exactly two chapters:

1. **Chapter 19 — Engineering Foundations for Request-Driven Enterprise Agentic Systems**
2. **Chapter 20 — Enterprise Supply-Chain Disruption Management**

The two chapters develop one coherent, request-driven enterprise supply-chain disruption management system. There are no additional application case studies, parallel business domains, or catalogue of unrelated systems.

## Implementation constraints

- Java is the only implementation language.
- The reference architecture is framework-independent. Do not introduce LangGraph4j, LangChain4j, another agent framework, or framework-specific runtime abstractions as dependencies of the reference system.
- Build and test tooling may be used as ordinary project infrastructure; that does not make an agent framework part of the architecture.
- CoALA and Fan & Lan remain the only overarching theoretical foundations. Part III is an engineering application, not a third cognitive theory.
- Clearly distinguish source-described mechanisms, book-created examples, and engineering proposals. Architecture, state and data contracts, control flow, persistence, authorization, recovery, and evaluation are engineering decisions made for this system.

## Chapter workflow

Chapter 19 establishes the engineering foundations. Chapter 20 develops the single supply-chain application. Each chapter requires its own detailed outline and explicit author approval before prose drafting begins. The chapter files therefore remain titled placeholders until the corresponding outline is approved.

## Repository consequences

- `Tex/part3/content.tex` includes only Chapters 19 and 20.
- Chapter 19 and Chapter 20 use the titles above and remain placeholders pending outline approval.
- The obsolete Chapter 21–30 placeholder files are removed from the active source tree.
- Earlier proposal documents and historical review records may remain archived for provenance, but they are not instructions for the current Part III implementation.
