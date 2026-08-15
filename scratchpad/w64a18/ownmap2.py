#!/usr/bin/env python3
"""W64-A18  OWNMAP v2 -- the W63-A19 E1-E5 ownership model with TWO corrections
that were costing real, byte-provable ownership:

 (A) E5 IS NOW RELOCATION-AWARE.  An `R_MIPS_32` word in our data section holds
     only its ADDEND until link, so its raw bytes can NEVER equal retail's
     linked value.  v1 compared raw bytes and therefore mis-classified every
     pointer-bearing data section as a DATA DEFECT (libcd/cddebug's whole
     160-byte string table; aicop's copGame[] pointers).  v2 resolves each
     R_MIPS_32 against the global name->VA map and compares the RESOLVED word.
     A reloc whose target VA is unknown makes the window UNDECIDABLE (reported
     as E5? -- never silently "owned").  This is a strengthening, not a
     loosening: v1 could also PASS a window whose reloc happened to match.

 (B) E4 ACCEPTS A RECORD-INTERIOR CUT.  The splat blob's label granularity is
     coarser than the object boundary: the retail run's last datum is often
     followed by inter-object ALIGNMENT PAD or an inert SN-LNK linker blob
     (methodology sec.3.9b) that carries no label of its own, so our section's
     end lands strictly inside the last blob RECORD.  v1 called that E4-fail.
     v2 allows the cut when it is 4-ALIGNED and the record it lands in is ours
     or a splat D_ interior label, and REPORTS the split point -- the blob is
     .word-per-line, so the cut is a clean LINE split (splitblob2.py).

Everything else is verbatim W63-A19: implied_base = retail_VA(label) -
our_section_offset(label); window = [base, base+size); E1 no foreign/unmigrated
label inside, E2 no own label outside, E3 one implied base, E5 bytes == retail.

  python scratchpad/w64a18/ownmap2.py --blob <pre-split blob> --end 0xVA
"""
import argparse
import json
import re
import struct
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import blobparse  # noqa: E402
import ownmap  # noqa: E402
import vamap  # noqa: E402

ROOT = Path(__file__).resolve().parents[2]
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
FBASE = 0x8000F800
DRX = re.compile(r"^D_[0-9A-Fa-f]{8}$")
DATA_SECS = (".sdata", ".sbss", ".data", ".bss", ".rodata")
RELHDR = re.compile(r"^RELOCATION RECORDS FOR \[(\S+)\]:")
RELROW = re.compile(r"^([0-9a-f]{8}) (\S+)\s+(.*)$")


def dump_relocs(objs):
    """obj -> section -> [(offset, type, symbol)]"""
    out = {}
    B = 40
    for i in range(0, len(objs), B):
        batch = objs[i:i + B]
        rel = [str(o.relative_to(ROOT)).replace("\\", "/") for o in batch]
        r = subprocess.run([OBJDUMP, "-r", *rel], capture_output=True,
                           text=True, cwd=ROOT)
        cur = sec = None
        for ln in r.stdout.splitlines():
            m = re.match(r"^(\S.*?):\s+file format", ln)
            if m:
                cur = m.group(1).replace("\\", "/")
                out[cur] = defaultdict(list)
                sec = None
                continue
            h = RELHDR.match(ln)
            if h:
                sec = h.group(1)
                continue
            if sec and cur:
                g = RELROW.match(ln)
                if g:
                    out[cur][sec].append(
                        (int(g.group(1), 16), g.group(2), g.group(3).strip()))
        for o in batch:
            key = str(o.relative_to(ROOT)).replace("\\", "/")
            assert key in out, f"objdump -r produced no record for {key}"
    return out


def resolve_e5(rb, ob, sec, relocs, names):
    """Return (ok, undecidable, ndiff, notes).  rb=retail, ob=our raw bytes."""
    if len(ob) != len(rb):
        return False, False, abs(len(ob) - len(rb)), ["size mismatch"]
    ob = bytearray(ob)
    notes = []
    undec = False
    for off, typ, sym in relocs:
        if off + 4 > len(ob):
            continue
        if typ != "R_MIPS_32":
            notes.append(f"non-32 reloc {typ}@{off:#x} {sym}")
            undec = True
            continue
        base = names.get(sym)
        if base is None:
            notes.append(f"unresolved reloc target {sym}@{off:#x}")
            undec = True
            continue
        addend = struct.unpack_from("<I", ob, off)[0]
        struct.pack_into("<I", ob, off, (base + addend) & 0xFFFFFFFF)
    nd = sum(1 for x, y in zip(rb, ob) if x != y)
    return (nd == 0 and not undec), undec, nd, notes


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--json", required=True)
    ap.add_argument("--no-split", action="store_true",
                    help="disable correction (B) -- v1 E4 semantics")
    a = ap.parse_args()

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    nl, header, recs = blobparse.load(ROOT / a.blob, int(a.end, 16))
    by_name = {r["name"]: r for r in recs}
    blob_lo, blob_hi = recs[0]["va"], recs[-1]["end"]
    bounds = {r["va"] for r in recs} | {blob_hi}

    names, _ = vamap.build()
    objs = sorted((ROOT / "build" / "recon").rglob("*.o"))
    data = ownmap.dump_objects(objs)
    rels = dump_relocs(objs)

    wins = defaultdict(list)
    tu_defined = set()
    for obj, d in data.items():
        for name, sec, off, glob in d["syms"]:
            if name in by_name and sec in DATA_SECS:
                wins[(obj, sec)].append((name, off))
                tu_defined.add(name)

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
        foreign, unmig = [], []
        for r in inwin:
            if r["name"] in mine:
                continue
            if r["name"] in tu_defined:
                foreign.append(r["name"])
            elif DRX.match(r["name"]):
                # (C) A splat `D_<VA>` label is a SYNTHETIC name for an offset
                # inside the object -- absorbed wherever it sits, INCLUDING at
                # the window base (v1 required va > base, which blocked every
                # TU whose section starts with un-named data, e.g.
                # genericpmx.cpp's 208 leading bytes = 26 8-byte D_ records).
                # Safe because a D_ name is never TU-defined (the `foreign`
                # test runs first) and because ownership still requires E5:
                # the window's bytes must equal retail's over its WHOLE extent.
                pass
            else:
                unmig.append(r["name"])
        outside = [n for n in mine if not (base <= by_name[n]["va"] < end)]
        e3 = len(bases) == 1

        # ---- E4 with the record-interior cut (correction B) ----
        split_at = None
        pad_to = None
        e4 = base in bounds and end in bounds and size > 0
        if not e4 and size > 0 and base in bounds and not a.no_split:
            host = next((r for r in recs if r["va"] < end < r["end"]), None)
            if host is not None:
                hostok = (host["name"] in mine
                          or (DRX.match(host["name"]) and host["va"] > base))
                nb = min((b for b in bounds if b >= end), default=None)
                if hostok and end % 4 == 0:
                    # B1 RECORD SPLIT: 4-aligned cut inside a record we own /
                    # a splat D_ interior label -- the residual tail stays in
                    # the blob as its own piece.
                    e4 = True
                    split_at = end
                elif (hostok and nb is not None and nb - end < 4
                      and nb % 4 == 0 and nb <= host["end"]
                      and set(rom[end - FBASE:nb - FBASE]) <= {0}):
                    # B2 ALIGNMENT SLACK: our section ends <4 bytes short of the
                    # next boundary and retail's bytes there are ZERO -- that is
                    # inter-object alignment pad, supplied by the .ld's FILL(0).
                    e4 = True
                    pad_to = nb
        # ---- E5, reloc-aware (correction A) ----
        rb = rom[base - FBASE:end - FBASE]
        ob = bytes(data[obj]["bytes"].get(sec, b""))
        if sec in (".bss", ".sbss"):
            ob = b"\x00" * size
            secrel = []
        else:
            secrel = [r for r in rels.get(obj, {}).get(sec, [])
                      if r[0] < size]
        e5, undec, ndiff, notes = resolve_e5(rb, ob, sec, secrel, names)

        ok = (not foreign and not unmig and not outside
              and e3 and e4 and e5 and bool(inwin))
        rows.append(dict(obj=obj, sec=sec, base=base, end=end, size=size,
                         n=len(members), nbases=len(bases), foreign=foreign,
                         unmig=unmig, outside=outside, e3=e3, e4=e4, e5=e5,
                         undec=undec, ndiff=ndiff, notes=notes, ok=ok,
                         split_at=split_at, pad_to=pad_to, nrel=len(secrel),
                         labels=sorted(mine),
                         inwin=[r["name"] for r in inwin]))

    rows.sort(key=lambda r: (r["base"], r["end"]))
    good = sorted([r for r in rows if r["ok"]], key=lambda r: r["base"])
    kept, dropped = [], []
    cur = -1
    for r in good:
        if r["base"] < cur:
            dropped.append(r)
            continue
        kept.append(r)
        cur = r["pad_to"] or r["end"]

    L = [f"# W64-A18 ownmap2 (reloc-aware E5 + record-interior E4)  blob={a.blob}",
         f"# blob labels={len(recs)}  TU-defined={len(tu_defined)}  windows={len(rows)}",
         "",
         f"{'base':>10} {'end':>10} {'size':>6} {'lbl':>4} {'rel':>4} {'ok':>4}  {'sec':<7} object"]
    for r in rows:
        tag = "OWN" if r["ok"] else "-"
        if r["ok"] and r["split_at"]:
            tag = "OWN*"
        if r["ok"] and r["pad_to"]:
            tag = "OWN+"
        L.append(f"{r['base']:#010x} {r['end']:#010x} {r['size']:6d} "
                 f"{r['n']:4d} {r['nrel']:4d} {tag:>4}  {r['sec']:<7} {r['obj']}")
        if r["ok"] and r["split_at"]:
            host = next(x for x in recs if x["va"] < r["split_at"] < x["end"])
            L.append(f"      * cut splits record {host['name']} at "
                     f"{r['split_at']:#010x}; residual "
                     f"{r['split_at']:#x}..{host['end']:#x} "
                     f"({host['end']-r['split_at']} B) stays in the blob")
        if r["ok"] and r["pad_to"]:
            L.append(f"      + window padded {r['end']:#010x}..{r['pad_to']:#010x} "
                     f"({r['pad_to']-r['end']} B of retail ZERO alignment pad, "
                     f"supplied by the .ld FILL(0))")
        if not r["ok"]:
            if not r["e3"]:
                L.append(f"      E3 {r['nbases']} implied bases")
            if r["foreign"]:
                L.append(f"      E1 {len(r['foreign'])} foreign: {r['foreign'][:6]}")
            if r["unmig"]:
                L.append(f"      E1 {len(r['unmig'])} un-migrated: {r['unmig'][:6]}")
            if r["outside"]:
                L.append(f"      E2 {len(r['outside'])} outside: {r['outside'][:6]}")
            if not r["e4"]:
                L.append("      E4 edge not a boundary / not splittable")
            if not r["e5"]:
                if r["undec"]:
                    L.append(f"      E5? UNDECIDABLE ({r['ndiff']} raw diffs): "
                             f"{r['notes'][:3]}")
                else:
                    L.append(f"      E5 BYTES DIFFER ({r['ndiff']} of {r['size']})")
    for r in kept:
        if r["pad_to"]:
            r["cut_end"] = r["pad_to"]
        else:
            r["cut_end"] = r["end"]
    L += ["",
          f"OWNABLE windows            : {len(good)}",
          f"  ... after overlap pruning: {len(kept)}  (dropped {len(dropped)})",
          f"  of which need a record split: {sum(1 for r in kept if r['split_at'])}",
          f"  of which end in alignment pad: {sum(1 for r in kept if r['pad_to'])}",
          f"bytes owned                : {sum(r['cut_end']-r['base'] for r in kept)} of {blob_hi-blob_lo}"]
    covered = {n for r in kept for n in r["inwin"]}
    L += [f"blob labels inside owned windows: {len(covered)}",
          f"  of which TU-defined      : {len(covered & tu_defined)}",
          f"  of which splat D_ interior: {len(covered - tu_defined)}",
          f"TU-defined labels NOT owned: {len(tu_defined - covered)}",
          "",
          "## FAILURE-MODE HISTOGRAM (windows, non-exclusive)"]
    L += [f"  E3 intra-TU drift          {sum(1 for r in rows if not r['e3'])}",
          f"  E4 edge not a boundary     {sum(1 for r in rows if not r['e4'])}",
          f"  E5 bytes differ            {sum(1 for r in rows if not r['e5'] and not r['undec'])}",
          f"  E5? undecidable reloc      {sum(1 for r in rows if r['undec'])}",
          f"  E1 foreign owner inside    {sum(1 for r in rows if r['foreign'])}",
          f"  E1 un-migrated inside      {sum(1 for r in rows if r['unmig'])}",
          f"  E2 own label outside       {sum(1 for r in rows if r['outside'])}"]
    (ROOT / a.out).write_text("\n".join(L) + "\n")
    json.dump(kept, open(ROOT / a.json, "w"), indent=1)
    print("\n".join(L[-24:]))
    print(f"-> {a.out} / {a.json}")


if __name__ == "__main__":
    main()
