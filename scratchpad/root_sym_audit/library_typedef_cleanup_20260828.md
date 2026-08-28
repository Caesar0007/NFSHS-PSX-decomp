# Library typedef-boundary cleanup receipt

Date: 2026-08-28

Owners:

- `spchsamp.obj`
- `libpad.lib(PAD.obj)`
- `libpad.lib(PADCMD.obj)`

Each retail owner has an empty linked type graph.  The reconstruction emitted
one source-only typedef record per owner:

- `spchsamp.c`: an unused decompiler-only `typedef int bool` plus unused
  `true`/`false` macros
- `PAD.c`: `PadIntFn`, used only to spell the `padIntFunc` data array
- `PADCMD.c`: `PadSndRcv`, used only to cast callback-slot stores

The unused speech aliases were deleted.  The two pad callback signatures are
now written directly at their declarations/casts, preserving the exact
function-pointer ABI and initialized storage without inventing a source typedef
record.  This is a source correction, not an audit suppression; the canonical
audit tool required no change.

Strict p304 result:

- all three owners move from `DIFF` to `OK`
- each owner has zero retail/source named, anonymous, and typedef records
- the full 458-owner census reports 343 `OK`, 74 `DIFF`, 30 known
  debug-compile failures, and 11 unresolved owner mappings
- row-by-row comparison with p303 shows exactly these three transitions and no
  other owner status change

Matching regression, run twice after the edits:

- `spchsamp.c`: 2/2 PASS
- `PAD.c`: data-only owner, 0/0 function gate PASS
- `PADCMD.c`: 19/19 PASS

Evidence:

- `project_type_graph_p304_20260828.tsv`

Repository integrity regression:

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols
- zero calls to undefined symbols in both lanes and zero proven wrong call
  targets across 460 audited units
- 513 objects with zero TU-order inversions
- no unsafe direct vtable-row indexing in 983 files
- no post-compiler text moves or branch retargets
- full phantom rebuild: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  zero hidden phantoms, and zero unmatched ownership gaps

The phantom rebuild's optional `2.8.1-norcse` ladder warning is unchanged and
does not affect this proof: all TUs compiled and all ownership counts are exact.
