# P887 verified checkpoint — 2026-09-07

The scoped regression, native-storage and reference checks passed. **The main goal remains incomplete:** this checkpoint does not establish that the whole project is SYM-exact, SLD-exact, fully source-restored, or a byte-exact final linked image.

Authoritative results are in [full_validation_receipts.json](C:/Temp/nfs4-decomp/scratchpad/p887_checkpoint/full_validation_receipts.json) and [final_receipts.json](C:/Temp/nfs4-decomp/scratchpad/p887_checkpoint/final_receipts.json). The latter explicitly records `goal_complete: false`.

## Verified scope

| Check | Result and boundary |
| --- | --- |
| Protected base source regression | **470/470 PASS across 24 base TUs**, with zero branch divergences. This is the covered P879–P887 regression set, not a whole-game percentage. |
| Full-build reproducibility | All three build lanes completed without skipped/failed TUs; **518/518 recon source objects reproduced** their accepted post-edit prebuild hashes (`changed_objects: []`). This proves rebuild consistency, not that all 518 objects equal retail or their pre-change versions. |
| Initialized source owners | **18 registered owners** verified at their native placements, with exact payloads/padding and oracle-only raw-copy exclusions. The src lane retains its raw copies. |
| Native zero-storage owners | **3 real NOBITS windows, 9,296 reserved bytes**, with native section/symbol contracts. These are not fabricated initialized zero-byte payloads. |
| ISO/stream references | **311 reference words equal raw retail; 156 newly corrected** relative to the captured baseline. No known native public-binding regressions. The other 155 words were already correct. |
| Prior vars references | All **438 prior words preserved**, plus **4 newly canonical ticks references** after retiring ticksA: **442/442** current named-reference words exact, across 46 native public bindings. |
| Prior table references | **50/50 preserved**: 34 math-table reference words plus 16 TABLE/SNDEF/atantbl reference words. These are preservation counts, not 50 new fixes. |

The exact 24-TU list, counts, object hashes and branch receipts are in [checkpoint_source_receipts.json](C:/Temp/nfs4-decomp/scratchpad/p887_checkpoint/checkpoint_source_receipts.json). The initialized-owner placement proof is [production_receipt.json](C:/Temp/nfs4-decomp/scratchpad/p887_checkpoint/production_receipt.json). It also retains the CTYPE/table seam checks and all 34 Hud string aliases/raw pointer references.

## Native NOBITS placement

| Source input | Native interval, end exclusive | Reserved bytes |
| --- | --- | ---: |
| C_005.c, .bss.st_80144874 | 0x80144874–0x8014487C | 8 |
| iso9660.c, .bss | 0x8014487C–0x80146C7C | 9,216 |
| CDROM.c, .bss.st_80146C7C | 0x80146C7C–0x80146CC4 | 72 |

The completed [ISO/stream production proof](C:/Temp/nfs4-decomp/scratchpad/p887_iso/production_receipts.json) establishes these placements and the 311 exact reference words. The earlier [ISO investigation](C:/Temp/nfs4-decomp/scratchpad/p887_iso/README.md) documents canonical SDK/raw-address/name evidence; its descriptions of proposed or previously misplaced windows are historical, not the final checkpoint state. Native private-name and full-source questions not proved by those records remain open. Four deliberately malformed zero-storage contracts were rejected by the validation tests, without modifying objects.

## P887 source and data changes

- **FEVideoWall:** restored scalar ticks, removed ReadVideoWallTicks, both ticksA views and both tickCounter locals. All 12 methods PASS; all 483 text words resolve exactly to raw retail. The final ELF is not identical to its original baseline: 24 bytes of alias metadata disappear and four relocations now name ticks. See the [source receipt](C:/Temp/nfs4-decomp/scratchpad/p887_fevideowall/README.md).
- **Remaining gHelpShapes aliases:** removed three regional fedialog aliases and drawshp's alias, correcting 16 false outer accesses while preserving genuine corner pointers. Drawshp's whole-TU G0 identity and native corner-before-tint statement order preserve all four matching functions. Code/text relocations remain unchanged; kNoColor's four bytes move from .sdata to native .data, so whole-object identity against its old G4 baseline is not claimed. All six selected regional fedialog checks remain PASS. See the [source/flag receipt](C:/Temp/nfs4-decomp/scratchpad/p887_ghelp_alias/README.md).
- **kNoColor ownership:** the raw residual is split into 32-byte prefix, four-byte native cell and 356-byte suffix. Both isolated baseline/src links preserve all **392 bytes and 31 label addresses**, including the anonymous zero word at 0x800529D4. The cell is now included among the 18 validated initialized source owners. See the [raw-split receipt](C:/Temp/nfs4-decomp/scratchpad/p887_knocolor/README.md).

The 518-object reproduction check starts after these accepted changes. It must not be used to erase the documented FEVideoWall metadata change or drawshp data-section correction.

## Corrected assertion fixtures

Two verification-fixture issues were corrected without weakening code/reference checks:

1. A hand-transcribed expected SHA for C_005.c was wrong. The unchanged actual hash was independently present in the prebuild snapshot. [first_validation_attempt.json](C:/Temp/nfs4-decomp/scratchpad/p887_checkpoint/first_validation_attempt.json) preserves the assertion and both strings; the completed receipts record the subsequent full 24-TU source/policy recheck.
2. The old named-reference count of 438 became stale when four FEVideoWall HI/LO sites changed from ticksA to canonical ticks. The corrected assertion requires **every old relocation key plus exactly those four new ticks keys**, rather than merely accepting a larger count. Compare [prior vars receipts](C:/Temp/nfs4-decomp/scratchpad/p886_vars/final_consumers.json), [P887 vars receipts](C:/Temp/nfs4-decomp/scratchpad/p886_vars/p887_consumers.json), and the explicit set checks in [full_validation.py](C:/Temp/nfs4-decomp/scratchpad/p887_checkpoint/full_validation.py).

## Remaining debt — do not report global completion

The complete GP comparator checks all **2,381** relocations: none unresolved, out of range, or incorrectly encoded for its selected binding. Nevertheless **1,433 still select the wrong native target while remaining in range**. It records 263 fixed native targets against its comparison baseline and **zero regressions**; that cumulative GP count is separate from the 156 newly corrected ISO/stream words. Use the complete 1,433 figure, not the preliminary 1,430 result that lacked three expected-target classifications. Four native/raw conflicts remain recorded.

The initialized-owner diagnostic records **130 allocated-output overlap pairs**. The three native NOBITS windows still intersect legacy replay/data-rest output sections. Those overlaps, other unplaced/duplicate data and outstanding source/name/type/SLD review work are not solved by correct individual owner addresses.

The relink policy gate is GREEN with zero real duplicates, hidden phantoms or relocation-referenced unresolved symbols, but still classifies **851 duplicates as existing blob copies**; the reconstruction partial-link command itself reports rc=1 for those duplicates. The permissive diagnostic ELF and a green policy gate are not a clean final-image link. Src-lane duplicate checks remain clean.

The completed vtable audit reports no unsafe row indexing in 1,029 files, and the source-policy audit reports no configured post-compiler text moves or branch retargets. These checks preserve their stated scope; they do not prove every record or source body restored. Continue the main goal from the remaining evidence-backed backlog.
