#!/usr/bin/env python3
"""aliascheck.py -- prove the shim's `sym2 = sym` -> second-label rewrite puts
every co-equal XDEF at EXACTLY the canonical symbol's offset in the ASPSX
object (the property GNU-as's symbol assignment gave us).

Imports tools/psyqproof.py so the pipeline is the shipped one, not a copy (12H).
"""
import importlib.util
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
spec = importlib.util.spec_from_file_location("psyqproof", ROOT / "tools" / "psyqproof.py")
pq = importlib.util.module_from_spec(spec)
spec.loader.exec_module(pq)                      # safe: main() is __main__-guarded

CASES = {
    "recon/eaclib/psx/eacpsxz/fixddiv.c": ("rdiv", ["fixeddiv"]),
    "recon/eaclib/psx/eacpsxz/fixdinv.c": ("fixedinverse", ["rinverse"]),
    "recon/eaclib/psx/eacpsxz/isqrttbl.c": ("decodeshiftjis",
                                            ["decodeshiftjis2", "decodeshiftjis3"]),
    "recon/eaclib/psx/eacpsxz/sinfunc.c": ("intcos", ["fastintcos"]),
    "recon/eaclib/psx/eacpsxz/nullfunc.c": ("setclipwindow", [
        "setmousesensitivity", "nullfunctionz", "restorewindow", "resetclipwindow",
        "nullwindow", "savewindow", "removewindow", "purgekey", "nullfunction",
        "createwindowadr", "createshapeadr", "FILE_resize", "librestoremouse",
        "shapewindowdefadr", "FILE_delete", "FILE_opdevice", "FILE_nametodevice",
        "FILE_handletodevice", "asynctopupoverride", "asyncidle"]),
}


def obj_for(rel):
    g, extra, lane = pq.tu_settings(rel)
    cc1 = pq.CC1PL if rel.endswith(".cpp") else pq.CC1
    i_file = ROOT / "build" / (rel + ".i")
    with tempfile.TemporaryDirectory() as td:
        s_out = Path(td) / "ps.s"
        r = subprocess.run([str(cc1), "-quiet", "-O2", f"-G{g or 4}", *extra,
                            str(i_file), "-o", str(s_out)],
                           capture_output=True, text=True)
        assert not r.returncode, r.stderr[:400]
        s_out.write_text(pq.strip_redundant_externs(
            pq.to_aspsx_dialect(s_out.read_text(errors="replace"))))
        obj_out = Path(td) / "ps.obj"
        r = subprocess.run([str(pq.ASPSX), "-o", str(obj_out), str(s_out)],
                           capture_output=True, text=True, cwd=td)
        blob = r.stdout + r.stderr
        assert obj_out.exists() and " : Error : " not in blob, blob[:400]
        spec2 = importlib.util.spec_from_file_location("pex", pq.PEX)
        pex = importlib.util.module_from_spec(spec2)
        spec2.loader.exec_module(pex)
        return pex.parse_obj(open(obj_out, "rb").read())


bad = 0
for rel, (canon, aliases) in CASES.items():
    obj = obj_for(rel)
    syms = {x["name"]: (x["sect"], x["off"]) for x in obj["xdefs"] + obj["locals"]}
    if canon not in syms:
        print(f"FAIL {rel}: canonical {canon} missing"); bad += 1; continue
    want = syms[canon]
    miss = [a for a in aliases if a not in syms]
    wrong = [a for a in aliases if a in syms and syms[a] != want]
    ok = len(aliases) - len(miss) - len(wrong)
    print(f"{'OK  ' if not (miss or wrong) else 'FAIL'} {rel}: {canon}@sect{want[0]}"
          f"+0x{want[1]:x}  aliases at same addr {ok}/{len(aliases)}"
          + (f"  MISSING={miss}" if miss else "") + (f"  WRONG_ADDR={wrong}" if wrong else ""))
    bad += bool(miss or wrong)
sys.exit(1 if bad else 0)
