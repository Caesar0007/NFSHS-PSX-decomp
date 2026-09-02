#!/usr/bin/env python
"""W85-M2 probe harness for recon/syslib/psx/libmcrd/LIBMCRD.c.

Usage:  python scratchpad/w85/M2_probe.py <variant.c> [fn,fn,...]

Copies <variant.c> over the live TU, runs tools/verify_asm.py, prints the
result table, and ALWAYS restores the pristine copy in a finally block.
With no variant it just gates the live file.
"""
import os, subprocess, sys, shutil, pathlib

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


def gate(fns):
    p = subprocess.run([sys.executable, 'tools/verify_asm.py',
                        'recon/syslib/psx/libmcrd/LIBMCRD.c', fns],
                       cwd=str(ROOT), capture_output=True, text=True)
    return p.stdout + p.stderr


def main():
    variant = sys.argv[1] if len(sys.argv) > 1 else None
    fns = sys.argv[2] if len(sys.argv) > 2 else ALLFNS
    try:
        if variant:
            shutil.copyfile(variant, LIVE)
        print(gate(fns))
    finally:
        if variant:
            shutil.copyfile(ORIG, LIVE)


if __name__ == '__main__':
    main()
