"""images.py -- shared loaders for the PSYLINK measurement lane: ROM image, our CPE image,
the honest GNU-lane ELF image, and the three symbol tables (retail SYM, our SYM, honest nm)."""
import re, struct, subprocess, sys
from pathlib import Path
ROOT = Path('C:/Temp/nfs4-decomp'); W = ROOT / 'scratchpad' / 'psyq_pipe'
sys.path.insert(0, str(ROOT / 'tools')); import build
OBJDUMP = str(build.MIPS / 'mipsel-none-elf-objdump.exe'); NM = str(build.MIPS / 'mipsel-none-elf-nm.exe')
LOAD = 0x80010000
RETAIL_SYM = Path('C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt')
HONEST_ELF = ROOT / 'build' / 'gen_ld' / 'recon_multdef-ok.elf'
TEXT = [(0x800128F0, 0x80051260), (0x8005797C, 0x8010CCD4)]


def rom():
    return ROOT.joinpath('rom/nfs4-f.exe').read_bytes()[0x800:]


def cpe_image(n):
    cpe = ROOT.joinpath('build/psyq/nfs4.cpe').read_bytes(); img = bytearray(n); cov = bytearray(n); i = 4
    while i < len(cpe):
        t = cpe[i]; i += 1
        if t == 0: break
        if t == 1:
            addr, ln = struct.unpack_from('<II', cpe, i); i += 8; d = cpe[i:i + ln]; i += ln
            o = addr - LOAD
            if 0 <= o and o + ln <= n: img[o:o + ln] = d; cov[o:o + ln] = b'\1' * ln
        else:
            i += {2: 4, 3: 6, 4: 2, 5: 4, 6: 4, 7: 4, 8: 1}[t]
    return img, cov


def honest_image(n):
    """placed image by VA from objdump -s (same device as tools/honest_measure.py)"""
    img = bytearray(n); cov = bytearray(n)
    for ln in subprocess.run([OBJDUMP, '-s', str(HONEST_ELF)], capture_output=True, text=True).stdout.splitlines():
        m = re.match(r'^ ([0-9a-f]{8}) ((?:[0-9a-f]{2,8} ?){1,4})', ln)
        if not m: continue
        va = int(m.group(1), 16); d = bytes.fromhex(m.group(2).replace(' ', ''))
        if va < LOAD or va - LOAD + len(d) > n: continue
        off = va - LOAD; img[off:off + len(d)] = d; cov[off:off + len(d)] = b'\1' * len(d)
    return img, cov


def our_symbols():
    d = {}
    for l in (W / 'nfs4_sym.txt').read_text().splitlines():
        m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) [126] (\S+)$', l)
        if m: d.setdefault(m.group(2), int(m.group(1), 16))
    return d


def retail_functions():
    """sorted [(addr, name)] from the 8c Function-start records"""
    fns = []; pend = None
    for l in RETAIL_SYM.read_text(errors='replace').splitlines():
        m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 8c Function start', l)
        if m: pend = int(m.group(1), 16); continue
        m = re.match(r'\s+name = (\S+)$', l)
        if m and pend is not None: fns.append((pend, m.group(1))); pend = None
    return sorted(set(fns))


def retail_data():
    d = {}
    for l in RETAIL_SYM.read_text(errors='replace').splitlines():
        m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 9[46] Def2? class (EXT|STAT) .* name (\S+)$', l)
        if m: d.setdefault(m.group(3), int(m.group(1), 16))
    return d


def honest_symbols():
    d = {}
    for l in subprocess.run([NM, str(HONEST_ELF)], capture_output=True, text=True).stdout.splitlines():
        m = re.match(r'^([0-9a-f]+) (\w) (\S+)$', l)
        if m: d.setdefault(m.group(3), int(m.group(1), 16))
    return d


def norm(w):
    """instruction shape: relocation fields masked; conditional-branch offsets kept"""
    v = struct.unpack('<I', w)[0]; op = v >> 26
    if op in (2, 3): return v & 0xFC000000
    if op in (0x0f, 0x09, 0x0d, 0x23, 0x2b, 0x20, 0x21, 0x24, 0x25, 0x28, 0x29, 0x22, 0x26, 0x2a, 0x2e, 0x08, 0x32, 0x3a): return v & 0xFFFF0000
    return v


def is_branch_pair(a, b):
    """same conditional branch differing only in offset"""
    va = struct.unpack('<I', a)[0]; vb = struct.unpack('<I', b)[0]
    return (va >> 26) in (1, 4, 5, 6, 7) and (va >> 16) == (vb >> 16)


def text_end(a):
    for lo, hi in TEXT:
        if lo <= a < hi: return hi
    return None
