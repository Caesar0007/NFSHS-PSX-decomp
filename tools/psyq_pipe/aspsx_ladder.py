"""aspsx_ladder.py [TU-fragment ...] -- which REAL assembler reproduces Sony's library objects?

For each chosen Sony-library TU the lane's assembler input (build/psyq/<tu>.s = the gcc 2.7.2 output, SN-translated by
psylink_lane.py) is assembled with every real ASPSX version on this machine, and each function of the result is compared
with the same function of the PsyQ 4.3 library member: size, and bytes with the relocated words masked.

    python tools/psyq_pipe/aspsx_ladder.py libmcrd/LIBMCRD libetc/INTR libcd/drv
"""
import re
import shutil
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
import psyq_extract as X  # noqa: E402

SDK = Path('C:/Temp/nfs4-clean/psyq43/extracted')
WORK = ROOT / 'build' / 'tmp' / 'aspsx_ladder'
WORK.mkdir(parents=True, exist_ok=True)
ASPSX = [('2.21', 'C:/Temp/nfs1-clean/psyq330/PSYQ/ASPSX.EXE'), ('2.34', 'C:/Temp/nfs2-clean/psyq350/PSYQ/ASPSX.EXE'),
         ('2.56', 'C:/Temp/nfs3-clean/psyq400/PSYQ/ASPSX.EXE'), ('2.77', 'C:/Temp/psq43/PSSN/ASPSX.EXE'),
         ('2.79', 'C:/Temp/psq44/pssn/bin/ASPSX.EXE'), ('2.81', 'C:/Temp/psq45/BIN/WIN/ASPSX.EXE')]
# recon TU -> (SDK library, member) where the file name differs from the member
MEMBER = {'libcd/drv': ('LIBCD', 'BIOS'), 'libcd/stcdint': ('LIBCD', 'C_011'), 'libcd/cdcont': ('LIBCD', 'SYS')}
ENV = dict(__import__('os').environ, MSYS2_ARG_CONV_EXCL='*', MSYS_NO_PATHCONV='1')


def is_pe(path):
    d = open(path, 'rb').read(0x400)
    off = struct.unpack_from('<I', d, 0x3c)[0] if len(d) > 0x40 else 0
    return d[off:off + 4] == b'PE' + bytes(2)


def parse(blob):
    for alt, pad in ((False, False), (True, False), (True, True)):
        try:
            o = X.parse_obj(blob, alt_debug=alt, pad_even=pad)
            if not any(blob[o['consumed']:]):
                return o
        except X.Desync:
            pass
    return None


def functions(o):
    """name -> (bytes, set of relocated word offsets inside the function)"""
    out = {}
    for sect, name in o['sections'].items():
        if not name.startswith('.text'):
            continue
        body = o['code'].get(sect, b'')
        marks = sorted({(x['off'], x['name']) for x in o['xdefs'] + o['locals'] if x['sect'] == sect and 'bss' not in x})
        offs = sorted({m[0] for m in marks})
        nxt = {a: (offs[i + 1] if i + 1 < len(offs) else len(body)) for i, a in enumerate(offs)}
        pat = {p['off'] & ~3 for p in o['patches'] if p['sect'] == sect}
        for off, nm in marks:
            out[nm] = (body[off:nxt[off]], {p - off for p in pat if off <= p < nxt[off]})
    return out


def same(a, b):
    (ba, pa), (bb, pb) = a, b
    ba, bb = ba.rstrip(b'\0'), bb.rstrip(b'\0')          # Sony's objects pad sections to 16 with zeros
    n = (max(len(ba), len(bb)) + 3) & ~3
    ba, bb = ba.ljust(n, b'\0'), bb.ljust(n, b'\0')
    mask = pa | pb
    return all(ba[i:i + 4] == bb[i:i + 4] or i in mask for i in range(0, n, 4))


tus = sys.argv[1:] or ['libmcrd/LIBMCRD', 'libetc/INTR', 'libcd/drv', 'libcd/stcdint', 'libgpu/SYS', 'libpad/PADMAIN']
for tu in tus:
    lib, mem = MEMBER.get(tu, (tu.split('/')[0].upper(), tu.split('/')[1].upper()))
    sdk = parse((SDK / lib / 'obj' / (mem + '.obj')).read_bytes())
    ref = functions(sdk)
    src = ROOT / 'build' / 'psyq' / ('recon__syslib__psx__%s.c.s' % tu.replace('/', '__'))
    print('== %s  vs  %s/%s.obj  (%d functions in the SDK member, .text 0x%x)' % (tu, lib, mem, len(ref),
          sum(len(v) for k, v in sdk['code'].items() if sdk['sections'].get(k, '').startswith('.text'))))
    for ver, exe in ASPSX:
        obj = WORK / ('%s_%s.obj' % (tu.replace('/', '_'), ver))
        if obj.exists():
            obj.unlink()
        g = re.search(rb'-G value = (\d+)', (ROOT / 'build' / 'recon' / 'syslib' / 'psx' / (tu + '.c.s')).read_bytes()[:600])
        gflag = '-G' + (g.group(1).decode() if g else '0')
        if is_pe(exe):
            r = subprocess.run([exe, '-q', gflag, str(src), '-o', str(obj)], capture_output=True, text=True, env=ENV, timeout=120)
        else:                                            # 16-bit DOS build: run it under the vendored DOS player, 8.3 names, local cwd
            shutil.copyfile(exe, WORK / 'ASPSXDOS.EXE'); shutil.copyfile(src, WORK / 'IN.S')
            if (WORK / 'OUT.OBJ').exists():
                (WORK / 'OUT.OBJ').unlink()
            r = subprocess.run([str(ROOT / 'tools/msdos-player/msdos.exe'), 'ASPSXDOS.EXE', '-q', gflag, 'IN.S', '-o', 'OUT.OBJ'], cwd=WORK, capture_output=True, text=True, env=ENV, timeout=300)
            if (WORK / 'OUT.OBJ').exists():
                shutil.move(str(WORK / 'OUT.OBJ'), str(obj))
        if not obj.exists():
            print('   ASPSX %-5s did not assemble: %s' % (ver, (r.stdout + r.stderr).strip().splitlines()[:1]))
            continue
        o = parse(obj.read_bytes())
        if o is None:
            print('   ASPSX %-5s object not parseable' % ver); continue
        mine = functions(o)
        names = [n for n in ref if n in mine]
        eq = [n for n in names if same(mine[n], ref[n])]
        sz = [n for n in names if len(mine[n][0].rstrip(b'\0')) // 4 == len(ref[n][0].rstrip(b'\0')) // 4]
        tot = sum(len(v) for k, v in o['code'].items() if o['sections'].get(k, '').startswith('.text'))
        print('   ASPSX %-5s .text 0x%-5x  functions compared %3d | same size %3d | byte-identical (relocs masked) %3d' % (ver, tot, len(names), len(sz), len(eq)))
