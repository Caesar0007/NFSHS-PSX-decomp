# Auto-hint: given a near-miss, find the source idiom that produces its ORACLE shape.
# Usage: python tools/pattern_suggest.py <recon/.../file.cpp> <MangledName>
# Compiles the fn, diffs vs oracle, isolates the oracle-side divergence windows, and
# queries pattern_db.json for SEALED functions with those shapes -> prints their source.
import importlib.util, subprocess, re, json, difflib, sys
from pathlib import Path
from collections import Counter
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
SPECIAL={'zero','at','sp','ra','gp','fp','k0','k1','hi','lo'}
def canon(insns):
    regmap={}
    def repl(m):
        r=m.group(1)
        if r in SPECIAL: return r
        if r not in regmap: regmap[r]=f'R{len(regmap)}'
        return regmap[r]
    return [re.sub(r'\b(zero|at|v[01]|a[0-3]|t\d|s[0-7]|k[01]|gp|sp|fp|ra|hi|lo)\b', repl, ins) for ins in insns]

db=json.loads((ROOT/'tools'/'pattern_db.json').read_text()); records=db['records']; index=db['index']
cpp=ROOT/sys.argv[1]; fn=sys.argv[2]
obj=bld.compile_cpp(cpp)
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
if fn not in bodies: sys.exit(f"{fn}: not in object")
if fn not in omap: sys.exit(f"{fn}: no oracle")
ours=bodies[fn]; oracle=oracle_ins(omap[fn])
diff=[l for l in difflib.unified_diff(ours,oracle,lineterm='') if l[0] in '+-' and not l.startswith(('+++','---'))]
print(f"{fn}: {len(diff)} diffs (ours {len(ours)} / oracle {len(oracle)})")
if not diff: sys.exit("ALREADY SEALED")
sm=difflib.SequenceMatcher(None, ours, oracle); windows=[]
for tag,i1,i2,j1,j2 in sm.get_opcodes():
    if tag=='equal': continue
    a=max(0,j1-1); b=min(len(oracle),j2+1)
    if b-a>=2: windows.append(oracle[a:b])
print("ORACLE divergence shapes (reproduce these):")
for w in windows[:5]: print("   [ "+'  ;  '.join(w)+" ]")
hits=Counter(); shp={}
for w in windows:
    for n in (5,4,3,2):
        for i in range(len(w)-n+1):
            key=' | '.join(canon(w[i:i+n]))
            for rid in index.get(key,[]):
                if records[rid]['func']==fn: continue
                hits[rid]+=n*n; shp.setdefault(rid,set()).add(key)
if not hits: sys.exit("\nno sealed function has these oracle shapes (novel shape / structural floor).")
print(f"\nSUGGESTIONS -- sealed fns producing the same oracle shape (=> copy their source idiom):")
for rid,score in hits.most_common(5):
    r=records[rid]; best=sorted(shp[rid],key=lambda k:-k.count('|'))[0]
    print(f"\n  --- {r['func']}  [{r['file']}]  score={score} ---")
    print(f"      shape: {best}")
    if r['src']:
        for ln in r['src'].splitlines()[:16]: print("      "+ln)
    else: print("      (no source marker)")
