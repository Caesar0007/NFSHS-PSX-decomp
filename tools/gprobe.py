#!/usr/bin/env python3
"""Per-TU -G / -mno-split-addresses identity probe (w42-a10).

For each TU: gate every symbol the TU's object shares with asm/nonmatchings/<dir>,
under the baseline and under each candidate PER_TU_FLAGS entry, and print the
whole-TU diff total + PASS count.  Edits tools/build.py in the worktree (an
in-memory patch is a no-op -- verify_asm re-imports build.py), then restores it.

  python scratch/gprobe.py recon/frontend/psx/mdec.cpp [more TUs...]
"""
import re, subprocess, sys, os
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
NM = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe"
BUILD = ROOT/"tools"/"build.py"
ORACLE = [ROOT/"asm"/"nonmatchings"/"front", ROOT/"asm"/"nonmatchings"/"main"]

def oracle_syms():
    s=set()
    for d in ORACLE:
        if d.is_dir(): s |= {p.stem for p in d.glob("*.s")}
    return s

def tu_syms(tu):
    obj = ROOT/"build"/(tu+".o")
    if not obj.exists(): return []
    out = subprocess.run([NM, str(obj)], capture_output=True, text=True).stdout
    have = oracle_syms()
    return [ln.split()[-1] for ln in out.splitlines()
            if len(ln.split())==3 and ln.split()[1] in "Tt" and ln.split()[-1] in have]

def gate(tu, syms):
    r = subprocess.run([sys.executable, "tools/verify_asm.py", tu, ",".join(syms)],
                       capture_output=True, text=True, cwd=ROOT)
    tot=0; npass=0; nfail=0
    for ln in (r.stdout+r.stderr).splitlines():
        m=re.search(r":\s+FAIL (\d+) diffs", ln)
        if m: tot+=int(m.group(1)); nfail+=1
        elif ": PASS" in ln: npass+=1
    return tot, npass, nfail

def with_flags(tu, flags):
    # w75-a13 FIX: read the PRISTINE build.py, never the file we just patched.
    # The old form re-read the mutated file, so every candidate's row ACCUMULATED
    # at the top of the dict literal; with duplicate keys the LAST (= oldest
    # inserted) row wins, so cells 3..N silently re-measured candidate 2.  On
    # overlays.cpp this reported the baseline (71) for all five cells while the
    # true numbers are 71/71/215/598/598.  Any "-G inert" verdict produced by the
    # old tool is VACUOUS for every cell after the first non-baseline one.
    src = orig
    if flags is None: return src
    ins = '    "%s": %r,\n' % (tu, flags)
    return src.replace("PER_TU_FLAGS = {\n", "PER_TU_FLAGS = {\n"+ins, 1)

CANDS = [("baseline", None),
         ("g_value=8", {"g_value": "8"}),
         ("g_value=0", {"g_value": "0"}),
         ("no_split_addresses", {"no_split_addresses": True}),
         ("g8+nosplit", {"g_value": "8", "no_split_addresses": True})]

orig = BUILD.read_text(encoding="utf-8")
try:
    for tu in sys.argv[1:]:
        syms = tu_syms(tu)
        if not syms:
            print(f"== {tu}: no gated symbols (build it first)"); continue
        print(f"== {tu}  ({len(syms)} gated fns)")
        for name, fl in CANDS:
            BUILD.write_text(with_flags(tu, fl), encoding="utf-8")
            tot, np_, nf = gate(tu, syms)
            print(f"   {name:20s} diffs={tot:<6d} PASS={np_:<3d} FAIL={nf}")
finally:
    BUILD.write_text(orig, encoding="utf-8")
