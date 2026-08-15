#!/usr/bin/env python3
"""W64-A19: land the ALIAS class empirically.

For every referencing TU and every wrong-mangling reference it emits, try each
candidate DECLARATION (the TU itself + the *_externs.h files it includes) by
appending an asm-label alias, recompile, and keep the edit only if:
  * the wrong symbol disappears from the TU's undefined set, AND
  * no NEW undefined symbol appears, AND
  * the TU's DEFINED symbol set is unchanged.
Otherwise revert.  Byte-neutrality is checked separately by the gate.

--dry lists the plan without editing.
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

BLOCKED = {
    "recon/nfs4_types.h",
    "recon/frontend/common/fedialog_externs.h",
    "recon/frontend/common/femenuextended_externs.h",
    "recon/frontend/common/screenusername_externs.h",
    "recon/frontend/common/femenudefs.cpp",
    "recon/frontend/common/femenu.cpp",
    "recon/frontend/common/fetv.cpp",
    "recon/frontend/common/screenpost.cpp",
    "recon/frontend/common/screenusername.cpp",
    "recon/lib/libfns.h",
    "recon/frontend/psx/psxfront.cpp",
}

inc_re = re.compile(r'^\s*#\s*include\s+"([^"]+)"')


def includes(p, seen=None):
    if seen is None:
        seen = set()
    p = p.resolve()
    if p in seen or not p.exists():
        return seen
    seen.add(p)
    for L in p.read_text(errors="replace").splitlines():
        m = inc_re.match(L)
        if m:
            cand = p.parent / m.group(1)
            if not cand.exists():
                for root in (ROOT / "recon", ROOT / "recon/lib"):
                    c2 = root / m.group(1)
                    if c2.exists():
                        cand = c2
                        break
            if cand.exists():
                includes(cand, seen)
    return seen


def rd(p):
    return (ROOT / p).read_bytes()


def wr(p, data):
    (ROOT / p).write_bytes(data)


def lines_of(data):
    return data.split(b"\n")


def compile_one(rel):
    p = ROOT / rel
    return bld.compile_c(p, skip_asm=False) if p.suffix == ".c" else bld.compile_cpp(p)


def syms(obj):
    out = subprocess.run([NM, str(obj)], capture_output=True, text=True).stdout
    u, d = set(), set()
    for L in out.splitlines():
        t = L.split()
        if not t:
            continue
        if t[0] == "U":
            u.add(t[1])
        elif len(t) >= 3:
            d.add(t[2])
    return u, d


def obj2src(o):
    return re.sub(r"\.o$", "", o.split("build/")[-1])


def main():
    dry = "--dry" in sys.argv
    rows = json.loads((ROOT / "scratchpad/w64a19/unres_classified.json").read_text())
    SA = {}
    for line in (ROOT / "configs/symbol_addrs.txt").read_text().splitlines():
        m = re.match(r"^\s*(\S+)\s*=\s*(0x[0-9A-Fa-f]+)", line)
        if m:
            SA.setdefault(m.group(1), m.group(2))

    bytu = collections.defaultdict(list)
    skipped = []
    for r in rows:
        if r["kind"] != "ALIAS":
            continue
        cands = [c for c in r["cands"] if c in SA]
        if len(cands) != 1:
            skipped.append((r["sym"], r["cands"], cands))
            continue
        for o in r["objs"]:
            src = obj2src(o)
            if (ROOT / src).exists():
                bytu[src].append((r["sym"], cands[0]))

    log = [f"TUs: {len(bytu)}  pairs: {sum(len(v) for v in bytu.values())}",
           f"skipped (ambiguous want): {len(skipped)}"]
    fixed, failed = [], []
    backups = {}

    for src in sorted(bytu):
        if src in BLOCKED:
            log.append(f"[BLOCKED TU] {src}: {[s for s, _ in bytu[src]]}")
            failed += [(s, src, "blocked TU") for s, _ in bytu[src]]
            continue
        obj = compile_one(src)
        U0, D0 = syms(obj)
        closure = sorted(includes(ROOT / src))
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
        cand_files = [src] + [
            str(f.relative_to(ROOT)).replace("\\", "/") for f in closure
            if f.suffix == ".h"
        ]
        cand_files = [f for f in dict.fromkeys(cand_files) if f not in BLOCKED
                      and (ROOT / f).exists()]
        cand_files.sort(key=prio)
        for sym, want in bytu[src]:
            if sym not in U0:
                log.append(f"  [stale] {src}: {sym} not undefined any more")
                continue
            i = sym.find("__")
            base = sym[:i] if i > 0 else sym
            pat = re.compile(r"(?<![A-Za-z0-9_])" + re.escape(base) + r"\s*\(")
            done = False
            for f in cand_files:
                data = rd(f)
                ls = lines_of(data)
                depth = 0
                incomment = False
                for idx, raw in enumerate(ls):
                    L = raw.decode("latin-1")
                    s = L.strip()
                    d0 = depth
                    # crude but adequate brace-depth / block-comment tracker
                    j, n = 0, len(L)
                    while j < n:
                        if incomment:
                            if L[j:j + 2] == "*/":
                                incomment = False
                                j += 2
                                continue
                        elif L[j:j + 2] == "/*":
                            incomment = True
                            j += 2
                            continue
                        elif L[j:j + 2] == "//":
                            break
                        elif L[j] == "{":
                            depth += 1
                        elif L[j] == "}":
                            depth -= 1
                        j += 1
                    if d0 != 0 or incomment:
                        continue
                    if not pat.search(L) or "asm(" in L:
                        continue
                    if s.startswith(("*", "//", "/*", "#")):
                        continue
                    if "::" in L.split("(")[0]:
                        continue
                    if re.search(r"=[^=]", L.split("(")[0]):
                        continue
                    body = s.rstrip("\r")
                    if not body.endswith(";"):
                        continue
                    # must have a return type token before the name
                    pre = L[:pat.search(L).start()].strip()
                    if not re.search(r"[A-Za-z_*&>\]]\s*$", pre):
                        continue
                    if dry:
                        log.append(f"  DRY {src}: {sym} -> {f}:{idx+1}")
                        done = True
                        break
                    new = L.rstrip("\r\n")
                    cr = "\r" if L.endswith("\r") else ""
                    new = new.rstrip()
                    assert new.endswith(";")
                    new = new[:-1] + f' asm("{want}");' + cr
                    ls2 = list(ls)
                    ls2[idx] = new.encode("latin-1")
                    backups.setdefault(f, data)
                    wr(f, b"\n".join(ls2))
                    try:
                        o2 = compile_one(src)
                        U1, D1 = syms(o2)
                    except Exception as e:
                        wr(f, data)
                        log.append(f"  FAILCOMPILE {src} {sym} @{f}:{idx+1}: {e}")
                        continue
                    if sym not in U1 and (U1 - U0) <= {want} and D1 == D0:
                        log.append(f"  OK {src}: {sym} -> {want}  @{f}:{idx+1}")
                        fixed.append((sym, want, f, idx + 1, src))
                        U0, D0 = U1, D1
                        done = True
                        break
                    wr(f, data)
                    log.append(f"  reject {f}:{idx+1} for {sym}"
                               f" (still={sym in U1} new={sorted(U1-U0)[:3]}"
                               f" defdelta={sorted((D1 ^ D0))[:3]})")
                if done:
                    break
            if not done:
                failed.append((sym, src, "no working decl"))
                log.append(f"  MISS {src}: {sym} -> {want}")
        # recompile clean at end of TU
        compile_one(src)

    log.append("")
    log.append(f"FIXED {len(fixed)} / FAILED {len(failed)}")
    for s, c, sa in skipped:
        log.append(f"  AMBIG {s}  cands={c} in_sa={sa}")
    for f in failed:
        log.append(f"  FAIL {f}")
    (ROOT / "scratchpad/w64a19/apply_log.txt").write_text("\n".join(log) + "\n")
    json.dump({"fixed": fixed, "failed": failed, "skipped": skipped},
              open(ROOT / "scratchpad/w64a19/apply_result.json", "w"), indent=1)
    print("\n".join(log[-40:]))


main()
