# Phase-4: mine Legacy of Kain: Soul Reaver matched C (github.com/fmil95/soul-re, CC0-1.0 public domain)
# into the pattern DB. Soul Reaver's own compiler IS gcc 2.8.1 (== our SH cc1psx, ~= our 2.8.0), so the
# indexed shapes land in our query space. Project is INCOMPLETE -> -DSKIP_ASM neutralizes INCLUDE_ASM
# (only MATCHED functions compile; no ROM / no extracted .s needed). soul-re uses #include "*.c" (14x) so
# a GLOBAL source index is used (a fn's body may live in a different .c than the compiled TU).
# Usage: python tools/pattern_db_build_soulre.py [src/subdir ...]   (default: src/Game src/Overlays)
# MERGES into tools/pattern_db.json (must already contain NFS4 + SH + SOTN). Idempotent (replaces soulre portion).
import subprocess, re, json, sys
from pathlib import Path
NFS4=Path(__file__).resolve().parent.parent
SR=Path(r"C:/Temp/soul-re")
TOOLS=Path(r"C:/Temp/silent-hill-decomp")           # reuse SH's vendored win cc1psx 2.8.1 + gcc preprocessor
SCR=Path(r"C:/Users/VYACHE~1/AppData/Local/Temp/claude/C--Temp-claud/ddf16a56-6da7-4366-ad76-3058cd568c75/scratchpad")
GCC=str(TOOLS/"tools/win-build/gcc-win/bin/gcc.exe")
CC1=str(TOOLS/"tools/win-build/gcc-psx/cc1psx.exe")
MASPSX=r"C:/Temp/maspsx-master/maspsx.py"
AS=r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-as.exe"
OBJD=r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
INC=['-I'+str(SR/'include'),'-I'+str(SR/'src')]
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
    i=SCR/'srx.i'; s=SCR/'srx.s'; o=SCR/'srx.o'
    r=subprocess.run([GCC,'-E','-nostdinc','-undef',*INC,'-D__GNUC__=2','-Dpsx','-D__psx__','-D__mips__',
                      '-DSKIP_ASM','-DTARGET_PSX',str(c),'-o',str(i)],capture_output=True,text=True)
    if r.returncode: return None
    r=subprocess.run([CC1,'-quiet','-O2','-G0','-mips1','-mcpu=3000','-funsigned-char','-fpeephole',
                      '-ffunction-cse','-fpcc-struct-return','-fcommon','-msoft-float',str(i),'-o',str(s)],capture_output=True,text=True)
    if r.returncode or not s.exists(): return None
    r=subprocess.run(['python',MASPSX,'--aspsx-version=2.77','--run-assembler','--gnu-as-path='+AS,
                      '-EL','-G0','-o',str(o)],input=s.read_text(errors='replace'),capture_output=True,text=True)
    if r.returncode or not o.exists(): return None
    return o
def sources(c):
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
records=[r for r in db['records'] if r.get('game')!='soulre']; base=len(records)
subdirs=sys.argv[1:] or ['src/Game','src/Overlays']
cfiles=[]
for sd in subdirs: cfiles+=sorted((SR/sd).rglob('*.c'))
print('building global soul-re source index...',flush=True)
GSM={}
for c in sorted((SR/'src').rglob('*.c')):
    for name,body in sources(c).items(): GSM.setdefault(name,body)
print(f'global source index: {len(GSM)} fns',flush=True)
cfail=0; seen=set()
for ci,c in enumerate(cfiles):
    if ci%20==0: print(f"[{ci+1}/{len(cfiles)}] {c.name} (soulre recs:{len(records)-base} fail:{cfail})",flush=True)
    o=compile_c(c)
    if o is None: cfail+=1; continue
    for fn,ins in obj_funcs(o).items():
        if not ins or len(ins)<3 or fn in seen: continue
        src=GSM.get(fn)
        if src is None: continue
        seen.add(fn)
        records.append({'func':fn,'file':'SOULRE/'+str(c.relative_to(SR)).replace('\\','/'),'n':len(ins),
                        'asm':ins,'src':src,'compiler':'gcc2.8.1','game':'soulre'})
index={}
for rid,rec in enumerate(records):
    asm=rec['asm']; s=set()
    for n in (2,3,4,5):
        for i in range(len(asm)-n+1):
            key=' | '.join(canon(asm[i:i+n]))
            if key not in s: s.add(key); index.setdefault(key,[]).append(rid)
(NFS4/'tools'/'pattern_db.json').write_text(json.dumps({'records':records,'index':index}))
sr=len(records)-base
print(f"SOULRE added: {sr} records (compile-fail files: {cfail}/{len(cfiles)}) | total records: {len(records)} | shapes: {len(index)} | src-attached: {sum(1 for r in records[base:] if r['src'])}/{sr}")
