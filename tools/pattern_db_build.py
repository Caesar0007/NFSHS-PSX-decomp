# Pattern-DB builder: mine SEALED (byte-matching) functions -> (oracle-asm, source) pairs
# + a structural n-gram index (registers canonicalised by first-appearance, symbols/offsets masked).
# Usage: python tools/pattern_db_build.py [recon/subdir ...]   (default: frontend)
import importlib.util, subprocess, re, json, sys
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

SPECIAL={'zero','at','sp','ra','gp','fp','k0','k1','hi','lo'}
def canon(insns):
    regmap={}
    def repl(m):
        r=m.group(1)
        if r in SPECIAL: return r
        if r not in regmap: regmap[r]=f'R{len(regmap)}'
        return regmap[r]
    return [re.sub(r'\b(zero|at|v[01]|a[0-3]|t\d|s[0-7]|k[01]|gp|sp|fp|ra|hi|lo)\b', repl, ins) for ins in insns]

def extract_sources(cpp):
    txt=cpp.read_text(errors='replace')
    parts=re.split(r'/\* ---- (\S+)', txt)
    sm={}
    for i in range(1,len(parts),2):
        name=parts[i]; body=parts[i+1] if i+1<len(parts) else ''
        sm[name]='/* ---- '+name+body
    return sm

def cand_names(mangled):
    # objdump gives mangled; recon markers use mangled / Class::method / bare base.
    c=[mangled]
    if '__' in mangled:
        base,rest=mangled.split('__',1)
        m=re.match(r'(\d+)(.+)',rest)
        if m:
            nn=int(m.group(1)); cls=m.group(2)[:nn]
            if base: c.append(f'{cls}::{base}')
            else: c+= [f'{cls}::{cls}', f'{cls}::~{cls}', f'{cls}::__{cls}']
        if base: c.append(base)
    return c
def attach(fn, sm):
    for c in cand_names(fn):
        if c in sm: return sm[c]
    return None

records=[]
subdirs=sys.argv[1:] or ['recon/frontend/common','recon/frontend/psx']
mods=[]
for sd in subdirs: mods+=sorted((ROOT/sd).rglob('*.cpp'))
comp_fail=0
for mi,m in enumerate(mods):
    if mi%10==0 or mi==len(mods)-1:
        print(f"[{mi+1}/{len(mods)}] {m.name}  (sealed so far: {len(records)}, compile-fail: {comp_fail})", flush=True)
    try: obj=bld.compile_cpp(m)
    except SystemExit: comp_fail+=1; continue
    except Exception: comp_fail+=1; continue
    sm=extract_sources(m)
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
    for fn,ins in bodies.items():
        if fn not in omap: continue
        if ins==oracle_ins(omap[fn]) and ins:   # SEALED (exact byte-match) + non-empty
            src=attach(fn, sm)
            records.append({'func':fn,'file':str(m.relative_to(ROOT)).replace('\\','/'),'n':len(ins),'asm':ins,'src':src})
index={}
for rid,rec in enumerate(records):
    asm=rec['asm']; seen=set()
    for n in (2,3,4,5):
        for i in range(len(asm)-n+1):
            key=' | '.join(canon(asm[i:i+n]))
            if key not in seen: seen.add(key); index.setdefault(key,[]).append(rid)
(ROOT/'tools'/'pattern_db.json').write_text(json.dumps({'records':records,'index':index}))
print(f"SEALED records: {len(records)} | ngram keys: {len(index)} | source-attached: {sum(1 for r in records if r['src'])}/{len(records)}")
