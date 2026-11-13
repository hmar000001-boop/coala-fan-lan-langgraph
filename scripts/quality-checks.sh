#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
PDF="build/book.pdf"
LOG="build/main.log"

[[ -s "$PDF" ]] || { echo "Missing or empty $PDF" >&2; exit 1; }
[[ -s "$LOG" ]] || { echo "Missing LaTeX build log $LOG" >&2; exit 1; }

if grep -Eqi 'LaTeX Warning: (There were undefined references|Reference .* undefined|Citation .* undefined)|Package biblatex Warning:.*(undefined|not found)|Label .* multiply defined' "$LOG"; then
  echo "Unresolved references/citations or duplicate labels detected." >&2
  exit 1
fi
if grep -Eqi 'Overfull \\[hv]box' "$LOG"; then
  echo "Overfull box detected; fix layout warnings before merging." >&2
  grep -Ei 'Overfull \\[hv]box' "$LOG" >&2 || true
  exit 1
fi

mkdir -p build/preview
pdftotext -layout "$PDF" build/book.txt
[[ -s build/book.txt ]] || { echo "PDF text extraction returned no content." >&2; exit 1; }
pdfinfo "$PDF" > build/pdfinfo.txt
pdfinfo -url "$PDF" > build/pdf-urls.txt
grep -q 'From Cognitive Architectures to Production Agentic Systems' build/pdfinfo.txt

# Source/PDF accessibility preflight: language metadata, extractable text and embedded fonts.
grep -q 'pdflang={en-US}' styles/bookstyle.sty
pdffonts "$PDF" > build/pdffonts.txt
if awk 'NR > 2 && $(NF-4) != "yes" { bad=1; print "Font is not embedded:", $0 > "/dev/stderr" } END { exit bad }' build/pdffonts.txt; then
  :
else
  echo "One or more fonts are not embedded in the PDF." >&2
  exit 1
fi

# Render each page for visual inspection. Pixel-diff regression is deferred until
# a human-approved visual baseline exists for authored chapters.
pdftoppm -png -r 90 "$PDF" build/preview/page >/dev/null 2>&1
preview_count="$(find build/preview -maxdepth 1 -type f -name 'page-*.png' | wc -l)"
(( preview_count > 0 )) || { echo "No page previews were rendered." >&2; exit 1; }

# Repeat the build in the same environment with a fixed SOURCE_DATE_EPOCH.
export SOURCE_DATE_EPOCH="${SOURCE_DATE_EPOCH:-1704067200}"
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT
cp "$PDF" "$tmpdir/first-build.pdf"
latexmk -C -outdir=build main.tex >/dev/null
bash scripts/build-book.sh >/dev/null
if ! cmp -s "$tmpdir/first-build.pdf" build/book.pdf; then
  echo "Repeat build was not byte-identical in the same environment." >&2
  sha256sum "$tmpdir/first-build.pdf" build/book.pdf >&2
  exit 1
fi

printf 'Quality checks passed. Pages: %s.\n' "$(pdfinfo "$PDF" | awk '/^Pages:/ {print $2}')"
printf 'PDF SHA-256: '
sha256sum "$PDF" | awk '{print $1}'
