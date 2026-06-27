# Per-TU match gate: `python tools/check_one.py recon/.../<file>.cpp`
# Prints `pass=N near=M far=K` + the near-miss list. Use to A/B a whole TU
# (pass count MUST NOT drop when applying a per-TU lever).
import importlib.util, subprocess, re, difflib, sys
from pathlib import Path
ROOT=Path(__file__).resolve().parent.parent
spec=importlib.util.spec_from_file_location('bld', ROOT/'tools'/'build.py'); bld=importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT=bld.BUILD
OBJD=r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
omap={}
for d in [ROOT/'asm'/'nonmatchings'/'main', ROOT/'asm'/'nonmatchings'/'front']:
    for p in d.glob('*.s'): omap.setdefault(p.name[:-2], p)
def norm(t):
    t=re.sub(r'\s+',' ',t.strip()).replace('$','');t=re.sub(r',\s+',',',t)
    t=re.sub(r'0x([0-9a-fA-F]+)',lambda m:str(int(m.group(1),16)),t)
    t=re.sub(r'%hi\([^)]*\)','0',t);t=re.sub(r'%lo\([^)]*\)','0',t);t=re.sub(r'%gp_rel\([^)]*\)','0',t)
    t=re.sub(r'^move (\w+),(\w+)$',r'addu \1,\2,zero',t)
    t=re.sub(r'^(?:addiu|ori) (\w+),zero,(\-?\d+)$',r'li \1,\2',t)
    m=re.match(r'(beq|bne)\s+(\w+,\w+),',t)
    if m:return f"{m.group(1)} {m.group(2)},T"
    m=re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),',t)
    if m:return f"{m.group(1)} {m.group(2)},T"
    m=re.match(r'(j|jal|b)\s+',t)
    if m:return f"{m.group(1)} T"
    return t
def oracle_ins(p):
    out=[]
    for ln in p.read_text().splitlines():
        ln=re.sub(r'/\*.*?\*/','',ln);s=ln.strip()
        if s.startswith('endlabel'): break
        if not s or s.startswith(('.','glabel','nonmatching','dlabel','jlabel')) or s.startswith('.L') or s.endswith(':'):continue
        out.append(norm(s))
    return out
obj=bld.compile_cpp(ROOT/sys.argv[1])
dis=subprocess.run([OBJD,'-d','-r',str(obj)],capture_output=True,text=True).stdout
cur=None;bodies={}
for ln in dis.splitlines():
    mm=re.match(r'^[0-9a-f]{8} <(.+)>:',ln)
    if mm: cur=mm.group(1);bodies[cur]=[];continue
    if cur:
        ii=re.match(r'^\s*[0-9a-f]+:\t[0-9a-f]+\s*\t(.*)',ln)
        if ii: bodies[cur].append(norm(ii.group(1)))
        elif 'R_MIPS_LO16' in ln and bodies[cur]:
            l=re.sub(r',-?\d+\(', ',0(', bodies[cur][-1]); bodies[cur][-1]=re.sub(r',-?\d+$', ',0', l)
res=[]
for fn,ins in bodies.items():
    if fn not in omap: continue
    e=oracle_ins(omap[fn])
    d=[l for l in difflib.unified_diff(ins,e,lineterm='') if l[0] in '+-' and not l.startswith(('+++','---'))]
    res.append((len(d) if d else 0, len(ins), len(e), fn))
res.sort()
p=sum(1 for r in res if r[0]==0); near=[r for r in res if 0<r[0]<=15]; far=[r for r in res if r[0]>15]
print(f"{sys.argv[1]}: pass={p} near={len(near)} far={len(far)} (total {len(res)})")
for d,no,ne,fn in near: print(f"  near {d:3}  ours{no}/orc{ne}  {'SAME-LEN' if no==ne else 'len-diff'}  {fn}")
