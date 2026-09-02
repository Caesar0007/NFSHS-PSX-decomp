import re,sys,subprocess,itertools,json
ROOT='C:/Temp/nfs4-decomp/'
CAND='regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp'
BASE='scratchpad/w84/R02_base.cpp'
SITES=[  # (name, ON-text, OFF-text)
 ('weather',  '(tListIterator *)({ &iteratorWeather; })',  '(tListIterator *)&iteratorWeather'),
 ('traffic',  '(tListIterator *)({ &iteratorTraffic; })',  '(tListIterator *)&iteratorTraffic'),
 ('speech',   'itemLocalSpeech(0xd3, ({ &iteratorLocalSpeech; }))', 'itemLocalSpeech(0xd3, &iteratorLocalSpeech)'),
 ('mto_dir',  '({ &itemTrackDirection; })', '&itemTrackDirection'),
 ('mto_mir',  '({ &itemTrackMirrored; })',  '&itemTrackMirrored'),
 ('garage',   '({ tMenuItem *garageCarItem = &itemGarageCar; (void)garageCarItem; 0x1a00; })', '0x1a00'),
 ('dpos',     '(tListIterator *)({ &iteratorDisplayPosition; })',  '(tListIterator *)&iteratorDisplayPosition'),
 ('dlap',     '(tListIterator *)({ &iteratorDisplayLapNumber; })', '(tListIterator *)&iteratorDisplayLapNumber'),
 ('dsplit',   'itemDisplaySplitTime(0x1e5, ({ &iteratorDisplaySplitTime; }))', 'itemDisplaySplitTime(0x1e5, &iteratorDisplaySplitTime)'),
]
def build(mask, extra=None):
    s=open(ROOT+BASE,encoding='utf-8',errors='replace').read()
    for i,(n,on,off) in enumerate(SITES):
        want_on = bool(mask>>i & 1)
        if want_on:
            if s.count(on)!=1: raise SystemExit('site %s ON text not unique (%d)'%(n,s.count(on)))
        else:
            if s.count(on)!=1: raise SystemExit('site %s ON text not unique (%d)'%(n,s.count(on)))
            s=s.replace(on,off,1)
    if extra:
        for old,new,cnt in extra:
            if s.count(old)!=cnt: raise SystemExit('extra pattern count %d != %d: %r'%(s.count(old),cnt,old[:60]))
            s=s.replace(old,new)
    open(ROOT+CAND,'w',encoding='utf-8',newline='').write(s)
def gate():
    r=subprocess.run([sys.executable,'regiondiff/tools/verify_region.py','JPN',CAND,'__15tGlobalMenuDefs',
                      '--lane-as=recon/frontend/common/femenudefs.cpp'],cwd=ROOT,capture_output=True,text=True)
    out=r.stdout or r.stderr[-300:]
    o=out.splitlines()[0]
    fr=632
    mf=re.search(r'- addiu sp,sp,(-\d+)',out)
    if mf: fr=-int(mf.group(1))
    m=re.search(r'FAIL (\d+) diffs \(ours (\d+)',o)
    if m: return int(m.group(1)), int(m.group(2)), fr
    if 'REGION-PASS' in o: return 0, int(re.search(r'\((\d+) insns',o).group(1)), fr
    return None, o, fr
if __name__=='__main__':
    if sys.argv[1]=='sweep':
        best=[]
        for mask in range(1<<len(SITES)):
            build(mask)
            d,n,fr=gate()
            names=''.join('1' if mask>>i&1 else '0' for i in range(len(SITES)))
            best.append((d if d is not None else 99999, n, names, fr))
            if mask%64==0: print('..',mask,flush=True)
        best.sort()
        for row in best[:30]: print(row)
        json.dump(best,open(ROOT+'scratchpad/w84/R02_sweep.json','w'))
    elif sys.argv[1]=='one':
        build(int(sys.argv[2],2))
        print(gate())
