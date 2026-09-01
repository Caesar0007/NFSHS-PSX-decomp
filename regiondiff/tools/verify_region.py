#!/usr/bin/env python3
"""verify_region.py REGION CPP FUNC[,FUNC...] [--lane-as recon/...]

Regional-variant gate: compile a recon candidate TU through the SAME
build.py pipeline as the main project (cc1plus/cc1 + maspsx, per-TU lanes,
per-fn splices), then diff each named function against its LINKED regional
oracle slice regiondiff/oracles/<REGION>/<fn>.s (regionrecon.py m2c-dialect).

Differences vs tools/verify_asm.py (the base gate), forced by the oracle
being a LINKED image slice with NO relocation info:
  * ours is UNLINKED (symbolic %hi/%lo/%gp_rel, zero addends); the regional
    slice carries the RESOLVED address constants of a DIFFERENT memory
    layout.  So address-materialization fields cannot be compared textually.
  * The gate therefore aligns the two streams on a SKELETON (mnemonic +
    register list, immediates dropped) and then compares aligned pairs
    FULLY (immediates included) EXCEPT in the fields our own object marks
    as relocations (R_MIPS_HI16 / LO16 / GPREL16 / 26): those are the
    layout-dependent fields, masked on both sides.
  * Consequence (documented soundness gap, same family as the base gate's
    LO16-zeroing): a wrong constant offset into a relocated symbol is
    invisible.  A REGION-PASS proves the instruction stream (opcodes,
    registers, schedule, all non-reloc immediates) matches the regional
    build; byte authority needs a per-region link map (future brdist-R).

REGION is one of: NFS4-R-AU NFS4-R-FR-DE NFS4-R-JPN NFS4-R-UK-ES-IT
NFS4-R-UK-SW NFS4-R-USA (short forms AU/FR-DE/JPN/UK-ES-IT/UK-SW/USA ok).

--lane-as recon/<unit>.<ext>: compile the candidate WITH the named base
TU's per-TU/per-fn build lanes AND from inside that TU's directory (a temp
copy next to the base TU so sibling #include "..." resolve).  Default: the
manifest column `unit` for the first FUNC, if the candidate sits under
regiondiff/recon/.  A candidate that IS a tree TU (recon/...) compiles
as itself, no copy.
"""
import os, re, sys, shutil, subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent   # nfs4-decomp/
RD   = ROOT / 'regiondiff'
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
OBJD = str(MIPS / 'mipsel-none-elf-objdump.exe')
REGIONS = ['NFS4-R-AU','NFS4-R-FR-DE','NFS4-R-JPN','NFS4-R-UK-ES-IT','NFS4-R-UK-SW','NFS4-R-USA']

def _region(arg):
    a = arg.upper()
    for r in REGIONS:
        if a == r or a == r.replace('NFS4-R-',''):
            return r
    sys.exit(f'unknown region {arg!r}; expected one of {REGIONS}')

args = [a for a in sys.argv[1:] if not a.startswith('--')]
opts = {a.split('=',1)[0]: (a.split('=',1)[1] if '=' in a else True)
        for a in sys.argv[1:] if a.startswith('--')}
if len(args) < 3:
    sys.exit(__doc__)
REGION = _region(args[0])
cand   = ROOT / args[1]
funcs  = args[2].split(',')

# ---------------------------------------------------------------- manifest
def _manifest():
    rows = {}
    p = RD / 'MANIFEST.tsv'
    if p.exists():
        hdr = None
        for ln in p.read_text().splitlines():
            f = ln.rstrip('\n').split('\t')
            if hdr is None:
                hdr = f; continue
            d = dict(zip(hdr, f))
            rows.setdefault(d['function'], []).append(d)
    return rows

# ------------------------------------------------- compile via build.py
sys.path.insert(0, str(ROOT / 'tools'))   # build.py imports siblings (fix_symsizes)
import importlib.util
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
# Mirror verify_asm.py's NFS4_SOURCE_ONLY strict-gate filtering.
if os.environ.get('NFS4_SOURCE_ONLY') == '1':
    for _name, _table in vars(bld).items():
        if not (_name.startswith('PER_FN_') and isinstance(_table, dict)):
            continue
        if _name == 'PER_FN_CC1_VER_SPLICE_272':
            continue
        if _name == 'PER_FN_CC1_VER_SPLICE':
            for _source in list(_table):
                if (not _source.startswith('recon/syslib/') and
                        _source != 'recon/eaclib/psx/pad.c'):
                    del _table[_source]
            continue
        _table.clear()
bld.OUT = bld.BUILD

lane_as = opts.get('--lane-as')
if not lane_as:
    man = _manifest()
    for r in man.get(funcs[0], []):
        if r.get('unit'):
            for ext in ('.cpp', '.c'):
                if (ROOT / 'recon' / (r['unit'] + ext)).exists():
                    lane_as = 'recon/' + r['unit'] + ext
            break

tmp = None
try:
    src = cand
    if lane_as and cand.resolve() != (ROOT / lane_as).resolve():
        base = ROOT / lane_as
        if not base.exists():
            sys.exit(f'--lane-as target not found: {lane_as}')
        # temp copy NEXT TO the base TU: sibling includes + directory-prefix
        # class rules (e.g. frontend/common -G0) resolve exactly as the base.
        tmp = base.parent / (base.stem + '__region_gate' + cand.suffix)
        shutil.copyfile(cand, tmp)
        src = tmp
        # alias every exact-rel-keyed lane table entry onto the temp path
        base_rel = base.relative_to(ROOT).as_posix()
        tmp_rel  = src.relative_to(ROOT).as_posix()
        for _n, _t in vars(bld).items():
            if isinstance(_t, dict) and base_rel in _t:
                _t[tmp_rel] = _t[base_rel]
    obj = bld.compile_c(src, skip_asm=False) if src.suffix == '.c' else bld.compile_cpp(src)
    dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)],
                         capture_output=True, text=True).stdout
    symtab = subprocess.run([OBJD, '-t', str(obj)],
                            capture_output=True, text=True).stdout
finally:
    if tmp is not None and tmp.exists():
        tmp.unlink()

_name2addr = {}
for _ln in symtab.splitlines():
    if '*UND*' in _ln or '*ABS*' in _ln:
        continue
    _t = _ln.split()
    if len(_t) >= 2 and re.match(r'^[0-9a-f]{8}$', _t[0]):
        _name2addr[_t[-1]] = _t[0]
_addr2label = {}
for _ln in dis.splitlines():
    _m = re.match(r'^([0-9a-f]{8}) <(.+)>:', _ln)
    if _m:
        _addr2label.setdefault(_m.group(1), _m.group(2))
def _resolve(fn):
    a = _name2addr.get(fn)
    return _addr2label.get(a, fn) if a else fn

# ------------------------------------------------------------- normalizer
_COP0 = {'sr':'12','status':'12','cause':'13','epc':'14','badvaddr':'8','prid':'15','index':'0',
         'random':'1','entrylo':'2','context':'4','config':'16','bpc':'3','bda':'5','dcic':'7','bdam':'9','bpcm':'11'}

def norm_ins(t):
    t = re.sub(r'\s+', ' ', t.strip())
    t = t.replace('$', '')
    t = re.sub(r'\bs8\b', 'fp', t)
    t = re.sub(r',\s+', ',', t)
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1),16)), t)
    m = re.match(r'^break\b(.*)$', t)
    if m:
        ops = [o for o in re.split(r'[ ,]+', m.group(1).strip()) if o and o != '0']
        t = 'break' + ((' ' + ','.join(ops)) if ops else '')
    m = re.match(r'^syscall\b(.*)$', t)
    if m:
        ops = [o for o in re.split(r'[ ,]+', m.group(1).strip()) if o and o != '0']
        t = 'syscall' + ((' ' + ','.join(ops)) if ops else '')
    t = re.sub(r'\bc0_(\w+)\b', lambda mm: _COP0.get(mm.group(1), mm.group(0)), t)
    # regional slice jtbl fixups carry symbolic %hi/%lo(jtbl_...) -> 0, like base
    t = re.sub(r'%hi\([^)]*\)', '0', t)
    t = re.sub(r'%lo\([^)]*\)', '0', t)
    t = re.sub(r'%gp_rel\([^)]*\)', '0', t)
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^or (\w+),zero,(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^or (\w+),(\w+),zero$', r'addu \1,\2,zero', t)
    t = re.sub(r'^(?:addiu|ori) (\w+),zero,(\-?\d+)$', r'li \1,\2', t)
    # branch/jump target masking (both sides)
    m = re.match(r'(beq|bne)\s+(\w+,\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(j|jal|b)\s+', t)
    if m: return f"{m.group(1)} T"
    return t

def skeleton(t):
    """mnemonic + register list only: strip every immediate/displacement.
    Alignment key; full compare happens pairwise afterwards."""
    t = re.sub(r'-?\b\d+\b', 'N', t)
    return t

def mask_reloc(t, kind):
    """Blank the layout-dependent field for a reloc-carrying instruction."""
    if kind in ('R_MIPS_HI16',):
        return re.sub(r'^(lui \w+),.*$', r'\1,A', t)
    if kind in ('R_MIPS_LO16', 'R_MIPS_GPREL16', 'R_MIPS_LITERAL'):
        t = re.sub(r',-?\d+\(', ',A(', t)          # lw/sw disp
        t = re.sub(r',-?\d+$', ',A', t)            # addiu/ori imm
        return t
    return t

# ------------------------------------------------------------- ours side
def ours(fn):
    """[(normalized, reloc_kind_or_None)] for fn's block in our object."""
    fnl = _resolve(fn)
    lines=[]; inb=False
    for ln in dis.splitlines():
        m=re.match(r'^[0-9a-f]{8} <(.+)>:',ln)
        if m:
            if inb and re.fullmatch(r'LM\d+', m.group(1)):
                continue
            if inb: break
            inb=(m.group(1)==fnl); continue
        if inb: lines.append(ln)
    out=[]
    for i,ln in enumerate(lines):
        mm=re.match(r'^\s*[0-9a-f]+:\t([0-9a-f]+)\s*\t(.*)',ln)
        if not mm: continue
        word=mm.group(1); insn=mm.group(2)
        if re.match(r'c(?:op)?2\b', insn):
            out.append(('cop2 '+word, None)); continue
        if insn.lstrip().startswith('.word'):
            out.append(('dword ' + word.lower().zfill(8), None)); continue
        nxt = lines[i+1] if i+1 < len(lines) else ''
        kind = None
        mrel = re.search(r'R_MIPS_\w+', nxt)
        if mrel:
            kind = mrel.group(0)
        out.append((norm_ins(insn), kind))
    return out

# ----------------------------------------------------------- oracle side
def _oracle_path(fn):
    fname = re.sub(r'[^\w]', '_', fn)[:80] + '.s'
    p = RD / 'oracles' / REGION / fname
    if p.exists() and p.name in {e.name for e in p.parent.iterdir()}:
        return p
    return None

def oracle(fn):
    p = _oracle_path(fn)
    if p is None: return None
    out=[]
    for ln in p.read_text().splitlines():
        s = ln.strip()
        if s.startswith('.section'):
            break                              # jtbl .rodata tail: not the fn
        s = re.sub(r'/\*.*?\*/', '', ln).strip()
        mw = re.match(r'\.word\s+0x([0-9a-fA-F]+)\b', s)
        if mw and (int(mw.group(1),16) >> 26) == 0x12:
            out.append('cop2 ' + mw.group(1).lower()); continue
        if mw:
            out.append('dword ' + mw.group(1).lower().zfill(8)); continue
        if not s or s.startswith(('.','glabel','nonmatching','dlabel','jlabel','alabel')) or s.endswith(':'):
            continue
        # regionrecon cop2fix renders a GTE compute op as `cop2 0xCOFUN`
        # (25-bit cofun); our side carries the full word 0x4A......  Recode.
        mc = re.match(r'cop2\s+(\d+)$', norm_ins(s))
        if mc:
            out.append('cop2 %08x' % (0x4A000000 | int(mc.group(1)))); continue
        out.append(norm_ins(s))
    return out

# ------------------------------------------------------------------ diff
import difflib
allpass = True
for fn in funcs:
    o = ours(fn); e = oracle(fn)
    if e is None: print(f"  {fn}: NO ORACLE ({REGION})"); allpass=False; continue
    if not o: print(f"  {fn}: NOT IN OBJECT"); allpass=False; continue
    o_txt  = [x[0] for x in o]
    o_kind = [x[1] for x in o]
    sm = difflib.SequenceMatcher(None, [skeleton(x) for x in o_txt],
                                       [skeleton(x) for x in e], autojunk=False)
    diffs = []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == 'equal':
            for k in range(i2 - i1):
                i, j = i1 + k, j1 + k
                a, b = o_txt[i], e[j]
                if o_kind[i]:
                    a = mask_reloc(a, o_kind[i]); b = mask_reloc(b, o_kind[i])
                if a != b:
                    diffs.append(f"- {o_txt[i]}"); diffs.append(f"+ {e[j]}")
        else:
            for i in range(i1, i2): diffs.append(f"- {o_txt[i]}")
            for j in range(j1, j2): diffs.append(f"+ {e[j]}")
    if not diffs:
        print(f"  {fn}: REGION-PASS ({len(o)} insns) [{REGION}]")
    else:
        allpass = False
        print(f"  {fn}: FAIL {len(diffs)} diffs (ours {len(o)} / oracle {len(e)}) [{REGION}]")
        for l in diffs[:int(os.environ.get('VA_MAX', '12'))]:
            print("      " + l)
sys.exit(0 if allpass else 1)
