"""M3_lib — build/gate helpers for the JPN __15tGlobalMenuDefs row (W85-M3).

Never writes the real candidate unless asked: default work file is
scratchpad/w85/M3_work.cpp, gated with --lane-as of the base TU.
"""
import re, os, sys, subprocess

ROOT = 'C:/Temp/nfs4-decomp/'
BASE = 'scratchpad/w84/R02_base.cpp'          # JPN constants, all 9 devices ON
WORK = 'scratchpad/w85/M3_work.cpp'
CAND = 'regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp'
FN   = '__15tGlobalMenuDefs'

SITES = [  # (name, ON-text, OFF-text)  — the TU's nine pre-existing statement-expr sites
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

def src_from(mask, extra=None, base=BASE):
    s = open(ROOT + base, encoding='utf-8', errors='replace').read()
    for i, (n, on, off) in enumerate(SITES):
        if s.count(on) != 1:
            raise SystemExit('site %s ON text not unique (%d)' % (n, s.count(on)))
        if not (mask >> i & 1):
            s = s.replace(on, off, 1)
    if extra:
        for old, new, cnt in extra:
            got = s.count(old)
            if got != cnt:
                raise SystemExit('extra pattern count %d != %d: %r' % (got, cnt, old[:70]))
            s = s.replace(old, new)
    return s

def write(s, path=WORK):
    open(ROOT + path, 'w', encoding='utf-8', newline='').write(s)

def gate(path=WORK, full=False):
    env = dict(os.environ)
    if full:
        env['VA_MAX'] = '100000'
    r = subprocess.run([sys.executable, 'regiondiff/tools/verify_region.py', 'JPN', path, FN,
                        '--lane-as=recon/frontend/common/femenudefs.cpp'],
                       cwd=ROOT, capture_output=True, text=True, env=env)
    out = r.stdout or r.stderr[-400:]
    o = out.splitlines()[0] if out.splitlines() else '??'
    fr = None
    mf = re.search(r'- addiu sp,sp,(-\d+)', out)
    if mf:
        fr = -int(mf.group(1))
    m = re.search(r'FAIL (\d+) diffs \(ours (\d+)', o)
    if m:
        return (int(m.group(1)), int(m.group(2)), fr, out)
    if 'REGION-PASS' in o:
        return (0, int(re.search(r'\((\d+) insns', o).group(1)), fr, out)
    return (None, o, fr, out)

def run(mask, extra=None, path=WORK, base=BASE, full=False):
    write(src_from(mask, extra, base), path)
    return gate(path, full)
