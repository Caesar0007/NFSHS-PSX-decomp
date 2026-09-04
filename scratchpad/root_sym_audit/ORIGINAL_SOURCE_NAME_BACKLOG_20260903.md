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

## Open items

| Owner/function | Retained unresolved identifier | What is proved | Missing evidence / closure condition |
|---|---|---|---|
| `recon/game/common/replay.cpp` — `Replay_ResetReplay__Fv` | `piVar2` (decompiler placeholder, not an accepted semantic replacement; invented `counterCursor` was rejected and reverted) | A distinct decrementing pointer is required: direct array indexing produces 87 rather than 86 instructions and one oracle mismatch; retained form is PASS 86/86. | Retail SYM names only `i`; recover the pointer's original source spelling from canonical/source-bearing evidence. |
| `recon/game/common/copspeak.cpp` — `CopSpeak_PlayNextRequest__Fv` | `iVar3` (decompiler placeholder, not an accepted semantic replacement; invented `queueIndex` was rejected and reverted) | A distinct cached queue index is required: direct global indexing/advancement produces six oracle diffs; retained form is PASS 71/71. | SYM names only `r` and `handle`; recover the cached index's original spelling. |
| `recon/game/common/aihigh.cpp` — `AIHigh_Execute__Fv` | `bVar1` (decompiler placeholder, not an accepted semantic replacement; invented `executeHighLevelAI` was rejected and reverted) | A distinct decision object is required: direct short-circuit reconstruction produces 61 rather than 66 instructions and 33 oracle diffs; retained form is PASS 66/66. | SYM names only `carLoop` and `carObj`; recover the decision object's original spelling. |
| `recon/game/common/pausemenu.cpp` — `PauseMenu_MenuText__FsbT1` | `iVar1` (decompiler placeholder) | A distinct `TextSys_WordX` result statement is required: inlining the call remains count-exact but causes two scheduling diffs; retained form is PASS 25/25. | Retail SYM retains no result-local name; recover the original spelling from source-bearing evidence. |
| `recon/game/common/nfs3.cpp` — `NFS3_CheckForFileOperations__Fv` | `e` (temporary placeholder, not an accepted source spelling) | The former guard-only `g` declaration was eliminated: repeating `gFileMgr.handlearray` is CSE'd to the exact retail guard value. A distinct loop bound remains required for PASS 21/21; direct loop comparison changes allocation. | Retail NFS4 SYM retains only `p`; this PSX-only function has no NFS2 PC counterpart, and the checked reference trees retain no source name for the bound. Recover it from canonical/source-bearing evidence or eliminate it with a byte-exact loop form. |
| `recon/game/common/aih_opp.cpp` — `AIHigh_Opponent::CheckForWipeOut` | `numRacers`, `bVar1`, `hlai`, `speedLimit`, `carIndex`, `field1380`, `slotAddr`, `absField`, `state` (all placeholders, including semantic-looking spellings) | Detailed GCC allocation/scheduling receipts prove that distinct source-shape quantities are required for the current PASS 120/120 body. | Retail NFS4 SYM retains only `perTickProb`, `randVal`, `oppLevel`, `oppFines`, `hLoop`, `thisPlayerObj`, `thisPlayer`, and `playFines`. Recover every other spelling from canonical/source-bearing evidence; behavior and register role are insufficient. |
| `recon/game/common/aidatarecord.cpp` — `AIDataRecord_t::StartUp2` | `pAVar1` (decompiler placeholder) | Retail SYM retains only `recordLoop`. Ordinary `recordCollection[recordLoop]->Setup()` emits 22 rather than 27 instructions and 11 oracle diffs because GCC devirtualizes the call; the explicit cached object/vtable dispatch remains PASS 27/27. | Recover the exact cached-pointer spelling from source-bearing evidence, or find an ordinary C++ expression that preserves retail virtual dispatch without an extra named source object. |
| `recon/game/common/aidatarecord.cpp` — `AIDataRecord_t::CleanUp1` | `pa_Var1` (decompiler placeholder) | Retail SYM retains no local. Ordinary `delete AIDataRecord_BestLine` / `delete AIDataRecord_TrackCurve` emit 18 rather than 28 instructions and 24 oracle diffs; the shared cached vtable row remains PASS 28/28. | Recover the exact source spelling from source-bearing evidence, or restore a class/deleting-destructor declaration that makes ordinary `delete` reproduce retail dispatch. |

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

Current measured queue: **1,592 unresolved carrier-marker rows project-wide**,
of which **600 are in `recon/game/common`**.  There are currently **24
`ORIGINAL-NAME-RECOVERED` evidence rows**.  These counts were measured from the
working tree on 2026-09-04 and must be regenerated after each recovery round.

## Strict per-directory snapshot through P838

These reports measure the current source tree; they are evidence of remaining
work, not completion certificates.  `Explicit source-only codegen carriers`
counts unique function/name mappings, whereas the 1,592 figure above counts raw
marker rows (a few names have more than one scoped marker row).

| Directory | SYM functions | Mapped | Declaration-clean | Missing names | Extra names | Type/storage findings | Source-only carriers | Mapping review |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `recon/game/common` | 1,258 | 1,258 | 1,228 | 0 | 6 | 28 / 28 | 600 | 0 |
| `recon/frontend/common` | 838 | 833 | 781 | 0 | 46 | 9 / 9 | 519 | 3 |
| `recon/frontend/psx` | 85 | 85 | 85 | 0 | 0 | 0 / 0 | 54 | 0 |
| `recon/game/psx` | 395 | 395 | 392 | 0 | 3 | 0 / 0 | 395 | 0 |
| `recon/eaclib/psx` | 5 | 5 | 5 | 0 | 0 | 0 / 0 | 5 | 0 |
| `recon/lib` | 0 | 0 | 0 | 0 | 0 | 0 / 0 | 0 | 0 |
| `recon/syslib/psx` | 0 | 0 | 0 | 0 | 0 | 0 / 0 | 0 | 0 |

The authoritative report files are
`game_common_strict_p838_20260904.md`,
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

### Retained after P813 source-shape retests

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
