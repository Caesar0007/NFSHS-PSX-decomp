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
| `recon/game/common/replay.cpp` — `Replay_ResetReplay__Fv` | `piVar2` (decompiler placeholder, not an accepted semantic replacement; invented `counterCursor` was rejected and reverted) | A distinct decrementing pointer is required: direct array indexing produces 87 rather than 86 instructions and one oracle mismatch; retained form is PASS 86/86. | Retail SYM names only `i`; recover the pointer's original source spelling from canonical/source-bearing evidence. |
| `recon/game/common/copspeak.cpp` — `CopSpeak_PlayNextRequest__Fv` | `iVar3` (decompiler placeholder, not an accepted semantic replacement; invented `queueIndex` was rejected and reverted) | A distinct cached queue index is required: direct global indexing/advancement produces six oracle diffs; retained form is PASS 71/71. | SYM names only `r` and `handle`; recover the cached index's original spelling. |
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
