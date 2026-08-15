import os

p = r'C:\Temp\nfs4-decomp\scratchpad\w64a6\RECEIPTS.md'
d = open(p, 'rb').read()

old = b"""```json
{"recon/syslib/psx/libcd/cdread.c": {"CdRead": [{
   "take":  "\\\\tsw\\\\t\\\\$20,0\\\\(\\\\$16\\\\)\\\\n(?=\\\\t#\\\\.set\\\\tnovolatile\\\\n\\\\tjal\\\\tCdSyncCallback\\\\n)",
   "after": "\\\\tjal\\\\tCdSyncCallback\\\\n(?=\\\\tmove\\\\t\\\\$4,\\\\$0\\\\n)",
   "slot":  true }]}}
```
"""
assert d.count(old) == 1, ("a", d.count(old))
new = ("""```json
{"recon/syslib/psx/libcd/cdread.c": {"CdRead": [
  {"take":  "\\\\tsw\\\\t\\\\$18,24\\\\(\\\\$sp\\\\)\\\\n",
   "after": "\\\\tsw\\\\t\\\\$31,36\\\\(\\\\$sp\\\\)\\\\n"},                      <-- the EXISTING w62-a6 row
  {"take":  "\\\\tsw\\\\t\\\\$20,0\\\\(\\\\$16\\\\)\\\\n(?=\\\\t#\\\\.set\\\\tnovolatile\\\\n\\\\tjal\\\\tCdSyncCallback\\\\n)",
   "after": "\\\\tjal\\\\tCdSyncCallback\\\\n(?=\\\\tmove\\\\t\\\\$4,\\\\$0\\\\n)",
   "slot":  true}                                              <-- THE NEW ROW
]}}
```
🔴 **THE FILE CARRIES BOTH ROWS ON PURPOSE, and this is a PROCESS FINDING worth a catalog
line.** `build.py` already has a `PER_FN_TEXT_MOVES[...cdread.c]["CdRead"]` LIST (the
w62-a6 prologue move), and vprobe's hook does
`bld.PER_FN_TEXT_MOVES.setdefault(rel, {}).update(_v)` -- `.update()` REPLACES the whole
`"CdRead"` list. A probe file holding only the NEW row therefore silently measures
*"my row INSTEAD OF the existing one"*, not the state wiring would produce. First
measurement (new row alone) and the corrected one (both rows) happen to agree at 2, but
the reading was accidental, not sound. **Rule: a TEXT_MOVES probe file must carry the
FINAL INTENDED LIST for that function, never just the delta.** Both anchors of the
existing row still `count == 1` after the w64 fence removal, so it is still firing --
it is not a dead row.
**Wiring action = APPEND the second dict to the existing `"CdRead": [ ... ]` list**
(build.py:1673-1677), never a second `"recon/syslib/psx/libcd/cdread.c":` key -- the 12F
duplicate-key shadowing hazard, which has fired four times in this campaign.
""").encode("utf-8")
d = d.replace(old, new, 1)

old2 = b"""### PROBED 2x VIA vprobe (`W60_TEXT_MOVES_FILE`), WHOLE TU, ZERO PASS->FAIL
| fn | control | with the row (run 1) | with the row (run 2) |
|---|---|---|---|
| **CdRead** | FAIL 5 (104/103) | **FAIL 2 (103/103) COUNT-EXACT** | **FAIL 2 (103/103)** |
"""
assert d.count(old2) == 1, ("b", d.count(old2))
new2 = b"""### PROBED 2x VIA vprobe (`W60_TEXT_MOVES_FILE`), WHOLE TU, ZERO PASS->FAIL
Control = the tree as committed (existing row only). "with the rows" = the final intended
list (existing + new), run twice.
| fn | control | with the rows (run 1) | with the rows (run 2) |
|---|---|---|---|
| **CdRead** | FAIL 5 (104/103) | **FAIL 2 (103/103) COUNT-EXACT** | **FAIL 2 (103/103)** |
"""
d = d.replace(old2, new2, 1)

old3 = b"Note for wiring: `cdread.c` **already has** a `PER_FN_TEXT_MOVES` entry (build.py:1664) --\nper 12F the `rel` key is a python dict literal, so this row must be MERGED into that\nexisting entry's dict, never added as a second `\"recon/syslib/psx/libcd/cdread.c\":` key\n(a duplicate key is silently shadowed; that hazard has fired four times in the campaign).\n"
assert d.count(old3) == 1, ("c", d.count(old3))
new3 = b"The objdump proof above was re-run on the BOTH-ROWS object and is unchanged (103/103,\none REAL word, slot PASS, branches PASS). Wiring action: append, per the note above.\n"
d = d.replace(old3, new3, 1)

tmp = p + '.tmp'
open(tmp, 'wb').write(d)
assert os.path.getsize(tmp) > 100
os.replace(tmp, p)
b = open(p, 'rb').read()
print('ok CR', b.count(13), 'NUL', b.count(0), 'size', len(b))
