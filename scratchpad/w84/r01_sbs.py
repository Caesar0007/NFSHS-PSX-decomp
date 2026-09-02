#!/usr/bin/env python3
"""R01 scratch: side-by-side of ours (already-built region-gate object) vs the
regional oracle slice, using verify_region's own normalizer, but printed as a
full aligned table with indices so a human can read the real structure.

usage: python r01_sbs.py <FN> [start] [count]
"""
import re, sys, subprocess
from pathlib import Path

ROOT = Path(r'C:/Temp/nfs4-decomp')
OBJ  = ROOT / 'build/recon/frontend/common/femenudefs__region_gate.cpp.o'
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
REGION = 'NFS4-R-USA'

_COP0 = {}

def norm_ins(t):
    t = re.sub(r'\s+', ' ', t.strip())
    t = t.replace('$', '')
    t = re.sub(r'\bs8\b', 'fp', t)
    t = re.sub(r',\s+', ',', t)
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1), 16)), t)
    t = re.sub(r'%hi\([^)]*\)', '0', t)
    t = re.sub(r'%lo\([^)]*\)', '0', t)
    t = re.sub(r'%gp_rel\([^)]*\)', '0', t)
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^or (\w+),zero,(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^or (\w+),(\w+),zero$', r'addu \1,\2,zero', t)
    t = re.sub(r'^(?:addiu|ori) (\w+),zero,(\-?\d+)$', r'li \1,\2', t)
    m = re.match(r'(beq|bne)\s+(\w+,\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(j|jal|b)\s+', t)
    if m: return f"{m.group(1)} T"
    return t

def mask_reloc(t, kind):
    if kind == 'R_MIPS_HI16':
        return re.sub(r'^(lui \w+),.*$', r'\1,A', t)
    if kind in ('R_MIPS_LO16', 'R_MIPS_GPREL16', 'R_MIPS_LITERAL'):
        t = re.sub(r',-?\d+\(', ',A(', t)
        t = re.sub(r',-?\d+$', ',A', t)
    return t

def ours(fn):
    dis = subprocess.run([OBJD, '-d', '-r', '-z', str(OBJ)],
                         capture_output=True, text=True).stdout
    lines = []; inb = False
    for ln in dis.splitlines():
        m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
        if m:
            if inb and re.fullmatch(r'LM\d+', m.group(1)):
                continue
            if inb: break
            inb = (m.group(1) == fn); continue
        if inb: lines.append(ln)
    out = []
    for i, ln in enumerate(lines):
        mm = re.match(r'^\s*[0-9a-f]+:\t([0-9a-f]+)\s*\t(.*)', ln)
        if not mm: continue
        word, insn = mm.group(1), mm.group(2)
        if insn.lstrip().startswith('.word'):
            out.append(('dword ' + word.lower().zfill(8), None)); continue
        nxt = lines[i+1] if i+1 < len(lines) else ''
        mrel = re.search(r'R_MIPS_\w+', nxt)
        out.append((norm_ins(insn), mrel.group(0) if mrel else None))
    return out

def oracle(fn):
    p = ROOT / 'regiondiff' / 'oracles' / REGION / (re.sub(r'[^\w]', '_', fn)[:80] + '.s')
    out = []
    for ln in p.read_text().splitlines():
        s = ln.strip()
        if s.startswith('.section'): break
        s = re.sub(r'/\*.*?\*/', '', ln).strip()
        mw = re.match(r'\.word\s+0x([0-9a-fA-F]+)\b', s)
        if mw:
            out.append('dword ' + mw.group(1).lower().zfill(8)); continue
        if not s or s.startswith(('.', 'glabel', 'nonmatching', 'dlabel', 'jlabel', 'alabel')) or s.endswith(':'):
            continue
        out.append(norm_ins(s))
    return out

fn = sys.argv[1]
start = int(sys.argv[2]) if len(sys.argv) > 2 else 0
count = int(sys.argv[3]) if len(sys.argv) > 3 else 10**9
o = ours(fn); e = oracle(fn)
print(f"# ours {len(o)} / oracle {len(e)}")
n = max(len(o), len(e))
for i in range(start, min(n, start + count)):
    a = o[i][0] if i < len(o) else ''
    k = o[i][1] if i < len(o) else None
    b = e[i] if i < len(e) else ''
    am, bm = (mask_reloc(a, k), mask_reloc(b, k)) if k else (a, b)
    flag = ' ' if am == bm else '*'
    print(f"{i:5d} {flag} {a:<36} | {b}")
