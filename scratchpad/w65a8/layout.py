#!/usr/bin/env python3
"""W62-A19 layout auditor -- the four censuses.

  1  TEXT ORDER MAP     per-object [min,max] retail text VA, sorted spine,
                        overlaps, gaps, coverage
  2  DATA/BSS LAYOUT    per-object data-ish symbol ORDER + SIZE vs retail
  3  -G / SDATA         per-object gp-relative assignment (ours vs oracle)
  4  COMMON census      linker-allocated blocks (no fixed VA at link time)

Read-only.  Usage: python scratchpad/w62a19/layout.py [section]
"""
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
MAP = Path(r"C:\Temp\nfs4-clean\NFS4.MAP")

# ---- retail section bands (from NFS4.MAP group table) --------------------
BANDS = [
    ("front.rdata", 0x80010000, 0x800128EF),
    ("front.text",  0x800128F0, 0x8005125F),
    ("front.data",  0x80051260, 0x80052B37),
    ("front.bss",   0x80052B38, 0x80054547),
    ("main.rdata",  0x80054548, 0x8005797B),
    ("main.text",   0x8005797C, 0x8010CCD3),
    ("main.data",   0x8010CCD4, 0x8013C54B),
    ("main.sdata",  0x8013C54C, 0x8013DD7B),
    ("main.sbss",   0x8013DD7C, 0x8013DEDF),
    ("main.bss",    0x8013DEE0, 0x80148B03),
]


def band(va):
    for n, lo, hi in BANDS:
        if lo <= va <= hi:
            return n
    return "?"


TEXTBANDS = ("front.text", "main.text")
GPBANDS = ("main.sdata", "main.sbss")

# ---- retail symbol table -------------------------------------------------
vas, dup = {}, set()
for ln in open(ROOT / "configs" / "symbol_addrs.txt", encoding="utf-8",
               errors="replace"):
    m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);", ln)
    if m:
        n, v = m.group(1), int(m.group(2), 16)
        if n in vas and vas[n] != v:
            dup.add(n)
        vas.setdefault(n, v)
DUPN = len(dup)
for n in dup:
    del vas[n]

# retail address-order table -> next-symbol deltas (retail "sizes")
mapva = {}
lines = open(MAP, errors="replace").read().splitlines()
start = next(i for i, l in enumerate(lines) if "address order" in l)
for l in lines[start + 1:]:
    m = re.match(r"^\s*([0-9A-Fa-f]{8})\s+(\S+)\s*$", l)
    if m:
        va = int(m.group(1), 16)
        if 0x80010000 <= va <= 0x80148B04:
            mapva.setdefault(va, m.group(2))
sortedva = sorted(mapva)
nextva = {v: (sortedva[i + 1] if i + 1 < len(sortedva) else None)
          for i, v in enumerate(sortedva)}

objdata = json.load(open(HERE / "objdata.json"))

DATASECS = (".data", ".sdata", ".rodata", ".bss", ".sbss")

# ---- per object ----------------------------------------------------------
objs = {}
for o, d in objdata.items():
    rec = {"text": [], "data": defaultdict(list), "com": [], "und": set(),
           "gprel_refs": set(), "unmatched_text": [], "unmatched_data": []}
    for s in d["syms"]:
        if s["sec"] == "*UND*":
            rec["und"].add(s["name"])
            continue
        if s["sec"] == "*COM*":
            rec["com"].append(s)
            continue
        va = vas.get(s["name"])
        if s["sec"] == ".text":
            if s["size"] == 0 and not s["glob"]:
                continue
            if va is None:
                rec["unmatched_text"].append(s["name"])
            else:
                rec["text"].append((s["off"], va, s["name"], s["size"]))
        elif s["sec"] in DATASECS:
            if va is None:
                rec["unmatched_data"].append((s["sec"], s["name"], s["size"]))
            else:
                rec["data"][s["sec"]].append((s["off"], va, s["name"], s["size"]))
    for r in d["relocs"]:
        if "GPREL16" in r["type"]:
            rec["gprel_refs"].add(re.sub(r"[+-]0x[0-9a-f]+$", "", r["val"]))
    rec["text"].sort()
    objs[o] = rec

sec = sys.argv[1] if len(sys.argv) > 1 else "all"


# =========================================================================
def census_text():
    print("=" * 78)
    print("CENSUS 1 -- OBJECT ORDER MAP (.text)")
    print("=" * 78)
    have = [(o, r) for o, r in objs.items() if r["text"]]
    notext = [o for o, r in objs.items() if not r["text"]]
    print(f"objects total            : {len(objs)}")
    print(f"objects with matched text: {len(have)}")
    print(f"objects with NO text sym : {len(notext)}")
    for o in sorted(notext):
        ut = objs[o]["unmatched_text"]
        print(f"    NOTEXT {o}  (unmatched text syms: {len(ut)}"
              + (f" e.g. {ut[:3]}" if ut else "") + ")")
    print(f"multi-VA names excluded  : {DUPN}")
    unm = sum(len(r['unmatched_text']) for r in objs.values())
    print(f"text syms w/o retail VA  : {unm}")

    rows = []
    for o, r in have:
        lo = min(t[1] for t in r["text"])
        hiend = max(t[1] + t[3] for t in r["text"])
        span_ours = max(t[0] + t[3] for t in r["text"]) - min(t[0] for t in r["text"])
        rows.append({"obj": o, "lo": lo, "hi": hiend, "n": len(r["text"]),
                     "retail_span": hiend - lo, "our_span": span_ours,
                     "band": band(lo),
                     "bands": sorted({band(t[1]) for t in r["text"]})})
    rows.sort(key=lambda x: x["lo"])

    # inversions inside an object (recomputed here, independent of tu_order_audit)
    inv = 0
    invobjs = set()
    for o, r in have:
        last = -1
        for off, va, name, size in r["text"]:
            if va < last:
                inv += 1
                invobjs.add(o)
            else:
                last = va
    print(f"intra-object inversions  : {inv} in {len(invobjs)} objects")

    # overlaps
    ovl = []
    for i in range(len(rows) - 1):
        a, b = rows[i], rows[i + 1]
        if b["lo"] < a["hi"]:
            ovl.append((a, b))
    print(f"object range OVERLAPS    : {len(ovl)}")
    for a, b in ovl:
        print(f"    OVERLAP {a['obj']} [{a['lo']:#x},{a['hi']:#x}) "
              f"vs {b['obj']} [{b['lo']:#x},{b['hi']:#x})")

    # multi-band objects (text split across front/main = impossible in one obj)
    mb = [r for r in rows if len(r["bands"]) > 1]
    print(f"objects spanning >1 band : {len(mb)}")
    for r in mb:
        print(f"    MULTIBAND {r['obj']} {r['bands']}")

    # gaps vs retail text
    gaps = []
    for bn, lo, hi in BANDS:
        if bn not in TEXTBANDS:
            continue
        cur = lo
        for r in rows:
            if r["band"] != bn:
                continue
            if r["lo"] > cur:
                gaps.append((bn, cur, r["lo"]))
            cur = max(cur, r["hi"])
        if cur <= hi:
            gaps.append((bn, cur, hi + 1))
    tot = sum(g[2] - g[1] for g in gaps)
    print(f"gaps in retail .text     : {len(gaps)} holes, {tot:#x} bytes "
          f"({tot} dec)")
    for bn, a, b in sorted(gaps, key=lambda g: g[1] - g[2])[:25]:
        print(f"    GAP {bn} [{a:#x},{b:#x})  {b-a:#x} bytes  "
              f"first-retail-sym-in-gap={mapva.get(next((v for v in sortedva if a <= v < b), 0), '-')}")

    # coverage of retail funcs
    allfn = {n: v for n, v in vas.items() if band(v) in TEXTBANDS}
    covered = set()
    for o, r in have:
        covered |= {t[2] for t in r["text"]}
    miss = sorted(set(allfn) - covered, key=lambda n: allfn[n])
    print(f"retail text symbols      : {len(allfn)}")
    print(f"covered by a recon obj   : {len(covered & set(allfn))}")
    print(f"NOT covered              : {len(miss)}")

    with open(HERE / "spine.txt", "w") as f:
        f.write("# W62-A19 ordered object spine (retail link order, .text)\n")
        f.write("# idx  lo         hi(end)    nfn  retail_span  our_span  band  object\n")
        for i, r in enumerate(rows):
            f.write(f"{i:4d}  {r['lo']:#010x} {r['hi']:#010x} {r['n']:4d} "
                    f"{r['retail_span']:#8x} {r['our_span']:#8x}  {r['band']:<11s} {r['obj']}\n")
    with open(HERE / "uncovered_text.txt", "w") as f:
        for n in miss:
            f.write(f"{allfn[n]:#010x} {n}\n")
    print(f"-> spine.txt ({len(rows)} objects), uncovered_text.txt ({len(miss)})")
    return rows


# =========================================================================
def census_data():
    print()
    print("=" * 78)
    print("CENSUS 2 -- DATA/BSS LAYOUT (order + size vs retail)")
    print("=" * 78)
    nsym = defaultdict(int)
    objs_with = set()
    order_bad = []
    size_bad = []
    secmismatch = []
    unmatched = 0
    for o, r in sorted(objs.items()):
        for s, lst in r["data"].items():
            nsym[s] += len(lst)
            objs_with.add(o)
            lst = sorted(lst)
            last = -1
            for off, va, name, size in lst:
                if va < last:
                    order_bad.append((o, s, name, va))
                else:
                    last = va
                # section-vs-retail-band check
                b = band(va)
                ours_gp = s in (".sdata", ".sbss")
                retail_gp = b in GPBANDS
                if ours_gp != retail_gp:
                    secmismatch.append((o, s, name, va, b))
                # size check vs retail next-symbol delta
                nv = nextva.get(va)
                if nv and size:
                    delta = nv - va
                    if delta != size:
                        size_bad.append((o, s, name, va, size, delta))
        unmatched += len(r["unmatched_data"])
    print("our data-ish symbols by section:")
    for s in DATASECS:
        print(f"    {s:<9s} {nsym[s]:5d}")
    print(f"objects carrying data    : {len(objs_with)}")
    print(f"data syms w/o retail VA  : {unmatched}  (local statics / splat D_ names)")
    print(f"ORDER divergences        : {len(order_bad)} "
          f"in {len({x[0] for x in order_bad})} objects")
    for o, s, n, va in order_bad[:40]:
        print(f"    DATAORDER {o} [{s}] {n} ({va:#x}) after a higher-VA symbol")
    print(f"SECTION-vs-retail-band   : {len(secmismatch)} "
          f"in {len({x[0] for x in secmismatch})} objects")
    for o, s, n, va, b in secmismatch[:40]:
        print(f"    SECMISMATCH {o} ours[{s}] {n} retail {va:#x} in {b}")
    print(f"SIZE != retail delta     : {len(size_bad)} "
          f"in {len({x[0] for x in size_bad})} objects")
    with open(HERE / "data_defects.txt", "w") as f:
        f.write("# ORDER divergences\n")
        for o, s, n, va in order_bad:
            f.write(f"ORDER {o} {s} {n} {va:#x}\n")
        f.write("# SECTION-band mismatches (ours vs retail sdata/sbss band)\n")
        for o, s, n, va, b in secmismatch:
            f.write(f"SEC {o} ours={s} {n} {va:#x} retail_band={b}\n")
        f.write("# SIZE mismatches: obj sec name va oursize retaildelta\n")
        for row in size_bad:
            f.write("SIZE %s %s %s %#x %d %d\n" % row)
    print("-> data_defects.txt")
    return order_bad, secmismatch, size_bad


# =========================================================================
def census_gp():
    print()
    print("=" * 78)
    print("CENSUS 3 -- -G / SDATA ASSIGNMENT")
    print("=" * 78)
    # retail gp-rel reference set, per function, from the oracle .s
    gpref = defaultdict(set)          # function name -> {sym}
    nfiles = 0
    for p in (ROOT / "asm" / "nonmatchings").rglob("*.s"):
        nfiles += 1
        txt = p.read_text(errors="replace")
        syms = set(re.findall(r"%gp_rel\(([^)+]+)", txt))
        if syms:
            gpref[p.stem] |= syms
    allret = set().union(*gpref.values()) if gpref else set()
    print(f"oracle .s files scanned  : {nfiles}")
    print(f"fns using %gp_rel        : {len(gpref)}")
    print(f"distinct retail gp syms  : {len(allret)}")
    cfg = {l.strip() for l in open(ROOT / "configs" / "gp_rel_symbols.txt")
           if l.strip()}
    print(f"configs/gp_rel_symbols   : {len(cfg)}   "
          f"(oracle-only {len(allret - cfg)}, config-only {len(cfg - allret)})")

    # retail-owned gp objects = symbols whose VA is in sdata/sbss band
    ownedgp = {n for n, v in vas.items() if band(v) in GPBANDS}
    print(f"retail syms in sdata/sbss: {len(ownedgp)}")

    rows = []
    tot_ours_def = tot_ours_ref = 0
    missing_ref = defaultdict(set)   # obj -> syms retail reaches gp-rel, we don't
    extra_ref = defaultdict(set)     # obj -> syms we reach gp-rel, retail doesn't
    for o, r in sorted(objs.items()):
        oursdef = {n for s in (".sdata", ".sbss") for _, _, n, _ in r["data"][s]}
        oursref = set(r["gprel_refs"])
        fns = {t[2] for t in r["text"]}
        retref = set().union(*[gpref[f] for f in fns]) if fns else set()
        retref = {s for s in retref if not s.startswith("D_")}
        tot_ours_def += len(oursdef)
        tot_ours_ref += len(oursref)
        miss = {s for s in retref - oursref if s in vas}
        extra = {s for s in oursref - retref if s in vas}
        if miss:
            missing_ref[o] = miss
        if extra:
            extra_ref[o] = extra
        rows.append((o, len(oursdef), len(oursref), len(retref),
                     len(miss), len(extra)))
    print(f"symbols WE define in .sdata/.sbss : {tot_ours_def}")
    print(f"symbols WE reach via GPREL16      : {tot_ours_ref}")
    print(f"objects missing a retail gp-ref   : {len(missing_ref)} "
          f"({sum(len(v) for v in missing_ref.values())} sym-refs)")
    print(f"objects with an EXTRA gp-ref      : {len(extra_ref)} "
          f"({sum(len(v) for v in extra_ref.values())} sym-refs)")
    with open(HERE / "gp_audit.txt", "w") as f:
        f.write("# obj  ours_def ours_ref retail_ref missing extra\n")
        for row in sorted(rows, key=lambda x: -(x[4] + x[5])):
            f.write("%-60s %3d %3d %3d %3d %3d\n" % row)
        f.write("\n# MISSING gp-rel references (retail uses %gp_rel, we do not)\n")
        for o in sorted(missing_ref, key=lambda o: -len(missing_ref[o])):
            f.write(f"MISSING {o}: {' '.join(sorted(missing_ref[o]))}\n")
        f.write("\n# EXTRA gp-rel references (we use gp-rel, retail does not)\n")
        for o in sorted(extra_ref, key=lambda o: -len(extra_ref[o])):
            f.write(f"EXTRA {o}: {' '.join(sorted(extra_ref[o]))}\n")
    print("-> gp_audit.txt")
    # top offenders
    for o in sorted(missing_ref, key=lambda o: -len(missing_ref[o]))[:10]:
        print(f"    MISS {len(missing_ref[o]):3d} {o}")
    for o in sorted(extra_ref, key=lambda o: -len(extra_ref[o]))[:10]:
        print(f"    EXTRA {len(extra_ref[o]):3d} {o}")


# =========================================================================
def census_common():
    print()
    print("=" * 78)
    print("CENSUS 4 -- COMMON blocks (no fixed VA under any linker)")
    print("=" * 78)
    tot = 0
    byobj = []
    known = 0
    for o, r in sorted(objs.items()):
        if r["com"]:
            n = len(r["com"])
            tot += n
            k = sum(1 for s in r["com"] if s["name"] in vas)
            known += k
            byobj.append((o, n, k, sum(s["size"] for s in r["com"])))
    print(f"objects with COMMON syms : {len(byobj)}")
    print(f"COMMON symbols total     : {tot}  (with a retail VA: {known})")
    print(f"COMMON bytes total       : {sum(b[3] for b in byobj):#x}")
    for o, n, k, sz in sorted(byobj, key=lambda x: -x[1])[:15]:
        print(f"    COM {n:4d} (VA-known {k:4d}, {sz:#7x} bytes) {o}")
    with open(HERE / "common_census.txt", "w") as f:
        for o, n, k, sz in sorted(byobj, key=lambda x: -x[1]):
            f.write(f"{n:5d} {k:5d} {sz:#9x} {o}\n")
            for s in sorted(objs[o]["com"], key=lambda s: -s["size"]):
                v = vas.get(s["name"])
                f.write(f"      {s['name']:<44s} size={s['size']:#8x} "
                        f"retail={'%#010x' % v if v else '-':>10s} "
                        f"band={band(v) if v else '-'}\n")
    print("-> common_census.txt")


# =========================================================================
def census_exact():
    """1b/2b -- EXACT LAYOUT: does each object reproduce retail's internal
    spacing?  For every section, (off[i]-off[0]) must equal (va[i]-va[0]).
    A drift here = wrong VAs at link even with a perfect object base."""
    print()
    print("=" * 78)
    print("CENSUS 1b/2b -- EXACT INTERNAL LAYOUT (offset delta vs retail VA delta)")
    print("=" * 78)
    out = open(HERE / "layout_drift.txt", "w")
    stats = {}
    for secname in (".text", ".data", ".sdata", ".rodata", ".bss", ".sbss"):
        ok = bad = skipped = 0
        badobjs = []
        for o, r in sorted(objs.items()):
            if secname == ".text":
                lst = [(off, va, n, sz) for off, va, n, sz in r["text"]]
            else:
                lst = list(r["data"][secname])
            if len(lst) < 2:
                skipped += 1
                continue
            lst.sort(key=lambda t: t[1])          # retail VA order
            off0, va0 = lst[0][0], lst[0][1]
            drift = [(n, (off - off0) - (va - va0))
                     for off, va, n, _ in lst if (off - off0) != (va - va0)]
            if drift:
                bad += 1
                badobjs.append((o, len(drift), len(lst), drift[0]))
                out.write(f"DRIFT {secname} {o}  {len(drift)}/{len(lst)} symbols "
                          f"off-by; first: {drift[0][0]} {drift[0][1]:+#x}\n")
                for n, d in drift:
                    out.write(f"      {n:<50s} {d:+#x}\n")
            else:
                ok += 1
        stats[secname] = (ok, bad, skipped)
        print(f"  {secname:<8s} exact:{ok:4d}  DRIFTING:{bad:4d}  "
              f"(<2 syms, skipped:{skipped})")
        for o, nd, nt, first in sorted(badobjs, key=lambda x: -x[1])[:12]:
            print(f"      DRIFT {nd:3d}/{nt:3d} {o}  first={first[0]} {first[1]:+#x}")
    out.close()
    print("-> layout_drift.txt")
    return stats


# =========================================================================
def census_size():
    """2c -- SIZE census using intra-object next-symbol deltas (ELF st_size is
    0 for 1418/1453 data syms, so the naive size check would be VACUOUS)."""
    print()
    print("=" * 78)
    print("CENSUS 2c -- SYMBOL SIZE (intra-object delta vs retail next-sym delta)")
    print("=" * 78)
    checked = mism = 0
    rows = []
    tail_rows = []
    tail_checked = 0
    for o, r in sorted(objs.items()):
        secs = objdata[o].get("secs", {})
        for secname in (".data", ".sdata", ".rodata", ".bss", ".sbss", ".text"):
            lst = sorted(r["data"][secname], key=lambda t: t[1]) if secname != ".text" \
                else sorted(r["text"], key=lambda t: t[1])
            if not lst:
                continue
            # INTERNAL pairs only: our offset delta vs retail VA delta between
            # two symbols of the SAME object (the last symbol's "size" runs into
            # the NEXT object and is reported separately as a tail row).
            for i in range(len(lst) - 1):
                off, va = lst[i][0], lst[i][1]
                oursz = lst[i + 1][0] - off
                rdelta = lst[i + 1][1] - va
                if oursz <= 0 or rdelta <= 0:
                    continue
                checked += 1
                if oursz != rdelta:
                    mism += 1
                    rows.append((o, secname, lst[i][2], va, oursz, rdelta))
            # tail symbol: our section remainder vs retail distance to the next
            # retail symbol anywhere (inter-object padding question)
            off, va, n, _ = lst[-1]
            oursz = secs.get(secname, 0) - off
            nv = nextva.get(va)
            if nv and oursz > 0:
                tail_checked += 1
                if nv - va != oursz:
                    tail_rows.append((o, secname, n, va, oursz, nv - va))
    print(f"INTERNAL pairs checked   : {checked}")
    print(f"size != retail delta     : {mism} "
          f"in {len({r[0] for r in rows})} objects")
    print(f"TAIL symbols checked     : {tail_checked}")
    print(f"tail size != next-obj gap: {len(tail_rows)} "
          f"in {len({r[0] for r in tail_rows})} objects")
    bysec = defaultdict(int)
    for r in rows:
        bysec[r[1]] += 1
    print("  internal mismatches by section: "
          + " ".join(f"{k}={v}" for k, v in sorted(bysec.items())))
    with open(HERE / "size_defects.txt", "w") as f:
        f.write("# INTERNAL (both symbols in the same object)\n")
        for o, s, n, va, a, b in sorted(rows, key=lambda x: -abs(x[4] - x[5])):
            f.write(f"INT {o} [{s}] {n} @{va:#x} ours={a:#x} retail={b:#x} "
                    f"delta={a-b:+#x}\n")
        f.write("# TAIL (last symbol of the object; gap runs to the next object)\n")
        for o, s, n, va, a, b in sorted(tail_rows, key=lambda x: -abs(x[4] - x[5])):
            f.write(f"TAIL {o} [{s}] {n} @{va:#x} ours={a:#x} retail={b:#x} "
                    f"delta={a-b:+#x}\n")
    for o, s, n, va, a, b in sorted(rows, key=lambda x: -abs(x[4] - x[5]))[:12]:
        print(f"    SIZE {o} [{s}] {n} ours={a:#x} retail={b:#x} ({a-b:+#x})")
    print("-> size_defects.txt")


# =========================================================================
def census_interleave():
    """1c -- CONTIGUITY: walk every retail text symbol in VA order and count
    the RUNS of consecutive symbols owned by the same object.  A correct
    whole-object attribution gives exactly one run per object; extra runs mean
    two objects interleave in retail = the TU boundary is wrong, and NO
    whole-object linker can place them both."""
    print()
    print("=" * 78)
    print("CENSUS 1c -- OBJECT CONTIGUITY IN RETAIL VA ORDER (runs per object)")
    print("=" * 78)
    owner = {}
    for o, r in objs.items():
        for off, va, n, sz in r["text"]:
            owner[va] = (o, n)
    seq = [owner[v] for v in sorted(owner)]
    runs = []
    for o, n in seq:
        if runs and runs[-1][0] == o:
            runs[-1][2] += 1
        else:
            runs.append([o, n, 1])
    per = defaultdict(list)
    for i, (o, first, cnt) in enumerate(runs):
        per[o].append((i, first, cnt))
    multi = {o: v for o, v in per.items() if len(v) > 1}
    print(f"text symbols placed      : {len(seq)}")
    print(f"objects with text        : {len(per)}")
    print(f"runs in retail VA order  : {len(runs)}  "
          f"(perfect = {len(per)}; excess = {len(runs) - len(per)})")
    print(f"objects in >1 run        : {len(multi)}")
    with open(HERE / "interleave.txt", "w") as f:
        for o, v in sorted(multi.items(), key=lambda x: -len(x[1])):
            f.write(f"{o}: {len(v)} runs\n")
            for i, first, cnt in v:
                f.write(f"    run@{i} first={first} n={cnt}\n")
    for o, v in sorted(multi.items(), key=lambda x: -len(x[1]))[:20]:
        print(f"    SPLIT {len(v):3d} runs  {o}")
    print("-> interleave.txt")
    return multi


if sec in ("all", "text"):
    census_text()
if sec in ("all", "inter"):
    census_interleave()
if sec in ("all", "exact"):
    census_exact()
if sec in ("all", "size"):
    census_size()
if sec in ("all", "data"):
    census_data()
if sec in ("all", "gp"):
    census_gp()
if sec in ("all", "com"):
    census_common()
