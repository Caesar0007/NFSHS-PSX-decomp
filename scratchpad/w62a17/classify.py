"""W62-A17: classify the raw divergence list from decl_scan.py into risk tiers.

TIER-1 BASE-TYPE MISMATCH : the underlying element/scalar type differs
                            (char vs int, short vs int, T vs U, bool vs int)  -> real bug class
TIER-2 INDIRECTION        : same base but the pointer DEPTH differs (T* vs T**)
TIER-3 ARRAY-VIEW         : same base + same depth, only the [] extent differs -> documented lever
"""
import re
import sys
import collections
import importlib.util

spec = importlib.util.spec_from_file_location(
    "decl_scan", r"C:\Temp\nfs4-decomp\scratchpad\w62a17\decl_scan.py")

# instead of importing (it prints), re-implement the collection by exec'ing the parser part
import os
sys.argv = ["x"]
src = open(r"C:\Temp\nfs4-decomp\scratchpad\w62a17\decl_scan.py", encoding="utf-8").read()
src = src.split("print(\"scanned")[0]
ns = {"__name__": "ds"}
exec(compile(src, "decl_scan.py", "exec"), ns)
data_decls = ns["data_decls"]

# --- normalize -------------------------------------------------------------
INT_ALIASES = {"int": "int", "long": "int", "u_long": "uint", "unsignedlong": "uint",
               "unsigned": "uint", "unsignedint": "uint", "u_int": "uint",
               "s32": "int", "u32": "uint"}


def split_norm(t):
    """-> (base, depth, extents, volatile, const)"""
    vol = t.startswith("volatile ")
    t = t.replace("volatile ", "")
    con = t.startswith("const ")
    t = t.replace("const ", "")
    ext = re.findall(r"\[[^\]]*\]", t)
    t = re.sub(r"\[[^\]]*\]", "", t)
    depth = t.count("*")
    base = t.replace("*", "").strip()
    return base, depth, ext, vol, con


def canon_base(b):
    return INT_ALIASES.get(b, b)


rows = []
for sym, ds in data_decls.items():
    if len(ds) < 2:
        continue
    types = collections.Counter(d["type"] for d in ds)
    if len(types) < 2:
        continue
    parsed = {t: split_norm(t) for t in types}
    bases = set(canon_base(p[0]) for p in parsed.values())
    depths = set(p[1] for p in parsed.values())
    # array-view compensation: `T x` vs `T x[]` -- depth same, extents differ
    # `T *x` vs `T **x[]` -- draww-style view: depth differs by exactly 1 AND the
    # deeper one carries an extent -> still flag as tier2 (needs eyes)
    if len(bases) > 1:
        tier = 1
    elif len(depths) > 1:
        tier = 2
    else:
        tier = 3
    rows.append((tier, sym, types, parsed))

rows.sort(key=lambda r: (r[0], r[1]))
for tier in (1, 2, 3):
    sub = [r for r in rows if r[0] == tier]
    print("=" * 78)
    print("TIER %d  (%d symbols)" % (tier, len(sub)))
    print("=" * 78)
    for _, sym, types, parsed in sub:
        print("--- %s" % sym)
        for t, c in types.most_common():
            locs = [d for d in data_decls[sym] if d["type"] == t]
            print("      %-40s x%-3d %s" % (t, c, ", ".join(
                "%s:%d" % (d["file"], d["line"]) for d in locs[:5])))
        print()
