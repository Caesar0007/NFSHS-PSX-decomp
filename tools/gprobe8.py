#!/usr/bin/env python3
"""gprobe8.py -- probe -G8 vs the TU's current -G on the per-function gate.

Retail CC1PSX's default small-data threshold is -G8; our lane defaults to -G0
(and frontend/common is force-defaulted to -G0).  A TU retail built at -G8 puts
its small (<=8 byte) read-only string/const literals in .sdata, but at -G0 our
compile pools them into .rodata -- reordering the section and diffing the image.

For each TU argument this compiles at its CURRENT g_value and at g_value 8, runs
the same per-function gate as tools/check_one.py, and reports pass counts + the
.sdata size delta.  Wire -G8 (in build.py PER_TU_FLAGS) only where pass does NOT
drop.  Report-only; edits nothing.
"""
import importlib.util, subprocess, re, difflib, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'

omap = {}
for d in [ROOT/'asm'/'nonmatchings'/'main', ROOT/'asm'/'nonmatchings'/'front']:
    for p in d.glob('*.s'):
        omap.setdefault(p.name[:-2], p)

def norm(t):
    t = re.sub(r'\s+', ' ', t.strip()).replace('$', ''); t = re.sub(r',\s+', ',', t)
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1), 16)), t)
    t = re.sub(r'%hi\([^)]*\)', '0', t); t = re.sub(r'%lo\([^)]*\)', '0', t); t = re.sub(r'%gp_rel\([^)]*\)', '0', t)
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^(?:addiu|ori) (\w+),zero,(\-?\d+)$', r'li \1,\2', t)
    m = re.match(r'(beq|bne)\s+(\w+,\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(j|jal|b)\s+', t)
    if m: return f"{m.group(1)} T"
    return t

def oracle_ins(p):
    out = []
    for ln in p.read_text().splitlines():
        ln = re.sub(r'/\*.*?\*/', '', ln); s = ln.strip()
        if s.startswith('endlabel'): break
        if not s or s.startswith(('.', 'glabel', 'nonmatching', 'dlabel', 'jlabel')) or s.startswith('.L') or s.endswith(':'): continue
        out.append(norm(s))
    return out

def gate(rel):
    obj = bld.compile_cpp(ROOT / rel)
    dis = subprocess.run([OBJD, '-d', '-r', str(obj)], capture_output=True, text=True).stdout
    cur = None; bodies = {}
    for ln in dis.splitlines():
        mm = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
        if mm: cur = mm.group(1); bodies[cur] = []; continue
        if cur:
            ii = re.match(r'^\s*[0-9a-f]+:\t[0-9a-f]+\s*\t(.*)', ln)
            if ii: bodies[cur].append(norm(ii.group(1)))
            elif 'R_MIPS_LO16' in ln and bodies[cur]:
                l = re.sub(r',-?\d+\(', ',0(', bodies[cur][-1]); bodies[cur][-1] = re.sub(r',-?\d+$', ',0', l)
    p = 0; tot = 0
    for fn, ins in bodies.items():
        if fn not in omap: continue
        e = oracle_ins(omap[fn]); tot += 1
        d = [l for l in difflib.unified_diff(ins, e, lineterm='') if l[0] in '+-' and not l.startswith(('+++', '---'))]
        if not d: p += 1
    # .sdata size
    sd = 0
    for ln in subprocess.run([OBJD, '-h', str(obj)], capture_output=True, text=True).stdout.splitlines():
        m = re.match(r'^\s*\d+\s+\.sdata\s+([0-9a-f]{8})', ln)
        if m: sd = int(m.group(1), 16)
    return p, tot, sd

def main():
    for rel in sys.argv[1:]:
        flags = bld.PER_TU_FLAGS.setdefault(rel, {})
        cur_g = str(flags.get('g_value', '0'))
        if rel.startswith('recon/frontend/common/') and 'g_value' not in flags:
            cur_g = '0'
        flags['g_value'] = cur_g
        p0, t0, sd0 = gate(rel)
        flags['g_value'] = '8'
        p8, t8, sd8 = gate(rel)
        flags['g_value'] = cur_g          # restore
        verdict = 'OK -G8' if p8 >= p0 else 'REGRESS'
        print(f'{rel}: G{cur_g} pass={p0}/{t0} sdata={sd0}  ->  G8 pass={p8}/{t8} '
              f'sdata={sd8}  [{verdict}{"" if p8==p0 else f" {p8-p0:+d}"}]')

if __name__ == '__main__':
    main()
