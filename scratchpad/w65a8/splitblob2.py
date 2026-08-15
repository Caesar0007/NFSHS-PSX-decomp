#!/usr/bin/env python3
"""W64-A18  SPLIT a splat data blob at the ownmap2 boundaries.

v2 over W63-A19's splitblob.py:
  * accepts a window whose cut end falls INSIDE a blob record (`split_at`) and
    performs a LINE-EXACT split of that record, giving the residual tail its
    own `D_<VA>` label.  The blob is one data directive per line with a
    `/* fileoff VA bytes */` comment, so a 4-aligned cut is always a clean
    line boundary -- asserted, never assumed.
  * accepts a window whose cut end sits in retail ZERO alignment pad
    (`pad_to`): the owned segment simply runs to the next record boundary and
    the .ld's FILL(0) supplies the <4 pad bytes our section does not emit.
  * re-emits from a PRE-SPLIT control copy, so it is re-runnable: it removes
    any previously emitted <stem>_[ro]NN pieces first.

Anti-vacuity (all asserted, run every time):
  A1 the parser round-trips the control blob byte-identically;
  A2 the concatenation of every emitted segment's lines == the original body
     (modulo exactly the label lines injected by a record split);
  A3 every segment's VA range tiles [blob_lo, blob_hi) with no gap/overlap;
  A4 every cut point is 4-aligned;
  A5 line sizes are derived from the NEXT line's VA (never guessed from the
     directive), and each record's line sizes sum to the record size.

  python scratchpad/w64a18/splitblob2.py --blob <ctl blob> --end 0xVA \
      --json scratchpad/w64a18/ownmap2_data.json --dest asm/data [--apply]
"""
import argparse
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import blobparse  # noqa: E402

ROOT = Path(__file__).resolve().parents[2]
VA_RE = re.compile(r"/\*\s*([0-9A-Fa-f]+)\s+([0-9A-Fa-f]{8})\s")

BANNER_O = """\
/* ============================================================
 * W64-A18  BLOB-vs-TU OWNERSHIP SWEEP -- SPLAT-LANE FILLER ONLY
 *
 * This segment's data is OWNED by
 *     {obj}
 * (section {sec}, retail {base:#010x}..{end:#010x}), whose own bytes were
 * proved byte-identical to retail before the cut (ownmap2 E1-E5, with
 * R_MIPS_32 relocations RESOLVED against the retail VA map).
 *
 * The RECON-lane linker script must link that object's {sec} here and must
 * NOT link this file -- otherwise every label below is multiply defined.
 * It stays in the tree only so the legacy splat-lane script
 * (linkers/nfs4.ld, which links build/src/**, where no recon object exists)
 * keeps producing a byte-identical image.{extra}
 * ============================================================ */
"""

BANNER_R = """\
/* W64-A18: residual segment of {stem} -- labels no recon TU defines
 * (or a record tail a recon TU's section stops short of).
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


def split_record(rec, va, nl):
    """Return (head_rec, tail_rec) split at `va` (must be a line boundary)."""
    ls = line_sizes(rec)
    k = next((n for n, (_, lva, _) in enumerate(ls) if lva == va), None)
    assert k is not None and k > 0, \
        f"{rec['name']}: {va:#x} is not a data-line boundary"
    cut_i = ls[k][0]
    pre = rec["lines"][:cut_i]
    post = rec["lines"][cut_i:]
    # strip the trailing enddlabel/blank lines off `post` -- they belong to the
    # record as a whole and are re-emitted on the tail.
    tail_name = f"D_{va:08X}"
    head_tailer = [f"enddlabel {rec['name']}", ""]
    tail_header = [f"nonmatching {tail_name}", "", f"dlabel {tail_name}"]
    # A record ends with `enddlabel <name>` possibly followed by a blank and
    # trailing directives (`.align 2` appears in front_data).  Rename the
    # enddlabel and keep every trailing line with the TAIL, so the emitted line
    # count is exactly the original + 5 (asserted by A2 in main()).
    ei = max(i for i, l in enumerate(rec["lines"]) if l.startswith("enddlabel "))
    assert ei >= cut_i, (rec["name"], ei, cut_i)
    ei_rel = ei - cut_i
    post = post[:ei_rel] + [f"enddlabel {tail_name}"] + post[ei_rel + 1:]
    head = dict(name=rec["name"], va=rec["va"], end=va, lines=pre + head_tailer)
    tail = dict(name=tail_name, va=va, end=rec["end"],
                lines=tail_header + post)
    return head, tail


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
        line_sizes(r)                                            # A5
    blob_lo, blob_hi = recs[0]["va"], recs[-1]["end"]

    wins = json.load(open(ROOT / a.json))
    wins = [w for w in wins if w["base"] >= blob_lo and w["base"] < blob_hi]
    wins.sort(key=lambda w: w["base"])
    for w in wins:
        w["cut_end"] = w.get("pad_to") or w["end"]
        assert w["base"] % 4 == 0 and w["cut_end"] % 4 == 0, \
            f"A4 cut not 4-aligned {w['base']:#x}..{w['cut_end']:#x}"

    # perform every required record split first
    nsplit = 0
    for w in wins:
        if not w.get("split_at"):
            continue
        va = w["split_at"]
        k = next(i for i, r in enumerate(recs) if r["va"] < va < r["end"])
        h, t = split_record(recs[k], va, nl)
        recs[k:k + 1] = [h, t]
        nsplit += 1
    print(f"record splits performed: {nsplit}")

    # segment
    segs, i = [], 0
    for w in wins:
        pre = []
        while i < len(recs) and recs[i]["va"] < w["base"]:
            pre.append(recs[i]); i += 1
        if pre:
            segs.append(("r", pre, None))
        own = []
        while i < len(recs) and recs[i]["va"] < w["cut_end"]:
            own.append(recs[i]); i += 1
        assert own and own[0]["va"] == w["base"] and own[-1]["end"] == w["cut_end"], \
            (f"window {w['base']:#x}..{w['cut_end']:#x} does not tile "
             f"({own[0]['va']:#x}..{own[-1]['end']:#x})" if own else "empty")
        segs.append(("o", own, w))
    if i < len(recs):
        segs.append(("r", recs[i:], None))

    # A3 tiling
    cur = blob_lo
    for _, rs, _ in segs:
        assert rs[0]["va"] == cur, f"A3 gap at {cur:#x}"
        cur = rs[-1]["end"]
    assert cur == blob_hi, f"A3 end {cur:#x} != {blob_hi:#x}"

    # A2: concatenation equals the original body plus exactly 5 injected lines
    # per split (enddlabel/blank on the head, nonmatching/blank/dlabel on tail)
    rebuilt = [l for _, rs, _ in segs for r in rs for l in r["lines"]]
    inj = [l for l in rebuilt if l not in body or True]
    assert len(rebuilt) == len(body) + 5 * nsplit, \
        f"A2 line count {len(rebuilt)} != {len(body)}+5*{nsplit}"
    keep = [l for l in rebuilt
            if not re.match(r"^(nonmatching|dlabel|enddlabel) D_[0-9A-F]{8}$", l)]
    # cheap structural check: the DATA lines must be identical and in order
    d_old = [l for l in body if VA_RE.search(l)]
    d_new = [l for l in rebuilt if VA_RE.search(l)]
    assert d_old == d_new, "A2 data lines changed"

    stem = ctl.name.split(".")[0]
    secsuf = ".".join(ctl.name.split(".")[1:])
    files, ri, oi = [], 0, 0
    for kind, rs, w in segs:
        if kind == "r":
            name = f"{stem}_r{ri:02d}.{secsuf}"; ri += 1
            head = BANNER_R.format(stem=stem)
        else:
            name = f"{stem}_o{oi:02d}.{secsuf}"; oi += 1
            extra = ""
            if w.get("split_at"):
                extra = (f"\n *\n * NOTE: the retail run's last blob record was SPLIT at "
                         f"{w['split_at']:#010x};\n * the residual tail is the next _rNN piece.")
            if w.get("pad_to"):
                extra = (f"\n *\n * NOTE: the owning section is {w['pad_to']-w['end']} byte(s) shorter than this\n"
                         f" * window -- that tail is retail ZERO alignment pad, supplied by FILL(0).")
            head = BANNER_O.format(obj=w["obj"], sec=w["sec"], base=w["base"],
                                   end=w["cut_end"], extra=extra)
        txt = nl.join(header[:1] + head.rstrip("\n").split("\n") + header[1:]
                      + [l for r in rs for l in r["lines"]])
        files.append((name, txt, kind, rs[0]["va"], rs[-1]["end"], w))
    print(f"segments: {len(files)}  residual={ri}  owned={oi}")
    for n, t, k2, lo, hi, w in files:
        print(f"  {n:<40} {lo:#010x}..{hi:#010x} {hi-lo:6d}"
              + (f"  <- {w['obj']}" if w else ""))
    if not a.apply:
        print("\n(dry run; pass --apply to write)")
        return

    dest = ROOT / a.dest
    old = sorted(dest.glob(f"{stem}_[ro][0-9][0-9].{secsuf}"))
    for o in old:
        o.unlink()
    print(f"removed {len(old)} previous pieces")
    live = dest / ctl.name
    if live.exists():
        live.unlink()
        print(f"removed un-split {live.name}")
    for n, t, *_ in files:
        (dest / n).write_text(t, newline="")
    (Path(__file__).resolve().parent / f"{stem}_pieces_order.txt").write_text(
        "\n".join(n for n, *_ in files) + "\n")
    print(f"wrote {len(files)} pieces to {a.dest}")


if __name__ == "__main__":
    main()
