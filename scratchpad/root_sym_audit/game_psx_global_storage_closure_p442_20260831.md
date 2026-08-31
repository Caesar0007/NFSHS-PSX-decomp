# game/psx global/storage closure (P442, 2026-08-31)

This round closed the strict `game/psx` global-definition review queue without
converting measured data-layout devices into false source claims.

## Removed fabricated storage

Thirty-six source definitions were proven to be stale link-harness BSS rather
than retail objects and were deleted with their obsolete extern surfaces:

- 11 `Skid_gCtrlPoint_*` / `Skid_gCtrlScratch_*` / `Skid_gScratchPos*` names;
- `Hrz_gProjResultZ0` and `Hrz_gProjScratch_9C`;
- 19 unused `DrawW_*` / `DrawWTrough_*` names;
- four unused `Hrz_gSkyVtx_*` names.

Every removed name lacks a trusted SYM record, MAP record, configured address,
raw data label, and compiled source reference.  The corresponding live code had
already been reconstructed through literal scratchpad views or real foreign
owner fields.

## Corrected platform storage ownership

`platform.cpp` no longer defines approximate 64-byte arrays for three absolute
retail addresses:

- `gDctBuffer` was corrected to canonical PsyQ/SYM/MAP `CF_DVLC`
  (`0x80124038`), which is owned by `libpress/TABLE.c`;
- the unrecoverably named retail boundaries are now external raw labels
  `D_80054D10` and `D_80148B0C`, with their exact addresses supplied to the
  link-symbol table;
- `NFS4.MAP` identifies `endofcode` at `0x80148B04`, proving the heap base
  `0x80148B0C` is a boundary eight bytes later rather than fabricated C BSS.

## Explicit carrier evidence

The remaining 15 source-only global definitions are measured split-element or
data-layout carriers.  Each now has a `SYM-GLOBAL-CARRIER` receipt.  The strict
audit accepts a receipt only when ctags independently finds the named source
definition, and reports the carriers separately from generic extras.  They are:

- four per-field components of SYM `Hrz_gLightningPosInSky`;
- `D_8013D9D4` and `D_8013DAA0`, the named `.sdata` literals `"back"` and
  `"cdrom:"` required by the retail data/address shape;
- three second-element small-data labels in `night.cpp`;
- the second `StatsTimer` word in `overlays.cpp`;
- the second `Fog_gCurrentKey` word in `textureprocess.cpp`;
- four second-element weather server pointers in `weather.cpp`.

## Verification

- Strict `game/psx` audit: 395/395 functions mapped and declaration-clean;
  missing/extra globals 0/0; global type/storage findings 0; 15 explicit
  source-only global/data-layout carriers.
- Affected whole-TU gates: `draww.cpp` 35/35, `hrzsku.cpp` 22/22,
  `skidmark.cpp` 11/11, `sim.cpp` 8/8, `bworld.cpp` 21/21,
  `loading.cpp` 3/3, `night.cpp` 19/19, `overlays.cpp` 5/5,
  `platform.cpp` 8/8, `textureprocess.cpp` 16/16, and `weather.cpp` 25/25 PASS.
- Both relink lanes GREEN: zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols.
- Undefined-call audit: recon 15,781 and src 15,779 call relocations, zero
  calls to undefined symbols.
- Full phantom audit: 518/518 TUs compile; all 3,491 oracle names exact; zero
  hidden phantoms and zero ownership gaps.
- Source-only text policy PASS; 521 objects with zero TU-order inversions;
  466 units with zero proven wrong call targets; vtable audit PASS across
  1,017 files.
