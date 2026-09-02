#!/usr/bin/env python3
"""R11 scratch: same normalisation as regiondiff/tools/verify_region.py but
prints a CONTEXTED side-by-side alignment instead of a bare diff list.
Read-only helper for W84-R11; does not modify any tool.

usage: python scratchpad/w84/R11_rdiff.py REGION CAND FN [--lane-as=recon/...]
"""
import os, re, sys, subprocess, difflib, shutil, importlib.util
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RD   = ROOT / 'regiondiff'
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
OBJD = str(MIPS / 'mipsel-none-elf-objdump.exe')
REGIONS = ['NFS4-R-AU','NFS4-R-FR-DE','NFS4-R-JPN','NFS4-R-UK-ES-IT','NFS4-R-UK-SW','NFS4-R-USA']

args = [a for a in sys.argv[1:] if not a.startswith('--')]
opts = dict(a.split('=',1) for a in sys.argv[1:] if a.startswith('--') and '=' in a)
a0 = args[0].upper()
REGION = next(r for r in REGIONS if a0 == r or a0 == r.replace('NFS4-R-',''))
cand = ROOT / args[1]
fn   = args[2]

sys.path.insert(0, str(ROOT / 'tools'))
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD

lane_as = opts.get('--lane-as')
tmp = None
try:
    src = cand
    if lane_as and cand.resolve() != (ROOT / lane_as).resolve():
        base = ROOT / lane_as
        tmp = base.parent / (base.stem + '__r11diff' + cand.suffix)
        shutil.copyfile(cand, tmp); src = tmp
        base_rel = base.relative_to(ROOT).as_posix()
        tmp_rel  = src.relative_to(ROOT).as_posix()
        for _n, _t in vars(bld).items():
            if isinstance(_t, dict) and base_rel in _t:
                _t[tmp_rel] = _t[base_rel]
    obj = bld.compile_c(src, skip_asm=False) if src.suffix == '.c' else bld.compile_cpp(src)
    dis = subprocess.run([OBJD,'-d','-r','-z',str(obj)],capture_output=True,text=True).stdout
    symtab = subprocess.run([OBJD,'-t',str(obj)],capture_output=True,text=True).stdout
finally:
    if tmp is not None and tmp.exists(): tmp.unlink()

_name2addr={}
for ln in symtab.splitlines():
    if '*UND*' in ln or '*ABS*' in ln: continue
    t=ln.split()
    if len(t)>=2 and re.match(r'^[0-9a-f]{8}$',t[0]): _name2addr[t[-1]]=t[0]
_addr2label={}
for ln in dis.splitlines():
    m=re.match(r'^([0-9a-f]{8}) <(.+)>:',ln)
    if m: _addr2label.setdefault(m.group(1),m.group(2))
def _resolve(f):
    a=_name2addr.get(f); return _addr2label.get(a,f) if a else f

_COP0={'sr':'12','status':'12','cause':'13','epc':'14','badvaddr':'8','prid':'15','index':'0',
       'random':'1','entrylo':'2','context':'4','config':'16','bpc':'3','bda':'5','dcic':'7','bdam':'9','bpcm':'11'}
def norm_ins(t):
    t=re.sub(r'\s+',' ',t.strip()).replace('$','')
    t=re.sub(r'\bs8\b','fp',t); t=re.sub(r',\s+',',',t)
    t=re.sub(r'0x([0-9a-fA-F]+)',lambda m:str(int(m.group(1),16)),t)
    m=re.match(r'^break\b(.*)$',t)
    if m:
        ops=[o for o in re.split(r'[ ,]+',m.group(1).strip()) if o and o!='0']
        t='break'+((' '+','.join(ops)) if ops else '')
    m=re.match(r'^syscall\b(.*)$',t)
    if m:
        ops=[o for o in re.split(r'[ ,]+',m.group(1).strip()) if o and o!='0']
        t='syscall'+((' '+','.join(ops)) if ops else '')
    t=re.sub(r'\bc0_(\w+)\b',lambda mm:_COP0.get(mm.group(1),mm.group(0)),t)
    t=re.sub(r'%hi\([^)]*\)','0',t); t=re.sub(r'%lo\([^)]*\)','0',t); t=re.sub(r'%gp_rel\([^)]*\)','0',t)
    t=re.sub(r'^move (\w+),(\w+)$',r'addu \1,\2,zero',t)
    t=re.sub(r'^or (\w+),zero,(\w+)$',r'addu \1,\2,zero',t)
    t=re.sub(r'^or (\w+),(\w+),zero$',r'addu \1,\2,zero',t)
    t=re.sub(r'^(?:addiu|ori) (\w+),zero,(\-?\d+)$',r'li \1,\2',t)
    m=re.match(r'(beq|bne)\s+(\w+,\w+),',t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m=re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),',t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m=re.match(r'(j|jal|b)\s+',t)
    if m: return f"{m.group(1)} T"
    return t
def skeleton(t): return re.sub(r'-?\b\d+\b','N',t)
def mask_reloc(t,kind):
    if kind=='R_MIPS_HI16': return re.sub(r'^(lui \w+),.*$',r'\1,A',t)
    if kind in ('R_MIPS_LO16','R_MIPS_GPREL16','R_MIPS_LITERAL'):
        t=re.sub(r',-?\d+\(',',A(',t); t=re.sub(r',-?\d+$',',A',t)
    return t

fnl=_resolve(fn); lines=[]; inb=False
for ln in dis.splitlines():
    m=re.match(r'^[0-9a-f]{8} <(.+)>:',ln)
    if m:
        if inb and re.fullmatch(r'LM\d+',m.group(1)): continue
        if inb: break
        inb=(m.group(1)==fnl); continue
    if inb: lines.append(ln)
o=[]
for i,ln in enumerate(lines):
    mm=re.match(r'^\s*[0-9a-f]+:\t([0-9a-f]+)\s*\t(.*)',ln)
    if not mm: continue
    word=mm.group(1); insn=mm.group(2)
    if re.match(r'c(?:op)?2\b',insn): o.append(('cop2 '+word,None)); continue
    if insn.lstrip().startswith('.word'): o.append(('dword '+word.lower().zfill(8),None)); continue
    nxt=lines[i+1] if i+1<len(lines) else ''
    mrel=re.search(r'R_MIPS_\w+',nxt)
    o.append((norm_ins(insn), mrel.group(0) if mrel else None))

p = RD/'oracles'/REGION/(re.sub(r'[^\w]','_',fn)[:80]+'.s')
e=[]; eva=[]
for ln in p.read_text().splitlines():
    s=ln.strip()
    if s.startswith('.section'): break
    va=''
    mva=re.match(r'/\*\s*([0-9A-Fa-f]{8})\s',ln)
    if mva: va=mva.group(1)
    s=re.sub(r'/\*.*?\*/','',ln).strip()
    mw=re.match(r'\.word\s+0x([0-9a-fA-F]+)\b',s)
    if mw and (int(mw.group(1),16)>>26)==0x12: e.append('cop2 '+mw.group(1).lower()); eva.append(va); continue
    if mw: e.append('dword '+mw.group(1).lower().zfill(8)); eva.append(va); continue
    if not s or s.startswith(('.','glabel','nonmatching','dlabel','jlabel','alabel')) or s.endswith(':'): continue
    mc=re.match(r'cop2\s+(\d+)$',norm_ins(s))
    if mc: e.append('cop2 %08x'%(0x4A000000|int(mc.group(1)))); eva.append(va); continue
    e.append(norm_ins(s)); eva.append(va)

o_txt=[x[0] for x in o]; o_kind=[x[1] for x in o]
sm=difflib.SequenceMatcher(None,[skeleton(x) for x in o_txt],[skeleton(x) for x in e],autojunk=False)
ndiff=0
for tag,i1,i2,j1,j2 in sm.get_opcodes():
    if tag=='equal':
        for k in range(i2-i1):
            i,j=i1+k,j1+k
            a,b=o_txt[i],e[j]
            if o_kind[i]: a=mask_reloc(a,o_kind[i]); b=mask_reloc(b,o_kind[i])
            mark='   ' if a==b else '***'
            if a!=b: ndiff+=1
            print(f"{mark} {i:4d} {eva[j]} | {o_txt[i]:44s} | {e[j]}")
    else:
        for i in range(i1,i2):
            ndiff+=1; print(f"-OU {i:4d}          | {o_txt[i]:44s} |")
        for j in range(j1,j2):
            ndiff+=1; print(f"+OR      {eva[j]} | {'':44s} | {e[j]}")
print(f"\n{fn}: diffs {ndiff}  (ours {len(o)} / oracle {len(e)})")
