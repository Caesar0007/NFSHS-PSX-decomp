"""romdis.py VA NWORDS [VA NWORDS ...] -- disassemble retail rom/nfs4-f.exe words at VA with the
GNU objdump (raw binary mode), pfn/branch targets left numeric; nearest type:func name printed."""
import bisect
import re
import struct
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
rom = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()
load = struct.unpack_from('<I', rom, 0x18)[0]
fn = []
for ln in open(ROOT / 'configs' / 'symbol_addrs.txt', errors='replace'):
    m = re.match(r'(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func', ln)
    if m:
        fn.append((int(m.group(2), 16), m.group(1)))
fn.sort()
keys = [v for v, _ in fn]


def name(va):
    i = bisect.bisect_right(keys, va) - 1
    v, n = fn[i]
    return n if v == va else f'{n}+{va - v:#x}'


args = sys.argv[1:]
for i in range(0, len(args), 2):
    va = int(args[i], 16)
    n = int(args[i + 1], 0)
    off = va - load + 0x800
    blob = rom[off:off + 4 * n]
    with tempfile.NamedTemporaryFile(delete=False, suffix='.bin') as f:
        f.write(blob)
        tmp = f.name
    out = subprocess.run([OBJDUMP, '-D', '-b', 'binary', '-m', 'mips:3000', '-EL', '--adjust-vma=%#x' % va, tmp],
                         capture_output=True, text=True).stdout
    print(f'== {va:#x} {name(va)}')
    for ln in out.splitlines():
        m = re.match(r'\s*([0-9a-f]+):\s+([0-9a-f]{8})\s+(.*)', ln)
        if m:
            a = int(m.group(1), 16)
            ins = m.group(3)
            jm = re.search(r'\b(jal|j)\s+0x([0-9a-f]+)', ins)
            if jm:
                ins += f'   <{name(int(jm.group(2), 16))}>'
            print(f'  {a:08x} {m.group(2)}  {ins}')
    Path(tmp).unlink()
