#!/usr/bin/env python3
"""w66-a2: ORACLE-DRIVEN rewiring of every remaining fabricated `_vtdtor_X`
vtable slot to the symbol RETAIL's slot actually names.

For each `{0, 0, (int (*)(...))&_vtdtor_X},  /* @0xVA ... */` line the tool reads
the retail word at VA+4 out of asm/data/*.s (the entry is the 8-byte cfront
{delta,index,fn} pair, so the function pointer is the SECOND word) and uses THAT
symbol -- which for a class with no declared dtor is an ANCESTOR's `___<len><Base>`
(w65-a3's DTOR-DEPTH LAW).  Nothing is assumed from the class name.

--check  : report only (no writes).
"""
import os
import re
import shutil
import sys

ROOT = r"C:/Temp/nfs4-decomp"
HERE = os.path.dirname(os.path.abspath(__file__))
BAK = os.path.join(HERE, "bak")
CHECK = "--check" in sys.argv

# ---- retail word index: VA -> symbol (only `.word <symbol>` lines) -----------
WORD = re.compile(r"/\*\s*[0-9A-Fa-f]+\s+([0-9A-Fa-f]{8})\s+[0-9A-Fa-f]{8}\s*\*/\s*"
                  r"\.word\s+([A-Za-z_]\w*)\s*$")
va2sym = {}
dd = os.path.join(ROOT, "asm", "data")
for fn in os.listdir(dd):
    if not fn.endswith(".s"):
        continue
    for ln in open(os.path.join(dd, fn), encoding="utf-8", errors="replace"):
        m = WORD.search(ln.rstrip())
        if m:
            va2sym[int(m.group(1), 16)] = m.group(2)

SLOT = re.compile(rb"&_vtdtor_(\w+)\}[^\n]*?@0x([0-9a-fA-F]{8})")
DECL_HDR = (
    b"/* w66-a2: retail's dtor slot holds a REAL destructor symbol (read per slot out\n"
    b" * of asm/data/*.s at the slot VA+4 -- for a class with no declared dtor that is\n"
    b" * an ANCESTOR's `___<len><Base>`, w65-a3's DTOR-DEPTH LAW).  The slots below name\n"
    b" * those symbols directly; the fabricated per-class wrappers\n"
    b" * `static int wrap(X *p){ p->~X(); return 0; }` (an artifact of C++ forbidding\n"
    b" * `&Class::~Class`) are gone. */\n")


def process(rel):
    path = os.path.join(ROOT, rel)
    with open(path, "rb") as f:
        data = f.read()
    if b"_vtdtor_" not in data:
        return
    crlf = data.count(b"\r\n")
    nl = b"\r\n" if crlf * 2 > data.count(b"\n") else b"\n"
    assert data.count(b"\r") == crlf, "%s: stray CR" % rel   # no CR-only endings
    slots = SLOT.findall(data)
    wrappers = set(re.findall(rb"^static int _vtdtor_(\w+)\(", data, re.M))
    used = {}
    print("== %s (%d wrappers, %d slots)" % (rel, len(wrappers), len(slots)))
    ok = True
    for cls, va in slots:
        sym = va2sym.get(int(va, 16) + 4)
        c = cls.decode()
        if sym is None or not sym.startswith("___"):
            print("   !! %-34s @0x%s -> retail word %r (NOT a dtor symbol)"
                  % (c, va.decode(), sym))
            ok = False
            continue
        own = "___%d%s" % (len(c), c)
        note = "" if sym == own else "   <== ANCESTOR (class has no declared dtor)"
        print("   %-34s @0x%s -> %s%s" % (c, va.decode(), sym, note))
        used.setdefault(sym, set()).add(c)
    if not ok:
        print("   !! skipped (unresolved slot)")
        return
    if set(x.decode() for x in wrappers) != set(x.decode() for x, _ in slots):
        print("   !! wrapper set != slot set; skipped")
        return
    if CHECK:
        return
    # declarations
    decls = b"".join(b'extern "C" void %s(void *thisp);   /* ~%s */%s'
                     % (s.encode(), ", ~".join(sorted(cs)).encode(), nl)
                     for s, cs in sorted(used.items()))
    hdr = DECL_HDR.replace(b"\n", nl) if nl != b"\n" else DECL_HDR
    first = data.index(b"static int _vtdtor_")
    m = re.search(rb"^static int _vtdtor_\w+\([^\n]*\n(?![^\n]*_vtdtor_)",
                  data[first:], re.M)
    data = data[:first] + hdr + decls + data[first + m.end():]
    for cls, va in slots:
        c = cls.decode()
        sym = va2sym[int(va, 16) + 4]
        data = data.replace(b"&_vtdtor_" + cls + b"}", b"&" + sym.encode() + b"}")
    assert b"_vtdtor_" not in data, rel
    assert b"\0" not in data and data.count(b"\r") == data.count(b"\r\n")
    os.makedirs(BAK, exist_ok=True)
    shutil.copyfile(path, os.path.join(BAK, os.path.basename(rel) + ".bak"))
    tmp = path + ".w66a2tmp"
    with open(tmp, "wb") as f:
        f.write(data)
    os.replace(tmp, path)
    print("   -> rewired (%d distinct dtor symbols)" % len(used))


files = []
for dp, dn, fns in os.walk(os.path.join(ROOT, "recon")):
    for f in fns:
        if f.endswith((".cpp", ".c")):
            p = os.path.join(dp, f)
            if b"_vtdtor_" in open(p, "rb").read():
                files.append(os.path.relpath(p, ROOT).replace("\\", "/"))
for rel in sorted(files):
    process(rel)
