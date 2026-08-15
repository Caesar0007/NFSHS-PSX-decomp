import json

# W64-A6 -- PER_FN_TEXT_MOVES row for CdRead's `jal CdSyncCallback` delay slot.
#
# RETAIL (asm/nonmatchings/main/CdRead.s:80-83):
#     sw   $s3, 0x4($s0)          ; w04 = buf
#     jal  CdSyncCallback
#      sw  $s4, 0x0($s0)          ; DELAY SLOT -- w00 = sectors
#     addu $a0, $zero, $zero
# OURS (build/recon/syslib/psx/libcd/cdread.c.s, post-nosplit-splice):
#     sw   $19,4($16)   /  sw $20,0($16)  /  jal CdSyncCallback  /  move $4,$0
#   -> maspsx (is_reorder) appends the nop, so the slot is empty.
# $19 = $s3 (buf), $20 = $s4 (sectors), $16 = $s0.  The store to MOVE is the
# w00 one = `sw $20,0($16)`  (an earlier receipt said $19 -- that is the w04
# store at displacement 4 and is NOT the one retail slots).
#
# `slot: True` wraps the anchor in `.set noreorder` ... `.set reorder`, which is
# what stops maspsx materialising the branch nop, so NO drop_nop is needed (the
# .s carries no nop of its own at this point).
#
# ANCHOR LAWS (15D/12F) honoured:
#   * NUMERIC registers ($20/$16/$4), never ABI names.
#   * label-agnostic (no $L... appears in either anchor; the nosplit splice
#     renumbers every label to $Lnosplit3_NN).
#   * BOTH anchors lookahead-pinned.  The `after` pin is LOAD-BEARING: the
#     unpinned `\tjal\tCdSyncCallback\n` matches TWICE in the CdRead region and
#     _apply_text_moves takes the FIRST -- which is the watchdog arm's call,
#     already inside a `.set noreorder/.set nomacro` block with
#     `addu $16,$16,-40` in its slot.  Splicing there would have been a silent
#     mis-fire of exactly the kind 12F warns about.
#   * verified count == 1 for both pinned anchors over the .ent/.end region
#     (scratchpad/w64a6/tm_count.py).

TAKE = (r"\tsw\t\$20,0\(\$16\)\n"
        r"(?=\t#\.set\tnovolatile\n\tjal\tCdSyncCallback\n)")
AFTER = (r"\tjal\tCdSyncCallback\n"
         r"(?=\tmove\t\$4,\$0\n)")

# 🔴 build.py ALREADY carries a PER_FN_TEXT_MOVES["...cdread.c"]["CdRead"] LIST with the
# w62-a6 prologue row.  The vprobe hook does `.update(_v)`, which REPLACES that whole
# list -- so a probe file holding only the new row silently measures the WRONG state
# (my row INSTEAD OF the existing one).  This file therefore carries the FINAL INTENDED
# LIST: the existing row verbatim, then the new one.  The wiring action is an APPEND to
# that list, never a second dict key (12F duplicate-key shadowing).
EXISTING = {"take": r"\tsw\t\$18,24\(\$sp\)\n", "after": r"\tsw\t\$31,36\(\$sp\)\n"}

TABLE = {
    "recon/syslib/psx/libcd/cdread.c": {
        "CdRead": [
            EXISTING,
            {"take": TAKE, "after": AFTER, "slot": True},
        ],
    },
}

p = r"C:\Temp\nfs4-decomp\scratchpad\w64a6\tm_cdread.json"
with open(p, "w", encoding="ascii", newline="\n") as f:
    json.dump(TABLE, f, indent=1)
    f.write("\n")
print(open(p, encoding="ascii").read())
# round-trip proof (14F): the decoded strings must be the ORIGINAL regexes
back = json.load(open(p, encoding="ascii"))
rows = back["recon/syslib/psx/libcd/cdread.c"]["CdRead"]
assert rows[0] == EXISTING, rows[0]
mv = rows[1]
assert mv["take"] == TAKE and mv["after"] == AFTER and mv["slot"] is True
print("round-trip OK")
