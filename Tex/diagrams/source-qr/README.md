# Chapter source QR assets

The PDF assets in this directory are generated from the adjacent standalone `.tex` files by `scripts/generate-source-qrs.sh`. The generator uses the CTAN `qrcode` package and XeLaTeX; no web QR service or image-generation service is used.

Each payload must exactly match the source permalink passed to `\BookSourceReferenceQR` in the relevant chapter. `scripts/check-source-qrs.py` compares the payload in each `.tex` source with the hyperlink URL in the chapter macro call and verifies that its PDF asset exists. The book build regenerates the vector PDFs before compilation and runs this consistency check.

The standalone source requests a 17 mm QR matrix with explicit `padding`, which supplies the four-module quiet zone on every side. The generated PDF asset includes that quiet zone. The chapter macro includes the complete square at 19.5 mm high on an opaque white field and wraps the embedded vector graphic in `\href` using the same URL as the printed source path and the **Open exact source** text link.

Do not hand-edit the generated PDF assets. Update the adjacent `.tex` payload and chapter source URL together, then run:

```bash
bash scripts/generate-source-qrs.sh
python3 scripts/check-source-qrs.py
```
