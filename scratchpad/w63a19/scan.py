#!/usr/bin/env python3
"""W62-A19 layout scanner.  Dumps, for every build/recon/**/*.o:
  - every symbol (section, offset, size, binding)
  - every relocation (section, offset, type, target)
into scratchpad/w62a19/objdata.json.  Read-only; no repo file is touched.
Batched objdump calls (xargs-style) per the anti-vacuity/batching rule.
"""
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"
OUT = Path(__file__).resolve().parent / "objdata.json"

objs = sorted(o for o in (ROOT / "build" / "recon").rglob("*.o")
              if "diffsrc" not in o.parts)
print(f"objects found: {len(objs)}")

SYMRE = re.compile(r"^([0-9a-f]{8})\s(.{7})\s+(\S+)\s+([0-9a-f]{8})\s(.*)$")
HDRRE = re.compile(r"^(\S+):\s+file format")
RELHDR = re.compile(r"^RELOCATION RECORDS FOR \[(\S+)\]:")
RELRE = re.compile(r"^([0-9a-f]{8})\s+(\S+)\s+(.*)$")

data = {}


def batches(seq, n):
    for i in range(0, len(seq), n):
        yield seq[i:i + n]


# ---- symbols -------------------------------------------------------------
cur = None
for b in batches(objs, 40):
    r = subprocess.run([OBJDUMP, "-t"] + [str(p) for p in b],
                       capture_output=True, text=True)
    for ln in r.stdout.splitlines():
        m = HDRRE.match(ln)
        if m:
            cur = str(Path(m.group(1)).resolve().relative_to(ROOT)).replace("\\", "/")
            data.setdefault(cur, {"syms": [], "relocs": []})
            continue
        m = SYMRE.match(ln)
        if m and cur:
            val, flags, sec, size, name = m.groups()
            if sec in (".reginfo", ".MIPS.abiflags", ".pdr", ".gnu.attributes",
                       ".comment", ".mdebug.abi32"):
                continue
            if " d " in flags or " df " in flags:
                continue
            data[cur]["syms"].append({
                "off": int(val, 16), "sec": sec, "size": int(size, 16),
                "name": name.strip(),
                "glob": "g" in flags[0:2] or "u" in flags[0:2],
                "flags": flags,
            })

# ---- relocations ---------------------------------------------------------
cur = None
sec = None
for b in batches(objs, 40):
    r = subprocess.run([OBJDUMP, "-r"] + [str(p) for p in b],
                       capture_output=True, text=True)
    for ln in r.stdout.splitlines():
        m = HDRRE.match(ln)
        if m:
            cur = str(Path(m.group(1)).resolve().relative_to(ROOT)).replace("\\", "/")
            data.setdefault(cur, {"syms": [], "relocs": []})
            sec = None
            continue
        m = RELHDR.match(ln)
        if m:
            sec = m.group(1)
            continue
        m = RELRE.match(ln)
        if m and cur and sec and m.group(2).startswith("R_"):
            data[cur]["relocs"].append(
                {"sec": sec, "off": int(m.group(1), 16),
                 "type": m.group(2), "val": m.group(3).strip()})

# ---- section sizes -------------------------------------------------------
SECRE = re.compile(r"^\s*\d+\s+(\S+)\s+([0-9a-f]{8})\s+")
cur = None
for b in batches(objs, 40):
    r = subprocess.run([OBJDUMP, "-h"] + [str(p) for p in b],
                       capture_output=True, text=True)
    for ln in r.stdout.splitlines():
        m = HDRRE.match(ln)
        if m:
            cur = str(Path(m.group(1)).resolve().relative_to(ROOT)).replace("\\", "/")
            data.setdefault(cur, {"syms": [], "relocs": []})
            data[cur].setdefault("secs", {})
            continue
        m = SECRE.match(ln)
        if m and cur:
            data[cur].setdefault("secs", {})[m.group(1)] = int(m.group(2), 16)

json.dump(data, open(OUT, "w"), indent=0)
print(f"wrote {OUT}  objects={len(data)}  "
      f"syms={sum(len(v['syms']) for v in data.values())}  "
      f"relocs={sum(len(v['relocs']) for v in data.values())}")
