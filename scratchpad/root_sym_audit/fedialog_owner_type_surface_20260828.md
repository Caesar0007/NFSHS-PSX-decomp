# `FEDialog.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `FEDialog.obj`

Source TU: `recon/frontend/common/fedialog.cpp`

`fedialog_types.h` composes ScreenMemcard's already exact shared frontend,
physics, tournament, dialog, memory-card, and PsyQ surfaces while excluding
the eight completed records which belong only to ScreenMemcard.obj.  It then
restores FEDialog's eight owner additions: `helpKeyData`, `tHelpData`,
`tDialogBackUpOnly`, `tDialogYesNoMem`, `tDialogYesNoTri`, `tFEApplication`,
`tMenuCommand`, and `tPlayer`.  Source-only text enum spellings remain integer
literals because FEDialog.obj emits no completed text-enum records.

The declaration gates expose only the FEDialog member functions and inline
receivers used by this TU.  In particular, the `tMenu` flag predicates and
the dialog virtual-dispatch helpers retain the exact retail inline source
shape without broadening the shared type surface for other owners.

FEDialog directly reads pad.obj's anonymous 84-byte `gPadinfo` aggregate, but
the linked owner does not retain its completed tag.  The canonical audit
filters `FEDialog_PadCodegenView` only as an exact tag/typedef pair from the
FEDialog owner header: its size, `initialized`, eight `PAD_COMMON` entries,
16 trailing state bytes, member offsets, leaf tag, and source origin are all
pair-locked.  Any layout or ownership drift therefore reappears as a graph
failure.  The audit tool's pre-change backup is pushed commit `2198f1eb`.

Strict compiler-emitted comparison:

- named records: 171/171 exact
- anonymous records: 2/2 exact
- source-only named records: 0 after the exact foreign-pad pair-lock
- source-only anonymous records: 0
- source-only typedef semantics: 0 after the exact pair-lock
- result: `OK`

Verification:

- repeated `python tools/tugate.py recon/frontend/common/fedialog.cpp` runs:
  33/33 PASS
- exact-neighbor regressions: ScreenMemcard 15/15 PASS, ScreenDisplay 3/3
  PASS, FEMemCard 18/18 PASS, FECheats 10/10 PASS
- focused graph: `fedialog_type_graph_p277_20260828.tsv`
- full frontend/common sweep: 27 exact owners, 14 remaining visibility
  residuals
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing names, extras, type findings,
  storage findings, or mapping-review entries
