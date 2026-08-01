#!/usr/bin/env python3
"""atsyms.py TU [TU...] -- per-function BOTH-DIRECTIONS census of assembler `$at`
address macros (`lui $at,%hi(SYM)` / `lui $at,<literal>`), ours vs the splat oracle.

  ours > oracle : we emit the assembler store/load macro where retail pre-split the
                  address into a NORMAL register.  Cure for a symbol reloc = the
                  store-side unsized-array declaration shape (`extern int G;` ->
                  `extern int G[];` + `G[0] = v;`, catalog w42 §E, methodology
                  §3.12 #5); for a scratchpad literal = a per-function anchor local.
  oracle > ours : retail used the macro and we pre-split -> the INVERSE lever
                  (scalar / correctly-sized declaration, or drop an anchor local).

Div-guard `lui $at,0x8000` is excluded on both sides (both spellings: our objdump
prints `0x8000`, the splat oracle prints `(0x80000000 >> 16)`).

🔴 2026-08-02 (w43-a10): the ORIGINAL version of this tool tested `'$at' in line`
against `objdump -d` output, which prints registers BARE (`at`, no `$`).  It could
therefore NEVER report a hit -- every run since it was written was VACUOUS.  Fixed
here; the corrected tree-wide census over recon/{frontend,game}/psx found the axis
essentially EMPTY (every symbol-reloc `$at` site already reproduces the oracle).
"""
import re
import subprocess
import sys
import importlib.util
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
sys.path.insert(0, str(ROOT / 'tools'))
_spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
ORACLE_DIRS = [ROOT / 'asm' / 'nonmatchings' / 'front',
               ROOT / 'asm' / 'nonmatchings' / 'main']
DIV_GUARD = 0x8000


def _lit(expr):
    """`0x1f80` or the oracle's `(0x1F800028 >> 16)` -> int."""
    e = expr.strip()
    m = re.match(r'^\((0x[0-9A-Fa-f]+)\s*>>\s*(\d+)\)$', e)
    if m:
        return int(m.group(1), 16) >> int(m.group(2))
    return int(e, 16) if e.lower().startswith('0x') else int(e)


def oracle_syms(fn):
    """-> Counter of $at address keys in the oracle .s, or None if no oracle."""
    for d in ORACLE_DIRS:
        p = d / (fn + '.s')
        if not p.exists():
            continue
        c = Counter()
        for line in p.read_text(encoding='utf-8', errors='replace').splitlines():
            m = re.search(r'\blui\s+\$at,\s*(.+?)\s*(?:/\*|$)', line)
            if not m:
                continue
            arg = m.group(1).strip()
            s = re.match(r'%hi\((.+)\)', arg)
            if s:
                c[s.group(1)] += 1
                continue
            v = _lit(arg)
            if v != DIV_GUARD:
                c['<literal 0x%x>' % v] += 1
        return c
    return None


def ours_syms(obj):
    """-> {fn: Counter of $at address keys} for our built object."""
    dis = subprocess.run([OBJD, '-d', '-r', '-z', str(obj)],
                         capture_output=True, text=True).stdout.splitlines()
    cur, out = None, {}
    for i, l in enumerate(dis):
        m = re.match(r'^([0-9a-f]{8}) <(.+)>:', l)
        if m:
            cur = m.group(2)
        if not re.search(r'\blui\s+at,', l):
            continue
        # objdump -r prints the reloc on the line IMMEDIATELY after the insn;
        # no reloc => a literal address (scratchpad / div guard).
        r = re.search(r'R_MIPS_HI16\s+(\S+)', dis[i + 1]) if i + 1 < len(dis) else None
        if r:
            key = r.group(1)
        else:
            v = _lit(re.search(r'lui\s+at,(\S+)', l).group(1))
            if v == DIV_GUARD:
                continue
            key = '<literal 0x%x>' % v
        out.setdefault(cur, Counter())[key] += 1
    return out


def sweep(rel):
    src = ROOT / rel
    obj = bld.compile_c(src, False) if src.suffix == '.c' else bld.compile_cpp(src)
    mine = ours_syms(obj)
    tab = subprocess.run([OBJD, '-t', str(obj)], capture_output=True, text=True).stdout
    fns = {m.group(1) for m in re.finditer(r'F \.text\t[0-9a-f]+ (\S+)', tab)}
    rows = []
    for fn in sorted(fns | set(mine)):
        o = oracle_syms(fn)
        m = mine.get(fn, Counter())
        if o is None:
            if m:
                rows.append((fn, m, Counter(), 'NO-ORACLE'))
            continue
        if m != o:
            rows.append((fn, m, o, ''))
    if rows:
        print('== %s' % rel)
        for fn, m, o, note in rows:
            print('   %-58s ours=%-32s oracle=%-32s %s'
                  % (fn[:58], dict(m) or '{}', dict(o) or '{}', note))
    else:
        print('== %s : $at census matches the oracle in every function' % rel)


if __name__ == '__main__':
    for a in sys.argv[1:]:
        sweep(a)
