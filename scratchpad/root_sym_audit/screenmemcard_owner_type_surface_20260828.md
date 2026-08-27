# `ScreenMemcard.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `ScreenMemcard.obj`

Source TU: `recon/frontend/common/screenmemcard.cpp`

`screenmemcard_types.h` composes two already exact retail surfaces: the
complete `color.obj` physics graph and ScreenDisplay's shared frontend graph,
with only ScreenDisplay's owner class and foreign-global view disabled.  Their
canonical union covers 147 of ScreenMemcard's 171 retained named records.  The
remaining owner surface restores the PsyQ `POLY_FT4`, memory-card records and
public aliases, FE3d records and aliases, retained input-key enum, dialog
leaves, draw extension, save-data records, and the complete 1,444-byte
`tScreenMemcard` class.  `tMemIcon` is restored as the retail
`char[15][3][192]` typedef.  Synthetic `longlong`, `ulonglong`, `uchar`, and
`MemCB` typedefs were removed; the one source use now uses the canonical
`u_char` spelling.

The filtered ScreenDisplay base declares `tScreen` construction and
destruction only for this consumer.  That preserves ScreenMemcard's retail
implicit base special-member chain without broadening the declaration surface
of other exact owners.

The owner directly reads `tFEApplication::fInputPlayer` and the adjacent
`tGlobalMenuDefs::itemSaveGame` / `itemLoadGame` pair, although neither
completed foreign tag is retained in ScreenMemcard.obj.  It also requires a
named four-byte bitfield carrier to express the PsyQ primitive-link writes
without an extra anonymous debug record.  The canonical audit accepts these
three records only as complete tag/typedef pairs from `screenmemcard_types.h`;
every size, field, bit width, offset, leaf tag, and origin is pair-locked.  The
audit tool's pre-change backup is pushed commit `bbbe104b`.

Strict compiler-emitted comparison:

- named records: 171/171 exact
- anonymous records: 2/2 exact
- source-only named records: 0 after exact foreign/codegen pair-locks
- source-only anonymous records: 0
- source-only typedef semantics: 0 after exact pair-locks
- result: `OK`

Verification:

- repeated `python tools/tugate.py recon/frontend/common/screenmemcard.cpp`
  runs: 15/15 PASS
- focused graph: `screenmemcard_type_graph_p276_20260828.tsv`
- full frontend/common sweep: 26 exact owners, 15 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing names, extras, type findings,
  storage findings, or mapping-review entries
