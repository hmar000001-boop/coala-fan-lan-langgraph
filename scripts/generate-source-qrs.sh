#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
QR_DIR="$ROOT/Tex/diagrams/source-qr"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

for source in "$QR_DIR"/C*-S*.tex; do
  [[ -f "$source" ]] || continue
  name="$(basename "$source" .tex)"
  xelatex \
    -interaction=nonstopmode \
    -halt-on-error \
    -file-line-error \
    -output-directory="$TMP_DIR" \
    "$source" >"$TMP_DIR/$name.build.log" 2>&1 || {
      cat "$TMP_DIR/$name.build.log" >&2
      exit 1
    }
  test -s "$TMP_DIR/$name.pdf"
  cp "$TMP_DIR/$name.pdf" "$QR_DIR/$name.pdf"
done
