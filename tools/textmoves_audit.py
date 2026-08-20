#!/usr/bin/env python3
"""w66-a2 -- textmoves_audit, ALABEL-WALKER FIXED (w65-a4 SS4.2 recommendation 4).

THE FIFTH BLIND SPOT: objdiff's fuzzy_match_percent can score 100.00 on a fn whose
BRANCH WORD differs, because a PER_FN_TEXT_MOVES seal deliberately reorders our
stream and the fuzzy aligner pairs across the shift.  This compares the ENCODED
PC-relative branch words of ours-vs-expected for every TEXT_MOVES-sealed function.

w66-a2 FIX -- the w65-a4 tool's walker stopped at the next `<label>:` objdump
header, so an interior splat `alabel` (exported as a GLOBAL symbol in the expected
object) truncated the expected-side scan and manufactured bogus "PC-REL BRANCH
COUNT" rows (iFILE_ExecCommand 29v10, vramfxya 9v2, AudioCmn_SoundCar 75v23,
CD_get_intr 38v14, sprintf 63v16, FntPrint 27v11 -- all artifacts).  The walker
now takes the function's [st_value, st_value+st_size) span from the SYMBOL TABLE
(`objdump -t`) and keeps every instruction inside it, whatever labels intervene --
the same rule verify_asm.ours() implements from the oracle side.

Every flagged row also carries objdiff's per-symbol `match_percent` (the honest
metric) instead of the report's fuzzy_match_percent.
"""
import ast
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-decomp")
OD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
CLI = str(ROOT / "tools" / "objdiff" / "objdiff-cli.exe")   # vendored 3.8.0; the repo IS the version pin
BR = re.compile(r"^\s*(b\w*|j)\b")
# Only PC-relative branches are comparable in an UNLINKED object (j/jal encode an
# absolute target + R_MIPS_26).  REGIMM 0x01, beq/bne/blez/bgtz 0x04-0x07, COPz 0x10-0x13.
PCREL_OPS = {0x01, 0x04, 0x05, 0x06, 0x07, 0x10, 0x11, 0x12, 0x13}


def text_moves_table():
    src = (ROOT / "tools" / "build.py").read_text(encoding="utf-8", errors="replace")
    for node in ast.walk(ast.parse(src)):
        if isinstance(node, ast.Assign):
            for t in node.targets:
                if isinstance(t, ast.Name) and t.id == "PER_FN_TEXT_MOVES":
                    return ast.literal_eval(node.value)
    sys.exit("PER_FN_TEXT_MOVES not found in tools/build.py")


_cache = {}


def obj_view(obj):
    """{'syms': {name: (addr, size)}, 'insns': [(addr, word, text)]}"""
    key = str(obj)
    if key in _cache:
        return _cache[key]
    t = subprocess.run([OD, "-t", str(obj)], capture_output=True, text=True).stdout
    syms = {}
    for ln in t.splitlines():
        # 00000000 g     F .text  000003c0 FntFlush
        m = re.match(r"^([0-9a-f]{8})\s+\S*\s*(?:F|O|\s)\s*\.text\s+([0-9a-f]{8})\s+(\S+)$",
                     ln)
        if m:
            syms[m.group(3)] = (int(m.group(1), 16), int(m.group(2), 16))
    d = subprocess.run([OD, "-d", "-r", "-z", "--section=.text", str(obj)],
                       capture_output=True, text=True).stdout
    insns = []
    for ln in d.splitlines():
        m = re.match(r"^\s*([0-9a-f]+):\t([0-9a-f ]+)\t(.*)$", ln)
        if m:
            insns.append([int(m.group(1), 16), m.group(2).strip().replace(" ", ""),
                          m.group(3).split(";")[0].strip(), False])
        elif "R_MIPS_" in ln and insns:
            insns[-1][3] = True   # objdump -r prints the reloc AFTER its insn
    v = {"syms": syms, "insns": insns}
    _cache[key] = v
    return v


def branch_words(obj, fn):
    """PC-relative branch words of fn, walking the SYMBOL-TABLE span (so interior
    alabels never truncate the scan).  Returns None if fn is absent/size-less."""
    v = obj_view(obj)
    if fn not in v["syms"]:
        return None
    a, n = v["syms"][fn]
    if n == 0:
        return None
    # {byte-offset-in-fn: (word, carries_a_relocation)}.  A branch carrying a
    # RELOCATION (R_MIPS_PC16 in the splat-assembled expected object; R_MIPS_26 for
    # j/jal) has a PLACEHOLDER immediate (0xffff) and is NOT comparable in an
    # unlinked object -- such a PAIR is skipped (brdist, which resolves the label
    # out of the oracle .s, is the instrument there).  Pairing is by OFFSET, so the
    # two sides stay aligned even when one of them relocates a branch the other
    # resolves locally.
    return {ad - a: (w, rel) for (ad, w, t, rel) in v["insns"]
            if a <= ad < a + n and BR.match(t) and (int(w, 16) >> 26) in PCREL_OPS}


_mp = {}


def match_percents(unit):
    if unit in _mp:
        return _mp[unit]
    out = tempfile.NamedTemporaryFile("w", suffix=".json", delete=False).name
    r = subprocess.run([CLI, "diff", "-u", unit, "-o", out, "--format", "json"],
                       cwd=str(ROOT), capture_output=True, text=True)
    res = {}
    if r.returncode == 0:
        d = json.load(open(out, encoding="utf-8"))
        for s in d["right"].get("symbols", []):
            if s.get("kind") == "SYMBOL_FUNCTION" and "match_percent" in s:
                res[s["name"]] = s["match_percent"]
    Path(out).unlink(missing_ok=True)
    _mp[unit] = res
    return res


def main():
    cfg = json.loads((ROOT / "objdiff.json").read_text(encoding="utf-8"))
    src2unit = {u.get("metadata", {}).get("source_path"): u["name"] for u in cfg["units"]}
    # w66-a2: object paths come from objdiff.json, NOT from a path convention --
    # a few units live outside the mirrored layout (aiphysic's expected object is
    # expected/src/aiphysic.c.o), and the convention silently reported "missing".
    src2obj = {u.get("metadata", {}).get("source_path"):
               (ROOT / u["base_path"], ROOT / u["target_path"]) for u in cfg["units"]}
    tbl = text_moves_table()
    tot = flagged = unresolved = blind = 0
    print("%d TU(s) carry PER_FN_TEXT_MOVES entries (PC-relative branches only)\n"
          % len(tbl))
    for rel, fns in sorted(tbl.items()):
        if rel in src2obj:
            ours, exp = src2obj[rel]
        else:
            ours = ROOT / "build" / "recon" / (Path(rel).relative_to("recon").as_posix() + ".o")
            stem = Path(rel).relative_to("recon").with_suffix("")
            exp = ROOT / "expected" / "src" / (stem.as_posix() + ".c.o")
        if not ours.exists() or not exp.exists():
            print("  ?? %s: missing object (ours=%s exp=%s)"
                  % (rel, ours.exists(), exp.exists()))
            continue
        unit = src2unit.get(rel)
        for fn in sorted(fns):
            tot += 1
            a, b = branch_words(ours, fn), branch_words(exp, fn)
            if a is None or b is None:
                unresolved += 1
                print("  ?? %-52s no sized symbol (ours=%s exp=%s)"
                      % (fn, a is not None, b is not None))
                continue
            mp = match_percents(unit).get(fn) if unit else None
            tag = "match_percent=%s" % ("%.4f" % mp if mp is not None else "n/a")
            only = sorted(set(a) ^ set(b))
            if only:
                flagged += 1
                print("  !! %-52s PC-REL BRANCH POSITIONS differ (ours-only=%s "
                      "expected-only=%s)  %s"
                      % (fn, sorted(set(a) - set(b))[:4], sorted(set(b) - set(a))[:4], tag))
                continue
            skipped = sum(1 for o in a if a[o][1] or b[o][1])
            bad = [(o, a[o][0], b[o][0]) for o in sorted(a)
                   if not a[o][1] and not b[o][1] and a[o][0] != b[o][0]]
            if skipped:
                tag += " (%d reloc-pending branch(es) skipped)" % skipped
            if bad:
                flagged += 1
                mark = ""
                if mp is not None and mp >= 100:
                    blind += 1
                    mark = "   <== METRIC-BLIND"
                print("  !! %-52s %d differing PC-rel branch WORD(s) %s  %s%s"
                      % (fn, len(bad), bad[:3], tag, mark))
    print("\n%d TEXT_MOVES-sealed fns audited; %d with a real PC-relative branch-word "
          "difference; %d unresolved (no sized symbol); %d scored 100 by objdiff"
          % (tot, flagged, unresolved, blind))


if __name__ == "__main__":
    main()
