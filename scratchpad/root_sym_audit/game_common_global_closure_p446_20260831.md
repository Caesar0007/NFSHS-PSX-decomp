# P446 game/common global, vtable, and storage closure

## Outcome

The strict `recon/game/common` audit now has no unresolved global/storage
record:

- 547/547 ordinary object-owned SYM data records mapped
- 115/115 compact GCC-v2 `_vt.*` records mapped by decoded class identity and
  exact retail VA
- 0 missing global definitions
- 0 unexplained extra global definitions
- 0 global storage-class findings
- 0 global type findings

Thirty-two objects whose bytes/addresses are retail-proven but whose original
source identifiers or materialization sites are not retained by SYM are listed
explicitly as `SYM-GLOBAL-CARRIER` records.  They are no longer generic audit
dispositions.

## Source restorations

### C++ static member

The flattened global
`_19AIHigh_BTC_HumanCop_lastInputRequestTick_` was restored as
`AIHigh_BTC_HumanCop::lastInputRequestTick_`.  GCC 2.8 now emits the exact
retail/SYM/MAP linkage name
`_19AIHigh_BTC_HumanCop.lastInputRequestTick_`.  `aih_btccop.cpp` remains
40/40 PASS.

### BWorld cop rotation state

`SetupBuildMatrices` declared the SYM-attested function-local static
`cop_angle` but updated an invented global pointer `gBWPrimPtr`.  The statement
was restored to `cop_angle += 0x40; xformy(&rotY, cop_angle);`, and the
fabricated global was removed.  The function remains 181-instruction PASS and
the whole TU remains 21/21 PASS.

### AudioCmn local aggregate initializer

The invented global `AudioCmn_FESFX_loadLangMap` represented the compiler's
constant template for the SYM local `TrackGenBank[11]`.  Declaring and
initializing `TrackGenBank` at its SLD statement boundary, immediately after
the `"Gen"` filename append, makes GCC 2.8 generate the retail copy naturally.
`AudioCmn_LoadGameSamples` remains 77-instruction PASS and the whole TU remains
48/48 PASS.

### HudPmx initializer templates

Four named `track.cpp` pointer tables at `0x80055a54..0x80055b3c` were stale,
misowned reconstructions of the anonymous constant templates generated for
`HudPmx_InitTextures`' local `tachs` and `ntachs` arrays.  No executable source
referenced the named globals.  They and the unrelated unused
`wordFile_psh_snow` harness definition were removed.  `track.cpp` remains
29/29 PASS and `hudpmx.cpp` remains 3/3 PASS.

### PSX render scratchpad

Eleven linked BSS definitions that attempted to represent literal
`0x1F8000xx` scratchpad fields were removed with their stale externs.  The
seven affected render TUs remain fully PASS; see the P445 storage-closure
report for the per-TU evidence.

## Audit coverage improvement

The scratchpad SYM audit now parses compact type-2 `_vt.*` records.  A mapping
is accepted only when the decoded GCC-v2 class identity and the explicit
`@0xVA` source receipt both agree.  All 115 special records present in the
trusted SYM map exactly.  The audit also rejects ctags' spurious `__asm__`
pseudo-variable emitted for asm-labelled data declarations.

## Regression proof

- Whole-TU gates remain fully PASS for every code-bearing TU changed in this
  round: `render`, `draw`, `draww`, `hrzsku`, `flare`, `r3dcar`, `bworld`,
  `track`, `hudpmx`, `audiocmn`, `aih_btccop`, `aih_traf`, `aihigh`.
- Both relink lanes GREEN: zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved names.
- Undefined-call audit: recon 15,781 and src 15,779 call relocations, zero
  undefined targets.
- Full phantom audit: 518/518 TUs compile; all 3,491 oracle symbols map
  exactly; zero hidden phantoms and zero ownership gaps.
- Unsafe vtable indexing audit: PASS across 1,017 files.

Authoritative receipts accompany this report as
`game_common_strict_p446_20260831.md`,
`game_common_global_closure_relink_p446_20260831.json`, and the two
`game_common_global_closure_undef_*_p446_20260831.json` files.
