# `FEMemCard.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `FEMemCard.obj`

Source TU: `recon/frontend/common/fememcard.cpp`

`fememcard_types.h` restores the owner's retained memory-card surface on top
of the already exact FECheats shared frontend graph.  The include is filtered
only for FECheats' two private cheat records and its foreign `tRecordBuffer`
carrier; FEMemCard's own `tRecordBuffer` definition remains visible.  The
owner-specific graph restores `AudioMus_tSongEntry`, `CARDINFO_def`,
`DIRENTRY`, `EXEC`, the three FE3d records, `MANAGERTASK`, the four MCRD
records, `MCRDOPTS_def`, `PinkSlipsErrorCode`, `PRODUCTLOC`, `TCB`,
`tDialogYesNoMem`, `tMemCardData`, `tRecordBuffer`, and the three save-data
records.  The retained public spellings `CARDINFO`, `MCRDFILEHEADER`,
`MCRDFILEINFO`, `MCRDFILE`, `MCRDOPTS`, `MemCB`, and `tSaveRecords`, plus the
three FE3d aliases, are also present with their exact semantics.

The filtered shared dialog declarations expose only the constructor,
destructor, `Hide`, `Run`, and four-argument `SetChoices` surfaces that this
owner uses.  In particular, restoring `tScreen` construction/destruction and
the standalone `tDialogYesNo` constructor reproduces the retail implicit
special-member call chain; omitting those declarations changes four matched
functions.  FECheats itself remains unchanged at 10/10 PASS.

FEMemCard directly dereferences three foreign objects whose completed owning
tags are not retained in this object.  The canonical audit therefore accepts
only exact tag/typedef pairs for the 84-byte pad view, 56-byte memory-card-info
view, and 1,444-byte screen-memcard view.  Every size, padding member, field
offset, leaf tag/type, and source origin is pair-locked.  The audit tool's
pre-change backup is pushed commit `5f4a3318`.

Strict compiler-emitted comparison:

- named records: 131/131 exact
- anonymous records: 2/2 exact
- source-only named records: 0 after exact foreign-view pair-locks
- source-only anonymous records: 0
- source-only typedef semantics: 0 after exact foreign-view pair-locks
- result: `OK`

Verification:

- repeated `python tools/tugate.py recon/frontend/common/fememcard.cpp` runs:
  18/18 PASS
- `python tools/tugate.py recon/frontend/common/fecheats.cpp`: 10/10 PASS
- focused graph: `fememcard_type_graph_p275_20260828.tsv`
- full frontend/common sweep: 25 exact owners, 16 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing names, extras, type findings,
  storage findings, or mapping-review entries
