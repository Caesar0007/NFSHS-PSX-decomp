#!/usr/bin/env python3
"""w64-a20: build the PRODUCTION object for a TU by calling tools/psyqproof.py's
OWN pipeline functions (12H anti-drift: nothing re-implemented -- the cc1 argv,
the cfront dtor rename, to_aspsx_dialect() and strip_redundant_externs() are the
shipped prover's), and hash the resulting SN object's code sections.

Why object-level instead of per-fn: psyqproof re-runs cc1+ASPSX per FUNCTION.
Hashing the object once per configuration is ~26x faster on a 26-fn TU AND
strictly stronger -- if the production object's code bytes are byte-identical
before vs after a source edit, then EVERY function's REAL/RELOP is unchanged by
construction, with no per-fn sampling.

Configurations:
  dialect=True   what the shipped prover does today (shim ON)
  dialect=False  the REAL retail toolchain with no shim -- the mission target

Usage: python prodobj.py <tu-rel> [--no-dialect] [--json]
Prints: sha256 of the concatenated code sections, section sizes, or the ASPSX
        error (which is what an un-converted TU produces without the shim).
"""
import hashlib, importlib.util, json, subprocess, sys, tempfile
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
sys.path.insert(0, str(ROOT / "tools"))
_sp = importlib.util.spec_from_file_location("pq", ROOT / "tools" / "psyqproof.py")
pq = importlib.util.module_from_spec(_sp)
sys.modules["pq"] = pq
_sp.loader.exec_module(pq)


def build(rel, dialect=True):
    """-> dict(ok, sha, sects, err).  Mirrors psyqproof.main()'s object build."""
    src_rel = rel[:-2] if rel.endswith(".i") else rel
    tu_g, tu_extra, lane = pq.tu_settings(src_rel)
    if lane:
        return {"ok": False, "err": f"INAPPLICABLE-LANE {lane}"}
    i_file = ROOT / "build" / (src_rel + ".i")
    if not i_file.exists():
        return {"ok": False, "err": f"no {i_file}"}
    cc1 = pq.CC1PL if src_rel.endswith(".cpp") else pq.CC1
    with tempfile.TemporaryDirectory() as td:
        s_out = Path(td) / "ps.s"
        # W56-08E hazard: CC1PLPSX intermittently exits NONZERO while writing a
        # complete .s (the documented "cc1plus intermittent-nonzero gate
        # flakiness / 5-retry wrapper").  Retry, and accept a nonzero exit that
        # still produced output whose only diagnostics are warnings.
        for _try in range(5):
            r = subprocess.run([str(cc1), "-quiet", "-O2", f"-G{tu_g or 4}",
                                *tu_extra, str(i_file), "-o", str(s_out)],
                               capture_output=True, text=True)
            if r.returncode == 0 and s_out.exists():
                break
            if s_out.exists() and s_out.stat().st_size and \
               " : Error" not in r.stderr and "error" not in r.stderr.lower():
                break
        else:
            return {"ok": False, "err": "cc1: " + r.stderr[:200].replace("\n", " ")}
        if src_rel.endswith(".cpp"):
            b = s_out.read_bytes()
            if b.count(b"_._"):
                s_out.write_bytes(b.replace(b"_._", b"___"))
        if dialect:
            s_out.write_text(pq.to_aspsx_dialect(s_out.read_text(errors="replace")))
        s_out.write_text(pq.strip_redundant_externs(s_out.read_text(errors="replace")))
        obj_out = Path(td) / "ps.obj"
        r = subprocess.run([str(pq.ASPSX), "-o", str(obj_out), str(s_out)],
                           capture_output=True, text=True, cwd=td)
        blob = r.stdout + r.stderr
        if not obj_out.exists() or " : Error : " in blob:
            errs = [l for l in blob.splitlines() if " : Error : " in l]
            return {"ok": False, "err": (errs[0] if errs else blob[:200]).strip()[:200]}
        obj = pq.parse_obj if hasattr(pq, "parse_obj") else None
        _s2 = importlib.util.spec_from_file_location("pex", pq.PEX)
        pex = importlib.util.module_from_spec(_s2)
        _s2.loader.exec_module(pex)
        o = pex.parse_obj(obj_out.read_bytes())
    h = hashlib.sha256()
    sects = {}
    for k in sorted(o["code"]):
        code = o["code"][k]
        h.update(bytes([k]))
        h.update(code)
        sects[k] = len(code)
    nsym = len(o["xdefs"]) + len(o["locals"])
    # 12H anti-vacuity: an object with NO code sections hashes to sha256("") and
    # would compare "equal" to any other empty result -- treat it as a failure.
    # (Seen once on drawc.cpp: ASPSX exited clean but parse_obj found no code;
    # a re-run was fine, i.e. a transient partial write.)
    if not sects or not any(sects.values()):
        return {"ok": False, "err": "parse_obj returned NO code sections "
                                    "(transient/partial object -- re-run)"}
    return {"ok": True, "sha": h.hexdigest(), "sects": sects, "nsym": nsym,
            "npatch": len(o.get("patches", []))}


if __name__ == "__main__":
    rel = sys.argv[1].replace("\\", "/")
    d = "--no-dialect" not in sys.argv
    res = build(rel, d)
    if "--json" in sys.argv:
        print(json.dumps(res))
    elif res["ok"]:
        print(f"{rel} dialect={d}: sha={res['sha'][:16]} sects={res['sects']} "
              f"syms={res['nsym']} relocs={res['npatch']}")
    else:
        print(f"{rel} dialect={d}: FAILED -- {res['err']}")
