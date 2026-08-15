#!/usr/bin/env python3
"""W63-A19  BLOB-vs-TU DATA OWNERSHIP MAP for one splat data blob region.

Model (W62-A18 sec.1.1 + W62-A19 sec.6.3 step 6): ld places WHOLE object
sections, so a recon TU can only take ownership of a retail data run if its
own section places as ONE contiguous window at a consistent implied base.

For every (recon object, section) that defines >=1 label of the blob:
    implied_base = retail_VA(label) - our_section_offset(label)
The window is [base, base + our_section_size).  It is OWNABLE iff

  E1 every blob label in the window that is defined by a recon TU is defined
     by THIS one (no foreign owner inside),
  E2 every blob label this (obj,sec) defines lies INSIDE the window,
  E3 all its labels agree on ONE implied base (no intra-TU data drift),
  E4 base and end are both blob-label BOUNDARIES (the cut is clean),
  E5 the window's RETAIL BYTES equal our section's bytes (zero for .bss/.sbss).

Blob labels named D_<VA> that are interior to the window are SPLAT SYNTHETIC
names for an offset inside the TU's own object (methodology sec.3.12) -- they
are absorbed, not treated as foreign data.

E5 is the anti-vacuity gate: without it "ownership" would be a name-level
claim only, and a wrong-bytes TU would silently corrupt the region.
"""
import argparse
import json
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import blobparse  # noqa: E402

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
FBASE = 0x8000F800
DRX = re.compile(r"^D_[0-9A-Fa-f]{8}$")
DATA_SECS = (".sdata", ".sbss", ".data", ".bss", ".rodata")

# objdump prints "%08lx %c%c%c%c%c%c%c %s\t%08lx %s" -- the 7 flag chars are
# COLUMN-EXACT and the first is a SPACE for undefined syms, so a greedy \s+
# would silently misalign the line.
SYMLINE = re.compile(r"^([0-9a-f]{8}) (.{7}) (\S+)\s+([0-9a-f]{8}) (.*)$")


def dump_objects(objs):
    out = {}
    B = 40
    for i in range(0, len(objs), B):
        batch = objs[i:i + B]
        rel = [str(o.relative_to(ROOT)).replace("\\", "/") for o in batch]
        r = subprocess.run([OBJDUMP, "-t", "-h", "-s", *rel],
                           capture_output=True, text=True, cwd=ROOT)
        cur = mode = None
        secname = None
        for ln in r.stdout.splitlines():
            m = re.match(r"^(\S.*?):\s+file format", ln)
            if m:
                cur = m.group(1).replace("\\", "/")
                out[cur] = {"secs": {}, "syms": [], "bytes": {}}
                mode = None
                continue
            if cur is None:
                continue
            if ln.startswith("Sections:"):
                mode = "sec"
                continue
            if ln.startswith("SYMBOL TABLE:"):
                mode = "sym"
                continue
            if ln.startswith("Contents of section "):
                mode = "hex"
                secname = ln.split("Contents of section ", 1)[1].rstrip(":")
                out[cur]["bytes"].setdefault(secname, bytearray())
                continue
            if mode == "sec":
                m = re.match(r"^\s*\d+\s+(\S+)\s+([0-9a-f]+)\s", ln)
                if m:
                    out[cur]["secs"][m.group(1)] = int(m.group(2), 16)
            elif mode == "sym":
                m = SYMLINE.match(ln)
                if m:
                    out[cur]["syms"].append(
                        (m.group(5).strip(), m.group(3), int(m.group(1), 16),
                         m.group(2)[0] == "g"))
            elif mode == "hex":
                m = re.match(r"^\s([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4})", ln)
                if m:
                    hx = m.group(2).replace(" ", "")
                    out[cur]["bytes"][secname] += bytes.fromhex(hx)
        for o in batch:
            key = str(o.relative_to(ROOT)).replace("\\", "/")
            assert key in out, f"objdump produced no record for {key}"
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", default="asm/data/sdata_8013C54C.sdata.s")
    ap.add_argument("--end", default="0x8013DD7C")
    ap.add_argument("--out", default="scratchpad/w63a19/ownmap_sdata.txt")
    ap.add_argument("--json", default="scratchpad/w63a19/ownmap_sdata.json")
    a = ap.parse_args()

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    nl, header, recs = blobparse.load(ROOT / a.blob, int(a.end, 16))
    by_name = {r["name"]: r for r in recs}
    blob_lo, blob_hi = recs[0]["va"], recs[-1]["end"]
    bounds = {r["va"] for r in recs} | {blob_hi}
    print(f"blob {a.blob}: {len(recs)} labels {blob_lo:#x}..{blob_hi:#x}")

    objs = sorted((ROOT / "build" / "recon").rglob("*.o"))
    data = dump_objects(objs)
    print(f"recon objects dumped: {len(data)}")

    # (obj, sec) -> [(label, offset)] for labels this section defines
    wins = defaultdict(list)
    tu_defined = set()
    for obj, d in data.items():
        for name, sec, off, glob in d["syms"]:
            if name in by_name and sec in DATA_SECS:
                wins[(obj, sec)].append((name, off))
                tu_defined.add(name)
    print(f"blob labels also defined by a recon TU: {len(tu_defined)}")

    # label -> owning (obj,sec) list
    owners = defaultdict(list)
    for k, members in wins.items():
        for name, _ in members:
            owners[name].append(k)

    rows = []
    for (obj, sec), members in wins.items():
        bases = defaultdict(list)
        for name, off in members:
            bases[by_name[name]["va"] - off].append(name)
        base = max(bases.items(), key=lambda kv: len(kv[1]))[0]
        size = data[obj]["secs"].get(sec, 0)
        end = base + size
        inwin = [r for r in recs if base <= r["va"] < end]
        mine = {n for n, _ in members}
        foreign_owned, unmigrated = [], []
        for r in inwin:
            if r["name"] in mine:
                continue
            if r["name"] in tu_defined:
                foreign_owned.append(r["name"])
            elif DRX.match(r["name"]) and r["va"] > base:
                pass                      # splat synthetic interior label
            else:
                unmigrated.append(r["name"])
        outside = [n for n in mine if not (base <= by_name[n]["va"] < end)]
        e3 = len(bases) == 1
        e4 = base in bounds and end in bounds and size > 0
        # E5: retail bytes vs our section bytes
        rb = rom[base - FBASE:end - FBASE]
        ob = bytes(data[obj]["bytes"].get(sec, b""))
        if sec in (".bss", ".sbss"):
            ob = b"\x00" * size
        e5 = (len(ob) == size and rb == ob)
        ok = (not foreign_owned and not unmigrated and not outside
              and e3 and e4 and e5 and inwin)
        rows.append(dict(obj=obj, sec=sec, base=base, end=end, size=size,
                         n=len(members), nbases=len(bases),
                         foreign=foreign_owned, unmig=unmigrated,
                         outside=outside, e3=e3, e4=e4, e5=e5, ok=ok,
                         labels=sorted(mine),
                         inwin=[r["name"] for r in inwin],
                         bytes_ok=e5, bytediff=sum(
                             1 for x, y in zip(rb, ob) if x != y)))

    rows.sort(key=lambda r: (r["base"], r["end"]))
    good = [r for r in rows if r["ok"]]
    # windows must not overlap each other
    good.sort(key=lambda r: r["base"])
    kept, dropped_ov = [], []
    cur = -1
    for r in good:
        if r["base"] < cur:
            dropped_ov.append(r)
            continue
        kept.append(r)
        cur = r["end"]

    L = []
    L.append(f"# W63-A19 blob-vs-TU ownership map   blob={a.blob}")
    L.append(f"# blob labels={len(recs)}  TU-defined={len(tu_defined)}  "
             f"windows={len(rows)}")
    L.append("")
    L.append(f"{'base':>10} {'end':>10} {'size':>6} {'lbl':>4} {'ok':>4}  "
             f"{'sec':<7} object")
    for r in rows:
        L.append(f"{r['base']:#010x} {r['end']:#010x} {r['size']:6d} "
                 f"{r['n']:4d} {'OWN' if r['ok'] else '-':>4}  "
                 f"{r['sec']:<7} {r['obj']}")
        if not r["ok"]:
            if not r["e3"]:
                L.append(f"      E3 {r['nbases']} implied bases (intra-TU data"
                         f" ORDER/SIZE drift)")
            if r["foreign"]:
                L.append(f"      E1 {len(r['foreign'])} labels owned by another"
                         f" TU inside: {r['foreign'][:6]}")
            if r["unmig"]:
                L.append(f"      E1 {len(r['unmig'])} UN-MIGRATED blob labels "
                         f"inside: {r['unmig'][:6]}")
            if r["outside"]:
                L.append(f"      E2 {len(r['outside'])} own labels OUTSIDE: "
                         f"{r['outside'][:6]}")
            if not r["e4"]:
                L.append(f"      E4 window edge is not a blob label boundary")
            if not r["e5"]:
                L.append(f"      E5 BYTES DIFFER from retail ({r['bydiff'] if 'bydiff' in r else r['bytediff']} of {r['size']})")
    L.append("")
    L.append(f"OWNABLE windows            : {len(good)}")
    L.append(f"  ... after overlap pruning: {len(kept)}  "
             f"(dropped {len(dropped_ov)})")
    L.append(f"bytes owned                : {sum(r['size'] for r in kept)} "
             f"of {blob_hi - blob_lo}")
    covered = {n for r in kept for n in r["inwin"]}
    L.append(f"blob labels inside owned windows: {len(covered)}")
    L.append(f"  of which TU-defined      : {len(covered & tu_defined)}")
    L.append(f"  of which splat D_ interior: {len(covered - tu_defined)}")
    L.append(f"TU-defined labels NOT owned: {len(tu_defined - covered)}")
    L.append("")
    L.append("## FAILURE-MODE HISTOGRAM (windows, non-exclusive)")
    for k, lbl in (("e3", "E3 intra-TU drift"), ("e4", "E4 edge not a boundary"),
                   ("e5", "E5 bytes differ")):
        L.append(f"  {lbl:<26} {sum(1 for r in rows if not r[k])}")
    L.append(f"  {'E1 foreign owner inside':<26} "
             f"{sum(1 for r in rows if r['foreign'])}")
    L.append(f"  {'E1 un-migrated inside':<26} "
             f"{sum(1 for r in rows if r['unmig'])}")
    L.append(f"  {'E2 own label outside':<26} "
             f"{sum(1 for r in rows if r['outside'])}")

    (ROOT / a.out).write_text("\n".join(L) + "\n")
    json.dump([{k: v for k, v in r.items()} for r in kept],
              open(ROOT / a.json, "w"), indent=1)
    print("\n".join(L[-22:]))
    print(f"-> {a.out}  /  {a.json}")


if __name__ == "__main__":
    main()
