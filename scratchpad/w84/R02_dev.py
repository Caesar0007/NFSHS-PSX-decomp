import re,sys,subprocess,json
from pathlib import Path
ROOT=Path('C:/Temp/nfs4-decomp')
CAND='regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp'
PURE='scratchpad/w84/R02_pure.cpp'     # device-free baseline (constants patched)
def entries(text):
    lines=text.splitlines(True)
    start=None;end=None
    for i,l in enumerate(lines):
        if l.startswith('tGlobalMenuDefs::tGlobalMenuDefs()'): start=i
        if start is not None and l.rstrip()=='{': end=i;break
    ents=[]
    for i in range(start,end):
        m=re.match(r'^\s*[,:]\s*(\w+)\(',lines[i])
        if m: ents.append((i,m.group(1)))
    return lines,ents
def arg_spans(line,name):
    o=line.index(name+'(')+len(name)+1
    d=0; spans=[]; st=o
    for k in range(o,len(line)):
        c=line[k]
        if c in '([{': d+=1
        elif c in ')]}':
            if d==0: spans.append((st,k)); return spans
            d-=1
        elif c==',' and d==0:
            spans.append((st,k)); st=k+1
    return spans
def addr_spans(line,name):
    """arg spans whose text materialises an ADDRESS (a constant folds to nothing)"""
    out=[]
    for a,b in arg_spans(line,name):
        t=line[a:b]
        if '&' in t or re.search(r'screen\w+\[',t) or re.search(r'frontEnd\.',t): out.append((a,b))
    return out
def firstarg_span(line,name):
    s=addr_spans(line,name)
    return s[0] if s else None
def build(devices, out=CAND):
    """devices: list of (entry_index, depth)"""
    text=(ROOT/PURE).read_text(encoding='utf-8',errors='replace')
    lines,ents=entries(text)
    byline={}
    for idx,depth in devices:
        li,nm=ents[idx]; byline.setdefault(li,[]).append((nm,depth))
    for li,items in byline.items():
        s=lines[li]
        for nm,depth in items:
            sp=firstarg_span(s,nm)
            if sp is None: raise SystemExit('no address arg on entry %s'%nm)
            a,b=sp; arg=s[a:b]
            new=arg
            for _ in range(depth): new='({ '+new+'; })'
            s=s[:a]+new+s[b:]
        lines[li]=s
    (ROOT/out).write_text(''.join(lines),encoding='utf-8',newline='')
def gate(out=CAND):
    r=subprocess.run([sys.executable,'regiondiff/tools/verify_region.py','JPN',out,'__15tGlobalMenuDefs',
                      '--lane-as=recon/frontend/common/femenudefs.cpp'],cwd=str(ROOT),capture_output=True,text=True)
    out=r.stdout or r.stderr[-300:]
    o=out.splitlines()[0]
    fr=632
    mf=re.search(r'- addiu sp,sp,(-\d+)',out)
    if mf: fr=-int(mf.group(1))
    m=re.search(r'FAIL (\d+) diffs \(ours (\d+)',o)
    if m: return int(m.group(1)),int(m.group(2)),fr
    if 'REGION-PASS' in o: return 0,int(re.search(r'\((\d+) insns',o).group(1)),fr
    return None,o,fr
