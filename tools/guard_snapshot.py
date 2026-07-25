#!/usr/bin/env python3
"""guard_snapshot.py DIR [DIR...] -> OUTFILE
Wave-25 a10 regression-guard helper. Like bulkverify.py but (a) records the
FULL per-function status (not truncated top-N), (b) is directory-recursive-safe
across a LIST of dirs in one run, (c) emits a stable, diffable text format:

    <status>\t<diffcount>\t<fn>\t<module-relpath>

status in {PASS, NEAR, FAR, NOORACLE-SKIP, COMPILE-FAIL}. One line per
oracle'd function (COMPILE-FAIL emits one line for the whole module, fn="*").

Read-only over recon/ source; only writes the given OUTFILE. Reuses
build.py's compile_c/compile_cpp exactly like bulkverify.py/verify_asm.py do,
so results are gate-identical to the project's authoritative verifier.
"""
import importlib.util, subprocess, re, difflib, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
ASMDIRS = [ROOT / 'asm' / 'nonmatchings' / 'main', ROOT / 'asm' / 'nonmatchings' / 'front']


def norm(t):
    t = re.sub(r'\s+', ' ', t.strip()).replace('$', '')
    t = re.sub(r',\s+', ',', t)
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1), 16)), t)
    # eval unevaluated constant-literal paren exprs (mirrors verify_asm.py's norm_ins,
    # the authoritative gate; see w25-a10 gate-bug fix in bulkverify.py for detail).
    t = re.sub(r'\((\d+) ?>> ?(\d+)\)', lambda m: str(int(m.group(1)) >> int(m.group(2))), t)
    t = re.sub(r'\((\d+) ?& ?(\d+)\)', lambda m: str(int(m.group(1)) & int(m.group(2))), t)
    t = re.sub(r'%hi\([^)]*\)', '0', t)
    t = re.sub(r'%lo\([^)]*\)', '0', t)
    t = re.sub(r'%gp_rel\([^)]*\)', '0', t)
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^(?:addiu|ori) (\w+),zero,(\-?\d+)$', r'li \1,\2', t)
    m = re.match(r'(beq|bne)\s+(\w+,\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(j|jal|b)\s+', t)
    if m: return f"{m.group(1)} T"
    return t


_oracle_names = {p.name[:-2]: p for d in ASMDIRS if d.exists() for p in d.glob('*.s')}


def oracle_ins(fn):
    p = _oracle_names.get(fn)
    if p is None:
        return None
    out = []
    for ln in p.read_text().splitlines():
        ln = re.sub(r'/\*.*?\*/', '', ln)
        s = ln.strip()
        if s.startswith('endlabel'):
            break
        if not s or s.startswith(('.', 'glabel', 'nonmatching', 'dlabel', 'jlabel', 'alabel')) or s.startswith('.L') or s.endswith(':'):
            continue
        out.append(norm(s))
    return out


def sweep(dirs):
    mods = []
    for d in dirs:
        dp = ROOT / d
        if not dp.exists():
            print(f"WARN: path not found: {d}", file=sys.stderr)
            continue
        if dp.is_file():
            mods.append(dp)
        else:
            mods += sorted([*dp.glob('*.cpp'), *dp.glob('*.c')])
    rows = []
    for m in mods:
        rel = m.relative_to(ROOT).as_posix()
        try:
            obj = bld.compile_c(m, False) if m.suffix == '.c' else bld.compile_cpp(m)
        except SystemExit as e:
            rows.append(("COMPILE-FAIL", "-", "*", rel))
            continue
        except Exception as e:
            rows.append(("COMPILE-FAIL", "-", "*", rel))
            continue
        dis = subprocess.run([OBJD, '-d', '-r', str(obj)], capture_output=True, text=True).stdout
        cur = None
        bodies = {}
        for ln in dis.splitlines():
            mm = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
            if mm:
                cur = mm.group(1); bodies[cur] = []; continue
            if cur:
                ii = re.match(r'^\s*[0-9a-f]+:\t[0-9a-f]+\s*\t(.*)', ln)
                if ii:
                    bodies[cur].append(norm(ii.group(1)))
                elif ('R_MIPS_LO16' in ln or 'R_MIPS_GPREL16' in ln) and bodies[cur]:
                    l = re.sub(r',-?\d+\(', ',0(', bodies[cur][-1])
                    bodies[cur][-1] = re.sub(r',-?\d+$', ',0', l)
        for fn, ins in bodies.items():
            e = oracle_ins(fn)
            if e is None:
                continue
            d = [l for l in difflib.unified_diff(ins, e, lineterm='') if l[0] in '+-' and not l.startswith(('+++', '---'))]
            if not d:
                rows.append(("PASS", "0", fn, rel))
            elif len(d) <= 15:
                rows.append(("NEAR", str(len(d)), fn, rel))
            else:
                rows.append(("FAR", str(len(d)), fn, rel))
    return rows


if __name__ == '__main__':
    args = sys.argv[1:]
    if len(args) < 2:
        sys.exit("usage: guard_snapshot.py DIR [DIR...] OUTFILE")
    outfile = args[-1]
    dirs = args[:-1]
    rows = sweep(dirs)
    with open(outfile, 'w') as f:
        for status, diffn, fn, rel in rows:
            f.write(f"{status}\t{diffn}\t{fn}\t{rel}\n")
    npass = sum(1 for r in rows if r[0] == "PASS")
    nnear = sum(1 for r in rows if r[0] == "NEAR")
    nfar = sum(1 for r in rows if r[0] == "FAR")
    ncf = sum(1 for r in rows if r[0] == "COMPILE-FAIL")
    print(f"{outfile}: {len(rows)} rows  PASS={npass} NEAR={nnear} FAR={nfar} COMPILE-FAIL={ncf}")
