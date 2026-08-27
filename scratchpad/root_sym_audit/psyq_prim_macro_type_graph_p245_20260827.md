# Canonical PsyQ primitive-tag macro reconciliation (P141/P245)

- Date: 2026-08-27
- Retail owners: standalone `font.obj`, `hrzsku.obj`
- Sources: `recon/game/psx/font.cpp`, `recon/game/psx/hrzsku.cpp`

## Source reconstruction

The packet-link statements in both owners use PsyQ's ordering-table macro
idiom.  Their required source type is the canonical LIBGPU `P_TAG`, an
eight-byte anonymous structure with a 24-bit `addr`, an 8-bit `len`, and the
four command bytes `r0`, `g0`, `b0`, and `code`.  The owner-specific
`Font_PTag` and `Hrz_PTag` reconstruction names were therefore not source
fidelity.  They are replaced by the shared owner header
`recon/game/psx/psyq_prim_macros.h`, which supplies `P_TAG`, `setaddr`,
`getaddr`, and `addPrim` in canonical source form.

## Debug-emission boundary proof

Original full-debug CC1PLUS output emits the header's macro-only carrier as:

- one anonymous `STRTAG`, size 8;
- `addr`: `FIELD UINT`, 24 bits at bit offset 0;
- `len`: `FIELD UINT`, 8 bits at bit offset 24;
- `r0`, `g0`, `b0`, `code`: `MOS UCHAR` at byte offsets 4, 5, 6, 7;
- one `P_TAG: STRUCT`, size 8 typedef linked to that anonymous tag;
- owner path ending in `psyq_prim_macros.h`.

Neither retail game owner retains this cast-only SDK type, although both retain
their concrete primitive-variable type graph.  The canonical-type audit removes
the carrier only when every row above, the typedef/tag link, size, spelling, and
owner path agree.  It cannot hide an application-owned type or a structural
drift.  After this strict boundary:

- `font.obj`: OK, 36/36 named, 2/2 anonymous, 103/103 typedefs;
- `hrzsku.obj`: OK, 75/75 named, 2/2 anonymous, all typedef semantics covered
  (166/194 physical rows after canonicalizing exact repeated debug records);
- complete `game/psx`: 23 OK, 5 DIFF.

## Binary and declaration proof

- `font.cpp`: 10 PASS / 5 NEAR / 0 FAR, unchanged; the five count-exact
  residuals remain 4, 6, 10, 14, and 14 diffs.
- `hrzsku.cpp`: 8 PASS / 10 NEAR / 4 FAR, unchanged.
- `Sky_RenderStars`: PASS, 111/111 instructions.
- strict declaration audit: 395/395 functions mapped; zero missing names, type
  findings, storage findings, global type findings, or mapping-review items.

The detailed machine-readable rows are in
`full_type_graph_game_psx_p245_20260827.tsv`,
`type_graph_font_p245_20260827.tsv`, and
`type_graph_hrzsku_p245_20260827.tsv`; the declaration receipt is
`game_psx_strict_p245_20260827.md`.
