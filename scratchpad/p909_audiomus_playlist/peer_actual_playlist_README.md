# Landed P909 Playlist — independent read-only review

`peer_actual_playlist_review.json` is frozen for the current image:

- Source82ded136... equals accepted candidate text, apart from EOL encoding.
- Normal objectf6e55641... is literally equal to root's frozen baseline.
- All23 PASS /206 branches and all22 neighbor debug/local/scope/SLD contracts
  are preserved. Playlist has all four native blocks, i in a3 at depth3, and
  numplaylistsongs/playlist in a0/a1. Its SLD partition is0/0.
- All34 actual linked Playlist words equal the native executable.
- SwitchSong retains its three native scopes, info/v0 home and SLD0/0.

The extra SwitchSong linked-byte check is explicitly **not yet fully exact**:
its two Hud_kTurnSongOffNext LO16 references at8007A188 and8007A1B4 still encode
8013E0BC rather than native8013D940. The other60 words match. This is pre-existing
HUD data-placement debt, not a Playlist source regression. Parent's planned
HUD-owner landing needs its own final34+62-word recheck; no future result is
asserted here.

Frozen current ELF:
`8ecfcdd06de59e1138efb5c946b5c2dc59f6df1bc5ddcef86b44e3f2b0d8a521`.
Frozen current map:
`ecc5bd9dace8ac2e376020066e21e7f5b313cb002fa9d23bdf5bc7d39e50e9ad`.

No builds, source edits or normal-output writes were performed by this review.
