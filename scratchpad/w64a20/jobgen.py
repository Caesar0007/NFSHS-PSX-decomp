#!/usr/bin/env python3
"""Build the job file + the shim/lane annotation map for the w62-a20 sweep."""
import importlib.util, json, pathlib, re, sys, collections

ROOT = pathlib.Path(r"C:/Temp/nfs4-decomp")
OUT = pathlib.Path(__file__).resolve().parent

spec = importlib.util.spec_from_file_location("nfs4build", ROOT / "tools" / "build.py")
bp = importlib.util.module_from_spec(spec)
sys.modules["nfs4build"] = bp
spec.loader.exec_module(bp)

# ---- rows -------------------------------------------------------------
rows = []
for ln in open(ROOT / "MATCH_PROGRESS.txt", encoding="utf-8", errors="replace"):
    m = re.match(r"^(0x[0-9A-F]+)\s+(\d+\.\d+)%\s+(\S+)\s+(\S+)\s*$", ln)
    if m:
        rows.append((m.group(1), float(m.group(2)), m.group(3), m.group(4)))
assert len(rows) > 3000, len(rows)
ea100 = [r for r in rows if r[2].startswith(("game/", "frontend/", "eaclib/")) and r[1] >= 100.0]
N_EA100 = len(ea100)   # w64: was 2972 at W63 close; the board moved
print('EA rows at 100.00%%:', N_EA100)

# ---- unit -> source rel ------------------------------------------------
units = collections.OrderedDict()
for va, pc, u, fn in ea100:
    if u not in units:
        for ext in (".cpp", ".c"):
            p = ROOT / "recon" / (u + ext)
            if p.exists():
                units[u] = p.relative_to(ROOT).as_posix()
                break
        else:
            raise SystemExit("no source for unit " + u)

# ---- shim tables -------------------------------------------------------
SHIM_TABLES = [
    "PER_FN_NO_DELAYED_BRANCH", "PER_FN_NO_THREAD_JUMPS", "PER_FN_G8",
    "PER_FN_NO_SPLIT_ADDRESSES", "PER_FN_FORCE_ADDR", "PER_FN_EPILOGUE_UNFILL",
    "PER_FN_EPILOGUE_UNFILL_272", "PER_FN_EPILOGUE_UNFILL_ALT28",
    "PER_FN_FLAG_SPLICE_272", "PER_FN_CC1_VER_SPLICE_272",
    "PER_FN_CC1_VER_SPLICE", "PER_FN_RA_SINK", "PER_FN_PROLOGUE_UNSINK",
    "PER_FN_TEXT_MOVES",
]
shims = collections.defaultdict(list)   # (rel, fn) -> [table names]
for t in SHIM_TABLES:
    tab = getattr(bp, t, None)
    assert tab is not None, t
    for rel, v in tab.items():
        names = v if isinstance(v, (set, list, tuple)) else list(v.keys())
        for fn in names:
            shims[(rel, fn)].append(t)

# ---- job file ----------------------------------------------------------
NONDEFAULT_CC1 = ("cc1_272", "cc1_alt", "cc1_ver")
FLAG_KEYS = ("no_delayed_branch", "no_split_addresses", "no_schedule_insns",
             "no_schedule_insns2", "no_strength_reduce", "no_builtin",
             "signed_char", "jtbl_at_fusion")
jobs = {"units": {}}
meta = {}
for u, rel in units.items():
    flags = bp.per_tu_flags(ROOT / rel)
    g = str(flags.get("g_value", bp.G_VALUE))
    fns = [r[3] for r in ea100 if r[2] == u]
    lane = next((k for k in NONDEFAULT_CC1 if flags.get(k)), None)
    extra = [k for k in FLAG_KEYS if flags.get(k)]
    meta[rel] = dict(unit=u, g=g, cpp=rel.endswith(".cpp"), lane=lane,
                     lane_val=str(flags.get(lane)) if lane else None,
                     tu_extra_flags=extra, nfns=len(fns))
    # W63: keep lane-wired TUs in the job file -- pqbatch2 asks psyqproof's own
    # tu_settings() and emits an explicit INAPPLICABLE-LANE row, so every one of
    # the 2972 board rows gets a row in the jsonl (w62 dropped them silently).
    jobs["units"][rel] = dict(g=g, cpp=rel.endswith(".cpp"), fns=fns, lane=lane)

json.dump(jobs, open(OUT / "jobs.json", "w"), indent=0)
json.dump({"rows": ea100,
           "units": units,
           "meta": meta,
           "shims": {f"{k[0]}|{k[1]}": v for k, v in shims.items()}},
          open(OUT / "ctx.json", "w"), indent=0)

njob = sum(len(u["fns"]) for u in jobs["units"].values())
print("EA 100% rows:", len(ea100))
print("units:", len(units), " job units:", len(jobs["units"]))
print("fns queued:", njob, " fns skipped (inapplicable lane):", len(ea100) - njob)
print("G distribution:", collections.Counter(m["g"] for m in meta.values()))
print("lane-wired EA TUs:", {r: (m["lane"], m["lane_val"], m["nfns"])
                             for r, m in meta.items() if m["lane"]})
print("EA TUs with extra cc1 flags psyqproof omits:",
      {r: (m["tu_extra_flags"], m["nfns"]) for r, m in meta.items() if m["tu_extra_flags"]})
ea_shims = {k: v for k, v in shims.items() if k[0] in units.values()}
print("shim entries on EA TUs:", len(ea_shims))
for k, v in sorted(ea_shims.items()):
    print("   ", k[0], k[1], v)
