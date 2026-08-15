#!/usr/bin/env python3
"""W63-A20 PRODUCTION-LANE BATCH SWEEP (v2).

ANTI-DRIFT (12H): this harness IMPORTS tools/psyqproof.py and reuses its
`tu_settings` / `to_aspsx_dialect` / `strip_redundant_externs` / `oracle_words`
verbatim -- it never re-implements a shim or a normalizer.  The only thing it
adds over the shipped prover is BATCHING (compile each TU once, prove every
sealed fn of that TU against the same object) and the JSONL report.

Usage: python pqbatch2.py <jobs.json> <out.jsonl> [--no-dialect]
jobs.json: {"units": {"<tu-rel>": {"g": ..., "cpp": bool, "fns": [...]}}}
           (g/cpp are informational; -G and the extra cc1 flags are taken from
            build.py through psyqproof.tu_settings, exactly like the prover)
"""
import importlib.util
import json
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
_s = importlib.util.spec_from_file_location("psyqproof", ROOT / "tools" / "psyqproof.py")
pq = importlib.util.module_from_spec(_s)
_s.loader.exec_module(pq)                      # main() is __main__-guarded

_s2 = importlib.util.spec_from_file_location("pex", pq.PEX)
pex = importlib.util.module_from_spec(_s2)
_s2.loader.exec_module(pex)

DIALECT = [True]


def oracle_words(fn):
    """psyqproof.oracle_words sys.exit()s when there is no oracle; batching
    needs a value.  Same search order + same regex (it is pq's own regex)."""
    for sub in ("main", "front"):
        p = ROOT / "asm" / "nonmatchings" / sub / (fn + ".s")
        if p.exists():
            import re
            ow = []
            for ln in open(p, encoding="utf-8", errors="replace"):
                m = re.search(r"/\*\s+\S+\s+[0-9A-F]{8}\s+([0-9A-F]{8})\s+\*/", ln)
                if m:
                    ow.append(bytes.fromhex(m.group(1)))
            return ow, sub
    return None, None


def build_tu(rel):
    g, extra, lane = pq.tu_settings(rel)
    if lane:
        return None, f"INAPPLICABLE-LANE {lane}", g, extra
    i_file = ROOT / "build" / (rel + ".i")
    if not i_file.exists():
        return None, f"no preprocessed input {i_file}", g, extra
    cc1 = pq.CC1PL if rel.endswith(".cpp") else pq.CC1
    with tempfile.TemporaryDirectory() as td:
        s_out = Path(td) / "ps.s"
        r = subprocess.run([str(cc1), "-quiet", "-O2", f"-G{g or 4}", *extra,
                            str(i_file), "-o", str(s_out)],
                           capture_output=True, text=True)
        if r.returncode:
            return None, "cc1 failed: " + (r.stderr.strip().splitlines() or [""])[-1][:160], g, extra
        if rel.endswith(".cpp"):
            b = s_out.read_bytes()
            if b.count(b"_._"):
                s_out.write_bytes(b.replace(b"_._", b"___"))
        t = s_out.read_text(errors="replace")
        if DIALECT[0]:
            t = pq.to_aspsx_dialect(t)
        s_out.write_text(pq.strip_redundant_externs(t))
        obj_out = Path(td) / "ps.obj"
        r = subprocess.run([str(pq.ASPSX), "-o", str(obj_out), str(s_out)],
                           capture_output=True, text=True, cwd=td)
        blob = r.stdout + r.stderr
        if not obj_out.exists() or " : Error : " in blob:
            return None, "aspsx failed: " + blob.strip()[:240], g, extra
        try:
            obj = pex.parse_obj(open(obj_out, "rb").read())
        except Exception as e:
            return None, f"parse_obj: {type(e).__name__}: {e}", g, extra
    return obj, None, g, extra


def prove(obj, fn):
    fn_off = fn_sect = src = None
    for x in obj["xdefs"]:
        if x["name"] == fn:
            fn_off, fn_sect, src = x["off"], x["sect"], "xdef"
    if fn_off is None:
        for x in obj["locals"]:
            if x["name"] == fn:
                fn_off, fn_sect, src = x["off"], x["sect"], "local"
    if fn_off is None:
        return dict(status="NO_SYMBOL")
    ow, sub = oracle_words(fn)
    if ow is None:
        return dict(status="NO_ORACLE")
    code = obj["code"][fn_sect]
    n = len(ow)
    ours = code[fn_off:fn_off + 4 * n]
    tail_pad = 0
    if len(ours) < 4 * n:
        avail = len(ours) // 4
        if all(w == bytes(4) for w in ow[avail:]):
            tail_pad, n, ow = n - avail, avail, ow[:avail]
        else:
            return dict(status="SHORT_CODE", have=len(ours), want=4 * n, words=n)
    rel_offs = set()
    for rc in obj.get("patches", []):
        sec, off = rc.get("sect"), rc.get("off")
        if sec == fn_sect and off is not None and fn_off <= off < fn_off + 4 * n:
            rel_offs.add((off - fn_off) // 4)
    real = reloc = relop = 0
    rows = []
    for i in range(n):
        a, b = ours[4 * i:4 * i + 4], ow[i]
        if a == b:
            continue
        if i in rel_offs:
            reloc += 1
            wa, wb = int.from_bytes(a, "little"), int.from_bytes(b, "little")
            ok = ((wa >> 26) == (wb >> 26)) if (wa >> 26) in (2, 3) or (wb >> 26) in (2, 3) \
                else ((wa >> 16) == (wb >> 16))
            if not ok:
                relop += 1
                if len(rows) < 12:
                    rows.append(f"RELOP w{i}: {a[::-1].hex()} vs {b[::-1].hex()}")
        else:
            real += 1
            if len(rows) < 12:
                rows.append(f"w{i}: {a[::-1].hex()} vs {b[::-1].hex()}")
    return dict(status="OK", words=n, real=real, reloc=reloc, relop=relop,
                tail_pad=tail_pad, oracle_dir=sub, symsrc=src, diffs=rows)


def main():
    DIALECT[0] = "--no-dialect" not in sys.argv
    jobs = json.load(open(sys.argv[1]))
    outp = open(sys.argv[2], "w", encoding="utf-8")
    units = jobs["units"]
    nfn = 0
    for i, (rel, u) in enumerate(sorted(units.items()), 1):
        obj, err, g, extra = build_tu(rel)
        if err:
            for fn in u["fns"]:
                outp.write(json.dumps(dict(tu=rel, fn=fn, g=g, extra=extra,
                                           status="TU_BUILD_FAIL", err=err)) + "\n")
                nfn += 1
            outp.flush()
            print(f"[{i}/{len(units)}] {rel}: TU FAIL {err}", flush=True)
            continue
        agg = {}
        for fn in u["fns"]:
            r = prove(obj, fn)
            r.update(tu=rel, fn=fn, g=g, extra=extra)
            outp.write(json.dumps(r) + "\n")
            nfn += 1
            agg[r["status"]] = agg.get(r["status"], 0) + 1
        outp.flush()
        print(f"[{i}/{len(units)}] {rel}: {len(u['fns'])} fns {agg}", flush=True)
    outp.close()
    print("TOTAL fn rows written:", nfn)


main()
