#!/usr/bin/env python3
"""w47-a8 per-module FLAG-SPACE SWEEP driver.

For one recon TU, re-measures the WHOLE-TU verify_asm gate under each candidate
cc1 flag delta, using the worktree-local probe hook in tools/build.py
(NFS4_A8_TU / NFS4_A8_CC1 / NFS4_A8_G).  The probe is IN PLACE: the same TU
path is compiled, only the flags change, so PER_TU_FLAGS path keying and every
header/include stay identical.

Judging rule (briefing 4.a8): a flag is recommendable only if
  (a) whole-TU TOTALDIFF strictly drops,
  (b) ZERO PASS->FAIL regressions (and no function disappears from the object),
  (c) reproduced twice.

usage:
  python scratch/w47_a8_sweep.py <tu> [--flags-file F] [--out J] [--only "-fX,-fY"]
"""
import json
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'

# Candidate set: every optimisation/codegen switch the REAL CC1PSX.EXE accepts
# (option tables read straight out of the binary's .rdata -- see
# w47_a8_receipts.md 1), restricted to those that can change MIPS codegen.
# "G=n" is special-cased to the -G threshold (C lane; build.py's `g_value`
# PER_TU_FLAGS key is wired in compile_cpp only).
CANDIDATES = [
    # --- briefing 0b priors -------------------------------------------------
    "-funsigned-char", "-fsigned-char",
    "-fno-defer-pop",
    "-finline-functions", "-fno-inline",
    "-fforce-addr",
    "-fshort-enums",
    "-fwritable-strings",
    "-fpcc-struct-return", "-freg-struct-return",
    "-fno-peephole",
    "-fno-caller-saves",
    "-mno-gpOPT",
    "-mmemcpy",
    "G=0", "G=2", "G=8", "G=16",
    # --- already-proven per-TU levers elsewhere in the tree ------------------
    "-mno-split-addresses", "-msplit-addresses",
    "-fno-schedule-insns", "-fno-schedule-insns2",
    "-fno-strength-reduce",
    "-fno-delayed-branch",
    "-fno-builtin",
    # --- remaining -O2 optimisation switches in the real table ---------------
    "-ffloat-store",
    "-fvolatile", "-fvolatile-global",
    "-fomit-frame-pointer",
    "-fno-cse-follow-jumps", "-fno-cse-skip-blocks",
    "-fno-expensive-optimizations",
    "-fno-thread-jumps",
    "-funroll-loops",
    "-fno-force-mem",
    "-fno-function-cse",
    "-fno-rerun-cse-after-loop",
    "-fno-common",
    "-fkeep-inline-functions",
    "-fno-gnu-linker",
    "-mgas", "-mmips-as",
    "-mrnames",
    "-mlong-calls",
]


def run_gate(tu, names, flag=None):
    env = dict(os.environ)
    env.pop("NFS4_A8_TU", None); env.pop("NFS4_A8_CC1", None); env.pop("NFS4_A8_G", None)
    if flag:
        env["NFS4_A8_TU"] = tu
        # combo syntax: "G=8|-mno-split-addresses ..." -- the G part drives BOTH
        # cc1's -G and maspsx/as's -G, the rest are extra cc1 flags.
        parts = flag.split("|")
        extra = []
        for p in parts:
            if p.startswith("G="):
                env["NFS4_A8_G"] = p[2:]
            else:
                extra.append(p)
        if extra:
            env["NFS4_A8_CC1"] = " ".join(extra)
    env["VA_MAX"] = "0"
    r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'verify_asm.py'), tu, ','.join(names)],
                       capture_output=True, text=True, env=env, cwd=str(ROOT))
    if r.returncode not in (0, 1):
        return None, (r.stdout + r.stderr)[-300:]
    res = {}
    for ln in r.stdout.splitlines():
        m = re.match(r'\s*(\S+): PASS \((\d+) insns\)', ln)
        if m:
            res[m.group(1)] = 0; continue
        m = re.match(r'\s*(\S+): FAIL (\d+) diffs', ln)
        if m:
            res[m.group(1)] = int(m.group(2)); continue
        m = re.match(r'\s*(\S+): (NO ORACLE|NOT IN OBJECT)', ln)
        if m:
            res[m.group(1)] = 9999                      # gone/unmatchable == hard regression
    return res, None


def main():
    tu = sys.argv[1]
    only = None
    if '--only' in sys.argv:
        only = sys.argv[sys.argv.index('--only') + 1].split(',')
    outp = sys.argv[sys.argv.index('--out') + 1] if '--out' in sys.argv else None
    base_json = ROOT / 'scratch' / ('base_' + Path(tu).stem + '.json')
    base = json.loads(base_json.read_text())
    names = [k for k, v in base.items() if isinstance(v, int)]
    base = {k: base[k] for k in names}
    base_total = sum(base.values())
    base_pass = sum(1 for v in base.values() if v == 0)
    print(f"BASE {tu}: n={len(names)} PASS={base_pass} TOTAL={base_total}")
    rows = []
    for flag in (only or CANDIDATES):
        res, err = run_gate(tu, names, flag)
        if res is None:
            print(f"  {flag:32s} BUILDFAIL {err[:120]!r}")
            rows.append({"flag": flag, "status": "BUILDFAIL", "err": err[:300]})
            continue
        tot = sum(res.get(n, 9999) for n in names)
        npass = sum(1 for n in names if res.get(n, 9999) == 0)
        regr = [n for n in names if base[n] == 0 and res.get(n, 9999) != 0]
        worse = [n for n in names if res.get(n, 9999) > base[n]]
        better = [n for n in names if res.get(n, 9999) < base[n]]
        tag = "*** " if (tot < base_total and not regr) else "    "
        print(f"{tag}{flag:32s} TOTAL {tot:6d} ({tot-base_total:+6d})  PASS {npass:3d} "
              f"({npass-base_pass:+d})  regr={len(regr)} better={len(better)} worse={len(worse)}")
        rows.append({"flag": flag, "total": tot, "delta": tot - base_total, "pass": npass,
                     "regressions": regr, "better": better, "worse": worse,
                     "per_fn": {n: res.get(n, 9999) for n in names}})
    if outp:
        Path(outp).write_text(json.dumps({"tu": tu, "base": base, "rows": rows}, indent=1),
                              encoding='utf-8', newline='')


if __name__ == '__main__':
    main()
