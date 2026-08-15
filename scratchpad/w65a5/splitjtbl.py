#!/usr/bin/env python3
"""W65-A5  splitjtbl.py -- THE .L LOCALIZE CUT.

Cut a splat rodata blob at its `jtbl_<VA>` record boundaries, emitting

    <stem>_rNN.rodata.s   residual splat bytes            -- linked by BOTH lanes
    <stem>_jNN.rodata.s   ONE whole jump-table record     -- SPLAT LANE ONLY

Every jump-table region is a DUPLICATE of a table the owning recon TU already
emits into its own `.rodata` (scratchpad/w65a5/jtbl_own.txt: 48 of 54 proven
word-for-word at the implied base, the other 6 owned by text-window
containment with a near-miss owner).  Its `.word .L<VA>` operands are src-lane
LOCAL labels that no recon object defines -- which is the whole reason the
recon-lane link carries 350 undefined `.L` names.

Cut granularity is the WHOLE blob record, so both edges are blob-label
boundaries by construction (the E4 leg) and no record ever needs splitting.

Anti-vacuity (asserted every run, never inferred from a count):
  A1 the parser round-trips the control blob byte-identically;
  A2 the concatenation of every emitted segment's lines == the original body,
     and the DATA lines are identical AND in order;
  A3 the segments tile [blob_lo, blob_hi) with no gap and no overlap;
  A4 every cut point is 4-aligned;
  A5 each record's per-line sizes are derived from the NEXT line's VA and sum
     to the record size.

  python scratchpad/w65a5/splitjtbl.py --blob <ctl blob> --end 0xVA \
      --json scratchpad/w65a5/jtbl_own.json [--apply]
"""
import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
import blobparse  # noqa: E402

VA_RE = re.compile(r"/\*\s*([0-9A-Fa-f]+)\s+([0-9A-Fa-f]{8})\s")

BANNER_J = """\
/* ============================================================
 * W65-A5  THE .L LOCALIZE CUT -- SPLAT-LANE FILLER ONLY
 *
 * {name}: the retail jump table of a switch inside
 *     {obj}
 * (retail {base:#010x}..{end:#010x}, {nw} entries).
 *
 * OWNERSHIP PROOF: {proof}
 *
 * The `.word .L<VA>` operands below are the SRC lane's local labels.  The
 * RECON lane must NOT link this file: the recon TU emits this very table into
 * its own `.rodata`, and no recon object defines a `.L<VA>` symbol, so
 * linking it here is exactly the 350-name undefined `.L` class.
 * It stays in the tree so the legacy splat-lane script (linkers/nfs4.ld,
 * which links build/src/**) keeps producing a byte-identical image.
 * ============================================================ */
"""

BANNER_R = """\
/* W65-A5: residual segment of {stem} -- the non-jump-table blob records.
 * Linked by BOTH lanes. */
"""


def line_sizes(rec):
    """[(line_index, va, size)] for the DATA lines of a record (A5)."""
    idx = []
    for i, ln in enumerate(rec["lines"]):
        m = VA_RE.search(ln)
        if m:
            idx.append((i, int(m.group(2), 16)))
    out = []
    for k, (i, va) in enumerate(idx):
        nxt = idx[k + 1][1] if k + 1 < len(idx) else rec["end"]
        out.append((i, va, nxt - va))
    assert not out or out[0][1] == rec["va"], rec["name"]
    assert sum(s for _, _, s in out) == rec["end"] - rec["va"], rec["name"]
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--blob", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--json", required=True)
    ap.add_argument("--dest", default="asm/data")
    ap.add_argument("--apply", action="store_true")
    a = ap.parse_args()

    ctl = ROOT / a.blob
    nl, header, recs = blobparse.load(ctl, int(a.end, 16))
    body = [l for r in recs for l in r["lines"]]
    assert nl.join(header + body) == ctl.read_text(errors="replace"), "A1 lossy"
    for r in recs:
        line_sizes(r)                                                     # A5
    blob_lo, blob_hi = recs[0]["va"], recs[-1]["end"]

    stem = ctl.name.split(".")[0]
    secsuf = ".".join(ctl.name.split(".")[1:])
    sec = "." + secsuf.split(".")[0]

    wins = [w for w in json.load(open(ROOT / a.json))
            if w["blob"].endswith(f"{stem}.{secsuf}")]
    wins.sort(key=lambda w: w["va"])
    assert wins, f"no jtbl windows for {stem}"
    for w in wins:
        assert w["owner"], f"{w['name']} has NO owner -- refusing to cut it"
        assert w["va"] % 4 == 0 and w["end"] % 4 == 0, \
            f"A4 cut not 4-aligned {w['va']:#x}..{w['end']:#x}"

    segs, i = [], 0
    for w in wins:
        pre = []
        while i < len(recs) and recs[i]["va"] < w["va"]:
            pre.append(recs[i]); i += 1
        if pre:
            segs.append(("r", pre, None))
        own = []
        while i < len(recs) and recs[i]["va"] < w["end"]:
            own.append(recs[i]); i += 1
        assert len(own) == 1 and own[0]["name"] == w["name"] \
            and own[0]["va"] == w["va"] and own[0]["end"] == w["end"], \
            f"window {w['name']} is not exactly one blob record"
        segs.append(("j", own, w))
    if i < len(recs):
        segs.append(("r", recs[i:], None))

    cur = blob_lo                                                          # A3
    for _, rs, _ in segs:
        assert rs[0]["va"] == cur, f"A3 gap/overlap at {cur:#x}"
        cur = rs[-1]["end"]
    assert cur == blob_hi, f"A3 end {cur:#x} != {blob_hi:#x}"

    # ---- BOUNDARY ALIGNMENT FIX -----------------------------------------
    # Every `jtbl_` record is preceded by a bare `.align 3` that spimdisasm
    # emitted as the TAIL of the previous record.  In the whole blob it pads
    # nothing (the control object's size == the VA span, asserted below by
    # proofs.py P3), but at the end of a standalone piece whose own size is
    # not 8-aligned it WOULD emit padding and make the concatenation longer
    # than the control.  Carry such trailing directives across to the head of
    # the NEXT segment's body: the global line ORDER is untouched, so A2 still
    # compares the full original stream.
    bodies = [[l for r in rs for l in r["lines"]] for _, rs, _ in segs]
    moved = 0
    for k in range(len(bodies) - 1):
        carry = []
        while bodies[k] and (not bodies[k][-1].strip()
                             or re.match(r"^\s*\.align\b", bodies[k][-1])):
            carry.insert(0, bodies[k].pop())
        if carry:
            bodies[k + 1][0:0] = carry
            moved += sum(1 for c in carry if c.strip())
    print(f"trailing alignment directives carried to the next piece: {moved}")
    for b in bodies:
        assert not re.match(r"^\s*\.align\b", b[-1]), \
            "a piece still ENDS in an alignment directive"

    rebuilt = [l for b in bodies for l in b]                              # A2
    assert rebuilt == body, "A2 line stream changed"
    d_old = [l for l in body if VA_RE.search(l)]
    d_new = [l for l in rebuilt if VA_RE.search(l)]
    assert d_old == d_new, "A2 data lines changed"

    files, ri, ji = [], 0, 0
    for (kind, rs, w), pbody in zip(segs, bodies):
        if kind == "r":
            name = f"{stem}_r{ri:02d}.{secsuf}"; ri += 1
            head = BANNER_R.format(stem=stem)
        else:
            name = f"{stem}_j{ji:02d}.{secsuf}"; ji += 1
            proof = ("word-for-word identical to the owner's own .rodata run "
                     f"at +{w['owner_off']:#x} (E5)" if w["proof"] == "E5" else
                     "the owner's text window CONTAINS every target; its own "
                     "table has drifted because the owning function is a "
                     "near-miss (per-word diff: scratchpad/w65a5/jtbl_diag.txt)")
            head = BANNER_J.format(name=w["name"], obj=w["owner"],
                                   base=w["va"], end=w["end"],
                                   nw=len(w["targets"]), proof=proof)
        txt = nl.join(header[:1] + head.rstrip("\n").split("\n") + header[1:]
                      + pbody)
        files.append((name, txt, kind, rs[0]["va"], rs[-1]["end"], w))
    print(f"{stem}: segments={len(files)}  residual={ri}  jump-table={ji}")
    for n, t, k, lo, hi, w in files:
        print(f"  {n:<38} {lo:#010x}..{hi:#010x} {hi-lo:5d}"
              + (f"  <- {w['owner']} [{w['proof']}]" if w else ""))
    if not a.apply:
        print("\n(dry run; pass --apply to write)")
        return

    dest = ROOT / a.dest
    old = sorted(dest.glob(f"{stem}_[rj][0-9][0-9].{secsuf}"))
    for o in old:
        o.unlink()
    live = dest / ctl.name
    if live.exists():
        live.unlink()
        print(f"removed un-split {live.name}")
    print(f"removed {len(old)} previous pieces")
    for n, t, *_ in files:
        (dest / n).write_text(t, newline="")
    (ROOT / f"scratchpad/w65a5/{stem}_pieces_order.txt").write_text(
        "\n".join(n for n, *_ in files) + "\n")
    print(f"wrote {len(files)} pieces to {a.dest} (section {sec})")


if __name__ == "__main__":
    main()
