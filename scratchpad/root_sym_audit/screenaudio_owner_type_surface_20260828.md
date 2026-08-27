# ScreenAudio owner type-surface receipt

Date: 2026-08-28

Owner: `ScreenAudio.obj`
Source: `recon/frontend/common/screenaudio.cpp`
Pre-change backup: Git commit `4ea6b112`

## Result

- Focused canonical type graph: `OK`.
- Named tags: 155/155 exact.
- Anonymous tags: 2/2 covered.
- Authoritative function matching: 8/8 PASS.
- Frontend/common board after this owner: 35 exact owners, 6 residual owners.

## Restored owner surface

`screenaudio_types.h` expresses the exact ScreenAudio graph as the shared
ScreenTrackInfo frontend surface minus its five input/screen/video records,
plus the 43 car, physics, audio, and sound-system records retained by the retail
object.  The 124-byte `tScreenAudio`, `AudioMus_tSongEntry`,
`AudioMus_tSongList`, and four SNDSYS option records retain their exact layouts.

Three foreign global layouts needed by the source but absent as completed tags
from this owner are exact pair-locked compiler views:

- `SndBnk_t`: 12 bytes.
- `SPEECHINFO`: 36 bytes.
- `ScreenAudio_GlobalMenuDefsCodegenView`: 10,336 bytes (`0x2860`), exposing
  the contiguous audio-menu slice from `itemMusicVolume` at `0x25cc` through
  `menuAudio` at `0x27e0`.

Both enum-erased FE text declarations retain explicit retail linkage labels,
so the source graph stays exact without creating unresolved mangled calls.

## Proof gates

- Strict source audit: 779/779 functions and 190/190 globals mapped; zero
  name, local, type, storage, or review findings.
- `screenaudio.cpp`: 8/8 PASS; shared `screentrackinfo.cpp`: 5/5 PASS.
- Call-target audit: 0 proven wrong targets.
- Relink both lanes: GREEN; 0 real duplicates, hidden phantoms, or unresolved
  relocation references.
- Undefined-call audit: 0 in both lanes.
- TU order: 513 objects, 0 inversions.
- Vtable audit: PASS across 1,432 files.
- Source-only text-move policy: PASS.
- Full phantom audit: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  0 hidden phantoms, and 0 unmatched ownership gaps.

The optional `2.8.1-norcse` rung was unavailable during the census, so affected
TUs used their configured compiler fallback; the focused owner PASS and
zero-phantom/zero-gap results are unaffected.
