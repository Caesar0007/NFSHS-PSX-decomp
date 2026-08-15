#!/usr/bin/env python3
"""W64-A19 pass 4: the AMBIGUOUS ALIAS rows.

The wrong mangling `Base__FP<len><Class><rest>` names its receiver explicitly:
the FIRST parameter is a pointer to the class whose member the call really is.
Pick the unique defined candidate `Base__<len><Class>...`; refuse (report) when
that is not unique or when the receiver is `Pv` (an opaque `void *` receiver --
only the call site can say which class it is).
"""
import importlib.util
import json
import re
import subprocess
import sys
import collections
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
spec = importlib.util.spec_from_file_location("bld", ROOT / "tools" / "build.py")
bld = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
NM = "C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm"

sys.path.insert(0, str(ROOT / "scratchpad/w64a19"))
import apply_alias3 as A3           # reuse the scanner + helpers

MANUAL = {
    # symbol -> retail name, decided at the call site (see RECEIPTS)
}


def receiver(sym):
    """-> (base, class, argstring) for both the flattened free-fn form
    Base__FP<len><Class><args> and the method form Base__<len><Class><args>."""
    m = re.match(r"^(.*)__FP(\d+)([A-Za-z_]\w*)$", sym)
    if m:
        base, ln, rest = m.group(1), int(m.group(2)), m.group(3)
        return base, rest[:ln], rest[ln:]
    m = re.match(r"^(.*)__(\d+)([A-Za-z_]\w*)$", sym)
    if m:
        base, ln, rest = m.group(1), int(m.group(2)), m.group(3)
        return base, rest[:ln], rest[ln:]
    return None, None, None


def nargs(a):
    """crude arg counter for a gcc2 mangled arg string"""
    n, i = 0, 0
    while i < len(a):
        c = a[i]
        if c in "PRUCV":
            i += 1
            continue
        if c.isdigit():
            j = i
            while j < len(a) and a[j].isdigit():
                j += 1
            ln = int(a[i:j])
            i = j + ln
            n += 1
            continue
        i += 1
        n += 1
    return n


def main():
    rows = json.loads((ROOT / "scratchpad/w64a19/unres_classified.json").read_text())
    SA = set()
    for line in (ROOT / "configs/symbol_addrs.txt").read_text().splitlines():
        m = re.match(r"^\s*(\S+)\s*=", line)
        if m:
            SA.add(m.group(1))
    want_of, unresolved = {}, []
    for r in rows:
        if r["kind"] != "ALIAS":
            continue
        cands = [c for c in r["cands"] if c in SA]
        if len(cands) == 1:
            continue                      # handled by passes 1-3
        sym = r["sym"]
        if sym in MANUAL:
            want_of[sym] = (MANUAL[sym], r["objs"])
            continue
        base, cls, args = receiver(sym)
        if not cls or cls == "v":
            unresolved.append((sym, "no class receiver", r["objs"], cands))
            continue
        pref = f"{base}__{len(cls)}{cls}"
        hit = [c for c in cands if c.startswith(pref)]
        if len(hit) > 1:
            want_n = nargs(args)
            hit2 = [c for c in hit if nargs(c[len(pref):]) == want_n]
            if len(hit2) == 1:
                hit = hit2
        if len(hit) != 1:
            unresolved.append((sym, f"{len(hit)} cands for {pref}", r["objs"], hit or cands))
            continue
        want_of[sym] = (hit[0], r["objs"])

    bytu = collections.defaultdict(list)
    for sym, (want, objs) in want_of.items():
        for o in objs:
            src = re.sub(r"\.o$", "", o.split("build/")[-1])
            if (ROOT / src).exists():
                bytu[src].append((sym, want))

    log, fixed, failed = [], [], []
    for src in sorted(bytu):
        if src in A3.BLOCKED:
            log.append(f"[BLOCKED TU] {src}: {[s for s, _ in bytu[src]]}")
            failed += [(s, src, "blocked TU") for s, _ in bytu[src]]
            continue
        U0, D0 = A3.syms(A3.compile_one(src))
        own = Path(src).stem + "_externs.h"

        def prio(f):
            n = Path(f).name
            if f == src:
                return 0
            if n == own:
                return 1
            if n.endswith("_externs.h"):
                return 2
            if f.startswith("recon/lib/"):
                return 4
            return 3
        cf = [src] + [str(f.relative_to(ROOT)).replace("\\", "/")
                      for f in sorted(A3.includes(ROOT / src)) if f.suffix == ".h"]
        cf = [f for f in dict.fromkeys(cf) if f not in A3.BLOCKED and (ROOT / f).exists()]
        cf.sort(key=prio)
        for sym, want in bytu[src]:
            if sym not in U0:
                continue
            i = sym.find("__")
            base = sym[:i]
            pat = re.compile(r"(?<![A-Za-z0-9_])" + re.escape(base) + r"\s*\(")
            done = False
            for f in cf:
                data = (ROOT / f).read_bytes()
                for idx, pos in A3.scan_decls(data, pat):
                    ls = data.split(b"\n")
                    L = ls[idx].decode("latin-1")
                    ls[idx] = (L[:pos] + f' asm("{want}")' + L[pos:]).encode("latin-1")
                    (ROOT / f).write_bytes(b"\n".join(ls))
                    try:
                        U1, D1 = A3.syms(A3.compile_one(src))
                    except Exception as e:
                        (ROOT / f).write_bytes(data)
                        log.append(f"  FAILCOMPILE {f}:{idx+1} {e}")
                        continue
                    if sym not in U1 and (U1 - U0) <= {want} and D1 == D0:
                        log.append(f"  OK {src}: {sym} -> {want}  @{f}:{idx+1}")
                        fixed.append((sym, want, f, idx + 1, src))
                        U0, D0 = U1, D1
                        done = True
                        break
                    (ROOT / f).write_bytes(data)
                    log.append(f"  reject {f}:{idx+1} for {sym} (still={sym in U1}"
                               f" new={sorted(U1-U0)[:3]})")
                if done:
                    break
            if not done:
                failed.append((sym, src, "no working decl"))
                log.append(f"  MISS {src}: {sym} -> {want}")
        A3.compile_one(src)

    log.append(f"PASS5 FIXED {len(fixed)} / FAILED {len(failed)}")
    log.append("=== NOT AUTO-RESOLVABLE ===")
    for u in unresolved:
        log.append(f"  {u[0]}  ({u[1]})  objs={[x.split('build/')[-1] for x in u[2]]}"
                   f"  cands={u[3][:6]}")
    (ROOT / "scratchpad/w64a19/apply_log5.txt").write_text("\n".join(log) + "\n")
    json.dump({"fixed": fixed, "failed": failed, "unresolved": unresolved},
              open(ROOT / "scratchpad/w64a19/apply_result5.json", "w"), indent=1)
    print("\n".join(log[-40:]))


main()
