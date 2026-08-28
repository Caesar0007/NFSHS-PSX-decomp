# `bworldSm.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `bworldSm.obj`

Source TU: `recon/game/common/bworldSm.cpp`

The retail graph proves that color.obj's complete 71-record game/platform
surface is a strict semantic subset of bworldSm.obj.  `bworldSm_types.h`
composes that already-exact surface and restores only bworldSm's three
additions: `Trk_NewSlice`, `BW_tContext`, and `tNormalCacheEntry`.

The former `nfs4_types.h` and `libfns.h` boundary supplied the required
layouts and calls but leaked 472 unrelated named records, nine anonymous
records, and 540 unrelated typedef semantics into this owner.  The owner-local
header and typed extern declarations remove that leakage.

`Track_chunkList` belongs to chunk.obj.  Retail instructions dereference five
of its fields, while bworldSm.obj's linked debug graph deliberately omits the
complete `Chunk` tag.  `BWorldSm_ChunkCodegenView` retains the exact owner
offsets at 56, 72, 76, 104, and 108 without importing chunk.obj's type graph.
The canonical audit suppresses this compiler-boundary view only when its full
112-byte tag and typedef pair, every member, offset, leaf tag, and source owner
agree.  Any drift remains a visible failure.  The audit-tool pre-change backup
is Git commit `5163e832`.

Strict compiler-emitted comparison:

- named records: 74/74 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- every distinct retail typedef semantic is present; linked duplicate typedef
  multiplicities remain recorded as debug-duplication evidence
- result: `OK`

Matching regression:

- two successive `python tools/tugate.py recon/game/common/bworldSm.cpp` runs:
  28/28 PASS

Project-wide graph regression: 458 owners scanned, 331 `OK`, 86 `DIFF`, 30
known debug-compile failures, and 11 unresolved owner mappings.  Comparing the
machine-readable rows against p298 shows exactly one status change:
`bworldSm.cpp` moved from `DIFF` to `OK`; no owner regressed.

Evidence:

- focused graph: `bworldsm_type_graph_p299_20260828.tsv`
- project graph: `project_type_graph_p300_20260828.tsv`

Repository integrity regression:

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols
- zero calls to undefined symbols in both lanes and zero proven wrong call
  targets
- 513 objects with zero TU-order inversions
- no unsafe direct vtable-row indexing in 983 files
- no post-compiler text moves or branch retargets
- full phantom rebuild: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  zero hidden phantoms, and zero unmatched ownership gaps

The phantom rebuild's optional `2.8.1-norcse` ladder warning is unchanged and
does not affect ownership proof: all 513 TUs compiled and all ownership counts
are exact.
