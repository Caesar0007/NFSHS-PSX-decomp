"""w66-a2: for every dtor slot in vtables_tdialog.cpp / vtables_tlist.cpp,
read RETAIL's symbol out of asm/data/*.s and report whether that symbol is
DEFINED (T) anywhere in the recon build tree.
"""
import os
import re
import subprocess
import sys

ROOT = r"C:/Temp/nfs4-decomp"
NM = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe"

# class -> vtable label in retail rdata
CLASSES = {
    "tdialog": ["tDialogBase", "tDialogHelp", "tDialogInteractive",
                "tDialogMessageString", "tDialogMessageStringWithTimeout",
                "tDialogNoInputMessage", "tDialogBackUpOnly", "tDialogYesNo",
                "tDialogYesNoTri", "tDialogYesNoMem"],
    "tlist": ["tListIteratorCarColor", "tListIteratorCar",
              "tListIteratorDoubleIndexed", "tListIteratorIndexed",
              "tListIteratorMultiPlayer", "tListIteratorRangeIndexed",
              "tListIteratorRange", "tListIteratorTournament",
              "tListIteratorTrack", "tListIterator"],
}

data = {}
for fn in os.listdir(os.path.join(ROOT, "asm", "data")):
    if fn.endswith(".s"):
        data[fn] = open(os.path.join(ROOT, "asm", "data", fn), encoding="utf-8",
                        errors="replace").read()

defined = {}
objs = []
for dp, dn, fns in os.walk(os.path.join(ROOT, "build")):
    for f in fns:
        if f.endswith(".o"):
            objs.append(os.path.join(dp, f))
for i in range(0, len(objs), 60):
    r = subprocess.run([NM] + objs[i:i + 60], capture_output=True, text=True)
    cur = None
    for ln in r.stdout.splitlines():
        if ln.endswith(":"):
            cur = ln[:-1]
            continue
        m = re.match(r"^([0-9a-f]{8})?\s*([A-Za-z])\s+(\S+)$", ln.strip())
        if m and m.group(2) in "TtRrDd":
            defined.setdefault(m.group(3), []).append(cur)

print("%-38s %-34s %s" % ("class", "retail dtor slot symbol", "defined in"))
for fam, cls in CLASSES.items():
    for c in cls:
        vt = "_vt_%d%s" % (len(c), c)
        sym = None
        for fn, txt in data.items():
            m = re.search(r"^dlabel %s\s*$(.*?)^enddlabel" % re.escape(vt),
                          txt, re.S | re.M)
            if m:
                body = m.group(1).splitlines()
                # slot layout: pairs of words; the dtor slot is the .word naming ___
                for ln in body:
                    mm = re.search(r"\.word\s+(___\w+)", ln)
                    if mm:
                        sym = mm.group(1)
                        break
                break
        d = defined.get(sym or "", [])
        d = [os.path.relpath(x, ROOT).replace("\\", "/") for x in d]
        print("%-38s %-34s %s" % (c, sym, ", ".join(d) if d else "*** NONE ***"))
