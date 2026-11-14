#!/usr/bin/env bash
set -euo pipefail
PDF="${1:?usage: quality-checks.sh PDF_PATH LATEX_LOG_PATH}"
LOG="${2:?usage: quality-checks.sh PDF_PATH LATEX_LOG_PATH}"
test -s "$PDF"
test -s "$LOG"
command -v pdfinfo >/dev/null
command -v pdftotext >/dev/null
pdfinfo "$PDF" > "${PDF%.pdf}.pdfinfo.txt"
pdftotext -layout "$PDF" "${PDF%.pdf}.txt"
test -s "${PDF%.pdf}.txt"
# Validate metadata separately from extracted text because PDF line wrapping may
# split the full title across lines. Also assert that both drafted chapters exist.
grep -q '^Title:[[:space:]]*From Cognitive Architectures to Production Agentic Systems' "${PDF%.pdf}.pdfinfo.txt"
grep -q 'Why Do Language Agents Need' "${PDF%.pdf}.txt"
grep -q 'The Architecture of CoALA' "${PDF%.pdf}.txt"
if grep -E 'LaTeX Warning: (Reference .* undefined|There were undefined references|Citation .* undefined)|Package biblatex Warning:.*undefined' "$LOG"; then
  echo 'Undefined references or citations found.' >&2
  exit 1
fi
if grep -E 'LaTeX Error:|Emergency stop\.' "$LOG"; then
  echo 'LaTeX errors found.' >&2
  exit 1
fi
# Overfull boxes are surfaced as a quality warning in the build summary; a few
# long technical lines may remain during drafting and are not a fatal TeX error.
if grep -E 'Overfull \\hbox|Overfull \\vbox' "$LOG"; then
  echo 'Review the overfull boxes above before a print-ready release.'
fi
pages=$(pdfinfo "$PDF" | awk '/^Pages:/ {print $2}')
[[ -n "$pages" && "$pages" -gt 1 ]]
echo "PDF validation passed: $pages pages; text extraction and metadata available."
