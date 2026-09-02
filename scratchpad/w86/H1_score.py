"""H1_score -- index-aligned, reloc-masked scorer for the W86-H1 JPN row.

Same instrument as W85's M3_score, but it builds from an arbitrary SOURCE
STRING (so it works off the CURRENT candidate, which carries the sealed DATA
edits) instead of regenerating from the W84 base.
"""
import os, re, sys, shutil, subprocess
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
MIPS = Path('C:/Tools/mips-ps1/mips/bin')
OBJD = str(MIPS / 'mipsel-none-elf-objdump.exe')
sys.path.insert(0, str(ROOT / 'tools'))
sys.path.insert(0, str(ROOT / 'scratchpad' / 'w84'))
sys.path.insert(0, str(ROOT / 'scratchpad' / 'w86'))
import importlib.util
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
from R02_norm import norm_ins, load
import H1_lib as L

FN = '__15tGlobalMenuDefs'
LANE = 'recon/frontend/common/femenudefs.cpp'
ORACLE = load(str(ROOT / 'regiondiff/oracles/NFS4-R-JPN/__15tGlobalMenuDefs.s'))


def mask_reloc(t, kind):
    if kind == 'R_MIPS_HI16':
        return re.sub(r'^(lui \w+),.*$', r'\1,A', t)
    if kind in ('R_MIPS_LO16', 'R_MIPS_GPREL16', 'R_MIPS_LITERAL'):
        t = re.sub(r',-?\d+\(', ',A(', t)
        t = re.sub(r',-?\d+$', ',A', t)
    return t


def build_src(text, tag='H1_score'):
    src = ROOT / 'scratchpad' / 'w86' / (tag + '.cpp')
    src.write_text(text, encoding='utf-8', newline='')
    base = ROOT / LANE
    tmp = base.parent / ('%s__%s_%d.cpp' % (base.stem, tag, os.getpid()))
    shutil.copyfile(src, tmp)
    base_rel = base.relative_to(ROOT).as_posix()
    tmp_rel = tmp.relative_to(ROOT).as_posix()
    for _n, _t in vars(bld).items():
        if isinstance(_t, dict) and base_rel in _t:
            _t[tmp_rel] = _t[base_rel]
    try:
        obj = bld.compile_cpp(tmp)
        dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)],
                             capture_output=True, text=True).stdout
    finally:
        if tmp.exists():
            tmp.unlink()
    lines = []
    inb = False
    for ln in dis.splitlines():
        m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
        if m:
            if inb and re.fullmatch(r'LM\d+', m.group(1)):
                continue
            if inb:
                break
            inb = (m.group(1) == FN)
            continue
        if inb:
            lines.append(ln)
    out = []
    for i, ln in enumerate(lines):
        mm = re.match(r'^\s*[0-9a-f]+:\t([0-9a-f]+)\s*\t(.*)', ln)
        if not mm:
            continue
        nxt = lines[i + 1] if i + 1 < len(lines) else ''
        k = re.search(r'R_MIPS_\w+', nxt)
        out.append((norm_ins(mm.group(2)), k.group(0) if k else None))
    return out


def build_cfg(cfg, edits=None, tag='H1_score'):
    s = L.read()
    if cfg is not None:          # cfg FIRST: edits are spelled against the
        s = L.set_cfg(s, cfg)    # configured text (site depths already applied)
    if edits:
        for old, new, cnt in edits:
            got = s.count(old)
            if got != cnt:
                raise SystemExit('edit count %d != %d: %r' % (got, cnt, old[:80]))
            s = s.replace(old, new)
    return build_src(s, tag)


def score_stream(o):
    if len(o) != len(ORACLE):
        return (None, len(o), 'len %d != %d' % (len(o), len(ORACLE)), [])
    bad = []
    for i, (t, k) in enumerate(o):
        a = mask_reloc(t, k) if k else t
        b = mask_reloc(ORACLE[i], k) if k else ORACLE[i]
        if a != b:
            bad.append((i, t, ORACLE[i]))
    return (len(bad), len(o), '', bad)


def probe1747(stream):
    """the menuCarUpgrades (R2) indicator: distance from `addiu a0,rX,7988`
    to its jal.  retail = 1, ours (unshifted) = 9."""
    idx = [i for i, (t, k) in enumerate(stream) if re.match(r'^addiu a0,\w+,7988$', t)]
    if not idx:
        return None
    i = idx[0]
    j = next((j for j in range(i, len(stream)) if stream[j][0].startswith('jal')), None)
    return (j - i) if j else None


def probeR1(stream):
    """the menuSingleCarSelect (R1) indicator: does the &menuCarOptions address
    get SPILLED (retail: `sw rX,264(sp)` near index ~1067) or parked in fp
    (ours: `addiu fp,rX,8408`)?"""
    fp = [i for i, (t, k) in enumerate(stream) if re.match(r'^addiu fp,\w+,8408$', t)]
    return ('fp@%s' % fp[0]) if fp else 'spilled'


def frame(stream):
    m = re.match(r'^addiu sp,sp,(-\d+)$', stream[0][0])
    return -int(m.group(1)) if m else None


if __name__ == '__main__':
    for cfg in sys.argv[1:]:
        st = build_cfg(cfg)
        n, ln, err, bad = score_stream(st)
        print('%s score=%s insns=%d frame=%s R2delta=%s R1=%s %s' %
              (cfg, n, ln, frame(st), probe1747(st), probeR1(st), err), flush=True)
        if n and n < 40:
            for i, a, b in bad:
                print('   %5d  %-34s | %s' % (i, a, b))
