#!/usr/bin/env python3
"""W66-A6 probe: can the PER_FN_G8 region splice express DATA placement?

Compiles recon/game/common/audiocmn.cpp into a PRIVATE output tree (never the
shared build/) under three configurations and reports, for the five 8-byte
objects retail keeps in .sdata, which section each lands in:

  A  baseline            (PER_FN_G8 as wired: {AudioCmn_Init})
  B  per-fn -G8 on EVERY function in the TU
  C  whole-TU -G8        (PER_TU_FLAGS g_value=8)

Usage:  python scratchpad/w66a6/probe_g8_data.py
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
PRIV = Path(__file__).resolve().parent / ("pbuild_%d" % os.getpid())


def all_fn_names(s_text):
    return sorted(set(re.findall(r"^\t\.ent\t(\S+)", s_text, re.M)))


def section_of(s_text, sym):
    """Walk the .s linearly tracking the current section directive; return the
    section in force at `sym:`'s label."""
    cur = ".text"
    for ln in s_text.split("\n"):
        st = ln.strip()
        if st in (".data", ".sdata", ".rdata", ".text", ".sbss", ".bss"):
            cur = st
        elif st.startswith(".section"):
            cur = st
        elif st == sym + ":":
            return cur
    return "<absent>"


def objdump_sections(obj):
    out = subprocess.run([OBJD, "-t", str(obj)], capture_output=True,
                         text=True).stdout
    res = {}
    for ln in out.split("\n"):
        for s in SYMS:
            if ln.rstrip().endswith(" " + s):
                res[s] = ln.split()[3] if len(ln.split()) > 4 else "?"
    return res


def run_cfg(tag, fn_names=None, g_value=None):
    bld.OUT = PRIV / tag
    bld.PER_FN_G8[REL] = set(fn_names) if fn_names is not None else {"AudioCmn_Init__Fv"}
    if g_value is None:
        bld.PER_TU_FLAGS.get(REL, {}).pop("g_value", None)
    else:
        bld.PER_TU_FLAGS.setdefault(REL, {})["g_value"] = g_value
    obj = bld.compile_cpp(SRC)
    s_text = (bld.OUT / (REL + ".s")).read_text(errors="replace")
    print("=== %s ===" % tag)
    print("   spliced fns: %d" % len(bld.PER_FN_G8[REL]))
    secs = objdump_sections(obj)
    for s in SYMS:
        print("   %-28s .s-section=%-8s obj-section=%s"
              % (s, section_of(s_text, s), secs.get(s, "?")))
    return s_text


if __name__ == "__main__":
    base_s = run_cfg("A_baseline")
    fns = all_fn_names(base_s)
    print("   (TU has %d .ent functions)" % len(fns))
    run_cfg("B_perfn_all", fn_names=fns)
    run_cfg("C_wholeTU_g8", g_value=8)
