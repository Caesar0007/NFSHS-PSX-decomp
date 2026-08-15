#!/usr/bin/env python3
"""psyqproof.py <tu.i-or-src-rel> <fn> [-G<n>] -- THE PRODUCTION-LANE PROVER.

Per the user directive (2026-08-15): maspsx+GNU-as is only the TESTING gate;
the production build is PsyQ 4.3.0's own cc1 + ASPSX 2.77.  This runs the fn
through the REAL pipeline and word-compares the assembled bytes against the
oracle .s COMMENT COLUMN (= retail byte truth):

    build/<tu>.i -> psq43 CC1PSX (no -mgas) -> ASPSX.EXE 2.77 -> SN-OBJ
    -> tools_psyq_extract.parse_obj -> <fn> bytes vs asm/nonmatchings/*/<fn>.s

Reloc sites (words the pre-link object cannot know) are counted separately and
listed; classify them by hand against symbol_addrs.  Exit 0 iff REAL=0.
Generalizes scratchpad/psyq_confirm/confirm2.py (the iSND100hzserver proof).

w62-a20 fixes (all measured over the 2965-fn EA sealed board; receipts in
scratchpad/w62a20/PRODUCTION_LEDGER.md):
  1. the oracle lives in asm/nonmatchings/main OR .../front (897 EA rows were
     unreachable with main/ hardcoded);
  2. C++ TUs need build.py's cfront dtor rename `_._` -> `___` before ASPSX
     (every `___<class>` dtor row was unreachable);
  3. ASPSX 2.77 exits NONZERO on WARNINGS ONLY while still writing a complete
     object -- gate on " : Error : " + object existence (4 TUs / 53 rows);
  4. a fn that is LAST in its object is one oracle word short: the oracle .s
     carries a trailing 00000000 object-padding word (26 rows scored REAL=1);
  5. static fns are not XDEFs -- fall back to the object's local symbols;
  6. take -G and the per-TU cc1 flags from tools/build.py instead of assuming
     -G4 (frontend/common is -G0, 15 EA TUs are -G8, 4 carry -fno-* flags);
  7. 12H anti-vacuity: a reloc-masked word may only differ in the RELOCATED
     field -- report RELOP (opcode/register mismatches hiding under a reloc);
  8. --dialect rewrites the GNU-as spellings ASPSX rejects inside our __asm__
     blocks (ABI register names, .set push/pop) -- 25 TUs / 252 rows;
  9. a TU wired to cc1_272/cc1_alt/cc1_ver is INAPPLICABLE to this prover
     (it always uses psq43 cc1) -- say so instead of printing a fake REAL.
Note: do NOT add -g1; ASPSX then emits debug op 0x52, which parse_obj cannot
read.  -g1/-mgpOPT/-fgnu-linker are code-byte inert (measured, 14 TUs/26 fns).
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

_FLAGMAP = {"no_delayed_branch": "-fno-delayed-branch",
            "no_split_addresses": "-mno-split-addresses",
            "no_schedule_insns": "-fno-schedule-insns",
            "no_schedule_insns2": "-fno-schedule-insns2",
            "no_strength_reduce": "-fno-strength-reduce",
            "no_builtin": "-fno-builtin"}

_REGS = {"zero": 0, "at": 1, "v0": 2, "v1": 3, "a0": 4, "a1": 5, "a2": 6,
         "a3": 7, "t0": 8, "t1": 9, "t2": 10, "t3": 11, "t4": 12, "t5": 13,
         "t6": 14, "t7": 15, "s0": 16, "s1": 17, "s2": 18, "s3": 19, "s4": 20,
         "s5": 21, "s6": 22, "s7": 23, "t8": 24, "t9": 25, "k0": 26, "k1": 27,
         "gp": 28, "sp": 29, "fp": 30, "s8": 30, "ra": 31}
_REG_RE = re.compile(r"\$(" + "|".join(sorted(_REGS, key=len, reverse=True)) + r")\b")


def to_aspsx_dialect(text):
    """ASPSX 2.77 accepts numeric regs, %hi/%lo, .set noreorder/reorder/noat,
    beqz/bnez, .L/$L labels, lwl/swl, mfc2, move, li; it REJECTS ABI register
    NAMES, `.set push/pop` and `sym2 = sym` (probe: scratchpad/w62a20/dialect.py)."""
    text = _REG_RE.sub(lambda m: "$%d" % _REGS[m.group(1)], text)
    text = re.sub(r"^\s*\.set\s+push\s*$", "", text, flags=re.M)
    text = re.sub(r"^\s*\.set\s+pop\s*$", "\t.set\treorder\n\t.set\tat", text, flags=re.M)
    return text


def tu_settings(rel):
    """-> (g_value, extra_cc1_flags, inapplicable_lane_or_None) from build.py."""
    try:
        spec = importlib.util.spec_from_file_location("nfs4build", ROOT / "tools" / "build.py")
        bp = importlib.util.module_from_spec(spec)
        sys.modules["nfs4build"] = bp
        spec.loader.exec_module(bp)
    except Exception:
        return None, [], None
    flags = bp.per_tu_flags(ROOT / rel)
    lane = next((k for k in ("cc1_272", "cc1_alt", "cc1_ver") if flags.get(k)), None)
    return (str(flags.get("g_value", bp.G_VALUE)),
            [v for k, v in _FLAGMAP.items() if flags.get(k)],
            f"{lane}={flags.get(lane)}" if lane else None)


def oracle_words(fn):
    for sub in ("main", "front"):
        p = ROOT / "asm" / "nonmatchings" / sub / (fn + ".s")
        if p.exists():
            ow = []
            for ln in open(p, encoding="utf-8", errors="replace"):
                m = re.search(r"/\*\s+\S+\s+[0-9A-F]{8}\s+([0-9A-F]{8})\s+\*/", ln)
                if m:
                    ow.append(bytes.fromhex(m.group(1)))  # already LE byte order
            return ow
    sys.exit(f"no oracle asm/nonmatchings/{{main,front}}/{fn}.s")


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("-G") and a != "--dialect"]
    dialect = "--dialect" in sys.argv
    rel, fn = args[0], args[1]
    rel = rel.replace("\\", "/")
    src_rel = rel[:-2] if rel.endswith(".i") else rel
    tu_g, tu_extra, lane = tu_settings(src_rel)
    gval = next((a[2:] for a in sys.argv[1:] if a.startswith("-G")), tu_g or "4")
    if lane:
        sys.exit(f"{fn}: INAPPLICABLE-LANE -- {src_rel} is wired to {lane}; this "
                 f"prover always uses psq43 CC1PSX/CC1PLPSX")
    i_file = ROOT / "build" / (rel + ".i") if not rel.endswith(".i") else ROOT / rel
    if not i_file.exists():
        sys.exit(f"no preprocessed input {i_file} (build the TU once first)")
    cc1 = CC1PL if src_rel.endswith(".cpp") else CC1
    with tempfile.TemporaryDirectory() as td:
        s_out = Path(td) / "ps.s"
        r = subprocess.run([str(cc1), "-quiet", "-O2", f"-G{gval}", *tu_extra,
                            str(i_file), "-o", str(s_out)],
                           capture_output=True, text=True)
        if r.returncode:
            sys.exit(f"cc1 failed:\n{r.stderr[:800]}")
        if src_rel.endswith(".cpp"):
            b = s_out.read_bytes()
            if b.count(b"_._"):
                s_out.write_bytes(b.replace(b"_._", b"___"))
        if dialect:
            s_out.write_text(to_aspsx_dialect(s_out.read_text(errors="replace")))
        obj_out = Path(td) / "ps.obj"
        r = subprocess.run([str(ASPSX), "-o", str(obj_out), str(s_out)],
                           capture_output=True, text=True, cwd=td)
        blob = r.stdout + r.stderr
        if not obj_out.exists() or " : Error : " in blob:
            sys.exit(f"aspsx failed:\n{blob[:800]}")
        spec = importlib.util.spec_from_file_location("pex", PEX)
        pex = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(pex)
        obj = pex.parse_obj(open(obj_out, "rb").read())
    fn_off = fn_sect = None
    for x in obj["xdefs"] + obj["locals"]:
        if x["name"] == fn:
            fn_off, fn_sect = x["off"], x["sect"]
    if fn_off is None:
        sys.exit(f"{fn}: not an XDEF/local symbol in the aspsx object")
    code = obj["code"][fn_sect]
    ow = oracle_words(fn)
    n = len(ow)
    ours = code[fn_off:fn_off + 4 * n]
    pad = 0
    if len(ours) < 4 * n:                      # last fn in the object
        avail = len(ours) // 4
        if all(w == bytes(4) for w in ow[avail:]):
            pad, n, ow = n - avail, avail, ow[:avail]
    rel_offs = set()
    for rc in obj.get("patches", []):
        sec = rc.get("sect", rc.get("section"))
        off = rc.get("off", rc.get("offset"))
        if sec == fn_sect and off is not None and fn_off <= off < fn_off + 4 * n:
            rel_offs.add((off - fn_off) // 4)
    real = reloc = relop = 0
    rows = []
    for i in range(n):
        a = ours[4 * i:4 * i + 4]
        b = ow[i]
        if a != b:
            if i in rel_offs:
                reloc += 1
                wa, wb = int.from_bytes(a, "little"), int.from_bytes(b, "little")
                ok = ((wa >> 26) == (wb >> 26) if (wa >> 26) in (2, 3) or (wb >> 26) in (2, 3)
                      else (wa >> 16) == (wb >> 16))
                if not ok:                     # 12H: not explicable by relocation
                    relop += 1
                    rows.append(f"  word {i:4d}: RELOP ours {a[::-1].hex()} vs retail {b[::-1].hex()}")
            else:
                real += 1
                rows.append(f"  word {i:4d}: ours {a[::-1].hex()} vs retail {b[::-1].hex()}")
    print(f"{fn}: {n} words (-G{gval}{' ' + ' '.join(tu_extra) if tu_extra else ''}"
          f"{', +%d padding word(s)' % pad if pad else ''}), REAL={real} RELOP={relop} "
          f"reloc-site diffs={reloc} (reloc sites are pre-link unknowns -- classify "
          f"vs symbol_addrs; RELOP>0 means a reloc-masked word differs beyond its "
          f"relocated field and REAL=0 would be VACUOUS)")
    for r_ in rows[:16]:
        print(r_)
    sys.exit(0 if real + relop == 0 else 1)


main()
