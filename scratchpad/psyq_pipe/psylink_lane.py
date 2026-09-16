#!/usr/bin/env python3
"""psylink_lane.py -- the ORIGINAL SN pipeline as a measurement lane:
cc1 .s (from build/) -> ASPSX 2.77 (-G per TU, -sfront for the frontend overlay)
-> PSYLINK 2.73 in the retail link order (from the SYM FILE records)
-> dumpsym -> per-object section starts vs the retail SYM.
usage: psylink_lane.py [--assemble] [--link] [--compare]  (default: all)"""
import sys, re, json, subprocess, os
from pathlib import Path
from collections import defaultdict, Counter
ROOT = Path('C:/Temp/nfs4-decomp'); sys.path.insert(0, str(ROOT / 'tools'))
import build
ASPSX = 'C:/Temp/psq43/PSSN/ASPSX.EXE'; PSYLINK = 'C:/Temp/psq43/PSSN/PSYLINK.EXE'
DUMPSYM = 'C:/Temp/claud/dumpsym_clean/dumpsym_src/dumpsym.exe'
RETAIL_SYM_TXT = Path('C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt')
OUT = ROOT / 'build' / 'psyq'; OUT.mkdir(parents=True, exist_ok=True)
W = ROOT / 'scratchpad' / 'psyq_pipe'
steps = [a for a in sys.argv[1:] if a.startswith('--')] or ['--assemble', '--link', '--compare']


def key_of(objname):
    m = re.search(r'\(([^)]+)\)$', objname)
    base = m.group(1) if m else objname.split('\\')[-1]
    return base.rsplit('.', 1)[0].lower()


def crlf(src: Path, dst: Path):
    # same dtor-prefix convention as build.py's GNU lane (`_._X` -> `___X`) so the
    # hand-written vtable references resolve; the compare step maps it back.
    dst.write_bytes(src.read_bytes().replace(b'_._', b'___').replace(b'\r\n', b'\n').replace(b'\n', b'\r\n'))


if '--assemble' in steps:
    ok = bad = 0; fails = []
    srcs = sorted([*(ROOT / 'recon').rglob('*.cpp'), *(ROOT / 'recon').rglob('*.c')])
    for s in srcs:
        sfile = ROOT / 'build' / (s.relative_to(ROOT).as_posix() + '.s')
        if not sfile.is_file():
            continue
        rel = s.relative_to(ROOT).as_posix()
        g = str(build.per_tu_flags(s.resolve()).get('g_value', build.G_VALUE))
        tmp = OUT / (rel.replace('/', '__') + '.s'); crlf(sfile, tmp)
        obj = OUT / (rel.replace('/', '__') + '.obj')
        cmd = [ASPSX, '-q', f'-G{g}'] + (['-sfront'] if rel.startswith('recon/frontend/') else []) + [str(tmp), '-o', str(obj)]
        if obj.exists():
            obj.unlink()
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=120)
        if obj.is_file():
            ok += 1
        else:
            bad += 1; fails.append((rel, (r.stdout + r.stderr).strip().splitlines()[:2]))
    # placeholders: bigbuf (the 0x44548 .rdata reservation the front overlay sits over)
    # and address (FrontStartAddress) -- the two retail data-only objects.
    (W / 'bigbuf.s').write_bytes(b'\t.rdata\r\n\t.globl\tbigBuf\r\nbigBuf:\r\n\t.space\t0x44548\r\n')
    (W / 'address.s').write_bytes(b'\t.rdata\r\n\t.globl\tFrontStartAddress\r\nFrontStartAddress:\r\n\t.word\t0x80010000\r\n')
    for n in ('bigbuf', 'address'):
        subprocess.run([ASPSX, '-q', str(W / (n + '.s')), '-o', str(OUT / (n + '.obj'))], capture_output=True, text=True)
    print('ASPSX ok %d bad %d' % (ok, bad))
    (W / 'assemble_fails.json').write_text(json.dumps(fails, indent=0))

if '--link' in steps:
    order = json.load(open(W / 'sym_obj_order.json'))
    seen = []
    for o in order:
        if not seen or seen[-1] != o[0]:
            seen.append(o[0])
    ours = defaultdict(list)
    for p in OUT.glob('*.obj'):
        k = p.name.split('__')[-1].split('.')[0].lower() if '__' in p.name else p.stem.lower()
        ours[k].append(p.name)
    inc = []; missing = []
    for n in seen:
        k = key_of(n)
        if k in ours:
            cands = ours[k]
            hint = 'syslib' if 'syslib' in n else 'eaclib' if 'eaclib' in n else None
            lib = re.search(r'([A-Za-z0-9_]+)\.lib\(', n)
            if hint:
                pick = next((c for c in cands if hint in c and (not lib or lib.group(1).lower() in c.lower())), None)
            else:
                pick = next((c for c in cands if 'syslib' not in c and 'eaclib' not in c), None)
            if pick is None:
                missing.append(n); continue
            inc.append((n, pick))
        else:
            missing.append(n)
    # GNU-lane carrier subsections (.data.replay_*, .bss.newton_*, .rodata, ...) that
    # PSYLINK would otherwise drop into a "(default)" group at the org: map them into
    # their natural groups right after their parent section, keeping .sdata/.sbss
    # adjacent (gp = .sdata start, +-32KB reach, exactly like retail's 0x8013C54C).
    extra = set()
    for sp in OUT.glob('*.s'):
        b = sp.read_bytes()
        for m in re.finditer(rb'^\s*\.section\s+([.\w]+)', b, re.M):
            extra.add(m.group(1).decode())
        if re.search(rb'^\s*\.rodata\b', b, re.M):
            extra.add('.rodata')
    extra -= {'.text', '.rdata', '.data', '.sdata', '.sbss', '.bss'}
    extra = sorted(n for n in extra if not n.startswith('front.'))
    def sub(prefixes):
        return ['\tsection\t%s,%s' % (n, 'bss' if n.startswith(('.bss', '.sbss')) else 'text')
                for n in extra if n.startswith(prefixes)]
    lnk = ['\torg\t$80010000', 'text\tgroup', 'bss\tgroup\tbss', 'front\tgroup\tover(text)',
           '\tsection\t.rdata,text'] + sub(('.rodata', '.rdata.')) + ['\tsection\t.text,text'] + sub(('.text.',)) + \
          ['\tsection\t.data,text'] + sub(('.data.',)) + ['\tsection\t.sdata,text'] + sub(('.sdata.',)) + \
          ['\tsection\t.sbss,bss'] + sub(('.sbss.',)) + ['\tsection\t.bss,bss'] + sub(('.bss.',)) + \
          ['\tsection\tfront.rdata,front', '\tsection\tfront.text,front', '\tsection\tfront.data,front',
           '\tsection\tfront.bss,front']
    for n, p in inc:
        lnk.append('\tinclude\t%s\t; %s' % (p, n))
    if (OUT / 'stub.obj').exists():
        lnk.append('\tinclude\tstub.obj\t; undefined-symbol stubs (measurement only; last object)')
    (OUT / 'nfs4.lnk').write_bytes(('\r\n'.join(lnk) + '\r\n').encode())
    print('LNK: %d objects included, %d retail objects missing:' % (len(inc), len(missing)), missing)
    env = dict(os.environ, MSYS2_ARG_CONV_EXCL='*', MSYS_NO_PATHCONV='1')
    for f in ('nfs4.cpe', 'nfs4.sym', 'nfs4.map'):
        if (OUT / f).exists():
            (OUT / f).unlink()
    r = subprocess.run([PSYLINK, '/c', '/m', '@nfs4.lnk,nfs4.cpe,nfs4.sym,nfs4.map'], cwd=OUT,
                       capture_output=True, text=True, timeout=600, env=env)
    log = r.stdout + r.stderr; (W / 'psylink.log').write_text(log)
    errs = [l for l in log.splitlines() if 'Error' in l]
    kinds = Counter(re.sub(r"'[^']*'", "'X'", e.split(':', 2)[-1].strip()) for e in errs)
    print('PSYLINK: %d error lines; kinds: %s' % (len(errs), kinds.most_common(6)))
    print('outputs:', {f: ((OUT / f).stat().st_size if (OUT / f).exists() else None) for f in ('nfs4.cpe', 'nfs4.sym', 'nfs4.map')})

if '--compare' in steps:
    def parse_symtxt(txt):
        """retail dump: per-object blocks end with a FILE record; data symbols come from the
        94/96 Def[2] class EXT/STAT records (address + name), functions from 8c blocks."""
        objs = []; cur = []; fns = []; pending_fn = None
        for l in txt.splitlines():
            m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 8c Function start', l)
            if m:
                pending_fn = int(m.group(1), 16); continue
            m = re.match(r'\s+name = (\S+)$', l)
            if m and pending_fn is not None:
                fns.append((pending_fn, m.group(1))); pending_fn = None; continue
            m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) 9[46] Def2? class (EXT|STAT) .* name (\S+)$', l)
            if m:
                cur.append((int(m.group(1), 16), m.group(3))); continue
            m = re.match(r'^[0-9a-f]+: \$[0-9a-f]{8} 94 Def class FILE type NULL size 0 name (\S+)', l)
            if m:
                objs.append((m.group(1), cur, fns)); cur = []; fns = []
        return objs

    r = subprocess.run([DUMPSYM, str(OUT / 'nfs4.sym')], capture_output=True, text=True, timeout=600)
    (W / 'nfs4_sym.txt').write_text(r.stdout)
    ours = parse_symtxt(r.stdout); retail = parse_symtxt(RETAIL_SYM_TXT.read_text(errors='replace'))

    def by_obj(objs):
        d = {}
        for n, syms, fns in objs:
            k = key_of(n)
            if not syms and not fns:
                continue
            d.setdefault(k, {'fn': (min(a for a, _ in fns) if fns else None), 'syms': dict((s, a) for a, s in syms + fns)})
        return d

    rt = by_obj(retail)
    flat = {}
    for l in r.stdout.splitlines():
        m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) (1|2|6) (\S+)$', l)
        if m:
            flat.setdefault(m.group(3), int(m.group(1), 16))
            if m.group(3).startswith('___'):
                flat.setdefault('_._' + m.group(3)[3:], int(m.group(1), 16))
    print('symbols: ours %d retail objects %d' % (len(flat), len(rt)))
    rows = []
    for k in rt:
        common = [s for s in rt[k]['syms'] if s in flat]
        if not common:
            continue
        dd = sorted(set(flat[s] - rt[k]['syms'][s] for s in common))
        rf = rt[k]['fn']
        rows.append((k, rf, None, None, len(common), dd[:6]))
    rows.sort(key=lambda r: (r[1] or 0))
    print('%-26s %10s nsym  symbol address deltas ours-retail (distinct, first 6)' % ('object', 'retail_fn'))
    for k, rf, of, d, n, dd in rows:
        print('%-26s %10s %4d  %s' % (k, ('%#x' % rf) if rf else '-', n, ['%+#x' % x for x in dd]))
    (W / 'compare_rows.json').write_text(json.dumps(rows, indent=0))
