#!/usr/bin/env python3
"""W62-A19 LINK PROBE -- prove the .ld regeneration recipe end to end.

Generates a scratchpad-only linker script that places EVERY recon object's
.text at its implied retail base (implied base = retail VA - our offset),
links with GNU ld, dumps the .text image and byte-compares it against
rom/nfs4-f.exe.  Nothing in the repo is modified: the script, the ELF and the
binary all live in scratchpad/w62a19/.
"""
import json
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
LD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-ld.exe"
OBJCOPY = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objcopy.exe"
ROM = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
FBASE = 0x8000F800

vas, dup = {}, set()
for ln in open(ROOT / "configs" / "symbol_addrs.txt", errors="replace"):
    m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func", ln)
    if m:
        n, v = m.group(1), int(m.group(2), 16)
        if n in vas and vas[n] != v:
            dup.add(n)
        vas.setdefault(n, v)
for n in dup:
    del vas[n]

objdata = json.load(open(HERE / "objdata.json"))
rows = []
for o, d in objdata.items():
    tsz = d.get("secs", {}).get(".text", 0)
    if not tsz:
        continue
    bases = defaultdict(int)
    for s in d["syms"]:
        if s["sec"] != ".text":
            continue
        va = vas.get(s["name"])
        if va is None:
            m = re.match(r"(?:func|D|lbl)_([0-9A-Fa-f]{8})$", s["name"])
            if m:
                va = int(m.group(1), 16)
        if va is not None:
            bases[va - s["off"]] += 1
    if bases:
        rows.append((max(bases.items(), key=lambda kv: kv[1])[0], tsz, o))
rows.sort()

# drop objects that would force the location counter backwards (interleavers)
placed, dropped, cur = [], [], 0
for base, sz, o in rows:
    if base < cur:
        dropped.append((base, sz, o))
        continue
    placed.append((base, sz, o))
    cur = base + sz
print(f"objects placed: {len(placed)}   dropped (overlapping): {len(dropped)}")
for b, s, o in dropped:
    print(f"    DROPPED {b:#x} {o}")

lines = ["SECTIONS", "{"]
for i, (base, sz, o) in enumerate(placed):
    lines.append(f"    .t{i:04d} {base:#x} : SUBALIGN(4) {{ {o}(.text) }}")
lines += ["    .other 0x80300000 : { *(.data) *(.sdata) *(.rodata) "
          "*(.bss) *(.sbss) *(COMMON) }",
          "    /DISCARD/ : { *(.pdr) *(.reginfo) *(.MIPS.abiflags) "
          "*(.gnu.attributes) *(.comment) }", "}"]
script = HERE / "probe.ld"
script.write_text("\n".join(lines) + "\n")

cmd = [LD]
for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
    p = ROOT / "linkers" / auto
    if p.exists():
        cmd += ["-T", str(p)]
cmd += ["-T", str(script), "--unresolved-symbols=ignore-all",
        "--allow-multiple-definition",
        "--no-check-sections", "--noinhibit-exec",
        "-Map", str(HERE / "probe.map"), "-o", str(HERE / "probe.elf")]
r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
print(f"[ld] rc={r.returncode}")
if r.stderr:
    errs = r.stderr.strip().splitlines()
    print(f"[ld] {len(errs)} stderr lines; first 10:")
    for e in errs[:10]:
        print("   ", e)
if not (HERE / "probe.elf").exists():
    sys.exit("no ELF produced")

sects = " ".join(f"--only-section=.t{i:04d}" for i in range(len(placed)))
subprocess.run([OBJCOPY, "-O", "binary", *sects.split(),
                str(HERE / "probe.elf"), str(HERE / "probe.bin")], check=True)
img = (HERE / "probe.bin").read_bytes()
start = 0x800128F0
print(f"linked .text image: {len(img)} bytes "
      f"({start:#x}..{start+len(img):#x})")

# byte compare against retail over the placed objects only
totb = okb = 0
per = []
for base, sz, o in placed:
    a = base - start
    ours = img[a:a + sz]
    theirs = ROM[base - FBASE:base - FBASE + sz]
    n = sum(1 for x, y in zip(ours, theirs) if x == y)
    totb += sz
    okb += n
    per.append((sz - n, sz, o))
print(f"bytes compared (placed objects): {totb}")
print(f"bytes identical to retail      : {okb}  ({100.0*okb/totb:.2f}%)")
exact = sum(1 for d, s, o in per if d == 0)
print(f"objects byte-IDENTICAL to retail: {exact}/{len(placed)}")
with open(HERE / "link_probe.txt", "w") as f:
    f.write(f"placed={len(placed)} dropped={len(dropped)} bytes={totb} "
            f"identical={okb} ({100.0*okb/totb:.2f}%) exact_objs={exact}\n")
    for d, s, o in sorted(per, key=lambda x: -x[0]):
        f.write(f"{d:7d}/{s:7d} differing  {o}\n")
print("-> link_probe.txt, probe.ld, probe.map")
