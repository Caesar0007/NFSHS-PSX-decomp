# `font.obj` owner/type-graph reconciliation (P140/P244)

- Date: 2026-08-27
- Retail owner: standalone `font.obj`
- Source: `recon/game/psx/font.cpp`

## Owner proof

The retail SYM contains both standalone game `font.obj` and the PsyQ archive
member `libgpu.lib(FONT.obj)`.  A stem-only join was ambiguous.  The sweep now
selects the standalone owner for non-`syslib` source and the archive member for
`syslib` source only when exactly one candidate of each kind exists.  All other
multi-candidate joins remain `OWNER_MAP` findings.

## Baseline and retained result

With the monolithic `nfs4_types.h` include, the standalone owner compared as:

- named types: 36/36, plus 511 unrelated source tags;
- anonymous types: 2/2, plus 10 unrelated source tags;
- typedefs: 92/103, plus 583 unrelated semantics.

After owner-local type/header reconstruction:

- named types: 36/36, no missing/mismatch and no unrelated named tags;
- anonymous retail types: 2/2;
- typedefs: 103/103, including the retail duplicate `charactertbl` semantic;
- one explicit source-only anonymous four-byte `Font_PTag` body and its typedef
  remain, so the owner correctly stays `DIFF` rather than receiving a false OK.

The durable row is in `type_graph_font_p244_20260827.tsv`; the full 28-owner
game/PSX sweep is in `type_graph_game_psx_p244_20260827.tsv`.

## Source corrections

- `font.cpp` and `font_externs.h` now use `font_obj_types.h`, which reconstructs
  only types retained by standalone `font.obj`.
- The C-lane `font_types.h` remains unchanged for `textpix.c`; `textpix.obj`
  independently remains exact at 15/15 named types and 46/46 typedefs.
- `fontblit` carries the seven-argument glyph prototype and replaces the
  generic reconstruction-only `fn_void` function type.
- `FontZeroView` is removed.  Three stores use the already-retail-visible
  `DR_MODE` 12-byte structure view, preserving the required
  `MEM_IN_STRUCT_P` alias shape without inventing a debug tag.
- PsyQ and eaclib boundaries have source-accurate prototypes instead of the
  project-wide varargs umbrella.  Scratchpad packet globals retain their proven
  fixed-address lvalue representation.
- The declaration audit's global function-pointer equivalence now consults
  parsed function-pointer typedefs; this proves `gCurrentBlitter`'s `fontblit`
  source type is the SYM `PTR FCN VOID` object rather than a `void *` conflict.

## Binary proof and unresolved carrier

`font.cpp` remains 10 PASS / 5 NEAR / 0 FAR.  The five residuals and instruction
counts are unchanged:

- `Font_LoadFont`: 4 diffs, 117/117;
- `Font_TextTint`: 6 diffs, 8/8;
- `Font_ComputeColors`: 10 diffs, 198/198;
- `Font_Blit`: 14 diffs, 55/55;
- `Font_TextXY`: 14 diffs, 86/86.

`Font_SwitchFont` remains PASS after the `FontZeroView` removal.  `textnpixels`
and `textpixels` remain PASS at 37 and 8 instructions.

The only owner-type residual is `Font_PTag`.  Raw-word and existing-structure
experiments were fully reverted: they preserve length but rotate the address,
low-mask, and high-mask quantities; `Font_TextXY` becomes 26 diffs/FAR.  Operand
reversal, complement spellings, cursor-bump placement, and zero-byte pricing
also failed to retain the 14-diff baseline.  The current bitfield carrier is
therefore retained as explicit evidence-backed matching work, not ignored by
the type audit.

## Declaration audit

The refreshed game/PSX strict audit reports:

- 395/395 functions mapped; zero mangled source definitions;
- zero missing SYM names, type findings, storage findings, or mapping review;
- 302 object-owned global records, zero missing globals, zero storage findings,
  and zero global type findings;
- nine pre-existing explicit source-local review names in five unrelated
  functions remain outside this font round.
