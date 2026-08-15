#!/usr/bin/env python3
"""W66-A6 probe G: the "=0 pair" lever on audiocmn's .sdata run, gated.

Adds an explicit `= 0` / `= {0,...}` initialiser to every zero-init object of
retail's .sdata run 0x8013c628..0x8013c71c so cc1plus emits ONE data batch in
DECLARATION order (retail's order) instead of {initialised, then tentative}.
Applies the patch to the real TU, runs tugate, then ALWAYS restores.

Usage: python scratchpad/w66a6/probe_zeroinit.py
"""
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
REL = "recon/game/common/audiocmn.cpp"
SRC = ROOT / REL
RUN_LO, RUN_HI = 0x8013C628, 0x8013C71C
DECL_RE = re.compile(
    r"^(?P<ty>char|int|short|u_char|u_int|void)(?P<sp>\s+)(?P<star>\*?)\s*(?P<nm>\w+)"
    r"(?P<arr>\[\d*\])?(?P<attr>\s*__attribute__\(\(.*?\)\)\s*)?"
    r"(?P<init>\s*=[^;]*)?;(?P<tail>\s*/\* @0x(?P<va>[0-9a-f]{8}))",
    re.M)


def patch(text):
    n = 0

    def sub(m):
        nonlocal n
        if m.group("init") is not None or not (RUN_LO <= int(m.group("va"), 16) <= RUN_HI):
            return m.group(0)
        arr = m.group("arr") or ""
        if arr:
            cnt = int(arr[1:-1] or "1")
            init = " = {" + ", ".join(["0"] * cnt) + "}"
        else:
            init = " = 0"
        n += 1
        return "%s%s%s%s%s%s%s;%s" % (m.group("ty"), m.group("sp"), m.group("star"),
                                      m.group("nm"), arr, m.group("attr") or "",
                                      init, m.group("tail"))

    return DECL_RE.sub(sub, text), n


def write_bytes(path, data):
    tmp = path.with_suffix(path.suffix + ".w66a6tmp")
    tmp.write_bytes(data)
    assert tmp.stat().st_size == len(data)
    os.replace(tmp, path)


if __name__ == "__main__":
    orig = SRC.read_bytes()
    log = Path(__file__).resolve().parent / "zeroinit_gate.txt"
    try:
        new, n = patch(orig.decode("utf-8"))
        print("[patch] %d initialisers added" % n)
        assert n > 0
        write_bytes(SRC, new.encode("utf-8"))
        r = subprocess.run([sys.executable, "tools/tugate.py", REL],
                           cwd=ROOT, capture_output=True, text=True)
        log.write_bytes((r.stdout + r.stderr).encode("utf-8", "replace"))
        print(r.stdout[-3000:])
    finally:
        write_bytes(SRC, orig)
        assert SRC.read_bytes() == orig, "RESTORE FAILED"
        print("[restored] %s" % REL)
