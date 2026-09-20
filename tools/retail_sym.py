#!/usr/bin/env python3
"""retail_sym.py -- the text dump of the retail NFS4.SYM, generated on demand.

The retail `NFS4.SYM` (from the disc, next to NFS4.MAP) is NOT in the repository: supply it as `rom/NFS4.SYM`.
`txt()` returns the path of its dumpsym text -- `build/sym/nfs4-f-v3.txt` -- and (re)creates it with the vendored
`tools/dumpsym/dumpsym.exe` when it is missing or older than the SYM or the dumper.  The result is byte-identical to the
`nfs4-f-v3.txt` the project has always used (the "v3" = dumpsym with the bool/NULL fix).

    python tools/retail_sym.py          # make sure the dump exists, print its path
"""
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DUMPSYM = ROOT / 'tools' / 'dumpsym' / 'dumpsym.exe'
SYM = ROOT / 'rom' / 'NFS4.SYM'
TXT = ROOT / 'build' / 'sym' / 'nfs4-f-v3.txt'
SYM_SIZE, SYM_SHA1 = 7881225, None      # size of the retail file; a wrong file is refused below


def dumpsym():
    """path of the vendored dumper (str)"""
    return str(DUMPSYM)


def txt():
    """path of the retail SYM text dump (str), generating it when needed"""
    if not SYM.is_file():
        sys.exit('[retail_sym] %s not found -- copy the retail NFS4.SYM from the disc there (it is not committed, like '
                 'rom/nfs4-f.exe and rom/NFS4.MAP)' % SYM)
    if SYM.stat().st_size != SYM_SIZE:
        sys.exit('[retail_sym] %s is %d bytes, the retail file is %d' % (SYM, SYM.stat().st_size, SYM_SIZE))
    fresh = TXT.is_file() and TXT.stat().st_size and TXT.stat().st_mtime >= max(SYM.stat().st_mtime, DUMPSYM.stat().st_mtime)
    if not fresh:
        TXT.parent.mkdir(parents=True, exist_ok=True)
        tmp = TXT.with_suffix('.tmp')
        with open(tmp, 'wb') as f:
            r = subprocess.run([str(DUMPSYM), str(SYM)], stdout=f, stderr=subprocess.PIPE)
        if r.returncode or not tmp.stat().st_size:
            sys.exit('[retail_sym] dumpsym failed: %s' % r.stderr.decode(errors='replace')[:300])
        tmp.replace(TXT)
    return str(TXT).replace(chr(92), '/')


if __name__ == '__main__':
    print(txt())
