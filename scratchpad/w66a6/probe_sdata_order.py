#!/usr/bin/env python3
"""W66-A6 probe E: does the .sdata section attribute reproduce RETAIL's ORDER?

Builds audiocmn.cpp with the five 8-byte objects carrying
`__attribute__((section(".sdata")))`, dumps the object's .sdata symbols sorted
by offset, and diffs that ORDER (and the inter-symbol deltas) against retail's
VA order taken from the `/* @0x8013cXXX */` breadcrumbs in the source.

Usage: python scratchpad/w66a6/probe_sdata_order.py
"""
import importlib.util
import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
spec = importlib.util.spec_from_file_location("bld", ROOT / "tools" / "build.py")
bld = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)

REL = "recon/game/common/audiocmn.cpp"
SRC = ROOT / REL
SYMS = ["bestLapTime", "gtotallaptimes", "AudioCmn_gPlayerArrested",
        "currentWindVal", "nextWindVal"]
OBJD = str(Path(r"C:/Tools/mips-ps1/mips/bin") / "mipsel-none-elf-objdump.exe")
PRIV = Path(__file__).resolve().parent / ("ebuild_%d" % os.getpid())
ATTR = b' __attribute__((section(".sdata")))'
DECL_RE = re.compile(
    r"^(?:char|int|short|u_char|u_int|void)\s+\*?\s*(\w+)(?:\[\d*\])?"
    r"[^;]*;\s*/\* @0x([0-9a-f]{8})", re.M)


def retail_map(text):
    """name -> retail VA, from the breadcrumb comments."""
    return {m.group(1): int(m.group(2), 16) for m in DECL_RE.finditer(text)}


def obj_sdata(obj):
    out = subprocess.run([OBJD, "-t", str(obj)], capture_output=True,
                         text=True).stdout
    rows = []
    for ln in out.split("\n"):
        p = ln.split()
        if len(p) >= 5 and ".sdata" in ln:
            try:
                rows.append((int(p[0], 16), p[-1]))
            except ValueError:
                pass
    return sorted(set(rows))


def patch(raw):
    out = raw
    for s in SYMS:
        pat = re.compile(rb"^(int\s+%s\[2\])(;)" % s.encode(), re.M)
        new, n = pat.subn(rb"\1" + ATTR + rb"\2", out)
        assert n == 1, "anchor count %d for %s" % (n, s)
        out = new
    return out


def write_bytes(path, data):
    tmp = path.with_suffix(path.suffix + ".w66a6tmp")
    tmp.write_bytes(data)
    assert tmp.stat().st_size == len(data)
    os.replace(tmp, path)


if __name__ == "__main__":
    orig = SRC.read_bytes()
    rmap = retail_map(orig.decode("utf-8", "replace"))
    try:
        write_bytes(SRC, patch(orig))
        bld.OUT = PRIV / "attr"
        obj = bld.compile_cpp(SRC)
        rows = obj_sdata(obj)
    finally:
        write_bytes(SRC, orig)
        assert SRC.read_bytes() == orig, "RESTORE FAILED"

    print("ours .sdata order (offset, name, retailVA, retail-order-rank)")
    known = [(o, n, rmap[n]) for o, n in rows if n in rmap]
    ranks = {n: i for i, (_, n) in enumerate(
        sorted([(rmap[n], n) for _, n, _ in known]))}
    prev_o = prev_v = None
    bad = 0
    for o, n, v in known:
        do = "" if prev_o is None else "+%d" % (o - prev_o)
        dv = "" if prev_v is None else "+%d" % (v - prev_v)
        flag = "" if do == dv else "   <-- DELTA MISMATCH"
        if flag:
            bad += 1
        print("  0x%04x %-30s 0x%08x  d_ours=%-5s d_retail=%-5s%s"
              % (o, n, v, do or "-", dv or "-", flag))
        prev_o, prev_v = o, v
    ours_rank = [ranks[n] for _, n, _ in known]
    print("ORDER MATCHES RETAIL: %s" % (ours_rank == sorted(ours_rank)))
    print("delta mismatches: %d / %d" % (bad, max(0, len(known) - 1)))
    print("symbols in our .sdata with no retail breadcrumb: %s"
          % [n for _, n in rows if n not in rmap])
