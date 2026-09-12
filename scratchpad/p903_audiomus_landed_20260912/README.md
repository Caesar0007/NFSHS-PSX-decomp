# P903 independent actual PlaySong landing validation

2026-09-12, after root's explicit landed notice. **Passed.** No production,
normal build output, shared-tool or prior-receipt writes were made here.

Actual audiomus.cpp:
`db13b32a51dc8027ef28afbab0a4ab580c5730c4b33fd9f781b0e08dba74a137`.
Accepted private candidate:
`3e0c7376f6a75d66c8d0111c7d5da747782ef03fd7cd69fabb253e0db6b98742`.
Their complete source bodies, comments and preamble are identical after universal
newline decoding. The actual file has seven fewer CRLF endings (29542 versus
29549 bytes); no formatting or source edits were made during this validation.

- **23/23 PASS**, all **206 branch checks** exact.
- Entire actual normal object literally equals P902, SHA
  `f6e556413410b4b0d3879ed8ae420b67df328f82cdf1e37add8e3ae6eee4a87b`.
  The private-to-actual difference is only its exact STT_FILE pathname; every
  other ordered symbol, payload/storage/header/schema and relocation is exact.
- Every actual function matches its accepted candidate's full debug instruction,
  local/parameter/source-label, scope-address/depth and source-partition graph.
- PlaySong: **all nine native blocks**, **pattern/title/newsong types and homes**,
  frame168/mask800f0000,-8, and **SLD0/0** exact. No pick or replacement local.
- **160/160 raw words**, including **30 references** and the independently
  checked `*-%s` literal at8013C724, exact. No object/assembly rewrites.
- All22 neighbors preserved, including Server39/29 with no ordinary locals and
  Threshold0/0 with no extra declarations.
- Full actual nine-file preprocessing closure verified; no staged headers used.

`landed_verified.json` is the combined receipt. `landed.json` records isolated
actual-path compilation/gates, `debug_labels_receipt.json` proves unchanged
compiler assembly and retained metadata-only anchors, and
`landed_raw_target_receipt.json` enumerates all reference words.

Primary candidate/intermediate receipts remain under ../p903_audiomus_playsong.
Unique original token/macro spelling and physical source line numbers are still
unsealed; this is not a project-wide completion claim. Publication remains
root-owned.
