#!/usr/bin/env python3
"""w65a4 -- THE FIFTH BLIND SPOT: fuzzy_match_percent can score 100 on a
function whose BRANCH WORD differs, when our instruction stream is REORDERED
relative to expected.

W64-A21 sec.2 concluded "the board is NOT lenient about branch words".  That is
true when the two streams are in the same order (the aligner pairs the branches
and charges 0.05 for the differing destination argument) -- but a
PER_FN_TEXT_MOVES seal deliberately RELOCATES lines, and the fuzzy aligner can
then pair instructions across the shift and report 100.00 while the encoded
branch word still differs.

Counter-example (measured): Camera_UpdateHeliCam__Fii
    ours     branch #26  word 04610003  (bgez, distance 4)
    expected branch #26  word 04610002  (bgez, distance 3)
    board fuzzy_match_percent = 100.00
    objdiff per-symbol match_percent = 99.809
    brdist = (26, 4, 3)

So PER_FN_TEXT_MOVES functions are exactly the population where the board can be
flattered.  This audit compares the ENCODED BRANCH WORDS of our object against
the expected object, directly, for every TEXT_MOVES-sealed function.
"""
import ast
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-decomp")
OD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
BR = re.compile(r"^\s*(b\w*|j)\b")


def text_moves_table():
    """Pull PER_FN_TEXT_MOVES out of build.py without executing it."""
    src = (ROOT / "tools" / "build.py").read_text(encoding="utf-8", errors="replace")
    tree = ast.parse(src)
    for node in ast.walk(tree):
        if isinstance(node, ast.Assign):
            for t in node.targets:
                if isinstance(t, ast.Name) and t.id == "PER_FN_TEXT_MOVES":
                    return ast.literal_eval(node.value)
    sys.exit("PER_FN_TEXT_MOVES not found in tools/build.py")


# ONLY PC-relative branches are comparable in an UNLINKED object.  j/jal
# (opcodes 0x02/0x03) encode an ABSOLUTE target and carry R_MIPS_26 relocations,
# so ours-vs-expected differ purely from section/symbol layout -- exactly the
# reason w64a21's calltarget_audit excludes section-relative .text+addend relocs.
# Comparable: REGIMM 0x01 (bgez/bltz/...), beq 0x04, bne 0x05, blez 0x06,
# bgtz 0x07, and the COPz branches 0x10-0x13.
PCREL_OPS = {0x01, 0x04, 0x05, 0x06, 0x07, 0x10, 0x11, 0x12, 0x13}


def is_pcrel(word_hex):
    return (int(word_hex, 16) >> 26) in PCREL_OPS


# 🔴 KNOWN LIMITATION -- read before trusting a "PC-REL BRANCH COUNT" row.
# This walker stops at the next `<label>:` header, so an interior splat `alabel`
# (which the EXPECTED object exports as a global symbol, splitting objdump's
# disassembly mid-function) truncates the expected-side scan and manufactures a
# bogus count mismatch.  It is the same hazard verify_asm documents for ours():
# "ours() must continue THROUGH interior alabels".  Every large count-mismatch
# row below (iFILE_ExecCommand 29v10, vramfxya 9v2, AudioCmn_SoundCar 75v23,
# CD_get_intr 38v14, sprintf 63v16, FntPrint 27v11) is this artifact, NOT a
# finding -- several of them are board 100.00, which is the tell.
# The WORD-comparison rows (equal counts) are the trustworthy output.
def branch_words(obj, fn):
    d = subprocess.run([OD, "-d", "-r", "-z", str(obj)],
                       capture_output=True, text=True).stdout
    body, on = [], False
    for ln in d.splitlines():
        m = re.match(r"^([0-9a-f]{8}) <(.+)>:", ln)
        if m:
            on = (m.group(2) == fn)
            continue
        if not on:
            continue
        m = re.match(r"^\s*([0-9a-f]+):\t([0-9a-f ]+)\t(.*)$", ln)
        if m:
            body.append((m.group(2).strip().replace(" ", ""),
                         m.group(3).split(";")[0].strip()))
        elif ln.strip() == "":
            on = False
    return [w for w, t in body if BR.match(t) and is_pcrel(w)]


import json  # noqa: E402
D = ROOT / "scratchpad" / "w65a4"
board = {tuple(k.split("|", 1)): v
         for k, v in json.load(open(D / "board_rows.json")).items()}
gate = {tuple(k.split("|", 1)): v
        for k, v in json.load(open(D / "gate_rows.json")).items()}
cfg = json.loads((ROOT / "objdiff.json").read_text(encoding="utf-8"))
src2unit = {u.get("metadata", {}).get("source_path"): u["name"] for u in cfg["units"]}

tbl = text_moves_table()
tot = flagged = blind = 0
print(f"{len(tbl)} TU(s) carry PER_FN_TEXT_MOVES entries "
      f"(PC-relative branches only; j/jal excluded)\n")
for rel, fns in sorted(tbl.items()):
    ours = ROOT / "build" / "recon" / (Path(rel).relative_to("recon").as_posix() + ".o")
    # expected object mirrors the src stub: expected/src/<rel-without-recon>.c.o
    stem = Path(rel).relative_to("recon").with_suffix("")
    exp = ROOT / "expected" / "src" / (stem.as_posix() + ".c.o")
    if not ours.exists() or not exp.exists():
        print(f"  ?? {rel}: missing object (ours={ours.exists()} exp={exp.exists()})")
        continue
    unit = src2unit.get(rel)
    for fn in sorted(fns):
        a, b = branch_words(ours, fn), branch_words(exp, fn)
        tot += 1
        fz = board.get((unit, fn))
        gv = gate.get((unit, fn))
        tag = f"board={fz} gate={gv}"
        if len(a) != len(b):
            flagged += 1
            print(f"  !! {fn}: PC-REL BRANCH COUNT ours={len(a)} expected={len(b)}  {tag}")
            continue
        bad = [(i, x, y) for i, (x, y) in enumerate(zip(a, b)) if x != y]
        if bad:
            flagged += 1
            # THE BLIND SPOT: board says 100 although a real branch word differs
            mark = ""
            if fz is not None and fz >= 100:
                blind += 1
                mark = "   <== BOARD-BLIND"
            print(f"  !! {fn}: {len(bad)} differing PC-rel branch WORD(s) "
                  f"{bad[:3]}  {tag}{mark}")
print(f"\n{tot} TEXT_MOVES-sealed fns audited; {flagged} with a real PC-relative "
      f"branch-word difference; {blind} of those are scored 100.00 by the board")
