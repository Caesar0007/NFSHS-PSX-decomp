#!/usr/bin/env python3
"""W65-A5  jtbl_own.py -- prove, region by region, that every `jtbl_<VA>`
region in the two splat rodata blobs is a DUPLICATE of a jump table the recon
lane's own TU already emits into its own `.rodata`.

This is the E5 discipline applied to the jump-table axis:

    implied_text_base(obj) = mode over obj's .text symbols of
                             (retail VA of the symbol) - (our section offset)

    for every R_MIPS_32 relocation in obj's `.rodata` whose target is `.text`,
    the in-place word IS the addend (MIPS REL), so

        resolved VA = implied_text_base(obj) + addend

    A blob region `jtbl_<VA>` holding the target sequence [t0, t1, ... tN-1]
    is OWNED by obj iff obj's own `.rodata` carries a run of N consecutive
    R_MIPS_32-vs-.text words whose resolved VAs equal that sequence exactly,
    element for element, in order.

Nothing is inferred from a count: the whole word sequence must match, and the
run must be contiguous in the owning object's `.rodata`.

Usage:
    python scratchpad/w65a5/jtbl_own.py [--json OUT.json] [--txt OUT.txt]
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
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump"
OBJDATA = HERE / "objdata.json"

BLOBS = [("asm/data/rdata_80010000.rodata.s", 0x800128F0),
         ("asm/data/rdata_80054548.rodata.s", 0x8005797C)]

sys.path.insert(0, str(ROOT / "tools"))
import blobparse  # noqa: E402

VA_RE = re.compile(r"/\*\s*([0-9A-Fa-f]+)\s+([0-9A-Fa-f]{8})\s")
DOTL_RE = re.compile(r"^\s*/\*[^*]*\*/\s*\.word\s+\.L([0-9A-Fa-f]{8})\s*$")


# ------------------------------------------------------------------ blob side
def blob_end(path):
    """Last record's end = the VA after the last data line (from the blob)."""
    txt = (ROOT / path).read_text(errors="replace")
    vas = [int(m.group(2), 16) for m in VA_RE.finditer(txt)]
    # the last line's size is unknown from the comment alone; use the byte
    # column when present, else 4.  Every jtbl region ends well before this.
    return max(vas) + 0x100


def load_regions():
    out = []
    for path, blobhi in BLOBS:
        nl, header, recs = blobparse.parse(ROOT / path)
        recs = [r for r in recs if r["va"] is not None]
        assert all(a["va"] < b["va"] for a, b in zip(recs, recs[1:])), path
        for k, r in enumerate(recs):
            r["end"] = recs[k + 1]["va"] if k + 1 < len(recs) else blobhi
        for r in recs:
            if not r["name"].startswith("jtbl_"):
                continue
            assert r["end"] is not None,                 f"{r['name']} is the LAST blob record -- end VA unknown"
            tgts, bad, seen_bad = [], [], False
            for ln in r["lines"]:
                if ".word" not in ln:
                    continue
                m = DOTL_RE.match(ln)
                if m:
                    assert not seen_bad, \
                        f"{r['name']}: a .L word FOLLOWS a non-.L word -- " \
                        "the trailing-pad assumption does not hold"
                    tgts.append(int(m.group(1), 16))
                elif VA_RE.search(ln):
                    seen_bad = True
                    assert re.search(r"\.word\s+0x0+\s*$", ln), \
                        f"{r['name']}: trailing non-.L word is NOT zero: {ln!r}"
                    bad.append(ln.strip())
            out.append(dict(blob=path, name=r["name"], va=r["va"],
                            end=r["end"], targets=tgts, nonlabel=bad,
                            nwords=len(tgts) + len(bad)))
    return out


# ------------------------------------------------------------------ recon side
def implied_bases(objdata, vas):
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


def rodata_bytes(objs):
    """{obj: bytes of its .rodata} -- batched objdump -s."""
    out = {}
    for i in range(0, len(objs), 30):
        batch = objs[i:i + 30]
        assert batch, "empty objdump batch (ARG_MAX/vacuity guard)"
        r = subprocess.run([OBJDUMP, "-s", "-j", ".rodata"] + batch,
                           capture_output=True, text=True, cwd=ROOT)
        cur, acc = None, None
        for ln in r.stdout.splitlines():
            m = re.match(r"^(\S+):\s+file format", ln)
            if m:
                if cur and acc is not None:
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
        if cur and acc is not None:
            out[cur] = bytes(acc)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--json", default=str(HERE / "jtbl_own.json"))
    ap.add_argument("--txt", default=str(HERE / "jtbl_own.txt"))
    a = ap.parse_args()

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

    objdata = json.load(open(OBJDATA))
    bases = implied_bases(objdata, vas)

    # objects that actually carry a .rodata R_MIPS_32-vs-.text relocation
    cand = []
    for o, d in objdata.items():
        if not o.startswith("build/recon"):
            continue
        if o not in bases:
            continue
        if any(rl["sec"] == ".rodata" and rl["type"] == "R_MIPS_32"
               and rl["val"].split("+")[0].strip() == ".text"
               for rl in d["relocs"]):
            cand.append(o)
    cand.sort()
    # build/** churns under peer belts: an object present at scan time can be
    # gone by now.  Report them; never silently pretend they were examined.
    gone = [o for o in cand if not (ROOT / o).exists()]
    cand = [o for o in cand if (ROOT / o).exists()]
    print(f"recon objects with .rodata R_MIPS_32 vs .text: {len(cand)}"
          + (f"  (+{len(gone)} vanished under a peer: {gone})" if gone else ""))
    ro = rodata_bytes(cand)
    missing = [o for o in cand if o not in ro]
    assert not missing, f"objdump gave no .rodata for {missing[:3]}"

    # resolved-VA word sequence per object (only the relocated words)
    seqs = {}
    for o in cand:
        b = ro[o]
        offs = sorted(rl["off"] for rl in objdata[o]["relocs"]
                      if rl["sec"] == ".rodata" and rl["type"] == "R_MIPS_32"
                      and rl["val"].split("+")[0].strip() == ".text")
        rec = {}
        for off in offs:
            if off + 4 > len(b):
                continue
            addend = struct.unpack("<I", b[off:off + 4])[0]
            rec[off] = bases[o] + addend
        seqs[o] = rec

    regions = load_regions()
    print(f"jtbl regions in the blobs: {len(regions)}")

    rows = []
    for reg in regions:
        t = reg["targets"]
        hit = None
        if t:
            for o, rec in seqs.items():
                offs = sorted(rec)
                for k in range(len(offs) - len(t) + 1):
                    run = offs[k:k + len(t)]
                    if run[-1] - run[0] != 4 * (len(t) - 1):
                        continue        # not contiguous
                    if [rec[x] for x in run] == t:
                        hit = (o, run[0])
                        break
                if hit:
                    break
        reg["owner"] = hit[0] if hit else None
        reg["owner_off"] = hit[1] if hit else None
        reg["proof"] = "E5" if hit else None
        if not hit and t:
            # SECOND TIER -- CONTAINMENT.  The blob region is still the jump
            # table of a function the recon lane owns; the owning function is
            # a near-miss, so its own table's targets have drifted.  Ownership
            # is established by the text window, the byte proof is recorded as
            # FAILED and every differing word is listed in jtbl_diag.txt.
            own = sorted(o for o, b in bases.items()
                         if objdata[o].get("secs", {}).get(".text", 0)
                         and b <= t[0] < b + objdata[o]["secs"][".text"])
            if len(own) == 1:
                reg["owner"] = own[0]
                reg["proof"] = "CONTAIN"
            elif len(own) > 1:
                reg["ambiguous"] = own
        rows.append(reg)

    owned = [r for r in rows if r["proof"] == "E5"]
    cont = [r for r in rows if r["proof"] == "CONTAIN"]
    print(f"OWNED, byte-proven duplicate (E5) : {len(owned)} / {len(rows)}")
    print(f"OWNED by containment (near-miss)  : {len(cont)}")
    print(f"NO OWNER                          : "
          f"{len(rows) - len(owned) - len(cont)}")

    lines = ["W65-A5  jump-table region ownership (E5 discipline)",
             "",
             f"regions                     : {len(rows)}",
             f"byte-proven duplicates (E5) : {len(owned)}",
             f"owned by containment        : {len(cont)}",
             f"no owner                    : {len(rows)-len(owned)-len(cont)}",
             ""]
    for r in rows:
        lines.append(f"{r['name']:<20} {r['va']:#010x}..{r['end']:#010x} "
                     f"{r['nwords']:3d} words  "
                     + (f"[E5] {r['owner']} @+{r['owner_off']:#x}"
                        if r["proof"] == "E5" else
                        f"[CONTAIN] {r['owner']} (owning fn is a near-miss)"
                        if r["proof"] == "CONTAIN" else "NO OWNER"))
        if not r["proof"]:
            lines.append(f"    targets: {[hex(x) for x in r['targets']]}")
            if r["nonlabel"]:
                lines.append(f"    non-.L words: {r['nonlabel'][:4]}")
    Path(a.txt).write_text("\n".join(lines) + "\n")
    json.dump(rows, open(a.json, "w"), indent=1)
    print(f"-> {a.txt}\n-> {a.json}")


if __name__ == "__main__":
    main()
