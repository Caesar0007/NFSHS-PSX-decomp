#!/usr/bin/env python3
"""psylink_lane.py -- the ORIGINAL SN pipeline as a measurement lane:
cc1 .s (from build/) -> ASPSX 2.77 (-G per TU) -> PSYLINK 2.73 in the retail link order
(from the SYM FILE records) -> dumpsym -> per-object section starts vs the retail SYM.
usage: psylink_lane.py [--assemble] [--link] [--compare]  (default: all)

Link-order rules (all derived, nothing hand-placed):
  * retail objects are included in SYM FILE-record order, matched to recon TUs by name;
  * an assembled object with no retail name (data-only split TUs such as COUNTER_data.c,
    snddata.c, the vtables_*.cpp tables, TUs whose file name differs from the retail
    member such as libcd drv.c = BIOS.obj) is inserted right after the object that
    precedes its first section in the honest GNU link map -- a consecutive split of one
    object is layout-neutral in a sectioned link;
  * retail objects with no recon TU at all become gap objects: the retail bytes between
    their matched neighbours' section ends/starts (per section), so the layout after
    them is preserved for measurement;
  * symbols nobody defines yet (asm/data residual labels, absolute VA labels, _gp) are
    `equ`'d in the LNK to their honest-link address, so every reference resolves to the
    retail value and the code bytes can be compared; the data they name stays a hole.
Assembler-input translation (sn_text) touches only zero-byte metadata and section NAMES:
  * `.type`/`.size` dropped (ELF symbol metadata), `.set maspsx_gas_reorder` -> `.set reorder`
    (build.py's per-function marker), `.include` of a repo file inlined, `X = Y` aliases ->
    a label right after Y's label (ASPSX has no relocatable equ);
  * the GNU lane's carrier subsections (.data.replay_*, .bss.sys_*, .sdata.replay_counter,
    .rodata via __attribute__((section))) flatten to their base section (the SN object has
    plain sections; object-internal order = emission order);
  * frontend-overlay objects (lowest honest-map section in the front range) get explicit
    front.text/front.rdata/front.data/front.bss names; .sdata/.sbss stay in the main
    small-data sections like retail (ASPSX -s would prefix them too);
  * the hand-written vtables_*.cpp tables are `.data` in the GNU lane (placed by absolute
    address into retail .rdata); here they become `.rdata` -- measurement-lane deviation.
"""
import sys, re, json, subprocess, os, struct
from pathlib import Path
from collections import defaultdict, Counter
ROOT = Path('C:/Temp/nfs4-decomp'); sys.path.insert(0, str(ROOT / 'tools'))
import build
ASPSX = 'C:/Temp/psq43/PSSN/ASPSX.EXE'; PSYLINK = 'C:/Temp/psq43/PSSN/PSYLINK.EXE'
if '--aspsx' in sys.argv:                     # e.g. --aspsx C:/Temp/claud/scratch_dos/ASPSX256.EXE
    ASPSX = sys.argv[sys.argv.index('--aspsx') + 1]
DUMPSYM = 'C:/Temp/claud/dumpsym_clean/dumpsym_src/dumpsym.exe'
NM = str(build.MIPS / 'mipsel-none-elf-nm.exe')
RETAIL_SYM_TXT = Path('C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt')
HONEST_ELF = ROOT / 'build' / 'gen_ld' / 'recon_multdef-ok.elf'
HONEST_MAP = ROOT / 'build' / 'gen_ld' / 'recon_multdef-ok.map'
ROM = ROOT / 'rom' / 'nfs4-f.exe'
OUT = ROOT / 'build' / 'psyq'; OUT.mkdir(parents=True, exist_ok=True)
W = ROOT / 'scratchpad' / 'psyq_pipe'
RET = [('front.rdata', 0x80010000, 0x800128F0), ('front.text', 0x800128F0, 0x80051260),
       ('front.data', 0x80051260, 0x80052B38), ('front.bss', 0x80052B38, 0x80054548),
       ('.rdata', 0x80054548, 0x8005797C), ('.text', 0x8005797C, 0x8010CCD4), ('.data', 0x8010CCD4, 0x8013C54C),
       ('.sdata', 0x8013C54C, 0x8013DD7C), ('.sbss', 0x8013DD7C, 0x8013DEE0), ('.bss', 0x8013DEE0, 0x80148B04)]
LOADED = {'front.rdata', 'front.text', 'front.data', '.rdata', '.text', '.data', '.sdata'}
steps = [a for a in sys.argv[1:] if a.startswith('--')] or ['--assemble', '--link', '--compare']
SECTION_RE = re.compile(rb'\.section\s+([.\w]+)')
ALIAS_RE = re.compile(rb'^\s*(\w+)\s*=\s*(\w+)\s*$')
INCLUDE_RE = re.compile(rb'\.include\s+"([^"]+)"')
MAPLINE_RE = re.compile(r'^ (\.\S+)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', re.M)


def key_of(objname):
    m = re.search(r'\(([^)]+)\)$', objname)
    base = m.group(1) if m else objname.split('\\')[-1]
    return base.rsplit('.', 1)[0].lower()


def retsec(a):
    for n, lo, hi in RET:
        if lo <= a < hi:
            return n
    return None


def honest_sections():
    """(retail section, VA, size, build-relative obj path) for every non-empty input
    section in the honest GNU link map."""
    rows = []
    for m in MAPLINE_RE.finditer(HONEST_MAP.read_text(errors='replace')):
        va, sz = int(m.group(2), 16), int(m.group(3), 16)
        if not sz or retsec(va) is None:
            continue
        rows.append((retsec(va), va, sz, m.group(4)))
    rows.sort(key=lambda r: r[1])
    return rows


def front_objects(rows):
    """build-relative TU paths whose lowest honest-map section lies in the front overlay"""
    first = {}
    for sec, va, sz, o in rows:
        first.setdefault(o, sec)
    return {o for o, sec in first.items() if sec.startswith('front.')}


def retail_pads(rows):
    """{build obj path: {base section: 4}} -- retail objects whose section is followed by a
    4-byte pad (every frontend object, most Sony library objects: their sections are padded
    to 8 bytes by whatever produced them; no ASPSX version and no PSYLINK alignment does it).
    Derived from the honest (= retail) layout: next object's section starts 4 bytes after
    this one's end and this one's size is 4 mod 8."""
    pads = defaultdict(dict)
    by = defaultdict(list)
    for sec, va, sz, o in rows:
        by[sec].append((va, sz, o))
    for sec, lst in by.items():
        lst.sort()
        base = sec.split('.')[-1]
        for (va, sz, o), (nva, nsz, no) in zip(lst, lst[1:]):
            if no != o and nva - (va + sz) == 4:
                pads[o][base] = 4
    return pads


def base_section(s):
    """normalised base section for a directive line (stripped), or None"""
    m = SECTION_RE.match(s)
    if m:
        nm = m.group(1)
        if nm in (b'.rodata', b'.rdata') or nm.startswith((b'.rodata.', b'.rdata.')):
            return b'.rdata'
        for b in (b'.sdata', b'.sbss', b'.data', b'.bss', b'.text'):
            if nm == b or nm.startswith(b + b'.'):
                return b
        return None
    if s in (b'.text', b'.rdata', b'.rodata', b'.data', b'.sdata', b'.sbss', b'.bss'):
        return b'.rdata' if s == b'.rodata' else s
    return None


COMM_RE = re.compile(rb'\.(l?comm)\s+(\S+?)\s*,\s*(\d+)')


def sn_text(src: Path, vtables=False, front=False, pads=None) -> bytes:
    out = []
    lines = src.read_bytes().replace(b'\r\n', b'\n').split(b'\n')
    # front-overlay objects: ASPSX -s puts the object's COMMONs into front.bss after its
    # explicit .bss, local commons first then global ones, each aligned to min(4, size)
    # (probed on PSYLINK 2.73); without -s they would fall into the main .bss, so emit
    # them explicitly in that order.
    lcomm = []; comm = []
    aliases = defaultdict(list)
    for ln in lines:
        m = ALIAS_RE.match(ln)
        if m:
            aliases[m.group(2)].append(m.group(1))
    for ln in lines:
        s = ln.strip()
        if ALIAS_RE.match(ln):
            continue
        m = re.match(rb'^(\w+):$', s)
        if m and m.group(1) in aliases:
            out.append(ln)
            out.extend(a + b':' for a in aliases[m.group(1)])
            continue
        if s.startswith((b'.type\t', b'.type ', b'.size\t', b'.size ')):
            continue
        m = COMM_RE.match(s)
        if m and front:
            (lcomm if m.group(1) == b'lcomm' else comm).append((m.group(2), int(m.group(3))))
            continue
        if s == b'.set\tmaspsx_gas_reorder':
            out.append(b'\t.set\treorder'); continue
        if vtables and s == b'.data':
            s = b'.rdata'
        base = base_section(s)
        if base is not None:
            if front and base in (b'.text', b'.rdata', b'.data', b'.bss'):
                out.append(b'\t.section front' + base)
            else:
                out.append(b'\t' + base)
            continue
        m = INCLUDE_RE.match(s)
        if m and (ROOT / m.group(1).decode()).is_file():
            out.append(sn_text(ROOT / m.group(1).decode(), front=front).rstrip(b'\r\n')); continue
        out.append(ln)
    if lcomm or comm:
        out.append(b'\t.section front.bss')
        for name, size in lcomm + comm:
            if size >= 4:
                out.append(b'\t.align 2')
            elif size >= 2:
                out.append(b'\t.align 1')
            if (name, size) in comm:
                out.append(b'\t.globl ' + name)
            out.append(name + b':')
            out.append(b'\t.space ' + str(size).encode())
    if front:
        # every retail frontend-overlay object has 8-byte-aligned sections (41/41 .text
        # starts, and the front.data drift shows the same 4-byte gaps): round each section
        # up to 8 relative to its own start, which is what the retail objects carry.
        for sec in (b'.text', b'.rdata', b'.data', b'.bss'):
            out.append(b'\t.section front' + sec); out.append(b'\t.align 3')
    else:
        for base, n in sorted((pads or {}).items()):
            sec = {'text': b'.text', 'rodata': b'.rdata', 'rdata': b'.rdata', 'data': b'.data', 'bss': b'.bss', 'sdata': b'.sdata', 'sbss': b'.sbss'}[base]
            out.append(b'\t' + sec)
            out.append(b'\t.space %d' % n)   # retail trailing pad (section padded to 8)
    return b'\r\n'.join(out) + b'\r\n'


def crlf(src: Path, dst: Path, front=False, pads=None):
    # same dtor-prefix convention as build.py's GNU lane (`_._X` -> `___X`) so the
    # hand-written vtable references resolve; the compare step maps it back.
    dst.write_bytes(sn_text(src, vtables='vtables_' in src.name, front=front, pads=pads).replace(b'_._', b'___'))


def objname(rel):
    return rel.replace('/', '__') + '.obj'


if '--assemble' in steps:
    ok = bad = 0; fails = []
    rows = honest_sections(); FRONT = front_objects(rows); HONEST_OBJS = {o for _, _, _, o in rows}
    PADS = retail_pads(rows) if '--no-pads' not in sys.argv else {}
    (W / 'pad8.json').write_text(json.dumps({o: p for o, p in PADS.items()}, indent=0))
    srcs = sorted([*(ROOT / 'recon').rglob('*.cpp'), *(ROOT / 'recon').rglob('*.c')])
    nfront = 0
    for s in srcs:
        sfile = ROOT / 'build' / (s.relative_to(ROOT).as_posix() + '.s')
        if not sfile.is_file():
            continue
        rel = s.relative_to(ROOT).as_posix()
        g = str(build.per_tu_flags(s.resolve()).get('g_value', build.G_VALUE))
        bo = 'build/' + rel + '.o'
        front = (bo in FRONT) if bo in HONEST_OBJS else rel.startswith('recon/frontend/')
        nfront += front
        tmp = OUT / (rel.replace('/', '__') + '.s'); crlf(sfile, tmp, front=front, pads=PADS.get(bo))
        obj = OUT / objname(rel)
        cmd = [ASPSX, '-q', f'-G{g}', str(tmp), '-o', str(obj)]
        if obj.exists():
            obj.unlink()
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=120, cwd=str(ROOT))
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
    print('ASPSX ok %d bad %d (front-overlay objects: %d)' % (ok, bad, nfront))
    (W / 'assemble_fails.json').write_text(json.dumps(fails, indent=0))


def build_link_order():
    order = json.load(open(W / 'sym_obj_order.json'))
    seen = []
    for o in order:
        if not seen or seen[-1] != o[0]:
            seen.append(o[0])
    for p in [*OUT.glob('gap__*.obj'), *OUT.glob('gap__*.s')]:   # stale gap objects from an earlier run
        p.unlink()
    ours = defaultdict(list)
    for p in OUT.glob('*.obj'):
        k = p.name.split('__')[-1].split('.')[0].lower() if '__' in p.name else p.stem.lower()
        ours[k].append(p.name)
    inc = []; missing = []
    for n in seen:
        k = key_of(n)
        pick = None
        if k in ours:
            cands = ours[k]
            hint = 'syslib' if 'syslib' in n else 'eaclib' if 'eaclib' in n else None
            lib = re.search(r'([A-Za-z0-9_]+)\.lib\(', n)
            if hint:
                pick = next((c for c in cands if hint in c and (not lib or lib.group(1).lower() in c.lower())), None)
            else:
                pick = next((c for c in cands if 'syslib' not in c and 'eaclib' not in c), None)
        inc.append([n, pick])
        if pick is None:
            missing.append(n)
    included = {p for _, p in inc if p}
    # --- unmatched assembled objects -> after their honest-map predecessor ---------------
    rows = honest_sections()
    bykey = {}
    for sec, va, sz, o in rows:
        m = re.match(r'build/(recon/.*)\.o$', o)
        if m:
            bykey.setdefault(objname(m.group(1)), []).append((sec, va, sz))
    unmatched = sorted(p.name for p in OUT.glob('*.obj') if p.name not in included and p.name in bykey)
    pending = []
    for u in unmatched:
        secs = sorted(bykey[u], key=lambda t: t[1])
        sec, va, sz = next((t for t in secs if t[0].endswith('.text')), secs[0])
        pred = None
        for s2, v2, z2, o2 in reversed(rows):
            if s2 == sec and v2 < va:
                m = re.match(r'build/(recon/.*)\.o$', o2)
                if m and objname(m.group(1)) in included | set(unmatched):
                    pred = objname(m.group(1)); break
        pending.append((sec, va, u, pred))
    pending.sort(key=lambda t: t[1])
    placed = {}
    for sec, va, u, pred in pending:
        if pred is None:
            print('  no predecessor for', u, 'at', hex(va)); continue
        idx = next((i for i, (_, p) in enumerate(inc) if p == pred), None)
        if idx is None:
            print('  predecessor not in LNK yet:', pred, 'for', u); continue
        inc.insert(idx + 1, ['<after %s>' % pred, u]); placed[u] = pred
    # --- gap objects for retail objects without a TU -------------------------------------
    rom = ROM.read_bytes()[0x800:]
    def ext(objn):
        d = {}
        for sec, va, sz in bykey.get(objn, []):
            lo, hi = d.get(sec, (va, va + sz))
            d[sec] = (min(lo, va), max(hi, va + sz))
        return d
    gaps = []
    i = 0
    while i < len(inc):
        n, p = inc[i]
        if p is not None:
            i += 1; continue
        j = i
        while j < len(inc) and inc[j][1] is None:
            j += 1
        prev_objs = [q for _, q in inc[:i] if q]; next_objs = [q for _, q in inc[j:] if q]
        gname = 'gap__' + '+'.join(key_of(n2) for n2, _ in inc[i:j]) + '.obj'
        lines = []
        for sec, lo_s, hi_s in RET:
            pe = None
            for q in reversed(prev_objs):
                e = ext(q).get(sec)
                if e:
                    pe = e[1]; break
            ns = None
            for q in next_objs:
                e = ext(q).get(sec)
                if e:
                    ns = e[0]; break
            if pe is None or ns is None or ns <= pe or ns - pe > 0x10000:
                continue
            size = ns - pe
            base = {'front.rdata': '.rdata', 'front.text': '.text', 'front.data': '.data', 'front.bss': '.bss'}.get(sec, sec)
            lines.append(('\t.section front' + base) if sec.startswith('front.') else ('\t' + base))
            if sec in LOADED:
                data = rom[pe - 0x80010000: ns - 0x80010000]
                if pe % 4 == 0 and size % 4 == 0:
                    for k in range(0, size, 4):
                        lines.append('\t.word\t0x%08x' % struct.unpack_from('<I', data, k)[0])
                else:
                    for k in range(0, size, 16):
                        lines.append('\t.byte\t' + ','.join('0x%02x' % b for b in data[k:k + 16]))
            else:
                lines.append('\t.space\t%d' % size)
            gaps.append((gname, sec, pe, ns))
        if lines:
            src = OUT / (gname[:-4] + '.s'); src.write_bytes(('\r\n'.join(lines) + '\r\n').encode())
            r = subprocess.run([ASPSX, '-q', str(src), '-o', str(OUT / gname)], capture_output=True, text=True)
            if (OUT / gname).exists():
                inc[i] = [inc[i][0], gname]
                for k in range(i + 1, j):
                    inc[k] = [inc[k][0], '<in ' + gname + '>']
            else:
                print('  gap assemble failed', gname, (r.stdout + r.stderr)[:200])
        i = j
    (W / 'gap_windows.json').write_text(json.dumps([(g, s, hex(a), hex(b)) for g, s, a, b in gaps], indent=0))
    return inc, missing, placed, gaps


def honest_addrs(names):
    r = subprocess.run([NM, str(HONEST_ELF)], capture_output=True, text=True)
    d = {}
    for l in r.stdout.splitlines():
        m = re.match(r'^([0-9a-f]+) (\w) (\S+)$', l)
        if m and m.group(3) in names:
            d.setdefault(m.group(3), int(m.group(1), 16))
    return d


def write_lnk(inc, equs):
    lnk = ['\torg\t$80010000', 'text\tgroup', 'bss\tgroup\tbss', 'front\tgroup\tover(text)',
           '\tsection\t.rdata,text', '\tsection\t.text,text', '\tsection\t.data,text', '\tsection\t.sdata,text',
           '\tsection\t.sbss,bss', '\tsection\t.bss,bss',
           '\tsection\tfront.rdata,front', '\tsection\tfront.text,front', '\tsection\tfront.data,front',
           '\tsection\tfront.bss,front']
    for n, p in inc:
        if p and not p.startswith('<'):
            lnk.append('\tinclude\t%s\t; %s' % (p, n))
        else:
            lnk.append('\t; MISSING %s %s' % (n, p or ''))
    for s, a in sorted(equs.items()):
        lnk.append('%s\tequ\t$%08x' % (s, a))
    (OUT / 'nfs4.lnk').write_bytes(('\r\n'.join(lnk) + '\r\n').encode())


def run_psylink():
    env = dict(os.environ, MSYS2_ARG_CONV_EXCL='*', MSYS_NO_PATHCONV='1')
    for f in ('nfs4.cpe', 'nfs4.sym', 'nfs4.map'):
        if (OUT / f).exists():
            (OUT / f).unlink()
    r = subprocess.run([PSYLINK, '/c', '/m', '@nfs4.lnk,nfs4.cpe,nfs4.sym,nfs4.map'], cwd=OUT,
                       capture_output=True, text=True, timeout=600, env=env)
    log = r.stdout + r.stderr; (W / 'psylink.log').write_text(log)
    return log


if '--link' in steps:
    inc, missing, placed, gaps = build_link_order()
    print('LNK: %d objects, %d retail names without a TU (-> gap objects), %d unmatched objects slotted by honest map'
          % (sum(1 for _, p in inc if p and not p.startswith('<')), len(missing), len(placed)))
    (W / 'slots.json').write_text(json.dumps(placed, indent=0))
    write_lnk(inc, {})
    log = run_psylink()
    undef = sorted(set(re.findall(r"Symbol '([^']+)' not defined", log)))
    equs = honest_addrs(set(undef) | {'_._' + u[3:] for u in undef if u.startswith('___')})
    for u in undef:
        if u not in equs and u.startswith('___') and ('_._' + u[3:]) in equs:
            equs[u] = equs['_._' + u[3:]]
    equs = {u: equs[u] for u in undef if u in equs}
    still = [u for u in undef if u not in equs]
    print('undefined after include pass: %d; equ from honest link: %d; unresolvable: %d %s' % (len(undef), len(equs), len(still), still[:10]))
    (W / 'equ_symbols.json').write_text(json.dumps(equs, indent=0))
    write_lnk(inc, equs)
    log = run_psylink()
    # --- phase object: make every section's content start congruent to retail mod 8 ---
    # Unowned residual data shifts our section starts; an 8-byte alignment pad inside an
    # object (gcc's .align 3 before arrays >= 8 bytes, 8-byte COMMONs) then lands at a
    # different offset than in retail and shows up as fake +/-4 drift.  A first object
    # carrying `.space` pads fixes each section's start phase (measurement scaffolding).
    if (OUT / 'nfs4.map').exists() and '--no-phase' not in sys.argv:
        starts = {}
        for l in (OUT / 'nfs4.map').read_text().splitlines():
            m = re.match(r' ([0-9A-F]{8}) [0-9A-F]{8} [0-9A-F]{8} [0-9A-F]{8} \S+\s+(\S+)$', l)
            if m:
                starts.setdefault(m.group(2), int(m.group(1), 16))
        retail_start = {n: lo for n, lo, hi in RET}
        pads = {}; shift = 0
        for grp in (('.rdata', '.text', '.data', '.sdata'), ('.sbss', '.bss'), ('front.rdata', 'front.text', 'front.data', 'front.bss')):
            shift = 0
            for s in grp:
                if s not in starts or s not in retail_start:
                    continue
                cur = starts[s] + shift
                need = (retail_start[s] - cur) % 8
                if need:
                    pads[s] = need
                shift += need
        print('phase: section starts %s -> pads %s' % ({k: hex(v) for k, v in starts.items()}, pads))
        if pads:
            lines = []
            for s, n in pads.items():
                base = s.replace('front', '').lstrip('.') if s.startswith('front.') else s.lstrip('.')
                if s == '.sbss':                        # ASPSX has no .sbss directive: a small common lands there at -G8
                    lines.append('\t.lcomm\t__phase_sbss,%d' % n); continue
                lines.append(('\t.section front.%s' % base) if s.startswith('front.') else ('\t.%s' % base))
                lines.append('\t.space %d' % n)
            (OUT / 'phase.s').write_bytes(('\r\n'.join(lines) + '\r\n').encode())
            r = subprocess.run([ASPSX, '-q', '-G8', str(OUT / 'phase.s'), '-o', str(OUT / 'phase.obj')], capture_output=True, text=True)
            if not (OUT / 'phase.obj').exists():
                print('phase.obj failed:', (r.stdout + r.stderr)[:200])
            if (OUT / 'phase.obj').exists():
                k = next((i for i, (_, p) in enumerate(inc) if p == 'address.obj'), 1)
                inc.insert(k + 1, ['<phase pads %s>' % pads, 'phase.obj'])
                write_lnk(inc, equs)
                log = run_psylink()
                print('phase pads:', pads)
    errs = [l for l in log.splitlines() if 'Error' in l]
    kinds = Counter(re.sub(r"'[^']*'", "'X'", e.split(':', 2)[-1].strip()) for e in errs)
    print('PSYLINK: %d error lines; kinds: %s' % (len(errs), kinds.most_common(6)))
    print('outputs:', {f: ((OUT / f).stat().st_size if (OUT / f).exists() else None) for f in ('nfs4.cpe', 'nfs4.sym', 'nfs4.map')})
    if (OUT / 'nfs4.map').exists():
        for l in (OUT / 'nfs4.map').read_text().splitlines()[1:40]:
            if re.match(r' [0-9A-F]{8} ', l):
                print('   ', l.strip())

if '--compare' in steps:
    def parse_symtxt(txt):
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
    (W / 'compare_rows.json').write_text(json.dumps(rows, indent=0))
    print('compare_rows.json written (%d objects)' % len(rows))
