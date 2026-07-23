#!/usr/bin/env python3
"""Reject vtable indexing that scales by the whole declared row.

The reconstructed class layouts model a vptr as a pointer to an array:

    __vtbl_ptr_type (*_vf)[N];

Consequently, ``obj->_vf[slot]`` advances by ``N`` entries per slot and is
almost always an out-of-bounds dispatch. A slot in the current row is
``(*obj->_vf)[slot]``; raw oracle offsets should first decay the vptr to a
byte/integer address.

Some frontend vtables deliberately continue past the first declared row and
spell an extended slot as ``row[1][slot]``. This audit accepts that explicit
two-dimensional form, but rejects a one-dimensional use of a pointer-to-row
alias for the same reason it rejects direct ``_vf[slot]`` access.

Usage: python tools/audit_vtable_indexing.py [path ...]
Defaults to scanning recon/ and include/. Exits nonzero when findings exist.
"""

from __future__ import annotations

import re
import sys
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
SOURCE_SUFFIXES = {".c", ".cc", ".cpp", ".cxx", ".h", ".hh", ".hpp"}


@dataclass(frozen=True)
class Finding:
    path: Path
    line: int
    kind: str
    text: str


def mask_comments_and_literals(text: str) -> str:
    """Replace comments/string contents with spaces while preserving lines."""
    out = list(text)
    i = 0
    state = "code"
    quote = ""
    while i < len(text):
        ch = text[i]
        nxt = text[i + 1] if i + 1 < len(text) else ""
        if state == "code":
            if ch == "/" and nxt == "/":
                out[i] = out[i + 1] = " "
                i += 2
                state = "line_comment"
                continue
            if ch == "/" and nxt == "*":
                out[i] = out[i + 1] = " "
                i += 2
                state = "block_comment"
                continue
            if ch in ('"', "'"):
                quote = ch
                out[i] = " "
                i += 1
                state = "literal"
                continue
        elif state == "line_comment":
            if ch == "\n":
                state = "code"
            else:
                out[i] = " "
        elif state == "block_comment":
            if ch == "*" and nxt == "/":
                out[i] = out[i + 1] = " "
                i += 2
                state = "code"
                continue
            if ch != "\n":
                out[i] = " "
        else:  # literal
            if ch == "\\":
                out[i] = " "
                if i + 1 < len(text):
                    if text[i + 1] != "\n":
                        out[i + 1] = " "
                    i += 2
                    continue
            if ch == quote:
                out[i] = " "
                state = "code"
            elif ch != "\n":
                out[i] = " "
        i += 1
    return "".join(out)


def line_number(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1


def scan_file(path: Path) -> list[Finding]:
    original = path.read_text(encoding="utf-8", errors="replace")
    masked = mask_comments_and_literals(original)
    original_lines = original.splitlines()
    findings: list[Finding] = []

    # The exact Wave-22 bug: member indexing before dereferencing the row.
    direct = re.compile(r"(?:->|\.)\s*_vf\s*\[")
    for match in direct.finditer(masked):
        line = line_number(masked, match.start())
        findings.append(
            Finding(path, line, "direct _vf row indexing", original_lines[line - 1].strip())
        )

    # Catch the same mistake after copying _vf into a pointer-to-row local.
    decl = re.compile(
        r"__vtbl_ptr_type\s*\(\s*\*\s*(?P<name>[A-Za-z_]\w*)\s*\)"
        r"\s*\[[^\]]+\]"
    )
    aliases = {match.group("name") for match in decl.finditer(masked) if match.group("name") != "_vf"}
    for name in aliases:
        first_index = re.compile(rf"\b{re.escape(name)}\s*\[")
        for match in first_index.finditer(masked):
            close = masked.find("]", match.end())
            if close < 0:
                continue
            after = close + 1
            while after < len(masked) and masked[after].isspace():
                after += 1
            if after < len(masked) and masked[after] == "[":
                # Explicit row + slot, used by extended frontend vtables.
                continue
            line = line_number(masked, match.start())
            findings.append(
                Finding(
                    path,
                    line,
                    f"one-dimensional pointer-to-row indexing ({name})",
                    original_lines[line - 1].strip(),
                )
            )

    return findings


def source_files(args: list[str]) -> list[Path]:
    inputs = [Path(arg) for arg in args] if args else [ROOT / "recon", ROOT / "include"]
    files: set[Path] = set()
    for item in inputs:
        path = item if item.is_absolute() else ROOT / item
        if path.is_file() and path.suffix.lower() in SOURCE_SUFFIXES:
            files.add(path.resolve())
        elif path.is_dir():
            files.update(
                candidate.resolve()
                for candidate in path.rglob("*")
                if candidate.is_file() and candidate.suffix.lower() in SOURCE_SUFFIXES
            )
        else:
            raise SystemExit(f"not a source file or directory: {item}")
    return sorted(files)


def main(argv: list[str]) -> int:
    files = source_files(argv)
    findings = [finding for path in files for finding in scan_file(path)]
    if findings:
        for finding in findings:
            try:
                display = finding.path.relative_to(ROOT)
            except ValueError:
                display = finding.path
            print(f"{display}:{finding.line}: {finding.kind}: {finding.text}")
        print(f"FAIL: {len(findings)} unsafe vtable indexing occurrence(s) in {len(files)} files")
        return 1
    print(f"PASS: no unsafe vtable row indexing in {len(files)} files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
