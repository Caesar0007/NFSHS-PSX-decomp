#!/usr/bin/env python3
"""W64-A19 pass 2: same empirical alias lander, with a stronger declaration
scanner --  handles trailing block comments after the ';' and declarations that
live inside an `extern "C" { ... }` block (the plain-vs-mangled class).
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
DECL_END = re.compile(r"\)\s*(?:const\s*)?;")


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


def scan_decls(data, pat):
    """yield (idx, semicolon_pos) for candidate declaration lines at effective
    file scope (top level, or inside an `extern "C"` block only)."""
    ls = data.split(b"\n")
    stack = []          # True = extern "C" block
    incomment = False
    pending_extc = False
    for idx, raw in enumerate(ls):
        L = raw.decode("latin-1")
        # an `extern "C"` on this line arms the NEXT '{' as an extern-C block
        if 'extern "C"' in L:
            pending_extc = True
        depth_ok = all(stack)
        line_start_ok = depth_ok
        m = pat.search(L)
        s = L.strip()
        cand = None
        if (line_start_ok and m
                and not incomment
                and not s.startswith(("*", "//", "/*", "#"))
                and "::" not in L[:m.start()]
                and not re.search(r"=[^=]", L[:m.start()])
                and re.search(r"[A-Za-z_*&>\]]\s*$", L[:m.start()].strip() or "x")):
            e = DECL_END.search(L, m.start())
            if e and "asm(" not in L[m.start():e.end()]:
                cand = e.end() - 1
        # advance block state
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
                stack.append(pending_extc)
                pending_extc = False
            elif L[j] == "}":
                if stack:
                    stack.pop()
            j += 1
        if cand is not None:
            yield idx, cand


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


def main():
    prev = json.loads((ROOT / "scratchpad/w64a19/apply_result2.json").read_text())
    todo = [(s, src) for s, src, why in prev["failed"] if why != "blocked TU"]
    rows = json.loads((ROOT / "scratchpad/w64a19/unres_classified.json").read_text())
    SA = set()
    for line in (ROOT / "configs/symbol_addrs.txt").read_text().splitlines():
        m = re.match(r"^\s*(\S+)\s*=", line)
        if m:
            SA.add(m.group(1))
    want_of = {}
    for r in rows:
        if r["kind"] != "ALIAS":
            continue
        c = [x for x in r["cands"] if x in SA]
        if len(c) == 1:
            want_of[r["sym"]] = c[0]

    bytu = collections.defaultdict(list)
    for s, src in todo:
        if s in want_of:
            bytu[src].append(s)

    log, fixed, failed = [], [], []
    for src in sorted(bytu):
        obj = compile_one(src)
        U0, D0 = syms(obj)
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
        cand_files = [src] + [str(f.relative_to(ROOT)).replace("\\", "/")
                              for f in sorted(includes(ROOT / src)) if f.suffix == ".h"]
        cand_files = [f for f in dict.fromkeys(cand_files)
                      if f not in BLOCKED and (ROOT / f).exists()]
        cand_files.sort(key=prio)
        for sym in bytu[src]:
            want = want_of[sym]
            if sym not in U0:
                log.append(f"  [stale] {src}: {sym}")
                continue
            i = sym.find("__")
            base = sym[:i] if i > 0 else sym
            pat = re.compile(r"(?<![A-Za-z0-9_])" + re.escape(base) + r"\s*\(")
            done = False
            for f in cand_files:
                data = rd = (ROOT / f).read_bytes()
                for idx, pos in scan_decls(data, pat):
                    ls = data.split(b"\n")
                    L = ls[idx].decode("latin-1")
                    ls[idx] = (L[:pos] + f' asm("{want}")' + L[pos:]).encode("latin-1")
                    (ROOT / f).write_bytes(b"\n".join(ls))
                    try:
                        U1, D1 = syms(compile_one(src))
                    except Exception as e:
                        (ROOT / f).write_bytes(data)
                        log.append(f"  FAILCOMPILE {src} {sym} @{f}:{idx+1}: {e}")
                        continue
                    if sym not in U1 and (U1 - U0) <= {want} and D1 == D0:
                        log.append(f"  OK {src}: {sym} -> {want}  @{f}:{idx+1}")
                        fixed.append((sym, want, f, idx + 1, src))
                        U0, D0 = U1, D1
                        done = True
                        break
                    (ROOT / f).write_bytes(data)
                    log.append(f"  reject {f}:{idx+1} for {sym}"
                               f" (still={sym in U1} new={sorted(U1-U0)[:3]})")
                if done:
                    break
            if not done:
                failed.append((sym, src, "no working decl"))
                log.append(f"  MISS {src}: {sym} -> {want}")
        compile_one(src)
    log.append(f"PASS3 FIXED {len(fixed)} / FAILED {len(failed)}")
    (ROOT / "scratchpad/w64a19/apply_log3.txt").write_text("\n".join(log) + "\n")
    json.dump({"fixed": fixed, "failed": failed},
              open(ROOT / "scratchpad/w64a19/apply_result3.json", "w"), indent=1)
    print("\n".join(log[-30:]))


if __name__ == "__main__":
    main()
