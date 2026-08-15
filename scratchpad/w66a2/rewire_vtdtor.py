"""w66-a2: point the tDialog/tList vtable dtor slots at the REAL
`___<len><Class>` symbols (retail's own slot content, read off asm/data/*.s)
and delete the fabricated `_vtdtor_X` wrappers.

Byte-mode, LF-preserving, every anchor count-asserted, .bak per file.
"""
import os
import re
import shutil
import sys

ROOT = r"C:/Temp/nfs4-decomp"
HERE = os.path.dirname(os.path.abspath(__file__))
BAK = os.path.join(HERE, "bak")

# class -> retail dtor symbol (VERIFIED against asm/data/*.s word entries)
SYMS = {
    "tDialogBackUpOnly": "___17tDialogBackUpOnly",
    "tDialogBase": "___11tDialogBase",
    "tDialogHelp": "___11tDialogHelp",
    "tDialogInteractive": "___18tDialogInteractive",
    "tDialogMessageString": "___20tDialogMessageString",
    "tDialogMessageStringWithTimeout": "___31tDialogMessageStringWithTimeout",
    "tDialogNoInputMessage": "___21tDialogNoInputMessage",
    "tDialogYesNo": "___12tDialogYesNo",
    "tDialogYesNoMem": "___15tDialogYesNoMem",
    "tDialogYesNoTri": "___15tDialogYesNoTri",
    "tListIterator": "___13tListIterator",
    "tListIteratorCar": "___16tListIteratorCar",
    "tListIteratorCarColor": "___21tListIteratorCarColor",
    "tListIteratorDoubleIndexed": "___26tListIteratorDoubleIndexed",
    "tListIteratorIndexed": "___20tListIteratorIndexed",
    "tListIteratorMultiPlayer": "___24tListIteratorMultiPlayer",
    "tListIteratorRange": "___18tListIteratorRange",
    "tListIteratorRangeIndexed": "___25tListIteratorRangeIndexed",
    "tListIteratorTournament": "___23tListIteratorTournament",
    "tListIteratorTrack": "___18tListIteratorTrack",
}

FILES = ["recon/game/common/vtables_tdialog.cpp",
         "recon/game/common/vtables_tlist.cpp"]

DECL_HDR = (
    b"/* w66-a2: retail's dtor slot holds the destructor's OWN address (verified in\n"
    b" * asm/data/rdata_80010000_r0*.rodata.s: `.word ___<len><Class>`), so the slots\n"
    b" * below name the real `___<len><Class>` symbols directly.  The former fabricated\n"
    b" * per-class wrappers `static int wrap(X *p){ p->~X(); return 0; }` are gone: they\n"
    b" * were an artifact of C++ forbidding `&Class::~Class`.  Each symbol is a real fn\n"
    b" * (w65-a3's extern-\"C\" dtor device / a real out-of-line member dtor renamed\n"
    b" * `_._`->`___` by build.py), defined in fedialog/fecars/femenu/fetourn/fetracks. */\n"
)


def rewire(rel):
    path = os.path.join(ROOT, rel)
    with open(path, "rb") as f:
        data = f.read()
    assert b"\r" not in data, rel
    orig = data

    # 1. collect the wrapper lines, in file order
    wrappers = re.findall(rb"^static int _vtdtor_(\w+)\([^\n]*\n", data, re.M)
    assert wrappers, rel
    decls = []
    for cls in wrappers:
        c = cls.decode()
        assert c in SYMS, "unknown class %s" % c
        decls.append(b'extern "C" void %s(void *thisp);   /* ~%s */\n'
                     % (SYMS[c].encode(), cls))

    # 2. replace the wrapper block with the extern "C" declarations
    first = data.index(b"static int _vtdtor_")
    last_line = re.search(rb"^static int _vtdtor_\w+\([^\n]*\n(?![^\n]*_vtdtor_)",
                          data[first:], re.M)
    end = first + last_line.end()
    data = data[:first] + DECL_HDR + b"".join(decls) + data[end:]

    # 3. re-point every slot
    for cls_b in set(wrappers):
        c = cls_b.decode()
        old = b"&_vtdtor_" + cls_b + b"}"
        n = data.count(old)
        assert n >= 1, "no slot for %s" % c
        data = data.replace(old, b"&" + SYMS[c].encode() + b"}")

    assert b"_vtdtor_" not in data, "leftover wrapper reference in %s" % rel
    assert b"\r" not in data and b"\0" not in data
    os.makedirs(BAK, exist_ok=True)
    shutil.copyfile(path, os.path.join(BAK, os.path.basename(rel) + ".bak"))
    tmp = path + ".w66a2tmp"
    with open(tmp, "wb") as f:
        f.write(data)
    os.replace(tmp, path)
    print("%s: %d wrappers -> real symbols (%d -> %d bytes)"
          % (rel, len(wrappers), len(orig), len(data)))


for rel in FILES:
    rewire(rel)
