#!/usr/bin/env bash
set -Eeuo pipefail

PDF="${1:?usage: quality-checks.sh PDF_PATH LATEX_LOG_PATH}"
LOG="${2:?usage: quality-checks.sh PDF_PATH LATEX_LOG_PATH}"

fail() {
  printf 'PDF quality check failed: %s\n' "$*" >&2
  exit 1
}

require_file() {
  local path="$1"
  [[ -s "$path" ]] || fail "required file is missing or empty: $path"
}

require_command() {
  local name="$1"
  command -v "$name" >/dev/null 2>&1 || fail "required command not found on the runner: $name (Ubuntu package: poppler-utils)"
}

require_file "$PDF"
require_file "$LOG"
require_command pdfinfo
require_command pdftotext
require_command grep
require_command awk
require_command tr

INFO_FILE="${PDF%.pdf}.pdfinfo.txt"
TEXT_FILE="${PDF%.pdf}.txt"

pdfinfo "$PDF" > "$INFO_FILE" || fail "pdfinfo could not read $PDF"
pdftotext -layout "$PDF" "$TEXT_FILE" || fail "pdftotext could not extract text from $PDF"
require_file "$INFO_FILE"
require_file "$TEXT_FILE"

TITLE_LINE="$(grep -m1 '^Title:' "$INFO_FILE" || true)"
case "$TITLE_LINE" in
  *"From Cognitive Architectures to Production Agentic Systems"*) ;;
  *)
    printf 'Observed PDF metadata:\n%s\n' "$TITLE_LINE" >&2
    fail 'PDF title metadata is missing or does not match the book title'
    ;;
esac

# Normalize line wrapping before checking chapter headings. Extractors may
# place a title on adjacent lines depending on font metrics and page layout.
NORMALIZED_TEXT="$(tr '\n\r\f' '   ' < "$TEXT_FILE" | tr -s ' ')"
for expected in \
  'Why Do Language Agents Need' \
  'The Architecture of CoALA' \
  'Understanding Memory' \
  'Internal Actions' \
  'Retrieval, Reasoning and Learning' \
  'External Actions and Grounding' \
  'Planning: From a Problem to Candidate Actions'; do
  case "$NORMALIZED_TEXT" in
    *"$expected"*) ;;
    *) fail "compiled PDF does not contain expected chapter heading: $expected" ;;
  esac
done

UNDEFINED_PATTERN='LaTeX Warning: (Reference .* undefined|There were undefined references|Citation .* undefined)|Package biblatex Warning:.*undefined'
if grep -nE "$UNDEFINED_PATTERN" "$LOG"; then
  fail 'undefined LaTeX references or citations were found; inspect the log lines above'
fi

if grep -nE 'LaTeX Error:|Emergency stop\.' "$LOG"; then
  fail 'LaTeX compilation errors were found; inspect the log lines above'
fi

# Overfull boxes remain visible as a review warning, but are not fatal during
# drafting. The final print-readiness review will address them separately.
if grep -nE 'Overfull \\hbox|Overfull \\vbox' "$LOG"; then
  printf '%s\n' 'Review the overfull boxes above before a print-ready release.' >&2
fi

PAGES="$(pdfinfo "$PDF" | awk '/^Pages:/ {print $2}')"
[[ "$PAGES" =~ ^[0-9]+$ ]] || fail 'could not determine the PDF page count'
(( PAGES > 1 )) || fail "PDF has only $PAGES page; expected a compiled book"

printf 'PDF validation passed: %s pages; book metadata, chapter headings, and text extraction verified.\n' "$PAGES"
