# Game/PSX global-storage source restoration — P774 (2026-09-02)

## Result

The strict `recon/game/psx` declaration audit now reports zero explicit
source-only global/data-layout carriers. This round restores the retail SYM
aggregate/array declarations instead of modelling their elements as invented
`D_...` globals, and restores two compiler-owned string literals without
giving them fabricated source identifiers.

`chunkvis.obj` is also explicitly accounted for, but it is a different object
class: its complete raw FILE interval contains 401 type-graph records and zero
function, SLD, label, storage, code, or data records. Its empty reconstructed
translation-unit owner is therefore correct; it is not a missing data-only
module. The full evidence remains in
`chunkvis_obj_source_home_p757_20260902.md`.

## Restored declarations

- `hrzsku.obj`: `Hrz_gLightningPosInSky`, `sunPosInSky`, and `moonPosInSky`
  are real `SVECTOR` objects. TU-wide `-G8` replaces twelve split scalar
  fields while preserving 22/22 PASS.
- `weather.obj`: the four server objects are real two-element pointer arrays.
  The existing proven `-G8` identity removes four second-cell globals and four
  assembler-label views while preserving 25/25 PASS.
- `night.obj`: `Night_gWeatherLightingTable[2]`, `Night_gCopColor[2]`, and
  `Night_gWeatherColor[2]` are real arrays. The existing proven `-G8` identity
  removes three second-cell globals and three assembler-label views. The TU
  remains at its prior 18/19 status; only the unchanged 56-diff
  `Night_CreateNightTableElement__FiliPUc` is not PASS.
- `textureprocess.obj`: `Fog_gCurrentKey[2]` is a real array. `-G4` regresses
  `Fog_InitFogTriggers` by 18; TU-wide `-G8` preserves 16/16 PASS.
- `loading.obj`: ordinary source literal `"back"` replaces `D_8013D9D4`.
  At `-G8`, rebuilt `.sdata` is exactly ordered as `smallShapeFile @ +0x00`,
  anonymous literal @ `+0x04`, and `totalAvailMem @ +0x0C`; 3/3 PASS.
- `platform.obj`: ordinary source literal `"cdrom:"` replaces `D_8013DAA0`.
  Declaration placement plus TU-wide `-G8` rebuilds the exact retail `.sdata`
  offsets: `gSysStartUp +0x00`, anonymous literal `+0x04`, `disablecard +0x0C`,
  `gDctXtraMem +0x10`, `gLowMemory +0x14`, `gHighMemory +0x18`,
  `gCurrentMemory +0x1C`, and `gTotalMemory +0x20`; 8/8 PASS. SYM/SLD do not
  encode a source line for these file-scope declarations, so the section order
  is authoritative while exact whitespace/lexical placement is not claimed.

## Measured compatibility carrier

Retail SYM owns logical `int StatsTimer[2]`, but direct array probes cannot
preserve all already-PASS consumers: overlays reaches only 1/5 PASS at `-G4`
and 4/5 at `-G8`; replay reaches 14/16 at `-G4` and 12/16 at `-G8`. The source
therefore retains one explicitly measured two-cell storage carrier, now using
semantic identifiers (`StatsTimerPlayer2Value` and semantic zero-storage cell
views). The raw address-name `D_8013D99C` survives only as the required
assembler linkage label, not as a C/C++ identifier. Overlays remains 5/5 PASS
and replay remains 16/16 PASS. The strict report classifies this as one
measured global array carrier, not an unexplained global/data-layout carrier.

## Verification

- Targeted whole-TU gates: hrzsku 22/22, weather 25/25, night 18/19 (unchanged),
  textureprocess 16/16, loading 3/3, platform 8/8, overlays 5/5, replay 16/16.
- `brdist.py`: 114 functions checked across those eight TUs, zero branch
  offset/count divergences.
- Strict game/psx audit: 395/395 functions mapped; zero missing/extra locals,
  type findings, storage findings, missing/extra globals, global type findings,
  or explicit source-only global/data-layout carriers. The separate queue of
  396 function-local codegen carriers remains active.
- Both relink lanes: GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols.
- Full source build succeeds at the branch's existing 1,239,008-byte size,
  still 32 bytes shorter than retail. This round does not claim whole-binary
  completion.

Tool changes are compiler-identity flags only; no post-compile rewrite exists.
The exact pre-loading/platform `tools/build.py` is retained as
`build.py.pre_statstimer_g8_p772_backup` (SHA-256
`93E5BE59617219CAB9A048481071960BC64D44FCAC0DD3BEDBA41997B66FD339`).
