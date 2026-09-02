"""M3_score.py — build a config, compile it through the real lane, and score it
against the JPN oracle with an INDEX-ALIGNED, reloc-masked comparison.

Rationale: the gate's own diff count is a difflib artifact once a pervasive
register-phase swap breaks its skeleton alignment (a structurally near-perfect
config scores WORSE than a structurally distant one).  When both streams have the
same length, position i of ours corresponds to position i of the oracle, so the
honest residual is simply the count of positions whose reloc-masked text differs.

usage: python M3_score.py <9-digit depth cfg> [more cfgs...]
"""
import os, re, sys, shutil, subprocess
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
MIPS = Path('C:/Tools/mips-ps1/mips/bin')
OBJD = str(MIPS / 'mipsel-none-elf-objdump.exe')
sys.path.insert(0, str(ROOT / 'tools'))
sys.path.insert(0, str(ROOT / 'scratchpad' / 'w84'))
sys.path.insert(0, str(ROOT / 'scratchpad' / 'w85'))
import importlib.util
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
from R02_norm import norm_ins, load
import M3_depth as D

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


def build(cfg, tag='M3_score'):
    src = ROOT / 'scratchpad' / 'w85' / (tag + '.cpp')
    src.write_text(D.src(cfg), encoding='utf-8', newline='')
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


def score(cfg):
    o = build(cfg)
    if len(o) != len(ORACLE):
        return (None, len(o), 'len %d != %d' % (len(o), len(ORACLE)), [])
    bad = []
    for i, (t, k) in enumerate(o):
        a = mask_reloc(t, k) if k else t
        b = mask_reloc(ORACLE[i], k) if k else ORACLE[i]
        if a != b:
            bad.append((i, t, ORACLE[i]))
    return (len(bad), len(o), '', bad)


if __name__ == '__main__':
    for cfg in sys.argv[1:]:
        n, ln, err, bad = score(cfg)
        print(cfg, 'score=', n, 'insns=', ln, err, flush=True)
        if n and n < 40:
            for i, a, b in bad:
                print('   %5d  %-32s | %s' % (i, a, b))
