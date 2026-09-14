#!/usr/bin/env python3
"""diag_diff_targets.py -- classify remaining full_link .text/front.text diffs by
the retail SECTION each diffing reloc site targets.  For every recon object,
place its .text at the implied retail base, walk its relocs, and for each reloc
whose word differs in build/full_link/full.elf vs rom, decode the RETAIL target
address (from the retail %hi/%lo/%gp_rel/jump) and bucket by which retail section
it lands in.  Tells us which placement lever (.bss / .sdata / .rodata / .text /
a genuine code diff) each remaining diff belongs to."""
import re, struct, subprocess
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MAP = Path(r'C:/Temp/_from_github/NFS4.MAP')
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
ROM = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()
ELF = ROOT / 'build' / 'full_link' / 'full.elf'
FOFF = 0x800
LOAD = 0x80010000
GP = 0x8013C54C
romend = LOAD + len(ROM) - FOFF

SECS = [('front.rdata',0x80010000,0x800128F0),('front.text',0x800128F0,0x80051260),
        ('front.data',0x80051260,0x80052B38),('front.bss',0x80052B38,0x80054548),
        ('.rdata',0x80054548,0x8005797C),('.text',0x8005797C,0x8010CCD4),
        ('.data',0x8010CCD4,0x8013C54C),('.sdata',0x8013C54C,0x8013DD7C),
        ('.sbss',0x8013DD7C,0x8013DEE0),('.bss',0x8013DEE0,0x80148B04)]
def secof(a):
    for n,lo,hi in SECS:
        if lo<=a<hi: return n
    return '??'

sym={}
for l in MAP.read_text(errors='replace').splitlines():
    m=re.match(r'^ ([0-9A-F]{8}) (\S+)\s*$',l)
    if m: sym.setdefault(m.group(2),int(m.group(1),16))
NV=re.compile(r'^(?:func|D|DAT|lbl)_([0-9A-Fa-f]{8})$'); DL=re.compile(r'^\.L?_?([0-9A-Fa-f]{8})$')
def aof(n):
    if n in sym: return sym[n]
    m=NV.match(n) or DL.match(n); return int(m.group(1),16) if m else None

def run(*a): return subprocess.run(a,capture_output=True,text=True).stdout
def s16(x): return struct.unpack('<h',struct.pack('<H',x&0xFFFF))[0]
def romw(va):
    o=va-LOAD+FOFF; return int.from_bytes(ROM[o:o+4],'little') if 0<=o<=len(ROM)-4 else None

# our linked image bytes by VA
elfimg={}
for ln in run(OBJD,'-s',str(ELF)).splitlines():
    m=re.match(r'^ ([0-9a-f]{8}) ((?:[0-9a-f]{2,8} ?){1,4})',ln)
    if m:
        va=int(m.group(1),16); d=bytes.fromhex(m.group(2).replace(' ',''))
        for i in range(0,len(d),4):
            if i+4<=len(d): elfimg[va+i]=int.from_bytes(d[i:i+4],'little')

def main():
    srcs=[*Path(ROOT/'recon').rglob('*.cpp'),*Path(ROOT/'recon').rglob('*.c')]
    bucket=Counter(); genuine=0; total_diff=0
    for s in srcs:
        o=ROOT/'build'/(str(s.relative_to(ROOT))+'.o')
        if not o.is_file(): continue
        st=run(OBJD,'-t',str(o))
        fns=[]
        for ln in st.splitlines():
            m=re.match(r'^([0-9a-f]{8})\s+.*F \.text\s+[0-9a-f]{8}\s+(\S+)$',ln)
            if m and aof(m.group(2)) is not None:
                fns.append((int(m.group(1),16),aof(m.group(2))))
        if not fns: continue
        votes=Counter(va-off for off,va in fns)
        tbase=votes.most_common(1)[0][0]
        rl=[]; cur=None
        for ln in run(OBJD,'-r',str(o)).splitlines():
            m=re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]',ln);
            if m: cur=m.group(1); continue
            m=re.match(r'^([0-9a-f]{8})\s+(R_MIPS_\S+)\s+(\S+)$',ln)
            if m and cur=='.text': rl.append((int(m.group(1),16),m.group(2),m.group(3)))
        for ro,ty,tg in rl:
            va=tbase+ro
            if not (LOAD<=va<romend): continue
            rv=romw(va); ov=elfimg.get(va)
            if rv is None or ov is None or rv==ov: continue
            total_diff+=1
            # decode retail target section from the retail instruction
            tgt=None
            if ty in ('R_MIPS_HI16','R_MIPS_LO16'):
                # target section = what the reloc names, else the symbol's sec
                a=aof(tg)
                if a is not None: tgt=a
                elif tg.startswith('.'): tgt={'.text':None}.get(tg,'SEC:'+tg)
            elif ty=='R_MIPS_GPREL16':
                tgt=GP+s16(rv&0xFFFF)
            elif ty=='R_MIPS_26':
                tgt=((va&0xF0000000)|((rv&0x3FFFFFF)<<2))
            if isinstance(tgt,int): bucket[secof(tgt)]+=1
            elif isinstance(tgt,str): bucket[tgt]+=1
            else: bucket['sec-rel/other:'+ty]+=1
    print(f'diff words at .text reloc sites: {total_diff}')
    for k,v in bucket.most_common(): print(f'  {v:6d}  {k}')

if __name__=='__main__': main()
