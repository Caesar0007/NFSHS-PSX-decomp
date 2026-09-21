#!/usr/bin/env python3
"""slink_lane.py -- link the project the way the ORIGINAL build did, as a test lane.

What the original build looked like (evidence: BUILDING.md "How retail was linked"):
  * the linker was SN's SLINK (the retail NFS4.MAP is in slink's map format: no "Program entry point" line, one space
    between address and name; PSYLINK writes both differently), run with /strip = function-level dead stripping;
  * Sony's libraries were linked PREBUILT (`inclib ..\\syslib\\psx\\lib\\libgpu.lib` -- the SYM FILE records carry those
    paths) and so was Sony's startup object 2MBYTE.OBJ;
  * EA's own libraries (eacpsxz / sndpsxz / spchpsxz) were `.lib` files too: their members appear in the retail link
    order interleaved with Sony's, i.e. pulled on demand, not listed.

This lane therefore builds:
  game objects   = our C through cc1 + ASPSX (psylink_lane.py in NFS4_LANE_OFFICIAL mode: LINK_STRIPPED bodies are KEPT
                   in .text -- the linker has to remove them, not us -- and no retail-derived pads are added)
  EA libraries   = PSYLIB2 /a over our objects, under the retail member names
  Sony libraries = the untouched PsyQ 4.3 LIB files + 2MBYTE.OBJ
and links them with slink, then reports: section sizes vs retail, what /strip removed vs linkers/link_stripped.json,
and whether the library members came out in the retail order.

usage: NFS4_LANE_OFFICIAL=1 NFS4_LANE_OUT=build/psyq_off python tools/psyq_pipe/psylink_lane.py --assemble --link
       python tools/psyq_pipe/slink_lane.py [--slink PATH] [--nostrip] [--variant NAME] [slink options...]
"""
import json
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
OUT = ROOT / os.environ.get('NFS4_LANE_OUT', 'build/psyq_off')
SDK = Path('C:/Temp/psq43')
SDKLIB = SDK / 'PSX' / 'LIB'
PSYLIB = str(SDK / 'PSSN' / 'PSYLIB2.EXE')
SLINK = str(ROOT / 'build/tmp/slink3b/slink.exe')      # SN slink Beta 3.0, 1999-01-05 (PsyQ 4.4 CD: pssn/Slink/slink3b.zip)
ENV = dict(os.environ, MSYS2_ARG_CONV_EXCL='*', MSYS_NO_PATHCONV='1')
BS = chr(92)
args = sys.argv[1:]
if '--slink' in args:
    SLINK = args[args.index('--slink') + 1]
    del args[args.index('--slink'):args.index('--slink') + 2]
variant = 'off'
if '--variant' in args:
    variant = args[args.index('--variant') + 1]
    del args[args.index('--variant'):args.index('--variant') + 2]
if '--sdklib' in args:                      # Sony LIB directory to link against (default PsyQ 4.3)
    SDKLIB = Path(args[args.index('--sdklib') + 1])
    del args[args.index('--sdklib'):args.index('--sdklib') + 2]
LIBFROM = {}                               # --lib LIBCD=C:/Temp/psq44/psx/lib/LIBCD.LIB : one library from another SDK release
while '--lib' in args:
    k, v = args[args.index('--lib') + 1].split('=', 1)
    LIBFROM[k.upper()] = Path(v)
    del args[args.index('--lib'):args.index('--lib') + 2]
FRONTALIGN = '8'                           # `section.8 front.text,front` ...: slink then aligns every object's chunk to 8 (--frontalign 0 = off)
if '--frontalign' in args:
    FRONTALIGN = args[args.index('--frontalign') + 1]
    del args[args.index('--frontalign'):args.index('--frontalign') + 2]
STRIP = '--nostrip' not in args
LIBORDER = None
if '--liborder' in args:
    LIBORDER = args[args.index('--liborder') + 1].split(',')
    del args[args.index('--liborder'):args.index('--liborder') + 2]
extra = [a for a in args if a.startswith('/') or (a and not a.startswith('--'))]
if not LIBFROM and '--sdklib' not in sys.argv:
    LIBFROM = {'LIBCD': Path('C:/Temp/psq44/psx/lib/LIBCD.LIB')}   # retail's libcd is the PsyQ 4.4 one (CdRead is 39 words longer than 4.3's)
if not extra:
    extra = ['-nostrip', 'stup1', '-nostrip']                    # the slink manual's own advice for Sony's startup object
if FRONTALIGN in ('0', '4'):
    FRONTALIGN = None

SLINK_ZIP = Path('C:/Temp/psq44/pssn/Slink/slink3b.zip')      # where SN shipped it: the PsyQ 4.4 CD (not vendored: SN's copyright)
if not Path(SLINK).exists() and SLINK_ZIP.exists():
    import zipfile
    Path(SLINK).parent.mkdir(parents=True, exist_ok=True)
    zipfile.ZipFile(SLINK_ZIP).extractall(Path(SLINK).parent)

RET = [('front.rdata', 0x28F0), ('front.text', 0x3E970), ('front.data', 0x18D8), ('front.bss', 0x1A10),
       ('.rdata', 0x4797C), ('.text', 0xB5358), ('.data', 0x2F878), ('.sdata', 0x1830), ('.sbss', 0x164), ('.bss', 0xAC24)]

# ---------------------------------------------------------------- 1. split the lane's script into game / EA lib / Sony
src = (OUT / 'nfs4.lnk').read_text(encoding='latin-1').splitlines()
head, game, equs = [], [], []
ealibs = {}            # lib -> [(member, our object file)]
sony_dropped, gaps = [], []
prev_kind = 'game'
for ln in src:
    m = re.match(r'^\s+include\s+(\S+)\s*(?:;\s*(.*))?$', ln)
    if not m:
        if re.match(r'^\S+\s+equ\s', ln):
            equs.append(ln)
        elif ln.strip().startswith(';') or not ln.strip():
            continue
        else:
            head.append(ln)
        continue
    fn, note = m.group(1), (m.group(2) or '').strip()
    if fn == 'phase.obj':
        continue                                   # measurement pad of the PSYLINK lane
    if note.startswith('<after'):
        kind = prev_kind
    elif 'syslib' + BS in note:
        kind = 'sony'
    elif re.search(r'eaclib\\psx\\(\w+)\.lib\((\w+)\.obj\)', note):
        kind = 'ea'
    else:
        kind = 'game'
    prev_kind = kind
    if fn.startswith('gap__'):
        if kind == 'ea':
            gaps.append((fn, note))
        continue
    if kind == 'sony':
        sony_dropped.append((fn, note))
        if note.lower().endswith('2mbyte.obj'):
            game.append('\tinclude\t"%s"' % str(SDKLIB / '2MBYTE.OBJ').replace('/', BS))
    elif kind == 'ea':
        mm = re.search(r'eaclib\\psx\\(\w+)\.lib\((\w+)\.obj\)', note)
        if mm:
            ealibs.setdefault(mm.group(1), []).append((mm.group(2), fn))
        else:                                      # `<after X>` split of an EA member: keep it next to its parent
            lib = list(ealibs)[-1]
            ealibs[lib].append((Path(fn).name.split('__')[-1].split('.')[0] + '_x', fn))
    else:
        game.append('\tinclude\t%s' % fn)

# ---------------------------------------------------------------- 2. EA's libraries, made with the SN librarian
LIBDIR = OUT / 'ealib'
if LIBDIR.exists():
    shutil.rmtree(LIBDIR)
for lib, members in ealibs.items():
    d = LIBDIR / lib
    d.mkdir(parents=True)
    names = []
    for member, fn in members:
        shutil.copy(OUT / fn, d / (member + '.obj'))
        names.append(member + '.obj')
    for i in range(0, len(names), 40):
        r = subprocess.run([PSYLIB, '/q', '/a', lib + '.lib', *names[i:i + 40]], cwd=d, capture_output=True, text=True, env=ENV)
        if r.returncode:
            print('PSYLIB2 failed:', lib, (r.stdout + r.stderr).strip()[:300])
            sys.exit(1)
    shutil.copy(d / (lib + '.lib'), OUT / (lib + '.lib'))
    print('PSYLIB2  %-13s %3d members, %7d B' % (lib + '.lib', len(names), (OUT / (lib + '.lib')).stat().st_size))

# ---------------------------------------------------------------- 3. the script
sony_libs = sorted({re.search(r'lib\\(\w+)\.lib', n).group(1).lower() for _, n in sony_dropped if re.search(r'lib\\(\w+)\.lib', n)})
liborder = LIBORDER or (list(ealibs) + sony_libs)
lnk = []
for ln in head:
    s = ln.strip()
    if s.startswith('front') and 'group' in s:
        ln = 'front\tgroup\tover(text),file("%s_front.bin")' % variant
    lnk.append(ln)
    if re.match(r'^\s+org\s', ln):
        lnk.append('\tregs\tpc=__SN_ENTRY_POINT')
lnk = [l for l in lnk if not re.match(r'^\s+section\s', l)]
# The section list of EA's script, read off the retail MAP: slink makes `_<section>_obj/_org` symbols for every section the
# script names, and retail has them for .ctors/.dtors (empty, end of `text`), four empty `textpsx.*` sections, front.sdata
# and front.sbss (empty, between front.data and front.bss), front.ctors/front.dtors (empty, end of `front`) and a `last`
# group at the very end of .bss (`__last_obj`, which the game takes as the start of free memory).
if '--oldscript' in sys.argv:
    lnk += ['\tsection\t.rdata,text', '\tsection\t.text,text', '\tsection\t.data,text', '\tsection\t.sdata,text',
            '\tsection\t.ctors,text', '\tsection\t.dtors,text', '\tsection\t.sbss,bss', '\tsection\t.bss,bss',
            '\tsection\tfront.rdata,front', '\tsection\tfront.text,front', '\tsection\tfront.data,front', '\tsection\tfront.bss,front',
            '\tsection\tfront.ctors,front', '\tsection\tfront.dtors,front']
else:
    k = next(i for i, l in enumerate(lnk) if l.startswith('front') and 'group' in l)
    lnk.insert(k, 'last\tgroup\tbss')
    lnk += ['\tsection\t.rdata,text', '\tsection\t.text,text', '\tsection\t.data,text', '\tsection\t.sdata,text',
            '\tsection\t.ctors,text', '\tsection\t.dtors,text',
            '\tsection\ttextpsx.text,text', '\tsection\ttextpsx.rdata,text', '\tsection\ttextpsx.data,text', '\tsection\ttextpsx.sdata,text',
            '\tsection\t.sbss,bss', '\tsection\t.bss,bss', '\tsection\t.last,last',
            '\tsection\tfront.rdata,front', '\tsection\tfront.text,front', '\tsection\tfront.data,front',
            '\tsection\tfront.sdata,front', '\tsection\tfront.sbss,front', '\tsection\tfront.bss,front',
            '\tsection\tfront.ctors,front', '\tsection\tfront.dtors,front']
if FRONTALIGN:
    lnk = [l.replace('\tsection\tfront.', '\tsection.%s\tfront.' % FRONTALIGN) for l in lnk]
# the overlay objects carry PLAIN section names; `include x.obj,front` makes the LINKER prefix them -- which also sends
# their COMMONs to front.bss, with the linker's own layout (front.bss exact that way; a hand-made layout was 24 short)
fr = set(json.load(open(OUT / 'front_objs.json'))) if (OUT / 'front_objs.json').exists() and '--oldscript' not in sys.argv else set()
game = [g + ',front' if g.split()[-1] in fr else g for g in game]
lnk += game
for fn, note in (gaps if '--gaps' in sys.argv else []):   # retail-byte fillers of the PSYLINK lane: not part of an original-style link
    lnk.append('\tinclude\t%s\t; %s (retail bytes, no TU yet)' % (fn, note))
for lib in liborder:
    p = (OUT / (lib + '.lib')) if lib in ealibs else LIBFROM.get(lib.upper(), SDKLIB / (lib.upper() + '.LIB'))
    lnk.append('\tinclib\t"%s"' % str(p).replace('/', BS))
# nothing of recon/syslib may be in this link: Sony's code comes from Sony's own LIB files only
leaked = [l for l in lnk if re.search(r'include.*syslib', l, re.I)] + [m for v in ealibs.values() for m in v if 'syslib' in m[1].lower()]
assert not leaked, leaked
print('syslib   reconstructed Sony objects in this link: 0 (%d dropped; Sony code comes from the LIB files only)' % len(sony_dropped))
print('script  %s.lnk: %d game includes, %d EA members in %d libs, %d Sony objects left to inclib (%s)'
      % (variant, len(game), sum(len(v) for v in ealibs.values()), len(ealibs), len(sony_dropped), ' '.join(sony_libs)))

# ---------------------------------------------------------------- 4. link
for f in (variant + '.cpe', variant + '.sym', variant + '.map', variant + '_front.bin', 'statcov.txt'):
    if (OUT / f).exists():
        (OUT / f).unlink()
cmd = [SLINK, '/psx', '/c', *(['/strip'] if STRIP else ['/st']), *extra, '@%s.lnk,%s.cpe,%s.sym,%s.map' % ((variant,) * 4)]
# pass 1 without any `equ`: only the names NOTHING defines (residual data labels of the game objects) get equated to their
# retail address; the PSYLINK lane's other equates were holes inside Sony's data, which Sony's libraries define themselves.
(OUT / (variant + '.lnk')).write_text('\r\n'.join(lnk) + '\r\n', encoding='latin-1')
r = subprocess.run(cmd, cwd=OUT, capture_output=True, text=True, env=ENV, timeout=900)
undefined = set(re.findall(r"Symbol '([^']+)' not defined", r.stdout + r.stderr))
need = [e for e in equs if e.split()[0] in undefined]
(OUT / (variant + '.lnk')).write_text('\r\n'.join(lnk + need) + '\r\n', encoding='latin-1')
print('equ      %d of the PSYLINK lane\'s %d equates needed (game data labels no source owns yet); still undefined: %d'
      % (len(need), len(equs), len(undefined - {e.split()[0] for e in equs})))
r = subprocess.run(cmd, cwd=OUT, capture_output=True, text=True, env=ENV, timeout=900)
log = (r.stdout + r.stderr)
(OUT / (variant + '.log')).write_text(log)
errs = [l for l in log.splitlines() if 'rror' in l]
print('slink    %s -> %s' % (' '.join(cmd[1:]), log.strip().splitlines()[-1] if log.strip() else '?'))
if errs:
    from collections import Counter
    print('         %d error lines; kinds:' % len(errs))
    for k, n in Counter(re.sub(r"'[^']*'|\"[^\"]*\"|\b[0-9A-Fa-f]{8}\b", 'X', e)[:110] for e in errs).most_common(8):
        print('           %5d  %s' % (n, k))
    for e in errs[:25]:
        print('           ', e[:200])
if not (OUT / (variant + '.map')).exists():
    sys.exit(1)
if (OUT / 'statcov.txt').exists():
    shutil.copy(OUT / 'statcov.txt', OUT / (variant + '_statcov.txt'))

# ---------------------------------------------------------------- 5. report
mp = (OUT / (variant + '.map')).read_text(encoding='latin-1')
ours = {}
for m in re.finditer(r'^ ([0-9A-F]{8}) ([0-9A-F]{8}) ([0-9A-F]{8}) [0-9A-F]{8} (\S+)\s+(\S+)\s*$', mp, re.M):
    ours[m.group(5)] = (int(m.group(1), 16), int(m.group(3), 16))
print()
print('section        ours     retail     diff')
for n, size in RET:
    o = ours.get(n, (0, 0))[1]
    print('%-12s %7X   %7X   %+6d' % (n, o, size, o - size))

sc = (OUT / 'statcov.txt').read_text(encoding='latin-1') if (OUT / 'statcov.txt').exists() else ''
part = sc.split('Functions referred to only by data')[0]
stripped = re.findall(r'^\s*(\d+): (\S+?): function (\S+)', part, re.M)
want = json.load(open(ROOT / 'linkers/link_stripped.json'))
rows = want['functions'] if isinstance(want, dict) and 'functions' in want else want
wanted = set()
for x in (rows.values() if isinstance(rows, dict) else rows):
    if isinstance(x, dict):
        wanted.add(x.get('symbol') or x.get('name') or x.get('function'))
    elif isinstance(x, str):
        wanted.add(x)
if isinstance(rows, dict):
    wanted |= set(rows)
wanted.discard(None)
got = {f for _, _, f in stripped}
print()
print('slink removed %d functions (%d B); retail-removed list (linkers/link_stripped.json) has %d names'
      % (len(got), sum(int(s) for s, _, _ in stripped), len(wanted)))
print('   in both               : %d' % len(got & wanted))
our_names = set(re.findall(r'^ [0-9A-F]{8} (\S+)\s*$', mp, re.M))
kept = sorted(f for f in wanted - got if f in our_names)
gone = sorted(f for f in wanted - got if f not in our_names)
print('   retail-removed, slink KEPT (name is in our map)      : %d  %s' % (len(kept), ' '.join(kept)[:400]))
print('   retail-removed, not reported, but NOT in our map either: %d  %s' % (len(gone), ' '.join(gone)[:400]))
print('      (a local label inside a removed Sony function, or a library member nothing in our objects pulled in)')
retail_names = set(re.findall(r'^ [0-9A-F]{8} (\S+)\s*$', Path('C:/Temp/nfs4iso/NFS4.MAP').read_text(encoding='latin-1'), re.M))
also = [(int(s), o, f) for s, o, f in stripped if f not in wanted and f not in retail_names]
print('   slink removed, not on our list, and ABSENT from the retail MAP too (= retail removed them as well): %d (%d B)  %s'
      % (len(also), sum(s for s, _, _ in also), ' '.join(f for _, _, f in also)[:300]))
over = [(int(s), o, f) for s, o, f in stripped if f not in wanted and f in retail_names]
print('   slink removed, retail KEPT (name is in the retail MAP): %d (%d B)' % (len(over), sum(s for s, _, _ in over)))
for s, o, f in sorted(over, reverse=True)[:40]:
    print('        %6d  %-44s %s' % (s, o[-44:], f))

# library members in the retail order?  compare the order of the .text function names both maps share
def text_names(text, lo, hi):
    rows = []
    for m in re.finditer(r'^ ([0-9A-F]{8})  ?(\S+)\s*$', text, re.M):
        a = int(m.group(1), 16)
        if lo <= a < hi:
            rows.append((a, m.group(2)))
    rows.sort()
    return [n for _, n in rows]


ret_map = Path('C:/Temp/nfs4iso/NFS4.MAP')
if ret_map.exists() and '.text' in ours:
    rt = text_names(ret_map.read_text(encoding='latin-1'), 0x8005797C, 0x8010CCD4)
    lo = ours['.text'][0]
    ot = text_names(mp, lo, lo + ours['.text'][1])
    common = set(rt) & set(ot)
    a = [n for n in rt if n in common]
    b = [n for n in ot if n in common]
    first = next((i for i, (x, y) in enumerate(zip(a, b)) if x != y), None)
    print()
    print('.text function order vs retail MAP: %d shared names, %s' % (len(common), 'IDENTICAL ORDER' if first is None else 'first difference at #%d: retail %s / ours %s' % (first, a[first], b[first])))
    print('   names only in retail: %d   only in ours: %d' % (len(set(rt) - set(ot)), len(set(ot) - set(rt))))
    (OUT / (variant + '_order.json')).write_text(json.dumps({'retail': a, 'ours': b, 'only_retail': sorted(set(rt) - set(ot)), 'only_ours': sorted(set(ot) - set(rt))}, indent=0))
