# Original-source name recovery backlog

## Policy

A descriptive semantic identifier is not evidence of the original source
spelling and is not an accepted correction.  When retail SYM/SLD proves that a
distinct source object existed but does not retain its name, the conspicuous
decompiler placeholder remains in source as an unresolved signal.  The item
remains **unresolved** until canonical source, another symbol-bearing build, or
equivalent direct evidence recovers the actual spelling.  Byte-exact code
generation does not close an original-name item.

The placeholder names below must not be described as recovered, SYM-exact, or
final.  Future work must replace each one with the proven original spelling;
invented semantic substitutions do not close the item.

Evidence limit: a failed finite set of carrier-removal experiments proves only
that those tested source shapes do not match. Historical statements below that
a carrier is "required" must not be read as proof that it existed in the lost
source or that every carrier-free form is impossible. Such items remain open to
source-shape recovery, including intermediate higher-diff experiments.

## Open items

| Owner/function | Retained unresolved identifier | What is proved | Missing evidence / closure condition |
|---|---|---|---|
| `recon/game/common/replay.cpp` — `Replay_ResetReplay__Fv` | `piVar2` (decompiler placeholder; invented `counterCursor` was rejected and reverted) | The retained pointer form is PASS86. Tested indexed loops emit87/86 with a late +4 address adjustment under both retail compilers; finite failed tests do not prove that a separate source pointer existed. | Retail SYM names only `i`; recover a matching carrier-free source/inline form, or direct evidence of an original pointer object and its spelling. P877 isolates the GCC late-GIV/address-bias question. |
| `recon/game/common/copspeak.cpp` — `CopSpeak_PlayNextRequest__Fv` | `next` (existing same-object recovery, not a surviving target-local record); remaining SLD grouping | P877 eliminates the rejected `iVar3` through the existing `next` value chain at PASS71, with unchanged whole-object bytes. Native `r`/`handle` homes remain exact. No invented `queueIndex` was reinstated. | Target SYM records only `r` and `handle`; establish the target-specific `next` lifetime/home and finish the remaining source groups at retail1221/1222/1237. Full SYM/SLD exactness is not claimed. |
| `recon/game/common/aihigh.cpp` — `AIHigh_Execute__Fv` | `bVar1` (decompiler placeholder, not an accepted semantic replacement; invented `executeHighLevelAI` was rejected and reverted) | A distinct decision object is required: direct short-circuit reconstruction produces 61 rather than 66 instructions and 33 oracle diffs; retained form is PASS 66/66. | SYM names only `carLoop` and `carObj`; recover the decision object's original spelling. |
| `recon/game/common/nfs3.cpp` — `NFS3_CheckForFileOperations__Fv` | `e` (temporary placeholder, not an accepted source spelling) | The former guard-only `g` declaration was eliminated: repeating `gFileMgr.handlearray` is CSE'd to the exact retail guard value. A distinct loop bound remains required for PASS 21/21; direct loop comparison changes allocation. | Retail NFS4 SYM retains only `p`; this PSX-only function has no NFS2 PC counterpart, and the checked reference trees retain no source name for the bound. Recover it from canonical/source-bearing evidence or eliminate it with a byte-exact loop form. |
| `recon/game/common/mpause.cpp` — `MPause_Logic__Fv` | `oldItem`, `newItem` (descriptive reconstruction placeholders, not accepted original spellings) | Retail code and SLD require distinct immutable before/after `fCurrentItem` snapshots across `VirtualProcessInput`. Declaring them as block-local `const int` objects produces the exact 199-instruction body and GCC 2.8.0 emits no debug definition for either, matching retail's local/block topology. | Retail SYM retains only `command`, `keyVal`, `debounce`, nested `start`, and nested `finish`. CPE/MAP, every split decompiler, NFS2/NFS3, NFS4 PC/mobile, and region references recover no spelling. Recover both names from source-bearing evidence or eliminate them with an exact ordinary expression shape. |
| `recon/game/common/sim.cpp` — `Sim_ProcessSimSchedules__Fv` | `firstSfx` (descriptive reconstruction placeholder; narrow integer spelling also underdetermined) | Retail SLD/debug topology proves a block-local optimized quantity initialized to `0x23` beside retained `int i`: non-const `char`, `u_char`, and `short` variants all preserve PASS 201/201 without emitting a `.def`, while `int` emits a forbidden extra debug local and literal/const forms collapse to 197 instructions. The natural clamp/`for` reconstruction now matches retail's six block starts and first block end. | Retail SYM names only `i`; all checked decompilers generate placeholders and the NFS2/NFS3/NFS4-PC/mobile/source references recover neither the lexeme nor a unique narrow type. Recover direct source-bearing evidence or an exact carrier-free source form. |
| `recon/game/common/aih_opp.cpp` — `AIHigh_Opponent::CheckForWipeOut` | `numRacers`, `bVar1`, `hlai`, `speedLimit`, `carIndex`, `field1380`, `slotAddr`, `absField`, `state` (all placeholders, including semantic-looking spellings) | Detailed GCC allocation/scheduling receipts prove that distinct source-shape quantities are required for the current PASS 120/120 body. | Retail NFS4 SYM retains only `perTickProb`, `randVal`, `oppLevel`, `oppFines`, `hLoop`, `thisPlayerObj`, `thisPlayer`, and `playFines`. Recover every other spelling from canonical/source-bearing evidence; behavior and register role are insufficient. |
| `recon/game/common/aih_basicperp.cpp` — `AIHigh_BasicPerp::RemoveChaser` / `AddChaser` | `piBase`, `piVar2` (decompiler placeholders) | Retail records an inlined `AICop_BasicPerpInfo this` receiver and, at the third indexed-read site, formal `copType type`. An inline reference-returning `operator[]` experiment made all three sites exact (15/15, 21/21, 202/202) and all ten header consumers stayed green. | SYM/SLD does not retain the accessor spelling; a named reference-returning member is observationally equivalent. Recover the actual member/operator spelling before replacing the conspicuous placeholders. |
| `recon/game/common/aih_basiccop.cpp` — `AIHigh_BasicCop::CheckSpikeBelt` | `freshenElapsed` (temporary placeholder) | Two separate nested `int timeNow` declarations are now restored to their exact SLD blocks. A distinct optimized-out predicate is still required for the retail zero initialization and `slti`/`sltiu` sequence; the function remains PASS 50/50. | Recover the predicate or timer-macro source spelling. Direct conditions and ternaries change allocation/control flow, and retail retains no name for the predicate. |
| `recon/game/common/aih_play.cpp` — `AIHigh_Player::SetupBlockade` / `HandlePullOver` | `bVar2`, `bVar1` (decompiler placeholders) | Retail materializes optimized-out short-circuit results in `$a1`/`$a2`. Carrier-free forms regress to 669/674 with 121 diffs and to 307/307 with register/scheduling diffs respectively. | Recover the exact boolean or macro spelling from source-bearing evidence; NFS4 SYM/SLD retains no name and the checked NFS2/NFS3/NFS4-PC families have no authoritative twin. |
| `recon/game/common/aiphysic.cpp` — `AIPhysic_RevEngine` | `deadfrm` (temporary two-word array) | Retail has an unused 8-byte leaf frame with no stack loads/stores, while SYM records only register locals `increase` and `redLine`. The generated debug twin emits `deadfrm` as an AUTO, proving the current array is not SYM-exact. The identical NFS3 routine has the same otherwise-unused frame. | Recover a natural shared source/compiler construct that recreates the 8-byte frame without a third debug local. Neither the current name nor its two-int array type is accepted as original. |
| `recon/game/common/ai.cpp` — `AI_KeepCarsInLane` | lost compile-time-dead body (the former `local[4]` claim is eliminated) | NFS2/NFS3/NFS4 PSX share the exact four-word leaf. A compile-time-dead ordinary call produces `.frame $sp,16,$31` with `vars=0,args=16`, no AUTO record, and exact retail code; the frame is GCC's surviving outgoing-argument area rather than source storage. | Recover the original disabled/dead body from source-bearing evidence. The retained dead call proves the compiler mechanism and SYM-valid frame class but is not asserted as the unique lost body. |
| `recon/game/common/aidatarecord.cpp` — `AIDataRecord_t::StartUp2` | direct manual vtable dispatch (no extra local remains) | Retail SYM retains only `recordLoop`. Repeating the indexed object/vtable expression lets GCC recreate the anonymous `$v1/$v0` temporaries and remains PASS 27/27; the disproved `pAVar1` source local is gone. | Restore the exact class/virtual declaration that lets ordinary `recordCollection[recordLoop]->Setup()` reproduce retail dispatch; current manual vtable syntax is an intermediate reconstruction, not final original C++. |
| `recon/game/common/aidatarecord.cpp` — `AIDataRecord_t::CleanUp1` | direct manual deleting-destructor dispatch (no extra local remains) | Retail SYM retains no local. Repeated global/vtable expressions recreate the anonymous temporaries and remain PASS 28/28; the disproved `pa_Var1` source local is gone. | Restore the exact class/deleting-destructor model so ordinary `delete` reproduces retail dispatch. Current manual vtable syntax remains an explicit source-restoration backlog item. |

## P843 verified game/common source-shape round

This round removed seven source-only carrier mappings without inventing NFS4
spellings and kept every touched function byte-exact:

- `AIPhysic_CalculateGear` now uses the source-bearing NFS2 compound `while`
  condition.  GCC naturally recreates the former `found` result; NFS4 remains
  **PASS 65/65** with an exact `-g`/SLD twin.
- Both AILife slice-visibility searches are natural indexed `for` loops with
  `sliceDist` in the exact retained inner block.  GCC strength-reduces the
  indexing into retail's anonymous cursor, eliminating both `ppCVar2`
  placeholders; each remains **PASS 40/40** with an exact debug twin.
- `AI_CalculateAdjustedDesiredSpeed` now follows the symbol-bearing NFS2
  `MAX(member, constant)` / ternary source family.  Restoring the canonical
  `MAX` macro expansion removed both the invented `adjustedSpeed` local and
  the invented constant-return helper while preserving **PASS 166/166** and
  the exact SLD twin.
- `AIHigh_Opponent::DoProvokedAttack` now uses `otherCar`, the exact spelling
  retained by the independent NFS2 SYM and source-bearing collision ancestor;
  NFS4 remains **PASS 43/43** with an exact debug twin.
- `AIDataRecord_t::StartUp2` and `CleanUp1` no longer claim source locals that
  retail does not record.  Direct expressions reproduce the anonymous
  compiler temporaries at **27/27** and **28/28**; the remaining manual-vtable
  source-model debt is kept explicitly open above.
- `CheckSpikeBelt` restores both exact nested `timeNow` declarations and their
  SLD regions while leaving the still-undetermined predicate conspicuous.
  It remains **PASS 50/50**.

Two attractive but underdetermined rewrites were deliberately rejected.  An
inline `AICop_BasicPerpInfo::operator[]` made all three indexed sites exact and
kept every header consumer green, but retail does not retain the accessor
spelling.  Carrier-free `SetupBlockade`/`HandlePullOver` conditions likewise
failed their detailed oracles.  The incoming placeholder forms were restored
instead of turning plausible semantics into invented source.

## P844 typed `Trk_NewSlice` source-model round

The symbol-bearing NFS2 AI sources and the exact 32-byte retail slice layout
recover the real `Trk_NewSlice` field model used by `ai.cpp`.  Adding that type
and the canonical `Trk_NewSlice *BWorldSm_slices` declaration allowed two
source-only carrier mappings to disappear without inventing local names:

- `AI_HandleChangeInNumLanes` now reads `.laneCount` directly.  GCC naturally
  recreates the former anonymous byte cache, eliminating the unsupported
  `laneCount` source local while preserving **PASS 92/92** and an exact
  `-g`/SLD twin.
- `AI_HandleShouldersAndOffRoad` now uses `.leftDrive`, `.rightDrive`,
  `.laneCount`, `.avgPavedWidthLf`, and `.avgPavedWidthRt` instead of scoped
  `char *sl` offset carriers.  The natural typed expressions preserve
  **PASS 241/241** and an exact `-g`/SLD twin.

The complete `ai.cpp` translation unit remains **40/40 PASS**, and both
functions have zero branch-opcode census divergence.  Closure evidence is the
retail SYM/SLD plus
`C:\Temp\nfs2-clean\pc-beta\match\ai\AI_HandleChangeInNumLanes.c` and
`C:\Temp\nfs2-clean\pc-beta\match\ai\AI_HandleShouldersAndOffRoad.c`.

## P845 carrier-free `AILife_RCPickSliceAndDirection`

Retail SYM omits both reconstruction objects `basisCarIndex` and `basisCar`.
SLD assigns the index calculation, life-basis-list lookup, and member store to
one source statement, while raw retail computes the index transiently and
later reloads `carObj->basisCar`.  The symbol-bearing NFS2 ancestor likewise
has no pointer/index local and repeatedly uses the member directly.

Restoring that source family closed both items without inventing names or
using a volatile barrier.  The first RNG result now feeds the single ordinary
pointer-add lookup
`*(Cars_gLifeBasisCarList + index)` before the second RNG statement; direct
`carObj->basisCar` accesses then let GCC reproduce the retail shared load.
`AILife_RCPickSliceAndDirection` remains **PASS 270/270** twice with an exact
`-g`/SLD twin, zero branch-opcode divergence, and `ailife.cpp` remains
**20/20 PASS**.  The previous explicit `basisCarIndex` local and volatile
`basisCar` snapshot are eliminated rather than renamed.

## P846 R3DCar CI diagnosis and canonical `locatebig` prototype

The reported two-TU CI failure was traced to the older `971772f7` tree.  Its
fatal errors were duplicate completed foreign types (`Sim_tSimGlobalVar` in
`anim_types.h` and `DRender_tView` in `r3dcar_types.h`); `build.py` displayed
only each compiler diagnostic's final line, making R3DCar's unrelated line
1863 conversion warning look fatal.  Commit `6ebbe9a3` had already removed
both duplicate definitions, and every subsequent workflow through the current
tree is green.

The warning nevertheless exposed a real declaration error.  The matched NFS4
callee in `recon/eaclib/psx/eacpsxz/locatbig.c` defines
`char *locatebig(void *, char *)`, independently corroborated by the
symbol-bearing NFS2 source.  `r3dcar_externs.h` now uses that exact prototype
instead of `void *locatebig(...)`.  All four false `void *`-to-`char *`
warnings disappear, `r3dcar.cpp` remains **27/27 PASS**, and its branch census
is unchanged.

## P847 carrier-free AI lane-position source

Retail SYM records no `laneWidth` local in either `AI_TryToShareLanes` or
`AI_CalculateDesiredLatPosition`, and no `blockingCarNearby` local in the
latter.  SLD assigns every width load/shift/multiply to the surrounding edge
or desired-position statement; it also assigns the compiler's false/true
condition materialization to one compound-condition line rather than to
source-local assignments.  This is independently corroborated by the matched,
symbol-bearing NFS2 `AI_CalculateDesiredPosition` ancestor and the NFS4 mobile
descendants.

Both functions now use the exact `Trk_NewSlice *BWorldSm_slices` fields
directly.  The source-backed `ABS(a)` expansion and nested condition let GCC
recreate the former anonymous `$s2` truth value without exposing a fake local.
All six scoped `laneWidth` declarations and the invented
`blockingCarNearby` declaration are gone.  `AI_TryToShareLanes` remains
**PASS 63/63**, `AI_CalculateDesiredLatPosition` remains **PASS 141/141**,
both `-g` twins are exact, and the complete `ai.cpp` TU remains **40/40 PASS**.

## P848 AILife source-backed ABS and paint index round

Retail SYM and SLD show that `AILife_PlaceCarAtLocation` has only
`targetDirection` and `speed` in its moving branch: the reconstruction's
`direction` cache was not a source local.  The matched NFS2 `AI_ReInit`
ancestor supplies the exact source family—`speed = ABS(currentSpeed)` followed
by direct `targetDirection.x` use—and the canonical `ABS(a)` expansion lets
GCC retain the field value anonymously.  The carrier is eliminated while the
function remains **PASS 129/129** with an exact `-g` twin.

The two traffic reincarnation functions genuinely require a standalone scalar,
but `colorIdx` was invented.  The symbol-bearing NFS2 source and SYM recover its
exact name and type as `int paintIndex`, plus the original
`(((randtemp & 0xffff00) >> 8) * 3) >> 16` expression.  Both NFS4 functions
remain **PASS 44/44** and **PASS 131/131**, respectively, with exact `-g`
twins.  `ailife.cpp` remains **20/20 PASS** and all affected branch-word audits
are clean.

## P849 AI indexed merits and traffic-honking source round

`AI_CalcMeritsBasedOnSpeed` no longer exposes the five reconstruction-only
objects `lane`, `laneInfo`, `laneSpeed`, `observation`, and
`observationBase`.  NFS4 SYM retains only `dSpeed`, `cSpeed`, and
`considerDesired`, while the exact symbol-bearing NFS2 predecessor recovers
the optimized loop counter as `int i`.  Direct indexed `AI_Info` and
`CarLogic_gObs` expressions in source, expressed as the retail-compatible
`do/while`, let GCC recreate all pointer induction anonymously.  The function
remains **PASS 224/224** twice, with an exact `-g`/SLD twin and 27/27 strict
branch words clean.

`AI_HandleTrafficHonking` now uses the typed source member
`GameSetup_gData.reverseTrack` and the source-family comparison
`direction != (reverseTrack == 0 ? 1 : -1)`.  This eliminates the synthetic
address alias `D_8011321C` and the unsupported `direction` and `shouldHonk`
locals.  The RNG intermediate is no longer named with the invented
`randomValue`: the matched, symbol-bearing NFS2 predecessor recovers its exact
spelling and type as block-local `int honkprob`, in the same lexical RNG block
shown by NFS4 SLD.  NFS4's optimized SYM omits that home, just as it omits the
recovered loop counter above.  The function remains **PASS 65/65** twice, its
`-g` twin is exact, and all 8 strict branch words are clean.

The complete `ai.cpp` TU remains **40/40 PASS**.  This round removes eight raw
`SYM-CODEGEN-CARRIER` rows and adds two exact cross-build name recoveries
without adding volatile, assembly, or postcompile rewriting.

## P850 canonical macro, forward-loop, and compiler-frame round

This round eliminates **20 reconstruction-only local declarations** represented
by **13 raw `SYM-CODEGEN-CARRIER` rows**, while every affected function remains
byte-exact and every `-g` twin is exact:

- The matched NFS2 source's canonical `MIN`/`MAX` family removes `t` from
  `AIPhysic_SimplePhysics_LongVel`, all seven scoped `r` clamp results from
  `AIPhysic_OutOfControlPhysics`, `clampedRoadNoiseAmp` from
  `AudioCmn_SoundCar`, `maxImpulse` from `Newton_ApplyTheLawOfGravity`, both
  scoped `a` results from `Physics_CalculateTireForces`, and `brakeCap` plus
  `limitedBrakeAcc` (including their empty compiler fence) from
  `Physics_Real`.  The functions remain **214/214**, **412/412**, **530/530**,
  **315/315**, **346/346**, and **1272/1272**, respectively.
- GCC 2.8.1 loop reversal explains the retail countdowns in
  `AIScript_ClearLastReactionIndex`, `AudioTrk_StartUp`, and
  `BWorld_InitContexts`.  Restoring ordinary forward `for` loops with direct
  `-1` stores removes both `neg1` locals and `noClient` while preserving
  **9/9**, **23/23**, and **14/14**.
- `AI_CheckForPlayerActions` now repeats the source member expression in the
  conventional multiplication order; GCC recreates the anonymous direction
  value and preserves **144/144**.
- `AI_KeepCarsInLane` no longer lies about a 16-byte AUTO array.  A
  compile-time-dead call produces the exact four-word leaf and the debug twin
  reports `vars=0,args=16` with no extra `.def`; the unrecovered dead body is
  kept open above.
- `NormalCache_Init` now uses the ordinary two-statement source implied by the
  retail SLD: `sliceInd = -1` and `quadInd = -1` occupy distinct line records
  1416 and 1417.  The `quadInd` member is restored as `signed char`: retail
  consumes it with `lb`, uses `-1` as its sentinel, and GCC 2.8 emits the same
  SYM `CHAR` debug code for `char` and `signed char`.  This removes both the
  unsupported `invalid` local and the chained-cast workaround while preserving
  **15/15**; `NormalCache_FindEntry` also remains **49/49** with direct typed
  access.

Two additional source-only expansions were collapsed back to their canonical
matched-source spellings without changing declarations or code: the six
`Collide_LimitAngularVel` clamps use NFS2/NFS3's `MIN`/`MAX` family at
**61/61**, and `Stats_TrackStats` uses NFS2's `MIN(speed, cap-rand*3)` at
**258/258**.  All fourteen touched branch-word audits are clean.  TU gates are
green for `ai` 40/40, `aiphysic` 42/42, `aiscript` 8/8, `audiocmn` 48/48,
`audiotrk` 6/6, `bworld` 21/21, `bworldSm` 28/28, `collide` 14/14, `newton`
32/32, `physics` 22/22, and `stats` 7/7.

## P851 ring-wrap and SLD block-scope round

This round eliminates **five reconstruction-only local declarations**
represented by **two raw `SYM-CODEGEN-CARRIER` rows**, while both functions
remain byte-exact and both `-g` twins are exact:

- `AIPhysic_GetDesiredVector` now uses the nested conditional wrap expression
  found in the matched NFS2 implementation.  Its two complete assignments
  correspond to single retail SLD statements at `0x8006AD64-0x8006ADA4` and
  `0x8006AF38-0x8006AF7C`; SYM contains no `v` local.  Repeating the original
  expression in both wrap sites removes four mutually exclusive scoped `v`
  declarations and preserves **378/378**.
- `Camera_SetSplineCam` now uses the canonical
  `MIN(numSlice + 1, 8)` expression and declares `direction` in the replay
  block where its retail SLD lifetime begins at `0x8008255C`.  The two changes
  are allocator-coupled: the macro shape alone changes 46 instructions, while
  restoring the block scope recreates the exact saved-register allocation.
  The unsupported `sliceStep` local disappears and the function remains
  **128/128**.

The complete `aiphysic.cpp` and `camera.cpp` TU gates remain **42/42 PASS** and
**38/38 PASS**, respectively.  Neither restoration uses volatile, assembly,
or postcompile rewriting.

## P852 replay source and retail-compiler identity round

`Replay_StoringControllerData` is restored to the ordinary four-stanza source
preserved by the symbol-bearing matched NFS2 implementation and by the retail
NFS4 SLD.  The only AUTO is `packeddata[33]`; each stanza directly copies the
33-byte result of `Replay_Compress`, appends the encoded byte count, and advances
`Replay_ReplayStorePtr`.  This removes four scoped `source` locals,
`packedPtr`, `replayBuffer`, their local aggregate workaround, and all five
empty asm fences represented by **three raw `SYM-CODEGEN-CARRIER` rows**.

The clean body exposes the original compiler identity.  Sony GCC 2.8.0 omits
one returned-pointer move after each `Replay_Compress` call and produces
239/243 instructions; the hash-pinned retail PsyQ 2.8.1 SN32 C++ compiler
naturally emits all four moves and is exact at **243/243**.  A narrowly scoped
`PER_FN_CC1PLUS_VER_SPLICE` entry selects that retail compiler for this function
only.  `diffsrc.py` now mirrors the same retail compiler selection for its
diagnostic `-g` twin, so the source/SLD attribution is exact rather than a
false 2.8.0 fuzzy comparison.  The complete `replay.cpp` TU remains
**16/16 PASS**.  This is compiler-input selection, not a postcompile text move
or opcode rewrite.

## P853 canonical slice-loop round

`AIWorld_IsDriveableLaneInSliceRange` now uses its retail SYM local
`checkSliceOffset` as the loop counter and the existing canonical
`WRAP_SLICE(checkSliceOffset * direction, startSlice)` macro.  The matched NFS2
source preserves the same loop/macro idiom, while NFS4 SLD assigns the loop
counter, complete wrap expression, profile access, and increment to the
corresponding source statements.  This removes the unsupported `sliceDelta`
and `i` declarations represented by **two raw `SYM-CODEGEN-CARRIER` rows**.
The function remains **46/46**, its `-g` twin is exact, all seven branch words
are clean, and the complete `AIWORLD.cpp` TU remains **22/22 PASS**.

## P854 nested macro and typed-row round

This round eliminates **four reconstruction-only local declarations**
represented by **three raw `SYM-CODEGEN-CARRIER` rows**:

- `AIPhysic_SimplePhysics` now uses the same repeated nested ring-wrap
  expression preserved by the symbol-bearing NFS2 AI-physics source.  GCC
  common-subexpression elimination recreates the retail value web without the
  two mutually exclusive scoped `v` declarations; the function remains
  **219/219**.
- The final look-ahead clamp in `AIPhysic_GetDesiredVector` is restored as
  `MAX(4, sliceLookAhead)`.  The constant-first argument order is allocation
  significant: reversing it gives 11 differences and 377/378 instructions,
  while the canonical retained form removes `t` and remains **378/378**.
- `Camera_SetSplineCam` now reads the camera and road matrix rows through
  `(coorddef *)&rotation.m[6]` views, the same typed row idiom preserved in the
  matched NFS2 camera source.  IDA's `$s1` is therefore a compiler-generated
  row pointer rather than a source local; removing `cameraDirection` preserves
  **128/128** and matches the single retail SLD dot-product statement.

All three `-g` twins are exact and all 56 branch words are clean.  The complete
`aiphysic.cpp` and `camera.cpp` TU gates remain **42/42 PASS** and **38/38
PASS**, respectively.  No volatile, assembly, invented replacement name, or
postcompile rewrite was introduced.

## P855 canonical lower-bound macro round

Two `aispeeds.cpp` lower-bound clamps now use EA's canonical
`MAX(a,b)` macro spelling instead of reconstruction-only source objects:

- `AISpeeds_GetDamageFactor` directly assigns
  `MAX(0x8000, carObj->damageMult)`.  This removes the invented inline helper
  identifier `AISpeeds_Max`, for which neither SYM nor SLD preserves a source
  declaration.  The constant-first argument order is allocation-significant
  and preserves the exact **70/70** body.
- `AISpeeds_CalcTrafficTopSpeed` directly returns through
  `MAX(desired, 0x8e38e)`.  This removes the unsupported `minimumSpeed` local
  represented by **one raw `SYM-CODEGEN-CARRIER` row** and preserves the exact
  **104/104** body; reversing the macro arguments gives 12 differences.

`AISpeeds_BTCGetGlueFactor` was also challenged with direct-index, ternary,
and all eight nested `MIN`/`MAX` argument-order forms.  None reproduced the
retail allocation (best result: 8 differences), so its receipted
`clampedGlueIndex` carrier remains open and exact at **111/111**.  All three
functions were gated twice and the complete `aispeeds.cpp` TU remains
**29/29 PASS**.  No volatile, assembly, or postcompile rewrite was introduced.

## P856 cross-build view identity and natural group-expression round

Three unsupported carrier rows have been closed without changing retail code:

- `AudioClc_GetClosestCars` now uses `DRender_tCalcView *view` and
  `view->translation.x/y/z`.  The symbol-bearing, byte-matched NFS2 PC source
  preserves that exact pointer name, type, and member-access spelling; NFS4
  replaces the earlier parameter with `&AudioClc_gRenderView`.  The optimized
  NFS4 SYM omits the pointer home, so this is recorded explicitly as an exact
  cross-build recovery rather than an invented semantic name.  The former
  `viewpos` carrier is gone and the function remains **267/267**.
- `SerializedGroup::LocateNextGroupType` now uses the natural mismatch guard
  and returns `group` afterward.  Retail SYM records only `group`; the
  reconstruction-only XOR operand `zero` is gone and the function remains
  **10/10**.
- `SerializedGroup::LocateGroupType` now expresses alignment directly as
  `group->m_length += 4 - (group->m_length & 3)`.  Retail SYM records only
  `group`, `numElems`, and `count`, while the IDA body independently preserves
  this `(length + 4) - (length & 3)` form.  The unsupported `newLen` carrier is
  gone and the function remains **28/28**.

All three source-only gates passed twice, all three `-g` twins are exact, and
all 45 branch words are clean.  Complete TU gates remain **18/18 PASS** for
`audioclc.cpp` and **6/6 PASS** for `group.cpp`.  The strict all-TU object build
also completes without skipped objects; vtable and source-policy audits pass,
and the complete `recon`/`src` relink gate is GREEN with zero real duplicates,
hidden phantoms, or relocation-referenced unresolved names.  Direct inlining of
`ObjectFinishedMultiAnim` was measured and rejected at 14 differences;
carrier-free `Paths_StartUp` candidates were rejected because the best natural
form retained two scheduling differences and the exact helper form damaged SLD
line/block provenance.  Those receipted exact carriers remain open.

## P857 canonical quad macros, Group receivers, and SLD lexical round

This round removes **six raw `SYM-CODEGEN-CARRIER` rows** without inventing
replacement names, and improves two additional functions' lexical/debug source
shape while keeping their unrecoverable names explicitly open:

- `BWorldSm_FindClosestQuadRez` and `BWorldSm_FindClosestTriangleRez` now use
  the exact `QUAD_PT_DIR` / `PT_IN_QUAD` macro family preserved by the matched,
  symbol-bearing NFS2 `RawFindClosestQuad` source.  The macros naturally
  recreate retail's condition values, eliminating `inQuad`, `crossA`, and
  `crossB`; the functions remain **PASS 115/115** and **PASS 39/39**.
  `BWorldSm_TunnelFlagSm::surfVal` remains open: direct, ternary, reversed, and
  default-valued name-free forms leave 6, 9, or 13 differences.
- `Track_LoadObjectKillData` now uses the pre-existing `Group::GetNumElements`
  and `Group::GetData` inline surface at both sites.  Retail records the paired
  nested `Group this` receivers at `0x800BAE3C` and `0x800BAE84`, proving that
  the former `groupElements` source object was spurious.  `inst`, `index`,
  `simObjs`, `numElements`, and `j` were also moved into retail's declaration
  order and nested lexical regions.  `ReduceObjectPrecision` and
  `InvalidatePersistentCollideBoomObjects` now use their recorded
  `GetNumElements` receiver scopes and declare `count` before `inst`;
  `CalcObjectBoundingSphere` restores the consecutive `GetData` and
  optimized-empty `GetNumElements` inline pairs.  The four functions remain
  **PASS 86/86**, **40/40**, **27/27**, and **152/152**.  Broader pre-existing
  compound-control wrapper `.begin/.bend` differences remain a future SLD
  source-structure item; this round claims the proven accessor and local-scope
  topology, not a globally identical raw debug stream.
- `PauseMenu_MenuTextPositioned::flags` is restored as `short flags`, exactly
  as retained by the byte-matched NFS2 `FeTools_Text` source.  GCC 2.8.0 emits
  no debug definition for the optimized NFS4 home, matching retail's `str` /
  `color`-only local list, and the function remains **PASS 30/30**.
- `MPause_ControllerLogic` now uses the TU's existing inline enable/disable
  source surface directly, eliminating the unsupported retained `item` pointer
  while preserving **PASS 57/57** and retail's zero-local record.
  `MPause_Logic` improves from function-scope mutable carrier declarations to
  block-local immutable before/after snapshots; GCC emits no `.def` and the
  function remains **PASS 199/199**.  The names `oldItem` and `newItem` are not
  source-backed, so both remain explicit carriers and open backlog entries.
- `Sim_ProcessSimSchedules` replaces its reconstruction-only `goto` clamp and
  `do/while` with the natural nested clamp/`for` topology recorded by SLD.
  Block-local `int i` now occupies retail's exact region.  A non-const narrow
  `firstSfx` object is required to retain `$s1 = 0x23` at **PASS 201/201** and
  is optimized out of the debug table; its spelling and unique narrow type are
  underdetermined, so the carrier remains explicitly open above.

All ten landed functions pass the source-only gate twice, their diagnostic
`-g` twins are exact, and all **77** of their strict branch words are clean;
the challenged-but-restored `BWorldSm_TunnelFlagSm` also remains PASS with its
two branch words clean.  Complete
TU gates remain **28/28** (`bworldSm.cpp`), **10/10** (`mpause.cpp`), **60/60**
(`pausemenu.cpp`), **8/8** (`sim.cpp`), and **29/29** (`track.cpp`).  The matched
NFS2-style carrier-free `Clock_MasterInterruptHandler` was also retested: all
ordinary postfix, prefix, assignment, pointer, and reference forms converge on
the same 42/43 scheduling result, so `clock.cpp` was restored byte-for-byte.
No volatile, new assembly, postcompile rewriting, or invented recovered name
was added.

## Expansion requirement

This is a living backlog.  Every retained source-only carrier whose spelling is
not directly recoverable must be added as the exhaustive carrier audit reaches
it.  Completion of the project-wide goal requires recovery of each original
spelling; a backlog entry records incomplete work and never converts an
underdetermined spelling into an accepted solution.

## Project-wide unresolved carrier queue

Every remaining `SYM-CODEGEN-CARRIER` marker in `recon/**/*.c` and
`recon/**/*.cpp` is an open original-source item, even when its identifier is a
plausible semantic phrase rather than an obvious decompiler placeholder.  The
marker itself records the owning function, identifier, and code-generation
receipt; it must not be interpreted as proof of the identifier's original
spelling.  A row leaves this queue only when direct source-bearing evidence is
recorded and its marker is replaced by `ORIGINAL-NAME-RECOVERED` (or when the
extra source object is eliminated while preserving the oracle).

Current measured queue: **1,523 unresolved carrier-marker rows project-wide**,
of which **532 are in `recon/game/common`**.  There are currently **34
`ORIGINAL-NAME-RECOVERED` evidence rows**.  These counts were measured from the
working tree on 2026-09-04 and must be regenerated after each recovery round.

## Strict per-directory snapshot through P857

These reports measure the current source tree; they are evidence of remaining
work, not completion certificates.  `Explicit source-only codegen carriers`
counts unique function/name mappings, whereas the 1,523 figure above counts raw
marker rows (a few names have more than one scoped marker row).

| Directory | SYM functions | Mapped | Declaration-clean | Missing names | Extra names | Type/storage findings | Source-only carriers | Mapping review |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `recon/game/common` | 1,258 | 1,258 | 1,228 | 0 | 6 | 28 / 28 | 532 | 0 |
| `recon/frontend/common` | 838 | 833 | 781 | 0 | 46 | 9 / 9 | 519 | 3 |
| `recon/frontend/psx` | 85 | 85 | 85 | 0 | 0 | 0 / 0 | 54 | 0 |
| `recon/game/psx` | 395 | 395 | 392 | 0 | 3 | 0 / 0 | 395 | 0 |
| `recon/eaclib/psx` | 5 | 5 | 5 | 0 | 0 | 0 / 0 | 5 | 0 |
| `recon/lib` | 0 | 0 | 0 | 0 | 0 | 0 / 0 | 0 | 0 |
| `recon/syslib/psx` | 0 | 0 | 0 | 0 | 0 | 0 / 0 | 0 | 0 |

The authoritative report files are
`game_common_strict_p857_20260904.md`,
`frontend_common_strict_p783_20260903.md`,
`frontend_psx_strict_p780_20260903.md`,
`game_psx_strict_p838_20260904.md`,
`eaclib_psx_strict_p779_20260903.md`,
`lib_strict_p779_20260903.md`, and
`syslib_psx_strict_p779_20260903.md` in this directory.

P780 also closed a source-scanning defect: two literal NUL bytes embedded in
`psxfront.cpp` character constants caused Universal Ctags to stop after
`CleanupSpinningCars`.  Re-spelling them as the source token `'\\0'` preserved
the 25/25 byte-exact TU and zero branch-distance divergence while improving the
frontend/PSX audit from 65/85 mapped with 20 false mapping-review items and
three false missing names to 85/85 mapped, zero review items, and zero missing
names.

### Frontend/common ownership and overload progress at P783

Retail places `_._31tDialogMessageStringWithTimeout` at
`FEDIALOG.H:215` but emits its STAT copy from `FEApp.obj`.  The misplaced
free ABI carrier was removed from `fedialog.cpp`; `feapp.cpp` now materializes
the real C++ destructor from the FEApp owner surface.  The destructor remains
**PASS 8/8**, and both affected translation units remain fully byte-exact
(`feapp.cpp` 16/16, `fedialog.cpp` 32/32).  The strict audit now maps this
record, although its remaining STAT-vs-EXT finding documents the manual-vtable
reconstruction gap rather than hiding it.

Three formerly ambiguous header-inline `Draw` records are now selected by
their exact GCC-v2 mangled parameter encodings (`b` versus `iib`).  This is an
audit disambiguation only: it does not exempt parameters, locals, types, or
storage.  Frontend/common therefore improved from **829/838 mapped with seven
mapping-review items** to **833/838 mapped with three mapping-review items**.

The three remaining mapping-review records are known byte-exact top-level
assembly destructor islands, not missing retail symbols:

| SYM function | Current carrier | Exact-source closure condition |
|---|---|---|
| `_._25tScreenPinkSlipsCarSelect` | `screencarselect.cpp` top-level `___25tScreenPinkSlipsCarSelect` | Restore compiler-generated implicit-`this` destructor emission while keeping the implicit `tAllScreens` destructor PASS. |
| `_._25tScreenCarSelectTwoPlayer` | `screencarselect.cpp` top-level `___25tScreenCarSelectTwoPlayer` | Same: generate the standalone vtable target from the real member destructor without losing the required inline teardown at aggregate call sites. |
| `_._23tScreenControllerConfig` | `screencontroller.cpp` top-level `___23tScreenControllerConfig` | Restore the real member destructor/vtable relationship while preserving `tAllScreens` inline teardown. |

An ordinary C wrapper for `___23tScreenControllerConfig` was tested and was
byte-exact (17/17), but rejected and reverted because it necessarily introduced
an invented explicit receiver identifier where the original C++ source had
implicit `this`.  These three records remain visibly unresolved.

P783 regression gates: `audit_vtable_indexing.py` passed across 1,017 files;
`relink.py --lane recon` remained GREEN across 757 objects with zero real
duplicates, zero hidden phantoms, and zero relocation-referenced unresolved
symbols.  `brdist.py` found zero branch-distance/count divergence in all 16
FEApp and 32 FEDialog functions.

### Game/common header-copy progress at P785

Five repeated GCC-v2 header-inline copies are now mapped by the conjunction of
their exact SYM name, exact retail VA suffix, and owning object.  This closes
the game/common mapping-review queue without relaxing any declaration check:

- `TestForRelease__12AIState_Base` at `0x8005F678`, `0x800613C4`, and
  `0x80072830`;
- `Execute__17AIState_NonActive` at `0x80061370` and `0x80072750`.

The explicit, unused `pThis` spelling was removed from all five ABI copies;
their receiver parameters are now unnamed because the original C++ source had
implicit `this`, and retail SYM retains no explicit source identifier to spell.
Every copy remains **PASS 2/2**.  The affected TUs remain fully byte-exact
(`aih_btccop.cpp` 40/40, `aih_btcperp.cpp` 26/26, `aistate.cpp` 52/52), with
zero branch-distance/count divergence.  Game/common now maps **1,258/1,258
functions with zero mapping-review items**.  Its type/storage counts rose from
23/23 to 28/28 because the five newly mapped copies expose their real
STAT-vs-EXT manual-vtable linkage debt; those findings remain open.

The project-wide vtable audit still passes across 1,017 files, and relink stays
GREEN across 757 objects with zero real duplicates, zero hidden phantoms, and
zero relocation-referenced unresolved symbols.

### Exact compact static-local recovery at P786

Compact opcode-6 SYM records retain old GCC's internal linkage spelling for
function-local statics as `sourceName.<numeric discriminator>`.  The numeric
suffix is compiler-generated and is not part of the C/C++ identifier.  The
strict audit now accepts such a local only when all three facts agree: Ctags
identifies function-local `static` storage, the declaration carries the exact
retail VA, and exactly one compact record at that VA has the same base spelling
plus a decimal suffix.  This is an exact name-and-address mapping; it is not a
semantic-name exemption.

Four game/common declarations meet that proof, including the newly closed
review items `Copspeak_gTimeString` from `Copspeak_gTimeString.308` at
`0x8013E0B0` and `tick32` from `tick32.32` at `0x8013DDB4`.  The two existing
`strspc` declarations in `Track_MakeTrackPathName` and
`Track_MakeTrackDataPathName` also satisfy the same rule.  Game/common improves
from **1,206 to 1,208 declaration-clean functions** and from **42 to 40 extra
source-local names**.  `CopSpeak_Debug` remains PASS 8/8 and
`DashHUD_HUDCalc` remains PASS 176/176; their TUs remain 27/27 and 6/6 PASS,
respectively, with zero branch-distance/count divergence.

### Exact symbol-bearing cross-build recovery at P787

Ten optimized-away NFS4 locals now carry a machine-checkable
`ORIGINAL-NAME-RECOVERED: <name>` receipt.  Each adjacent receipt identifies
the corresponding NFS2 function, and NFS2's own debug-local record—not merely
its reconstructed C text—retains the exact spelling.  The scratch audit admits
only marked names that Ctags independently finds as real declarations; ordinary
semantic carrier comments remain unresolved.

The recovered names are `perpDistance`, `bend`, `bankNum`, two instances of
`sliceChanged`, `vertices`, `rpmAtMaxSpeedInHighestGear`, `vy`, `vz`, and
`u_pointer`.  They cover nine functions in `AIWORLD.cpp`, `audiocmn.cpp`,
`bworldSm.cpp`, `physics.cpp`, and `replay.cpp`.  Game/common improves from
**1,208 to 1,217 declaration-clean functions** and from **40 to 30 extra
source-local names**.  The five affected TUs remain **22/22, 48/48, 28/28,
22/22, and 16/16 PASS**, respectively, with zero branch-distance/count
divergence throughout.

### Dead synthetic-declaration removal at P788/P789

Two byte-exact bodies contained declarations with no SYM/SLD ownership and no
retail use.  `tPMenuItem::IsDisabled` carried five unrelated dead names
(`ret`, `item`, `orgdata`, `col`, `i`) around a single return expression;
removing them preserves PASS 3/3 and the complete `pausemenu.cpp` TU remains
60/60 PASS.  `AIDataRecord_AccTable_t::~AIDataRecord_AccTable_t` similarly
carried dead `recordLoop` and `curveLoop` declarations in an otherwise empty
compiler-synthesized destructor; removing them preserves PASS 8/8 and the
complete `aidatarecord.cpp` TU remains 26/26 PASS.  Both TUs have zero
branch-distance/count divergence.

These source corrections improve game/common from **1,217 to 1,219
declaration-clean functions** and from **30 to 23 extra source-local names**.
`NFS3_CheckForFileOperations::g` and all nine unproven
`AIHigh_Opponent::CheckForWipeOut` carrier spellings were explicitly marked
unresolved rather than being replaced by invented semantic names.

### Real member-destructor restoration at P790/P791

Eight AI hierarchy destructor bodies formerly existed as top-level C-linkage
wrappers with an invented `thisp` receiver.  They are now ordinary C++ member
destructors with implicit `this`: `AIHigh_Traffic`, `AIHigh_Cop`,
`AIHigh_BTC_Cop`, `AIHigh_Opponent`, `AIHigh_BasicCop`,
`AIHigh_BasicPerp`, `AIHigh_Player`, and `AIHigh_BTC_Perp`.  All eight retain
their exact 8- or 10-instruction retail bodies; all owning TUs remain fully
PASS with zero branch-distance/count divergence.

The same conversion removed the invented receiver and in-charge parameters
from `AIState_RovingTraffic` and `AIState_Idle`.  `AIState_Idle` also no longer
needs its `pCVar1` cached-car placeholder and remains PASS 22/22.
At that point `AIState_RovingTraffic` remained PASS 29/29 with two cached
quantities; P813 below supersedes that interim conclusion by recovering the
chained-assignment and compound-assignment source shapes.

Finally, direct virtual-call expressions eliminated `pa_Var1` and `pOVar2`
from both object-animation destructors without a byte change.  Their remaining
cached `deleteMe` pointer is explicitly unresolved: removing it through either
repeated member accesses or C++ `delete[]`/`delete` measures 44/45 with 33
oracle diffs in the Sign variant.  Both retained object destructors remain
PASS 45/45 and `object.cpp` remains 37/37 PASS.

Together these changes reduce game/common's explicit deleting-destructor ABI
carriers from **29 to 19**, improve declaration-clean functions from **1,219
to 1,225**, and reduce extra source-local names from **23 to 10**.  The current
report for that round is `game_common_strict_p791_20260903.md`.

### Further member-destructor and placeholder cleanup at P792/P793

Seven additional deleting-destructor wrappers were restored as real C++ member
destructors with implicit `this`: `AIState_NonActive` in `aih_btccop.cpp`, plus
`AIState_Chase`, `AIState_Offroad`, `AIState_Purgatory`, `AIState_Donuts`,
`AIState_GotoSlice`, and `AIState_Cruise` in `aistate.cpp`.  Their exact retail
bodies remain PASS at 19, 34, 29, 72, 25, 13, and 13 instructions,
respectively; both owning TUs remain fully PASS with zero branch-distance/count
divergence.  This reduces the explicit deleting-destructor ABI carrier count
from **19 to 12**.

`AIState_None` was also tested as a member destructor but rejected and fully
reverted: the available class graph makes GCC delegate to the base destructor,
emitting 10 rather than retail's 13 instructions and five authoritative diffs.
It therefore remains a visible ABI-carrier restoration item rather than being
declared solved without evidence.

In `NFS3_CheckForFileOperations`, direct spelling of
`gFileMgr.handlearray` lets GCC CSE the guard value and eliminates the former
unproved `g` local while preserving PASS 21/21.  The distinct loop bound is
still codegen-relevant, so its placeholder `e` is now explicitly marked
`ORIGINAL-NAME-UNRESOLVED` rather than hidden behind a carrier exemption.
Consequently the strict audit still reports a truthful **10 extra names**, while
the game/common source-only carrier count falls from **656 to 655**.

The game/common report for that round is
`game_common_strict_p793_20260903.md`: 1,258/1,258 functions mapped, 1,225
declaration-clean, zero missing names, 10 extra names, 12 deleting-destructor
ABI carriers, 655 source-only carriers, and zero mapping-review items.

### Canonical loop/macro restoration at P794

Two NFS2 symbol-bearing source shapes removed three more unproved source
objects without changing retail output.  `Cars_Restart` now uses its canonical
two `for` loops.  GCC naturally strength-reduces the second loop's
`Cars_gList[i]` expression into retail's `$s1` pointer walk, eliminating the
invented `carCursor`; direct use of `Cars_gNumCars` likewise eliminates the
unrecorded `numCars`.  The block-local `carObj` spelling is accepted because
NFS2 debug data records that exact name and type in the same function, its
matched source initializes it from `Cars_gList[i]`, and NFS4 SLD opens the
corresponding nested second-loop block at line 10.  The function remains PASS
58/58.

`Cars_CalculateRoadSpan` now uses EA's canonical
`ABS(a) (((a) > 0) ? (a) : -(a))` macro shape recovered from the symbol-bearing
NFS2 tree.  That ternary itself creates retail's fresh result pseudo, so the
invented `absSpan` declaration is no longer required.  The function remains
PASS 146/146, and the complete `cars.cpp` translation unit remains 33/33 PASS.

The game/common report for that round is
`game_common_strict_p794_20260903.md`: 1,258/1,258 functions mapped, 1,225
declaration-clean, zero missing names, 10 extra names, 12 deleting-destructor
ABI carriers, 652 source-only carriers, 11 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Local-free thunder update restoration at P795

Retail SYM and SLD record no source locals in `AudioCmn_UpdateThunder`.
Replacing the decompiler-style `uVar1` and `iVar2` carriers with direct
per-branch compound assignments lets GCC perform the same common-tail store
and random-mask scheduling as retail.  The reconstructed function remains
PASS 43/43 with no invented local names; `audiocmn.cpp` remains 48/48 PASS and
has zero branch-distance/count divergence.  A tempting local-free rewrite of
`AudioTrk_StartUp` did not match and was fully reverted, so its conspicuous
unresolved `neg1` placeholder remains open rather than receiving a guessed
name.

The game/common report for that round is
`game_common_strict_p795_20260903.md`: 1,258/1,258 functions mapped, 1,225
declaration-clean, zero missing names, 10 extra names, 12 deleting-destructor
ABI carriers, 650 source-only carriers, 11 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### SLD-exact `BworldSm_UpdateSimQuad` restoration at P796

The function now follows its retained debug structure exactly: one
function-scope `simIndex` in `$a2`, plus the nested line-6 `startsimquad`.
The decompiler-only `iVar3` delta was removed.  Grouping the final address as
`startsimquad + (simquadIndex + simIndex)` supplies retail's expression tree
and register allocation without another source object.  The function remains
PASS 34/34; `bworldSm.cpp` remains 28/28 PASS with zero branch-distance/count
divergence.

The game/common report for that round is
`game_common_strict_p796_20260903.md`: 1,258/1,258 functions mapped, 1,225
declaration-clean, zero missing names, 10 extra names, 12 deleting-destructor
ABI carriers, 649 source-only carriers, 11 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### SLD-exact `AIWorld_CalculateDeltaRoadYaw` restoration at P797

Retail SYM/SLD records only function-scope `delta` and the nested line-5
`yaw0`.  The decompiler-only `iVar2`, `nextSlice`, `gnLess1`, and `numSlices`
carriers were therefore removed rather than assigned invented semantic names.
The canonical EA/NFS2 `WRAP_SLICE` macro restores the complete repeated
expression tree.  Instrumented GCC allocation traces then proved that one
additional reference to the existing `carObj` parameter (p80 references 4 to
5) produces retail's `carObj=$v1` / `gNumSlices=$a1` handout; the retained
zero-instruction read-only compiler fence supplies that reference without
inventing another source object.  The function remains PASS 34/34, and
`AIWORLD.cpp` remains 22/22 PASS with zero branch-distance/count divergence.

The game/common report for that round is
`game_common_strict_p797_20260903.md`: 1,258/1,258 functions mapped, 1,225
declaration-clean, zero missing names, 10 extra names, 12 deleting-destructor
ABI carriers, 645 source-only carriers, 11 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### SYM-register-exact `AudioMus_SetEntry` restoration at P798

Retail SYM names exactly `titlechar` in `$a1`, `havefile` in `$a3`, and the
nested-block `p` in `$a2`.  The former PASS source had assigned the current
character to `titlechar` and introduced an unrecorded `$a1` index named
`iVar3`, so name-presence auditing alone had concealed a role/register
mismatch.  SLD lines 351 and 354 establish that `titlechar` is initialized
before the filename loop and that the filename load belongs to the loop
statement.  Restoring the natural `while (*p)` form lets GCC create the
unnamed `$v1` character pseudo while the three source locals retain their
recorded roles and registers.  The synthetic `iVar3` object is eliminated;
the function remains PASS 34/34, `audiomus.cpp` remains 23/23 PASS, and the
debug twin has zero branch-distance/count divergence.

The game/common report for that round is
`game_common_strict_p798_20260903.md`: 1,258/1,258 functions mapped, 1,225
declaration-clean, zero missing names, 10 extra names, 12 deleting-destructor
ABI carriers, 644 source-only carriers, 11 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### SLD-order-exact `BWorldSm_SetSlice` restoration at P799

Retail SYM records no source local in this function.  Its SLD sequence places
the `simSlice`, `simQuad`, and `simRotFlag` resets before the three change-flag
stores, followed by the direct chunk assignment and then the final status
bytes.  The prior PASS body used a different source order and an unrecorded
`uVar1` to force the desired schedule.  Restoring the retail statement order
allows the direct `BWorldSm_slices[slicePos->slice].chunkIndex` expression to
be hoisted exactly as the oracle without a source-only object.  The function
remains PASS 21/21, `bworldSm.cpp` remains 28/28 PASS, and its debug twin has
zero branch-distance/count divergence.  A neighboring attempt to eliminate
`NormalCache_Init`'s unresolved `invalid` carrier regressed to five diffs and
was fully reverted; that placeholder remains visibly open.

The game/common report for that round is
`game_common_strict_p799_20260903.md`: 1,258/1,258 functions mapped, 1,225
declaration-clean, zero missing names, 10 extra names, 12 deleting-destructor
ABI carriers, 643 source-only carriers, 11 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Symbol-bearing NFS2 `TextSys_Word*` restoration at P801

The matched NFS2 PC-beta `Textsys.c` and its debug-local records preserve the
original lookup-local spellings for the same 12-byte word-table operations:
`offset` and `phrase`, `sptr` and `s`, `xptr` and `x`, and `yptr` and `y`.
Porting those four canonical source shapes removes the invented `off` carrier
from `TextSys_Word`, `TextSys_WordFlags`, `TextSys_WordX`, and `TextSys_WordY`.
The NFS4 `offset` field is 32-bit rather than NFS2's 16-bit field, so its
pointer type is correctly restored as `int *` from the NFS4 retail `lw`.
Every function remains PASS 8/8, `textsys.cpp` remains 8/8 PASS, and all four
debug twins have zero branch-distance/count divergence.

The prior game/common report was
`game_common_strict_p801_20260903.md`: 1,258/1,258 functions mapped, 1,225
declaration-clean, zero missing names, 10 extra names, 12 deleting-destructor
ABI carriers, 639 source-only carriers, 19 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Inline `AnimScript` destructor restoration at P802

Retail has no out-of-line `AnimScript` destructor, but four independent exact
call sites prove its missing inline class definition: `delete [] inst`.  With
that destructor restored, `Anim_FreeHandle` collapses from an explicit
`deleteMe` temporary and two raw builtin calls to `delete animSlots[handle]`;
the result remains PASS 32/32 with an exact debug twin.  `Anim_Restart` likewise
loses `deleteMe`, `p`, and `pEnd` and returns to a 32-entry indexed loop.  Its
counter name `i` is retained by the symbol-bearing NFS2 `Anim_Restart`, and the
NFS4 SLD maps the loop to line 86; the restored function remains PASS 34/34.

The same inline class definition eliminates the unproved `deleteMe` local from
the compiler-emitted `ObjectSignAnim` and `ObjectMultiAnim` deleting
destructors.  Both now use `delete pThis->script` and remain PASS 45/45 with
exact debug twins.  `anim.cpp` is 18/18 PASS and `object.cpp` is 37/37 PASS.

The game/common report for that round is
`game_common_strict_p802_20260903.md`: 1,258/1,258 functions mapped, 1,227
declaration-clean, zero missing names, 8 extra names, 12 deleting-destructor
ABI carriers, 635 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Inline `SimpleMem` destructor restoration at P803

`Track_DeInit` formerly carried an unproved `deleteMe` copy of `Track_mem` to
hold the object across heap cleanup and object deletion.  Restoring the missing
inline `SimpleMem` destructor—`purgememadr(heap); freeMem = 0`—lets the call
site return to the original C++ expression `delete Track_mem`.  GCC's delete
expansion creates the required anonymous saved-register lifetime itself, so no
source local or invented name remains.  `Track_DeInit` remains PASS 53/53 with
an exact debug twin; `track.cpp` remains 29/29 PASS and `simplemem.cpp` remains
3/3 PASS.

The current authoritative game/common report is
`game_common_strict_p803_20260903.md`: 1,258/1,258 functions mapped, 1,227
declaration-clean, zero missing names, 8 extra names, 12 deleting-destructor
ABI carriers, 634 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Ordinary `AITrigger_TriggerManager` lifetime restoration at P804

`AI_TrafficStartUp` and `AI_TrafficCleanUp` still exposed GCC implementation
internals as reconstructed source: literal-size `__builtin_new(0x34c)`,
`__builtin_delete`, and a flat asm-aliased `AITrigger_Init` declaration.
Restoring the exact 0x34c-byte `AITrigger_TriggerManager` class layout in the
owning TU allows the original-source C++ forms `new AITrigger_TriggerManager`,
`delete triggerManagerTraffic`, and `triggerManagerTraffic->Init(...)`.
Both functions remain byte-exact (39/39 and 20/20), both debug twins are exact,
and the complete `aiinit.cpp` TU remains 17/17 PASS.  No source identifier was
invented or renamed in this closure.

The adjacent `AIDataRecord_t::StartUp2` and `CleanUp1` carriers were retested
after the class/destructor restoration work.  Natural member-call and `delete`
forms still produce 11 and 24 oracle diffs respectively, so `pAVar1` and
`pa_Var1` remain conspicuous unresolved placeholders and are now explicit open
items above; they were not replaced by semantic guesses.

The game/common report for that round is
`game_common_strict_p804_20260903.md`: 1,258/1,258 functions mapped, 1,227
declaration-clean, zero missing names, 8 extra names, 12 deleting-destructor
ABI carriers, 634 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Ordinary `AITrigger_TriggerManager` lifetime restoration at P805

The same exact class layout was then restored in `aicop.cpp`'s type surface.
This replaces literal-size `operator new(0x34c)`, `operator delete`, and the
flat asm-aliased `AITrigger_Init` helper with `new AITrigger_TriggerManager`,
`delete triggerManagerCops`, and `triggerManagerCops->Init(...)`.  `AICop_StartUp`,
`AICop_Restart`, and `AICop_CleanUp` remain byte-exact at 43/43, 20/20, and
24/24; all three debug twins are exact and `aicop.cpp` remains 4/4 PASS.  This
round changes no identifier spelling and introduces no inferred name.

The game/common report for that round is
`game_common_strict_p805_20260903.md`: 1,258/1,258 functions mapped, 1,227
declaration-clean, zero missing names, 8 extra names, 12 deleting-destructor
ABI carriers, 634 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Exact inline `AIPhysic_BrakeInfo` constructor restoration at P808

Retail SYM records `d` in `AIPhysic_InitCar` and then a line-47 inlined
`AIPhysic_BrakeInfo` constructor scope containing implicit `this` plus the
exact names `deceleration`, `invDeceleration`, `brakeTableLoop`, `distance`,
`brakeDistanceMeters`, and `sIndex`.  Reconstructing that inline constructor
lets the call site return to `carObj->brakeInfo = new AIPhysic_BrakeInfo(d)`.
The decompiler stand-in `this_`, raw `__builtin_new(0x84)`, and the expanded
constructor body are gone.  The result remains PASS 93/93 with an exact debug
twin, and `aiphysic.cpp` remains 42/42 PASS.

The declaration audit was extended narrowly to recognize `new Class(...)` as
an inline-constructor invocation.  It admits constructor-local receipts only
when Ctags finds the unique header-defined constructor and its actual named
parameter/local; it is not a generic missing-name exemption.  The corrected
audit maps all seven retail inline records and restores zero missing names.

The current authoritative game/common report is
`game_common_strict_p808_20260903.md`: 1,258/1,258 functions mapped, 1,227
declaration-clean, zero missing names, 8 extra names, 12 deleting-destructor
ABI carriers, 633 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Exact inline finished-animation constructors at P809

The default constructors for `ObjectFinishedMultiAnim` and
`ObjectFinishedSignAnim` are now represented as real inline class constructors
instead of raw `__builtin_new` calls followed by manual vtable stores.  At the
`ObjectFinishedSignAnim` call site, the exact ordinary expression
`new ObjectFinishedSignAnim` also eliminates the decompiler-only
`finishedSign` carrier while preserving `Object_CheckCollisionResults` at PASS
166/166 with an exact debug twin.  The complete `object.cpp` TU remains 37/37
PASS.

Directly nesting `new ObjectFinishedMultiAnim` at its call site was separately
tested and produces 14 oracle diffs.  Therefore the distinct `finishedMulti`
quantity remains marked as unresolved; it has not been given an invented
semantic replacement.  This is an unresolved original-source recovery item,
not a confirmed final name.

The current authoritative game/common report is
`game_common_strict_p809_20260903.md`: 1,258/1,258 functions mapped, 1,227
declaration-clean, zero missing names, 8 extra names, 12 deleting-destructor
ABI carriers, 632 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.  The report contains 57 exact inline
local mappings and zero mapping-review items.

### Exact `Speech::Speaker` construction at P810

Retail SYM gives `Nfs2_SystemNLibStartUp` no named local, while its nested SLD
blocks and instruction order identify an inlined default construction at the
`Speech::fgUndefined` assignment.  Restoring the real inline `Speaker` default
constructor and the ordinary expression `Speech_fgUndefined = new Speaker`
eliminates the decompiler-only `p` object entirely.  No replacement identifier
was introduced.  The constructor preserves retail's vptr-before-`fSub` store
order and the existing global spelling is directly backed by the retail
`_6Speech.fgUndefined` record.

`Nfs2_SystemNLibStartUp` remains PASS 25/25 with an exact debug/SLD twin.  All
11 functions in `nfs3.cpp` remain PASS, and direct dependent consumers of the
shared `Speaker` type compile successfully.  The current authoritative
game/common report is `game_common_strict_p810_20260903.md`: 1,258/1,258
functions mapped, 1,227 declaration-clean, zero missing names, 8 extra names,
12 deleting-destructor ABI carriers, 631 source-only carriers, 20 exact
cross-build/canonical name recoveries, and zero mapping-review items.

### Four synthetic `AnimScript` constructor objects eliminated at P811

Retail SYM names only `this` and `num` in `AnimScript::AnimScript(int)`, only
`this`, `num`, `numParts`, and `i` in `AnimScript::AnimScript(int,int)`, and
only `this`, `instanceGroup`, `type`, `boomIndex`, `numParts`, `numElems`,
`objInstance`, and `i` in the four-argument constructor.  It contains no
records for `iVar1`, `iVar2`, `iVar3`, or `ppTVar1`.

Rebuilding from the SLD statement order proved that all four decompiler-only
objects can be removed: each constructor now assigns
`baseTicks = simGlobal.gameTicks` directly, and the two-argument constructor
assigns its `new[]` result directly to `inst`.  No replacement identifiers
were introduced.  The three constructors remain PASS at 27/27, 39/39, and
51/51, each with an exact debug/SLD twin; all 18 functions in `anim.cpp`
remain PASS.

The current authoritative game/common report is
`game_common_strict_p811_20260903.md`: 1,258/1,258 functions mapped, 1,227
declaration-clean, zero missing names, 8 extra names, 12 deleting-destructor
ABI carriers, 627 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Synthetic acceleration-table result eliminated at P812

Retail SYM records only `this` and `loop` for
`AIDataRecord_AccTable_t::Setup`; it has no source record corresponding to the
decompiler-only `iVar1`.  Restoring the SLD-ordered nested
`Get`/`fixedmult`/shift/store expression eliminates that object without adding
any replacement identifier.  The function remains PASS 27/27 with an exact
debug/SLD twin, and all 26 functions in `aidatarecord.cpp` remain PASS.

The adjacent `Upgrade` carriers were re-tested independently.  Direct buffer
indexing still produces 16 oracle diffs and a literal `0xffff` still produces
25, so `pcVar1` and `round` remain conspicuous unresolved placeholders rather
than receiving guessed names.  `AudioMus_Threshold` was likewise re-tested;
removing its cached pointer still produces four diffs, so it also remains
unresolved.

The current authoritative game/common report is
`game_common_strict_p812_20260903.md`: 1,258/1,258 functions mapped, 1,227
declaration-clean, zero missing names, 8 extra names, 12 deleting-destructor
ABI carriers, 626 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Nine synthetic AI-state pointer objects eliminated at P813

Retail SLD assigns the three `targetPos` stores to one source statement and
the oracle executes them in `z`, `y`, `x` order.  Restoring the ordinary
right-associative assignment
`targetPos.x = targetPos.y = targetPos.z = 0` preserves the single car-object
load naturally and removes seven decompiler-only cached pointers without
inventing replacement names.  This applies to `AIState_Normal` construction,
the `AIState_Chase`, `AIState_Offroad`, `AIState_Donuts`, and
`AIState_RovingTraffic` destructors, `AIState_Chase::SetUp`, and
`AIState_Offroad::Execute`.

The second `AIState_RovingTraffic` destructor pointer existed only for a
`carFlags` read-modify-write.  The ordinary compound assignment
`carFlags &= 0xfffff7ff` emits the same retail sequence and eliminates that
object as well.  In `AIState_Purgatory`, SLD puts the adjacent `direction` and
`desiredDirection` stores on one statement; restoring the correctly ordered
chain `desiredDirection = direction = 1` removes its `pCVar4` placeholder and
preserves the 72-instruction retail body.  All eight affected functions remain
PASS with exact debug/SLD twins, and all 52 oracle-backed text symbols in
`aistate.cpp` remain PASS.

The current authoritative game/common report is
`game_common_strict_p813_20260903.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 619 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### SLD/NFS2-exact `Cars_CleanUp` restoration at P814

The decompiler-only `pCVar2` cache is removed.  NFS4 SLD attributes each
`Cars_gList[i]` reload to its individual condition or scheduler-call source
line, while the symbol-bearing NFS2 predecessor records only `i` and uses the
same direct list expressions plus an explicit final `if/else`.  Restoring that
complete source shape, rather than the previously tested partial direct-index
rewrite, emits the exact NFS4 retail body: 98/98 PASS, debug twin exact, and
the complete `cars.cpp` TU remains 33/33 PASS.  Evidence:
`C:\Temp\nfs2-clean\pc-beta\match\cars\Cars_CleanUp.c`, retail SYM/SLD for
`Cars_CleanUp__Fv`, and the authoritative source-only gate.

The current authoritative game/common report is
`game_common_strict_p814_20260903.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 618 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Carrier-free `Car_TireSkiddingStuff` front clamp at P815

The decompiler-only `cappedFront` local is removed.  NFS4 SYM retains
`front=$s3` but no separate clamp-result local; the symbol-bearing NFS2
predecessor likewise performs the clamp through `front`.  For the PSX source,
chaining the added `carObj->frontSkid` destination to `front` preserves GCC's
retail clamp-result pseudo without exposing another source object.  The result
is PASS 1,957/1,957 with an exact debug twin.  A direct `MIN` spelling measured
1,954/1,957 with 21 diffs, while `MAX(front,1)` for the adjacent unresolved
`splashFront` measured 1,958/1,957 with nine diffs and was reverted.  Evidence:
`C:\Temp\nfs2-clean\pc-beta\match\cars\Car_TireSkiddingStuff.c`, NFS4
SYM/SLD for `Car_TireSkiddingStuff__FP8Car_tObj`, and the source-only oracle.

The current authoritative game/common report is
`game_common_strict_p815_20260903.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 617 source-only carriers, 20 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Exact `Replay_Compress::u_pointer` recovery at P816

The NFS4 `u` marker is replaced with the exact original spelling
`u_pointer`.  The symbol-bearing NFS2 `Replay_Compress` source and its debug
local record both name that same input induction variable `u_pointer`; NFS4
loop optimization removes its local debug home but preserves the identical
walk and bound role.  This is direct source-bearing name evidence rather than
a semantic inference.  `Replay_Compress` remains PASS 49/49 with an exact
debug twin, and the complete `replay.cpp` TU remains 16/16 PASS.  Evidence:
`C:\Temp\nfs2-clean\pc-beta\match\replay\Replay_Compress.c` and
`C:\Temp\nfs2-clean\pc-beta\locals\local_038_[replay.c].txt`.

The current authoritative game/common report is
`game_common_strict_p816_20260903.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 616 source-only carriers, 21 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Exact `Physics_AttenuateVelocity::x` recovery at P817

The `x` carrier is now accepted as its original spelling.  The
symbol-bearing NFS2 PC debug record retains nested block locals `x` and `z`
under `Physics_AttenuateVelocity`'s function record at parent offset `02F5`;
the matched source assigns the same absolute-X velocity value to `x` before
the `speedXZ` approximation.  This corrects the former backlog comment, which
incorrectly said that the nested debug name was absent.  The NFS4 function
remains PASS 279/279 and the complete `physics.cpp` TU remains 22/22 PASS.
Evidence: `C:\Temp\nfs2-clean\pc-beta\match\physics\Physics_AttenuateVelocity.c`
and `C:\Temp\nfs2-clean\pc-beta\locals\local_033_[physics.c].txt`.

### SYM-exact `Collide_TestWithPlane::height` source shape at P818

The invented `relDotFull` carrier is removed.  NFS4 retail SYM assigns the
name `height` to the complete plane-distance sum, and the symbol-bearing NFS2
function independently retains the same name and expression.  The former
reconstruction instead attached `height` to a later `raiseUp / 2` helper that
NFS2 writes directly in the three fixed-point calls.  Restoring that one-to-one
shape leaves `Collide_TestWithPlane` PASS 779/779 and the complete
`collide.cpp` TU 14/14 PASS.  Evidence:
`C:\Temp\nfs2-clean\pc-beta\match\collide\Collide_TestWithPlane.c`,
`C:\Temp\nfs2-clean\pc-beta\locals\local_014_[collide.c].txt`, and NFS4's
`Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1` 8c block.

The current authoritative game/common report is
`game_common_strict_p818_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 614 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Removed `Souffle_Add::limit` source-only carrier at P819

The invented `limit` local is removed.  NFS4 retail SYM retains only `i` and
`maxc` in the full-pool search block, while the symbol-bearing NFS2 matched
source uses `i < gCISouffle` directly.  Restoring that direct global-bound
source shape produces the same 120 retail instructions: `Souffle_Add` remains
PASS 120/120 and the complete `souffle.cpp` TU remains 10/10 PASS.  Evidence:
`C:\Temp\nfs2-clean\pc-beta\match\souffle\Souffle_Add.c` and the NFS4
`Souffle_Add__FP8coorddefiT0iii` 8c block.

### Removed both `AudioCmn_SFX::forceAmp` copies at P820

Both invented `forceAmp` clamp results are removed.  The symbol-bearing NFS2
matched source assigns the expanded `MIN((tweakedForce * 127) / 0xa0000, 127)`
back to the `tweakedForce` parameter in both the impact and damage-scrape
branches.  NFS4 retail SYM likewise retains no `forceAmp` local.  Restoring
that macro/parameter source shape is byte-identical: `AudioCmn_SFX` remains
PASS 224/224 and the complete `audiocmn.cpp` TU remains 48/48 PASS.  Evidence:
`C:\Temp\nfs2-clean\pc-beta\match\audiocmn\AudioCmn_SFX.c` and the NFS4
`AudioCmn_SFX__Fi6s_typeT1iii` 8c block.

The current authoritative game/common report is
`game_common_strict_p820_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 612 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.

### Removed `Physics_RampCarControlValues::incValue` at P821

Both scoped copies of the invented `incValue` carrier and their empty lifetime
fence are removed.  NFS4 retail SYM retains only the `CHAR inc` declaration in
this block, while the symbol-bearing NFS2 matched source expresses the two
updates directly as `gasLevel += MIN(inc,diff)` and
`gasLevel -= MIN(inc,-diff)`.  Restoring that exact macro/source shape emits
the same 502 retail instructions: `Physics_RampCarControlValues` remains PASS
502/502 and the complete `physics.cpp` TU remains 22/22 PASS.  Evidence:
`C:\Temp\nfs2-clean\pc-beta\match\physics\Physics_RampCarControlValues.c`
and the NFS4 `Physics_RampCarControlValues__FP8Car_tObj` 8c block.

The current authoritative game/common report is
`game_common_strict_p821_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 611 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.  The tracked-source raw carrier
queue is 1,602 project-wide / 611 in game/common.

### Removed `Sched_ExecuteCheck::distanceTemp` at P822

The invented `distanceTemp` rounding carrier and its hand-expanded signed
shift corrections are removed.  NFS4 retail SYM retains `distanceIndex` and
no second rounding local; the symbol-bearing NFS2 matched source independently
uses two ordinary statements on that same local: `distance / 16`, followed by
`distanceIndex / 65536`.  Restoring those exact signed-division statements
emits the same 77 retail instructions: `Sched_ExecuteCheck` remains PASS 77/77
and the complete `schedule.cpp` TU remains 6/6 PASS.  Evidence:
`C:\Temp\nfs2-clean\pc-beta\match\schedule\Sched_ExecuteCheck.c` and the NFS4
`Sched_ExecuteCheck__FiiiiPiN24i` 8c block.

The current authoritative game/common report is
`game_common_strict_p822_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 610 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.  The tracked-source raw carrier
queue is 1,601 project-wide / 610 in game/common.

### Removed `AI_CalculateLaneSpeeds::forwardDistanceIntMeters` at P823

The invented `forwardDistanceIntMeters` sign-correction carrier and its
hand-expanded signed shift are removed.  NFS4 retail SYM retains
`distanceIntMeters` and no second distance local, while the symbol-bearing NFS2
matched source uses the ordinary signed-division statement
`distanceApart = distance / 0x10000 - 2`.  Restoring that source shape with the
NFS4 names emits the same 229 retail instructions: `AI_CalculateLaneSpeeds`
remains PASS 229/229 and the complete `ai.cpp` TU remains 40/40 PASS.  Evidence:
`C:\Temp\nfs2-clean\pc-beta\match\ai\AI_CalculateLaneSpeeds.c` and the NFS4
`AI_CalculateLaneSpeeds__FP8Car_tObj` 8c block.

The current authoritative game/common report is
`game_common_strict_p823_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 609 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.  A fresh `git grep` recount found
that the prior raw project-wide figures had undercounted three tracked marker
rows: HEAD at P822 contains 1,604, so the post-removal tracked-source raw queue
is 1,603 project-wide / 609 in game/common.

### Removed both `Camera_SetSplineCam::slice` copies at P824

The two invented branch-local `slice` staging objects are removed.  Retail NFS4
SYM retains only `anchor`, `numSlice`, and `direction` in this function, and the
symbol-bearing NFS2 `Camera_SetSplineCam` independently spells each wrapped
slice update as a direct conditional assignment to the destination camera row.
Restoring that source shape with NFS4's positive/negative offsets preserves the
retail branch and final-store layout exactly: `Camera_SetSplineCam` remains PASS
128/128 and the complete `camera.cpp` TU remains 38/38 PASS.  Evidence:
`C:\Temp\nfs2-clean\pc-beta\match\camera\Camera_SetSplineCam.c` and the NFS4
`Camera_SetSplineCam__Fi` 8c block.

The current authoritative game/common report is
`game_common_strict_p824_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 608 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.  The tracked-source raw carrier queue
is 1,602 project-wide / 608 in game/common.

### Removed five `Camera_gFlags` mode caches at P825

The invented `sVar1`/`mode` staging objects are removed from
`Camera_UpdateSimpleCam`, `Camera_UpdateBumperCam`, `Camera_UpdateTailCam`,
`Camera_UpdateHeliCam`, and `Camera_UpdateBlimpCam`.  Retail NFS4 SYM retains no
cached mode local in these functions.  Standard C/C++ defines `a[b]` as
`*(a + b)`, and pointer addition is commutative; consequently
`(Camera_gInfo[player].mode + Camera_gFlags)->arm` is the same direct array
lookup while making GCC evaluate the camera-info index row before materializing
the flag-table base.  That source expression reproduces the retail allocation
and scheduling without an extra source object.

All five functions remain byte-exact: `Camera_UpdateSimpleCam` PASS 57/57,
`Camera_UpdateBumperCam` PASS 118/118, `Camera_UpdateTailCam` PASS 402/402,
`Camera_UpdateHeliCam` PASS 443/443, and `Camera_UpdateBlimpCam` PASS 81/81.
The complete `camera.cpp` TU remains 38/38 PASS.

The current authoritative game/common report is
`game_common_strict_p825_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 603 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.  The tracked-source raw carrier queue
is 1,597 project-wide / 603 in game/common.

### Restored canonical pause-menu `GameSetup_tData` access at P826

The invented `MPause_GameSetupWords` integer-array alias is removed from the
pause-menu TU.  The gmesetup owner record proves that `controllerData` begins at
offset `0x60`, that its first field is `controllerConfig[2]`, and that the other
pause-menu words are the named `raceType`, `userSetting.language`,
`userSetting.audioMode`, `controllerData.shockMode`, and
`controllerData.shockImpact` fields.  Restoring those canonical aggregate
expressions removes the invented `MPause_EndPauseMenu::deviceSetup` local:
`GameSetup_gData.controllerData.controllerConfig[Device_gPausePortIndex]`
naturally emits retail's `lw 96(base)` form without a staging object.

The entire `mpause.cpp` TU remains byte-exact: constructor PASS 216/216,
destructor PASS 109/109, `MPause_MusicLogic` PASS 174/174,
`MPause_ControllerLogic` PASS 57/57, `MPause_Logic` PASS 199/199,
`MPause_Render` PASS 106/106, `MPause_InitMPause` PASS 14/14,
`MPause_StartPauseMenu` PASS 140/140, `MPause_EndPauseMenu` PASS 15/15, and
`MPause_KillMPause` PASS 16/16.

The current authoritative game/common report is
`game_common_strict_p826_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 602 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.  The tracked-source raw carrier queue
is 1,596 project-wide / 602 in game/common.

### Removed audio `GameSetupWords` aliases at P827

The invented `AudioEng_GameSetupWords` and `AudioTrk_GameSetupWords` integer
array aliases are removed.  Both TUs now declare the canonical
`GameSetup_tData GameSetup_gData` aggregate proved by the gmesetup owner record,
and the four affected expressions use its exact `commMode` member.  This reduces
the tracked project-wide raw-GameSetup alias inventory from 15 declarations / 70
uses at P826 to 13 declarations / 66 uses, without introducing source locals or
changing generated code.

The complete `audioeng.cpp` TU remains 9/9 PASS (`AudioEng_Set` 159/159,
`AudioEng_Update` 366/366, `AudioEng_LoadDef` 30/30, `AudioEng_StartUp`
376/376, `AudioEng_StartServer` 9/9, `AudioEng_StopServer` 9/9,
`AudioEng_Pause` 44/44, `AudioEng_Resume` 2/2, and `AudioEng_CleanUp` 56/56).
The complete `audiotrk.cpp` TU remains 6/6 PASS (`AudioTrk_Reset` 56/56,
`AudioTrk_StartUp` 23/23, `AudioTrk_AddCustomObject` 413/413,
`AudioTrk_SoundTrack` 358/358, `AudioTrk_PreLoad` 116/116, and
`AudioTrk_CleanUp` 38/38).

The current authoritative game/common report is
`game_common_strict_p827_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 602 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.  The tracked-source raw carrier queue
remains 1,596 project-wide / 602 in game/common.

### Removed AI-init/state `GameSetupWords` aliases at P828

The invented `AIInit_GameSetupWords` and `AIState_GameSetupWords` integer-array
aliases are removed.  `aiinit.cpp` now uses the exact `GameSetup_tData` members
`raceType`, `trafficDensity`, and `track`; `AIState_Purgatory::TestForRelease`
uses `commMode` and `trafficDensity`.  All field spellings and offsets come from
the gmesetup owner record rather than semantic inference.  The tracked raw alias
inventory falls from 13 declarations / 66 reference lines at P827 to 11
declarations / 62 reference lines.

Every function in `aiinit.cpp` remains byte-exact (17/17 PASS), including the
affected `AIInit_Reset2` at 65/65 and `AI_TrafficStartUp` at 39/39.
`AIState_Purgatory::TestForRelease` remains PASS 31/31.

The current authoritative game/common report is
`game_common_strict_p828_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 602 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.  The tracked-source raw carrier queue
remains 1,596 project-wide / 602 in game/common.

### Removed `AI_GameSetupWords` at P829

The invented `AI_GameSetupWords` integer-array alias is removed.  Its five
source sites now use the exact gmesetup owner fields `raceType`, `Time`, and
`commMode`.  The complete `ai.cpp` TU remains 40/40 PASS, including all four
affected functions: `AI_DoReactions` 144/144, `AI_CheckForPlayerActions`
144/144, `AI_HandleTrafficHonking` 65/65, and
`AI_PushFinishedCarsToSide` 103/103.  The tracked raw alias inventory falls
from 11 declarations / 62 reference lines at P828 to 10 declarations / 57
reference lines.

The current authoritative game/common report is
`game_common_strict_p829_20260904.md`: 1,258/1,258 functions mapped, 1,228
declaration-clean, zero missing names, 6 extra names, 12 deleting-destructor
ABI carriers, 602 source-only carriers, 22 exact cross-build/canonical name
recoveries, and zero mapping-review items.  The tracked-source raw carrier queue
remains 1,596 project-wide / 602 in game/common.

### Removed `CarIO_GameSetupWords` at P830

The invented `CarIO_GameSetupWords` integer-array alias is removed.  Its source
site now uses the exact gmesetup owner field `GameSetup_gData.mirrorTrack`.
Every function in `cario.cpp` remains byte-exact (11/11 PASS), including the
affected `CarIO_CreateLicense` at 229/229.  The game/PSX raw alias inventory
falls from 11 declarations / 40 reference lines at P829 to 10 declarations / 38
reference lines.

The current authoritative game/PSX report is
`game_psx_strict_p830_20260904.md`: 395/395 functions mapped, 392
declaration-clean, zero missing names, 3 extra names, 397 source-only carriers,
and zero mapping-review items.

### Removed `Sfx_GameSetupWords` at P831

The invented `Sfx_GameSetupWords` integer-array alias is removed.  Its only
source site now uses the exact gmesetup owner field `GameSetup_gData.Time`.
The affected `Sfx_AdditivePrim` remains byte-exact at 126/126 instructions.
The game/PSX raw alias inventory falls from 10 declarations / 38 reference
lines at P830 to 9 declarations / 36 reference lines.

The current authoritative game/PSX report is
`game_psx_strict_p831_20260904.md`: 395/395 functions mapped, 392
declaration-clean, zero missing names, 3 extra names, 397 source-only carriers,
and zero mapping-review items.

### Removed `TrsProj_GameSetupWords` at P832

The invented `TrsProj_GameSetupWords` integer-array alias is removed.  Its only
source site now uses the exact gmesetup owner field `GameSetup_gData.commMode`.
The affected `TrsProj_SetViewTrsProjEnviro` remains byte-exact at 21/21
instructions.  The game/PSX raw alias inventory falls from 9 declarations / 36
reference lines at P831 to 8 declarations / 34 reference lines.

The current authoritative game/PSX report is
`game_psx_strict_p832_20260904.md`: 395/395 functions mapped, 392
declaration-clean, zero missing names, 3 extra names, 397 source-only carriers,
and zero mapping-review items.

### Removed `Draw_GameSetupWords` at P833

The invented `Draw_GameSetupWords` integer-array alias is removed.  Its four
source sites now use the exact gmesetup owner field `GameSetup_gData.commMode`.
Both affected functions remain byte-exact: `AllocatePrimitivesBuffer` 79/79 and
`ClearPlatformPrimitivesBuffer` 23/23.  The game/PSX raw alias inventory falls
from 8 declarations / 34 reference lines at P832 to 7 declarations / 29
reference lines.

The current authoritative game/PSX report is
`game_psx_strict_p833_20260904.md`: 395/395 functions mapped, 392
declaration-clean, zero missing names, 3 extra names, 397 source-only carriers,
and zero mapping-review items.

### Removed `Force_GameSetupWords` at P834

The invented `Force_GameSetupWords` integer-array alias is removed.
`Force_StartUp` now uses the exact `GameSetup_gData.commMode` field, while the
existing oracle-required controller cursor is rooted at the typed global.  Both
affected functions remain byte-exact: `Force_Update` 278/278 and
`Force_StartUp` 51/51.  The game/PSX raw alias inventory falls from 7
declarations / 29 reference lines at P833 to 6 declarations / 26 reference
lines.

The current authoritative game/PSX report is
`game_psx_strict_p834_20260904.md`: 395/395 functions mapped, 392
declaration-clean, zero missing names, 3 extra names, 397 source-only carriers,
and zero mapping-review items.

### Removed `Loading_GameSetupWords` at P835

The invented `Loading_GameSetupWords` integer-array alias is removed.  Its
three accesses are now the exact canonical fields `userSetting.language`,
`track`, and `mirrorTrack`; the first is word 56 because the preceding
`controllerData` record occupies 22 words.  `Loading_DrawLoadingScreen` remains
byte-exact at 82/82 instructions.  The game/PSX raw alias inventory falls from
6 declarations / 26 reference lines at P834 to 5 declarations / 23 reference
lines.

The current authoritative game/PSX report is
`game_psx_strict_p835_20260904.md`: 395/395 functions mapped, 392
declaration-clean, zero missing names, 3 extra names, 397 source-only carriers,
and zero mapping-review items.

### Removed `TrackSpec_GameSetupWords` at P836

The invented `TrackSpec_GameSetupWords` integer-array alias is removed.  Its
five accesses now use the exact `Weather`, `Time`, and `track` fields.  All
three affected functions remain byte-exact: `TrackSpec_SetDefault` 142/142,
`TrackSpec_SetUp` 9/9, and `TrackSpec_Read` 63/63.  The game/PSX raw alias
inventory falls from 5 declarations / 23 reference lines at P835 to 4
declarations / 17 reference lines.

The current authoritative game/PSX report is
`game_psx_strict_p836_20260904.md`: 395/395 functions mapped, 392
declaration-clean, zero missing names, 3 extra names, 397 source-only carriers,
and zero mapping-review items.

### Eliminated the remaining `GameSetupWords` aliases at P837

All remaining raw integer-array views of `GameSetup_gData` are removed from
`recon/game/common` and `recon/game/psx`.  The canonical 2,600-byte
`GameSetup_tData` fields now replace the aliases in `camera`, `aiphysic`,
`newton`, `render`, `night`, `overlays`, and `weather`; the unused `hud` alias
is deleted.  The game/common inventory falls from 4 declarations / 48 reference
lines to zero, and game/PSX falls from 4 declarations / 17 reference lines to
zero.

This round also recovers two deeper aggregate shapes.  Camera's opaque
`CAMERA_SETUP_CAMERA` cast is the exact
`GameSetup_gData.carInfo[player].Camera[index]` member at `+0x478`; direct use
eliminates the non-SYM `setupBase` and `setupOffset` locals from
`Camera_NextMode`.  Overlays' raw `simGlobal` array and wrapper macros are
replaced by `simGlobal.gameTicks`.  Weather's canonical typed access makes the
non-SYM staged `cm` and `one` locals unnecessary; both are removed from
`Weather_DoWeather`, while its independently measured `gameSetup` and
`commModeNetwork` carriers remain explicit.

All eight changed translation units retain every oracle-known function:
game/common `camera` 38/38, `aiphysic` 42/42, `newton` 32/32, and `render`
23/23; game/PSX `hud` 62/62, `night` 19/19, `overlays` 5/5, and `weather`
25/25.  The authoritative reports are
`game_common_strict_p837_20260904.md` (1,258/1,258 mapped, 600 source-only
carriers) and `game_psx_strict_p837_20260904.md` (395/395 mapped, 395
source-only carriers), both with zero missing names and zero mapping-review
items.  The raw carrier-marker queue is now 1,592 project-wide / 600 in
game/common.

### Restored canonical shared-runtime fields at P838

The remaining raw word-array views in this focused runtime batch are replaced
by their exact aggregate declarations and fields.  `AI`, `AISpeeds`,
`AIState`, `AudioTrk`, `Force`, `Night`, `Weather`, and `Camera` now access the
canonical `Sim_tSimGlobalVar` object directly, including `gameTicks` and
`schedule32Hz`.  Camera additionally uses the exact `Sim_tSimSystemVar`
`pauseSim`/`quickPauseSim` fields and
`Replay_ReplayInterface.changeCamera`, eliminating its three integer-array
views.

The same round restores the canonical 12-byte `SndBnk_t` declaration and its
`bnkID`/`pdata` fields in `Audio`, `AudioEng`, and `MPause`, and the canonical
12-byte `Input_tDeviceList.startupfunc` entry used by `GameSetup_StartUp`.
These are source-shape recoveries backed by the retail SYM layouts; no semantic
names were invented.

All twelve affected translation units retain every oracle-known function:
game/common `ai` 40/40, `aispeeds` 29/29, `aistate` 52/52, `audioeng` 9/9,
`audiotrk` 6/6, `camera` 38/38, `gmesetup` 2/2, and `mpause` 10/10;
game/PSX `audio` 6/6, `force` 9/9, `night` 19/19, and `weather` 25/25.  The
authoritative reports are `game_common_strict_p838_20260904.md` (1,258/1,258
mapped, 600 source-only carriers) and `game_psx_strict_p838_20260904.md`
(395/395 mapped, 395 source-only carriers), both with zero missing names and
zero mapping-review items.  This batch removes typed alias scaffolding rather
than marker-bearing local rows, so the measured raw carrier-marker queue
remains 1,592 project-wide / 600 in game/common.

### Restored canonical aggregate ownership at P839

This round removes another broad layer of same-symbol word/byte/row overlays
and private `*CodegenView` tags.  The common owners now use the retail SYM
aggregates directly: `AI_Info`, `AIPhysicConfig`, `AITune_accelerationScale`,
`GameSetup_gData`, `simGlobal`, `Camera_gInfo`, `TrackSpec_gSpec`,
`BWorldSm_slices`, `Track_gSaveSurface`, `Device_gDeviceList`,
`DashHUD_gInfo`, and `HudPmx_gShapes`.  The exact canonical types introduced
or reused include `AI_tInfo`, `AIPhysic_Config_t`, `accelscale_t`,
`GameSetup_tData`, `Sim_tSimGlobalVar`, `Sim_tSimSystemVar`, `camera_info`,
`CTrackSpec`, `Trk_NewSlice`, `SaveSurface`, `Input_tDeviceList`,
`dashhud_info`, and `HudPmx_tShape`.  Dependent `audiocmn` and `speech`
headers were also corrected after a whole-tree compile gate exposed their
stale references to the removed AudioClc aliases.

The PSX owners likewise use canonical `DRender_tView`, `Draw_tView`, `dflip`,
`FLARE_DEF`, `tPadModuleState`, `tBTCPerpInfo`, `tReplayInterface`, and the
same shared runtime aggregates.  In particular, HUD's GameSetup/sim/camera/
dash/replay/pad/BTC views are now direct named fields, and RPause's raw
200-byte Draw-view rows, raw environment bytes, accessor macros, and empty
inline-assembly anchor are all gone.  RPause remains 3/3 PASS with ordinary
member access.

All twenty-four affected or dependency-gated translation units retain every
oracle-known function: game/common `aiinit` 17/17, `audioclc` 18/18,
`audiocmn` 48/48, `bworld` 21/21, `genericpmx` 1/1, `hudpmx` 3/3, `input`
8/8, `newton` 32/32, `object` 37/37, `pausemenu` 60/60, `render` 23/23,
`schedule` 6/6, `sim` 8/8, `speech` 102/102, and `track` 29/29; game/PSX
`device` 10/10, `drawc` 20/20, `flare` 27/27, `hrzsku` 22/22, `hud` 62/62,
`night` 19/19, `psxcontroller` 4/4, `rpause` 3/3, and `weather` 25/25.  The
combined gate is 605/605 PASS.

The authoritative reports are `game_common_strict_p839_20260904.md`
(1,258/1,258 mapped, 600 source-only carriers) and
`game_psx_strict_p839_20260904.md` (395/395 mapped, 394 source-only carriers),
both with zero missing names and zero mapping-review items.  The raw
carrier-marker queue is now 1,588 project-wide / 600 in game/common / 404 in
game/PSX.

The remaining load-bearing quantities are not presented as recovered source
names.  Among them, Flare's `trackSpec`, Track's `simPtr`, BWorld's `ts` and
fog/time staging, AudioClc's `viewpos`, PauseMenu's `packetPtr`, HUD's
`DashHUD_view` and `dh`, and PSXController's three `index` quantities retain
their measured receipts.  The attempted direct PSXController field spelling
was explicitly falsified at 239/233 instructions and 170 diffs; the PASS
233-instruction form was restored.  `dh` is marked
`ORIGINAL-NAME-UNRESOLVED`, because the retail evidence proves the distinct
pointer quantity but not its original spelling.

### Canonical foreign-type closure at P840

This round removes the remaining explicit `CodegenView`/`CodegenSlice`
foreign-type wrappers from `game/common` and `game/PSX`.  The affected owners
now spell the retail types directly: `SndBnk_t`, `Chunk`, `Trk_NewSlice`,
`Object_tIMassObjInfo`, `AITune_BTC_t`, `GameSetup_tData`,
`Sim_tSimGlobalVar`, `Sim_tSimSystemVar`, `camera_info`,
`AICop_spikeBelt_t`, `copTuning_t`, `AITrigger_TriggerManager`,
`AIState_Idle`, `AICop_RoadBlockState`, `dashhud_info`, `Draw_FlareCache`,
`Draw_tGiveShelbyMoreCache`, `CTrackSpec`, `tReplayInterface`, and
`DrawC_tEnvMap`.  `Replay`, `R3DCar`, and `DrawW` now declare their external
objects under those canonical types rather than same-symbol asm-label shims.
The last local wrapper, `DrawW_Pack8CodegenView`, is also gone: the canonical
`tQuat` assignment retains GCC's retail unaligned `movstrsi` sequence and the
entire DrawW TU remains exact.  The p839-era source contained 56 Codegen-named
struct tags, 126 identifier occurrences, and 39 type-alias macros; a current
active-source scan finds zero in all three classes.

All seventeen affected translation units retain every oracle-known function:
game/common `aih_basiccop` 9/9, `aih_basicperp` 9/9, `aih_btccop` 40/40,
`aih_btcperp` 26/26, `aih_cop` 10/10, `aih_opp` 6/6, `aih_play` 10/10,
`aihigh` 14/14, `anim` 18/18, `bworld` 21/21, `bworldSm` 28/28, `cars` 33/33,
`copspeak` 27/27, `nfs3` 11/11, `r3dcar` 27/27, and `replay` 16/16;
game/PSX `draww` remains 35/35.  The combined gate is 340/340 PASS.  The exact
CI build pair (`expected`, then `build --skip-asm`) completes with zero skipped
TUs, and objdiff report generation opens all 466 configured units.

The authoritative reports are `game_common_strict_p840_20260904.md`
(1,258/1,258 mapped, zero missing names, zero mapping-review items, 600
explicit source-only carriers) and `game_psx_strict_p840_20260904.md`
(395/395 mapped, zero missing names, zero mapping-review items, 394 explicit
source-only carriers).  Those carrier counts deliberately do not fall in this
round: this batch removes foreign type-alias scaffolding, not the still-open
marker-bearing local quantities.  No retained carrier is presented as an
original recovered spelling.

### Recovered pause-menu coordinate at P841

`PauseMenu_MenuText` no longer retains the synthetic `iVar1` result carrier.
The restored source declares `short x`, assigns the `TextSys_WordX(index)`
result to it, and passes it to `PauseMenu_MenuTextPositioned`.  This spelling
is recorded as an evidence-backed cross-build recovery, not as a direct local
from the target function: the target's optimized SYM block contains only its
three parameters and no local record.  Its SLD trace nevertheless separates
the `TextSys_WordX` work at source line 106 from the positioned call at line
109.  In the same retail `PAUSEMENU.CPP` object,
`tPMenuItemLeftRightSlider::Draw` records `AUTO SHORT x` for the identical
WordX-to-positioned-text path, and the callee names its fourth parameter
`SHORT x`.  Matched NFS2 `MenuSys_Display` independently declares `short x`
and uses the same assignment-then-call idiom.  A nested expression was
count-exact but had two scheduling diffs; the two-statement `short x` form is
exact at 25 instructions and the full TU remains 60/60 PASS.

The nearby `AIDataRecord_CurveSpeedTable_t::Upgrade` carrier was not renamed
or hidden.  Retail SYM records only `curveLoop`, and the natural compact
`fixedmult(Get(...), handlingUpgrade) / 0x10000` form emitted 34/35
instructions with 25 diffs.  GCC 2.8.1 allocation traces show why: the natural
form keeps `handlingUpgrade` in `s2` and rematerializes the signed-rounding
bias in `v0`, while retail requires the parameter in `s3` and a loop-invariant
`0xffff` in `s2`.  With no source-bearing evidence for `iVar1`, `pcVar1`, or
`round`, the exact 35-instruction baseline remains explicitly unresolved and
the TU is restored to 26/26 PASS.

The authoritative report `game_common_strict_p841_20260904.md` maps all
1,258/1,258 functions with zero missing names and zero mapping-review items.
It records 23 exact cross-build/canonical recoveries and 599 explicit
source-only carriers, one fewer than P840.  `x` is counted only through its
adjacent source-bearing evidence receipt; no generic carrier exemption was
added.

### SLD source-shape and same-object name recovery at P842

Five owning translation units retain every oracle-known function while nine
source-only carrier mappings leave the current queue.

- `CopSpeak_PlayNextRequest` retains its required unresolved `iVar3` queue-index
  carrier, but the wraparound output local is now `next`.  This is an exact
  same-object recovery: retail `COPSPEAK.CPP` records `int next` for the same
  queue-output role in `CopSpeak_DirectRequest`,
  `CopSpeak_GenericBankRequest`, and `CopSpeak_Request`.  The target remains
  PASS 71/71 and `copspeak.cpp` remains 27/27 PASS.
- `AudioTrk_Reset` no longer uses `pCVar2`, `puVar3`, or `neg1`.  A scoped
  `AudioElem *se` performs the natural 24-byte walk; `se` is the exact retail
  SYM spelling for the same `AudioElem *` role in both
  `AudioTrk_SoundTrack` and `AudioTrk_PreLoad` in the owning
  `AUDIOTRK.CPP` object.  SLD lines 78/79 require `nextDelay` before `chan`,
  which produces retail's chan-biased induction cursor.  The target remains
  PASS 56/56 and the TU remains 6/6 PASS.
- `MPause_MusicLogic` no longer materializes `bVar1` or `iVar3`.  Retail SLD's
  nested inline blocks and artificial `this` records at the menu-item test
  prove the existing `MPause_CurrentItem` accessor shape for the `1 || 2`
  decision; the later item tests and music-level call are direct expressions.
  The target remains PASS 174/174 and `mpause.cpp` remains 10/10 PASS.
- `AIHigh_Opponent::DoProvokedAttack` no longer materializes `iVar1`.  SLD
  statement order places `attackTicksLeft_ = personality->attackTime` before
  `hitCount_ = 0`; with that order, ordinary `hitCount_++` and the direct
  threshold test emit the exact 43-instruction body.  `pCVar3` remains an open
  spelling item because repeating `lastOtherObj` emits 46/43 instructions and
  15 authoritative diffs, while retail SYM retains only `this`.  The TU remains
  6/6 PASS.
- `AIPhysic_CheckForGripReduction` no longer materializes `iVar1` or `iVar4`.
  SLD and the raw CFG place the recent-collision/null-object test and recovery
  threshold in one short-circuit OR.  That source shape lets GCC emit its signed
  `/ 4` bias naturally and retain `gripFactor` in retail's register, preserving
  PASS 101/101; `aiphysic.cpp` remains 42/42 PASS.  The separate `pers` carrier
  remains explicitly unresolved.

Two PASS-only routes were deliberately rejected.  A
`switch (bool) { case false: ... default: ... }` spelling can reproduce
`AIHigh_Execute` 66/66, but SLD proves only a materialized predicate, not a
switch/default source construct, so the honest `bVar1` backlog form was
restored.  `Speech::DispatchSpeaker::Activate` likewise remains unchanged at
39/39: instrumented GCC proves that its `iVar1` carrier extends the loop-address
pseudo's lifetime enough to give the loop address `$a0` and the SYM-owned `i`
`$a1`, but neither SYM nor checked source-bearing references recover a spelling
or a natural eliminating form.

The authoritative report `game_common_strict_p842_20260904.md` maps all
1,258/1,258 functions, with zero missing names, zero mapping-review items, 25
exact cross-build/canonical recoveries, and 590 explicit source-only carrier
mappings (down from 599 at P841).  A raw current-tree census records 1,578
carrier-marker rows project-wide and 27 `ORIGINAL-NAME-RECOVERED` evidence
rows.  Detailed target/TU oracle checks remain exact throughout; no asm,
volatile, postcompile rewrite, generic audit exemption, or invented semantic
replacement was added.

### Retained after P813 source-shape retests

This subsection is a historical P813 receipt.  The P842 section above
supersedes its `AudioTrk_Reset` bullet; the other listed items remain open.

Four nearby groups remain deliberately conspicuous because no exact original
spelling or eliminating source form is yet proved:

- `AIState_Purgatory::~AIState_Purgatory`: natural
  `Cars_gSortedList[search]` indexing emits 68/72 instructions with 38 diffs;
  direct pointer arithmetic is count-exact with two scheduling diffs; split
  pointer initialization emits 71/72 with 15 diffs.  The exact
  `ppCVar3`/`sortedList` form was restored.
- `AIState_RovingTraffic::Execute`: replacing `iVar8`/`iVar9` with direct
  `field = field >> 12` statements emits 231/233 instructions with 38 diffs.
  Both unresolved placeholders were restored.
- `AudioTrk_Reset`: typed `AudioElem` indexing emits 62/56 instructions with
  38 diffs; a typed `AudioElem *` induction pointer is count-exact but differs
  in six address-immediate/store instructions because GCC biases the cursor to
  `nextDelay` rather than retail's `chan` byte.  The exact `puVar3` placeholder
  remains until source-bearing evidence recovers its spelling.
- `Paths_StartUp`: deleting `scanFrame` emits a frameless 17/19-instruction
  body with four diffs.  A direct PsyQ 4.3 CC1PLPSX `-g` probe also emits that
  frameless body and records `scan` as REG rather than the retail AUTO at -8.
  The PASS 19/19 carrier remains until the exact address-taken/source mechanism
  is recovered.

## Prior marked generic-placeholder census at P777

The table below is an immutable historical snapshot of 89
`SYM-CODEGEN-CARRIER` marker rows whose identifier had a decompiler-style
spelling at P777.  Each row was open at P777; later sections and the current
source tree supersede rows resolved after that snapshot.  Existing
inline receipts may prove that the distinct codegen quantity is required, but
they do not prove its original name.  Closure requires either eliminating the
quantity with byte-exact source or recovering its exact spelling from direct
source-bearing evidence.  The broader declaration-level P780 census below
supersedes this table as the current completeness/count authority.

| Translation unit / function | Unresolved placeholder(s) | Count |
|---|---|---:|
| `frontend/common/femenuextended.cpp` — `tMenuNFS4::TransitionIsFinished` | `ptVar1`, `iVar2`, `uVar3`, `iVar4` | 4 |
| `frontend/common/femenuextended.cpp` — `tMenuNFS4::Draw` | `iVar3`, `iVar4` | 2 |
| `frontend/common/femenuextended.cpp` — `tMenuOptions::TransitionOff` | `iVar1` | 1 |
| `frontend/common/femenuoptions.cpp` — `tMenuItemGoToMenuButtonFade::UpdateTransition` | `iVar2` | 1 |
| `frontend/common/femenuoptions.cpp` — `tMenuItemLeftRightFade::UpdateTransition` | `iVar2` | 1 |
| `frontend/common/femenuoptions.cpp` — `tInsideBoxMenu::ProcessInput` | `tVar2` | 1 |
| `frontend/common/femenuoptions.cpp` — `tMenuItemSlidingMenu::UpdateTransition` | `iVar2` | 1 |
| `frontend/common/femenuoptions.cpp` — `tMenuItemSlidingActivated::UpdatefOpenHeight` | `iVar2`, `iVar4` | 2 |
| `frontend/common/femenuoptions.cpp` — `tMenuItemSlidingActivated::UpdateTransition` | `iVar2` | 1 |
| `frontend/common/femenuoptions.cpp` — `tMenuItemLeftRightAudioSlider::UpdateTransition` | `iVar1` | 1 |
| `frontend/common/femenuoptions.cpp` — `tUserNameMenuItem::UpdateTransition` | `iVar2` | 1 |
| `frontend/common/femenuoptions.cpp` — `tMemoryCardMenuItem::Draw` | `sVar2` | 1 |
| `frontend/common/fescreen.cpp` — `tScreen::TransitionOff` | `iVar1` | 1 |
| `frontend/common/fescreen.cpp` — `tScreen::TransitionOn` | `iVar1` | 1 |
| `frontend/common/fetracks.cpp` — `tListIteratorTrack::TextValue` | `uVar1` | 1 |
| `frontend/common/front.cpp` — `Front_GetLapsForType` | `uVar1` | 1 |
| `frontend/common/screenpinkslips.cpp` — `tScreenPinkSlips::Initialize` | `iVar1` | 1 |
| `frontend/common/screentracks.cpp` — `tScreenTrackSelect::ProcessInput` | `ptVar1` | 1 |
| `game/common/aidatarecord.cpp` — `AIDataRecord_t::StartUp2` | `pAVar1` | 1 |
| `game/common/aidatarecord.cpp` — `AIDataRecord_AccTable_t::Setup` | `iVar1` | 1 |
| `game/common/aidatarecord.cpp` — `AIDataRecord_CurveSpeedTable_t::Upgrade` | `pcVar1`, `iVar1` | 2 |
| `game/common/aih_basicperp.cpp` — `AIHigh_BasicPerp::RemoveChaser` | `piVar2` | 1 |
| `game/common/aih_basicperp.cpp` — `AIHigh_BasicPerp::AddChaser` | `piVar2` | 1 |
| `game/common/aih_opp.cpp` — `AIHigh_Opponent::CheckForWipeOut` | `bVar1` | 1 |
| `game/common/aih_opp.cpp` — `AIHigh_Opponent::DoProvokedAttack` | `iVar1`, `pCVar3` | 2 |
| `game/common/aih_play.cpp` — `AIHigh_Player::SetupBlockade` | `bVar2` | 1 |
| `game/common/aih_play.cpp` — `AIHigh_Player::HandlePullOver` | `bVar1` | 1 |
| `game/common/aihigh.cpp` — `AIHigh_Execute` | `bVar1` | 1 |
| `game/common/ailife.cpp` — `AILife_IsSliceInAnyVisibleArea` | `ppCVar2` | 1 |
| `game/common/ailife.cpp` — `AILife_IsSliceCloseToAnyCopCar` | `ppCVar2` | 1 |
| `game/common/aiphysic.cpp` — `AIPhysic_ProcessCollision` | `iVar1`, `iVar4` | 2 |
| `game/common/aistate.cpp` — `AIState_Normal::AIState_Normal` | `pCVar1` | 1 |
| `game/common/aistate.cpp` — `AIState_Chase::~AIState_Chase` | `pCVar1` | 1 |
| `game/common/aistate.cpp` — `AIState_Chase::SetUp` | `pCVar2`, `iVar2` | 2 |
| `game/common/aistate.cpp` — `AIState_Chase::ApproachTargeting` | `iVar5`, `pCVar4` | 2 |
| `game/common/aistate.cpp` — `AIState_Offroad::~AIState_Offroad` | `pCVar1` | 1 |
| `game/common/aistate.cpp` — `AIState_Offroad::Execute` | `pCVar3`, `iVar4` | 2 |
| `game/common/aistate.cpp` — `AIState_Purgatory::~AIState_Purgatory` | `ppCVar3`, `pCVar4` | 2 |
| `game/common/aistate.cpp` — `AIState_RovingTraffic::Execute` | `iVar8`, `iVar9` | 2 |
| `game/common/aistate.cpp` — `AIState_Donuts::~AIState_Donuts` | `pCVar1` | 1 |
| `game/common/AIWORLD.cpp` — `AIWorld_CalculateDeltaRoadYaw` | `iVar2` | 1 |
| `game/common/anim.cpp` — `AnimScript::AnimScript` | `iVar1`, `ppTVar1`, `iVar2`, `iVar3` | 4 |
| `game/common/audiocmn.cpp` — `AudioCmn_UpdateThunder` | `uVar1`, `iVar2` | 2 |
| `game/common/audiotrk.cpp` — `AudioTrk_Reset` | `pCVar2`, `puVar3` | 2 |
| `game/common/bworldSm.cpp` — `BworldSm_UpdateSimQuad` | `iVar3` | 1 |
| `game/common/camera.cpp` — `Camera_UpdateSimpleCam` | `sVar1` | 1 |
| `game/common/camera.cpp` — `Camera_UpdateAnimCam` | `cVar1`, `cVar4` | 2 |
| `game/common/cars.cpp` — `Cars_CleanUp` | `pCVar2` | 1 |
| `game/common/copspeak.cpp` — `CopSpeak_PlayNextRequest` | `iVar3` | 1 |
| `game/common/mpause.cpp` — `MPause_MusicLogic` | `bVar1`, `iVar3` | 2 |
| `game/common/pausemenu.cpp` — `PauseMenu_MenuText` | `iVar1` | 1 |
| `game/common/r3dcar.cpp` — `R3DCar_Restart` | `ppCVar3` | 1 |
| `game/common/r3dcar.cpp` — `R3DCar_InsertCarFacetMenu` | `bVar2`, `sVar3`, `iVar9`, `pGVar14`, `uVar20`, `ppTVar21` | 6 |
| `game/common/replay.cpp` — `Replay_ResetReplay` | `piVar2` | 1 |
| `game/common/speech.cpp` — `Speech::DispatchSpeaker::Activate` | `iVar1` | 1 |
| `game/common/speech.cpp` — `Speech::MobileSpeaker::Status` | `iVar4`, `uVar8`, `pSVar10`, `pMVar12` | 4 |
| `game/common/speech.cpp` — `Speech::MobileSpeaker::Activate` | `iVar3` | 1 |
| `game/common/speech.cpp` — `Speech::MobileSpeaker::Lose` | `iVar3` | 1 |
| `game/common/track.cpp` — `Track_Init` | `this_00` | 1 |

P777 table total: **89 unresolved generic-placeholder carrier rows**.

## Synthetic-declaration closure at P780

A broader declaration-level Universal Ctags census (comments excluded) found
**114 synthetic/decompiler-style declarations**.  Of these, **95 carry an
explicit `SYM-CODEGEN-CARRIER` marker**.  Nineteen are unmarked, but four of
those (`optVar1`/`optVar2` in `AIWorld_CalcSpeed` and
`Physics_CalcWheelLockAcc`) are directly proven exact by NFS4 retail SYM.
Therefore **110 synthetic-shaped declarations remain unresolved**: 95 marked
with `SYM-CODEGEN-CARRIER` and the following **15 now marked explicitly with
`ORIGINAL-NAME-UNRESOLVED`**.  Their current spellings are not accepted names.
No same-function symbol-bearing NFS2 record was found for the eaclib entries,
and NFS4 has only address/name records (no retained local records) for those
five eaclib functions.

| Translation unit / function | Unmarked unresolved declaration(s) | Count |
|---|---|---:|
| `eaclib/psx/eacpsxz/stream.c` — `parsechunks` | `bvar1`, `uVar5` | 2 |
| `eaclib/psx/eacpsxz/stream.c` — `readcallback` | `bvar1`, `iVar2`, `uVar3` | 3 |
| `eaclib/psx/eacpsxz/stream.c` — `restartstream` | `uVar3`, `uVar5` | 2 |
| `eaclib/psx/sndpsxz/sdmemman.c` — `iSNDpsxmalloc` | `local_block`, `local_avail` | 2 |
| `eaclib/psx/spchpsxz/spchpick.c` — `iSPCH_ChooseSentence` | `local_order`, `local_30` | 2 |

This census is intentionally separate from semantic-looking carriers: a name
such as `slot`, `result`, or `nextSlice` can still be invented and remains open
whenever it carries `SYM-CODEGEN-CARRIER`.  “Not decompiler-shaped” is not
evidence of original spelling.

### P780 verification receipt

- `psxfront.cpp`: 25/25 TU PASS; 25 functions with zero branch-distance/count
  divergence; strict audit 85/85 mapped and declaration-clean, with zero
  missing/extra names and zero mapping-review items.
- `AIWORLD.cpp` and `physics.cpp`: 22/22 TU PASS each, with zero
  branch-distance/count divergence after recording the exact `optVar` names.
- `stream.c`, `sdmemman.c`, `spchpick.c`, and `object.cpp`: 99/99 TU PASS
  combined, with zero branch-distance/count divergence after adding the
  unresolved-name receipts.
- Vtable-indexing audit: PASS across 1,017 files.
- Reconstructed-lane relink: GREEN; 0 real duplicates, 0 hidden phantoms, and
  0 relocation-referenced unresolved symbols.

## Recovered names closed through P780

- `game/common/AIWORLD.cpp` — `AIWorld_LaneIndex`: `iVar2` is restored as
  `perpDistance`.  NFS2 PC's symbol-bearing `AI_LaneIndex` records
  `laneWidth`, `inverseLaneWidth`, `perpDistance`, and `li`; its
  `perpDistance = FIXMUL(position, inverseLaneWidth)` value is the same value
  represented by the NFS4 carrier.  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\locals\local_000_[ai.c].txt` and
  `C:\Temp\nfs2-clean\pc-beta\match\ai\AI_LaneIndex.c`.
- `game/common/physics.cpp` — `Physics_GetTorque`: `iVar1` and `iVar2` were
  not source locals.  The symbol-bearing NFS2 PC function records only
  `carObj` and `index` and supplies the original statement
  `index = MAX(MIN(index, 40), 0)`.  Restoring the canonical EA macro
  definitions produces the exact NFS4 15-instruction body.  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\match\physics\Physics_GetTorque.c` and
  `C:\Temp\nfs2-clean\pc-beta\locals\local_033_[physics.c].txt`.
- `game/common/audiocmn.cpp` — `scaleFrequency`: `uVar1` was not an original
  local.  NFS2 PC's symbol-bearing function records only `scaledFreq` and uses
  the quotient directly as the first operand of EA's `MIN` macro.  Applying
  that recovered expression to all three NFS4 channel arms remains exact at
  51 instructions.  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\match\audiocmn\scaleFrequency.c` and
  `C:\Temp\nfs2-clean\pc-beta\locals\local_005_[audiocmn.c].txt`.
- `game/common/bworldSm.cpp` — `BWorldSm_FindClosestSlice`: `bVar3` is restored
  as `sliceChanged`.  The symbol-bearing NFS2 PC function records that exact
  local and assigns the same slice comparison through `sliceChanged` to both
  change fields and the return.  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\match\bworldSm\BWorldSm_FindClosestSlice.c`
  and `C:\Temp\nfs2-clean\pc-beta\locals\local_009_[bworldSm.c].txt`.
- `game/common/AIWORLD.cpp` — `AIWorld_CalcRoadBend`: `bend` is an
  evidence-backed original spelling, not an invented semantic label.  The
  symbol-bearing NFS2 PC predecessor `AIPhysic_CalcRoadBend` records the local
  set `bend`, `thisSlice`, and `nextSlice`, and its matching source assigns the
  same first fixed-point road-bend product through `bend`.  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\match\aiphysic\AIPhysic_CalcRoadBend.c`
  and `C:\Temp\nfs2-clean\pc-beta\locals\local_001_[aiphysic.c].txt`.
- `game/common/physics.cpp` — `Physics_CalculateDerivedCarSpecs`:
  `rpmAtMaxSpeedInHighestGear` is the exact spelling retained by the
  symbol-bearing NFS2 predecessor and is used for the same fixed-point
  max-speed RPM intermediate.  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\match\physics\Physics_CalculateDerivedCarSpecs.c`
  and `C:\Temp\nfs2-clean\pc-beta\locals\local_033_[physics.c].txt`.
- `game/common/physics.cpp` — `Physics_AttenuateVelocity`: `vy` and `vz` are
  exact spellings in the same NFS2 function's matching source and debug-local
  record.  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\match\physics\Physics_AttenuateVelocity.c`
  and `C:\Temp\nfs2-clean\pc-beta\locals\local_033_[physics.c].txt`.
- `game/common/bworldSm.cpp` — `GetStmQuadPts`: `vertices` is the exact name
  of the cached geometry-vertex base in the symbol-bearing NFS2 predecessor.
  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\match\bworldSm\GetStmQuadPts.c` and
  `C:\Temp\nfs2-clean\pc-beta\locals\local_009_[bworldSm.c].txt`.
- `game/common/bworldSm.cpp` — `FindClosestQuad`: `sliceChanged` is the exact
  name of the comparison local in NFS2's matching source and nested debug
  blocks.  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\match\bworldSm\FindClosestQuad.c` and
  `C:\Temp\nfs2-clean\pc-beta\locals\local_009_[bworldSm.c].txt`.
- `game/common/audiocmn.cpp` — `AudioCmn_PlaySFX`: `bankNum` is the exact name
  of the byte bank-table index in NFS2's matching source and debug-local
  record.  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\match\audiocmn\AudioCmn_PlaySFX.c` and
  `C:\Temp\nfs2-clean\pc-beta\locals\local_005_[audiocmn.c].txt`.
- `game/common/replay.cpp` — `Replay_Decompress`: `u_pointer` is the exact
  output-index name in the symbol-bearing NFS2 function's matching source and
  debug-local record.  The later NFS4 compiler eliminates its debug home but
  preserves the same induction role.  Closure evidence:
  `C:\Temp\nfs2-clean\pc-beta\match\replay\Replay_Decompress.c` and
  `C:\Temp\nfs2-clean\pc-beta\locals\local_038_[replay.c].txt`.
- `game/common/physics.cpp` — `Physics_CalcWheelLockAcc`: NFS4 retail SYM
  directly records `optVar1` and `optVar2` as the exact names of the absolute
  X/Z intermediates.  The same NFS2 function's matched source and debug-local
  record independently preserve those spellings.  Their decompiler-like form
  is original evidence, not a reason to rename them.  Closure evidence:
  `C:\Temp\nfs4-clean\nfs4-f-v3.txt` at the function's 8c record, plus
  `C:\Temp\nfs2-clean\pc-beta\match\physics\Physics_CalcWheelLockAcc.c` and
  `C:\Temp\nfs2-clean\pc-beta\locals\local_033_[physics.c].txt`.
- `game/common/AIWORLD.cpp` — `AIWorld_CalcSpeed`: NFS4 retail SYM directly
  records `optVar1` and `optVar2` as the function's two INT locals.  Their
  synthetic-looking spelling is authoritative and must not be normalized.
  Closure evidence: `C:\Temp\nfs4-clean\nfs4-f-v3.txt`, function record
  `AIWorld_CalcSpeed__FP8Car_tObj` at `0x800738D4`.

## P858 source-shape closure (2026-09-05)

This round removes five `SYM-CODEGEN-CARRIER` declarations without adding
replacement names.  The strict `game/common` census falls from 532 to 527
source-only carriers while all three affected retail functions remain exact.

- `game/common/aispeeds.cpp` —
  `AISpeeds_CalcHumanCurveSpeed`: removed `off`.  The five repeated offset and
  wrap blocks are invocations of EA's `WRAP_SLICE(a,b)` macro.  This exact
  expansion survives in the NFS4 `ai.cpp`, `cars.cpp`, and `AIWORLD.cpp`
  translation units; matched NFS2 AI source retains the same macro family.
  Retail SYM records
  only `sliceHere`, `sliceAhead`, `curveAhead`, and `tightestCurve`; its SLD
  statement boundaries agree with one macro invocation per look-ahead.
  Source-only `verify_asm` is PASS at 183 instructions, `diffsrc` is zero with
  an exact `-g` twin, strict branches are clean, and the whole TU is 29/29
  PASS.
- `game/common/aidatarecord.cpp` —
  `AIDataRecord_CurveSpeedTable_t::Upgrade`: removed `round`, `pcVar1`, and
  `iVar1`.  Retail SYM records only `curveLoop`.  The NFS4 mobile descendant
  `sub_5115A8` independently preserves the direct
  `fixedmult(Get(...), handlingUpgrade) / 0x10000` byte-store expression.
  The infinite loop with its mid-loop exit is the natural GCC source shape
  that preserves retail's single top test; bounded-loop spellings rotate and
  add an instruction.  Source-only `verify_asm` is PASS at 35 instructions,
  `diffsrc` is zero with an exact `-g` twin, strict branches are clean, and the
  whole TU is 26/26 PASS.
- `game/common/aitriger.cpp` — `AITrigger_TriggerManager::Init`: removed
  `deletedCheckTime`.  The NFS4 mobile descendant and NFS3 predecessor both
  retain direct forward loops with the literal `-0xa00`; retail SYM records
  only `numTriggers`, `currentTrigger`, and `tLoop`.  Retail SLD separately
  attributes the two loop initializations/stores.  Source-only `verify_asm` is
  PASS at 55 instructions, `diffsrc` is zero with an exact `-g` twin, strict
  branches are clean, and the whole TU is 10/10 PASS.

Three neighboring carriers remain deliberately open.  Direct and canonical
clamp spellings for `AISpeeds_BTCGetGlueFactor::clampedGlueIndex`, direct
surface reads for `BWorldSm_TunnelFlagSm::surfVal`, and ordinary boolean
spellings for `AIHigh_Traffic::HighExecute::release` do not reproduce retail
allocation.  A carrier-free `switch` spelling can shape the last function
exactly, but has no source-lineage evidence and contradicts the SLD topology,
so it was rejected rather than accepted as invented source.  The traffic SYM
trace instead suggests an as-yet-unrecovered inline accessor around
`forcePurgatory_`.

## P859 source-shape closure (2026-09-05)

This round removes **21 source-only declarations** and recovers one exact
cross-build name without adding asm or volatile.  The strict `game/common`
census moves from 527 to **507** marked source-only carriers and from 32 to
**33** canonical name recoveries.  All 1,258 SYM functions remain mapped,
with zero missing names or mapping-review items; 547/547 object-owned globals
and 115/115 special vtable records remain mapped.  The six extra source locals
left by the strict report are explicitly retained review items, not accepted
original names.

- `game/common/aiperson.cpp` — `AIPerson_LoadScriptData`: removed
  `byteOffset`, `actionMul`, `byteOff2`, and `scriptBase`.  Retail SYM records
  exactly `perLoop`, `actionLoop`, and `reactionLoop`.  The recovered source is
  now a natural triple nested `for`, with direct
  `AIPerson_ScriptData[perLoop][actionLoop]` member indexing and no synthetic
  source label.  Its generated debug stream matches the retail block-start
  VAs (`EA4` twice, `EE8`, `EF4` twice, `F00`), block-end VAs (`F3C` twice,
  `F44` twice, `F50` twice), local ordering, and registers (`perLoop=$s7`,
  `actionLoop=$s2`, `reactionLoop=$s1`).  It is PASS 55/55, `diffsrc` zero
  with an exact `-g` twin, 3/3 branches clean, and the TU is 8/8 PASS.
- `game/common/audiotrk.cpp` — `AudioTrk_AddCustomObject`: removed
  `fadevol`, both full-width `level` declarations, and `dopClamped`.  Retail
  SYM retains only `rangesq` in the near branch and
  `range`/`rangesq`/`ambdist` in the fade branch.  The 127 scale uses the
  source-backed shift/subtract idiom `((fade << 7) - fade)` found in matched
  Rage Racer code; signed division and the duplicated clamp expression retain
  retail code without extra names.  It is PASS 413/413, `diffsrc` zero with an
  exact `-g` twin, and 57/57 branches clean; `AudioTrk_SoundTrack` remains PASS
  358/358 and the TU remains 6/6 PASS.
- `game/common/bworld.cpp` — `SetupChunkBuildList`: replaced the unproven
  `viewList` spelling with `chunkViewList`, the exact name used for the same
  per-chunk visibility-row walker in matched NFS2 `bworld` source, and removed
  a stale `buildList` carrier marker for which no declaration existed.  The
  function is PASS 203/203, `diffsrc` zero with an exact `-g` twin, and 18/18
  branches clean.  `BWorld_OnyxBuildFacets` removes `fogStart`, `fogDist`,
  `fogState`, and `time`; none exists in the retail function's SYM block, and
  the direct typed field/global expressions are exact.  It is PASS 193/193
  with 12/12 branches clean; the TU is 21/21 PASS.
- `game/common/cars.cpp` — `Car_TireSkiddingStuff`: removed four scoped
  `splashFront`/`splashRear` copies.  Retail SYM has no splash-result locals;
  the orientation-sensitive `front = front <= 0 ? 1 : front` and rear twin
  each occupy exactly one corresponding retail SLD statement interval.  The
  function is PASS 1957/1957, `diffsrc` zero with an exact `-g` twin, 248/248
  branches clean, and the TU is 33/33 PASS.
- `game/common/chunk.cpp` — `Chunk::InstanceGroup`: removed `renderQuad`,
  `quadCount`, `probe`, and `cur`.  The group walk now uses retail-SYM `inst`,
  the clamp uses the natural indexed `simObjs[count]` form and the recovered
  inline `GetNumElements()` calls, and the four render-quad boundaries are
  direct member chains at the retail SLD intervals.  The function is PASS
  329/329, `diffsrc` zero with an exact `-g` twin, 20/20 branches clean, and the
  TU is 4/4 PASS.
- `game/common/replay.cpp` — `Replay_ResetReplay`: removed `pBuf`.  Matched
  NFS2 source has the same unbraced ascending indexed buffer-clear `for`;
  NFS4 SLD maps its setup to the first interval and its store plus reversed
  induction update to the second.  GCC reverses that source loop into retail's
  decrementing pointer walk.  The function is PASS 86/86, `diffsrc` zero with
  an exact `-g` twin, and 8/8 branches clean.  The normal TU gate is 16/16;
  the source-only lane remains 15/16 because of the unrelated existing
  `Replay_StoringControllerData` residual.

### P859 retained source-shape debt

- `AIPerson_LoadPersonalityData::copCollisionFirmness` remains: the spelling
  is the exact destination member name, but no corresponding local survives
  in that function's SYM block and direct assignment removes three retail
  instructions.  `AudioTrk_SoundTrack::curBack` likewise remains required to
  prevent reassociation; neither declaration has unique source-bearing proof.
- `BWorld_OnyxBuildFacets::ts` remains because direct
  `TrackSpec_gSpec` fields are count-exact but differ at ten words.
  `chunkIndFwd`/`chunkIndBwd` and `BWorld_Init::random` remain after their
  direct/canonical probes regressed substantially.
- `Chunk::InstanceGroup::groupData` remains because direct group access emits
  328/329 instructions with five diffs.  `quadData` awaits recovery of the
  likely original inline payload accessor.  The first-loop `simObjs` spelling
  is semantically sound but optimizes away and is not independently named in
  that lexical SYM scope.  Removing the inherited volatile guard read was
  tested and rejected at 328/329 with three diffs; no new volatile was added.
- `Replay_ResetReplay::piVar2` remains: direct counter indexing emits 87/86
  instructions with an extra address increment.  Its first buffer loop is now
  SLD-aligned, but the later camera/counter loops and epilogue still carry
  source-line grouping debt.
- The five non-SYM values in `AIHigh_Opponent::CheckForWipeOut` remain after
  six direct-expression/source-order probes (best: three diffs at 121/120).
  `NFS3_CheckForFileOperations::e` also remains after direct-bound and natural
  one-local `for` forms regressed to 11 and 10 diffs respectively.  Both files
  were restored byte-for-byte and retain their PASS functions/TUs.

## P860 source-shape closure (2026-09-05)

This round removes **eight source-only declarations** without inventing
replacement names.  The strict `game/common` census moves from 507 to **499**
marked source-only carriers.  All 1,258 SYM functions remain mapped; 1,228 are
declaration-clean, with zero missing SYM names and zero mapping-review items.
All 547 object-owned globals and all 115 special vtable records remain mapped.
The six extra source locals remain explicit review items.

- `game/common/aiphysic.cpp` — `AIPhysic_HandleWipeoutTimer`: removed
  `info` and uses the typed `carObj->personality` member directly for the two
  retail fields.  Retail SYM records no locals; the still-marked `limit` is a
  measured source-only carrier.  The direct member spelling remains PASS at
  37 instructions.  `AIPhysic_CheckForGripReduction` removes
  `pers`, restores the SLD-supported random-update statements before the
  probability calculation, and reads both personality members directly.
  Retail SYM records only `perTickProb` and `randVal`; `randtemp` is a global,
  and there is no shared personality-pointer local.  It remains PASS at 101
  instructions.  The whole TU is 42/42 PASS with zero
  branch-distance/count divergence.
- `game/common/audiocmn.cpp` — `AudioCmn_Init`: removed `backwards` by
  reusing retail-SYM local `j` for `reverseTrack` before its later loop-index
  definition.  `AudioCmn_TrafficSFX` removes `patch` and reuses retail-SYM
  local `player` for the first engine-patch result.  Both statement orders are
  supported by the retail SLD stream; the functions remain PASS at 94 and 163
  instructions respectively.  `AudioCmn_PlayFESFXVol` removes `volScaled` and
  expresses 120 as `((vol * 0xf) << 3)`, preserving the retail multiplication
  tree without a local absent from SYM.  That expression is a compiler-tree
  inference rather than a textual lineage quote.  Removing its redundant
  final return also makes the normalized source debug-transition boundaries
  exactly equal to retail.  `UpdateSiren` removes `bend` by reusing the sole
  retail-SYM local `iFreq` for its upper clamp; its normalized transition
  boundaries are likewise exact.  The latter functions remain PASS at 34 and
  129 instructions.  The whole TU is 48/48 PASS with zero branch divergence.
- `game/common/audioeng.cpp` — `AudioEng_Update`: removed `targetVolume` and
  uses `g->vol[n]` directly in both left- and right-voice ramps.  Retail SYM
  has no target-volume local, and its SLD/assembly repeatedly loads that field
  through the clamp arms.  The function remains PASS at 366 instructions; the
  whole TU is 9/9 PASS with zero branch divergence.
- `game/common/bworldSm.cpp` — `BWorldSm_TunnelFlagSm`: removed `surfVal` and
  restores the surface selection as one conditional expression assigned to
  retail-SYM local `surf`.  The `% 16` spelling is an oracle/codegen inference,
  not a recovered textual source quote; it preserves the retail instruction
  stream and SLD statement interval exactly.  The function remains PASS at 22
  instructions; the whole TU is 28/28 PASS with zero branch divergence.

### P860 retained source-shape debt

- `AIPhysic_HandleWipeoutTimer::limit`,
  `AISpeeds_BTCGetGlueFactor::clampedGlueIndex`, and the tested
  `AIPhysic_CheckForGripReduction` neighboring shapes remain open.  Direct
  repetitions/removals produced measured 3-, 4-, 9-, or 12/13-diff
  regressions, so none was accepted as original source.
- `AudioCmn_Init::setup`, `AudioCmn_TrafficSFX::fade`, and
  `AudioEng_Update::rampedVolume` remain marked carriers.  Direct forms alter
  allocation or scheduling; the best tested replacements produced 17 to 51
  authoritative diffs.  `AudioEng_CleanUp::player` and both
  `AudioEng_StartUp::chanbase` instances remain pending recovery of the
  natural pointer-walk/GIV source shape documented by SYM, SLD, IDA, and the
  PC predecessor.
- The four changed TUs total 127/127 PASS in source-only whole-TU gates, and
  every one of their 127 functions has matching branch offsets/counts.  No
  asm, volatile qualifier, postcompile rewrite, or tool modification was added
  by this round.

## P861 source-shape closure (2026-09-06)

This round removes **four audited per-function carrier names across five
declarations** without introducing replacement names.  The two scoped replay
`counter` declarations count as one name in the census.  The strict
`game/common` audit moves from 499 to **495** source-only carriers.  Its other
headline counts remain unchanged: 1,258/1,258 functions mapped, 1,228
declaration-clean functions, zero missing SYM names or mapping-review items,
six extra source-local names, 547/547 object-owned globals, and 115/115 special
vtables.  The generated receipt is
`game_common_strict_p861_20260906.md`.

- `game/common/newton.cpp` -- `Newton_AddDamageZone`: removed `result`,
  `newYVel`, and `cappedYVel`.  The first damage-neighbor selection now reuses
  the existing retail-SYM `imp`; its old value is dead after the average is
  calculated.  Both outer `imp` and inner `temp` have retail REG 3 records.
  This is an allocation-compatible reconstruction, **not proof that the
  original source reused `imp` rather than `temp`**.  The vertical-velocity
  clamp is a constant-left conditional expression with no local declarations.
  All 15 instructions from VA `8009f290` through `8009f2c8` now map to one
  source statement, exactly the retail SLD line-149 interval.  The conditional
  spelling/macro identity is inferred, not recovered textual lineage.  An
  independent raw-executable read confirms all 51 oracle instructions across
  the two edited regions.  The function remains source-only PASS 502/502,
  `diffsrc` zero with an exact debug twin; the TU is 32/32 PASS with zero
  branch-count or branch-offset divergence.
- `game/common/replay.cpp` -- `Replay_GetInput`: removed both `counter`
  pointer declarations.  The index-first byte-offset lvalues retain pointer
  arithmetic and produce retail's address setup without an invented local.
  SYM records no locals for this function.  Nested camera guards and removal
  of the redundant final return also restore the tail's normalized SLD
  transition boundaries.  These lvalue spellings are compiler/source-shape
  inferences, not quoted original source.  The function remains source-only
  PASS 280/280, `diffsrc` zero with an exact debug twin, and has no branch
  divergence.  The source-only TU remains 15/16: the pre-existing unrelated
  `Replay_StoringControllerData` residual is still 188 diff lines with one
  branch-offset mismatch.  No previously passing function regressed.

### P861 retained source-shape debt and regression scope

- `Newton_AddDamageZone` is not fully SLD/source-exact.  Its damage clamps
  still split retail single-line statement intervals across source branches,
  and the `imp` reuse does not establish the original local lifetime.  A
  combined conditional/member assignment remained count-exact but produced
  60 authoritative diffs; the in-place maximum probe produced 51 diffs at
  501/502.  Those failed experiments were removed.
- `Replay_GetInput::hasCameras` and `steering` remain marked carriers.  Fully
  typed index-first counter expressions produced 30 verification diffs at
  280/280.  Removing `hasCameras` disturbed address scheduling (24 diffs at
  280/280 or 34 at 282/280); direct widened steering selected `lbu` instead of
  retail `lb` (two diffs).  None was retained.  Whole-function SLD recovery
  remains open despite the corrected tail.
- `pausemenu.cpp` has no retained content changes.  Slider `ProcessInput`
  still has the non-SYM `max`/`value` carriers; its only named SYM local is
  `sound`.  Direct conditional/native min-max probes produced 15 diffs at
  70/71, direct memory-update clamps 47 at 80/71, and max-only removal 12 at
  71/71.  Baseline restoration was verified: Slider PASS 71, Choice `Draw`
  PASS 118, TU 60/60, zero branch divergence, and an exact Slider debug twin.
- The source-policy audit and vtable-indexing audit pass.  The reconstruction
  link gate is green across 757 live objects: zero real duplicate definitions,
  zero hidden phantoms, and zero relocation-referenced unresolved names; its
  964 known blob-class duplicates are not new source duplicates.  This is a
  relocatable-link regression check, not a claim of complete image equality.
  No asm, volatile, postcompile rewrite, tool/header modification, or invented
  replacement identifier was added.  Unrelated user edits remain untouched.

## P862 source-shape and SLD cleanup (2026-09-06)

This round removes **eight audited per-function carrier names across ten
declarations**, with no invented replacement name. The game/common census
falls from 495 to **492**, and frontend/common from 519 to **514**. The two
generated receipts are `game_common_strict_p862_20260906.md` and
`frontend_common_strict_p862_20260906.md`. These counts measure the explicit
carrier queue, not full original-source or SLD completion.

- `frontend/common/fecredits.cpp` -- `tCreditManager::DrawCurrCredit` removes
  `frameTick`, `titleFadeBase`, `subTitleFadeBase`, `text`, and `pixelWidth`.
  The animation argument now directly uses `(ticks >> 4) % 10`; the raw oracle
  confirms the shift precedes the signed remainder, despite the split M2C's
  misleading `/160` shortcut. Text lookups feed their consumers directly,
  and the subtitle width uses one difference expression. The updated split
  M2C `func_80036084.c` independently supports the call structure. Each color
  is faded in two statements using its actual SYM-named local, `ColTextTitle`
  or `ColTextSubTitle`. An initially passing nested-call form was superseded
  because it collapsed distinct retail SLD intervals: the retained form
  restores the transitions at `80036164` (269 to 270) and `80036184` (272 to
  273) while still introducing no local. The animation statement grouping
  agrees with retail line 249, and the width expression agrees with line 318.
  The function remains source-only **PASS 451/451**, `diffsrc` zero with an
  exact debug twin. These expression spellings are reconstructions, not a
  uniquely recovered textual source.
- `tCreditManager::Draw` moves the recorded `int i` into its loop-local
  block. Generated debug metadata now places REG 6 inside the block bounded
  by the instructions at `80035ca8` and `80035cf8`, matching the retail SYM
  block range. The function stays **PASS 81/81**, with an exact debug twin.
  `mainScreen` remains an explicitly unresolved source-only cache; the loop's
  full line-attribution pattern is not yet retail-exact.
- `game/common/collide.cpp` -- `Collide_CheckMeForCollisions` removes
  `minImpulse` using a constant-left maximum expression. Its whole clamp
  interval `80091b88` through `80091b9c` now belongs to one statement, matching
  retail SLD 1604. The function remains **PASS 381/381** with an exact debug
  twin. `Collide_DoActualObjectCollisionCheck` removes the `o1` half's
  `selectedRange` declaration by checking the selected axis in each branch;
  GCC merges the common negation tail. The NFS2 source-bearing sibling
  supports this per-axis sign-test family, and the retail axis tests belong
  to SLD 999/1009/1019. The function remains **PASS 765/765**, with an exact
  debug twin. The `o0` half still uses `selectedRange`, so that audited name
  remains in the per-function census.
- `game/common/aistate.cpp` -- `AIState_Chase::FindBarrierEndSlice` removes
  both branch-local `numSlicesLess6` declarations; `AIState_Donuts::Execute`
  removes `numSlicesLess3`. Conditional expressions with an explicitly widened
  inner `(long long)(gNumSlices - N)` preserve the arithmetic tree until final
  `int` conversion. This conversion is a tested compiler-shape inference,
  not proof of the lost spelling. The barrier tail's normalized SLD
  transitions are restored at instruction indices 194/200/210, and the
  Donuts wrap transitions at 97/99/109/117 (retail 1281/1283). Both remain
  source-only **PASS 230/230** and **319/319**, with zero `diffsrc` differences
  and exact debug twins.

### P862 unresolved items, failed probes, and gates

- Credits `tag` remains unresolved. Direct literal/tag tests shortened the
  function to 444/451 with 69 diffs and were restored. Removing `mainScreen`
  produced 25 diffs at 84/81 and was restored, keeping only `i`'s corrected
  scope. The unused `Init(int arg1)` parameter's arity is linkage-proven but
  its spelling is not recovered; making it anonymous would conceal that
  name-recovery debt, so it is left marked. The existing volatile tag reads
  and start-tick snapshot are unchanged, not newly introduced or endorsed as
  original source by this round.
- Collision `n` and `o0`'s `selectedRange` remain unresolved. Postincrement
  loop and both-half per-axis probes produced 11 diffs at 131/128 and
  10/4 diffs at 773/765 or 769/765. Only the independently passing `o1`
  change was retained. Some jump-line attribution at `800900a8`/`800900d8`
  still collapses retail SLD 1003/1013 into guard lines; full SLD equality
  is not claimed.
- Reusing AIState `mySlice` produced 13 diffs at 229/230; unsigned wrap
  folding produced 21 at 227/230; reusing GotoSlice `distMeters` for
  `desiredSpeed` produced 14 at 70/70. These experiments were restored.
  They are evidence about those specific forms, not impossibility proofs.
- All three edited TUs pass their source-only whole-TU gates: credits 7/7,
  collision 14/14, AIState 52/52 (**73/73 total**). All 73 have zero branch
  count/offset divergence. Independent raw-ROM reads corroborate all oracle
  words in the six changed functions: 532 credits, 1,146 collision, and 549
  AIState words. This verifies the oracle against the executable, not a
  separately linked byte-for-byte final image.
- Strict game/common declaration coverage remains 1,258/1,258 mapped and
  1,228 declaration-clean, with zero missing names/mapping-review items and
  six extra source-local names. Its 547 globals and 115 special vtables
  remain mapped. Frontend/common remains 833/838 mapped, plus two correctly
  implicit special members and three existing assembly-destructor mapping
  reviews; 781 declaration-clean, zero missing names, and 46 extra locals.
  Its 190 object-data records comprise 171 source definitions and 19
  blob-backed records. These other queues did not shrink in P862.
- Source-policy and vtable-indexing audits pass (1,029 files for the latter).
  The 757-object reconstruction link gate is green with zero real duplicate
  definitions, hidden phantoms, or relocation-referenced unresolved names;
  964 known blob-class duplicates remain. Scoped `git diff --check` is clean.
  No new asm, volatile qualifier, postcompile rewrite, tool/header change,
  audit exemption, or fabricated identifier was introduced. Unrelated edits
  were preserved. This round and P861 remain uncommitted at this checkpoint.

## P863 frontend source expressions and statement ownership (2026-09-06)

Six more explicit source-only names/declarations are removed, without inventing
replacement names. Frontend/common's marked-carrier census is now **508**, down
from P862's 514 (`frontend_common_strict_p863_20260906.md`). Its other headline
queues are unchanged: 838 SYM functions, 833 mapped definitions, two correctly
implicit special members, three mapping reviews, 781 declaration-clean
functions, zero missing names, and 46 extra source-local names. The explicit
carrier census and extra-local review queue are separate metrics.

- `screenmain.cpp`, `tScreenMain::DrawBackground`: removed `fadeComponent`.
  The first passing direct packed expression was not the final answer: SLD
  showed that retail line 529 computes the division result and line 530
  complements it, packs the color, and writes both TV tints. The retained
  source therefore assigns `((int)fWarningFade << 6) / 0x60` to the actual SYM
  `int fade`, then uses a single chained assignment to `tvConfigs[5].tint`
  and `tvConfigs[6].tint`, with repeated unsigned `0x80 - fade` terms.
  GCC's debug definition places `fade` in REG 2, exactly as retail SYM does.
  The normalized statement partition agrees at `80037ce4..80037d0c` (529),
  the independently scheduled 537 instructions at `80037cf8/80037cfc`, and
  `80037d10..80037d2c` (530). The stores remain in retail order, slot 6 then
  slot 5. Target **PASS 822/822**, zero `diffsrc`, exact debug twin; whole TU
  **13/13 PASS**, zero branch-count/offset divergence. All 822 oracle words
  were independently checked against raw `rom/nfs4-f.exe`.
- `femenuextended.cpp`, `tMenuNFS4::TransitionIsFinished`: removed `ptVar1`,
  `iVar2`, `uVar3`, and `iVar4`. A direct indexed `for` loop and typed vtable
  entry 9 access leave only retail `short i` and `bool result`. Slot byte
  offsets remain the retail delta at `0x48` and function pointer at `0x4c`.
  The exact debug twin's partitions match retail prologue 504, result 506,
  loop test 508, call/backedge 509, and return 511. Target **PASS 40/40**;
  whole TU **57/57 PASS**, zero branch divergence; all 40 oracle words match
  the raw executable. The ordinary virtual-method/class reconstruction is
  still open: direct manual dispatch removes fabricated locals but is not
  asserted to be the lost C++ spelling or a fully restored class model.
- `fetourn.cpp`, `tListIteratorTournament::Decrement`: removed `value` using
  direct decremented stores in the zero/nonzero arms. Only the recorded
  `tTierInfo *tier` remains. GCC merges the store and supplies the retail
  branch-delay decrement. Removing the redundant final `return` additionally
  restores one statement group for the validity test through the epilogue,
  `80033f7c..80033fac`, corresponding to retail SLD 1158. Target **PASS 36/36**,
  zero `diffsrc`, exact debug twin; whole TU **35/35 PASS**, zero branch
  divergence; all 36 oracle words match raw ROM. The guard, wrap load, shared
  decrement/store and validity test correspond to 1153/1154/1156/1158, but the
  load-delay nop at `80033f70` still inherits the wrap-load source line while
  retail assigns it to 1156. Full numerical/partition SLD equality is not
  claimed for this function.

### P863 probes restored and remaining source recovery

- ScreenMain's `curMenu` remains in the extra-local review queue. Direct
  cast/widened comparison was one instruction short (821/822). Retail records
  an inlined `tFEApplication this` at the two menu tests, so recovering the
  accessor is still relevant; the broad header's descriptive `CurrentMenu`
  name is explicitly not source-proven and was not propagated. The isolated
  screenmain type has no such method. No header or helper was fabricated.
  `elapsedTicks` removal by reusing `deltaTicks` or by widened direct
  comparisons gave ten diffs at 822/822. Reusing `deltaTicks` for
  `animationFrame` gave six diffs at 822/822. All were restored. `videoY`,
  `startMovie`, `elapsedTicks`, `nextAnimation`, and `animationFrame` remain
  marked, alongside the separate `curMenu` review.
- Menu `Draw` carrier removals were restored (26 diffs at 88/82 and 35 at
  87/82). Direct widened timer reads in TransitionOff/On also failed (seven
  diffs at 16/15 and ten at 38/38); restored neighbors remain PASS 82/15/38.
- Tournament Initialize's widened direct car-count gave four diffs at 53
  instructions; GetTournamentFinishPrize's inline pointer gave eleven at
  28/29. GetTrophyName conditional/reuse probes gave 8/16/6/40 diffs (the
  conditional form 46/48). All were restored. These finite failures are not
  proofs that a carrier or its current spelling existed in the lost source.
- All **105 functions** across the three edited TUs remain PASS and have
  zero branch-count/offset divergence. Source-policy and vtable-indexing
  guards pass; the 757-object reconstruction link gate is green with zero
  real duplicates, hidden phantoms, or relocation-referenced unresolved names
  (964 existing blob-class duplicates remain). No new asm, volatile qualifier,
  postcompile rewrite, tool/header change, or audit exemption was introduced.
  Unrelated edits and the uncommitted P861/P862 checkpoint are preserved;
  P863 is also uncommitted/unpushed. The project-wide original-source/SLD
  goal remains open.

## P864 frontend expression recovery and SLD ownership (2026-09-06)

Five further source-only names/declarations are removed, without replacement
names. The strict frontend report is `frontend_common_strict_p864_20260906.md`:
**503** explicit carriers (P863: 508), 781 declaration-clean functions, zero
missing names, 46 extra source-local reviews, and three mapping reviews.
The other headline counts are unchanged: 838 SYM functions, 833 mapped
definitions, two implicit special members, nine type and nine function-storage
findings, 190 object-owned data records (171 source definitions / 19 blob-backed).
These are separate review metrics, not proof of complete original-source recovery.

- `screentrophyinfo.cpp`, `tScreenTrophyInfo::DrawBackground`: removed `fade`
  and `word`. The lower clamp is now an expression assigned to the real SYM
  `FadePartI`, without a pre-clamp source local. The text renderer nests both
  `TextSys_Word` and `CalcFadeVal` calls directly, removing the extra text
  pointer and later reassignment of `col`. The entire call range
  `8004128c..800412c0` now has one source statement corresponding to retail
  SLD94, instead of three reconstructed statements. The real local declaration
  order is also restored: FadePartI, FadePartIITheRevenge, r, col, yyy,
  drawFlags, drawFlags2, i. The exact debug twin reproduces their register/
  storage records respectively: REG19, REG20, AUTO-88/8B, REG16, REG17,
  AUTO-80/24B, AUTO-56/24B, REG16 (register numbers decimal).
- The same renderer's second fade uses period GNU C++ min/max operators,
  `(((int)fScreenFadeVal << 1) >? 0) <? 0x80`. These are explicitly supported
  by the retail-family compiler: gcc-2.8.1 `cp/lex.c` around 4198 maps the tokens
  to MIN_EXPR/MAX_EXPR; `cp/typeck.c` around 3521 handles numeric operands.
  One clamp expression restores the normalized SLD72 interval
  `80041178..80041190`; the preceding expression restores SLD71 at
  `80041160..80041174`, including the scheduled second-fade shift. This is an
  **inferred, compiler-supported expression**, not recovery of unique original
  tokens or macro text. It uses the period GNU C++ dialect, not modern ISO C++.
  Target **PASS298**, zero diffs, exact debug twin; TU **3/3 PASS**, branch
  divergence zero, all 298 oracle words checked against raw `rom/nfs4-f.exe`.
- `screenaudio.cpp`, `tScreenAudio::Initialize`: removed `audioMode` by moving
  `this->prevAudioMode = frontEnd.audioMode` before the three resets. This puts
  the load and delayed store (`800461dc/e0` and `800461f0`) in the same SLD311
  statement, while the intervening resets retain distinct SLD312/313/314
  ownership. SYM has no local besides the receiver. Target **PASS24**, exact
  debug twin and raw 24-word corroboration; TU **8/8 PASS**, branch divergence
  zero. `screenoptions.cpp` was inspected first but is an intentionally empty
  data/code-free object marker; no speculative body was introduced there.
- `screencongrats.cpp`, `tScreenPinkSlipCongrats::CalculatePrizes`: removed
  `speechId2` and `base`. The signed speech byte is read directly from SYM's
  `carinfo`, and the award uses its doubled value plus
  `(long long)(this->fWinner + 0x13)`. Widening the already-grouped right operand
  preserves the retail addition order; the int member assignment truncates the
  result. This is an inferred expression spelling, not a recovered cast token.
  Guard `80048d74..80048d80`, award `80048d84..80048d98`, and else
  `80048d9c..80048da8` now each form one source group matching SLD475/477/481.
  The owning SYM block records only `carinfo` AUTO-232/204B and receiver REG19,
  frame248. Target **PASS68**, zero diffs with exact debug twin, raw 68-word
  corroboration; TU **28/28 PASS**, zero branch divergence (105 branch words).

### P864 restored probes and remaining recovery work

- TrophyInfo GetShapeInfo's conditional placement lookup, including casts
  around the conditional or its selected value, still gave FAIL27 at 73/76;
  restored. Placement, idx, feTier, and currentTourn remain unresolved there.
  DrawBackground's nested/two-stage plain ternary clamps gave 28 diffs at
  300/298, six at 300/298, and nineteen at 303/298; all replaced by the passing
  GNU expression above. None is a proof that the lost source required carriers.
  DrawBackground still has tournID, tourn, feTier, and currentTourn, and other
  statement/block gaps remain. The header's descriptive TrophyRoomTierView /
  TrophyRoomCurrentView helpers also remain source-model debt; this round did
  not recover their original accessor spelling or change that shared surface.
- Audio Initialize's `menus` still splits retail SLD308; direct accesses after
  the reordered assignment gave six diffs at 24/24. The epilogue also retains
  a retail311-versus-source-return attribution difference. PlaySound's direct
  range predicate compared with true gave 21 diffs at 231/232; restored to
  PASS232 with `validItem` still visible. No whole-function SLD equality claim.
- PinkSlip CalculatePrizes still has `player`; the CarIO call and coordinate /
  float-store partitions remain open. Removing widening from the direct-field
  award expression gave FAIL12 at 66/68 and was restored. The old assertions
  that the split speech/base locals were required are superseded by this round.
- Parent independently rechecked all **39 functions** across these three TUs:
  all PASS, zero branch-count/offset divergence. Source-policy and vtable guards
  pass (1,029 files); the reconstruction relink gate is green across 757
  objects, with zero real duplicates, hidden phantoms, or relocation-referenced
  unresolved names (964 existing blob-class duplicates). Scoped diff checks
  are clean. No new asm, volatile, postcompile rewrite, tool/header modification,
  invented identifier, or audit exemption was introduced. Unrelated edits are
  preserved. P861-P864 remain uncommitted/unpushed; the full goal remains open.

## P865 frontend local and lexical-scope recovery (2026-09-06)

Six more non-SYM local names/declarations are removed without replacement names.
The strict frontend report is `frontend_common_strict_p865_20260906.md`:
**497** explicit source-only carriers (P864: 503), 781 declaration-clean mapped
functions, zero missing SYM names, 46 extra-local reviews, and three mapping
reviews. Other headline counts remain 838 SYM functions / 833 mapped definitions,
two implicit special members, nine type and nine function-storage findings,
190 object-owned data records (171 source definitions / 19 blob-backed).
These distinct counts do not establish complete original-source or SLD recovery.

- `screentrackrecords.cpp`, `tScreenTrackRecords::DrawBackground`: removed
  `clampTmp`, `lineFadeCalc`, and `half`, plus the invented file-local
  `TrackRecordLineY` helper. The 17 outer locals now exactly reproduce the
  recorded names, types, order, and debug homes: string AUTO-232/50B,
  string2 AUTO-176/50B, fade REG3, linefadeval AUTO-96/SHORT, maxitem
  AUTO-88/SHORT, boxx AUTO-80/SHORT, boxy AUTO-72/SHORT, boxw AUTO-64/SHORT,
  midy AUTO-56/SHORT, j REG17/SHORT, Col REG22, ColTextSel REG30,
  ColTextBright REG18, shape REG4/PTR tTexture_ShapeInfo, lbx REG19,
  tt REG18, and drawflags AUTO-120/24B. The frame remains 264 bytes,
  saved-register mask `0xc0ff0000`, receiver ARG0. The nested `xx` remains
  REG16/INT. Register numbers are decimal; unqualified numeric locals are INT.
- Period GNU C++ `>?` / `<?` expressions keep the clamp operands at int width
  and assign directly to the recorded `tt`, `maxitem`, and `linefadeval`.
  The exact debug twin has one statement per retail clamp group:
  `80042bac..80042bc8` / SLD216, `80042bcc..80042be4` / SLD218,
  `80042be8..80042c20` / SLD219, followed by maxitem arithmetic SLD220.
  The delayed short stores at `80042e00/e04` still have SLD219/220 ownership.
  Widening the already-bounded half-width subtraction preserves the retail
  `addiu -2` before subtracting centerx, without `half`. Widening the
  sign-extended `midy - 12` likewise removes the invented helper; the entire
  final bright-line setup `8004301c..8004305c` is one source statement,
  matching SLD284. These are inferred, compiler-supported expression forms,
  not proof of original tokens or macro text; min/max uses the period GNU
  dialect, not modern ISO C++.
- Independent range review confirmed that no removed narrowing changes
  behavior: SHORT screen fade gives fade in [-78848,78845], whose product
  with 128 fits INT; clamp outputs fit their SHORT destinations. The former
  half-width intermediate lies in [-16386,16381], so its SHORT narrowing
  was redundant; lbx lies in [-49153,49149]. The line-height subtraction
  lies in [-65547,65523], so the widened result converts losslessly to INT.
  The existing generated block boundaries around the xx loop still align
  with `80042e38`, `80042efc`, `80042f7c`, and `80042f84`. Target **PASS364**,
  zero diffs and exact debug twin; TU **7/7 PASS**, branch divergence zero,
  raw executable corroborates all 364 oracle words.
- `screenpinkslips.cpp`, `tScreenPinkSlips::Initialize`: removed `iVar1` and
  `tmp`. The hVideo member receives VIDEO_create directly and feeds
  VIDEO_spoolfile; fTVTicks receives the ticks snapshot before the reset
  statements, with GCC retaining the retail delayed store. Only recorded
  outer locals r, moviename[80], and trackInfo remain, in order; their
  generated homes are AUTO-152/8B, AUTO-144/80B, AUTO-64/48B, frame176,
  receiver REG16. Target **PASS82**, exact debug twin; TU **8/8 PASS**, branch
  divergence zero; raw 82-word corroboration.
- `screentournselect.cpp`, `tScreenTournSelect::DrawBackground`: removed
  `word` by selecting between complete FETextRender_WordWrapFade calls,
  each nesting its TextValue call. GCC tail-merges the conditional expression
  exactly, and the title-render block corresponding to SLD347 becomes one
  source statement. Also moved `char moviename[80]` from function scope
  into its recorded nested branch. SYM records 65e013-65e03a specify block
  `80040254..80040288`, relative lines93-98 / file331-336, declaration
  65e01c AUTO-136/80B. Target **PASS415**, zero diffs and exact debug twin;
  TU **9/9 PASS**, branch divergence zero (35 strict branch words), raw
  415-word corroboration. The conditional spelling is inferred, not claimed
  as the uniquely recovered original expression.

### P865 remaining recovery and restored probes

- TrackRecords still lacks the three empty two-level block pairs at
  `80042c24`, line10. They suggest inline/macro expansion but do not prove
  a particular helper name, signature, or body. Earlier assertions that
  the deleted locals/helper were required are superseded by the passing
  expressions. Shape/tick-load scheduling attribution, the tt conditional,
  other statement groups and the full numerical SLD stream remain open.
  No fresh failed TrackRecords probe was retained this round.
- PinkSlips Initialize still lacks the inline tFEApplication receiver
  scope. Retail assigns the hoisted ticks load at `800392e4/e8` to SLD252
  and its store `80039304` to SLD258; direct source assignment does not
  recover that partition or prove the original lexical order. Moving it
  after the resets at lexical258 gave FAIL4 at 82/82 and was restored.
  Epilogue attribution also remains open. Its DrawBackground carriers and
  ProcessInput::defs were not changed.
- TournSelect's receiver-only conditional inside TextValue gave FAIL15
  at 414/415 and was restored. Rectangle initialization, later iterator
  selection and description rendering retain SLD partition differences.
  Six existing carriers remain visible: tvIdx, number, descriptionText,
  shapeX, tournament, and fe. Neither these finite probes nor the existing
  comments prove that the lost source required those names or objects.
- Parent independently rechecked all **24 functions** across the three
  edited TUs: all PASS, no branch-count/offset divergence. Source-policy and
  vtable guards pass (1,029 files). Reconstruction relink is green across
  757 objects: zero real duplicates, hidden phantoms, and relocation-referenced
  unresolved names; 964 existing blob-class duplicates remain. No new asm,
  volatile, postcompile rewrite, tool/header modification, invented identifier,
  or audit exemption was introduced. Unrelated edits are preserved. P861-P865
  remain uncommitted/unpushed, and the full original-source/SLD goal remains open.

## P866 - three wrong-buffer references corrected; three carriers removed (2026-09-06)

Strict frontend report: `frontend_common_strict_p866_20260906.md`.
Source-only local carriers fall **497 -> 494**. Declaration-clean mapped
functions remain 781, missing SYM names 0, extra source-local names 46,
type/storage findings 9/9 and mapping-review functions 3. The 190 object-owned
data records still map to 171 source definitions and 19 blob-backed globals,
with zero missing/extra global definitions. These declaration counts do NOT
prove that all uses refer to the right objects: this round found and fixed
three real wrong-buffer bugs in functions that already passed the normalized
instruction gate.

### P866 proven storage-reference repairs

- `screenusername.cpp`, `tScreenUserName::GetShapeInfo`: replaced the empty
  literal used both as sprintf's destination and as `*permFileName` with the
  existing `UserPermFileName`. Owning SYM record `736c69` specifies EXT
  `char UserPermFileName[20]` at `800529b8`. Its declaration and definition
  already existed; no header, storage definition, or invented name was added.
  Retail `8004b058/05c` loads that address into s0, `8004b064` passes it as
  sprintf's a0, and `8004b090` stores the same pointer to the output. Updated
  M2C `func_8004B048.c` corroborates both references. Raw bytes at `800125e0`
  confirm the unchanged format `zUser%d`. The debug object's HI16/LO16
  relocations explicitly name UserPermFileName and preserve the shared s0
  path. **PASS24**, zero diffs, exact debug twin; all 24 oracle words checked
  against `rom/nfs4-f.exe`.
- `screencarselect.cpp`, `tScreenCarSelectTwoPlayer::SetDialog` and
  `tScreenPinkSlipsCarSelect::SetDialog`: replaced each empty sprintf
  destination and its corresponding dialog string with existing
  `WaitingString`. SYM record `64b3d1` specifies module-static
  `char WaitingString[50]` at `80052c58`; the definition already exists in
  `screencarselect_externs.h`. The TwoPlayer oracle loads this address at
  `8003ecc4/c8`, passes s0 to sprintf at `8003eccc`, and stores s0 to the
  dialog string at `8003ece4`. PinkSlips does the corresponding operations
  at `8003f428/42c`, `8003f430`, and `8003f448`. Updated M2C bodies
  `func_8003EC50.c` and `func_8003F300.c` independently corroborate the
  shared buffer. The debug-object symbol table places WaitingString at
  `.bss+0x38`; both functions' HI16/LO16 .bss relocations have addend 0x38
  and retain the same pointer for formatting and display. **PASS48/164**,
  zero diffs and exact debug twins; raw executable confirms all 212 words.
- This fixes six pointer uses across three functions, not three new PASSes.
  Normalization clears relocation identities/addends, so the old wrong
  literals and the corrected storage references both passed verify_asm.
  Source/global-use correctness must remain a separate oracle-backed gate.
  A targeted scan of frontend empty sprintf/strcpy destinations and filename
  assignments found one remaining filename literal in ScreenCongrats'
  no-swap-shapes default. It is legitimate: retail points at the read-only
  empty string `D_800122A4` and returns zero swap shapes. It was not changed.
  This limited scan is NOT an exhaustive reference-use audit.

### P866 local and SLD improvements

- `screenusername.cpp`, `tScreenUserName::DrawBackground`: removed
  `textfadev` without a replacement identifier. Period GNU C++ `fade <? 0x80`
  supplies the common normal/high result directly to fTextFade while the
  separate zero store and original outer check remain. **PASS394**, exact
  debug twin, raw 394-word corroboration. The eleven recorded outer locals
  retain their SYM names/types/order/homes: i REG16/SHORT, k REG16/SHORT,
  x REG17/SHORT, y REG21/SHORT, gray REG16/INT, fade REG5/SHORT,
  fadebox AUTO-72/SHORT, gridpos AUTO-64/SHORT, row AUTO-56/SHORT,
  col AUTO-48/SHORT, output AUTO-80/CHAR[2]; nested colText remains REG16/INT.
  Frame112, mask `0xc0ff0000`, receiver ARG0. The GNU expression is an
  inferred source form, not proven original macro text or modern ISO C++.
- `screentrackinfo.cpp`, `tScreenTrackInfo::GetShapeInfo`: removed
  `dayTimes2` and `weatherPlus`, leaving the no-local shape recorded in SYM.
  Widening the grouped day contribution within sprintf's expression retains
  retail evaluation order; the final int cast preserves a single-word
  vararg. Both input fields are UCHAR, so the result is bounded by 97..862.
  Arithmetic and call at `8004223c..4224c` and `8004225c..42274` now belong
  to one expression, as in SLD53; neighboring assignment groups 52/54
  remain distinct. **PASS40**, exact debug twin, raw 40-word corroboration.
  The expression spelling remains inferred; epilogue attribution is open.
- `screenmemcard.cpp`, `tScreenMemcard::DrawVerticalLine(short,short,short,short)`:
  retained existing innerHeight but comma-sequenced its two arithmetic
  stages in one expression, then passed it to PSXDrawBrightEndLine. Removing
  the redundant final return lets the call and epilogue share SLD269.
  The geometry instructions at `800468f0/f4/f8/fc`, `80046908/0c`, and
  `80046918/1c/20` now share one statement as in SLD267. **PASS45**, exact
  debug twin and raw 45-word corroboration. No carrier count is credited
  here. The comma spelling is inferred, not recovered original text.

### P866 restored probes and remaining original-source work

- UserName DrawBackground still has the unrecorded fadeboxv/gridposv clamps,
  an alignment carrier, an inferred accessor name, and an existing empty
  asm use marker. These were not removed, renamed, or claimed original.
  Retail SLD95 remains fragmented across the nested checks, GNU-min/store,
  goto, and zero-store source lines; full SLD exactness is not claimed.
  Restored probes: combined logical textfade check 17 diffs at 391/394;
  gridpos ternary/logical condition 102 at 394/394 (widened-zero variant
  identical); direct GNU-min/zero gridpos stores 100 at 396/394; direct
  SHORT fadebox destination plus GNU min 144 at 394/394. Finite failures
  do not prove any remaining carrier is necessary.
- TrackInfo's alternative widening on the weather operand gave 12 diffs
  at 40/40 and was restored. Its separate ProcessInput fee-field probes
  gave 4/6/4 diffs at 39/39 and were also restored. Proven field identity
  is fTournaments base +0x24, stride84, fEntranceFee +0x30 (= access +0x54);
  finding a passing original-field source expression remains open.
- Memcard's four unrecorded carriers innerHeight/pos/test/shifted and the
  fragmented SLD265 clamp remain open. Restored probes: GNU min/max 23
  diffs at 44/45, MIN/MAX macro 11 at 46/45, oracle-shaped ternary 7 at
  44/45, widened height forms 9 at 46/45. Existing assembly was unchanged.
- Parent regression-checked all four edited TUs: UserName **6/6**,
  TrackInfo **5/5**, Memcard **15/15**, CarSelect **59/59**: **85/85 PASS**,
  zero branch-count/offset divergence. Six targeted function oracles were
  corroborated against 715 raw executable words. Source-policy and vtable
  guards PASS (1,029 files). Reconstruction relink is GREEN across 757
  objects: zero real duplicates, hidden phantoms, and relocation-referenced
  unresolved names; 964 pre-existing blob-class duplicates remain.
- No new asm, volatile, postcompile rewrite, header/tool change, invented
  identifier, or audit exemption was introduced. Unrelated edits remain
  preserved. P861-P866 remain unstaged, uncommitted and unpushed. The full
  SYM/global-use/original-source/SLD goal remains active and incomplete.

## P867 (2026-09-06): audio references, standings locals, TrackSelect scope

Retained verified restoration in three frontend TUs, plus a read-only review
of the user's CPE-derived data map. No new function PASS is credited: these
functions already passed the normalized gate, and the work improves source
declarations, actual reference identity, and selected SLD groups.

### P867 actual reference and literal recovery

- `feaudio.cpp`, `FEAudio_StartLoadPatch__FP10SPEECHINFO` at 80015780:
  replaced the empty filename passed to FeAudio_StartBigfileRead with the
  existing `currentSpeechViv`. Native SYM `4bfaec` records CHAR[40] at
  80051510. Retail 800157e8/ec materializes this address, calls at
  800157f8 and stores the result at 80015800; updated M2C func_80015780.c
  corroborates it. The debug object explicitly relocates HI16/LO16 to
  currentSpeechViv. **PASS41**, exact debug twin. The old empty literal
  also passed because relocation normalization does not verify identity.
- Replaced five bigBuf-relative literal uses with four recovered strings:
  comHeader at 80010104, %c%02d at 80010110, %c%ca at 80010118 (two uses),
  and streamBuffer at 80010120. Raw bytes, caller instructions, and M2C
  agree. Targets StartPatch/AsyncPlaySpeech/StartBigfileRead remain
  **PASS73/31/38**, exact debug twins. The complete emitted 117-byte
  .rodata pool now equals merged retail beginning at 80010104, including
  string pooling and inter-string padding. No claim is made about the
  following three alignment bytes or complete frontend data linkage.

### P867 SYM declaration and SLD recovery

- StartLoadPatch's declaration order is now length then offset, as in
  records `4bf401`/`4bf415`; generated homes remain AUTO-12/AUTO-16.
  Combined offset/length rejection forms one expression for SLD51 at
  800157ac..800157c8. Conditional purge and reset form one expression
  for SLD55 at 800157cc..800157e4; no unproven macro name was introduced.
  The filename call remains one SLD57 group. The concrete conditional
  spelling is inferred, not recovered source text. SLD59/61/64 return
  and epilogue attribution still needs work; full SLD exactness is not
  claimed. All retained steps independently preserve PASS41/exact -g.
- LocateBigfile declarations now follow SYM order i, info, tempChar:
  REG18/UINT, REG17/PTR FILEINFO, REG5/PTR CHAR. Parameter homes and
  frame56/mask c0ff0000 remain exact. **PASS86**, exact debug twin.
- InitCommentary keeps its linkage-proven second int parameter but
  leaves it unnamed. Removed synthetic arg1 and its audit exemption;
  **PASS40**, exact debug twin, no replacement identifier. Native NFS4
  SYM records language only. NFS2's raw Watcom Feaudio.c locals dump
  names the corresponding unused argument postGame (BP-4); its matched
  PC body has closely related initialization. This is a strong lineage
  candidate, NOT proof of the original NFS4 spelling. The NFS4 caller
  supplies trailing zero, which proves a value, not a name. Original
  parameter-name recovery remains in the backlog.
- `screenpost.cpp`, TournamentStandings DrawBackground: removed line
  and halfWidth with no replacement names. The widened grouped
  `(int)((long long)i + 0x2fe)` expression generates the separate row
  induction value while retaining only SYM i. Row-call groups SLD203,
  208/223 and back edge224 remain correct; i is bounded by the
  signed-short racer count, so this sum narrows losslessly. A grouped
  widened width adjustment directly computes lbx in SLD250.
  **PASS561**, exact debug twin; frame248/mask c0ff0000 unchanged.
- PinkSlipStandings DrawBackground: removed halfWidth in the equivalent
  lbx expression, matching SLD390. **PASS265**, exact debug twin;
  frame208/mask c0ff0000 unchanged. Both signed-short width/centerx
  expressions have final range -49153..49149. Retail subtraction delay
  slots 80039fc8/8003a78c remain unchanged. Widening is an inferred
  source expression, not an assertion about original macro tokens.
- `screentracks.cpp`, TrackSelect DrawBackground: moved existing
  moviename[80] into its full SYM-recorded playback-start scope before
  the brightness guard, through VIDEO_startplayback. Records
  `691546/69154f/69156d` specify AUTO-128 in block
  800417f8..80041864, source143..150. Executable groups agree with
  SLD145/146/148/149/150. **PASS299**, exact debug twin. No carrier
  count credit: this is the same recorded object with corrected scope.

### P867 restored probes and remaining recovery queue

- TrackSelect ProcessInput ptVar1 chained clear/set: FAIL21 at 117/114.
  DrawBackground startTicks field staging: FAIL1 at 300/299 (extra sw);
  embedding brightness store in subtraction: FAIL3 at 300/299;
  widened tick operand: FAIL8 at 305/299. videoWall pointer-to-member
  expression: FAIL6 at 299/299. Every probe was restored; source comments
  record these attempts without claiming any carrier is indispensable.
- Remaining TrackSelect carriers include shapeX, videoY, videoWall,
  startTicks, packetPtrSlot, ptVar1; original inline receiver form,
  empty inline blocks, and whole-function SLD remain open.
- TournamentStandings retains numRacers, lastRacer, type. Its separate
  Initialize method also retains an invented SCREENPOST_SET_COUNT_SPEED
  macro with max_money/max_damage locals, not counted by the declaration
  audit. Do not mistake their absence from the count for original-source
  validity. No new names were assigned to these unresolved values.
- No canonical guarded-purge-and-null macro was found in the searched
  references. NFS2 has an explicit guard/purge/reset sequence; its
  `_purgememadr` definition is only an alias, not such a macro. This
  search failure is not proof that no original macro existed.

### P867 final gates and CPE evidence

- Fresh parent gates: Feaudio **10/10**, Screenpost **13/13**,
  Screentracks **10/10**: **33/33 PASS**, zero branch-offset/count
  divergences. Fourteen associated function oracles corroborated against
  **1,891 raw executable words**, zero mismatches.
- Refreshed strict audit `frontend_common_strict_p867_20260906.md`:
  recorded source-only carriers **494 -> 490** (three local declarations
  and one unused parameter name, not four runtime objects). Unchanged:
  781 declaration-clean mapped functions; missing names 0, extra locals 46,
  type findings 9, storage findings 9, mapping review 3. Globals remain
  190 records / 171 source definitions / 19 blob-backed, missing/extra 0,
  type/storage findings 0. These figures are review coverage, not full
  original-source or SLD proof.
- Reconstruction relink GREEN: 757 objects, zero real duplicates,
  hidden phantoms, or relocation-referenced unresolved names; 964
  pre-existing blob-class duplicates remain. Vtable indexing guard
  PASS across 1,029 files; source-only policy PASS; diff-check clean.
- New user reference `C:\Temp\nfs4-clean\nfs4_data.txt` validated as
  an address-range index: all 1,328 numbered CPE extents and all 211,949
  payload bytes corroborate raw CPE/merged retail. It is NOT an exact
  source-object/type map. Detailed pitfalls and reproducible read-only
  receipt are in `CPE_DATA_MAP_REFERENCE_20260906.md` and
  `probe_cpe_data_map_p867.py`: pointer-pointee size confusion,
  unrelated MOS-name fallback, multi-object load chunks, and the
  reserved zero overlay hole must not drive false source edits.
- No new reconstructed asm, volatile, postcompile rewrite, invented
  identifier, or audit exemption. No production build-tool/header edits;
  the new scratch probe is read-only and does not affect matching.
  Existing unrelated edits are preserved. P861-P867 remain unstaged,
  uncommitted and unpushed; no fresh commit/push was requested. Full
  SYM/global-use/original-source/SLD restoration remains incomplete.

## P868: close current work, commit to main, and pause (2026-09-06)

The user requested finishing the current work, committing, pushing, and
pausing. No new matching targets were started after that request. This
checkpoint includes the retained P861-P868 work and excludes unrelated
working-tree edits. Original-source/SYM/SLD restoration is still incomplete;
pausing this work is not completion of the larger goal.

### Retained SetScreen cleanup

- `feapp.cpp`, `tFEApplication::SetScreen`: removed the unrecorded
  slotOffset declaration and its exemption without introducing another
  identifier. Repeating the existing signed-short scaling expression
  preserves **PASS20**, including the exact debug twin. The simpler
  `(int)i * 4` spelling was count-exact FAIL6 and was restored.
- Native SYM records only this, i, screen (REGPARM4/5/6; pointer, SHORT,
  pointer); frame 24 / mask 80000000 / offset -8 remain unchanged. The remaining
  currentScreen source carrier is not claimed as an original local.
- Joining the scale and load agrees better with retail SLD454 at
  80013f28..80013f3c. Whole-function SLD is not exact: the currentScreen
  assignment and comparison still split retail 454, the condition joins
  454/457, and the epilogue remains separate from 458. These are open
  recovery items, not a claim that the current spelling is original.
- DisplayHelp direct-member probes, with or without a widened address,
  gave FAIL4 at 9/9 and moved the variant store out of the call slot.
  Restored the original body, retaining only the experiment receipt.
  Final **PASS9**, exact debug twin; owning Feapp TU **16/16 PASS**,
  zero branch divergences. Original inline-method spelling remains open.

### Byte-PASS alternatives rejected for SLD regressions

- `stattool.cpp`: directly using the signed-short sum as the loop bound
  removes nNumCars and gives PASS34/exact-g, but joins the separate
  retail 418 assignment (8004aec8) to the retail 422/436 conditions
  (8004aee0/8004af30). Removing namePtr through a conditional
  pointer-to-array expression gives PASS15/exact-g but merges retail
  457/458/459 predicate, assignments, and return into one statement.
  Both probes restored; final **11/11 PASS**, zero branch divergences,
  raw oracle checks **34/34 + 15/15 words**.
- `fevideowall.cpp`: storing ticksA[0] into fTVTicks before setting
  fTransitionDirection removes tickCounter and reaches ordinary-source
  PASS9/exact-g in both TurnOff/TurnOn. It merges distinct retail SLD
  264/265 and 289/290 groups, so both edits were restored. A canonical
  ticks alias cleanup also passed but was restored to keep this
  checkpoint scoped. Final **12/12 PASS**, zero branch divergences,
  **18/18 raw oracle words**. Recover the original inline-method form
  in a future round; these are successful byte alternatives, not floors.
- `fecheats.cpp`: removing feApp in HandleActivation gives FAIL2;
  direct best-placement indexing gives FAIL10/116; mutating cheat to
  remove its carrier gives FAIL9/117. All experiments restored.
  Final HandleActivation **PASS116**, ActivateCheat **PASS66**, owning
  TU **10/10 PASS**, zero branch divergences. No retained source edits
  in fecheats.cpp, stattool.cpp, or fevideowall.cpp.

### Final checkpoint validation and remaining work

- Final strict frontend report: `frontend_common_strict_p868_20260906.md`.
  Source-only carrier count **490 -> 489**; unchanged declaration-clean
  mapped functions 781, missing names 0, extra locals 46, type findings 9,
  storage findings 9, mapping-review 3. These are audit coverage metrics,
  not proof of complete original-source or SLD recovery.
- Parent rebuilt and checked all **22 retained source TUs**: frontend
  **309/309 PASS**; game **113/114 PASS**; total **422/423 PASS**.
  The only miss is the unchanged pre-existing
  Replay_StoringControllerData__FG15tControllerData (188 diffs and one
  branch-offset divergence). It was not edited. Replay_GetInput remains
  PASS280. No previously passing function regressed in this batch; all
  other checked branch-offset/count gates are zero.
- Final relink remains GREEN: 757 objects, 964 known blob duplicates,
  zero real duplicates, hidden phantoms, or relocation-referenced
  unresolved names. Vtable indexing PASS across 1,029 files; source-only
  policy PASS. The CPE reference probe again corroborates all 1,328 numbered
  ranges and 211,949 payload bytes, without claiming source ownership.
- Fetched origin/main and fast-forwarded over disjoint sound-library
  commit 2a75cf16 before preparing this checkpoint. No production
  build-tool/header changes, new reconstructed asm/volatile, invented
  source names, or postcompile rewrites were introduced by this batch.
- Commit scope is the 22 retained source files, this backlog, P861-P868
  strict audit receipts, and the CPE reference note/read-only probe.
  Existing unrelated edits and untracked archives are excluded and
  preserved. The exact commit/push result is reported separately after
  Git confirms it. All bounded agents have stopped; pause after push.

## P869: ordinary source shapes and scalar declaration restored (2026-09-06)

Resumed on user request after the P861-P868 checkpoint was committed and
pushed to main as fe5df950. The active goal remains original-source/SYM/SLD
restoration. The later user rule forbids invented semantic names even though
the older stored goal text still mentions them; no such names are introduced.

### SetScreen: the old matching recipe is no longer necessary

- `feapp.cpp`, SetScreen__14tFEApplicationsP7tScreen at 80013f24:
  **PASS20 -> PASS20**, exact debug twin. Restored nested if/store/if
  source with ordinary fCurrentScreen[i]/fTransitionToScreen[i] accesses.
  Removed currentScreen and all integer-address/long-long/shift casts,
  the embedded comma-expression store, and Yoda comparison. No replacement
  local or helper. Native SYM has only this/i/screen, REGPARM4/5/6;
  SHORT i and pointer-array members [2] at +0x0c/+0x1c are retained.
- A mixed intermediate form (old widened first test, typed later accesses)
  was FAIL17 at 23/20. Completing the consistent typed-array source reaches
  PASS20. This is a measured example of a temporary degradation leading to
  a better source reconstruction, not a reason to retain the old casts.
- Parent inspected all instruction line mappings: retail454 now groups
  scale/load/first comparison;457 groups transition store/null checks;
  458 contains the TransitionOff call. Its relocation resolves to80026804.
  The common epilogue still has a separate closing-brace source tag while
  retail attributes it to458. Full SLD exactness is therefore NOT claimed.
  DisplayHelp remains unchanged and PASS9.

### Car-select source statements and local set

- CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46 at8003b820:
  **PASS176 -> PASS176**, exact debug twin. Removed _i by expressing each
  conversion as `(Result2[n] >> 1) / 0x10000`; ordinary signed division
  regenerates the negative-input correction. Native records6462ef-646561
  specify only T/G/i/Result1/Result2. Their declaration order, types, slots,
  registers, parameters, frame168 and mask80ff0000 remain exact.
- Parent checked instruction attribution: screenX conversion belongs to
  SLD611, screenY to612, camRot to625. Each complete calculation/store is
  now one source statement. Existing unrelated statement attribution,
  including the shared epilogue, is not claimed fully restored.
- UpdateVideoWall__16tScreenCarSelectR8tCarInfo at8003bba4:
  **PASS52 -> PASS52**, exact debug twin. Removed country by assigning
  fPreviousCountry before clearing fTVsInitialized. Retail SLD657 is the
  country load;658 is reset;659 includes the scheduled country store in
  the SetBrightness call delay slot. The earlier failing direct-assignment
  probe had used the wrong source order. Native records6466bd-646787
  contain no caller local. No replacement identifier was invented.

### speechfileHeader: scalar PTR, not a one-element array

- Native SYM4bfac2 at8005150c explicitly records EXT PTR STRUCT LUMPYHEAD.
  Replaced the array[1] definition and unsized-array extern with a scalar
  `LUMPYHEAD *speechfileHeader`, removing five [0] accesses. Its four-byte
  storage does not become16 bytes: the debug size16 describes the pointee.
- Only feaudio.cpp includes the owning feaudio.h/feaudio_externs.h chain.
  The existing frontend/common -G0 identity already handles non-gp
  addressing, making this historical array workaround unnecessary. No
  section attribute, compiler setting, symbol alias, or tooling change.
- Fresh original and scalar builds have byte-identical complete objects,
  SHA256 `1dfee36a2678e8c3c7cd69a923343e29cd758fec5d5ebb6dff2068b7a357a2a3`;
  parent independently rebuilt and confirmed the final hash. Code, data,
  rodata, relocations and storage order are unchanged. Debug .def now has
  true scalar pointer type0x18, tagLUMPYHEAD, scl2. Cell offset0x44 is
  followed by currentSpeechViv at0x48 and commentaryActualLevel at0x70.
- StartLoadPatch41, InitCommentary40 and DeInitCommentary14 each retain
  PASS and exact debug twins. P867 corrected buffers and literals remain.

### Restored probes and gates

- Root RemoveFromPinkSlipsList lastSlotOffset-elimination probes: widened
  full address FAIL2 at82/82; natural slot31 field address FAIL2 at82/82;
  widening playerNum multiplication FAIL44 at88/82. A complete ordinary
  typed-array body without any of its seven carriers gave FAIL39 at81/82.
  All probes were restored with apply_patch; fecars.cpp has no retained
  content change. Final owning TU46/46 PASS, zero branch divergences;
  SellCar96 and RemoveFromPinkSlipsList82 remain PASS. These measurements
  do not establish impossibility; original expression/statement recovery
  remains open.
- Parent fresh changed-TU gates: Feapp16/16, Screencarselect59/59,
  Feaudio10/10: **85/85 PASS**, zero branch-offset/count divergences.
  All six directly affected function debug twins are exact. Thirteen
  distinct oracles corroborate **900 raw executable words**, no mismatch.
- Strict report `frontend_common_strict_p869_20260906.md`: source-only
  carriers **489 -> 486**; measured global array carriers **13 -> 12**.
  Unchanged: declaration-clean781, missing names0, extra locals46,
  type findings9, storage findings9, mapping-review3. Globals190 records,
  171 source definitions,19 blob-backed; missing/extra/type/storage0.
  These are audit coverage metrics, not full source-restoration proof.
- Relink GREEN:757 objects,964 pre-existing blob duplicates,0 real
  duplicates, hidden phantoms or relocation-referenced unresolved names.
  Vtable audit PASS1029 files; source-only policy PASS; diff-check clean.
- Retained scope: feapp.cpp, screencarselect.cpp, feaudio.cpp and its
  private extern header. No new asm/volatile, invented names, production
  tooling edits, or postcompile rewriting. Unrelated edits are preserved.
  This resumed round has not been committed or pushed.

## P870: second obsolete array carrier removed (2026-09-06)

### gLargestUnused restored across its consumers

- Native SYM record `4b4f25` proves EXT ULONG at800514b8, owned by
  FEApp.obj. Restored the scalar `u_long gLargestUnused` definition,
  scalar externs, and all six direct uses in feapp.cpp and front.cpp.
  Also corrected the unused `int` extern in bworld_externs.h to
  `unsigned long`; bworld.cpp itself was not edited. Header include
  inventory confines the affected build scope to these three TUs.
- No section attribute or compiler change was needed: the established
  frontend/common -G0 identity makes the historical array workaround
  unnecessary. Generated .def now correctly has scalar ULONG type0x0f.
- All three entire non-debug objects are byte-identical to their
  respective pre-P870 baselines, with final hashes independently
  corroborated by the parent:

  ```text
  feapp  aed59b1d17dd6befe6112862e1d2233441c9a484a071c86f50132db2e17ca65a
  front  aa730506c2578190bce89be3559cef70c4494582b1af0d37a37497f5a4c8c5fb
  bworld c3a0b5c04421d3854304c9961d5e6d4f398e3d5d4729f7ea0c886af4bff30435
  ```

- Feapp16/16, Front43/43, Bworld21/21 remain PASS with zero branch
  divergences. RunDemoVideo164, MainLoop1123 and Front_Menu173 retain
  exact debug twins; parent corroborated all1,460 oracle words against
  the raw executable. Six stores still reference gLargestUnused+0 at
  the correct VA; four-byte zero storage and relocations are unchanged.
- This fixes declaration shape, NOT all FEApp data layout: gLargestUnused
  remains at object .data+0, FEApp at .data+4, and function-static
  currentVideo is still .bss+0 rather than between them as in the native
  address sequence. That pre-existing original-section/order question
  remains open. P869 SetScreen and every other prior edit are preserved.

### Coordinated scalar recovery queued, not partially applied

`FeTools_gScrollTicksOut` is native SYM579b67, EXT INT at800517d0,
initialized to30. An array[1] is still present. A complete scalar fix
requires five TUs and their shared extern header:

- Base fetools.cpp: `[1] = {30}` definition becomes scalar `= 30`.
- Base feinput.cpp: remove its two `[0]` accesses.
- Base feinput_externs.h: unsized-array extern becomes scalar.
- NFS4-R-JPN regional fetools.cpp: scalar definition.
- NFS4-R-JPN regional feinput.cpp: remove two `[0]` accesses.
- NFS4-R-USA regional fetools.cpp: scalar definition.

The regional JPN feinput TU includes the base header and carries pre-existing
user/other-agent edits. Changing only the base header would break it; leaving
regional array definitions would preserve declaration drift. No source or
header in this candidate's dependency set was edited. Baseline base Fetools6/6
and Feinput4/4 PASS, with zero branch divergence. This is a coordinated edit
queue, not proof of an unavoidable matching carrier. Resolve the regional
changes together after inspecting and preserving that existing work.

### Consolidated P869-P870 verification

- Five distinct affected TUs: **149/149 PASS**, zero branch divergences.
  The separately restored fecars probe is46/46 PASS. Nine directly affected
  functions have exact debug twins. Sixteen distinct oracles have **2,360
  raw executable words** corroborated, with no mismatch.
- Final frontend report `frontend_common_strict_p870_20260906.md`:
  source-only carriers **489 -> 486** across these two rounds; global array
  carriers **13 -> 11**. Declaration-clean781, missing0, extra46, type9,
  storage9 and mapping-review3 remain unchanged. Global record coverage,
  type and storage findings remain unchanged and clean. The counts do not
  establish full SYM/source/SLD exactness; the goal is still incomplete.
- Final relink GREEN (757 objects,964 known blob duplicates,0 real
  duplicates/hidden phantoms/relocation-referenced unresolved names),
  vtable indexing PASS1029 files, source-only policy PASS.
- Added P870 scope: feapp_externs.h, front.cpp, front_externs.h,
  bworld_externs.h, plus the already-edited feapp.cpp. No new asm/volatile,
  invented source names, production tooling edits or postcompile rewrite.
  Existing unrelated changes and regional files were preserved.
  P869-P870 remain uncommitted and unpushed; this resume request did not
  ask for a new commit. The latest committed checkpoint is fe5df950.

## P871: coordinated scalar restoration and original vol parameter (2026-09-06)

The previous goal turn was verified progress. This round followed the complete
declaration/consumer graph, including regional variants, rather than declaring
the base-only audit sufficient. Existing unrelated edits remain preserved.

### Nine more native scalar globals restored

| Native record | Global | Restored type / initial value |
| --- | --- | --- |
| 579b67 | FeTools_gScrollTicksOut | int = 30 |
| 579b0f | font12 | char pointer, zero |
| 579b23 | font18 | char pointer, zero |
| 579b37 | fontTitle | char pointer, zero |
| 579b4e | currentSize | short, zero |
| 5e4a59 | CURRENTPLAYER | int = 0 |
| 5984a8 | gPSXMemCardFull | int, zero |
| 5984e6 | gAllScreens | tAllScreens pointer, zero |
| 59850d | memCardReadOK | bool, zero (four-byte target storage) |

- Parent read all nine native records directly. None is an ARY record.
  Pointee debug sizes are not scalar pointer storage sizes; gAllScreens
  occupies four bytes, not the 15,320-byte tAllScreens pointee size.
- FeTools' five definitions, externs and uses were corrected coherently
  across base fetools/feinput/fetextrender, JPN fetools/feinput and USA
  fetools, plus three owning extern headers. No partial shared-header
  change was left to break a regional consumer. JPN feinput received only
  the two relevant [0] removals; its existing source was otherwise preserved.
- CURRENTPLAYER was corrected in base plus USA/JPN/AU fememcard and its
  owning extern header. Six uses per owner now access the scalar. Base and
  regional fedialog consumers, and USA femenudefs, already used the correct
  scalar declaration; they were checked but not edited.
- Front's three globals were corrected in base/USA front.cpp and their
  shared front_externs.h. Existing scalar declarations in other headers
  needed no changes. Genuine native arrays (gFE_Cheats[5], colourChosen[8],
  CarLineup[9], picked[11], and the [7][5] cop-model tables) were preserved.
- No section attributes, new aliases, identifiers, asm, volatile, compiler
  flags or production tools were introduced. The established frontend -G0
  lane produces the same addressing with the native scalar declarations.

### Object identity and data receipts

Every affected base object in the scalar-only work is byte-identical to its
own fresh pre-change baseline. Parent rebuilt all affected base TUs and
independently corroborated these final SHA-256 values:

```text
fetools      1d535232d8873d24d4c2b4711591edc976272e6d3c8b89c66145d2a4478d9f57
feinput      82466870af7c89b215e35aac5d4335a7ec237f82008bd5d2f75f55ffc8553a52
fetextrender fc573287922a2dc9949dd2cc97b5d714612ba489c1ea87a6a07c9e3fb0a62260
fememcard    e395c1f80d78658688679ae01ce07663e319d09e2e1816d0515625fe5e5d81d8
fedialog    c6c396dcd266d5d211506f03e71c8ee09ae2cc0f01282b4ef0bcbf9897156983
front       aa730506c2578190bce89be3559cef70c4494582b1af0d37a37497f5a4c8c5fb
```

- This proves unchanged code, data, relocation and symbol payloads for
  those builds, not completeness of the entire game's linked layout.
  Native debug entries now correctly distinguish PTR CHAR (0x12), SHORT
  (0x3), INT (0x4), PTR STRUCT and BOOL instead of artificial arrays.
- The FeTools 18-byte run at800517d0 (INT30, three zero pointers, SHORT0)
  and FEMemCard 56-byte run at80051a68 match retail. Storage/definition order
  remained unchanged. FeTools Init58/Deinit20, GetDebounce69, SetFont29 and
  Front ConstructAll100/DeleteAll25/InitialCheck19/SecondaryCheck50 retain
  exact debug twins. These affected base oracles comprise 370 raw words.
- Regional scalar-only comparisons preserve every code/data/relocation
  section and every decoded non-file symbol. Their literal ELF file hashes
  can differ because verify_region embeds PID-specific temporary filenames;
  this metadata difference is excluded explicitly, not silently treated as
  whole-file identity. All pre-existing regional code mismatches remain.

### P870 regional omission found and repaired

The P870 base-only consumer search missed two USA front.cpp uses and all
six regional feapp.cpp copies. They still used gLargestUnused[1]/[0] after
the shared declaration became scalar, causing regional compile failures.
The earlier 149/149 base gate did NOT cover that error.

- Corrected the two USA Front_Menu accesses and only five lines in each
  regional feapp.cpp (scalar definition plus four uses). All six regional
  variants now agree with the shared scalar header.
- Established original-array regional baselines with the original single
  extern declaration, then restored the scalar declaration before final
  validation. These checks were serialized while other frontend builds
  were stopped; no temporary array declaration remains.
- Regional feapp objects preserve all sections, relocations and decoded
  symbols apart from temporary source filenames. All24 manifest-selected
  regional checks pass; 11,433 raw oracle words corroborated.
- Front_Menu has no standalone regional oracle file. Its repaired USA
  form compiles; the mapped 173-word raw comparison agrees outside marked
  relocation fields. This is not misreported as a dedicated REGION-PASS.
- Parent's final search of both recon and regiondiff/recon finds no live
  array definition/use for any of the eleven restored scalar globals from
  P869-P871. Old scratchpad snapshots were intentionally left unchanged.

### AudioEng_Set: restore use and register home of vol

- Native AudioEng_Set__Fiiiiiiii at8007b5a8 records vol as REGPARM s7,
  with only g/a/s as ordinary function locals. The previous reconstruction
  instead recorded vol in a1 and an invented volume alias in s7.
- Removed volume and use vol directly at all four input/output boost
  accesses. **PASS159 -> PASS159**, exact debug twin; owning TU9/9 PASS,
  zero branch divergences, 159/159 raw oracle words corroborated.
- Generated .def vol now has val23/scl17/type0x4, matching native SYM.
  The s7 argument copy now belongs to the function prologue (retail SLD205)
  instead of the deleted alias-initialization statement. The other existing
  parameter aliases and their SLD attribution remain unresolved; this is
  not a claim that the whole function is source/SLD-exact.
- Measured probes, all restored except volume removal: deleting all six
  parameter aliases gives FAIL12 at159/159; const-qualified or register
  parameter spellings remain FAIL12. Keeping only volume/doppler gives
  FAIL22. Individual removals give camera22, doppler12, azimuth14,
  gasLevel18, direction8, all count-exact159/159. These receipts reject
  those particular forms, not all future original-source recovery paths.
- AIPerson_LoadPersonalityData was inspected only, remains PASS209 with
  its existing unresolved copCollisionFirmness carrier; no source change.

### Final scope-correct verification and remaining queue

- Parent refreshed all11 distinct base TUs affected across P869-P871:
  **235/235 PASS**, zero branch-offset/count divergences. Relink GREEN:
  757 objects,964 known blob duplicates,0 real duplicates, hidden phantoms
  or relocation-referenced unresolved names. Vtable indexing PASS1029
  files; source-only policy PASS; diff-check clean.
- Parent also ran the manifest's candidate/region/function combinations
  for all affected regional units: **141/159 REGION-PASS**. The18 remaining
  checks are pre-existing mismatches of unchanged object payloads, now
  explicitly visible rather than hidden by narrow per-representative gates:
  AU fememcard Init_Memcard against JPN (2 diffs); JPN FEInput_GetNoDebounceKey
  (4); USA fememcard LoadGame against six regions (2 or4); SaveGame against
  AU/FR-DE/UK-ES-IT/UK-SW (2); SavePinkSlipsCars against six regions (20).
  No current scalar rewrite caused these byte differences. The regional
  candidate/group mapping and those source bodies remain a review queue;
  full regional matching is not claimed.
- `frontend_common_strict_p871_20260906.md`: local carriers remain486;
  global array carriers **11 -> 2** (gMenu_SubMenuPlayer and menuDefs).
  Declaration-clean781, missing0, extra46, type9, storage9 and mapping3
  remain unchanged. Global declaration coverage/type/storage remain clean.
- `game_common_strict_p871_20260906.md`: local carriers **492 -> 491**;
  declaration-clean1228, missing0, extra6, type28, storage28, mapping0.
  All547 owned data records have source definitions;115/115 SYM vtables
  mapped. These audit figures still include unresolved carriers/ABI cases
  and are not an original-source or complete SLD proof.
- P869-P871 changes are uncommitted and unpushed. The full goal remains
  active and incomplete; no completion criterion was narrowed to this
  round's successful scalar and parameter restorations.

## P872: native source shapes replace alias/inflator recipes (2026-09-06)

The prior goal turn was verified progress. This round removes more real
source discrepancies; it does not treat declining audit counts as completion.

### Last two owned frontend array carriers restored

- Native563d74 records gMenu_SubMenuPlayer as ENUM tPlayer, four bytes at
  800517c0, initialized to ffffffff. Native5ba0c1 records menuDefs as PTR
  tGlobalMenuDefs, four bytes at80051a58. The pointee is15,128 bytes, not
  the pointer cell. Both definitions and their complete live declaration/use
  graphs now use scalars, across base and regional source copies.
- Scope covered16 base TUs,35 regional copies and18 private extern headers.
  The menuDefsA aliases in base/USA/AU screentracks and A_menuDefs aliases in
  base/USA screenpinkslips were removed: five asm-alias declarations and two
  alias macros, with ordinary menuDefs references replacing them.
- An important mixed-declaration interaction surfaced: after scalarizing
  menuDefs, GoToDealer and GoToSeller initially failed14 at26/26. Merely
  removing old inflators did not fix them. Native64b0d0 also identifies
  screenCarSelect as a scalar pointer, while its shared extern is still an
  array view. Reading that scalar with
  `(*(tScreenCarSelect **)&screenCarSelect)->SetState(...)` resolves the
  interaction without another named carrier or new asm.
- Both MenuExtended_GoToDealer and MenuExtended_GoToSeller now have the
  original five statements: command type, next menu, SetState, Decrement,
  Increment. Each has only native command REGPARM a2 and zero locals,
  frame24/mask80010000/offset-4. **PASS26/exact-g** each; all26 instruction
  SLD tags match by a single constant source-line offset, including prologue
  and epilogue. Removed ten source carriers and four absorption inflators.
- The complete screenCarSelect extern graph is still a genuine next task;
  the scalar-equivalent read is not presented as completion of that graph.
  Native-source restoration must not stop at the owned-global audit's zero.
- Evidence artifact `p872_frontend_scalar_receipts_20260906.json` records
  all51 pre/post object comparisons, exact candidate/region/function gates,
  scope, native records, failures and final receipts. Parent parsed it and
  independently re-gated all16 base TUs: **459/459 PASS**, branch divergence0.
  All16 raw base object hashes, and all51 code/data/relocation and decoded
  non-file symbol payloads, match their pre-change baselines.
- Selected regional matrix: **433/439 PASS**. The six unchanged misses are
  DrawForeground__14tScreenMemcard, two diffs in each region. This is a
  different check set from P871's159 checks, not evidence that its18 misses
  were fixed. Non-selected stale regional bodies retain their prior misses.

### AudioEng_Set: only native parameters and locals, no asm

- Restored the complete dop call/store in EACH carType arm. GCC naturally
  tail-merges the common operations, reproducing the original code without
  the merged adjustedEsp result variable. This also restores the actual
  parameter homes instead of forcing copies into differently named locals.
- Removed camera, doppler, azimuth, gasLevel, direction, adjustedEsp and
  shiftedEsp, plus BOTH empty asm statements. P871's vol correction remains.
  The function now contains only original parameters and locals g/a/s.
- Native1b37ad-1b38c8 homes are reproduced: vol23, gas19, cam21, dop5,
  azi22, dir20; stack ARG records16/20/24/28 remain present alongside their
  register copies. g/a/s are17/18/16, frame56/mask80ff0000/offset-8.
- Parent verified **PASS159/exact-g**, TU9/9 PASS, branch divergence0 and
  the complete unchanged object hash
  `a31bfb39592b9d323c16a6ebbaacc3513cbc8337b626a5561d99015c76d17b56`.
  Raw159/159 oracle words match retail. SLD205 source groups6->1 (proper
  prologue), SLD224 and226 each2->1; no unrelated retail groups were merged.
- All31 nonempty subsets of the previous five argument-alias removals failed
  before restoring the branch-level statement shape. The best diagnostic
  basins were azimuth-only4 and four-alias-removal6 diffs, both count-exact.
  This disproves the interpretation of those earlier per-alias failures as
  evidence that the original source needed the extra names or fences.
- Corrected the unrelated stale file-header description that called this
  bworld.obj: the TU is audioeng.obj and contains nine engine-audio functions.

### Collision loop: native locals, scope and actual crash field

- Collide_CheckForCollisionBetween at80091374 now uses p/normal at function
  scope and count in the native nested block. Removed normalPtr and
  speedThresh by restoring
  `while (Collide_TestObjectVertices(...) && count > 0)`, a separate count
  decrement and shared final return. The matched NFS2 PC beta function in
  `C:\Temp\nfs2-clean\pc-beta\match\collide` independently supports that
  loop shape; NFS4-specific collision and damage behavior was preserved.
- Native21e074-21e193 and emitted debug entries agree: o0/o1=s1/s2,
  p AUTO-56,size12, normal AUTO-40,size12, nested count INT/s0,
  frame72/mask801f0000/offset-4. **PASS88/exact-g**, TU14/14 PASS and
  zero branch divergences, including after the parent's field correction.
- Parent traced both damage guards to raw offset0x3ec. Native Car_tObj MOS
  records identify this as crash (e.g.02acf1), not a collision member of a
  second BO_tNewtonObj. Replaced the two misleading
  `o[1].collision.lastCollision` accesses with `((Car_tObj *)o)->crash`.
  No offset/value changed; the field identity now reflects the actual car.
- Full instruction-to-SLD grouping is preserved, including loop1389 and
  damage checks1402/1407. Four callee identities map to native VAs90144,
  8e5d4, aa7b0 and9ef2c. Raw88/88 words match retail.
- Restored probes: direct removal in while(true)96 diffs at86/88,
  normalPtr-only89 at89/88, threshold-only19 at85/88, postdecrement-condition
  rewrite104 at94/88. Source shape, not an alleged allocator floor, resolved
  the recorded object budget.

### AIPerson: literal/array identity and public source names

- Startup's five format arguments now use the actual strings from raw
  80055354/64/74/84/94: `%sprsonal.bin`, `%sscripts.bin`, `%sbtcglue.bin`,
  `%shhglue.bin`, `%sglue.bin`. The unusual prsonal spelling is retail,
  not corrected by guesswork. Removed their five synthetic D_ externs.
- Both former D_80116470 reads now use Paths_Paths[2], and the duplicate
  address-only extern is removed. Parent inspected actual LO16 addends:
  the last two path reads carry +8; literal addends are0/16/32/48/64.
  All **75 emitted .rodata bytes** match retail80055354..8005539e, including
  the inter-string alignment bytes. Trailing bytes/full linked layout are
  not included in that claim.
- SetPersonality now accesses GameSetup_gPersonalityNames[personalityIndex]
  directly instead of pointer arithmetic from row0. Native2874e4 proves
  CHAR[15][8],120 bytes; its private extern now records both dimensions.
  Startup **PASS105/exact-g**, SetPersonality **PASS50/exact-g**; TU8/8
  PASS and branch divergence0. Split m2c/raw call arguments corroborate them.
- The currently unconsumed public aiperson.h still declared all eight API
  names with embedded GCC-v2 mangling. Corrected those prototypes to the
  same ordinary source names as the implementations; the C++ compiler
  supplies the mangling. Legacy cc1plus syntax-only header check PASS.
  Production include inventory had no users of that stale public header.
- Remaining AIPerson source-model debt is explicit: its private header
  still models GameSetup_gData as int[19], and AIPERSON_PERSONALITY_AT
  reaches the real car-row Personality value through the unrelated
  Car_tObj::angularVel_ch.x offset. Correct field/global reconstruction
  requires reconciling the GameSetup type/owner graph, not hiding it under
  another invented identifier. This round did not claim that model exact.
  Other stale public headers with mangled source prototypes also need
  inventory; definition-only declaration audits do not cover them.

### P872 consolidated gates and remaining state

- Parent fresh checks: frontend459/459 plus game31/31 = **490/490 PASS**
  across19 TUs checked this round, all branch gates clean. These are scoped
  regression counts, not the whole-project matching board.
- Parent independently checked402 raw words for the four game targets;
  frontend receipt corroborates103 additional base words. The AIPerson
  literal/reference checks are separate from normalized instruction PASS.
- Final reports: frontend source-only carriers **486 -> 476**, owned global
  array carriers **2 -> 0**; game carriers **491 -> 482**. Existing clean
  coverage and review counts otherwise remain unchanged (frontend781
  declaration-clean,46 extra,9 type/9 storage/3 mapping; game1228 clean,
  6 extra,28 type/28 storage/0 mapping). Zero global-array-carrier count
  does NOT cover remaining wrong extern views, all aliases, or source names.
- Relink GREEN:757 objects,964 known blob duplicates,0 real duplicates,
  hidden phantoms or relocation-referenced unresolved names. Vtable indexing
  PASS1029 files; source-only policy PASS; diff-check clean. No new asm,
  volatile, invented source names, production tool change or postcompile
  rewrite. Existing unrelated edits and historical snapshots are preserved.
- All P869-P872 work remains uncommitted/unpushed. The full source/SYM/SLD
  goal remains active and incomplete; the next coordinated declaration
  task includes screenCarSelect, alongside the remaining local/type/scope
  and correct-field recovery work.

## P873: scalar extern closure, native fields, and explicit type visibility (2026-09-06)

The prior goal turn was verified progress. This round follows the discrepancies
left outside the owned-global audit, while keeping genuine visibility questions
explicit rather than forcing a misleading green result.

### screenCarSelect: complete declaration/use graph corrected

- Native64b0d0 proves a scalar PTR tScreenCarSelect at8005203c, one four-byte
  cell with a928-byte pointee. The owning definition and most externs were
  already correct; femenudefs_externs.h was the remaining array declaration.
- Corrected that extern and every corresponding use in all seven base/regional
  femenudefs.cpp copies. Dealer/Seller now use ordinary
  `screenCarSelect->SetState`, removing the P872 scalar-punning expressions.
  Both remain **PASS26/exact-g** with their exact native SLD partitions.
- The old GoToGarage ternary became FAIL8 at42/42 after the declaration fix.
  Native SLD1228/1229/1230 distinguishes the condition, then and else; restoring
  explicit if/else assignments gives **PASS42**, including all regional copies.
  Its existing garageIterator inline-scope carrier is not claimed recovered.
- Parent re-gated Femenudefs66/66, Screencarselect59/59 and Front43/43:
  **168/168 PASS**, branch divergence0. All12 graph objects preserve code,
  data, relocation payloads and decoded symbols. All254 selected regional
  checks pass. True same-named embedded members in tAllScreens were untouched.
- Full receipt: `p873_screen_car_select_scalar_receipts_20260906.json`,
  including12 object comparisons,23 regional groups and94 base/48,658 regional
  raw words corroborated. Historical array spellings in comments remain receipts,
  not live declarations or uses.

### AudioEng_Update: remove rampedVolume

- Removed the unrecorded rampedVolume local. Each decreasing volume assignment
  uses `((signed char)current - 2) >? target`; each increasing assignment uses
  `((signed char)current + 2) <? target`, in its original left/right voice arm.
  Working-value-first GNU max/min preserves signed promotion and retail reloads.
  No replacement name or invented macro was introduced.
- **PASS366/exact-g**, AudioEng_Set **PASS159/exact-g** preserved; TU9/9
  PASS, branch divergence0,366/366 raw oracle words exact. The complete object
  remains byte-identical to P872:
  `a31bfb39592b9d323c16a6ebbaacc3513cbc8337b626a5561d99015c76d17b56`.
- SLD source grouping improves at378/381/383 and415/418/420 (the complete
  clamp belongs to one original statement); no new cross-retail-line merges.
  Ternary expansions grew to376/378 instructions, and reversed GNU operand
  order gave56 diffs; those probes were restored. Existing loop-head asm is
  unchanged and remains an original-source recovery issue.

### Collide_DoObjectObjectCollision: original parameter and car flags

- Removed object1 and its preceding obsolete empty asm together. Alias removal
  alone was FAIL5 at992/991; removing the compensating fence as well restores
  **PASS991/exact-g**. Native o1 now emits REGPARM30 rather than parm5 plus an
  invented REG30 local. No other parameter/local was renamed.
- Replaced six fictitious `o[1].simRoadInfo.quadPts[1].y` accesses with the
  actual `((Car_tObj *)o)->carFlags` field. Native2169a8 is INT at+0x260 and
  the raw loads agree. The P872 crash-field corrections remain intact.
- Each Rt0/Rt1 subtraction triple is now one comma expression matching the
  single retail SLD563/564 statement. No unavailable original macro name was
  invented. The fp argument copy now belongs to the proper SLD554 prologue.
- Parent verified target991, whole TU14/14, branch divergence0 and991/991 raw
  words. Removing the remaining post-impulse fence gave FAIL3 at990/991; it was
  restored and explicitly documented. Full asm-free restoration is still open.

### AIPerson: correct canonical GameSetup model, with a visible audit discrepancy

- Native2874b5 defines GameSetup_gData as a2600-byte GameSetup_tData structure.
  Replaced the false int[19] extern with that canonical type, using the exact
  body recorded at27dcf0..27e1c7. Parent compared every emitted member/type/
  offset/dimension and total size against the gmesetup owner's canonical type
  record: exact semantic equality.
- Replaced AIPERSON_RACE_TYPE/WEATHER/PERSONALITY_AT macros with actual fields:
  raceType at0, Weather at0x48, carInfo[carLoop].Personality. carInfo begins at
  0x3d4, has nine180-byte rows, and Personality is at row+0x50; combined0x424
  exactly matches the raw load with0xb4 stride. Aiperson's own record108e21
  independently names Personality. The previous use of the unrelated
  Car_tObj::angularVel_ch.x member was a false identity, not original typing.
- Four additional raw+0x260 accesses in LoadGlue/Startup now use the real
  Cars_gHumanRaceCarList[index]->carFlags member. P872 literals, path-table
  identity, name-array dimensions and public API corrections are preserved.
- Affected LoadGrid19, LoadPersonalityData209, LoadGlue67 and Startup105
  retain PASS and exact debug twins. Entire TU8/8 and branch gates remain
  clean. Parent rebuilt the fresh P872 baseline and the corrected form:
  their complete non-debug objects are identical, SHA256
  `983f08f87ad79f45b2255cbd8ffe1b45b83535a28f5222bd510af2a31af0ed4d`.
- **The per-aiperson type-visibility question is NOT solved.** Its retained
  native block106235..10f834 contains the nested GameSetup records but not the
  outer GameSetup_tData body. The fresh before graph is OK,73/73 named types,
  2/2 anonymous,157/192 typedef records (duplicate-count deficits pre-existing).
  The corrected graph still matches those73 native types but adds the owner-
  proven GameSetup_tData tag and implicit typedef: the tool correctly reports
  DIFF. No exemption, filter or tooling change was added to hide that result.
- Reports `type_graph_aiperson_p873_before_20260906.tsv` and
  `type_graph_aiperson_p873_final_20260906.tsv` preserve the distinction. A
  separate independent read-only review confirmed that restoring the actual
  global/field identities is the more faithful model; absence of the outer
  tag in this object's debug graph does not prove why the original compiler
  omitted it. Original header/accessor/debug visibility must still be
  investigated. Do not claim per-TU SYM exactness from code PASS, and do not
  restore false types solely to turn the audit green.

### P873 final gates and remaining scope

- Parent's six-TU regression set: frontend168 plus game31 = **199/199 PASS**,
  zero branch divergences. Its six game-target raw checks corroborate1,757
  words. Regional254/254 is this round's screenCarSelect matrix, not a claim
  that P871/P872's differently scoped regional misses were fixed.
- Frontend strict declaration metrics remain476 local carriers and0 owned
  global array carriers; game local carriers **482 -> 480**. Other declaration
  review counts remain unchanged. These reports do not subsume the explicit
  additional GameSetup per-owner type-visibility DIFF above.
- Relink GREEN:757 objects,964 existing blob duplicates,0 real duplicates,
  hidden phantoms or relocation-referenced unresolved names. Vtable indexing
  PASS1029 files; source-only policy PASS; diff-check clean. No invented names,
  new asm/volatile, build-tool changes or postcompile rewrite. One old asm
  fence was removed; remaining fences have not been excused as original source.
- P869-P873 changes remain uncommitted/unpushed. The full source/SYM/SLD goal
  remains active and incomplete, including true external declarations,
  field identities, source-local budgets, remaining asm and original scopes.

## P874: callback/local scopes and verified public-prototype repair (2026-09-06)

The previous goal turn was verified progress. This round also examines public
declarations that definition-only audits and the current build never exercised.

### Four menu callback carriers removed with full SLD alignment

- Removed menuDefsBase from MenuExtended_GoToUpgrades (8002c960),
  GoToShowroom (8002d278), GoToDealerShowroom (8002d2b8), and
  TransitionFromPostGameToMainMenu (8002c494).
- The first three now use ordinary type/nextMenu/SetState statements;
  the final callback assigns nextMenu before type, matching SLD296/297.
  Native records contain only command REGPARM a0 (PTR tMenuCommand,size8),
  no caller locals. The corrected scalar global declarations make the old
  direct-use failure receipts obsolete for these functions.
- Parent verified **PASS16/16/16/7**, all exact debug twins. All55 retained
  instructions match native SLD grouping by one constant source-line offset
  per function, including prologues/delay slots/epilogues. No line directives.
- Owning TU66/66 PASS, zero branch divergences, and complete object hash
  unchanged: `e5f8a1f116f2e9aeecfbf0d2d96c5e4e6a6164caea5ef588aec3690449580fd0`.
  The direct YesNoDialog-object probe in AskTheUserToSaveTheGame remained
  FAIL6 at30/30 (sp-based stores instead of the retained s0 receiver) and
  was fully restored. No original inline receiver spelling was invented.
- Detailed receipt: `p874_femenudefs_callbacks_receipts_20260906.md`.

### Collide_ClearCollisionRegistry: correct declaration scopes

- Native21e256/21e25f places i in the first for scope;21e277/21e280 places
  slice in its nested body. Replaced the flattened function-scope declarations
  with `for (int i=...)` and a distinct nested body containing slice.
- Generated block boundaries now follow retail: loop test8009151c, slice
  block80091530..80091664, i scope end80091690. An extra enclosing-brace
  probe produced surplus entry blocks and was replaced, not retained.
- Parent verified **PASS128/exact-g**, TU14/14 PASS and branch divergence0;
  raw128/128 words corroborated. Corrected the stale TU comment count13->14.
- The later n carrier remains. Direct-bound/native-scope for probes gave
  FAIL10 at132/128; postincrement-condition for11 at131; do/postincrement4
  at128; do/prefix7 at129. All were restored. No carrier-count credit is
  claimed for the scope restoration; the original empty-loop form is open.

### AudioEng_StartUp: bounded probes restored

- Investigated its two chanbase locals using46 source-shape/scope variants,
  separately and together. Best first-base removal was FAIL11 at375/376:
  the compiler folded the g+284 base into the inner index instead of hoisting
  g->chan. Second-only removal91 at375; both100 at374. These identify the
  specific invariant/strength-reduction question, not an impossibility.
- Every probe restored; final **PASS376/exact-g**, TU9/9 and branch0,
  raw376/376 words exact. Complete object remains
  `a31bfb39592b9d323c16a6ebbaacc3513cbc8337b626a5561d99015c76d17b56`.
  P872/P873 Set/Update and all previous improvements are preserved.

### Twenty-three public prototypes now name the actual source functions

- audioeng.h and collide.h still spelled nine/fourteen C++ prototypes with
  encoded GCC-v2 suffixes. Their implementations use ordinary source names.
  Parent verified each native EXT FCN record, source definition and return
  type before removing the suffixes. Argument types/order/names were unchanged.
- No literal production include of either stale public header was found in
  recon or regiondiff/recon. Thus the existing object/relink gates had not
  tested these API declarations; an unused bad declaration is still a source
  restoration problem.
- Independent legacy-compiler probes took addresses of all23 functions.
  Isolated copies of the original headers produced **23/23 double-mangled
  references absent from the native symbol map**, for example
  `AudioEng_CleanUp__Fv__Fv`. Corrected headers produce **23/23 exact native
  symbols**, including complete pointer/reference/type encodings. The probes
  use the real cc1plus and do not execute or link any test code into the game.
- Only source declaration spelling and explanatory comments changed. These
  are verified public API corrections, not renames of native binary symbols
  or assembler oracles. Existing C-linkage bridges must be treated separately.

### Systematic public-header remaining-work inventory

- New read-only `p874_public_header_inventory.py` creates
  `public_header_prototype_queue_p874_20260906.md`. It finds1130 candidates
  across79 headers with paired C++ sources:1060 have a native EXT linkage
  record and a same-name implementation candidate;59 require C-linkage
  review;11 have weaker/ambiguous evidence.
- These are candidates for verification and repair, NOT final exceptions
  or a claim that every row is wrong. The scan does not establish complete
  signatures, namespace/member scope, export visibility, overloads, macro
  expansion or transitive includes. It deliberately omits multi-line and
  member/operator forms, which still need review. Literal include counts
  are search hints, not a dependency proof.
- The next systematic pass must compile typed references, reconcile native
  return/parameter records and actual definitions, and preserve genuine ABI
  bridges. Do not blindly strip mangling or leave evidence-backed candidates
  indefinitely as documentation. Aiperson's8 earlier corrections and these
  23 completed prototypes are excluded from the remaining queue.

### P874 final validation and outstanding work

- Parent regression set: **89/89 PASS** across Femenudefs66, AudioEng9,
  Collide14; branch gates all0. Relink GREEN:757 objects,964 pre-existing
  blob duplicates,0 real duplicates/hidden phantoms/relocation-referenced
  unresolved names. Vtable indexing PASS1029 files; source-only policy and
  diff-check PASS. No new asm, volatile, invented names or postcompile rewrite.
- Frontend source-only carriers **476 -> 472**; game remains480. Other
  declaration review metrics are unchanged. Scope corrections and public
  prototype recovery are real progress outside those carrier counts.
- P873's canonical GameSetup model and its explicit additional per-aiperson
  type-visibility DIFF remain unchanged and unresolved. Remaining asm,
  unknown original inline/macro forms, wrong extern views and public-header
  declarations are still part of the full goal; no completion claim is made.
- P869-P874 retained work remains uncommitted/unpushed. Unrelated edits,
  regional bodies and historical scratch snapshots were preserved.

## P875: public-header source names and native API contracts restored (2026-09-06)

### The recorded 1,130-row queue is resolved, not exempted

Reviewed every P874 candidate against native function records, actual definitions,
compiler-generated linkage and defining-object visibility. Across 79 public
headers, **1,119 EXT prototypes now use original source names/signatures** and
**11 native STAT declarations were removed from public interfaces**. Their
file-private implementations remain unchanged. No native binary symbol, oracle
label or implementation was renamed by this pass.

| Disjoint batch | Headers | Corrected EXT | Removed STAT | Other false non-member declarations removed | Paired function gates |
| --- | ---: | ---: | ---: | ---: | --- |
| AI | 13 | 197 | 4 | 49 | 274/274 PASS |
| Audio/math/path common | 9 | 115 | 0 | 0 | 114/115 PASS |
| Remaining common | 17 | 249 | 2 | 64 | 320/320 PASS |
| Root common | 15 | 174 | 3 | 9 | 205/206 PASS |
| PSX | 25 | 384 | 2 | 0 | 384/386 PASS |
| Total | 79 | 1119 | 11 | 122 | 1297/1301 PASS |

The 122 separately removed declarations were erroneous non-member forms of
existing constructors/destructors/methods. The real class APIs remain in their
included types. Typed member pointers and ordinary constructor/destructor calls
emit all 122 expected native references; the corresponding real exports exist.
Legitimate explicit-C ABI bridges were distinguished and preserved, not stripped
by a blanket name rule. No new semantic identifier was invented.

### Name correctness alone was insufficient

Typed reference probes exposed additional argument, callback and return drift.
For example, Replay_RetreivingControllerData returns a 128-byte tControllerData
aggregate, not void; return type is not encoded in the free-function linkage
name, so an nm-only comparison would have missed it. Other repairs restore native
Car_tObj/coorddef/animation/schedule/scene pointers, enum and bool parameters,
const/reference qualification, variadic Debug, and actual callback/array arity.
Font_Blit's seventh int and Font_SetBlitter's seven-argument callback are restored.
Each batch retains per-record evidence; source spelling follows SYM, including
original misspellings, rather than inventing prettier names.

All 79 final whole headers compile. The before state had 69 compiling headers
and 10 genuine whole-header failures: four AI headers, object/track, and
anim/mpause/pausemenu/bworldsm. Failed original headers are not counted as
successful old-symbol probes. AI's separate collision-filtered diagnostics are
explicitly identified as such. Every corrected public reference (1119/1119)
emits the exact expected native symbol and targets a GLOBAL defining symbol;
all 11 excluded private functions retain LOCAL visibility.

### Parent validation and honest residuals

- A fresh parent source-only run over all 79 owners confirms **1297/1301 PASS**.
  Four existing misses remain unchanged: AudioClc_SoundPlayersCar (4 differences),
  Replay_StoringControllerData (188), Night_CreateNightTableElement (56), and
  Weather_Init (12). These are scoped totals, not a whole-project board update.
- Branch checks retain exactly three existing residual functions:
  AudioClc_SoundPlayersCar (instruction51,14 vs12),
  AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji
  (instruction48,14 vs13), and Replay_StoringControllerData
  (instruction1,219 vs223). No new branch mismatch was found.
- The 41 root/common defining objects have fresh pre-header-edit/post-edit
  whole-object hash identity receipts. AI/PSX additionally have fresh owner
  gates and actual-export checks; their implementation/include graphs were
  unchanged. Searches found no production consumers of these formerly malformed
  public headers. A zero literal include count alone is not proof of arbitrary
  historical or macro-driven include structure.
- The parent accepted-object/rebuild check initially found78/79 exact whole
  hashes. The diagnostic had invoked AIWORLD.cpp with filesystem-uppercase
  spelling instead of the established aiworld.cpp spelling embedded in the
  object. Recompiling the unchanged source with that established spelling
  restored the exact accepted SHA256
  a6a9b6c58170fef79f5ba2bded119d90b1807e9c5e2c55ec19a2faed7706bd5a.
  The diagnostic preserves the initial result and uses the established spelling
  for its separate final recheck; no compiler output is normalized or rewritten.
  Final recheck completed successfully: **79/79 whole accepted objects reproduce
  exactly**, still1297/1301 PASS. Full output and hashes are retained in
  p875_public_header_final_recheck_20260906.json.
- Relink remains GREEN:757 objects,964 pre-existing blob duplicates,0 real
  duplicates,0 hidden phantoms,0 relocation-referenced unresolved symbols.
  Vtable indexing PASS1029 files; source-only policy and normal diff-check PASS.
  No CPP/private-header/production-tool/asm/volatile edit belongs to this round.

### Evidence and the remaining source-restoration work

- New snapshot: public_header_prototype_queue_p875_20260906.md reports **0
  candidates** using the same deliberately limited scan as P874. Historical
  public_header_prototype_queue_p874_20260906.md is preserved. The diagnostic
  inventory gained an output/phase parameter solely to avoid overwriting it.
- Parent validator: p875_public_header_final_validation.py and its initial
  p875_public_header_final_validation_20260906.json plus final recheck report.
  These compare the accepted working objects, not old Git HEAD.
- Root receipt: p875_root_public_header_receipts_20260906.md, frozen original
  p875_root_header_snapshots.json, native plan, object hashes and independent
  p875_root_independent_review_20260906.md. Independent 9-member proof lives in
  p875_root_members/README.md and receipt.json. Review corrected a mistaken
  intermediate manual sum235/236 to the actual205/206 and fixed historical-mode
  probes to read frozen originals instead of the now-repaired headers.
- Other batch receipts: p875_common_public_header_receipts_20260906.md,
  p875_common2_public_header_receipts_20260906.md, p875_psx/README.md plus per-header
  JSON/MD, and ../p875_ai_headers/README.md plus receipts.json.
- Zero inventory rows does NOT prove all headers or source are restored.
  Multiline/member/operator forms, ABI bridges, historical include/macro layout,
  and existing local/SLD carriers remain in scope. Specifically,27 ABI-spelled
  declarations in aihigh.h/aistate.h, pre-existing Newton linkage labels,
  the nonblocking ObjectAnim bridge, and the shared monolithic fontblit typedef
  still need their own evidence-backed disposition.
- P873's extra per-aiperson GameSetup type-visibility DIFF remains explicit and
  unresolved. Frontend/game source-only carrier counts remain472/480; this
  header pass does not pretend to reduce those definition-only counts.
- P869-P875 retained changes remain uncommitted/unpushed. No broad staging,
  reset, source-body rewrite or unrelated cleanup was performed. The main
  original-source/SYM/SLD goal remains active and incomplete.

## P876: real AI destructor/static-member interfaces (2026-09-06)

The27 ABI-spelled public declarations remaining from P875 are now resolved:
26 false destructor free-function prototypes and one encoded static-member
prototype are removed from aihigh.h/aistate.h. Ordinary C++ class APIs take
their place; no native binary name or implementation was renamed.

This required restoring19 missing native destructor declarations in the shared
nfs4_types.h class surface, not merely deleting the bad public prototypes.
Without those declarations, canonical destructor expressions used implicit
destructors/ancestor calls and exposed only7 distinct destructor exports.
With them, all26 destructor calls plus AIState_Purgatory::StartUp emit the exact
27 native references, each backed by native EXT/STAT records and actual global
function exports. All26 target-compiler class sizes are unchanged.

The static-member case is a separate compiler-lookup defect: the old encoded
StartUp prototype emitted a correct link name but made the ordinary qualified
class expression fail. Removing the duplicate restores the existing class
declaration; an nm-only test would not have caught it. The26 old destructor
prototypes instead emitted nonexistent double-mangled names. Frozen old-header
and old-class-shape fixtures reproduce both failure modes.

The shared-header edit is commented and backed up byte-for-byte in
../p876_ai_bridges/nfs4_types.before.h. A real preprocessor dependency census of
all184 recon C++ sources found36 consumers and0 errors. All36 freshly built
consumer objects remain entirely byte-identical. They are data/no-covered-code
TUs (0/0 gates), not36 newly matched functions. Both strict source-only full
build lanes passed, with no skipped TUs. Fresh aihigh14/14 and aistate52/52
function gates PASS with0 branch differences. Relink/vtable/source-only/diff
checks remain green; no new asm, volatile or post-compiler rewrite was added.

The source-only Replay_ResetReplay pointer investigation tested11 ordinary
loop forms and restored them all. Its final body remains PASS86, and the entire
replay object reproduces the prior hash. The whole TU remains15/16 with only
the pre-existing188-difference StoringControllerData residual. The new named
angle is GCC's late induction-address initialization/address splitting, not an
assertion that the pointer must have existed in original source. No semantic
identifier was invented and no carrier-removal credit is claimed.

Detailed receipts, native record identities, original/candidate/final probes,
36 before/after object hashes and replay experiments are in
../p876_ai_bridges/README.md and api_receipts.json. Fresh strict declaration
reports remain game1228 clean/480 carriers and frontend781 clean/472 carriers;
public API restoration is outside those definition-only counts. Existing
ABI-body/vague-linkage ownership findings, GameSetup visibility discrepancy,
other public declarations, local names and SLD statement ownership remain open.
No overall SYM/source-exactness claim, commit or push is made.

## P877: whole-TU C++ identity and CopSpeak source reduction (2026-09-06)

### Retire the two C++ function-compiler splices

Both former users of PER_FN_CC1PLUS_VER_SPLICE are now compiled once per TU
with the hash-verified retail PsyQ2.8.1 SN C++ compiler. Replay retainsG4;
Night retains its independently provenG8. The C++ function-splice table is
empty; its compatibility helper remains for existing diagnostic callers.

Source-only Replay improves15/16 to16/16 PASS and Night18/19 to19/19 PASS.
StoringControllerData's188 differences and CreateNightTableElement's56
differences disappear without any source-body rewrite or output splice.
Both entire new production objects equal the freshly compiled old normal
mixed-compiler objects exactly, including all data, relocations and metadata:

- Replay: ef13e273eff6b799c58a324040fc37b3cce9c3940f74c5bd66d516db072fbf39.
- Night: b818c9cff41a8dfb429466fc1dd62719ef38541900ddc888cc77618651071dab.

This is35/35 source-only PASS and removal of two compiler-output splices,
not an increase to a normal board which already counted those two as PASS.
Branches are0 for both TUs; both changed compiler cases have exact-g twins
(243 and113 instructions). All35 native function identities and3252 raw
oracle words were verified against rom/nfs4-f.exe. Existing source references
are preserved by whole-object identity; unrelated alias/type debt is not closed.

tools/build.py now selects a cc1plus_ver before code generation through
cpp_compiler(src); tools/diffsrc.py uses the same selector for debug twins.
Other182 C++ source selections and all unrelated per-TU flags are unchanged.
Tests cover missing-compiler failure, the existing hash-matching CI zip slot,
and one actual compiler call per selected TU. Commented tool edits have backups
in ../p877_replay. Both strict source-only full-build lanes passed without
skipped TUs. No instruction normalization or verifier acceptance rule changed.

### CopSpeak_PlayNextRequest: remove iVar3, keep qualifications visible

The initial queue index and wrapped output now form one chain through the
already recovered same-object `next`. The first capture/index is one expression;
the final conditional result and global store are one assignment chain. An
in-place if/else variant measured8 differences and was reverted; the conditional
expression preserves PASS71. The target's native rREG16 and handleREG5
declarations/homes remain exact and their declaration order is restored.

The full CopSpeak TU remains27/27 PASS with0 branch differences. Its entire
real-path object is unchanged from the independently recorded P875 baseline:
70fc97ebe71e9feeb970a4af6af67f16969a2171d4a82bfc1a35834376f9807e.
All71 oracle words were checked against the raw image. No newly invented
name, asm, volatile, shared header or build intervention belongs to this edit.

The target SYM still does not record next. Its existing debug record changes
REG3 toREG4 as the lifetime extends over the value chain; that home is not
claimed as native truth. Initial SLD1192 groups improve2 to1, and tail1237
groups4 to2, but remaining1221/1222/1237 grouping is still open. An exact-g
code twin is not proof of native-only locals or full SLD exactness. The first
open-item table above now reflects this rather than calling iVar3 required.

### Rejected replay pointer alternatives and remaining work

Replay_ResetReplay's piVar2 remains unchanged. Default indexed source still
has one late +4 instruction under both retail compilers. Four pre-anchors
converge to the same residual; four byte/integer-address forms regress to10
differences, and the plain array-address cast is neutral. No such source was
retained. Whole-TU no-split, force-addr and disabled post-loop CSE configurations
lose existing matches and were rejected. GCC loop/expmed/expr source identifies
late GIV construction through a nonconstant RTL_EXPR as the next tracing
question, not proof that a source pointer existed or an impossible compiler floor.

Game/common source-only carriers decrease480 to479; other declaration-review
counts remain explicit. The full goal still includes target-specific recovered
names, extra locals, inline/ABI ownership, data views and SLD statement/scope
restoration. Detailed evidence: ../p877_replay/README.md, ../p877_night/
WHOLE_TU_RECEIPT_20260906.md and ../p877_copspeak/README.md, with frozen probes
and JSON receipts. No commit or push; the full goal remains active.

## P878: source shapes, scopes and final flag-splice retirement (2026-09-06)

- Weather_Init now consistently uses the genuine initialized
  Weather_gTrackSpec->type pointer for all three type reads. No local or
  alias was added. Normal and source-only Weather25/25 PASS, branch0,
  Init211/exact-g; the full new object equals the old mixed-flag result.
  The obsolete PER_FN_FORCE_ADDR entry is removed and its table is empty.
- Whole-TU AudioClc -fno-thread-jumps at the existing2.8.0/G4 identity gives
  18/18 PASS, branch0 and SoundPlayersCar461/exact-g. The complete object
  is byte-identical to the old two-compile per-function-splice result. Its
  PER_FN_NO_THREAD_JUMPS entry is retired; debug twins use the same TU flag.
  Old sibling-regression receipts no longer described the restored source.
  This is a consistent object-wide configuration, not a claim that a lost
  original command line has been uniquely recovered.
- MenuExtended_GoToTournTrackInfo and GoToSpecialEventTrackInfo each lose
  their menus alias. The repaired scalar menuDefs interface now permits
  ordinary final command stores at PASS90/91 with exact code twins. The
  whole Femenudefs TU remains66/66/branch0 and its complete object is unchanged.
  Existing manager/frontEnd/selectedTourney webs and fences are not hidden.
- CopSpeak_Flush moves native int i/REG3 into its recorded loop scope
  (26bcc8/26bcd1/26bcda), preserving PASS20 and the full27/27 object. Its
  request pointer still needs restoration; nine failed removal probes were
  reverted. The remaining diagnostic distinction is plain-char li255 versus
  signed access li-1 with different object/member-base anchoring, not a floor.

The final P875-cohort sweep reaches1301/1301 normalized PASS across79 owners.
One inherited AudioTrk_AddCustomObject branch-distance discrepancy remains
explicit. Both strict full-build lanes pass; targeted new branch checks are0.
The AIWORLD object hash variation is exactly7 source-filename-case bytes in
.strtab; same-input recompilation reproduces the full accepted hash, with no
code/data/relocation difference. No instruction rewrite was used to clear it.

Frontend source-only carriers decrease472 to470; game remains479. Other
declaration-review findings, original inline/parameter ownership and the main
SYM/SLD restoration goal remain open. In the two tournament callbacks,
the nested native amount record also warrants ownership/scope review rather
than treating name presence alone as caller-local proof.

Detailed receipts and protected-tool backups: ../p878_checkpoint/README.md,
../p878_weather/P878_WEATHER_RECEIPT_20260906.md, ../p878_audioclc/README.md,
and ../p878_copspeak/README.md. The user authorized commit and push of the
verified P869-P878 checkpoint to origin/main, excluding unrelated edits and
generated build files. Git publication is performed only after final checks.
