#!/usr/bin/env python3
"""side_by_side.py CPP FUNC -- print ours vs oracle instruction lists numbered, for manual alignment."""
import re, sys, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
OBJD = str(MIPS / 'mipsel-none-elf-objdump.exe')

cpp = ROOT / sys.argv[1]
fn = sys.argv[2]

import importlib.util
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
obj = bld.compile_c(cpp, skip_asm=False) if cpp.suffix == '.c' else bld.compile_cpp(cpp)
dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)], capture_output=True, text=True).stdout

_symtab = subprocess.run([OBJD, '-t', str(obj)], capture_output=True, text=True).stdout
_name2addr = {}
for _ln in _symtab.splitlines():
    if '*UND*' in _ln or '*ABS*' in _ln:
        continue
    _t = _ln.split()
    if len(_t) >= 2 and re.match(r'^[0-9a-f]{8}$', _t[0]):
        _name2addr[_t[-1]] = _t[0]
_addr2label = {}
for _ln in dis.splitlines():
    _m = re.match(r'^([0-9a-f]{8}) <(.+)>:', _ln)
    if _m:
        _addr2label.setdefault(_m.group(1), _m.group(2))
def _resolve(fn):
    a = _name2addr.get(fn)
    return _addr2label.get(a, fn) if a else fn

_COP0 = {'sr':'12','status':'12','cause':'13','epc':'14','badvaddr':'8','prid':'15','index':'0',
         'random':'1','entrylo':'2','context':'4','config':'16','bpc':'3','bda':'5','dcic':'7','bdam':'9','bpcm':'11'}

def norm_ins(t):
    t = re.sub(r'\s+', ' ', t.strip())
    t = t.replace('$', '')
    t = re.sub(r'\bs8\b', 'fp', t)
    t = re.sub(r',\s+', ',', t)
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1),16)), t)
    m = re.match(r'^break\b(.*)$', t)
    if m:
        ops = [o for o in re.split(r'[ ,]+', m.group(1).strip()) if o and o != '0']
        t = 'break' + ((' ' + ','.join(ops)) if ops else '')
    m = re.match(r'^syscall\b(.*)$', t)
    if m:
        ops = [o for o in re.split(r'[ ,]+', m.group(1).strip()) if o and o != '0']
        t = 'syscall' + ((' ' + ','.join(ops)) if ops else '')
    t = re.sub(r'\bc0_(\w+)\b', lambda mm: _COP0.get(mm.group(1), mm.group(0)), t)
    t = re.sub(r'\((\d+) ?>> ?(\d+)\)', lambda m: str(int(m.group(1))>>int(m.group(2))), t)
    t = re.sub(r'\((\d+) ?& ?(\d+)\)', lambda m: str(int(m.group(1))&int(m.group(2))), t)
    def _dlabel_lo(m):
        addr = int(m.group(1), 16)
        return str(addr & 0xFFFF) if (addr >> 16) == 0x1F80 else '0'
    def _dlabel_hi(m):
        addr = int(m.group(1), 16)
        return str(addr >> 16) if (addr >> 16) == 0x1F80 else '0'
    t = re.sub(r'%lo\(D_([0-9A-Fa-f]{8})\)', _dlabel_lo, t)
    t = re.sub(r'%hi\(D_([0-9A-Fa-f]{8})\)', _dlabel_hi, t)
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

def ours(fname):
    fname = _resolve(fname)
    lines=[]; inb=False
    for ln in dis.splitlines():
        m=re.match(r'^[0-9a-f]{8} <(.+)>:',ln)
        if m:
            if inb: break
            inb=(m.group(1)==fname); continue
        if inb: lines.append(ln)
    out=[]
    for i,ln in enumerate(lines):
        mm=re.match(r'^\s*[0-9a-f]+:\t([0-9a-f]+)\s*\t(.*)',ln)
        if not mm: continue
        word=mm.group(1); insn=mm.group(2)
        if re.match(r'c(?:op)?2\b', insn):
            out.append('cop2 '+word); continue
        nxt = lines[i+1] if i+1 < len(lines) else ''
        if 'R_MIPS_LO16' in nxt or 'R_MIPS_GPREL16' in nxt:
            insn = re.sub(r',\s*-?(?:0x)?[0-9a-fA-F]+\(', ',0(', insn)
            insn = re.sub(r',\s*-?(?:0x)?[0-9a-fA-F]+$', ',0', insn)
        out.append(norm_ins(insn))
    return out

def oracle(fname):
    p = ROOT / 'asm' / 'nonmatchings' / 'main' / (fname + '.s')
    if not p.exists():
        p = ROOT / 'asm' / 'nonmatchings' / 'front' / (fname + '.s')
    if not p.exists(): return None
    out=[]
    for ln in p.read_text().splitlines():
        ln = re.sub(r'/\*.*?\*/', '', ln)
        s = ln.strip()
        if s.startswith('endlabel'):
            break
        mw = re.match(r'\.word\s+0x([0-9a-fA-F]+)\b', s)
        if mw and (int(mw.group(1),16) >> 26) == 0x12:
            out.append('cop2 ' + mw.group(1).lower()); continue
        if not s or s.startswith(('.','glabel','nonmatching','dlabel','jlabel')) or s.startswith('.L') or s.endswith(':'):
            continue
        out.append(norm_ins(s))
    return out

o = ours(fn)
e = oracle(fn)
n = max(len(o), len(e))
import difflib
sm = difflib.SequenceMatcher(None, o, e, autojunk=False)
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag == 'equal':
        for k in range(i1, i2):
            print(f"  {o[k]}")
    else:
        maxlen = max(i2-i1, j2-j1)
        for k in range(maxlen):
            ol = o[i1+k] if i1+k < i2 else ''
            el = e[j1+k] if j1+k < j2 else ''
            mark = '!=' if tag=='replace' else ('-ONLY' if tag=='delete' else '+ONLY')
            print(f"{mark:6} OURS:{ol:30} ORACLE:{el}")
