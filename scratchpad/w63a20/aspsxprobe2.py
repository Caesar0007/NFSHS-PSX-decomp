#!/usr/bin/env python3
"""aspsxprobe2.py -- second construct table (directives + alias shapes)."""
import subprocess
import tempfile
from pathlib import Path

ASPSX = Path(r"C:/Temp/psq43/PSSN/ASPSX.EXE")


def run(text):
    with tempfile.TemporaryDirectory() as td:
        s = Path(td) / "p.s"
        s.write_bytes(text.replace("\n", "\r\n").encode("ascii", "replace"))
        o = Path(td) / "p.obj"
        r = subprocess.run([str(ASPSX), "-o", str(o), str(s)],
                           capture_output=True, text=True, cwd=td)
        blob = r.stdout + r.stderr
        ok = o.exists() and " : Error : " not in blob
        err = ""
        if not ok:
            for ln in blob.splitlines():
                if " : Error : " in ln:
                    err = ln.split(" : Error : ")[-1].strip()
                    break
        return ok, err


BASE = "\t.text\n\t.globl\tprobe_fn\nprobe_fn:\n\tjr\t$31\n\tnop\n"

CASES = [
    (".type only",        BASE + "\t.type\tprobe_fn,@function\n"),
    (".size only",        BASE + "\t.size\tprobe_fn,0xa8\n"),
    (".set noat alone",   "\t.text\n\t.set\tnoat\n" + BASE),
    (".set at alone",     "\t.text\n\t.set\tat\n" + BASE),
    (".set push alone",   "\t.text\n\t.set\tpush\n" + BASE),
    (".set pop alone",    "\t.text\n\t.set\tpop\n" + BASE),
    (".set nomacro",      "\t.text\n\t.set\tnomacro\n" + BASE + "\t.set\tmacro\n"),
    (".set volatile",     "\t.text\n\t.set\tvolatile\n" + BASE),
    (".set mips1",        "\t.text\n\t.set\tmips1\n" + BASE),
    ("alias via 2 labels+globl",
     "\t.text\n\t.globl\tprobe_fn\n\t.globl\tp_alias\nprobe_fn:\np_alias:\n\tjr\t$31\n\tnop\n"),
    ("alias label AFTER globl-later",
     "\t.text\n\t.globl\tprobe_fn\nprobe_fn:\np_alias:\n\t.globl\tp_alias\n\tjr\t$31\n\tnop\n"),
    ("weak/hidden",       BASE + "\t.weak\tp_alias\n"),
    ("ent/end",           "\t.text\n\t.globl\tprobe_fn\n\t.ent\tprobe_fn\nprobe_fn:\n\tjr\t$31\n\tnop\n\t.end\tprobe_fn\n"),
    ("$L label",          "\t.text\nprobe_fn:\n$L1:\n\tb\t$L1\n\tnop\n"),
    (".L label",          "\t.text\nprobe_fn:\n.L1:\n\tb\t.L1\n\tnop\n"),
    ("li big",            BASE.replace("\tjr", "\tli\t$8,0x12345\n\tjr")),
    ("la sym",            "\t.text\nprobe_fn:\n\tla\t$8,probe_fn\n\tjr\t$31\n\tnop\n"),
    ("lwl/swl $12",       "\t.text\nprobe_fn:\n\tlwl\t$14,2($4)\n\tswl\t$14,2($5)\n\tjr\t$31\n\tnop\n"),
    ("mfc2/cop2 word",    "\t.text\nprobe_fn:\n\tmfc2\t$2,$12\n\t.word\t0x4a180001\n\tjr\t$31\n\tnop\n"),
    ("rem 3-op $0 noat",  "\t.text\n\t.set\tnoat\nprobe_fn:\n\trem\t$0,$4,$5\n\tjr\t$31\n\tnop\n"),
    ("mflo/mfhi",         "\t.text\nprobe_fn:\n\tmflo\t$2\n\tmfhi\t$3\n\tjr\t$31\n\tnop\n"),
    ("noat + lui/ori",    "\t.text\n\t.set\tnoat\nprobe_fn:\n\tlui\t$1,0x1234\n\tori\t$1,$1,0x5678\n\tjr\t$31\n\tnop\n"),
    ("noat + sw abs",     "\t.text\n\t.set\tnoat\nprobe_fn:\n\tsw\t$2,glob\n\tjr\t$31\n\tnop\n"),
]

for name, text in CASES:
    ok, err = run(text)
    print("%-30s %s  %s" % (name, "ACCEPT" if ok else "REJECT", err))
