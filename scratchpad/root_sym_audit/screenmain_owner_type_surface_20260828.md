# `ScreenMain.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `ScreenMain.obj`

Source TU: `recon/frontend/common/screenmain.cpp`

`screenmain_types.h` layers ScreenMain's ten unique retained records on the
proven shared frontend graph: `POLY_G4`, the complete draw/dialog/application
records, `tVertex`, `tVideoWallConfig`, and the 1,464-byte `tScreenMain`.
`tInputKeyType` is retained without the foreign `tPlayer` tag.  The latter and
the unused `tMenuCommand` reference are storage-neutral `int` source spellings;
the member declaration preserves the exact retail GCC-v2 ProcessInput linkage
name.  The owner-retained `STREAMHANDLE` and `STREAMREQUESTID` aliases are
restored as `long` typedefs.

ScreenMain directly dereferences two foreign aggregates whose completed tags
the linked owner does not retain.  The canonical audit therefore accepts the
56-byte `tCreditManager` and `ScreenMain_GlobalMenuDefsCodegenView` only as
complete tag/typedef pairs from `screenmain_types.h`.  The menu view prices all
three accessed fields at their retail offsets: `itemTwoPlayerPinkSlips` at
`0x8f4`, `menuPinkSlipSelect` at `0xa20`, and `menuCredits` at `0x39f0`.
Every size, padding member, leaf tag, offset, and origin is pair-locked.  The
audit tool's pre-change backup is pushed commit `a4a33894`.

Strict compiler-emitted comparison:

- named records: 122/122 exact
- anonymous records: 2/2 exact
- source-only named records: 0 after exact foreign-carrier pair-locks
- source-only anonymous records: 0
- source-only typedef semantics: 0 after exact foreign-carrier pair-locks
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/screenmain.cpp`
  runs: 13/13 PASS
- focused graph: `screenmain_type_graph_p274_20260828.tsv`
- full frontend/common sweep: 24 exact owners, 17 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit and repository-wide regression gates:
  green
