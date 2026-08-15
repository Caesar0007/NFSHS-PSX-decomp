"""Driver for the 13A decl-order scope experiment (see declab.py docstring)."""
import hashlib
import sys
import os

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from declab import gen, compile_dump, parse, VARS, USES, NAME  # noqa: E402

# ref count -> variable name (refs = USES[v] + def + return-use)
BYREFS = {}
PERMS = [
    ("decl_abcde", ["a", "b", "c", "d", "e"]),
    ("decl_edcba", ["e", "d", "c", "b", "a"]),
    ("decl_cadbe", ["c", "a", "d", "b", "e"]),
    ("decl_bcdea", ["b", "c", "d", "e", "a"]),
]
KINDS = ["glob", "loc", "init", "addr"]
LANES = [("cpp", "CC1PLPSX 2.8.0 C++ (-fno-exceptions -fno-rtti -G4)"),
         ("c272", "CC1PSX 2.7.2 C (-G0 -mgas)"),
         ("c280", "CC1PSX 2.8.0 C (-G4)")]


def sha(t):
    return hashlib.sha1(t.encode("utf8", "replace")).hexdigest()[:10]


def main():
    only_kind = sys.argv[1] if len(sys.argv) > 1 else None
    for lane, desc in LANES:
        print("=" * 78)
        print("LANE %s : %s" % (lane, desc))
        for kind in KINDS:
            if only_kind and kind != only_kind:
                continue
            print("-" * 78)
            print("  PROBE kind=%s" % kind)
            rows = []
            for tag, order in PERMS:
                src = gen(kind, order)
                s, lreg, greg, err = compile_dump(src, lane,
                                                  "%s_%s_%s" % (lane, kind, tag))
                if not s:
                    print("    %-12s COMPILE FAILED: %s" % (tag, err[-200:]))
                    continue
                regs, home = parse(lreg, greg)
                # map pseudo -> variable via its (invariant) ref count
                byrefs = {}
                for pseudo, (refs, live, blk, note) in regs.items():
                    byrefs.setdefault(refs, []).append((pseudo, live, blk, note))
                ident = {}
                for v in VARS:
                    want = USES[v] + 2
                    cand = byrefs.get(want, [])
                    if len(cand) == 1:
                        ident[v] = cand[0]
                pseudos = " ".join(
                    "%s=p%d/%s" % (v, ident[v][0],
                                   NAME[home[ident[v][0]]]
                                   if ident[v][0] in home
                                   and home[ident[v][0]] < 32 else "?")
                    for v in VARS if v in ident)
                unident = [v for v in VARS if v not in ident]
                rows.append((tag, sha(s), pseudos, unident, len(regs)))
            base = rows[0] if rows else None
            for tag, h, pseudos, unident, nregs in rows:
                flag = "" if base and h == base[1] else "   <== .s DIFFERS"
                print("    %-12s s=%s npseudo=%-3d %s%s"
                      % (tag, h, nregs, pseudos, flag))
                if unident:
                    print("                 (unidentified: %s)" % unident)


main()
