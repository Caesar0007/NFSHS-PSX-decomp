# `Movie.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `Movie.obj`

Source TU: `recon/frontend/psx/movie.cpp`

The retail graph proves that color.obj's complete 71-record platform/game
surface is a strict semantic subset of Movie.obj.  `movie_types.h` composes
that already-exact surface and restores only Movie's twelve additions:
`CdlLOC`, `CdlFILE`, `TCB`, `EXEC`, `DIRENTRY`, `kernpair`, the four retained
sound-system records, `DECENV`, and `CDSECTOR`.

The prior `nfs4_types.h` and `libfns.h` includes supplied the required layouts
but leaked 463 unrelated named records, nine unrelated anonymous records, and
525 unrelated typedef semantics into Movie.obj.  The owner-local header and
typed extern boundary remove that leakage.  Decompiler-only `byte`, `uint`,
and `fn_void` spellings were replaced with retail-backed `u_char`, `u_int`,
and `CallbackFunc`; the unused `longlong` and `ulonglong` aliases were removed.

Strict compiler-emitted comparison:

- named records: 83/83 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- all 147 distinct retail typedef semantics covered
- repeated byte-identical retail tag/typedef rows remain recorded as linked
  debug duplication evidence rather than being mistaken for distinct C types
- result: `OK`

Matching regression:

- two successive `python tools/tugate.py recon/frontend/psx/movie.cpp` runs:
  17/17 PASS

Project-wide graph regression: 458 owners scanned, 330 `OK`, 87 `DIFF`, 30
known debug-compile failures, and 11 unresolved owner mappings.  This improves
the preceding census by exactly one owner (`Movie.obj`: `DIFF` to `OK`) with
no owner regression.

Evidence:

- focused graph: `movie_type_graph_p297_20260828.tsv`
- project graph: `project_type_graph_p298_20260828.tsv`

Repository integrity regression:

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols
- zero calls to undefined symbols in both lanes and zero proven wrong call
  targets
- 513 objects with zero TU-order inversions
- no unsafe direct vtable-row indexing in 982 files
- no post-compiler text moves or branch retargets
- full phantom rebuild: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  zero hidden phantoms, and zero unmatched ownership gaps
