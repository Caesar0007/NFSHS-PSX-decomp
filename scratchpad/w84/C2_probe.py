#!/usr/bin/env python3
"""W84-C2 prober: apply a text substitution to C2_LIBMCRD.c, gate, restore.
Usage: python C2_probe.py <label> <pyfile-with-OLD/NEW>  -- or use as a module.
Simplest use: edit VARIANTS below and run.
"""
import subprocess, sys, os, pathlib, shutil

ROOT = pathlib.Path(__file__).resolve().parents[2]
CAND = ROOT / 'scratchpad' / 'w84' / 'C2_LIBMCRD.c'
BAK  = ROOT / 'scratchpad' / 'w84' / 'C2_LIBMCRD.c.probebak'

FNS_ALL = ('MemCardAccept,MemCardCallback,MemCardCmd_cb,MemCardCreateFile,MemCardDeleteFile,'
           'MemCardEnd,MemCardEventToRslt,MemCardExist,MemCardExist_cb,MemCardFormat,'
           'MemCardGetDirentry,MemCardInit,MemCardMakeDevname,MemCardReadData,MemCardReadData_cb,'
           'MemCardReadFile,MemCardReadFile_cb,MemCardStart,MemCardStart_cb,MemCardStop,'
           'MemCardSync,MemCardUnformat,MemCardWriteData,MemCardWriteData_cb,MemCardWriteFile,'
           'MemCardWriteFile_cb')


def gate(fns='MemCardGetDirentry', dump=False, maxdiff='12'):
    env = dict(os.environ, NFS4_SOURCE_ONLY='1', VA_MAX=maxdiff)
    if dump:
        env['C2_DUMP'] = '1'
    r = subprocess.run([sys.executable, str(ROOT / 'scratchpad' / 'w84' / 'C2_verify.py'),
                        'scratchpad/w84/C2_LIBMCRD.c', fns],
                       capture_output=True, text=True, env=env, cwd=str(ROOT))
    return r.stdout + r.stderr


def probe(label, old, new, fns='MemCardGetDirentry', keep=False, show=False):
    txt = CAND.read_text(encoding='utf-8', errors='replace')
    if old not in txt:
        print(f'{label}: ANCHOR NOT FOUND'); return None
    shutil.copyfile(CAND, BAK)
    try:
        CAND.write_text(txt.replace(old, new, 1), encoding='utf-8')
        out = gate(fns)
        line = [l for l in out.splitlines() if 'MemCard' in l]
        print(f'--- {label}')
        for l in line:
            print('   ', l.strip())
        if show:
            for l in out.splitlines():
                if l.startswith('      '):
                    print(l)
    finally:
        if not keep:
            shutil.copyfile(BAK, CAND)
    return out


if __name__ == '__main__':
    print(gate(sys.argv[1] if len(sys.argv) > 1 else 'MemCardGetDirentry'))
