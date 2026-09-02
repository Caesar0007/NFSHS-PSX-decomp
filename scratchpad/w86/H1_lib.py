"""H1_lib -- build/gate helpers for the W86-H1 JPN __15tGlobalMenuDefs attack.

Unlike W85's M3_lib (which regenerated from scratchpad/w84/R02_base.cpp) this
harness takes the CURRENT CANDIDATE as its base, so the sealed DATA edits
(SelectListOffOn / SelectListTrackDirection) are always preserved.

Work file: scratchpad/w86/H1_work.cpp, gated with --lane-as of the base TU.
"""
import re, os, sys, subprocess

ROOT = 'C:/Temp/nfs4-decomp/'
CAND = 'regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp'
WORK = 'scratchpad/w86/H1_work.cpp'
FN   = '__15tGlobalMenuDefs'

# the nine pre-existing statement-expression sites.
#   (name, INNER = the expression inside `({ ... ; })` at depth>=1,
#          OFF   = the depth-0 spelling)
SITES = [
 ('weather',  '&iteratorWeather',            '&iteratorWeather'),
 ('traffic',  '&iteratorTraffic',            '&iteratorTraffic'),
 ('speech',   '&iteratorLocalSpeech',        '&iteratorLocalSpeech'),
 ('mto_dir',  '&itemTrackDirection',         '&itemTrackDirection'),
 ('mto_mir',  '&itemTrackMirrored',          '&itemTrackMirrored'),
 ('garage',   'tMenuItem *garageCarItem = &itemGarageCar; (void)garageCarItem; 0x1a00', '0x1a00'),
 ('dpos',     '&iteratorDisplayPosition',    '&iteratorDisplayPosition'),
 ('dlap',     '&iteratorDisplayLapNumber',   '&iteratorDisplayLapNumber'),
 ('dsplit',   '&iteratorDisplaySplitTime',   '&iteratorDisplaySplitTime'),
]


def read(path=CAND):
    return open(ROOT + path, encoding='utf-8', errors='replace').read()


def write(s, path=WORK):
    open(ROOT + path, 'w', encoding='utf-8', newline='').write(s)


def wrap(inner, off, d):
    """depth-d statement-expression spelling (d==0 -> the OFF spelling)"""
    if d == 0:
        return off
    return ('({ ' * d) + inner + ('; })' * d)


def find_sites(s):
    """locate the nine sites in `s`; return list of (start,end,inner,off,depth)"""
    out = []
    for name, inner, off in SITES:
        hit = None
        for d in range(5, -1, -1):
            txt = wrap(inner, off, d)
            idxs = [m.start() for m in re.finditer(re.escape(txt), s)]
            if d == 0:
                idxs = [i for i in idxs if s[max(0, i - 3):i] != '({ ']
            if len(idxs) == 1:
                hit = (idxs[0], idxs[0] + len(txt), inner, off, d)
                break
            if len(idxs) > 1:
                raise SystemExit('site %s ambiguous at depth %d (%d hits)' % (name, d, len(idxs)))
        if hit is None:
            raise SystemExit('site %s not found' % name)
        out.append(hit)
    return out


def cfg_of(s):
    return ''.join(str(h[4]) for h in find_sites(s))


def set_cfg(s, cfg):
    hits = find_sites(s)
    # apply right-to-left so offsets stay valid
    order = sorted(range(9), key=lambda i: -hits[i][0])
    for i in order:
        st, en, inner, off, _d = hits[i]
        s = s[:st] + wrap(inner, off, int(cfg[i])) + s[en:]
    return s


def gate(path=WORK, fn=FN):
    r = subprocess.run([sys.executable, 'regiondiff/tools/verify_region.py', 'JPN', path, fn,
                        '--lane-as=recon/frontend/common/femenudefs.cpp'],
                       cwd=ROOT, capture_output=True, text=True)
    out = r.stdout or r.stderr[-800:]
    lines = out.splitlines()
    o = lines[0] if lines else '??'
    fr = None
    mf = re.search(r'[-+] addiu sp,sp,(-\d+)', out)
    if mf:
        fr = -int(mf.group(1))
    m = re.search(r'FAIL (\d+) diffs \(ours (\d+)', o)
    if m:
        return (int(m.group(1)), int(m.group(2)), fr, out)
    if 'REGION-PASS' in o:
        return (0, int(re.search(r'\((\d+) insns', o).group(1)), fr, out)
    return (None, o, fr, out)


def data_gate(path=WORK):
    r = subprocess.run([sys.executable, 'regiondiff/tools/verify_data.py', 'JPN', path,
                        'SelectListOffOn,SelectListTrackDirection',
                        '--lane-as=recon/frontend/common/femenudefs.cpp'],
                       cwd=ROOT, capture_output=True, text=True)
    return (r.stdout or r.stderr)[-600:]


def run(cfg=None, edits=None, base=None, path=WORK):
    """edits = list of (old, new, expected_count)"""
    s = base if base is not None else read()
    if edits:
        for old, new, cnt in edits:
            got = s.count(old)
            if got != cnt:
                raise SystemExit('edit pattern count %d != %d: %r' % (got, cnt, old[:80]))
            s = s.replace(old, new)
    if cfg is not None:
        s = set_cfg(s, cfg)
    write(s, path)
    return gate(path)


if __name__ == '__main__':
    s = read()
    print('candidate cfg =', cfg_of(s))
    print('gate          =', gate(CAND)[:3])
