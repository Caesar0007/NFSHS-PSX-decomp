"""lcomm_probe.py -- what do the real ASPSX builds do with gcc's `.lcomm name,size` runs?
Assembles build/psyq/probe/lc.s with each ASPSX, links with PSYLINK 2.73, prints symbol spacing.
Retail spacing to reproduce (collide): basisDots 36 -> +48, x3, then basisDotRelative 24;
camera corrPt.47 12 -> +12, lastOppVector.106 24 -> +32."""
import re
import subprocess
from pathlib import Path

P = Path('C:/Temp/nfs4-decomp/build/psyq/probe')
PSYLINK = 'C:/Temp/psq43/PSSN/PSYLINK.EXE'
ASMS = {'2.77': 'C:/Temp/psq43/PSSN/ASPSX.EXE', '2.56': 'C:/Temp/claud/scratch_dos/ASPSX256.EXE'}
SRC = """\t.text
\tnop
\t.lcomm\txr,4
\t.lcomm\tbd1,36
\t.lcomm\tbd2,36
\t.lcomm\tbd3,36
\t.lcomm\tbdr,24
\t.lcomm\tcorr,12
\t.lcomm\tlov,24
\t.lcomm\tcop1,4
\t.lcomm\tspos,132
\t.lcomm\trec,96
\t.lcomm\tnum,25
\t.lcomm\tnamebuf,8
\t.lcomm\twait,50
\t.lcomm\tend,4
"""
SRC = re.sub(r'\t\.lcomm\t(\w+),', lambda m: '\t.globl\t%s\n\t.lcomm\t%s,' % (m.group(1), m.group(1)), SRC)   # map lists globals only
(P / 'lc.s').write_bytes(SRC.replace('\n', '\r\n').encode())
(P / 'lc.lnk').write_bytes(b"\torg\t$80010000\r\ntext\tgroup\r\nbss\tgroup\tbss\r\n\tsection\t.text,text\r\n"
                           b"\tsection\t.sbss,bss\r\n\tsection\t.bss,bss\r\n\tinclude\tlc.obj\r\n")
for ver, exe in ASMS.items():
    if not Path(exe).exists():
        print(ver, 'missing', exe)
        continue
    for g in ('0', '8'):
        for f in ('lc.obj', 'lc.cpe', 'lc.map', 'lc.sym'):
            (P / f).unlink(missing_ok=True)
        r = subprocess.run([exe, '-q', '-G' + g, 'lc.s', '-o', 'lc.obj'], cwd=P, capture_output=True, text=True)
        if not (P / 'lc.obj').exists():
            print(ver, 'G' + g, 'assemble failed', (r.stdout + r.stderr)[:200])
            continue
        r = subprocess.run([PSYLINK, '/m', '@lc.lnk,lc.cpe,lc.sym,lc.map'], cwd=P, capture_output=True, text=True)
        mp = (P / 'lc.map')
        if not mp.exists():
            print(ver, 'G' + g, 'link failed', (r.stdout + r.stderr)[:300])
            continue
        syms = {}
        for ln in mp.read_text(errors='replace').splitlines():
            m = re.match(r'\s*([0-9A-Fa-f]{8})\s+(\w+)\s*$', ln)
            if m and m.group(2).lower() in ('xr', 'bd1', 'bd2', 'bd3', 'bdr', 'corr', 'lov', 'cop1', 'spos', 'rec', 'num', 'namebuf', 'wait', 'end'):
                syms[m.group(2).lower()] = int(m.group(1), 16)
        order = sorted(syms.items(), key=lambda kv: kv[1])
        print(f'== ASPSX {ver} -G{g}')
        for (n, a), (_, b) in zip(order, order[1:] + [(None, None)]):
            print(f'   {a:08x} {n:8s}' + (f' +{b - a}' if b else ''))
