#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
python3 - <<'PY'
from pathlib import Path
import re
import struct
import sys
import zlib

src_root = Path('Tex/diagrams/source')
out_root = Path('Tex/diagrams/generated')
chapters = [
    Path('Tex/part1/chapter01/chapter-body.tex'),
    Path('Tex/part1/chapter02/chapter.tex'),
    Path('Tex/part1/chapter03/chapter.tex'),
    Path('Tex/part1/chapter04/chapter.tex'),
    Path('Tex/part1/chapter05/chapter.tex'),
    Path('Tex/part1/chapter06/chapter.tex'),
]
sources = sorted(src_root.rglob('*.mmd'))
if not sources:
    sys.exit('Diagram validation failed: no Mermaid source files found.')

errors = []
source_rel = {p.relative_to(src_root).with_suffix('').as_posix(): p for p in sources}
for rel, source in source_rel.items():
    source_text = source.read_text(encoding='utf-8')
    if not re.search(r'^\s*accTitle\s*:', source_text, re.MULTILINE):
        errors.append(f'Mermaid source needs accTitle: {source}')
    if not re.search(r'^\s*accDescr\s*:', source_text, re.MULTILINE):
        errors.append(f'Mermaid source needs accDescr: {source}')

    output = out_root / (rel + '.png')
    if not output.is_file() or output.stat().st_size == 0:
        errors.append(f'missing or empty PNG for {source}: expected {output}')
        continue

    raw = output.read_bytes()
    if len(raw) < 45 or raw[:8] != b'\x89PNG\r\n\x1a\n':
        errors.append(f'not a valid PNG: {output}')
        continue

    width, height = struct.unpack('>II', raw[16:24])
    if width < 1 or height < 1:
        errors.append(f'PNG has invalid dimensions {width}x{height}: {output}')
        continue

    # Validate the complete PNG chunk stream and CRCs, not only the header.
    pos = 8
    seen_ihdr = seen_idat = seen_iend = False
    png_error = None
    while pos + 12 <= len(raw):
        length = struct.unpack('>I', raw[pos:pos + 4])[0]
        kind = raw[pos + 4:pos + 8]
        end = pos + 12 + length
        if end > len(raw):
            png_error = 'truncated PNG chunk'
            break
        payload = raw[pos + 8:pos + 8 + length]
        crc = struct.unpack('>I', raw[pos + 8 + length:end])[0]
        if (zlib.crc32(kind + payload) & 0xffffffff) != crc:
            png_error = 'PNG chunk CRC mismatch'
            break
        if kind == b'IHDR':
            seen_ihdr = True
        elif kind == b'IDAT':
            seen_idat = True
        elif kind == b'IEND':
            seen_iend = True
            pos = end
            break
        pos = end

    if png_error or not (seen_ihdr and seen_idat and seen_iend) or pos != len(raw):
        errors.append(f'invalid PNG structure for {output}: {png_error or "missing chunks or trailing data"}')
        continue
    if max(width, height) < 2200:
        errors.append(f'PNG longest edge is {max(width, height)} px (<2200): {output}')

referenced = set()
for chapter in chapters:
    if not chapter.is_file():
        errors.append(f'missing chapter source: {chapter}')
        continue
    text = chapter.read_text(encoding='utf-8')
    pattern = r'\\BookDiagram(?:\[[^\]]*\])?\s*\{([^}]+\.png)\}'
    for image in re.findall(pattern, text):
        image_path = Path(image)
        try:
            rel = image_path.relative_to(out_root).as_posix()
        except ValueError:
            errors.append(f'{chapter}: image must be under {out_root}: {image}')
            continue
        key = str(Path(rel).with_suffix(''))
        referenced.add(key)
        if key not in source_rel:
            errors.append(f'{chapter}: no Mermaid source for {image}')
        if not image_path.is_file() or image_path.stat().st_size == 0:
            errors.append(f'{chapter}: missing PNG: {image}')

for key, source in source_rel.items():
    if key not in referenced:
        errors.append(f'Mermaid source not referenced by Chapters 1-6: {source}')

# Reject stale or hand-added PNGs that have no matching Mermaid source.
generated_pngs = sorted(out_root.rglob('*.png')) if out_root.exists() else []
for output in generated_pngs:
    rel = output.relative_to(out_root).with_suffix('').as_posix()
    if rel not in source_rel:
        errors.append(f'orphan generated PNG has no Mermaid source: {output}')

if errors:
    print('Diagram validation failed:', file=sys.stderr)
    for error in errors:
        print(' - ' + error, file=sys.stderr)
    sys.exit(1)

print(f'Diagram validation passed: {len(sources)} Mermaid sources and {len(referenced)} referenced PNGs across Chapters 1-6.')
PY
