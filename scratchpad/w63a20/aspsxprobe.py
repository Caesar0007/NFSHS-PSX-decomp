#!/usr/bin/env python3
"""aspsxprobe.py -- run a fragment of asm through the REAL ASPSX 2.77 and report
accept/reject.  Used to derive the GNU->ASPSX dialect shim rules empirically.

Usage: python aspsxprobe.py            (runs the built-in construct table)
       python aspsxprobe.py FILE.s     (probes one file verbatim)

ASPSX needs CRLF input (W63 BRIEF).  Never pipe this into head/sed.
"""
import subprocess
import sys
import tempfile
from pathlib import Path

ASPSX = Path(r"C:/Temp/psq43/PSSN/ASPSX.EXE")

PROLOG = "\t.text\n\t.globl\tprobe_fn\nprobe_fn:\n"
EPILOG = "\tjr\t$31\n\tnop\n"


def run(body, prolog=PROLOG, epilog=EPILOG):
    text = prolog + body + epilog
    with tempfile.TemporaryDirectory() as td:
        s = Path(td) / "p.s"
        s.write_bytes(text.replace("\n", "\r\n").encode("ascii", "replace"))
        o = Path(td) / "p.obj"
        r = subprocess.run([str(ASPSX), "-o", str(o), str(s)],
                           capture_output=True, text=True, cwd=td)
        blob = r.stdout + r.stderr
        ok = o.exists() and " : Error : " not in blob
        return ok, blob


CASES = [
    ("raw divu 3-op $0 dest",        "\tdivu\t$0,$4,$5\n"),
    ("raw divu 3-op $0 + noat",      "\t.set\tnoat\n\tdivu\t$0,$4,$5\n\t.set\tat\n"),
    ("raw divu 2-op",                "\tdivu\t$4,$5\n"),
    ("raw divu 2-op + noat",         "\t.set\tnoat\n\tdivu\t$4,$5\n\t.set\tat\n"),
    ("raw div 2-op + noat",          "\t.set\tnoat\n\tdiv\t$4,$5\n\t.set\tat\n"),
    ("raw div 3-op $0 + noat",       "\t.set\tnoat\n\tdiv\t$0,$4,$5\n\t.set\tat\n"),
    ("divu word form",               "\t.word\t0x0085001b\n"),
    ("mult 2-op",                    "\tmult\t$4,$5\n"),
    ("negu",                         "\tnegu\t$4,$4\n"),
    ("sub trapping",                 "\tsub\t$2,$2,$8\n"),
    ("beqz/bnez",                    "\tbeqz\t$4,1f\n\tnop\n1:\n"),
    ("sym assign  a = b",            "\ta_alias = probe_fn\n"),
    ("sym assign  .set a,b",         "\t.set\ta_alias,probe_fn\n"),
    ("sym assign  a equ b",          "a_alias\tequ\tprobe_fn\n"),
    ("sym assign  .equ a,b",         "\t.equ\ta_alias,probe_fn\n"),
    ("second label at same addr",    ""),  # handled specially below
    (".type/.size",                  "\t.type\tprobe_fn,@function\n\t.size\tprobe_fn,8\n"),
    (".set push/pop",                "\t.set\tpush\n\t.set\tnoat\n\t.set\tpop\n"),
    ("ABI reg name $a0",             "\taddu\t$a0,$a0,$zero\n"),
]


def main():
    if len(sys.argv) > 1:
        ok, blob = run("", prolog=Path(sys.argv[1]).read_text(errors="replace"), epilog="")
        print("OK" if ok else "FAIL")
        print(blob)
        return
    for name, body in CASES:
        if name == "second label at same addr":
            ok, blob = run("", prolog="\t.text\n\t.globl\tprobe_fn\n\t.globl\ta_alias\n"
                                      "probe_fn:\na_alias:\n", epilog=EPILOG)
        else:
            ok, blob = run(body)
        err = ""
        if not ok:
            for ln in blob.splitlines():
                if " : Error : " in ln:
                    err = ln.split(" : Error : ")[-1].strip()
                    break
        print("%-32s %s  %s" % (name, "ACCEPT" if ok else "REJECT", err))


main()
