#!/usr/bin/env python3
"""W64-A18  Rewrite the blob's piece list in linkers/nfs4.ld (SPLAT lane) and
regenerate linkers/nfs4_recon.<sec>.ldfrag (RECON lane) from a piece order file
plus the ownmap2 window json.

The splat-lane script links EVERY piece (residual + owned filler) so it keeps
producing a byte-identical image; the recon-lane fragment links the residual
pieces plus each owning object's OWN section in place of its _oNN filler.

  python scratchpad/w64a18/relink_ld.py --stem data_8010CCD4 --sec data \
     --order scratchpad/w64a18/data_8010CCD4_pieces_order.txt \
     --json scratchpad/w64a18/ownmap2_data.json [--apply]
"""
import argparse
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

FRAG_HDR = """\
/* linkers/nfs4_recon.{stem}.ldfrag -- W64-A18 (supersedes W63-A19)
 * RECON-lane ordering of the retail run {lo:#010x}..{hi:#010x}.
 * _rNN = residual splat bytes; <obj> = a recon TU that OWNS its window
 * (ownmap2 E1-E5 all green, R_MIPS_32 relocations RESOLVED).  The matching
 * _oNN piece must NOT be linked here -- it is the splat-lane filler for
 * linkers/nfs4.ld only.
 * Regenerate:
 *   python scratchpad/w64a18/ownmap2.py --blob scratchpad/w63a19/ctl_blob/{stem}.{sec}.s --end {end:#010x} \\
 *       --out scratchpad/w64a18/ownmap2_{sec}.txt --json scratchpad/w64a18/ownmap2_{sec}.json
 *   python scratchpad/w64a18/splitblob2.py --blob ... --json ... --apply
 *   python scratchpad/w64a18/relink_ld.py --stem {stem} --sec {sec} ... --apply
 */

"""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--stem", required=True)
    ap.add_argument("--sec", required=True)
    ap.add_argument("--order", required=True)
    ap.add_argument("--json", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--apply", action="store_true")
    a = ap.parse_args()

    order = [l.strip() for l in
             (ROOT / a.order).read_text().splitlines() if l.strip()]
    wins = json.load(open(ROOT / a.json))
    wins = [w for w in wins if w["sec"]]
    wins.sort(key=lambda w: w["base"])
    owned = [n for n in order if re.search(r"_o\d\d\.", n)]
    assert len(owned) == len(wins), (len(owned), len(wins))

    ld = ROOT / "linkers" / "nfs4.ld"
    txt = ld.read_text()
    nlk = "\r\n" if "\r\n" in txt else "\n"
    lines = txt.split(nlk)
    hit = [i for i, l in enumerate(lines) if f"build/asm/data/{a.stem}" in l]
    assert hit, f"no {a.stem} entries in nfs4.ld"
    lo, hi = hit[0], hit[-1]
    assert hi - lo + 1 == len(hit), "blob entries are not contiguous in nfs4.ld"
    indent = re.match(r"^(\s*)", lines[lo]).group(1)
    new = [f"{indent}build/asm/data/{n}.o(.{a.sec});" for n in order]
    print(f"nfs4.ld: replacing {len(hit)} entries at line {lo+1} with {len(new)}")
    lines[lo:hi + 1] = new

    frag = [FRAG_HDR.format(sec=a.sec, stem=a.stem, lo=wins[0]["base"],
                            hi=int(a.end, 16), end=int(a.end, 16))]
    oi = 0
    for n in order:
        if re.search(r"_o\d\d\.", n):
            w = wins[oi]; oi += 1
            ce = w.get("pad_to") or w["end"]
            note = ""
            if w.get("pad_to"):
                note = f"  (+{w['pad_to']-w['end']} B FILL(0) align pad)"
            frag.append(f"    {w['obj']}({w['sec']});   /* {w['base']:#010x}"
                        f"..{ce:#010x}  was {n}{note} */")
        else:
            frag.append(f"    build/asm/data/{n}.o(.{a.sec});")
    fragtxt = "\n".join(frag) + "\n"
    # 🔴 NAME THE FRAGMENT AFTER THE BLOB STEM, NOT THE SECTION.  front_data and
    # data_8010CCD4 are BOTH `.data` runs, so a per-section name silently
    # CLOBBERS the other region's ordering (the fixed-name hazard W63-A19 fixed
    # for the piece-order file, fired again here).
    fp = ROOT / "linkers" / f"nfs4_recon.{a.stem}.ldfrag"
    if not a.apply:
        print("(dry run)")
        print("\n".join(frag[:12]))
        return
    ld.write_text(nlk.join(lines), newline="")
    fp.write_text(fragtxt, newline="")
    print(f"wrote {ld} and {fp}")


if __name__ == "__main__":
    main()
