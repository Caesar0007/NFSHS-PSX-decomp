#!/usr/bin/env python3
"""qty272.py -- THE ALLOCATOR INSTRUMENT FOR THE cc1_272 LANE (W60-A1).

THE FINDING THAT MAKES THIS POSSIBLE:  PsyQ 4.0's CC1PSX (= GNU C 2.7.2.SN32,
the binary the `cc1_272` / `cc1_alt` lanes drive) ACCEPTS gcc's RTL dump flags
`-dl` (local-alloc -> `<input>.lreg`), `-dg` (global-alloc -> `<input>.greg`)
and `-dL` (loop -> `<input>.loop`).  Nobody had tried them on this binary, so
the whole 272 lane was being treated as instrument-dark (W59-11A: "allocsim
6/10 on 2.7.2 dumps, reqdelta unusable in the 272/alt lanes").  It is not.

WHAT THE DUMPS GIVE YOU (all of it, per function):
  .lreg  ";; Function <name>"
         ";; Register N used R times across L insns[ in block B];
            [dies in D places;][ crosses C calls;][ S bytes;] <class>[; pointer]"
              -> REG_N_REFS (loop-depth-weighted), live length, SIZE, the
                 block-local flag ("in block B" == local_alloc QTY, NOT a
                 global allocno), call-crossing, and the machine mode
         ";; Register N in H."   -> THE LOCAL-ALLOC HANDOUT (the 06E gap)
  .greg  ";; N regs to allocate: <pseudos, IN global.c PRIORITY ORDER>"
         ";; P conflicts: ..."   ";; P preferences: ..."
         ";; Register dispositions:  P in H  ..."
         ";; Hard regs used: ..."

USAGE  (w64-a22 doc fix: the tool was promoted out of scratchpad/w60a1/ into
        tools/, and the advertised `--rtl` flag NEVER EXISTED -- argparse
        rejects it with "unrecognized arguments".  The real flag set is below;
        `-dr`-style RTL dumps are not produced by this tool, use tools/rtl_dump.py.)
  python tools/qty272.py <recon/....c> <FUNC> [--all] [--keep DIR]
  python tools/qty272.py <recon/....c> --list
    --all   also show pseudos with no hard-reg home
    --keep  keep the .i/.lreg/.greg dumps in DIR instead of a temp dir

The flags are taken from tools/build.py's PER_TU_FLAGS for that TU (imported,
never edited) so the dump describes the SAME compilation the gate measures.
Dump files are written next to a PER-INVOCATION COPY of the .i -- cc1 names its
dumps after the INPUT path, and a shared .i silently clobbers them (W45).
"""
import argparse
import importlib.util
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]   # tools/ -> repo root


def _load_build():
    sys.path.insert(0, str(ROOT / "tools"))
    spec = importlib.util.spec_from_file_location("nfs4build",
                                                  ROOT / "tools" / "build.py")
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


def _floor_log2(n):
    r = -1
    while n:
        n >>= 1
        r += 1
    return r


# NOTE: dump_flow_info's per-register lines carry NO ";;" prefix (unlike
# dump_local_alloc's ";; Register N in H."), so the prefix is optional here.
REG_RE = re.compile(
    r"(?:;; )?Register (\d+) used (\d+) times across (\d+) insns"
    r"(?: in block (\d+))?(.*)")
IN_RE = re.compile(r";; Register (\d+) in (-?\d+)\.")
ALLOC_RE = re.compile(r";; (\d+) regs to allocate: (.*)")
CONF_RE = re.compile(r";; (\d+) conflicts: (.*)")
PREF_RE = re.compile(r";; (\d+) preferences: (.*)")
DISP_RE = re.compile(r"\s*(\d+) in (-?\d+)")

HARD = {0: "zero", 1: "at", 2: "v0", 3: "v1", 4: "a0", 5: "a1", 6: "a2",
        7: "a3", 8: "t0", 9: "t1", 10: "t2", 11: "t3", 12: "t4", 13: "t5",
        14: "t6", 15: "t7", 16: "s0", 17: "s1", 18: "s2", 19: "s3", 20: "s4",
        21: "s5", 22: "s6", 23: "s7", 24: "t8", 25: "t9", 26: "k0", 27: "k1",
        28: "gp", 29: "sp", 30: "fp", 31: "ra"}


def hname(h):
    h = int(h)
    if h < 0:
        return "(spilled)"
    if h > 31:
        # not a MIPS hard reg -- 2.7.2's disposition line can carry a
        # non-hard-reg renumber; report it rather than faking a "$64".
        return f"(reg {h})"
    return f"${HARD.get(h, h)}"


def split_functions(text):
    """-> {fnname: block-text} for a `;; Function <name>`-delimited dump."""
    out, cur, buf = {}, None, []
    for ln in text.splitlines():
        m = re.match(r";; Function (\S+)", ln)
        if m:
            if cur:
                out[cur] = "\n".join(buf)
            cur, buf = m.group(1), []
            continue
        buf.append(ln)
    if cur:
        out[cur] = "\n".join(buf)
    return out


def parse_lreg(block):
    regs, homes = {}, {}
    for ln in block.splitlines():
        m = REG_RE.match(ln)
        if m:
            tail = m.group(5) or ""
            sz = re.search(r"(\d+) bytes", tail)
            cr = re.search(r"crosses (\d+) call", tail)
            di = re.search(r"dies in (\d+) place", tail)
            regs[int(m.group(1))] = dict(
                refs=int(m.group(2)), live=int(m.group(3)),
                block=(int(m.group(4)) if m.group(4) is not None else None),
                size=int(sz.group(1)) if sz else 4,
                calls=int(cr.group(1)) if cr else 0,
                dies=int(di.group(1)) if di else 0,
                ptr="pointer" in tail)
            continue
        m = IN_RE.match(ln)
        if m:
            homes[int(m.group(1))] = int(m.group(2))
    return regs, homes


def parse_greg(block):
    order, conflicts, prefs, disp = [], {}, {}, {}
    in_disp = False
    for ln in block.splitlines():
        m = ALLOC_RE.match(ln)
        if m:
            order = [int(x) for x in m.group(2).split()]
            continue
        m = CONF_RE.match(ln)
        if m:
            conflicts[int(m.group(1))] = m.group(2).split()
            continue
        m = PREF_RE.match(ln)
        if m:
            prefs[int(m.group(1))] = m.group(2).split()
            continue
        if ln.startswith(";; Register dispositions:"):
            in_disp = True
            ln = ln[len(";; Register dispositions:"):]
        elif ln.startswith(";;"):
            in_disp = False
        if in_disp:
            for a, b in DISP_RE.findall(ln):
                disp[int(a)] = int(b)
    return order, conflicts, prefs, disp


def pri(r):
    """THE 272-LANE PRIORITY (W60-A1, measured -- do NOT use the 2.8 formula here).

        pri = floor_log2(refs) * refs / live_length          [NO size term]

    gcc-2.8's allocno_compare / QTY_CMP_PRI multiplies by SIZE; gcc-2.7.2 does
    not.  Validated by reading the `;; N regs to allocate:` order (which IS the
    post-sort allocation order) out of the .greg dumps of 18 cc1_272-lane TUs:
    the size-free form is consistent on 47/47 functions with >=3 global
    allocnos, the 2.8 form on only 40/47 -- 7 clean counter-examples, none the
    other way.  This is exactly why `tools/allocsim.py` / `tools/reqdelta.py`
    score 6/10 on 2.7.2 dumps (W59-11A): every HImode (`2 bytes`) pseudo -- and
    this lib code is full of them -- gets a 2x priority error under the 2.8
    formula.  See qty272_rule.py + rule_validation.txt.
    """
    live = max(r["live"], 1)
    return int(_floor_log2(r["refs"]) * r["refs"] / live * 10000)


def compile_dumps(src: Path, keep: Path = None):
    B = _load_build()
    rel = src.relative_to(ROOT)
    tu = B.per_tu_flags(src)
    tmp = Path(keep or tempfile.mkdtemp(prefix="qty272_"))
    tmp.mkdir(parents=True, exist_ok=True)
    i_file = tmp / (src.stem + ".i")
    r = subprocess.run([str(B.CPP), *[str(x) for x in B.CPP_FLAGS],
                        str(src), "-o", str(i_file)],
                       capture_output=True, text=True, cwd=ROOT)
    if r.returncode:
        sys.exit(f"[cpp] {rel}\n{r.stderr}")

    ver = os.environ.get("NFS4_FORCE_CC1_ALT") or tu.get("cc1_alt")
    cc1 = B._resolve_cc1_alt(str(ver)) if ver else B.CC1_272
    if cc1 is None or not Path(cc1).is_file():
        sys.exit(f"no 272/alt cc1 for {rel} (ver={ver!r}); "
                 f"CC1_272={B.CC1_272}")

    g = str(tu.get("g_value", "0"))
    flags = ["-quiet", "-O2", f"-G{g}", "-mgas"]
    for key, opt in (("no_delayed_branch", "-fno-delayed-branch"),
                     ("no_strength_reduce", "-fno-strength-reduce"),
                     ("no_schedule_insns", "-fno-schedule-insns"),
                     ("no_schedule_insns2", "-fno-schedule-insns2"),
                     ("no_builtin", "-fno-builtin")):
        if tu.get(key):
            flags.append(opt)
    # 04S/W60-A3: sub-2.8 rungs reject -mno-split-addresses; build.py's
    # _cc1_flags_for_rung drops it there.  Mirror that exactly.
    if tu.get("no_split_addresses"):
        drop = False
        try:
            drop = not B._cc1_flags_for_rung(str(ver or "2.7.2"), [])[0]
        except Exception:
            drop = str(ver or "2.7.2").startswith(("2.6", "2.7"))
        if not drop:
            flags.append("-mno-split-addresses")

    r = subprocess.run([str(cc1), *flags, "-dl", "-dg", "-dL",
                        str(i_file), "-o", str(tmp / "out.s")],
                       capture_output=True, text=True, cwd=ROOT)
    if r.returncode:
        sys.exit(f"[cc1-272 dumps] {rel}\n{r.stdout}{r.stderr}")
    return tmp, i_file, cc1, flags


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("src")
    ap.add_argument("func", nargs="?")
    ap.add_argument("--list", action="store_true")
    ap.add_argument("--all", action="store_true",
                    help="also show pseudos with no hard-reg home")
    ap.add_argument("--keep", help="keep dumps in this directory")
    a = ap.parse_args()

    src = (ROOT / a.src).resolve()
    tmp, i_file, cc1, flags = compile_dumps(src, a.keep)
    lreg = split_functions(Path(str(i_file) + ".lreg").read_text(errors="replace"))
    greg = split_functions(Path(str(i_file) + ".greg").read_text(errors="replace"))

    if a.list or not a.func:
        print(f"cc1={cc1}\nflags={' '.join(flags)}\nfunctions:")
        for f in lreg:
            print("   ", f)
        return

    fn = a.func
    if fn not in lreg:
        cand = [k for k in lreg if k.startswith(fn)]
        sys.exit(f"{fn!r} not in dump; candidates: {cand[:8]}")

    regs, homes = parse_lreg(lreg[fn])
    order, conflicts, prefs, disp = parse_greg(greg.get(fn, ""))

    print(f"== {fn}   cc1={Path(cc1).name}  flags={' '.join(flags)}")
    print(f"   dumps: {i_file}.lreg / .greg / .loop")

    locals_ = {n: r for n, r in regs.items() if r["block"] is not None}
    globals_ = {n: r for n, r in regs.items() if r["block"] is None}

    print("\n-- LOCAL-ALLOC QTYS (block-local pseudos; local_alloc runs FIRST "
          "and its handout BLOCKS global.c) --")
    print(f"{'pseudo':>7}{'blk':>5}{'refs':>6}{'live':>6}{'sz':>4}{'calls':>6}"
          f"{'pri':>9}  home")
    for n in sorted(locals_, key=lambda x: (locals_[x]["block"], -pri(locals_[x]))):
        r = locals_[n]
        h = homes.get(n)
        if h is None and not a.all:
            continue
        print(f"{n:>7}{r['block']:>5}{r['refs']:>6}{r['live']:>6}{r['size']:>4}"
              f"{r['calls']:>6}{pri(r):>9}  "
              f"{hname(h) if h is not None else '-'}"
              f"{'  ptr' if r['ptr'] else ''}")

    print("\n-- GLOBAL ALLOCNOS (global.c order = the ORDER THEY WERE ALLOCATED) --")
    if not order:
        print("   (none -- every pseudo in this fn is block-local; the whole "
              "register assignment is local_alloc's)")
    else:
        print(f"{'rank':>5}{'pseudo':>8}{'refs':>6}{'live':>6}{'sz':>4}"
              f"{'calls':>6}{'pri':>9}  home   prefs / conflicts")
        for i, n in enumerate(order):
            r = globals_.get(n) or regs.get(n)
            h = disp.get(n, homes.get(n))
            if r is None:
                print(f"{i:>5}{n:>8}   (no flow record)")
                continue
            p = ",".join(prefs.get(n, [])) or "-"
            c = " ".join(conflicts.get(n, []))
            print(f"{i:>5}{n:>8}{r['refs']:>6}{r['live']:>6}{r['size']:>4}"
                  f"{r['calls']:>6}{pri(r):>9}  "
                  f"{hname(h) if h is not None else '-':<6} {p:<8} {c}")

    if disp:
        print("\n-- dispositions (post-reload) --")
        print("   " + "  ".join(f"{n}->{hname(h)}" for n, h in sorted(disp.items())))
    lost = [n for n in (order or []) if disp.get(n, -1) < 0]
    if lost:
        print(f"   SPILLED: {lost}")


if __name__ == "__main__":
    main()
