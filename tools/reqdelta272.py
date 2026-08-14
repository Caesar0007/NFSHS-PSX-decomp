#!/usr/bin/env python3
"""reqdelta272.py -- price a register-order change on the cc1_272 lane.

The 272 companion to tools/reqdelta.py (which implements the gcc-2.8 rule and
is therefore WRONG here -- see qty272.py's `pri` docstring).  Given a function
and a pseudo that must move UP or DOWN the global.c allocation order relative
to a rival, print the minimal (refs, live) deltas that flip the pair under the
measured 272 priority

    pri = floor_log2(refs) * refs / live_length

and flag the floor_log2 STEP boundaries (powers of two in refs), where one
single extra reference is worth more than any live-length dial.

Usage:
  # show the whole ordered table with each neighbour's flip cost
  python scratchpad/w60a1/reqdelta272.py <recon/....c> <FUNC>
  # price one specific pair
  python scratchpad/w60a1/reqdelta272.py <recon/....c> <FUNC> --flip 74 105
"""
import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import qty272 as Q                                          # noqa: E402


def P(refs, live):
    return Q._floor_log2(max(refs, 1)) * refs / max(live, 1)


def cost_to_beat(r, target, cap_refs=64, cap_live=None):
    """Minimal single-axis dials on `r` to reach pri > target."""
    out = []
    refs, live = r["refs"], max(r["live"], 1)
    for n in range(refs + 1, cap_refs + 1):
        if P(n, live) > target:
            out.append(f"refs {refs}->{n} (+{n-refs}"
                       f"{', CROSSES a floor_log2 step' if Q._floor_log2(n) > Q._floor_log2(refs) else ''})")
            break
    else:
        out.append(f"refs: unreachable <= {cap_refs}")
    lo = cap_live or 1
    for l in range(live - 1, lo - 1, -1):
        if P(refs, l) > target:
            out.append(f"live {live}->{l} (-{live-l})")
            break
    else:
        out.append("live: unreachable")
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("src")
    ap.add_argument("func")
    ap.add_argument("--flip", nargs=2, type=int, metavar=("MOVER", "RIVAL"))
    a = ap.parse_args()

    src = (Q.ROOT / a.src).resolve()
    tmp, i_file, cc1, flags = Q.compile_dumps(src)
    lreg = Q.split_functions(Path(str(i_file) + ".lreg").read_text(errors="replace"))
    greg = Q.split_functions(Path(str(i_file) + ".greg").read_text(errors="replace"))
    if a.func not in greg:
        sys.exit(f"{a.func!r} not in dump")
    regs, homes = Q.parse_lreg(lreg.get(a.func, ""))
    order, conflicts, prefs, disp = Q.parse_greg(greg[a.func])

    if a.flip:
        m, v = a.flip
        for n in (m, v):
            if n not in regs:
                sys.exit(f"pseudo {n} has no flow record")
        pm, pv = P(regs[m]["refs"], regs[m]["live"]), P(regs[v]["refs"], regs[v]["live"])
        print(f"mover {m}: refs={regs[m]['refs']} live={regs[m]['live']} pri={pm:.4f}"
              f"  home={Q.hname(disp.get(m, homes.get(m, -1)))}"
              f"  prefs={','.join(prefs.get(m, [])) or '-'}")
        print(f"rival {v}: refs={regs[v]['refs']} live={regs[v]['live']} pri={pv:.4f}"
              f"  home={Q.hname(disp.get(v, homes.get(v, -1)))}"
              f"  prefs={','.join(prefs.get(v, [])) or '-'}")
        if pm > pv:
            print("mover ALREADY outranks rival")
        else:
            print("to put the mover FIRST: " + "  OR  ".join(cost_to_beat(regs[m], pv)))
        print("to demote the RIVAL instead: " +
              "  OR  ".join(f"live {regs[v]['live']}->{l}"
                            for l in [regs[v]['live'] + 1] if P(regs[v]['refs'], l) < pm) or
              "   (raise the rival's live length until pri < mover)")
        if prefs.get(m):
            print(f"NOTE: mover carries a hard-reg PREFERENCE {prefs[m]} -- find_reg takes it "
                  f"before the numeric scan, so priority alone will not move it.  Kill the "
                  f"copy preference first (opacity fence on the value: an asm_operands def "
                  f"makes global.c's set_preference return early).")
        return

    print(f"== {a.func}  (272 rule: floor_log2(refs)*refs/live)")
    print(f"{'rank':>5}{'pseudo':>8}{'refs':>6}{'live':>6}{'pri':>10}  home   prefs  "
          f"cost to overtake the one above")
    prev = None
    for i, n in enumerate(order):
        r = regs.get(n)
        if r is None:
            print(f"{i:>5}{n:>8}   (no flow record)")
            continue
        p = P(r["refs"], r["live"])
        note = ""
        if prev is not None:
            note = "  OR  ".join(cost_to_beat(r, prev))
        print(f"{i:>5}{n:>8}{r['refs']:>6}{r['live']:>6}{p:>10.4f}  "
              f"{Q.hname(disp.get(n, homes.get(n, -1))):<6} "
              f"{','.join(prefs.get(n, [])) or '-':<6} {note}")
        prev = p


if __name__ == "__main__":
    main()
