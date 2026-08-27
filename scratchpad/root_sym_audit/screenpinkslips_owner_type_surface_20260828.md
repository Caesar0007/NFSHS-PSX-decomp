# ScreenPinkSlips owner type-surface receipt

Date: 2026-08-28

Owner: `ScreenPinkSlips.obj`
Source: `recon/frontend/common/screenpinkslips.cpp`
Pre-change backup: Git commit `df189daa`

## Result

- Focused canonical type graph: `OK`.
- Named tags: 163/163 exact.
- Anonymous tags: 2/2 covered.
- Authoritative function matching: 8/8 PASS.
- Frontend/common board after this owner: 36 exact owners, 5 residual owners.

## Restored owner surface

`screenpinkslips_types.h` reuses the proven ScreenTournSelect shared graph and
adds only the records retained by ScreenPinkSlips: the mission/academy records,
sound-system leaves, `FLARE_PIECE_DEF`, `tMenuTextState`, the complete 896-byte
`tFEApplication`, and the 712-byte owner class.

The linked object retains `tSaveRecords[187]` but attributes the completed
`tRecordBuffer` body elsewhere.  Its exact 20-byte compiler carrier is therefore
pair-locked while the public array typedef remains visible to the audit.

The foreign FEMenuDefs aggregate is represented by a pair-locked 3,988-byte
view: `iteratorTrack` at `0xc88`, `itemTraffic` at `0xf4c`, and
`itemLocalSpeech` at `0xf70`.  The full aggregate tag is correctly absent.
Enum-erased source declarations for `ProcessInput` and the FE text helper retain
their exact retail linkage labels.

## Proof gates

- Strict source audit: 779/779 functions and 190/190 globals mapped; zero
  name, local, type, storage, or review findings.
- `screenpinkslips.cpp`: 8/8 PASS, including the separately supplied exact
  eight-instruction destructor.
- Shared neighbors: `screentournselect.cpp` 9/9, `screenmemcard.cpp` 15/15,
  and `screentrophyroom.cpp` 9/9 PASS.
- Call-target audit: 0 proven wrong targets.
- Relink both lanes: GREEN; 0 real duplicates, hidden phantoms, or unresolved
  relocation references.
- Undefined-call audit: 0 in both lanes.
- TU order: 513 objects, 0 inversions.
- Vtable audit: PASS across 1,433 files.
- Source-only text-move policy: PASS.
- Full phantom audit: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  0 hidden phantoms, and 0 unmatched ownership gaps.

The optional `2.8.1-norcse` rung was unavailable during the census, so affected
TUs used their configured compiler fallback; the focused owner PASS and
zero-phantom/zero-gap results are unaffected.
