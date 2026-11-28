> **Historical status note (26 November 2026):** This source/QR review predates the completion of Chapters 23–24. Its statements that those chapters were outline-gated describe the earlier snapshot only. The current Part III contains drafted Chapters 19–24, with Chapter 24 as its final chapter.

# Chapter 19 Source and QR Review — v4

**Date:** 26 November 2026  
**Chapter:** Engineering Foundations for Request-Driven Enterprise Agentic Systems  
**Application archive:** `supply-chain-agent-main (10).zip`  
**Application archive SHA-256:** `8d2fd8eb0aef0ea65704349469619d789351ec7b085dd55a23d5041153f62d4c`  
**Application repository:** `https://github.com/haythemabr/supply-chain-agent`  
**Frozen source commit:** `fa8cd5ec0742d7010dbba2c3646852e95062a419`  
**Review scope:** six-chapter Part III scaffold, Chapter 19 source accuracy, QR generation/layout, PDF hyperlinks, and the exact change-set boundary.

This review supersedes the Chapter 19 QR-readiness conclusion in `Chapter_19_Source_Review_v3.md`. The v3 report was accurate about the source paths and code review, but its repository-identity conclusion was incomplete: the current application ZIP's `CHANGESET_INFO/CHANGESET_INFO.txt` identifies `haythemabr/supply-chain-agent`, and the ZIP comment carries the full frozen commit. The repository and commit-pinned source views were then verified. No source URL, owner, or repository name was guessed.

## 1. Scaffold correction

The canonical build tree is `Tex/`; the book README identifies `Tex/main.tex` as the authoritative combined-book entry point. The canonical Part III aggregator includes Chapters 19–24.

- `Tex/part3/` now contains exactly six chapter source directories: `chapter19` through `chapter24`.
- The obsolete canonical-build placeholders `Tex/part3/chapter25` through `Tex/part3/chapter30` were removed. Each contained only a placeholder `chapter.tex` and none was included by `Tex/part3/content.tex`.
- `scripts/check-scaffold.sh` explicitly requires `count3 == 6` and rejects any of the old `Tex/part3/chapter25`–`chapter30` directories.
- The repository-root `check-scaffold.sh` is now a small executable wrapper that invokes the canonical `scripts/check-scaffold.sh`; there is one source of truth rather than two conflicting checks.

Both commands passed on the revised tree:

```text
bash scripts/check-scaffold.sh
bash check-scaffold.sh
```

Both report Part I = 8, Part II = 10, and Part III = 6. The existing chapter gates remain intact: Chapters 19–22 contain drafted prose, while 23–24 remain outline-gated placeholders.

## 2. Frozen source identity and URL construction

The application ZIP reports the full commit `fa8cd5ec0742d7010dbba2c3646852e95062a419` in its archive comment. `CHANGESET_INFO/CHANGESET_INFO.txt` identifies the repository as `haythemabr/supply-chain-agent`. The commit-pinned GitHub `blob` pages were checked before use.

Every Chapter 19 source URL has this structure:

```text
https://github.com/haythemabr/supply-chain-agent/blob/fa8cd5ec0742d7010dbba2c3646852e95062a419/<repository-relative-source-path>
```

The payload opens the immutable source file view at the reviewed commit. The exact member and source line range are printed alongside it. The QR does not point to `main`, `master`, a raw download endpoint, or a shortener.

## 3. Listing/source/test audit

| Listing / ID | Source file and member | Printed source lines | Test file and named tests | QR |
| --- | --- | ---: | --- | --- |
| 19.1 / `C19-S01` | `supply-chain-agent-domain/src/main/java/dev/supplychain/agent/domain/common/Quantity.java` — `Quantity.plus()` and `requireSameUnit()` | 12–24 | `supply-chain-agent-domain/src/test/java/dev/supplychain/agent/domain/common/QuantityTest.java` — `arithmeticRejectsUnitMismatchAndUnderflow()`; `arithmeticPreservesUnitAndNormalizesScale()` | No; supporting excerpt |
| 19.2 / `C19-S02` | `supply-chain-agent-simulator/src/main/java/dev/supplychain/agent/simulator/command/SimulationCommand.java` — `SimulationCommand.ReserveInventory` constructor | 77–87 | `supply-chain-agent-simulator/src/test/java/dev/supplychain/agent/simulator/SupplyChainSimulatorTest.java` — `exactProductReservationReducesAvailableInventoryAndIsImmutable()`; `approvedSubstitutionUsesItsDeclaredPhysicalQuantityRatio()` | Yes; explicit author-selected pilot example |
| 19.3 / `C19-S03` | `supply-chain-agent-simulator/src/main/java/dev/supplychain/agent/simulator/SupplyChainSimulator.java` — `reduceSupplierCapacity()` | 71–102 | `supply-chain-agent-simulator/src/test/java/dev/supplychain/agent/simulator/SupplyChainSimulatorTest.java` — `supplierCapacityReductionFlagsExistingOpenCommitmentsAtRisk()`; `capacityCommandRejectsAnIncrease()` | Yes; primary transition |
| 19.4 / `C19-S04` | `supply-chain-agent-actions/src/main/java/dev/supplychain/agent/actions/external/grounding/InMemorySupplyChainSimulationWorld.java` — `apply(long, SimulationCommand)` | 20–28 | `supply-chain-agent-actions/src/test/java/dev/supplychain/agent/actions/SupplyChainExternalActionsTest.java` — `staleWorldVersionIsRejectedBeforeClaimAndSameKeyCanBeUsedAfterRefresh()`; `reservationMutatesOnlyTheSimulationWorldAndDuplicateDoesNotApplyAgain()` | Yes; critical version/CAS gate |

C19-S02 is a deliberate exception to the general rule against QR codes for supporting records: the author specifically selected Listing 19.2 as the first concrete example and requested its QR. This does not create a QR quota for every record, interface, or small excerpt.

The semantic limits in v3 remain unchanged. The `ReserveInventory` constructor validates structural input; it does not establish lot availability or order-line feasibility. The capacity test and CAS tests are not overclaimed as a concurrent-thread stress test. The exact CAS conflict message in Listing 19.4 is retained from the source.

## 4. LaTeX implementation

- `Tex/preamble.tex` loads `hyperref`; it does not generate QR symbols inline.
- `Tex/shared-macros.tex` defines `\BookSourceReferenceQR` and `\BookSourceReferenceNoQR`.
- The QR artwork is generated from adjacent standalone `.tex` sources in `Tex/diagrams/source-qr/`, using CTAN `qrcode` v1.51 and XeLaTeX. The matrix is requested at 17 mm with `padding`, preserving the four-module quiet zone.
- `scripts/generate-source-qrs.sh` regenerates the three vector PDF assets. `scripts/check-source-qrs.py` compares each QR payload with argument 8 (the implementation URL) in the corresponding `\BookSourceReferenceQR` macro call and checks that the PDF asset exists. The book CI regenerates and checks these assets before the book build.
- The QR macro places the corresponding vector PDF in a white field and wraps the graphic in `\href{#8}{...}`. The same `#8` argument supplies the source ID, source path, and **Open exact source** link. The test file and test-method labels link separately to the test file at the same commit.
- The strip sits immediately below its code listing. Text sits on the left; the QR and **Scan to inspect** label sit on the right.
- C19-S01 uses a text-only reference strip; C19-S02, C19-S03, and C19-S04 use QR strips.

The requested Listing 19.2 strip visibly includes its source ID, Maven module, full source path, member, source line range, test file, two exact test names, clickable **Open exact source**, and the QR. The path and method references are not hidden behind the QR.

## 5. PDF smoke-test and QR scan result

The standalone Chapter 19 entry point compiled with XeLaTeX in a temporary proof copy and rendered at 220 DPI. The container did not contain the production TeX Gyre font families, so only the temporary proof copy used DejaVu fonts. The supplied book preamble and its production font declarations were not changed. The source archive did not contain generated Mermaid PNGs, so the proof copy used temporary diagram placeholders. These substitutions mean this is a LaTeX/source-strip layout smoke test, not the final production-font book PDF. The temporary font substitutions and diagram placeholders are not included in the change-set.

The `qrcode` package generated these QR matrix levels for the commit-pinned URLs:

| Listing | QR version / correction | Matrix modules | QR artwork generation |
| --- | --- | ---: | --- |
| 19.2 / C19-S02 | 10-M | 57 × 57 | 17 mm matrix + four-module quiet zone |
| 19.3 / C19-S03 | 10-M | 57 × 57 | 17 mm matrix + four-module quiet zone |
| 19.4 / C19-S04 | 11-M | 61 × 61 | 17 mm matrix + four-module quiet zone |

The standalone vector assets include the full padded symbol. In the Chapter 19 PDF, each clickable QR area measures **19.15 × 19.50 mm**, including the four-module quiet zone, within the 18–21 mm target.

The three 220-DPI rendered pages were inspected visually and the QR payloads were decoded. For each listing, the decoded payload matches byte-for-byte the PDF URI destination attached to the clickable QR rectangle. The clickable URI rectangle was verified at the actual QR location on page 10, page 13, and page 14. The separate source-ID, source-path, **Open exact source**, and test-file links were also inspected. The QR scan result is a raster-screen proof only; no physical printed proof has yet been scanned.

The long Listing 19.3 method originally left the source strip too close to the page footer. Its listing alone now uses an 8.5 pt font with 9.5 pt leading; the revised render clears the page number without shrinking the QR. The standard code style for the other listings is unchanged. The source-strip text is 8 pt with 9 pt leading.

## 6. Scope and change boundary

The application repository remains read-only. No application source, test, Maven build, migration, CI, or application documentation was modified. The change-set is confined to the book repository:

- Modified: `.github/workflows/build-book.yml` (regenerate and validate QR assets before compiling the book)
- Modified: `Tex/part3/chapter19/chapter.tex`
- Modified: `Tex/shared-macros.tex`
- Modified: `scripts/check-scaffold.sh`
- Modified: `check-scaffold.sh`
- Modified: `CODE-PRESENTATION-PLAN.md`
- Modified: `review/Chapter_19_Source_Review_v4.md`
- Added: `scripts/generate-source-qrs.sh` and `scripts/check-source-qrs.py`
- Added: `Tex/diagrams/source-qr/README.md`, three standalone QR `.tex` sources, and three generated vector PDF assets
- Added: `CHANGESET_README.md` and `DELETE_THESE_PATHS.txt`
- Deleted: `Tex/part3/chapter25/chapter.tex` through `Tex/part3/chapter30/chapter.tex` (listed explicitly in `DELETE_THESE_PATHS.txt`; a ZIP overlay cannot delete paths by itself)

No other chapter prose was revised. Chapters 20–24, including the planned next QR examples in Chapters 21 and 22, remain untouched.

## 7. Review conclusion

The six-chapter canonical Part III scaffold now passes both scaffold entry points. Chapter 19 includes visible, vector QR/source strips under Listings 19.2–19.4; the QR image itself is clickable, and the final XeLaTeX PDF contains a URI annotation over each QR square. All three symbols decode to the exact same commit-pinned GitHub source URL used by their clickable text references. The book CI now regenerates the QR assets and checks URL consistency before compilation. This does not claim a final full-book CI build, accessibility-tagged PDF compatibility, or a physical-print scan.
