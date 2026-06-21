#!/usr/bin/env python3
"""verify_asm.py CPP FUNC[,FUNC...] — compile a recon .cpp (cc1plus+maspsx) and diff each
named function against its asm/nonmatchings/main/<FUNC>.s oracle (spimdisasm format).
Reloc-name + branch-target lenient. Prints PASS/diff per function."""
import re, sys, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
OBJD = str(MIPS / 'mipsel-none-elf-objdump.exe')

cpp = ROOT / sys.argv[1]
funcs = sys.argv[2].split(',')

# compile via build.py's compile_cpp
import importlib.util
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
obj = bld.compile_cpp(cpp)
dis = subprocess.run([OBJD, '-d', '-r', str(obj)], capture_output=True, text=True).stdout

def norm_ins(t):
    t = re.sub(r'\s+', ' ', t.strip())
    t = t.replace('$', '')                                    # drop $ on regs (oracle has them, objdump doesn't)
    t = re.sub(r',\s+', ',', t)                               # normalize space after commas
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1),16)), t)  # hex->dec (case-insens)
    t = re.sub(r'\((\d+) ?>> ?(\d+)\)', lambda m: str(int(m.group(1))>>int(m.group(2))), t)  # eval (N>>M)
    t = re.sub(r'\((\d+) ?& ?(\d+)\)', lambda m: str(int(m.group(1))&int(m.group(2))), t)     # eval (N&M)
    t = re.sub(r'%hi\([^)]*\)', '0', t)            # %hi(SYM) -> 0 (objdump shows lui r,0)
    t = re.sub(r'%lo\([^)]*\)', '0', t)            # %lo(SYM) -> 0
    t = re.sub(r'%gp_rel\([^)]*\)', '0', t)        # %gp_rel(SYM) -> 0
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)   # objdump move idiom -> addu
    # normalize load-immediate idioms BOTH ways -> `li reg,N` (objdump shows `li`;
    # oracle .s shows addiu/ori reg,zero,N depending on the value's sign-range)
    t = re.sub(r'^(?:addiu|ori) (\w+),zero,(\-?\d+)$', r'li \1,\2', t)
    # branch/jump target masking (handles objdump `38 <f+20>`, oracle `.Lxxx`, `funcname`)
    m = re.match(r'(beq|bne)\s+(\w+,\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(j|jal|b)\s+', t)
    if m: return f"{m.group(1)} T"
    return t

def ours(fn):
    out=[]; inb=False
    for ln in dis.splitlines():
        m=re.match(r'^[0-9a-f]{8} <(.+)>:',ln)
        if m:
            if inb: break
            inb=(m.group(1)==fn); continue
        if inb:
            mm=re.match(r'^\s*[0-9a-f]+:\t[0-9a-f]+\s*\t(.*)',ln)
            if mm: out.append(norm_ins(mm.group(1)))
    return out

def oracle(fn):
    p = ROOT / 'asm' / 'nonmatchings' / 'main' / (fn + '.s')
    if not p.exists():
        p = ROOT / 'asm' / 'nonmatchings' / 'front' / (fn + '.s')   # front overlay segment
    if not p.exists(): return None
    out=[]
    for ln in p.read_text().splitlines():
        ln = re.sub(r'/\*.*?\*/', '', ln)                     # strip /* addr hex */ comments
        s = ln.strip()
        if not s or s.startswith(('.','glabel','nonmatching','endlabel','dlabel')) or s.startswith('.L') or s.endswith(':'):
            continue
        out.append(norm_ins(s))
    return out

allpass=True
for fn in funcs:
    o=ours(fn); e=oracle(fn)
    if e is None: print(f"  {fn}: NO ORACLE"); allpass=False; continue
    if not o: print(f"  {fn}: NOT IN OBJECT"); allpass=False; continue
    d=[l for l in __import__('difflib').unified_diff(o,e,lineterm='') if l[0] in '+-' and not l.startswith(('+++','---'))]
    if not d: print(f"  {fn}: PASS ({len(o)} insns)")
    else:
        allpass=False; print(f"  {fn}: FAIL {len(d)} diffs (ours {len(o)} / oracle {len(e)})")
        for l in d[:12]: print("      "+l)
sys.exit(0 if allpass else 1)
