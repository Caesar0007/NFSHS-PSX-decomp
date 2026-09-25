# SYM match — making the source agree with the retail `NFS4.SYM`

Status as of 2026-09-25. Current full-debug board: `build/psyq_g/symtree_report.json`.

2026-09-25 (session from commit 4eff2f1a). SLD line matching is parked by the user for a later
stage; this round is the native contract (locals, homes, scope trees) only. Every retained
change passed `symloop.py` (BYTES UNCHANGED), and the whole tree was rebuilt, relinked and
measured afterwards (honest 299819/299819, vtable audit PASS, link-stripped 0 violations).

- The 52 remaining in-function `if (0) sprintf((char *)0,"SimpleMem")` carriers were converted
  to the file-scope unused inline class-name form (`tools/psyq_pipe/simplemem_inline.py`, kept as a
  scratch tool). One symloop run over all 52 TUs: BYTES UNCHANGED, 930 functions compared. The
  constant-false call had been leaving two empty debug scopes in each first function; they are
  gone. Only one of those functions became CLEAN outright (the others carry further issues), so
  the board moves 1781 -> 1784 with the two items below.
- `Night_AdditiveNightCalc`: retail `lookup` ($v0) is the night-table byte and `addColor`
  ($v1) the colour word fetched with it; ours had folded `lookup` into `addColor`. Split as
  `lookup = Night_gNightTbl[index]; addColor = *(long *)&Night_gAdditiveHeadlightColor[lookup];`
  the sums read `addColor`. 64/64 bytes unchanged, function native CLEAN; NIGHT 14/19.
- `DashHUD_CheckWrongWay`: the camera anchor IS the car (`Car_tObj::N` is at offset 0) and the
  word at 0x3F0 is `Car_tObj::wrongway` (retail MOS record), not a byte-shifted
  `N.collision.lastOtherObj` reached through `anchor + 1`. `car` is now the loaded pointer, as
  retail's `car` ($v0) is. Bytes unchanged, function native CLEAN; DASHHUD 5/6.
- Reverted trials, receipts: `AI_TryToShareLanes` MOVED `absLaneIndex` ($a2 ours, $v1 retail =
  the lane-relative index): assigning the global read to the condition and the `-7`/`-6`
  result to `absLaneIndex` moved the gap tail (20+ diffs); in-place `absLaneIndex -= 7` moved
  49. `Hud_BuildTimeString` REGPARM `time` ($a2 ours, $a1 retail): in-place
  `if (time < 0) time = -time;` 21 diffs, two `__builtin_abs(time)` reads 8 diffs. Both stay
  open. `AI_CalcMeritsBasedOnSpeed` (30 scopes vs retail 1): the per-call scope pairs are not
  from `+=` (plain assignment reproduces the same tree at PASS bytes) nor from a `(...)`
  prototype (probe shows none); `fixedmult` has NO declaration in that TU (implicit
  declaration) -- untested lead.
- Stale byte references: `symloop --ref-only` reported BYTES MOVED on untouched TUs because the
  committed 2026-09-22 SimpleMem rodata tag (12/16-byte prefix + LO16 addends) and the
  `CopCarTypeLights-22` address post-date the Sep-20 references. `tools/psyq_pipe/ref_refresh.py`
  archives such a reference to `scratchpad/symloop_ref_archive_20260925/` and re-adopts it;
  the proof is the fresh honest link (0 diff) at the same commit, checked before adopting.
- Mechanics of the SN debug records, measured with `tools/psyq_pipe/gprobe.py` (standalone `-g`
  probe) and `tools/psyq_pipe/sldprobe.py` (real TU, tags aligned to the real object; `var_fn.py`
  splices a candidate function body and reports both): the function's `line` is the line of its
  `{`; `.begin`/`.bend` values are relative to that line minus one, so the function block
  always starts at 1; a block's end line is the highest line note seen inside it; sched2
  re-emits BLOCK_BEG/END notes at the head of their basic block, which is why retail scopes so
  often sit zero-length at a block boundary; a header-defined inline called on line L gives the
  `{L {L }L }L` pair with its body instructions tagged L, while a same-file inline leaks the
  callee's `{` line (clamped to 1); an `if` condition is tagged with its `)` line; the epilogue
  carries the last statement's line. These are for the parked SLD stage.


FETOURN source-line round: `CalcTierFinishPrize` omits a redundant `return;`,
`ReleaseDescription` uses the retail-aligned guard/brace layout without its
redundant return, and `GetTrackList` omits a non-emitting blank line before
the call. Fresh `symloop.py` reports BYTES UNCHANGED for the full 35-function
TU and 18/35 native CLEAN; strict SLD improves from 3/35 to 6/35, with
these functions exact across all 11, 15, and 14 instruction-relative tags
respectively. The source-line evidence does not establish exact original
whitespace or punctuation. `GetAwardInformation` then became strict SLD-exact
across all 16 tags after a reconstruction-only explanatory comment was moved
above the method instead of occupying retail source lines inside it. Fresh
`symloop.py` still reports BYTES UNCHANGED, 18/35 native CLEAN; strict SLD is
now 7/35.

AudioCmn_Init in `recon/game/common/audiocmn.cpp` now keeps the two explicit
array bases as const pointer snapshots. Fresh `verify_asm.py` reports
PASS 94/94 and whole-TU `symloop.py` reports BYTES UNCHANGED (48 functions).
The two non-retail `ambient`/`mystic` debug locals disappear; `setup` and four
vs one lexical scopes remain unresolved. AUDIOCMN remains 42/48 native CLEAN
and 20/48 strict SLD; this is a category reduction, not a newly clean function.

Clock_SystemCleanUp in `recon/game/common/clock.cpp` now uses a separate
guard brace line and omits the redundant void return. Fresh `symloop.py`
reports BYTES UNCHANGED for all three functions, and strict SLD agrees on
all 12 instruction tags; CLOCK is 2/3 native CLEAN and 1/3 strict SLD.
`Clock_MasterInterruptHandler` still needs the non-retail `even128` carrier:
the direct condition with the existing fence gives 43/43 instructions but
two positions differ and was reverted.

For AudioCmn_SoundCar, moving `roadProduct` to a const use-site declaration
kept 530/530 bytes but did not remove its extra native debug local. Inlining
the product at its fence input and shifted use emitted 529/530 instructions
and seven differences. Both experiments were reverted; the distinct value
web is still required by current source codegen, but original source-object
identity is unproven.

FECARS native-scope round: `SellCar` and `RemoveFromPinkSlipsList` now form
each of the removed, previous, and selected slot addresses with one const
expression; their wrapper blocks were removed. Each function retains its
96/96 or 82/82 retail instruction stream, while all three non-retail REG
locals per function and four non-retail lexical scopes disappear. Fresh
`symloop.py` reports BYTES UNCHANGED across all 46 functions and native CLEAN
improves 42/46 to 44/46; strict SLD remains 17/46. These address snapshots
are codegen-supported source shapes, not proof of EA's exact spelling.
The `GetTournamentFinishPrize` const-pointer trial emitted 28 instead of 29
instructions (three diffs) and was reverted; its native mismatch stays open.

FEFADES is now a fully strict native/SLD TU: 6/6 functions native CLEAN and
6/6 strict SLD, with all 207 instruction-relative line tags, lexical blocks,
and function spans exact and the full object BYTES UNCHANGED. The two
CalcTextFade helpers expose distinct const call results and returns at the
retail line regions; CalcOnOffFade groups its SYM locals and the three
source-only table-color values into declarations and separates paired fade
statements at the retail lines. The latter values are named by their proven
table columns (3/4/5), not by invented color semantics; SYM does not reveal
EA's original identifiers or punctuation. `tOptionsMenu::UpdateTransition`
use-site const `item` changed 22 instructions and was reverted, as was the
const x/y trial in `tMenuItemControllerLeftRightChoice::Draw` (33 diffs).

FASTRAND is now 2/2 native CLEAN and 2/2 strict SLD: placing the empty
FastRandom_CleanUp braces on separate lines aligns both retail instruction
tags, with its two-function object BYTES UNCHANGED.

FECREDITS `Setup` and `DeInit` now omit redundant void returns and are strict
SLD-exact (4/4 and 3/3 tags); the seven-function object remains byte-identical.
`RealDeInit` uses the retail-aligned guard and return regions and now matches
all 16 instruction tags, improving from 12 mismatches. It is not strict:
the function lexical block closes at relative line 11 in ours versus 10 in
retail despite the same end address (+0x30). Same-line brace trials did not
change that record and were reverted. FECREDITS is 5/7 native CLEAN and
2/7 strict SLD; the remaining source form is not inferred from line tags alone.

HRZSKU source-line round: `Hrz_KillHorizon` and
`Hrz_CalculateLightning` omit redundant void returns; the former places its
first call in the retail line region. `HrzSetPsxTranslation` separates the
three translation stores from the matrix-upload call by the retail source
line gap. Fresh `symloop.py` reports BYTES UNCHANGED for all 22 functions;
native remains 16/22 CLEAN and strict SLD improves 1/22 to 4/22 (11/11,
15/15, and 20/20 instruction tags for these three functions). This does not
claim their exact original whitespace.

LOADING `GetInitialMemory` now omits its blank pre-store line and redundant
void return, giving strict SLD 8/8 with the three-function TU BYTES UNCHANGED.
LOADING is 2/3 native CLEAN, 1/3 strict SLD. A const use-site `y` in
`UpdateLoadingScreen` preserved its 62 instructions and removed the extra
REG local, but introduced three non-retail lexical scopes; that trade was
reverted. The original addend idiom is still unresolved.

OBJECT source-shape round: `Object_GetObjDefID` separates its final return
into the retail line region; `Object_DeInitIMassObjectInfo` omits a redundant
void return; `Object_InitStatus` is now a counted `for` loop (a natural
source shape that reproduces all ten retail instructions and SLD tags);
`Object_GetAnim` uses an unbraced null guard. Fresh `symloop.py` reports
BYTES UNCHANGED for all 32 functions, native remains 25/32 CLEAN, and strict
SLD improves 2/32 to 6/32. Each of the four functions is individually
native-clean and strict-exact (21/21, 10/10, 10/10, 11/11 tags).
The `StatChk_SaveRecordLapTime` const use-site `newBestLap` trial preserved
100 instructions but reversed the global-address/value registers (six
diffs); it was reverted and the existing carrier remains on review.

OBJECT continued: `Object_KillStatus` also uses a counted `for` loop with
an unbraced delete guard (27/27 byte-PASS and strict SLD), and
`Object_FindDefWithThisID` uses the retail-aligned unbraced inner guard
(22/22 byte-PASS and strict SLD). The full 32-function TU remains BYTES
UNCHANGED; native stays 25/32 CLEAN and strict SLD rises 6/32 to 8/32.
A two-const staging of `CalcObjYawAngle` kept its bytes but improved only
10 to 8 SLD tag mismatches while inventing non-SYM source objects; it was
reverted pending a better-supported source form.

OBJECT `Object_DeInitCustomObjects` now uses three unbraced guarded purges,
then the three global clears. This naturally places each guard, call, and
clear at its retail SLD line and removes a redundant void return. The
24-instruction function is native CLEAN and strict SLD-exact; fresh full-TU
`symloop.py` reports BYTES UNCHANGED (32 functions), with OBJECT strict
coverage rising 8/32 to 9/32 and native unchanged at 25/32.

OBJECT `Object_GetIMassObjectDimensions` now places its struct copy on the
retail SLD line and omits a redundant void return. A two-line non-emitting
source gap is explicitly marked as unrecoverable text, not asserted to be
EA's original comment or statement. It is native CLEAN and strict SLD-exact
(11/11 tags), with the full 32-function object BYTES UNCHANGED; OBJECT is
now 25/32 native CLEAN and 10/32 strict SLD. `Object_ClearCustomObjects`
already matches retail lexical-scope *addresses*, but its source line fields
and the ten-line gap before the first traffic-car loop remain unresolved.

AIHIGH source-shape round: `AIHigh_Restart1` and `AIHigh_Restart2` omit
redundant void returns and non-emitting gaps, making their 8/8 and 10/10
retail SLD tags strict-exact. `AIHigh_CleanUp` uses a counted `for` with its
single SYM `carLoop` declared in the loop, and a separately braced inner
delete guard; this reproduces all 35 retail instructions, native local/scope
records, and SLD tags. Fresh full-TU `symloop.py` reports BYTES UNCHANGED
across 7 functions; native stays 4/7 CLEAN and strict rises 0/7 to 3/7.
`AIHigh_Execute`, `StartUp`, and the base constructor still have native
local/scope residuals requiring structural source recovery.

FEMENU range-iterator source-line round: `tListIteratorRange::Value`,
`Increment`, and `Decrement` now match their retail line regions. Their
three-line non-emitting preambles are explicitly labeled unknown source
text, not fabricated as EA statements; the increment/decrement methods
also omit redundant void returns. The indexed-range constructor omits its
blank pre-store line and redundant return, while its increment/decrement
use one-line guards and assignments with no redundant return.
`tMenuItemGoToMenuButton`'s constructor likewise omits a pre-store blank
line and redundant return. Fresh `symloop.py` reports BYTES UNCHANGED across
all 71 functions, native stays 63/71 CLEAN, and strict SLD rises 44/71 to
51/71. This proves retail debug-line equivalence for those functions, not
exact original punctuation or the contents of the non-emitting preambles.

DRAW small-method source-line round: `Draw_InitViews`,
`Draw_RestartRenderEngine`, `Draw_SetDrawSyncCallback`,
`Draw_DeInitRenderEngine`, `Draw_SetViewMemBudget`,
`Draw_SetEnvironment`, `Draw_InitLibRender`, and
`Draw_DrawDirectScreen` now match native SYM and strict SLD. These edits
remove redundant void returns and place calls/stores on retail line regions;
the three-line non-emitting gap in `Draw_DrawDirectScreen` is marked as
unknown original text. Fresh full-TU `symloop.py` reports BYTES UNCHANGED
for all 25 functions; native remains 17/25 CLEAN and strict SLD rises
1/25 to 9/25. A multiline `CancelAsyncLoad` comparison trial in FESCREEN
shifted 28/38 tags, so it was reverted; its two-tag split remains open.

DRAW `Draw_SetViewColor` now uses the canonical PsyQ 4.3 `setRGB0` macro
form from `C:/Temp/nfs4-clean/psyq43/PSX43/psx/include/libgpu.h:119`.
Retail SLD assigns each three-store RGB expansion to a single source line;
the macro call, guarded on that same line for each drawenv, reproduces all
24 instruction tags and native scope/locals while keeping the full 25-function
TU BYTES UNCHANGED. DRAW is now 17/25 native CLEAN and 10/25 strict SLD.
This is positive canonical-source evidence for a macro idiom, though the
retail record cannot prove every character of EA's original invocation.

DRAW `ClearPrimitivesBuffer` now groups each guarded purge on its retail
source line, groups the two server-pointer clears, and omits a redundant
void return. The 26-instruction function is native CLEAN and strict SLD-exact;
the full 25-function TU remains BYTES UNCHANGED and DRAW strict rises 10/25
to 11/25. The adjacent `ClearPlatformPrimitivesBuffer` has a five-line
non-emitting region before its clears and another gap before the comm-mode
guard; their original source contents are not established by this trace.

DRAW native-ownership round: `AllocatePrimitivesBuffer` now declares
`view0`/`view1` inside the multiplayer arm and `view` inside the other arm.
The native nested scope tree, local types/registers, and exact start/end
addresses now agree with retail; all 79 instructions remain PASS.
`Draw_StartRenderingView` now computes the signed `/8` bias as two const
expression snapshots (numerator and biased numerator) before the clip stores.
They emit no extra retail-SYM locals and preserve all 46 instructions. A
single const quotient gave 46 instructions but eight diffs; a const numerator
with `/8` at the store gave 45 instructions and 13 diffs; both were rejected.
Fresh full-TU `symloop.py` reports BYTES UNCHANGED for all 25 functions and
native CLEAN improves 17/25 to 19/25; strict SLD remains 11/25. The exact
original C expression spelling for the bias is not proven by these gates.

Current combined checkpoint: `scratchpad/sym_source_checkpoint_20260922/verify.py`
and `receipt.json`. Freshly validates both touched TUs together:51/51bytePASS,
939/939raw linked instruction words across seven changed functions,44unchanged
neighbor contracts, unchanged whole objects/ELF/map and honest0diff. Earlier
per-round receipts describe their historical deltas; use this combined driver
for the current retained changes. Partial SYM/SLD findings remain explicit.

2026-09-23: AudioCmn_AddBank now gives native p ($v1) the filename walk and
ptemp ($s1) the allocated bank buffer. Its SYM function contract is CLEAN,
Audio.obj first improves to4/6CLEAN and stays6/6bytePASS. Early SLD lines through
the filename scan agree; the later statement positions and span remain open.
The SimpleMem literal now comes from the unused inline class-name form rather
than a constant-false call in Audio_InitDriver. That function's two excess
empty scopes disappear, making Audio.obj5/6CLEAN with unchanged loaded
sections and relocations. Its raw ELF section-symbol ordering changes, so
whole-object file identity is not claimed; the linked-image gate is separate.
Audio_DeInitDriver's two missing retail scopes are not created by adding
ordinary nested braces around the function body and restore/free calls;
that byte-neutral, scope-neutral experiment was reverted. Their original
source construct remains unknown.
Audio_InitDriver's full 56 instruction-relative SLD tags, lexical-block line
fields and function span now agree. `AudioCmn_AddBank` remains SLD-partial.
Audio_FECleanUp now also has all18 instruction-relative tags, block-line
fields and span exact, with the same compiled body. AudioCmn_LoadBank now
matches all33 tags/line fields/span, and Audio_CleanUp all23. AUDIO strict
SLD is4/6. Audio_CleanUp still carries an unreferenced `game*` literal via a
constant-false call; available SYM/SLD and binary bytes do not identify the
original source expression for that datum.
Proof: `scratchpad/sym_audio_addbank_20260923/README.md`. The 2026-09-22
combined checkpoint covers the earlier two TUs only; this is a separate TU.

tCarManager::LoadDescription now holds native data in $a0 as `input + 4`, the
file payload sent to blockmove. The allocation result stores directly into
fCars. FECARS first improves35/46 ->36/46CLEAN and stays46/46bytePASS; entire
allocated object payloads and honest link remain unchanged. Its relative SLD
layout is still unresolved. The old FECARS byte reference included a phantom
16-byte `"%s%s.viv"` prefix owned by Feaudio.obj; raw-ROM/LO16 proof precedes
its explicit refresh. Receipt: `scratchpad/sym_fecars_load_20260923/README.md`.

GetStockCar then removes its non-retail `viewable` local through a direct
field assignment before the two zero stores. All47instructions, lexical-block
line fields and function-relative SLD tags match; FECARS is37/46CLEAN and
46/46bytePASS. The former direct-after-zero form cost6diffs and remains
rejected. Same receipt directory above.

GetNumTourneyCars no longer declares synthetic carID. It tests the signed
garage ID, stores the ID in carInfo, and reuses carInfo.fCarID for lookup.
All42instructions remainPASS; its local list is retail-exact and FECARS is
38/46SYM-clean. Its instruction line map is still partial. A repeated
garage-index read cost19diffs and was not retained.

tListIteratorCarColor::Increment now uses a direct signed wrap guard, so
fNumColors and notWrapped are anonymous compiler values rather than source
locals. This removes the last non-retail local from that function while
keeping38/38bytePASS. All38relative SLD tags, block-line fields and span
also match; FECARS is39/46SYM-clean,46/46bytePASS.

SetCarAvailable and SetCarViewable now use direct guarded stores and have
all7relative SLD instruction tags, block-line fields and spans exact each,
with the same machine code. Decrement now keeps native `offset` as the
player-index product (SYM optimized-away REG:$ffffffff) and indexes the
signed car ID at each use, rather than storing the combined index in a
real register. It remains32/32bytePASS and matches all32relative SLD tags,
block-line fields and span. At that point the whole-FECARS audit was40/46native
CLEAN and6/46strict relative SLD; the other functions remain on the line
and source-shape review queue. The SLD-compatible formatting does not
uniquely prove EA's original whitespace or braces.

The adjacent tListIteratorCarColor::Value now computes the native
player-index `offset` (optimized-away REG:$ffffffff), rather than casting
the player pointer into a synthetic offset. All24code words still match.
Its trailing instruction tags and function span now align: the whole
FECARS file is41/46native CLEAN and7/46strict relative SLD. The five
remaining native mismatches are still open.

CalcUsedPrice's synthetic `upgrades` local is now removed: direct garage
field tests compile to the same single retail byte load and keep67/67PASS.
Its native locals and frame now agree, but one block-end address still
differs, so it remains one of FECARS's five DIRTY functions.

FindSimilarCar now gives `i` the inner counter ($t0), `j` the outer counter
($t4), and `carColor` the raw order-table byte ($a0); the old source named
the derived `>>3` group instead. IDA register annotation and retail SYM
agree on these roles. All109instructions remain byte-PASS; the native
function contract is CLEAN, but its relative SLD map is still open.
FECARS advances to42/46native CLEAN,7/46strict SLD. Four native mismatches
remain.

The short tListIteratorCar Increment/Decrement wrappers now omit redundant
void returns and match each two-line retail function span and all8relative
instruction tags. Both stay byte-PASS and native-clean; FECARS reaches
9/46strict relative SLD matches.

SellCar and RemoveFromPinkSlipsList now use named frontend fields and direct
`fNumCars` reads; a conditional store replaces each `newSelection` local.
That removes three non-retail locals from each without changing their
96/96 and82/82byte-PASS bodies. Both remain DIRTY because address-staging
locals and extra scopes remain. Flat address expressions were tested and
rejected after changing four or nine retail instructions; a direct slot-31
store also reversed one `addu` operand pair and was rejected. Their source
identities and SLD layouts remain on the review queue.

ValidCar now dispatches on the native UCHAR `fCarClass` field with a switch,
removing the synthetic int local. The switch retains the retail signed
range checks and all243byte-PASS instructions; direct field if-tests lost
two instructions. Native locals, homes and frame now agree, but the source
still emits five debug scopes against retail's eleven. Its SLD/source
structure remains open, so FECARS is still42/46native CLEAN.

GetCarFromID and GetCarFromSimID now also align their complete 20-instruction
relative SLD maps, lexical-block line records and spans. Their byte-PASS
and native-clean states are unchanged; FECARS reaches11/46strict relative
SLD matches. Source-line equivalence does not prove exact original spacing.

GetNumOwnedCars and GetNumPinkSlipsCars now initialize `num` at declaration
and use a `for` loop, the grouping supported by their retail SLD records.
Both preserve17/17byte-PASS and native-clean contracts and now match every
relative instruction tag, block-line field and function span. FECARS strict
SLD advances to13/46.

GetNumTourneyCars now uses declaration-time `result` initialization and a
32-slot `for` loop, preserving42/42byte-PASS and the native SYM contract.
Its relative SLD mismatch fell to one instruction tag (+0x58, the class
byte load); block-line/span details still need recovery. A multiline
member access moved the call tag too and was rejected.

ReleaseDescription now omits the redundant void return and matches all16
relative SLD tags, block-line fields and retail function span, preserving
16/16byte-PASS. FECARS strict SLD reaches14/46.

CheapestCarStockPrice now initializes `returnprice` at declaration, as its
retail line map indicates. All22code words, native locals/homes, relative
SLD tags, block-line field and function span agree. FECARS reaches15/46
strict relative SLD matches.

SetClassAvailable now uses a top-tested for-loop with distinct car-ID and
class predicates; SetClassViewable keeps its nested predicates and omits
the redundant void return. They retain33/33 and27/27byte-PASS respectively,
and both now match every relative SLD tag, block-line field and span.
FECARS reaches17/46strict relative SLD matches.

tTrackManager::LoadDescription has the same native data role: input+4 is
held in $a0 before the allocation call, whose return stores directly in
fTracks. FETRACKS improves13/15 ->14/15SYM-clean, stays15/15bytePASS,
and the honest link remains0diff. Relative SLD lines/span still need work.
Receipt: `scratchpad/sym_fetracks_load_20260923/README.md`.

TextValue in the same FETRACKS TU no longer declares the decompiler-style
uVar1. The function remains16/16bytePASS and its native comparison has only
the extra trackEntry local, reduced from two extras. Direct expression forms
move10instructions; that remaining inferred local stays on the review queue.

Follow-up: TextValue's native `trackInfo` is the selected track record,
initialized from `fTracks[fValue[*fIndex]]`; the index cursor needs no
named local. Removing trackEntry this way preserves16/16bytePASS and
matches its native local/home/scope plus all16relative SLD tags, block-line
fields and span. The whole-FETRACKS census is now15/15native CLEAN and
1/15strict SLD; the other14functions still need source-line review.

FETRACKS ReleaseDescription and SetTrackAvailable now also match their
complete relative SLD traces (16/16 and5/5), lexical block lines and
function spans, with unchanged byte-PASS and native contracts. FETRACKS
is15/15native CLEAN and3/15strict SLD.

GetTrackByID now also matches all21relative SLD tags, block-line fields
and span with21/21byte-PASS. FETRACKS strict SLD reaches4/15. LoadTracks
and SaveTracks still have large source-line gaps before their loop bodies;
no original statements or comments have been inferred from that spacing.

GetTrack and Initialize now also match all28 and16relative SLD tags,
block-line fields and spans respectively, with unchanged native contracts
and byte-PASS bodies. Initialize resets the fields before setting its
short loop counter, matching retail statement order. FETRACKS reaches
6/15strict relative SLD matches.

The tListIteratorTrack destructor and constructor now match all10 and22
relative instruction-line tags, their block lines and spans. The
whole-file auditor normalizes CC1's `___` deleting-destructor debug name
to retail MND's `_._` form before comparison; this was a representation
gap, not a source mismatch. Both methods remain byte-PASS/native-clean.
FETRACKS reaches8/15strict relative SLD matches.

tListIteratorTrack Increment and Decrement now match their full43- and
36-instruction relative SLD traces, block-line fields and spans without
byte or native-contract regressions. Decrement uses a byte-identical
if/else source form in place of the old multiline ternary. FETRACKS
reaches10/15strict relative SLD matches.

tTrackManager::SetClassAvailable now places its reconstruction note outside
the function and omits a redundant void return. All24relative SLD tags,
block-line fields and span match without changing24/24bytePASS or native
locals. FETRACKS reaches11/15strict relative SLD matches.

tListIteratorTrack::ValidTrack now initializes both SYM-named locals at
declaration and aligns the switch case statement lines through its tail.
All42relative SLD tags, block-line fields and span match with42/42bytePASS.
FETRACKS reaches12/15strict SLD; only LoadDescription, LoadTracks and
SaveTracks remain line-map open in this TU.

FETRACKS backlog detail: retail LoadTracks' loop body maps to relative
lines+12/+13 and SaveTracks' to+11/+12 after a setup at+4. Independent
m2c bodies show only their simple byte-copy loops; no executed omitted
statement explains those source-line gaps. LoadDescription's retail call
anchors are+9 (sprintf),+13 (release),+16 (file load),+25 (allocation),
+28 (copy),+45 (purge). The missing source text between anchors cannot
be uniquely reconstructed from the current SYM, SLD or binary, so no
padding statements or invented comments have been inserted.

FEFADES' inline `TextDefinitionColor` no longer declares the synthetic
`colors` pointer; it indexes `kRGBVals` directly. The three inlining
consumers lose their `EXTRA colors` native findings without changing any
allocated object byte, relocation, or6/6function PASS status. A new
whole-TU census reports FEFADES6/6native CLEAN and2/6strict SLD; four
line maps remain open. The full honest link remains0diff. Evidence:
`scratchpad/sym_fefades_colors_20260923/README.md`.

FEFADES `CalcFadeVal(int,int,int)` now matches all36relative SLD tags,
block-line fields and span with36/36bytePASS. FEFADES reaches3/6strict
SLD; the two text-fade wrappers and CalcOnOffFade remain line-map open.

FECREDITS `tCreditManager::Init(int)` now leaves the unused ABI parameter
unnamed, as the retail SYM does, while retaining the trailing `i` mangling
and56/56bytePASS. The ignored byte reference was refreshed only after
proving a committed SimpleMem 12-byte `.rodata` prefix and two corresponding
LO16 addends+12; its old bytes are archived. FECREDITS is5/7native CLEAN,
7/7bytePASS and0/7strict SLD. DrawCurrCredit/SetupCurrCredit remain
native/SLD open. Evidence: `scratchpad/sym_fecredits_arg_20260923/README.md`.

FEDIALOG `tDialogBase::InitializeClass` and `HideAllDialogs` are now static
members, consistent with their absent retail `this` records, member
mangling, object-free raw bodies and the neighboring static dialog methods.
They remain8/8 and16/16bytePASS. Both complete source and oracle-side
rebuilds passed, and FEDIALOG is10/23native CLEAN,32/32bytePASS;
0/23strict SLD remains open. Evidence:
`scratchpad/sym_fedialog_static_20260923/README.md`.

FEDIALOG `tDialogBase::ProcessInput` now leaves its unused first and third
ABI parameters unnamed, as retail SYM does, while retaining its mangled
types and17/17bytePASS. FEDIALOG advances to11/23native CLEAN; source-line
work and12native findings remain open.

PAUSEMENU's unused virtual/member ABI arguments are now unnamed in the
eleven affected definitions (eight iterator methods, noninteractive Draw,
empty base ProcessInput, and left/right choice ProcessInput). The slider
ProcessInput also loses its unused `command` name, though other findings
remain. Mangled signatures and60/60function byte-PASS are unchanged.
PAUSEMENU advances36/58->47/58native CLEAN, with6/58strict SLD. Evidence:
`scratchpad/sym_pausemenu_params_20260923/README.md`.

The PAUSEMENU iterator Value/TextValue/Increment/Decrement pairs, empty
base ProcessInput and noninteractive Draw now also match all their retail
relative SLD tags, block-line fields and spans. Their native contracts and
machine bytes remain unchanged. PAUSEMENU reaches16/58strict SLD; the
other42debug-covered methods remain on the source-line review queue.

PAUSEMENU's eight derived and three root empty destructors now use
byte-identical one-line definitions matching their retail zero-line spans.
Four short constructors also shed redundant returns/body blank lines.
All15new methods are strict SLD-exact without native or byte regressions:
PAUSEMENU rises to31/58strict SLD, leaving27covered methods open.

Four more PAUSEMENU base-forward constructors now match strict SLD, bringing
the TU to35/58. Its varargs `tPMenu` constructor now uses `va_list`,
`va_start` and `va_end` instead of a hand-written stack-pointer expression;
the same19retail instructions and native local records remain. That method
is still three instruction-line tags short of strict SLD, with block lines
and span exact. PAUSEMENU stays47/58native CLEAN and60/60bytePASS.

Two more PAUSEMENU constructors, the indexed-slider Draw/ProcessInput
pair and menu Debounce now match their full retail SLD traces. They remain
byte-PASS and native-clean. PAUSEMENU advances to40/58strict SLD; seven
native-clean methods and eleven native-DIRTY methods still need work.

PauseMenu_MenuText additionally matches all25relative SLD tags, block
lines and span after moving its reconstruction note above the method.
PAUSEMENU reaches41/58strict SLD with unchanged bytes.

PAUSEMENU `PauseMenu_MenuTextPositioned` now initializes the NFS2-PC-
supported `short flags` at declaration, where retail SLD attributes the
word-flags call. Its30/30code words/native locals remain exact, and its
SLD mismatches fall23->16instruction tags. The remaining unknown
intervening source text is explicitly open; PAUSEMENU remains41/58strict.

FEMENU's two `tMenuItem::Draw` overloads now leave their unused coordinate
parameters unnamed, restoring their retail SYM parameter sets while
preserving15/15 and17/17bytePASS. Two left/right input methods similarly
lose an unused `command` name but retain other findings. The stale
pre-SimpleMem byte reference was archived and refreshed only after proving
its committed 16-byte aligned `.rodata` prefix; `.text`, `.data` and
`.sdata` were identical. FEMENU is60/71native CLEAN,12/71strict SLD,
73/73bytePASS. Evidence: `scratchpad/sym_femenu_drawarg_20260923/README.md`.

Both corrected FEMENU Draw overloads now also match every retail relative
SLD tag, block-line field and function span after their ABI notes moved
outside the bodies. FEMENU strict SLD advances12/71->14/71, with all
73/73function bytes and native contracts unchanged.

FEMENU's twelve empty iterator/menu destructors now use byte-identical
one-line definitions and match all their retail SLD tags, block-line
fields and zero-line spans. FEMENU advances to26/71strict SLD, staying
60/71native CLEAN and73/73bytePASS.

SetDimensions and four FEMENU iterator/item constructors also now match
strict SLD after byte-neutral statement-line placement and removal of
redundant returns. FEMENU reaches31/71strict SLD, still60/71native CLEAN
and73/73bytePASS.

FEMENU gains eight further strict-SLD methods from byte-neutral empty
wrapper, constructor and multiplayer-increment source grouping. It now
stands at39/71strict SLD,60/71native CLEAN and73/73bytePASS. The
remaining32line maps are explicitly unfinished.

Four FEMENU iterator `TextValue` methods now align all20relative SLD tags
and spans each by keeping the return expression on the retail source line.
FEMENU reaches43/71strict SLD,60/71native CLEAN and73/73bytePASS. A
short-typed x trial in tMenuItemLeftRightChoice::Draw changed five code
instructions and was reverted; that non-retail local remains under review.

FEMENU tMenu's constructor now follows retail SLD statement order:
fOptionsMenu/callback/title precede the two final reset fields. The same
17code words compile, with native locals and full SLD exact. FEMENU reaches
44/71strict SLD, remaining60/71native CLEAN and73/73bytePASS.

SCREENAUDIO's `GetShapeInfo`, constructor, and `Initialize` now have
native-CLEAN, strict-SLD-exact source layouts. `Initialize` no longer needs
the non-retail `menus` pointer: moving the first field store before the
direct `menuDefs` call reproduces the retail `$a2` reuse, 24/24 byte-PASS,
with all line tags and relative span exact. The whole TU is 7/7 byte-PASS,
3/7 native CLEAN, and 3/7 strict SLD. The other four dirty methods retain
their existing local/scope backlog.

STATTOOL `GetAINameFromPersonality` no longer has the non-retail `namePtr`
result carrier. The inverted early-return condition preserves the exact
15-instruction branch/call/return sequence; omitting the empty `if` braces
aligns its retail line tags and three-line span.

STATTOOL `GetAllDefaultRecords` now uses SYM's actual counter roles: `i`
is the inner `$s2` counter, `n` the outer `$s4` counter. Previously their
semantic uses were exchanged despite correct declaration order. Renaming
those uses leaves all 62 code instructions unchanged and makes the function
native CLEAN. The best-lap copy precedes the increment in source; `++i`
and `++n` in the loop conditions and retail line grouping make all 62 SLD
tags, scope-line fields, and the source span exact. STATTOOL is now 9/11
native CLEAN and 2/11 strict SLD.

STATTOOL `nCreateIndex` had the same counter-name reversal: SYM `i` is the
inner `$a2` insertion scan while `j` is the initial and outer `$s0` loop.
Swapping their source uses leaves 77/77 instructions unchanged and fixes
both MOVED records. The non-retail `one` carrier and one extra scope remain.
`ReadDefaultRecords` is now native CLEAN too: spelling its two `sprintf`
arms as a conditional call expression preserves 34/34 instructions while
removing three extra debug scopes. Its line map remains 29/34 different;
`switch` and single-call format selection changed code and were reverted.
STATTOOL is now 10/11 native CLEAN, 2/11 strict SLD; only `nCreateIndex`
remains native-DIRTY.

AUDIOCMN `UnPauseAndQuit` and `UnPauseAndRestart` now match their two
same-named SYM locals exactly. Retail's function-scope `i` owns the 128-step
volume ramp in `$s0`; a block-local `i` owns the earlier 71-channel loop in
`$s1`. Moving the nested declaration onto the channel loop corrects both
register records and the block start/end addresses while preserving both
58/58 and 63/63 instruction streams. AUDIOCMN advances to 36/48 native
CLEAN. Byte-neutral source grouping now makes every SLD tag, block-line
field, and relative span exact in both methods: `UnPauseAndQuit` 58/58 and
`UnPauseAndRestart` 63/63. AUDIOCMN's strict SLD coverage rises from 1/48
to 3/48 after the separate `UnPause` cleanup below.

AUDIOCMN `UnPause` no longer calls a reconstruction-only inline twin of
`AudioCmn_MusicLevel`. Writing the formula directly in its `AudioMus_Volume`
argument preserves the 35/35 retail instruction stream and removes the
helper's non-retail inlined `level` debug local and two scopes. The unused
helper definition is removed. Byte-neutral source-line grouping now makes
all 35 SLD tags, block lines and relative span exact. AUDIOCMN advances to
37/48 native CLEAN and 1/48 strict SLD.

AUDIOCMN `InitAsyncSfx` now declares `i` in the retail's inner source block:
its REG $a0 home and depth-two local record match. The 14/14 instruction
stream is unchanged. A const `inRange` at the loop head is optimized out of
native locals while generating the retail test-only scope at +16..+28. A
for-declared `i` with the explicit body test preserves 14/14 bytes, local
ownership, and the full block tree; AUDIOCMN rises to 39/48 native CLEAN.
Its relative SLD residual falls from 14 to 7 tags; the loop test and end
line attribution remain open. Condition-controlled `while` and `for`
alternatives rotated and shortened the code (13/14) and were reverted. A
direct-index trial for `LoadAsyncSfx` perturbed allocation (107/105), so
its byte-PASS pointer alias was restored.

AUDIOCMN `InitReverb` and `SetLevels` now align their complete relative SLD
tables (17/17 and 20/20) after byte-neutral source grouping and redundant
return removal. `RemoveAsyncSfx` likewise binds its native `s` pointer at
declaration and matches all 34 SLD tags and its source span, with the entire
object unchanged. These three methods remain native CLEAN and byte-PASS;
AUDIOCMN strict SLD coverage was 6/48 at this checkpoint.

AUDIOCMN's following native-CLEAN wrappers now also have exact SLD tags,
scope-line fields, and spans: `SirenOff` (47 instructions), `PlayFESFX`
(8), `PlayWrongWaySFX` (14), `PlayPauseSound` (14), `InitThunder` (5), and
`PlayThunder` (11). The source changes only remove redundant void returns
and align the thunder condition/store lines; all remain byte-PASS. AUDIOCMN
is now 12/48 strict SLD.

AUDIOCMN `LoadFESamples`, `DeInitAsyncSfx`, and `ReverbOff` now align their
full retail line maps (17/17, 14/14, and 10/10) through native pointer/loop
statement placement and redundant-return cleanup. All stay byte-PASS and
native CLEAN, taking AUDIOCMN to 15/48 strict SLD. In `GetTimePhrase`, a
single source expression for signed time adjustment matches the retail
branch layout and first five line tags; its scan remains 15/20 tags apart.
The compact `for` and short-circuit `while` trials rotated the bytecode and
were reverted. The table/scan source layout is still under review.

That `GetTimePhrase` layout is now resolved: the 25 threshold values occupy
individual initializer lines, the sign-adjusted seconds expression owns
retail line +1, and the byte-identical explicit scan owns line +32. All
20 instruction tags, block-line fields and the 33-line relative span match.
AUDIOCMN advances to 16/48 strict SLD without changing its 37/48 native
CLEAN census.

AUDIOCMN `GetAsyncSfx` now has retail-exact lexical ownership. An outer
block covers the first search; its loop-local `s` is declared only in the
match-check region, at REG `$v1` and depth three. The FOUND path uses the
corresponding slot element directly, and GCC reuses the live address, so
all 93 instructions remain byte-identical. Local records and every block
address match; AUDIOCMN advances to 38/48 native CLEAN. Its 60/93 SLD
residual remains open.

AUDIOCMN `MusicLevel` is now strict-SLD-exact: its two return arms share
retail source line +1, and the original 24-instruction stream is unchanged.
AUDIOCMN reaches 17/48 strict SLD. `GetTrackRecordLapTime` remains a four-
instruction byte-PASS with no local records, but its retail +4/+6 address/
load line split is not reproduced by an ordinary split member expression;
the awkward trial spelling was reverted.

AUDIOCMN `Pause` is now native-CLEAN and strict-SLD-exact across all 46
instructions after restoring the retail line grouping of the channel loop,
music stop, reverb test, and level stores. AUDIOCMN reaches 18/48 strict
SLD. In `GetAsyncSfx`, moving the FOUND source block next to the first
search emitted that block too early and changed 93 instructions to 95; the
exact byte-PASS dispatch spelling was restored. Its early-line attribution
remains under review.

AUDIOCMN `LoadGameSamples` now matches all 77 retail SLD tags, block-line
fields, and its 26-line span after aligning its startup, file path, track
bank and bank-ID source phases. `InitChannelArray` similarly aligns all 14
tags and its ten-line span. Both source edits are byte-neutral, leave native
locals and scopes CLEAN, and raise AUDIOCMN to 20/48 strict SLD.

SCREENCONTROLLER `Controller_SetRamp` now has retail-exact native locals and
scopes. An outer block owns short `i`; the loop block owns `type` and
`config`. The named `type` first receives the raw controller type in `$v1`
before its categorical assignment, correcting its debug home while the
83/83 instruction stream remains identical. Reconstruction trial notes were
consolidated outside the function so they do not claim retail SLD lines;
its 75/83 relative line tags remain unfinished. SCREENCONTROLLER advances
to 12/21 native CLEAN.

AIH_BASICPERP `RemoveChaser` now initializes its native `pos` at declaration
and is strict-SLD-exact across all 15 instructions. `Clear` now preserves
the for-scoped native `loop` and matches all 15 retail line tags after
moving its explanatory note outside the body. `AddChaser` also reaches exact
SLD: a local `result` receives `CheckChaserPosition` on line +11 and is
returned on +12. GCC optimizes that source-only temporary out of native SYM
and keeps all 21 instructions unchanged. The TU is 3/8 native CLEAN and
3/8 strict SLD, with all eight functions byte-PASS.

AIH_BASICPERP `CheckIfCaught` now declares SYM's `perpUpright` at function
scope between `absSpeed` and `skill`, and declares `xDot` after
`distanceAbsMeters`/`barrierInWay` in the later position-check region. The
previous ORDER finding disappears; all 380 instructions remain byte-PASS.
At that checkpoint its scope tree was not retail-exact (12 scopes on each
side but different nesting and addresses), so the method remained DIRTY. The five other
methods in this TU remain unchanged by these declaration moves.

Further `CheckIfCaught` source work uses the verified inline `GetCrime()`
at the +108 test and expresses both crime and finish-type exclusions as
shared-end guards. This retains 380/380 instructions and aligns the retail
block tree through +244. An immediate finish-type return instead shrank the
frame and changed 377 instructions, so it was reverted. Later blocks still
start at different addresses (+564 ours versus +556 retail, with additional
nesting around +764/+972), and SLD is not exact; native CLEAN is not claimed.

AIH_BASICPERP `CheckForCrimes` now calls inlined `AICop_BasicPerpInfo`
`GetCrime`/`SetCrime` members. Retail SYM records their entry and final
scope pairs, including a second block-local `crime` in `$s0`; the helper
names are semantic reconstructions because inline identifiers do not survive
in retail SYM. A conditional switch also removes the non-retail `wrongWay`
local while preserving 163/163 instructions. The entry and final scope
sequences now match exactly; two source-only `speed` aliases and the middle
scope tree remain open. Direct field reads in either speed arm changed code
(169/163 and 158/163), and the failed experiments were reverted. Full recon
and oracle-side no-link builds passed after the shared-header addition.

AIH_BASICPERP `RemoveCloseCops` now has retail-exact native locals and all
14 block addresses. The channel loop owns `copLoop`; its body owns `cop` and
`distance`; the close-cop arm owns `thisCop`. Inferred inline
`AIHigh_BasicCop::SetDriveAway` calls recover both typed receiver records,
and `AIHigh_Base::GetCarObj` recovers the final base receiver record. An
early AIFlags exit removes the extra enclosing scope. The 84-instruction
object remains byte-PASS, advancing AIH_BASICPERP to 4/8 native CLEAN;
all 84 instruction-relative SLD tags and the 29-line span now match, but
lexical block-line fields still differ, so strict SLD is not claimed. A
more natural early `continue` changed the body to 86 instructions and was
reverted; the byte-exact loop-tail label remains under review. Full recon
and oracle-side no-link builds passed
after the two shared class declarations were added.

The two `RemoveCloseCops` helper bodies are now exposed in-class only to
AIH_BASICPERP's owner-specific type surface. Other TUs retain declarations,
avoiding unwanted out-of-line copies in their key-function objects. This
keeps 84/84 bytes and native scopes unchanged while attributing the second
drive-away setter and base-car accessor inline body lines to their retail
call sites. The first setter scope and outer lexical block-line fields still
disagree. A split-semicolon spelling shifted instruction tags and was
reverted. Both full reconstruction and oracle-side no-link builds passed.

AIH_BASICPERP `CheckChaserPosition` now uses the verified inline
`AIHigh_Base::GetCarObj` for its entry car lookup, recovering retail's first
two nested inline scopes and `this` in `$v0` with the 87-instruction PASS
unchanged. The second car lookup remains a direct field read: using the
inline member there makes GCC preserve an additional C `blez` alongside the
current pinned guard and changes the loop tail/register band. Removing the
pin in that basin gives 85/87 instructions; loop-local declaration moves
did not repair it. All such experiments were reverted, retaining only the
byte-neutral first accessor. The later inline scope and full SLD remain open.

AILIFE's two traffic reincarnation functions now use a `const` declaration-
initializer for `paintIndex`. NFS2 PC supplies the recoverable original name;
CC1PLPSX 2.8.0 emits the same 44/44 and 131/131 code bytes but omits the
optimized const local from native SYM, matching retail. Directly inlining the
expression into the guarded color call changed scheduling (43/44) and was
reverted. AILIFE advances to 19/20 native CLEAN; its remaining dirty method
is `AILife_RCPickSliceAndDirection`, and these two SLD maps remain open.

AILIFE `RCPickSliceAndDirection` now uses the retail role of `offset`: the
named `$v0` local is the unscaled random distance, while `offset *
approachSide` is consumed anonymously by `WRAP_SLICE`. Separating those
roles preserves all 270 retail instructions and moves `offset` from `$a0`
to the SYM-required `$v0`. Early candidate `continue` guards also move the
named `checkCar` scope start from +328 to retail +416 without changing
bytes. Names, register homes, and block addresses match, but the later
strict depth audit found `checkCar` still bound at depth one rather than
retail depth three. AILIFE is therefore 19/20 strictly native CLEAN, though
all 20 functions remain byte-PASS. Function-relative SLD remains open.

The native comparator now reports local scope depth explicitly. Its prior
board had five false CLEAN cases despite matching block trees. Four are
source-corrected without byte changes: `AudioEng_Pause` declares `player`
in its for initializer; `Sky_InitStars` declares `oldSeed`/`i` inside the
star-initialization arm; `Object_AddCustomSimObject` scopes `simObj`,
`slicePos`, and `pt` to the custom-object arm; and `Replay_LoadCameraFile`
scopes `cameraFile`, `fname`, and `bigFile` to its guarded load. The sole
scope-only residual is AILIFE's `checkCar`. Comparator backup:
`scratchpad/symtree_cmp_pre_scope_20260923.py`; the 11 guarded-loop tests
pass. The strict board below supersedes the earlier count.

FRONT `GetLapsForType` no longer declares the non-retail `uVar1` result
carrier. Putting the tournament arm in an inverted early return preserves
42/42 retail instructions. The native `lapconv` local retains its AUTO:-8
home, and its two initialization stores now share SLD line +1 through a
source array initializer. Native comparison still reports only the scope
tree (1 versus 5 scopes) as DIRTY. The NFS2 PC counterpart uses a `switch`;
the NFS4 two-arm `switch` remains 42/42 byte-PASS and reduces the relative
SLD residual to 3/42 tags. A conditional-expression trial reversed the
retail branch layout, and an empty wrapper did not emit native scopes; both
were reverted. No invented empty scopes or names were added to make this
look complete.

FEAPP `SetScreen` is now native-CLEAN and strict-SLD-exact (all 20 line
tags, scope-line fields, and relative span). A blank source line before the
second guard plus the simple unbraced call removed the former closing-brace
line tag; the object remains byte-identical. FEAPP is 7/15 native CLEAN and
1/15 strict SLD. `DisplayHelp`'s direct-member trial still moved its variant
store out of the retail call delay slot and was reverted; its pointer carrier
remains unresolved.

FEMENUOPTIONS clamp backlog: the six `UpdateTransition` methods retain
non-retail `iVar1`/`iVar2` source locals. Both canonical NFS2-PC MIN/MAX
nestings changed19-23instructions in a representative method. A
single-evaluation inline clamp matched31/31bytes but introduced an extra
native local and two extra debug scopes, so it too was reverted. The
restored source and byte reference pass; the original single-evaluation,
scope-neutral source form remains unknown. Evidence:
`scratchpad/sym_femenuoptions_clamp_20260923/README.md`.

FEMISSION is now5/5native-function CLEAN and5/5bytePASS. In LoadDescription,
input is the loaded file in $s2 while data is the advancing payload cursor
in $s1. GetMissionToRace now uses its native currentTier pointer in $v0.
The whole-file strict SLD audit is3/5: GetMissionToRace aligns all17
instruction tags, block-line fields and two-line span; ReleaseDescription
aligns all15tags, block lines and five-line span; GetMissionStages now aligns
all26tags, block lines and six-line span. The two remaining functions need
SLD source work. The complete code stays byte-PASS. Evidence and positions:
`scratchpad/sym_femission_load_20260923/README.md`.

## Why this exists

`NFS4.SYM` is an output of EA's own link. PSYLINK wrote it next to `NFS4.CPE` and `NFS4.MAP`, from the debug records the
compiler (`-g`) and ASPSX (`-g`) put into every game object. It therefore describes EA's **source**, not only the code:

- every function's frame (size, saved-register mask, mask offset) and source line,
- every parameter and local: name, type, and home (register number or stack offset), in **declaration order**,
- the scope tree: every block that declares something, with its start and end address and line,
- a line table.

Matching code bytes does not prove the source is right: an invented local, an extra brace level, a wrong type or a member
function written as a free expression can all compile to the same bytes. The SYM sees all of those. Our toolchain is the same
as retail's (CC1PSX / CC1PLPSX 2.8.0, ASPSX 2.77, PSYLINK 2.73), so we can emit our own full-debug SYM from our source and
compare it with retail's, function by function.

The rule throughout: **the code bytes must not move.** Every change is kept only if the object's bytes are unchanged and
the honest link stays at 0 diff.

## Current numbers

| | Functions |
|---|---|
| Retail functions with debug records | 2570 |
| Compared (present on both sides) | 2565 |
| **Match implemented function checks (CLEAN)** | **1724** |
| Differ (DIRTY) | 841 |
| Files whose compared functions are all CLEAN | 50 of 177 |

The effort started at 1499 clean. The 5 retail functions not compared are the EA pad library's `PAD.C`
(`recon/eaclib/psx/pad.c`), which is outside the two directories the debug compile covers.

Honest link: 299819/299819 words = 0 diff. Overlap audit: 0 masked RECON mismatch bytes
(not zero physical overlap bytes); foreign-label gate 0/0.

End-to-end smoke test: `AudioClc_CalcDistance` corrected the exchanged value roles of `length` and `length1`,
preserving declaration order and the entire compiled object. Fresh native SYM comparison changed it from two MOVED
findings to CLEAN; `audioclc.cpp` improved from16/18 to17/18 CLEAN. Fresh honest link and reference guards stayed green.
Receipt: `scratchpad/sym_pipeline_check_20260920/README.md`. CLEAN still excludes the coverage gaps listed below.

The follow-up `AudioClc_GetClosestCars` round restored its native for/continue traversal, `searchdist` scope and
distance variable roles:15 scopes ->5, with unchanged bytes. AudioClc is now18/18 CLEAN. Ternary source forms also
give both changed functions0 SLD merges/splits; CalcDistance's relative line positions and span are exact.
Receipt: `scratchpad/sym_audioclc_closest_20260920/README.md`.

`AIWorld_CalcSpeed` supplies another small end-to-end check: the native `optVar1` (a1)
holds X velocity and `optVar2` (v1) holds Z velocity, opposite to our previous value/name
association. Restoring those roles and the single speed-selection expression clears both
MOVED findings. AIWORLD improves from15/22 to16/22 CLEAN while remaining22/22 instruction
PASS; the entire object is unchanged. All18 target words match the raw ROM, and every
instruction's function-relative SLD line and the function span match retail. The21 neighbors'
debug contracts and relative SLD maps are unchanged.
Receipt: `scratchpad/sym_aiworld_speed_20260920/README.md`.

`AIWorld_LaneIndex` is now CLEAN too (AIWORLD17/22). The extra debug local came
from reusing `perpDistance` as a hand-expanded division and final return carrier.
Restoring separate lookup/multiply/divide statements and the constant-first upper
clamp removes the extra record without changing the object. The NFS2 SYM supplies
the cross-version `inverseLaneWidth`/`perpDistance` spellings; neither survives as
a debug local in the restored NFS4 compilation. Every instruction's relative SLD
line and the26-line scope span match retail. Their original NFS4 spellings remain
unprovable from its optimized SYM; the cross-version attribution is explicit.
Receipt: `scratchpad/sym_aiworld_lane_20260920/README.md`.

Both car-based `AIWorld_ApxSplineDistance` overloads now give `a`/`b` their native
input-slice roles instead of treating them as multiply intermediates. Natural
signed wrap conditions and a single scaled return remove both decompiler goto
labels. `AIWorld_IsDriveableLaneInSliceRange` now declares its counter in the for
statement and its slice in the body, restoring retail's three scopes. AIWORLD is
20/22 CLEAN and22/22 PASS; all101 target instruction words and their relative SLD
lines match retail. Complete object and honest-link ELF/map bytes are unchanged.
Receipt: `scratchpad/sym_aiworld_scopes_20260920/README.md`.

AIWORLD now has22/22 native function contracts CLEAN and22/22 byte-PASS.
`CalculateDeltaRoadYaw` no longer needs its empty asm fence: the separate yaw
statements and explicit else-zero branch restore the retail allocation and
scope ends. `CalcRoadBend` no longer needs the inline division helper or the
first-product carrier: plain signed division and assigning the complete sum
restore the single native scope. Both match every relative SLD line and preserve
the entire object and fresh honest-link ELF/map.
Receipts: `scratchpad/sym_aiworld_yaw_20260920/README.md` and
`scratchpad/sym_aiworld_bend_20260920/README.md`.

**This is not complete AIWORLD source restoration:** an independent whole-TU
SLD audit now finds21/22 exact relative instruction lines/spans and21/22 exact
statement partitions, improved from10/22 and15/22. The remaining case is listed in
`scratchpad/sym_aiworld_tail_20260920/all_sld_audit.json`: CalculateLaneInfo's
44 body words agree exactly, but its5 epilogue words carry retail relative line151
instead of25. All22 lexical-block line fields also agree (a separate check beyond
the board). Retail jumps from351 to477; the intervening source text is not known,
and no padding/directive was added to claim completion. The audit includes the type88 new-file
SLD record so a previous TU's final line cannot leak into a first prologue.

The nine-function SLD follow-up grouped the two ZSplineDistance vector
subtractions as single expressions, restored the SplineDistance early-return
order, aligned the integer ApxSplineDistance statement order, and restored
native statement regions for lane/profile/barrier/lateral-velocity operations.
All234 target words still equal rawROM, with unchanged whole-object and linked
ELF/map bytes. Original macro spelling and comments are not claimed recovered.
Receipt: `scratchpad/sym_aiworld_sld_20260920/README.md`.

The tail round restored CalcFutureLateralVel's complete dot-product temporary
and separate return, the barrier search's compound-condition loop, and
CalculateLaneInfo's separate edge calculations followed by lane queries.
All190 target words remain raw-ROM exact, with unchanged complete object and
honest-link ELF/map. Cross-version optimized-away names are receipted, not
claimed uniquely recoverable from the NFS4 SYM.
Receipt: `scratchpad/sym_aiworld_tail_20260920/README.md`.

`CopSpeak_LoadNextRequest` now restores loop-local r/bnk, the combined loop
condition, compound asynchronous-lookup conditions and separate file-error
call/test. It is native-contract CLEAN with all125 instruction-relative SLD
lines, lexical-block line fields and the70-line span exact. COPSPEAK improves
17/27 ->18/27 CLEAN while staying27/27 byte-PASS. At that checkpoint strict SLD
was only2/27 exact, so old `SLD-VERIFIED` breadcrumbs do not imply whole-function
instruction-line agreement. The pre-existing volatile queue-ready read remains
an explicit source-recovery item; inferred result name `error` is labeled and
not claimed as a native SYM spelling. EnginePatch/PlayNextRequest experiments
were restored after failing byte or native-parameter checks.
Receipt: `scratchpad/sym_copspeak_engine_20260920/README.md`.

The radio-static trio now restores its native for-declaration ownership and
lexical-block line fields. RadioStaticActive loses two redundant scopes and
restores volume/patnum order: COPSPEAK19/27 CLEAN, still27/27 byte-PASS.
RadioStaticInit and RadioStaticSquelch are now fully relative-SLD exact, raising
the strict whole-TU count to4/27. Active has two explicit loop-back line-tag
mismatches remaining (relative35 vs36 at+0x120/+0x124); an explicit continue
fixed those but displaced native scope ends, so that candidate was not retained.
Receipt: `scratchpad/sym_copspeak_static_20260921/README.md`.

`CopSpeak_Play` now gives noise its native clamped-input role and vol the final
narration-volume role. Two excess scopes and the MOVED noise finding are gone;
all86 relative SLD instruction tags, native block lines and the54-line span
agree. One explicit EXTRA remains: scaled. Its old generic codegen-carrier
necessity claim was replaced by an unresolved review note; direct-expression
trials do not prove that a distinct source object was required. Whole-TU strict
SLD exactness is now5/27. This is progress without claiming the function CLEAN.
Receipt: `scratchpad/sym_copspeak_play_20260921/README.md`.

`CopSpeak_GetEnginePatch` now makes native `patch` the `$a0` index/result
quantity instead of the transient `$v0` timbre increment. The latter is a
`const int` intermediate that does not survive into debug locals. All 14
instructions remain byte-PASS, its native SYM contract is CLEAN, and all 14
instruction-relative SLD tags are exact after matching the source statement
line groups. COPSPEAK is now 20/27 native CLEAN and 6/27 strict SLD exact;
the other seven native findings remain open. Direct arithmetic reassociation
and an expression-only attempt in `CopSpeak_Play` broke its byte match and
were reverted. This result was verified by fresh `symloop.py`, detailed
`verify_asm.py`, SLD trace, and full `symtree_cmp.py` (1700/2565 CLEAN).

`CopSpeak_Stop` now omits a redundant explicit `return`, bringing its last
epilogue line tag into agreement (8/8 SLD tags) with unchanged PASS bytes.
`CopSpeak_InitRequest` places the car reset before the buffer and phrase
resets, as the retail line map requires; GCC schedules the same 12
instructions, and omitting its explicit return aligns the last line tag.
Both remain native CLEAN and are now SLD-exact. COPSPEAK is 20/27 native
CLEAN and 8/27 strict SLD exact. Tests that put `continue` inside or outside
RadioStaticActive's innermost block corrected only its two line tags but
changed native scope addresses, so both were reverted; an empty statement
was code-neutral and SLD-neutral and was also reverted.

`CopSpeak_SilenceCop` now spells the null-car and player/car exclusions as
separate early guards with a shared silence tail. This preserves its 25/25
byte-PASS body and native CLEAN function scope while matching all 25 relative
SLD tags, block-line fields and the 11-line span. COPSPEAK strict SLD rises
to 9/27. A formatting-only split of the old compound condition could not
give the separate branches distinct line tags and was reverted. The retail
records prove the source regions and control-flow equivalence, not that this
exact `goto` spelling was EA's unique original expression.

`CopSpeak_Skip` retains its named request pointer and all27 byte-PASS
instructions while matching its recovered statement regions and all27 SLD
tags; the retail gap between queue selection and request-field resets is
left as source whitespace because its original intervening text is not
recoverable. `CopSpeak_Flush` moves the reconstruction note outside the
function's debug line span and groups the short loop across retail's two
source lines. Its20 instructions, native scope tree and full SLD trace match.
COPSPEAK strict SLD is now 11/27, still 20/27 native CLEAN. These line layouts
are constrained by SYM/SLD, not proof of unique historical whitespace.

`CopSpeak_CleanUp` now follows retail's statement-line regions (Stop at
+1, bank loop at +12, buffer cleanup at +25..28) without changing any of
its 37 machine instructions or its native scope tree. All 37 relative SLD
tags, lexical-block line fields and the 28-line span match. COPSPEAK was
20/27 native CLEAN and 12/27 strict SLD exact at this step. The long source gap between
Stop and the loop is left as whitespace: SLD proves a gap, not its missing
historical text.

The two outstanding COPSPEAK EXTRA locals were re-tested against fresh
retail SYM/assembly. In `CopSpeak_Play`, reusing `noise` or `vol` for the
anonymous scale value moves 16 of the 86 instructions; the previously tested
direct expression moved 17, while a block-scoped `const` preserved bytes
but added two non-retail scopes. In `CopSpeak_PlayNextRequest`, direct global
indexing moves six of 71 instructions and loses the early `$a0`/`slti`
delay-slot shape; an explicit negative-bank early path grows to 79
instructions. Both verified baseline bodies are restored. The `next` name
is borrowed from neighboring methods but not recorded for this function by
retail SYM, and the source comment now marks that limitation explicitly.

`CopSpeak_StartUp` now uses `for (int i = 0; ...)` for the second bank-index
walk instead of a wrapper block with a separately declared `i`. Retail has
one loop-index scope and one body scope at +0x140/+0x164; this change removes
our extra scope while retaining the retail homes of `i`, `bankname`, and
`timbre`. All356 instructions stay byte-PASS, the whole function becomes
native CLEAN, and SLD tag differences fall326 ->282; its full source-line
reconstruction remains open. COPSPEAK is now 21/27 native CLEAN and 12/27
strict SLD exact. Full comparison: 1701/2565 CLEAN, 864 DIRTY.

`CopSpeak_ReadyNextRequest` now has the retail outer invalid/success-path
scope at +0xb4..+0x1d8: a block-scoped `const requestOk = ok` disappears from
debug locals and leaves all156 instructions byte-PASS. Its native scope count
improves 3 ->4 against retail's5. The inner +0xbc..+0xe8 scope is still
missing, so the function remains DIRTY and SLD-partial. A `const` phrase
alias inside the guarded call produced eight scopes, a GNU statement
expression produced nine, and `do/while(0)` produced no new scope; all
three experiments were reverted. The retained alias is an evidenced source
shape for the outer scope, not proof of EA's unique original spelling.

`CopSpeak_Debug` no longer falsely owns `Copspeak_gTimeString` as a
function-local static: retail's typed Debug block has no such local, while
the compact symbol `Copspeak_gTimeString.308` could belong in the source-line
gap between SilenceCop and Alloc. The file-scope declaration keeps all code
bytes matched and makes Debug native CLEAN; removing its redundant return
also makes all8 SLD tags exact. COPSPEAK is22/27 native CLEAN and13/27
strict SLD exact; full function comparison is1702/2565 CLEAN,863 DIRTY.
This is not a global-data seal: our current generated BSS symbol is
unsuffixed `Copspeak_gTimeString` at 0x8013DD38, whereas retail's compact
symbol is `Copspeak_gTimeString.308` at 0x8013E0B0. The variable's exact
owning TU and BSS placement remain a named data-layout backlog item, not a
claim that the suffix uniquely identifies retail source line 308.

`CopSpeak_Server` no longer needs the synthetic `carNoise` clamp input. A
direct conditional expression through the signed car-noise field produces
the same179 instructions, removes the extra debug local and its two extra
scopes, and makes the whole function native CLEAN. Its SLD line map remains
partial (159/179 tags differ), so this is not a strict-source seal.
COPSPEAK rises to23/27 native CLEAN,13/27 strict SLD; the full function
board is1703/2565 CLEAN,862 DIRTY.

`CopSpeak_Cancel` now matches all40 instruction-relative SLD tags, lexical
block lines and the 35-line span with the same byte-PASS body and native
CLEAN contract. The line gaps around the queue drain and handle reset are
evidenced by retail SLD, not a recovery of their original comments.
COPSPEAK strict SLD rises to14/27. In `CopSpeak_ReadyNextRequest`, m2c's
nested `sfx`/bank guards compiled byte-identically but did not create the
last retail inner scope; a scoped const bank alias created eight scopes
instead of five. Both trials were reverted, leaving the verified
+0xb4..+0x1d8 outer-scope improvement and the inner scope unresolved.

`Front_EnableLocalSpeech` now uses a post-GetTrack `const int lang` in a
guarded early-return shape. All35 instruction bytes and all43 Front TU
function bytes remain unchanged. The alias does not survive as a debug
local, reducing the full board's EXTRA-function count from446 to445, but
the sole lexical scope closes at+0x78 rather than retail+0x74 and the
function remains DIRTY (18/35 SLD tags differ). Direct field repetition
shortens the function to33/35; a shared-tail `goto` across the const
initializer is illegal C++, and changing return/braces is scope-neutral.
This is a partial source-local improvement, not a native or SLD seal.
`Clock_MasterInterruptHandler` was also tested with a scoped const parity
alias and then an early-return form: both kept its43 PASS instructions but
moved the retail-exact scope endpoint, so both were reverted. Two other
one-EXTRA candidates, Night_GenerateNextLightningEvent and Force_Vbl, have
stale byte references under fresh `symloop --ref-only`; they were not edited.

Two Front serializer carriers also disappear from debug locals when declared
`const` at their assignment sites. `Front_AppendTrafficData` keeps its
32-bit traffic-count division and all148 byte-PASS instructions, while
`Front_AppendTrackData` keeps its signed three-test speed-mode branch shape
and all80 byte-PASS instructions. Both now match the retail native local
lists, homes and scope trees; FRONT improves28/43 ->30/43 native CLEAN and
the full board1703/2565 ->1705/2565 CLEAN. Their SLD line maps remain
partial (140/148 and73/80 differences respectively), so this is not a
strict source-line seal. The remaining Front_EnableLocalSpeech scope endpoint
and other Front TU findings remain open.

`Front_InitPlayerCars` now has the retail outer final-loop scope at
+0x2bc..+0x3a8 around the existing +0x2c4..+0x334 `carModel`/`carColor`
scope. A scoped const for the existing 13-model bound is optimized out of
debug locals; all241 instructions remain byte-PASS and the native function
contract becomes CLEAN. FRONT improves30/43 ->31/43 native CLEAN and the
full board1705/2565 ->1706/2565, with the 234/241 SLD line differences
still open. The separate `Front_InitTourneyTraffic` pointer-const and
array-index attempts were byte-FAIL (two displaced instructions) and were
reverted; that `tourn` EXTRA remains unresolved.

`Front_InitPerps` now has the missing +0x34..+0x1a4 mission-loop scope
around its existing +0x48..+0x190 `carModel`/`carColor` block. An optimized-
out const alias for the pre-existing 16-model bound leaves all114 byte-PASS
instructions intact and gives both locals their retail scope depth. FRONT
improves31/43 ->32/43 native CLEAN; the full board rises1706/2565 ->
1707/2565 CLEAN. Its 105/114 SLD line-tag differences remain open, so the
const spelling is a verified scope lever, not proof of EA's exact text.

`Front_SecondaryMemCardCheck` now encloses `j` and the nested retry-loop
`i` in the retail's two lexical scopes (+0x0..+0x90 and +0x34..+0x84).
All50 instructions remain byte-PASS and the function becomes native CLEAN.
FRONT rises32/43 ->33/43 native CLEAN; the full board1707/2565 ->
1708/2565 CLEAN. Its SLD lines remain partial (44/50 differences), so the
scope restoration is not yet a strict-source seal.

`Front_BuildStream` now has only the nine retail-named locals and the two
empty +0 scopes inside the function body. A declaration-at-assignment
`const randomSeed` preserves the delayed seed store without a debug local;
scoped const `t` and `seed` aliases preserve the word-width `ticks` load and
retail scope nesting. All1000 instructions and the entire Front TU remain
byte-PASS. FRONT rises33/43 ->34/43 native CLEAN; the full board1708/2565
->1709/2565 CLEAN. Its line map is still partial (990/1000 SLD tags differ).
`Front_AppendCopData` separately gains the exact outer +0x4c..+0x234 loop
scope, byte-neutrally, but the inner +0x50..+0x104 scope is still missing.
A bounded const inside an explicit inner block emitted two scopes instead
of one, and empty braces emitted none; both inner experiments were reverted.
Independent IDA and m2c bodies place that inner range over the cop-car lookup,
early stream fields, and the anonymous `$a0` value funnel selecting 8 or 16
for the `0x105` tag. Retail SYM names only `i`, so the funnel is not a named
local. A second bounded const/empty-brace trial reconfirmed the 4-scope and
2-scope outcomes with all149 bytes unchanged; the remaining 3-scope form
needs a source/macro construct supported by more than a fabricated local.
`Loading_UpdateLoadingScreen` was tested with a use-site `const y` alias:
its62 instructions stayed byte-PASS and the EXTRA local disappeared, but
the debug tree grew from one to four scopes against retail's one. The
experiment was reverted and its existing source-local carrier remains open.

`Camera_AcquireTarget` now uses direct signed divide-by-four expressions
for the three target-position deltas instead of the synthetic mutable
`adj`. GCC emits the same 231 instructions, including each signed
adjust-and-shift sequence, and all remaining native locals/homes and the
scope tree match retail. Camera rises19/38 ->20/38 native CLEAN; the full
board rises1709/2565 ->1710/2565 CLEAN. Its source-line map remains partial
(201/231 differing SLD tags), so this is not yet a strict SLD seal.

`Camera_SetAboveGround` now assigns `elevation` the adjusted ground height
(Newton's return plus 0x10000) before its compare and possible store.
Retail's named `elevation` is in `$v0` after the add, not the raw call
result. This source role restores the MISSING local at its exact register
without changing any of the35 byte-PASS instructions or the scope tree.
Camera rises20/38 ->21/38 native CLEAN and the full board1710/2565 ->
1711/2565 CLEAN; at that checkpoint its SLD line map was partial (17/35
differences). A later source-line pass moved `slicePos` initialization onto
its declaration and separated the ground-height call (retail line +9) from
the `elevation += 0x10000` adjustment (line +10). The guard and conditional
store occupy retail +11/+12, and the redundant explicit return is gone.
All35 instructions remain byte-PASS; the native local/scope contract, every
relative SLD tag, block-line field, and 13-line span are now exact. Camera
strict SLD rises0/38 ->1/38. This fixes statement attribution, not the
unrecoverable original comments or whitespace in the line gaps.

`Camera_Init` now declares retail-named `type` only in the tail block after
`Camera_ResetRelPos`, matching the +0x2e4..+0x374 scope and `$a1` register
home. All229 instructions remain byte-PASS; Camera improves21/38 ->22/38
native CLEAN and the full board1711/2565 ->1712/2565 CLEAN. Its 222/229
SLD line-tag differences remain open.

`Camera_SetMode` now uses an early guard for `modechange` and declares
retail-named `flagMode` only in the final flag-copy block. That block's
+0x114..+0x1fc scope and `$a1` home match the retail SYM, while all133
instructions remain byte-PASS. Merely nesting the declaration inside the
original outer `if` emitted four scopes, so the guard-return flattening is
required for the two-scope retail tree. Camera rises22/38 ->23/38 native
CLEAN; the full board1712/2565 ->1713/2565 CLEAN. Its SLD line map remains
partial (125/133 differing tags).

`Camera_NextMode` follows the same guard-return/tail-block source shape:
retail-named `flagMode` now owns the exact +0x2b8..+0x3a0 scope and `$a1`
home, and a const range alias removes the extra `modeForRange` debug local.
All237 instructions remain byte-PASS. The function is still DIRTY: the
split-screen `splitBase` carrier remains EXTRA, with two excess scopes.
Replacing it by a const or register-const alias kept instruction count but
moved `addiu a1,a1,0` past the signed quotient shift (two diffs); those
variants were reverted. Its SLD map remains partial (232/237 differences).

`Camera_TooSteep` now places the three-vector `camToCar` only in the
post-flat-ground nested block, with the outer work block spanning entry to
+0x154 and the inner block +0xbc..+0x154. Moving the final zero return
outside both blocks put their ends at the exact retail addresses. All92
instructions remain byte-PASS and all named locals/homes/scopes are native
CLEAN. Camera rises23/38 ->24/38 and the full board1713/2565 ->1714/2565
CLEAN; the SLD line map remains partial (61/92 differing tags).

`Camera_TunnelLimit` now has the retail nested +0x6c..+0x128 block under
its tunnel-flag arm. The six named locals in that block retain their exact
homes and gain the correct scope depth with all82 instructions byte-PASS.
Camera rises24/38 ->25/38 native CLEAN and the full board1714/2565 ->
1715/2565 CLEAN; its SLD line map remains partial (73/82 differences).

`Camera_UpdateCircleCam` now exits early when the update gate is false,
flattening two non-retail outer lexical scopes while preserving all160
byte-PASS instructions. The existing h0/h1/ang block consequently has the
retail +0x124 home/depth under the +0x108..+0x1f0 scope. Camera rises25/38
->26/38 native CLEAN and the full board1715/2565 ->1716/2565 CLEAN. Its
SLD line map remains partial (154/160 differences).

`Camera_UpdateCollisionCam` now carries its unreferenced `"SimpleMem"`
rodata tag through a file-scope inline class-name form, as previously
verified in Audio.obj, instead of a constant-false call inside the function.
The two excess +0 debug scopes disappear; all111 code instructions and the
linked byte comparison stay unchanged. Camera rises26/38 ->27/38 native
CLEAN and the full board1716/2565 ->1717/2565 CLEAN. Its SLD lines remain
partial (106/111 differences). The exact historical macro/class spelling of
that unreferenced tag is not established by SYM.

`Camera_IslandProfile` now matches all22 relative SLD tags, lexical block
lines and the 22-line span with unchanged byte-PASS/native-CLEAN status.
The two u_short locals and mutated `before` still drive the same MIPS
mask/loop instructions; moving the reconstruction note outside the function
and respecting retail's statement gaps aligned the trace. `Camera_ResetRelPos`
now likewise matches all44 SLD tags and block/span fields after spacing the
two guarded store groups and omitting a redundant explicit return. It stays
byte-PASS/native-CLEAN. Camera strict SLD rises1/38 ->3/38; the native board
remains1717/2565 CLEAN. Source-line evidence does not uniquely recover the
historical comments or whitespace occupying those gaps.
`Camera_Kill` now matches all34 relative SLD tags and block/span fields:
the split-screen bound is initialized with the retail-named local at +1,
the index loop starts at +3, its handle test/call/store occupy +5/+6/+7,
and the back edge is +8. Moving the reconstruction note outside the
function and omitting the explicit final return left every instruction and
native local unchanged. Camera strict SLD rises3/38 ->4/38.
`Camera_GetMode` now matches all40 SLD tags and its function/block line span
without changing bytes or native locals. Retail puts the first finish-type
guard at relative line +9 and the second at +12; the source-line gap does not
identify its original text. `Camera_PitchAndRoll` now matches all45 SLD tags,
block fields and span: the `anchor` load is +2, pitch read +7, the two
fixed-transform calls +15/+16, and the matrix multiply pair +17/+22. Its
byte-PASS body and named local contract are unchanged. Camera strict SLD
rises4/38 ->6/38, while the native board stays1717/2565 CLEAN.
`Camera_UpdateSimpleCam` now matches all57 SLD tags, block-line fields and
span after grouping its two vector declarations, retaining the transform
and tunnel-limit statement regions, and omitting the redundant explicit
return. The complete body remains byte-PASS/native-CLEAN. Camera strict SLD
rises6/38 ->7/38. `Camera_ReplayUpdate` now matches all65 instruction tags
and its 20-line function span, but its only lexical block-end line remains
+20 versus retail +14. Moving four blank lines across the guarded block
and adding empty braces left that emitted debug field unchanged, so it is
not marked strict SLD-exact; the experiments are reverted. The native board
remains1717/2565 CLEAN.
`Camera_UpdateBlimpCam` now matches all81 SLD tags, lexical block lines and
function span. Retail attributes the three old-arm component differences to
one source line (+9) and the three final camera-position stores to one line
(+17); the reconstructed statements are grouped accordingly, with the
transform and interpolation calls at their recorded lines. All81 bytes and
native locals remain matched. Camera strict SLD rises7/38 ->8/38. The
original vector macro, if any, cannot be inferred uniquely from line tags.
`Camera_UpdateCopCam1` now matches all102 SLD tags, block-line fields and
span with unchanged byte-PASS/native-CLEAN status. Retail gives one line to
each three-component sum, difference, and fixedmult group (+4/+10/+12),
then separate lines for the three camera-position stores (+13..+15).
Grouping those statements and removing the redundant explicit return
restores that map. Camera strict SLD rises8/38 ->9/38; exact historical
vector-macro spelling remains unrecoverable from these records alone.

`Cars_ResetCollidedCars` now assigns the road-up/orientation-up dot product
to retail-named `y` within its existing short-circuit guard. The result is
the `$v1` quantity compared with 0xC000, matching the SYM local/home while
retaining all280 instructions byte-PASS. `Cars_FindTotalSlice` now declares
retail `lapSlices` only in the post-unlap nested block (+0x18..+0x64), under
the outer +0..+0x64 block, with all27 instructions byte-PASS. Cars improves
22/33 ->24/33 native CLEAN; the full board1717/2565 ->1719/2565 CLEAN.
Both SLD line maps remain partial (270/280 and27/27 differences), so these
are native-local/scope recoveries, not strict source-line seals.
The later `Cars_FindTotalSlice` line pass moves its reconstruction note out
of the function and groups each arm's total-slice expression on its retail
source line. All27 instructions remain byte-PASS, all native block-line
fields and the 13-line span match, and SLD instruction differences fall
27/27 ->2/27. The two remaining tags are the +0x64 epilogue, attributed
to line +13 here versus retail +12. Adding a same-line shared return is
byte-neutral but does not move that tag, so it was reverted. The function
is still not strict SLD-exact.
`Cars_InitializeCarTablesFlagsAndCounters` now declares retail-named
`personality` directly in the AI-car arm, causing GCC to emit its +0x218
and +0x224 scopes with the `$s2` home; four manually added wrapper scopes
were excess and were removed. All326 instructions remain byte-PASS.
`Cars_IniCarObjects` similarly moves retail `carMass` into the conditional
base-Newton initialization arm; its +0 and +0x3c nested scopes and `$a2`
home now match with all251 instructions byte-PASS. Cars rises24/33 ->26/33
native CLEAN and the full board1719/2565 ->1721/2565 CLEAN. Both SLD maps
remain partial (297/326 and244/251 differing tags).
`Cars_Randomize` now declares `rLoop` in a block immediately after the
count load, before the nonzero-count guard. That produces the retail
+0x10..+0x70 nested scope and `$v1` home while all30 instructions remain
byte-PASS. Declaring it inside the guard emitted two excess scopes and was
reverted. Cars rises26/33 ->27/33 native CLEAN; the full board1721/2565
->1722/2565 CLEAN. Its SLD map remains partial (24/30 differences).
`Cars_ManageBureaucracy` now skips inactive cars with an early loop continue,
then scopes the active-car work after lane calculation. The resulting +0x54,
+0x90, +0xa4, and +0xc8 block chain matches retail, with named `facing` in
the innermost `$s1` slot. All114 instructions remain byte-PASS. Moving
`facing` alone into the range arm made its depth too great; flattening the
active guard alone removed one scope too many. The combined source shape
reconciles both. Cars rises27/33 ->28/33 native CLEAN and the full board
1722/2565 ->1723/2565 CLEAN; SLD remains partial (99/114 differences).
`Cars_CheckForAccidentScenes` now uses an optimized-out scoped const for the
`SceneLoaded` snapshot inside the mode guard. That produces retail's empty
+0 and +0x3c..+0xb8 scopes without a non-retail debug local and keeps all50
instructions byte-PASS. Cars rises28/33 ->29/33 native CLEAN; the full
board1723/2565 ->1724/2565 CLEAN. Its SLD map remains partial (47/50
differences), and the exact original source construct behind the empty
scopes is not uniquely determined.
`Cars_Randomize` is now strict SLD-exact (30/30 tags, all block-line fields
and the seven-line span). Retail's `count` scope and nested `rLoop` scope
both start on relative source line +3, before the count-load instruction
tagged +4. Placing the outer declaration and inner block opening with the
+2 guard, then `rLoop` on +3, restores that boundary; the loop test is +5
and the three random-state updates share +6. The 30 byte-PASS instructions
and native locals are unchanged. Cars strict SLD rises1/33 ->2/33, with the
full native board still1724/2565 CLEAN.
Four small Cars helpers now also have exact relative SLD tags, block-line
fields and spans with unchanged byte-PASS/native-CLEAN status:
`Cars_GetDashData` (9/9) and `Cars_InitDashData` (10/10) omit redundant
explicit returns, leaving their last stores as the epilogue's source line;
`Cars_ResetCarCounters` (10/10) restores the line gap before the human-car
counter group and likewise omits its explicit return; `Cars_Initialize`
(9/9) groups its loop update and back-edge on retail line +6. Cars strict
SLD rises2/33 ->6/33. These source regions are evidenced by retail SLD,
but exact historical whitespace/comments are not.
`Cars_DeInitCar` now puts the optional specs release on retail lines +4/+5
and the 3D-car teardown on +8, with all18 SLD tags, block fields and span
exact. `Cars_SetCarUpForHiRezSim` now matches the guarded shape lookup and
collision reset on +3/+5/+7/+8 with all29 SLD tags exact. Both omit
redundant explicit returns and retain byte-PASS/native-CLEAN status. Cars
strict SLD rises6/33 ->8/33; the full native board remains1724/2565 CLEAN.
`Cars_ResetVariablesAfterACollision` now matches all26 relative SLD tags,
block-line fields and span after separating the angular-velocity,
channel-velocity, acceleration and collision-state reset regions. Removing
its redundant final return keeps the last `Physics_ResetCar` call on retail
line +24. `Cars_SetAudioCalls` now matches all50 SLD tags and block/span
fields after aligning the first stream-field store at +2 and omitting its
redundant explicit return. Both remain byte-PASS/native-CLEAN. Cars strict
SLD rises8/33 ->10/33; the full native board stays1724/2565 CLEAN.
`Cars_QDUpdateVelGlue` now has all31 relative SLD instruction tags,
block-line fields and function span exact. Its six-line matching note was
moved outside the function, preserving a source-line gap after the opening
brace, and its redundant explicit return was removed. `Cars_CalcVelDownRoad`
now has all39 tags/block-line fields/span exact after moving its three-line
matching note outside the function and preserving the retail gap before the
return. Both functions remain byte-PASS and native-CLEAN; Cars strict SLD
rises10/33 ->12/33. Exact historical comments/whitespace remain unknown.
`Cars_InitStats` now reconciles all26 SLD instruction tags, block-line
fields and the function span. `stats` remains the retail $a0 base pointer
and `lapLoop` the retail $a1 loop variable. The loop initialization is
placed on retail source line +13; gcc still schedules its zeroing before the
base-pointer setup, matching the binary. The post-loop stores retain their
retail line gaps. All33 Cars functions remain byte-PASS, the native local
board remains29/33 CLEAN, and strict SLD rises12/33 ->13/33. The exact
historical spacing/comments are not recovered.
`Cars_SortCars` now has all92 relative SLD instruction tags, block-line
fields and the 48-line span exact. The two `swapped = 1` assignments were
moved to the retail statement positions before their corresponding swap
stores; the compiled instructions stayed unchanged. Source line grouping
now follows the first slice sort, sort-index assignment, and total-slice
sort regions of the retail map. The explanatory comments are explicitly
reconstruction notes, not claimed retail text. Cars stays33/33 byte-PASS
and29/33 native CLEAN; strict SLD rises13/33 ->14/33.
`Car_DoPostCollisionStuff` remains a substantive Cars SYM backlog item:
retail records only `Yoffset` in the nested collision-height block, whereas
the byte-PASS reconstruction still emits four named carrier locals
(`roundedGV`, `clampCond`, `absRoll`, `rideOffsetVal`). The NFS2 PC beta
`MIN`/`MAX` macros confirm a plausible EA source family, but the existing
in-tree macro trials did not match this retail body. A new `const int`
declaration-initializer trial for `rideOffsetVal` changed 28 instructions
(158 vs154) and was reverted; all33 Cars functions were recompiled and
restored to their byte-PASS state. This needs a structural source/macro
reconstruction, not merely a const spelling change. `Cars_FindTotalSlice`
is independently native-CLEAN and 25/27 SLD tags agree; its remaining
scope-start line fields and epilogue tag require a source-region shape that
cannot be inferred by simply shifting the outer braces.
`Cars_DoGravityEffectsOnAcc` now preserves80/80 byte-PASS instructions and
native SYM-CLEAN ownership while matching all80 relative instruction-line
tags (previously76 differences). A scoped const `roadNormal` separates the
fixedmult call at source +7 from the threshold at +10, and GCC optimizes it
out of the debug local list. Both acceleration-sign arms now use explicit
branches at retail's distinct +30/+33 and +37/+40 line regions, preserving
the same machine code. Strict SLD remains open because the generated outer
block end is +44 while retail is +41, despite the epilogue tag itself being
+44 in both. Do not claim the original comments or exact source macro are
recovered; a line-directive workaround has not been added.
`Replay_ResetReplay` replaces the Ghidra-style `piVar2` carrier name with
`counterSlot`, the pointer to the current `Replay_ReplayCounter` element in
the reverse two-entry clear. Retail SYM still records only `i`; the extra
REG:$v0 local is therefore an explicit unresolved source-shape carrier,
not a claimed original variable name. The matched NFS2 PC beta source uses
an indexed counter clear, but that NFS4 candidate and a `for` variant both
compile to87 vs retail86 instructions (one extra address increment); a
pre-decrement counter variant has13 diffs. All trials were reverted before
retaining the name-only change: Replay.obj stays16/16 byte-PASS and12/16
native-CLEAN. A more faithful no-carrier source form remains to be found.
`Replay_InitReplay` moves the real SYM `temp` user-setting buffer from
function scope into the `Replay_ReplayMode == 2` branch. Its native nested
scope now matches retail (+0x38..+0x11c), raising Replay.obj12/16 ->13/16
CLEAN with all16 functions still byte-PASS. The `Replay_Size` snapshot now
appears before `Replay_ReplayGetPtr = 0`, following the retail SLD statement
order; GCC schedules the same instructions. Its relative instruction lines
remain 102/105 different and lexical line fields still need restoration.
The full native board improves1724/2565 ->1725/2565 CLEAN.
`Replay_GetInput`'s extra `steering` local remains necessary for the current
byte-PASS form: direct signed-byte lvalue and shared-field signedness trials
both produced a six-diff `lbu`/address-order residual and were reverted.
`Replay_ReplayFindClosestCamera` now declares `i` in its `for` initializer
instead of an explicit surrounding block. That removes one compiler debug
scope: `i` and all three real distance locals now have retail depth and
exact +0x3c..+0x38c ownership. All282 instructions stay byte-PASS; Replay
rises13/16 ->14/16 native-CLEAN and the global board gains one CLEAN
function (1725/2565 ->1726/2565). Its SLD source-line fields remain different despite exact native
scope addresses, so strict SLD is not claimed.
`FastRandom_StartUp` now scopes real SYM local `i` inside the seed-work
block while leaving `a`, `b`, and `seedIterations` at function scope. The
retail register homes and native block addresses match, improving its
two-function TU from1/2 to2/2 SYM-CLEAN; both functions remain byte-PASS.
The global native board improves1726/2565 ->1727/2565 CLEAN.
The block's source-line fields (+5/+19 ours versus retail +4/+16) and
instruction tags initially differed; the subsequent byte-neutral line
grouping aligns `a`/`b` at +3/+4, the two seed stores at +7, quotient at
+9, guard at +11, random-state updates at +13 and loop step at +15.
`FastRandom_StartUp` now has all34 instruction tags, nested block fields
and function span strict SLD-exact; the TU is1/2 strict. The compressed
same-line source grouping is a reconstruction of debug-line regions, not
proof of EA's exact whitespace or comments.
`FastRandom_CleanUp` now uses a compact empty body, matching the retail
single-line block end (+0x0, line +1), with its two instructions still
byte-PASS. The remaining strict-SLD residual is exactly the two epilogue
tags: GCC assigns relative line0, retail line+1. Equivalent one-line
`return;`, `return (void)0;`, and `(void)0;` forms produced the same tags
and were reverted. Native FastRandom remains2/2 CLEAN, strict1/2.
`Object_ClearCustomObjects` now scopes retail `i` inside the clear-and-two-
car-list block, ending at +0xa4 before the optional `Track_gSaveSurface`
restore. The native scope addresses and register match exactly, and all52
instructions stay byte-PASS. Object.obj gains one native-CLEAN function;
the global board rises1727/2565 ->1728/2565 CLEAN. Its SLD line fields
remain partial and are not claimed strict.
`Object_InitIMassObjectInfo` now uses early exits for unavailable persistent
groups and failed `reservememadr`, then one work block beginning at +0x5c.
This places SYM locals `objIndex` ($s1) and `objInst` ($s0) in the retail
depth/address range through +0xf8. The nested-if declaration trial reached
five scopes and was rejected; the early-exit form stays67/67 byte-PASS and
improves Object.obj18/32 ->19/32 native-CLEAN. SLD line offsets remain open.
The full native board advances1728/2565 ->1729/2565 CLEAN.
`Object_GetIMassObjectMotion` now has one inner work block containing the
two real SYM locals `timeDiff` ($a0) and `objTime` ($s1), both owned from
+0x0 through +0x16c exactly as retail. Its111 instructions stay byte-PASS,
and Object.obj improves19/32 ->20/32 native-CLEAN. The source-line fields
on the two blocks and the body statements still differ and remain in the
SLD queue.
The full native board advances1729/2565 ->1730/2565 CLEAN.
`GetObjMaxDimensions` now places all five retail locals (`objDef`,
`minDim`, `maxDim`, `vertCount`, `pts`) in one function-spanning inner block,
matching their register/stack homes and +0x0..+0x11c ownership. Its94
instructions remain byte-PASS; Object.obj improves20/32 ->21/32 native-
CLEAN. The block and statement line fields remain outside retail and are
not yet strict SLD.
The full native board advances1730/2565 ->1731/2565 CLEAN.
`Object_InitCustomObjects` now reproduces the retail two nested, empty
debug scopes at +0x0 without emitting extra locals or instructions. Plain
braces were scope-neutral; scoped compile-time constants for the first
allocation's capacity (0x400) and empty flag (0) cause GCC to retain both
scopes while folding the values. The names are semantic reconstruction
labels, not claimed original identifiers. The function remains33/33 byte-
PASS, Object.obj improves21/32 ->22/32 native-CLEAN; its instruction-line
SLD remains29/33 different.
The full native board advances1731/2565 ->1732/2565 CLEAN.
`Object_GetPointsCollisionData` now has the two retail zero-length nested
scopes at +0x88 inside the `objDef` block. Scoped compile-time declarations
for the existing object type and clear flag, confined before the lookup,
produce those blocks without extra SYM locals or code bytes. Plain braces
were insufficient; keeping the constants live across the work region gave
the right count but wrong +0xdc scope ends. The retained form stays79/79
byte-PASS and improves Object.obj22/32 ->23/32 native-CLEAN. Their semantic
names describe the checked values but are not claimed original; the exact
source macro/construct behind the empty scopes remains a backlog item.
The full native board advances1732/2565 ->1733/2565 CLEAN.
`ObjectSignAnim::Draw` now declares retail `i`/`anim` in the finished-
animation arm and `pObjDef`/`cp`/`frame`/`numFrames` in the render arm.
All six named locals now have retail depth, register/stack home and branch
start address while118 instructions stay byte-PASS. Native CLEAN remains
open only for lexical endpoints: our render-arm and containing branch
scopes end at +0x1b8, whereas retail ends both at +0xd0. Moving the
render tail after the first arm's early return corrected the outer endpoint
but placed four render locals one level too shallow; that trial was
reverted. Original scope-producing source construct remains unknown.
The two derived ObjectAnim constructors share a retail zero-length scope
inside their base-construction prologues. An explicit empty inline
`ObjectAnim()` in `object_types.h` reproduces that scope in both without
changing their instruction streams. Together with moving the seven real
rotation/matrix locals into the +0x100 work block, `ObjectSignAnim` ctor
is now fully native SYM-CLEAN and remains181/181 byte-PASS. Object.obj
improves23/32 ->24/32 native-CLEAN. `ObjectMultiAnim` ctor also gains the
base scope; its independent extra `z` carrier remains unresolved. Both
full `build.py --skip-asm` and `build.py --out expected --no-link` passed
after the shared-header edit. Constructor SLD line fields remain open.
The full native board advances1733/2565 ->1734/2565 CLEAN.
`ObjectMultiAnim` ctor no longer needs synthetic `z`: assigning
`this->impactVel.z = impactVel->z >> 6` alongside x/y before the member
pointer stores produces the same62 retail instructions and the correct
load/store schedule. The earlier cached-local form matched bytes but added
a non-retail `$v0` debug local; the direct early-store form removes it.
Together with the explicit `ObjectAnim()` base scope, this constructor is
now native SYM-CLEAN. Object.obj improves24/32 ->25/32; SLD tags are still
partial (28/62 differing) and exact original spacing is unproven.
The full native board advances1734/2565 ->1735/2565 CLEAN, and the
EXTRA-local category decreases441 ->440 functions.
`AIHigh_CleanUp` now scopes the real `carLoop` ($s1) around the car-list
deletion loop, ending at +0x70 before `AIState_CleanUp`. Its35 instructions
stay byte-PASS, improving AIHIGH.obj3/7 ->4/7 native-CLEAN. Retail's
inner/function block line fields are +9/+10 versus our +13/+16, so SLD
placement remains open.
The full native board advances1735/2565 ->1736/2565 CLEAN.
`AIHigh_Execute` replaces Ghidra-style `bVar1` with semantic
`executeNow`, the boolean deciding whether to call `HighExecute`. It is
still an extra debug local: the measured direct short-circuit form loses
five instructions and has33 diffs, so the byte-PASS source currently needs
an explicit decision lifetime. Placing `carLoop` in the outer loop block
and declaring `carObj` after the count guard makes their retail register,
depth and +0x0..+0xec / +0x2c..+0xdc ownership exact with all66 bytes
unchanged. The five retail nested scheduling scopes (four zero-length at
+0x54) are still absent. Native CLEAN/SLD seal is not claimed; the
original macro/source construct remains an explicit backlog item.
`AudioMus_SetEntry` now declares SYM local `p` ($a2) only around the
filename walk, ending at +0x74 before the title terminator store. It stays
34/34 byte-PASS and improves AUDIOMUS.obj20/23 ->21/23 native-CLEAN.
Moving the reconstruction note outside the body and grouping the two
function-scope declarations reduced its relative SLD mismatches34/34 ->
26/34; the pointer block end line now matches, while its start and the
outer function end still need source-line reconciliation.
The full native board advances1736/2565 ->1737/2565 CLEAN.
`AudioMus_GetSongList` now declares its fill-loop `i` in the `for`
initializer and removes the redundant enclosing wrapper. This keeps the
retail `i` scope and moves `size`/`songname` one level shallower into the
retail +0xc8..+0x180 block. Its117 instructions stay byte-PASS; the TU
improves21/23 ->22/23 native-CLEAN. Function and block source-line fields
still differ, so strict SLD is not claimed.
The full native board advances1737/2565 ->1738/2565 CLEAN.
`AudioMus_Volume` now uses two nested source guards (`AudioMus_g` present,
then volume changed) rather than a compound condition. GCC retains111/111
byte-PASS instructions and emits the retail nine-scope tree: the two
pre-fade scopes begin at +0x1c, `ticksleft` is owned from +0x2c and
`curvol` from +0x68 at their exact register homes. AUDIOMUS.obj reaches
23/23 native SYM-CLEAN and has no remaining native-dirty functions. Its
SLD instruction tags (104/111 mismatching) and lexical line fields still
require reconstruction; native-CLEAN is not a strict-SLD seal.
The full native board advances1738/2565 ->1739/2565 CLEAN.
`CopSpeak_PlayNextRequest`'s direct queue-index form and a scoped const
snapshot both retain71 instructions but change six rows, including the
retail `$a0` input/index lifetime; both were reverted. `CopSpeak_Play`'s
direct repeated `(0x80 - noise/4)` expression and the algebraically
equivalent `*0x81` form each emitted87 versus retail86 instructions and
17 diffs; its byte-PASS, instruction-line-SLD-exact `scaled` carrier was
restored. The available NFS2/NFS2b/NFS3/NFS4 sound source search yielded
no matching body. `CopSpeak_ReadyNextRequest`'s missing +0xbc..+0xe8
scope was not reproduced by a scoped bank threshold (7 vs retail5 scopes)
or a scoped no-buffer call argument (8 vs5); both byte-neutral trials were
reverted. These precise source shapes remain backlog, not claims of a
confirmed compiler floor.
`Audio_DeInitDriver` now uses a compile-time audio-off comparison and a
const heap snapshot in the existing cleanup guard. GCC optimizes both
values out of retail-style locals but retains exactly the two nested
scopes (+0x0 and +0x38) missing before, with all23 instructions byte-PASS.
AUDIO.obj improves5/6 ->6/6 native-CLEAN. Their semantic identifiers are
reconstruction labels, not recovered original spellings. Eight of23 SLD
instruction tags and the block-line fields still differ, so strict SLD
remains4/6 rather than a full seal.
Byte-neutral grouping of the cleanup call, guard, restore and heap release
has since aligned the first19/23 relative instruction tags; the detailed
SLD residual decreases8/23 ->4/23. The four remaining tags belong to the
epilogue (+0x4c ours line+10 vs retail+7), while the two inner block-line
fields are still +4/+7 ours versus +5/+8 retail. The original compact
source construct is not uniquely determined.
The full native board advances1739/2565 ->1740/2565 CLEAN.
Six `femenuoptions.cpp` fade `UpdateTransition` methods now use semantic
`fadeValue` instead of decompiler-style `iVar2` (five methods) or `iVar1`
(audio slider). All six represent the same signed promoted `fFadeVal +
fFadeDir` value before clamping to 0..128. Retail SYM retains no local in
these methods, so this is explicitly not a recovered original name and
the EXTRA-local mismatch remains in the review queue. A repeated-field
ternary for `tMenuItemGoToMenuButtonFade` compiled34/31 with19 diffs;
a const-sum ternary compiled35/31 with14 diffs. Both were reverted.
The retained name-only edits keep the full FEMENUOPTIONS.obj83/83 byte-
PASS and its native-CLEAN count50/83 unchanged; no post-compile rewrite.
`tMenuItemSlidingActivated::UpdatefOpenHeight(bool)` now leaves the unused
ABI parameter unnamed, matching retail's absent REGPARM while preserving
the `b` mangling. Direct `fSlideOffset` reads remove the extra `iVar4`
with26/26 byte-PASS instructions. The remaining minimum/zero-clamp result
is now semantic `clampedSlideHeight` (not a recovered original name) in
$v1; its `heightLimit` input is a scoped const optimized out of SYM.
Moving the height calculation before the active-slide update cost37 diffs
and one instruction; a const ternary after the update cost5 diffs, and an
explicit two-arm final store cost3. The retained mutable final value
reproduces all26 retail instructions, reduces this function's extra debug
items from three to one, and keeps FEMENUOPTIONS.obj83/83 byte-PASS.
Its SLD line regions remain unmatched; native CLEAN is not claimed.
Six more FEMENUOPTIONS Draw definitions now leave their unused `bool`
parameter unnamed while retaining the retail `iib`/`iiib` mangling:
DisplayLeftRightChoice, OnOffLeftRightChoice, LeftRightAudioSlider,
ControllerLeftRightChoice, InsideBoxLeftRightSlider and
InsideBoxTwoWaySlider. Together with the earlier UserName and MemoryCard
Draw edits, eight retail-absent `selected` REGPARM/ARG records have been
removed. All83 functions in the TU stay byte-PASS. Their remaining
expression locals, `this` homes and lexical scopes are separate backlog
items; the native-CLEAN count remains50/83.
The global EXTRA-local function category decreases440 ->438 while the
full native board stays1740/2565 CLEAN; other issues keep these methods
in the DIRTY set.
Three FEMENUOPTIONS `ProcessInput` definitions now leave unused `tPlayer`
and `tMenuCommand&` ABI parameters unnamed while keeping their mangled
types and byte-PASS bodies: InsideBoxSongMenu, InsideBoxTwoWaySlider and
UserNameMenuItem. Retail SYM has only `this`/`keyval` (plus `j` for
SongMenu) in these functions. The first two become fully native-CLEAN,
raising FEMENUOPTIONS.obj50/83 ->52/83; UserNameMenuItem still has its
independent source-only expression locals and scope mismatch. Their SLD
line fields remain open, so native-CLEAN is not a strict-SLD claim.
The global native board advances1740/2565 ->1742/2565 CLEAN and the
EXTRA-local function category decreases438 ->436.
`tMenuItemDisplayLeftRightChoice::Draw` and
`tMenuItemOnOffLeftRightChoice::Draw` now use an early fade==0x80 return
and const x/y coordinates declared at first use. The early-out removes
the guard's extra lexical scopes; GCC preserves each function's existing
60/60 and94/94 byte-PASS body while omitting both coordinate debug locals.
Their retail SYM locals (`ColText`; `ColTextOn`/`ColTextOff`) and block trees
are now native-CLEAN. FEMENUOPTIONS.obj improves52/83 ->54/83. Earlier
parameter-only and one-coordinate trials were basin-relative; this paired
source-shape lever is the verified no-carrier form. Detailed SLD line
placement remains open.
`tMenuItemControllerLeftRightChoice::Draw` now declares `w` as a const
use-site width adjustment just before its only shape draw. GCC omits that
retail-absent debug local and preserves the exact129/129 instruction body
and unreassociated `x - w` address calculation. Const x and const y
experiments each compiled131 instructions with22 diffs and were reverted;
their separate saved-register lifetimes still require a source-shape
recovery. The function remains native-DIRTY for x/y and lexical scopes,
but its extra-local review count falls by one.
The full native board advances1744/2565 ->1746/2565 CLEAN and the
EXTRA-local function category decreases431 ->429.
`Font_Blit` now leaves its unused seventh ABI `int` unnamed in both the
local declaration and definition. The blitter function pointer still passes
that argument and the mangled `...i` signature is unchanged, but retail SYM
does not retain a `tpage` parameter record because the body never reads it.
The 55-instruction byte-PASS function now has an exact native parameter,
local and block tree; FONT.obj improves10/15 ->11/15 native-CLEAN. Its
non-monotonic SLD line map is separate work.
The full native board advances1742/2565 ->1743/2565 CLEAN, and the
EXTRA-local function category decreases436 ->435.
`Font_LoadFont` no longer needs synthetic `hdr`: a `char *const hdr`
initialized immediately before `resizememadr` preserves the retail
`f1 - 0x10` address subexpression and the117/117 byte-PASS body, while
GCC omits the const from the debug local list. Reordering the three real
declarations to retail SYM order (`shp`, `i`, `l`) is also byte-neutral.
FONT.obj improves11/15 ->12/15 native-CLEAN, correcting the earlier
receipt that a *mutable named* header local was necessary. Its detailed
SLD map remains partial (105/117 tag differences); no original comment or
whitespace is claimed.
The full native board advances1743/2565 ->1744/2565 CLEAN, and the
EXTRA-local function category decreases435 ->434.
`tMenuItemLeftRightChoice::Draw` now declares the shared x coordinate as
a const at its `TextSys_WordX` call. GCC preserves all51 retail instructions
and the saved value across both text renders but omits x from native SYM;
the existing y result is already optimized out. The method's ABI params,
empty local list and one block now match retail exactly, improving
FEMENU.obj60/71 ->61/71 native-CLEAN. x/y are semantic reconstruction
names, not claimed original spellings. Its SLD source-line regions remain
partial.
The full native board advances1746/2565 ->1747/2565 CLEAN, and the
EXTRA-local function category decreases429 ->428.
`tMenu::UpdateTransition` now owns retail `item` ($s0) in the inner
+0x0..+0x80 loop block, leaving the terminal function tail outside it.
`tMenu::tMenuConstructor` keeps `i` at function scope but adds the
function-spanning work block above the +0xc..+0x28 `p` loop scope.
Both source changes preserve their37/37 and14/14 byte-PASS bodies;
FEMENU.obj improves61/71 ->63/71 native-CLEAN. The lexical source-line
fields remain partial, so neither is claimed strict SLD-exact.
The full native board advances1747/2565 ->1749/2565 CLEAN.
`tScreen::TransitionOff` and `TransitionOn` now retain the two retail
zero-length nested scopes at function entry through scoped compile-time
fade/off values. Their8/8 and9/9 instruction bodies stay byte-PASS, and
no extra debug locals are emitted. FESCREEN.obj improves21/25 ->23/25
native-CLEAN. The semantic const names are reconstruction labels, not
original identifiers; their SLD block-line fields (+4/+6/+8 ours versus
retail +2) and instruction tags remain open.
The relink and native SYM rerun confirm the board at 1751/2565 CLEAN
(814 DIRTY, BLOCKS 685); the linked RECON region remains 299819/299819
retail-identical words, with no masked overlap mismatches or foreign labels.
FESCREEN's short-method SLD follow-up preserves every byte-PASS body and
raises its strict instruction-line coverage from 1/25 to 6/25: removing
redundant terminal returns aligns `AsyncLoadPermanentShapeFile`,
`UploadSwapShapes`, `UploadPermanentShapes`, and `Cleanup`; the latter three
also restore the retail blank-line gaps. `GetShapeInfo` now uses paired
chained assignments in the observed store order, with both stores in each
pair attributed to one retail source line; it is also strict SLD-exact.
Native SYM stays 23/25 CLEAN. This certifies
instruction tags and block records, not the unrecoverable contents of
blank/comment source lines.
The empty `tScreen::ProcessInput` needs a non-emitting source statement:
plain `return;` put the native block end at +2; an empty body put the
instruction tag at +1. A null statement at source line +1 preserves the
two retail instructions, places the block end at +1 and the return tag at
+2, making the function strict SLD-exact and FESCREEN 7/25 strict. The
statement's exact original macro/comment spelling is not recoverable.
FESCREEN's `tScreen` constructor removes a non-retail leading blank line
and terminal return, aligning all 22 SLD instruction tags at unchanged
byte-PASS. Its empty destructor also omits the explicit return and becomes
strict SLD-exact at 13/13 byte-PASS. FESCREEN strict coverage rises
7/25 -> 9/25 while native coverage stays 24/25; the remaining viewTable
carrier in `GoNonInterlaced` is independent.
FESCREEN `CancelAsyncLoad` now uses the unbraced inner purge and SLD-driven
source regions +3/+5/+7/+11/+12/+14/+16/+17/+18/+20. It remains
38/38 byte-PASS and native-CLEAN; instruction-tag differences fall
34/38 -> 2/38. The only residual is the status call/compare pair at
+0x28: a const status snapshot makes all tags exact but adds two
non-retail scopes, while a single expression keeps the block tree exact
but tags the compare one line early. The snapshot and equivalent ternary
were reverted; original non-emitting/macro structure remains open.
FESCREEN `AsyncLoadSwapShapeFile` now keeps the filename branch's call
on retail lines +5/+6, the null branch on +8, and no redundant terminal
return; all 21 instruction tags and native records are exact at 21/21
byte-PASS. `tScreen::Draw(bool)` writes `} else {` as one source line and
omits its redundant return, aligning all 21 tags while preserving its
byte-PASS body. FESCREEN strict coverage rises 9/25 -> 11/25; native
coverage remains 24/25.
FESCREEN `InitializeShapes` now aligns the old-shape purge (+5/+8/+9),
field reset (+13..+17), zero-count guard (+20), allocation (+22), and
unbraced fill loop (+23/+24). Its 42 instructions and native local tree
remain byte/SYM-PASS, and all 42 SLD tags plus block/function spans match,
raising FESCREEN strict coverage 11/25 -> 12/25. The source-end brace
shares relative line +24 as retail records; exact original punctuation
and non-emitting text in earlier gaps are not claimed recovered.
FESCREEN `PreLoad` moves its virtual-slot explanation outside the body,
keeps the four retail-named stack locals, and places GetShapeInfo on +5,
the two InitializeShapes calls on +8/+9, and async loads on +12/+13.
The redundant return is removed. All 33 instruction tags and block lines
are exact with 33/33 byte-PASS, raising FESCREEN strict coverage
12/25 -> 13/25; native coverage stays 24/25.
FESCREEN `DrawBackgroundImage` now has the two drawFlags stores, loop head,
first draw, flip guard, and optional second draw on retail source regions
+4/+5/+7/+9/+10/+11. The optional call uses a natural unbraced `if`,
making the loop closure land on +12 without invented statements. All 52
SLD tags and native locals are exact at unchanged 52/52 byte-PASS, raising
FESCREEN strict coverage 13/25 -> 14/25.
The next FESCREEN carrier pass makes `UpdateTransition` native-CLEAN:
its first value chain is now a const ternary at the assignment site, and
its clamp is two const value snapshots. Both compile to the same 30
retail instructions while emitting no named local records. In
`GoNonInterlaced`, const use-site snapshots likewise remove the extra
`displayHeight`, `viewHeight`, `frontView`, `backView`, and `displayEnv`
records without changing its 52-instruction body. `viewTable` remains the
sole named extra: direct inlining costs 26 diffs; const-at-use-site or
function entry preserves length but swaps $a1/$a2 (18 diffs), so those
counterfactuals were reverted. FESCREEN now has 24/25 native-CLEAN,
one explained source-only carrier, and 6/25 strict SLD-exact functions.
The source expression names are semantic, not claimed original spellings.
The full native comparison confirms 1752/2565 CLEAN (813 DIRTY,
EXTRA-function category 427); relink, honest image, and vtable gates remain
green. `UpdateTransition` still has 25/30 differing SLD line tags, so
native-clean is not presented as full source-line recovery.
FECREDITS `SetupCurrCredit` now drops all five source-only debug locals:
`nextCredit` and `textFade` use const snapshots; the direct short-circuit
input test removes `advanceRequested`; and subsequent credit uses read
the already-updated `fShowCreditNum`, removing `currentCredit`. A const
snapshot of the second `ticks` load removes the named `startTicksSnapshot`
record while its volatile source read preserves the exact 199 retail
instructions. Direct and nonvolatile reads were tested and failed 10
diffs at 197/199, then reverted. Native locals now match, but the method
still has 9 versus 28 retail scope blocks; FECREDITS remains 5/7 native,
0/7 strict SLD, all 7 byte-PASS. The nested-block source layout is open.
The combined native rerun keeps the board at 1752/2565 CLEAN and reduces
the EXTRA-function category 427 -> 426; linked RECON stays 299819/299819
identical, with vtable and overlap audits green.
FETOURN `tListIteratorTournament::TextValue` now initializes the retail
`short tournIndex` from the tier offset and accumulates the selected
value with `+=` on the next source line. The single-expression form had
lost retail's `REG $v0` local despite 22/22 byte-PASS; the split form keeps
the same bytes, restores its native record and block endpoint, and aligns
all 22 instruction SLD tags. FETOURN improves 17/35 -> 18/35 native-CLEAN
and this function is strict SLD-exact; 17 other FETOURN functions remain
native dirty, so this is not a module-wide completion claim.
The linked whole-tree rerun confirms 1753/2565 native CLEAN (812 DIRTY,
MISSING-function category 240) and all 299819 reconstructed image words
retail-identical; vtable, overlap and foreign-label checks pass.
Further FETOURN work restores `UpdateTrackFinishMoney`'s named `dummyCars`
pointer at the same 24-instruction byte match. Its two entry-only retail
scopes remain unattributed, so the function is still native-dirty on BLOCKS.
`GetTrophyName` now uses const `best` and `t` values, preserving its 48
instructions while removing both synthetic debug locals; its scope tree
still differs at the branch and entry. `Initialize`'s const `numCars`
snapshot similarly removes its extra local at 53/53 byte-PASS. In
`tournPointsCompare`, a const `comps` snapshot removes one extra local
at 35/35 byte-PASS; `tm` remains documented because const or direct
inlining omits retail's +280 address instruction (1 diff). These edits
reduce source-only declarations but do not yet clear the remaining
FETOURN block-structure cases.
The combined rerun holds native CLEAN at 1753/2565 but lowers the
EXTRA-function category to 424 and MISSING to 239. The relink remains
299819/299819 identical, with no masked or foreign-label mismatch.
DRAW.obj gains three native-CLEAN functions with byte-PASS preserved:
`Draw_StopRenderingView` uses a const palette-pointer snapshot and places
`LEnv`, `pEnv`, `view` in retail declaration order (70 instructions);
`Draw_SetView` uses a const pre-increment view-index snapshot (69);
`Draw_DirectSetEnvironment` now has two independently typed, branch-local
`e` objects (DRAWENV and DISPENV). GCC correctly reuses sp-128 for their
nonoverlapping lifetimes, reproducing all 65 retail instructions and the
exact local/scope address tree. DRAW.obj improves 14/25 -> 17/25 native
CLEAN. Its strict line-tag audit is still only 1/25, so these are not
claimed SLD-exact. The `Draw_InitViewOT` indexed-array alternative
added five instructions and was reverted; its pointer-walker carrier is
still open. The `Draw_StartRenderingView` const-rounding alternative
failed 59 diffs and was likewise reverted.
Whole-tree confirmation: 1756/2565 native CLEAN (809 DIRTY), with EXTRA
422, MISSING 238 and BLOCKS 684 functions. The real linked reconstruction
remains 299819/299819 retail-identical words; vtable and overlap gates pass.
SKIDMARK's `CalcStartSegment` and `CalcOneSegment` now put `angle` in the
inner retail scope while retaining outer `pxp`/`pzp`. The three-angle
calculation block in `Skidmark_OnyxBuildFacets` similarly owns `t1`/`t2`/`t3`
at retail depth. All three scoped rewrites are byte-neutral (116, 74, 40
instructions) and restore the exact native local/block trees, improving
SKIDMARK.obj 5/11 -> 8/11 native-CLEAN. Their instruction SLD tags remain
non-exact (85/116, 63/74, 37/40 differences); the three remaining SKIDMARK
functions contain extra source carriers, not these scope defects.
Whole-tree confirmation is 1759/2565 native CLEAN (806 DIRTY), with SCOPE
324 and BLOCKS 681; the relink remains 299819/299819 retail-identical and
vtable/overlap checks pass.
FEDIALOG `tDialogBase::DrawAllDialogs` now owns its sole `short i` inside
the retail function-spanning inner block (52/52 byte-PASS). `Hide` is an
early-out on an inactive dialog followed by a scoped list-removal loop;
this places `i` at retail +0x28 and preserves 45/45 byte-PASS. Both are now
native-CLEAN, improving FEDIALOG 11/23 -> 13/23. The adjacent `Display`
early-out also puts `i` at the right depth and +0x24..+0x74 address range,
but two retail zero-instruction scopes at +0x74 remain unexplained; empty
source braces were optimized out of debug and removed. All three functions
still have non-exact SLD instruction tags, so no strict SLD claim is made.
Whole-tree confirmation: 1761/2565 native CLEAN (804 DIRTY), SCOPE 321,
BLOCKS 679. The linked RECON image remains 299819/299819 identical with
vtable and overlap checks green.
AUDIOCMN `RemoveOldestAsyncSfx` now gives each scan a const per-iteration
slot snapshot, creating retail's +0x2c..+0x64 and +0x84..+0xb8 lexical
loop-body scopes without extra debug locals or byte changes. The second
search index is in its separately nested retail block; all 58 instructions
remain PASS. `UpdateSiren` moves retail `iFreq` to function scope, removes
two non-retail debug blocks, and preserves its 129/129 byte match. AUDIOCMN
improves 39/48 -> 41/48 native-CLEAN. Both functions still have non-exact
SLD instruction tags (55/58 and 117/129 differences), so their line maps
remain open.
The full rerun confirms 1763/2565 native CLEAN (802 DIRTY), SCOPE 319 and
BLOCKS 677. Linked RECON remains 299819/299819 retail-identical, and
vtable/overlap checks stay green.
AUDIOCMN `LoadAsyncSfx` moves its indexed-slot alias to function scope,
removing the non-retail +0x50..+0x168 lexical block without adding a
debug local; its 105 instructions remain byte-PASS. AUDIOCMN reaches
42/48 native-CLEAN. `Reset` now scopes the channel index at +0..+0x80,
the music-wait `ticks` inside +0x200/+0x218, and the four-phrase index
one level deeper at +0x11c. Its 214 instructions remain PASS, and all
named local depths agree; two nested retail blocks at +0x2d0 and +0x310
are still unrecovered, leaving Reset native-dirty (16 vs 18 scopes).
Whole-tree confirmation: 1764/2565 native CLEAN (801 DIRTY), SCOPE 318,
BLOCKS 676. The linked RECON image remains 299819/299819 identical and
vtable/overlap checks pass.
FEMENUOPTIONS's repeated fade transitions now use three const expression
snapshots: promoted next fade, upper bound, lower bound. GCC preserves each
31-instruction body but omits the retail-absent `fadeValue` debug local in
`tMenuItemGoToMenuButtonFade`, `tMenuItemLeftRightFade`,
`tMenuItemSlidingMenu`, `tMenuItemSlidingActivated`, and
`tUserNameMenuItem`. `tMenuItemLeftRightAudioSlider` is a measured
exception: this spelling adds one instruction/nine diffs, so its old
19/19 PASS source was restored. A similar two-stage const clamp removes
`clampedSlideHeight` from `tMenuItemSlidingActivated::UpdatefOpenHeight`
at 26/26 PASS. FEMENUOPTIONS improves 54/83 -> 60/83 native-CLEAN;
its strict SLD count remains 7/83, with these six line maps still open.
Whole-tree confirmation is 1770/2565 native CLEAN (795 DIRTY), with EXTRA
down to 416. The linked RECON image is still 299819/299819 retail-identical;
vtable and overlap gates remain green.
FEMENUOPTIONS `tInsideBoxMenu::ProcessInput` now tests `keyval` directly
after its conditional AlreadyProcessed write. This removes the non-SYM
`tVar2` cached-key local and a goto while preserving the 52-instruction
retail body, improving the module to 61/83 native-CLEAN. Its line tags
remain partial. `tMenuItemSlidingMenu::Draw(bool)` removes a redundant
terminal return, preserving 15/15 byte-PASS and aligning all 15 SLD tags;
FEMENUOPTIONS strict SLD coverage rises 7/83 -> 8/83.
Whole-tree confirmation: 1771/2565 native CLEAN (794 DIRTY), EXTRA 415.
The linked RECON region remains 299819/299819 retail-identical and
vtable/overlap checks pass.
SCREENMEMCARD `PlaceIcons` now assigns retail's named `yy` to the saved
$s0 coordinate and leaves the preceding computed-Y expression optimized
out of debug; the prior `savedY` EXTRA and `yy` MISSING disappear at the
same 213-instruction byte-PASS. The separate expression carrier is retained
because direct reuse of one `yy` value is count-exact but two oracle diffs
around the ticks address/copy schedule. An outer placement-loop scope also
puts `fFlags` at the retail local depth and restores the +0..+0x324 block.
Two zero-instruction retail scopes at +0xec remain unattributed, so
`PlaceIcons` is still native-dirty (five vs seven scopes) and far from
strict SLD (199/213 instruction-tag differences). `computedY` is a
semantic reconstruction label, not a claimed original spelling.
The global board remains 1771/2565 CLEAN, but MISSING falls 238 -> 237
and SCOPE 318 -> 317. Relink, honest image (299819/299819), and vtable
checks remain green.
SCREENMEMCARD `LoadIcon` now has exactly retail's four native blocks:
placing the source-only `one` value in the event-loop body owns the
+0x14c..+0x310 scope, while `pulled` lives outside the switch's case scope.
Both values are optimized out of the debug local list; the 215-instruction
body remains byte-PASS and all block start/end offsets agree. SCREENMEMCARD
improves 4/14 -> 5/14 native-CLEAN. Its instruction-line trace is still
partial (203/215 differences), and `PlaceIcons` remains native-dirty.
Whole-tree confirmation: 1772/2565 native CLEAN (793 DIRTY), BLOCKS 675.
The linked RECON image remains 299819/299819 identical; vtable and overlap
checks pass.
`tInsideBoxLeftRightSlider`'s constructor now places its two assignments
on retail relative source lines +2 and +4 and omits a redundant return;
16/16 byte-PASS and native SYM hold, all 16 SLD tags match, raising
FEMENUOPTIONS strict coverage 8/83 -> 9/83. The blank/comment content
between those original lines is not uniquely recoverable. Further probes
on the audio-slider fade clamp found a GNU statement-expression form that
is byte-PASS 19/19 but adds a different debug local and block, so it was
reverted. Moving `tOptionsMenu::UpdateTransition`'s item snapshot into
the loop changed eight instructions, also reverted. Both remain open.
MEMCARD.c uses direct signed `/ 0x2000` in both
`garyMemCardGrabBlocks` and `iMCRD_LoadCard`. GCC emits retail's
sign-bias-and-shift instruction sequence exactly (34 and 63 instructions),
without reusing `card` as a size temporary or declaring a synthetic `size`.
The former restores retail `card` REGPARM $a0; both functions become
native-CLEAN, improving MEMCARD.c 14/21 -> 16/21. Their SLD line maps
remain partial (19/34 and 58/63 differences). A const loop-local `ch`
in `iMCRD_DoFileLoad` stayed EXTRA and added a non-retail block, so it was
reverted to the verified byte-PASS form.
Whole-tree confirmation: 1774/2565 native CLEAN (791 DIRTY), with EXTRA
414 and MOVED 64. The linked RECON image remains 299819/299819 identical;
vtable and overlap checks pass.
MEMCARD.c `sjis2ascii` now uses retail `idx` for the SJIS table-selector
in $a1, retains `bottom` in $a2, and spells the sign-extended high-byte
range tests as direct source expressions. GCC CSEs those expressions into
the retail $v1 web without emitting a named extra; declaration order and
all 44 instruction bytes match, raising MEMCARD.c to 17/21 native-CLEAN.
Its 44/44 SLD line tags remain non-exact. A const loop-local `ch` in
`iMCRD_DoFileLoad` stayed EXTRA and added a non-retail scope; it was
reverted.
Whole-tree confirmation: 1775/2565 native CLEAN (790 DIRTY), EXTRA 413,
MOVED 63. The linked RECON image remains 299819/299819 identical; vtable
and overlap checks pass.
MEMCARD.c `garyMemCardGrabBlocks` now spells its traversal as the source
`for` loop that GCC compiles to the same 34 retail instructions and maps
entirely to SLD line +9. Its three named declarations share the compact
retail entry line; the directory call and signed-division return align to
lines +6 and +16. All 34 instruction tags, block line, and function span
are strict SLD-exact, raising MEMCARD.c to 4/21 strict. The six-line gap
before the return is annotated as unrecovered source content rather than
filled with invented executable statements; exact original comment/macro
text is not claimed.
MEMCARD.c `iMCRD_DoFileLoad` now tests the result of assigning
`sjis2ascii(...)` to `pMFI->title[i]` in one statement. Direct store plus
field reread added four instructions; the assignment expression preserves
retail's 170/170 bytes, omits synthetic `ch`, and matches the retail SLD
statement attribution at +0xd8 (relative line +32). MEMCARD.c improves
17/21 -> 18/21 native-CLEAN; its full function line map remains partial.
Whole-tree confirmation: 1776/2565 native CLEAN (789 DIRTY), EXTRA 412.
The linked RECON image remains 299819/299819 identical; vtable and overlap
checks pass.
AUDIOMUS `InitGlobals` omits its redundant terminal return, aligning all
9 instruction SLD tags at unchanged byte-PASS. `SetCurrentSongInfo` now
separates the remaining-time store from the entry-length calculation and
uses a const snapshot of `AudioMus_g`: the global pointer load belongs to
retail line +1, remaining store to +3, entry address to +5, length store
to +7, filename to +8, call to +10. The snapshot is optimized out of
native SYM and preserves all 16 retail instructions. Both functions are
strict SLD-exact, improving AUDIOMUS 0/23 -> 2/23 strict while retaining
23/23 native-CLEAN. The const snapshot's spelling is semantic, not
claimed original text.
AUDIOMUS `Buffered` now uses three unbraced early returns and the retail
blank line before its final value return; all 19 SLD tags match at 19/19
byte-PASS. `RefreshStatus` puts its guard, status call, nested guard,
request call and else-store on retail source lines +1/+3/+5/+6/+9 and
omits its redundant return, preserving 25/25 byte-PASS. Its constant-false
SimpleMem call is a rodata-retention reconstruction, not claimed original
text; the matching line region is explicit. AUDIOMUS strict SLD coverage
rises 2/23 -> 4/23, with native coverage still 23/23.
AUDIOMUS `InitDriverGlobals` moves `requestsong = -1` after the other
initial zero stores, as retail SLD line +8 requires. GCC still schedules
its constant load before those stores, preserving all 23 retail bytes.
Its declarations and assignments now occupy the retail +1..+25 source
regions with 0/23 SLD differences, raising AUDIOMUS strict coverage
4/23 -> 5/23. Non-emitting gaps are left as blank/comment regions; their
original text is not claimed recoverable.
AUDIOMUS `DriverCleanUp` now places the guarded task deletion and stream
destruction on retail relative lines +3/+5/+6 and +8/+10/+11, with the
driveractive reset on +13; removing its redundant terminal return makes
all 31 instruction tags exact. `SysCleanUp` similarly aligns its driver
cleanup, two guarded purges and final global reset to retail lines
+3/+5/+6/+8/+9/+11/+12 and omits the return, preserving 30/30 bytes.
Both become strict SLD-exact, raising AUDIOMUS 5/23 -> 7/23 strict;
native coverage remains 23/23.
AUDIOMUS `QueueRequestedSong` now spells the locate and queue calls on
retail +3/+7, switch/failby on +9/+10, remaining reset on +14, `info`
address on +16, and six entry-field stores on +18..+23. Reordering the
remaining reset before `info` is byte-neutral; GCC still schedules its
address calculation first. All 44 SLD tags and native locals now match
at unchanged 44/44 byte-PASS, raising AUDIOMUS strict coverage
7/23 -> 8/23. Explanatory oracle comments moved outside the function;
non-emitting gaps are not claimed as verbatim original text.
AUDIOMUS `Threshold` now preserves retail's single blank source line before
its early-return chain. This aligns its function block end and all 33
instruction SLD tags at unchanged 33/33 byte-PASS and 23/23 native-CLEAN;
AUDIOMUS strict coverage rises 8/23 -> 9/23.
AUDIOMUS `Fail` now aligns the error store (+1), guarded autovol and
fade-time calls (+3/+5/+6), and switch resets (+20..+24) at unchanged
31/31 byte-PASS. A twelve-line interval between fade-time and newswitch
has no emitted instructions or recoverable original text; the source marks
it explicitly without inventing behavior. All 31 SLD tags are exact,
raising AUDIOMUS strict coverage 9/23 -> 10/23.
AUDIOMUS `SetEntry` moves the nested `p` declaration to retail source
line +2 and aligns the artist/label/date/notes stores to +1..+4, with
titlechar's initial zero and the filename-loop head on +6/+9. The
34-instruction body and native local homes remain exact; instruction-tag
differences fall 26/34 -> 18/34. The loop-body and closing-line source
shape is still open (the `p` block ends +25 versus retail +27), so the
function is not marked strict SLD-exact.
FEINPUT `VerifyControllerValues` now uses nested unbraced guards for
the no-pad and controller-ID checks, matching retail source lines +1/+5
and putting Front_ResetPSXController on +9. The 24 instructions, native
locals and block end stay exact; SLD instruction-tag differences fall
22/24 -> 4/24. The final return instruction still tags +9 rather than
retail +10. A null statement did not move it; an explicit return moved
the native block end to +11, so those variants were reverted. Its
remaining line attribution is documented, not marked strict SLD.
COPSPEAK `ReadyNextRequest` now tests the SYM-owned `ok` value directly.
A const hasSfx snapshot in the failure arm supplies retail's nested
+0xbc..+0xe8 scope while its containing branch supplies +0xb4..+0x1d8;
the old requestOk alias and one redundant lexical block are removed.
The exact native local/block address tree and all 156 instructions match,
improving COPSPEAK 23/27 -> 24/27 native-CLEAN. The SLD source-line
fields remain partial; hasSfx is a semantic, optimized-out label.
Whole-tree confirmation: 1777/2565 native CLEAN (788 DIRTY), BLOCKS 674.
The linked RECON image remains 299819/299819 identical; vtable and overlap
checks pass.
COPSPEAK `InitVars` now puts the bank initialization loop on retail SLD
lines +5/+7/+8/+9, then writes buffer before speech handle on +10/+11.
GCC still schedules the handle store ahead of the buffer store, preserving
all 31 retail instructions. The queue fields remain +12..+20 and the
request initializer +21; removing the redundant return makes all 31 tags
and native block lines exact. COPSPEAK strict coverage rises 13/27 ->
14/27 while native coverage remains 24/27.
COPSPEAK `Alloc` now follows retail source order in its second allocation
arm: buffer high on +16, buffer start on +17, buffer end/low on +19/+20,
and the zero-buffer return on +22. The first arm's guard and stores map to
+9/+11/+12, and the final failure store/end to +25. GCC preserves all
38 retail instructions despite scheduling the buffer-start store ahead
of buffer-high. All SLD tags and native records match, raising COPSPEAK
strict coverage 14/27 -> 15/27. Compact same-line returns/closing brace
encode recoverable line spans, not a claim of exact original punctuation.
COPSPEAK `Free` now places its outer/inner guards on +1/+3/+5, the high/end
resets on +7/+8, the fallback guard on +11, buffer-start reset and return
on +12, low-buffer update on +14, and final buffer clear/end on +16/+17.
All 36 SLD tags and native records match at unchanged 36/36 byte-PASS,
raising COPSPEAK strict coverage 15/27 -> 16/27. Compact same-line
punctuation records the source span, not verbatim original formatting.
COPSPEAK `GenericBankRequest` compacts its pointer/count setup to retail
line +1, uses the one-line bound update at +3, and aligns its queue guard,
initializer and fields to +6/+8..+13. The 41-instruction byte-PASS body
and native locals remain exact; 41/41 SLD tags now match, raising strict
coverage 16/27 -> 17/27.
COPSPEAK `DirectRequest` now shares the proven queue-setup source shape of
`GenericBankRequest`: pointer/count +1, bound update +3, guard +6,
initializer +8, fields +9..+13 and head update +19. All 43 instruction
tags and native records match at 43/43 byte-PASS, raising COPSPEAK strict
coverage 17/27 -> 18/27.
The five non-emitting lines before the head update are annotated as
unrecovered source content, not invented behavior.
REPLAY `SaveReplay` removes a redundant terminal return, aligning 35/35
SLD tags at unchanged byte-PASS. `StoringReplay` places its save call on
retail +2 and camera-count reset on +5 with no redundant return, aligning
8/8 tags. `LoadReplay` is an empty retail stub whose scope ends on +1
while its return instruction is attributed to +23; a null statement and
21 non-emitting lines represent exactly those known records without
inventing replay behavior. All three are strict SLD-exact, improving
REPLAY from 0/16 to 3/16 strict while retaining 14/16 native-CLEAN.
The original text of LoadReplay's gap remains an explicit backlog item.
REPLAY `DoReplay` now places its mode guard, save-input call and get-input
call on retail relative source lines +5/+6/+8; the compact else and
omitted terminal return preserve its 17/17 byte-PASS body. All SLD tags
match and strict coverage rises 3/16 -> 4/16. The four non-emitting lines
before the guard are left textually unrecovered.
`Font_Getcharacter` now uses a const use-site snapshot of the font-table
pointer, removing synthetic `characterTableBase` while keeping35/35
byte-PASS. `ch` and `base` are declared in retail order. The sole native
residual is `base` in $s3 rather than retail $s2: the raw stream keeps
`&currentfont` in $s3 and the loaded table pointer in $s2, so the current
source name attaches to the wrong value role. Direct rereads shrink to
33 instructions (22 diffs); an in-place base value chain shrinks to33
(36 diffs); a const font-record alias keeps14 diffs. Those were reverted.
The exact C shape that attaches `base` to $s2 without changing bytes remains
open; no source-role fiction is claimed as solved.
`Font_SwitchFont` now uses const use-site values for `fontShape` and
`abr_val`, omitting both extra debug locals while preserving27/27
byte-PASS. Removing the wrapper around optimized `arg3` removes its
non-retail empty scope. Only the `base` carrier remains: const or direct
`&currentfont` struct-view stores produce28 instructions and13 diffs by
losing the shared MEM_IN_STRUCT_P address pseudo; both were reverted.
FONT.obj remains12/15 native-CLEAN, but its three dirty functions now have
fewer unexplained source objects. SLD line work remains independent.
The full native board remains1744/2565 CLEAN, while the global
EXTRA-local function category decreases434 ->433.
Six short FONT methods are now strict SLD-exact and remain byte-PASS:
`Font_SetBlitter` (3), `Font_ReSetBlitter` (5), `Font_ExitFromGame` (5),
`Font_TextTint` (8), `Font_TextColor` (14), and `Font_DeInit` (20).
Each omitted a redundant explicit terminal `return`, letting the final
store or guarded cleanup own the retail epilogue line; their lexical block
fields and spans also agree. FONT.obj strict SLD rises0/15 ->6/15 while
native remains12/15. The remaining Font functions have distinct source
or SLD issues and were not blanket-edited.
Five short FEMENUOPTIONS fade transitions are now strict SLD-exact with
unchanged byte-PASS bodies: `TransitionOff` for GoToMenuButtonFade (3),
LeftRightFade (6), LeftRightAudioSlider (4), and UserNameMenuItem (3),
plus `TransitionOn` for LeftRightAudioSlider (6). Each omitted a redundant
explicit final return so the epilogue tag follows the last retail store.
The TU's strict SLD count improves2/83 ->7/83; native remains50/83 and
all83 functions remain byte-PASS. Other `TransitionOn` functions have
different retail statement ordering and were not blanket-edited.
`StatChk_SaveRecordLapTime`'s one extra `newBestLap` result remains:
changing it to a compile-time const and removing its later assignment
preserved100 instructions but reproduced the known six address/value-
register swaps, so the trial was reverted. `StatChk_ClearNewRecords` now
has all11 relative SLD tags, the `i` register and the function block span
exact after moving its reconstruction note outside the body and grouping
the loop store/back-edge on retail line +3. All five STATCHK functions
remain byte-PASS; strict SLD improves0/5 ->1/5, native remains4/5.
`tScreenMemcard::DrawForeground` still needs the extra fade carrier in the
byte-PASS 39-instruction form: a const direct clamp shortened it to37
instructions with18 diffs and was reverted. In the same TU, placing the
constructor's final card store and explicit return on retail line +2
aligns all17 instruction tags, block fields and function span. The memcard
TU remains14/14 byte-PASS and4/14 native-CLEAN; strict SLD improves0/14
->1/14. The same-line grouping is debug-line evidence, not a claim about
original formatting.
`tScreenMemcard::GetShapeInfo` now matches all9 relative SLD tags, its
one-line lexical block and function span, staying9/9 byte-PASS/native-
CLEAN. The two zero stores share retail line+3, the permanent-shape count
is +4, and the filename store/return share +12. A seven-line source gap
before the latter has no instruction or named local; it is marked in a
reconstruction comment without inventing behavior or claiming original
text. The memcard TU's strict SLD count rises1/14 ->2/14. `Cleanup`'s four
missing zero-length entry scopes remain unattributed and were not faked
with unused local declarations.
`tScreenMemcard::LoadIcon` no longer needs its synthetic `cardInfo`
pointer. A `CARDINFO_def *const` declared where `this->pCI` is read
preserves the retail pCI-load position and the full215/215 byte-PASS body,
while GCC omits that const from native SYM. Direct repeated `this->pCI`
accesses previously moved the load by two rows; the const form keeps the
single snapshot. The function still has eight reconstructed scopes versus
retail four, so it remains native-DIRTY and SLD-partial. The const name is
a semantic reconstruction label, not a recovered original identifier.
The full native board remains1744/2565 CLEAN, while the global
EXTRA-local function category decreases433 ->432.
`tScreenMemcard::ReleaseIcons` now has all30 relative SLD instruction
tags, the SYM-named `i` register and block-line fields exact, with its
30/30 byte-PASS body unchanged. The initializer/loop entry share retail
line+2; icon clears are +6/+7/+8; conditional CLUT release is +10/+12/+13;
increment, back-edge and return share +17. The intervening comment lines
mark regions with no recovered instruction or local, not original text or
invented behavior. Screenmemcard strict SLD rises2/14 ->3/14; native
remains4/14.
`tScreenMemcard::Initialize` now selects the Load Game message ID in a
`const uint msgId` at its use site, after `player` and `card` are set. GCC
keeps the retail staged `$a3` value and106/106 byte-PASS instructions but
omits `msgId` from the native local list. A direct menu-field ternary was
previously measured at43 diffs; this retains its allocation without the
extra source object. The method remains native-DIRTY solely for six
unrecovered zero-length retail scopes at +0x120 (2 scopes ours versus8
retail), and its SLD line map remains partial. The const name is semantic
reconstruction, not an original-name claim.
The full native board remains1744/2565 CLEAN; the global EXTRA-local
function category decreases432 ->431.

`Camera_OpponentLookBehind` now uses early guards for the empty car list,
self-car entry, and distance cutoff. GCC keeps all245 instructions byte-PASS
and the named local homes unchanged while the debug tree shrinks from eight
scopes to two. The remaining non-retail +0xd0..+0x21c scope follows the
candidate loop body. An explicit label/back-edge changed 109 instructions
and frame allocation; a `for` version changed17 instructions; `while(1)`
kept bytes but moved that scope end to +0x234 rather than removing it. Those
loop-form trials were reverted. This is verified partial scope recovery,
not a native CLEAN or SLD seal; the Camera and full-board CLEAN counts do
not change.

AIDelayCar is now3/3 function-contract CLEAN,3/3 byte-PASS and3/3 exact for
instruction-relative SLD, native lexical-block lines and function spans.
Update no longer misuses currentDeltaRoadPosition as a distance/slice carrier;
the correct road delta holds its native a0 home. Grouped vector operations and
the constructor's delayFactor-before-basisCar assignment order restore SLD.
The optimized-away currentDeltaMeters result name is explicitly inferred from
the distance query, not claimed as recovered. No bytes or linked data moved.
Receipt: `scratchpad/sym_aidelaycar_20260921/README.md`.

AISpeeds_RandomizeTrafficSpeed restores newsafe as the resulting speed in a1,
not the randomizing factor in a0. Ordinary signed divisions replace manual
rounding and the oldsafe carrier chain. Its native function contract, all35
instruction-relative SLD tags and lexical-block lines match; AISPEEDS is17/29
CLEAN and29/29byte-PASS, with a literally unchanged object and honest link.
Receipt: `scratchpad/sym_aispeeds_random_20260921/README.md`.

AISpeeds_GetPrevAICar now declares carLoop in its for loop rather than at
function scope. Its native scope/address/line contracts and all27 relative
instruction SLD tags agree, without changing the object. AISPEEDS is18/29
CLEAN and29/29byte-PASS. Receipt: `scratchpad/sym_aispeeds_prev_20260921/README.md`.

AISpeeds_MaintainLeaderBoard restores its for-counter and per-iteration test
scope (1 ->3), with native declaration homes/order, block lines and all64
relative instruction SLD tags exact. Explicit head-break and post-increment
control flow are preserved. AISPEEDS is19/29CLEAN and29/29byte-PASS; object and
honest link unchanged. Receipt: `scratchpad/sym_aispeeds_board_20260921/README.md`.

AISpeeds_CalcCopTopSpeed now assigns the final scaled speed to native
newDesired before applying direction, restoring its missing v1 record.
All50 instruction-relative SLD tags and native scope lines match, with an
unchanged object and honest link. AISPEEDS is20/29CLEAN and29/29byte-PASS.
Receipt: `scratchpad/sym_aispeeds_coptop_20260921/README.md`.

AISpeeds_NeedToSlowDownForCurve now retains neededDistance as the adjusted
distance rather than folding it into an anonymous return expression. The
private inline helper's formal order and sole call site now agree with native
futureSpeed/currentSpeed records. All41 relative SLD tags, inline scopes and
block-line fields match; AISPEEDS is21/29CLEAN and29/29byte-PASS, with unchanged
object/link bytes. Receipt: `scratchpad/sym_aispeeds_brake_20260921/README.md`.

AISpeeds_LimitGlueMultiplier now uses an in-range early return, a for scan and
the native per-iteration distance local. Its three scopes, native block lines
and all61relative SLD instruction tags match. The old duplicated return used
as an allocation dial was removed; ordinary control flow preserves the same
bytes. AISPEEDS is22/29CLEAN and29/29byte-PASS. Receipt:
`scratchpad/sym_aispeeds_limit_20260921/README.md`.

The AISPEEDS start-of-race speedup function now retains the native
f_crappyFrameRateCompensatingSpeedup local instead of leaving its declaration
unused. Native scopes and all39relative instruction SLD tags match with
unchanged object/link bytes. AISPEEDS is23/29CLEAN and29/29byte-PASS.
Receipt: `scratchpad/sym_aispeeds_startboost_20260921/README.md`.

AISpeeds_CalcOpponentCurveSpeed no longer uses the reconstruction-only
AISpeeds_AddScanSlice helper. The established slice-wrap expression, for scan
and combined return condition preserve all90words while removing seven excess
scopes. Native local contracts, block lines and relative SLD tags all agree.
AISPEEDS is24/29CLEAN and29/29byte-PASS. Receipt:
`scratchpad/sym_aispeeds_curve_20260921/README.md`.

Checkpoint before the requested pause: all seven retained AISPEEDS corrections
were rechecked together against fresh native SYM (372 instruction SLD tags,
including full lexical-block lines). The GetLegalSpeed no-volatile loop probe
remained3differences/16vs17words and was reverted; its existing workaround and
scope discrepancy remain open. Combined proof:
`scratchpad/sym_aispeeds_legal_20260921/checkpoint.json`.

2026-09-22 refresh: committed SimpleMem data attribution changed the AISPEEDS
reference by a12-byte retail tag prefix and exactly two LO16 addends (+12).
The old references were archived only after raw-ROM and fresh honest-link
proof; the new baseline preserves those committed changes. Stale NIGHT and
SPEECH debug objects were refreshed, removing a reference to the deleted
Night_gCopCarTypeColorIdx placeholder and restoring all53 SPCHEVNT functions
after their committed fold into Speech. Compared coverage remains2565.

ReadTuningInfo now for-declares trackLoop, restoring its missing repeated
native records. It remains DIRTY (slotLoop and scope work still open); its
whole object and linked image are unchanged and AISPEEDS remains29/29PASS.
Receipt: `scratchpad/sym_aispeeds_tuning_20260922/README.md`.

Follow-up: ReadTuningInfo is now function-contract CLEAN. A for-declared
slotLoop plus the first loop's real timing intermediate, and a for-declared
carModelLoop in the discard branch, restore every native local/order/home and
all11scope boundaries. The timing intermediate is optimized away; its name
distanceMaintainTime is explicitly inferred, not claimed as a native spelling.
For-declaration alone was9diffs/160words; the scoped value computation restores
161/161PASS with the complete object unchanged. AISPEEDS is25/29CLEAN and
29/29PASS; honest link remains299819/299819words,0diff. Relative SLD line tags
and block-line fields remain unresolved, so this is not full source restoration.
Receipt: `scratchpad/sym_aispeeds_tuning_20260922/scope_receipt.json`.

GetGlueFactor follow-up removes four invented goto labels using ordinary
nonnegative-first nested clamps. The complete object stays identical,
131/131target instructions and29/29AISPEEDS functions remainPASS, with no
branch-target changes. Its three MOVED glueIndex records still need correction:
retail names the pre-clamp index, whereas our source names the selected index.
Direct expression repairs tested so far move bytes and were not retained.
Receipt: `scratchpad/sym_aispeeds_glue_20260922/README.md`.

BTCGetGlueFactor's empty identity asm fence is now removed. An excluded-car
early return and for-declared humanLoop naturally preserve the retail zero
initialization and restore the native first-loop scope nesting/address ends.
All111instructions and the complete AISPEEDS object remain unchanged;29/29PASS.
The extra clampedGlueIndex and later scope/SLD discrepancies remain open,
and the source no longer asserts that the extra object is proven necessary.
Receipt: `scratchpad/sym_aispeeds_btc_20260922/README.md`.

Its subsequent clamp cleanup also removes the invented clampLow/clampDone
labels through structured nested branches, preserving the complete object.
Direct subscript-expression trials still change code generation; the extra
clampedGlueIndex is not hidden or relabeled as a proven original object.

Hrz_InitSky's height/radius value associations now agree with retail: height
is the sine-derived vertical s4 value, radius the cosine-derived horizontal
s5 value. Native declaration order stays unchanged, as does the complete
object. HRZSKU15/22SYM-clean,22/22byte-PASS. Its pre-existing fence remains
an explicit recovery item; this does not claim full SLD restoration. The stale
legacy reference was first explained by committed SimpleMem data (+12bytes,
two LO16 addends+12), checked against rawROM and honest0diff, and archived.
Receipt: `scratchpad/sym_hrzsku_names_20260922/receipt.json`.

Hrz_LightningFlicker now places i in the on-branch, restoring all three native
scope address boundaries (previously one) while retaining55/55instructions
and the complete object. EXTRA col remains: direct literals move two loop
initializations, so those trials were not retained. Its necessity is no
longer asserted; relative SLD line positions also remain open.
Receipt: `scratchpad/sym_hrzsku_names_20260922/flicker_review.md`.

Hrz_InitSkyColor now restores native loop/body declaration scopes with ordinary
for-loop tests. All87relative instruction SLD tags, lexical-block line fields,
function span and native local/frame/scope contracts match. This supersedes
the old claim that for tests could not preserve its branch topology. Entire
object stays unchanged; HRZSKU16/22SYM-clean and22/22bytePASS. No new names,
asm, volatile, helper carriers or output rewriting.
Receipt: `scratchpad/sym_hrzsku_names_20260922/skycolor_sld.py`.

Hrz_Init2DRing's colour half now restores for-declared level and native
cur_bk/cur_fr/rounddiff/j ownership, with the exact scope address sequence
from+0x158 onward. The whole object remains unchanged and22/22PASS. Two
empty scopes in its earlier pixmap loop and full SLD remain unresolved;
candidate temporary declarations were rejected rather than retained to make
scope counts look right. Receipt:
`scratchpad/sym_hrzsku_names_20260922/ring_review.md`.

Ownership correction (historical checkpoint): compact SYM proves
Copspeak_gTimeString.308 exists, but did not prove CopSpeak_Debug owned it.
Its later file-scope move is documented above along with the still-open
generated-name, BSS-address and exact-TU attribution mismatches; clearing
the function's EXTRA alone is not a whole-data SYM seal.

## Tool set

All tools are in `tools/psyq_pipe/` unless a path is given; their generated outputs go to the local, git-ignored `scratchpad/psyq_pipe/`. Nothing here edits `tools/build.py`.

### Producing our SYM

| Tool | What it does |
|---|---|
| `gdebug_compile.py [fragment ...]` | Compiles the game and front-end translation units with full `-g` into `build/gdebug/`. It imports `tools/build.py` and uses its own per-file flag logic, turning `-g1` into `-g` for C and injecting `-g` into every CC1PLPSX call. Writes `gdebug_report.json`: per file, whether `-g` left the instruction stream unchanged. |
| `psylink_lane.py` with `NFS4_LANE_G=1 NFS4_LANE_OUT=build/psyq_g` | The PSYLINK lane in full-debug mode: uses the `build/gdebug` compiler output where it exists, passes `-g` to ASPSX (required — without it only the variable records survive), links in retail order into its own directory, and dumps the SYM to `build/psyq_g/nfs4_sym.txt`. The normal measurement lane (`build/psyq`) is untouched. |
| `NFS4_LANE_ONLY=<fragment,...>` | Restricts the lane's assemble step to the named files; everything else keeps its last object. This is what makes the per-file loop fast. |

### Comparing

| Tool | What it does |
|---|---|
| `symtree_cmp.py build/psyq_g/nfs4_sym.txt [--list CLASS] [--fn NAME] [--retail-only]` | The whole-tree board. Compares frame, local names/homes/types/**scope depths**, and block tree with retail SYM and writes `symtree_report.json`. Normalises the lane's `___X` destructor spelling and anonymous tag numbers (`._148`). The scope-depth comparison and backup are documented above. |
| `symfn_cmp.py <dump> <mangled name>` | One function, both sides next to each other: frame, every local with its home, and the scope tree with function-relative addresses and line numbers. The main tool for hand work. |
| `symlocals.py <name> ...` | Compact one-line view: the locals of a function in declaration order with scope depth and home, ours against retail. |
| `symtree_parse.py` | The dumpsym-text parser shared by the tools above. |
| `scope_probe.py <file.cpp>` | Compiles a small probe with the retail compiler and `-g` and prints each function's scope tree. Used to learn which source constructs create a debug scope (see "Scope rules"). Probe source: `tools/psyq_pipe/gsym/scopes.cpp`. |
| `g_codecmp.py A.s B.s`, `g_codediff_fn.py <rel path>` | Does `-g` change the generated instructions? Whole file, or per function with the diff. |

### The edit loop and its gate

| Tool | What it does |
|---|---|
| `symloop.py <rel path> [...] [--quiet] [--ref-only]` | Guarded per-file loop. `--ref-only` **freshly rebuilds** before capturing a missing reference or verifying an existing one; run it **before editing**, including once to adopt a legacy reference's section-layout companion. Normal runs require references, unchanged section bytes/layout, fresh successful debug/native-link outputs and complete selected-function coverage. Failures return nonzero without a success token. `BYTES: UNCHANGED` is printed only after the full pipeline succeeds. Logs and earlier generated artifacts are retained in `build/symloop_runs/`. |
| `symfix_order_drive.py [fixer.py]` | Legacy automatic driver: still uses whole-file `git checkout` reverts and needs separate hardening. Do not use on a dirty worktree or assume its stdout-based acceptance is a complete source/matching proof. Use the guarded per-file loop manually for now. |

Wrapper regression tests: `python tools/psyq_pipe/test_symloop.py` (11 tests /38 controlled runs).
Live proof and limitations: `scratchpad/symloop_guard_20260920/README.md`.
Known `-g` code-changing cases require lower-level diagnostics rather than passing the acceptance loop.
SYM CLEAN and unchanged baseline bytes do not replace the separate requirement that **every function must be PASS**.
Keep this a single-writer workflow; the downstream normal/debug caches are shared.

### Automatic fixers

| Fixer | Pattern | Result so far |
|---|---|---|
| `symfix_spchevnt.py` | `SPCHEVNT.C`: parameters are `struct SPCHNFSType_X { unsigned long flags; } *`; `parms` is declared before `i`. | 53 of 53 functions clean |
| `symfix_order.py [--apply] [--fn a,b]` | Reorders the declarations at the top of each scope into retail's order. Handles a leading literal-carrier statement, multi-line brace initialisers, and carrier locals retail lacks (they keep their place). | 87 functions; 3 move code |
| `symfix_fordecl.py` | A retail local alone in a scope one level below where we declare it, driving a loop: rewrite as `for (T v = INIT; COND; STEP)`. Handles existing `for (v = ...)` and the decompiler shape `v = INIT; do { ...; v = v + 1; } while (COND);`. | 35 functions; 3 move code |
| `symfix_rename.py` | One extra local and one missing retail local in the same home: rename ours. | Dry run only — almost every candidate is skipped because the retail name is already used in the function |

### Guards on the honest link

`tools/honest_measure.py` (0 diff), `tools/overlap_audit.py`, `tools/foreign_labels.py`. Run
`python tools/gen_ld.py --link` and `python tools/honest_measure.py` after every batch.

Pitfall: `gen_ld` links whatever object is in `build/`. After a manual `git checkout` of a source, rebuild that file
(running `symloop.py` on it is enough) before linking, or a stale object shows up as diff words.

## Scope rules of CC1PLPSX 2.8.0 with `-g`

Measured with `scope_probe.py`. These explain most scope-tree differences.

- `for`, `while`, `do`, `if`, `switch` and a plain `{ }` **without declarations** create no scope. A brace block becomes a
  scope only when it declares something.
- `for (int j = 0; ...)` creates one scope holding `j`. Later blocks of the enclosing block nest inside it.
- An **inlined call** creates two nested scopes: the outer holds the callee's parameters (`this` for a member function;
  value parameters the optimiser removed are not listed), the inner is the callee's body. So `{ REG $n this { } }` inside a
  function means "an inline member function was called here on the object in register n".
- A declared local the optimiser eliminated is not listed, but its scope stays. An empty retail scope is a block, or an
  inline body, whose locals were all optimised away.
- A scope's locals are listed in declaration order.

## How the differences are classified

A function can be in several classes.

| Class | Functions | Meaning |
|---|---|---|
| BLOCKS | 724 | The scope tree differs: retail has more scopes in 530, ours in 170, and 24 have equal counts but different nesting or addresses. |
| EXTRA | 448 (1255 locals) | We declare a local retail does not have: an invented carrier, a decompiler temporary, or an expression retail wrote through an inline call. |
| MISSING | 243 (350 locals) | Retail has a local we lack, often an inlined `this`. |
| MOVED | 66 | Same name, different register or stack slot: our local plays a different role than retail's. |
| SCOPE | 358 | Same local name can occupy a different lexical depth even when the block tree matches; now reported explicitly. |
| ORDER | 7 | Declaration order differs (only reported when no local is extra or missing). |
| TYPE | 1 | Same name and home, different type. |
| FRAME | 1 | Frame size differs. |

Most common combinations: BLOCKS + SCOPE 160; BLOCKS only 127; EXTRA only 109;
BLOCKS + EXTRA 98; BLOCKS + EXTRA + SCOPE 79; BLOCKS + MISSING 66.

Files with the most differing functions: `SPEECH.CPP` 44 of 87, `HUD.CPP` 33 of 62, `FEMENUOPTIONS.CPP` 33 of 83,
`FEMENUDEFS.CPP` 26 of 59, `DRAWW.CPP` 24 of 35, `SCREENCARSELECT.CPP` 21 of 56,
`AISTATE.CPP` 20 of 42, `CAMERA.CPP` 19 of 38, `FETOURN.CPP` 18 of 35, `NEWTON.CPP` 17 of 32.

## What is left, and how to attack it

### 1. Inline calls (the bulk of BLOCKS, MISSING and much of EXTRA)

Retail's source called inline member functions and inline helpers where ours spells the expression out, often through an
invented pointer local. The SYM shows where the call was and on which register, but never the inline's name.

Method, proven on `AIHigh_BasicPerp::AddChaser` / `RemoveChaser`:

1. `symfn_cmp.py` on the function. Find the `{ REG $n this { } }` pair and its function-relative line.
2. Find which object lives in that register at that point, and which of our statements it corresponds to.
3. Add an inline member to that class that does exactly that, and call it. Delete the carrier locals it replaces.
4. `symloop.py` on the file (and on every file that includes the header, if the class changed). Keep it only if the
   bytes are unchanged.

In that case the old note said the direct array spelling cost 7–12 diffs; the inline member was the exact form, and three
`SYM-CODEGEN-CARRIER` locals disappeared. Inline names are ours — the SYM keeps none — and should be marked as such.

Each inline member added to a shared class pays off in several functions. Good starting points: the rest of
`aih_basicperp.cpp` (4 functions, all this kind), then the other AI files that share `aih_hierarchy_types.h`.

One failed attempt, reverted: an inline default constructor for `AICop_BasicPerpInfo` to reproduce the nested scope pairs
in the `AIHigh_BasicPerp` constructor. The bytes moved and the tree was still one level short.

### 2. Declaring blocks and for-declarations (BLOCKS where retail has more scopes but no `this`)

- A retail local alone in a deeper scope with a loop on it: `for (T v = ...)`. The automatic fixer has done the cases
  it can recognise; others need the loop found by hand.
- A group of retail locals one level deeper than ours: they were declared inside a block (`if (...) { T x; ... }`), as in
  `Audio_InitDriver` and `Night_PauseLightningEffect`. Move the declarations into the block.
- An empty retail scope: a block or inline body whose locals were optimised away. The names are unknowable; only the
  shape can be reproduced, and only by a local that really gets eliminated. Example still open:
  `Stats_TrackEndGame`'s scope `+150..+1c8`, and the intermediate scope in `AIHigh_Traffic::CheckForCops`.

### 3. Scopes we have and retail does not (BLOCKS, 171 functions)

Usually braces added to steer code generation, or inline helpers of ours that retail did not have. 55 files also carry the
`if (0) sprintf((char *)0,"SimpleMem")` literal carrier in their first function; how retail got that unreferenced string
into each object is unsolved, and until it is, those functions cannot be fully clean by honest means.

### 4. Invented locals that are not inline calls (EXTRA)

Carriers introduced to get a register allocation or an instruction order (`SYM-CODEGEN-CARRIER` comments mark most). Each
is a real matching problem: the local has to go and the code has to stay. `Stats_TrackEndGame` (commit `ad44f8d0`) is the
model: the fix was the operand order of a `MIN`, after which two register pins, four asm statements and four invented
locals were all unnecessary.

Only 36 of the 1301 extra locals still have decompiler names (`iVar1`, `piVar2`); the rest look deliberate.

### 5. MOVED (80)

Same name, different home. The bytes match, so our variable of that name is not the quantity retail's was. Typical cause:
names swapped between two locals (`AIPhysic_HandleSignalling`: `lPos`/`lDes`; `DrawC_ShadowPrimClip`: `uv2`/`uv3` are
named by destination slot). Check for a swap first; 15 functions have MOVED as their only difference.

### 6. Open order and type cases (9)

| Function | Why it is still open |
|---|---|
| `DrawGouraudShape` (`psxfront.cpp`) — TYPE `prim` | Retail: `POLY_GT4 *`. Ours: `u_char *` byte cursor. A typed pointer with byte casts regresses the match (documented in the source, 7 → 89); needs a rewrite through the struct's fields. |
| `Anim_InitSystem`, `DrawC_DividePrim`, `Night_InitNightDriving` | The plain reorder to retail's order moves the code. Something else in our source compensates for the wrong order. |
| `PinkSlipsPreSave` | Retail has `ret`, `YesNoDialog`, `answer` in one scope. Spelled that way the code moves: our inner block currently steers a delay slot. |
| `AISpeeds_GetCaravanFactor` | Our body is built from gotos; retail has nested scopes (`tempRandom` at depth 3, `prevAICar` at depth 5). Needs restructuring. |
| `CheckIfCaught`, `CheckCallSignBank`, `R3DCar_ReadInCarData` | The order differences come from missing nested scopes and inline calls; they fall out of the scope work. |

### 7. The one FRAME case, and the `-g` decision

`-g` is code-neutral in 180 of the 181 game files. The exception is the `tGlobalMenuDefs` constructor in
`femenudefs.cpp`: frame 608 bytes with `-g`, 640 without. Retail was built with `-g` and has 640, so our source for that
function matches only under the wrong flag.

Open decision: make `-g` the default for game code in the normal build. It is the flag retail used; the constructor has to
be re-matched under it first. Until then the debug compile lives beside the normal build (`build/gdebug`).

### 8. Coverage gaps

- `recon/eaclib/psx/pad.c` (5 functions with debug records in retail) is not in the `-g` file list.
- `SPCHEVNT.C` is compiled **inside** `Speech.obj` in retail (its debug records sit in that object's block). Ours is a
  separate C file. The functions are clean, but the file structure is not retail's.
- Line layout is not compared. Retail's block and function records carry function-relative line numbers, so the original
  line structure of each function is recoverable (for example `Stats_TrackEndGame` spans 81 lines; ours 65).
- Types of globals, struct layouts and the file-level records of the SYM are not compared yet — only function-level records.

## Typical session

```bash
python tools/psyq_pipe/symloop.py recon/game/common/aih_basicperp.cpp --ref-only
```

```bash
python tools/psyq_pipe/symfn_cmp.py build/psyq_g/nfs4_sym.txt AddChaser__16AIHigh_BasicPerpii7copType
```

Edit the source, then:

```bash
python tools/psyq_pipe/symloop.py recon/game/common/aih_basicperp.cpp
```

Keep the change only on `BYTES: UNCHANGED`. After a batch:

```bash
python tools/gen_ld.py --link
```

```bash
python tools/honest_measure.py
```

```bash
python tools/psyq_pipe/symtree_cmp.py build/psyq_g/nfs4_sym.txt
```

A full refresh from scratch (about 15 minutes): `gdebug_compile.py`, then the lane with `NFS4_LANE_G=1
NFS4_LANE_OUT=build/psyq_g`, then `symtree_cmp.py`.
