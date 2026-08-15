#!/usr/bin/env python3
"""W66-A6 probe D: the SECTION-ATTRIBUTE route.

Patches the five 8-byte audiocmn globals with
`__attribute__((section(".sdata")))`, compiles into a PRIVATE tree, and reports
    * which section each object lands in (.s walk + ELF symtab)
    * whether the TEXT of the object is byte-identical to the unpatched build
      (i.e. the change is codegen-neutral -- zero PASS->FAIL risk)
The source file is ALWAYS restored (byte-mode temp + os.replace + size assert).

Usage: python scratchpad/w66a6/probe_sdata_attr.py
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
PRIV = Path(__file__).resolve().parent / ("dbuild_%d" % os.getpid())
ATTR = b' __attribute__((section(".sdata")))'


def section_of(s_text, sym):
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


def symtab(obj):
    out = subprocess.run([OBJD, "-t", str(obj)], capture_output=True,
                         text=True).stdout
    res = {}
    for ln in out.split("\n"):
        p = ln.split()
        if p and p[-1] in SYMS:
            res[p[-1]] = (p[-3] if len(p) >= 4 else "?")
    return res


def text_bytes(obj):
    out = subprocess.run([OBJD, "-d", "-z", str(obj)], capture_output=True,
                         text=True).stdout
    # keep only the encoded words: "  addr:\t xx xx xx xx \tmnemonic..."
    return "\n".join(re.findall(r"^\s+[0-9a-f]+:\t([0-9a-f ]+)\t", out, re.M))


def build(tag):
    bld.OUT = PRIV / tag
    obj = bld.compile_cpp(SRC)
    s_text = (bld.OUT / (REL + ".s")).read_text(errors="replace")
    return obj, s_text


def patch(raw):
    out = raw
    for s in SYMS:
        pat = re.compile(rb"^(int\s+%s\[2\])(;)" % s.encode(), re.M)
        new, n = pat.subn(rb"\1" + ATTR + rb"\2", out)
        assert n == 1, "anchor count %d for %s" % (n, s)
        out = new
    return out


def write_bytes(path, data, must_grow_from=None):
    tmp = path.with_suffix(path.suffix + ".w66a6tmp")
    tmp.write_bytes(data)
    assert tmp.stat().st_size == len(data)
    if must_grow_from is not None:
        assert len(data) >= must_grow_from
    os.replace(tmp, path)


if __name__ == "__main__":
    orig = SRC.read_bytes()
    bak = Path(__file__).resolve().parent / "audiocmn.cpp.bak"
    bak.write_bytes(orig)
    try:
        obj0, s0 = build("ctl")
        t0 = text_bytes(obj0)
        print("=== CONTROL (unpatched) ===")
        st0 = symtab(obj0)
        for s in SYMS:
            print("   %-28s .s=%-8s obj=%s" % (s, section_of(s0, s), st0.get(s)))
        print("   text words: %d lines" % t0.count("\n"))

        write_bytes(SRC, patch(orig), must_grow_from=len(orig))
        obj1, s1 = build("attr")
        t1 = text_bytes(obj1)
        print('=== PATCHED  __attribute__((section(".sdata"))) ===')
        st1 = symtab(obj1)
        for s in SYMS:
            print("   %-28s .s=%-8s obj=%s" % (s, section_of(s1, s), st1.get(s)))
        print("   text words: %d lines" % t1.count("\n"))
        print("   TEXT BYTE-IDENTICAL TO CONTROL: %s" % (t0 == t1))
    finally:
        write_bytes(SRC, orig)
        assert SRC.read_bytes() == orig, "RESTORE FAILED"
        print("[restored] %s (%d bytes)" % (REL, len(orig)))
