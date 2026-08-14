#!/usr/bin/env python3
"""w60a1 cross-function-reference classifier.

For every build/recon object, find intra-object CROSS-FUNCTION references, i.e.
references whose encoded bytes (or link-time VA) depend on where the referenced
function sits INSIDE the object:

  A) branch (b/beq/bne/blez/...) whose target offset lands outside the
     enclosing function's [start, start+size) -> the ASSEMBLER already baked a
     16-bit displacement into the word.  Intra-TU order change = DIFFERENT BYTES
     (this is the MSC02 class; it is also the only class a byte gate can see).
  B) j / jal to a label with NO relocation record -> assembler-resolved local
     target, same sensitivity at the 26-bit field.
  C) lui/addiu %hi/%lo or any R_MIPS_* reloc naming another function DEFINED in
     the same object -> ld patches it, so bytes are fine, but the VALUE is the
     other function's VA => wrong VA in a linked image if either moved.

Usage: python xfn.py [objfilter]
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"

BRANCH = re.compile(r"^\s*(b|beq|bne|blez|bgtz|bltz|bgez|beqz|bnez|bgezal|bltzal)(?:\s|$)")

filt = sys.argv[1] if len(sys.argv) > 1 else ""

objs = sorted(o for o in (ROOT / "build" / "recon").rglob("*.o")
              if "diffsrc" not in o.parts and filt in str(o))

for obj in objs:
    # function extents in .text
    r = subprocess.run([OBJDUMP, "-t", str(obj)], capture_output=True, text=True)
    fns = []
    for ln in r.stdout.splitlines():
        m = re.match(r"([0-9a-f]{8})\s+\S*\s+F\s+\.text\s+([0-9a-f]+)\s+(\S+)", ln)
        if m:
            fns.append((int(m.group(1), 16), int(m.group(2), 16), m.group(3)))
    if len(fns) < 2:
        continue
    fns.sort()
    defined = {n for _, _, n in fns}

    def owner(off):
        for s, sz, n in fns:
            if s <= off < s + sz:
                return n
        return None

    r = subprocess.run([OBJDUMP, "-dr", "-j", ".text", str(obj)],
                       capture_output=True, text=True)
    hits = {"A": [], "B": [], "C": []}
    lines = r.stdout.splitlines()
    for i, ln in enumerate(lines):
        m = re.match(r"\s*([0-9a-f]+):\s+([0-9a-f]{8})\s+(.*)$", ln)
        if not m:
            continue
        off = int(m.group(1), 16)
        body = m.group(3).strip()
        src = owner(off)
        if src is None:
            continue
        nxt = lines[i + 1] if i + 1 < len(lines) else ""
        has_reloc = "R_MIPS" in nxt
        tm = re.search(r"\b([0-9a-f]+)\s*<([^>+]+)(\+0x[0-9a-f]+)?>", body)
        if BRANCH.match(body) and tm:
            tgt = int(tm.group(1), 16)
            dst = owner(tgt)
            if dst is not None and dst != src:
                hits["A"].append(f"{src} -> {dst} @0x{off:x}  {body}")
        elif re.match(r"^\s*(j|jal)\s", body) and tm and not has_reloc:
            dst = owner(int(tm.group(1), 16))
            if dst is not None and dst != src:
                hits["B"].append(f"{src} -> {dst} @0x{off:x}  {body}")
        if has_reloc:
            rm = re.search(r"R_MIPS_\S+\s+(\S+)", nxt)
            if rm:
                nm = rm.group(1).split("+")[0]
                if nm in defined and nm != src:
                    hits["C"].append(f"{src} -> {nm} @0x{off:x}  {body}")
    if any(hits.values()):
        rel = obj.relative_to(ROOT).as_posix()
        print(f"== {rel}  A={len(hits['A'])} B={len(hits['B'])} C={len(hits['C'])}")
        for k in "ABC":
            for h in hits[k][:8]:
                print(f"   [{k}] {h}")
