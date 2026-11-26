# Chapter 19 QR and six-chapter scaffold correction

This is a **changes-only patch** for the book repository. It is not a full project archive. It consolidates the earlier Chapter 19 revision and the follow-up fixes for the canonical six-chapter Part III scaffold and QR implementation.

## Apply

1. Extract this ZIP at the root of `coala-fan-lan-langgraph-main` (or the working root of your renamed book repository), preserving all relative paths.
2. Delete every file/directory listed in `DELETE_THESE_PATHS.txt`. ZIP overlays do not remove deleted files automatically.
3. Run:

   ```bash
   bash scripts/check-scaffold.sh
   bash check-scaffold.sh
   bash scripts/generate-source-qrs.sh
   python3 scripts/check-source-qrs.py
   ```

   Both scaffold checks must report Part III = 6. The QR validator must report three matching QR assets.

The canonical Part III LaTeX tree is `Tex/part3/` and includes Chapters 19–24 only. The root-level `part3/` directory is a legacy secondary copy; `Tex/main.tex` remains the authoritative combined-book entry point.

## Included changes

**Modified**

- `.github/workflows/build-book.yml` — regenerate the standalone vector QR assets and verify URL/payload consistency before compiling the book.
- `Tex/part3/chapter19/chapter.tex` — revised Chapter 19 source/test references below Listings 19.1–19.4; QR/source strips under Listings 19.2, 19.3, and 19.4; text-only source strip under Listing 19.1; local code-font reduction only for the long Listing 19.3 algorithm.
- `Tex/shared-macros.tex` — reusable text-only and QR source-reference macros; each embedded QR vector graphic is wrapped in `\href` using the same source URL as the text links.
- `scripts/check-scaffold.sh` — explicitly require exactly six canonical Part III chapters (19–24) and reject old chapter25–30 directories.
- `check-scaffold.sh` — root-level entry point delegates to the canonical checker, avoiding two conflicting implementations.
- `CODE-PRESENTATION-PLAN.md` — QR policy, source-reference convention, generated vector asset workflow, and proof results.
- `review/Chapter_19_Source_Review_v3.md` — preserved as a historical intermediate review and explicitly marked superseded.
- `review/Chapter_19_Source_Review_v4.md` — current source, scaffold, QR, and PDF-proof audit.

**Added**

- `scripts/generate-source-qrs.sh` — creates the three vector QR PDF assets from the adjacent standalone LaTeX sources using `qrcode.sty` and XeLaTeX.
- `scripts/check-source-qrs.py` — verifies that each QR payload exactly matches its chapter macro source URL and that the vector PDF is present.
- `Tex/diagrams/source-qr/README.md` — QR asset generation and update procedure.
- `Tex/diagrams/source-qr/C19-S02.tex` and `.pdf` — Listing 19.2 QR.
- `Tex/diagrams/source-qr/C19-S03.tex` and `.pdf` — Listing 19.3 QR.
- `Tex/diagrams/source-qr/C19-S04.tex` and `.pdf` — Listing 19.4 QR.
- `DELETE_THESE_PATHS.txt` — explicit deletions required because a ZIP overlay cannot remove old placeholder files.
- `CHANGESET_MANIFEST.txt` — Added/Modified/Deleted inventory relative to the supplied book repository.
- `CHANGESET_README.md` — this file.

**Deleted by manual application**

- `Tex/part3/chapter25/chapter.tex` through `Tex/part3/chapter30/chapter.tex` — obsolete placeholder-only canonical build chapters. Remove them as specified in `DELETE_THESE_PATHS.txt`.

## QR behaviour and verification

The source QR is generated as a vector PDF with `qrcode.sty`, a 17 mm matrix, and the required four-module quiet zone. The book includes the complete asset at 19.5 mm height on an opaque white field. The QR image itself is clickable in the PDF. Its hyperlink, the source ID, the printed source path, and **Open exact source** all use the same immutable GitHub source URL. Test file and test-method labels link separately to the matching test file at the same commit.

The final Chapter 19 XeLaTeX proof was rendered at 220 DPI. All three QR payloads were decoded and matched exactly to the URI annotation covering the QR rectangle. The clickable squares measured 19.15 × 19.50 mm. Listing 19.3 was visually checked to ensure the source strip no longer collides with the page number. This is a screen/raster proof, not a physical-print certification or final full-book CI build.

The application archive identity is `hmar000001-boop/supply-chain-agent`, commit `fa8cd5ec0742d7010dbba2c3646852e95062a419`. No application-repository files are included or modified.
