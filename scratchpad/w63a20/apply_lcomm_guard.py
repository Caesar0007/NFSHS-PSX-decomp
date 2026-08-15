#!/usr/bin/env python3
"""Apply the w62-a18 .lcomm guard to a PRIVATE maspsx copy (never the shared one).

Written via the Write tool, not a heredoc: the heredoc backslash-collapse hazard
fires on the `f"\t.globl {symbol}"` literal (AGENT_GUIDE 6 / 13F).

usage: python apply_lcomm_guard.py <path-to-maspsx/__init__.py>
"""
import ast
import sys
from pathlib import Path

OLD = (
    '                # only mark bss symbols as global\n'
    '                if section == "bss":\n'
    '                    res.append(\n'
    '                        f"\\t.globl {symbol}",\n'
    '                    )\n'
)
NEW = (
    '                # only mark bss symbols as global -- and only those that\n'
    '                # came from `.comm` (a true tentative definition).  A\n'
    '                # `.lcomm` is a FILE STATIC: GNU as keeps it local and so\n'
    '                # must we.  Without this guard maspsx globalizes every\n'
    '                # file-static that lands in .bss (24 tree-wide; the five\n'
    '                # `static char gSwapFileName[..]` copies then collide with\n'
    '                # the one genuinely global symbol of that name).\n'
    '                # w62-a18 SYMBOL_LEDGER 1.2; probe w63a20/lcomm_probe.py.\n'
    '                if section == "bss" and symbol in self.comm_symbols:\n'
    '                    res.append(\n'
    '                        f"\\t.globl {symbol}",\n'
    '                    )\n'
)

p = Path(sys.argv[1])
raw = p.read_bytes()                       # byte mode: write_text would turn the
t = raw.decode("utf-8")                    # file's LF into CRLF on Windows and
n = t.count(OLD)                           # make the unified diff whole-file
assert n == 1, f"anchor found {n} times in {p}"
new = t.replace(OLD, NEW).encode("utf-8")
assert len(new) > len(raw)
p.write_bytes(new)
assert p.read_bytes().count(b"\r\n") == raw.count(b"\r\n"), "line endings moved"
ast.parse(p.read_bytes().decode("utf-8"))
print(f"patched {p} (1 site) + ast.parse OK + line endings preserved")
