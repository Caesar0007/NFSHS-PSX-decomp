#!/usr/bin/env python3
"""psyqproof.py <tu.i-or-src-rel> <fn> [-G<n>] -- THE PRODUCTION-LANE PROVER.

Per the user directive (2026-08-15): maspsx+GNU-as is only the TESTING gate;
the production build is PsyQ 4.3.0's own cc1 + ASPSX 2.77.  This runs the fn
through the REAL pipeline and word-compares the assembled bytes against the
oracle .s COMMENT COLUMN (= retail byte truth):

    build/<tu>.i -> psq43 CC1PSX (no -mgas) -> ASPSX.EXE 2.77 -> SN-OBJ
    -> tools_psyq_extract.parse_obj -> <fn> bytes vs asm/nonmatchings/main/<fn>.s

Reloc sites (words the pre-link object cannot know) are counted separately and
listed; classify them by hand against symbol_addrs.  Exit 0 iff REAL=0.
Generalizes scratchpad/psyq_confirm/confirm2.py (the iSND100hzserver proof).
"""
import importlib.util
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CC1 = Path(r"C:/Temp/psq43/COMPILER/CC1PSX.EXE")
CC1PL = Path(r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE")
ASPSX = Path(r"C:/Temp/psq43/PSSN/ASPSX.EXE")
PEX = r"C:/Temp/nfs3-clean/tools_psyq_extract.py"

def main():
    args = [a for a in sys.argv[1:] if not a.startswith("-G")]
    gval = next((a[2:] for a in sys.argv[1:] if a.startswith("-G")), "4")
    rel, fn = args[0], args[1]
    rel = rel.replace("\\", "/")
    i_file = ROOT / "build" / (rel + ".i") if not rel.endswith(".i") else ROOT / rel
    if not i_file.exists():
        sys.exit(f"no preprocessed input {i_file} (build the TU once first)")
    cc1 = CC1PL if rel.endswith(".cpp") else CC1
    with tempfile.TemporaryDirectory() as td:
        s_out = Path(td) / "ps.s"
        r = subprocess.run([str(cc1), "-quiet", "-O2", f"-G{gval}",
                            str(i_file), "-o", str(s_out)],
                           capture_output=True, text=True)
        if r.returncode:
            sys.exit(f"cc1 failed:\n{r.stderr[:800]}")
        obj_out = Path(td) / "ps.obj"
        r = subprocess.run([str(ASPSX), "-o", str(obj_out), str(s_out)],
                           capture_output=True, text=True, cwd=td)
        if r.returncode or not obj_out.exists():
            sys.exit(f"aspsx failed:\n{r.stdout[:400]}{r.stderr[:400]}")
        spec = importlib.util.spec_from_file_location("pex", PEX)
        pex = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(pex)
        obj = pex.parse_obj(open(obj_out, "rb").read())
    fn_off = fn_sect = None
    for x in obj["xdefs"]:
        if x["name"] == fn:
            fn_off, fn_sect = x["off"], x["sect"]
    if fn_off is None:
        sys.exit(f"{fn}: not an XDEF in the aspsx object")
    code = obj["code"][fn_sect]
    # oracle words from the comment column
    ow = []
    for ln in open(ROOT / "asm" / "nonmatchings" / "main" / (fn + ".s"),
                   encoding="utf-8", errors="replace"):
        m = re.search(r"/\*\s+\S+\s+[0-9A-F]{8}\s+([0-9A-F]{8})\s+\*/", ln)
        if m:
            ow.append(bytes.fromhex(m.group(1)))  # already LE byte order
    n = len(ow)
    ours = code[fn_off:fn_off + 4 * n]
    # reloc offsets within the fn
    rel_offs = set()
    for rc in obj.get("patches", []):
        try:
            sec = rc.get("sect", rc.get("section"))
            off = rc.get("off", rc.get("offset"))
        except AttributeError:
            sec, off = rc[0], rc[1]
        if sec == fn_sect and off is not None and fn_off <= off < fn_off + 4 * n:
            rel_offs.add((off - fn_off) // 4)
    real = reloc = 0
    rows = []
    for i in range(n):
        a = ours[4 * i:4 * i + 4]
        b = ow[i]
        if a != b:
            if i in rel_offs:
                reloc += 1
            else:
                real += 1
                rows.append(f"  word {i:4d}: ours {a[::-1].hex()} vs retail {b[::-1].hex()}")
    print(f"{fn}: {n} words, REAL={real} reloc-site diffs={reloc} "
          f"(reloc sites are pre-link unknowns -- classify vs symbol_addrs)")
    for r_ in rows[:16]:
        print(r_)
    sys.exit(0 if real == 0 else 1)

main()
