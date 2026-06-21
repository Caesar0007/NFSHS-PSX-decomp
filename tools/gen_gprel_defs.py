#!/usr/bin/env python3
"""gen_gprel_defs.py [--apply] — add tentative definitions for gp-rel-owned globals.

The dominant frontend/lib near-miss "wall" is a gp-rel addressing gap: the oracle
reaches a small (<=G4) global via `lw $r,%gp_rel(SYM)($gp)` but our build emits
absolute `lui;lw`, because the whole-project import declared the global `extern`-only
(never defined). cc1 then emits `.extern SYM,4` -> absolute. Defining SYM as a
TENTATIVE DEFINITION in its OWNING module makes cc1 emit `.comm SYM,4` -> STOCK
maspsx gp-rels it (methodology section 3.12 #6 + MIPS gp-relative).

OWNERSHIP: a module owns SYM iff its own functions reach SYM via %gp_rel(SYM) in the
oracle. (Non-owner TUs keep `extern SYM` -> absolute, which the oracle also uses
there, so leaving them extern is correct -> per-owner gp-rel == the oracle, no
regression.) This tool maps every %gp_rel(SYM) in the per-function oracles back to
the recon module that DEFINES that function, finds SYMs owned by exactly one module
that are currently extern-only, and proposes/inserts `<type> SYM;` after that module's
includes.

Default = DRY-RUN report. --apply inserts the defs.
"""
import re
import subprocess
import sys
from pathlib import Path
from collections import defaultdict

ROOT = Path(__file__).resolve().parent.parent
OBJD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
APPLY = "--apply" in sys.argv

ASM_DIRS = [ROOT / "asm" / "nonmatchings" / "main", ROOT / "asm" / "nonmatchings" / "front"]

# function -> its oracle .s path
oracle_of = {}
for d in ASM_DIRS:
    for p in d.glob("*.s"):
        oracle_of.setdefault(p.name[:-2], p)

GPREL_RE = re.compile(r"%gp_rel\(([A-Za-z_]\w*)")


def gprel_syms_in(fn):
    p = oracle_of.get(fn)
    if not p:
        return set()
    return set(GPREL_RE.findall(p.read_text()))


# Map each recon module -> the functions it defines (from its built object).
def text_syms(obj):
    r = subprocess.run([OBJD, "-t", str(obj)], capture_output=True, text=True)
    out = []
    for ln in r.stdout.splitlines():
        if re.search(r"\sF\s\.text\s", ln):
            out.append(ln.split()[-1])
    return out


# Build: symbol -> set(modules whose functions gp-rel it); and module -> its fns.
sym_owners = defaultdict(set)
module_fns = {}
for cpp in sorted(ROOT.glob("recon/**/*.cpp")):
    rel = cpp.relative_to(ROOT)
    obj = ROOT / "build" / (str(rel) + ".o")
    if not obj.exists():
        continue
    fns = text_syms(obj)
    module_fns[cpp] = set(fns)
    gp = set()
    for fn in fns:
        gp |= gprel_syms_in(fn)
    for s in gp:
        sym_owners[s].add(cpp)

# A symbol's tentative-def goes in its UNIQUE owner; flag multi-owner (shouldn't happen).
multi = {s: ms for s, ms in sym_owners.items() if len(ms) > 1}


# Pre-index every `extern <type> SYM;` decl across recon headers (pure Python; no
# external grep). gp-rel symbols are <=4 bytes -> scalar or single pointer; skip
# arrays/function-pointers (an array as a whole isn't a gp-rel scalar).
EXTERN_RE = re.compile(
    r'extern\s+(?:"C"\s+)?([A-Za-z_][\w\s\*]*?)\s*\b([A-Za-z_]\w*)\s*;')
extern_type = {}
for hp in list(ROOT.glob("recon/**/*.h")) + list(ROOT.glob("recon/**/*.cpp")):
    for line in hp.read_text(errors="ignore").splitlines():
        s = line.strip()
        if not s.startswith("extern"):
            continue
        # strip trailing comment
        s = re.sub(r"/\*.*", "", s).strip()
        m = EXTERN_RE.match(s)
        if not m:
            continue
        typ, sym = m.group(1).strip(), m.group(2)
        typ = re.sub(r"\s+", " ", typ)
        extern_type.setdefault(sym, f"{typ} {sym};".replace("* ", "*").replace(" *", " *"))


def find_extern_type(sym):
    return extern_type.get(sym)


def already_defined(cpp, sym):
    """True if the module already DEFINES SYM (tentative def or initializer, non-extern)
    or defines it as a function."""
    if sym in module_fns.get(cpp, set()):
        return True
    for line in cpp.read_text(errors="ignore").splitlines():
        s = line.strip()
        if not s or s.startswith(("extern", "//", "*", "/*", "#")):
            continue
        # a non-extern definition: `<type> SYM ;` / `<type> SYM = ...` / `<type> SYM[...]`
        if re.match(rf"[A-Za-z_][\w\s\*]*?\b{re.escape(sym)}\b\s*(=|;|\[)", s):
            return True
    return False


plan = defaultdict(list)   # module -> [def lines]
skipped_multi = []
skipped_notype = []
for sym, owners in sorted(sym_owners.items()):
    if len(owners) != 1:
        skipped_multi.append(sym)
        continue
    cpp = next(iter(owners))
    if sym in module_fns.get(cpp, set()):
        continue  # it's a function this module defines, not a data global
    if already_defined(cpp, sym):
        continue
    deftext = find_extern_type(sym)
    if not deftext:
        skipped_notype.append(sym)
        continue
    plan[cpp].append(deftext)

total_defs = sum(len(v) for v in plan.values())
print(f"modules scanned: {len(module_fns)}")
print(f"gp-rel symbols seen: {len(sym_owners)}  (multi-owner: {len(multi)})")
print(f"tentative-defs to add: {total_defs} across {len(plan)} modules")
print(f"skipped (no clean extern type): {len(skipped_notype)}"
      + (f" e.g. {skipped_notype[:8]}" if skipped_notype else ""))
if multi:
    print(f"MULTI-OWNER (manual review) {len(multi)}: "
          + ", ".join(list(multi)[:10]))
print("\ntop modules by #defs:")
for cpp, defs in sorted(plan.items(), key=lambda kv: -len(kv[1]))[:15]:
    print(f"  {len(defs):3}  {cpp.relative_to(ROOT).as_posix()}")

if not APPLY:
    print("\nDRY-RUN. Re-run with --apply to insert the tentative defs.")
    sys.exit(0)

# ---- APPLY: insert defs after the last #include, per module, COMPILE-CHECKED ----
# (auto-revert any module whose defs break the build — guards type conflicts / dup defs.)
import importlib.util
bspec = importlib.util.spec_from_file_location("bld", ROOT / "tools" / "build.py")
bld = importlib.util.module_from_spec(bspec)
bspec.loader.exec_module(bld)
bld.OUT = bld.BUILD

applied_mods = applied_defs = reverted = 0
for cpp, defs in plan.items():
    orig = cpp.read_text()
    lines = orig.splitlines(keepends=True)
    last_inc = max((i for i, l in enumerate(lines) if l.lstrip().startswith("#include")),
                   default=None)
    if last_inc is None:
        continue
    block = ["\n",
             "/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared\n",
             " * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them\n",
             " * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */\n"]
    block += [d + "\n" for d in sorted(defs)]
    lines[last_inc + 1:last_inc + 1] = block
    cpp.write_text("".join(lines))
    try:
        bld.compile_cpp(cpp)
        applied_mods += 1
        applied_defs += len(defs)
    except SystemExit:
        cpp.write_text(orig)   # defs broke the build -> revert this module
        reverted += 1
        print(f"   REVERTED (compile fail): {cpp.relative_to(ROOT).as_posix()}")
print(f"\nAPPLIED {applied_defs} defs to {applied_mods} modules; reverted {reverted} module(s).")
