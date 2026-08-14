#!/usr/bin/env python3
"""qty272_rule.py -- WHICH priority formula does the 272 lane's global.c use?

The `.greg` dump prints `;; N regs to allocate: <pseudos>` in the EXACT order
global.c allocated them (i.e. post-`allocno_compare` sort).  So the ordering
rule can be read off the tool's own output instead of guessed: for every
function in a set of TUs, check the printed order against each candidate
formula (ties allowed in any order, since qsort is unstable).

This matters because `tools/allocsim.py` / `tools/reqdelta.py` implement the
gcc-2.8 rule (`floor_log2(refs)*refs*SIZE/live`).  If 2.7.2 differs, every
priced dial they emit on a cc1_272 TU is wrong -- which is the documented
"allocsim 6/10 on 2.7.2 dumps" symptom (W59-11A).

Usage:  python scratchpad/w60a1/qty272_rule.py <recon/....c> [more TUs...]
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import qty272 as Q                                          # noqa: E402

ROOT = Q.ROOT


def f_log2(n):
    return Q._floor_log2(n)


FORMULAS = {
    "2.7.2? refs*log2/live          ": lambda r: f_log2(r["refs"]) * r["refs"] / max(r["live"], 1),
    "2.8   refs*log2*SIZE/live      ": lambda r: f_log2(r["refs"]) * r["refs"] * r["size"] / max(r["live"], 1),
    "alt   refs*log2/(live*SIZE)    ": lambda r: f_log2(r["refs"]) * r["refs"] / (max(r["live"], 1) * r["size"]),
    "old   longest live first       ": lambda r: r["live"],
    "naive refs only                ": lambda r: r["refs"],
}


def check(order, regs, key):
    """Is `order` a descending sort by key (ties in any order)?"""
    vals = []
    for n in order:
        r = regs.get(n)
        if r is None:
            return None
        vals.append(key(r))
    return all(vals[i] >= vals[i + 1] - 1e-9 for i in range(len(vals) - 1))


def main():
    tus = sys.argv[1:]
    if not tus:
        sys.exit(__doc__)
    tot = {k: [0, 0] for k in FORMULAS}          # [consistent, total]
    nfun = 0
    for tu in tus:
        src = (ROOT / tu).resolve()
        tmp, i_file, cc1, flags = Q.compile_dumps(src)
        lreg = Q.split_functions(Path(str(i_file) + ".lreg").read_text(errors="replace"))
        greg = Q.split_functions(Path(str(i_file) + ".greg").read_text(errors="replace"))
        for fn, blk in greg.items():
            order, _c, _p, _d = Q.parse_greg(blk)
            if len(order) < 3:                    # need a real ordering signal
                continue
            regs, _homes = Q.parse_lreg(lreg.get(fn, ""))
            nfun += 1
            bad = []
            for name, key in FORMULAS.items():
                ok = check(order, regs, key)
                if ok is None:
                    continue
                tot[name][1] += 1
                tot[name][0] += 1 if ok else 0
                if not ok:
                    bad.append(name.strip())
            print(f"{Path(tu).name:>16} {fn:<34} n={len(order):<3} "
                  f"FAILS: {', '.join(b.split()[0] for b in bad) or '(none)'}")
    print(f"\n{nfun} functions with >=3 global allocnos")
    print(f"{'formula':<34}{'consistent':>12}")
    for k, (c, t) in tot.items():
        print(f"{k:<34}{c:>6}/{t:<5}{'  <== RULE' if t and c == t else ''}")


if __name__ == "__main__":
    main()
