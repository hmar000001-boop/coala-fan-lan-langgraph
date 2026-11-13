#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
for part in part0 part1 part2 part3; do
  [[ -f "$part/main.tex" && -f "$part/content.tex" ]] || {
    echo "Missing part entry point or content file: $part" >&2; exit 1;
  }
done
mapfile -t chapters < <(find part1 part2 part3 -mindepth 2 -maxdepth 2 -type f -path '*/chapter*/chapter.tex' | sort)
[[ "${#chapters[@]}" -eq 30 ]] || {
  echo "Expected 30 chapter placeholders; found ${#chapters[@]}." >&2; exit 1;
}
for chapter in "${chapters[@]}"; do
  grep -q '^\\chapter{' "$chapter" || { echo "Missing chapter heading: $chapter" >&2; exit 1; }
  grep -q '\\PlaceholderNote' "$chapter" || { echo "Missing placeholder note: $chapter" >&2; exit 1; }
done
printf 'Scaffold check passed: 4 part entry points and 30 chapter placeholders.\n'
