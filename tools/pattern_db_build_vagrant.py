# Phase-5: mine Vagrant Story matched C (github.com/ser-pounce/rood-reverse, CC0-1.0 public domain) into
# the pattern DB. Vagrant's own compiler is PsyQ 4.6/4.7 (gcc 2.8.x-era); we compile its MATCHED C with the
# SH cc1psx 2.8.1 so the indexed shapes land in our query space. Project INCOMPLETE -> -DPERMUTER neutralizes
# INCLUDE_ASM (src/include/common.h) so only MATCHED functions compile (no ROM/asm). No #include "*.c" -> per-file
# source extraction. PsyQ SDK headers are vendored at include/psx/.
# Usage: python tools/pattern_db_build_vagrant.py [src/overlay ...]   (default: all VS overlays)
# MERGES into tools/pattern_db.json (NFS4+SH+SOTN+SOULRE already present). Idempotent (replaces vagrant portion).
import subprocess, re, json, sys
from pathlib import Path
NFS4=Path(__file__).resolve().parent.parent
VS=Path(r"C:/Temp/rood-reverse")
TOOLS=Path(r"C:/Temp/silent-hill-decomp")
SCR=Path(r"C:/Users/VYACHE~1/AppData/Local/Temp/claude/C--Temp-claud/ddf16a56-6da7-4366-ad76-3058cd568c75/scratchpad")
GCC=str(TOOLS/"tools/win-build/gcc-win/bin/gcc.exe")
CC1=str(TOOLS/"tools/win-build/gcc-psx/cc1psx.exe")
MASPSX=r"C:/Temp/maspsx-master/maspsx.py"
AS=r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-as.exe"
OBJD=r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
OVERLAYS=['BATTLE','ENDING','GIM','MENU','SLUS_010.40','TITLE']
INC=['-I'+str(VS/'include/psx'),'-I'+str(VS/'src/include'),'-I'+str(VS/'src')]
def norm(t):
    t=re.sub(r'\s+',' ',t.strip()).replace('$','');t=re.sub(r',\s+',',',t)
    t=re.sub(r'0x([0-9a-fA-F]+)',lambda m:str(int(m.group(1),16)),t)
    m=re.match(r'^break\b(.*)$',t)
    if m:
        ops=[o for o in re.split(r'[ ,]+',m.group(1).strip()) if o and o!='0']
        t='break'+((' '+','.join(ops)) if ops else '')
    t=re.sub(r'\((\d+) ?>> ?(\d+)\)',lambda m:str(int(m.group(1))>>int(m.group(2))),t)
    t=re.sub(r'\((\d+) ?& ?(\d+)\)',lambda m:str(int(m.group(1))&int(m.group(2))),t)
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
SPECIAL={'zero','at','sp','ra','gp','fp','k0','k1','hi','lo'}
def canon(insns):
    rm={}
    def repl(m):
        r=m.group(1)
        if r in SPECIAL: return r
        if r not in rm: rm[r]=f'R{len(rm)}'
        return rm[r]
    return [re.sub(r'\b(zero|at|v[01]|a[0-3]|t\d|s[0-7]|k[01]|gp|sp|fp|ra|hi|lo)\b', repl, i) for i in insns]
def compile_c(c):
    i=SCR/'vsx.i'; s=SCR/'vsx.s'; o=SCR/'vsx.o'
    r=subprocess.run([GCC,'-E','-nostdinc','-undef',*INC,'-D__GNUC__=2','-Dpsx','-D__psx__','-D__mips__',
                      '-DPERMUTER',str(c),'-o',str(i)],capture_output=True,text=True)
    if r.returncode: return None
    r=subprocess.run([CC1,'-quiet','-O2','-G0','-mips1','-mcpu=3000','-funsigned-char','-fpeephole',
                      '-ffunction-cse','-fpcc-struct-return','-fcommon','-msoft-float',str(i),'-o',str(s)],capture_output=True,text=True)
    if r.returncode or not s.exists(): return None
    r=subprocess.run(['python',MASPSX,'--aspsx-version=2.77','--run-assembler','--gnu-as-path='+AS,
                      '-EL','-G0','-o',str(o)],input=s.read_text(errors='replace'),capture_output=True,text=True)
    if r.returncode or not o.exists(): return None
    return o
def src_funcs(c):
    txt=c.read_text(encoding='utf-8',errors='replace'); sm={}
    for m in re.finditer(r'\n([A-Za-z_][\w \t\*]*?\b(\w+)\s*\([^;{)]*\)[^{};]*\{)', txt):
        name=m.group(2); start=m.start(1); i=txt.index('{',start); depth=0; j=i
        while j<len(txt):
            ch=txt[j]
            if ch=='{':depth+=1
            elif ch=='}':
                depth-=1
                if depth==0:break
            j+=1
        sm[name]=txt[start:j+1][:1800]
    return sm
def obj_funcs(o):
    dis=subprocess.run([OBJD,'-d','-r',str(o)],capture_output=True,text=True).stdout
    cur=None;b={}
    for ln in dis.splitlines():
        mm=re.match(r'^[0-9a-f]{8} <(.+)>:',ln)
        if mm: cur=mm.group(1);b[cur]=[];continue
        if cur:
            ii=re.match(r'^\s*[0-9a-f]+:\t[0-9a-f]+\s*\t(.*)',ln)
            if ii: b[cur].append(norm(ii.group(1)))
            elif 'R_MIPS_LO16' in ln and b[cur]:
                l=re.sub(r',-?\d+\(', ',0(', b[cur][-1]); b[cur][-1]=re.sub(r',-?\d+$', ',0', l)
    return b

db=json.loads((NFS4/'tools'/'pattern_db.json').read_text())
records=[r for r in db['records'] if r.get('game')!='vagrant']; base=len(records)
subdirs=sys.argv[1:] or ['src/'+d for d in OVERLAYS]
cfiles=[]
for sd in subdirs: cfiles+=sorted((VS/sd).rglob('*.c'))
cfail=0; seen=set()
for ci,c in enumerate(cfiles):
    if ci%25==0: print(f"[{ci+1}/{len(cfiles)}] {c.name} (vagrant recs:{len(records)-base} fail:{cfail})",flush=True)
    o=compile_c(c)
    if o is None: cfail+=1; continue
    funcs=obj_funcs(o); srcs=src_funcs(c)
    for fn,ins in funcs.items():
        if not ins or len(ins)<3 or fn in seen: continue
        src=srcs.get(fn)
        if src is None: continue
        seen.add(fn)
        records.append({'func':fn,'file':'VAGRANT/'+str(c.relative_to(VS)).replace('\\','/'),'n':len(ins),
                        'asm':ins,'src':src,'compiler':'psyq46','game':'vagrant'})
index={}
for rid,rec in enumerate(records):
    asm=rec['asm']; s=set()
    for n in (2,3,4,5):
        for i in range(len(asm)-n+1):
            key=' | '.join(canon(asm[i:i+n]))
            if key not in s: s.add(key); index.setdefault(key,[]).append(rid)
(NFS4/'tools'/'pattern_db.json').write_text(json.dumps({'records':records,'index':index}))
vs=len(records)-base
print(f"VAGRANT added: {vs} records (compile-fail files: {cfail}/{len(cfiles)}) | total records: {len(records)} | shapes: {len(index)} | src-attached: {sum(1 for r in records[base:] if r['src'])}/{vs}")
