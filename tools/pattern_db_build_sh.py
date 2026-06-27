# Phase-2: mine Silent Hill (gcc2.8.1) matched C into the pattern DB (tagged compiler=gcc2.8.1).
# Compiles SH src with its vendored win cc1psx 2.8.1 + our maspsx 2.77 (NO rom needed: a real-C
# function in SH src is matched, so its compiled asm IS the target idiom). Source = C (unmangled).
# Usage: python tools/pattern_db_build_sh.py [src/subdir ...]   (default: all of SH src)
# MERGES into tools/pattern_db.json (must already contain the NFS4 records).
import subprocess, re, json, sys
from pathlib import Path
NFS4=Path(__file__).resolve().parent.parent
SH=Path(r"C:/Temp/silent-hill-decomp")
SCR=Path(r"C:/Users/VYACHE~1/AppData/Local/Temp/claude/C--Temp-claud/ddf16a56-6da7-4366-ad76-3058cd568c75/scratchpad")
GCC=str(SH/"tools/win-build/gcc-win/bin/gcc.exe")
CC1=str(SH/"tools/win-build/gcc-psx/cc1psx.exe")
MASPSX=r"C:/Temp/maspsx-master/maspsx.py"
AS=r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-as.exe"
OBJD=r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
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
SPECIAL={'zero','at','sp','ra','gp','fp','k0','k1','hi','lo'}
def canon(insns):
    rm={}
    def repl(m):
        r=m.group(1)
        if r in SPECIAL: return r
        if r not in rm: rm[r]=f'R{len(rm)}'
        return rm[r]
    return [re.sub(r'\b(zero|at|v[01]|a[0-3]|t\d|s[0-7]|k[01]|gp|sp|fp|ra|hi|lo)\b', repl, i) for i in insns]
def compile_sh(c):
    i=SCR/'shx.i'; s=SCR/'shx.s'; o=SCR/'shx.o'
    r=subprocess.run([GCC,'-E','-nostdinc','-undef','-Iinclude','-Iinclude/psyq','-Iinclude/decomp',
                      '-D__GNUC__=2','-Dpsx','-D__psx__','-D__mips__',str(c),'-o',str(i)],cwd=SH,capture_output=True,text=True)
    if r.returncode: return None
    r=subprocess.run([CC1,'-quiet','-O2','-G0','-mips1','-mcpu=3000','-funsigned-char','-fpeephole',
                      '-ffunction-cse','-fpcc-struct-return','-fcommon','-msoft-float',str(i),'-o',str(s)],capture_output=True,text=True)
    if r.returncode or not s.exists(): return None
    r=subprocess.run(['python',MASPSX,'--aspsx-version=2.77','--run-assembler','--gnu-as-path='+AS,
                      '-EL','-G0','-Iinclude','-o',str(o)],input=s.read_text(errors='replace'),cwd=SH,capture_output=True,text=True)
    if r.returncode or not o.exists(): return None
    return o
def sh_sources(c):
    txt=c.read_text(encoding='utf-8', errors='replace'); sm={}
    for m in re.finditer(r'\n([A-Za-z_][\w \t\*]*?\b(\w+)\s*\([^;{)]*\)[^{};]*\{)', txt):  # [^{};]* allows a trailing // 0xVA comment between ) and {
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
records=[r for r in db['records'] if r.get('game')!='sh']; base=len(records)  # idempotent: replace SH portion
subdirs=sys.argv[1:] or ['src']
cfiles=[]
for sd in subdirs: cfiles+=sorted((SH/sd).rglob('*.c'))
cfail=0
for ci,c in enumerate(cfiles):
    if ci%25==0: print(f"[{ci+1}/{len(cfiles)}] {c.name} (sh recs:{len(records)-base} fail:{cfail})",flush=True)
    o=compile_sh(c)
    if o is None: cfail+=1; continue
    sm=sh_sources(c); funcs=obj_funcs(o)
    for fn,ins in funcs.items():
        if not ins or len(ins)<3: continue
        src=sm.get(fn)
        if src is None: continue   # no matched C in SH src => INCLUDE_ASM (original asm, not a source->asm pair). skip.
        records.append({'func':fn,'file':'SH/'+str(c.relative_to(SH)).replace('\\','/'),'n':len(ins),
                        'asm':ins,'src':src,'compiler':'gcc2.8.1','game':'sh'})
# rebuild index over ALL records
index={}
for rid,rec in enumerate(records):
    asm=rec['asm']; seen=set()
    for n in (2,3,4,5):
        for i in range(len(asm)-n+1):
            key=' | '.join(canon(asm[i:i+n]))
            if key not in seen: seen.add(key); index.setdefault(key,[]).append(rid)
(NFS4/'tools'/'pattern_db.json').write_text(json.dumps({'records':records,'index':index}))
sh=len(records)-base
print(f"SH added: {sh} records (compile-fail files: {cfail}/{len(cfiles)}) | total records: {len(records)} | shapes: {len(index)} | SH src-attached: {sum(1 for r in records[base:] if r['src'])}/{sh}")
