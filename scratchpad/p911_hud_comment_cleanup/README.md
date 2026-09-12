# P911 HUD comment correction

Only comments change in `recon/game/psx/hud.cpp`:

- Two obsolete scalar-split blocks now describe the actual native arrays and
  current -G8 compilation. No split backing objects remain in the active source.
- Two .data and 22 .sdata cells previously called BSS are correctly described
  as CPE-loaded zero data. Zero values do not prove original initializer syntax.

Independent review (`peer_comment_review.json`) verifies all 24 typed SYM
records, MAP section membership and complete CPE loads, plus the three INT[2]
view arrays and LOCAL BOOL[2] PerpOverlayOn.

Private and actual-path compilation (`verification.json`,
`verification_actual.json`) preserve 62 PASS functions, 533 branches, every
lexical/SLD graph and the entire normal object. The only private-object metadata
exception is its precisely checked FILE path; the real-path object is literally
unchanged. All 24,795 non-comment code tokens are identical. No source type,
name, qualifier, declaration, code statement or storage was changed.

The diagnostic script has a private default mode and an explicit `--actual`
mode which recompiles the actual object; neither mode edits production source
or rewrites compiler/debug output. Native BSS placement is a separate rejected
proposal under `../p911_hud_bss`, not part of this comment correction.
