"""W62-A17: give the flattened Speech statics their REAL link symbol via an asm label.

speech.cpp defines (extern "C") Mobile__6SpeechP8Car_tObj / Dispatch__6Speech /
Reset__6Speech.  Consumer headers declare them as C++ free fns named Speech_Mobile /
Speech_Dispatch / Speech_Reset, which mangle to Speech_Mobile__FP8Car_tObj /
Speech_Dispatch__Fv / Speech_Reset__Fv -- symbols that exist NOWHERE.  Every caller
therefore emits an undefined reference PSYLINK cannot resolve; verify_asm's
reloc-name leniency hides it completely.

Fix = an asm label on the declaration (the established non-builtin-alias device,
AGENT_GUIDE 4.4 policy table).  Call sites are untouched; codegen is identical
except that the emitted relocation now names the symbol that actually exists.

Usage:  python fix_speech_alias.py <symbol>
        symbol in {Mobile, Dispatch, Reset}
"""
import io
import os
import re
import sys

ROOT = r"C:\Temp\nfs4-decomp"

SPEC = {
    "Mobile": (
        re.compile(r"int Speech_Mobile\(Car_tObj \*carObj\);"),
        'int Speech_Mobile(Car_tObj *carObj) asm("Mobile__6SpeechP8Car_tObj");',
    ),
    "Dispatch": (
        re.compile(r"int Speech_Dispatch\(void\);"),
        'int Speech_Dispatch(void) asm("Dispatch__6Speech");',
    ),
    "Reset": (
        re.compile(r"extern void Speech_Reset\(\);"),
        'extern void Speech_Reset() asm("Reset__6Speech");',
    ),
}

sym = sys.argv[1]
pat, repl = SPEC[sym]

targets = []
for dp, dn, fn in os.walk(os.path.join(ROOT, "recon")):
    for f in fn:
        if f.endswith("_externs.h"):
            targets.append(os.path.join(dp, f))

nfiles = 0
for path in targets:
    with io.open(path, "rb") as fh:
        raw = fh.read()
    text = raw.decode("utf-8", "replace")
    new, n = pat.subn(repl, text)
    if not n:
        continue
    assert new != text
    out = new.encode("utf-8")
    assert len(out) > len(raw), "size must grow"
    tmp = path + ".w62a17.tmp"
    with io.open(tmp, "wb") as fh:
        fh.write(out)
    os.replace(tmp, path)
    nfiles += 1
    print("patched %d site(s): %s" % (n, os.path.relpath(path, ROOT)))
print("files patched: %d" % nfiles)
assert nfiles, "no site matched -- FATAL"
