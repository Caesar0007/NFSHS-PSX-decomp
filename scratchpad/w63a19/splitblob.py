#!/usr/bin/env python3
"""W63-A19  SPLIT a splat data blob at the TU-ownership boundaries.

Emits one .s per segment of the retail run:
  <stem>_rNN.<sec>.s   RESIDUAL  -- labels no recon TU defines; BOTH lanes link it
  <stem>_oNN.<sec>.s   OWNED     -- the window a recon TU owns; SPLAT LANE ONLY
                                    (the recon-lane .ld links the TU's own
                                     section here instead; see the banner)

Anti-vacuity: the concatenation of every emitted segment's body must be
byte-identical to the original blob body, and every cut point must be 4-aligned
(a mis-aligned cut would let ld insert padding and silently shift the region).

  python splitblob.py --apply
"""
import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import blobparse  # noqa: E402

ROOT = Path(__file__).resolve().parents[2]

BANNER_O = """\
/* ============================================================
 * W63-A19  BLOB-vs-TU OWNERSHIP SWEEP -- SPLAT-LANE FILLER ONLY
 *
 * This segment's data is OWNED by
 *     {obj}
 * (section {sec}, retail {base:#010x}..{end:#010x}), whose own bytes were
 * proved byte-identical to retail before the cut (ownmap.py E5).
 *
 * The RECON-lane linker script must link that object's {sec} here and must
 * NOT link this file -- otherwise every label below is multiply defined.
 * It stays in the tree only so the legacy splat-lane script
 * (linkers/nfs4.ld, which links build/src/**, where no recon object exists)
 * keeps producing a byte-identical .sdata image.
 * ============================================================ */
"""

BANNER_R = """\
/* W63-A19: residual segment of {stem} -- labels no recon TU defines.
 * Linked by BOTH lanes. */
"""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", default="asm/data/sdata_8013C54C.sdata.s")
    ap.add_argument("--end", default="0x8013DD7C")
    ap.add_argument("--json", default="scratchpad/w63a19/ownmap_sdata.json")
    ap.add_argument("--apply", action="store_true")
    a = ap.parse_args()

    blob = ROOT / a.blob
    nl, header, recs = blobparse.load(blob, int(a.end, 16))
    body = [l for r in recs for l in r["lines"]]
    orig = blob.read_text(errors="replace")
    assert nl.join(header + body) == orig, "parser is lossy"

    wins = json.load(open(ROOT / a.json))
    wins.sort(key=lambda w: w["base"])
    for w in wins:
        assert w["base"] % 4 == 0 and w["end"] % 4 == 0, \
            f"cut not 4-aligned: {w['base']:#x}..{w['end']:#x}"
    # segment the record list
    segs, i, k = [], 0, 0
    for w in wins:
        pre = []
        while i < len(recs) and recs[i]["va"] < w["base"]:
            pre.append(recs[i]); i += 1
        if pre:
            segs.append(("r", pre, None))
        own = []
        while i < len(recs) and recs[i]["va"] < w["end"]:
            own.append(recs[i]); i += 1
        assert own and own[0]["va"] == w["base"] and own[-1]["end"] == w["end"], \
            f"window {w['base']:#x} does not tile blob records"
        segs.append(("o", own, w))
    if i < len(recs):
        segs.append(("r", recs[i:], None))

    # anti-vacuity: segments must reconstruct the body exactly
    rebuilt = [l for _, rs, _ in segs for r in rs for l in r["lines"]]
    assert rebuilt == body, "segmentation lost or reordered lines"
    tot = sum(r["end"] - r["va"] for _, rs, _ in segs for r in rs)
    print(f"segments: {len(segs)}  "
          f"residual={sum(1 for t,_,_ in segs if t=='r')}  "
          f"owned={sum(1 for t,_,_ in segs if t=='o')}  bytes={tot}")

    stem = blob.name.split(".")[0]          # sdata_8013C54C
    secsuf = ".".join(blob.name.split(".")[1:])   # sdata.s
    files, ri, oi = [], 0, 0
    for kind, rs, w in segs:
        if kind == "r":
            name = f"{stem}_r{ri:02d}.{secsuf}"; ri += 1
            head = BANNER_R.format(stem=stem)
        else:
            name = f"{stem}_o{oi:02d}.{secsuf}"; oi += 1
            head = BANNER_O.format(obj=w["obj"], sec=w["sec"],
                                   base=w["base"], end=w["end"])
        txt = nl.join(header[:1] + head.rstrip("\n").split("\n")
                      + header[1:] + [l for r in rs for l in r["lines"]])
        files.append((name, txt, kind, rs[0]["va"], rs[-1]["end"], w))
    for n, t, k2, lo, hi, w in files:
        print(f"  {n:<40} {lo:#010x}..{hi:#010x} {hi-lo:6d}"
              + (f"  <- {w['obj']}" if w else ""))

    if not a.apply:
        print("\n(dry run; pass --apply to write)")
        return
    dest = blob.parent
    for n, t, *_ in files:
        (dest / n).write_text(t, newline="")
    blob.unlink()
    order = [n for n, *_ in files]
    (ROOT / "scratchpad/w63a19/sdata_pieces_order.txt").write_text(
        "\n".join(order) + "\n")
    print(f"\nwrote {len(files)} pieces, removed {blob.name}")


if __name__ == "__main__":
    main()
