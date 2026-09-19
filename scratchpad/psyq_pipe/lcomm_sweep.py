"""lcomm_sweep.py -- ASPSX 2.77 `.lcomm` alignment as a function of size: each test symbol follows a 1-byte
symbol, so its section-relative offset exposes the alignment the assembler gave it."""
import re
import subprocess
from pathlib import Path

P = Path('C:/Temp/nfs4-decomp/build/psyq/probe')
PSYLINK = 'C:/Temp/psq43/PSSN/PSYLINK.EXE'
ASPSX = 'C:/Temp/psq43/PSSN/ASPSX.EXE'
SIZES = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 17, 20, 24, 25, 31, 32, 33, 36, 40, 48, 50, 64, 96, 132, 524]
src = ['\t.text', '\tnop']
for n in SIZES:
    src += [f'\t.globl\tp{n}', f'\t.lcomm\tp{n},1', f'\t.globl\ts{n}', f'\t.lcomm\ts{n},{n}']
(P / 'ls.s').write_bytes(('\r\n'.join(src) + '\r\n').encode())
(P / 'ls.lnk').write_bytes(b"\torg\t$80010000\r\ntext\tgroup\r\nbss\tgroup\tbss\r\n\tsection\t.text,text\r\n"
                           b"\tsection\t.sbss,bss\r\n\tsection\t.bss,bss\r\n\tinclude\tls.obj\r\n")
for f in ('ls.obj', 'ls.map'):
    (P / f).unlink(missing_ok=True)
subprocess.run([ASPSX, '-q', '-G0', 'ls.s', '-o', 'ls.obj'], cwd=P, capture_output=True)
subprocess.run([PSYLINK, '/m', '@ls.lnk,ls.cpe,ls.sym,ls.map'], cwd=P, capture_output=True)
syms = {}
for ln in (P / 'ls.map').read_text(errors='replace').splitlines():
    m = re.match(r'\s*([0-9A-Fa-f]{8})\s+([PS]\d+)\s*$', ln)
    if m:
        syms[m.group(2).lower()] = int(m.group(1), 16)
base = min(syms.values())
for n in SIZES:
    p, s = syms[f'p{n}'] - base, syms[f's{n}'] - base
    al = 1
    while s % (al * 2) == 0 and al < 64:
        al *= 2
    print(f'size {n:4d}: pad@{p:#06x} sym@{s:#06x}  gap {s - p - 1:2d}  (offset divisible by {al})')
