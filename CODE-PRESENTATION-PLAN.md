# Code Presentation and Source Navigation Plan

**Status:** Accepted design; staged rollout pending the three-listing pilot  
**Created:** 25 November 2026  
**Applies to:** Part III, Chapters 19–24  
**Canonical LaTeX tree:** `Tex/part3/`  
**Implementation baseline currently reviewed for Chapter 19:** `fa8cd5ec0742d7010dbba2c3646852e95062a419`

> **Provenance note.** The supplied book archive did not contain a file named `CODE-PRESENTATION-PLAN.md`. This is therefore the first version of the plan, created in the book repository; it is not an edit to a previously present copy.

## 1. Decision

Use **one QR code per primary implementation listing**, not one QR code per chapter and not one QR code for every code excerpt.

A QR code is a print-navigation shortcut for a particular implementation. It must never replace the explanation, the source path printed beside it, or the test evidence. The book continues to explain the problem, contract, algorithm, state transition, invariants, failure boundaries, and what the tests do and do not establish.

Place the QR/source reference strip immediately below the relevant listing by default. Align the QR block to the right and place the compact source-reference text beside it. The printed reference must remain useful without a phone: readers should see the source ID, Maven module, complete repository-relative source path, class/member, and corresponding proof test.

## 2. What qualifies for a QR code

A QR code is appropriate when a listing is a primary implementation spotlight:

| Content | QR policy |
| --- | --- |
| Primary algorithm or business-state transition | **Yes** |
| Critical authorization, concurrency, or fencing operation | **Yes** |
| Important lifecycle method that establishes a contract or recovery boundary | **Yes**, when the listing is central to the chapter |
| Supporting record, interface, enum, or value-object excerpt | No; print the source reference |
| Small helper method or short illustrative fragment | No; print the source reference |
| Test assertion accompanying an implementation listing | No separate QR; identify the test and link it in the PDF |
| Diagram spanning several modules | No; provide a source map or module map |
| Whole chapter | No chapter-level QR |

The threshold is pedagogical, not a count quota. A chapter may have no QR codes or several. Do not add a QR merely to make a page look balanced.

## 3. Source identity and stable references

Assign a stable, chapter-local source ID to each implementation spotlight or important supporting excerpt. Use the form `C<chapter>-S<sequence>` (for example, `C21-S03`). Do not derive IDs from source line numbers because lines can move during ordinary edits.

Every source reference must carry:

1. **Source ID** — the printed and searchable identifier.
2. **Repository revision** — the full immutable commit SHA used for the chapter.
3. **Maven module** — the real module name from the supplied reactor.
4. **Repository-relative path** — complete path from the repository root, including `src/main/java` or `src/test/java` as applicable.
5. **Class and exact member** — method, constructor, record, or other symbol discussed.
6. **Proof test** — test class and exact test method(s), with the test source path when space permits.

A source ID must resolve to one implementation target in one source revision. If the target changes materially or moves to another source file, review the ID rather than silently redirecting it. Supporting excerpts receive a source ID and printed path but do not automatically receive a QR.

## 4. Canonical URL and commit pinning

The QR and the visible **Open exact source** PDF hyperlink must use the **same canonical GitHub source-view permalink**. Use the GitHub `blob` view, not a `raw` file-download URL. Pin the exact commit; never use `main`, `master`, or another moving branch for a published source reference.

Canonical form (template only; not a verified URL):

```text
https://github.com/{OWNER}/{REPOSITORY}/blob/{COMMIT_SHA}/{REPOSITORY_RELATIVE_PATH}#L{START}-L{END}
```

The source ID and the printed source path identify the same destination used by the QR. The test label is a separate clickable PDF reference to the test file at the same commit; it is not encoded in the implementation QR.

**Publication gate:** repository owner and repository name must be confirmed from the actual project origin. They must never be inferred from a local folder name, Maven artifact, ZIP filename, or a guessed GitHub search result. The current application archive exposes the source commit `fa8cd5ec0742d7010dbba2c3646852e95062a419`, but neither supplied archive provides a verified Git remote URL or owner/repository pair. Consequently, no production GitHub permalink, QR image, or clickable source hyperlink may be generated until that identity is supplied or verified. Do not encode a placeholder or invented URL.

## 5. LaTeX layout and package choice

### Default: `qrcode` plus `hyperref`

Use `qrcode` for the standard right-aligned inline source strip. The supplied book already loads `hyperref`; the locally installed `qrcode` package is v1.51. It can create a clickable QR when `hyperref` is loaded. The final macro should accept the canonical URL once and use that exact value for both the QR payload and the visible PDF link, avoiding separately maintained URLs.

The strip should have two aligned regions:

- **Text region:** source ID, module, full source path, class/member, proof test, and the visible text **Open exact source**.
- **QR region:** black modules on a white, opaque background, right-aligned, with the short label **Scan to inspect**.

Keep the strip compact and directly attached to its listing. The reference text is part of the printed navigation system, not a replacement for the listing caption or surrounding explanation.

### Quiet zone is mandatory

The installed `qrcode` package defaults to `tight`, which suppresses the empty border. Set `padding` explicitly for every printed QR. The padding option turns off tight rendering and adds the required four-module empty border on each side. Do not crop, cover, tint, invert, round, add a logo to, or place a background image behind the QR.

### Physical size

Target **18–21 mm for the complete printed square, including the quiet zone**. Do not assume that the package's `height` parameter already includes the quiet zone: the padding expands the outside dimensions beyond the encoded matrix. Calibrate the matrix height against the actual URL density and measure the final bounding square in the rendered PDF.

Longer commit-pinned URLs can produce denser QR matrices. Do not shorten the payload with a redirect, URL shortener, branch alias, or an unverified intermediary. If the resulting QR cannot be scanned reliably at the target size, investigate a layout/size change rather than changing the destination semantics.

### `hvqrurl` remains an alternative

Use `hvqrurl` only if the margin layout proves better for a particular page design. It is designed for QR placement in document margins and can select the outer margin in two-sided layouts. Its installed default QR height is 1 cm and must be increased and measured. In the installed version, set the visible `linktext` globally with `\hvqrset{...}` rather than relying on an unverified per-call option. It is not the default implementation for the standard source strip.

## 6. Digital-PDF behaviour and accessibility

The PDF must provide a normal selectable text link labelled **Open exact source** in addition to the clickable QR. The printed path and source ID remain visible whether or not the PDF is interactive. Test references should also be clickable to their test files.

The QR is primarily a print-navigation mechanism; it is not the only way to access the source. The `qrcode` package is not to be assumed compatible with Tagged PDF. If a tagged/accessibility-conformant PDF is produced, test the QR treatment separately and retain the selectable text link and readable source reference independently of the QR object.

## 7. Verification required before publication

For each QR-enabled listing:

1. Verify the source path, symbol, exact commit, and line range against the frozen application snapshot.
2. Verify the associated test file and test method; state exactly what the test proves and does not prove.
3. Generate the QR with explicit quiet-zone padding and an opaque white field.
4. Confirm the QR payload and **Open exact source** hyperlink are byte-for-byte the same canonical source URL.
5. Confirm the test hyperlink resolves to the matching test path at the same commit.
6. Build the print-ready PDF and inspect the actual rendered page: no clipping, collision, overfull source text, or broken line wrapping.
7. Decode the QR from the final PDF render, including a high-quality raster rendition at 200 DPI or above.
8. Produce and scan a physical proof at the intended print size. A successful decode from a screen image is not physical-print certification.
9. Confirm that the code remains black-on-white, unaltered, and surrounded by the full quiet zone.
10. Re-run the checks whenever the source commit, URL, LaTeX macro, package version, QR size, or PDF production pipeline changes.

A chapter is not QR-approved merely because LaTeX compiled. Record the commit, resolved permalink, measured outside dimensions, decoded payload, PDF inspection, and physical-proof result in the relevant review note.

## 8. Pilot and rollout order

Do not retrofit QR images across the existing chapters before the pilot is reviewed. The first pilot comprises three distinct code paths:

| Pilot | Implementation target | Why it is a useful test |
| --- | --- | --- |
| Chapter 21 — B1 | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b1/B1RetrievalSelector.java`, `select(...)` | Primary candidate-ranking and context-budget algorithm; validates a long source link in a mechanism module |
| Chapter 21 — B3 | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b3/WorkspaceAdmissionService.java`, `admit(...)` | Workspace/coalition admission and competition; tests a second primary listing and source destination |
| Chapter 22 — B2 | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ImpasseResolutionCase.java`, `resolve(...)` | Parent-context/version fence on child results; checks a distinct critical lifecycle/concurrency boundary |

After the author reviews the three printed and digital examples, lock the source-strip dimensions, QR macro, caption treatment, and hyperlink behaviour. Then apply the approved format consistently to eligible primary listings in Chapters 19–24. Do not add a chapter-level QR.

## 9. Chapter 19 source-register created in the first revision

The first chapter revision assigns these IDs and prints their full paths, members, and test evidence against application commit `fa8cd5ec0742d7010dbba2c3646852e95062a419`:

| Source ID | Classification | Implementation target | QR status |
| --- | --- | --- | --- |
| `C19-S01` | Supporting value-object excerpt | `Quantity.plus()` / `requireSameUnit()` | No QR |
| `C19-S02` | Supporting command-record excerpt | `SimulationCommand.ReserveInventory` constructor | No QR |
| `C19-S03` | Primary business transition | `SupplyChainSimulator.reduceSupplierCapacity()` | Deferred until pilot is accepted |
| `C19-S04` | Critical world-version/compare-and-set gate | `InMemorySupplyChainSimulationWorld.apply()` | Deferred until pilot is accepted |

The two supporting excerpts remain fully traceable without QR codes. The two primary references are QR candidates under this policy, but the pilot order remains Chapters 21 and 22. No QR or live GitHub link has been emitted for Chapter 19 because the archive does not reveal a verified repository origin.

## 10. Non-negotiable editorial rules

- A QR never replaces the code that teaches the mechanism.
- A QR never replaces a source path, source ID, test reference, or the explanation of the test boundary.
- No branch-based or unverified URL may be printed or encoded.
- No fabricated repository owner, repository name, commit, path, symbol, line range, test, or scan result.
- Distinguish the source code from the test evidence; the test does not automatically prove every property described by the surrounding prose.
- Keep primary implementation code short enough to inspect in print; prefer a focused algorithm or state transition over unrelated surrounding code.
- Keep supporting records, interfaces, and tiny excerpts navigable through printed paths and clickable PDF text, without a QR quota.
- Preserve the distinction between a reference demonstration and a production integration throughout the Part III chapters.
