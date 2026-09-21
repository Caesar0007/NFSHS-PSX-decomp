#!/usr/bin/env python3
"""gen_rodata_extra.py -- W67-A7 supplementary recon .rodata/.data/.sdata placement.

The W66-A4 ownmap (linkers/nfs4_recon.rodata_placement.json) + the P907 .data
implied-base spine place recon TUs' initialized data whose cells carry a
name-encoded / MAP symbol.  TUs whose data is entirely ANONYMOUS local statics
(no such name) fall through to the .rodata_rest / main-.data catch-alls -- and
every `%hi/%lo` / `%gp_rel` reference to that section in the TU's OWN .text then
resolves to the catch-all address instead of the retail one.  That is the bulk
of the full_link .text / front.text diff class (StCdInterrupt's 42 .data
relocs, SYS/track/texture .rodata jump tables, ...).

For each such (object, section) this derives the retail base the same
non-circular way tools/floor_image.py derives un-named section bases: decode
retail's resolved reference (%hi/%lo pair, or %gp_rel single for .sdata) at the
same in-.text offset and subtract OUR addend (base = retail_target - our_addend;
our addend still tests our code).  It then RESOLVES the section's own pointer
relocations (R_MIPS_32 -> MAP / name-encoded / .L<hex> / section-relative) and
BYTE-COMPARES the resolved bytes to the retail image at that base.  Only a
window whose every resolvable word matches retail is emitted -- so placing it
(overlapping the identical residual blob, benign exactly like the P907 .data
implied-base overlap) is provably byte-neutral for the region and only fixes
the reference target.  Outputs:
  linkers/nfs4_recon.rodata_extra.json  -- .rodata windows (merged into .roNNNN)
  linkers/nfs4_recon.data_extra.json    -- .data/.sdata retail bases (placed_data
                                           /placed_sdata override in gen_ld)
"""
import json, re, struct, subprocess, importlib.util
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MAP = ROOT / 'rom' / 'NFS4.MAP'   # retail link map off the disc; not committed
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
IMG = (ROOT / 'rom' / 'nfs4-f.exe').read_bytes()
FOFF = 0x800
LOAD = 0x80010000
GP = 0x8013C54C
OUT_RO = ROOT / 'linkers' / 'nfs4_recon.rodata_extra.json'
OUT_DATA = ROOT / 'linkers' / 'nfs4_recon.data_extra.json'
OUT_BSS = ROOT / 'linkers' / 'nfs4_recon.bss_extra.json'
PLACEMENT = ROOT / 'linkers' / 'nfs4_recon.rodata_placement.json'

# retail section spans a decoded base is allowed to land in, per section kind
SPANS = {
    # .data may legitimately land in a read-only span too: the vtables_*.cpp
    # TUs emit const virtual tables to .data that retail keeps in .rdata.  Every
    # .data window is byte-validated, so a wrong base is still rejected.
    '.rodata': [(0x80010000, 0x800128F0), (0x80054548, 0x8005797C)],
    # .data/.sdata may also decode to a base in the .bss region: retail keeps
    # some TUs' zero-init card/flag "data" as BSS (e.g. BIOS.c .data @0x801489ec).
    # Those land beyond the ROM image and are placed NOLOAD for reloc resolution
    # only (see romend handling in main; strong-consensus gated, no byte-check).
    '.data':   [(0x80010000, 0x800128F0), (0x80051260, 0x80052B38),
                (0x80054548, 0x8005797C), (0x8010CCD4, 0x8013C54C),
                (0x80052B38, 0x80054548), (0x8013DEE0, 0x80148B04)],
    '.sdata':  [(0x8013C54C, 0x8013DD7C), (0x8013DD7C, 0x8013DEE0),
                (0x8013DEE0, 0x80148B04)],
    '.sbss':   [(0x8013DD7C, 0x8013DEE0)],
    '.bss':    [(0x80052B38, 0x80054548), (0x8013DEE0, 0x80148B04)],
}
ROMEND = 0x8013E000          # bytes at/after this are not in rom/nfs4-f.exe
# NOBITS sections have no image payload to byte-validate against (and are
# zero-filled, so a wrong base into another zero run would falsely "match").
# Accept a NOBITS base only on strong retail-decode consensus (>=2 independent
# .text references agreeing) or a named-symbol anchor.
NOBITS = {'.bss', '.sbss'}

# ---- symbol map (MAP globals + configs data + name-encoded + .L<hex>) --------
sym = {}
for ln in MAP.read_text(errors='replace').splitlines():
    m = re.match(r'^ ([0-9A-F]{8}) (\S+)\s*$', ln)
    if m:
        sym.setdefault(m.group(2), int(m.group(1), 16))
sa = ROOT / 'configs' / 'symbol_addrs.txt'
if sa.exists():
    for ln in sa.read_text().splitlines():
        m = re.match(r'^\s*([\w$.]+)\s*=\s*(0x[0-9A-Fa-f]+)\s*;', ln)
        if m:
            sym.setdefault(m.group(1), int(m.group(2), 16))
# The MND SYM names every retail global INCLUDING file-statics the MAP lacks
# (SQVclue.. in unref/unbtree .sbss, kMovingHighlight, ...).  Fallback only:
# MAP + symbol_addrs stay authoritative where they have the name.
SYMTXT = Path(__import__('retail_sym').txt())
if SYMTXT.exists():
    for ln in SYMTXT.read_text(errors='replace').splitlines():
        m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) [26] (\S+)$', ln)
        if m:
            sym.setdefault(m.group(2), int(m.group(1), 16))
NAMEVA = re.compile(r'^(?:func|D|DAT|lbl)_([0-9A-Fa-f]{8})$')
DOTL = re.compile(r'^\.L?_?([0-9A-Fa-f]{8})$')
VTBL = re.compile(r'^(.+)_vtable$')
VTBL_ANON = {
    'AIState_None_vtable': 0x80054E1C,
    'tDialogMessageStringWithTimeout_vtable': 0x80010098,
    'AIHigh_BasicCop_vtable': 0x80054E9C,
    'AIHigh_BTC_Perp_vtable': 0x80054FE0,
    'AIHigh_Player_vtable': 0x80055098,
    'tBlankMenuItemGoToMenuNFS4Button_vtable': 0x800114D8,
    'tBlankMenuItemNFS4LeftRightChoice_vtable': 0x80011530,
}

def aof(name):
    if name in sym:
        return sym[name]
    m = NAMEVA.match(name) or DOTL.match(name)
    if m:
        return int(m.group(1), 16)
    # the vtables_*.cpp TUs export const virtual tables to .data under the
    # unmangled <Class>_vtable name; the retail map has them in .rdata under the
    # cfront-mangled _vt.<len><Class> name.  Map one to the other so those .data
    # sections anchor (and their absolute HI16/LO16 references resolve).
    m = VTBL.match(name)
    if m:
        cls = m.group(1)
        if f'_vt.{len(cls)}{cls}' in sym:
            return sym[f'_vt.{len(cls)}{cls}']
        # retail vtables the SYM leaves anonymous (no `_vt.` record); the
        # addresses come from the per-TU breadcrumbs / retail decode, and the
        # window is still byte-validated before placement.
        return VTBL_ANON.get(name)
    # build.py renames our cfront dtor prefix `_._<Class>` to EA's `___<Class>`;
    # the retail map keeps `_._`.  Without this the R_MIPS_32 dtor slots of a
    # .data vtable-ish table count as "unresolved" and the window is rejected
    # (aihigh .data @0x8010cd00: highLevelAIObjs).
    if name.startswith('___') and f'_._{name[3:]}' in sym:
        return sym[f'_._{name[3:]}']
    # address-named carriers for retail data the SYM leaves anonymous
    # (AIHigh_kVtbl_80054dcc: the abstract BTC_Perp-family vtable).
    m = re.search(r'_([0-9A-Fa-f]{8})$', name)
    if m and 0x80010000 <= int(m.group(1), 16) < 0x80150000:
        return int(m.group(1), 16)
    return None

def run(*a):
    return subprocess.run(a, capture_output=True, text=True).stdout

def imgw(va):
    o = va - LOAD + FOFF
    return int.from_bytes(IMG[o:o+4], 'little') if 0 <= o <= len(IMG)-4 else None

def s16(x):
    return struct.unpack('<h', struct.pack('<H', x & 0xFFFF))[0]

def secbytes(obj, sec):
    buf = bytearray()
    for ln in run(OBJD, '-s', '-j', sec, str(obj)).splitlines():
        m = re.match(r'^ ([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4})', ln)
        if m:
            a = int(m.group(1), 16); dd = bytes.fromhex(m.group(2).replace(' ', ''))
            if len(buf) < a:
                buf.extend(b'\0' * (a - len(buf)))
            buf[a:a+len(dd)] = dd
    return bytes(buf)

def sec_size(obj, sec):
    """section size from objdump -h (works for NOBITS, unlike -s)."""
    for ln in run(OBJD, '-h', str(obj)).splitlines():
        m = re.match(r'^\s*\d+\s+(\S+)\s+([0-9a-f]{8})\s', ln)
        if m and m.group(1) == sec:
            return int(m.group(2), 16)
    return 0

def relocs(obj, want):
    out = []; cur = None
    for ln in run(OBJD, '-r', str(obj)).splitlines():
        m = re.match(r'^RELOCATION RECORDS FOR \[(\S+)\]', ln)
        if m:
            cur = m.group(1); continue
        m = re.match(r'^([0-9a-f]{8})\s+(R_MIPS_\S+)\s+(\S+)$', ln)
        if m and cur == want:
            out.append((int(m.group(1), 16), m.group(2), m.group(3)))
    return out

def text_fns(obj):
    out = []
    for ln in run(OBJD, '-t', str(obj)).splitlines():
        m = re.match(r'^([0-9a-f]{8})\s+.*F \.text\s+[0-9a-f]{8}\s+(\S+)$', ln)
        if m:
            va = aof(m.group(2))
            if va is not None:
                out.append((int(m.group(1), 16), va))
    return out

def text_base(obj):
    votes = Counter(va - off for off, va in text_fns(obj))
    return votes.most_common(1)[0][0] if votes else None

def decode_base(obj, tbase, sec):
    """retail base for section `sec` by CONSENSUS over the object's .text
    references to it (HI16/LO16 pairs, and %gp_rel singles for small data);
    each votes retail_target - our_addend.  Certificate/vendor-vintage noise is
    outvoted.  Search fallback for reloc-free const runs."""
    if tbase is None:
        return None, 0
    tb = secbytes(obj, '.text')
    rl = relocs(obj, '.text')
    votes = Counter()
    inspan = lambda a: any(lo <= a < hi for lo, hi in SPANS[sec])
    for i, (ro, ty, tg) in enumerate(rl):
        if tg != sec:
            continue
        if ty == 'R_MIPS_HI16':
            j = i + 1
            while j < len(rl) and not (rl[j][1] == 'R_MIPS_LO16' and rl[j][2] == sec):
                j += 1
            if j >= len(rl) or ro + 4 > len(tb) or rl[j][0] + 4 > len(tb):
                continue
            lo = rl[j][0]
            oadd = ((struct.unpack_from('<I', tb, ro)[0] & 0xFFFF) << 16) + \
                s16(struct.unpack_from('<I', tb, lo)[0])
            rhi = imgw(tbase + ro); rlo = imgw(tbase + lo)
            if rhi is None or rlo is None:
                continue
            cand = (((rhi & 0xFFFF) << 16) + s16(rlo)) - oadd
            if inspan(cand):
                votes[cand] += 1
        elif ty == 'R_MIPS_GPREL16':
            if ro + 4 > len(tb):
                continue
            oadd = s16(struct.unpack_from('<I', tb, ro)[0])
            rw = imgw(tbase + ro)
            if rw is None:
                continue
            cand = GP + s16(rw) - oadd
            if inspan(cand):
                votes[cand] += 1
    if votes:
        b, n = votes.most_common(1)[0]
        return b, n
    if sec not in NOBITS and not relocs(obj, sec):
        raw = secbytes(obj, sec)
        if len(raw) >= 8:
            for lo, hi in SPANS[sec]:
                blob = IMG[lo - LOAD + FOFF: hi - LOAD + FOFF]
                idx = blob.find(raw)
                if idx >= 0 and blob.find(raw, idx + 1) < 0:
                    return lo + idx, 99   # unique byte run == a strong anchor
    return None, 0

def named_base(obj, sec):
    """base from a MAP / name-encoded symbol that lives IN this section
    (base = retail_addr - in-section offset); consensus over such symbols.
    Returns (mode_base, mode_votes, total_named): a section whose named symbols
    do NOT unanimously agree (mode_votes < total_named) has a layout that
    differs from retail and CANNOT be placed as one contiguous block."""
    votes = Counter(); total = 0
    for ln in run(OBJD, '-t', str(obj)).splitlines():
        m = re.match(r'^([0-9a-f]{8})\s+.*?\s' + re.escape(sec) +
                     r'\s+[0-9a-f]{8}\s+(\S+)$', ln)
        if m:
            a = aof(m.group(2))
            if a is not None:
                votes[a - int(m.group(1), 16)] += 1; total += 1
    if votes:
        b, n = votes.most_common(1)[0]
        return b, n, total
    return None, 0, 0

def section_bases(obj, tbase, known):
    """retail bases for the object's other sections (to resolve pointer words),
    from named symbols; `known` seeds already-decoded bases."""
    out = dict(known)
    out.setdefault('.text', tbase)
    persec = {}
    for ln in run(OBJD, '-t', str(obj)).splitlines():
        m = re.match(r'^([0-9a-f]{8})\s+.*?\s(\.(?:data|sdata|rodata))\s+[0-9a-f]{8}\s+(\S+)$', ln)
        if m:
            va = aof(m.group(3))
            if va is not None:
                persec.setdefault(m.group(2), Counter())[va - int(m.group(1), 16)] += 1
    for sec, votes in persec.items():
        out.setdefault(sec, votes.most_common(1)[0][0])
    return out

def resolve_and_check(obj, sec, base, sbases):
    """resolve the section's R_MIPS_32 pointer words, byte-compare to retail at
    base; returns (checked_words, diff_words, unresolved_count, nbytes)."""
    rb = bytearray(secbytes(obj, sec))
    unresolved = set()
    for ro, ty, tg in relocs(obj, sec):
        if ro + 4 > len(rb):
            continue
        w = struct.unpack_from('<I', rb, ro)[0]
        if ty != 'R_MIPS_32':
            unresolved.add(ro); continue
        ta = aof(tg)
        if ta is None and tg in sbases and sbases[tg] is not None:
            ta = sbases[tg]
        if ta is None:
            unresolved.add(ro); continue
        struct.pack_into('<I', rb, ro, (ta + w) & 0xFFFFFFFF)
    checked = diff = 0
    for w in range(0, (len(rb) // 4) * 4, 4):
        if w in unresolved:
            continue
        ov = struct.unpack_from('<I', rb, w)[0]
        rv = imgw(base + w)
        checked += 1
        if rv != ov:
            diff += 1
    return checked, diff, len(unresolved), len(rb)

def main():
    placed_ro = {r['obj'] for r in json.load(open(PLACEMENT))}
    srcs = [*Path(ROOT / 'recon').rglob('*.cpp'), *Path(ROOT / 'recon').rglob('*.c')]
    objs = []
    for s in srcs:
        o = ROOT / 'build' / (str(s.relative_to(ROOT)) + '.o')
        if o.is_file():
            objs.append((o.relative_to(ROOT).as_posix(), o))
    ro_out, data_out, bss_out = [], [], []
    skipped = []
    for rel, o in sorted(objs):
        tbase = text_base(o)
        known = {}
        # section sizes (NOBITS have a nonzero size with no PROGBITS payload)
        for sec in ('.rodata', '.data', '.sdata', '.sbss', '.bss'):
            if sec == '.rodata' and rel in placed_ro:
                continue                          # already in the ownmap
            nb = sec_size(o, sec)
            if not nb:
                continue
            base, nvotes = decode_base(o, tbase, sec)
            nbase, nn, ntot = named_base(o, sec)
            # NOBITS: content can't be byte-validated -> require a strong anchor
            # (>=2 agreeing .text refs, a unique search, or a named symbol).
            if sec in NOBITS:
                if nbase is not None and (base is None or nn >= nvotes):
                    base, nvotes = nbase, max(nn, 99)   # named anchor = trusted
                if base is None or nvotes < 2:
                    skipped.append((rel, sec, f'weak NOBITS anchor (votes={nvotes})'))
                    continue
            elif base is None and nbase is not None:
                # loadable: a MAP/name-encoded symbol in the section is a direct,
                # reliable base when the TU references its own data by name (e.g.
                # ginfo/screenMemcard) rather than section-relative.  Still
                # byte-validated below, so a wrong anchor is rejected.
                base = nbase
            # anchor quality for overlap arbitration: a UNANIMOUS named anchor
            # (nn==ntot, ntot>=1) is authoritative; a non-unanimous one is a
            # layout mismatch whose mode-base is unreliable.
            anchor_q = (2 if (ntot >= 1 and nn == ntot) else
                        1 if ntot == 0 else 0)
            if base is None:
                skipped.append((rel, sec, 'no anchor / no unique search')); continue
            span = next((s for s in SPANS[sec] if s[0] <= base < s[1]), None)
            if span is None or base + nb > span[1]:
                skipped.append((rel, sec, f'{base:#x}..{base+nb:#x} outside span')); continue
            known[sec] = base
            # W67-A11: a .data/.sdata section whose decode base lands BEYOND the
            # ROM image (retail keeps this TU's zero-init "data" as BSS, e.g.
            # BIOS.c .data @0x801489ec) -- place NOLOAD for reloc resolution only
            # (no bytes to byte-validate; require strong decode consensus).
            if sec not in NOBITS and base >= ROMEND:
                if nvotes < 2:
                    skipped.append((rel, sec, f'beyond-image {base:#x} weak consensus {nvotes}')); continue
                bss_out.append({'obj': rel, 'section': sec, 'base': base,
                                'end': base + nb, 'size': nb, 'ok': True,
                                'votes': nvotes, 'noload_data': True, 'q': anchor_q})
                continue
            if sec in NOBITS:
                bss_out.append({'obj': rel, 'section': sec, 'base': base,
                                'end': base + nb, 'size': nb, 'ok': True,
                                'votes': nvotes, 'q': anchor_q})
                continue
            sbases = section_bases(o, tbase, known)
            checked, diff, unres, _ = resolve_and_check(o, sec, base, sbases)
            if checked == 0:
                skipped.append((rel, sec, 'no resolvable words')); continue
            if diff:
                skipped.append((rel, sec, f'{diff}/{checked}w differ @ {base:#x}')); continue
            row = {'obj': rel, 'section': sec, 'base': base, 'end': base + nb,
                   'size': nb, 'ok': True, 'unresolved': unres, 'words': checked,
                   'q': anchor_q}
            (ro_out if sec == '.rodata' else data_out).append(row)
    ro_out.sort(key=lambda r: r['base'])
    for a, b in zip(ro_out, ro_out[1:]):
        assert a['end'] <= b['base'], f"rodata extra overlap: {a['obj']} vs {b['obj']}"
    # curated owner address ranges (SOURCE_DATA_OWNERS/SOURCE_ZERO_OWNERS): an
    # extra window must never overlap one (that displaces the owner's symbol ->
    # link ASSERT, the TrackSpec_* class).  Drop any window intersecting one.
    owner_ranges = []
    for modname, listname in (('source_data_owners', 'SOURCE_DATA_OWNERS'),
                              ('source_zero_owners', 'SOURCE_ZERO_OWNERS')):
        try:
            sp = importlib.util.spec_from_file_location(modname, ROOT / 'tools' / (modname + '.py'))
            m = importlib.util.module_from_spec(sp); sp.loader.exec_module(m)
            for ow in getattr(m, listname):
                a = ow.get('address')
                if a is not None:
                    owner_ranges.append((a, a + ow.get('size', ow.get('oracle_size', 0))))
        except Exception:
            pass
    def hits_owner(r):
        return any(r['base'] < oe and oa < r['end'] for oa, oe in owner_ranges)
    # data/sdata: two extras must not claim the same retail bytes (residual-blob
    # overlap is benign; extra-vs-extra overlap is a wrong base -- drop both).
    def drop_overlaps(rows, label):
        rows = sorted(rows, key=lambda r: r['base'])
        keep = []
        for r in rows:
            if hits_owner(r):
                skipped.append((r['obj'], r['section'], f'{label} overlaps a curated owner')); continue
            keep.append(r)
        rows = keep
        drop = set()
        for a, b in zip(rows, rows[1:]):
            if b['base'] < a['end']:
                # IDENTICAL NOBITS windows (same base AND size) are the C
                # "tentative definition in two TUs" case (unref.c/unbtree.c
                # SQV*): retail folded them into one COMMON allocation, ours
                # keeps both zero-size-identical sections and places both at
                # the same retail base so whichever definition ld binds is
                # right.  Keep both.
                if label == 'bss' and a['base'] == b['base'] and a['end'] == b['end']:
                    continue
                # prefer the higher-quality anchor; drop only the weaker (a
                # unanimous-named window beats a decode/non-unanimous one, whose
                # mode-base is the likely-wrong one causing the overlap).
                qa, qb = a.get('q', 1), b.get('q', 1)
                loser = a if qa < qb else b if qb < qa else a
                keeper = b if loser is a else a
                drop.add(loser['obj'] + loser['section'])
                skipped.append((loser['obj'], loser['section'],
                                f"{label} overlaps {keeper['obj']}{keeper['section']} (lower-q)"))
        return [r for r in rows if r['obj'] + r['section'] not in drop]
    data_out = drop_overlaps(data_out, 'data')
    bss_out = drop_overlaps(bss_out, 'bss')
    OUT_RO.write_text(json.dumps(ro_out, indent=1) + '\n')
    OUT_DATA.write_text(json.dumps(data_out, indent=1) + '\n')
    OUT_BSS.write_text(json.dumps(bss_out, indent=1) + '\n')
    print(f'{len(ro_out)} .rodata windows -> {OUT_RO.name}')
    for r in ro_out:
        print(f"  {r['base']:#010x}..{r['end']:#010x}  {r['size']:5d}B  {r['words']}w  "
              f"({r['unresolved']} unres)  {r['obj']}")
    print(f'{len(data_out)} .data/.sdata bases -> {OUT_DATA.name}')
    print(f'{len(bss_out)} .bss/.sbss bases -> {OUT_BSS.name}')
    for r in bss_out:
        print(f"  {r['base']:#010x}  {r['section']:6s} {r['size']:5d}B  votes={r['votes']}  {r['obj']}")
    print(f'--- skipped {len(skipped)} ---')
    for rel, sec, why in sorted(skipped):
        print(f'  {rel} {sec}: {why}')

if __name__ == '__main__':
    main()
