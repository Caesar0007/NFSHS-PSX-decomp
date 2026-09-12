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

## P879: source names, native scope placement and a raw branch repair (2026-09-06)

P869-P878 was published as 88bad579. The following P879 work is not part of
that commit and remains uncommitted. The original-source/SYM/SLD goal is still
active; none of the partial results below certifies the entire project exact.

### Frontend: nine extra declarations removed, two real locals relocated

The repaired scalar menuDefs interface now permits removal of both
menuDefinitions declarations in GoToTwoPlayerSingleRace, player/defs in
EnterUserName, defs in both FinishedPlayer name callbacks, and menuDefsBase
in AwardPinkSlipsCar and ExitPinkSlipsEarly. Direct username arguments also
remove the volatile byte read while retaining both native LBU instructions.

GoToTwoPlayerSingleRace additionally uses the existing SetString/SetChoices
member operations and ordinary Run call, removing its dialog caller alias.
The separate member statements preserve native SLD 225/229 grouping; a
byte-identical chained expression does not and was rejected. No new helper
name was introduced, and the existing inferred private spellings remain
unproven. carSelectScreen, nextMenu and screenState are still open. Eight
further direct-source/fence-removal basins were tested and not retained.

The tournament and special-event callbacks now declare amount only in the
post-sound debit block. The early fee guards use tourn->fEntranceFee directly.
Success-first if/else restores native LONG REG3 and the zero-width debug scope
at cancellation PCs 8002D028/8002D194. The fee is still read on the successful
path after AudioCmn_PlayFESFX, not during cancellation. A remaining inner
inline-body shell/name, separate debit statement notes, and the existing
selectedTourney/tourn register mismatch are explicitly unresolved. This is
scope recovery, not a claim that name presence alone makes the source exact.

All eight touched callbacks PASS at 69/25/68/40/138/76/90/91 instructions,
with exact-g code twins; Femenudefs remains 66/66 and branch-clean. Its entire
normal object still equals published P878, including every relocation and
data byte (e5f8a1f116f2e9aeecfbf0d2d96c5e4e6a6164caea5ef588aec3690449580fd0).
All 597 oracle comment words were checked against the raw EXE; independent
ordinary links additionally prove all 100 username and 724 tournament bytes.
The pre-existing whole-debug-TU constructor discrepancy remains 3205/3207;
exact-g target checks must not be reported as a 66/66 debug-lane result.

### CopSpeak: signed field semantics remove the remaining Flush pointer

CopSpeak_tRequest.bank is signed char at byte +30 in both existing type homes.
CopSpeak_Flush now writes CopSpeak_gQueue[i].bank directly, removing request
and its per-use signed pointer cast. Native loop-scoped int i is preserved.
Native CHAR encodes plain and signed char identically in this compiler's
debug output; signed loads/negative sentinel use and source-only A/B establish
the access contract, not an exact recovered keyword or compiler command line.
The other three byte fields and all offsets/size remain unchanged. A whole-TU
signed-char flag regressed eight neighbors and was not used.

Fresh actual-preprocessor dependency census found 47 consumers among 698
C/C++ sources: 40 base and seven regional. All 40 base objects are entirely
byte-identical before/after, including 119/119 covered functions and 36
data/no-covered-function TUs. Five buildable regional consumers preserve all
code/data/symbol/relocation fingerprints and 21/21 selected oracle matches.
Two regional nfs3 copies have the same pre-existing obsolete-Speech-alias
compile failures before and after; their repair is investigated separately,
not silently counted as verified shared-header consumers. The complete
CopSpeak object remains 70fc97ebe71e9feeb970a4af6af67f16969a2171d4a82bfc1a35834376f9807e,
27/27 PASS and branch-clean. Protected headers have pre-edit backups.

### AudioTrk: resolve the real branch-target mismatch without output rewrites

AudioTrk_AddCustomObject now tests the type interval with two byte comparisons,
type >= 4 and type < 36, instead of unsigned subtraction and a range bound.
No new name, local, asm, volatile, compiler flag or post-compiler action is
used. The source statement remains the native type-range test at SLD 279.

Stock compiler RTL proves why it works: the earlier spelling yields an SI
zero-extend load identical to the earlier type-test pattern. During delayed
branch scheduling, redundant_insn finds that earlier load and redirects the
type-3 edge past retail's reload. The two bounds keep a QI-mode load that emits
the very same LBU but is not RTL-identical, so the native edge survives.
Instrumented compiler/GDB traces corroborate the mechanism; only stock PsyQ
results are used as byte authority. Its unsigned-char flag is necessary to
make the instrumented compiler reproduce stock defaults, not a production flag.

Root rebuilt the landed production source and independently linked it at
native addresses: all 1,004 text words plus 13 rodata bytes and four sdata
bytes match rom/nfs4-f.exe. The former 8007CBBC jump to 8007CBF4 now correctly
targets 8007CBF0. All six functions PASS, no branch differences, target 413
exact-g. The old 1,003/1,004 result is superseded, not a verifier false positive.
The suspicious null-base c->handle access remains because raw retail proves
it; no intent-based behavioral repair was made.

### Strict audit state and evidence

Frontend carriers 470 -> 462; game/common 479 -> 478. Other review counts
remain visible: frontend 781 declaration-clean, 46 extra locals, nine type,
nine storage and three mapping findings; game 1228 declaration-clean, six
extra locals, 28 type and 28 storage findings. Both have zero missing names
in these definition audits. These are scoped declaration reports, not proof
that every raw SYM record or SLD statement in the entire project is restored.

Primary receipts: ../p879_femenudefs/README.md and receipts.json,
../p879_username/RECEIPT_20260906.md, ../p879_amount/RECEIPT_20260906.md,
../p879_audiotrk/reorg_receipts.json and production_receipts.json, and the
../p879_copspeak before/after consumer records. Full-build, relink and source
policy results belong in ../p879_checkpoint/validation_receipts.json; a
partially written runner log is not proof that the whole sequence finished.

### Follow-up: repair the two pre-existing regional startup copies

The AU and USA nfs3 copies now use the already-restored shared Speech_fgUndefined
name and ordinary new Speaker expression, matching the base source. This
removes their obsolete undeclared flattened aliases and one unrecorded p
carrier per copy without adding any helper, name or header declaration.
The constructor still installs the vtable and clears fSub before publication.

Both production TUs compile again. AU LoadingIcon73/main237 and USA LoadPerps172,
all three owned manifest rows, retain REGION-PASS. Each 25-word startup was
also checked against its own regional raw EXE, including every relocation's
opcode/register bits and resolved target; the function has no standalone
manifest row. Whole text/data/relocations equal a compatibility-only legacy
control, not a fictitious object built from the initially broken source.

AU's separate copied LoadPerps remains a pre-existing 12-difference 168/172
body; it is not changed or counted as PASS. USA has no separate regional
LoadingIcon/main oracles. These coverage limitations remain explicit.
See ../p879_nfs3_regions/README.md, receipts.json and production_receipts.json.
This follow-up supersedes the two unresolved compile failures in the earlier
bank-only consumer comparison; the before/after failure receipts are retained.

### Next evidence-backed angle: native tourn's missing copy boundary

The follow-up single-tourn investigation tested 14 ordinary source controls
against the landed amount/Run shape. None is retained. Even removing only
the selectedTourney fence while leaving both declarations makes stock CSE
delete pointer-copy instruction 66 before allocation. Six global pseudos
become five; the initial pointer moves from a1 directly into s2. The closest
90/91-instruction result still has three replacements and a true first-branch
distance of 46 instead of 45, so it is not a safe source cleanup.

Native selector/guard SLD 661/699 and 663/704 identifies an anonymous selector
result versus the named cross-call tourn in REG18. The next question is the
original inline/return-expression boundary, using actual header/sibling
evidence. It is not a QTY handout-priority problem in the tested source and
does not justify a newly invented getter or a disguised fence. The 64 other
normal functions remain unchanged; all P879 production wins are preserved.
Stock CSE/global excerpts and exact negative controls are retained in
../p879_tourn/RECEIPT_20260906.md. No compiler-floor claim is made.

### Final regional closure and regression results

The separate AU LoadPerps mismatch noted above is now repaired: the existing
USA code representative provides the missing trafficDensity <= 0 selection,
as independently confirmed by the AU raw load at field +0x18 and branch. This
changes 12 differences at 168/172 to REGION-PASS 172/172. Raw reference checking
then revealed AU uses fecarsb.car, not the representative's fecars.car. The AU
literal is corrected from its actual bytes, not guessed from a sibling region.

Root's landed-source checks require AU3/3 and USA1/1 with no failing selected
row, both startup 25-word/reference checks, all 172 AU LoadPerps instruction
and relocation fields, and every byte of its 71-byte rodata section exact.
The ten neighboring bodies are preserved modulo necessary local-jump rebasing;
startup bytes and data/sdata are unchanged. Missing USA oracles and unverified
whole-regional-data owner layout remain outside this targeted proof.
pre_loadperps_production_receipts.json retains the earlier explicit failure;
production_receipts.json is the final verified state.

Three complete strict build lanes passed with no failed/skipped TUs (skip-asm,
expected/no-link, then assembly-inclusive build/no-link for the actual src link
input). Both unchanged standing link gates pass: REAL duplicates, hidden
phantoms and relocation-referenced unresolveds are zero. The known recon
blob-class duplicate count remains 964; a green standing gate does not close
that source/data integration backlog. Vtable/source-only policy audits pass.
The fresh 79-owner sweep is 1301/1301 normalized PASS, 79/79 identical accepted
rebuilds, and all 79 branch checks clean. No post-compiler instruction rewrite
or checker relaxation was used. P879 remains uncommitted and the full goal active.

## P880: remove frontend locals and false extern views; expose a real static gap

Eleven additional source-only local declarations are removed without replacing
them with invented semantic names: three dialog aliases in Femenudefs, two
globalMenuDefs declarations plus helpDialog in FEApp, four Initialize/Cleanup
aliases in ScreenMemcard, and Draw's mainScreen in FECredits. They represented
ten audit carrier mappings because one mapping covered two same-name blocks.
Frontend mappings therefore decrease462 to452; game remains478.

Five CPP-local extern array views are also gone: FEApp's ticks_array and
Draw_gDoVSync_arr, ScreenMemcard's A_FEApp, and FECredits' A_ticks/A_screenMain.
Each now uses the existing scalar declarations. Native local ticks is preserved
via ::ticks for global accesses; no source name was invented. Removing these
false storage views unlocks direct expressions that older array-based receipts
had reported as failures. Remaining private foreign CodegenView types and
inferred inline helper spellings are not certified as original source.

All four entire normal objects are byte-identical to their respective accepted
baselines, including data, symbols, relocation addends and branch encodings:
Femenudefs66/66, FEApp16/16, ScreenMemcard15/15 and FECredits7/7, totaling104/104
PASS with zero branch discrepancies. Detailed debug/raw receipts independently
check the changed native locals/scopes and relevant references. Both unchanged
standing relink lanes and vtable/source-only policy checks pass. No shared
header, compiler flag, new asm/volatile or post-compiler rewrite was introduced.

The strict report is intentionally more honest about one existing source gap:
FECredits lasttick is a known function-local STAT INT record, not restored by
the current blob-backed extern view. The SYM-CARRIER exemption is removed.
Missing native declarations therefore changes0 to1 and declaration-clean781
to780, with no compiled-code regression. The raw static name is known and the
actual declaration/data ownership must be restored, not hidden by a mapping.

An additional lexical inventory finds100 remaining extern-array/asm-label sites
across37 reconstructed source/header files. This is one syntax-family review
inventory, not proof all100 are wrong or active, nor exhaustive macro-view
coverage. Native arrays/hardware views require individual adjudication.
It explains why zero global carrier markers did not prove absence of extern
storage-view debt. See ../p880_checkpoint/EXTERN_ARRAY_VIEW_REVIEW.md.

Clock's ordinary parity conditions still miss43 by one instruction. New stock
RTL proves the direct source already has native-like order before delay-slot
scheduling: pointer low completion27, parity ANDI50, generic store43, branch52.
The .dbr pass moves27 into52's slot (sequence148), replacing retail's NOP.
Narrow casts add a wrong byte/halfword reload; whole no-delay/no-split flags
regress all three functions; 2.8.1/no-thread/debug forms do not solve it.
No failing Clock source was retained. The next evidence-backed question is
the original source/assembler scheduling boundary, not an allocator floor.

Primary receipts: ../p880_checkpoint/receipts.json, ../p880_fem_dialogs/
RECEIPT_20260906.md, ../p880_feapp/README.md and views_receipts.json,
../p880_screenmemcard/receipt.json and raw_debug_receipt.json,
../p880_fecredits/receipts.json, and ../p880_clock/README.md. P879's source
receipts remain historical; its object-level wins and regional repairs remain
intact. P880 is uncommitted. The full original-source/SYM/SLD goal stays active.

## P881: native lasttick declaration and single-cell data ownership restored

The missing SetupCurrCredit lasttick is now an actual function-local
`static int lasttick = 0`, matching SYM5f1f9a STAT INT and object data offset4.
The FECredits_lastFadeTick/A_ array view and erroneous public extern are gone.
The initialized owner section contains CREDFADETICKS700 at+0 and lasttick0
at+4, exactly the native eight-byte run80051AA0..80051AA8. A tentative static
also code-PASSes but produces BSS rather than the native data run; it was not
retained. No carrier exemption or invented identifier closes this record.

All seven credits functions remain PASS, branches0 and SetupCurrCredit199
exact-g. Of3240 text bytes, only two unlinked data-addend bytes change0->4;
the references now resolve to the true local static instead of an extern
alias. The live debug record is STAT/INT in the owning function scope.
The rest of SetupCurrCredit's source-only names/inline/SLD debt remains open.

Raw r03 is split into its740-byte prefix, eight-byte oracle-only credits
piece, and1456-byte suffix. No original data byte is removed. Src selects
the three raw pieces; recon uses the typed source section instead of the
raw eight-byte owner. Independent ordinary links prove both2204-byte windows
exact against retail, with one local lasttick at80051AA4 and no raw D_80051AA4
definition in recon. ScreenMain's neighboring tvOrder starts80051AA8 and is
not absorbed into credits. CPE is only the zero overlay reservation here;
native SYM/MAP plus merged nfs4-f.exe establish this initialized content.

Commented protected-tool changes, with backups, add explicit source-data
ownership metadata and fail-closed payload/global/local-offset validation.
Relink and the canonical generator exclude the validated oracle-only input.
The active generator places credits data at80051AA0 and removes it from the
resident catch-all; the otherwise dormant frontend fragment is updated too.
Live-source object selection prevents stale cache/probe copies from returning.
The link command now consumes existing recovered linker-data PROVIDE metadata,
which clears the previously omitted _front_objend/D_8014899C references without
new storage. The generated linker script is regenerated, not hand-patched.

Canonical output shows the exact owner address, one lasttick cell, no raw
duplicate and all four lasttick-reference words equal retail. The broader
generated diagnostic image still has ten small-data relocation truncations;
rc0 under --noinhibit-exec is not a clean final-executable claim. Standing
link gates pass with zero REAL duplicates, phantoms and referenced unresolveds;
the known blob-class duplicate count decreases964 to963.

### Additional native global-view/type corrections

Fecheats loses four A_ array/asm views while retaining the genuine187-element
Stats_gTrackRecords array. Cheat/bonus externs are corrected from unsigned int
to native ULONG, consistent with the existing u_long owner definitions.
Base10/10/branch0 and the entire object remain unchanged; the only additional
actual header consumer, USA, retains4/4 and exact program/data/relocation
identity. Native data shapes and26 changed-reference words were checked.

FETextRender uses native BOOL gSemiTransText directly instead of its int-array
view. Its true textDefinitions[14][6] remains intact. Whole17/17/branch0 and
the entire8080-byte object remain unchanged. Failed pixels-local experiments
were not retained. Across this round six extern views are removed, including
the credits static view; no new asm/volatile or instruction rewrite is added.

### Verification and remaining goal

Three full build lanes complete without failures/skips, both standing link
lanes pass, and source-only/vtable policies pass. Detailed source, data-window,
debug, raw-reference and fail-closed controls are retained in
../p881_lasttick/{source_receipts,storage_receipts,full_validation_receipts}.json
and README.md. The independent ownership analysis is in
../p881_lasttick_ownership/OWNERSHIP_ROUTE_20260906.md; other source receipts
are in ../p881_fecheats and ../p881_fetextrender.

The strict frontend report returns to781 declaration-clean/zero missing names
because lasttick is genuinely restored, not exempted. Carrier mappings remain
452 frontend/478 game; other type/storage/source/SLD reviews remain open.
P881 remains uncommitted. The complete original-source restoration goal is
not achieved by this bounded data-and-declaration closure.

## P882: native source scopes/views and exhaustive GP/data ownership (2026-09-07)

### Source restoration

Fescreen removes three false scalar-array views, preserving the existing
suppression-flag linkage bridge rather than inventing its original class
declaration. FeMenuOptions removes scalar FEApp/menu_kUserNameRows views and
the dst local; genuine NumberOfRows[6] is restored to the first function block
without moving its post-sprintf initializer. FEDialog removes gHelpShapesA[]
and uses the existing scalar pointer while keeping the pointed-to shape table.
All three entire objects are unchanged:27/27,92/92 and32/32 PASS, branches0.
Native NumberOfRows SHORT/dim6/AUTO-40 scope and raw table values are proved.
Frontend carrier mappings decrease452 to451; other review counts remain open.

The FEDialog scalar ticks header experiment is not retained. Its four actual
consumers regress only Help CalculateDimensions by9 differences/one instruction;
passing currentTicks through the existing helper is neutral. All five files
were restored to their pre-ticks state, preserving root's gHelpShapes edit;
base32/32 and all6 selected regional cases/fingerprints are reverified.

### Correct the old overflow count and repair the actual cause

The earlier ten-truncation statement was only the linker's printed error count;
it explicitly omitted additional overflows. An exhaustive frozen baseline
checks2381 GP-relative relocations in78 live TUs:324 true signed-16 overflows,
1696 wrong retail addresses,1372 of which were still in range. All expected
addresses are established, including three FIRST cases using non-retail GP
addressing for a raw absolute slot. Native GP8013C54C is independently derived
from1867 raw/MAP sites; it is not changed to conceal displacement errors.

The canonical generator wrongly treated selecting an object's .data as also
selecting its .sdata. Section-qualified (object,section) accounting fixes the
omission and eliminates all324 overflows, but by itself fixes zero wrong native
addresses. That intermediate result is saved explicitly, not called a native
match. Fragment ownership checks use actual parsed selectors and fail closed.

### Five proven native data-owner transfers

Complete relocation-free payloads and independent native anchors justify
Hudpmx.sdata@8013C84C/0x535, CopSpeak@8013D07C/0x7E, NFS3@8013D270/0x58,
R3DCar@8013D324/0x9C and Sim@8013D40C/0x28. Raw copies are split into separate
oracle-only files; recon selects the typed source sections in their native
fragment slots. The three Hudpmx and two CopSpeak alignment bytes are preserved.
The other five omitted sections remain unpromoted because they lack complete
native placement/payload proof or have genuine packing/value mismatches.

All2692 bytes across checked windows match raw retail in baseline, src and
recon links, with neighboring addresses preserved. Source-owner validation
checks exact sizes/hashes and rejects unexpected data relocations. The P881
credits window and its stricter global/local-static checks remain intact.

Thirty-four existing raw string labels are retained as storage-free PROVIDEs
for the still-raw Hudpmx pointer tables. Each is proved from the excluded raw
object's symbol offset, the native bytes and every actual pointer-table use;
no additional string storage is allocated. Repeated table entries are checked
from their real records, not assumed sequential.

The actual generated link now has234 more native GP targets correct, with
zero formerly correct targets regressing. All2381 remain in range and resolve;
1462 wrong-but-in-range targets remain explicit. Source-owned raw duplicate
inputs are excluded, decreasing known blob duplicates963 to912. REAL duplicate,
phantom and referenced-unresolved standing checks remain zero.

### Remaining integration debt and evidence

The generated diagnostic ELF still has overlapping output sections, including
an oversized .data range over .sdata, and a .sbss PROGBITS warning. Native-owner
checks select the actual owning output section and record those overlaps; they
do not certify a valid flattened final image. FIRST's three non-retail addressing
sites need source/toolchain correction, not just placement. These remain part
of the full original-source/link restoration goal.

Authoritative receipts: ../p882_gprel/BASELINE_RECEIPT_20260906.md,
baseline_complete.json, section_accounting_complete.json, native_owners_complete.json,
OWNERSHIP_LANDING_20260907.md, ownership_window_receipts.json and
production_owner_receipts.json. Full regression commands/results are recorded
by full_validation.py in that directory; only the complete sequence counts.
Source receipts are in ../p882_fescreen, ../p882_femenuoptions,
../p882_fedialog and ../p882_fedialog_ticks. No new names/helpers, asm/volatile,
compiler flags or instruction rewrites were added. P882 remains uncommitted;
the full original-source/SYM/SLD objective remains active.

P882 final regression sequence is complete: all three full builds passed
without failed/skipped TUs, both data-lane window checks and actual native-owner
placement/reference checks passed, and the exhaustive final2381-site GP audit
confirms zero overflows/unresolveds/encoding discrepancies,234 newly correct
retail targets and zero regressed targets. The remaining1462 wrong addresses
are not waived. Standing link,151/151 frontend, vtable and source-only policy
checks pass. These complete results are in p882_gprel/full_validation_receipts.json
and final_complete.json; no commit or push has occurred.

## P883 / 2026-09-07: native data slots and verified publication checkpoint

The user has now explicitly approved committing and pushing the verified
P879-P883 checkpoint to origin/main. Earlier uncommitted statements above
describe their historical round state, not the current publication authority.

Front.cpp's MEMCARDFRONTENDISINITTED_words array alias is removed. Native
SYM2c74e8 EXT BOOL already agrees with the public/owning bool declarations;
ordinary false/false/true stores preserve all43 functions, branches and the
entire39004-byte object. Both affected debug twins and all69 raw words match.
No original name was invented, and no new asm or volatile was introduced.

CTYPE0's canonical mutable129-byte table is selected from its real .data,
not the stale .rodata selector. Native _ctype_=801371D0, the three alignment
zeros and unchanged twelve-byte gap are proved. The typed asintbl section
resumes at80137260; the native ordered main .data run again ends8013C54C.
All1632 seam bytes match in three isolated links. Only CTYPE's raw copy is
split into its own oracle-only file; the remainder of r18 is preserved.

FETextRender's existing88-byte data becomes source-owned at800515B8:
textDefinitions CHAR[14][6], followed by gSemiTransText BOOL at8005160C.
The source/object/raw payloads agree exactly and have zero data relocations.
The inactive historical frontend fragment is not confused with actual link
selection; this owner receives explicit output section source_data_7.

There are now eight validated source-owned windows. Each source section is
selected once at its native address, and its raw copy is kept in src but
excluded from recon. Hud's34 storage-free aliases and every actual raw-table
reference remain exact. Known raw/source duplicates fall912->909; REAL
duplicates, hidden phantoms and relocation-referenced unresolveds remain zero.

The broad diagnostic link is NOT final-image exact. Its .data still extends
28348 bytes past the native ordered run (88 fewer than P882);119 allocated
output overlap pairs remain. Public asintbl still binds to its pre-existing
raw duplicate at8015BEB4, not the correctly placed typed section. This is
explicit separate ownership/reference work, not solved by the CTYPE fix.
All2381 GP relocations resolve/in-range/encode correctly;234 native targets
are restored versus the frozen baseline, none regress, and1462 wrong-but-
in-range targets remain open. The sbss section-type warning also remains.

Final checkpoint verification completed: all three full builds without
failed/skipped TUs; all518 live source objects reproducible byte-for-byte;
358/358 across all12 changed base TUs with branches0; AU3/3 and USA1/1,
AudioTrk1004 raw words, credits local-static references, both data windows,
all eight actual owner placements, vtable/source-policy and standing relink
checks pass. The CI-style objdiff report also generated successfully.

P883's first validation attempt exposed a diagnostic lexer bug: slash-star
inside build/src/*(.text) is a filename wildcard, not a comment. The parser
was corrected and all remaining checks rerun. Its subsequent asintbl public-
binding assertion exposed the genuine pre-existing neighbor debt documented
above; the receipt now distinguishes typed placement from legacy binding.
Neither finding was hidden by changing production instructions or by claiming
the overall diagnostic link is clean.

Current reproducible gates and consolidated receipts are in
../p883_data_layout/README.md, verify_production.py,
verify_checkpoint_sources.py, production_receipt.json,
checkpoint_source_receipts.json and full_validation_receipts.json.
Historical baseline-object comparisons are labelled as such; no old binary
cache, generated build output or unrelated scratch work is part of the
published source checkpoint. The full original-source/SYM/SLD goal is active.

## P884 / 2026-09-07: fix table bindings and retire scalar array views

Baseline is published main acbe34775f4e. This round is uncommitted; no renewed
publication request has been inferred from the active goal continuation.

### Four real native table bindings restored

asintbl, sintbl, fatantbl and rcossin_tbl source sections were already at their
native data slots but public symbols still bound to raw orphan copies. Four
raw-only leaves now preserve the src/oracle bytes and labels, while validated
source ownership excludes them from recon. The native public bindings are
80137260,80137464,80137868,80137D20. All18952 initialized table bytes are exact;
the enclosing20496-byte baseline/src/recon window preserves every gap and55
raw labels (54 shared recon labels). D_8013745F stays oracle-only; no recon
reference requires inventing it as a new source global.

All34 table relocation words across six consumer TUs were wrong before the
change and are now raw-exact, with unchanged input objects. Whole function
non-relocation-bit identity proves instruction alignment. Two SDK oracles add
only1/2 trailing zero alignment words after verified jr-ra/delay slots; that
padding is explicitly bounded and reported. No output rewriting was used.
The P883 asintbl public-binding issue is resolved, not merely reclassified.

### Original-source scalar shapes

screenmemcard.cpp loses19 asm-linked array views (17 native INT layout values,
ticks and the BOOL state flag), their macros and the unrecorded extraY local.
The real fMemIcon pointer-to-array dimensions and source global definition
order remain. tickPtr and other still-unresolved locals remain visible.
All15 functions, branch checks, debug twins,1744 raw oracle words and76 data
bytes pass; the entire14096-byte object is unchanged.

fememcard.cpp loses six array views plus MEMCARDFRONTENDISINITTED_word. The
genuine tRecordBuffer[187] array is preserved; flags use native scalar BOOLs.
Its existing volatile polling qualification moves to the actual scalar ticks
declaration in its scoped header. Simply dropping the qualification removes
real polling (Init80/87 and DeInit34/40) and was rejected. Moving it preserves
the entire original object,18/18 PASS, branches0, both debug twins and48 raw
affected references. This adds no volatile cast/helper or new volatile behavior.
The NFS4 ticks name record is untyped; existing owner storage/access width and
the NFS2 INT record corroborate int, but original CV/macro spelling is not
uniquely recovered. That limitation stays explicit, not called SYM proof.

The changed header has four actual consumers among698 checked sources. Base
and all three regional files preserve their code/data/symbol/relocation output
and local/SLD statement grouping. Region status remains AU2/9,JPN1/9,USA7/9;
all17 pre-existing regional misses are unchanged, not advertised as fixed.
No region CPP bodies were changed. Header backup and comments are retained.

### Broad regression and remaining work

All three full builds complete without failed/skipped TUs. All518 source
objects reproduce byte-for-byte. The previous358 checked functions plus18
fememcard functions give376/376 base PASSes with branches0. The twelve native
data owners, raw table words/windows, both-lane standing relink, vtable/source
policy and CI-style objdiff report checks pass. Known blob duplicates fall
909->905; REAL duplicates, phantoms and referenced unresolveds stay zero.

The complete2381-site GP audit retains zero overflows/unresolveds/encoding
discrepancies and zero regressed native targets. It still has1462 wrong-but-
in-range targets; the separate34 restored table relocations are HI16/LO16,
not falsely credited as GP improvements. The full diagnostic still has119
allocated overlap pairs,28348 appended main-data bytes and the sbss warning.

Fresh frontend strict audit:781 declaration-clean functions,0 missing names,
46 extra locals,9 type findings,9 storage findings,3 mapping-review functions
and450 source-only carriers (451 before this round). Removing25 external
array aliases is separate from those local-carrier counts. The one-family
lexical inventory now has62 sites across28 files; some are genuine arrays,
and plain false-array declarations without asm labels remain a separate
audit family. No broader source-completeness claim follows from these counts.

Receipts: ../p884_tables/README.md, final_receipts.json,
full_validation_receipts.json, final_consumer_receipts.json,
production_receipt.json and frontend_strict.md; source/native/debug evidence
is in ../p884_screenmemcard and ../p884_fememcard. Existing user scratch edits
and historical checkpoint receipts are preserved. The full goal remains active.

## P885 / 2026-09-07: plain extern-pointer graphs and three native data owners

P884 remains intact and uncommitted. No new commit/push authority is inferred.

Three native scalar pointer contracts are restored through their complete
source/header graphs, beyond the older audit's explicit asm-label syntax:
FEApp4b4f01 at800514C0 (6TUs/191falseouterindices), screenMain605a62 at80051E58
(7/126), gCurrentShapes56d925 at800517CC (10/22). Their PTR STRUCT size fields
describe pointees, not pointer-cell sizes or arrays. All339 false outer[0]
accesses are removed while real member/shape arrays and constructor order
are preserved. Native scalar owner definitions already existed.

Confirm's feApp/displayDialog source-only receivers are removed in base and
three regional copies (8instances). Native5e2ee4 does not name them. Only
feApp had an emitted debug-local record, so two source removals are not
misrepresented as two debug removals. Remaining local types/homes and inline
receiver roles are unchanged; there are zero new merged native SLD-line pairs
across both61-function base FEApp consumers. No new identifiers, helpers, asm,
volatile, pins, flags or postcompile instruction rewrites are introduced.

All23 consumer TUs retain byte-identical base objects and full regional object
or code/data/symbol/relocation fingerprints. All baseline gate outputs remain
identical. Regional totals:51 selectedPASSes,112existingmisses,3NOT IN OBJECT
over166selected cases/17regionalTUs. The old PAL body/text-ID/constructor misses
and UK-SW minimal psxfront copy's absent bodies remain open, not hidden.

Raw source-reference proof covers66 FEApp words,15 gCurrentShapes words and
252 screenMain pointer-target fields. Four old PAL constructors retain24
register/opcode word mismatches even though those target fields agree. The
base menu constructor's debug-only3205/3207 divergence is reproduced from
the pre-change context; normal66/66 and all seven whole objects remain exact.
Other affected callbacks/shape methods have exact debug twins. Reference
arithmetic to native global cells is distinguished from whole-link placement.

Three more typed native data sections receive exclusive recon ownership:
TABLE69632bytes at80123838, SNDEF8bytes at80136CD0, atantbl257bytes at80136CE8
plus3alignment zeros. Their raw leaves remain in src. All79312 bytes of the
strict baseline/src/recon window,76raw labels and5existing external bindings
agree. Seven public symbols now bind to their native source cells;16actual
linked relocation words across seven consumers change wrong->raw-exact. All
consumer objects remain unchanged; P884's34raw words/fourbindings stay correct.

Final verification: three complete builds without skipped/failed TUs; all518
live source objects reproduced byte-for-byte;421/421 protected base functions
with branches0; all15 native data owners, raw windows/refs, both standing link
lanes, vtable/source-policy and CI-style objdiff report generation pass.
Known blob duplicates905->898; REAL duplicates, phantoms and referenced
unresolveds stayzero. The2381-site GP audit remains in-range/resolved/encoding-
correct with zero native-target regressions;1462 wrong-but-in-range targets
are still open. New table fixes are HI16/LO16, not extra GP improvements.

The diagnostic link still permits overlaps. Removing the large raw TABLE
copy causes remaining unregistered legacy sections to repack: pair count
119->125, pairwise intersecting bytes110375->72019. This is not a unique
corruption-byte count or a final executable PASS. Exact pair additions/removal
are in ../p885_checkpoint/overlap_delta.json. Main data overrun, remaining
raw/source duplicates, vars/new/simqueue/replay/ISO9660 ownership, and the
sbss warning remain restoration work.

Fresh frontend/common audit remains781 declaration-clean,0missing names,
46extra locals,9type/9storage findings and3mapping reviews; codegen carriers
fall450->448. Frontend/psx has85declaration-clean mapped functions but54source-
only carriers and18blob-backed globals. Neither report certifies all extern
interfaces, optimized-away source or statement/scope fidelity. The plain
gHelpShapes and other scalar-pointer/ticks graphs remain explicit next angles.

Consolidated evidence: ../p885_checkpoint/README.md, final_receipts.json,
full_validation_receipts.json and both strict audit reports. Graph-specific
backups/native/SLD/reference receipts are in ../p885_feapp_scalar,
../p885_screenmain, ../p885_gcurr and ../p885_owners. Historical P883/P884
receipts and the user's unrelated scratch edits are preserved. Goal active.

## P886 / 2026-09-07: real fog-file repair, vars ownership and source scopes

The round remains uncommitted with prior P884/P885 work preserved.

gHelpShapes native768122 is restored as a single pointer across nine
declarations/13actualTUs, removing52 falseouterindices and five lexical slot
carriers. Native noise52dbb6 remains because it is a real PTR/REG17 local.
All base46/46/functions/branches, complete objects,16raw reference words and
native SLD merge checks pass; regional13selectedPASSes/23oldmisses are unchanged.
The separate regional fedialog gHelpShapesA and drawshp gHelpShapes_v asm
aliases are outside this corrected plain-declaration graph and remain open.

FEInput base/JPN now read the actual scalar ticks into the existing native
tick local once. All objects, scoped debug declarations and statement order
remain; base4/4 and four raw ticks-reference words pass. The JPN old four-diff
and unrelated GetNoDebounceKey branch discrepancies remain unchanged. No
volatile or polling semantic change was introduced here.

Root found a genuine source bug in Fog_ReadFogKeys: old N/W/S literals occupied
the native S/N/W branch slots, invisible to normalized verify_asm. Raw bytes,
delay-slot instruction stepping and Redec establish the exact four-condition
filename truth table. Correcting the three ordinary literal characters makes
the complete source .sdata native. The only7800-byte object deltas are those
three bytes at .sdata+0/+8/+16; .text,148relocations, symbols and all other
sections are unchanged. WholeTU16/16/branches0 and the70-instruction -g twin pass.

The same function's i declaration is restored to its native INT/REG17 loop
scope. Generated enclosing bounds exactly equal native476a7c..476aa6,
800E0FD8..800E1004, ending before purgememadr. Outer readmem/strspc/numkeys order
is restored too. That final order adjustment was separately re-gated and has
the identical complete object, so the completed full-build/link outputs remain
valid. This is named-scope restoration, not a claim that every empty nested
block or original source-line spelling is recovered.

TextureProcess's real G8 .sdata begins40bytes before gZDepth. The old link
selected all68bytes at8013DB74 after also retaining its40raw string bytes;
this displaced the whole following tail. Rawr21/o34 ownership now divides
at8013DB4C, source68bytes match native, and the84-byte strict baseline/src/recon
window preserves all raw labels. No string-label source variables were invented.

With that upstream defect fixed, vars.c's40native globals fit8013DC64..DD04.
The raw160-byte copy is a separate oracle-only file. All392 surrounding bytes,
90labels and shapeext's pointer are preserved. All46vars/fog public bindings
are now native;438named relocation words across38consumers are raw-exact,
437newly corrected. GP audit independently repairs29more native targets,
1462->1433 wrong-but-in-range, with zero correct-target regressions. These
counts overlap; the46bindings,438words and29GP targets are not additive gains.

Final regression completes all three full builds without skipped/failed TUs,
518reproducible final source objects,446/446 protected basefunctions/branches0,
seventeen native data owners, raw code/data windows, prior50table reference
words, standing relink, vtable/source policy and CI-style report generation.
Known raw/source duplicates898->852; REAL duplicates/phantoms/referenced
unresolveds stayzero. All2381 GP relocations fit and encode correctly, but1433
wrong native targets remain. The diagnostic still has124overlap pairs,
28348appended main-data bytes and the sbss warning; no final-image PASS is claimed.

Fresh frontend/psx has85declaration-clean functions yet53source-only carriers
and18blob-backed globals. Game/psx has392/395declaration-clean functions,
three extra names and394codegen carriers. Exact typed/source names, scopes,
macro reconstruction and data ownership remain substantial active work.

Next real data-binding defect: ISO9660's9216-byte BSS is at8013F624 rather than
native8014487C, with42text references. Its16-byte initialized data already
binds correctly; raw-copy retirement alone would not solve this. New heap,
SimQueue and Replay raw windows were also inspected: their current typed
bindings are native, so proposed transfers remove duplication, not active
code-reference errors. Some zero-storage sections are PROGBITS and others
NOBITS; do not feed the latter blindly into a payload-hash validator.

Receipts: ../p886_checkpoint/README.md, final_receipts.json,
full_validation_receipts.json and strict audits; ../p886_vars/window_receipts.json,
scope_receipts.json, production_receipt.json and before/final consumer ledgers;
../p886_owners/VARS_TRANSFER.md and READ_ONLY_FINDINGS.md; source graphs in
../p886_ghelp and ../p886_feinput. Existing scratch/user edits and earlier
checkpoints remain preserved. No new publication was authorized. Goal active.

## P887 / 2026-09-07: native BSS ownership and remaining frontend aliases

Completed regression: 470/470 protected functions in 24 base TUs, branches0,
all three full builds without skips/failures, and 518 reproduced source objects.
Eighteen initialized source owners now include the actual kNoColor cell;
the full 392-byte surrounding raw window and 31 label addresses are preserved.

Three native NOBITS output windows reserve 9296 bytes: C_005 at80144874 (8),
ISO9660 at8014487C (9216), and CDROM at80146C7C (72). Twenty public globals and
three private arrays have the verified native offsets. All311 ISO/stream
reference words match retail,156 newly corrected; no known native bindings
regressed. Canonical SDK4.0 supplies private ISO names/offsets while SDK4.3
supplies the target extent; their code versions are not claimed identical.
Stsector_offset is short2 plus alignment2, not a four-byte source object.

FEVideoWall loses its false ticks array, ticksA aliases, ReadVideoWallTicks
helper and two tickCounter locals. All12 functions and483 raw text words are
exact. Four relocations now name ticks and24 bytes of obsolete symbol metadata
disappear; whole-object identity to the earlier baseline is not claimed.
Regional fedialog and drawshp gHelpShapes aliases are removed. Native corner
statement order plus drawshp's whole-TU G0 identity preserves all four functions;
its kNoColor payload moves from sdata to data, so this object also changes.

All438 prior vars words remain exact plus exactly four newly visible canonical
ticks words (442 total), and all50 prior table words remain exact. GP remains
2381 resolved/in-range/encoding-correct sites,1433 wrong native targets and zero
regressed correct targets. The diagnostic link still has130 overlap pairs,
28348 appended main-data bytes and the sbss warning. The new BSS windows still
intersect unretired replay-legacy/data_rest sections: not a final-image PASS.
Standing relink has851 known blob duplicates, zero REAL duplicates, phantoms
or referenced unresolveds. No whole-project source/SLD completion is claimed.

Detailed receipts and the two corrected assertion-fixture errors are documented
in ../p887_checkpoint/README.md. Strict frontend/common still has781 declaration-
clean functions,46 extra locals,9type/9storage findings,3mapping reviews and446
source-only carriers. This report does not validate every source scope or extern.

## P888-P889 / 2026-09-07: storage compatibility and further ticks cleanup

CDROM's storage asm contains data directives, not executable instructions.
Scratch typed definitions with nocommon/section(.bss) preserve native storage
and code, but require GNU as to reject an incorrect @progbits request. They
are not promoted to production or advertised as original Sony declarations.
Actual GCC2.7.2 binary/source evidence identifies the compatibility cause;
ordinary COMMON's native PsyQ allocation order is the next finite experiment.
See ../p888_cdrom_c, ../p888_c005_c and ../p889_cdrom_storage/README.md.

FEScreen and Femenuextended now use scalar ticks in all six actual base/AU/USA
consumer TUs. Twenty-one false outer-array accesses and twelve source-local
instances are removed, including four base carriers. There are no replacement
invented names. Base27/27 and57/57 functions and branches remain PASS; all six
selected regional manifest tests remain PASS. Whole normal objects or complete
code/data/symbol/relocation fingerprints are unchanged. All42 ticks reference
words across those six consumers match their own retail images.

SLD is not declared solved by those code matches. FEScreen's native zero-local
methods now have no invented local, but emitted line partitions still split
the native fade/ticks line. Femenuextended TransitionOff's direct ticks expression
spans native856/858 in the debug map; TransitionOn still has the separate
itemCursor/source-scope recovery question. These are active technical review
items, not generic carrier exemptions or claims that evidence is unknowable.
The affected source headers no longer unconditionally claim SLD-VERIFIED.
Per-family receipts: ../p889_ticks and ../p889_femenuextended/README.md.
Coordinated full-build/relink/strict results are in ../p889_checkpoint.
The full goal remains incomplete and active; no new publication is performed.

P889 final coordinated validation completed: all three full builds have no
skipped/failed TUs,518/518 source objects reproduce P887 exactly, and527/527
functions across25protected baseTUs pass with branches0. The diagnostic ELF
itself is byte-identical to P887, preserving both earlier reference fixes and
earlier overlap/GP debt. Vtable/source policy and standing relink counts pass
unchanged. Fresh frontend/common carriers446->442;781declaration-clean,
46extra names,9type/9storage findings and3mapping reviews are unchanged.
See ../p889_checkpoint/README.md and link_identity.json. The goal is not complete.

## P890 / 2026-09-07: unnamed ABI parameters and closer transition SLD

Six unsupported arg2 definition spellings and four unverified prototype names
are removed from FEScreen's base/AU/USA graph and owning/shared headers. The
tMenu* parameter remains in the exact native signature; no ABI argument is
lost. Actual Ctags/native-symbol checks retain both explicit parameter types.
The original unused name remains unknown, not claimed originally absent.

The same transitions now chain the two related fade-field initializations,
retaining field-write and flag/ticks order. Eight finite trials show the natural
chain preserves all code while the reverse chain fails. Native SLD split pairs
Off5->4 and On12->8 (17->12 total), merges0. The ticks/fade group and native
nested blocks are still open source-recovery issues, not a fully SLD-exact seal.
All three whole objects remain unchanged; raw51words and12ticks refs are exact.

Front's base/USA private header now has scalar ticks and seedrandom(int).
All43base functions/branches and9selectedUSA cases remain PASS, with unchanged
complete object fingerprints and12raw reference words. Direct seed assignments
still narrow lw to lhu (2diffs at1000/1000), so the failed removal is reverted.
The existing t local and USA volatile read remain open, without new names.

lang/randomSeed in both Front copies are moved out of generic carrier exemptions
and explicitly back into source review: their measured codegen choices do not
prove distinct original source objects. No audit parser or suppression is added.
Fresh frontend/common therefore reports780clean,48extra,438carriers,0missing,
9type/9storage findings and3mapping reviews. The clean781->780/extra46->48 change
exposes existing debt; it is not a byte-matching regression. Of carrier442->438,
two are removed base parameter spellings and two are reclassified existing locals.

Final full validation completes the three initial build lanes plus a fresh
all-source rebuild after the fade-chain landing. All518objects reproduceP887;
527/527 protected functions across25TUs and branches pass. All25source receipt
hashes equal final worktree files. Diagnostic linked ELF remains byte-identical;
standing relink/vtable/source policy and CI-style report generation pass. Earlier
851blob duplicates,1433wrongGP targets and overlaps are not claimed solved.

Actual PsyQ native C/assembler/linker controls now support ordinary CDROM COMMON
declarations but expose separate allocation-order and assembler-schedule questions.
Neither canonical nor candidate standalone COMMON order matches retail under the
tested contexts; their equality is distinct from retail equality. Canonical
objects also contain anonymous16-byte MMIO data missing from current source
objects. Its repeated payload is not a unique VA proof. Native named
pfuncCdReadyCallback is absent from source declarations; type and ownership
must be traced before adding a declaration. These are active next investigations,
not unproved claims that original information is irrecoverable.

Receipts: ../p890_checkpoint/README.md, ../p890_fescreen_params,
../p890_transition_shape, ../p890_front and ../p890_cdrom_native.
No publication is performed; user edits are preserved. Full goal remains active.

## P891 / 2026-09-07: brightness statement recovery and clock interfaces

ScreenTracks base/AU/USA and its private header now use scalar ticks at18reads.
SetBrightness now has the three native field assignments in order, removing
the unsupported inline call/extra generated receiver/current/start records.
Native this/SHORT bright remain. SLD distance9->5, from2splits/7merges to4/1,
with no new merge. Remaining ticks attribution and nested scopes stay open.
All three whole objects are unchanged; base10/10/branches0 and39ticks references
plus36complete SetBrightness words are exact. AUInitialize's prior2diffs remain.

FeMenuOptions's three consumers use a scalar clock at three direct reads and
&ticks at three pointer-helper calls. All three whole normal objects and the
complete85,108-byte debug object are unchanged. All151 instruction/source maps,
8,487 pair classifications and parameter/local/block records match the baseline.
Base92/92/branches0 and453raw affected words pass. AU's four prior2/4/4/2 misses
remain unchanged; the helper's original names and existing SLD gaps stay open.

No startTicks/inline_fn removal is claimed: byte-exact direct startTicks removal
created six new SLD merges; field staging added a store. The helper's direct
forms lost the retail copy. Failed variants are retained only as diagnostics.

Fedialog scalar conversion remains9diffs in one function despite31/32 base
matches. All five source/header files were restored byte-for-byte, including
their original line endings; full base/regional gates are restored. Actual
CC1PLPSX tracing attributes the residual to one MEM_IN_STRUCT flag and two
lost scheduler anti-dependencies, not an unexplained allocator tie. The effect
does not uniquely identify an original array or macro; native NFS4 ticks is
untyped, with scalar width/type corroboration rather than a native typed row.
The alias-sensitive access/source-boundary question is active, not declared
irrecoverable and not worked around with invented names or output changes.

Final three-build validation reproduces all518objects and passes537/537
protected functions/branches in26baseTUs. Source receipt drift0; diagnostic
ELF is byte-identical to P887; vtable/source policy, standing relink policy
and CI-style report generation pass. Existing851blob duplicates/1433wrongGP
targets/overlaps are unchanged. Strict frontend/common remains780clean,
48extra,438carriers,0missing,9type/9storage findings and3mapping reviews.

Receipts: ../p891_checkpoint/README.md, ../p891_screentracks,
../p891_femenuoptions (including before/after SLD supplement),
../p891_fedialog and ../p891_fedialog_compiler. No publication is performed;
the user scratch file and earlier work are preserved. Goal remains active.

## P892 / 2026-09-08: native fields, inline removal and coherent Camera regions

ScreenPost/TrackRecords base and USA now use scalar ticks through both private
headers. Ten false array reads disappear; native tt locals remain. All four
whole objects and all eight affected debug local/line partitions are unchanged;
base20/20, USA3/3 each,104 base branch entries and18 raw timer words pass.

ScreenCongrats base/USA/JPN initialize the native fields directly, reading the
entry tick first. The unsupported nonvirtual PrepareInitialize helper is gone
from the private and shared class definitions. Initializer SLD merges24->0 and
splits33->32, with no new bad pairs; its147 words and90 full-TU timer references
are raw-exact. The remaining32 splits and native empty-block identity stay open.
Scalar ticks/spinTicks-removal experiments lost reloads and were fully reverted;
their original access/qualification still needs recovery, without fake arrays,
volatile or new helpers. Base28/28, USA6/6 and JPN's six prior misses are preserved.

AIInit now uses native leaderBoard and its four actual pointer fields rather
than the invented array/asm alias. Native type130b95..130c49/global1371f7 support
the contract; the existing AISpeeds owner is unchanged. AIInit17/17/AISpeeds29/29,
all17 methods' debug maps/locals and all65 Reset2 raw words remain exact.

Camera base plus six regions now use native Replay_ReplayCamera fields, removing
the invented linedef alias and accessor macros. The six regions also recover
current GameSetup/simVar/simGlobal/Replay field interfaces, fixing their stale
header build incompatibility. Coherent historical-header baselines exist only
in scratch. The actual regional production files now compile with current
headers, preserving all code/storage/relocation semantics and regional constants.
No old header or compiler output was restored into production.

The six regional NextMode bodies lose unsupported setupBase/setupOffset locals.
Their line partitions improve by164 split pairs per region relative to base SYM,
with no new bad pairs; independent regional SLD is not claimed. All38 functions
per Camera TU were compared, not only the replay accessors. Base38/38 and Replay
owner16/16 pass, as do13 target-layout assertions and42 raw replay-reference
words. AU's three regional targets pass; FR-DE/UK-ES-IT/UK-SW prior3/2/2diffs
remain. JPN/USA have no Camera CHANGED oracle and are not called regional PASS.

AIInit/Camera's native foreign types are explicit owner-derived projections.
Their presence in each consumer's original header/type stream remains unproved.
Recover that provenance instead of treating the correct layout as full SYM seal.

All three coordinated full builds pass without skips/failures. The expanded
protected set is665/665 functions across31 base TUs, branches0/source drift0.
Of518 rebuilt objects,515 are literally identical; ScreenCongrats, AIInit and
Camera differ only in documented compiler metadata. All code/data/storage,
symbol bindings and ordered relocation semantics remain exact to the frozen
baseline. ScreenCongrats's only UID change is local carRotate.44->carRotate.42;
AIInit/Camera change symbol ordering and corresponding relocation indices.
The diagnostic linked ELF therefore has a new hash, but no code/data/layout,
header, LOAD segment or global-binding change. The local carRotate anchor is
preserved at8013EFF0; that is not asserted to be its native retail placement.

The scratch metadata verifier was independently hardened against false accepts:
unknown/RELA metadata, duplicate sections/local symbols, executable UID renames,
comment-only name authorization and entry/LOAD-header changes now fail closed.
All14 self-tests pass (11 unsafe cases rejected,3 valid cases accepted), and
the full518-object/link audit has no unapproved UID change. No production
matching threshold was weakened and no post-compile rewrite was introduced.

Strict frontend/common remains780clean,48extra,438carriers,0missing,
9type/9storage findings and3mapping reviews. Game/common reports1228clean,
6extra,478carriers,0missing,28type/28storage findings and0mapping reviews.
These counts do not seal existing source-only annotations, scope/line gaps or
global/header provenance. Earlier851 blob duplicates,1433 wrong GP targets and
link overlap/overrun debt remain unchanged. CI-style report generation and
git diff --check pass. The user scratch hash and prior work remain preserved.

Receipts: ../p892_checkpoint/README.md, ../p892_post_records,
../p892_screencongrats, ../p892_leaderboard and ../p892_replay_camera.
No commit/push is performed in this round. Full source/SYM/SLD goal stays active.

## P893 / 2026-09-08: Camera's native road-slice access graph

The invented Camera_BWorldSmSlices pointer-to-byte-row alias and four
CAMERA_SLICE_* macros are removed. Seven Camera sources now express105 prior
macro calls and39 direct alias uses through native BWorldSm_slices and
Trk_NewSlice fields; raw center-height accesses use center[1]. SYM1cec71..1cedc3
defines all32 bytes, and1d937e establishes the actual pointer owner at8013C7C0.
The real bworldsm owner is unchanged. No new helper, asm, qualifier, flag or
invented source name is introduced. AU's existing nextSlice receives the true
pointer type, but that does not establish its unsupported local name/presence.

All seven actual production objects are literally identical to P892. All266
function instances retain line partitions;168 own-image raw pointer-reference
words and18 target layout assertions pass. Existing native-relative SLD gaps,
Camera carriers/fences and original foreign-header visibility remain open.
The private header no longer inaccurately claims an exact source-visible graph.

The fresh three-build checkpoint passes665/665 protected functions across31TUs,
branches0/source drift0. All518 normal objects and the diagnostic linked ELF
are literally unchanged from P892. Strict frontend/common remains780clean,
48extra,438carriers; game/common1228clean,6extra,478carriers. Missing names0 in
both; prior type/storage/mapping review queues remain. Relink/vtable/source
policy and CI-style report generation pass. User edits are preserved.

Parallel next proposals are explicitly outside that full-build snapshot:
AI can remove its slice alias/macros using an already present native type,
and ScreenPost's max locals can be tested against its native one-local body.
Their per-family receipts distinguish isolated candidates from production.

Replay's true StatsTimer[2] consumer was re-probed under the current2.8.1-SN
identity: direct native array gives14/16 with8diffs each in ResetReplay and
GetInterfaceKey at unchanged instruction counts. Whole-TU G8 gives12/16 and
branch regressions. No production change. Raw Replay stores are absolute
lui-at/sw pairs, not the gp-relative stores claimed by an existing comment.
Compiler-source ENCODE_SECTION_INFO evidence explains declaration-size-sensitive
symbolic-address treatment; the original array/header/object contract remains
to be recovered, not replaced by invented cells, qualifiers or output rewrites.

Receipts: ../p893_checkpoint/README.md, ../p893_camera_slices,
../p893_replay_stats, ../p893_slice_alias_audit and ../p893_post_locals.
No commit/push performed. Whole original-source/SYM/SLD goal remains active.

## P894 / 2026-09-08: AI native fields and ScreenPost macro-local removal

AI's synthetic BWorldSm slice alias and two offset macros are gone. Ten
accesses now use the existing native Trk_NewSlice type/fields; no type header
or local was changed. Actual40/40 code/branch gates, all40 full debug scope/
local contracts and line partitions, and36 raw pointer references pass.
Existing AddCollidableObjects/PushFinishedCarsToSide native-scope issues remain
open separately from this field graph. Other remaining slice alias inventory
is in ../p893_slice_alias_audit, including Newton/AIPhysic/AIState/AudioTrk.

ScreenPost base/USA Initialize loses the invented count-speed macro and both
max_money/max_damage locals. Native this/tInfo are the only resulting debug
locals. Separate flag and nested maximum expression preserve all code while
reducing native SLD merges29->8, splits29 unchanged, with no new bad pairs.
The original maximum-operator tokens are not recovered; no replacement name
was invented. Native empty-block topology remains unresolved, not suppressed.
The old comment's line118 attribution is corrected to flag113/max115.

Actual base13/13 with67 clean branch checks, USA3/3 manifest gates and198 raw
initializer words (16 reloc words included) pass. All26 function-instance
local/SLD comparisons pass their stated before/after tests; USA native counts
are explicitly base-SYM projections. Both actual production whole objects
are literally unchanged. Debug label assertions prove zero label rewriting.

Full three-build validation passes705/705 protected functions across32TUs,
branches0/source drift0. Of518 objects,517 are literally identical; AI alone
has symbol/string ordering and corresponding relocation-index changes. Its
code/data/storage/full symbol multiset/ordered relocations are unchanged with
no UID rename. The diagnostic linked ELF is literally identical to P893.
Relink/vtable/source policy, strict audits and CI-style report generation pass.

Strict totals remain frontend780clean/48extra/438carriers and
game1228clean/6extra/478carriers,0missing in both. The macro-private max names
were not included in these ordinary body-local counters; their removal is
verified by actual source and compiler debug records, not an inflated audit
delta. Existing851 blob duplicates,1433 wrong GP targets and layout debts
remain. User edits are preserved. No publication is performed; goal active.

Receipts: ../p894_checkpoint/README.md, ../p894_screenpost,
../p893_slice_alias_audit/landed_verification.json. Further AI scope and
NewBestLap candidates are still separately staged proposals at this snapshot.

## P895 / 2026-09-08: exact AI instruction groups and native lexical ownership

AI_PushFinishedCarsToSide now uses one combined short-circuit guard with its
two actual INT locals inside the body. Native three block spans/depths match:
roots8005A724 atdepth0/1; locals8005A7C0..8005A8B0 atdepth2. The synthetic
PUSH label/gotos are removed. Separate call-result then abs assignments to
the same native absDistancePastFinish preserve its $6 home and totalSortIndex's
$3 home without introducing a carrier.

Native SLD pair differences485splits/9merges ->0/0. First the combined guard
closed485splits, then native1997call/1998abs separation closed the last9merges.
The complete actual AI object is unchanged;40/40 functions/branches and all39
neighbor debug contracts remain exact. Full target raw103/103 words (412B),
including22 relocated words, matches retail. The first guard-only production
proof and rejected five-scope intermediate probes remain preserved.

This is not literal-text or physical-line recovery: the expanded conditional
still gives block-relative6..30 versus native4..28. The three block address
spans/depths and instruction-line equivalence are exact, while original
formatting/macro tokens/whole-file line positions remain open. No #line spoofing,
new asm, qualifiers, flags or helpers were used. No broad full-SYM claim follows.

TrackRecords base/USA now use the genuine scalar BOOL NewBestLap directly,
removing both invented NewBestLapA[] asm views. Native71dba4 proves scalar
shape; true NewRecords[8] and all native locals/types/region ids remain.
Actual7/7 base,37 clean branches,3/3 USA,all14 local/line partitions and240 raw
DrawRecords words pass. The fourNewBestLap refs are exact for each image.
Existing3merge/144split DrawRecords pairs remain unchanged, not sealed.

Fresh705/705 protected functions across32 base TUs pass, branches0/source drift0.
All518 source objects and diagnostic linked ELF are literally identical to
P894. P894's three full build lanes are preserved; P895's CPP-only changes
are verified by fresh complete-TU compilation plus exhaustive object hashes,
not falsely described as another full-tree rebuild. Relink/vtable/source
policy, strict audits and CI-style report generation pass.

Strict totals remain frontend780clean/48extra/438carriers and
game1228clean/6extra/478carriers, with0missing in both. Native scope/source
fidelity improves despite unchanged declaration counters. All previous
link/data/header and source-carrier queues remain active; no unknown name is
renamed merely for readability. User edits preserved; no commit/push performed.

Receipts: ../p895_checkpoint/README.md, ../p895_ai_abs_split actual landed
scope/raw receipts, ../p894_ai_single_guard and ../p895_newbestlap.
The full original-source/SYM/SLD goal remains active and incomplete.

## P896 / 2026-09-09: AI initialized state/native scopes and Newton fields

AI_AddCollidableObjects now restores static CHAR firstTime=1 at nativeGP0,
8013C54C, and real132-byte BWorldSm_Pos spos at8013DEE0. The previous source
zero flag read the wrong SBSS cell; its raw/CPE initializer and compact spos
record were not fully applied despite declaration-clean audits. All eight
static-reference words and the complete127-word actual linked function now
match retail. No unlinked-relocation normalization substitutes for this proof.

The source restores Group::GetData's implicit receiver, for-local objectIndex,
loop-local pt and five inner locals. All11 native local/inline type/home/storage
records and all7 lexical address spans/depths match. SLD36merge/92split pairs
improve to30/0, with no new bad pairs. Vector subtraction and load/scale radius
are grouped without an invented macro name; a code-exact multiplied initializer
that lost native radius debug visibility was rejected. The remaining call-result
versus range-test source boundary and original token/physical-line recovery stay
open; no extra variable is invented to hide the gap.

AI source owns a native16-byte initialized run and132-byte NOBITS region.
Only raw r00(4B)/o00(12B) inputs are excluded from reconstruction; oracle files
are retained. __sdata_org is the linker-owned boundary. Registry checks support
explicit multi-piece ownership, exact offsets/bindings and unique numeric UID
stems, with comments/backups.50/50 negative/positive controls pass after closing
ten initial fail-open cases;21old owners stay compatible. No instruction or
debug-label rewriting was introduced. GAS-L diagnostic reassembly retains only
pre-existing compiler labels and proves instruction/data bytes unchanged.

Newton base/USA recovers97 native field accesses, including USA's three stale
aggregate interfaces. Trk_NewSlice's owner-derived projection stays in the
Newton-only extern boundary; shared private newton_types and AIH-BTCCop remain
untouched.32/32base and USA492target pass;64debug/local/scope/source contracts,
108own-image raw references and30actual-header layout assertions pass. USA's
simGlobal mapping was an interior gameTicks cell, corrected before relocation.
Original external type/header visibility and other source scopes remain open.

All3full build lanes and737/737 protected functions across33baseTUs pass,
branches0/source drift0. Of518 normal objects,517 are byte-identical; AI's
only changes are native initialized storage and expected section/symbol
contracts. All normal instruction bytes are unchanged. Actual GP audit has
2381resolved/encoded sites,0overflows:2378native-known,3unknown; confirmed
wrong targets1430->1428. All948 previously correctGP rows and3779native globals
are preserved. Recon blob duplicates851->848, REAL/phantom/referenced-unresolved0.

Native spos placement still overlaps three oversized existing output sections:
overlap pairs130->133. Catchallpacking/orphandata move; none of the previously
correct native bindings regress, but wrong/unknown moved bindings and all
inherited overlap/SBSS/data-overrun debt remain. No fully valid final-image or
whole-project source/SYM claim is made. Strict declaration counters remain
frontend780/48/438 and game1228/6/478,0missing in both; they are not scope or
initialized-state proofs.

ScreenPost DrawBackground trials were rejected and frozen. Direct text-type
literals first diverge only after the loop; cached-count and nested j/source
identity need further work. Existing names are not relabeled as solved. See
../p896_post_draw. Full goal remains active; no commit/push performed.

Receipts: ../p896_checkpoint/README.md and final_receipts.json,
../p896_ai_statements, ../p896_newton_slices, ../p896_production_storage,
../p896_ai_storage and ../p896_owner_validator_tests. User edits preserved.

## P897 / 2026-09-09: native AI slice interfaces and AudioTrk scope ownership

AIPhysic, AIState (base/USA), and AudioTrk now use the native BWorldSm_slices
pointer and Trk_NewSlice fields instead of three invented asm aliases and
byte-offset views. The 32-byte type is supported by owner records
1cec71..1cedc3 and global 1d937e; its original visibility in each consumer's
foreign headers remains unproved. These are private extern-boundary projections,
not newly claimed native type-stream records in those consumers.

Actual AIPhysic 42/42 and AIState 52/52 base functions preserve all branches
and existing local/source/debug contracts. AIState USA repairs eleven stale
SimGlobal/GameSetup accesses that no longer compiled with current headers.
Its two available regional oracles PASS; all 52 USA bodies, data, symbols and
ordered relocations preserve the coherent historical-header baseline. The
regional simGlobal map anchors gameTicks at +4, so the actual base is derived
before relocation. All 18 AIPhysic and 90 AIState raw reference words are exact.
Existing synthetic carriers, fences and unresolved source scopes are not sealed.

AudioTrk retains 6/6 PASS with the five PreLoad local owners corrected:
se at 8007D3D8..8007D4DC/depth1, i at 8007D410..8007D4DC/depth2,
x/z/d at 8007D424..8007D4CC/depth3. Native checkonly is BOOL, so two calls now
pass false rather than a null void pointer; the prototype's bank/patch/checkonly
names agree with 191b4b..191b70. All 116 raw PreLoad words and both slice
reference words match. Existing instruction-line partitions remain unchanged.

Correction to P842's old name claim: AudioTrk_Reset's se was borrowed from
neighboring functions, not recovered from Reset's own SYM1be94f..1bea5c, which
lists only two i locals. Same-role sibling usage and pointer-induction assembly
do not prove an original local/name. Keep the current code/name visible as
SOURCE-RECOVERY-OPEN, without a generic carrier or original-name exemption.
A fresh direct-index trial was 58/56 with 32 differences and was rejected;
that is a failed form, not proof that the pointer is required or original.

PreLoad still lacks the CAudioList implicit this record 1bf4f2 and two
zero-width inline blocks at 8007D410. The original accessor identity has not
been established; do not invent GetData/GetElements to fill the debug gap.
AIPhysic_GetDesiredVector still owns checkSide at function scope rather than
native 11cd8f's depth3 block, 8006B104..8006B164. The next bounded angle is
to narrow the existing declaration, preserving its separate assignment, and
check the parent block beginning at the fCPoint copy (8006AF80). No change to
that scope has been made in P897.

Actual-source, raw-word, layout and scope receipts are in
../p897_aiphysic_slices, ../p897_aistate_slices and ../p897_audiotrk.
The combined build/publication results are recorded in ../p897_checkpoint.
Full original-source/SYM/SLD restoration and final native image layout remain
open. CDROM.c's existing file-scope assembly reserves BSS only (no executable
instructions); it remains a storage-source restoration item, not ordinary C.

Completed local P897 regression: all three full builds and 831/831 protected
functions across 35 base TUs PASS, with zero branch divergence. All 518 normal
objects, the linked ELF and map are literally unchanged from P896. Vtable,
source-policy, relink and CI-style report checks pass. Strict game/common now
reports 1227 clean / 7 extra / 478 carriers / 32 original-name recoveries;
the one reopened se claim explains the count change. Frontend/common remains
780 / 48 / 438. Both have zero missing mapped SYM names. Goal remains active.

Publication integration preserves upstream c652c79a/373adb47/7728c5ea.
All 182 incoming oracle-known symbols (180 scaffold entries plus two static
copies) retain PASS. Ten of eleven closure TUs compile; USA Speech's existing
SPCH_ResolveData/AddBank pointer-type errors remain unchanged. Base
SubmitRequest__6Speechlll's existing branch distance -2 versus +8 also remains
open. These are not claimed new regressions or counted as green. Incoming
behavior-derived Vox record names/layouts are not automatically exact native
name recoveries. The real regenerated linked ELF and map remain byte-identical
to the frozen P897 checkpoint after the six chosen-field relocation retargets.

## P898 / 2026-09-12: native scope repair and one carrier removed

Applied only aiphysic.cpp and audiotrk.cpp. AIPhysic_GetDesiredVector now
owns checkSide in native 11cd8f's 8006B104..8006B164 block at depth 3.
Removing the redundant wrapper restores all four native ranges/depths and
all 14 local/parameter homes, with 42/42 PASS and 378/378 raw words exact.
Its separate SLD 77-merge/184-split work remains active, not sealed.

AudioTrk_SoundTrack no longer declares curBack or exempts it as a generic
source-only carrier. The old optimized-away claim was false: it emitted a
REG v0 debug declaration absent from native SYM. Widening the grouped int
subtraction preserves the exact bounded arithmetic and all 358 raw words
without a new name. Original cast spelling is unproved. All 25 native local
definitions are preserved; 29 emitted blocks become 23 versus 21 native.
Remaining owner/topology differences are active reconstruction work.

PreLoad's separate guards, grouped distances, nested tests, separate se++ and
conditional return restore native statement partitions: 178 merges/43 splits
->2/5, zero new bad pairs, 116/116 raw words exact. Five native local owners
remain exact. The remaining pairs and missing inline this/two empty blocks
belong to the list-access expression; its original accessor identity remains
unproved. Do not invent a helper to claim that missing source recovered.

Fresh 1013/1013 oracle-known symbol instances across 45 TUs preserve their
code matches and complete prior branch diagnostics, including the existing
Speech anomaly. All 518 normal objects, the regenerated ELF and map remain
literally identical; relink/vtable/source-policy/report checks pass. No build
tool, header, flag, asm/volatile device or postcompile rewrite was introduced.
P897's full three-build lanes are inherited; this CPP-only round uses fresh
complete-TU gates and exhaustive object/link equality, not a claimed rebuild
of every TU again.

Game/common source-only carriers fall 478->477. Other strict totals remain
1227 clean /7 extra /28 type /28 storage /0 mapping review. Frontend remains
780 clean /48 extra /438 carriers /9 type /9 storage /3 mapping review.
Neither cluster has missing mapped SYM names; full source/SLD/data restoration
is still incomplete. Receipts: ../p898_checkpoint and the dated P898 actual
AIPhysic/audio validation directories. User edits and historical probes remain
preserved. This checkpoint is local and uncommitted at this recorded state.

## P899 / 2026-09-12: exact native owners and further SLD recovery

AIPhysic_GetDesiredVector's native SLD conflicts improve 77 merges/184 splits
->7/0. Existing native locals carry split call/result stages; related vector
assignments become actual comma expressions and the max clamp a conditional
expression. No new local/helper/macro name is invented. All 4 native scopes,
14 homes, 41 neighbors and 378 raw words remain exact. Remaining seven pairs
are argument shift/call boundaries; failed carrier staging is preserved, not
treated as a floor. Original operator/macro tokens remain unproved.

Reset now uses scoped for-loops with both original i owners exact, and omits
its redundant void return: SLD20/60->0/0. All seven emitted nonempty blocks
match native order/ranges/depths. Empty records1be9fc/1bea05 at8007C6A0 remain
unrecovered. The existing se name remains SOURCE-RECOVERY-OPEN, not renamed
or exempted. Fresh indexed-source failures and -da diagnostics identify the
base-capture versus reloaded-list-value issue; compiler evidence is not proof
of an original pointer variable/name or license to add false qualifiers.

SoundTrack's 25 native local owners now all match; its 19 emitted blocks have
the exact native projection, with only two empty CE40 records absent. Native
SLD115/132->22/76, zero new pairs. Repeated post-call type tests remain intact.
Only native single-line distance selections are grouped; velocity components
retain their distinct native lines. All 358 raw words remain exact. PreLoad's
P8982/5 and five native owners remain protected, with116 raw words exact.

Actual-path independent validation and fresh1013/1013 symbol-instance gates
across45TUs preserve all prior branch diagnostics. All518 normal objects and
the linked ELF/map are identical to P898. Six existing source-label PCs are
verified despite naturally renumbered compiler labels. No compiled instruction
or debug label is rewritten; no production build flag/tool/header is changed.
Vtable, relink, source-policy and CI-style report checks pass. Known Speech
and final-image layout issues remain explicit, not counted green.

Strict totals remain game1227/7/477 and frontend780/48/438 (clean/extra/carrier),
with no missing mapped names. Native scope and statement restoration improved
without manipulating those counters. Full goal remains active; this checkpoint
is local and uncommitted. Receipts: ../p899_checkpoint and its referenced actual
source/native/raw verification directories. No user edits were discarded.

## P900 / 2026-09-12: AudioTrk native control flow and local values restored

AudioTrk_AddCustomObject now has all 31 native block records reproduced in
order, spans, depth, declaration placement, types/tags/sizes and register/stack
homes. All 18 local owners are exact (previously 6). Seven invented control-flow
labels are removed, including their six emitted SCL6 records. Structured guards,
scoped for-loops and the native repeat/audio conditional replace the gotos;
all 413 raw instructions, 40 reference words and branch targets are preserved.

Native SLD conflicts fall from 1 merge/174 splits to 0/0. The final correction
also restores a named local's source meaning: ambdist holds the unshifted
distance difference on native line292; the >>2 belongs in each fixedmult
argument on line293. The former premature shift produced identical code but
the wrong source statement ownership. An independent trace rejected the initial
NOP-attribution hypothesis for this site: 8007CCC0 is a real SRA instruction.

StartUp and CleanUp now declare their existing i in scoped for initializers.
Their eight native blocks and both local owners match exactly; native SLD0/3
and0/9 become0/0. StartUp's single-statement loop and CleanUp's omitted redundant
void return preserve every raw word (23+38). No original names were invented.

SoundTrack retains all25 owners and its exact19-block projection while native
SLD22/76 improves to22/16. The randtick and next conditional expressions restore
their original single statement groups. Its two absent empty CE40 blocks, the
original inline accessor identity and P898 widening-cast spelling remain open.
Two remaining SLD discrepancies are specifically assembler attribution issues:
CC1 already marks the anim test and final tck shift correctly, but current
maspsx inserts the preceding hazard NOP before the retained line marker.
These account for18 merges/3 splits; they remain in the reported22/16 totals,
without an exemption, C workaround, or compiler-output rewrite. Other residual
statement groups remain active source recovery, not a confirmed floor.

Reset's existing unproved se name and two empty C6A0 blocks are still open.
PreLoad still needs its original CAudioList accessor/implicit this and two
empty D410 blocks, and retains native SLD2/5. Do not fabricate helper names or
aliases to make those records appear covered. Matching source scopes and line
partitions do not prove exact historical macro/operator token spelling.

The source proposals preserve the full six-function audio object and all159
branches byte-for-byte. Combined actual-path proof and campaign regression are
recorded in ../p900_audio_landed_20260912 and ../p900_checkpoint. Detailed native
and raw receipts are in ../p900_audio_addcustom, ../p900_audio_lifecycle and
../p900_soundtrack_sld. All prior local checkpoints and user edits are retained.
This is local uncommitted work; the full source/SYM/SLD/layout goal remains open.

## P901 / 2026-09-12: one unproved local removed and SoundTrack groups restored

AudioMus_Threshold no longer declares the unrecorded music pointer or its
SYM-CODEGEN-CARRIER exemption. Four reconstruction-only goto labels are also
removed. Separate natural early-return statements read AudioMus_g directly
and reproduce the same33 raw words, backward return edges and native empty
root scope19ee87..19ee90. Native SLD0/4 becomes0/0. The earlier failed direct
substitution was not proof that the cached source pointer was required.
All23 music functions and206 branches remain exact, with every neighboring
local/type/scope/statement/debug graph unchanged. No replacement name is added.

SoundTrack's native336 value selection now uses conditional assignment arms
to the existing end local. GCC2.8.1 fold-const/expr source explains why bare
MIN_EXPR forms invert the needed strict compare; the canonical compiler's
actual object and branch checks confirm this ordinary-C++ form. It is one
related value selection, not independent statements placed on one line.
Original selection tokens are unproved. The final call uses the positive
eligibility condition and se++ is restored to the body tail, leaving i++ in
the for header. This preserves skip behavior while restoring native469/470
as distinct statement groups. Native SLD22/16 improves to18/7; all25 owners,
the19-block projection and all358 raw words remain exact.

The remaining18 merged pairs and3 of the7 split pairs are the P900 traced
assembler hazard-NOP attribution gaps. The other4 split pairs concern the
list-data address and vx load on native329. None are hidden or exempted.
P900's Reset/AddCustomObject/StartUp/CleanUp0/0 and PreLoad2/5 stay preserved.

Bounded inline-source audit: all20 literal CAudioList occurrences in raw
NFS4.SYM are accounted for by13 dump records (2STRTAG,2EOS,7TPDEF,1EXT,1REGthis).
No named class-function/accessor record was found; MAP has no accessor name.
PreLoad's only this record1bf4f2 is v0 at the zero-width D410 owner, associated
with callerAUDIOTRK.CPP498, not a recovered header line. RawD410..D41C proves
the data-pointer+16 expression; the count load occurs earlier on caller492.
The checked PC walker instead uses a separate count and96-byte entries, so
its layout does not establish a PSX accessor spelling. Do not invent one or
pretend an unparsed native name was recovered. Reset's se and these inline
identities remain explicitly open; other source recovery continues.

Actual-source/native/raw receipts: ../p901_audiomus_threshold,
../p901_audio_landed_20260912, ../p901_soundtrack_sld. The bounded class-name
evidence is in ../p901_audio_inline_identity. Full regression and strict
totals are recorded in ../p901_checkpoint. No codegen device, build-tool/header
change, instruction/label rewrite, naming exemption or publication is added.
The broader goal remains active; all unrelated user files remain preserved.

## P902 / 2026-09-12: three Server carriers and artificial async control flow removed

AudioMus_Server now contains no ordinary locals, consistent with native
19f34b..19f3d1, which records only mode/ticks parameters and one root scope.
Removed randomMusic, randomRange and switchMode without replacing their names.
The first two removals must be paired: a direct left-associated random-song
expression is byte-identical, although earlier isolated substitutions each
failed. The positive default-state guard, supported by M2C/IDA and GCC CSE
path analysis, lets the anonymous constant2 survive the queue call in native
s0 without switchMode. A plain literal or switch replacement alone failed.

Structured disk/default/zero-state guards and legitimate duplicate time-update
source tails remove five reconstruction labels. Native SLD39/170 becomes39/29,
with no new bad pairs. All300 raw words/56 references,23 functions,206 branches
and22 neighboring source/debug contracts remain exact. The existing done
label is still a non-native SCL6 declaration; the root's span/depth and native
params are exact, but root declaration coverage and full SLD are NOT complete.
A full no-goto form and direct early-return substitution were measured and
rejected because they changed return-zero placement and shared-tail behavior.

AudioCmn_LoadAsyncSfx removes both FAIL labels and its artificial do/while(0)
wrapper. Natural failure cleanup preserves the two stores on every failing
path; a complete success/header-allocation condition and loop-test increment
restore native statement groups. SLD0/58 becomes0/9,105raw words/23references
remain exact, and all48functions/513branches preserve PASS. Native slot/check
owners remain exact. The source s alias and extra empty lexical block remain
unproved. Its old claim of being required in s4 was incorrect: s0 is the slot
GIV and s4 holds a diagnostic string high address. No new name or qualifier is
used to hide this. Failed alias-free/for/success-else forms remain private.

AudioEng_CleanUp was freshly checked,9/9PASS/128branches/56rawwords/7references.
Its four native blocks and g/i owners were already exact. Moving player into
the for initializer was fully neutral and reverted; it did not recover an
original name. player has no emitted debug declaration in either form and
remains a source-identity gap. Its entire SLD1/2 residual is NOP8007C578:
native line713 includes it; CC1 already emits the next source marker before
#nop, but the assembled marker lands atC57C. No marker or metric is altered.

Actual-source and compiler receipts: ../p902_audiomus_server and its peer
review; ../p902_audiocmn_async and the actual-path validation it references;
../p902_audioeng_cleanup. Campaign checks and strict totals are recorded in
../p902_checkpoint. No production header/tool/flag change, codegen device,
postcompile rewrite or new source-identity exemption is introduced. The full
source/SYM/SLD/link-layout goal remains active; no commit or push is performed.

## P903 / 2026-09-12: six local carriers and two asm sites removed

AudioMus_PlaySong removes pick through a paired natural source change: move
newsong initialization after randomize=1, use the real availablesongs member
as the pattern-arm divisor, replace the volume wrapper with an early return,
and restore the outer null-global else. All9 native blocks and all3 declarations
(pattern/title/newsong) are exact. Native SLD0/44 becomes0/0;160raw words and
30references remain exact. The repeated GetRCnt calls are preserved. An earlier
passing GNU-expression probe is diagnostic only; no GNU block or extra object
is retained. The old fence/necessity comments were stale and are corrected.

AudioCmn_TrafficSFX removes fade and its emitted REG19 pointer record, plus
two unsupported scopes. The three locals and all15 ordered parameter/ARG-copy/
local records now match native. Separate native engine-patch assignments use
player before each call. Widened grouped index subtractions preserve the exact
int indices and prevent reassociation through the array address; the cast
tokens remain unproved. Native SLD49/46 becomes0/10, with no new pairs;
163raw words/20references and all129 Xfade bytes are exact.

AudioCmn_SoundCar removes currentGas, previousGas, gasDelta and rampedGas,
together with their two empty-asm references. Direct array accesses, branch-local
rising stores and a normal MIN falling step reproduce the gas ramp. Its early
audio-off return restores gas at native depth1; all18 non-static local owners
and the independently checked static cobbleCount owner are exact. Two wet-noise
labels disappear. Emitted scopes12->5 and SLD37/319->37/261;530raw words and
70references plus12switch targets remain exact. Three old asm sites and six
unproved locals remain explicit debt, with three extra scopes still present.

A successful SoundCar dead-clamp experiment is NOT applied. It proves that
ordinary C plus late dead-conditional cleanup can retain the retail unused
freq*doppler product, but neither the shift nor clamp bound127 is uniquely
recoverable from those surviving words. The checked PC relatives only provide
related idioms. Replacing the old fence with that guessed expression would
hide, not recover, source intent. Keep the diagnostic as a new compiler angle;
the existing fence remains openly unproved until stronger provenance appears.

Newly explicit data qualification: SoundCar's12-word switch table matches raw
targets when placed at8005573C, but its current rodata offset104 implies fragment
base800556D4; the async loader's literal run needs800556D0. This existing4-byte
whole-rodata packing discrepancy is not a source/code regression, and per-site
raw verification must not be reported as proof of final linked layout. Static
cobbleCount's byte/type/offset and46 owned small-data symbols independently
agree with the native data base; CPE confirms its byte and separate padding.

Per-function and actual-path receipts are under ../p903_audiomus_playsong,
../p903_audiomus_landed_20260912, ../p903_audiocmn_traffic and
../p903_audiocmn_soundcar; the combined AudioCmn validation and campaign checks
are linked by ../p903_checkpoint. Existing source/header/tool/user files outside
the selected bodies remain unchanged. The full goal is active and incomplete.

### P903 publication integration of upstream EAC headers

Preserved incoming2ee63940/3b616348/df4e6e0a before the approved checkpoint.
The74-TU EAC closure has248/248 native functions and1139 branch checks, including
three fxform functions absent from its old scaffold and six data-only owners
that are not counted as functions. No quote/angle include consumers outside
the cluster were found under actual include-search flags.

Integration fixes preserve those headers while addressing measured regressions:
place primate.h after the owner declarations to retain its existing local
SBSS order and22 GP addends; give the ordinary-C mutexbuf its128-byte BSS and
four-byte alignment (aligned alone on COMMON was ignored); restore two emptied
host fallback bodies and five co-equal host aliases; retain crossproduct's
previous expression shape rather than introduce three unproved temporary names.
These do not claim primate's scattered native storage/duplicate-state debt or
callback's native placement is solved.

Final EAC checks preserve all74 object semantics, with73 objects literally
identical; callback differs only in symbol-table order. After actual normal
recompilation,517/518 project objects remain literal, and the linked ELF, map
and objdiff report remain literally identical to the pre-integration checkpoint.
Combined protected function instances total1341 (1093 plus248), without new
branch regressions. The five restored host branches and aliases pass four
baseline/actual O0/O2 runs of1066499 assertions each. Host input-domain limits
are documented rather than ignored. See ../p903_upstream_eac and its host
disposition. Publication is authorized; final commit/push state is recorded
separately so the historical pre-publication receipts remain honest.

## P904 / 2026-09-12: native initialized drawing state and callback reservation

P898-P903 was committed and pushed as7aef1e7c before this new work. P904
restores real source-owned storage, not merely matching-display names.

Native compact SYM0192d1..01930c, MAP and physical CPE load3465 prove the
five-cell primate initialized run at8013DD04..8013DD18. Ordinary definitions
now initialize otbuf/primbuf/linkmodeflag/drawpending to0 and semitrans to1.
The old private tentative cells were zero-filled and disagreed with external
draw consumers. The source .sdata is20 bytes with all five native public
offsets. Only the corresponding raw20-byte leaf becomes oracle-only; its
following .psh string and shapeext pointer retain exact bytes and addresses.
Both src and expected retain the complete raw oracle, including all labels
and relocation destinations. No function body changed.

This repairs11 of25 primate GP references in the actual linked image. All26
outside HI/LO reference words remain raw-native. The remaining ten tentative
SBSS cells still have14 wrong GP targets; their relative declaration order
is preserved and their LOCAL-versus-shared binding debt is explicit in source.
Names otbl2 and primbuf2 remain unproved carriers, not recovered originals.
Compact labels do not prove the exact original char-pointer/int declarations
or whether either unnamed slot was an aggregate interior.

Callback's existing128-byte, four-byte-aligned mutexbuf reservation now links
at native801477E0 rather than80140DCC, without a callback source edit. All25
actual linked callback instruction words match raw; two old LO16 words are
repaired. Its type spelling short[64] remains inferred, not a typed SYM fact.

All74 EAC TUs were recompiled:248 functions remain PASS and1139 branch checks
are preserved;73 objects are literally unchanged. Of702 old linked inputs,
700 are byte-preserved; only primate and the raw r22 split change. All950
previously correct GP references and3779 previously correct native public
bindings remain correct. GP wrong-target count1428->1417; all2381 resolve,
with zero overflow/encoding mismatch and three unchanged unknown targets.
Both relink lanes, vtable indexing and source-only policy remain green.

This is NOT a fully restored linked image. Allocated-section overlap pairs
are133->135: the new callback NOBITS section overlaps two already misplaced
PROGBITS ranges (.data_rest and .data.r13_replay_legacy),128 bytes each. It
does not overlap catch-all BSS. The inherited .data/.sdata overlap also remains.
No invented filler preserves the former wrong cells: catch-all SBSS shrinks
20 bytes and BSS shrinks128. Wrong orphan placement still requires restoration.

Three source-only SBSS probes are rejected: explicit .sbss attributes keep
the instruction match but produce PROGBITS; .bss attributes give NOBITS but
regress initlinkmode; nocommon attributes produce initialized small data.
Existing --use-comm-section preserves global COMMON metadata and the code
match in a private probe, but its complete native allocation/order/link
contract is unproved and is NOT enabled in production. No build.py or maspsx
change, generic asm, volatile, renamed carrier or postcompile rewrite lands.

Protected owner-tool edits have comments and backups. Initialized-storage
and zero-storage validators have negative controls against bad payloads,
types, bindings, offsets, extents and alignment. Exact receipts and residual
qualifications: ../p904_checkpoint, ../p904_primate_native,
../p904_primate_owner and ../p904_callback_owner. The main goal remains open.

## P905 / 2026-09-12: remaining primate shared storage is native

The ten-cell SBSS storage gap from P904 is now fixed. Ordinary C tentative
definitions emit the compiler's public COMMON declarations in native address
order. A narrowly opted-in assembler binding correction preserves public
binding while lowering those declarations into one40-byte NOBITS section;
the existing source-zero owner mechanism selects it at8013DE68. All ten
source symbols have their exact native offsets and four-byte alignment.
The old raw40-byte transport copy is retained solely in the src oracle lane.
No duplicate native storage or invented former-site padding remains.

All81 actual linked primate instruction words match raw retail, including
all25 GP reference words. All26 outside drawing-reference words (13 HI16,
13 LO16) remain raw-exact and bind the same shared source globals. The
remaining14 bad primate GP targets are repaired: whole-project GP wrong
count1417->1403, after P904 had already repaired11. Both unproved carrier
names otbl2/primbuf2 remain visible; this does not recover their lexical
names, original aggregate membership or exact C type tokens. Address order
is verified; an exact original declaration-order claim is not made.

The rejected true-COMMON path is documented, not hidden: GNU ld pools these
symbols into .scommon in link-context-dependent hash order; its common-sort
options sort alignment, which is identical for all ten cells. The accepted
option instead extends the existing large-COMMON public-binding behavior
to a verified small owner. It is a strong section definition, not generic
COMMON coalescing. Only primate opts in. Legacy defaults and true .lcomm
static binding are unchanged. No function instruction, source asm, volatile,
register dial, relocation record or assembled object is rewritten.

The normal and debug compiler lanes agree on all instruction bytes and
public storage records. All74 EAC TUs recompile;248 functions and1139 branch
checks remain PASS,73 objects remain byte-identical to P904, and700 of702
prior linked inputs remain unchanged. The two changed inputs are primate
and the precisely split raw tail. All961 previously correct GP references
and3780 previously correct native public bindings remain correct; callback
storage remains native. Physical overlap/layout debt elsewhere remains open.

Allocated output overlap pairs change135->139 because the previous tail
section is split around the native zero owner; no new overlapping address
range or increased overlap multiplicity is introduced. All four pre-existing
native/raw disagreement diagnostics remain unchanged. These are not waivers
or evidence that the full linked image is already restored.

Raw-seam checks retain every byte, label and relocation in src/expected.
Five assembler unit tests cover public/private/common options and source
order;48 cases equal the backed-up default implementation. Eleven invalid
SBSS owner metadata cases are rejected in memory. Both relink lanes are
GREEN; the exclusion report now includes both initialized and zero owners
(22 exact raw leaves), not just initialized owners. See ../p905_checkpoint
and ../p905_common_contract for actual-source, native-image and peer proof.

Next material layout work is now evidence-backed: ../p905_orphan_replay
proves29540 bytes of existing duplicate raw data behind the callback overlaps.
Replay's entire28628-byte orphan is already covered by eight typed source
sections plus three native CPE alignment bytes. FEI's separate912-byte raw
table duplicates a linked typed source owner, including108 exact pointer
relocations. These exclusions are NOT yet landed: Replay needs its own
exact raw leaf/eight-section guard, and FEI needs a relocation-aware owner
guard rather than weakening the existing no-relocation invariant. The rest
of .data_rest must not be blanket removed. The full goal is still incomplete.

## P906 / 2026-09-12: native field expressions, store order and data ownership

FEI_gList now uses108 direct typed pointers:107 exact GameSetup_gData member/
array paths and &gUseFrontend. All paths and INT leaf types are independently
derived from native SYM and checked against the actual header/compiler layout.
No field names are invented. The114 scalar entries, six nulls and108 ordered
R_MIPS_32 target/addend pairs are unchanged; the actual FEI object is literally
identical to the former byte-offset-cast source. Its entire912-byte linked
table equals CPE/ROM. Original macro/token spelling is not claimed.

Replay's complete28628-byte raw duplicate is retired in favor of its eight
already-typed source sections:28625 declared bytes plus three real CPE
alignment bytes. Full-group validation and native linker assertions prevent
excluding the whole raw leaf after checking only a subset. Every raw byte,
label and relocation remains available in the src/expected oracle lane.
The misleading Scene-function header on replay.cpp is corrected; all sixteen
Replay functions and their whole object remain unchanged.

Four source stores were in the wrong order despite normalized PASS. Native
AudioCmn_Init lines705/706 reset intensityFalseLapCounter before falseLapCounter;
the source pair is corrected without renaming either global. TrackSpec_Read's
native line160 assigns Current then Prev; a chained assignment restores that
single statement group. Audio's SLD0/100 remains explicit, Track's0/8 becomes0/7.
All53 functions,523 branches and their local/debug/scope contracts are preserved.

Crucial erratum: resolving an isolated object using forced native symbol VAs
was NOT actual-link proof. Before the final owner fix, Track's two stores were
name-correct/raw-wrong, while Audio's two cells were also physically displaced.
The corrected final report derives those partitions from the actual old/new
linked targets, not the earlier all-four-good assumption.

AudioCmn's full248-byte initialized .sdata now occupies native8013C628 instead
of an appended misplaced run. All58 storage addresses are checked:46 native
global names, two native function statics and ten existing literal carriers.
lastImpactSample remains LOCAL INT atC6AC, value99; cobbleCount remains LOCAL
CHAR atC6B0, value0. Their compiler numeric UIDs are not exported aliases.
Literal carriers remain unproved source names; SFXHDR/fesfx actual extents7/6
are distinguished from their padded8-byte slots. TrackSpec's already-native
three-word source run now replaces its unused12-byte raw duplicate as well.

The final actual link repairs126 Audio GP targets:1403->1277. All four corrected
store instructions now match raw. All354 source-owner reference targets across
fifteen source TUs and two raw inputs are verified. All973 other previously
correct GP rows,3780 native public bindings and86 native local records are
preserved. The four native/raw disagreements are zero, all2381 GP rows resolve,
and no overflow or encoding mismatch exists; three expectations remain unknown.

Combined duplicate retirement is29800 bytes (Replay28628, FEI912, Audio248,
Track12); raw-blob duplicate count848->780. There are still133 output-section
overlap pairs (previously139), with no increased overlap area or multiplicity.
The callback reservation still overlaps a different raw GameSetup copy:
data_8010CCD4_o20.data.s.o currently8014773C..80148164. Removing FEI did not
magically seal the whole catch-all: subsequent misplaced inputs repack there.
That exact remaining2600-byte candidate requires its own source/CPE audit.

69 functions and739 branches were freshly re-gated. FEI is data-only, not a
function PASS. EAC's248 functions and Primate81/callback25 raw words remain
preserved. Of702 old linked inputs,699 are unchanged; only the two store-fix
objects and the exact raw r13 split differ. The objdiff report is unchanged.

The new pointer owner guard pins unresolved/masked/resolved payloads and all
108 native relocation fields, preserving the default no-relocation rule.
An initial50/51 integration test exposed a missing owner visibility check;
the hardened final helper passes51/51 and all30 default guards reject injected
relocations. Replay has16 negative payload/group cases; private wrong-order
linking trips two native assertions even when ld --noinhibit-exec returns0.
gen_ld now rejects those explicit owner failures rather than trusting that0.

Authoritative current receipts: ../p906_checkpoint/final_receipts.json,
peer_final_preservation_corrected.json and peer_owner_references_final.json;
../p906_fei_owner/actual/final31 and actual_source_final;
../p906_native_name_conflicts/landed_verified.json and ownership.
Earlier provisional/forced-native reports remain historical, with an explicit
erratum. No new source ASM/volatile, invented names or postcompile rewriting
is introduced. P904-P906 remain local pending publication approval; the main
original-source/SYM/SLD goal is active and incomplete.

## P907 / 2026-09-12: GameSetup ownership and ordinary AudioCmn literals

GameSetup's complete 3024-byte initialized source block now replaces its raw
duplicates: 424 bytes of name tables/alignment plus GameSetup_gData's 2600
bytes. All four native global declarations, exact storage extents, ROM/CPE
bytes and the unchanged GameSetup object are verified. The mixed raw r09
prefix's unrelated 1304 bytes remain untouched; both separated raw leaves
remain available to src/expected. No new GameSetup source type was invented.

Three existing address-named aliases are removed from their consumers:
D_801131F8 -> GameSetup_gData.commMode in nfs3;
D_8011321C -> GameSetup_gData.reverseTrack in AIState and HUD;
D_801132CC -> GameSetup_gData.userSetting.language in HUD. Five source uses
become nine native HI/LO reference words (the two HUD language uses CSE to
one load). Four obsolete declarations are removed. These existing typed
field paths are native SYM-backed, not semantic renames of unknown objects.
However, inherited GameSetup type/header visibility in the nfs3/AIState TU
views is not uniquely recovered from their native SYM graphs. It remains
source-context debt; byte-exact field access does not prove original tokens.

AIDataRecord's four constructors retain their pre-existing D_80113228 source
alias (eight reference words). The owning SYM graph does not repeat the
GameSetup root type/global, and no native standalone declaration or original
accessor/header context was found. The tempting full-type private probe
passed all 26 function gates but was NOT landed: matching does not authorize
inventing that context. Its CPP/types/externs remain literally unchanged.
A clearly labelled compatibility-only linker PROVIDE binds that existing
name to GameSetup_gData + 0x3C; it is GLOBAL NOTYPE ABS, size zero, and allocates
no second storage word. This preserves native addressing while removing the
duplicate raw block, but is NOT recovery of the original source spelling.
Required next evidence: recover the original accessing declaration/macro or
header context, then replace the alias without inventing names or types.

AudioCmn's ten explicit D-named string carriers, forced section/alignment
attributes and carrier exemptions are removed. Code uses ordinary literals:
SFXHDR, fesfx, eng, ger, frn, spn, itl, Gen, brt, fre. Placing the existing
native AudioCmn_LanguageName definition between LoadFESamples and
LoadGameSamples restores the native literal-pool order. A naive literal-only
probe passed code but scrambled data; only the paired source arrangement
matches both. The existing -G8 profile is unchanged. The obsolete -G4/header
claim was corrected, not implemented as a new compiler-flag workaround.
All 48 Audio functions, 513 branches, debug locals/statics/scopes and SLD
partitions remain preserved; this does not claim its old SLD splits solved.

AudioCmn's full 2416-byte .data now has native source ownership, including
seven R_MIPS_32 literal pointers. Its existing 248-byte .sdata remains native
and exact; 69 native storage records across both sections include four real
LOCAL statics. The 44-byte TrackGenBank readonly template has eleven exact
same-TU literal pointers. Its original four following zero bytes remain a
separate raw padding leaf in both lanes, not invented C padding. The old
synthetic D_8005570C extent was 48, incorrectly including that padding; it is
now the native SYM array extent 44. All 1352 original r05 bytes, 57 relocations
and 41 symbol records survive the raw split, with that one explicit extent
correction. No compiler output was split, patched or rewritten.

The new opt-in same-TU section-pointer guard requires a previously validated
ordinary native owner from the same exact object, a genuine LOCAL section
symbol, complete relocation/target/addend sets, exact storage metadata and
unresolved/masked/resolved hashes. The readonly window does not create a
second source selection. Actual linker assertions check its selected section
base/size/window; retained raw padding is validated separately. There are
33 initialized owner rows (31 relocation-free, one FEI 108-pointer row, one
Audio seven-pointer row) plus six zero owners. The nested 44-byte window is
not a 34th owner. FEI's strict GLOBAL/UNDEF target boundary is unchanged.

All 40 Audio guard controls pass. FEI passes 51/51; all 31 default owners
reject injected relocations. Generic visibility checks now reject internal,
hidden and protected symbol visibility: 225 tests cover 75 storage records
in 15 generic explicit-symbol-contract rows (14 ordinary plus FEI). The
17 older payload-only
rows still lack explicit symbol identity/visibility contracts; do not claim
that this audit makes every registered owner fully declaration-exact.

Current actual-link proof: all 17 GameSetup references, all 24 changed Audio
literal references and all 196 Audio data-consumer references are native
exact. All 2381 GP targets are unchanged from P906; 1101 previously correct
GP bindings, 3826 native public full records and 86 native LOCAL/FILE full
records are preserved. Nineteen additional public records are now native.
Primate's 81 and callback's 25 instruction words remain raw-exact. There is
no new overlap area or multiplicity. The full link is still NOT runnable-
image-exact: 1277 wrong GP targets and three unknown expectations remain.

Duplicate raw bytes retired in this round: 5484 (GameSetup 3024, Audio .data
2416, TrackGenBank 44). Raw-blob duplicate count falls 780 -> 757, with zero
REAL duplicates, phantom names or referenced unresolved symbols. There are
30 exact oracle-only exclusions. Total allocated section sizes fall by 5440,
not 5484: the readonly source/raw hole arrangement is different from simply
deleting bytes in a flat image. Neither number is an executable size claim.
The callback still overlaps repacked raw o21.data, currently
8014773C..80147B44 (1032 bytes); removing o20 was not a whole-link solution.
Audio SoundCar's following readonly table still has its pre-existing four-
byte placement discrepancy (source offset104 versus native108). The exact
TrackGenBank window must not be extrapolated to the entire .rodata section.

175 functions and 1441 branches pass the final combined five-TU gate, with
normal/debug allocated payloads identical. Authoritative receipts:
../p907_checkpoint/final_gates.json and final_gp_audit.json;
../p907_gmesetup_owner/final_audio and final_audio_source_review;
../p907_audio_literals/integration/landed_20260912/peer_final_review.json.
No new source ASM, volatile, fabricated identifier or post-recompile rewrite
was introduced. P904-P907 are local; the last published commit is 7aef1e7c.
The overall original-source/SYM/SLD goal is still active and incomplete.

P907 final-build qualification: NFS4_STRICT full expected/recon builds finish
without skipped TUs, but build.py itself does not implement NFS4_SOURCE_ONLY;
that profile selection exists in verify_asm.py. An ordinary full build changed
six pre-existing strict-profile SDK objects (FIRST, cdread, INTR, LIBMCRD,
PADCMD, PADSEQD) via legacy per-function options. This is not local-label noise
or a P907 source regression. All six are reproduced literally at their frozen
hashes by recompiling with the exact existing strict-verifier profile; no code,
flags registry or postcompiled output is modified to force those hashes.
The original report hash is restored and a fresh actual relink reproduces the
reviewed ELF/map exactly. The ordinary full-build report is retained separately;
do not claim the two profiles are interchangeable. Required tooling follow-up:
explicitly distinguish CI/full-build and strict-verifier profiles in reports.
See ../p907_checkpoint/build_profile_restored.json. The final 699-input closure
preserves 693 whole objects; only four scoped C++ objects and two exact raw
split objects differ. Full original-source/SLD restoration remains unproved.

## P908 / 2026-09-12: SwitchSong source scopes and 47 exact data contracts

AudioMus_SwitchSong now uses the ordinary short-circuit if/else supported by
native SYM/SLD, raw MIPS and the independent M2C body. SONG_OFF, SONG_ON and
SONG_DONE source labels are removed; two had emitted compiler SCL6 records.
The existing native info variable (19f03d, register v0, PTR AudioMus_tSongEntry)
belongs inside the work branch, not at function root. Its owner is now exactly
8007A114..8007A1CC at depth2. All three native blocks are reproduced. Removing
the redundant final void return naturally restores native line278's grouping
of the final else-store and epilogue: SLD0/24 ->0/0. No new name, wrapper,
qualifier, macro, assembly, volatile or compiler-output rewrite is used.

The actual production-path whole normal AudioMus object is literally unchanged;
all23 functions/206 branch comparisons pass, and all22 neighboring complete
local/scope/SLD graphs are preserved. The extra-wrapper probe generated four
scopes instead of three and was not retained. This proves the native observable
statement partition and local ownership, not every original whitespace/token
or shared-header declaration.

Important actual-link finding: evaluating the isolated object's relocations at
forced native addresses produces all62 retail words, but the current linked
image has only60/62 exact. At8007A188 and8007A1B4, the load/store of
Hud_kTurnSongOffNext resolve to8013E0BC instead of native8013D940. The entire
linked ELF is identical to the P907 baseline, so this is pre-existing storage
placement debt, not a source regression. It must not be hidden behind PASS or
the isolated62-word result. Read-only follow-up proves the complete existing
HUD .sdata240 bytes equal native ROM/CPE at8013D89C..8013D98C; moving that full
source owner, while preserving both neighbors of its raw duplicate, is the
next concrete repair. No single-symbol alias or guessed bool/padding edit is
proposed. HUD's old140-byte/fconserve-space comment is contradicted by this
current240-byte primary-data evidence and needs correction with the owner work.

The existing r3dcar, copspeak and nfs3 initialized-data rows now have exact
contracts for47 native globals, not just payload hashes. Every original name,
offset, storage width, GLOBAL binding and default visibility is checked. All
370 existing source bytes retain their hashes;204 of these remain anonymous
literal/alignment spans, not invented variables. CopSpeak's final two raw zeros
are preserved separately: they match ROM/linked data but are NOT CPE-loaded.
PTR STRUCT size36/12 records describe pointees, not pointer-cell widths;
BOOL retains the existing four-byte PSX representation. Same-width C type or
signedness-token equivalence is not inferred merely from an ELF symbol.

All509 controls pass on the landed registry: six valid cases,503 unsafe cases
rejected. The actual source owner count remains33 plus six zero owners; the
legacy payload-only review queue falls17 ->14 rows. All previous guard function
ASTs, exclusion sets, FEI and Audio local-section contracts are unchanged.
The generated linker map adds exactly47 successful native-symbol assertions;
all placements and the entire linked ELF remain identical. The actual linked
reference proof verifies462 target/addend/complete-word encodings across20
consumers:222 GP,115 HI16,124 LO16 and one R32. Only259 individual references
also receive a strict raw-word claim;195 lie in non-byte-identical linked
function bodies and eight lack a unique native function-name anchor. These
qualifications remain explicit rather than counting all462 as raw instruction
matches. Existing .data/.sdata VMA overlaps require section-qualified reads.

The prior full --skip-asm build had cleared build/src oracle text. The two-lane
relink guard correctly refused to count those empty objects as success. All
467 source scaffolds were recompiled asm-inclusive and independently matched
expected/src whole objects exactly, without touching reconstructed objects.
Both relink lanes are now GREEN under their scoped duplicate/unresolved gates;
757 known raw-blob duplicates and1277 wrong GP targets still prevent a complete
image-exact claim. The vtable and source-only policy audits pass.

SoundCar's four-byte readonly gap gained a new falsifiable source-context angle.
Original ASPSX2.77 fixtures reproduce offset104 just like the current assembler,
so the simple assembler-padding hypothesis failed. The native SimpleMem string
at800556C4 could supply a missing twelve-byte prefix: with section base556C4,
ordinary alignment would put the existing template at5570C and switch at5573C.
Compiler probes show an unused default-argument declaration emits no literal,
whereas an uncalled inline body can emit it without code. This mechanism alone
does NOT establish which original inline/header body existed; no dummy literal
emitter, padding object or guessed constructor was added.

A productive independent twin is mobile Track_Init/SimpleMem. Raw PE bytes
prove a tag-first,size-second constructor, and expose an allocator third-zero
argument omitted by IDA. Field/null/size stores corroborate the PSX inlined
region. The tag formal's original name, unused default-SimpleMem overload and
AudioCmn header context remain unproved. Generated ThisDust/SYM headers were
not treated as original-source evidence. Keep this original-context question
open rather than manufacturing a passing header.

Current receipts: ../p908_checkpoint/actual_source_receipt.json,
negative_controls.json, oracle_src_restored.json and relink.json;
../p908_audiomus_switchsong; ../p908_owner_contracts/references;
../p908_soundcar_rodata and ../p908_simplemem_context. P904-P908 remain local,
with no publication approval inferred from the earlier P898-P903 approval.
The full original-source/SYM/SLD goal remains active and incomplete.

## P909 / 2026-09-12: native HUD owner repairs real linked addresses; playlist scopes

The complete existing HUD .sdata240-byte source block now occupies its native
8013D89C..8013D98C range. All33 storage identities are checked against SYM:
28 public cells and five LOCAL statics. The four function statics keepup,
oldCountdown, lastsec and lastsectick retain their real owners and numeric
compiler UID suffix handling; file-static BTC_playedsoundalready keeps its
exact name and LOCAL binding. Named storage covers143 bytes; the other97
remain literal/alignment bytes, not fabricated source variables. Every byte
of the full240-byte run is independently ROM/CPE-exact. The incorrect old
140-byte/-fconserve-space source comment is corrected without changing code,
types, initializers or compiler options. HUD's separate .sbss76/.data668/
.bss1226 remain independent ownership work.

The mixed r20 raw donor is split into its original36-byte prefix,240-byte HUD
middle and380-byte suffix. All656 bytes and133 original raw symbol records
survive, with exact MIPS small-data flags and zero relocation sets preserved.
The middle remains in an oracle-only leaf; pre/post remain at their native
addresses in both applicable lanes. All21 additional raw-only labels have
zero live input references, so no compatibility aliases are added. The later
appended duplicate source240 bytes are removed; only that extra-data suffix
naturally shifts earlier. This is not a rewrite of compiler-produced objects.

The actual normal linked image is identical to the independently verified
private image. Hud_kTurnSongOffNext now resolves to native8013D940, repairing
SwitchSong's two old LO16 failures at8007A188/8007A1B4. The actual full function
is now62/62 raw-exact, and all six references to the flag (four Music HI/LO
words plus two HUD GP stores) match retail. This supersedes P908's actual60/62
result through a real source-owner correction, not forced verifier symbols.
All250 HUD reference target/addend/encoded-word records and all33 storage
identities are verified against the actual selected sections and map.

Wrong GP targets fall1277 ->1124:153 newly correct HUD references and zero
regressions among all1101 previously correct GP references. All2381 resolve,
with zero overflows, encoding mismatches or native/raw expectation conflicts;
three expectations remain unknown. All3845 prior native-correct public records
and86 previously established file-qualified native LOCAL records are preserved.
All533 changed linked code words occur at existing relocations (118 LO16,
415 GP), with opcode/register bits and code geometry unchanged. Of698 original
link inputs,697 are literally unchanged; only the verified raw r20 split object
differs. The full image still has inherited overlaps and incorrect bindings;
neither250 reference checks nor normalized PASS is a whole-image runtime seal.

The first HUD guard test exposed two existing generic flag-check omissions:
dropping MIPS_GPREL or adding SHF_MERGE was accepted. The frozen553/555 failure
receipt is retained. An optional exact section_flags contract, enabled only
for the new HUD row, fixes both; the actual production guard passes555/555
(39 valid cases,516 unsafe cases). Other33 rows and their established paths
are unchanged; this does not claim their optional high-bit flags now have
full coverage. There are34 initialized owners, six zero owners and31 exact
oracle exclusions. Known raw-blob duplicates fall757 ->729, with no REAL
duplicates, phantoms or referenced unresolved symbols in the scoped relink.

AudioMus_BuildPlayList also has a source-only lexical/statement improvement:
the manually rotated loop and hoisted i become a normal for(int i...) inside
the existing nonnull guard. Removing the redundant final return produces all
four native blocks, with i in depth3 at8007AEE8..8007AF58, INT/register a3;
the two parameter names/types/homes remain native. SLD0/11 ->0/0, and the
actual linked34 words match retail. All23 Music functions/206 branches and22
neighbor full contracts remain unchanged, including SwitchSong's restored
scope/SLD0/0. Both actual normal HUD and Music objects are literally equal to
the round's baseline despite the legitimate source improvements.

Fresh combined verification:85/85 functions and739 branches, actual62-word
SwitchSong and34-word playlist equality,555 actual guard controls,250 actual
HUD reference encodings, full GP/public/local preservation, both scoped relink
lanes GREEN, source-policy/vtable audits PASS and an unchanged objdiff report.
Raw header comments were clarified after landing; reassembly proves identical
objects in build and expected. User edits and untracked files are preserved.

Authoritative receipts: ../p909_checkpoint/integration.json,
playlist_actual.json, final_gp_audit.json, actual_scoped_local_preservation.json,
actual_guard_controls/results.json and final_transport.json;
../p909_hud_owner/actual and actual_references; ../p909_audiomus_playlist.
P904-P909 remain local and unpushed; no publication authority is inferred from
the earlier approved checkpoint. No new source ASM, volatile, invented names
or post-compiler instruction/object rewrites were introduced. Remaining HUD
storage, SoundCar/header context and tree-wide source/SYM/SLD debts stay open.

## P910 / 2026-09-12: complete HUD initialized/zero owners and BuildPattern scopes

HUD's initialized .data668 bytes now occupy native80120924..80120BC0. All11
storage declarations are native typed records: nine GLOBAL arrays and two
file-static ULONG[30] needle tables. Their662 declared bytes plus six real
alignment zeros match source, ROM and complete CPE loads. The mixed raw r15
donor preserves all3288 bytes,30 symbol records and six suffix R32 pointer
targets/addends as pre1580/HUD668/post1040. The two raw D needle labels have
zero live references and remain only in the oracle leaf; no aliases are added.
The stale bss(zero) annotations on the two color arrays are not storage truth:
current initialized section and CPE evidence establish .data. Initializer-token
spelling is not inferred solely from zero values.

The separate HUD .sbss76 reservation now occupies8013DE00..8013DE4C as NOBITS,
with all14 original LOCAL identities,69 named bytes and seven alignment bytes.
CountdownTick is native function-static ULONG, with a numeric compiler UID;
the other13 names are file statics. PTR STRUCT sizes describe pointees, not
pointer-cell storage. There is no CPE load in this span and no NOBITS file-offset
payload or invented ROM-zero hash was used. Original76 transport bytes and15
raw labels remain in the oracle leaf. The entire raw604-byte tail tree and73
symbols are preserved; native pre44/post28 stay fixed.

Eight unreferenced raw GLOBAL exports used names that native SYM calls STAT:
g1Player, gSprite0, gSprite1, currentSpriteColor, HudSplitTimeDiff1/2,
PerpOverlayOn and PerpOverlayMessage. Those wrong-global exports are retired
in favor of the actual source LOCAL cells at the same native addresses. This
is an explicit binding correction, not a hidden preservation exemption.
Biglen is different: its native8013DE64 address, width4, binding/visibility and
bytes are preserved; only its output container becomes .tail_after_hud_sbss.

Zero-owner validation gains HUD-only exact section_flags and symbol_visibility
checks; all old six rows and their behavior remain unchanged. All268 controls
pass, including a beyond-EOF NOBITS sh_offset positive case. The source input
alignment is8. An intermediate private link exposed the generator's hardcoded
SUBALIGN4; using each owner's explicit alignment with default4 fixes HUD output
alignment to8 while preserving all six old output alignments. That alignment4
intermediate is frozen and is not final evidence. The initialized-data guard
adds only the new row; all predicates remain unchanged and66 negative controls
reject wrong metadata/payload variants.

The actual combined ELF is literally equal to the independently reviewed final
private alignment8 image. All32 initialized-data and140 zero-owner reference
encodings are exact. Wrong GP targets fall1124 ->1006:118 newly correct HUD
references, with all1254 previously correct GP bindings preserved. All2381
resolve, with no overflow, encoding mismatch or native/raw conflict. Three
expectations remain unknown. All3864 ordinary native public full records are
preserved, plus the explicit biglen container transition; the eight wrong-global
STAT exports are separately corrected. Root also rechecks91 previously
established file-qualified native LOCAL contracts, all preserved.

Every one of2336 changed executable-input words is an existing relocation with
both old/new encoding verified:1816 LO16,361 GP,140 R26 and19 HI16. This audit
includes executable input sections inside non-executable .data_rest outputs.
All3238 previously native-positioned STT_FUNC records and addresses are preserved.
Four already-unanchored code inputs shift backward76 bytes as generic storage
shrinks: feapp10208 bytes, xform400, C52 eight and C_00296. Their code/relocations
are unchanged, but their placement remains debt; do not claim all code geometry
is unchanged. An inert24-byte SN-LNK blob also moves, with zero references and
no input relocations; it is not another callable function.

All696 retained original inputs are identical; only the two verified raw donors
change. No new allocated-overlap area/multiplicity appears. The callback's
existing raw o21 overlap persists with .data_rest's new position. Raw duplicate
count falls729 ->720; removing the eight wrong-global STAT exports is not counted
as eight source duplicate removals. There are35 initialized owners, seven zero
owners and33 exact oracle exclusions. The broad runtime layout remains incomplete.

AudioMus_BuildPattern now uses the existing native i in a for-init declaration,
with total-song and32-entry capacity bounds in one ordinary compound condition.
It preserves left-to-right reads and terminates before either call when full.
The implicit final void exit restores the loop-tail/epilogue group. All four
native scopes, pattern PTR CHAR/s1 and i INT/s0 are exact; SLD0/72 ->0/0.
The compound for header's single-line expression grouping matches native861;
no unrelated statements were compressed or debug/output labels rewritten.
The wrapped-header and return-only intermediate failures remain recorded.
All23 Music functions/206 branches and22 neighbor full contracts are unchanged.

Final combined checks:85/85 functions,739 branches; actual linked SwitchSong62,
Playlist34 and BuildPattern52 words match retail; raw build/expected/private
objects are identical; both scoped relink lanes are GREEN; source-policy and
vtable audits pass; objdiff report remains unchanged. New tool changes have
comments/backups. No source ASM, volatile, invented name or compiler-output
rewrite was introduced. P904-P910 are local and unpushed. HUD's separate
.bss1226 and stale historical scalar-split/G4 comments, other wrong bindings,
SoundCar's missing header context and tree-wide original-source/SLD debts
remain open. See ../p910_checkpoint and the p910_hud_data/p910_hud_sbss receipts.

## P911 / 2026-09-12: DriverStartUp scopes, HUD comment truth, BSS placement debt

AudioMus_DriverStartUp now places its four existing locals (chunks, size,
sndlimits, opts) only in the native stream-creation scope. Separate nested
streamhandle and streambuffer tests recover the seven SYM blocks; implicit
void exit restores the final store/epilogue SLD group. Native records
19f683..19f7ed establish the exact scopes and all six parameter/local homes:
buffersize s2, spusize s0, chunks s1, size s2, sndlimits AUTO -64 and opts
AUTO -40, with the original INT/SNDLIMITS/SNDPLAYOPTS types. SLD mismatches
fall from 12 merges / 18 splits to 0 / 0. No name, helper or codegen device
was added. All 23 Music functions, 206 branches and 22 neighboring complete
local/lexical/SLD contracts remain unchanged. The actual compiled object is
literally unchanged; the actual linked 81 words are independently raw-exact.

HUD's two obsolete scalar-split comment blocks are replaced by the current
native array contracts: three GLOBAL INT[2] view arrays and one LOCAL BOOL[2]
PerpOverlayOn. The supposed split backing stores are absent from current
source, and the old -G4 discussion does not describe the actual -G8 build.
Twenty-four zero-data annotations now distinguish CPE-loaded .data (two)
and .sdata (22) from uninitialized reservation. Independent review verifies
each typed SYM record, native MAP section and complete zero-valued CPE load.
This does not recover original initializer-token spelling from zero bytes.
All 24,795 code tokens are unchanged. Private and actual-path checks preserve
62 HUD PASS functions, 533 branches and every lexical/SLD instruction graph;
the actual HUD object is literally unchanged.

The proposed six-array HUD .bss owner remains NOT LANDED. Its native range
8013E390..8013E85A is 1,226 NOBITS bytes, flags 3, alignment 1, six LOCAL
arrays with exact native names, types and extents. All 54 source references
and 121 owner controls pass privately. Eleven existing unconditional oracle
fallbacks can become conditional PROVIDEs at unchanged values: the actual
oracle HUD object's 54 references still resolve through all 11 names. This
conditional edit would be overwritten by make split, however, so a narrowly
validated generation solution is required before any future landing.

More importantly, native placement increases existing allocated-overlap
multiplicity from two to three across all 1,226 bytes. The proposal is
explicitly rejected despite its successful reference checks. Current .data
and .rodata_rest spill across that range. Ranked read-only prerequisites:
Collide .data (64 bytes, whole ROM/CPE-exact) is the smallest native-owner
candidate; GenericPMX .data (1,304 bytes) needs original pointer-array order,
not a payload-only registration; Camera .data (1,404 bytes) needs declaration
order plus 102 initializer-byte corrections. These three alone cannot clear
the entire catch-all overlap: at least 17,516 misplaced .data bytes and the
separate readonly spill need authoritative recovery. No arbitrary repacking,
source padding, invented names or overlap waiver is accepted.

Final normal-path checks preserve all 698 link inputs and the complete ELF
and map literally. Both scoped relink lanes, vtable and source-policy checks
are green. The prior 35 initialized owners, seven zero owners, 33 oracle
exclusions, 720 raw duplicates and 1,006 wrong GP targets are unchanged.
Fresh checks cover 85 functions and 739 branches, not a new whole-board count.
The report is not regenerated: identical code inputs preserve its existing
result. Full original-source/SYM/SLD and runnable layout goals remain open.
P904-P911 are local and unpushed; the earlier P898-P903 publication approval
was consumed by 7aef1e7c. User edits and unrelated untracked files are preserved.
Receipts: ../p911_checkpoint, ../p911_audiomus_driver,
../p911_hud_comment_cleanup and ../p911_hud_bss/PREREQUISITES.md.

## P912 / 2026-09-12: Camera initializer repair and three native data owners

Three complete source .data owners now occupy their native addresses, replacing
only their exact raw reconstruction-lane duplicates: Collide_gRegistry[16]
(64 bytes at 80110C30), Camera's ten arrays (1,404 bytes at 8010F2AC), and
GenericPMX's seven arrays (1,304 bytes at 80112B2C). The raw r06/r07/r09 objects
remain intact for src/oracle. Their build and expected objects reassemble
literally unchanged after comment-only clarifications. This is ordinary source
compilation and linker-input ownership, not postcompile rewriting.

Camera_gFlags[19] had malformed flat initializers that repeated the packed
flag word into coordinates and one-bit fields. Native SYM1e05ee..1e06b0 defines
coorddef arm plus six INT one-bit fields at bits 96..101. Correctly nested
initializers recover every coordinate and bit value, fixing 102 source data
bytes. ROM and complete CPE loads independently agree. Explicit zero
initialization of the existing Camera_gInfo[2] makes its 544-byte storage lead
the initialized tables. The resulting full 1,404-byte source run matches
retail, including all ten original names, bindings and extents plus three
alignment bytes. No new name, type, padding object or macro is invented.
Original initializer/macro token spelling is not uniquely proved by this data;
the source comment and peer review retain that distinction. Camera's copied
clock-module caption and wrong BSS annotations are also corrected.

Both Camera stages preserve all 38 PASS functions, 382 branches, and existing
local, lexical and SLD instruction graphs. The initializer-value correction
alone changes no code word. Restoring the data order changes seven existing
LO16 relocation addends; all 204 own data references retain their native
cell/interior target. The actual linked image verifies all 268 Camera owner
references, including outside consumers. Other Camera BSS/external references
are not thereby declared native, nor are all Camera source statements sealed.

GenericPMX's zero-filled payload had hidden five wrong named-array offsets.
Native records 27bd72..27be86 place Spark/StartUp/Weather before Flare/Lightning.
The source now follows all seven native declarations; its .sdata group and
entire function/body/tail, including pre-existing mixed line endings, are
unchanged. Fresh checks preserve its 593 instructions and 18 branches, all
local/scope/SLD graphs and all implicit relocation addends. All 46 actual linked
references across six objects resolve to native cells and raw words. The extra
raw D_80112B84 label is gWeatherPixmap[2], with no live reconstruction reference;
it remains available to the Weather_CreateSplat oracle. The unproved pmx_height
carrier and SLD 0 merges / 1,377 splits remain explicit future recovery work,
not hidden by the corrected declaration-order caption.

Collide's registry already had the correct source type and 64-byte payload.
Its source-owned linked symbol was at the wrong address; native placement fixes
all four HI/LO references while preserving its actual NOTYPE/size-0 metadata.
Native SYM independently supplies the 16-pointer, 64-byte extent. The raw
input's size-64 metadata was not the prior linked winner. Its one-line source
comment now identifies CPE-loaded .data. All 14 PASS functions, 716 branches,
the complete object and debug assembly remain literally unchanged.

The three strict metadata rows append to the prior 35, preserving all existing
generated owner indices and validator predicates. All 3,161 actual-object guard
controls pass: 40 valid cases accepted and 3,121 malformed cases rejected.
Every Camera and GenericPMX payload byte is mutation-tested, and old wrong-order
objects are rejected even when their zero payload matches. Protected tooling
and linker/source backups are under ../p912_checkpoint/backups.

Actual normal-path integration matches the independently reviewed private ELF
in all allocated payloads, program/section geometry, ordered symbol entities
and relocations, with only two precisely checked scratch-to-real FILE paths.
All 318 owner-reference words are native-exact (Collide 4, Camera 268, PMX 46).
The 1,356 changed executable words are all existing HI/LO relocations with
both old/new encodings checked; no non-relocation instruction bits or code
inputs move. All 3,874 previously native public records, 104 FILE-qualified
LOCAL records, 3,238 native function records and all 2,381 GP target/status
records are preserved. Wrong GP targets remain 1,006; three expectations stay
unknown. Following unanchored legacy data shifts by 2,772 bytes as duplicate
storage is removed, with no increased allocated overlap area/multiplicity.

Fresh actual checks cover 53 PASS functions and 1,116 branch checks. Both scoped
relink lanes, vtable and source-policy checks are green. The complete before
and after objdiff reports are literally identical; that report does not prove
data layout or source/SLD completeness. Raw duplicates fall 720 -> 707, with
38 initialized owners, seven zero owners and 36 exact oracle exclusions.
Only the Camera and GenericPMX code objects change; the other 696 original
objects remain on disk unchanged, including the three now-excluded raw leaves.
The actual link retains 695 of the original 698 inputs.

The rejected HUD .bss placement remains blocked by broader .data/.rodata_rest
spill; these 2,772 bytes alone do not clear it. No overlap waiver is taken.
The full original-source/SYM/SLD/runtime-link goal remains open. P904-P912 are
local and unpushed; no broader publication approval is inferred. GenericPMX's
previous EOL-only file status is now promoted to a scoped source edit while its
unrelated body/tail bytes are preserved. See ../p912_checkpoint,
../p912_combined_owners, ../p912_camera_data and ../p912_genericpmx_order.

## P913 / 2026-09-12: native GenericPMX scopes and HrzSku data ownership

GenericPMX_LoadTexture now reproduces all 48 ordered native SYM scope spans,
depths and declaration owners, up from 45. The two leaf/MONF inner blocks place
their existing pmx declarations at native depth 5. A multiline GNU statement
expression containing only the three existing final ChangeTPage calls restores
empty block 27bd2a. No dummy expression, invented local or macro name is added.
Ordinary final braces were tested and discarded: they are optimized out and
restore only 47 scopes. All 34 recorded names/types/homes remain exact, including
the 27 separate pmx owners. The actual normal object remains literally identical:
593 instructions PASS, 18 branch checks. SLD remains 0 merges / 1,377 splits in
the 27 pixmap allocation/load/store groups; exact scope topology does not seal
those source statements or prove original macro/initializer spelling.

The pmx_height issue is now more precisely characterized, not hidden or renamed.
Native Texture_LoadPmx record 46bf5f names argument five ry, not height; h is a
separate callee local. The existing caller identifier has no native identity,
and even the current optimized debug stream omits it. The source comment now
says SOURCE-RECOVERY-UNRESOLVED, not an apparent SYM-backed carrier claim. No
current tools/*.py exemption keyed on the old comment marker was found; this
is a correction to human-facing evidence, not a loosened audit rule.

Production-compiler RTL dumps were captured with emitted assembly identical to
untraced compilation. The current form starts with a single user pseudo 84 =160;
it remains unallocated globally and reload rematerializes all 21 values in t0.
The literal form creates per-call temporary constant pseudos, CSE shares values
and a saved register carries a constant. Pseudo 84 itself acquires REG_EQUAL
during CSE, so absence of that note in initial RTL is not the whole mechanism.
These traces explain the current output, not an original name or proof that a
distinct source object is necessary. Full-scope literal removal still emits
579 instructions, 494 diffs and five branch-target differences. Statement-
expression and fabricated inline-helper probes also failed; the latter adds
f/n locals absent from native SYM and must not land. Initializer-placement probes
using only existing native locals were neutral. All remain private diagnostics,
not a floor claim or permission to add another carrier. Original header/macro
context and an evidence-directed literal/value expression remain next angles.

HrzSku's complete nine-object .data run now occupies native 801202F8..80120924.
All 1,580 bytes, original names/types/dimensions and GLOBAL bindings match SYM
40f50b..40f65d, ROM and full CPE loads. Eight objects are arrays; gHrz_Lightning
is a scalar 104-byte structure. Source declarations, initializers and code
remain unchanged. The wrong HUD-module caption and nine false BSS annotations
are corrected as comments only. All 22 functions PASS with 170 branch checks;
the actual object and every existing debug/local/SLD graph remain unchanged.
Unproved function-local carriers such as pv are separate source-recovery debt.

The raw 1,580-byte prefix becomes data_hrzsku_legacy.data.s for the oracle lane.
The original r15 file retains its 1,040-byte suffix at the native address, with
all seven symbols and six R32 language pointers. All 2,620 original raw bytes,
19 symbol records and six relocations survive. The three unused prefix aliases
D_80120664, D_801207F8 and D_80120838 disappear only from reconstruction and stay
available in the oracle leaf. The separately restored HUD owner is untouched.

The new strict row appends to the previous 38 without changing any existing
entry, generated owner index or validator predicate. All 1,765 actual guard
controls pass: 19 valid cases accepted and 1,746 malformed cases rejected,
including a mutation of every payload byte. Actual raw build/expected objects
are literally the proven split objects; no private object is copied into a
normal output and no compiler instruction/object rewrite is used.

The actual linked ELF is literally the reviewed private image. All 50 HrzSku
reference words are native-exact. Existing 3,887 native public records, 109
FILE-qualified LOCAL records, 3,238 native functions and all 2,381 GP target/
status records are preserved. All 751 changed executable words are existing
relocations with both states checked (726 LO16, 25 HI16). No code input moves
and no overlap area/multiplicity increases. Later unanchored raw data shifts
back by 1,580 bytes. The suffix's six pointers and whole payload stay native.
An initial private relink path-classification artifact is frozen; the actual
normal relink is green without any classifier adjustment or waived duplicate.

Combined actual verification: 23 PASS functions, 188 branch checks, green
owner/vtable/source-policy/relink checks and an unchanged full matching report.
Raw duplicates fall 707 -> 698; there are 39 initialized owners, seven zero
owners and 37 exact oracle exclusions. All reconstructed code objects and 694
of 695 original input files are unchanged; only the raw r15 donor becomes its
verified suffix. The new raw prefix is excluded from the reconstruction link.
The broader layout/SYM/SLD goal remains incomplete, including the HUD BSS
overlap and GenericPMX's literal/macro/SLD work. P904-P913 remain local and
unpushed. No new reconstructed-body asm, volatile, invented identifier or
postcompile rewrite was introduced. Receipts: ../p913_checkpoint,
../p913_genericpmx_native, ../p913_genericpmx and ../p913_hrzsku_owner.

## P914 / 2026-09-12: Horizon source recovered; strict identity review mode

Horizon_InterpolateLineSCoords is now source- and SLD-valid within its complete
native function contract. The previous source incorrectly used p as a product
temporary and invented pv for the cached percentage. Native record 40dcdd says
p is the INT value in a0, owned only by the else block at 800CF61C..800CF6AC.
The multiplication products are unnamed compiler temporaries in v0. Native i
is the root loop counter in t0. The independently matched NFS2 PC source at
C:/Temp/nfs2-clean/pc-beta/match/Horizon/Horizon_InterpolateLineSCoords.c confirms
the same ordinary for-loop and else-local p structure.

The repaired body uses direct signed product /65536 coordinate assignments,
the original i, and else-local int p = *percentage. It removes pv, the false
product role of p, the artificial i | (i & 3) reference identity, and obsolete
fence/dialect comments. No replacement name, fence, asm, volatile, dummy local,
or output rewrite is introduced. The scalar arm still reads *percentage before
the n<=0 exit, and the array arm re-reads it after storing vx, then advances by
one int. Native VOID overrides IDA's spurious BOOL return; M2C's typed-pointer
increment rendering is not copied as a four-int stride.

Actual verification proves all 80 raw words, all three native scope spans/
depths, six parameters with eight native argument/register location records,
and the two local names/types/homes. SLD 0 merges /232 splits becomes 0/0.
All 21 neighbors' full declaration, lexical, SLD and compiler-label graphs are
preserved. The whole actual HrzSku object is literally unchanged and all 22
functions/170 branches remain PASS. The patch is confined to this target's
body/comment. apply_patch initially normalized a few adjacent context line
endings; a guarded formatting-only repair restored the exact original prefix
and suffix bytes, then the actual compile and full checks were repeated.

The tracked read-only declaration auditor now has opt-in
--strict-source-identities. The default output is retained for compatibility,
not as an original-source completion certificate. Strict mode stops accepting
matching-only annotations as exemptions for missing SYM-CARRIER locals, extra
codegen/register-asm locals, extra source-only globals, missing split aggregates,
their extra scalar components, and same-name scalar/array carrier mismatches.
Existing optimized/inline, ABI, canonical, macro, compact-static, host/common
and primary type/storage-override categories stay distinct and still require
their own evidence. The mode does not certify foreign header bounds, initializer
values, local value roles, SLD or complete runtime layout.

This corrects the P913 tools-only search limitation: the actual legacy scratch
auditor does recognize SYM-CODEGEN-CARRIER. GenericPMX's unresolved annotation
therefore exposes pmx_height in both modes; Horizon now has no pv declaration
or finding in either mode. Neither marker changes nor names copied from a
plausible semantic role count as source restoration.

Independent tests pass 33 policy assertions and four real historical/current
pv/pmx_height cases, including all six suppression paths, inverse/unsized array
shapes and preserved primary categories. On all four frontend/game common/psx
directories, new default report bytes and stdout exactly equal the backed-up
tool, and default -> strict -> default reuse is stable. Current strict reports
expose the following review queue (not newly introduced runtime defects):

| Directory | Legacy declaration-clean | Strict declaration-clean | Legacy extra locals | Strict extra locals |
|---|---:|---:|---:|---:|
| frontend/common | 780 | 613 | 48 | 484 |
| frontend/psx | 85 | 60 | 0 | 53 |
| game/common | 1226 | 1085 | 8 | 474 |
| game/psx | 392 | 258 | 3 | 395 |

These 1,406 strict extra-local review items need individual source evidence;
the lower legacy total of 59 relied on matching-carrier exclusions. The tool
does not establish that every review item is wrong, nor that its remaining
explicit categories are automatically original. See STRICT_SOURCE_IDENTITY_REPORTING.md.

All 695 normal link inputs, the complete ELF/map and the regenerated matching
report remain literally unchanged. Native owner validation (39 data, seven
zero), both scoped relink lanes, vtable and source-policy checks pass. User
edits are preserved. No Git mutation has occurred; P904-P914 remain local.

Separate DrawW work is still PRIVATE: G8/native compiler-default diagnostics,
native Cars[9] and gSkidMarkPixmap[2] declarations, a compatible incomplete Night
extern and primary initializer repairs produce 35 PASS/361 branches and native
1,776-byte .data plus36-byte .sdata. Its native-owner/link closure and existing
regional USA dependency repair are not part of this source/auditor checkpoint
and must not be reported as landed. The full original-source/SYM/SLD goal stays
active. Receipts: ../p914_checkpoint, ../p914_horizon_native and
../p914_identity_review; pending work: ../p914_draww_storage.

## P915 / 2026-09-12: DrawW native declarations and data ownership landed

The DrawW work recorded as private in P914 is now integrated into actual source
and both raw build lanes. Cars_gList and Cars_gHumanRaceCarList are correctly
declared as nine pointers, and gSkidMarkPixmap as two pointers. The deliberate
false one-element skidmark declaration is removed. Night's caller declaration
uses a compatible incomplete outer array; its owning definition remains [2].
DrawW's original caller-bound spelling is absent from its surviving SYM and is
NOT uniquely recovered by this result.

The installed compiler's ordinary G8/default behavior, these corrected foreign
declarations, the original identity MATRIX diagonal values and explicit zero
initialization of stackSpeedUpEnbabledFlag together recover all 14 native storage
objects: 1,776 bytes of .data at8011F570 and36 bytes of .sdata at8013D81C. This
includes both genuine eight-byte LOCAL arrays, goffsets and function-static
offsets. Two nonzero bytes missing from the matrix are restored. Native size
evidence constrains the threshold to8<=G<24; the installed default is8, but the
historical command-line spelling is still unproved. No arbitrary padding,
invented storage, replacement alias or ordinary source-body change is involved.

The actual base source passes all35 functions and361 branch checks. Its complete
normal object equals the frozen candidate except for the exact FILE path;
all35 existing declarations, lexical scopes and SLD partitions are preserved.
This preserves the prior contract, not a claim that all existing DrawW locals,
source statements or macro spellings are already original. Strict game/psx
review still reports258 declaration-clean functions and395 extra-local items.

The USA source previously failed to compile because it referenced six removed
compatibility-view families. Its bounded repair uses the already-declared
native Camera, GameSetup, simGlobal, Trk_NewSlice, BWorldSm_slices and TrackSpec
objects/types. The standing regional pipeline selects the actual base G8 row;
its compiled object equals the independently raw-verified USA candidate except
for the exact temporary FILE path. All35 actual-USA instruction streams and359
internal branches are preserved; this is not a fully linked USA image proof.
Inherited VA breadcrumbs in that regional source still refer to the base image.

The raw DrawW tail remains as an oracle-only source file. All3,456 preceding
bytes, all other donor sections and110 relocation records are preserved. Both
native source sections are placed by strict whole-section owner contracts;
the actual41-row validator passes2,091 controls:30 valid and2,061 rejected
malformed cases. All39 prior owner rows and validator predicates are unchanged.

Private whole-link proof plus exact actual-image transfer covers all265 selected
native references, all14 cells/1,812 initialized bytes,3,896 previously native
public records,109 FILE-qualified LOCAL records and3,238 native functions.
Exactly34 DrawW GP sites become correct: known wrong targets1006->972, with all
1,372 already-correct sites preserved. Every one of1,280 changed executable
words is an exact existing relocation encoding; no code movement or new overlap
is introduced. Allocated duplicate storage drops by1,812 bytes, and raw duplicate
symbols698->686. Existing unanchored data movement is explicitly receipted.

Both actual standing relink lanes, native data/zero owner contracts, vtable and
source-policy gates pass without private path-classifier substitutions. The
fresh complete matching report is literally identical to P914. Of695 original
normal inputs, only DrawW's source object and the split raw donor changed.
Original unchanged-line EOL bytes were restored after patch application, with
complete logical-text equivalence checked before compilation. No compiler
output, opcode, relocation or debug label was rewritten; user edits remain.

P904-P915 remain local. Approval for P898-P903 applies to the already-published
7aef1e7c, not these later changes. DrawW's remaining source-local/macro/SLD debt,
GenericPMX's unresolved original expression and macro grouping, and the wider
layout/identity review queue remain open. This checkpoint is not a full-source,
full-SYM/SLD or runnable-link completion claim. Receipts: ../p915_checkpoint,
../p914_draww_storage and ../p914_draww_peer.

## P916 / 2026-09-12: GetAnimationTime source/SLD restoration and publication

DrawW_GetAnimationTime now has only its original track and maxTick locals.
SYM3e3a12..3e3af8 puts track in the root scope and maxTick in the nested else
scope; the former source's root maxTick plus invented result/tick carriers did
not reproduce that contract. The repaired ordinary conditional minimum keeps
maxTick first in the comparison and puts the complete return selection on one
source line. This matches the operand order in the reconstructed NFS2 nfs2.h
MIN expansion, but exact original NFS4 macro tokens remain unproved. NFS2's
ealib.h has a different equivalent macro, so sibling evidence is not overstated.

The actual function retains all 33 instruction words and four internal branch
targets, with animInst in a0 and original track/maxTick in a1. All three native
scope spans/depths match. SLD changes from 0 merges/73 split pairs to 0/0.
The return's unnamed load/result values are now generated by the compiler, not
declared as guessed source objects. No asm, volatile, new helper or fabricated
source identifier was added. The whole actual DrawW object is literally equal
to P915; all 35 functions/361 branches and all 34 neighbor contracts survive.
Independent review also checks all six HI/LO records against primary native
targets and every retained compiler label's real function-relative PC. Compiler
label-number drift is not an output rewrite or a permission to move a label.

The fresh strict game/psx report improves declaration-clean coverage 258->259
and extra-local review items 395->393. The legacy default remains at 392 clean
and 3 extra-local items because it previously hid these two names.
The wider review queue and other DrawW source/SLD work remain incomplete.

User requested commit, push and pause. Remote main's two intervening commits
(40a6597a and82005b8a) were inspected and fast-forwarded without overlapping
the 60 scoped restoration paths. All seven changed C translation units were
actually recompiled and their full objects are byte-identical. All 694 normal
inputs, complete ELF/map and the freshly regenerated report remain unchanged.
Both standing relink lanes, 41 native initialized-owner contracts, seven zero
owners, vtable and source-policy gates pass. The existing source-static
locaterequest@800FC4E4 uses an explicit diagnostic name/VA mapping; no compiler
or source identifier was rewritten to satisfy the oracle filename.

The publication checkpoint includes verified P904-P916 source/tooling/data
restoration and its selected receipts. Unrelated user/EOL edits, generated build
outputs, backups and all failed experiments remain excluded. Private DrawC
seven-object data restoration and centerline rn-removal probes are NOT landed
or part of this commit. Their bounded handoffs are ../p916_drawc_storage and
../p916_draww_centerline; both agents stopped. The full original-source/SYM/SLD
goal is not complete; work pauses after publication as requested. Receipts:
../p916_checkpoint, ../p916_animation_time and ../p916_animation_time_peer.
