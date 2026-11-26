# Code Presentation and Source Navigation Plan

**Status:** Accepted design; Chapter 19 QR strip implemented and render-checked; Chapters 21–22 remain the next mechanism pilot  
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

Canonical form (the current Chapter 19 links use this commit-pinned form):

```text
https://github.com/hmar000001-boop/supply-chain-agent/blob/fa8cd5ec0742d7010dbba2c3646852e95062a419/{REPOSITORY_RELATIVE_PATH}
```

The source ID and the printed source path identify the same destination used by the QR. The test label is a separate clickable PDF reference to the test file at the same commit; it is not encoded in the implementation QR.

**Repository identity verified for this snapshot.** The application archive's `CHANGESET_INFO/CHANGESET_INFO.txt` records `hmar000001-boop/supply-chain-agent`; its ZIP comment records commit `fa8cd5ec0742d7010dbba2c3646852e95062a419`. The public GitHub repository and commit-pinned source files were checked before these URLs were added. This is not an inferred owner/repository pair. The links intentionally target the source-file `blob` view at that immutable commit. Source line ranges remain printed next to the member because line-fragment anchors are not currently part of the QR payload.

## 5. LaTeX layout and package choice

### Default: `qrcode.sty` vector asset plus `hyperref`

Generate each QR as a small standalone vector PDF using the CTAN `qrcode` package (tested v1.51), then include that PDF in the source strip as a graphic. The reusable `\BookSourceReferenceQR` macro accepts one canonical source URL and uses it for the clickable source ID, clickable source path, clickable QR graphic, and visible **Open exact source** link. The adjacent standalone QR `.tex` payload is checked against that macro argument by `scripts/check-source-qrs.py`. The test file and test-method labels link separately to the matching test file at the same commit.

This two-stage approach is deliberate: in the tested XeLaTeX pipeline, wrapping the `qrcode` package's inline minipage output directly in `\href` did not produce a PDF link annotation over the QR area. Embedding the same vector output as a graphic does, and the final clickable rectangle is verified from the generated PDF. It retains LaTeX-based QR generation without a third-party image service or raster artwork.

The strip should have two aligned regions:

- **Text region:** source ID, module, full source path, class/member, source line range, test file, test methods, and the visible text **Open exact source**. The source ID and printed source path are clickable.
- **QR region:** a black-on-white vector PDF asset, right-aligned, with the short label **Scan to inspect**. The embedded graphic is wrapped in `\href` using the same source URL and produces a clickable PDF annotation over the QR square.

Keep the strip compact and directly attached to its listing. The reference text is part of the printed navigation system, not a replacement for the listing caption or surrounding explanation.

### Quiet zone is mandatory

The standalone QR source defaults to `tight`, which suppresses the empty border. Set `padding` explicitly for every printed QR. The padding option turns off tight rendering and adds the required four-module empty border on each side. The main book embeds the generated PDF on an opaque white field with zero extra color-box inset. Do not crop, cover, tint, invert, round, add a logo to, or place a background image behind the QR.

### Physical size

Target **18–21 mm for the complete printed square, including the quiet zone**. Each standalone asset uses a **17 mm matrix height**; the four-module border is included in the PDF asset. The main source strip includes the complete vector PDF at **19.5 mm high** (approximately 19.1–19.5 mm wide/high including the quiet zone, depending on the small baseline excess in the standalone page box). Do not assume the `height` parameter already includes the quiet zone: measure the actual embedded asset for each payload/version.

Longer commit-pinned URLs can produce denser QR matrices. Do not shorten the payload with a redirect, URL shortener, branch alias, or an unverified intermediary. If the resulting QR cannot be scanned reliably at the target size, investigate a layout/size change rather than changing the destination semantics.

### `hvqrurl` remains an alternative

Use `hvqrurl` only if the margin layout proves better for a particular page design. It is designed for QR placement in document margins and can select the outer margin in two-sided layouts. Its installed default QR height is 1 cm and must be increased and measured. In the installed version, set the visible `linktext` globally with `\hvqrset{...}` rather than relying on an unverified per-call option. It is not the default implementation for the standard source strip.

## 6. Digital-PDF behaviour and accessibility

The PDF must provide normal selectable text links labelled **Open exact source**, source ID, and source path in addition to the clickable QR. The printed path and source ID remain visible whether or not the PDF is interactive. Test-file and test-method references should also be clickable to their test file.

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

Chapter 19 now acts as the first layout/source-navigation pilot: C19-S02, C19-S03, and C19-S04 exercise different modules and URL densities. The next mechanism-specific pilot remains the three examples originally selected for the QR architecture review:

| Pilot | Implementation target | Why it is a useful test |
| --- | --- | --- |
| Chapter 21 — B1 | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b1/B1RetrievalSelector.java`, `select(...)` | Primary candidate-ranking and context-budget algorithm; validates a long source link in a mechanism module |
| Chapter 21 — B3 | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b3/WorkspaceAdmissionService.java`, `admit(...)` | Workspace/coalition admission and competition; tests a second primary listing and source destination |
| Chapter 22 — B2 | `supply-chain-agent-mechanisms/src/main/java/dev/supplychain/agent/mechanisms/b2/ImpasseResolutionCase.java`, `resolve(...)` | Parent-context/version fence on child results; checks a distinct critical lifecycle/concurrency boundary |

After the author reviews the Chapter 19 layout and the three mechanism-specific examples, lock the source-strip dimensions, QR macro, caption treatment, and hyperlink behaviour. Then apply the approved format consistently to eligible primary listings in Chapters 19–24. Do not add a chapter-level QR.

## 9. Chapter 19 source-register created in the first revision

The Chapter 19 revision assigns these IDs and prints their full paths, members, source line ranges, and test evidence against application commit `fa8cd5ec0742d7010dbba2c3646852e95062a419`. The requested Listing 19.2 example receives a QR as an explicit reader-navigation pilot even though the constructor is a supporting typed-command excerpt; this is not a rule to QR every record or declaration:

| Source ID | Classification | Implementation target | QR status |
| --- | --- | --- | --- |
| `C19-S01` | Supporting value-object excerpt | `Quantity.plus()` / `requireSameUnit()` | No QR |
| `C19-S02` | Supporting typed-command constructor (author-selected pilot exception) | `SimulationCommand.ReserveInventory` constructor | **QR included** |
| `C19-S03` | Primary business transition | `SupplyChainSimulator.reduceSupplierCapacity()` | **QR included** |
| `C19-S04` | Critical world-version/compare-and-set gate | `InMemorySupplyChainSimulationWorld.apply()` | **QR included** |

C19-S01 remains a supporting value-object excerpt with a readable, clickable source path and no QR. C19-S02 is QR-enabled because the author specifically selected Listing 19.2 as the concrete pilot example. The source ID, path and **Open exact source** text link and QR payload share one exact source URL; the test file and test methods link to their separate test-file permalink.

## 10. Chapter 19 QR implementation and proof result

The Chapter 19 source strips are implemented in `Tex/shared-macros.tex` and used immediately below Listings 19.2, 19.3, and 19.4. The QR vector sources and generated PDF assets live in `Tex/diagrams/source-qr/`; `scripts/generate-source-qrs.sh` regenerates them with XeLaTeX and `scripts/check-source-qrs.py` verifies that each QR payload exactly matches the source URL passed to the macro. The book CI runs both steps before compiling. The command listing requested by the author (C19-S02) is included as the explicit pilot example. C19-S01 remains a clickable text-only source reference.

The standalone Chapter 19 proof was compiled and rendered at 220 DPI. The proof environment required temporary DejaVu font substitutions because the container did not have the book's TeX Gyre families; those substitutions were made only in the temporary proof copy and were not made in `Tex/preamble.tex`. The proof copy also used temporary diagram placeholders because the source archive does not include generated Mermaid PNGs. This is a layout/QR smoke test, not the production-font full-book PDF or a physical print proof.

| Listing | QR version / correction | Calculated outside size including quiet zone | Raster decode | PDF link check |
| --- | --- | ---: | --- | --- |
| 19.2 / `C19-S02` | 10-M | 19.15 × 19.50 mm | Passed at 220 DPI | One PDF URI annotation covers the QR square and resolves to the exact decoded source URL; source ID/path/Open exact source use the same URL; tests link separately to `SupplyChainSimulatorTest.java` |
| 19.3 / `C19-S03` | 10-M | 19.15 × 19.50 mm | Passed at 220 DPI | One PDF URI annotation covers the QR square and resolves to the exact decoded source URL; visible source links use the same URL; tests link separately to `SupplyChainSimulatorTest.java` |
| 19.4 / `C19-S04` | 11-M | 19.15 × 19.50 mm | Passed at 220 DPI | One PDF URI annotation covers the QR square and resolves to the exact decoded source URL; visible source links use the same URL; tests link separately to `SupplyChainExternalActionsTest.java` |

The final 220-DPI page images were decoded successfully. For each listing, the decoded payload was compared byte-for-byte with the single PDF URI annotation whose rectangle covers the QR square; all three pairs match. Each clickable QR annotation measures 19.15 × 19.50 mm, including the quiet-zone area, and is within the target 18–21 mm range. The separate source-ID/path/Open exact source annotations and test-file annotations were also checked. The final rendered Listing 19.3 source strip no longer collides with the page number; only that long algorithm listing uses a local 8.5 pt / 9.5 pt code size to make room. No physical-print certification is claimed.

## 11. Non-negotiable editorial rules

- A QR never replaces the code that teaches the mechanism.
- A QR never replaces a source path, source ID, test reference, or the explanation of the test boundary.
- No branch-based or unverified URL may be printed or encoded.
- No fabricated repository owner, repository name, commit, path, symbol, line range, test, or scan result; the Chapter 19 links are tied to the repository identity and commit recorded in the actual source archive.
- Distinguish the source code from the test evidence; the test does not automatically prove every property described by the surrounding prose.
- Keep primary implementation code short enough to inspect in print; prefer a focused algorithm or state transition over unrelated surrounding code.
- Keep supporting records, interfaces, and tiny excerpts navigable through printed paths and clickable PDF text, without a QR quota.
- Preserve the distinction between a reference demonstration and a production integration throughout the Part III chapters.
