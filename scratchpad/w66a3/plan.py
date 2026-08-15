#!/usr/bin/env python3
"""W66-A3: classify every remaining recon-lane undefined symbol.

For each name:  VA (symbol_addrs -> SYM dump -> @0xVA breadcrumb),
                referencing recon objects (objdump -r, batched),
                whether some asm/data blob already emits that VA
                (label + byte offset inside it), and the BSS/IMAGE split.
Read-only.
"""
import json
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
SYMTXT = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")
BSS_ORG = 0x8013E000

NAMES = sys.argv[1:] or [l.strip() for l in
                         (ROOT / "scratchpad/w66a3/recon_strict_undef.txt")
                         .read_text().splitlines() if l.strip()]


def batched(seq, n):
    for i in range(0, len(seq), n):
        yield seq[i:i + n]


# ---- symbol_addrs -----------------------------------------------------------
sa = {}
for ln in (ROOT / "configs/symbol_addrs.txt").open(errors="replace"):
    m = re.match(r"^(\S+)\s*=\s*(0x[0-9A-Fa-f]+);", ln.strip())
    if m:
        sa.setdefault(m.group(1), int(m.group(2), 16))

# ---- SYM dump: name -> VA (type-2 plain symbols and 8c function starts) ------
symva = {}
if SYMTXT.exists():
    for ln in SYMTXT.open(errors="replace"):
        m = re.search(r"\$([0-9a-fA-F]{8})\s+(\d+)\s+(\S.*)$", ln)
        if not m:
            continue
        va = int(m.group(1), 16)
        rest = m.group(3).strip()
        w = rest.split()
        if w:
            symva.setdefault(w[-1], va)

# ---- blob VA map ------------------------------------------------------------
blob = {}          # VA -> (file, label, offset)
LAB = re.compile(r"^dlabel\s+(\S+)")
WORD = re.compile(r"^\s*/\*\s*[0-9A-Fa-f]+\s+([0-9A-Fa-f]{8})\s")
for f in sorted((ROOT / "asm").rglob("*.s")):
    lab, labva = None, None
    try:
        txt = f.read_text(encoding="latin-1")
    except OSError:
        continue
    if "dlabel" not in txt:
        continue
    for line in txt.splitlines():
        m = LAB.match(line)
        if m:
            lab, labva = m.group(1), None
            continue
        m = WORD.match(line)
        if m:
            va = int(m.group(1), 16)
            if lab and labva is None:
                labva = va
            blob.setdefault(va, (f.name, lab, va - labva if labva else 0))

# ---- referencing recon objects ---------------------------------------------
objs = sorted(o for o in (ROOT / "build" / "recon").rglob("*.o")
              if "diffsrc" not in o.parts and "scratch" not in o.parts)
refs = defaultdict(set)
cur = None
for b in batched(objs, 30):
    r = subprocess.run([OBJDUMP, "-r"] + [str(p.relative_to(ROOT).as_posix())
                                          for p in b],
                       capture_output=True, text=True, cwd=ROOT)
    for ln in r.stdout.splitlines():
        m = re.match(r"^(\S+):\s+file format", ln)
        if m:
            cur = m.group(1).replace("\\", "/")
            continue
        m = re.match(r"^[0-9a-f]{8}\s+R_MIPS_\S+\s+(\S+)", ln)
        if m:
            nm = m.group(1).split("+")[0].split("-")[0]
            if nm in NAMES:
                refs[nm].add(cur)

out = []
for n in NAMES:
    va = sa.get(n) or symva.get(n)
    src = "symbol_addrs" if n in sa else ("SYM" if n in symva else "")
    if va is None:
        for o in sorted(refs[n]):
            p = ROOT / o.split("build/")[-1]
            p = p.with_suffix("") if p.suffix == ".o" else p
            if not p.exists():
                continue
            for line in p.open(encoding="latin-1", errors="replace"):
                if re.search(r"\b" + re.escape(n) + r"\b", line):
                    m = re.search(r"@\s*(0x[0-9A-Fa-f]{8})", line)
                    if m:
                        va, src = int(m.group(1), 16), p.name
                        break
            if va:
                break
    b = blob.get(va) if va else None
    out.append({"sym": n, "va": f"{va:#010x}" if va else None, "va_src": src,
                "kind": (None if va is None else
                         ("BSS" if va >= BSS_ORG else "IMAGE")),
                "blob": b, "refs": sorted(refs[n])})
    print(f"{n:<62} {out[-1]['va'] or '?':>10} {out[-1]['kind'] or '?':<6} "
          f"blob={('%s:%s+%s' % (b[0], b[1], hex(b[2]))) if b else '-'} "
          f"refs={len(refs[n])}")
    for o in sorted(refs[n])[:8]:
        print(f"      {o}")
(ROOT / "scratchpad/w66a3/plan.json").write_text(json.dumps(out, indent=1))
