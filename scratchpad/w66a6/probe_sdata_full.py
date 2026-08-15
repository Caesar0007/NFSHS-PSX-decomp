#!/usr/bin/env python3
"""W66-A6 probe F: the FULL .sdata window recipe for audiocmn.cpp.

Two levers applied together, both storage-only:
  (1) `__attribute__((section(".sdata")))` on the five 8-byte objects that -G4
      exiles to .data   -- the per-fn -G8 substitute (probe D proved text-neutral);
  (2) the W64-16E "=0 pair" lever: an explicit initialiser on every zero-init
      object of the run, so cc1plus emits ONE batch in DECLARATION order instead
      of {initialised batch, then tentative batch}.

Reports the resulting .sdata order/deltas vs retail and whether the TEXT is
byte-identical to the control build.  Source is always restored.

Usage: python scratchpad/w66a6/probe_sdata_full.py [--only-attr]
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
BIG = ["bestLapTime", "gtotallaptimes", "AudioCmn_gPlayerArrested",
       "currentWindVal", "nextWindVal"]
OBJD = str(Path(r"C:/Tools/mips-ps1/mips/bin") / "mipsel-none-elf-objdump.exe")
PRIV = Path(__file__).resolve().parent / ("fbuild_%d" % os.getpid())
ATTR = ' __attribute__((section(".sdata")))'
# the retail .sdata run: trackMusicState .. AudioCmn_ThunderDel
RUN_LO, RUN_HI = 0x8013C628, 0x8013C71C
DECL_RE = re.compile(
    r"^(?P<ty>char|int|short|u_char|u_int|void)\s+(?P<star>\*?)\s*(?P<nm>\w+)"
    r"(?P<arr>\[\d*\])?(?P<init>\s*=[^;]*)?;(?P<tail>\s*/\* @0x(?P<va>[0-9a-f]{8}))",
    re.M)


def retail_map(text):
    return {m.group("nm"): int(m.group("va"), 16) for m in DECL_RE.finditer(text)}


def obj_sdata(obj):
    out = subprocess.run([OBJD, "-t", str(obj)], capture_output=True,
                         text=True).stdout
    rows = []
    for ln in out.split("\n"):
        p = ln.split()
        if len(p) >= 5 and ".sdata" in ln and not p[-1].startswith("."):
            try:
                rows.append((int(p[0], 16), p[-1]))
            except ValueError:
                pass
    return sorted(set(rows))


def text_words(obj):
    out = subprocess.run([OBJD, "-d", "-z", str(obj)], capture_output=True,
                         text=True).stdout
    return re.findall(r"^\s+[0-9a-f]+:\t([0-9a-f ]+)\t", out, re.M)


def patch(text, only_attr=False):
    n_attr = n_init = 0

    def sub(m):
        nonlocal n_attr, n_init
        va = int(m.group("va"), 16)
        nm, arr, init = m.group("nm"), m.group("arr") or "", m.group("init")
        ty, star = m.group("ty"), m.group("star")
        attr = ATTR if nm in BIG else ""
        if attr:
            n_attr += 1
        if init is None and not only_attr and RUN_LO <= va <= RUN_HI:
            if arr:
                cnt = int(arr[1:-1] or "1")
                init = " = {" + ", ".join(["0"] * cnt) + "}"
            else:
                init = " = 0"
            n_init += 1
        return "%s %s%s%s%s%s;%s" % (ty, star, nm, arr, attr, init or "",
                                     m.group("tail"))

    out = DECL_RE.sub(sub, text)
    return out, n_attr, n_init


def write_text(path, s):
    data = s.encode("utf-8")
    tmp = path.with_suffix(path.suffix + ".w66a6tmp")
    tmp.write_bytes(data)
    assert tmp.stat().st_size == len(data)
    os.replace(tmp, path)


def report(rows, rmap, label):
    known = [(o, n, rmap[n]) for o, n in rows if n in rmap and RUN_LO <= rmap[n] <= RUN_HI]
    print("=== %s : %d symbols of the retail run ===" % (label, len(known)))
    prev_o = prev_v = None
    bad = 0
    for o, n, v in known:
        do = None if prev_o is None else o - prev_o
        dv = None if prev_v is None else v - prev_v
        if do is not None and do != dv:
            bad += 1
            print("   0x%04x %-30s 0x%08x  d_ours=%-4s d_retail=%-4s  <-- MISMATCH"
                  % (o, n, v, do, dv))
        prev_o, prev_v = o, v
    order_ok = [rmap[n] for _, n, _ in known] == sorted(rmap[n] for _, n, _ in known)
    print("   ORDER MATCHES RETAIL: %s   delta mismatches: %d/%d"
          % (order_ok, bad, max(0, len(known) - 1)))
    return bad, order_ok


if __name__ == "__main__":
    only_attr = "--only-attr" in sys.argv
    orig = SRC.read_bytes()
    text = orig.decode("utf-8")
    rmap = retail_map(text)
    try:
        bld.OUT = PRIV / "ctl"
        obj0 = bld.compile_cpp(SRC)
        t0 = text_words(obj0)
        report(obj_sdata(obj0), rmap, "CONTROL")
        new, na, ni = patch(text, only_attr)
        print("[patch] %d section attributes, %d added initialisers" % (na, ni))
        write_text(SRC, new)
        bld.OUT = PRIV / "pat"
        obj1 = bld.compile_cpp(SRC)
        t1 = text_words(obj1)
        report(obj_sdata(obj1), rmap, "PATCHED")
        print("TEXT BYTE-IDENTICAL: %s  (%d vs %d words)"
              % (t0 == t1, len(t0), len(t1)))
        if t0 != t1:
            d = [i for i, (a, b) in enumerate(zip(t0, t1)) if a != b]
            print("   first differing word index: %s" % (d[:5]))
        (Path(__file__).resolve().parent / "audiocmn.cpp.patched").write_bytes(new.encode("utf-8"))
    finally:
        Path(SRC).write_bytes(orig)
        assert SRC.read_bytes() == orig, "RESTORE FAILED"
        print("[restored] %s" % REL)
