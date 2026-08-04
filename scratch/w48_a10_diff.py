# -*- coding: utf-8 -*-
"""w48-a10 DIFFERENTIAL: same cc1 .s -> (real ASPSX) vs (maspsx+GNU as).

Prints the two word streams side by side so any assembler-side divergence is
visible instantly.  This is the instrument that turns "does aspsx do X?" from
an inference into a measurement.

usage: python w48_a10_diff.py <file.s> [--asm 2.77] [-G 4] [--fn NAME]
"""
import os, re, struct, subprocess, sys, tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import importlib
snasm = importlib.import_module("w48_a10_snasm")

MASPSX = os.environ.get("NFS4_MASPSX", r"C:/Temp/maspsx-master/maspsx.py")
AS = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-as.exe"
OBJDUMP = r"C:\Tools\mips-ps1\mips\bin\mipsel-none-elf-objdump.exe"


def via_maspsx(src, g="4"):
    obj = os.path.splitext(src)[0] + "_maspsx.o"
    txt = open(src, "rb").read().replace(b"\r\n", b"\n").decode("latin1")
    cmd = [sys.executable, MASPSX, "--aspsx-version=2.77", "--expand-div",
           "--run-assembler", "--gnu-as-path=" + AS,
           "-EL", "-march=r3000", "-mtune=r3000", "-no-pad-sections",
           "-O1", "-G" + g, "-o", obj]
    r = subprocess.run(cmd, input=txt, capture_output=True, text=True)
    if not os.path.exists(obj):
        sys.stderr.write(r.stdout + r.stderr)
        raise SystemExit("maspsx failed")
    return obj


def elf_words(obj, fn=None):
    out = subprocess.run([OBJDUMP, "-d", obj], capture_output=True, text=True).stdout
    res = []
    for ln in out.splitlines():
        m = re.match(r"\s*([0-9a-f]+):\s+([0-9a-f]{8})\s+(.*)$", ln)
        if m:
            res.append((int(m.group(1), 16), int(m.group(2), 16), m.group(3).strip()))
    return res


def main():
    a = sys.argv[1:]
    src = a[0]
    ver = a[a.index("--asm") + 1] if "--asm" in a else "2.77"
    g = a[a.index("-G") + 1] if "-G" in a else "4"
    obj, _ = snasm.assemble(src, ver, ["-G" + g] if g != "4" else None)
    o = snasm.parse(obj)
    sec = max(o.code, key=lambda k: len(o.code[k]))
    sn = snasm.disasm(o.code[sec])
    rel = o.relocs.get(sec, {})
    me = elf_words(via_maspsx(src, g))
    print("# ASPSX %s  (%d insns)      |  maspsx+as (%d insns)" % (ver, len(sn), len(me)))
    n = max(len(sn), len(me))
    for i in range(n):
        A = "%08x %-34s" % (sn[i][1], sn[i][2]) if i < len(sn) else " " * 43
        B = "%08x %-34s" % (me[i][1], me[i][2]) if i < len(me) else ""
        same = (i < len(sn) and i < len(me) and
                (sn[i][1] == me[i][1] or
                 (sn[i][0] in rel and (sn[i][1] >> 26) == (me[i][1] >> 26))))
        print("%3d %s | %s %s" % (i, A, B, "" if same else "   <<< DIFF"))


main()
