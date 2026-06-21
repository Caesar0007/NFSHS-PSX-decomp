import importlib.util, subprocess, re, difflib, sys
from pathlib import Path
ROOT=Path(__file__).resolve().parent.parent
spec=importlib.util.spec_from_file_location('bld', ROOT/'tools'/'build.py'); bld=importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT=bld.BUILD
OBJD=r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
ASMDIR=ROOT/'asm'/'nonmatchings'/'main'
import itertools
oracles={p.name[:-2] for d in (ASMDIR, ROOT/'asm'/'nonmatchings'/'front') for p in d.glob('*.s')}
# reuse verify_asm norm logic
import importlib.util as ilu
vspec=ilu.spec_from_file_location('vfy', ROOT/'tools'/'verify_asm.py')
# can't exec verify_asm (it runs on import) -> inline norm
def norm(t):
    t=re.sub(r'\s+',' ',t.strip()).replace('$','')
    t=re.sub(r',\s+',',',t); t=re.sub(r'0x([0-9a-fA-F]+)',lambda m:str(int(m.group(1),16)),t)
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
def oracle_ins(fn):
    p=(ASMDIR/(fn+'.s')) if (ASMDIR/(fn+'.s')).exists() else (ROOT/'asm'/'nonmatchings'/'front'/(fn+'.s'));out=[]
    for ln in p.read_text().splitlines():
        ln=re.sub(r'/\*.*?\*/','',ln);s=ln.strip()
        if not s or s.startswith(('.','glabel','nonmatching','endlabel','dlabel')) or s.startswith('.L') or s.endswith(':'):continue
        out.append(norm(s))
    return out
mods=sorted((ROOT/sys.argv[1] if len(sys.argv)>1 else ROOT/'recon'/'game'/'common').glob('*.cpp'))
tot_fn=0; tot_pass=0; near=0; far=0; comp_fail=0; matched=[]; near_list=[]
for m in mods:
    try: obj=bld.compile_cpp(m)
    except SystemExit: comp_fail+=1; continue
    except Exception: comp_fail+=1; continue
    dis=subprocess.run([OBJD,'-d','-r',str(obj)],capture_output=True,text=True).stdout
    # parse function bodies
    cur=None; bodies={}
    for ln in dis.splitlines():
        mm=re.match(r'^[0-9a-f]{8} <(.+)>:',ln)
        if mm: cur=mm.group(1); bodies[cur]=[]; continue
        if cur:
            ii=re.match(r'^\s*[0-9a-f]+:\t[0-9a-f]+\s*\t(.*)',ln)
            if ii: bodies[cur].append(norm(ii.group(1)))
    for fn,ins in bodies.items():
        if fn not in oracles: continue
        tot_fn+=1
        e=oracle_ins(fn)
        d=[l for l in difflib.unified_diff(ins,e,lineterm='') if l[0] in '+-' and not l.startswith(('+++','---'))]
        if not d: tot_pass+=1; matched.append(fn)
        elif len(d)<=15: near+=1; near_list.append((fn,len(d)))
        else: far+=1
print(f"=== BULK VERIFY ===")
print(f"modules: {len(mods)}  compile-fail: {comp_fail}")
print(f"functions with oracle: {tot_fn}")
print(f"  BYTE-MATCH (0 diff): {tot_pass}")
print(f"  near-miss (<=15):    {near}")
print(f"  far (>15):           {far}")
print(f"=== {tot_pass} FREE byte-matches from verbatim import ===")
for f in sorted(matched)[:60]: print('  +',f)
print(f"=== near-misses (<=15 diffs), top 40 ===")
for f,n in sorted(near_list,key=lambda x:x[1])[:40]: print(f'  {n:2} {f}')
