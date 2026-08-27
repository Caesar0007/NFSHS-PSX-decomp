# `FEInput.obj` owner type-surface receipt

Date: 2026-08-27

Retail owner: `FEInput.obj`

Source TU: `recon/frontend/common/feinput.cpp`

`feinput_types.h` now exposes the exact shared frontend/core graph plus only
the four records present in this owner: `tInputKeyType`, `tPlayer`,
`AudioMus_tSongEntry`, and `tPSXToFEMapping`.

FEInput.obj retains `PAD_COMMON` but no 84-byte `tPadModuleState` tag.  The
global definition record proves `gPadinfo` belongs to pad.obj as anonymous
`.63fake`, while retail instructions require the symbol base and `buf` at
offset +4.  `FEInput_PadCodegenView` records that foreign layout without
claiming a recoverable original tag name.  The canonical audit suppresses it
only when its struct and typedef pair, 84-byte size, complete member graph,
and owning `feinput_externs.h` all agree; any drift is reported.

Strict compiler-emitted comparison:

- named records: 55/55 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/feinput.cpp`
  runs: 4/4 PASS
- focused graph: `feinput_type_graph_p257_20260827.tsv`
- full frontend/common sweep: 7 exact owners, 34 remaining visibility residuals
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing/extra/type/storage findings
- both relink lanes and all structural/call-target gates: green
