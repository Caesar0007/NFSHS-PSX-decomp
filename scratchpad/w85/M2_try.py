#!/usr/bin/env python
"""W85-M2: apply (old -> new) text substitutions to a copy of the pristine
LIBMCRD.c, drop it on the live path, gate, restore.

  python scratchpad/w85/M2_try.py <spec.py> [fns]

<spec.py> is a python file defining SUBS = [(old, new), ...] and optionally
FNS = "a,b,c".
"""
import os, subprocess, sys, shutil, pathlib, runpy

ROOT = pathlib.Path(__file__).resolve().parents[2]
LIVE = ROOT / 'recon/syslib/psx/libmcrd/LIBMCRD.c'
ORIG = ROOT / 'scratchpad/w85/M2_LIBMCRD.orig.c'
ALLFNS = ("MemCardAccept,MemCardCallback,MemCardCmd_cb,MemCardCreateFile,"
          "MemCardDeleteFile,MemCardEnd,MemCardEventToRslt,MemCardExist,"
          "MemCardExist_cb,MemCardFormat,MemCardGetDirentry,MemCardInit,"
          "MemCardMakeDevname,MemCardReadData,MemCardReadData_cb,"
          "MemCardReadFile,MemCardReadFile_cb,MemCardStart,MemCardStart_cb,"
          "MemCardStop,MemCardSync,MemCardUnformat,MemCardWriteData,"
          "MemCardWriteData_cb,MemCardWriteFile,MemCardWriteFile_cb")


def main():
    spec = runpy.run_path(sys.argv[1])
    subs = spec['SUBS']
    fns = sys.argv[2] if len(sys.argv) > 2 else spec.get('FNS', ALLFNS)
    txt = ORIG.read_text()
    for old, new in subs:
        if txt.count(old) != 1:
            print('!! anchor count = %d for:\n%s' % (txt.count(old), old[:200]))
            return 2
        txt = txt.replace(old, new)
    keep = sys.argv[1].replace('.py', '.c')
    pathlib.Path(keep).write_text(txt)
    try:
        LIVE.write_text(txt)
        p = subprocess.run([sys.executable, 'tools/verify_asm.py',
                            'recon/syslib/psx/libmcrd/LIBMCRD.c', fns],
                           cwd=str(ROOT), capture_output=True, text=True)
        sys.stdout.write(p.stdout + p.stderr)
    finally:
        shutil.copyfile(ORIG, LIVE)
    return 0


if __name__ == '__main__':
    sys.exit(main())
