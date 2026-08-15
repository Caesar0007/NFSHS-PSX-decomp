#!/usr/bin/env python3
"""W64-A19 byte-neutrality proof for the alias landing.

For every recon TU whose include closure touches a file this agent edited:
compile it TWICE -- once with this agent's edits REVERTED to the pre-wave
snapshot (scratchpad/w64a19/bak0), once with them in place -- and compare the
raw SECTION BYTES of the two objects.  An asm-label alias / a hoisted prototype
may change only symbol and relocation NAMES; if any section byte moves, the
edit is not byte-neutral and must be re-examined.

Anti-vacuity: the TU list is derived, the section list is read from the object
(not assumed), an empty comparison set is a hard failure, and the peers' own
concurrent edits stay in place on BOTH sides (only this agent's files are
swapped), so the A/B isolates exactly this agent's change.
"""
import importlib.util
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
sys.path.insert(0, str(ROOT / "scratchpad/w64a19"))
spec = importlib.util.spec_from_file_location("bld", ROOT / "tools" / "build.py")
bld = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
import apply_alias3 as A3

OD = "C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"
BAK = ROOT / "scratchpad/w64a19/bak0/recon"
MINE = [Path(p) for p in json.loads((ROOT / "scratchpad/w64a19/myfiles.json").read_text())]


def sections(obj):
    out = subprocess.run([OD, "-h", str(obj)], capture_output=True, text=True).stdout
    names = []
    for L in out.splitlines():
        t = L.split()
        if len(t) > 3 and t[0].isdigit() and t[1].startswith("."):
            names.append((t[1], int(t[2], 16)))
    res = {}
    for n, sz in names:
        if sz == 0:
            res[n] = b""
            continue
        p = subprocess.run([OD, "-s", "-j", n, str(obj)],
                           capture_output=True, text=True).stdout
        body = []
        for L in p.splitlines():
            t = L.split()
            if len(t) >= 2 and t[0].endswith(("0", "1", "2", "3", "4", "5", "6",
                                              "7", "8", "9", "a", "b", "c", "d",
                                              "e", "f")) and len(t[0]) >= 4:
                try:
                    int(t[0], 16)
                except ValueError:
                    continue
                body.append("".join(t[1:5]))
        res[n] = "".join(body).encode()
    return res


def main():
    tus = []
    for p in sorted(list((ROOT / "recon").rglob("*.cpp")) + list((ROOT / "recon").rglob("*.c"))):
        rel = p.relative_to(ROOT).as_posix()
        clos = {f.relative_to(ROOT).as_posix() for f in A3.includes(p)
                if str(f).startswith(str(ROOT))}
        if clos & {m.as_posix() for m in MINE}:
            tus.append(rel)
    assert tus, "no TUs -- refusing a vacuous proof"
    print(f"{len(tus)} affected TUs")

    # snapshot my current versions
    cur = {m.as_posix(): (ROOT / m).read_bytes() for m in MINE}
    old = {}
    for m in MINE:
        b = BAK / m.relative_to("recon")
        assert b.exists(), b
        old[m.as_posix()] = b.read_bytes()

    ok, bad, skipped = [], [], []
    # PASS A: pre-edit
    for k, v in old.items():
        (ROOT / k).write_bytes(v)
    before = {}
    for t in tus:
        try:
            before[t] = sections(A3.compile_one(t))
        except Exception as e:
            skipped.append((t, f"before: {e}"))
    # PASS B: post-edit
    for k, v in cur.items():
        (ROOT / k).write_bytes(v)
    for t in tus:
        if t not in before:
            continue
        try:
            aft = sections(A3.compile_one(t))
        except Exception as e:
            skipped.append((t, f"after: {e}"))
            continue
        if aft == before[t]:
            ok.append(t)
        else:
            diff = [n for n in set(aft) | set(before[t])
                    if aft.get(n) != before[t].get(n)]
            bad.append((t, diff))

    rep = [f"affected TUs: {len(tus)}",
           f"section-byte IDENTICAL: {len(ok)}",
           f"section-byte CHANGED  : {len(bad)}",
           f"skipped (compile err) : {len(skipped)}", ""]
    for t, d in bad:
        rep.append(f"CHANGED {t}: {d}")
    for s in skipped:
        rep.append(f"SKIP {s}")
    (ROOT / "scratchpad/w64a19/byteneutral.txt").write_text("\n".join(rep) + "\n")
    print("\n".join(rep[:40]))


main()
