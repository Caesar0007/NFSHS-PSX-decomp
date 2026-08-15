#!/usr/bin/env python3
"""W66-A4  rodownmap.py -- THE `.rodata` OWNMAP.

The data twin of tools/ownmap.py for the ONE section ownmap could never reach.

WHY A SEPARATE TOOL.  ownmap.py derives a window's retail base from a BLOB
LABEL the recon object also defines (`implied_base = retail_VA(label) -
our_section_offset(label)`).  A compiler-emitted `.rodata` jump table carries
NO global symbol at all -- it is a local `$L`/`.L` label -- so no recon object
ever defines a `jtbl_<VA>` name and ownmap's anchor step yields ZERO windows
for `.rodata`.  The anchor here is W65-A5's jump-table CONTENT proof instead:

    implied_text_base(obj) = mode over obj's .text symbols of
                             (retail VA of the symbol) - (our section offset)

    every R_MIPS_32 word in obj's own `.rodata` whose target is `.text` holds
    only its ADDEND until link (MIPS REL), so
        resolved VA = implied_text_base(obj) + addend

    a blob region `jtbl_<VA>` holding [t0 .. tN-1] ANCHORS obj's `.rodata` at
        implied_rodata_base = VA - (offset of the matching run in our .rodata)
    iff obj's `.rodata` carries a CONTIGUOUS run of N such resolved words equal
    to that sequence element for element, in order.

Everything after the anchor is verbatim ownmap E1-E5 discipline:

  E1  no foreign / un-migrated blob label inside the window
      (own jtbl regions and splat `D_` interior labels are absorbed)
  E2  every region this object anchors lies inside the window
  E3  ONE implied base -- N independent jump tables in one TU must agree
  E4  both window edges are blob-record boundaries
      (+ ownmap's two relaxations: a 4-aligned record-interior cut, and a
       trailing run of retail ZERO bytes = inter-object alignment pad)
  E5  our bytes, with every relocation RESOLVED, equal retail's over the whole
      window.  A relocation whose target VA we cannot resolve makes the window
      UNDECIDABLE (`E5?`) -- never silently "owned".

Anti-vacuity, asserted every run (the ARG_MAX / empty-output family):
  * objdump is fed in batches, never one glob; an empty batch is a hard assert
    and an object that produced no record is named, never skipped;
  * an object that vanished from build/ under a peer belt between the scan and
    the objdump is REPORTED BY NAME;
  * the blob record set is re-derived from the CUT PIECES and asserted to tile
    each blob span with no gap or overlap;
  * an anchor is only accepted when the whole word sequence matches -- never a
    length or a single word;
  * a run of ZERO anchors reported as such (the tool cannot pass vacuously).

  python scratchpad/w66a4/rodownmap.py [--json OUT] [--txt OUT]
"""
import argparse
import json
import re
import struct
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
FBASE = 0x8000F800
OBJDATA = HERE / "objdata.json"

sys.path.insert(0, str(ROOT / "tools"))
import blobparse  # noqa: E402
import vamap  # noqa: E402

# stem -> (blob base, blob end).  The blobs are CUT into `<stem>_[rj]NN` pieces
# at HEAD (W65-A5); the record set is re-assembled from the pieces so this tool
# stays correct across any future re-cut.
BLOBS = [("rdata_80010000", 0x80010000, 0x800128F0),
         ("rdata_80054548", 0x80054548, 0x8005797C)]

DRX = re.compile(r"^D_[0-9A-Fa-f]{8}$")
DATA_SECS = (".sdata", ".sbss", ".data", ".bss", ".rodata")
SECREL = {".text", ".rodata", ".data", ".sdata", ".bss", ".sbss"}


# --------------------------------------------------------------- blob records
def load_records():
    """Re-assemble each blob's VA-ordered record list from its cut pieces."""
    dataroot = ROOT / "asm" / "data"
    out = {}
    for stem, lo, hi in BLOBS:
        pieces = sorted(dataroot.glob(f"{stem}_[rj][0-9][0-9].rodata.s"))
        whole = dataroot / f"{stem}.rodata.s"
        srcs = pieces if pieces else ([whole] if whole.exists() else [])
        assert srcs, f"no {stem} blob or pieces in asm/data"
        assert not (pieces and whole.exists()), \
            f"{stem}: whole blob AND pieces both present -- ambiguous"
        recs = []
        for p in srcs:
            _, _, rs = blobparse.parse(p)
            recs += [r for r in rs if r["va"] is not None]
        recs.sort(key=lambda r: r["va"])
        assert all(a["va"] < b["va"] for a, b in zip(recs, recs[1:])), \
            f"{stem}: duplicate/unordered record VAs"
        for a, b in zip(recs, recs[1:]):
            a["end"] = b["va"]
        recs[-1]["end"] = hi
        assert recs[0]["va"] == lo, \
            f"{stem}: first record at {recs[0]['va']:#x}, expected {lo:#x}"
        out[stem] = recs
        print(f"blob {stem}: {len(recs)} records, {lo:#x}..{hi:#x} "
              f"({hi - lo} B), {len(srcs)} source file(s)")
    return out


DOTL_RE = re.compile(r"^\s*/\*[^*]*\*/\s*\.word\s+\.L([0-9A-Fa-f]{8})\s*$")
VA_RE = re.compile(r"/\*\s*([0-9A-Fa-f]+)\s+([0-9A-Fa-f]{8})\s")


def jtbl_targets(rec):
    """[.L target VAs] for a jtbl_ record; asserts the trailing-pad shape."""
    tgts, pad, seen_bad = [], [], False
    for ln in rec["lines"]:
        if ".word" not in ln:
            continue
        m = DOTL_RE.match(ln)
        if m:
            assert not seen_bad, \
                f"{rec['name']}: a .L word FOLLOWS a non-.L word"
            tgts.append(int(m.group(1), 16))
        elif VA_RE.search(ln):
            seen_bad = True
            assert re.search(r"\.word\s+0x0+\s*$", ln), \
                f"{rec['name']}: trailing non-.L word is NOT zero: {ln!r}"
            pad.append(ln.strip())
    return tgts, pad


# ---------------------------------------------------------------- object side
def rodata_bytes(objs):
    out = {}
    B = 30
    for i in range(0, len(objs), B):
        batch = objs[i:i + B]
        assert batch, "empty objdump batch (ARG_MAX/vacuity guard)"
        r = subprocess.run([OBJDUMP, "-s", "-j", ".rodata"] + batch,
                           capture_output=True, text=True, cwd=ROOT)
        cur, acc = None, None
        for ln in r.stdout.splitlines():
            m = re.match(r"^(\S+):\s+file format", ln)
            if m:
                if cur is not None and acc is not None:
                    out[cur] = bytes(acc)
                cur = m.group(1).replace("\\", "/")
                acc = None
                continue
            if ln.startswith("Contents of section .rodata"):
                acc = bytearray()
                continue
            m = re.match(r"^\s*([0-9a-f]{4,8})\s((?:[0-9a-f]{2,8}\s){1,4})", ln)
            if m and acc is not None:
                for grp in m.group(2).split():
                    acc += bytes.fromhex(grp)
        if cur is not None and acc is not None:
            out[cur] = bytes(acc)
    return out


def implied_text_bases(objdata, vas):
    bases = {}
    for o, d in objdata.items():
        b = defaultdict(int)
        for s in d["syms"]:
            if s["sec"] != ".text":
                continue
            va = vas.get(s["name"])
            if va is None:
                m = re.match(r"(?:func|D|lbl)_([0-9A-Fa-f]{8})$", s["name"])
                if m:
                    va = int(m.group(1), 16)
            if va is not None:
                b[va - s["off"]] += 1
        if b:
            bases[o] = max(b.items(), key=lambda kv: kv[1])[0]
    return bases


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--json", default=str(HERE / "rodownmap.json"))
    ap.add_argument("--txt", default=str(HERE / "rodownmap.txt"))
    a = ap.parse_args()

    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    names, _ = vamap.build()
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

    blobs = load_records()
    allrecs = [r for stem, _, _ in BLOBS for r in blobs[stem]]
    allrecs.sort(key=lambda r: r["va"])
    by_name = {r["name"]: r for r in allrecs}
    bounds = set()
    for stem, lo, hi in BLOBS:
        bounds |= {r["va"] for r in blobs[stem]} | {hi}

    objdata = json.load(open(OBJDATA))
    tbases = implied_text_bases(objdata, vas)

    # blob labels that some recon TU DEFINES as a data symbol (ownmap's
    # `tu_defined`): a foreign one of those inside a window kills E1.
    tu_defined = set()
    for o, d in objdata.items():
        for s in d["syms"]:
            if s["name"] in by_name and s["sec"] in DATA_SECS:
                tu_defined.add(s["name"])

    cand = sorted(o for o, d in objdata.items()
                  if o.startswith("build/recon")
                  and d.get("secs", {}).get(".rodata", 0))
    gone = [o for o in cand if not (ROOT / o).exists()]
    if gone:
        print(f"🔴 {len(gone)} object(s) VANISHED from build/ under a peer "
              f"between scan and objdump -- NOT examined: {gone}")
    cand = [o for o in cand if (ROOT / o).exists()]
    print(f"recon objects with a non-empty .rodata: {len(cand)}")
    ro = rodata_bytes(cand)
    missing = [o for o in cand if o not in ro]
    assert not missing, f"objdump produced no .rodata for {missing[:3]}"
    for o in cand:
        assert len(ro[o]) == objdata[o]["secs"][".rodata"], \
            f"{o}: objdump -s gave {len(ro[o])} B, -h says " \
            f"{objdata[o]['secs']['.rodata']}"

    # resolved .text-target word map per object (the anchor material)
    seqs = {}
    for o in cand:
        b = ro[o]
        rec = {}
        if o in tbases:
            for rl in objdata[o]["relocs"]:
                if (rl["sec"] == ".rodata" and rl["type"] == "R_MIPS_32"
                        and rl["val"].split("+")[0].strip() == ".text"):
                    off = rl["off"]
                    if off + 4 <= len(b):
                        rec[off] = tbases[o] + struct.unpack(
                            "<I", b[off:off + 4])[0]
        seqs[o] = rec

    # --------------------------------------------------------------- anchoring
    # ANCHOR 1 -- jump-table CONTENT (W65-A5's proof, generalised to a base).
    regions = [r for r in allrecs if r["name"].startswith("jtbl_")]
    print(f"jtbl regions in the blobs: {len(regions)}")
    anchors = defaultdict(list)          # obj -> [(base, region, off)]
    region_owner = {}
    for reg in regions:
        t, pad = jtbl_targets(reg)
        reg["targets"], reg["pad"] = t, pad
        if not t:
            continue
        for o in cand:
            r_ = seqs[o]
            offs = sorted(r_)
            hit = None
            for k in range(len(offs) - len(t) + 1):
                run = offs[k:k + len(t)]
                if run[-1] - run[0] != 4 * (len(t) - 1):
                    continue
                if [r_[x] for x in run] == t:
                    hit = run[0]
                    break
            if hit is not None:
                anchors[o].append((reg["va"] - hit, reg, hit))
                region_owner.setdefault(reg["name"], []).append(o)
                break
    nanch = sum(len(v) for v in anchors.values())
    assert nanch, "ZERO jump-table anchors -- refusing a vacuous ownership map"
    print(f"jtbl-anchored regions: {nanch} across {len(anchors)} objects")

    # ANCHOR 2 -- UNIQUE MASKED ROM MATCH.  87 of the 123 objects whose .text
    # relocates against `.rodata` carry NO jump table at all (string literals /
    # const tables), so anchor 1 cannot reach them.  Their `.rodata` content is
    # its own anchor: resolve every relocation we can, WILDCARD the ones we
    # cannot (a self-`.rodata` reloc depends on the base we are solving for),
    # and look for the byte pattern in the ROM.  A UNIQUE 4-aligned hit is
    # simultaneously the anchor AND the E5 byte proof -- by construction the
    # window's bytes equal retail's.  Zero hits = our content is a near-miss;
    # more than one = ambiguous (never used).
    rom_anchor, rom_hits = {}, {}
    for o in cand:
        ob = bytearray(ro[o])
        n = len(ob)
        wild = set()
        for rl in objdata[o]["relocs"]:
            if rl["sec"] != ".rodata":
                continue
            off = rl["off"]
            if off + 4 > n:
                continue
            if rl["type"] != "R_MIPS_32":
                wild.update(range(off, min(off + 4, n)))
                continue
            tgt = rl["val"].split("+")[0].strip()
            b0 = (tbases.get(o) if tgt == ".text" else
                  None if tgt == ".rodata" else names.get(tgt))
            if b0 is None:
                wild.update(range(off, off + 4))
                continue
            ad = struct.unpack_from("<I", ob, off)[0]
            struct.pack_into("<I", ob, off, (b0 + ad) & 0xFFFFFFFF)
        # a distinctive seed = the longest fixed run, preferring non-zero bytes
        best = (0, 0)
        i = 0
        while i < n:
            if i in wild:
                i += 1
                continue
            j = i
            while j < n and j not in wild:
                j += 1
            run = bytes(ob[i:j])
            score = (j - i) + 8 * len(set(run) - {0})
            if score > best[0]:
                best = (score, i, j)
            i = j
        if len(best) < 3 or best[2] - best[1] < 8:
            rom_hits[o] = -1                 # no usable seed
            continue
        _, s0, s1 = best
        seed = bytes(ob[s0:min(s1, s0 + 24)])
        hits, p = [], 0
        while True:
            p = rom.find(seed, p)
            if p < 0:
                break
            b = p - s0
            if b >= 0 and b % 4 == 0 and b + n <= len(rom):
                if all(rom[b + k] == ob[k] for k in range(n) if k not in wild):
                    hits.append(b + FBASE)
            p += 1
        rom_hits[o] = len(hits)
        if len(hits) == 1:
            rom_anchor[o] = hits[0]
    print(f"ROM-matched .rodata (unique)   : {len(rom_anchor)} of {len(cand)}"
          f"  (ambiguous {sum(1 for v in rom_hits.values() if v > 1)},"
          f" no match {sum(1 for v in rom_hits.values() if v == 0)},"
          f" no seed {sum(1 for v in rom_hits.values() if v == -1)})")
    agree, dis = 0, []
    for o in list(anchors):
        if o in rom_anchor:
            cnt = defaultdict(int)
            for b, _, _ in anchors[o]:
                cnt[b] += 1
            b = max(cnt.items(), key=lambda kv: kv[1])[0]
            if rom_anchor[o] == b:
                agree += 1
            else:
                dis.append((o, b, rom_anchor[o]))
    for o, b, rb in dis:
        print(f"  🔴 ANCHOR DISAGREEMENT {o}: jtbl={b:#x} rom={rb:#x} "
              f"(delta {rb - b:+d})")
    print(f"  cross-check where both anchors exist: "
          f"agree={agree} disagree={len(dis)}")
    rom_only = 0
    for o, b in rom_anchor.items():
        if o not in anchors:
            anchors[o] = [(b, None, 0)]
            rom_only += 1
    print(f"objects anchored by ROM match alone: {rom_only}")

    # ANCHOR 3 -- BEST PARTIAL MATCH, for a `.rodata` whose CONTENT is a
    # near-miss (a wrong string, a missing const) so anchor 2's exact test can
    # never fire.  Every fixed run >= 12 bytes with >= 3 distinct non-zero
    # bytes is used as a seed; each ROM occurrence yields a candidate base;
    # the base is accepted only if it is (a) inside a rodata blob span,
    # (b) the UNIQUE best by a >= 8-percentage-point margin, and (c) matches
    # >= 60 % of the comparable bytes.  Every accepted base is reported with
    # its score so a weak one is never mistaken for a proof.
    partial = {}
    span = [(lo, hi) for _, lo, hi in BLOBS]
    for o in cand:
        if o in anchors:
            continue
        ob, n = bytearray(ro[o]), len(ro[o])
        wild = set()
        for rl in objdata[o]["relocs"]:
            if rl["sec"] != ".rodata":
                continue
            off = rl["off"]
            if off + 4 > n:
                continue
            tgt = rl["val"].split("+")[0].strip()
            b0 = (tbases.get(o) if tgt == ".text" else
                  None if tgt == ".rodata" else names.get(tgt))
            if rl["type"] != "R_MIPS_32" or b0 is None:
                wild.update(range(off, min(off + 4, n)))
                continue
            ad = struct.unpack_from("<I", ob, off)[0]
            struct.pack_into("<I", ob, off, (b0 + ad) & 0xFFFFFFFF)
        fixed = [k for k in range(n) if k not in wild]
        if len(fixed) < 12:
            continue
        runs, i = [], 0
        while i < n:
            if i in wild:
                i += 1
                continue
            j = i
            while j < n and j not in wild:
                j += 1
            if j - i >= 12 and len(set(bytes(ob[i:j])) - {0}) >= 3:
                runs.append((i, j))
            i = j
        cands = defaultdict(int)
        for s0, s1 in runs:
            seed = bytes(ob[s0:min(s1, s0 + 20)])
            p = 0
            while True:
                p = rom.find(seed, p)
                if p < 0:
                    break
                b = p - s0
                if b >= 0 and b % 4 == 0 and b + n <= len(rom):
                    cands[b + FBASE] = 0
                p += 1
        scored = []
        for va in cands:
            if not any(lo <= va and va + n <= hi for lo, hi in span):
                continue
            b = va - FBASE
            good = sum(1 for k in fixed if rom[b + k] == ob[k])
            scored.append((good / len(fixed), va, len(fixed) - good))
        scored.sort(reverse=True)
        if not scored:
            continue
        top = scored[0]
        second = scored[1][0] if len(scored) > 1 else 0.0
        if top[0] >= 0.60 and top[0] - second >= 0.08:
            partial[o] = (top[1], top[0], top[2])
    print(f"partial-match anchors accepted: {len(partial)}")
    for o, (va, sc, bad) in sorted(partial.items()):
        print(f"    {va:#010x}  {sc*100:5.1f}%  ({bad} fixed bytes differ)  {o}")
        anchors[o] = [(va, None, 0)]

    # ------------------------------------------------------------ E1..E5 rows
    rows = []
    for o in sorted(anchors):
        ancs = anchors[o]
        basecount = defaultdict(list)
        for base, reg, off in ancs:
            basecount[base].append(reg["name"] if reg is not None else "ROM")
        base = max(basecount.items(), key=lambda kv: len(kv[1]))[0]
        e3 = len(basecount) == 1
        size = objdata[o]["secs"][".rodata"]
        end = base + size
        mine = {reg["name"] for _, reg, _ in ancs if reg is not None}
        inwin = [r for r in allrecs if base <= r["va"] < end]
        foreign, unmig = [], []
        for r in inwin:
            if r["name"] in mine:
                continue
            if r["name"] in tu_defined:
                foreign.append(r["name"])
            elif r["name"] in region_owner and o not in region_owner[r["name"]]:
                foreign.append(r["name"])          # another TU's jump table
            elif DRX.match(r["name"]):
                pass                                # splat interior label
            elif r["name"].startswith("jtbl_"):
                unmig.append(r["name"])             # nobody owns it
            else:
                unmig.append(r["name"])
        outside = [reg["name"] for _, reg, _ in ancs
                   if reg is not None and not (base <= reg["va"] < end)]

        # ---- E4 with ownmap's two relaxations -------------------------------
        split_at = pad_to = None
        e4 = base in bounds and end in bounds and size > 0
        if not e4 and size > 0 and base in bounds:
            host = next((r for r in allrecs if r["va"] < end < r["end"]), None)
            nb = min((b for b in bounds if b >= end), default=None)
            if host is not None:
                hostok = (host["name"] in mine
                          or (DRX.match(host["name"]) and host["va"] > base))
                if hostok and end % 4 == 0:
                    e4, split_at = True, end
            if (not e4 and nb is not None and nb > end
                    and nb - end <= 8 and nb % 4 == 0
                    and set(rom[end - FBASE:nb - FBASE]) <= {0}):
                # trailing retail ZERO run = inter-object alignment pad; the
                # `.ld` supplies it with FILL(0) / the next region's own `. =`.
                e4, pad_to = True, nb

        # ---- E5, relocation-aware ------------------------------------------
        ob = bytearray(ro[o])
        notes, undec = [], False
        for rl in objdata[o]["relocs"]:
            if rl["sec"] != ".rodata":
                continue
            off = rl["off"]
            if off + 4 > len(ob):
                continue
            if rl["type"] != "R_MIPS_32":
                notes.append(f"non-32 reloc {rl['type']}@{off:#x} {rl['val']}")
                undec = True
                continue
            tgt = rl["val"].split("+")[0].strip()
            if tgt == ".text":
                b0 = tbases.get(o)
            elif tgt == ".rodata":
                b0 = base
            elif tgt in names:
                b0 = names[tgt]
            else:
                b0 = None
            if b0 is None:
                notes.append(f"unresolved reloc target {tgt}@{off:#x}")
                undec = True
                continue
            addend = struct.unpack_from("<I", ob, off)[0]
            struct.pack_into("<I", ob, off, (b0 + addend) & 0xFFFFFFFF)
        rb = rom[base - FBASE:end - FBASE]
        ndiff = (abs(len(rb) - len(ob)) if len(rb) != len(ob)
                 else sum(1 for x, y in zip(rb, ob) if x != y))
        e5 = (len(rb) == len(ob)) and ndiff == 0 and not undec

        ok = (e3 and e4 and e5 and not foreign and not unmig and not outside)
        rows.append(dict(obj=o, base=base, end=end, size=size,
                         anchor=("jtbl" if any(r is not None for _, r, _ in ancs)
                                 else "rom"),
                         romhits=rom_hits.get(o, 0),
                         nanchor=len(ancs), nbases=len(basecount),
                         regions=sorted(mine), foreign=foreign, unmig=unmig,
                         outside=outside, e3=e3, e4=e4, e5=e5, undec=undec,
                         ndiff=ndiff, notes=notes[:4], ok=ok,
                         split_at=split_at, pad_to=pad_to,
                         inwin=[r["name"] for r in inwin]))

    rows.sort(key=lambda r: r["base"])
    good = [r for r in rows if r["ok"]]
    kept, dropped, cur = [], [], -1
    for r in good:
        if r["base"] < cur:
            dropped.append(r)
            continue
        kept.append(r)
        cur = r["pad_to"] or r["end"]
    for r in kept:
        r["cut_end"] = r["pad_to"] or r["end"]

    L = ["W66-A4  .rodata OWNMAP  (jump-table-anchored, ownmap E1-E5)", "",
         f"blob records            : {len(allrecs)}",
         f"jtbl regions            : {len(regions)}",
         f"recon .rodata objects   : {len(cand)}",
         f"anchored objects        : {len(anchors)}  ({nanch} regions)",
         f"OWNABLE windows         : {len(good)}",
         f"  after overlap pruning : {len(kept)} (dropped {len(dropped)})",
         f"  needing a record split: {sum(1 for r in kept if r['split_at'])}",
         f"  ending in align pad   : {sum(1 for r in kept if r['pad_to'])}",
         f"bytes owned             : "
         f"{sum(r['cut_end'] - r['base'] for r in kept)}", "",
         f"{'base':>10} {'end':>10} {'size':>6} {'reg':>4} {'ok':>5}  object"]
    for r in rows:
        tag = "OWN" if r["ok"] else "-"
        if r["ok"] and r["split_at"]:
            tag = "OWN*"
        if r["ok"] and r["pad_to"]:
            tag = "OWN+"
        L.append(f"{r['base']:#010x} {r['end']:#010x} {r['size']:6d} "
                 f"{r['nanchor']:4d} {tag:>5}  {r['obj']}")
        L.append(f"        regions: {r['regions']}")
        if r["ok"] and r["pad_to"]:
            L.append(f"      + padded {r['end']:#x}..{r['pad_to']:#x} "
                     f"({r['pad_to'] - r['end']} B retail ZERO align pad)")
        if r["ok"] and r["split_at"]:
            host = next(x for x in allrecs if x["va"] < r["split_at"] < x["end"])
            L.append(f"      * cut splits {host['name']} at {r['split_at']:#x}"
                     f"; residual {host['end'] - r['split_at']} B stays")
        if not r["ok"]:
            if not r["e3"]:
                L.append(f"      E3 {r['nbases']} implied bases -- "
                         f"{ {hex(k): v for k, v in {}.items()} or ''}")
            if r["foreign"]:
                L.append(f"      E1 foreign inside ({len(r['foreign'])}): "
                         f"{r['foreign'][:6]}")
            if r["unmig"]:
                L.append(f"      E1 un-migrated inside ({len(r['unmig'])}): "
                         f"{r['unmig'][:6]}")
            if r["outside"]:
                L.append(f"      E2 own region outside: {r['outside']}")
            if not r["e4"]:
                L.append("      E4 edge not a blob-record boundary")
            if not r["e5"]:
                if r["undec"]:
                    L.append(f"      E5? UNDECIDABLE ({r['ndiff']} raw diffs) "
                             f"{r['notes']}")
                else:
                    L.append(f"      E5 BYTES DIFFER {r['ndiff']} of {r['size']}")
    L += ["", "## FAILURE-MODE HISTOGRAM (non-exclusive)",
          f"  E3 multiple implied bases  {sum(1 for r in rows if not r['e3'])}",
          f"  E4 edge not a boundary     {sum(1 for r in rows if not r['e4'])}",
          f"  E5 bytes differ            "
          f"{sum(1 for r in rows if not r['e5'] and not r['undec'])}",
          f"  E5? undecidable reloc      {sum(1 for r in rows if r['undec'])}",
          f"  E1 foreign inside          {sum(1 for r in rows if r['foreign'])}",
          f"  E1 un-migrated inside      {sum(1 for r in rows if r['unmig'])}",
          f"  E2 own region outside      {sum(1 for r in rows if r['outside'])}"]
    Path(a.txt).write_text("\n".join(L) + "\n")
    json.dump(kept, open(a.json, "w"), indent=1)
    json.dump(rows, open(str(a.json).replace(".json", "_all.json"), "w"),
              indent=1)
    print("\n".join(L[:12]))
    print("\n".join(L[-9:]))
    print(f"-> {a.txt} / {a.json}")


if __name__ == "__main__":
    main()
