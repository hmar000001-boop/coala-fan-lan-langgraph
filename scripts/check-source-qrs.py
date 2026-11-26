#!/usr/bin/env python3
"""Check that each Chapter QR asset encodes the same pinned URL as its source strip."""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
QR_DIR = ROOT / "Tex" / "diagrams" / "source-qr"
CHAPTERS = sorted((ROOT / "Tex" / "part3").glob("chapter*/chapter.tex"))
EXPECTED_PREFIX = "https://github.com/hmar000001-boop/supply-chain-agent/blob/"
EXPECTED_COMMIT = "fa8cd5ec0742d7010dbba2c3646852e95062a419"


def extract_macro_args(text: str, macro: str, count: int) -> list[list[str]]:
    marker = "\\" + macro
    calls: list[list[str]] = []
    offset = 0
    while True:
        start = text.find(marker, offset)
        if start < 0:
            break
        pos = start + len(marker)
        args: list[str] = []
        while len(args) < count:
            while pos < len(text) and text[pos].isspace():
                pos += 1
            if pos >= len(text) or text[pos] != "{":
                raise ValueError(f"Malformed {macro} call at offset {start}")
            pos += 1
            depth = 1
            chars: list[str] = []
            while pos < len(text) and depth:
                char = text[pos]
                escaped = pos > 0 and text[pos - 1] == "\\"
                if char == "{" and not escaped:
                    depth += 1
                elif char == "}" and not escaped:
                    depth -= 1
                    if depth == 0:
                        break
                chars.append(char)
                pos += 1
            if depth:
                raise ValueError(f"Unbalanced braces in {macro} call at offset {start}")
            args.append("".join(chars))
            pos += 1
        calls.append(args)
        offset = pos
    return calls


def main() -> int:
    seen: set[str] = set()
    checked = 0
    for chapter in CHAPTERS:
        text = chapter.read_text(encoding="utf-8")
        for args in extract_macro_args(text, "BookSourceReferenceQR", 9):
            source_id, url = args[0].strip(), args[7].strip()
            if source_id in seen:
                raise ValueError(f"Duplicate QR source ID: {source_id}")
            seen.add(source_id)
            if not url.startswith(EXPECTED_PREFIX + EXPECTED_COMMIT + "/"):
                raise ValueError(f"{source_id}: source URL is not pinned to the reviewed commit")
            qr_tex = QR_DIR / f"{source_id}.tex"
            qr_pdf = QR_DIR / f"{source_id}.pdf"
            if not qr_tex.is_file() or not qr_pdf.is_file() or qr_pdf.stat().st_size == 0:
                raise ValueError(f"{source_id}: missing QR source or generated PDF asset")
            qr_source = qr_tex.read_text(encoding="utf-8")
            match = re.search(r"\\qrcode\[[^]]*\]\{([^{}]+)\}", qr_source)
            if not match:
                raise ValueError(f"{source_id}: could not read the QR payload")
            payload = match.group(1).strip()
            if payload != url:
                raise ValueError(f"{source_id}: QR payload differs from the visible PDF link")
            checked += 1
    if not checked:
        raise ValueError("No BookSourceReferenceQR calls found")
    print(f"Source QR validation passed: {checked} QR assets match their commit-pinned PDF links.")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:  # Fail closed in CI.
        print(f"Source QR validation failed: {exc}", file=sys.stderr)
        raise SystemExit(1)
