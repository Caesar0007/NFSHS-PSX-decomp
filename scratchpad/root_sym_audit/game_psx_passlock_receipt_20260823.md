# Game/PSX PASS-only SYM local restoration receipt

Date: 2026-08-23

Scope rule: only functions already confirmed PASS were edited.  The unmatched
`InGame_GetPSXPadValue` and `CarIO_ReadInCarTextureData` bodies were not changed.

## Landed source corrections

| Function | Retail SYM locals | Removed reconstruction locals | Authoritative gate |
|---|---|---|---|
| `AudioCmn_LoadBank__FPci` | `bankdata` AUTO -0x60; `pdata` REG $s0 | `iVar1` | PASS 33/33 |
| `Device_Fail__Fi` | static `failtime[2]` only | `iVar2`, `bVar1` | PASS 28/28 |
| `Device_PSXPad__FUl` | none | `iVar1`, `state` | PASS 26/26 |
| `CarIO_StartUp__Fv` | `i` REG $v1 | `iVar2`, `pDVar1` | PASS 27/27 |
| `CarIO_ReStart__Fv` | `i` REG $v1 | `iVar2`, `pDVar1` | PASS 19/19 |
| `Device_Update__Fv` | none | `iVar2` | PASS 56/56 |

The first five functions also have compiler-emitted `-g` confirmation:
`AudioCmn_LoadBank` emits only `pdata` and `bankdata`; `Device_Fail` emits only
the static `failtime`; `Device_PSXPad` emits no local definition; both CarIO
loops emit only `i` in physical register 3 (`$v1`).

## Retained, measured carrier

`Device_Update__Fv` still contains `iVar1` although its SYM local list is empty.
Removing it changes a 56-instruction PASS into 59 instructions: gcc retains the
`GameSetup_gData` base in `$s0` and reloads word 3 after `Device_Fail`, while
retail retains the loaded word itself in `$s0`.  The direct call-result local
`iVar2` was independently removable and has been deleted.  The remaining
carrier is explicit backlog evidence, not a claim of source exactness.

`Platform_InitMemory__Fv` remains PASS 12/12 with its extra `m` carrier.  Every
tested no-local C expression lets CSE delete retail's recovery `addu` (11
instructions).  A zero-instruction tied-output barrier restores the 12-count
shape but splits liveness at the global store and produces a complete
`$v0/$v1` swap (14 diffs); operand reference dials do not move it.  The source
comment records this unresolved angle.

## Second PASS-only cleanup wave

The continuation remained inside functions that were PASS before editing. It
removed another 36 reconstruction-only names while keeping every edited oracle
byte-exact:

| Module/functions | Removed reconstruction locals | Authoritative gate |
|---|---|---|
| `draw.cpp`: `Draw_SetView`; both `Draw_InitViewOT` variants; `Draw_DeInitViews`; `Draw_StopRenderingView`; `Draw_StartFrameRender`; `Draw_StopFrameRender` | `iVar1`; two `puVar1` + two `iVar3`; `iVar2`; `otw`; `piVar2`/`ppuVar3`/`iVar5`; `iVar3` (11 total) | all 18 checked neighbors PASS |
| `Force_HitWall__Fi` | `skids`, `impacts`, `padnum`, `v1`, `v0`, `impactmultiplier`, `frontmultiplier`, `rearmultiplier` | PASS 2/2; all 9 `force.cpp` functions PASS |
| `font.cpp`: `Font_SetABR`, `Font_Getcharacter`, `Font_SwitchFont`, `Font_TextXY` | `val`; `p`/`probe_idx`; `pcVar1`/`c_val`/`arg2`; `pal`/`tpage` (8 total) | all 15 `font.cpp` functions PASS |
| `HrzSetPsxTranslation__FP8coorddef` | `tt` | PASS 20/20 |
| `OptionsBarThing__Fiiii` | `str`, `width` | PASS 56/56 |
| `textureprocess.cpp`: `TextureProcess_TransColorCheck`, `Fog_CheckRange`, `Fog_FindKey`, `Fog_AllocKey` | `uVar1`; `iVar2`/`iVar3`; `pFVar1`; `pFVar2`/`piVar1` (6 total) | PASS 13/13, 21/21, 37/37, 19/19 |

Fresh game/PSX declaration audit: 204/395 mapped functions are now
declaration-clean and the extra-local queue is 882, improved from 198/395 and
918 at the start of this continuation. `RaceStatistics__Fv` was only
regression-checked and remains its untouched locked baseline FAIL 71
(474/475); its body was not edited.

## Third PASS-only cleanup wave

Another 11 reconstruction-only names were removed from functions that were
already exact before editing:

| Module/functions | Removed reconstruction locals | Authoritative gate |
|---|---|---|
| `texture.cpp`: `Texture_ColorCarPalette`, `Texture_CopyPalette`, `Texture_CleanupMenuTexture` | `count`/`src`/`entry`; `entry`; `ppDVar1` | PASS 14/14, 24/24, 24/24; all 24 `texture.cpp` oracle functions PASS |
| `TrsProj_TransPtN16__FP10RelCoord16P8coorddefi` | `i` (the `n` parameter is the actual countdown) | PASS 34/34; all 11 `trsproj.cpp` functions PASS |
| `weather.cpp`: both `Weather_Change*State` routines and `Weather_Restart` | two `goalPlusChange`; `iVar2`/`pcVar1` | PASS 29/29, 30/30, 31/31; all 25 `weather.cpp` functions PASS |
| `read__FPPcPvi` in `trackspec.cpp` | `c` | PASS 12/12; all 5 `trackspec.cpp` functions PASS |

The fresh game/PSX audit is now 211/395 declaration-clean with 871 extra
source-local names.  Relative to the pre-wave baseline recorded for this
PASS-lock series, the aggregate movement is 193 -> 211 declaration-clean and
928 -> 871 extra names (57 removed).  Type-graph sweeps are exact for all four
translation units: texture 37/37, trsproj 50/50, weather 68/68, and trackspec
35/35 named types, each also 2/2 anonymous types.

## Fourth PASS-only cleanup wave

Ten more reconstruction-only names were removed from functions that were
already exact before editing:

| Module/functions | Removed reconstruction locals | Authoritative gate |
|---|---|---|
| `hrzsku.cpp`: `Hrz_RotProj16`, `Sky_InitStars` | `i`; `seed` (SYM's `oldSeed` is now the real seed carrier) | PASS 17/17, 122/122 |
| `weather.cpp`: `Weather_BuildWeather` | `pvVar1` | PASS 23/23; all 25 `weather.cpp` functions PASS |
| `textureprocess.cpp`: `TextureProcess_DepthColorCluts`, `CV_ColorTracks` | `ret`; `uVar1` | PASS 54/54, 130/130; all 16 functions PASS |
| `flare.cpp`: `Flare_SetMatrix`, `Flare_Moon` | `mm`; `xy` | PASS 43/43, 46/46; all oracle functions PASS |
| `sfx.cpp`: `Sfx_Add` | `cycle` | PASS 47/47; all 7 functions PASS |
| `unpack.c`: `unpacksizez` | `magic` | PASS 50/50; all 4 functions PASS |
| `texture.cpp`: `Texture_LoadMenuTexture` | `shapefile` (SYM's `shpfile` is now the real file pointer) | PASS 109/109; all 24 oracle functions PASS |

The fresh declaration audit is 221/395 clean with 861 extra source-local
names. Relative to the pre-series baseline, this is 193 -> 221 clean and
928 -> 861 extras (67 names removed). The locked unmatched
`Hrz_BuildSky` and `Hrz_BuildHorizon` bodies were not edited; their observed
baselines remain FAIL 146 and FAIL 12.

The root `tPA32` typedef was also corrected from array-of-pointers
`short *[32]` to SYM's `PTR ARY SHORT`, expressed as `short (*)[32]`.
The flare type sweep consequently raised typedef coverage from 193/224 to
194/224 and no longer reports `tPA32` as missing/extra. Its overall `DIFF`
status remains due to unrelated whole-header type extras, so this is a
specific semantic correction rather than a claim that the whole TU type
surface is exact. `Flare_SetMatrix` and `Flare_Moon` remain PASS after the
header change.

## Fifth PASS-only type and carrier wave

Two source declarations now use the retail SYM identities rather than
layout-equivalent reconstruction aliases:

- `textnpixels::ch` is spelled `struct charactertbl *`, matching the C object's
  named struct tag without inventing a typedef absent from `textpix.obj`.
  `textnpixels` remains PASS 37/37, `textpixels` remains PASS 8/8, and the
  complete textpix type graph is exact at 15/15 named and 46/46 typedef rows.
- `TP_gZPaletteSystem` is declared and defined as `TP_ZPaletteSystem` instead
  of the alias `TP_tZPaletteSystem`. All 16 `textureprocess.cpp` functions
  remain PASS and its type graph remains OK at 83/83 named and 2/2 anonymous
  types.

The audit normalization now explicitly recognizes two representations that
the underlying records prove equivalent: a C ctags `struct:tag` is PsyQ's
plain named STRUCT tag, and a direct C `R(*)(args)` declarator is a function
pointer when the SYM row is `PTR FCN R`. This correctly clears the false
`Draw_gSyncCallback` `void*` report; the raw row is
`STAT PTR FCN VOID`, and the source is already the direct
`static void (*Draw_gSyncCallback)(void)` declaration.

Five measured source-only locals are now classified as codegen carriers rather
than left in the generic review queue: `Font_SetABR::y` (inline form: 6 diffs,
18/18), `Font_Getcharacter::base_00` (removal: 22 diffs and 33/35),
`Loading_UpdateLoadingScreen::{tile,y}` (nested `tile` call: 44 diffs and
64/62; `y` is the proven addend-reassociation lever), and
`textnpixels::fontbase` (direct form: 5 diffs and 36/37). The full font
(15 functions), loading (3), and textpix (2) gates are PASS.

The refreshed audit is 225/395 declaration-clean with 856 generic extra local
names, one function type finding, and zero global type findings. Cumulatively,
the PASS-lock series moves 193 -> 225 clean functions and 928 -> 856 generic
extras. The sole function type finding is `DrawC_PrimClip::facetFlag`; that
function is unmatched and its body remains locked and untouched.

## Sixth PASS-only carrier-resolution wave

This continuation replaced another 86 generic local-name dispositions with
explicit, per-function `SYM-CODEGEN-CARRIER` records backed by the existing
oracle/compiler receipts. The classifications cover:

- view-count, pointer-walk, palette-CSE, rounding, and loop-lifetime devices in
  `device.cpp`, `draw.cpp`, and `platform.cpp`;
- clamp, controller-view, structure-alias, font-base, and call-staging devices
  in `force.cpp`, `font.cpp`, and `loading.cpp`;
- uncoalesced call-result, GIV, segment-index, packet-link, pixmap-word, and
  allocation-priority devices in `trackspec.cpp`, `skidmark.cpp`, and `sfx.cpp`;
- palette-count, frame-size, row-rounding, CLUT-loop, fog-walker, packet-bump,
  palette-RMW, and local-allocation devices in `texture.cpp`,
  `textureprocess.cpp`, and `weather.cpp`.

The exact names and owning functions are enumerated in
`game_psx_passlock_carriers6_20260823.md`; the generic queue no longer treats
those measured source devices as unexplained reconstruction locals.

Two names were removed from source entirely:

- `Platform_SysStartUp::userRam`: the canonical direct
  `Platform_nfsUserRam = 0x801fc000 - (int)endofcode` form remains PASS 54/54.
- `Force_Update::uVar3`: direct `(u_int)car->carIndex` preserves the unsigned
  `sltiu` and remains PASS 278/278. The uncast direct form was exactly two
  signedness diffs; the cast is the source-level correction.

Two final generic candidates were measured and classified rather than removed:

- `Texture_CheckForSharedPalette::num`: direct global bounds remain 77/77 but
  swap `$t3/$t4` in both arms (16 diffs).
- `Force_Update::controller`: direct typed casts add one instruction and produce
  11 diffs (279/278) by folding the two field offsets into a different
  base/index chain.

The audit is now 263/395 declaration-clean with 768 generic extra local names,
92 explicit source-only codegen carriers, one function type finding, and zero
global type findings. Relative to the original PASS-lock baseline, cumulative
movement is 193 -> 263 clean functions and 928 -> 768 generic extras.

Full gates are PASS for every oracle function in device, platform, draw, force,
font, loading, textpix, trackspec, sfx, skidmark, texture, textureprocess, and
weather. In `psxcontroller.cpp`, the three PASS neighbors remain PASS; the only
observed FAIL is the untouched locked `InGame_GetPSXPadValue` baseline at 76
diffs (235/233).

## Regression gates

- `audio.cpp`: all 6 functions PASS.
- `device.cpp`: all 10 functions PASS.
- `cario.cpp`: 10 existing PASS functions remain PASS;
  `CarIO_ReadInCarTextureData__FPcP8Car_tObjii` remains the untouched baseline
  FAIL 19 (492/491).
- `platform.cpp`: `Platform_InitMemory`, `Platform_ReserveMemory`,
  `Platform_TempReserveMemory`, and `Platform_SysStartUp` all PASS.
- `psxcontroller.cpp`: `InGame_SetRamp`, `InGame_ResetPSXController`, and
  `InGame_GetDevice` all PASS; untouched `InGame_GetPSXPadValue` remains FAIL
  76 (235/233).

## Seventh PASS-only carrier-resolution wave

This continuation operated under the user's explicit unmatched-function lock:
no function body was edited until a fresh detailed gate returned PASS.  The
exact changes and per-function receipts are listed in
`game_psx_passlock_carriers7_20260823.md`.

Three source-only locals were removed while retaining byte identity:

- `DrawW_SetUpSubdividFacet::sVar2` -> direct `vN->dvy` field reads, PASS 206/206;
- `DrawW_NightColorCalc::lt` -> unused declaration removed, PASS 279/279;
- `uppercase::pbVar2` -> indexed byte access, PASS 24/24.

Ten already-proven source-only names were moved out of the generic review queue
and into explicit `SYM-CODEGEN-CARRIER` dispositions.  One of them was newly
measured in this wave: removing `Hrz_LightningFlicker::col` and storing the two
colour literals directly is count-exact but FAIL 4 (55/55); the PASS form was
restored and annotated.  The other nine have pre-existing in-source oracle,
SLD, allocation, or ABI receipts: `Flare_Tri::pkt_addr24`,
`Flare_2DSpike::rgb`, `Font_Blit::tpage`, `Font_LoadFont::hdr`,
`Horizon_InterpolateLineSCoords::pv`, `CarIO_UpdateCarTextureData::pmx`,
`DrawC_ReadLightingData::trk`, `DrawW_kCtrlWorld_High::sentinel`, and
`Sfx_BuildSouffleFacet::ds`.

The refreshed audit is 276/395 declaration-clean with 755 generic extra local
names, 102 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings.  Cumulatively, the
PASS-lock series moves 193 -> 276 clean functions and 928 -> 755 generic
extras.

Detailed whole-TU verification after the edits reports:

- `flare.cpp` 27/27 PASS, `font.cpp` 15/15 PASS, and `sfx.cpp` 7/7 PASS;
- `hrzsku.cpp` 20/22 PASS; only untouched locked `Hrz_BuildSky` FAIL 146 and
  `Hrz_BuildHorizon` FAIL 12 remain;
- `cario.cpp` 10/11 PASS; only untouched locked
  `CarIO_ReadInCarTextureData` FAIL 19 remains;
- `drawc.cpp` 19/20 PASS; only untouched locked `DrawC_PrimClip` FAIL 49 remains;
- `draww.cpp` 31/35 PASS; only untouched locked `DrawW_SubdividFacet` FAIL 8,
  `DrawW_DoTrough` FAIL 9, `Draw_kCtrlSkidmark` FAIL 20, and
  `DrawW_OnyxLinePrim` FAIL 66 remain;
- `hud.cpp` 59/62 PASS; only untouched locked `Hud_BuildCdPlayer` FAIL 1,
  `Hud_RenderTacView` FAIL 11, and `Hud_BuildNumbers` FAIL 188 remain.

Thus every function modified in this wave remains PASS and no locked unmatched
body was changed.

## Eighth PASS-only carrier-resolution wave

This continuation again obeyed the unmatched-function lock: every edited body
was freshly gated PASS before modification, and every retained form was gated
PASS afterward. Exact per-function measurements are recorded in
`game_psx_passlock_carriers8_20260823.md`.

Seven source-only local names were eliminated from byte-matched functions:
`DrawW_WorldSetUpTranslation::{iVar1,iVar2}` were replaced by the canonical SYM
`ty/tz` locals; `Draw_CircleClip::{iVar1,iVar2}` by canonical `dx/dz` locals;
`Hud_BuildF4::uVar3` and `Hud_BuildG4::uVar3` by direct expressions; and
`Night_RestartNightDriving::r` by direct `random()` consumption.

Seven names were converted from generic discrepancies to explicit measured
codegen carriers: `Night_NightCalc::lt`,
`DrawW_GetAnimationTime::{iVar2,tick}`, `Hud_InitTables::patVar1`,
`Hud_InitMap::iVar4`, and `Fog_Update::{slot,start}`. The rejected simplifications
were all measured: `Hud_InitTables` direct arms FAIL 12 (15/11), `Hud_InitMap`
direct bounds FAIL 22 (46/40), `Fog_Update` direct indexing FAIL 4 (81/81), and
its direct per-arm global stores FAIL 11 (82/81). Each exact PASS form was
restored and documented.

The refreshed audit is 286/395 declaration-clean with 741 generic extra local
names, 109 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Relative to the initial
PASS-lock baseline, cumulative movement is 193 -> 286 clean functions and
928 -> 741 generic extras.

Whole-TU detailed verification reports `draww.cpp` 31/35 PASS, `hud.cpp` 59/62
PASS, `night.cpp` 18/19 PASS, and `textureprocess.cpp` 16/16 PASS. Every observed
failure is an unchanged locked baseline; no unmatched body was edited.

## Ninth PASS-only carrier-resolution wave

Two source-only declarations were removed while preserving byte identity:
`DrawC_ShadowPrim::iVar1` was replaced by direct assignment/tests of `sd->otz`,
and the unused `DrawW_CalcSubdivision::iVar1` declaration was deleted.

Eight additional names now have explicit oracle-measured carrier dispositions:
`CarIO_CleanUpLicense::{ppPlate1,psVar1}`,
`CarIO_LicenseCheck::{sVar1,sVar2}`, `DrawC_ShadowPrim::otp`,
`DrawW_CalcSubdivision::minz`, `Hud_FBuildSprite::prev_pkt`, and
`Hud_FBuildF4::prev_pkt`. A canonical `CarIO_LicenseCheck` reuse attempt was
count-exact but FAIL 2 (39/39), changing a retail byte load into a word load;
the exact PASS shape was restored.

The refreshed audit is 292/395 declaration-clean with 731 generic extra local
names, 117 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 292 clean functions and 928 -> 731 generic extras.

Whole-TU detailed gates report `cario.cpp` 10/11 PASS, `drawc.cpp` 19/20 PASS,
`draww.cpp` 31/35 PASS, and `hud.cpp` 59/62 PASS. All failures are unchanged
locked baselines; no unmatched body was edited.

## Tenth PASS-only carrier-resolution wave

Eight source-only local names were removed while retaining byte identity:
`DrawC_ShadowPrimClip::{u2,vt2}`, `Hud_BuildRadar::tag`,
`Hud_PositionMap::track`, `Hud_Reset::{psVar1,iVar2}`, and
`Night_DoLightningEffect::{r,tunnel}`. The retained source uses direct member,
global-index, and call-result expressions or the canonical SYM `Hud_Reset::i`.

Fourteen names were converted from generic discrepancies to explicit measured
codegen carriers across `DrawC_PrimMenu`, the two `Flare_Quad` variants,
`Hrz_SetDitheringPrim`, `Hud_BuildRadar`, `Hud_RenderMapView`, and
`Weather_ProcessParticles`. Rejected simplifications were restored: direct
flare color staging is FAIL 5 (42/41), removing both flare stages is FAIL 9
(42/41), direct Hrz slot expressions are FAIL 24 (36/34), removing its staged
value is FAIL 4 (34/34), and direct weather translation access is FAIL 22
(251/251).

The refreshed audit is 303/395 declaration-clean with 709 generic extra local
names, 131 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 303 clean functions and 928 -> 709 generic extras.

Whole-TU detailed gates report `drawc.cpp` 19/20 PASS, `flare.cpp` 27/27 PASS,
`hrzsku.cpp` 20/22 PASS, `hud.cpp` 59/62 PASS, `night.cpp` 18/19 PASS, and
`weather.cpp` 25/25 PASS. All failures are unchanged locked baselines.

## Eleventh PASS-only carrier-resolution wave

Twelve source-only locals were removed from exact functions:
`Flare_SingleColorTex::{sVar1,sVar2}`, `Hud_BuildF3::{uVar1,iVar2,iVar3}`,
`Hud_BuildF4o::{uVar1,uVar2,uVar3,uVar4}`, `Hud_ParseTime::iVar1`, and
`Night_GenerateNextLightningEvent::{r,fork}`. Their replacements are direct
casts, packed-coordinate expressions, direct global indexing, or direct random
call results, and every function remains byte-identical.

Sixteen names were converted from generic discrepancies to explicit measured
carriers across `DrawW_BuildChunkObjectFacets`, `Hud_Init`, `Hud_BTCStats`,
`Hud_RenderStatsView`, `CarIO_CopyToShape`, `Hud_ParseTime`, and
`Night_GenerateNextLightningEvent`. New rejected-form measurements include
direct Hud time mutation FAIL 13 (92/91), direct lightning delay expressions
FAIL 8 (29/29), and direct gameTicks global access FAIL 2 (29/29).

The refreshed audit is 313/395 declaration-clean with 681 generic extra local
names, 147 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 313 clean functions and 928 -> 681 generic extras.

Whole-TU detailed gates report `cario.cpp` 10/11 PASS, `draww.cpp` 31/35 PASS,
`flare.cpp` 27/27 PASS, `hud.cpp` 59/62 PASS, `night.cpp` 18/19 PASS, and
`overlays.cpp` 4/5 PASS. All failures are unchanged locked baselines.

## Twelfth PASS-only carrier-resolution wave

Sixteen source-only local names were removed from byte-matched functions:
`DrawW_DoObjectAnimations::{time_00,ppTVar1,iVar2,table}` were replaced by the
canonical SYM `track`, `trackPtr`, `i`, and `time` locals;
`ObjectClipped::{iVar1,iVar2}` by direct `tmp2.x/tmp2.z` comparisons; and the
four `Hud_GoTpage` plus three-each `Hud_FBuildGT4`/`Hud_FBuildFT4` packet-link
temporaries by the canonical `P_TAG`/`addPrim` source shape.

Seven names were converted from generic discrepancies to explicit measured
codegen carriers: `DrawC_ShowroomPrims::{m1,hs,z1}`,
`DrawC_SpotPrims::{color,pDVar7,puVar8}`, and `ObjectClipped::pvVar3`. Rejected
simplifications were restored: direct spot-color storage is FAIL 7 (226/225),
pointer reuse in `DrawC_SpotPrims` is FAIL 74 (227/225), and direct
`ObjectClipped` returns are FAIL 6 (61/61).

The refreshed audit is 320/395 declaration-clean with 658 generic extra local
names, 154 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 320 clean functions and 928 -> 658 generic extras.

Whole-TU detailed gates report `drawc.cpp` 19/20 PASS, `draww.cpp` 31/35 PASS,
and `hud.cpp` 59/62 PASS. Every failure is an unchanged locked baseline; no
unmatched function body was edited.

## Thirteenth PASS-only carrier-resolution wave

Nine unproven source names were removed from byte-matched functions:
`Draw_MenuRenderingView::{mr,m}` became direct view-matrix member accesses;
`DrawW_BuildChunkCenterLineFacets::{bVar10,curLine}` became a direct loop test
and reuse of canonical SYM `lineQuad`; `Flare_QuadRing::prev_pkt_slot` became a
direct packet-field store; `Hud_Render::{iface,j}` were deleted or replaced by
canonical SYM `i`; and the unused `Hud_Draw321Num::{arg4,arg5}` names were
omitted while retaining the mangling-proven six-`int` ABI.

Six names were converted from generic discrepancies to explicit measured
codegen carriers: `Draw_MenuRenderingView::bVar1`,
`DrawW_BuildChunkCenterLineFacets::rn`, `Flare_QuadRing::{innerColor,outerColor}`,
`Hud_Draw321Num::by2`, and `Hud_Render::remain`. New rejected-form measurements
include direct showroom retest FAIL 19 (237/234), direct flare color stores
FAIL 5/9 (46/45), merged HUD row storage FAIL 16 (111/111), and a source-level
HUD bonus-time clamp FAIL 16 (284/282).

The refreshed audit is 325/395 declaration-clean with 643 generic extra local
names, 160 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 325 clean functions and 928 -> 643 generic extras.

Whole-TU detailed gates report `fe3dmenu.cpp` 3/3 PASS, `draww.cpp` 31/35 PASS,
`flare.cpp` 27/27 PASS, and `hud.cpp` 59/62 PASS. Every failure is an unchanged
locked baseline; no unmatched function body was edited.

## Fourteenth PASS-only carrier-resolution wave

Seven source-only locals were removed from byte-matched functions:
`Night_SetWeatherColors::{colorH,color_walk,wtbl,wtblp}` became direct indexing
of the correctly sized retail arrays; unused `Night_SetEnviroment::{mode,zn}`
were deleted; and `DrawC_PrimHalo::iVar6` became direct mutation/tests of
canonical `sd->otz`.

Ten names were converted from generic discrepancies to explicit measured
codegen carriers: `DrawC_NightHeadlight::{h0,h1,h2,lp,wc}`,
`DrawC_PrimHalo::{uVar8,ov,ovs}`, and `Night_SetEnviroment::{tgt,zn2}`. New
rejected-form measurements include in-place halo type reuse FAIL 97 (295/298),
direct environment target access FAIL 6 (68/68), and direct Z-near constant
storage FAIL 8 (68/68). Existing in-source receipts preserve the allocator and
scheduler evidence for the remaining draw-car carriers.

The refreshed audit is 329/395 declaration-clean with 626 generic extra local
names, 170 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 329 clean functions and 928 -> 626 generic extras.

Whole-TU detailed gates report `drawc.cpp` 19/20 PASS and `night.cpp` 18/19
PASS. Both failures are unchanged locked baselines; no unmatched function body
was edited.

## Fifteenth PASS-only carrier-resolution wave

Twelve unproven source-local names were removed from byte-matched functions:
`DrawW_StripDraw_High::{bVar1,pTVar4,sVar2}` became the canonical SYM
`stripPtr` plus direct member expressions;
`DrawW_SetUpSubdividFacet_Line::{cw_a,cw_b,ts2,ts4,ts6}` became the exact
nested `a,b` color block plus direct `dvy` reads; and
`Hud_BustedOverlayOn::{pcVar1,iVar2,iVar4,psVar3}` became direct
`Hud_NextPerp[i]` indexing, leaving exactly the sole SYM local `i`.

Five source-only names now have explicit codegen-carrier dispositions:
`DrawW_StripDraw_High::pMaterial` and
`Hrz_TextureQuad::{pmx,pal,slot,tag}`. Their retained shapes are backed by the
existing in-source addressing/allocation and staged-OT-RMW receipts.

The refreshed audit is 333/395 declaration-clean with 609 generic extra local
names, 175 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 333 clean functions and 928 -> 609 generic extras.

Whole-TU detailed gates report `draww.cpp` 31/35 PASS, `hud.cpp` 59/62 PASS,
and `hrzsku.cpp` 20/22 PASS. Every failure is an unchanged locked baseline; no
unmatched function body was edited.

## Sixteenth PASS-only carrier-resolution wave

Fourteen unproven source-local names were removed from byte-matched functions:
`Flare_TextureQuad::shape_p`; `Flare_SingleColorOct`'s four decompiler
temporaries; `Hud_Render321Go`'s four duplicate `_00`/generic values;
`Weather_InitSplats::{rnd,splat_i,uVar1,y_max}`; and the unused
`Fe3D_InitShowroom::pCVar6`. The retained source now uses the exact SYM names,
natural signed division, direct call expressions, and indexed arrays.

Nine names were converted from generic discrepancies to explicit measured
codegen carriers across `Flare_TextureQuad`, `Weather_InitSplats`, and
`Fe3D_InitShowroom`. New rejected-form measurements include direct flare color
storage FAIL 5 (56/55), direct weather setup access FAIL 15 (66/69), and direct
showroom call algebra FAIL 22 (105/107); every exact form was restored.

The refreshed audit is 338/395 declaration-clean with 586 generic extra local
names, 184 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 338 clean functions and 928 -> 586 generic extras.

Whole-TU detailed gates report `flare.cpp` 27/27 PASS, `weather.cpp` 25/25
PASS, `fe3dmenu.cpp` 3/3 PASS, and `hud.cpp` 59/62 PASS. Every failure is an
unchanged locked baseline; no unmatched function body was edited.

## Seventeenth PASS-only carrier-resolution wave

Twenty-five previously generic source-local discrepancies were resolved across
four byte-matched functions. `Hud_BTC_QuitOut` now uses only the canonical SYM
`i`; `RaceSummary` directly derives its half-height and bar height;
`Weather_CheckAndResetParticles` uses canonical `flag`, direct random-call
expressions, and a direct signed half-z divisor; and `Hud_BlackThinBox` directly
expresses all six derived coordinates/spans.

Five names were converted to explicit measured codegen carriers:
`RaceSummary::{titleX,titleY,w2}`, `Weather_CheckAndResetParticles::rnd`, and
`Hud_BlackThinBox::CORNERWIDTH`. Rejected simplifications were restored: direct
`titleY` is FAIL 87 (344/349), direct weather modulo ordering is FAIL 77
(222/223), and direct shape-width expressions are FAIL 126 (117/123).

The refreshed audit is 342/395 declaration-clean with 562 generic extra local
names, 189 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 342 clean functions and 928 -> 562 generic extras.

Whole-TU detailed gates report `hud.cpp` 59/62 PASS, `overlays.cpp` 4/5 PASS,
and `weather.cpp` 25/25 PASS. Every failure is an unchanged locked baseline; no
unmatched function body was edited.

## Eighteenth PASS-only carrier-resolution wave

Eight byte-matched functions were restored to the canonical PsyQ `addPrim`
source shape. The real 24-bit ordering-table tag field replaces thirty-three
hand-mask staging names across six small-flare routines, both `Flare_Sun`
sites, and `Sky_RenderStars`; every function remains byte-identical.

Four color-load stages remain as explicit measured codegen carriers. Direct
loads are one instruction long and FAIL 5 in `Flare_Spikes`, `Flare_HexFlare`,
and `Flare_ReflectHexFlare`; the corresponding `Flare_PreCalcHexLightBeam`
form is FAIL 7. Each exact form was restored and receipted in source.

The refreshed audit is 350/395 declaration-clean with 525 generic extra local
names, 193 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 350 clean functions and 928 -> 525 generic extras.

Whole-TU detailed gates report `flare.cpp` 27/27 PASS and `hrzsku.cpp` 20/22
PASS. The two horizon failures are unchanged locked baselines; no unmatched
function body was edited.

## Nineteenth PASS-only carrier-resolution wave

Twenty source-only names were removed from five byte-matched functions.
`Flare_2DHalo` and `Hud_BuildReplay` now use canonical direct PsyQ/object
expressions; both `Hud_NextPlayer` routines use the exact SYM iteration and
object names; and `DrawW_BuildObjectFacets` directly consumes its clipping and
distance-call results.

Five remaining names were converted to explicit measured codegen carriers:
the two `Hud_NextPlayer*::carObj_00` values and
`DrawW_BuildObjectFacets::{animType,g,zo}`. Rejected simplifications were
restored: the Hud merges are FAIL 78 and FAIL 59 respectively, direct animation
member tests are FAIL 2 at the same 189-instruction count, and the `g`/`zo`
pair is the previously proven GCC `loop.c` anti-hoist joint cell.

The refreshed audit is 355/395 declaration-clean with 501 generic extra local
names, 198 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 355 clean functions and 928 -> 501 generic extras.

Whole-TU detailed gates report `flare.cpp` 27/27 PASS, `hud.cpp` 59/62 PASS,
and `draww.cpp` 31/35 PASS. Every failure is an unchanged locked baseline; no
unmatched function body was edited.

## Twentieth PASS-only carrier-resolution wave

`Hud_BuildSprite` was restored to its sole SYM local, `shape`, removing six
decompiler-only staging names with no byte change. `Hud_BuildString`'s six
non-SYM names now have explicit compiler-carrier dispositions: direct forms of
`iw1` through `iw5` fail by 8, 30, 8, 8, and 12 diffs respectively and are two
instructions long; `as` retains its existing measured allocator receipt.

The refreshed audit is 357/395 declaration-clean with 489 generic extra local
names, 204 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 357 clean functions and 928 -> 489 generic extras.

The whole-TU detailed gate remains `hud.cpp` 59/62 PASS. Its three failures are
unchanged locked baselines; no unmatched function body was edited.

## Twenty-second PASS-only carrier-resolution wave

`Hud_BuildTimeSprites` lost six dead decompiler declarations and now explicitly
classifies only its measured indexed-GIV `n`. `Flare_CarShapedHalo` and
`Flare_Halo2` now use canonical `Flare_PTag` ordering-table links; their
remaining source-only values are backed by the existing compiler receipts.
`Flare_Halo2`'s unused final argument retains its mangling-proven type and arity
without asserting a parameter name absent from the SYM.

The refreshed audit is 364/395 declaration-clean with 442 generic extra local
names, 211 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 364 clean functions and 928 -> 442 generic extras.

Whole-TU detailed gates report `flare.cpp` 27/27 PASS and `hud.cpp` **60/62
PASS**. `Hud_BuildNumbers` moved from FAIL 188 to independently verified PASS
758/758 as a collateral TU-codegen improvement; its body was not edited. Only
the untouched locked `Hud_BuildCdPlayer` FAIL 1 and `Hud_RenderTacView` FAIL 11
remain in Hud.

## Twenty-third PASS-only carrier-resolution wave

Twenty-seven previously generic names across `Hud_BuildNumbers`,
`Hud_BuildTach`, `Hud_BuildMapMarkers`, and `Hud_BuildWingmanInterface` now have
explicit compiler-carrier dispositions tied to their existing measured
allocation, scope, CSE, fold, or scheduling receipts. A fresh direct-load test
also proves `Hud_BuildTach::tachNeedle_p` is required: its removal is FAIL 14 at
the same 269-instruction count.

The refreshed audit is 368/395 declaration-clean with 415 generic extra local
names and 238 explicit source-only carriers. `hud.cpp` remains 60/62 PASS; only
the two untouched locked failures remain.

## Twenty-fourth PASS-only carrier-resolution wave

`Hrz_GetHorizonPixMap` was rewritten from nine fabricated address walkers to
natural indexed arrays and exactly the sole SYM local `i`, remaining PASS
45/45. `Weather_Init` now uses canonical SYM `i` and `sv` for its two loops,
removing eight decompiler staging names; only its two independently measured
aggregate-copy base carriers remain. It stays PASS 211/211.

The refreshed audit is 370/395 declaration-clean with 396 generic extra local
names, 240 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 370 clean functions and 928 -> 396 generic extras.

Whole-TU detailed gates report `hrzsku.cpp` 20/22 PASS and `weather.cpp` 25/25
PASS. The two horizon failures are unchanged locked baselines; no unmatched
function body was edited.

## Twenty-first PASS-only carrier-resolution wave

Twenty-eight unused, non-SYM declarations were removed from four byte-matched
packet builders: `Hud_BuildGT4`, `Hud_BuildFT4`, `Hud_BuildMirrorFT4`, and
`Hud_BuildMapMirrorFT4`. Their bodies were already expressed as direct packet
stores, so the cleanup is source-only and all four remain exact.

The refreshed audit is 361/395 declaration-clean with 461 generic extra local
names, 204 explicit source-only codegen carriers, zero missing SYM names, one
function type finding, and zero global type findings. Cumulative PASS-lock
movement is 193 -> 361 clean functions and 928 -> 461 generic extras.

The whole-TU detailed gate remains `hud.cpp` 59/62 PASS. Its three failures are
unchanged locked baselines; no unmatched function body was edited.
