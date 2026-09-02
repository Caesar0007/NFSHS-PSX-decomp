#!/usr/bin/env python3
"""extend_corpus.py -- promote audit_lo16's HIDDEN-CHANGED functions into the
regional corpus: slice their regional bodies (m2c-dialect, regionrecon.py's
emit format), append CHANGED rows to each region's INDEX.tsv, extend
variants.tsv (grouping regions by exact delta signature vs base), so
gen_manifest.py picks them up as normal work-plan rows.

Safe to re-run: skips rows already present in INDEX.tsv.
"""
import re, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
RD = ROOT / 'regiondiff'
BIN = Path(r'C:/Temp/nfs4-clean/Binaries')
DIFFDIR = BIN / 'NFS4-B-USA' / 'regiondiff'
BASE_EXE = BIN / 'NFS4-B-USA.EXE'
BASE_VA = 0x80010000
HDR = 0x800
REGIONS = ['NFS4-R-AU','NFS4-R-FR-DE','NFS4-R-JPN','NFS4-R-UK-ES-IT','NFS4-R-UK-SW','NFS4-R-USA']

sys.path.insert(0, str(RD / 'tools'))
import audit_lo16 as AU

import subprocess
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
REGS = ("zero at v0 v1 a0 a1 a2 a3 t0 t1 t2 t3 t4 t5 t6 t7 "
        "s0 s1 s2 s3 s4 s5 s6 s7 k0 k1 gp sp fp s8 ra").split()
REG_RE = re.compile(r'\b(' + '|'.join(REGS) + r')\b')
JT = re.compile(r'(?:0x)?([0-9a-f]{6,8})\s*$')

def cop2fix(hexw, mnem, ops):
    """regionrecon.py's cop2fix, verbatim semantics."""
    if mnem == 'c2':
        return 'cop2', ops
    if mnem == '.word':
        w = int(hexw, 16)
        op = w >> 26
        if op == 0x12 and (w & 0x02000000):
            return 'cop2', '0x%X' % (w & 0x1FFFFFF)
        if op == 0x12 and not (w & 0x7FF):
            mn = {0: 'mfc2', 2: 'cfc2', 4: 'mtc2', 6: 'ctc2'}.get((w >> 21) & 31)
            if mn:
                return mn, '$%s, $%d' % (REGS[(w >> 16) & 31], (w >> 11) & 31)
        if op in (0x32, 0x3A):
            imm = w & 0xFFFF
            if imm >= 0x8000:
                imm -= 0x10000
            return ('lwc2' if op == 0x32 else 'swc2',
                    '$%d, %d($%s)' % ((w >> 16) & 31, imm, REGS[(w >> 21) & 31]))
    return mnem, ops

def slice_fn(rimg, rva, nwords):
    """emit an m2c-dialect slice (regionrecon.emit format) for [rva, rva+4n)."""
    off = rva - BASE_VA + HDR
    blob = rimg[off:off + 4 * nwords]
    tmp = RD / 'tools' / '_slice.bin'
    tmp.write_bytes(blob)
    dis = subprocess.run([OBJD, '-D', '-z', '-b', 'binary', '-m', 'mips:3000',
                          '-EL', '--adjust-vma=%#x' % rva, str(tmp)],
                         capture_output=True, text=True).stdout
    tmp.unlink()
    rows = []
    for line in dis.splitlines():
        m = re.match(r'^\s*([0-9a-f]+):\s+([0-9a-f]{8})\s+(\S+)(?:\s+(.*))?$', line)
        if m:
            ops = re.split(r'\s*#', (m.group(4) or '').strip())[0].strip()
            rows.append([int(m.group(1), 16), m.group(2), m.group(3), ops])
    s, e = rva, rva + 4 * nwords
    targets = set()
    for va, hexw, mnem, ops in rows:
        if mnem[0] == 'b' or mnem == 'j':
            mm = JT.search(ops)
            if mm and s <= int(mm.group(1), 16) < e:
                targets.add(int(mm.group(1), 16))
    lines = ['.set noat', '.set noreorder', '', 'glabel func_%08X' % rva]
    for va, hexw, mnem, ops in rows:
        if va in targets:
            lines.append('.L%08X:' % va)
        newops = ops
        if mnem == 'jal':
            mm = JT.search(ops)
            if mm:
                newops = 'func_%08X' % int(mm.group(1), 16)
        elif mnem[0] == 'b' or mnem == 'j':
            mm = JT.search(ops)
            if mm:
                t = int(mm.group(1), 16)
                lbl = ('.L%08X' % t) if s <= t < e else ('func_%08X' % t)
                newops = ops[:mm.start()] + lbl
        mnem, newops = cop2fix(hexw, mnem, newops)
        newops = ','.join(REG_RE.sub(lambda mm: '$' + mm.group(1), p)
                          for p in newops.split(','))
        lines.append('/* %08X %s */  %-8s %s' % (va, hexw, mnem, newops))
    return '\n'.join(lines) + '\n'

def fnfile(name):
    return re.sub(r'[^\w]', '_', name)[:80]

def main():
    base_img = BASE_EXE.read_bytes()
    # per fn: {region: (rva, delta_sig, words)}
    found = {}
    for region in REGIONS:
        rimg = (BIN / (region + '.EXE')).read_bytes()
        for ln in (DIFFDIR / (region + '.tsv')).read_text().splitlines()[1:]:
            f = ln.split('\t')
            if len(f) < 6 or f[0] not in ('LO16', 'RELOC') or not f[3]:
                continue
            bva, rva, name, wb, wr = int(f[1],16), int(f[2],16), f[3], int(f[4]), int(f[5])
            if wb != wr:
                continue
            masks = AU.oracle_masks(name)
            if masks is None or len(masks) != wb:
                continue
            bw = AU.words_of(base_img, bva, wb)
            rw = AU.words_of(rimg, rva, wb)
            sig = tuple((i, rw[i]) for i in range(wb)
                        if (bw[i] ^ rw[i]) & ~masks[i] & 0xFFFFFFFF)
            if sig:
                found.setdefault(name, {})[region] = (rva, bva, sig, wb, rimg)
    print('hidden-changed union:', len(found))

    added_idx = {r: 0 for r in REGIONS}
    var_lines = []
    for name in sorted(found):
        per = found[name]
        # slices + INDEX rows
        for region, (rva, bva, sig, wb, rimg) in per.items():
            d = RD / 'oracles' / region
            sp = d / (fnfile(name) + '.s')
            idx = d / 'INDEX.tsv'
            # exact NAME-COLUMN check -- a substring test wrongly skips fns
            # that appear in other rows' callers columns (MainLoop et al.)
            have = {l.split('\t')[3] for l in idx.read_text().splitlines()[1:]
                    if l.count('\t') >= 3}
            if name in have:
                continue                     # already promoted
            sp.write_text(slice_fn(rimg, rva, wb), newline='\n')
            with open(idx, 'a', newline='\n') as fh:
                fh.write(f'CHANGED\t{rva:08X}\t{bva:08X}\t{name}\t{wb}\t\t'
                         f'HIDDEN-CHANGED (audit_lo16: {len(sig)} non-reloc words differ)\n')
            added_idx[region] += 1
        # variants row: group regions by identical delta signature
        groups = {}
        for region, (rva, bva, sig, wb, rimg) in per.items():
            groups.setdefault(sig, []).append(region.replace('NFS4-R-', ''))
        wb = next(iter(per.values()))[3]
        gtxt = ' || '.join('+'.join(sorted(regs)) + f'({wb}w)'
                           for regs in groups.values())
        var_lines.append(f'{name}\t{len(groups)}\t{gtxt}')

    vt = RD / 'variants.tsv'
    existing = vt.read_text()
    new = [l for l in var_lines if l.split('\t')[0] + '\t' not in existing]
    with open(vt, 'a', newline='\n') as fh:
        for l in new:
            fh.write(l + '\n')
    print('INDEX rows added:', added_idx)
    print('variants rows added:', len(new))

if __name__ == '__main__':
    main()
