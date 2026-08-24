#!/usr/bin/env python3
"""phantom_audit.py — hidden-phantom mangling audit (worker w14-a2, task part 1).

For every oracle mangled name in asm/nonmatchings/{main,front}/*.s, check whether ANY
compiled recon .o defines that EXACT symbol. If not, look for a NEAR match (same base
name before the GNU2-mangling separator, different param/return signature suffix) among
ALL defined symbols in the whole recon tree — that's a hidden phantom (precedent:
AudioCmn_GetAsyncSfx __FiiPv vs oracle __Fiib). If no near match either, it's an
ownership/missing-function gap.

Usage:  python tools/phantom_audit.py [--skip-compile]  (skip-compile reuses build/ objects)
Output: scratch/phantom_report.txt + prints summary to stdout.
"""
import re, subprocess, sys, importlib.util
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MIPS = Path(r'C:/Tools/mips-ps1/mips/bin')
NM = str(MIPS / 'mipsel-none-elf-nm.exe')

spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD

SKIP_COMPILE = '--skip-compile' in sys.argv

# ---------- 1. oracle names ----------
oracle = {}  # name -> set of sources ('main'/'front')
for sub in ('main', 'front'):
    d = ROOT / 'asm' / 'nonmatchings' / sub
    if not d.is_dir():
        continue
    for f in d.glob('*.s'):
        oracle.setdefault(f.stem, set()).add(sub)
print(f"oracle names: {len(oracle)}")

# ---------- 2. compile every recon TU, collect defined symbols ----------
tus = sorted(list(ROOT.glob('recon/**/*.c')) + list(ROOT.glob('recon/**/*.cpp')))
print(f"recon TUs: {len(tus)}")

defined = {}   # symbol name -> list of (tu_relpath)
compile_fail = []
compile_ok = []

for src in tus:
    rel = src.relative_to(ROOT)
    obj = bld.OUT / (str(rel) + '.o')
    if SKIP_COMPILE and obj.exists():
        pass
    else:
        try:
            if src.suffix == '.c':
                bld.compile_c(src, skip_asm=True)
            else:
                bld.compile_cpp(src)
        except SystemExit as e:
            compile_fail.append((str(rel), str(e)[:300]))
            continue
        except Exception as e:
            compile_fail.append((str(rel), 'EXC:' + str(e)[:300]))
            continue
    if not obj.exists():
        compile_fail.append((str(rel), 'no .o produced'))
        continue
    compile_ok.append(str(rel))
    r = subprocess.run([NM, str(obj)], capture_output=True, text=True)
    for ln in r.stdout.splitlines():
        parts = ln.split()
        if len(parts) < 3:
            continue
        addr, typ, name = parts[0], parts[1], parts[2]
        if typ in ('U',):
            continue
        defined.setdefault(name, []).append(str(rel))

print(f"compiled OK: {len(compile_ok)}  FAILED: {len(compile_fail)}")
print(f"total distinct defined symbols across tree: {len(defined)}")

# ---------- 3. GNU2-mangling-aware split: (funcname, classname) -> param/return sig ----------
# separator = first "__" whose tail starts F (free fn) / C (const member) / Q<n> (qualified
# class) / a digit (simple class len-prefix). A "near match" for a hidden phantom must share
# BOTH funcname AND classname (two different classes' same-named method, e.g. Draw__14Foo vs
# Draw__11Bar, is NOT a phantom of each other) -- only the trailing param/return encoding may differ.
SEP_RE = re.compile(r'^(.*?)__((?:F|C|Q\d|\d).*)$')

def parse_class(s):
    """s = text right after '__'. Returns (classname_or_None, remaining_sig, is_free)."""
    const = False
    if s.startswith('C') and re.match(r'^C(\d|Q\d)', s):
        const = True
        s = s[1:]
    if s.startswith('F'):
        return None, ('const:' if const else '') + s, True
    if s.startswith('Q'):
        m = re.match(r'^Q(\d)(.*)$', s)
        if not m:
            return None, s, False
        n = int(m.group(1)); rest = m.group(2)
        comps = []
        ok = True
        for _ in range(n):
            m2 = re.match(r'^(\d+)(.*)$', rest)
            if not m2:
                ok = False; break
            ln = int(m2.group(1)); rest = m2.group(2)
            comps.append(rest[:ln]); rest = rest[ln:]
        if not ok:
            return None, s, False
        classname = '::'.join(comps)
        return classname, ('const:' if const else '') + rest, False
    m = re.match(r'^(\d+)(.*)$', s)
    if m:
        ln = int(m.group(1)); rest = m.group(2)
        classname = rest[:ln]; rest = rest[ln:]
        return classname, ('const:' if const else '') + rest, False
    return None, s, False

def split_name(n):
    m = SEP_RE.match(n)
    if not m:
        return n, None, None  # unmangled C name / no signature encoding
    fname, tail = m.group(1), m.group(2)
    classname, sig, is_free = parse_class(tail)
    return fname, classname, sig

# index all defined symbols by (funcname, classname)
by_key = {}
for name in defined:
    fname, classname, sig = split_name(name)
    by_key.setdefault((fname, classname), []).append((name, sig))

# ---------- 4. classify each oracle name ----------
exact = []
phantom = []   # (oracle_name, near_matches[list of defined names], sources)
unmatched = []

for name, sources in sorted(oracle.items()):
    if name in defined:
        exact.append(name)
        continue
    fname, classname, sig = split_name(name)
    candidates = by_key.get((fname, classname), [])
    # near match = same (funcname, classname), some defined symbol with a DIFFERENT sig
    near = [c[0] for c in candidates if c[0] != name]
    if near:
        phantom.append((name, near, sorted(sources)))
    else:
        unmatched.append((name, sorted(sources)))

print(f"exact-matched: {len(exact)}")
print(f"near-matched (HIDDEN PHANTOMS): {len(phantom)}")
print(f"unmatched (ownership/missing gap): {len(unmatched)}")

out = ROOT / 'scratch' / 'phantom_report.txt'
with out.open('w') as f:
    f.write(f"oracle names: {len(oracle)}\n")
    f.write(f"recon TUs: {len(tus)}  compiled OK: {len(compile_ok)}  FAILED: {len(compile_fail)}\n")
    f.write(f"defined symbols (union): {len(defined)}\n")
    f.write(f"exact-matched: {len(exact)}\n")
    f.write(f"near-matched (HIDDEN PHANTOMS): {len(phantom)}\n")
    f.write(f"unmatched (ownership/missing gap): {len(unmatched)}\n")
    f.write("\n=== COMPILE FAILURES ===\n")
    for rel, err in compile_fail:
        f.write(f"{rel}: {err}\n")
    f.write("\n=== HIDDEN PHANTOMS (near match, different signature) ===\n")
    for name, near, sources in phantom:
        f.write(f"ORACLE {name}  [{','.join(sources)}]\n")
        for n in near:
            f.write(f"    near: {n}  (defined in: {', '.join(defined[n])})\n")
    f.write("\n=== UNMATCHED (no exact, no near — ownership/missing gap) ===\n")
    for name, sources in unmatched:
        f.write(f"{name}  [{','.join(sources)}]\n")

print(f"\nfull report -> {out}")
