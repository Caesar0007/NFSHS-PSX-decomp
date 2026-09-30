# SYM match — making the source agree with the retail `NFS4.SYM`

Status as of 2026-09-30. Current full-debug board: `build/psyq_g/symtree_report.json`.

Native-only per-directory snapshot after the physics/collision restoration rounds (2565 common
covered functions; not a full source-declaration/carrier/SLD seal):

| Retail directory | Native CLEAN | Native DIRTY |
|---|---:|---:|
| FRONTEND/COMMON | 711 | 127 |
| FRONTEND/PSX | 61 | 24 |
| GAME/COMMON | 1096 | 151 |
| GAME/PSX | 284 | 111 |
| Total | 2152 | 413 |

Retail-only functions and incomplete eaclib/syslib data are outside these
common-function counts. Unrecorded const aliases and inferred inline helper
spellings still require explicit source review even when native CLEAN.

2026-09-30 `AIHigh_BasicPerp::RemoveCloseCops`: the old byte-matched loop
used a source `goto nextCop` and therefore emitted a LABEL record absent
from retail. A `for (copLoop=0; ...; copLoop++)` with an early `continue`
preserves all 84 retail instructions and the complete native
local/home/depth/order/scope tree without the label. Whole `aih_basicperp.cpp`
gate is BYTES UNCHANGED, ASPSX 524/0, PSYLINK zero errors (`run-1rqndfzy`);
the TU remains 4/8 native CLEAN and the full board remains 2152/2565
CLEAN, 413 DIRTY. The old comparator did not score LABEL records, so it
already counted this function CLEAN before the label removal. This is a
partial source recovery, not an SLD seal:
13/84 linked-SYM line tags differ, all at the common loop tail (+0x11c..148),
with native function-end delta 25 versus retail 29. A guarded-body `if`
added two unsupported scopes and shifted named homes, while body-local
duplicated increments changed the 84-word body to 86; both were reverted.
The five cfront duplicate-name functions and SLD-only backlog remain open.

### Whole-tree SLD snapshot (2026-09-30)

`python tools/psyq_pipe/sldtree_cmp.py` compares every common native/retail
function's linked word-by-word relative SLD tag, block line/address sequence
and function-end line delta. It writes the per-function evidence to ignored
`build/psyq_g/sldtree_report.json`; `--fn NAME` shows one record and
`--require-exact` fails while any covered function is not exact. Seven parser
and fail-closed fixture tests pass (`python -m unittest
tools.psyq_pipe.test_sldtree_cmp`). Golden checks agree with the individual
`sldprobe.py` traces for `InTargetSliceRange`, `BworldSm_IsSimQuadValid` and
`CalcObjDefPtrs`, and reject the known `Quatern_QuatToMat` and
`AISpeeds_GetLegalSpeed` SLD gaps. Unlike a source-seal claim, this is a
snapshot of the existing native dump: it must be refreshed after edits, and
the current uncommitted `aih_play.cpp`/`platform.cpp` files are not certified
by this snapshot.

| Retail directory | SLD exact / covered | Tag differences / compared words |
|---|---:|---:|
| FRONTEND/COMMON | 161 / 838 | 46,058 / 55,037 |
| FRONTEND/PSX | 4 / 85 | 4,700 / 5,393 |
| GAME/COMMON | 229 / 1,247 | 87,773 / 102,405 |
| GAME/PSX | 30 / 395 | 38,130 / 41,666 |
| Total | 424 / 2,565 | 176,661 / 204,501 |

The remaining classifications are 2,135 SLD differences, five duplicate
function names intentionally marked ambiguous, and one code-span mismatch
(`tGlobalMenuDefs` constructor, 3,206 native versus 3,207 retail words).
The five retail-only PAD functions and incomplete eaclib/syslib records remain
outside this common-function board. SLD-exact is still weaker than recovered
literal source spelling or complete carrier review.

2026-09-30 `tCarManager::GetNumTourneyCars`: retail tags the
`GetCarFromID` call and its delay-slot store as line +12, then the returned
car's class-field load as +13. A direct chained call/load tagged that load
+12; splitting the call into a block-local pointer changed the 42-word
loop body. A function-root `tCarInfo *matchedCar` (inferred semantic name)
declared on the existing `carInfo` line is optimized out of detailed SYM,
preserves all 42 instructions and the complete native local/scope tree, and
gives 0/42 relative SLD differences plus exact block/end line records. The
full `fecars.cpp` gate is BYTES UNCHANGED, ASPSX 524/0, PSYLINK zero errors;
44/46 native CLEAN (`run-pz8aqmw5`). After refreshing the exact TUs touched
by rejected probes, the SLD snapshot above is 424/2,565 exact; BasicPerp's
13 tail-tag differences remain counted, not hidden. Literal original pointer
spelling is not uniquely determined.

2026-09-30 `CalcObjDefPtrs`: three repeated `gObjDefOffsetsGroup->GetData()`
expressions inside the offset-accumulation loop created six inline scopes
absent from retail. A single typed `offsets` payload pointer acquired before
the loop is optimized away as a debug local and reproduces the retail
strength-reduced cursor and all 25 instructions. The complete 11-region
native scope tree, named `this`/`i` records and section/layout fingerprints
now match (`track.cpp` gate `run-6bwsadai`: BYTES UNCHANGED, ASPSX 524/0,
PSYLINK zero errors). `track.cpp` rises 22/29 to 23/29 native CLEAN; the
full board is 2152/2565 CLEAN, 413 DIRTY. `offsets` is an evidence-supported
semantic name, not a recovered literal identifier. A subsequent source-line
round puts the loop close with its body assignment, separates the final
GetData result into a typed `objDefs` pointer (optimized out of detailed
SYM), and lets the void function fall through on the final store line.
`sldprobe.py` now reports 0/25 relative tag differences, matching block
line pairs and header-to-end delta +9. The full gate is again byte/layout
unchanged (`run-3bdif76v`). This is a verified function-level SYM/SLD
representation, not proof of the literal local spellings.

2026-09-30 `DrawGouraudShape` native TYPE correction: retail records `prim`
as `POLY_GT4*` in s0, but our byte-cursor declaration was `u_char*`.
Repricing the current 245-word source basin (the older typed trial measured
89 diffs on a different basin) shows that a real `POLY_GT4* prim` plus
explicit `u_char*` views for packet byte offsets is 245/245 PASS. A same-TU
-G0 probe was first confirmed byte-identical and emitted `.def prim; .val 16;
.tag POLY_GT4; .size 52`; the change was then applied to the authoritative
source. Final `psxfront.cpp` gate `run-0a3rq8_8`: whole-TU bytes/layout
UNCHANGED, ASPSX 524/0, PSYLINK zero errors, 15/25 native CLEAN. Global
native TYPE issues fall from one to zero, while the function remains DIRTY
for seven additional locals and two excess scopes; none were hidden or
renamed. Its source spelling and SLD remain open. The isolated probe source
was removed after promotion; no compiler-output rewrite or new ASM was used.

2026-09-30 `DrawGouraudShape` carrier follow-up on that type-correct basin:
retail has no `c3` local. Direct `color[3]` at its old late store was still
10 detailed diffs, but moving the same direct packet-field store *before*
the two header-byte stores lets GCC schedule the identical 245 instructions
without a named snapshot. Whole `psxfront.cpp` bytes/layout remain unchanged,
ASPSX 524/0, PSYLINK zero errors (`run-aq4gg4ld`); `c3` is removed from the
native EXTRA list. Six other extra locals and the 4-vs-2 scope tree remain
open. Direct repeated `addw - 1` was 41 diffs at 248/245 and folding `wsel`
into `w` was 77 diffs at 246/245 on this refreshed basin; both were reverted.
No new carrier, ASM or generic exemption was added.

2026-09-30 `AIState_GotoSlice::InTargetSliceRange`: retail has one v0
`distanceMeters` local and a root block whose start/end are both at function
entry. The explicit negative-value `if` kept the native block open through
+0x30. Returning `__builtin_abs(distanceMeters)` directly matched 17/17 and
closed the block at entry, but optimized the named local away. Assigning the
built-in absolute value directly to `distanceMeters` preserves the same 17
instructions, its correct v0 record and the zero-length retail block, with
no extra carrier or label. Full `aistate.cpp` gate `run-kgbcdms1` is
`BYTES: UNCHANGED`, ASPSX 524/0, PSYLINK zero errors; 31/42 native CLEAN.
Full common board is 2151/2565 CLEAN, 414 DIRTY. A subsequent three-statement
layout assigns the call, built-in absolute value, and return to successive
source lines: `sldprobe.py` reports 0/17 relative instruction-tag differences,
the block start/end lines agree, and the native function-end line is header+3
as in retail (`run-o8dqphts`). Exact literal EA spelling remains unknown.

2026-09-30 `Quatern_QuatToMat`: retail names doubled quaternion components
`x/y/z` in v0/t3/t1. Direct `q->field * 2` compiles byte-exactly but drops all
three native debug rows. Splitting raw loads then `*=2` restores the names on
the *input* registers instead (a2/a3/v1), while `<<=1` changes the halfword
load/sign-extension code. `x = q->x + q->x` (and y/z analogues) retains the
names on the doubled values, with the original 68/68 instructions and all
locals/types/homes/order/block boundaries matching. Whole-`quatern.cpp`
gate: `BYTES: UNCHANGED`, ASPSX 524/0, PSYLINK zero errors, 4/4 native CLEAN
(`run-xtpljb6y`). Full common board is 2150/2565 CLEAN, 415 DIRTY. This
does not prove literal EA syntax; relative SLD tags remain unsealed.

2026-09-30 `DashHUD_HUDCalc` compact-static reconciliation: the detailed
retail function lists `car` then `resethud` but omits `tick32`; its raw type-6
symbol stream retains `resethud.28` at 0x8013ddb0 and `tick32.32` at +4.
Native has `resethud.18` at 0x8013df24 and `tick32.19` at +4. The comparator
now accepts only an INT function-static with an exact native compact address,
a unique same-name retail compact symbol, and matching +4 offset from a
same-function detailed INT STAT anchor; it records that receipt explicitly
and does not excuse other extras (`aihCopFlagsBoundary_` remains EXTRA).
Reordering the source declarations to retail `car`, `resethud` then the
compact-only `tick32` preserves the 176-word PASS, 6/6 `dashhud.cpp` native
CLEAN, whole-TU bytes/layout, ASPSX 524/0 and PSYLINK zero errors
(`run-38fgw3pp`). Full common board is 2149/2565 CLEAN, 416 DIRTY; the
comparator's EXTRA count falls to 290 with no other function's issues changed.
The raw symbol corroborates storage/name, not every original source use:
`sldprobe.py` still reports 129/176 relative line-tag differences.
Comparator backup: `scratchpad/symtree_cmp_before_compact_static_20260930.py`.

2026-09-30 `BworldSm_UpdateSimQuad`: retail records `simIndex` at the root,
an outer region starting at +0, and `startsimquad` in a zero-instruction
inner region at +0x30; both outer/root regions end at +0x80. The previous
positive-if body kept `startsimquad` scoped through +0x78. An ordinary
single-result conditional expression inside the outer region, with a GNU
statement-expression for the recorded `startsimquad` value and a direct
read-back of the first `simQuad` store, reproduces all three native regions
without an invented label, extra object, or ASM. Detailed 34/34 PASS; whole
`bworldSm.cpp` byte/layout gate UNCHANGED, ASPSX 524/0, PSYLINK zero errors;
28/28 native CLEAN (`run-qshk9jon`). Full-tree native board 2148/2565 CLEAN,
417 DIRTY. An early-return/goto form also matched native scopes and bytes but
emitted an unsupported LABEL record, so it was rejected. The source expression
is a verified representation, not proof of EA's literal macro or ternary
spelling: SLD attribution still differs at all 34 instruction positions in
the current source (`sldprobe.py`), and original text remains open.

2026-09-30 `BworldSm_IsSimQuadValid`: the native declaration/block records
were already exact, but the null-path return and function end were attributed
one source line late. Spelling that path as `} else return 0;` places its
return on retail relative line 3, leaves the non-null path on line 2, and
matches all 12 relative instruction SLD tags plus the block-end and
function-end lines. The 12-instruction body and full `bworldSm.cpp` bytes/
layout remain unchanged; 28/28 native CLEAN, ASPSX 524/0, PSYLINK zero
errors (`run-6hprt9qb`). The literal original syntax remains unproved.

2026-09-30 `R3DCar_InsertCarFacetZ`: retail is a two-source-line wrapper.
The explicit `return;` placed the four epilogue words on relative line 2,
while retail attributes the call and epilogue to line 1. A call followed by
implicit void fallthrough, with the function's closing brace on the call
line, keeps all eight instructions and matches 0/8 SLD tag differences,
the one-line block record, and the function-end delta. Full `r3dcar.cpp`
gate `run-0x3ewviu`: `BYTES: UNCHANGED`, ASPSX 524/0, PSYLINK zero errors;
21/27 native CLEAN. Literal original whitespace is not claimed.

2026-09-30 startup/restart wrapper SLD round: `BWorldSm_Restart`,
`AIState_StartUp`, and `AIState_Restart` are call-only void functions. The
prior explicit `return;` put their epilogue instructions one source line
late. Implicit void fallthrough on the call line keeps each eight-word body
exact and gives 0/8 relative SLD tag differences, matching root-block and
function-end line deltas. Full byte/native gates: `bworldSm.cpp` 28/28 CLEAN
(`run-_8lckee8`) and `aistate.cpp` 31/42 CLEAN (`run-twsqocxg`); ASPSX
524/0 and PSYLINK zero errors in both. Literal original formatting is not
claimed, but these three function-level SYM/SLD traces are verified.

2026-09-30 renderer/HUD wrapper SLD round: `Render_InitLibRender` and
`DashHUD_KillHUD` each had the call on retail line +1 but an explicit void
`return;` tagged four epilogue words as line +2. Implicit fallthrough on
the call line preserves both eight-instruction bodies and produces 0/8
relative SLD differences with exact block/function-end lines. Full native
gates are BYTES UNCHANGED, ASPSX 524/0, PSYLINK zero errors:
`render.cpp` 23/23 CLEAN (`run-k8_44otb`) and `dashhud.cpp` 6/6 CLEAN
(`run-hh603ylq`). The separate `Render_StopRenderingWorldView` call-line
gap does not respond to this form and remains open; this is not a blanket
mechanical rewrite rule.

2026-09-30 audio-engine/HUDPMX wrapper SLD round: `AudioEng_StartServer`,
`AudioEng_StopServer`, and `HudPmx_Kill` each had a byte-exact single call
but their explicit `return;` put the four epilogue words on source line +2.
Implicit void fallthrough on the call line preserves nine instructions per
function and matches 0/9 relative SLD tags and exact block/end deltas.
Whole-TU gates are BYTES UNCHANGED, ASPSX 524/0, PSYLINK zero errors:
`audioeng.cpp` 7/9 native CLEAN (`run-rhkb3euf`) and `hudpmx.cpp` 3/3
native CLEAN (`run-okjx4y1d`). No dummy statements or line padding used.

2026-09-30 void-wrapper SLD round: `Speech_PurgeRAM`, `Scene_DeInit`, and
`AudioClc_SilenceOpponentHorn` retain their respective eight-instruction
PASS bodies when their explicit `return;` is replaced with implicit void
fallthrough on the call line. Each now has 0/8 relative SLD tag differences
and matching block/function-end line deltas. `speech.cpp` is BYTES UNCHANGED,
ASPSX 524/0, PSYLINK zero errors and 85/87 native CLEAN (`run-ks6u1p6d`);
`scene.cpp` is likewise unchanged and 5/6 native CLEAN (`run-d5glnq8e`).
`audioclc.cpp` has all 18 detailed functions PASS, but its fail-closed
`symloop --ref-only` byte reference already failed before edits, so a fresh
full-TU native seal is not claimed from that lane; independent real-link
integrity remains the gate. Similar Render/BWorld wrappers need a call-line
shift that neither implicit fallthrough nor `return void_call()` produced and
were reverted; no dummy statements or line padding were retained.

2026-09-30 `TexturesLoadInitial` partial scope cleanup: the old three nested
zero-length debug regions at +0x8c came from two explicit braces and a
count-zero loop. One lexical level and the `n` temporary are unnecessary:
one `i`-counted zero loop retains the required compiler label/CSE boundary,
107/107 instructions, and whole-`track.cpp` `BYTES: UNCHANGED`, ASPSX 524/0,
PSYLINK zero errors (`run-jc1zgx7u`). The five scope count now equals retail's,
with matching two zero-length nested regions and `tmpShapes` ownership. This
is not CLEAN: its outer loaded-shapes region still starts at +0x74 rather
than retail +0x84. Separating the shape-file assignment from the guard did
not move that native start; inverted guard changed 10 detailed instructions;
reusing named `success` for the shape-file result changed seven and added one
instruction; zero-variable `if(0)` and `for(;0;)` forms changed six. All such
variants were reverted. The remaining `i` spelling and literal original loop
form are not recoverable from this SYM; they remain source/SLD review work,
not an exemption or a claimed original-source seal.

2026-09-30 `Control_Human` partial lexical restoration: retail opens an
additional region at +0x39c around the case-12 headlight toggle. One nested
ordinary source block there restores that region without changing any of the
288 retail instructions or other functions in `control.cpp`; full-TU gate
`run-ipiyfy9_` is `BYTES: UNCHANGED`, ASPSX 524/0, PSYLINK zero errors.
Native scopes improve from 6/8 to 7/8. Retail has one more zero-length region
at +0x3c8 (the off-headlight branch); an empty brace and `if(0)` were pruned,
while a GNU argument statement-expression added three regions (10/8), so
none was retained. `lights` remains debug-elided and its literal source name
unknown; no dummy source object or invented label was added. `Stats_TrackEndGame`
for-loop reshaping failed 60 detailed diffs/234 versus 232 and was reverted;
`R3DCar_GetCarName` direct cop-index expressions failed 13/50 diffs and were
reverted. These trials are finite evidence, not compiler-floor claims.

2026-09-30 `AIPhysic_CalculateGear`: retail has no source LABEL record at
the return join, whereas the old byte-matched reconstruction emitted `end`.
Keeping the named `gear` assignment funnel inside a structured
`if / else if / else` and returning after it removes that unsupported label
while retaining 65/65 instructions, all named homes and the whole physics
TU byte/layout fingerprint (`run-dbc_v1ia`; ASPSX 524/0, PSYLINK zero errors).
Direct early returns were 64/65 with five detailed diffs and were reverted.
The native root block still closes at +0xe4 versus retail +0xe0; an extra
lexical brace and an explicit return cast did not move that endpoint and were
reverted. Relative SLD attribution is also unsealed (52/65 instruction tags
in the current source probe); the label removal is not a full source seal.

2026-09-30 targeted source-shape probes (all failed variants reverted; no source
or PASS-status change): `CopSpeak_Play` remains 86/86 PASS with an unrecorded
`scaled` local. Duplicating the arithmetic directly and factoring it as `*0x81`
both produced 87 instructions/17 detailed diffs; updating `noise` in place gave
86 instructions/16 diffs. `Replay_ResetReplay` remains 86/86 PASS with its
unrecorded reverse cursor: indexed, index-first byte-address, and post-decrement
indexed forms each added one `addiu v0,v0,4` (87 instructions). In
`AISpeeds_BTCGetGlueFactor`, clamping retail's `glueIndex` in place retained
111 instructions but made 12 register/branch diffs, so the unrecorded
`clampedGlueIndex` remains open. `AISpeeds_GetLegalSpeed` remains 17/17 PASS;
moving `--speedData` into the final access, or replacing `<<8` with `*256`,
left the native root-block end at relative +0x34 versus retail +0x38, despite
full-TU `BYTES: UNCHANGED`, ASPSX 524/0 and PSYLINK zero errors
(`run-df4t27jn`, `run-v_fg5wv4`). These finite failures do not establish a
compiler floor or an original spelling; next probes should use retail SLD and
compiler debug/RTL evidence to change the ownership or evaluation boundary.

2026-09-27: `game/psx/draw.cpp` native-contract round, 19/25 -> 25/25 CLEAN.
The six OT/view/frame loops now declare retail's `i` in the `for` scope and
derive a const per-iteration view expression instead of mutable pointer-walker
carriers (and a cached-bound carrier in DeInitViewsInGame). Detailed verify_asm:
InitViewOT 33, InitViewOTInGame 31, DeInitViews 34, DeInitViewsInGame 13,
StartFrameRender 40, StopFrameRender 57 instructions, all PASS. Full symloop:
BYTES UNCHANGED; 524 ASPSX objects, zero failures; PSYLINK zero errors;
25 CLEAN, zero DIRTY (`build/symloop_runs/run-awwgapgn`). Original spelling of
the absent view temporary is not claimed recovered. Stale comments asserting
unreachable loop-rotation floors have been replaced. SLD-only work remains parked.
Final comment-cleaned rebuild: `run-u5f7v5o0`, again 25/25 native CLEAN and
BYTES UNCHANGED. Whole-tree native report: 2075 CLEAN / 490 DIRTY; honest
RECON 299819/299819, zero mismatches or masked mismatches, zero foreign labels;
vtable audit PASS across 1314 files; whitespace check clean.
GNU link checkpoint: fresh 526-object census; strict rc=0 (existing overlap
warnings), multdef-ok rc=0 with empty stderr, zero undefined names or truncated
relocations. `SetupBuildMatrices` now assigns retail's t2=$v0 and t3=$v1
to the night/cop-matrix temporaries without reordering their computations.
181/181 PASS; full bworld symloop BYTES UNCHANGED, 16/21 CLEAN (one gained),
zero ASPSX failures or PSYLINK errors (`run-48fpin8l`).
After the naming fix, full-tree native board: 2076 CLEAN / 489 DIRTY; honest
RECON remains 299819/299819. GetGlueFactor's direct ternary-clamp experiment
merged the first two arms (118 vs 131 instructions, 47 diffs) and was reverted.
Its restored TU passes the full byte gate (`run-vcwfkgnj`); the three glueIndex
home mismatches remain an active source-shape investigation, not a proven floor.

2026-09-27 bworld continuation: 16/21 -> 19/21 native CLEAN, plus Onyx's
two buildInd scope mismatches resolved (its ts carrier remains).
- CheckChunkVisible: retail's testChunkIndFwd/Bwd are the loaded chunk IDs
  at REG $11/$3, not the preliminary slice indices. Const slice-index expression
  aliases retain 80/80 instructions and disappear from debug locals; both original
  chunk names now have their retail homes. Direct index expressions were 22 diffs.
  The sliceIndexFwd/Bwd spellings describe proven arithmetic roles, not recovered names.
- SetupChunkBuildList: while instead of for removes the extra C++ loop binding
  level. All six body locals are now at retail depth 3; 203/203 PASS.
- BuildGlareEffects: canonical Group::GetData supplies retail's this/inline pair;
  the outer for restores the loop level, pad/type declaration order is restored,
  and nested found_match/pad guards place the recorded pt1=$v0 (the fifth call
  argument, objInstance[j]) in its retail scope. 86/86 PASS; native CLEAN.
- Source-recovery queue, NOT a generic exemption: the inner search loop still
  needs an unrecorded declaration to preserve its binding level. Removing it
  changes 86 -> 87 instructions (33 diffs); its unused assignment can be removed
  without changing bytes. Its pre-existing pt1 spelling and coorddef-pointer type
  are not uniquely recoverable from this retail SYM. The source flags this uncertainty;
  native CLEAN must not be presented as fully recovered original text.
- Falsified and reverted: BWorld_Init const use-site random remains EXTRA and adds
  four unwanted scopes; reusing AudioScene gives 186/187 and 15 diffs. Onyx's const
  ts collapses to direct field expressions (193/193, ten diffs), so ts remains open.
Full combined byte/native receipt: `run-cx6rtyiv`, BYTES UNCHANGED, 524 ASPSX
objects with zero failures, PSYLINK zero errors, 19 CLEAN / 2 DIRTY. SLD-only
work stays parked; this receipt covers locals, homes, declaration order and native
scope trees, not instruction/source-line attribution.
Final restored rebuild: `run-imxc_29_`, again 19/21 CLEAN and BYTES UNCHANGED.
Full-tree native board: 2079 CLEAN / 486 DIRTY, with five retail-only functions
still outside the common set. Native-only directory coverage (not a source/SLD seal):

| Retail directory | Native clean | Unresolved | Covered |
|---|---:|---:|---:|
| FRONTEND/COMMON | 711 | 127 | 838 |
| FRONTEND/PSX | 61 | 24 | 85 |
| GAME/COMMON | 1032 | 215 | 1247 |
| GAME/PSX | 275 | 120 | 395 |

Fresh GNU link: 526 objects, zero undefined names/truncated relocations;
multdef-ok rc=0, empty stderr (strict retains existing overlap diagnostics).
Vtable audit PASS in 1314 files. Original-source, unrecorded-declaration and SLD
requirements remain open; no completion claim is implied by these native counts.

2026-09-27 AI continuation: ai.cpp 33/40 -> 37/40 native CLEAN. Retained
source changes all pass detailed verify_asm and full symloop BYTES UNCHANGED
(`run-pqkoxlim`, 524 ASPSX objects, zero failures, PSYLINK zero errors):
- HandleChangeInNumLanes (92 instructions): absLaneLookAhead now holds the
  positive slice distance, lookAhead the directed distance, laneIndex only the
  lane checks. The const rounding expression reproduces the distinct v0
  correction while all three original names get retail's v1 home. Direct signed
  division was one instruction short/seven diffs; the rounding-alias spelling is inferred.
- CheckForBarriers (240): the for loop supplies retail's +278 binding level,
  putting checkSlice in depth 5 rather than 4.
- CalcBestLineMerits (34): restore the inline BestLine accessor's this/slice
  parameters and buffer/latPos locals, rather than open-coding the read. The early
  flag return puts the inline pair directly under the function; CC1PLPSX reverses
  the inline local declaration list, so latPos-before-buffer emits retail's
  buffer-before-latPos debug order. Get is the record-family accessor spelling,
  not a name retained in this retail inline scope; ai_types.h has only ai.cpp as a consumer.
- CalculateLaneSpeeds (229): for-loop binding, inactive-car continue, and the
  two collision-speed declarations inside the distance guard reproduce depth 5.
TryToShareLanes remains open: direct normalized offsets gave 26 diffs, in-place
normalization 49, and a const desired-lane snapshot 30. All three were reverted;
the restored TU passed the full byte gate (`run-ay3x3law`).
Fresh full-tree native report: 2083 CLEAN / 482 DIRTY. Full normal and expected
build lanes are running; their completion is not yet claimed. No SLD seal is claimed.
Isolated preprocessed-snapshot probe while those builds run: deleting the
redundant HandleChangeInNumLanes goto and LAB_800588a4 label preserves the
entire AI object's .text SHA256:
`0628d87b946ec965cd60a6c222070a9fc62d11b765289b68c2c8a1683dbe68dc`.
The combined alias-plus-label deletion does not: it duplicates the shift and
adds an instruction. Label-only cleanup is ready for promotion after the
integration snapshot finishes; the project source has not yet been changed.
Probe artifacts: ignored `build/ai_source_probe/` (CC1PLPSX -O2 -G4
-fno-implement-inlines, canonical maspsx/as pipeline; no instruction rewrites).
DoReactions isolated probe: moving absDistance/seconds/otherCarObj to their
retail compounds and making metersDistance hold
`AIWorld_SplineDistance(carObj,otherCarObj) * carObj->direction` reproduces
the missing `.def metersDistance; .val -1; .scl 4; .type 0x4` naturally.
The non-debug probe's entire .text has the same SHA256 quoted above. Ordinary
scope placement alone, and an ordinary register keyword, did not recover the record.
GCC evidence: `gcc-2.8.1-src/extracted/config/mips/mips.c:3766..3780` initializes
all debug-register mappings to -1, then maps only GP/FP registers, explicitly
ignoring special-purpose registers. Thus retail REG $ffffffff is consistent
with the named multiply result in LO, not evidence of a dead/uninitialized local.
The raw oracle at 80057D98..80057DA8 is mult/mflo followed by the threshold test.
This candidate is ready for main-source/native-SYM promotion after the full builds;
no comparator exemption or instruction rewrite was introduced.
Honking isolated probe: const use-site initialization of the predecessor's
recovered honkprob name emits no honkprob debug local and preserves the same
entire .text hash. Direct substitution into the condition changes code.
Artifacts: `build/ai_source_probe/honk_const.i`, `honk_const.s` (-g receipt),
`honk_const.o` (normal byte receipt). This candidate is also queued for
main-source scope/native verification after the integration builds finish.
Integration snapshot completed: both `build.py --skip-asm` and
`build.py --out expected --no-link` exited 0 with no failed/skipped TUs.
The queued DoReactions/honking/label changes are now promoted to main source.
Detailed gates: DoReactions 144/144, HandleTrafficHonking 65/65,
HandleChangeInNumLanes 92/92 PASS. Combined symloop `run-394n3ncf`:
BYTES UNCHANGED; ASPSX 524 good / 0 bad; PSYLINK zero errors;
AI 39/40 native CLEAN. Only TryToShareLanes' absLaneIndex home remains open.
The expression-assignment normalization probe also changes bytes and was not promoted.
Post-promotion full-tree native report: 2085 CLEAN / 480 DIRTY.
Fresh 526-object GNU link: multdef-ok rc=0 with empty stderr; zero undefined
symbols/truncated relocations. Strict lane keeps the pre-existing overlap
diagnostics. Vtable audit PASS across 1314 files; whitespace check clean.
Post-promotion honest linked measure: RECON 299819/299819 identical, zero
diff words, zero masked mismatches, zero foreign-label violations.
Font round: Getcharacter's retail base=$s2 is the character-table pointer,
not the font-header pointer currently named base=$s3. Const pointer/integer
header aliases each produced 14 diffs at 35 instructions; destructive pointer
replacement lost the held header address (33 vs 35, 38 diffs). All were reverted;
the restored full Font byte gate passed (`run-9q87qpbb`). This remains a source-
shape problem, not merely a register-name swap.
SetABR's generic y carrier exemption was replaced by a const use-site expression
and explicit evidence: canonical PsyQ LIBGPU.H:744 declares GetTPage(tp,abr,x,y);
retained y gives 18/18 PASS with no extra debug local. Fresh direct substitution
gives six a2/a3 diffs at the same 18 instructions. Original local spelling is not
recoverable from this SYM; y is the canonical argument role, not a recovered spelling.
Final Font symloop `run-4p0poh5w`: BYTES UNCHANGED, 524 ASPSX good / 0 bad,
PSYLINK zero errors; 12/15 native CLEAN (unchanged). No failed Getcharacter
experiment remains in source. Fresh GNU link and vtable audit remain green.
Font continuation: SwitchFont const header-base substitution produced 13 diffs
and 28 vs 27 instructions; TextXY's const header-base substitution produced
24 diffs and 88 vs 86. Both were reverted. TextXY's recoverable root declaration
order is now str, ch, code as retail emits, retaining 86/86 PASS; the extra
cfbase remains an explicit unresolved item. No masking comparator change was made.
Combined Font scope/byte receipt: `run-mbb1cbfq`, BYTES UNCHANGED; ASPSX
524 good / 0 bad, PSYLINK zero errors, 12/15 native CLEAN. The three remaining
Font issues are unchanged; the named TextXY root locals now have retail's order.
2026-09-28 AIPerson scope round: 6/8 -> 8/8 native CLEAN.
LoadGlue's glueLoop declaration is inside the guarded compound (retail depth 3),
not at function scope or in the for initializer; 67/67 PASS.
LoadPersonalityData uses a for-declared perLoop (depth 2) and twelve named
body locals (depth 3) in retail's order; 209/209 PASS. Its unrecorded final-read
copCollisionFirmness object remains explicitly queued rather than claimed original.
Full symloop `run-6dz31g7t`: BYTES UNCHANGED, ASPSX 524 good / 0 bad,
PSYLINK zero errors; native 8 CLEAN / 0 DIRTY. Whole-tree native report:
2087 CLEAN / 478 DIRTY. Native CLEAN does not seal unknown source spellings or SLD.
Regression: fresh 526-object GNU link, multdef-ok rc=0/empty stderr,
zero undefined names or truncated relocations; vtable audit PASS in 1314 files;
whitespace check clean.

2026-09-28 AISpeeds_GetCaravanFactor native-source round: aispeeds 25/29 ->
26/29 CLEAN. Replaced the selection's decompiler-label jumps with a default-first
if/else inside the original outer if/else. Retail's scope sequence is now exact:
root selection binding at +000, two nested bindings at +058, named leader-distance
body at +0f8..+174. tempRandom is declared in the acquisition body (+2e4), and
prevAICar in its combined short-circuit guard body (+354..+368), rather than at
function scope. No new locals, asm, volatile, comparator masking, or tool changes.
The positive-condition-first alternative changed 18 instructions (239/239) and
was replaced with the byte-identical default-first form, not retained.
Detailed verify_asm: 239/239 PASS. Final comment/format-cleaned full symloop
`run-70p99ma8`: all four compiled sections/layouts UNCHANGED, ASPSX 524 good /
0 bad, PSYLINK zero errors; 26 native CLEAN / 3 DIRTY. Native frame header, local
names/types/homes/order/depths, and scope nesting/address boundaries agree.
The instruction-level retail/our source-line attribution has not been restored;
this is explicitly not a full SLD seal. Remaining AISpeeds native queue:
BTCGetGlueFactor's extra clamp result and nested scopes; GetGlueFactor's three
glueIndex homes; GetLegalSpeed's block nesting/address differences.
Whole-tree native report: 2088 CLEAN / 477 DIRTY. Fresh 526-object GNU relink:
strict rc=0 with the existing 590 overlap multiple-definition diagnostics;
multdef-ok rc=0 and empty stderr; both have zero undefined names and truncated
relocations. Honest linked RECON is 299819/299819 identical, zero masked mismatch
bytes or foreign labels; retail-passthrough BLOB words are excluded. Vtable audit
PASS in 1314 files; source/ledger whitespace check clean.

2026-09-28 AISpeeds_BTCGetGlueFactor scope round: replaced the two decompiler
label jumps with default-first nested if/else arms. The multiplication remains
before the RSControl guard; moving it inside the else changed 17 instructions
(112 vs 111), so that experiment was reversed. All nine retail scopes now agree
in nesting and instruction-relative boundaries, and glueIndex/glue are at retail
depth 5 instead of depth 2. No carrier exemption or comparison-tool change.
Final full symloop `run-drka_kvf`: BYTES UNCHANGED, ASPSX 524 good / 0 bad,
PSYLINK zero errors; native module 26/29 CLEAN, with this function's only remaining
issue EXTRA clampedGlueIndex REG:$3. Detailed checks: BTCGetGlueFactor 111/111
PASS and GetCaravanFactor 239/239 PASS. Source-line/SLD attribution remains open.
Failed clamp probes were reversed: both direct nested-conditional polarities
changed 22 instructions at 111/111; reuse of glue as the clamp result changed
14 instructions at 111/111. These do not prove a distinct original source object
was required, nor a compiler limit; the unrecorded clamp variable remains an
explicit source-recovery backlog item.
Compiler-source lead for future clamp work: gcc-2.8.1 fold-const.c at 5631-5731
recognizes both A op B ? A : B and the adjacent-bound A < 21 ? A : 20 forms
as MIN/MAX; expr.c at 6519-6589 then expands those through its own target and
conditional-jump selection. This explains why a direct ternary is not merely
the explicit assignment tree with a local removed, but is not yet a traced
receipt for this particular build's allocation. A new source form must still
pass the byte and native-record checks.
Fresh 526-object relink after this scope round: strict rc=0 (existing 590
multiple-definition diagnostics), multdef-ok rc=0/empty stderr, zero undefined
names or truncated relocations. Vtable audit PASS in 1314 files.
Fresh honest measurement: RECON 299819/299819 identical, zero masked mismatch
bytes and foreign labels; BLOB passthrough is excluded. Whole-tree native board
remains 2088 CLEAN / 477 DIRTY; no native CLEAN function regressed.

2026-09-28 AISpeeds_GetGlueFactor value-role investigation (no retained body
change): the raw subtraction feeds v1, the unbounded quotient-plus-ten index
also lives in v1, while the bounded index is an anonymous a0 quantity. Retail
names distance and glueIndex both at REG:$3; our glueIndex currently names the
bounded a0 value. This is a genuine phase/name mismatch, not debug decoration.
Probes with distance as the raw odometer subtraction and glueIndex as its
quotient-plus-ten were reverted: reuse of root glue for the bounded index
changed 11 instructions (138 vs 131); a direct ternary in one arm changed 12
(139 vs 131), and in all three arms changed 47 (118 vs 131) through tail sharing;
branch-local table reads changed 16 (139 vs 131). Baseline detailed verification
returned to 131/131 PASS before the final full-module gate. Do not add a third
named clamp carrier just to turn these three MOVED records into EXTRA records;
the needed target is retail's original locals plus an anonymous bounded value.
Final baseline full-module receipt `run-rrfc6il9`: BYTES UNCHANGED, ASPSX 524
good / 0 bad, PSYLINK zero errors, 26/29 native CLEAN (unchanged issue set).
An independent GetLegalSpeed source-order probe combined the pointer decrement
with its return-expression load. `run-x_yt2k8m` was byte-identical but did not
correct the scope boundary (+034 ours versus +038 retail), so the neutral edit
was also reversed. No new body change from these investigations is retained.

2026-09-28 AIPhysic_GetRearEndDamageFactor: removed the unrecorded `result`
local and its carrier annotation. The ordinary bound-first return expression
`0x10000 < totalDamage ? 0x10000 : totalDamage` reproduces all 22 retail
instructions, including the anonymous a0 result funnel and v1 named accumulator.
No asm, volatile, extra alias, compiler pin, or tool change was added. Native
frame/local name/type/home/order/depth and scope boundaries now match exactly;
relative SLD source lines still differ and are not claimed recovered.
The old source comment claiming a separate named result was necessary has been
corrected. GCC MIN_EXPR operand/arm order is a site-specific source lever, not
a reason to preserve a debug-visible carrier. Individual full symloop
`run-eyeb_eof`: aiphysic 35/42 -> 36/42 native CLEAN, BYTES UNCHANGED.
Final combined comment-cleaned symloop `run-to5zbjux`: both TUs' compiled
sections/layouts unchanged; ASPSX 524 good/0 bad; PSYLINK zero errors;
aiphysic+aispeeds 62/71 native CLEAN. This removes one EXTRA issue rather than
renaming or exempting it. The reconstruction-methodology reference also records
the exact successful spelling and receipts for future work.
The corresponding nested bound-first clamps were tried in AISpeeds, failed,
and reverted: BTCGetGlueFactor 13 diffs at 110/111 for either outer polarity;
GetGlueFactor 39 diffs at 130/131. The earlier verified AISpeeds scope changes
remain intact, with no additional body change from those clamp probes.
Final regression: fresh 526-object GNU relink, strict rc=0 with existing 590
overlap multiple-definition diagnostics; multdef-ok rc=0 and empty stderr;
zero undefined names/truncated relocations. Honest RECON 299819/299819 identical,
zero masked mismatch bytes or foreign labels (retail BLOB passthrough excluded).
Vtable audit PASS in 1314 files. Whole-tree native board 2089 CLEAN / 476 DIRTY.
The broad source-restoration goal and its SLD coverage remain incomplete.

2026-09-28 BWorldSm_FindClosestSlice: removed the extra sliceChanged local
entirely. Return the chained field assignments of the comparison instead of
storing its anonymous result in a reconstructed local. This preserves the
quadChanged-then-sliceChanged store order and all 39 retail instructions.
Cross-version evidence: NFS2 matched source
`C:/Temp/nfs2-clean/pc-beta/match/bworldSm/BWorldSm_FindClosestSlice.c`
uses that same assignment chain, and NFS2 SYM function at 0041618c has the
named sliceChanged AUTO record at dump offset 050884. NFS4 retains only
startSlice in this function; do not blindly import the NFS2 local.
A const use-site alias first passed (`run-iokdzwun`), then was superseded by
the stronger alias-free return expression. Final comment-cleaned full symloop
`run-n487b51m`: whole compiled sections/layouts unchanged; ASPSX 524 good/0 bad;
PSYLINK zero errors; bworldSm 24/28 -> 25/28 native CLEAN. Frame, params, sole
local, and scope boundaries match retail; complete SLD attribution remains open.
No new name, alias, asm, volatile, tool change, or generic exemption was added.
Camera_UpdateTVCam clamp probes failed and were fully reversed: direct nested
MAX/MIN forms with two operand orders changed 51 instructions (84 vs 83) and
47 (80 vs 83). camera.cpp is unchanged; this is not a compiler-limit verdict.
Rebuilt the reverted camera baseline explicitly because verify_asm writes the
normal object cache. `run-f5c1lqpf` confirms camera's compiled sections/layouts
unchanged, ASPSX 524 good/0 bad, PSYLINK zero errors; camera native 29/38 CLEAN
and its original nine-function issue set are unchanged. Final GNU relink is
performed after that rebuild, rather than measuring a failed trial's cached
object.
Final fresh 526-object relink: strict rc=0 (existing 590 multiple-definition
diagnostics); multdef-ok rc=0/empty stderr; zero undefined names and truncated
relocations. Honest RECON 299819/299819 identical, zero masked mismatch bytes
or foreign labels, BLOB passthrough excluded. Vtable audit PASS in 1314 files.
Native whole-tree board: 2090 CLEAN / 475 DIRTY, with no CLEAN regressions.
Next concrete bworldSm scope evidence: Check_Rot's vecX/vecZ are currently at
depth 1 but retail places both at depth 5 inside the cache-miss body. The
forward/normal sub-block ends at +30c ours versus +2fc retail, suggesting the
NormalCache_AddEntry call belongs after that sub-block. These are untested
source-shape hypotheses, not established original-text claims.

2026-09-28 bworldSm scope/helper round: Check_Rot now declares vecX/vecZ in
the cache-miss body (retail depth 5, same AUTO homes -48/-32). Moved the
NormalCache_AddEntry call after the forward/normal sub-block, restoring its
retail +2ac..+2fc extent rather than +2ac..+30c. All compiled sections/layouts
unchanged; native function CLEAN, detailed 206/206 PASS. Full receipts
`run-a2bxfjip`, then comment-cleaned `run-zlancl97`, module 26/28 native CLEAN.
RawFindClosestSlice's reconstruction-only closeXZDistSquared inline function
was replaced by the identical arithmetic macro with side-effect-free arguments.
This removes all four inline expansions' artificial scope pairs and repeated
slice/pt records; the existing root locals and homes remain exact. Retail
scope count is now 1 rather than 19. Detailed 173/173 PASS. Full receipt
`run-3nuk7jqp`: all compiled sections/layouts unchanged, ASPSX 524 good/0 bad,
PSYLINK zero errors, module 27/28 native CLEAN. Macro name provenance:
NFS2 SYM's closeXZDistSquared symbol at 0041603f and matched-source declaration
in match/nfs2.h; the literal PSX macro spelling is not claimed recoverable.
The remaining UpdateSimQuad scope probe was reversed: ending startsimquad's
region before an outer offset calculation introduced three instructions,
37 versus 34, and 21 detailed differences. Baseline restored to 34/34 PASS.
SLD attribution remains unsealed; these are native-source contract corrections,
not a whole-project source-restoration completion claim.
Final comment-cleaned helper/scope gate `run-0nvhfh0n` repeats 27/28 native
CLEAN, compiled sections/layouts unchanged, ASPSX 524 good/0 bad, PSYLINK zero
errors. The subsequent explicit else arm in UpdateSimQuad is also byte-identical
(`run-dlntnucv`) and corrects its outer binding endpoint +078 -> retail +080.
Its inner startsimquad endpoint is still +078 versus retail +030; this is now
the only native difference in the module. The partial boundary improvement is
retained, not described as a seal. Whole-tree native board 2092 CLEAN / 473 DIRTY.
Final fresh 526-object link: strict rc=0 with the existing 590 overlap
multiple-definition diagnostics; multdef-ok rc=0/empty stderr; zero undefined
names and truncated relocations. Honest RECON 299819/299819 identical, zero
masked mismatch bytes or foreign labels, BLOB passthrough excluded. Vtable audit
PASS in 1314 files. Final detailed Check_Rot/RawFindClosestSlice/UpdateSimQuad
checks are 206/173/34 instructions respectively, all PASS.

2026-09-28 UpdateSimQuad/relocation investigation: all new scope experiments
were reversed. A const startsimquad initializer preserved bytes but hid its
required REG:$3 record (`run-2ik81ubd`); a mutable initializer preserved bytes
without fixing scope (`run-zl4mv81i`). A GNU scoped-expression trial reproduced
the short +030..+030 region but added a fourth scope and depth 4 versus retail
3 (`run-371n3izc`), so it was not kept. Baseline restored and full module gate
`run-97he3u_v` confirms unchanged compiled sections/layouts and 27/28 native CLEAN.

Platform_InitMemory's pre-edit reference check failed on already-present source;
no platform source edit is retained and the legacy reference was not replaced.
That legacy fingerprint is 599 bytes versus current 609, lacks its layout
companion, omits the current SimpleMem tag, and has different address addends.
The current canonical bigBuf addressing accounts for the high/low addend
differences in InitMemory; other fingerprint differences need separate review.
Current code's
bigBuf+0x44d10 is retail's 0x80054d10 after link. Independent fresh GNU relink
and honest_measure prove RECON 299819/299819 identical, zero masked mismatches
or foreign labels, with the restored current platform source compiled.

Fixed a comparison-only verify_asm defect revealed by that canonical large
addend: an actual R_MIPS_HI16-relocated LUI can contain a nonzero high addend
(4 here), not always 0 as the old comment assumed. Normalize only the immediate
of a LUI carrying that relocation, symmetrically with oracle %hi(SYM)->0.
Literal LUIs without HI16, opcode/register differences, and unrelocated low
immediates remain visible. No source/object/compiler/link output is rewritten.
Backup: scratchpad/verify_hi16_addend_20260928/verify_asm.py. New regression
tests tools/test_verify_asm_relocations.py load the real normalizer via AST
without CLI compilation: 2 high-addend tests failed before the fix, all 8
positive/negative tests pass afterwards. Linked address correctness remains
an independent gate; relocation normalization is not proof of correct offsets.
Detailed receipts after the fix: Platform_InitMemory 12/12, UpdateSimQuad 34/34,
Check_Rot 206/206, RawFindClosestSlice 173/173, RearEndDamageFactor 22/22, all
PASS. Native board remains 2092 CLEAN / 473 DIRTY. Platform's stale reference
must be reconciled separately before a guarded source change; it was not
bypassed or silently re-recorded in this round.

2026-09-28 replay/night carrier investigation (no retained body change):
Replay_ResetReplay's indexed post-decrement, index-term-first byte address,
and end-relative array index each preserved the stream except for one extra
address increment (87 vs 86). A use-site initialized mutable pointer preserved
all compiled sections but retained counterSlot REG:$2 (`run-f2q95a5n`), so
that neutral edit was reversed. A pre-decrement for condition produced 8 diffs
at 88/86; unsigned end-relative distance prevented induction strength reduction
and produced 9 at 89/86. The original source body was restored; its fresh
reference check verified the existing baseline. No new cursor name or alias
was kept, and no array/global ownership declaration was changed.
Night_GenerateNextLightningEvent's anonymous delay arithmetic had 16/8/12
detailed differences at 29/29 under operand-order, association, and unsigned-bound
variants. Using the existing timing globals as arithmetic accumulators preserved
the old instruction sequence but added two stores (31 vs 29); those writes are
not in retail and were rejected. The original body was restored and its fresh
reference check verified unchanged compiled sections. These failed shapes are
not evidence of a compiler limit or proof that a named source object was original.
Final combined restored-baseline gate `run-qw8067j6`: all compiled sections/
layouts unchanged, ASPSX 524 good/0 bad, PSYLINK zero errors; 35 covered native
functions, 29 CLEAN / 6 DIRTY, original issue set unchanged. The 8 relocation
normalizer regression tests also remain green. No replay/night source change
or failed-trial cache is retained.

2026-09-28 lighting declaration round: Night_SetCopColor's copColors/col1/col2
now belong to the retail root scope, not a reconstruction-only extra block.
Its use-site array initializer remains after the country/model reads; hoisting
it before those reads changed 32 detailed differences at 37/37, so that order
experiment was reversed. The original cartype value-role remains unresolved:
raw model and model-minus-22 probes, with the mapping moved into the color
lookups, both produced 23 differences at 38/37 and were reversed. The retained
scope fix remains detailed 37/37 PASS; the only native issue is cartype's home.

Night_InitNightDriving now has the positive rendering guard around its load/
initialization body. name (AUTO -272) precedes mem (REG:$16) inside that body,
at retail depth 3, rather than both at root scope in reversed order. Native
frame, names/types/homes/order and the +060/+070..+188 scope pairs now agree.
Detailed 103/103 PASS. Initial full gate `run-8g9mktec`: compiled sections/
layouts unchanged, ASPSX 524 good/0 bad, PSYLINK zero errors; night 14/19 ->
15/19 native CLEAN. Source-line/SLD attribution remains unsealed. No asm,
volatile, new local name, carrier exemption, or tool change was introduced.
Final comment/indent-cleaned gate `run-v9vq5wph`: unchanged compiled sections/
layouts, ASPSX 524 good/0 bad, PSYLINK zero errors, 15/19 native CLEAN. An
additional value-phase probe put the raw model in cartype and the mapped index
temporarily in carTable before its pointer use; it changed 50 detailed
differences at 43/37 and was reverted. It is not part of the retained scope fix.
Fresh 526-object GNU link of the verified checkpoint: strict rc=0 with existing
590 multiple-definition diagnostics, multdef-ok rc=0/empty stderr, zero undefined
names or truncated relocations. Honest RECON 299819/299819 identical, zero masked
mismatch bytes or foreign labels; BLOB passthrough excluded. Vtable audit PASS
in 1314 files. Native whole-tree board: 2093 CLEAN / 472 DIRTY.
Post-probe restored-baseline full gate `run-3cpzhdxw` again confirms unchanged
compiled sections/layouts, ASPSX 524/0, PSYLINK zero errors and 15/19 native CLEAN.
Final SetCopColor/InitNightDriving detailed checks remain 37/103 instructions,
both PASS; no failed experiment is retained in source or its normal object cache.
2026-09-28 Night_GenerateAllLightTables scope round: moved the inner i into
the for declaration after Night_SetWeatherColors, replacing the enclosing
reconstruction block and separate while initialization. Retail's +0e8..+134
i scope and +0ec..+12c bright body now agree, as do all other scope boundaries
and nesting. Full gate `run-_b34a841`: whole compiled sections/layouts unchanged,
ASPSX 524 good/0 bad, PSYLINK zero errors. The only native issue is now the
missing outer i REG:$6 record; that declaration is currently unused. A zero
initialization preserved bytes but still emitted no record (`run-o85j70bq`),
so the neutral initialization was reversed. Do not add an artificial use or
invent a role merely to manufacture the debug record. Final comment/indent
gate `run-ngis9hca` confirms unchanged compiled sections/layouts and native
15/19 CLEAN. Relative source-line/SLD attribution remains unsealed.
Detailed GenerateAllLightTables verification is 165/165 PASS. Fresh 526-object
GNU link: strict rc=0 with existing 590 multiple-definition diagnostics;
multdef-ok rc=0/empty stderr; zero undefined names/truncated relocations.
Vtable audit PASS in 1314 files. The native count is unchanged, but the
previously wrong loop-scope boundaries have been corrected independently of
the unresolved missing local record.
Honest linked RECON remains 299819/299819 identical, zero masked mismatch bytes
or foreign labels, BLOB passthrough excluded. Whole-tree native board remains
2093 CLEAN / 472 DIRTY; no native CLEAN function regressed.

2026-09-28 Camera_UpdateAnimCam: removed both cVar1/cVar4 synthetic signed-byte
captures and their carrier annotations. Each acquisition now uses
`(signed char)((Camera_gInfo[player].animNum -= 1) + 1)` as the array index.
The unsigned byte assignment wraps the decrement; casting after the plus-one
reconstructs the signed old byte, including old zero/128/255. All 256 byte
values were checked for index equivalence, and the compiled instruction stream
matches independently. No new local, asm, volatile, header/type change, macro
exemption, or post-compile edit was introduced.
Plain signed-lvalue postfix cost 17 differences (179 vs 176); a signed cast of
unsigned postfix had the right count but the wrong decrement immediate, 255
versus retail -1. Explicit subtraction with old-byte reconstruction resolves
that without a named temporary at either acquisition site. Detailed 176/176
PASS. Full gate `run-u555nwy7`: compiled sections/layouts unchanged, ASPSX 524
good/0 bad, PSYLINK zero errors; camera 29/38 -> 30/38 native CLEAN. Target
frame, sole parameter, three AUTO names/types/homes/order and scope boundaries
match retail. Original expression spelling/field-signedness context and complete
SLD attribution are not claimed uniquely recovered; source reconstruction stays
explicit about that uncertainty rather than presenting native CLEAN as a full seal.
Final comment-cleaned gate `run-vp06rioz` repeats unchanged compiled sections/
layouts, ASPSX 524 good/0 bad, PSYLINK zero errors and camera 30/38 native CLEAN.
The stored decrement byte as well as the reconstructed signed old index agree
for all 256 byte inputs. Fresh 526-object GNU relink: strict rc=0 with existing
590 overlap multiple-definition diagnostics; multdef-ok rc=0/empty stderr;
zero undefined names and truncated relocations. Vtable audit PASS in 1314 files;
all 8 relocation-normalizer regression tests pass. Native whole-tree board:
2094 CLEAN / 471 DIRTY. The exact successful spelling and limitations were also
recorded in the reconstruction-methodology reference.
Fresh honest linked measurement remains RECON 299819/299819 identical, zero
masked mismatch bytes or foreign labels, with retail BLOB passthrough excluded.
The complete source-restoration/SLD goal is still incomplete.

2026-09-28 Camera_NextMode: removed the splitBase integer-address carrier.
The split-screen mode selection now uses the real int[3] gSplitCameras array
with a signed-short remainder subscript and the increment's narrowed assignment
value: `(short)gSplitCameras[(short)((Camera_gInfo[cviewP].camNum += 1) % 3)]`.
This preserves retail's halfword load, signed-short index scaling, address
allocation and all 237 instructions. No new alias, local, asm, volatile, header
change or post-compile rewrite. Plain pointer-arithmetic forms (base-first,
index-first, unsigned base, widened base) were each count-exact but had six
differences in the address allocation/schedule and were replaced, not retained.
Initial whole-module gate `run-x1nos9vf`: compiled sections/layouts unchanged,
ASPSX 524 good/0 bad, PSYLINK zero errors; camera 30/38 -> 31/38 native CLEAN.
Frame, parameter, flagMode local/home/scope and all scope boundaries now match
retail. The pre-existing unrecorded const modeForRange alias remains an explicit
source-review item; native CLEAN does not erase that review obligation or seal
original expression spelling/SLD attribution.
Final comment-cleaned gate `run-8f_zbxts`: unchanged compiled sections/layouts,
ASPSX 524 good/0 bad, PSYLINK zero errors, 31/38 native CLEAN. Fresh 526-object
GNU link: strict rc=0 with existing 590 multiple-definition diagnostics;
multdef-ok rc=0/empty stderr; zero undefined names/truncated relocations.
Vtable audit PASS in 1314 files, all 8 relocation-normalizer tests pass.
Whole-tree native board: 2095 CLEAN / 470 DIRTY; no native CLEAN regressions.
Fresh honest RECON remains 299819/299819 identical, zero masked mismatch bytes
or foreign labels; retail BLOB passthrough excluded. The source-restoration and
full SLD goal remains active and incomplete.

2026-09-28 Camera_UpdatePulloverCam: restored ySign to the actual road-frame
cross product's y component in retail REG:$16 and removed the unrecorded side
local. The Camera_IslandProfile return remains anonymous in the sign-flip
condition, XORed with `(ySign < 0) ? 1 : 0` and normalized at the common join.
This preserves the two-instruction bgez skip and shared sltu, not merely a
branch-target-normalized match. Full compiled-section gate `run-b_4ty6c4` is
UNCHANGED; ASPSX 524 good/0 bad, PSYLINK zero errors; camera 31/38 -> 32/38
native CLEAN. Detailed 223/223 PASS. Target frame, parameter, five AUTO records,
ySign's type/home/order and scope boundaries match retail; source spelling and
full SLD attribution remain unsealed. The pre-existing unrecorded gameTicks
const snapshot still requires source review and is not erased by native CLEAN.
SetCameraZoom probes were reversed: reusing targetDist as the zoom working value
changed 20 detailed differences at 70/68; global accumulation with a bound-first
clamp expression changed 14 at 70/68. The original gs carrier remains explicitly
unresolved. No fake name, alias, asm, volatile or tool exemption was added.
Final comment-cleaned gate `run-0f7sz75d`: compiled sections/layouts unchanged,
ASPSX 524 good/0 bad, PSYLINK zero errors, camera 32/38 native CLEAN. Fresh
526-object GNU link: strict rc=0 with existing 590 multiple-definition
diagnostics; multdef-ok rc=0/empty stderr; zero undefined names/truncated
relocations. Vtable audit PASS in 1314 files, all 8 relocation-normalizer tests
pass. Whole-tree native board 2096 CLEAN / 469 DIRTY. The successful value-role
correction and shared-normalization recipe are recorded in the methodology ref.
Fresh honest linked RECON is 299819/299819 identical, zero masked mismatch
bytes and foreign labels, BLOB passthrough excluded. Full original-source/SLD
restoration is not complete; const snapshots remain in the explicit review queue.

Additional heli carrier correction: after restoring vertigo's quantity, direct
`arm.y += vertigo` after the existing boundary removes armY while preserving
443/443 instructions. Neither a new fence nor a relocated fence is retained.
Full gate `run-b89clpg1`: compiled sections/layouts unchanged, ASPSX 524/0,
PSYLINK zero errors; armY's EXTRA record disappears. Earlier accumulating arm.y
into vertigo changed 11 differences at 444/443; moving the field update before
the existing boundary changed 5 at 444/443; both were reversed.
Second-slice address removal probes were reversed: branch-local typed array,
typed-pointer conditional and explicit byte-pointer conditional each changed
8 differences at 445/443. Moving the slice subtraction before a unified index
conditional was count-exact but changed 12 schedule differences. The original
second address carrier remains visible with a corrected unresolved comment.
Final full-module gate `run-rkeh3jc2`: compiled sections/layouts unchanged,
ASPSX 524 good/0 bad, PSYLINK zero errors. Heli retains four EXTRA categories
(ax/z occur in two phases, plus rev and second) and 8 versus 3 scopes; the
vertigo home and scale depth are no longer issues, and armY is gone. Native
board remains 2096 CLEAN / 469 DIRTY; camera 32/38 native CLEAN, with no CLEAN
regressions. Fresh 526-object link: strict rc=0 with existing 590 overlap
multiple-definition diagnostics; multdef-ok rc=0/empty stderr; zero undefined
names/truncated relocations. Vtable audit PASS in 1314 files.
Fresh honest RECON remains 299819/299819 identical, zero masked mismatch bytes
and foreign labels, BLOB passthrough excluded. All 8 relocation-normalizer
tests pass. Complete original-source/SLD restoration remains unproven.
Post-probe restored-baseline gate `run-5a04dm6k`: camera's compiled sections/
layouts unchanged, ASPSX 524 good/0 bad, PSYLINK zero errors, 32/38 native
CLEAN. A patch context initially matched the neighboring TailCam's similar
behavior block; the compiler gate rejected its duplicate z declaration, and
the edit was corrected before the final gate. Neither a failed trial nor a
change to TailCam is retained.

2026-09-28 Camera_UpdateHeliCam partial native correction: combined the
transition/length predicates, with len assigned in the short-circuited second
operand. This restores scale to retail depth 3 and the exact +59c/+62c..+670
scope pair, reducing total scopes from 10 to 8 (`run-4ypgcw97`, BYTES UNCHANGED).
Restored vertigo to the terrain-height difference/behavior-clamp quantity in
retail REG:$4, instead of naming the speed-rate clamp result in REG:$5. The
rate clamp now assigns directly to rate; fallback retains its velocity-retreat
role. NFS2's matched Camera_UpdateHeliCam2 independently names the velocity
retreat fallback. No new local or semantic name was introduced. Detailed
443/443 PASS; full gate `run-25g9arek` has unchanged compiled sections/layouts,
ASPSX 524 good/0 bad and PSYLINK zero errors. All retail named root locals now
agree in type/home/order; extra z/ax/rev/second/armY objects and their declaring
blocks remain visible and unresolved. Native module count remains 32/38 CLEAN.
Stale comments claiming current text-move rows or an epilogue ref-step fence
were corrected: neither exists in the current build/source. Existing empty
fences remain explicit source-restoration review items; none was added. Full
SLD/source spelling remains unsealed, and this function is not called CLEAN.

2026-09-28 first helicopter speed-quantity check (no retained change): replacing
the unrecorded z capture with repeated conditional absolute-Z expressions
changed 24 detailed differences at 455/443. Repeated __builtin_abs was closer
but still 8 differences at 445/443: the Z load moved after the existing
boundary, and the required in-place sign correction gained a copy. Both forms
were reverted. This identifies the current scheduling/value-flow constraint,
not a proven compiler limit or original source spelling. The previously
verified vertigo, scale, and arm.y corrections remain intact.

2026-09-28 AITrigger_TriggerManager::CheckForClosestTriggerOfType: the original
thisTrigger pointer belongs to the loop body at depth 3, not function root.
Moving its declaration alone was byte-identical but still left the loop one
scope short (`run-2foxwywa`). A normal `for` with tLoop's increment in its
header restores the retail binding at +02c, body at +034, and the exact
+0a0/+0ac scope ends. Final full gate `run-j58u7_33`: all compiled sections/
layouts unchanged, ASPSX 524 good/0 bad, PSYLINK zero errors; aitriger 5/10 ->
6/10 native CLEAN. Target frame, four parameters, six local names/types/homes/
order and scope tree match. No synthetic alias, asm, volatile, post-compile
rewrite or new name was added. Relative SLD line attribution remains unsealed.

2026-09-28 aitriger.obj completed its native function-local contract, 5/10 ->
10/10 CLEAN with all compiled sections/layouts unchanged. CheckForClosestTriggerOfType
now uses a for loop whose +02c binding and +034 body own retail's thisTrigger
REG:$3; receipt `run-j58u7_33`, 52/52 detailed PASS. GetNextTrigger and
GetPrevTrigger update lastTriggerChecked_[car] with prefix ++/--, leaving no
extra root triggerNum. Their shared tail is an inferred nonvirtual inline member
GetCheckedTrigger(int triggerNum): receiver `this` and value parameter belong
to the +040 outer inline scope, the inner empty scope extends to +068. Passing
the slot pointer instead preserved bytes but put triggerNum one scope too deep;
passing its loaded value matches both debug trees. The exact original helper
name is not in retail SYM and remains unproven; its semantic name and upper-bound
only behavior are annotated in the header. GetTrigger shares that helper for
its bounds-checked return, restoring its own nested this/triggerNum records at
+034..+060 without an invented int-as-pointer result variable.
AITrigger_Compare now names the two trigger_t pointer values ta and tb and
compares their typed `any.slice` fields, replacing offset-cast loads. It matches
retail REG:$2/$3 and all six original leaf instructions. Final full native gate
`run-y0h1v4q8`: BYTES UNCHANGED, ASPSX 524 good/0 bad, PSYLINK zero errors,
aitriger 10/10 CLEAN; no previous PASS regressed. The two manager-pointer
globals are under retail's aitriger.obj FILE record, not anim.obj; corrected
the stale owner comment. No general asm, volatile, register pins, generic
exemption or post-compile rewrite was introduced. Original helper spelling,
complete SLD line attribution, and broader project declaration coverage remain
open; 10/10 native CLEAN is not a full-project source-restoration claim.
The final full reconstruction build (`python tools/build.py --skip-asm`) passed
after the private header edit. The inferred helper has no standalone symbol in
the reconstructed object or generated SYM; it is used only at the three proven
inline sites. Current whole-tree native board: 2101 CLEAN / 464 DIRTY.
Both full builds passed after the header edit: `build.py --skip-asm` and
`build.py --out expected --no-link`, with no failed/skipped units. Final
comment-cleaned native gate `run-kjce9_uc` repeats unchanged sections/layouts,
ASPSX 524/0, PSYLINK zero errors and 10/10 CLEAN. Detailed GetNext/GetPrev/
GetTrigger/Compare/Closest checks are 28/28/26/6/52 instructions, all PASS.
The inferred nonvirtual member preserves retail's 844-byte manager layout and
emits no standalone helper symbol. Fresh 526-object GNU link: strict rc=0 with
existing 590 multiple-definition diagnostics; multdef-ok rc=0/empty stderr;
zero undefined names/truncated relocations. Vtable audit PASS in 1314 files;
all 8 relocation-normalizer tests pass. Complete original-source/SLD restoration
remains open, including the exact original inline helper name.
Final honest real-link measurement: RECON 299819/299819 identical, zero masked
mismatch bytes or foreign labels; retail BLOB passthrough excluded. No failed
experiment is retained in the reconstructed source or the normal object cache.

2026-09-28 AIState_Idle::Execute and AIState_Offroad::Execute: moved off into
Idle's declaring else body and zero into Offroad's hold-in-place body, both
at retail depth 3. Idle's +000/+040..+0ac scopes now match; Offroad's zero
scope +020..+0c8 matches. Offroad's targetLatPos clear belongs in both source
arms; placing it there leaves one merged physical store and extends the outer
scope to retail +19c, rather than +190. Full gate `run-ysc5kkvm` is unchanged
in compiled sections/layouts, ASPSX 524/0, PSYLINK zero errors; aistate 26/42 ->
28/42 native CLEAN. With that source shape restored, direct assignment of
AIWorld_ApxSplineDistance to longMetersBetween_ is also 107/107 PASS, so the
synthetic iVar4 carrier and its exemption comment were removed entirely.
The earlier comment's 73-diff verdict applied to a different source shape,
not a compiler limit. No alias, invented name, new asm/volatile or post-compile
rewrite was introduced. Full original expression spelling/SLD attribution
remain unsealed; native CLEAN is not a project-completion claim.
Final carrier-free Offroad gate `run-_pn_5wry` repeats unchanged compiled
sections/layouts, ASPSX 524/0 and PSYLINK zero errors. Idle/Offroad detailed
checks are 47/107 instructions, both PASS. Updated their stale SLD-VERIFIED
labels to distinguish verified native/byte contracts from open line attribution.
Purgatory::TestForRelease now declares trafficInWorld in the timer-expired body
at retail depth 3. Full gate `run-zwyuwq6g` is unchanged in compiled sections/
layouts, ASPSX 524/0, PSYLINK zero errors; aistate becomes 29/42 native CLEAN.
Its +000/+018..+06c scope pair, record type/home/order and frame now agree.
Final comment-cleaned gate `run-e7gbelwu`: whole compiled sections/layouts
unchanged, ASPSX 524 good/0 bad, PSYLINK zero errors; aistate 29/42 native CLEAN.
Detailed Idle/Offroad/TestForRelease checks are 47/107/31 instructions, all PASS.
The three modified functions' source labels now explicitly leave SLD line
attribution open instead of retaining an unjustified SLD-VERIFIED stamp.
Current native whole-tree board: 2104 CLEAN / 461 DIRTY; no CLEAN regressions.
Fresh 526-object GNU link: strict rc=0 with existing 590 multiple-definition
diagnostics; multdef-ok rc=0/empty stderr; zero undefined names/truncated
relocations. Vtable audit PASS in 1314 files and all 8 relocation-normalizer
regression tests pass. No failed trial or Offroad's former iVar4 carrier is retained.
Fresh honest linked RECON remains 299819/299819 identical, zero masked mismatch
bytes or foreign labels, BLOB passthrough excluded. Full original-source/SLD
restoration remains active and incomplete.

2026-09-28 AIState_RovingTraffic::CheckIfCarIsNearbyAndStop: restored nested
longitudinal/lateral guards and moved posDiff to retail depth 5, AUTO -40.
The status=2 else arm's explicit return restores the surrounding +194 endpoints;
the distance-failure else arm restores +198. All +074/+084/+0cc..+188/+194/+198
scope boundaries now match. Replaced the two LAB_STATUS labels with ordinary
returns/else stores. The nonpositive-dot path still leaves status untouched,
including its exact epilogue-target branch word. Initial native-complete gate
`run-9pinrbcy` is unchanged in compiled sections/layouts. With that source shape,
removing the old otherCarObj identity asm also preserves all 109 instructions;
carrier-free gate `run-osxgw8l6`: BYTES UNCHANGED, ASPSX 524/0, PSYLINK zero
errors, aistate 29/42 -> 30/42 native CLEAN. No replacement fence, volatile,
register pin, fake use, alias or invented local name was added. Frame, three
parameters, distance/posDiff records and scope tree match retail. Source
spelling/full SLD attribution remains unsealed; updated the old SLD-VERIFIED
label accordingly rather than treating native CLEAN as complete restoration.
Final comment/indent-cleaned gate `run-5_wbz74u`: whole compiled sections/
layouts unchanged, ASPSX 524 good/0 bad, PSYLINK zero errors; aistate 30/42
native CLEAN. Detailed 109/109 PASS. No previous CLEAN function regressed;
whole-tree native board is 2105 CLEAN / 460 DIRTY. No header change was made.
Fresh 526-object GNU link: strict rc=0 with existing 590 multiple-definition
diagnostics; multdef-ok rc=0/empty stderr; zero undefined names and truncated
relocations. Vtable audit PASS in 1314 files; all 8 relocation-normalizer tests
pass. Original-source/SLD completion remains unproven across the broader tree.
Fresh honest linked RECON remains 299819/299819 identical, zero masked mismatch
bytes or foreign labels; retail BLOB passthrough excluded. No failed trial is
retained in source or the normal object cache.

2026-09-28 release/donuts source-scope investigation: release lower-bound
statement probes changed 7 differences at 31/30 and 14 at 30/30. Reversing the
comparison or initializing releaseDistanceMeters at use preserved bytes but
did not recover its record. An inferred inline release setter matched the
30-instruction caller but emitted an unwanted 12-byte standalone function and
changed rodata, so the whole-object gate rejected it. Its in-class and
out-of-class forms were both reverted; aistate_classes.h is unchanged and no
helper or byte-reference replacement is kept. Full restored baseline gate
`run-_gl5ni3b` verified unchanged compiled sections/layouts and 30/42 native CLEAN.
Removed the artificial declaring block around Donuts' carObj snapshot without
removing or exempting the unresolved capture itself. Full gate `run-708btuc_`:
BYTES UNCHANGED, ASPSX 524/0, PSYLINK zero errors; Donuts scope count 4 -> 3
(retail 3). Its first if-binding start is still +0c4 versus retail +0cc, and
carObj REG:$4 remains EXTRA. This partial source correction is retained because
it removes an unsupported lexical region, not because native CLEAN was attained.
No invented name, asm/volatile, tool exclusion or post-compile rewrite added.
Final comment-cleaned gate `run-2i4c5jy_`: unchanged compiled sections/layouts,
ASPSX 524/0, PSYLINK zero errors; aistate 30/42 native CLEAN, original DIRTY
issue set except the verified Donuts scope reduction. Detailed Donuts and
UnleashIfInRange checks are 319/30 instructions, both PASS. The attempted
release helper is absent from source, and no shared header change is retained.
Fresh 526-object GNU link: strict rc=0 with existing 590 multiple-definition
diagnostics; multdef-ok rc=0/empty stderr; zero undefined names/truncated
relocations. Vtable audit PASS in 1314 files; all 8 relocation-normalizer
regressions pass. Honest RECON remains 299819/299819 identical, zero masked
mismatch bytes or foreign labels, BLOB passthrough excluded. Native board
remains 2105 CLEAN / 460 DIRTY; source/SLD completion remains unproven.

2026-09-28 AIHigh_BTC_AIPerp::AvoidCops: combined the null/control/direction/
distance predicates into one short-circuit guard. Retail's four x/z position
and index locals now occupy its single depth-3 +05c..+324 body instead of
depth 7 across separately nested tests. Guard binding +000..+324 and function
end +33c match too. Full gate `run-hprv7677`: compiled sections/layouts unchanged,
ASPSX 524/0, PSYLINK zero errors; aih_btcperp 5/20 -> 6/20 native CLEAN.
The address-style exit label was replaced by semantic apply_brake_choice,
which explicitly denotes skipping the u-turn random roll after brake selection;
its original spelling is unavailable and not claimed recovered. Byte/native
gate `run-2c6quygr` is unchanged. The alternative guarded second-roll form
changed 11 differences at 210/209; a single-pass do/break form changed 290 at
203/209 and was also reversed. No new alias, fake variable, asm/volatile,
register pin, tool exclusion or post-compile rewrite was kept. Original source
spelling/full SLD attribution remains unsealed; the old SLD-VERIFIED stamp
was corrected rather than promoting native CLEAN to a full source seal.
Final comment-cleaned gate `run-do9xw8zp`: unchanged compiled sections/layouts,
ASPSX 524/0, PSYLINK zero errors; AvoidCops detailed 209/209 PASS. All retail
named locals, homes, order, depth and scope boundaries now agree. The semantic
label is not a recovered original spelling; complete SLD attribution remains
unsealed. Whole-tree native board 2106 CLEAN / 459 DIRTY; no CLEAN regressions.
Fresh 526-object link: strict rc=0 with existing 590 multiple-definition
diagnostics; multdef-ok rc=0/empty stderr; zero undefined names/truncated
relocations. Vtable audit PASS in 1314 files and all 8 relocation-normalizer
tests pass. No failed structured-exit experiment is retained.
Fresh honest linked RECON remains 299819/299819 identical, zero masked mismatch
bytes or foreign labels; BLOB passthrough excluded. Overall original-source/SLD
completion remains active and unproven.

2026-09-28 cop-notification loop ownership round: ReleaseCops, NotifyCopsOfArrest,
NotifyCopsOfArrestComplete, NotifyCopsOfFalseArrest and NotifyHumanCopsOfArrestHud
now use for-declared carLoop and body-local otherCarObj, at retail depths 2/3
and the same homes. Full gate `run-n90lash3`: compiled sections/layouts unchanged,
ASPSX 524/0, PSYLINK zero errors; no prior PASS regressed. Each function's
remaining native issue is now only BLOCKS 3 versus retail 5: two empty regions
around the action/receiver path are not recovered. Separating the flag and
active checks was byte-identical but did not create those regions, so that
neutral variant was reversed. Do not add dummy declarations or an invented
forwarder just to manufacture empty scopes. The verified named-local ownership
improvement is retained while the missing regions remain explicit backlog items.
No new name, alias, asm/volatile, generic exemption or instruction rewrite.

2026-09-28 drawc declaration-region round: DrawC_ReadLightingData's retail
records contain one root scope and i/ScaneData/RenderingFileData/name. Removing
the artificial block around the optimized-away track staging declaration
restores that scope tree without changing the 130 retail instructions. Final
symloop `run-vwx1i907`: all sections/layouts UNCHANGED, ASPSX 524 good/0 bad,
PSYLINK zero errors, drawc 7/20 native CLEAN (one gained). Whole-tree native
report is now 2107 CLEAN / 458 DIRTY. Direct field passing was still two
scheduled-word differences at 130/130 and was reverted: trk's source spelling
and need for a distinct original object remain explicitly unresolved. Native
CLEAN does not seal that source carrier or full SLD attribution. No new asm,
volatile, dummy use or instruction rewrite. Clock's comma-expression and
duplicated generic-increment-arm probes were 18/31 diffs and were fully
reverted; its fresh restored baseline passes the immutable byte reference.
Force's fresh pre-edit byte gate disagrees with its existing reference
(`run-tam51vrp`); no Force source or reference was changed. Reconcile that
baseline separately before attempting its loop-local ownership corrections.
Final linked regression: fresh 526-object census, multdef-ok rc=0/empty stderr,
zero undefined names or truncated relocations (strict retains the existing
590 multiple-definition diagnostics). Honest RECON 299819/299819, zero
differences/masked mismatches/foreign labels; vtable audit PASS in 1314 files,
whitespace check clean. This post-12c98ae1 correction is local and uncommitted.

2026-09-28 DrawC_PrimStop guarded ownership: retail records place sort_carObj,
worldZ and sub_otSize at depth 3 in +010..+0b8, under the sort_flag==0
guard, rather than at root before a negative early return. Restoring that
positive body reproduces all three native scopes and local homes without
changing 48/48 instructions. SLD independently maps the initial flag test to
1536 and body acquisition to 1538. Final comment-cleaned full symloop
`run-k4u5ikll`: BYTES UNCHANGED, ASPSX 524/0, PSYLINK zero errors, drawc
8/20 native CLEAN; whole-tree 2108 CLEAN / 457 DIRTY. No new carrier/name,
asm, volatile, dummy use, header edit or instruction rewrite. Full statement
and instruction-line attribution remains open. The following round resolves
the backwards 1548/1547 ordering evidence without claiming a full SLD seal.
This correction and the preceding ReadLightingData region cleanup are local,
uncommitted post-12c98ae1 work.
Fresh GNU link: 526 objects, multdef-ok rc=0/empty stderr, no undefined names
or truncated relocations; strict retains existing overlap diagnostics. Honest
RECON 299819/299819, zero differences/masked mismatches/foreign labels. Vtable
audit PASS across 1314 files; whitespace check clean.

2026-09-28 DrawC_PrimStop SLD/source-spelling continuation: retail associates
worldZ with lines 1547/1551 and sub_otSize with the following 1548/1552;
the scheduled machine loads run size-first. Reordering both source pairs to
world-first preserves 48/48 instructions, and sldprobe reproduces those
backwards line-tag pairs (+040/+044 and +050/+054). Retail also tags the
entire two-tag-store tail +05c..+0b4 as one source statement, line 1561.
Canonical PsyQ 4.3 LIBGPU.H:248 defines addPrims(ot,p0,p1) as precisely
setaddr(p1,getaddr(ot)),setaddr(ot,p0). Restoring that SDK macro spelling
with p0=sd->sub_ot+sub_otSize and p1=sd->sub_ot preserves all 48 words
and puts both stores under one call-site tag; no invented game helper or
inline scopes are introduced. Added the canonical macro to the existing
psyq_prim_macros.h without changing its types or existing macros. Remaining
relative line counts/complete SLD attribution still differ (sldprobe reports
46/48 tag differences); no padding or artificial #line directives were used.
This is partial source restoration, not a claim of complete SLD validity.
Final gate `run-dwjq_ayi`: all compiled sections/layouts UNCHANGED, ASPSX
524/0, PSYLINK zero errors, drawc 8/20 native CLEAN. Whole-tree native report
stays 2108 CLEAN / 457 DIRTY. Fresh GNU census 526 objects; multdef-ok
rc=0/empty stderr, no undefined names or truncated relocations (strict retains
existing overlap diagnostics). Honest RECON 299819/299819, no differences,
masked mismatches or foreign labels; vtable audit PASS in 1314 files.
Changes remain local/uncommitted, and full source/SLD restoration remains active.

2026-09-28 DrawC_MenuColorData carrier/ownership round: retail carType REG:$3
is the initial car-info type, not the later anonymous current-render-type load
in a1. Assign carType only to the former and pass/read the latter directly.
Retail filename/infilename/shpfile live at depth 5 in the texture-reload arm,
not at function scope. The asynchronous path's early colorIndex store/return
cross-jumps with the common final store, removes two excess enclosing scopes,
and preserves branch words. The pointer-free typed array spelling remained
22 diffs at 136/136; fused comparison assignment was 18 diffs. Index-term-first
`*(int *)((player << 2) + (int)DrawC_gMenuColor)` for the compare and store
preserves 136/136 instructions without menuColorSlot. No alias, const-hidden
carrier, asm/volatile or instruction rewrite replaces it. Final full gate
`run-fwyjbk7y`: complete sections/layouts UNCHANGED, ASPSX 524/0, PSYLINK
zero errors, drawc 9/20 native CLEAN. Target now matches all named homes,
types, depths and five native scopes; full SLD attribution remains unsealed.
Whole-tree native comparison: 2109 CLEAN / 456 DIRTY (EXTRA 305, MOVED 40,
SCOPE 201, BLOCKS 380 affected functions). New work remains uncommitted.
Final linked regression: fresh 526-object census; multdef-ok rc=0/empty stderr,
zero undefined/truncated relocations, existing strict overlap diagnostics.
Honest RECON 299819/299819 with zero differences/masked mismatches/foreign
labels. Vtable audit PASS in 1314 files; whitespace check clean.

2026-09-28 DrawC_NightHeadlight carrier reduction: negative-first arithmetic
`tmp.x = -human.position.x + car.position.x` (and y/z) preserves retail's
subtrahend-first read order without three named h0/h1/h2 objects or their
extra declaring block. GCC emits the same subu operations, all 107/107
instructions and complete section/layout fingerprints. Direct staging through
the AUTO tmp fields added six instructions (113/107, 18 diffs) and was reverted.
The old h-object necessity claim was basin-specific and is now explicitly
superseded in source. Final `run-2id3fxoe`: BYTES UNCHANGED, ASPSX 524/0,
PSYLINK zero errors; all retail named locals/homes/depths and five scopes
match, leaving only EXTRA lightSlotView REG:$6. Direct &light guards in
either operand order are still two scheduling differences at 107/107 and were
reverted. That view remains a specific unresolved source-recovery item, not
proof of an original separate object and not a generic exemption. The retired
PER_FN_TEXT_MOVES historical recipe is labeled obsolete; current build.py
has no such output rewrites. No new asm/volatile/fence/alias. Whole-tree native
board stays 2109 CLEAN / 456 DIRTY; BLOCKS issues fall to 379 functions.
Full SLD/source spelling remains open; this reduction is local/uncommitted.
Fresh linked regression: 526-object census, no undefined names/truncated
relocations, multdef-ok rc=0/empty stderr (existing strict overlap diagnostics).
Honest RECON 299819/299819, zero differences/masked mismatches/foreign labels;
vtable audit PASS in 1314 files and whitespace check clean.

2026-09-28 DrawC_NightHeadlight pointer-view continuation: retail pos is the
root coorddef pointer in a2. Its coordinate phase ends before the transform
calls; retail later reuses a2 as sp+104, the address of light's pointer slot,
for lightning RGB. Reuse pos as `(coorddef *)&light`, then actually read/write
the three channels through `(CVECTOR *)pos`. The guard is only the real
Night_gDrawLightning test: the dummy non-null predicate and unrecorded
lightSlotView are gone. No coorddef members are read through the four-byte
slot; only CVECTOR r/g/b are touched, preserving the retail pointer-slot bug
confirmed by raw loads/stores and independent M2C func_800BE978.c. Restore
root declaration order pos/light/i/nightMat/nightV/zero to match the retained
SYM records. Final `run-isoj73rm`: 107/107 PASS, all sections/layouts UNCHANGED,
ASPSX 524/0, PSYLINK zero errors, drawc 10/20 native CLEAN. Whole-tree native
board 2110 CLEAN / 455 DIRTY. This is a verified reconstruction with no extra
object, not proof of the literal original pointer-reuse/cast expression;
that spelling and complete SLD attribution remain explicit source-review work.
Integer-cast direct &light guard was 38 diffs at 107/107 and was reverted.
No new invented name, alias, asm, volatile, fence or output rewrite. Local,
uncommitted post-12c98ae1 work remains active.
Fresh link regression: 526-object census; multdef-ok rc=0/empty stderr,
zero undefined names/truncated relocations (existing strict overlap diagnostics).
Honest RECON 299819/299819, zero differences/masked mismatches/foreign labels;
vtable audit PASS in 1314 files and whitespace check clean.

2026-09-28 DrawC_ShowroomPrims identity round: root index REG:$2 is the
tick remainder, now `index=gettick()%256`; i REG:$8 is the fill and outer
counter, j REG:$7 is the inner counter. The main loop is for(i...), with a
separate body-local index=i*2 at REG:$2 and iPlus=index+2 at REG:$5. All
vertex and hilight-state uses now follow those distinct roles. This restores
the missing root/nested index record and original counter homes without new
names or alias copies. The explicit fill block was also unnecessary: move
the still-unresolved hs/m1 into the existing guarded body, restoring all
18 retail scopes. Pointer-free indexed fills with and without m1 were still
8 diffs at 297/297; fully reverted. Existing vt0 fence/z1 carrier still need
source review even where optimized out of native locals. Final full gate
`run-d2eu1mlk`: 297/297 PASS, complete sections/layouts UNCHANGED, ASPSX
524/0, PSYLINK zero errors. Target issues now only EXTRA hs REG:$2 and
EXTRA m1 REG:$3; they are specific unresolved recovery items, not a proven
source-object necessity or generic exemption. Whole-tree 2110 CLEAN / 455
DIRTY, with MISSING 123, MOVED 39, BLOCKS 378 affected functions. No new asm,
volatile, dummy use or output rewrite. Full SLD remains open; uncommitted.
Fresh regression: 526-object link census, multdef-ok rc=0/empty stderr,
zero undefined names or truncated relocations (existing strict overlap
diagnostics). Honest RECON 299819/299819, zero differences/masked mismatches/
foreign labels; vtable audit PASS across 1314 files, whitespace clean.

2026-09-28 Showroom fill compiler diagnosis (no speculative source retained):
post-decrement, ordinary for-loop and index-term-first integer address forms
all remain eight differences at 297/297. The canonical CC1PLPSX -O2 -G8
`-dL` diagnostic (`tools/rtl_dump.py`, scratch/rtl/drawc.i.loop) identifies
fill loop 118..144, six real instructions, BIV reg83 initialized to31;
address GIV insn132 has benefit3 before reduction costs and is rejected:
`giv of insn 132 not worth while, 0 vs 6`. GCC 2.8.1 loop.c:3879..3921
subtracts increment costs then tests lifetime*threshold*benefit < insn_count.
This explains this indexed spelling's absent reverse walker, not a universal
source floor. The more focused explicit-walker/literal -1 trial is just two
ordering differences: the -1 materialization must precede the counter setup.
Both hs and m1 remain unresolved; no invented rename, const-hidden alias,
fake use or changed compiler flags were kept. All failed variants were
reverted; a fresh immutable reference gate passes and detailed target is again
297/297 PASS. The next investigation can compare those constant-ready-list
graphs and price a genuinely different loop form rather than retry identical
indexed forms. Native board unchanged; full SLD/source recovery still active.
Restored-state regression: 526-object link, no undefined/truncated relocations,
multdef-ok rc=0/empty stderr (existing strict overlap diagnostics), honest
RECON 299819/299819 with no differences/masked mismatches/foreign labels.
Vtable audit PASS in 1314 files; whitespace clean; no new code fix or commit.

2026-09-28 DrawC_DividePrim declaration-region restoration: replace the
capacity/OT-range positive wrappers with negative early guards, leaving
retail's explicit bfct, clipW/clipH and packet-field regions directly under
the proper parent. bfct/clip depths are 2, packet-local depths 3; native
scope nesting and instruction boundaries now agree. Declare uv0/uv1/uv2
before clut/tpage as retail records do, assigning the latter at their existing
use sites. This fixes declaration order without changing emitted loads or
stores. Final full `run-439z8mx0`: 153/153 PASS, all sections/layouts
UNCHANGED, ASPSX 524/0, PSYLINK zero errors, drawc 11/20 native CLEAN.
Whole-tree native board 2111 CLEAN / 454 DIRTY (SCOPE 200, ORDER 3,
BLOCKS 377 affected functions). No new name, carrier, asm, volatile, fake
use or compiler-output rewrite; existing hardware/template macros unchanged.
Original expression spelling and full instruction-line attribution remain
unsealed. Source/journal changes remain local and uncommitted.
Final regression: fresh 526-object link; zero undefined names/truncated
relocations, multdef-ok rc=0/empty stderr (existing strict overlap diagnostics).
Honest RECON 299819/299819, zero differences/masked mismatches/foreign labels;
vtable audit PASS in 1314 files; whitespace check clean.

2026-09-28 DrawC_DivideShadowPrim partial restoration: negative early
capacity/front-z guards remove artificial declaring wrappers; the OT and
texture-field regions now have retail depth 2 and exact native boundaries.
Declare uv0/uv1/uv2/uv3/clut/tpage in retail order inside the field region.
uv2/uv3 name destination slots: uv2 reads *u3 and uv3 reads *u2, matching
their retail v1/v0 homes rather than preserving the swapped decompiler names.
The separate color capture is unnecessary: copy sd->color directly into the
packet before the length store, allowing GCC to produce the same load/store
schedule. Final full `run-puxsyq5t`: 122/122 PASS, complete sections/layouts
UNCHANGED, ASPSX 524/0, PSYLINK zero errors. Target's sole native issue is
EXTRA otp REG:$4; all retail named types/homes/depths/order/scopes match.
Plain ot mutation, uint-pointer arithmetic, compound mutation in the first
tag expression, and canonical addPrim were all 8 scheduled-word differences
at 122/122 and were reverted. They did not improve the whole-byte gate.
otp is an explicit unresolved recovery item, not proof of original separate
storage or a generic exemption. No new name/alias, asm/volatile/fence/output
rewrite. Whole-tree 2111 CLEAN / 454 DIRTY; MOVED 38, SCOPE 199, BLOCKS
376 affected functions. Full SLD/original text remains open; uncommitted.
Fresh regression: 526-object GNU link, multdef-ok rc=0/empty stderr,
no undefined/truncated relocations (existing strict overlap diagnostics).
Honest RECON 299819/299819, zero differences/masked mismatches/foreign labels;
vtable audit PASS in 1314 files and whitespace check clean.

2026-09-28 DivideShadowPrim OT-carrier completion: separate base-load/ot
mutation forms, integer-address operand ordering, earlier mutation, and typed
`prim+1` advancement still left 8 scheduled-word differences at 122/122.
The distinct source-shape lever is one initializer before packet advancement:
`ot = LastPrim + sd->otz`. This removes otp with 122/122 PASS; canonical
PsyQ addPrim(ot,prim) is also byte-exact at this basin and replaces the two
manual masked tag stores. Typed packet advancement is retained as prim+1;
it is not credited as the independent fix. Final `run-rdwmed1l`: all sections/
layouts UNCHANGED, ASPSX 524/0, PSYLINK zero errors, drawc 12/20 native
CLEAN. Target matches all retail locals/homes/types/order and scopes; all
old color/otp carriers are gone. Whole-tree 2112 CLEAN / 453 DIRTY, EXTRA
303 affected functions. No new name/alias, fence, asm/volatile, compiler flag
or output rewrite. Literal original initializer spelling and full SLD
attribution remain unsealed. This verified source round remains uncommitted.
Fresh 526-object GNU link: no undefined/truncated relocations, multdef-ok
rc=0/empty stderr (existing strict overlap diagnostics). Honest RECON
299819/299819, zero differences/masked mismatches/foreign labels; vtable
audit PASS across 1314 files and whitespace check clean.

2026-09-28 DrawC_ShadowPrim local-role/scope round: retail's l0 REG:$2
is the first pixmap word, not the earlier anonymous sd->color capture in v1.
Copy color directly before the packet length store; assign l0 together with
l1/l2/l3 from shadowPmx and then store all four texture words. Early negative
capacity/OT-range guards leave separate root-child OT and field-copy regions,
matching retail's three scopes and depth-2 locals. Target native issues reduce
to only EXTRA otp REG:$4. DivideShadowPrim's fused-slot initializer does not
transfer here: it omits the retail forwarded-index copy (128/129, three diffs);
in-place ot plus canonical or manual tag stores is count-exact but ten schedule
differences. These failed variants were reverted; no extra asm/fence/volatile
or flag/output rewrite was added. Retain otp only as explicit unresolved
source recovery, not proven original separate storage or generic exemption.
Final `run-61o05y0k`: 129/129 PASS, complete sections/layouts UNCHANGED,
ASPSX 524/0, PSYLINK zero errors, drawc 12/20 native CLEAN. Whole-tree native
board stays 2112 CLEAN / 453 DIRTY; MOVED 37, SCOPE 198, BLOCKS 375
affected functions. Full SLD/source spelling remains open; uncommitted.
Fresh linked regression: 526-object census, multdef-ok rc=0/empty stderr,
no undefined names or truncated relocations (existing strict overlaps).
Honest RECON 299819/299819, zero differences/masked mismatches/foreign labels;
vtable audit PASS in 1314 files and whitespace check clean.

2026-09-28 ShadowPrim OT-carrier completion: the missing placement variant
is the complete initializer `ot=LastPrim+sd->otz` AFTER PrimPtr advancement.
Unlike the before-advance form (128/129), this preserves the retail forwarded
index copy and all 129/129 instructions. Canonical addPrim(ot,prim) is exact
at this spelling; otp and manual tag stores are removed, with their old
necessity comment replaced. Final `run-qbqm6yqy`: complete sections/layouts
UNCHANGED, ASPSX 524/0, PSYLINK zero errors, drawc 13/20 native CLEAN.
Target locals/types/homes/order and all three scopes now agree with retail.
Whole-tree native board 2113 CLEAN / 452 DIRTY; EXTRA 302 affected functions.
This is site-specific: DivideShadowPrim's initializer passes BEFORE packet
advancement, ShadowPrim's AFTER. Do not generalize one location or assume the
earlier missing-copy trial proved a source floor. No new object/name/alias,
asm, volatile, fence, compiler flag or output rewrite. Original spelling and
full SLD attribution remain unsealed; source/journal changes are uncommitted.
Fresh GNU census 526 objects; no undefined/truncated relocations, multdef-ok
rc=0/empty stderr (existing strict overlap diagnostics). Honest RECON
299819/299819, zero differences/masked mismatches/foreign labels; vtable
audit PASS in 1314 files and whitespace check clean.

2026-09-28 DrawC_SpotPrims source-shape restoration: retail records a root
POLY_G3* prim plus two block-local DR_MODE* prim objects, not drawMode.
Restore those shadowing declarations; each mode's nested u_long* ot directly
initializes LastPrim+sd->otz after packet advancement and uses canonical
addPrim, removing both otEntry captures. The loop's direct color copy before
length/zero-channel stores also removes color. Use an indefinite for with
the exit-in-body test and shared increment; capacity failure continues to
that increment. This removes two excess declaring levels and a temporary
semantic skip label. The duplicated-increment while/continue trial was
228/225, 13 diffs and was reverted; a shared-label trial passed but was
superseded by the ordinary for form. All three OT links use canonical
addPrim. Final `run-a18uizm7`: 225/225 PASS, complete sections/layouts
UNCHANGED, ASPSX 524/0, PSYLINK zero errors, drawc 14/20 native CLEAN;
all target locals/types/homes/order/scopes match. Whole-tree native board
2114 CLEAN / 451 DIRTY (EXTRA 301, MISSING 122, SCOPE 197, BLOCKS 374
affected functions). No new object/name/alias, asm/volatile/fence/flag/output
rewrite. Original spelling and full instruction-line attribution remain
unsealed. Source and evidence changes are local/uncommitted.
Fresh 526-object GNU link: multdef-ok rc=0/empty stderr, zero undefined/
truncated relocations (existing strict overlap diagnostics). Honest RECON
299819/299819, zero differences/masked mismatches/foreign labels; vtable
audit PASS across 1314 files and whitespace check clean.

2026-09-28 DrawC_PrimHalo lexical/flow restoration: remove three artificial
parent regions around the facet work; vertex z/t1/t2/t3 groups are now direct
loop children. bfct belongs to its own depth-3 backface region, copyLastPrim
to the final depth-3 emission region. Restore the positive index>=0 overlay
body with overlayFlag at retail depth4; reuse ov/ovs within that region rather
than separate declaring blocks. Select real_type's high byte there before
common emission, eliminating the jump into the old flare-selection if.
Direct real_type&0xff call/reflect uses then remove flareType; the facet
absorption identity also becomes unnecessary and is deleted. Both preserve
all 298/298 words at this recovered shape despite older failed trials.
Removing all four existing ovs fences was 18 diffs at 296/298; fully reverted.
ov/ovs and these fences remain explicit unresolved source-recovery devices,
not proof of original objects or a generic exemption. No new asm/volatile,
alias name, fake use, compiler flag or output rewrite was retained. Final
`run-34vr4u9j`: complete sections/layouts UNCHANGED, ASPSX 524/0, PSYLINK
zero errors, drawc 14/20 native CLEAN. Target issues only EXTRA ov REG:$2
and ovs REG:$4: all retail named homes/types/depths/order and 12 scopes match.
Whole-tree remains 2114 CLEAN / 451 DIRTY; SCOPE 196 and BLOCKS 373 affected
functions. Original spelling/full SLD remain unsealed; changes uncommitted.
Fresh 526-object link: multdef-ok rc=0/empty stderr, zero undefined/truncated
relocations (existing strict overlap diagnostics). Honest RECON 299819/299819,
no differences/masked mismatches/foreign labels; vtable audit PASS in 1314
files and whitespace check clean.

2026-09-28 PrimHalo raw-word capture removal: initialize/assign ovs directly
from `(int)((u_int)(u_short)DrawC_gOverlay[...]<<16)` at both sites; ov is
removed without replacing it with another name or const-hidden alias.
All 298/298 instructions remain exact. The first-site direct conditional
without the capture/fences instead hoists array-address work, grows the
frame and gives 98 differences at 302/298; fully reverted. Final full
`run-ucnwcbf3`: complete sections/layouts UNCHANGED, ASPSX 524/0, PSYLINK
zero errors, drawc 14/20 native CLEAN. Halo now has only EXTRA ovs REG:$4;
all recorded homes/types/depths/order and 12 scopes still agree. ovs and
the four pre-existing fences remain specific source-recovery work, not
proof of an original distinct object or a source floor. No new device,
name/alias, asm/volatile, compiler flag or output rewrite was kept. Whole-tree
native board stays 2114 CLEAN / 451 DIRTY; literal original expression and
full SLD attribution remain open. Changes are local and uncommitted.
Fresh 526-object GNU link, multdef-ok rc=0/empty stderr, no undefined or
truncated relocations (existing strict overlap diagnostics). Honest RECON
299819/299819, zero differences/masked mismatches/foreign labels; vtable
audit PASS in 1314 files and whitespace check clean.

2026-09-28 DrawC_PrimMenu partial declaration-region round: use while(true)
instead of the empty for facet loop, eliminating its extra binding level.
Remove the extra u/v wrapper in the first vertex loop. Put byte setter locals
in a child region of pmx in both UV arms, and the halfword setter locals in
their retained inner region. Full retail/ours scope-tree inspection shows
the environment packet field groups share a parent at +408; restore that
parent rather than wrapping only clut/tpage. Lift tex's declaration from its
artificial private block into the facet body without changing its use site
or existing fence. All retained changes are 480/480 PASS; target now has no
SCOPE issues for emitted matching locals. In-place facetFlag masking after
sign decoding was 128 diffs at 484/480, frame increased; fully reverted.
Final `run-7r6a6rv8`: complete sections/layouts UNCHANGED, ASPSX 524/0,
PSYLINK zero errors, drawc 14/20 native CLEAN. Remaining target issues:
EXTRA facetMask/tex, facetFlag in a0 rather than t3, missing emitted u0/u1/u2/
v0/v1/v2 debug rows (the source already declares/assigns them in both arms),
and scope-tree addresses/nesting still different at the environment color
end and overlay tail. Do not manufacture uses or claim existing declarations
prove native recovery. Whole-tree 2114 CLEAN / 451 DIRTY, SCOPE 195 affected
functions. No new name, object, asm/volatile/fence/flag/output rewrite.
Full SLD and literal original spelling remain open; local/uncommitted.
Fresh 526-object GNU link, zero undefined/truncated relocations, multdef-ok
rc=0/empty stderr (existing strict overlap diagnostics). Honest RECON
299819/299819, no differences/masked mismatches/foreign labels; vtable audit
PASS in 1314 files and whitespace check clean.

2026-09-28 PrimMenu UV identities and scope endpoints: for each of u0/u1/u2/
v0/v1/v2, separate the byte load from its in-place offset addition in both
setter arms. This preserves all 480 words but retains the original variable
identities in GCC's full debug output; all missing UV rows disappear, with
matching types/homes/depths/order. Scope-tree comparison reveals bfct ends
at +348 (before SXY/depth extraction), not +394: end its region after the
backface gate and use direct sd->otz arithmetic/tests outside. The old claim
that bfct also holds composed OT depth is superseded. Remove the redundant
overlay-arm continue to restore its +5f4 endpoint; use one shared environment
color store after branch selection to restore the +4f8 endpoint. A GNU
statement-expression code-byte variant was neutral and was reversed. All 33
retail scope records (nesting/relative begin/end addresses) now match.
Masked facetFlag with raw-field sign tests was 51 diffs at 481/480; later
in-place masking 21 at 483/480. Both were fully reverted. Final full gate
`run-dfji9cyz`: 480/480 PASS, complete sections/layouts UNCHANGED, ASPSX
524/0, PSYLINK zero errors, drawc 14/20 native CLEAN. Target remaining only
EXTRA facetMask REG:$11, EXTRA tex REG:$2, MOVED facetFlag a0 versus t3.
Whole-tree 2114 CLEAN / 451 DIRTY; MISSING 121 and BLOCKS 372 affected
functions. No new name/object, asm/volatile/fence/flag/output rewrite retained.
Full SLD and literal source spelling remain open; local/uncommitted.
Fresh 526-object link, multdef-ok rc=0/empty stderr, zero undefined/truncated
relocations (existing strict overlap diagnostics). Honest RECON 299819/299819,
zero differences/masked mismatches/foreign labels; vtable audit PASS across
1314 files and whitespace check clean.

2026-09-28 PrimMenu tex/fence placement probe (no failed code retained):
direct texture-field input in the existing fence after facetFlag gives only
3 differences at 481/480 (texture-load order and an extra load-delay nop).
Moving that fence before facetFlag, removing it entirely, or reversing the
two direct source reads gives 7 differences at 481/480; raw flag load/mask/
sign-extension register choices differ. Reusing overlayFlag as the initial
texture index is 24 differences at 484/480. These distinct source forms do
not prove an original named tex capture existed; they narrow the next
investigation to the raw flag/texture load schedule and quantity assignment,
not another whole-function rewrite or a source floor. All were fully reverted.
Fresh immutable reference passes and restored target is 480/480 PASS.
Only precise source-review comments remain from this round; existing UV
identity and 33-scope restorations are preserved. No new asm input, operand,
fake use, alias name, compiler flag or output rewrite was kept. Native board
unchanged; full source/SLD goal remains active, changes uncommitted.
Restored-state regression: fresh 526-object GNU link, no undefined/truncated
relocations, multdef-ok rc=0/empty stderr (existing strict overlaps). Honest
RECON 299819/299819 with zero differences/masked mismatches/foreign labels;
vtable audit PASS in 1314 files, whitespace clean. No new function fix/commit.

2026-09-28 AudioCmn_Init source-object cleanup: direct GameSetup_gData.track/
reverseTrack loads preserve the retail head schedule with no setup pointer
or empty identity asm. Inline the ambient/mystic global-array addresses in
the indexed byte stores, removing both const snapshots and their private
region. The audio-on guard now emits no extra declaring scopes. Target's
root j/temptrack records and single +0..+110 scope match retail; all 94/94
instructions remain exact. Dropping the existing volatile-only direction
read was 92/94, four diffs; restored, with original qualifier/spelling still
source-review work rather than a proven permanent requirement. Corrected
the file's stale bworld header provenance to its real AUDIOCMN owner. Final
`run-jn3kvw_5`: complete sections/layouts UNCHANGED, ASPSX 524/0, PSYLINK
zero errors, audiocmn 43/48 native CLEAN. Whole-tree 2115 CLEAN / 450 DIRTY,
EXTRA 300 and BLOCKS 371 affected functions. No new object/name, asm/volatile,
fence, compiler flag or output rewrite. Full SLD/source spelling remains
unsealed; source/evidence changes are local and uncommitted.
Fresh 526-object link, no undefined/truncated relocations, multdef-ok rc=0/
empty stderr (existing strict overlap diagnostics). Honest RECON 299819/299819,
zero differences/masked mismatches/foreign labels; vtable audit PASS across
1314 files and whitespace check clean.

2026-09-28 AudioCmn_CheckState guarded ownership: opponents in the first
checkpoint body belongs at depth3, not a private depth4 block. The changed-
lap/non-arrested compound guard owns r/saidplayer/opponents at depth3 and
all subsequent lap bookkeeping; unchanged/arrested paths still skip those
stores, preserving the old early-return behavior. The second position is
inside the opponents guard, and phrase belongs to the depth9 time-phrase
else arm, not its outer lap test. Replace LAB_800774e0's early skip with an
ordinary else-if; no semantic label replaces it. Typed carFlags members
also replace two raw +0x260 pointer accesses. Final `run-ymynmshu`:
415/415 PASS, complete sections/layouts UNCHANGED, ASPSX 524/0, PSYLINK
zero errors, audiocmn 44/48 native CLEAN. Target locals/types/homes/order
and all13 scopes agree. Whole-tree 2116 CLEAN / 449 DIRTY; SCOPE194 and
BLOCKS370 affected functions. No new object/name/alias, asm/volatile/fence,
flag or output rewrite. Literal original spelling/full SLD attribution
remain unsealed; source/evidence changes local/uncommitted.
Fresh 526-object link, multdef-ok rc=0/empty stderr, no undefined/truncated
relocations (existing strict overlaps). Honest RECON 299819/299819 with zero
differences/masked mismatches/foreign labels; vtable audit PASS in 1314 files,
whitespace check clean.

2026-09-28 AudioCmn_SFX partial ownership: tempAmp belongs to the selected
0x1f impact arm at depth5, not the outer negative-player body at depth3.
Move its declaration there, and place ChooseImpactSample's assignment in
the arm's condition so its binding region starts at the call. All 224/224
instructions remain exact. A nested car-type guard putting c at depth9
was 8 diffs at 224/224 (first load v1 versus retail s0 and a new copy);
fully reverted, so c still needs recovery. A clamp statement-expression
returning to tweakedForce was 8 at 226/224 and was reverted. Deleting the
two existing force-reference fences was 68 at 224/224 and was reverted;
all four old ref devices remain explicitly unresolved, not source proof or
a permanent compiler floor. Final `run-oigaq_3k`: complete sections/layouts
UNCHANGED, ASPSX 524/0, PSYLINK zero errors, audiocmn 44/48 native CLEAN.
Target now only SCOPE c depth7 versus9 and BLOCKS10 versus12; tempAmp's
depth/type/home match, exact region endpoints remain in the open block issue.
Whole-tree 2116 CLEAN / 449 DIRTY. No new name/object, asm/volatile/fence,
flag or output rewrite retained. Full source/SLD goal active; uncommitted.
Fresh 526-object GNU link, no undefined/truncated relocations, multdef-ok
rc=0/empty stderr (existing strict overlaps). Honest RECON 299819/299819,
zero differences/masked mismatches/foreign labels; vtable audit PASS in
1314 files and whitespace check clean.

2026-09-28 AudioCmn_SoundCar region cleanup: root-declare the existing
distanceScale/roadProduct intermediates and remove their artificial private
regions. All recorded local/type/home/order contracts and retail's two-scope
tree (root plus final gas region) agree; native target issues now only EXTRA
attenuation/distanceScale/roadProduct/scaledAmplitude. tunnelFlag/rpmRatio
still require source-only review even though optimized out of native rows.
Direct gas scaling in two source steps was 14 diffs at 530/530; one fused
division was 92 at 530/530. Direct tuntrig in the existing fence/condition
was 23 at 531/530, with spill offsets changed. All failed variants were
reverted; no source-object necessity or source floor is proved. Final full
`run-o1l0rl6j`: 530/530 PASS, complete sections/layouts UNCHANGED, ASPSX
524/0, PSYLINK zero errors; audiocmn 44/48 native CLEAN. Whole-tree stays
2116 CLEAN / 449 DIRTY, BLOCKS369 affected functions. No new object/name,
asm/volatile/fence/flag/output rewrite retained. Existing qualifier/device
and literal original source/SLD requirements remain open; uncommitted.
Fresh 526-object GNU link, multdef-ok rc=0/empty stderr, no undefined/
truncated relocations (existing strict overlaps). Honest RECON 299819/299819,
zero differences/masked mismatches/foreign labels; vtable audit PASS across
1314 files and whitespace check clean.

2026-09-28 AudioCmn_Reset empty-region restoration: retail's missing pair is
the final threshold-test region +2d0..+318 and fallback gettick region
+310..+318, both with no named locals. A fallback-only GNU expression gives
19 scopes (one extra), while an expression around the whole if gives17
(one missing). A conditional expression within the outer expression region,
with the real zero-level/volume side effects sequenced in its true arm and
the gettick expression region in its false arm, exactly reproduces all18
retail scopes without adding a dummy variable, name, alias or fake use.
All 214/214 instructions remain exact. This is a verified name-free source
representation, not proof of the literal original macro syntax; that remains
explicit source-review/SLD work. Final `run-omjds8lr`: complete sections/
layouts UNCHANGED, ASPSX 524/0, PSYLINK zero errors, audiocmn45/48 native
CLEAN. Target frame, locals/types/homes/depths/order/scopes agree. Whole-tree
2117 CLEAN / 448 DIRTY; BLOCKS368 affected functions. No asm/volatile,
compiler flag or output rewrite added. Local/uncommitted, full goal active.
Fresh 526-object link, zero undefined/truncated relocations, multdef-ok rc=0/
empty stderr (existing strict overlaps). Honest RECON 299819/299819, zero
differences/masked mismatches/foreign labels; vtable audit PASS across 1314
files and whitespace check clean.

2026-09-28 AudioCmn_PlaySFX two-base cleanup: the real bank lookup storage
is int[71]. `(u_char)gBankNumLookupTable[sndPlayer]` keeps the retail byte
load without the separate lookup byte-view base. bankNum's existing
cross-version-supported role remains (folding it too was38 diffs at316/316
and was reverted). Direct gaChannel indexed reads in the final pitch calls
remove bbase. Target remains316/316 PASS with complete object bytes/layouts
UNCHANGED. Direct chbase integer sums in either order or typed channel address
were8 diffs at316/316; stereo pbase removal4; direct final returns5 at317/316;
inlined bank flag (boolean or int conditional)6 at316/316. All failed forms
fully reverted. Final `run-5k7ikfpk`: ASPSX524/0, PSYLINK zero errors,
audiocmn45/48 native CLEAN. PlaySFX remaining native extras chbase/nbase/pan/
pbase/pch/r/slot; iPartial's home and scope tree remain unresolved. No new
name/object, asm/volatile/fence/flag/output rewrite retained; existing devices
and unrecorded source-only names still require review even when debug-elided.
Whole-tree stays2117 CLEAN /448 DIRTY; full source/SLD goal active, uncommitted.
Fresh526-object GNU link, no undefined/truncated relocations, multdef-ok rc=0/
empty stderr (existing strict overlaps). Honest RECON299819/299819, zero
differences/masked mismatches/foreign labels; vtable audit PASS in1314 files,
whitespace clean.

2026-09-28 PlaySFX pan web cleanup: replace pan's assignment funnel with
the same unsigned selection directly in SNDpan's second argument, cast to
int before the right shift. Both selected values are0..65535. At this form,
the pch pointer and pbase base snapshot can also be removed in favor of
gaChannel[sndPlayer].Partial. All three source captures disappear with
316/316 PASS. Branch-local SNDpan calls were17 diffs at319/316 and were
reverted; the direct conditional changes the expression graph where those
duplicated calls did not merge correctly. Final `run-g399av7q`: complete
sections/layouts UNCHANGED, ASPSX524/0, PSYLINK zero errors, audiocmn45/48
native CLEAN. PlaySFX now has only chbase/nbase/r/slot native extras plus
iPartial's wrong home and scope-address/nesting issues. No new name/alias,
asm/volatile/fence/flag/output rewrite. Whole-tree stays2117 CLEAN /448
DIRTY; full source/SLD recovery still active, source/evidence uncommitted.
Fresh526-object link: multdef-ok rc=0/empty stderr, no undefined/truncated
relocations (existing strict overlaps). Honest RECON299819/299819, zero
differences/masked mismatches/foreign labels; vtable audit PASS across1314
files and whitespace clean.

2026-09-28 commit checkpoint: PlaySFX's new-sound arm now indexes gaChannel
directly, removing nbase and its obsolete carrier comment. Detailed target
check remains316/316 PASS. Final whole-TU `run-uc0gp_26`: BYTES UNCHANGED,
ASPSX524 good/0 bad, PSYLINK zero errors, audiocmn45/48 native CLEAN.
PlaySFX remaining native extras are chbase/r/slot, with iPartial home and
scope-address issues still open. Whole-tree2117 CLEAN /448 DIRTY. Fresh
526-object link: multdef-ok rc=0/empty stderr, no undefined or truncated
relocations; strict link retains590 existing overlap diagnostics. Honest
RECON299819/299819 identical, zero masked mismatch bytes/foreign labels;
vtable audit PASS1314 files, whitespace check clean. This checkpoint includes
only drawc.cpp, psyq_prim_macros.h, audiocmn.cpp and this journal; unrelated
staged format documentation and untracked port/build files are excluded.
Native CLEAN is not a full original-source/SLD seal; the main goal remains open.

2026-09-28 post-checkpoint PlaySFX scope/ownership continuation:
The cross-version-supported bankNum declaration now sits at root, as in matched
NFS2 PlaySFX, removing the unsupported lookup-only +148..+178 region. It remains
debug-elided; its literal original NFS4 spelling is not claimed uniquely recovered.
The positive selected-SFX guard with explicit NEWSOUND else preserves the original
branch target and bypasses the later SFXnum reload on mismatched entry.
Final `run-4pvdmtzh`: 316/316 PASS, full-TU BYTES UNCHANGED, ASPSX524/0,
PSYLINK zero errors, audiocmn45/48 native CLEAN. Scope tree now has the exact
root/+178/+1c4 outer prefix, but four scopes vs retail five; the result's +254..+2b8
region remains misplaced and retail's +1c4/+1e0..+234 regions remain absent.
No dummy declaration was introduced to manufacture those empty regions.

Actionable combined experiment (not retained): assign the new-sound result to
root iPartial, use the direct channel test in RECHECK, and put the async flag
directly in the call. This reduces the failed old13-diff/317-word reuse trial
to6 diffs at316 words. With a positive SFX guard, direct gaChannel accesses also
remove chbase/slot and their empty fence at the SAME six-difference stream.
The only mismatch is three flag instructions: retail li/xor in v0 then sltiu
a0,v0,1; trial li/xor in a0 then sltiu a0,a0,1. Narrow casts and opposite integer
conditional spelling are neutral; duplicated conditional calls give21dif/321.
Restoring the old iPartial bank-flag use with the carrier-free guard produces an
80-difference saved-register rotation. All non-PASS candidates were reverted;
the existing slot fence and r remain explicit recovery work, not proven source
objects. Solving the anonymous flag target can unlock the handle name, both
address carriers and the fence together. Full source/SLD goal remains active.
Final regression: fresh526-object link, multdef-ok rc=0/empty stderr, no
undefined/truncated relocations (590 existing strict overlap diagnostics).
Honest RECON299819/299819 identical, zero masked mismatch bytes/foreign labels;
vtable audit PASS1314 files. Source and evidence remain local/uncommitted.

2026-09-28 Newton continuation:18/32 ->23/32 native CLEAN, five corrected
covered functions, all detailed PASS and complete section/layout fingerprints
unchanged. Retail blocks/local/type/home/order records were read directly:
- CopyRoadMatrixToOrientMat and CopyRoadMatrixToShadowMat (53 words each):
  ordinary if/else, not early-return plus a standalone declaring block, restores
  the outer +000 binding and depth3 ori/road or shad/road at +04c..+0cc.
- InitBaseNewtonObj (160): i is owned by the damage-clear/tail region at
  +1dc..+24c, depth2, not function root. An actual block owns that real local
  and following tail stores; no unused declaration, new name or line padding.
- QDUpdateVel (57): inactive early return removes an unsupported outer if
  binding; t1/t2/t3 belong to the sgge branch. This ordinary C++ reproduces
  retail's empty +03c..+03c declaring region and +028..+0cc parent, without
  a manufactured empty statement or GNU expression region.
- CalcDistToClosestPlayerCar (200): merge the far/forced condition and startup
  condition by short-circuit &&, then make oldOptz work the else arm. Far/forced
  alone does NOT skip that work: both conditions must hold for early return.
  All five scopes now agree, oldOptz depth3 and static dummy depth5.
Final source/comment gate `run-4ceidwmp`: BYTES UNCHANGED, ASPSX524 good/0 bad,
PSYLINK zero errors; no new asm, volatile, carrier or compiler-output rewrite.
The five native contracts are CLEAN, but complete statement-line attribution
and literal original spelling are not yet sealed; stale SLD-VERIFIED claims
were removed from all five edited header annotations. Final annotation-only
recheck `run-wtufe2a_` again23/32 CLEAN, full bytes/layouts unchanged,
ASPSX524/0 and PSYLINK zero errors. Full tree2122/443.
Fresh526-object link: multdef-ok rc=0/empty stderr, zero undefined/truncated
relocations,590 existing strict overlap diagnostics. Honest RECON299819/299819,
zero masked mismatches/foreign labels, vtable audit PASS1314 files.
Source/evidence changes remain local and uncommitted; main goal active.

2026-09-28 Newton continuation II:23/32 ->26/32 native CLEAN, three more
retail local/type/home/order/scope contracts restored, all previously PASS:
- CalculateGroundShadowMatrix (221): retain both real r1/r2/r3 copy regions,
  but make the general construction the else arm of the initial orient branch.
  Second copy names now depth4, and all six scope tuples agree. Matched NFS2
  PC source independently uses the same if/else architecture. No copy local
  renamed or manufactured; initial orient path still skips general construction.
- CheckForSpikeBelts (49): inline getter directly tests/returns active_, removing
  its unrecorded active snapshot. Collapse getter/active/slice guards with &&,
  placing real latPos in the depth3 selected-body region +048..+0bc. All five
  scopes agree, including the nameless inline pair. Getter spelling is explicitly
  inferred, not a recovered NFS4 symbol; literal original header spelling remains
  review work. Full-TU check covers its complete consumer set.
- FindGroundElevationAndNormalFast (72): end the first r1/r2/r3 copy region
  before the height guard, then test normal->y (same loaded value; stores and
  guard remain byte-exact). The second r2/r3/r4 copy is now depth4, not5.
  Missing surfaceType was an unused zero placeholder. Restore it to retail's
  real v0=1 wheel-surface value and use it for the four stores. Its correct REG
  record survives with actual uses; the (void) fake use is removed. All five
  scope tuples and original names/types/homes now agree. No new name or fence.
Final comment-cleaned `run-uvjnfiwy`: complete bytes/layouts UNCHANGED,
ASPSX524 good/0 bad, PSYLINK zero errors; no post-compile rewriting.
Whole-tree2125 CLEAN /440 DIRTY; EXTRA299, MISSING120, SCOPE186, BLOCKS360
affected functions. Full SLD statement/line attribution is still unsealed;
stale SLD-VERIFIED claims were removed from these three modified headers.
Fresh526-object link: multdef-ok rc=0/empty stderr, no undefined/truncated
relocations;590 existing strict overlap diagnostics. Honest RECON299819/299819,
zero masked mismatches/foreign labels; vtable audit PASS1314 files, whitespace
clean. Changes remain local/uncommitted. Main exhaustive goal remains active.

2026-09-28 Newton continuation III:26/32 ->28/32 native CLEAN:
- UpdateRoadGeometry (228 words): inactive early return removes two unsupported
  binding levels. i belongs to the for initializer, temp to its body; the high-res
  copy/matrix r1..r6/x1 group owns its own real declaring region at depth6,
  while low-res r1/r2/r3 belong at depth3. All13 native scope tuples now agree.
  Root hiRez/slice and final yaw locals retain retail types/homes/order.
  Full gate `run-p9by44ma` BYTES UNCHANGED, ASPSX524/0, PSYLINK zero errors.
- AddDamageZone (502): the second average/clamp in each of four explicit-zone
  arms belongs to the already-recorded imp, not a new block-local temp.
  Restore actual imp computations/stores; four extra declarations and their
  four extra scopes disappear, without renaming an unrelated carrier or adding
  fake uses. The first average's temp stays in each retail block; the general
  zone arm's separate temp also stays. Reusing the first temp instead lost an
  instruction (19dif/501); a direct repeated-expression clamp was30dif/512,
  so both failed forms were reverted. The recorded imp home is v1 and the
  second quantity also occupies v1; matched code/native evidence supports
  this no-extra-object reconstruction, not uniquely recovered literal text.
  Type arm declaration order is transposeMat/intensity/xMult/yMult/zMult.
  Unused Newton_AddDmgZ_typeSet reconstruction label is gone. Final
  `run-r2ec3c75`: full bytes/layouts UNCHANGED, ASPSX524/0, PSYLINK zero errors,
  Newton28 CLEAN/4 DIRTY. Full SLD statement attribution remains unsealed;
  old SLD-VERIFIED annotations on both edited functions were corrected.
Whole-tree2127 CLEAN/438 DIRTY; EXTRA298, SCOPE185, BLOCKS358 affected
functions. Fresh526-object link: multdef-ok rc=0/empty stderr, no undefined/
truncated relocations;590 existing strict overlap diagnostics. Honest
RECON299819/299819 identical, zero masked mismatch bytes/foreign labels;
vtable audit PASS1314 files and whitespace clean. No new asm/volatile/pin or
compiler-output rewrite. Changes local/uncommitted; exhaustive goal active.

2026-09-28 Newton gravity continuation:28/32 ->29/32 native CLEAN.
ApplyTheLawOfGravity (315 words) uses inactive/scheduler/fast-sim early returns,
removing unsupported outer declaring levels while preserving all branch words.
The orientation selection has its own real enclosing region; collisionPoint
and bounceVel now depth8. k belongs to the for initializer at depth9, and scale
to the high groundVel branch at depth7. All names/types/homes/order agree.
The remaining empty +0a8..+0a8 region corresponds to the actual shadowNormal
copy (retail block line54). A name-free GNU expression around that assignment
restores it without a dummy object or test. This verified representation does
not uniquely recover literal original copy-macro text; source spelling and full
SLD statement mapping remain explicitly open. All15 scope tuples agree.
Final comment-cleaned `run-9e1vupey`: BYTES/layouts UNCHANGED, ASPSX524/0,
PSYLINK zero errors; no new asm/volatile/pin or compiler-output rewrite.
Whole-tree2128 CLEAN/437 DIRTY. Fresh526-object link completed rc=0;
multdef-ok stderr empty, zero undefined/truncated relocations,590 existing
strict overlap diagnostics. Honest measurement rerun after link completion:
RECON299819/299819 identical, zero masked mismatches/foreign labels. Vtable
audit PASS1314 files, whitespace clean. Source/evidence remain uncommitted;
the exhaustive source/SLD goal remains active, not complete.

2026-09-28 Newton undrivable continuation:29/32 ->30/32 native CLEAN.
TestForUndrivableSurfaces remains470/470 PASS. The outer for owns testPoint
at depth3 and check/newTestPoint at depth7. Two real centroid regions own j
and loop-body temp at retail depths16/17 and14/15; they end at loop exit,
BEFORE centroid divisions. Closing after division was byte-exact but both
scope endpoints were60 bytes late. While loops preserve j=0 before the
existing cursor boundary; direct for-initializer variants moved it (four
differences) and were superseded. Both old mechanical loop labels are gone.
Positive aborted==0 and high-impulse guards own impulse/zone at depth9;
the low/aborted paths still return without damage processing. All26 native
scope tuples and recorded local types/homes/order now agree.

With ownership restored, remove quadPt and BOTH empty pointer identity asm
calls. temp=testSimRoadInfo.quadPts[j] was18 differences at468/470, with
struct-anchor reuse and bare8/12/16 offsets. The index-first expression
`temp=*(coorddef*)((j*12)+(int)testSimRoadInfo.quadPts)` at BOTH sites instead
gives470/470 PASS, no pointer carrier, no replacement fence or fake local.
Old NO C SPELLING/SEALED assertions are explicitly historical, not source
evidence. Existing memory-ref fences and the cross-version-supported abort
flag still need source-only review; native CLEAN does not exempt those.
Final comment-cleaned `run-gr0asj2g`: full bytes/layouts UNCHANGED,
ASPSX524/0, PSYLINK zero errors, Newton30 CLEAN/2 DIRTY. Whole-tree2129/436;
EXTRA297, SCOPE183, BLOCKS356 affected functions. Full SLD attribution and
literal original macro spelling remain unsealed. Source/evidence uncommitted;
main exhaustive goal active. No new asm/volatile/pin or output rewriting.
Final regression: fresh526-object link completed, multdef-ok rc=0/empty
stderr, zero undefined/truncated relocations (590 existing strict overlaps).
Post-link honest RECON299819/299819 identical, zero masked mismatches or
foreign labels; vtable audit PASS1314 files, whitespace clean.

2026-09-28 Newton full-ground partial restoration (still DIRTY,905/905 PASS):
- Restore six sibling vector-calculation regions, not nested lifetimes. r1/r2/
  r3 in the first three groups are shifted matrix inputs, not product results;
  scaling appears in the vector stores. This corrects three r3 home mismatches
  while preserving every word. Root declaration order now matches retail.
- Restore enclosing wheelHeight/testSimRoadInfo region and final vector region,
  original declaration order, per-wheel roadNormal/roadCenterPoint/roadSurfaceType
  ownership, and the three real for-initializer i records. The actual low speed
  limit has its own clamp region. All recorded names/types/homes/depths now agree.
- Missing suspension-sum r1/r2/r3/r4 are actual four loaded wheel-acceleration
  terms, not fake declarations: restore their loads/use in count's sum. All four
  REG records return in retail homes at depth5, complete bytes unchanged.
- Two nested real selection regions restore speed/ratio ownership at depths9/13.
  Independent bounce predicates retain retail's global allocation; changing them
  to ordinary else rotated34 words at905/905 and was reverted. Direct wheelAcc
  updates with first-arm continue preserve the shared store, removing newWheelAcc
  plus storeWheelAcc/nextWheel labels. Without continue three differences at906.
  Literal original helper/macro spelling for those regions is not uniquely proved;
  native ownership improvement is not a full source-text/SLD seal.
- Failed and restored: direct wheelHeight.y loses the old height snapshot20dif/
  907; assignment inside the guard25dif/906. Tire-range clamp direct ternary27dif/
  906, bound-first26dif/905. wheelY and five unsupported clamp-result limit names
  remain precise recovery work, not proof distinct source objects were necessary.
Final `run-afqmcjjl`: full-TU bytes/layouts UNCHANGED, ASPSX524/0, PSYLINK
zero errors; Newton30/32 native CLEAN. Target remaining native differences are
EXTRA limit/wheelY and49 vs41 scopes. Whole-tree2129 CLEAN/436 DIRTY;
MISSING119 and SCOPE182 affected functions, down from120/183. Full SLD/statement
attribution remains open. No new asm/volatile/pin or compiler-output rewriting.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, zero undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link honest
RECON299819/299819 identical, zero masked mismatches/foreign labels, vtable audit
PASS1314 files, whitespace clean. Changes local/uncommitted; full goal active.

2026-09-28 Newton post-barrier named-ownership round (still DIRTY,106/106 PASS):
Retail's distRetreat is the pre-clamp signed quotient in v1, not the clamped
attenuation argument in a1. Restore that actual role; existing retreat is now
explicitly the unresolved clamp-result carrier, not a recovered local. Other
recorded locals impactVel/upVec/islandMatrix belong to the depth2 +000..+128
region, with barrierVec at root. Those original names/types/homes/depths/order
now agree; only11 EXTRA carriers and3 scopes vs2 remain in native comparison.
Stale SLD-VERIFIED and retreat-role assertions corrected; full source/SLD open.
Failed and restored: live conditional clamp in the attenuation call79dif/103
vs106; deleting early reorg boundary8dif/106; dot accumulation through dsum
without p1 capture26dif/106. These trials prove no source-object necessity.
No failed edit survives, no replacement asm/volatile/pin or output rewrite.
Final comment-cleaned `run-522veaof`: full bytes/layouts UNCHANGED, ASPSX524/0,
PSYLINK zero errors, Newton30/32 native CLEAN. Whole-tree2129/436; MOVED36
and SCOPE181 affected functions, down from37/182. No completion claim.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, zero undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link honest
RECON299819/299819 identical, zero masked mismatches/foreign labels; vtable audit
PASS1314 files and whitespace clean. Source/evidence local/uncommitted, goal active.

2026-09-28 scheduler/track native ownership round:three additional CLEAN
functions, all detailed PASS and complete compiled sections/layouts unchanged.
- Sched_ExecuteCheck (77): distanceIndex/mask belong to the late-game guard
  at depth3; index stays root. Fallback is the else arm, extending the outer
  binding to +12c rather than ending at +100. Final schedule `run-zkz9k_9_`:
  native6/6 CLEAN, ASPSX524/0, PSYLINK zero errors.
- CalcObjectBoundingSphere (152): center-average/radius calculation owns the
  +0c0..+1f8 region, including the second point loop. Its diff now depth5,
  all9 scope tuples agree; no dummy name or extra operation.
- SaveSurface::RestoreAll (27): i belongs to the actual restore/count-clear
  region at depth2, +000..+064, not function root. All records agree.
Final track `run-pkc6eysf`: native19/29 CLEAN (up from17/29), full bytes/layouts
unchanged, ASPSX524/0, PSYLINK zero errors. Full SLD attribution and literal
original region/helper spelling remain open; old SLD-VERIFIED claims corrected.

CalcObjDefPtrs stays unresolved/PASS25. Its loop has three extra GetData
inline pairs absent from retail. Direct payload pointer or equivalent Group
word indexing is8 differences/25: ours anchors base+4 with0/4 load/store
offsets, retail base+8 with-4/0. Compound store sixdif/25; explicit index-first
integer addresses28dif/29. No differing reference overwritten, all failed
forms restored. These are source-basin results, not a source-impossibility floor.
Whole-tree2132 CLEAN/433 DIRTY, SCOPE178/BLOCKS353 affected functions. No new
asm/volatile/pin, synthetic carrier or compiler-output rewriting.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, no undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link honest
RECON299819/299819 identical, zero masked mismatches/foreign labels; vtable
audit PASS1314 files, whitespace clean. Source/evidence remain local/uncommitted.
Main exhaustive source/SLD goal is active, not complete.

2026-09-28 track shape-loader ownership round (still DIRTY,211/211 PASS):
LoadShapesAndMakePmx main for(i=0;...;i++) owns name/tempclut at depth3.
Null-shape continue removes unsupported declaring levels without changing
the branch or pmx increment behavior. Both inner palette/mipmap j names
belong to their for initializers. palnum/icode now depth5, both j records
match their retail scopes, and all19 native scope tuples agree. No new name,
asm/volatile/pin or compiler-output rewrite; root induction multiPalCount
is debug-elided and remains original-spelling review, not a full seal.
Only emptyPalNum remains EXTRA. Literal store after scope restoration is
two differences at211/211: do/while, local for initializer, and typed
index-first palette address all move li a0,-1 relative to li v1,127. All
non-PASS forms restored; the existing snapshot is explicitly unresolved,
not proven distinct source storage and not excused by a generic exemption.
Final `run-x2jly2yp`: full bytes/layouts UNCHANGED, ASPSX524/0, PSYLINK
zero errors. Track19/29 native CLEAN, whole-tree2132/433. SCOPE177 and
BLOCKS352 affected functions (down from178/353); complete SLD attribution
and original macro spelling remain open. Stale SLD-VERIFIED header corrected.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, no undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link
honest RECON299819/299819 identical, zero masked mismatches/foreign labels;
vtable audit PASS1314 files and whitespace clean. Source/evidence local and
uncommitted; exhaustive main goal remains active, not complete.

2026-09-28 material/object precision ownership round: Track_AssociateSingleMaterial
native CLEAN/91 PASS; Track20/29 native CLEAN (up from19/29).
Retail records TWO separate shapeIndex locals in the UV processing and direct
arms, both at depth5/a0. Root shared shapeIndex was incomplete. Restore both
actual declarations/uses, originalPmx only in the processing arm, and root
animCount. Ordinary for loop removes TrkAssoc_loopTest; all6 scope tuples and
recorded names/types/homes/order agree. Old generic-name exemption paragraph
removed, obsolete compiler version annotation corrected. Full SLD remains open.

ReduceObjectPrecision stays DIRTY/40 PASS: inactive early return removes
unsupported outer bindings, puts inline GetNumElements receiver at depth2 and
objDef at depth4. Its real nested count/pts region owns those locals at depth5,
in retail declaration order. All8 scope tuples and recorded names/homes agree.
Only EXTRA x/y/z remain. Direct member shifts37dif/41, direct halfword indexing
42dif/40: all non-PASS forms restored, no unsupported const alias or substitute
carrier introduced. Those captures remain recovery work, not proven source
objects. Existing CCOORD16 signed-short fields verified against raw lh/srav/sh.
Final comment-cleaned `run-jp68azkb`: full-TU bytes/layouts UNCHANGED,
ASPSX524/0, PSYLINK zero errors. Whole-tree2133 CLEAN/432 DIRTY; MISSING118,
SCOPE175, BLOCKS350 affected functions. Full source/SLD goal remains active.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, zero undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link honest
RECON299819/299819 identical, zero masked mismatches/foreign labels; vtable
audit PASS1314 files and whitespace clean. No new asm/volatile/pin or output
rewriting. Source/evidence local/uncommitted; no full original-source seal claimed.

2026-09-28 track object-kill loader: native CLEAN/86 PASS; Track21/29 CLEAN.
Retail orders inst's GetData receiver at depth6, then bounds-check receiver
at depth7, followed by index/simGroup at depth6. Source had GetNumElements
before GetData inside a positive bounds owner, putting descendants two levels
too deep. GetData first plus objInd>=GetNumElements continue restores all19
scope tuples, all original names/types/homes/order, and all86 words. A merged
positive guard was byte-exact but receiver depths/order still disagreed;
the final earlier getter/continue spelling satisfies the full native contract.
Null group and invalid index still skip processing; file purge remains common.
No synthetic block/local, asm/volatile/pin, or compiler-output rewrite added.
Full statement-line attribution and literal original spelling remain open;
stale SLD-VERIFIED annotation and wrong accessor-order comment corrected.
Track_AnimateTextures standard while and while(true)/break trials both55dif/
105 versus102, including constant hoists and register rotation. Both restored;
the existing102-word PASS and its precise carrier/scope queue remain unchanged.
Final `run-dhawczuj`: complete bytes/layouts UNCHANGED, ASPSX524/0, PSYLINK
zero errors. Whole-tree2134 CLEAN/431 DIRTY; SCOPE174/BLOCKS349 affected
functions. Fresh526-object link completed: multdef-ok rc=0/empty stderr, zero
undefined/truncated relocations;590 existing strict overlap diagnostics.
Post-link honest RECON299819/299819 identical, zero masked mismatches/foreign
labels; vtable audit PASS1314 files, whitespace clean. Changes local/uncommitted;
full original-source/SLD goal remains active, not complete.

2026-09-28 track material-link receiver restoration: native CLEAN/241 PASS.
Track_LinkMaterials mats must use SerializedGroup::GetData, not bare group+1.
The real member expansion restores missing this REG:$4 at depth4 and its
two empty +034 scope regions. All21 scope tuples, recorded local names/types/
homes/order agree, with all241 words unchanged. Track22/29 native CLEAN.
Track_InitPersistentData declaration order is now persistentGroups/count,
still119/119 PASS. Its one missing receiver and nine absent regions remain
open. Case2 raw proves m_length-16 for the payload length, but surviving SYM
and inspected PC-beta headers provide no accessor spelling. No guessed getter
or fake use was added merely to match empty scopes. Original case-wrapper
source and complete SLD attribution require further reference investigation.
Final comment-cleaned `run-y403ul1q`: full bytes/layouts UNCHANGED, ASPSX524/0,
PSYLINK zero errors; no new asm/volatile/pin or output rewriting. Stale
SLD-VERIFIED annotations corrected on both edited functions. Whole-tree
2135 CLEAN/430 DIRTY; MISSING117 and BLOCKS348 affected functions.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, zero undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link honest
RECON299819/299819 identical, zero masked mismatches/foreign labels; vtable
audit PASS1314 files, whitespace clean. Changes remain local/uncommitted;
the exhaustive original-source/SLD goal remains active, not complete.

2026-09-28 renderer startup: R3DCar_StartUp native CLEAN/52 PASS.
Its filename buffer belongs to the license-path/load region at depth2,
not root. Full scope tuple +06c..+06c and all recorded locals now agree.
Remove fake if(0) allocator call that existed only to retain SimpleMem.
The project's existing unused-inline class-tag representation retains the
same literal without inventing an allocator operation. All compiled sections
and layouts stay unchanged, including .rodata. Literal original header
spelling/full SLD remain unsealed; root file's wrong module/function-count
and whole-SYM-applied claim corrected. Final `run-uwi7t_9q`: R3DCar15/27
native CLEAN, BYTES UNCHANGED, ASPSX524/0, PSYLINK zero errors.

Souffle pre-edit guard stopped at `run-btk38ke0`; no source edit or differing
reference overwrite. Independent read-only comparison proves old reference
equals fresh sections except its missing10-byte SimpleMem\0 .rodata tag.
Raw rom/nfs4-f.exe at0x800565D8 confirms that tag, and all10 fresh detailed
Souffle functions PASS (18/14/16/120/295/24/59/16/7/10 words). Its baseline
is stale, not evidence of a code regression. Asked user before reference-only
backup/refresh; pending decision. Keep old baseline intact meanwhile.
MaintainAvailableCops remains ORDER-only unresolved. Initial declaration swap
and normal increment spelling did not fix it. Reusing second-loop playLoop
in third loop fails ordinary lexical scope; initializing it to0 preserves
162 words but introduces a third debug playLoop. All neutral/failed trials
restored; aih_play source content unchanged. Fresh `run-zewod0q9` again
BYTES UNCHANGED, ASPSX524/0, PSYLINK zero errors,2/9 native CLEAN.
Whole-tree2136 CLEAN/429 DIRTY; SCOPE173/BLOCKS347 affected functions.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, no undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link
honest RECON299819/299819 identical, zero masked mismatches/foreign labels;
vtable audit PASS1314 files, whitespace clean. No new asm/volatile/pin or
compiler-output rewriting; changes local/uncommitted. Full source/SLD goal active.

2026-09-28 renderer filename/menu-release round:
- GetCarName remains37 PASS. Real index is owned only by the cop-country
  guard at depth3, +04c..+07c; all three scope tuples and recorded locals now
  agree. Only copIdx remains EXTRA. Mutating carType before sprintf then
  undoing for its name argument11dif/38; after sprintf13dif/38. Both restored,
  no replacement alias/const qualifier added. This is not a source-object floor.
- DeInstantiate3DCarMenu native CLEAN/80 PASS. countryFlag belongs to valid
  current-car arm, status to pending-read arm, both depth3. Separate successful
  status guard owns bigFile at depth5, then its null guard purges it. Calls and
  invalid/pending paths remain byte-exact; all7 scope tuples and original
  names/types/homes/order agree. R3DCar16/27 native CLEAN (up from15/27).
Final comment-cleaned `run-l6hjzlk_`: complete bytes/layouts UNCHANGED,
ASPSX524/0, PSYLINK zero errors. Stale SLD-VERIFIED claims corrected; literal
original spelling/full statement-line attribution remain unsealed.
Whole-tree2137 CLEAN/428 DIRTY; SCOPE171/BLOCKS345 affected functions.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, zero undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link
honest RECON299819/299819 identical, zero masked mismatches/foreign labels;
vtable audit PASS1314 files and whitespace clean. No new asm/volatile/pin or
compiler-output rewriting. Source/evidence local/uncommitted, full goal active.
Souffle baseline remains unchanged pending the previously requested decision.

2026-09-28 renderer restart: native CLEAN/30 PASS, all FIVE old captures
removed (ppCVar3/numCars/gsData/headOn/brakeOn), no replacement alias.
Real for/body ownership puts carObj at depth3. For plus pointer walker was
12dif/30 a0/a1 swap; indexed Cars_gList[i] fixes the swap, leaving only i
initialization order (two differences). Restore initialization before the
captured preheader; later retire both light constants jointly (literal stores
are30 PASS), then direct GameSetup.Time and finally direct Cars_gNumCars also
become30 PASS. Initial direct count alone was4dif/30 and direct Time12dif/30;
those results were basin-specific, not source-object requirements. With all
captures gone, ordinary for(i=0;...) is again30 PASS and restores genuine
loop statement grouping. R3DRestart_loopTop and obsolete carrier assertions
gone. Final source `run-1al493qs`: full sections/layouts UNCHANGED, ASPSX524/0,
PSYLINK zero errors; R3DCar17/27 native CLEAN. All3 native scope tuples and
recorded names/types/homes/order agree. No new asm/volatile/pin or output rewrite.

SLD diagnostic repair: sldprobe's old header heuristic used the first code
statement/prologue, not the function's pre-.ent .loc header; this shifts all
relative tags. Corrected capture/comment with backup
scratchpad/sldprobe_before_header_20260928.py. All27 renderer header anchors
agree with the independently emitted full-debug SYM, py_compile passes.
Actual native dump versus retail SLD comparison for Restart confirms17/30
remaining instruction-line differences;13 tags agree, including initialization,
whole preheader and car pointer load. Not an SLD seal. No #line or source-line
padding introduced, no byte verifier behavior relaxed. Literal original layout/
statement formatting remains review work. Whole-tree2138 CLEAN/427 DIRTY;
EXTRA296, SCOPE170, BLOCKS344 affected functions. Full source/SLD goal active.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, zero undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link honest
RECON299819/299819 identical, zero masked mismatches/foreign labels; vtable
audit PASS1314 files and whitespace clean. Source/tool/evidence local/uncommitted.

2026-09-28 texture-menu selected-pointer removal (still DIRTY,211 PASS):
ReadInCarTextureMenu's sfp object and its extra +1f8 region are unnecessary.
Use the actual dereference directly with base-first integer address arithmetic:
`*(char **)((int)sfBase+(index<<2))`. It preserves the original addu operand
order with all211 words unchanged, where the earlier ordinary base+index
pointer form had two differences. All4 scope tuples and recorded local
names/types/homes/order now agree; only EXTRA sfBase remains. No new alias,
const/volatile qualifier, asm operand or compiler-output rewrite added.
Direct stack-array base12dif/209; indexed optional-file load/postincrement
24dif/209. Both restored. A temporary misplaced declaration during restoration
was removed immediately; complete-TU byte gate confirms no collateral change.
sfBase still requires original-source investigation, not a generic exemption
or assertion that an original object was necessary. Stale combined carrier
and SLD-VERIFIED comments corrected. Full SLD attribution remains unsealed.
Final `run-pi2_sy0_`: full bytes/layouts UNCHANGED, ASPSX524/0, PSYLINK zero
errors; R3DCar17/27 native CLEAN. Whole-tree2138/427; BLOCKS343 affected
functions (down from344), native count alone not a source-completion seal.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, zero undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link honest
RECON299819/299819 identical, zero masked mismatches/foreign labels; vtable
audit PASS1314 files and whitespace clean. Source/evidence local/uncommitted;
the full goal remains active. Souffle baseline still unchanged pending decision.

2026-09-28 renderer geometry reader: native CLEAN/322 PASS.
ReadInCarData carType/eScaleX/eScaleY belong to the whole geometry region at
depth2, not root; object for loop owns Nobj at depth4. R3DCar_objects_done
label removed. Normal generation is a separate numVertex/object-flag/carType
guard AFTER vertex allocation, not nested within it. Its actual shared region
owns j/tx/ty/tz at depth7 in retail order; the inner for uses that j and its
body owns vt/nm/nm_vx at depth9. All9 scope tuples and all recorded original
names/types/homes/order now agree, with every322 word unchanged. No new
carrier, helper name, fake use, asm/volatile/pin or output rewrite added.
Final comment-cleaned `run-q4xjrq_x`: full bytes/layouts UNCHANGED,
ASPSX524/0, PSYLINK zero errors, R3DCar18/27 native CLEAN.
Direct actual native/retail SLD comparison still310/322 instruction-line
differences. Retail object-loop block starts at source relative71, normal
processing at145, translation/normal iteration region at219. Missing source
formatting/comment/conditional/template context cannot be identified uniquely
from those line spans alone; investigate references, do not manufacture dead
code or line padding. This native-contract result is NOT a full SLD/source seal.
Whole-tree2139 CLEAN/426 DIRTY; SCOPE169, ORDER2, BLOCKS342 affected functions.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, zero undefined/
truncated relocations;590 existing strict overlap diagnostics. Post-link honest
RECON299819/299819 identical, zero masked mismatches/foreign labels; vtable
audit PASS1314 files, whitespace clean. Source/evidence local/uncommitted;
the exhaustive full goal remains active, not complete.

2026-09-28 VLA terminal-cleanup ownership round:
InsertAllListFacet native CLEAN/301 PASS: explicit terminal return created
an extra empty +480..+480 cleanup region after the final car loop. Implicit
void fallthrough removes that unsupported region, preserving every301 word
and dynamic-stack restoration. All17 scope tuples and recorded names/types/
homes/order now agree; no local/operation added. Final `run-dwldyeaa`:
R3DCar19/27 native CLEAN, complete bytes/layouts UNCHANGED, ASPSX524/0,
PSYLINK zero errors. Full source/SLD statement attribution remains open.
The same explicit-return pattern explains Track_InitPersistentData's unwanted
+1b4 terminal region. Remove its final return, still119/119 PASS and full
sections/layouts unchanged (`run-g21eemkr`, ASPSX524/0, PSYLINK zero errors).
It now has12 actual regions vs22 retail, rather than13 including a spurious
terminal region; missing inline/accessor context is still explicit backlog.
No missing region was fabricated, no source padding/new helper name or
generic exemption introduced. Track22/29 native CLEAN remains unchanged.
Whole-tree2140 CLEAN/425 DIRTY, BLOCKS341 affected functions. No new
asm/volatile/pin or compiler-output rewriting; stale renderer SLD-VERIFIED
annotation corrected. Fresh526-object link completed: multdef-ok rc=0/empty
stderr, zero undefined/truncated relocations;590 existing strict overlaps.
Post-link honest RECON299819/299819 identical, zero masked mismatches/foreign
labels; vtable audit PASS1314 files, whitespace clean. Source/evidence local
and uncommitted; exhaustive full goal active, not complete.

2026-09-28 primitive-emitter ownership/role round:two additional native CLEAN,
R3DCar21/27 native CLEAN (up from19/27), both detailed PASS:
- InsertCarFacetMenuII266: failed PrimStart is an early return inside the
  valid-detail arm, not another positive owning level. This restores every
  original loop/facet/cop local's depth and all14 scope tuples, with the same
  failure path and every instruction unchanged. Obsolete priority-fence comment
  corrected: no such source device remains at that site.
- InsertCarFacetII379: negative-detail and negative-worldZ setup checks are
  early returns. Remove four unsupported owning levels, restoring all12 scope
  tuples and original object/facet/clip/cop ownership. Missing inAir is the real
  wheel-flag OR used by its zero test, not an optimized-away night constant;
  reflect's night -1 is assigned directly only in the commMode1 arm. Missing
  light is the masked packed QuadLight value stored on the car, not a discarded
  full call return. Real computations/uses restore both REG:$2 records without
  fake use or storage. All recorded names/types/homes/order now agree.
Final comment-cleaned `run-okr4gaky`: full-TU bytes/layouts UNCHANGED,
ASPSX524/0, PSYLINK zero errors. Whole-tree2142 CLEAN/423 DIRTY; MISSING116,
SCOPE167, BLOCKS339 affected functions. Literal original/complete SLD remains
unsealed; stale SLD-VERIFIED annotations corrected. No new carrier/helper name,
asm/volatile/pin or compiler-output rewrite. Fresh526-object link completed:
multdef-ok rc=0/empty stderr, zero undefined/truncated relocations;590 existing
strict overlaps. Post-link honest RECON299819/299819 identical, zero masked
mismatches/foreign labels; vtable audit PASS1314 files and whitespace clean.
Source/evidence local/uncommitted, full source/SLD goal remains active.

2026-09-28 instantiation source-only handoff round (still DIRTY,520 PASS):
Root original declaration order restored: filename/workFile/bigname/reload/
carType. Remove the unrecorded scaledIndex and finalIndex handoffs. Actual
`index=((index*3)<<3)-(-index)` preserves retail's operand order and all520
instructions; simple addition had previously reversed two operands. The
negated operand is safe in int: index originates from signed-short color>>3,
so cannot be INT_MIN. No new object, const qualifier or fake use introduced.
This verifies a no-handoff representation, not unique original expression text.
Five native extras and15 vs13 regions still remain; native-clean count unchanged.
Failed/restored: direct VRAM global addressing and base-first grouping both
14dif/520; remove colorTypeOffset plus its old reference device8dif/520;
index-first form6dif/520; reversed comparison8dif/520. Restore the original
device exactly, no substitute or additional operand. Existing loadedSceneColor/
VRam and pressure-device comments now explicitly queue unknown original storage,
not generic exemptions. Stale SLD-VERIFIED annotation corrected; full SLD open.
Final comment-cleaned `run-_yjkozk1`: complete bytes/layouts UNCHANGED, ASPSX524/0, PSYLINK
zero errors, R3DCar21/27 native CLEAN, whole-tree2142/423. Source-only progress
must not be hidden by unchanged native counts. Fresh526-object link completed:
multdef-ok rc=0/empty stderr, zero undefined/truncated relocations;590 existing
strict overlaps. Post-link honest RECON299819/299819 identical, zero masked
mismatches/foreign labels; vtable audit PASS1314 files, whitespace clean.
Source/evidence local/uncommitted; full source/SLD goal active, not complete.

2026-09-28 visibility coordinate ownership round (still DIRTY,234 PASS):
R3DCar_Visibilty x/z own only the corner construction, not the subsequent
corner tests/common rejection label. Close their actual region before that
test: +2d0..+2d0 now matches retail, formerly ended at+374. All recorded
names/types/homes remain unchanged; modeOne's seven extra regions are still
explicit unresolved source work. No source variable/qualifier/fake use added.
Failed/restored: direct1 plus no mode identity2dif/234 (addu s5,v1,zero vs
li s5,1), flag-before-mask same2dif/234; comparison-assigned inCarCam11dif/
235; dropping older maxMax/carObj reference82dif/234. These are priced
counterexamples, not proof original devices/objects were necessary. Existing
identity and reference operands restored exactly, no replacements added.
Final `run-3xbuw3v9`: full bytes/layouts UNCHANGED, ASPSX524/0, PSYLINK zero
errors, R3DCar21/27 native CLEAN, whole-tree2142/423. Source-only ownership
progress must not be misrepresented as a full-clean function; full SLD and
original mode-source construction remain open, stale SLD-VERIFIED annotation
corrected. Fresh526-object link completed: multdef-ok rc=0/empty stderr,
zero undefined/truncated relocations;590 existing strict overlaps. Post-link
honest RECON299819/299819 identical, zero masked mismatches/foreign labels;
vtable audit PASS1314 files and whitespace clean. Source/evidence local and
uncommitted; full goal active. Souffle baseline remains untouched pending decision.

2026-09-28 human-control gear ownership round (still DIRTY,288 PASS):
Control_Human newGear belongs only to the post-event gear selection region
at depth2, +428..+470, not function root. Restore its actual declaration/use
region; all original names/types/homes/depths agree. Two light-event regions
remain missing (six vs eight scopes); no dummy region or helper was invented.
Debug-elided lights capture remains original-source work. Direct field shifts/
reads and fused ^=3 store/test both17dif/289 vs288; restored. Queue comment
states those trials establish no distinct source-object necessity, no generic
exemption. No new name/qualifier, asm/fake use or compiler-output rewrite.
Final `run-ffq96g0f`: full bytes/layouts UNCHANGED, ASPSX524/0, PSYLINK zero
errors; control1/2 native CLEAN. Whole-tree2142/423 unchanged, SCOPE166
affected functions (down from167). Full SLD/light-inline spelling still open.

Trigger-SFX pre-edit guard `run-n17ecvhn` found another stale baseline:
read-only snapshot comparison equals the reference except the omitted10-byte
SimpleMem\0 .rodata tag. Raw rom/nfs4-f.exe at0x80056724 confirms that tag.
No TrgSfx source edit or reference overwrite; the same diagnosis as Souffle
does not authorize an unrequested baseline replacement. Preserve old data
until an appropriate refresh decision. This is no code-regression claim.
Fresh526-object link completed: multdef-ok rc=0/empty stderr, no undefined/
truncated relocations;590 existing strict overlaps. Post-link honest
RECON299819/299819 identical, zero masked mismatches/foreign labels;
vtable audit PASS1314 files, whitespace clean. Source/evidence local and
uncommitted; the full source/SLD goal remains active, not complete.

2026-09-28 physics continuation, diagnostic baseline (no function edit yet).
Fresh immutable-reference check passed; detailed RampCarControlValues is
502/502 PASS. Full TU gate `run-k9d6yrvn`: complete sections/layouts UNCHANGED,
ASPSX 524 good/0 bad, PSYLINK zero errors, physics 10/22 native CLEAN.
The earlier root comment's "Full SYM-locals applied" is not a completion proof:
12 covered physics functions still have concrete native discrepancies.

RampCarControlValues's missing ownership is now tied to cross-version source,
not an arbitrary brace-count nudge. Matched NFS2 PC beta
`match/physics/Physics_RampCarControlValues.c` owns normal ramping in the
finish-state ELSE arm. Retail NFS4 has the corresponding enclosing +044..+528
and ELSE +0d8..+528 regions; the current jump-to-earlyBrake spelling omits both.
The actual gas calculation region owns inc at depth4 (ours2), and steering's
guarded calculation owns rampIn at depth5 (ours3). Raw retail branches from
the finished-car velocity decay directly to +528, confirming that the normal
ramp/gear/steering phase is skipped but the shared early-brake tail still runs.
Next source experiment: restore that real if/else ownership, remove the unused
setSteering label, then reprice the brake/steering calculation regions. Preserve
the shared tail and check +158..+198 and +4d8..+51c before claiming eight exact
retail scopes; do not add fake locals merely to force empty debug regions.

Independent full-g native-SYM versus retail per-word relative SLD baseline is
496/502 differences (actual pre-.ent header anchors, not first-instruction
heuristics). Scope boundary source tags also differ: +044 retail23/ours9,
+0d8 42/23, +4d8 171/147, +528 184/173. This is explicit remaining source-order/
ownership evidence, NOT an SLD seal and not a justification for line padding.
No source, baseline, compiler output or binary was rewritten in this round.

2026-09-28 physics source round, retained changes after that baseline.
- AutoShift: failed-gear early return removes two unsupported binding levels;
  velocity is now at retail depth2 with the exact +0f8..+180 region. The
  negated-sum spelling already proved at the later upshift guard also works at
  the first gear guard, eliminating lastGearOffset and its generic carrier
  exemption. Both calculations remain distinct/rematerialized; no replacement
  local, asm, volatile, fake use or output rewrite. All175 words PASS and all
  recorded names/types/homes/order plus the two scope tuples are retail-exact.
- RampCarControlValues: normal phase now belongs to the real finish-state
  ELSE, replacing the earlyBrake jump and unused setSteering label. inc and
  rampIn depths/homes match retail. NFS2-supported MIN expressions in steering
  extend its inner region through +51c exactly, not the former +514 endpoint.
  All502 words PASS. Six of eight retail scopes are represented; the empty
  brake selection/calculation pair +140..+1a4 / +158..+198 remains unresolved.
  Do not claim that the whole TU's locals or source text is fully restored.
- Reverted brake experiments: MIN/conditional clamp folded to slti17 instead
  of16 and produced504/502 with14 differences. Void conditional side effects
  with GNU regions preserved502 but closed the inner region at+190 rather
  than+198. Selecting the complete adjusted byte needed explicit void casts
  to avoid a narrowed-value reload (505/502, five differences), yet still
  closed at+190. A value-returning region feeding the common assignment was
  eight differences at502; swapping its outer arms was eleven at503. None of
  these GNU brake representations is retained merely to improve block counts;
  the original ordinary brake statements remain. No invented declaration.

Final comment/indent-cleaned gate `run-0aknr5pu`: full TU sections/layouts
UNCHANGED, ASPSX524/0, PSYLINK zero errors, physics10/22 ->11/22 native CLEAN.
Global native report2143 CLEAN/422 DIRTY; GAME/COMMON1087/160, other directory
counts unchanged. This measures native contracts, not full source/SLD completion.
Actual native-SYM versus retail SLD remains157/175 different in AutoShift and
496/502 in RampCarControlValues; no padding/#line work or full SLD seal claimed.
Fresh real526-object GNU link: strict rc0 with the existing590 overlap warnings;
multdef-ok rc0 with empty stderr, zero undefined names/truncated relocations.
Independent honest RECON299819/299819 identical, zero masked mismatches/foreign
labels; vtable audit PASS1314 files; scoped whitespace check clean.
Retained physics/doc changes are uncommitted after adc9fb10. Backups:
scratchpad/physics_before_ramp_20260928.cpp and physics_after_ramp_20260928.cpp.

2026-09-28 physics continuation: two more native contracts restored and one
unrecorded product capture removed, while preserving every compiled TU byte.
- CalculateRoadGripModifiers95/95: i belongs to an enclosing for binding at
  depth3; roadSurfaceType/tempSurface are body locals at depth4. Ordinary
  enclosing block plus for initializer reproduces the first four scopes.
  The final multiplier calculation and guarded aero contribution are real
  variable-free expression regions, reproducing +0e4..+16c and +128..+16c.
  Their literal lost macro spelling is unknown, not asserted recovered.
  The last real store is explicitly void-valued so this compiler accepts
  the no-op false arm; no dummy object/use or additional asm/volatile.
  All six scope tuples and named type/home/order/depth records are exact.
- AttenuateVelocity279/279: direct builtin-abs expressions in the octagonal
  speed approximation remove x and its declaring block. The formerly cited
  twelve-difference repeat-expression failure was specific to manual abs
  selectors; builtin abs gives the actual retail graph without the capture.
  vel_b declaration now precedes the scalar locals as retail records it.
  All native locals/types/homes/order and the single root scope match.
  vy/vz remain source-only, with independent NFS2 name/value evidence already
  in source; native CLEAN does not by itself prove original NFS4 spelling.
- FixEngineRpm86/86: firstProduct inlines into the first two-term sum despite
  its older 88-word/32-difference necessity claim. It is gone, together with
  obsolete exemptions for nextVelX/nextVelY/nextMatY (already absent objects).
  The remaining transformedZ and pre-existing nine-reference empty fence are
  explicit unresolved source review, NOT a generic exemption or proof of an
  original distinct object. Reverted trials: no fence32/86, direct full sum
  35/87, field-by-field accumulation49/89. The existing fence is restored;
  no replacement device was introduced. Only transformedZ remains EXTRA.

Final comment/format-cleaned full gate `run-vyvw28vi`: complete sections/layouts
UNCHANGED, ASPSX524/0, PSYLINK zero errors, physics13/22 native CLEAN (was11/22).
Global native coverage2145 CLEAN/420 DIRTY; GAME/COMMON1089/158, other directory
counts unchanged. Actual per-word relative native-versus-retail SLD differences
remain248/279 in AttenuateVelocity,91/95 in RoadGripModifiers,86/86 in FixEngineRpm.
Function banners no longer assert SLD verification for these unsealed bodies.
Fresh526-object real GNU link: strict rc0 with the existing590 overlap warnings,
multdef-ok rc0/empty stderr, zero undefined names or truncated relocations.
Independent linked RECON299819/299819 identical, zero masked mismatches/foreign
labels; vtable audit PASS1314 files; scoped whitespace check clean.
All these physics/doc changes remain uncommitted after adc9fb10. Backups:
scratchpad/physics_before_grip_20260928.cpp, physics_after_grip_20260928.cpp,
and physics_before_attenuate_20260928.cpp. Full source/SLD goal remains active.

2026-09-28 RS desired-position value-ownership round (partial native restoration).
Raw v1 holds desLane-7 in the right arm and6-desLane in the left, followed by
the shared multiplication/comparison uses. Those are retail's two laneOffset
records, not the scaled slice-width values previously assigned that name.
Restore both named index-difference objects and remove laneDelta plus its
generic carrier exemption. The former width captures are retained as laneWidth,
an explicitly inferred role from the byte-field read and0x8000 scale, NOT a
recovered original name or an exemption for its source-object necessity.
Each branch's desLane/laneOffset name, type, home, order and depth now agrees.
No asm, volatile, fake read, const-name masking or compiler/output rewrite.

Still active, not a floor: position is recorded in a0, retail v0, and the first
arm closes at+124 instead of retail+11c. Its quantity/return funnel needs actual
source reconstruction; do not simply rename the width or another unrelated
v0 value to position. The width captures' original declaration/macro context
also needs recovery. Direct width expressions were42 differences at112 words;
using position as the width then returning adjusted expressions was39/115;
in-place final negation in that form was33/111. Assigning the final negative
selection to position (split statements, common return, or return-assignment)
was8/112. Moving only the positive return outside the if/else was5/113.
All failing variants reverted; the retained112/112 form is a verified naming/
ownership improvement, not a complete native or SLD seal.

Final full gate `run-4cu6ex5s`: all TU sections/layouts UNCHANGED, ASPSX524/0,
PSYLINK zero errors, physics13/22 native CLEAN. Global2145/420 unchanged;
affected-function EXTRA tally294->293 and MISSING116->115. Actual per-word
relative native-vs-retail SLD still99/112 different in this function.
Fresh526-object real link strict rc0 (existing590 overlap warnings),
multdef-ok rc0/empty stderr; zero undefined names or truncated relocations.
Independent linked RECON299819/299819 identical, no masked mismatches/foreign
labels; vtable audit PASS1314 files. Backup:
scratchpad/physics_before_rsposition_20260928.cpp. Retained edits uncommitted.
The full project source/SLD objective remains active; this entry is evidence
for known work still required, not an assertion that remaining work is unknowable.

2026-09-28 traction/wheel-lock source round, retained value recovery at233/233.
Retail gripLoss is the clamped quotient in v1, not the earlier excess
acceleration kept in s1. Express that excess as totalAcc-roadGrip at its actual
uses, put the quotient/clamp into the existing recorded gripLoss, and use
canonical MIN(roadGrip/divider,excess/divider). Despite textual operand order,
the emitted divisions remain loss-first/road-second, with retail's v0-to-v1
copy. gripLossRatio and gripLossQuotient are removed, along with both existing
read-only fences on those earlier stages. The first operand/reference-fence
removal was independently PASS; quotient/override without the second fence
was four differences at233, and MIN sealed it. All recorded non-parameter
locals now have their correct original names, types, homes, order and depth.

Not sealed: wheel_reg remains unrecorded and the wheel parameter debug home
is a1 instead of retail s0; direct wheel references were90 differences at233
both before and after the MIN landing, unchanged by register on the parameter.
Reusing named gripLoss for the early difference then clamping it was229/236.
Those variants are reverted. roadGripCompare/skidValue plus the two remaining
empty fences and TireType labels still require genuine source recovery.
Do not treat these finite trials as proof that extra source objects were
original, or as generic exemptions. Current source comments state that review.

WheelLock127/127 is restored unchanged in code after unsuccessful source trials:
two direct MIN operand orders40/127 and38/127; field reads after the old
comparison fence3/128; direct ordinary clamp4/127, unchanged by register
roadGrip; inline TireType cap inside MIN29/142; explicit branch stores12/127.
No failing rewrite, neutral register keyword or self-store experiment remains.
Its skid/cmp and original empty identity fence are still active source review,
not a newly proved floor; generic carrier exemptions were replaced by receipts.

Final full gate `run-4kg_ipbh`: complete sections/layouts UNCHANGED, ASPSX524/0,
PSYLINK zero errors, physics13/22 native CLEAN, global2145/420 unchanged.
The traction function remains DIRTY only for its three native extras and wheel
parameter home; the previous gripLoss home mismatch is gone. Actual relative
per-word SLD differences remain225/233 in traction and117/127 in wheel lock.
Fresh526-object GNU link strict rc0 with existing590 overlap warnings,
multdef-ok rc0/empty stderr, zero undefined names or truncated relocations.
Independent linked RECON299819/299819 identical, no masked mismatches or foreign
labels; vtable audit PASS1314 files; scoped whitespace check clean.
Backups: scratchpad/physics_before_lock_20260928.cpp and
physics_before_traction_20260928.cpp. Retained physics/doc work remains
uncommitted after adc9fb10; the full original-source/SLD goal remains active.

2026-09-28 tire-force capture elimination: native CLEAN at346/346 PASS.
Canonical MIN(wheel->velCap.x,abs(latAcc)) and
MAX(wheel->velCap.x,-abs(latAcc)) assigned directly to finalAcc.x match BOTH
front/rear instruction streams, including the shared physical stores. Both
xAcc declarations are removed. The older claim that a memory-target conditional
could never produce the shared store was source-basin-specific, not a law.
Then the COMPLETE nested MIN(MAX(abs(slipAngle),0x8000),0x20000) inside fixedmult
also matches346 exactly, eliminating minSlipAngle and cap, with no replacement
object, alias, fake use, asm or volatile. This shape is independently supported
by matched NFS2 tire-force source. All six extra native scopes disappear; only
retail's root remains. Names/types/homes/order/depth for both params and all four
root locals match. Removed unused storeSkid label; used wheelLock/normalTire
labels now use the independently evidenced NFS2 semantic spellings, not a claim
of uniquely recovered NFS4 label text. Obsolete necessity claims removed from
the live source and superseded here, not kept as generic carrier exemptions.

Reverted interim shapes: reusing latAcc as the rear lower-bound capture was
six schedule differences at346, both before/after the xAcc removal; duplicated
branch-local fixedmult calls16/346; latAcc reused through every cap stage24/348;
front result reuse in latAcc25/347. Their finite failures do not rule out the
complete macro form that subsequently passed. The retained version has NONE
of those substitutions and no temporary diff degradation is left in the tree.

Final comment/label-cleaned full gate `run-fn_pw48a`: all TU sections/layouts
UNCHANGED, ASPSX524/0, PSYLINK zero errors. Physics13/22 ->14/22 native CLEAN;
global2146 CLEAN/419 DIRTY, GAME/COMMON1090/157; other directories unchanged.
Actual relative per-word native-versus-retail SLD remains337/346 different;
no line padding/#line and no full original-text/SLD seal claimed.
Fresh526-object real GNU link strict rc0 (existing590 overlap warnings),
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent linked RECON299819/299819 identical, zero masked mismatches/foreign
labels; vtable audit PASS1314 files; scoped whitespace check clean.
Backups: scratchpad/physics_before_tireforces_20260928.cpp and
physics_after_tire_xacc_20260928.cpp. Retained physics/doc edits remain
uncommitted after adc9fb10; full project original-source/SLD goal still active.

2026-09-28 car-acceleration named-value/ownership round,710/710 retained.
Retail temp in v1 owns the raw fixedmult RPM product before signed /65536,
not the RPM+250 precursor in a0. Express that precursor as the actual field
increment; temp owns the early selected minimum and the later raw product.
The late positive-demand clamp uses diffDesiredRpm after its initial difference
is dead, before its existing driveAcc overwrite. Its real selection/stores
preserve the a0 web and remove the former temp identity fence. This is a
verified no-new-object/dead-phase representation; register reuse alone does
not uniquely prove literal original C variable spelling for that late phase.
No new fence, volatile, dummy read or output rewrite. Original declaration
order restored, including blip/bblip before the scalar locals. Normal driving
is the real ELSE of the initial gear/shift/power branch (also NFS2-supported),
not a body reached after a jump to the common tail; rpmDrop/rpmRise now belong
to retail depths5/7. Removed the newly unused finalAdjustReturn label.
All recorded names, types, homes, relative declaration order and depths agree.

Detailed diffsrc (-g twin EXACT) attributed the14-difference paired-source
trial solely to the late clamp: moving temp to its v1 role exposed that the
old identity-fenced desired-RPM selection was borrowing its a0 web. Correct
dead-phase ownership removed that fence and preserved710 exact words.
Reverted trials: combined rev-limit conditional MIN29/727; per-arm MIN22/710;
early direct MIN plus temp product14/710 (reversed MIN25/709); product rename
alone8/710; direct late MIN14/710; both candidate caps reused as desiredRpm
370/708. Candidate/rev-limit captures remain explicitly unresolved, not floors.

Final comment/format-cleaned full gate `run-ct36lhg5`: all TU sections/layouts
UNCHANGED, ASPSX524/0, PSYLINK zero errors. Physics14/22 native CLEAN and
global2146/419 unchanged, but affected-function MOVED36->35 and SCOPE163->162.
CarAcceleration still has extra RPM/scaled-ratio captures and27 scopes versus
retail8; root end+ae8 instead of+ae4. These are known recovery targets, not an
assertion of native CLEAN. Actual relative per-word SLD remains662/710 different.
Fresh526-object GNU link strict rc0 with existing590 overlap warnings;
multdef-ok rc0/empty stderr, zero undefined names or truncated relocations.
Independent linked RECON299819/299819 identical, no masked mismatches/foreign
labels; vtable audit PASS1314 files; scoped whitespace check clean.
Backups: scratchpad/physics_before_caracc_20260928.cpp and
physics_after_caracc_temp_20260928.cpp. Physics/doc edits remain uncommitted
after adc9fb10; the full original-source/SLD objective remains active.

2026-09-28 car-acceleration rev-limit continuation: adjustedDesiredRpm removed.
The already-recorded temp now owns the selected rev-limit minimum in v1,
without a new object/fence or home/depth mismatch. All710 words remain PASS;
the intermediate original-name restoration also matches full TU bytes/layouts.
The preceding revLimitedRpm value in v0 is still unrecorded and unresolved.
Reverted follow-ups: direct conditional selection into temp5/709 (lost the
v0-to-v1 copy), MIN with conditional operand into temp33/727, removal of the
existing scheduling fence3/709. The original fence is restored, not replaced
with a new device. Live source comments now name the one remaining review
item rather than asserting that two extra objects must be retained.

Final full gate `run-7blpob69`: complete sections/layouts UNCHANGED,
ASPSX524/0, PSYLINK zero errors, physics14/22 native CLEAN; global2146/419
unchanged. The function still has other captures and27 scopes versus retail8;
actual relative per-word SLD remains662/710 different. No native/full-source
seal is claimed. Fresh526-object GNU link strict rc0 (existing590 overlap
warnings), multdef-ok rc0/empty stderr; zero undefined names/truncated
relocations. Independent linked RECON299819/299819 identical, no masked
mismatches/foreign labels; vtable audit PASS1314 files; whitespace check clean.
Backup: scratchpad/physics_after_revlimit_temp_20260928.cpp. Retained
physics/doc edits remain uncommitted after adc9fb10; full goal still active.

2026-09-28 car-acceleration flywheel-snapshot elimination,710/710 retained.
All three currentFlywheelRpm objects are removed. Root redline comparison
uses flywheel>=redline instead of redline<=flywheel: the operand spelling
restores the snapshot's source-driven load order (direct old order was two
differences at710). The late minimum reads the field directly after the earlier
identity-fence removal/value-owner correction, with no additional code.
The rise arm factors the common base into += MIN(-diffFlywheelRpm,rpmRise).
That operand order preserves the branch and both additions exactly; the
reverse MIN was six differences at710. Plain factored ternary was102/712;
direct fields in both original ternary arms were12/714. Failing alternatives
reverted, no replacement alias, asm, volatile or fake use retained.
The older snapshot-necessity comments are superseded, not generic exemptions.

Final full gate `run-9ri5bnxl`: all TU sections/layouts UNCHANGED,
ASPSX524/0, PSYLINK zero errors, physics14/22 native CLEAN; global2146/419
unchanged. CarAcceleration is still DIRTY for remaining captures and25
scopes versus retail8. Full relative SLD/original text remains unsealed;
no line-padding work is used to conceal that gap. Fresh526-object GNU link
strict rc0 with existing590 overlap warnings, multdef-ok rc0/empty stderr;
zero undefined names/truncated relocations. Independent linked RECON
299819/299819 identical, no masked mismatches/foreign labels; vtable audit
PASS1314 files; scoped whitespace check clean. Retained physics/doc edits
remain uncommitted after adc9fb10; full project goal is still active.

2026-09-28 desired-RPM candidate elimination,710/710 retained.
Each branch now assigns the complete canonical MIN(redline+bias,
fixedmult(redline+bias,gGasRatio)) expression. Both candidateRpm declarations
are removed; the macro's repeated call operand preserves retail's comparison/
fallback call behavior, unlike single-call rewrites or eager desiredRpm reuse.
Detailed710/710 and immutable-reference whole-TU byte/layout checks confirm
the call setup, branches, arithmetic and data placement are unchanged.
Three extra native scopes disappear (CarAcceleration25->22); all recorded
local names/types/homes/order/depth remain correct. No replacement object,
asm, volatile, dummy read or post-compile rewrite.

Signed-/256 follow-ups were not retained: whole (driveAcc/256)*(ratio/256)
and split named diffDesiredRpm quotient both10 differences at710. The earlier
manual bias/interleave plus scaledRatio and its original identity fence are
restored. scaledRatio is an explicitly unresolved source-recovery item, not
exempted or proved original by those finite trials. Remaining native extras:
clampedFlywheelRpm, revLimitedRpm and scaledRatio. Known scope/SLD recovery
also remains; no native/full-source seal is claimed.

Final full gate `run-72s2_wuz`: all sections/layouts UNCHANGED, ASPSX524/0,
PSYLINK zero errors; physics14/22 native CLEAN, global2146/419 unchanged.
Fresh526-object GNU link strict rc0 (existing590 overlap warnings),
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent linked RECON299819/299819 identical, no masked mismatches/foreign
labels; vtable audit PASS1314 files; scoped whitespace check clean.
Backups: scratchpad/physics_before_candidate_min_20260928.cpp and
physics_after_candidate_min_20260928.cpp. Retained physics/doc edits remain
uncommitted after adc9fb10; full project original-source/SLD goal stays active.

2026-09-28 shared flywheel-clamp snapshot elimination,710/710 retained.
Damage now performs its real field decrement and MAX(flywheelRpm,0), then
reaches the wheel-spin tail. The non-damage shifted-gear path writes the same
real MAX clamp. GCC cross-jumps the two source tails back into the exact retail
shared comparison/store, including the damage path's skip past the reload and
its jump-delay-slot store. clampedFlywheelRpm and the now-unused cfLbl1 label
are removed. No new object, asm, volatile, fake use or output rewrite.
Old staging/if-funnel necessity assertions were source-shape-specific and are
superseded in the live source. Independent NFS2 source also uses field MAX.

Reverted partial steps: direct field if-clamp while retaining the jump into
the other arm14/704; replacing only that common clamp with MAX9/705. The paired
source-tail rewrite, not either isolated edit, is710/710 PASS. Final full gate
`run-nyqi32w2`: all TU sections/layouts UNCHANGED, ASPSX524/0, PSYLINK zero errors.
Physics14/22 native CLEAN and global2146/419 unchanged; CarAcceleration's
remaining native extras are only revLimitedRpm and scaledRatio, with22 scopes
versus retail8. The elided downshiftRedlineRpm source capture also remains
explicit review; native-extra counts are not a complete carrier audit.
Actual relative SLD661/710 still differs; no full original-text/SLD seal claimed.
Fresh526-object GNU link strict rc0 (existing590 overlap warnings),
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent linked RECON299819/299819 identical, no masked mismatches/foreign
labels; vtable audit PASS1314 files; scoped whitespace check clean.
Backup: scratchpad/physics_before_flyclamp_20260928.cpp. Retained physics/doc
work remains uncommitted after adc9fb10; full project goal remains active.

2026-09-28 downshift redline source-capture elimination,710/710 retained.
Canonical ratio=MIN(flywheelRpm,specs->redline) preserves the redline-v0,
flywheel-a0 loads and the selected v1 quantity. The reverse operand spelling
was four moved-load differences at710, so operand order is part of the receipt.
The elided const downshiftRedlineRpm object and its read-only empty fence are
removed, not hidden behind a native-CLEAN exception. Original named ratio is
the actual selection result; no new object, alias, asm, volatile or fake use.
This is source-only progress a declaration/local-row-only audit would miss:
nine extra binding regions vanish (CarAcceleration22->13 scopes, retail8).
The earlier fenced-snapshot necessity statement is superseded in live source.

Final full gate `run-6h5ehkl9`: all TU sections/layouts UNCHANGED,
ASPSX524/0, PSYLINK zero errors, physics14/22 native CLEAN; global2146/419
unchanged. Remaining native captures in CarAcceleration: revLimitedRpm and
scaledRatio; scope boundaries and full original-source/SLD remain open.
Actual relative SLD661/710 still differs, with no line-padding workaround.
Fresh526-object GNU link strict rc0 (existing590 overlap warnings),
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent linked RECON299819/299819 identical, no masked mismatches/foreign
labels; vtable audit PASS1314 files; scoped whitespace check clean.
Backup: scratchpad/physics_before_downshift_20260928.cpp. Retained physics/doc
changes remain uncommitted after adc9fb10; full project goal remains active.

2026-09-28 car-acceleration root-scope endpoint correction,710/710 retained.
Combine the final car-type/slippery/second-gear/positive-acceleration guards,
eliminating the duplicate early return expression. Every instruction remains
identical, but the root binding now ends at retail's+ae4 instead of+ae8.
All retail block tuples are now an exact ordered subsequence of the native
tree; the five extra regions correspond to remaining revLimitedRpm/scaledRatio
declarations. This is a scope-boundary improvement, NOT full native CLEAN:
13 scopes still differ from retail8. No padding, dummy object/use, asm addition,
volatile or output rewrite. ScaledRatio fence-removal retest was4/710 (only
the preserved ratio-copy input); its pre-existing fence is restored.

Final full gate `run-xzd3zwwx`: all TU sections/layouts UNCHANGED,
ASPSX524/0, PSYLINK zero errors, physics14/22 native CLEAN. Actual relative
SLD661/710 remains different, with full project source/SLD goal still active.
Fresh526-object GNU link strict rc0 (existing590 overlap warnings),
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent linked RECON299819/299819 identical, no masked mismatches/foreign
labels; vtable audit PASS1314 files; scoped whitespace check clean.
Backup: scratchpad/physics_before_scaledratio_round2_20260928.cpp. Retained
physics/doc edits remain uncommitted after adc9fb10; no completion seal claimed.

2026-09-28 Physics_Real named damage/damping source round,1272/1272 retained.
Restore original root declaration order without changing any code/data/layout.
damp moves from function root to the real guarded damping region at depth5,
supported independently by matched NFS2 source. Removing its terminal return
and writing the mutually exclusive handbrake case as ELSE restores ALL tail
scope tuples, including +12bc..+1300 for the declared damping region and its
parents ending+13b8. The optimized scope ends before the six calls even though
the source block contains them; do not model debug bounds as literal code length.

Brake attenuation retail damage is the coefficient in v0 at depth3, not the
initial raw damage[9] severity in v1. Direct field guard plus block-local
damage=0x10000-damage[9]/128 restores that record/region and removes the extra
damageMult object. Transfer damage is the divided four-zone sum in v1, not
the unrecorded pre-division sum: damage=(sum)/512;transferMult=damage+0xc000
restores its missing REG record with all1272 instructions unchanged. The
alternative in-place divide statement was26 differences at1272 and reverted.
All three damage records now agree in name/type/home/order/depth.

Reverted RPM/look-ahead pair: naming the shifted RPM as currentRpm and direct
look-ahead MAX expressions were15/1273 and17/1271 by operand order. currentRpm
home and remaining rsControl capture remain known source-recovery work, not
exempted by those finite trials. Other snapshots/math devices and regions
remain explicitly unsealed. No new asm, volatile, dummy object/use, padding
or compiler/output rewrite in this retained round.

Final full gate `run-5kh8adqt`: all TU sections/layouts UNCHANGED,
ASPSX524/0, PSYLINK zero errors, physics14/22 native CLEAN. Global2146/419
unchanged; affected-function MISSING115->114 and SCOPE162->161. Actual
relative native-versus-retail SLD1227/1272 still differs; no full SLD seal.
Fresh526-object GNU link strict rc0 (existing590 overlap warnings),
multdef-ok rc0/empty stderr; zero undefined names/truncated relocations.
Independent linked RECON299819/299819 identical, no masked mismatches/foreign
labels; vtable audit PASS1314 files; scoped whitespace check clean.
Backups: scratchpad/physics_before_real_20260928.cpp and
physics_after_real_damage_20260928.cpp. Retained physics/doc changes remain
uncommitted after adc9fb10; full project original-source/SLD goal remains active.

2026-09-28 Physics_Real RS gas/brake source-clamp round,1272/1272 retained.
Bound-first (char)MIN(0xe0,tempGas) removes gasLevel while retaining the
shared physical compare/store. The reverse MIN was14 differences at1272,
including the byte-target constant/store lowering, and was superseded.
For braking, reuse the recorded tempGas for the real signed quotient,
store (char)MIN(0xff,tempGas), then test the actual unsigned RSBrakeLevel
field. This removes brakeLevel without altering its original signed clamp
or low-byte threshold behavior. MAX(0,tempGas) expresses the negative-demand
gas floor directly. The former tempGas identity fence is unnecessary in
this source shape and is removed too, with no replacement alias/fence,
volatile, fake use or output rewrite. All1272 words and full TU sections/
layouts are unchanged. Reusing lookAhead for the RS direction/multiplier
precursor was44 differences at1272 and reverted; rsControl remains review.

Final full gate `run-__1dx8nh`: ASPSX524/0, PSYLINK zero errors,
physics14/22 native CLEAN; global2146/419 unchanged. Physics_Real remaining
native extras: adjustedRpm,fz,lm,rsControl; currentRpm home and24 scopes versus
retail23 remain unresolved. Per-word relative SLD1227/1272 still differs,
so no whole-function original-source/SLD seal is claimed. Fresh526-object
GNU link strict rc0 (existing590 overlap warnings), multdef-ok rc0/empty
stderr; zero undefined names/truncated relocations. Independent linked
RECON299819/299819 identical, no masked mismatches/foreign labels; vtable
audit PASS1314 files; scoped whitespace check clean.
Backup: scratchpad/physics_before_real_clamps_20260928.cpp. Retained
physics/doc changes remain uncommitted after adc9fb10; full goal still active.

2026-09-28 Physics_Real RPM/look-ahead diagnostic revalidation (no failing
function changes retained). After the gas/brake/fence cleanup, paired real
shifted-currentRpm ownership and look-ahead forms still failed: MAX with
reversed multiply order15/1273; explicit intermediate lookAhead quotient17/1271;
expanded conditional with per-arm multiplication16/1276. The current verified
branch/capture form is restored at1272/1272 and full TU byte/layout identity
(`run-d644fefc`, ASPSX524/0, PSYLINK zero errors). Source comments now explicitly
record these current failures instead of silently exempting rsControl.
The missing original quantity ownership is not fixed by renaming its width/
step precursor; it remains a known investigation, not a floor or unknowable.

Next instrument routing established read-only: complete GCC function.c exists
under extracted2/gcc-2.8.1 and extracted5/gcc-2.8.1 (not the small extracted/
subset); global.c/local-alloc.c are in extracted/. C++ trace binaries exist
in C:/Temp/nfs4-instr-cc1. qtytrace/qtyprio accept file-first positional inputs,
not --help: trace function filter with --steps/--blocked/--want, or lreg plus
signature. A trace receipt requires byte fidelity against the authentic
compiler for this specific function first; no such new trace is claimed here.
The global simulator needs genuine greg/lreg dumps; do not infer allocation
windows from already scheduled final assembly or silently swap compiler lanes.
All failed source variants are reverted, no baseline/tool/compiler output or
binary rewrite. Existing linked-image checkpoint remains unchanged by these
restored-code/comment-only diagnostics. Full project goal remains active;
retained physics/doc restoration changes are still uncommitted after adc9fb10.

2026-09-28 authentic allocation-dump preparation (diagnostics, no source experiment).
Normal physics preprocessing input copied into isolated
build/physics_alloc_20260928/physics.i. Authentic CC1PLPSX -quiet -O2 -G4
with -dg -dl -dS produced greg/lreg/sched dumps and auth.s. Its FULL assembly
SHA256 is exactly the normal verified build's:
503463949C70102A4DFA640286CE6A4ECFC3B4CAB607CEB4356B8BE063072217.
Thus dump flags are code-neutral for this current TU, without relying on a
different compiler or post-compile rewrites. Inputs and generated outputs are
isolated; production build objects/source/baselines were not overwritten.

Simulator invoked with the actual dump signature prefix, void Physics_Real
(bare Physics_Real is not a valid prefix for allocsim). Order matches the dump,
but handout fidelity is only93/95: p348 sim v1/actual a1, p344 sim a0/actual v1.
Do NOT price or retain register dials on the assumption that this whole model
is validated. Next diagnostic work must reconcile those differences or obtain
a per-function code-faithful instrumented trace before using local qty windows.
qtyprio's refs/live numbers are proxies; merged quantities need qtytrace's
actual merged counts. No new instrumented-compiler trace/fidelity claim here.
Current matching and original-source/SLD objective remain open, not a floor.

This receipt supplies real compiler state for the pending RPM/look-ahead
investigation rather than another spelling sweep or status restatement.
Matched source unchanged in this diagnostic round; retained physics/doc
restoration checkpoint remains uncommitted after adc9fb10. Full goal active.

2026-09-28 allocation diagnostic repair after physics checkpoint00c8c2cb.
Revalidated authentic auth.s versus normal physics assembly: both SHA256
503463949C70102A4DFA640286CE6A4ECFC3B4CAB607CEB4356B8BE063072217.
The two Physics_Real simulator discrepancies are explained by GCC global.c
expand_preferences (776..817), not by a guessed register dial. At RTL insn1295
p332 dies while copied into non-conflicting p348. p332's a1 COPY preference
must propagate to p348 before pruning/allocation; the printed greg union
{v1,a1} alone cannot reveal that the copy subset prefers a1 first. Correcting
that recovery also restores p344 to v1 through the ordinary conflict handout.
No hard-coded pseudo number/register answer is added to the parser.

allocsim now replays pure single-set allocno copies with matching REG_DEAD,
non-conflict checks in BOTH directions, and one forward pass in RTL order.
Arithmetic preferences, subreg forms and unsupported patterns are not silently
treated as copy preferences. All in-repo consumers supply the allocno/conflict
tables (validator, reqdelta, dialsearch, dial). Comments and pre-change backups
*.bak-pre-copydeath-20260928 accompany each modified diagnostic tool.
No reconstructed source, baseline, compiler output or binary is rewritten.

Seven focused unittest cases pass (death, liveness, both conflict directions,
non-allocno, arithmetic, wrong death, one-pass-vs-fixed-point). Physics_Real
now95/95; reqdelta's constructed model independently reports95/95. Physics
validator:461 matching handouts plus five separately classified reload cases,
20/20 functions with no remaining unclassified miss. Do not misreport this as
466/466: raw disposition agreement is461/466. Saved physics/screencongrats/
front/hud regression comparison covers1386 handouts:1367->1369 raw agreements,
zero previously correct handouts lost. Existing other-corpus/reload discrepancies
remain and this bounded repair is not a blanket validation of all allocator paths.
All six touched Python files compile; whitespace checks clean. Source remains
exactly the committed physics checkpoint; no fresh relink is claimed for this
tool-only round. The full original-source/SLD objective stays active. Next:
map the now-validated function's actual quantity ownership before any source
experiment; final register reuse alone does not prove an original C name.

2026-09-28 Physics_Real trace-fidelity and RPM ownership experiments.
Fresh immutable-reference compile passes. Full instrumented cc1plus-ecoff
compile stops with an internal compiler error in RampCarControlValues (rc33),
so no complete-TU trace fidelity is asserted. Isolated real.i preserves the
preprocessed headers/declarations and the complete Physics_Real body. Authentic
CC1PLPSX compiles it with a normalized instruction stream identical to the
production function; no declaration/context shortcut is used. Instrumented
compile then succeeds, but three genuine register differences remain in the
wheel-multiplier region: leftMult v1->a1, rightMult a1->v0, and the corresponding
subtraction operands. No full-function instrumented byte fidelity receipt;
do not price qty windows from that trace as if it were the retail/original lane.
Generated inputs, outputs and traces stay isolated under
build/physics_trace_20260928, not committed reconstructed source.

Direct retail SYM re-read confirms currentRpm REG:v0, diffRpm REG:a1,
tempGas REG:a0; current source currentRpm remains wrongly attached to the later
speed-step value in a2. IDA sub_800AC164 separately confirms the signed RPM
product/bias, gas division, difference, and speed-step/look-ahead computations.
Retained source is NOT repaired just because those values are understood.
New no-asm/no-volatile source trials were all reverted:
- diffRpm owns product/bias then becomes desired minus shifted value:5diffs,
  1273/1272; the shifted quotient is duplicated across the sign-bias arms.
- explicit currentRpm quotient between gas division and diff assignment:
  same5/1273, quotient now a2 instead of v0.
- complete signed /65536 assigned to currentRpm before gas division:11/1273.
- currentRpm owns raw product, division at difference use, with lookAhead
  holding the later speed-step phase:21/1273; bias/division schedule changes.
None proves a distinct adjustedRpm object was original or a source floor.
Next source/allocator work must account for the signed division's split value
web and genuine named-value lifetime, not simply rename the later speed step.

Restoration verified against git: physics.cpp has no changes from00c8c2cb.
Detailed1272/1272 PASS, full TU gate run-fyi1fpig: BYTES UNCHANGED, ASPSX524/0,
PSYLINK zero errors, physics14/22 native CLEAN with the same eight discrepancies.
Rebuilt production assembly has the same full50346394...072217 SHA256 as the
authentic diagnostic dump; vtable audit PASS1314 files. Prior linked-image
checkpoint unchanged; no fresh GNU relink claimed for this restored-code round.
Only diagnostic tools/tests and this evidence journal remain pending. Full
original-source/SLD goal active and incomplete; no new code improvement claimed.

2026-09-28 barrier-check real ownership and byte-stage recovery,358/358 retained.
Retail has three sibling calculation regions at depth2 (including the initial
optimized zero-length region), then widthVector at depth2,+368..+480. Remove
the reconstruction's enclosing carrier block; write the real no-collision
early return before Force/width/contact handling. All ten native block tuples
now equal retail, not merely an ordered subsequence or a correct block count.
All already-recorded nested r/x and widthVector depths are correct. No fake
declaration, wrapper, new asm/volatile, or output rewrite is introduced.

Reprice byte-stage captures on that shape: r3 directly receives the signed
byte then <<=9, r2 likewise. raw2/raw3 are both removed at358/358 PASS; their
previous grouped direct-shift failure did not prove either object necessary.
The remaining raw1 has its existing read-only fence and is explicit unresolved
source recovery, not proof of an original source object. Function banner no
longer claims complete SLD verification. Other carriers/old devices remain
unsealed, including native extras x1raw/centerX/centerY/positionZ/velocityZ/
centerKeep/raw1/x3factor/x3left and source-only const aliases. No replacement
alias hides either removed name. Missing wallType remains an investigation.

Reverted trials in this round: direct field-target MIN on wheel-lock38/127
and40/127; cmp-cap plus root roadGrip skid capture9/128. Original127/127 wheel
lock restored. Barrier centerX+its fence removal2/358, same with negative-first
form; paired positionX removal/regrouping6/358, positionX-only removal42/358.
Attaching wallType to the collision flags as full OR/split in-place OR8/358;
loaded flag plus separate OR6/358 in both operand orders. These do not recover
wallType's actual original quantity, so all are reverted rather than naming a
convenient reused hard register to clean a report.

Final comment/format-cleaned full gate run-4dmfoq7f: complete TU bytes/layouts
UNCHANGED, ASPSX524/0, PSYLINK zero errors; physics14/22 native CLEAN unchanged.
Global2146 CLEAN/419 DIRTY; SCOPE161->160 and BLOCKS335->334 affected functions.
Native-extra rows in this function decrease11->9, though function-level EXTRA
remains292. Independent full-native-versus-retail relative SLD is349/358
different: original source-line attribution is NOT sealed by exact scopes.
Fresh526-object GNU link strict rc0 with existing590 overlap warnings;
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent fresh linked RECON299819/299819 identical, zero masked mismatches
and foreign labels (retail passthrough BLOB excluded from reconstruction proof).
Vtable audit PASS1314 files; scoped whitespace clean. Original-source/SLD
goal remains active and incomplete. Source/doc restoration and diagnostic-tool
repair remain pending after00c8c2cb; no new commit/push in this round.

2026-09-28 barrier-check instrumented trace fidelity established on current source.
Further source trials all reverted: x3 owns the divided right.z then *=factor
48diffs at358 words; removing raw1/fence with in-place signed-byte shift18/358;
unsigned-domain combined shift20/358. No failed source change, replacement
alias or new fake-use/asm device remains. Current physics.cpp SHA256 equals
the pre-round backup168E92953364F1583A4C17F19E13CF043D38D26D189F08102320FB807459E4BB.
The retained previous round's exact scope and raw2/raw3 improvements remain.

Unlike Physics_Real's three-difference instrumentation result, DoBarrierCheck
now has a genuine function-specific trace receipt. Current preprocessed headers/
decls and the entire target body are isolated in
build/physics_trace_20260928/barrier.i. Authentic and instrumented ECOFF C++
compiles both succeed; normalized source instruction streams match the normal
production function. Then BOTH compiler outputs are assembled through the
normal maspsx/as pipeline/flags:358 raw instruction words identical, and all20
relocation rows (offset/type/target) identical. SHA256 of concatenated objdump
word bytes is c7a0dc387ea5eb76910a686a89511edc5304e70f7ee98d6c7b532404cb9968d8
for both. This is unlinked function-code fidelity, not a new whole-image seal.
No compiler output is rewritten; the normal assembler performs its ordinary
translation. All diagnostic outputs are isolated and generated/ignored.

Actual first local-alloc window maps: raw1=p97 (q2,v0,refs4/life6), shifted
r1=p94 (q4,a1,refs2/life8), x1raw=p89 (q6,a2,refs2/life60), centerX=p90 and
centerY=p91 (q7/q10,a0,refs4/life12). Slice address quantity p101 has merged
refs16/life74 in the trace, while the lreg pseudo's unmerged proxy says14/37.
Use qtytrace's merged windows, not proxy arithmetic or final hard-reg reuse.
The authentic global model has59 exact handouts plus one separately classified
reload case out of60. Finite reframe failures do NOT prove any remaining
carrier was an original source object; no floor or blanket exemption claimed.
Next genuine source experiment can now inspect those checked local quantities
before changing capture lifetimes/evaluation order; no unverified trace swap.

Final restored-source TU gate run-tm_5_4ow: BYTES UNCHANGED, ASPSX524/0,
PSYLINK zero errors, physics14/22 native CLEAN; same nine barrier extras and
missing wallType. Prior fresh linked299819/299819 checkpoint remains valid
for this unchanged source; no new GNU relink or source improvement claimed
in this diagnostic round. Full original-source/SLD goal active and incomplete.

2026-09-28 barrier-check missing wallType value restored,358/358 retained.
Retail root INT wallType is REG:v0. The formerly declaration-only reconstruction
attached it only to the AttenuateVelocity result, which GCC optimized out of
debug records. Raw boundary handling has the actual classification1 in v0
before the first global currentWallType store; mobile twin independently
stages classification1 in both boundary arms. Make the existing wallType own
that value and make both real global stores use it. All358 instructions remain
exact, including the second arm's shared collide=1 store register. No new
declaration, fake use, fence, volatile or opcode/output rewrite.

Every retail-recorded parameter/local/type/home/depth and relative declaration
sequence now agrees, including wallType; all ten scope tuples still agree.
The nine unrecorded captures remain and are not excused by that narrower proof.
Complete original source/SLD is still unsealed: native-versus-retail relative
SLD349/358 differs. Actual source-line attribution is not repaired by padding.

Earlier centerX follow-ups reverted: dropping only its read-only fence moves
the center load AFTER the two car loads (2diffs at358), explicit negative
capture gives the same two; staged vel_b.x +=/-= target form adds one word
(359/358) and reorders/recolors other quantities. These are source-basin
receipts, not distinct-object necessity proofs. All prior raw2/raw3 and scope
improvements remain; no failed variant retained.

Final source-only detailed gates358/358 and neighboring FixEngineRpm86/86;
full TU run-1o0ncm4h: complete bytes/layouts UNCHANGED, ASPSX524/0, PSYLINK zero
errors. Global2146 CLEAN/419 DIRTY; MISSING114->113 affected functions, other
issue tallies unchanged. Physics14/22 native CLEAN remains unchanged because
of its extras, not because this missing name is still absent. Fresh526-object
real GNU link strict rc0 with existing590 overlap warnings; multdef-ok rc0
with empty stderr, zero undefined names/truncated relocations. Fresh linked
RECON299819/299819 identical, zero masked mismatch bytes and foreign labels;
retail passthrough BLOB excluded from reconstruction proof. Vtable audit
PASS1314 files; scoped whitespace clean. Retained changes pending after00c8c2cb;
the exhaustive original-source/SLD goal remains active and incomplete.

2026-09-28 collision fixed-object native contract restored,874/874 retained.
Fresh immutable-reference compile passed. Retail's scale/lengthInverse and
upVec/dotx/doty/dotz belong at depth4, not5: remove the two extra reconstruction
wrappers around the velocity and low-speed guarded phases. The real if owners
supply the parent regions. Every six retail scope tuples (12 endpoints) now
match exactly; no fake empty region or local is manufactured.

Missing root temp3 was attached to the wrong arithmetic stage. NFS2 PC matched
Collide_DoObjectFixedObjectCollision explicitly names the half-scaled
fixedmult(VectorLength2(RCrossN),moInertiaInv*2)/2 term temp3, then adds temp2
in the division argument. Retail NFS4 independently computes that half in
a1, then adds s0=temp2 in rdiv's jal delay slot. Restore that actual named
value, leaving temp2+temp3 as the call argument, rather than naming the sum
denominator temp3. This naturally restores INT REG:a1 without a fake use,
new object, asm/volatile, register pin, or compiler/output rewrite. All874
instructions and full TU sections/layouts remain exact.

Final comment/format-cleaned source-only gate and full symloop run-kjf1d5q1:
BYTES UNCHANGED, ASPSX524/0, PSYLINK zero errors; collide9/14 ->10/14 native
CLEAN. Target frame/params/every local type/home/depth/order and all scopes
are exact, with no extra/missing native row. This is NOT a complete original
source/SLD seal: actual relative native-versus-retail SLD864/874 differs.
Other collide functions still have known source/scope/capture discrepancies;
the broader goal is neither completed nor reduced to this native contract.

Global2147 CLEAN/418 DIRTY; GAME/COMMON1091/156. Affected-function tallies:
MISSING113->112, SCOPE160->159, BLOCKS334->333; others unchanged. Vtable audit
PASS1314 files, scoped whitespace clean. Retained collide/physics/doc and
allocator-tool/test changes remain pending after00c8c2cb. Backup:
scratchpad/collide_before_fixedobject_20260928.cpp. Full goal stays active.
Fresh526-object GNU link: strict rc0 with existing590 overlap warnings;
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent real linked RECON299819/299819 identical, zero masked mismatches
or foreign labels (retail passthrough BLOB excluded from reconstruction proof).

2026-09-28 actual-object collision ownership/scopes restored,765/765 retained.
Retail has sibling max-velocity regions at depth2 and high/low locals at
depth3 in each half. The reconstruction nested the entire second half inside
the first low-velocity block and added extra wrappers. Remove those wrappers,
make the halves siblings, and use real inactive-high-path jumps into the
low-velocity regions. Terminal branches belong OUTSIDE declaring regions:
first high's last goto outside its vector block, first negate jump outside
both low block and parent, second high's return outside its vector block,
and the common return outside the second low block/parent. That restores
all18 retail block endpoints exactly, not merely counts/depths. Low-velocity
label names describe proven control flow; original label text is not claimed.
All recorded parameter/local types/homes/order/depth agree; selectedRange is
the only native EXTRA. No new asm, volatile, fake object/use or output rewrite.

Important source-lifetime work remains, not an audit exception: first high
still uses the existing shared-copy labels in the second high source region.
Same physical AUTO slots/byte match do not by themselves prove a portable C++
object-lifetime representation. Recover a legitimate shared-copy expression/
owner (or make equivalent ordinary per-half copies match) before claiming
whole original-source or portable semantic restoration. Existing normal ref
fences and selectedRange also remain genuine work, not declared original
objects or unreachable floors. Source comments explicitly keep those open.

Reverted broader variants: ordinary per-half copies+returns, common-return
gotos, builtin memcpy copies, and comma returns all765 words but68diffs:
GCC retains the shared normal-copy tails in FIRST half instead of retail's
SECOND. Per-axis range tests with that variant72/769. On the scope-correct
matched form, one side-effecting conditional expression removes selectedRange
but distributes comparison into three slti tests plus a Boolean join:7/766,
unchanged by long cast; long long184/773. All reverted. The real scope repairs
are retained independently, without treating those failures as proof that
a named range carrier was required in the lost source.

Final comment/format-cleaned source-only gates765/765 and neighbor874/874;
full TU run-muz56b34: complete bytes/layouts UNCHANGED, ASPSX524/0, PSYLINK
zero errors; collide10/14 native CLEAN unchanged. Global2147/418 unchanged,
but SCOPE159->158 and BLOCKS333->332 affected functions. Full relative
native-versus-retail SLD755/765 still differs; no line padding/full SLD seal.
Vtable audit PASS1314 files; scoped whitespace clean. Backups:
scratchpad/collide_before_actual_20260928.cpp and
collide_after_actual_scopes_20260928.cpp. Retained source/doc/tool/test work
pending after00c8c2cb; exhaustive original-source/SLD goal remains active.
Fresh526-object GNU link: strict rc0 with existing590 overlap warnings,
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent real linked RECON299819/299819 identical, zero masked mismatch
bytes or foreign labels; retail passthrough BLOB excluded from source proof.

2026-09-28 actual collision shared-copy SOURCE LIFETIME repaired at765/765.
The prior first-half jumps entered second-half vector-copy labels, reading
different source AUTO objects whose initialization had been bypassed. Shared
physical frame slots hid that issue in the byte gate. It is now removed:
each first-half case actually copies from its own initialized normalx/y/z,
then jumps to a shared return label AFTER the corresponding second-half copy.
Second-half cases likewise use their own initialized objects. Incoming
first-half jumps reach constant returns, not uninitialized object reads.
No new object, alias, asm, volatile, fake use or output rewrite. Label names
describe actual axis-return paths, not claimed literal original spellings.

GCC-source lever: jump.c:2124..2155 tries instructions immediately before an
unconditional jump's DIRECT target (minimum1) BEFORE other jumps to the same
label (minimum2). find_cross_jump at2528 stops on a label in stream1 but skips
labels in stream2; do_cross_jump redirects the jump BEFORE the matched tail
and deletes the first copy. Returns/shared function-exit funnels had kept
FIRST copies (the68-diff relocation); direct targets just AFTER each SECOND
copy make GCC retain retail's SECOND copies instead. This is a real source
control-flow lever, not relocating instructions after compilation. Detailed
source-only gate confirms765/765 and every instruction/register unchanged.

Diagnostic setup also recovered authentic jump-state files, not just final
assembly. CC1PLPSX accepts -dj ->.jump and -dJ ->.jump2 (toplev.c3904..3912),
with -ds ->.cse; cross-jump runs after register allocation/sched2 but BEFORE
delay filling (toplev.c3548ff). Isolated matched input base.i and ordinary
per-half-copy ordinary.i are in build/collide_jump_20260928/. Both compile
with authentic -O2 -G4 and those dump flags; base.s's normalized target stream
equals the production function. Dumps/output files are isolated/generated,
not modified compiler/binary output or committed reconstructed functions.
No instrumented-compiler fidelity is assumed for this target.

Reverted candidate forms: aggregate lvalue conditional first-half copy20/771
(materializes selected stack address); copy-valued casts68/793 (extra stack
temporary); scalar conditional-return copies68/765 (still wrong tail owner).
The retained AFTER-copy return-target form is the one that fixes source
lifetime AND remains byte-exact. Builtin last-Z copy and a same-block Z
return label do not seal its scope end; both are reverted/kept out.

Explicit remaining native gap: one second-high block now ends+aa8(2728),
retail+a90(2704),24 bytes later. All named locals/types/homes/order/depth
still agree; the other17 block endpoints agree. This known debug-endpoint
gap stays open; do NOT roll back the genuine lifetime fix merely to make
the native scope report greener, or call either form fully source/SLD sealed.
selectedRange and the older normal ref fences also remain source recovery.
Goal scope is unchanged and includes those genuine outstanding requirements.

Final source-only765/765 and neighbor874/874; full TU run-kyhu6qug: all
sections/layouts UNCHANGED, ASPSX524/0, PSYLINK zero errors; collide10/14
native CLEAN unchanged. Global2147/418; BLOCKS332->333 affected functions
reflects the explicit endpoint gap, SCOPE158 and other issue counts unchanged.
Fresh526-object GNU link strict rc0 with existing590 overlap warnings,
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent linked RECON299819/299819 identical, no masked mismatches/foreign
labels (retail BLOB passthrough excluded); vtable audit PASS1314 files;
whitespace clean. Source/doc/tool/test work still uncommitted after00c8c2cb.
Full original-source/SLD goal active and incomplete. Backup:
scratchpad/collide_before_normal_select_20260928.cpp.

2026-09-28 registry-bound carrier removed,128/128 retained.
Retail tail loads Cars_gNumCars once into a0, compares the actual root
carLoop in v1 and increments it in the back-branch slot. A real
exit-in-the-middle while(true)/break loop lets loop optimization hoist that
anonymous bound naturally. n and the old carloop_top label are removed, not
renamed or hidden behind const, with no replacement source object/fence/use.
The body-expression region contains only the actual range-exit and increment
statements; it retains the two empty loop regions without invented locals.
Every original frame/parameter/local/type/home/order/depth record agrees.

Known gap, not a floor: the parent's start is+1c8(456), retail+1bc(444),
12 bytes late. Six scopes now match in nesting/count and the other11
endpoints agree. Actual relative native-versus-retail SLD119/128 differs;
literal original loop/macro spelling and exact ownership/SLD remain open.
No full native CLEAN or original-text seal is claimed. NFS2 PC's sibling
contains only the global clear, so it is not a body substitute for this
NFS4 loop; raw retail/SYM remain the authority.

Reverted trials: ordinary top-tested while131/128 adds a pretest and final
counter correction; initialized and separately initialized infinite for,
exit-middle do, unsigned-char predicate and braceless for variants10/132.
Bare exit-middle while matches128 but drops both empty debug regions.
Two real GNU regions give seven scopes; only outer gives five; predicate-
region or body-region for variants match128 but give seven scopes. A used
labelled while body is128 PASS but still five scopes, so it is not kept as
a dummy scope dial. The retained single real body-expression form has no
such label, unused declaration, fake test, asm addition or output rewrite.
Neutral returnNormalZ label-at-block-end/null-statement experiment also
reverted:765 PASS but no endpoint improvement. The earlier genuine shared-
copy source-lifetime fix remains, with its explicit24-byte endpoint gap.

Final comment-cleaned source-only gates registry128/128, actual collision
765/765 and fixed-object874/874; full TU run-c7f3mh0u: sections/layouts
UNCHANGED, ASPSX524/0, PSYLINK zero errors; collide10/14 native CLEAN.
Global2147/418 unchanged, but affected-function EXTRA292->291; other issue
counts unchanged. Vtable audit PASS1314 files; scoped whitespace clean.
Source/doc/tool/test changes pending after00c8c2cb. Backup:
scratchpad/collide_before_registry_loop_20260928.cpp. Full exhaustive
original-source/SLD objective active and incomplete, not reduced to native
record coverage or byte identity.
Fresh526-object GNU link: strict rc0 with existing590 overlap warnings;
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent linked RECON299819/299819 identical, no masked mismatch bytes
or foreign labels; retail BLOB passthrough excluded from reconstruction proof.

2026-09-28 CheckMeForCollisions ownership checkpoint before user-requested pause.
Inactive/simOptz real early exits replace the enclosing catch-all nesting;
timer and surface tests are separate positive owners. A real region around
Object_InitCollisionCheckLoop and for-owned object iteration restores the
point-list/j levels; closest-point, accurate-hit and nonzero-result guards
own signCase. The geometry phase is a one-case switch (case1) with default
sign2/-1 checks, not an invented source object. Its normal/samplePoint/impulse
scope ends AFTER the zero-impulse skip and BEFORE effect bookkeeping.
Every original param/local/type/home/depth/order now agrees, with no native
extra/missing name. No new asm/volatile, fake references or output rewrite.

Retained form381/381 PASS. Remaining native scope gap is exactly one of36
endpoints: switch-body start+1a8(424), retail+190(400),24 bytes late; the other
35 endpoints agree. Full literal original syntax and SLD remain unsealed.
Do not describe this function as fully SYM/source/SLD-exact despite repaired
names/owners. Other collision functions retain their separately recorded
endpoint/capture work, and the broader exhaustive goal remains incomplete.

Source experiments, all not retained: three-case switch37/388 (different
dispatch and handouts), Boolean switch4/383 (materialized Boolean), comma
getter switch condition neutral for the endpoint. Geometry/body expression
forms preserve381 but produce extra level or two bad endpoints. One-case
ordinary switch plus moving the real geometry boundary after the zero-impulse
skip is the verified retained form; initializer/case labels are not dummy uses.
Registry grouped do expressions also neutral/worse in scope count and were
reverted to its earlier128/128 form; no neutral boundary/null-label trial remains.

Final comment/format-cleaned source-only gates: CheckMe381, Registry128,
ActualCollision765, FixedObject874 all PASS. Full collide TU run-jw9ju1l7:
complete sections/layouts UNCHANGED, ASPSX524/0, PSYLINK zero errors,
collide10/14 native CLEAN. Global2147 CLEAN/418 DIRTY; SCOPE158->157 affected
functions; other issue counts unchanged (EXTRA291, MISSING112, BLOCKS333).
Fresh526-object GNU link: strict rc0 with existing590 overlap warnings;
multdef-ok rc0/empty stderr, zero undefined names/truncated relocations.
Independent linked RECON299819/299819 identical, zero masked mismatch bytes
or foreign labels, retail BLOB passthrough excluded. Vtable PASS1314 files;
seven allocation-parser tests pass; all six diagnostic Python files compile;
scoped whitespace clean. User requested finish current round, commit/push,
then pause. Only verified physics/collide restoration, diagnostic tools/test
and this journal enter the checkpoint; unrelated files/generated artifacts
are excluded. Baseline backups remain local; no differing reference refreshed.

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
- Implicitly declared callees create debug scopes. CC1PLPSX 2.8.0 accepts a call to a function
  with no visible declaration (an implicit `int f(...)`), but it wraps every such call statement
  in nested debug scopes that retail's SYM does not have: `AI_CalcMeritsBasedOnSpeed` carried
  30 scopes against retail's 1 (a pair around each `fixedmult` call, nested per enclosing `if`
  and `do`); one `extern "C" int fixedmult(int, int)` in `ai_externs.h` collapses it to the
  retail tree at unchanged bytes. `tools/psyq_pipe/implicit_sweep.py` compiles every game and
  frontend TU as `build.py` does and lists the compiler's implicit-declaration warnings: 17 TUs
  (34 names: eaclib fixed-point and matrix helpers, libc `memset`/`strncmp`/`sprintf`,
  `SetSp`, `blockclear`/`purgememadr`/`reservememadr`, libgpu/libgte/libpad calls).
  `implicit_fix.py` inserts C-linkage prototypes (every name is an unmangled symbol in the
  retail MAP) into each TU's `<tu>_externs.h`, spelled after the tree's / PsyQ 4.3's typed
  declarations; `aih_basiccop.cpp`'s `(MATRIX *)` casts on its `transpose` call became
  `(matrixtdef *)` to fit the prototype. Gate: one symloop run over the 16 TUs, BYTES UNCHANGED
  (382 functions); with `ai.cpp` the board rises 1784 -> 1794 CLEAN (AI 26 -> 28, CAMERA,
  NEWTON, OBJECT, PHYSICS, AISTATE, MPAUSE gain the rest); BLOCKS 671 -> 659. The parameter
  names in those prototypes are ours, not recovered spellings.
- Guards around declared blocks. The C++ front end pushes a binding level for `if`, `for` and
  `switch` statements (for condition declarations); a level is kept in the debug output when it
  declares something or contains a kept sub-block. So an `if` whose body holds a block-local
  declaration (or an inline call, whose params/body are blocks) adds TWO scopes of its own -- the
  statement level and the body compound -- and a `for` whose body declares a local adds one.
  Where retail's tree has such blocks directly under the function, EA wrote the guard as an
  early return: `InvalidatePersistentCollideBoomObjects` (`if (!instGroup || !defGroup) return;`,
  the `GetNumElements` inline pair then sits under the function block), `CleanupSpinningCars`
  and `CleanupSpinningCarsMenu` (`if (!rendering3DEnvironmentInitialized) return;` with the `i`
  and `handle`/`fname` blocks as siblings), `Render_InsertDepthOfField` (`if (!(mode & 1))
  return;`, the three prim blocks under the function).  `AIInit_StartUp2`'s second loop is a
  `while` (its `for` form nested the `carObj` block one level too deep; the first loop, with no
  inner declaration, stays a `for`).  All five: bytes unchanged in one symloop run over the four
  TUs, each now native CLEAN; board 1794 -> 1799.  Retail's block-line fields and the SLD tags
  of these functions are not claimed (SLD is parked).
- Inline-call multiplicity and counter scopes. `Blockade_AddRoadFlare` had two inline scope
  pairs where retail has one (`GetData()` with its `this`): the element count is read as the
  `m_num_elements` field, as the increment below it already did. `BWorldSm_QuadLight` expanded a
  `GetData()` macro four times (four pairs; retail one): the vertex base is now one
  `CCOORD16 *const` local (optimised out of the debug locals), and the miss path is the `else`
  arm of the `rez == 2` test, which makes the statement level span the function as retail's does.
  `FindBarrierEndSlice` declared each `sliceLoop` in a wrapper block around a `for`; retail's
  tree is the `for`-level scope holding the counter with the body block inside it, i.e.
  `for (int sliceLoop = 0; ...)`. All three byte-unchanged (symloop), native CLEAN; board
  1799 -> 1802.
- Three more scope-tree restorations of the same family, each byte-unchanged (symloop) and now
  native CLEAN: `R3DCar_CalcCarDimensions` (the per-object test is a `continue`, so the wheel
  block sits straight inside the loop body as retail's does); `AIHigh_Opponent::DoRearEnder`
  (one `simOptz && speed` guard instead of two nested ifs, `for (int racerLoop ...)`, and
  `longDistance`/`latDistance` declared with `otherCarObj` at the top of the loop body, the
  road-position test then declaring nothing); `Collide_TestWithPlane` (`height` in its own
  block, and the three nested `Collide_gRaiseUp`/`raiseUp`/`Raise.y` ifs are one `&&` chain
  around the `correction`/`v2` block). Board 1802 -> 1805.
- Carrier round (2026-09-26, user: "continue with the carrier functions"). Every `SYM-CODEGEN-CARRIER`
  local is an invented variable the SYM lacks; each was kept because the pure spelling missed bytes in
  some earlier basin. Re-priced in today's basin with statement-ORDER and store-position variants
  (scratch `build/tmp/trials.py` runs a spec of named variants through `var_fn.py`; `var_fn.py` now
  matches member functions as `Class::Name`). Twelve carriers removed, all `verify_asm` PASS and
  `symloop` BYTES UNCHANGED, functions now native CLEAN: `tScreenCarSelectDuel::UpdateVideoWall` and
  the TwoPlayer twin (`country`: store `fPreviousCountry` BEFORE `fTVsInitialized`, the order the base
  class already used); `Hud_FBuildSprite`/`Hud_FBuildF4` (`prev_pkt`: the direct OT link in
  `Hud_GoTpage`'s order); `Hud_InitTables` (`positionTable`: one indexed read
  `Hud_gElementPositions[1 < numPlayerRaceCars]`, a `?:` select also passes); `Device_Update`
  (`commMode`: the arm stores the literal 1, the same bytes as a copy of a value known to be 1);
  `Flare_Spikes`/`Flare_HexFlare`/`Flare_ReflectHexFlare` (`rgb`: the colour store sits where the
  load was, plus `flare_dvxy` declared before `i` as the SYM orders them);
  `DrawW_kCtrlWorld_High` (`sentinel`: `while (numQuads != -1)`, the hoisted loop constant is what
  retail parks in $s3); `Skidmark_Add`/`Skidmark_AddStretch` (`n`: chained assignments
  `seg[n].rgb = seg[n+1].rgb = *color`, one `sm->n` read per pair). Falsified today (all variants
  gated): `bright` x2 (param mutate 27, casts 32), `gs` (19/13/20), `result` in
  GetRearEndDamageFactor (9/21/9), `limit` (4/6/47), `offset` (10), `random` (15/3), `m` (15/5/15),
  `newBestLap` (6/6/11/10), `counterSlot` (index forms 1 diff: an extra address insn),
  `carCount` (22), `otWord` (32/46/44), `linkWord` (12; macro forms need a tag type the TU lacks),
  `packetCell` (30), `fadeValue` (21/18), `rgb` in Flare_2DSpike (5/2/6/7). Board 1807 -> 1819.
  Also: `build/symloop_runs` had grown to 32 GB; symloop now keeps only the newest 20 runs
  (`SYMLOOP_KEEP_RUNS`).
- Carrier round 2 (2026-09-26). Same method; ten more carriers gone, all `verify_asm` PASS and `symloop`
  BYTES UNCHANGED: `CarIO_CleanUpLicense` (`plateSlot`/`plateShape`: the plain indexed
  `CarIO_Plate1[player]` form); `Loading_UpdateLoadingScreen` (`y`: the addend order
  `(checkpoint - 1) * 0x17 + 0x8e + i`); `Flare_Quad`/`Flare_QuadNotTransparent`/`Flare_TextureQuad`
  (`color_word`: colour store at the load position; `pkt_addr24` stays, every bump spelling is the same
  v0/v1 swap of the bump value, 4 diffs); `tScreenControllerConfig::Initialize` (`b`: store
  `player` where the load was; `mode`: chained `fTextConfig = fPrevConfig = ...`); `Movie_NextFrame`
  (`ret`: early `return -1`; `deadfrm` stays); `Movie_SetDecodeOffset` (`r0`/`r1`: `dec.rect->` and
  `(dec.rect + 1)->`, the indexed `dec.rect[1].` form is 27 diffs); `Hud_ParseTime` (`centi_total`:
  `nTime * 0x6400 / 0x4000`; `min`/`sec` stay, inlining them is 87-115 diffs). Falsified:
  `Camera_UpdateTVCam` (57/49), `Force_Vbl` `actuator1` (83/64), `Camera_UpdateAnimCam` post-decrement
  index (2 diffs per site: retail's decrement is `addiu 255`, i.e. an SImode subtract masked by the byte
  store, which the `--` form does not produce), `Hrz_SetDitheringPrim` `prev_val` (4), `Flare_Tri`
  `pkt_addr24` (4 in five spellings), `Night_GenerateNextLightningEvent` (10-16),
  `Flare_QuadRing` (5). Board 1819 -> 1823.
- Carrier round 3 (2026-09-26): the retail tree itself names the lever. A function-level `{ {} }`
  pair with no `this` is an inline call where we open-code an expression; a carrier whose register
  equals a MISSING retail local is that local under another name; a level with no recorded variable
  is a block whose local was optimised out of the debug records. Applied, all `symloop` BYTES UNCHANGED:
  `tScreenCarSelectTwoPlayer::GetCar` (`player` IS retail's `currentplayer`, $s5);
  `DrawW_CalcSubdivision` (`minz` IS retail's `z0`, $a1: z0 is the running minimum);
  `Hud_NextPlayer`/`Hud_NextPlayerNameOrCarOrTime` (`humanCar` IS retail's `carObj`, $s0; the
  sorted-list entry is read direct, and the SYM order is i, j, direction, carObj); `DrawCar`
  (the pair at +000 is a tick getter: `static inline long GetTicks()`, whose long return type
  supplies the signed remainder the `signedTicks` carrier staged); `Front_InitTourneyTraffic`
  (the pair at +000 is a current-tourney accessor, `static inline tTourneyInfo *CurrentTourney()`,
  the same index chain that 28 other frontend sites still open-code); `tScreenAudio::Cleanup`
  (loop level + pair: `while (SpeechLoading(&ginfo)) FeAudio_systemtask(0);` with a
  `static inline` taking the info pointer, which is what the `info` carrier held); `Front_AppendCopData`
  (a plain `for` whose body declares the looked-up car, no explicit block, no `carInfo` carrier; the
  body END note is hoisted to the ternary join at +104, and the loop is not rotated because jump.c
  will not duplicate the two-load bound); `tScreenControllerConfig::SetActuators` (pair inside the
  shaker compound: `static inline int GetTicks()` plus block-local tick/pulse; `pulse` still gets
  a register and stays EXTRA); `tScreenTournSelect::GetShapeInfo` (zero-length pair at the end:
  `*swapFileName = SwapFileName()`; `fe`/`useSpecial` remain, direct `frontEnd` reads are 3 diffs);
  `AIHigh_BTC_Wingman::UpdateFreezeModeAndPullOverMode` (the pre-clear value lives in the else
  compound, matching retail's if-level + inner level; the local still records); `strCallback`
  (`static inline void strCdCheck()` for the RGB24 CD-interrupt test: pair present, but retail's
  inner block starts at +018 after both tests and no condition-argument spelling keeps the bytes).
  Falsified: `tournPointsCompare` accessor forms (9 diffs, free or member inline alike: the +280
  base formation), `Camera_UpdateAnimCam`. Board 1823 -> 1831.
- Carrier round 4 (2026-09-26), same tree-reading method, all `symloop` BYTES UNCHANGED. Native CLEAN
  now: `tScreenTrophyRoom::GetShapeInfo` and `LoadTrophy` (one `static inline TourneyInTier(tier, cur)`
  replaces the open-coded index chain; GetShapeInfo has no block and no `cur`), `Replay_GetInput`
  (`Input_gSim.steering = ((signed char)x - '@') * 4`: the int-typed product keeps retail's `lb`
  where the `<< 2` form let gcc narrow the load to `lbu`; no `steering` block local),
  `tScreenCongrats::ProcessInput` (inner if-level with two pairs: `SpeechLoading(&ginfo)` and a
  `long` tick getter, no consume flag). Partial, tree closer but still DIRTY: `Camera_NextMode`
  (`splitBase` at function scope: retail's split-screen arm is not a declaring block),
  `AIState_Chase::SetUp` (four pairs: two `AIState_SpeedDir` selects and two delay-car getters; the
  inline parameters `speed`/`d` are recorded in ours while retail's pairs hold no variables, and
  `dc` must stay), `tMenuOptions::TransitionOn` (end pair = tick getter; the `tMenuItem_IsDisabled`
  pair inside the goto loop costs 2 diffs, and every for/while spelling of the walk costs 6),
  `AIHigh_Cop::CheckForWipeOut` (`AI_Rand()` inline for the RAND statement, a `GameTicks()` pair in
  the guard, `for (int hLoop ...)`; the pair retail keeps inside the loop body is unidentified, and a
  `WipeOutTickProb()` getter for `AI_elapsedTime * 89` breaks LICM, 75 diffs),
  `R3DCar_ReadInCarTextureMenu` (SYM order `filename`, `carType`; direct `shpfiles[index]` is 12 diffs).
  Falsified: `tScreenAudio::DrawForeground` inline clamp (25-31 diffs), `AIHigh_Execute` inline
  predicate (byte-exact with the `||` form, but the inline's `carObj` parameter is recorded and the
  addresses differ, so it was reverted), `CalcTrackFinishDamageBill`, `AudioCmn_Init`,
  `Hud_RenderStatsView`, `Execute__21AIState_RovingTraffic` (retail's levels are unexplained).
  Observation for the inline-pair lever: a pair with no recorded variable needs an inline whose
  arguments are constants or which has no parameters; a parameter bound to a loaded value is recorded
  under the parameter's name. Board 1831 -> 1835.
- Tick-getter round (2026-09-26). Retail's SYM records an inline-call pair at nearly every read of the
  frontend `ticks` counter: the counter was read through an inline getter, not directly. A per-TU
  `static inline int FE_Ticks(void) { return ticks; }` (or `ticks[0]` where the TU declares the array
  form), inserted once after the TU's include block, with every bare read in a function replaced by
  `FE_Ticks()`, keeps the bytes and reproduces the pairs. `build/tmp/ticks_sweep.py --apply` tried
  every DIRTY function that reads `ticks` (75), kept 63 (verify_asm PASS, pairs grew but did not exceed
  retail's), across 23 TUs; `symloop` BYTES UNCHANGED on all 23 (464 functions). Examples:
  `tCreditManager::SetupCurrCredit` 9 -> 25 of retail's 28 scopes; `tScreenCongrats::DrawBackground`
  gains its 14 pairs. Not kept: functions where the pairs would exceed retail's (the read is not a
  getter there, e.g. `PlaceIcons`, `SetPads`, `tDialogYesNo::Draw`) and `tDialogHelp::Draw` (bytes).
  Board 1835 -> 1857.
- The same getter sweep for `simGlobal.gameTicks` (`build/tmp/getter_sweep.py`, generalised: needle,
  getter name/type/expression) is NOT universal: of 49 DIRTY readers, 26 have no retail pair at all,
  and where a tick read is inside the getter's pair the scope total can still overshoot retail
  (`AIHigh_Cop::CheckForWipeOut` 13 vs 12 with a getter at the store site; `AIState_Chase::SetUp`,
  `Execute`, `AIHigh_Opponent::CheckForWipeOut` likewise) -- those four were reverted. Six AI
  functions kept a `GameTicks()` getter where the pairs grow within retail's count
  (`DoNitrous`, `HandlePullOver` (Player), `HighExecute` (BTC_AIPerp), `HudOn`, `NewStage` (BTC_AIPerp),
  `SetupBlockader`); all stay DIRTY, so this is a shape step, not a board step. Lesson: gate a
  getter sweep on the function's total scope count as well as its pair count.
- Getter sweeps for `menuDefs->` (`static inline tGlobalMenuDefs *MenuDefs()`) and `frontEnd.`
  (`static inline tfrontEnd &FrontEnd()`), same gate as the tick sweep plus a hand check of the total
  scope count afterwards: 41 functions kept by the pair gate, 8 reverted for overshooting retail's
  scope count (the read is not a getter there), `tScreenDisplay::DrawBackground` native CLEAN, the rest
  DIRTY but closer (e.g. `tScreenMain::DrawBackground` 37 -> 52 of 55, `tFEApplication::MainLoop`
  24 -> 50 of 70). Board 1857 -> 1858.
  OPEN: `femenudefs.cpp` cannot be gated by `symloop` at all -- its PRISTINE `-g` compile already differs
  from the normal one (the `tGlobalMenuDefs` constructor's frame is 640 bytes without `-g` and 608 with
  it; `gdebug_compile.py` reports CODE DIFFERS 6030 vs 6031 insns). Its sweep edits were reverted and
  the TU is excluded until that divergence is understood.
- Six more getter sweeps (`FEApp->`, `Cars_gNumHumanRaceCars`, `AI_elapsedTime`, `Cars_gNumRaceCars`,
  `Cars_gNumCars`, `screenMemcard->`): 35 functions kept by the pair gate, 5 reverted for overshooting the
  scope count, none native CLEAN (board stays 1858) -- the AI/frontend functions that hold these reads are
  the deeply DIRTY ones, so these are shape steps. `AI_elapsedTime` is never a getter (0 of 14 kept).
  Diminishing returns for the no-parameter getter lever; the remaining retail pairs are mostly `this`
  pairs (member inlines of Speech/AIHigh classes) and pairs inside deeper levels.
- Speech `this`-pair round (2026-09-26). Retail's Speech code is written against small inline members,
  and the SYM names them by receiver: a pair recording the outer `this` is a Speaker/MobileSpeaker
  member, a pair with no variables is an inline on a temporary receiver (e.g. `Dispatch()->Sub()`,
  `CallSign()->Dispatch()`) or a static getter, and a nested pair recording `carObj` is an inline
  calling an inner Speech inline. Added to `speech_class.h`: Speaker `SetArrest/SetUpdate/SetSub/To/
  From/Reverse/SetTo`, MobileSpeaker `SetPerp/MakeSpeaker/Voice/SetSpeedType/ClearCarObj`, Speech
  `SetSpeakerCar(carObj)`, `MultiplePerps()`, `Mobile/DispatchCallSign()`, `ClosestMobile/Dispatch
  Location(slice)`, CallSignBank `Dispatch()`. `MakeSpeaker` must be defined after `struct Speech`
  closes, or the inner inline is not yet available and gcc emits a real call. Native CLEAN now:
  `MobileSpeaker::Purge` (setters, natural fall-through, `while (Chain->Sub() != this)`), `CallSign`,
  `FindClosestLocationTo` (both speakers), `KnownPerp` (`for (int i ...)`), `Bullhorn`, `SetSpeed`,
  `Speech::Reset` (early return, `for (int i ...)` with `ClearCarObj()`), `RoadBlock` and `SpikeBelt`
  (the `ctx`/`dispatch` carriers are gone: `if (Dispatch()->Sub() != 0 && Dispatch()->Sub() != this)`,
  plain `Promote()`, `MultiplePerps()`, `SetTo(CallSign()->Dispatch())`). `MakeSpeaker()`/`Voice()`
  swept into 10 more MobileSpeaker functions (shape steps). Falsified: `GetCarBank` through a getter
  (the `fgSpeech` load moves ahead of the index arithmetic), `Speech::Dispatch` with a `result` local
  (8-11 diffs). `var_fn.py` now parses `Q`-qualified mangled names. Board 1858 -> 1869.
- Speech round 2: `ReportBlockade`, `Backup`, `DispatchSpeaker::Grant` and `Ready` native CLEAN, all
  carriers gone (`DISTANCE`, `requestCar`). Retail's local list gives each pair's receiver type in order
  (Speaker vs MobileSpeaker vs none), which pins the argument accessors left to right: `Voice()`,
  `Position()`, `Location()`, `Distance()`, `SpikeSide()`, `From()`, `To()`, `Reverse()`, `Colour()`,
  `Car()`, `Confirm()`, `BlockadeSlot()`. Two more lessons: a trailing call shared by both arms of an `if`
  belongs in each arm (retail's arm scopes close after gcc cross-jumps it); and an inline's parameter is
  recorded only when its argument is a real load -- `SetBlockade(Sub()->BlockadeSlot()->flags)` records
  retail's `Blockade`, `SetBlockade(Sub()->BlockadeFlags())` does not (and a member function named like
  that parameter also suppresses it). Board 1869 -> 1873.
- Speech round 3: `MobileSpeaker::ReActivate`, `DispatchSpeaker::Deny`, both `Activate` native CLEAN; the
  carriers `iVar3`, `iVar1`, `unit`, `bank` and `vs_RDBLK_SSTRP` are gone. `Voice`/`unit` in retail are inline
  parameters (`SetVoice(a->voice)`, `CallSign()->Mobile(fUnit)`), not function locals. In `Activate` the
  `SetReverse(GameSetup_gData.track & 1)` call is written right after `SetFrom` (retail loads `track` there;
  gcc schedules the store last). Board 1873 -> 1877.
- Shared type core (2026-09-26, user request). cc1 -g records every struct a translation unit DEFINES, used or
  not (probe: an unreferenced struct gets its full tag record), so the headers decide each object's SYM type block
  and one mega header would put hundreds of game types into every object. Retail's own blocks show the right
  shared set: 50 tags recorded by >= 99% of its 151 objects -- the PsyQ geometry/graphics structs, EA
  `shapetbl`/`cdstreamstruct`, SYS/TYPES.H and EA's file/thread typedefs. That core already lived in
  `frontend/psx/ea_psx_types.h` (reaching 149/150 objects through the `*_leaf_types.h` chain); it is now
  `recon/nfs4_types.h`, and its five unsigned shorthands (`u_char`..`ushort`) are declared after `size_t` as
  retail records them (the SDK structs spell their fields `unsigned char` etc.). New gate
  `tools/psyq_pipe/tagset_cmp.py`: per source file, retail vs ours type-record sets and per-kind order (retail
  emits all tags of an object before its typedefs, our cc1 interleaves them -- an emission difference, not a
  source one). Result: the core's order now matches retail in 92 of 150 files (was 1); 46 differ only by
  function-level typedef re-emissions (cc1 re-emits the typedef of each struct a function uses; retail does this
  too, 19,861 repeats, for different types), 8 are retail objects sharing one source name, 5 need a closer look
  (MDEC, MEMCARD.C, DEVICE, FEINPUT, DRAWW/FLARE). Bytes, board (1877) and the whole SYM text otherwise
  unchanged. Whole-object totals today: retail 55,436 tag records, ours 46,005, 13,042 missing, 3,611 extra,
  0 files exact -- the game-type tiers are the remaining work (e.g. `GameSetup_tData` is defined in 41 headers).
  To rebuild the full debug SYM: `gdebug_compile.py` (no args), then `psylink_lane.py` with `NFS4_LANE_G=1
  NFS4_LANE_OUT=build/psyq_g`, then `symtree_cmp.py build/psyq_g/nfs4_sym.txt`.
- Type dedup, step 2a (2026-09-26). `tools/psyq_pipe/dedup_types.py --apply`: 154 game types that were defined
  identically in 2-41 headers each (854 copies: `Sched_tSchedule` x41, `TCB` x32, `Sim_tSimGlobalVar` x26, ...) now
  have ONE definition in `recon/shared/<Type>.h`; each former copy is `#include "shared/<Type>.h"` at the same
  place, padded with blank lines so the header keeps its line count. Every object therefore compiles the same tokens
  in the same order: program bytes, the board and the ENTIRE SYM text are byte-identical to before (checked by
  comparing the full debug SYM). Excluded on purpose: classes with inline member bodies and derived/virtual classes
  (13, e.g. `AIHigh_Player`, `AIHigh_BTC_Wingman`, the dialog/screen subclasses) -- the code they emit, including
  compiler-generated destructors, records the class definition's file and line, so they must move as part of their
  retail module header (`AIHIGH.H`, `FEDIALOG.H`, ...), not into a per-type file. Also left: 134 types whose copies
  differ (e.g. `GameSetup_tData` has 3 bodies in 41 headers, `EXEC`/`DIRENTRY` 2, `tScreen` 7); each needs its
  copies reconciled against retail's member records before it can be shared. `header_groups.py` groups retail types
  by co-occurrence as a first map of the original headers; most groups are single types because retail objects
  include headers selectively.
- Type dedup, step 2b (2026-09-26). `dedup_types.py --canon --apply` also shares types whose copies differ only in
  spelling (`tools/psyq_pipe/type_canon.py`: comments dropped, `u_short`/`u_char`/... expanded, elaborated
  `struct X` members reduced to `X`, one declarator per declaration). 34 more types / 365 copies now have one
  definition (e.g. `GameSetup_tData`, `EXEC`, `POLY_FT4`, `SPRT`, `kernpair`, `charactertbl`, `tfrontEnd`). Program
  bytes, board 1877, tag totals and the ENTIRE debug SYM are byte-identical to the step-2a SYM. Trap found on the
  way: the first run took the most common spelling, which used `u_short`/`u_char`; `font_obj_types.h` defines
  `kernpair`/`charactertbl` BEFORE those aliases are typedef'd, and cc1 silently dropped the unparsable members
  (`kernpair` 8 -> 4 bytes, `charactertbl` 11 -> 3). The honest byte gate stayed green; only the debug-lane SYM
  moved (Font_Blit -12 bytes, everything after it shifted). The shared definition now keeps an alias-free spelling
  whenever one copy has it. The full debug-SYM compare is therefore the gate for header refactors, not only the
  byte gate. Then `type_canon.py` also folds `signed short/int/long` (tTexture_ShapeInfo), and
  `dedup_types.py --except NAME@header` leaves out a copy that retail shows is a different definition:
  `tools/psyq_pipe/member_cmp.py` compares member records per source file and finds DIRENTRY recorded with
  `unsigned char` arrays only in retail PAD.C, exactly like our `pad_types.h`, so that copy stays and the other 30
  are shared. SYM still identical. member_cmp's summary: 361 of our multi-file types record exactly retail's
  members, 10 differ (Sim_tSimGlobalVar, Speech, tScreen, tMenu, ...), 9 have several retail definitions. The 97
  types still listed as differing are classes whose copies declare different member functions (33 differ only
  there) or carry class-body extras: they move with their retail module headers (step 2c).
- Step 2c, first member-record fixes (2026-09-26). The game objects saw the frontend menu roots as trimmed
  "layout-only" copies with only a virtual destructor, so our SYM gave them 2-slot vtables where retail records
  tListIterator 6, tMenuItem 11, tMenu 11 and tScreen 10 in every object. `recon/shared/fe_menu_game_surface.h` now
  holds the game-side family once (audiocmn, gmesetup, pausemenu, mmeffect) with retail's full virtual lists, and the
  MMEFFECT/NFS3 tScreen copies include `fescreen_virtuals.inc`. Retail's game objects define neither tPlayer nor
  tInputKeyType, so those surfaces spell them `int` (the `felist_classes.h` idiom). Bytes unchanged; the SYM changes
  in exactly 41 `.vf` member records (dims 2 -> 11/6/10); tListIterator, tMenuItem and tScreen now record retail's
  members in every object. Open member differences (`member_cmp.py --summary`): FEMENU's tMenu sees tScreen complete
  (retail: incomplete, pointer size 0); CAMERA's Sim_tSimGlobalVar sees Sched_tSchedule incomplete; FRONT.CPP defines
  2-member stubs of tCreditManager/tFEApplication/tGlobalMenuDefs that retail FRONT does not record; Speech is a
  1-byte stub in six AI objects; AIHIGH.CPP records AIHigh_BTC_AIPerp. Retail records Sim_tSimGlobalVar ONLY in
  SIM.CPP (we record it in 33 objects), so the other objects reached `simGlobal` without that type -- open question.
- FEMENU order fix: `femenu_types.h` now defines the item classes and tMenu first, then tShapeInformation, tScreen,
  tActiveLine and the dialog family in retail's order (Base, Help, MessageString, WithTimeout, NoInput, Interactive,
  YesNo). FEMENU's tMenu now records `fScreen` as a pointer to an incomplete tScreen, as retail does. Bytes and board
  unchanged; `member_cmp.py --summary`: 365 SAME, 6 left (Sim_tSimGlobalVar, Speech, the three FRONT stubs,
  AIHigh_BTC_AIPerp).
- Two retail type-record patterns our cc1plus does not produce from any source form tried (standalone probes with the
  same CC1PLPSX, and the PsyQ 4.4/4.5 2.8.1 builds): (1) REPEATED tags -- retail records BO_tNewtonObj twice in 111
  objects, TCB in 53, tMenu in 50, tScreen in 32, AIPhysic_BrakeInfo in 18 (804 repeats in all; ours has none beyond
  the doubled objects). A repeat is either back to back with identical members (BO_tNewtonObj, TCB) or a first record
  where the type is first needed and a second at its definition (tMenu, tScreen); both carry the complete layout.
  Forward declarations, `typedef struct X X`, anonymous typedef structs, `const` variants, prototypes, array externs,
  by-value members, derivation, in-class inlines, `#pragma interface` did not repeat a tag. (2) SUPPRESSED tags --
  retail FRONT.CPP allocates tFEApplication/tGlobalMenuDefs with `new` (complete types needed) yet records neither,
  and only SIM.CPP records Sim_tSimGlobalVar although ~30 objects read `simGlobal.gameTicks`. Our cc1plus records
  every struct a unit defines. Both point at how retail's headers presented these types (or at a debug-emission
  difference), not at member layouts; they account for much of the tag-count gap (missing 13,042 / extra 3,611).
- Speech round 4 (2026-09-26). Byte-unchanged (symloop) and CLEAN: `Speech::Dispatch` (one `result`, the
  fallback first: `if (!fgSpeech || !fgSpeech->fBankOffset) result = fgUndefined; else result = fDispatch;` --
  the early-return form matches bytes but lets gcc drop `result`); both `GetCarBank`s (one variable-free inline
  pair = a STATIC inline taking the register index, `Speech::MobileCarBank(carIndex)`); `LocationBank::Distance`
  (retail records no locals and no inline scopes: a `SPEECH_MIN` macro over the two distances, first test
  `fStartSlice > fEndSlice` so start loads first); `Speech::FindMobile` (each loop calls one inline on
  `fMobile[i]`: `IsCar(carObj)` = `carObj == fCarObj`, which records this+carObj, and `IsFree()`). speech.cpp
  62 -> 67 CLEAN.
- Speech round 5. Byte-unchanged and CLEAN: `CalculateBankSize` (`for (int i ...)`; IsHeader reads the four
  extension chars into locals a-d from a COMPUTED pointer `c - 4` -- a plain variable argument (`c`) is recorded
  as a parameter row, a computed one is not; the '.', 'h', 'd' stay constant arguments because they decide the
  constant hoisting); `CheckCallSignBank` (`i` in its own block around the un-rotated loop); `CheckLocationBank`
  (`for (int i ...)`, and the Set call BEFORE `match = 1` so the inline's body block is empty as in retail);
  `FindClosestLocationTo` (locals in their scopes, `if (locationbank->BankId() == -1) continue;` -- a bool
  predicate inline loses the hoisted -1 and two saved registers -- and `else return 0;` so the if-scope reaches
  the function end). speech.cpp 71 CLEAN.
- Speech round 6. Byte-unchanged and CLEAN: `SubmitRequest` (locals declared in the `if` block; a static
  `ResetStatus()` inline for the dispatch status reset and an instruction-free static `Idle()` inline right after
  the bank offset -- retail records a variable-free pair exactly there -- which also retires the empty `__asm__`
  barrier the old spelling needed; `else return 0;`); `Speech::Speech()` (DispatchSpeaker has NO user
  constructor: `new DispatchSpeaker` then expands only the base Speaker() pair, while MobileSpeaker's user
  constructor adds a body block); `Speaker::SetCar` (CarBank getters `Full()`/`Model()` on GetCarBank's temporary
  = variable-free pairs; `if (MultiplePerps()) SetColour(c); else SetColour(c | 0x78020);` with SetColour a plain
  setter -- the computed argument is why the second pair records only `this`). speech.cpp 74 CLEAN.
- Speech round 7: `MobileSpeaker::Catch` CLEAN (was the goto/carrier spelling). Retail's pairs map one-to-one
  onto accessor calls in the SPCHNFS argument lists; new Speaker accessors PerpName/SetAmbulance/Ambulance/Arrest
  and MobileSpeaker::DelayStatus (defined after struct Speech). The first test is an early `return` (no scope),
  so MakeSpeaker's pair sits at body level as in retail. Bytes unchanged; speech.cpp 75 CLEAN.
- `Speaker::Promote` CLEAN: `while (Super->Sub() != 0 && Super->Sub() != this) Super = Super->Sub();` then
  `Super->SetSub(this->Sub()); this->SetSub(Dispatch()->Sub()); Dispatch()->SetSub(this);` -- retail's five
  trailing pairs, the last recording SetSub's parameter `Sub` = this. The `cont` carrier is gone. 76 CLEAN.
- `MobileSpeaker::Lose` CLEAN, and its whole carrier apparatus (voiceArg launder, iVar3, perpCar, outOfRange,
  savedDispatch, dispatchThis/finalDispatch) is gone: the accessor spelling retail's pairs imply is byte-exact on
  the first try. Two readings from the SYM: a Speaker pair that emits no code right after BlockadeFlags() is a
  REPEATED `ArrestFlags() == 0` test that gcc folds on the path where arrest is already known zero; and the final
  save/Roger/restore keeps its saved value in `Speaker *saved = Dispatch()->Sub();` which gcc copy-propagates, so
  the variable (and SetSub's parameter row for it) leave no record -- exactly retail's variable-free last pair.
  77 CLEAN.
- `MobileSpeaker::Status` (358 instructions) CLEAN with the accessor spelling, byte-exact on the first try; the
  carrier locals and BOTH `__asm__("" : "+r"(branchVoice) : : "$2")` clobbers are gone. New accessors UpdateFlags,
  HavePerp (Speaker), Speed/SpeedType (MobileSpeaker), AllUnits (CallSignBank). Block extents: PlaySpeech belongs in
  each arm (gcc cross-jumps them into one call) so the if-chain spans the function, and the two arms that must skip
  PlaySpeech just END (no `return;`) -- a trailing `return` makes gcc extend the arm's block to the next arm.
  78 CLEAN.
- Both `Report`s CLEAN with the accessor spelling (MobileSpeaker: trailing `Dispatch()->SetSub(this)`;
  DispatchSpeaker: `ClearSpeaker()`, `KnownPerp(perp) && Sub() != 0`, `SetTo(CallSign()->Mobile(Sub()->Unit()))`,
  `SetTo(CallSign()->AllUnits())`) -- carriers and one more empty `__asm__` barrier removed. 80 CLEAN.
- Both `Roger`s CLEAN with the accessor spelling (DispatchSpeaker: every access to the sub goes through `Sub()`,
  e.g. `Sub()->BlockadeFlags()`/`Sub()->ArrestFlags()`/`Sub()->UpdateFlags()` = a `this` pair for Sub() plus a
  variable-free pair on its temporary). MobileSpeaker::Roger's zero-byte `__asm__` identity carrier is gone. 82 CLEAN.
- `MobileSpeaker::Engage` (467 instructions) CLEAN, byte-exact on the first try with the accessor spelling; the
  goto/carrier form (superReady, pursuitReady, condition, repeatReady, the reply/sighted/engage staging locals) is
  gone. Two SYM readings: a list-walk advance `SubChain = SubChain->Sub();` records a VARIABLE-FREE pair (gcc does
  not give the inline's `this` its own copy when the result overwrites the receiver), and retail reuses `SubChain`
  as the saved dispatch sub around `Dispatch()->Report(Perp())` -- that restore pair records `Sub` = SubChain.
  SetPerp's parameter is `car` (retail's name). speech.cpp 83 CLEAN.
- `DispatchSpeaker::Status` (366 instructions) CLEAN with the accessor spelling: a plain early
  `if (Sub() == 0 || Sub()->Perp() == 0) return;` (the old two-stage `initialInvalid` flag was a carrier -- the
  oracle's s0 flag is gcc's own `||` materialization), `Sub()->Sub()`/`Sub()->Update()` pairs, and the update switch
  in retail's case order 2 -> 0 and 3 (else-if distance test) -> 1 with fall-throughs. 84 CLEAN.
- `DispatchSpeaker::StatusReply` (269 instructions) CLEAN, and the W69 `__asm__("" : "=r"(wing) : "0"(wing) :
  "$7")` launder seal is no longer needed: retail's pairs show the spike arm writing the wing through `SetWing()`
  and passing `Wing()`, which reproduces the $v1 -> $a3 copy by itself. Also: the fallback arm reads
  `CallSign()->AllUnits()`, the backup arm fetches `Sub()->Sub()` into a copy-propagated local before the counter
  stores, and the final test is `Sub()->SetBlockade(0)` on the direct sub. 85 CLEAN, 2 DIRTY (FindLocation,
  LoadBankHeaders).
- `Speaker::FindLocation`: lower half now in accessor spelling (SetDistance/SetPosition setters, SetLocation(loc)
  = `fLocation = loc->BankId()` in BOTH arms -- retail's no-location arm really reads the null bank,
  `lw v0,8($zero)`, and only the literal `SetLocation(0)` keeps that load). Still DIRTY: the slice look-ahead.
  Retail records no local there and calls fixedmult six times, but without the `advance`/`offset` carriers the
  quotient is allocated to $v0 instead of $v1 -- all 64 operand orders of the six sums, flipped/negated/subtracted
  conditions, a short-typed slice and a statement expression stay at 12 diffs. Next angle: the division spelling
  itself (a helper macro with its own cast/shift) or a copy-propagated local.
- Session total (2026-09-26): speech.cpp 62 -> 85 CLEAN; whole board 1877 -> 1900 CLEAN; honest link 0 diff.
- Still open in speech.cpp (receipts for the next angle):
  * FindLocation slice look-ahead: side-by-side shows the only difference is the `addu` in the two range tests --
    retail makes the SLICE register the destination/first operand with the fixedmult call evaluated first.
    `A + S` evaluates the call first but ties the sum to the quotient; `S + A` loads the slice before the call
    (+2 instructions). A statement expression `({ int ahead = A; S + ahead; })` is byte-exact but records
    `ahead` (+7 scopes); the committed spelling keeps the `advance`/`offset` carriers.
  * LoadBankHeaders: a from-scratch natural spelling (ReadBE32/IsHeader/IsData pointer inlines, for-scoped loops,
    else-if chain) is count-exact at 28 diffs in two regions. (1) Retail reads header[8] before advancing
    `header`: only `ReadBE32(header + 8)` gives that order, but then `header` loses s0 to the "spch temp" pointer
    (header 5 refs/72 insns vs string 3/52 in the -dl dump; the tie is not decided by priority). (2) The IsHeader
    result pseudo (6 refs / 12 insns, global-alloc priority 1.0) loses v1 to the character loads (4 refs / 5 insns,
    1.6); the old `__asm__` fence adds exactly the two references that flip it. Inline shapes (int/bool, declare
    order, if-return, ?:, negated ||), `!= 0`, `== true` and optimized-away locals in the header arm do not.
    Tools: build/tmp/va_side.py (side-by-side verify), CC1PLPSX -dg/-dl on build/recon/.../speech.cpp.i.
    Dump detail for (1): header = pseudo 81 (5 refs, local-alloc priority higher than the "spch temp" pointer, pseudo
    119) yet 119 takes s0; retail's s0 sharing of header and ReadBE32's `p` needs sched1 to hoist the folded
    `lbu 8(header)` above `p = header + 8` so header dies at p's definition and local-alloc ties them.
- aih_btccop.cpp probe (not committed): retail's pairs there record `this` typed AIHigh_BTC_HumanCop, i.e. inline
  MEMBERS of HumanCop, yet retail has no out-of-line copies of them. cc1plus 2.8 emits a copy of every inline member
  of a class whose vtable the TU emits (standalone probes: top-level, nested and derived classes alike), which is
  why speech.cpp carries `no_implement_inlines`. With that flag aih_btccop's current bytes are unchanged, and
  SetDesiredSpeed spelled `CarObj()->desiredSpeed = req < curveSpeed ? req : curveSpeed;` is byte-exact with retail's
  two pairs -- but `curveSpeed` (retail REG $2) is copy-propagated away in every byte-exact spelling tried
  (in-block init, declare-then-assign, function level, swapped compare), and the clamp spellings that keep it
  cost an instruction (the car load moves after the branch). Next: find what keeps curveSpeed in v0 in retail.
- AI lane build flag (user decision 2026-09-26): `no_implement_inlines` for the AI translation units, so inline
  MEMBER accessors (retail's `this`-typed pairs in AIHigh/AIState classes) no longer force out-of-line copies that
  retail does not have. Set on 22 of 25 `recon/game/common/ai*.cpp`; NOT on aih_basicperp, aih_btcperp and aistate,
  whose objects carry retail inline virtual destructor copies the flag would suppress (bytes moved). Every flagged
  file gated byte-unchanged (symloop; aidebug/aispeech have no retail functions and are covered by the link), honest
  link 0 diff, full debug SYM byte-identical. Five stale symloop references (rodata-prefix only) were re-adopted on
  the honest-link proof with `ref_refresh.py --proven`.
- aih_btccop round 1: HumanCop::HighExecute, UpdateAndCheckTimeLeft, Wingman::SetupWingman CLEAN (17 -> 20). Retail's
  variable-free pair there is the existing static helper `AIHigh_GetCarObj(other)` reading ANOTHER AI object's car
  (`perpTarget_`, `humanCop`) -- its parameter leaves no record -- plus `coorddef notUsed` scoped to its if-block.
- aih_btccop 20 -> 28 CLEAN with the new flag: HumanCop/AIHigh_Base/AIHigh_Traffic/AICop_BasicPerpInfo accessors
  (CurrentStage, InitialDirection/Movement, SetRequestedDesiredSpeed, CarObj, SetForcePurgatory, Crime), for-scoped
  loop locals, `continue` guards, a copy-propagated `result`, else-if chains. AIHigh_Base::SetState is now a MEMBER
  inline (retail pairs: this + newState) in the flagged TUs. aih_cop CheckForWipeOut: one more retail pair, still
  DIRTY (`skipWipeOut` flag). Board 1900 -> 1911 CLEAN; honest 0 diff.
- aih_btccop 28 -> 33/33 CLEAN (SetDesiredSpeed, HumanCop ctor, NewStage, SetupBlockader, Wingman::HighExecute), all
  byte-unchanged. What retail's records gave:
  - Accessor names come from retail pair PARAMETERS where another site passes a variable: NewStage records
    `SetInitialDirection(initialDirection)` / `SetInitialMovement(initialMovement)`; an aih_cop function records the
    Chase inline's `minTimeInZone`/`minLatMetersDistance`/`minLongMetersDistance`. Wingman::HighExecute calls it
    with constants (`chaseState->InMurderRange(8, 0xe0000, 0xf0000)`), which is why retail compares against
    constants held in registers: inline parameters are variables at tree level, so fold cannot canonicalize the
    compares, and constant arguments leave no rows.
  - Empty pairs inside one basic block are collected at the block head by the scheduler: the ctor's three setter
    pairs all sit at +0, the NonActive ctor + SetState pairs of a case at the case head. A pair whose body spans
    basic blocks keeps its real end (InMurderRange +3fc..+448).
  - Six `CarObj()` pairs on ONE retail line (SetupBlockader) = a macro that expands its slice argument several times:
    `SLICE_ADD(slice, delta)` (wrap into [0, gNumSlices)). It replaced every per-branch wrap and its carrier locals.
  - `x = x < K ? x : K` with a literal K is folded to MIN_EXPR(x, K) = an in-place clamp. Retail's
    `a0 = K; if (x < a0) a0 = x; x = a0` is MIN_EXPR(K, x), which fold builds only when the bound is not an
    INTEGER_CST at fold time: a named bound (`int maximumDistance = 0x5dc0000;`), which gcc propagates away, so it
    leaves NO record. `const` locals/globals and g++'s `<?` fold like the literal.
  - A `mult` by a register constant with no record: `initializationDistance / 0x60000 * side` with a local
    initialized to a constant (CSE folds the division, the operand stays anonymous).
  - The inlined AIState_NonActive ctor records `trafficOffset` two blocks below its body block in every retail
    expansion; two plain brace levels reproduce it (no code).
  - A `goto` at the end of an if-arm stretches the arm's block over the jump (as `return` does); the case's own
    trailing goto is enough.
  - Spike-belt helpers are free static inlines (`SpikeBelt_Set/Freshen/SetFreshenTime/SetActive/Slice`): member
    functions on the shared `AICop_spikeBelt_t` added four TPDEF records.
  - Dead copy warning: aih_btccop.cpp carried an `#if 0` old Wingman::HighExecute ahead of the live one; `var_fn.py`
    splices the FIRST textual match, so a variant "PASS" there was the untouched live function. The dead copy is
    removed; check for `#if 0` twins before trusting var_fn on a file.
- aih_cop 4 -> 6/9 and aih_play 1 -> 2/9 CLEAN (CheckForNeedyPlayers, CheckForNewTarget, CleanupBlockaders), all
  byte-unchanged; CheckForNewTriggers lost its `volatile copType` read and perpInfo/type carriers (bytes exact, still
  DIRTY on scope shape). Accessors added to the shared hierarchy header: AIHigh_Base::CarObj(),
  AIHigh_BasicCop::BlockadeMode()/Blockade(), AICop_BasicPerpInfo::CopsAssigned(type), AIHigh_Player::ChaseLevel()/
  LastPullOverTime(); free inlines on the embedded chase info (PerpChase_CopFreeTicks/ChaseLevel) in aih_cop.cpp.
  - A pair with a computed receiver (`&thisPlayer->basicPerpInfo_`) DOES record `this` when that address pseudo is
    reused by a second accessor (CheckForNewTriggers: CopsAssigned's `this` REG 3); two accessors on it CSE the
    address into one register, which retail avoided in CheckForNewTarget by computing `needs` as a ternary.
  - OPEN CheckForNewTriggers: retail's Player inline (param newSlice, local temp) returns the old lastTriggerCheckSlice_
    into an anonymous register that both min/max arms copy from. Caller spellings (7 tried) coalesce it with
    startSlice/endSlice (10-16 diffs); reference outputs spill (140 diffs). Early return + `continue` guards + the
    accessor set are otherwise byte-exact (W3 in build/tmp/ntr_W3.txt: 10 diffs, only that split).
  - OPEN HandleCops: retail = early return, `perpChaseInfo_.GetChaseLevel()`, then ONE AICop_PerpChaseInfo inline with
    parameters ticks/totalCopsEngaged (+ a computed direction flag) holding the whole engagement update, with nested
    GetEngagementSeconds()/GetChaseLevelSeconds() pairs. Two `CopsAssigned()` calls fix the load order; the last
    5 diffs are the engagementTime_ store: retail stores through the Player base (140(s1)) and reloads via the inline's
    `this`, ours stores through `this` (0(a1)). Receipts: build/tmp/hc_combo.py, hc_combo2.py.
- aih_traf 1 -> 3/5 (CopCheck, CheckForCops) and aih_opp 2 -> 4/5 (DoProvokedAttack, HighExecute) CLEAN, bytes unchanged.
  - Placement-new spellings (`new((T *)operator new(n)) T(...)`) add a variable-free pair (the inline placement
    `operator new`); retail uses plain `new T(...)`.
  - A `break`/`goto` inside a case compound stretches the case block; retail puts `break` after the `}`.
  - A then-block with no records but emitted = a local declared there that gcc propagates (DoProvokedAttack otherCar).
  - Member inlines ALWAYS record `this` (even single-use); plain parameters used once are propagated (no row). A
    retail pair with only `trigger` therefore comes from a free inline, but passing the AI object as its first
    parameter records it (`high`) -- traffic HighExecute is byte-exact and fence/carrier-free but still DIRTY on
    that row and on where retail closes the type==5 then-block (before the reencarnate pair).
  - `idleState = (AIState_Idle *)this->state_` right after SetState is how retail gets the object for
    SetIdlePosition (CSE turns the reload into `addu a0,s0`); the first of the two idle blocks is nested one extra
    brace level in retail.
  - OPEN aih_opp CheckForWipeOut: a clean rewrite (chase-level/crime/CopsAssigned accessors, early returns, for loop,
    propagated `speeding`/`lowLevel` temps) is byte-exact up to the loop body with NO asm fences; 4 diffs remain
    (sched order of the thisPlayer/playFines/level loads). Receipt: build/tmp/ow_best_4diffs.txt.
- aih_basiccop 3 -> 8/8 CLEAN and aihigh 4 -> 5/7 (AIHigh_Base ctor) -- board 1930, bytes unchanged.
  - A block with no records that retail still emits (CheckSpikeBelt's two ifs) = a local that gcc propagates:
    `int slice = SpikeBelt_Slice(); if (!AILife_IsSliceInAnyVisibleArea(slice)) ...`.
  - `!Inline()` in the caller gives retail's `sltiu` where every in-inline negation spelling folds to `xori`
    (`return !(a < b)`, `== 0`, `?:`, bool return).
  - Blockade_AddObject: rotx/roty/rotz are the three row pointers into theObj.orient declared up front.
  - OPEN AIHigh_Execute: retail's predicate inline (scheduling-off || Sched_ExecuteCheck(...carObj...)) records no
    rows although it uses carObj four times; every parameter spelling records the car parameter.
- Board 1930 -> 1946 CLEAN (aicop 4/4, aiphysic 26 -> 34/42, ai 28 -> 33/40, aih_play MaintainAvailableCops partial),
  bytes unchanged, 0 regressions.
  - NEW LAW: a declared-but-UNUSED scalar local makes gcc emit its block with NO record (no RTL -> dbxout skips it).
    Retail blocks that exist but carry no records (AI_AvoidSpikeBelt's then-block) are reproduced that way. A USED
    local that is only propagated can still be recorded (register -1), and an unused local in a for-init's second
    declarator is recorded one scope late -- so the unused-local reading applies to plain block declarations.
  - Locals whose retail value differs from ours: SimplePhysics `speed` is the lateral speed (laneChangeSpeed *
    direction); SimplePhysics_LatVel `carSpeed` is the absolute speed; ShouldIPerformCutOffBlock `metersBetween` is the
    signed spline distance and `carLength` the target length term.
  - Compare operand order decides the load order: `simGlobal[1] <= tick` loads gameTicks first (HandleWipeoutTimer).
  - `x > limit ? limit : x` with a named `limit` gives retail's clamp shape (GetRearEnd) but the bound is recorded;
    SetupBlockader's `x < max ? x : max` propagated it. Open: GetRearEnd, RevEngine's record-less 8-byte frame,
    ChangeDirection's `&simGlobal` base register, AI_HandleTrafficHonking (honkprob must exist for the load order).
- Frontend round (fetourn 19 -> 32/35, screencongrats tScreenTournamentCongrats::CalculatePrizes), bytes unchanged.
  - A member inline gives TWO blocks: the parameter level (records `this`) and its body. Retail's
    "pair + nested pair with `this` in the outer" is one member inline, not two inlines. fetourn's
    `tTournamentManager::CurrentTourney()` (`&fDefinition->fTournaments[fTiers[fTier].fTournOffset + fTournament]`)
    turns nine functions CLEAN; the functions that lost the `this` REGPARM record entirely were the ones retail
    wrote through it.
  - Free accessor pairs at entry: the new-car-stats list, carManager.fNumCars (Initialize: one call per
    garageCar store, not a reused value), the competitor array (tournPointsCompare's `tm` carrier),
    tournamentManager.fMoney, the best-placement byte (pass the id, not `tourn`, or the inline's parameter is
    recorded as an EXTRA REGPARM).
  - StartNewTournament rewritten carrier-free: `if ((this->fDirection[i] = track->fDirection) > 1)` gives retail's
    reload of the track byte after the store; `x = f; if (f > 1)` CSEs it.
  - Open: LoadDescription (retail reloads fDefinition at each use with no local; spelling it directly changes
    CSE/regalloc, 77 diffs); UpdateTrackFinishPoints `stats` (held &dummyCars[k]) and `ranking` (retail forms
    this+i from the counter register; every for/do spelling folds it to this+5 -- 2 diffs); GetTrophyName's
    short selection (fold pushes `(short)` into the ?: arms; only a named short temp keeps the sign-extension
    after the merge, and it brings a block); screencongrats PinkSlip `player` (1 - fWinner held in s1 across
    the licence calls with no record).
- femenuextended 44 -> 52/53 and front Front_GetLapsForType, bytes unchanged.
  - Per-TU member inlines on classes whose key function lives elsewhere: guard them with a macro defined only in
    the owner's _types.h (`NFS4_FE_CORE_MENUITEM_ISENABLED`, `NFS4_FE_LIST_SELECTION_INLINE`, following the
    screencarselect precedent), so FEMenu.obj (the key-function TU) never sees them.
  - Member vs free is read straight off the record: a `this` of the BASE class type (tMenuItem, tListIterator,
    tFEApplication) = member inline on that base; a variable-free pair = free inline (parameters used once, or a
    constant global argument).  tMenuItem enabled test exists in both forms: member `(fFlags & 1) == 0` in the item
    Draw bodies, free `((fFlags ^ 1) & 1) != 0` in the menu loops (the xor form fixes the xori/andi order).
  - A for-init counter that loop strength reduction replaces by a pointer walk leaves its scope with NO record
    (tMenuOptions::TransitionOn: `for (int i = 0; ...)` reproduces retail's record-less for-scope).
  - `const` locals with initialisers are not recorded; they hold inline results the scheduler keeps in registers
    (tMenuNFS4::Draw image/frames).
  - Open: Front_EnableLocalSpeech (block end must precede the final return copy; the goto form crosses `lang`'s
    initialisation), MenuNFS4_DrawTextBox (asm-pinned carrier block).
- femenuoptions 61 -> 70/83 (board 1990), bytes unchanged.
  - More guarded per-TU members: tListIterator MinValue/MaxValue (`NFS4_FE_LIST_RANGE_INLINE`), tMenuItem
    Enable/Disable (`NFS4_FE_CORE_MENUITEM_SETENABLED`), tScreenControllerConfig::ResetShakeTimeOut
    (`NFS4_SCREENCONTROLLER_RESETSHAKE_INLINE`), tFEApplication::CurrentScreen in femenuoptions' own copy.
  - DrawSlider's range arguments are `fData->MinValue()` (member, records the iterator) + a free max accessor, in
    every slider Draw and in Percentage.
  - An if-scope that holds a pair: move the call into a `T *const x = ...;` snapshot before the if (unrecorded).
  - An else-if chain whose repeated test is removed by jump threading (tUserNameMenuItem::TransitionIsFinished:
    `else if (dir > 0 && val < 0x80) ... else if (dir > 0 && Busy())`) gives retail's late-starting scopes.
  - Register-swapped names (MOVED col/col2) = the names are the other way round.
  - Open: tMenuItemLeftRightAudioSlider::UpdateTransition (clamp without a local; const snapshots 8 diffs),
    tMemoryCardMenuItem::Draw (volatile carrier), UpdateTransition__12tOptionsMenu (goto carriers).
- screencarselect 39 -> 47/56 (board 1998), bytes unchanged.
  - A `while` counter loop has no scope; the same loop as `for (j = 0; ...)` gives retail's loop scope when the body
    holds an inline block (DrawSliders, both multiplayer DrawForeground).
  - An inline parameter bound to a bare variable argument is recorded (SetPosition's `player`, OtherPlayer's
    `player`); a converted argument (`(tPlayer)(short)player`) is an expression and propagates.
  - One `GetPlayer()` feeding two uses = a `const` snapshot (unrecorded) + free accessors on it.
  - If-scope ending after the fall-back return = `if (ok) {...; return 1;} else { return 0; }`.
  - Goto dispatch over sparse states was a `switch` (SetState: case 0/2/5/6).
  - VSync `ticks`: a volatile-reading free accessor keeps both loads batched (Initialize, SetState).
  - Open: GetCar `color` (a const needs braces in the case -> extra block), DrawVideoWall (two record-less wrapper
    scopes around both GetPlayer pairs; a free wrapper inline loses the delay-slot init), the DrawBackground set.
- hud 37 -> 45/62 (board 2006), bytes unchanged.
  - `if (...) { for (int i ...) }` reproduces retail's if-scope/then/for-scope triple (Hud_Reset, BTC_QuitOut,
    BustedOverlayOn); locals one level deeper than the function block = an explicit inner `{ ... }` (InitMapFrame).
  - `const` locals are unrecorded only when their value is propagated: `const short min = nTime / 6000;`
    (ParseTime) leaves no record, but a const loop bound living in a register across the loop IS recorded
    (InitMap keeps its one carCount carrier).
  - A param moved to another register (MOVED time) = the source reassigns it; spell the expression at each use
    (`abs(time)` twice, CSE merges them) so the param keeps its incoming register.
  - Open: BuildDistanceString (retail keeps `dist` live in $t1; abs spellings 12 diffs), Draw321Num (i/j swap + by2),
    the Build*/Render* carrier sets.
- const-snapshot sweep (board 2006 -> 2020, EXTRA records 997 -> 961), bytes unchanged.
  - A single-assignment carrier written as `const T v = e;` leaves no record when gcc propagates the value (it
    is used once, or folded into addresses); when the const still owns a register across a loop or call it IS
    recorded, so such edits are useless and are reverted.
  - Tool: `build/tmp/const_sweep.py REL` (per DIRTY function: const-ify each EXTRA var with exactly one
    assignment, keep only verify_asm-PASS edits, re-measure with symloop, undo edits whose EXTRA survives) and
    `build/tmp/const_sweep_all.sh FILE...` (runs it over many TUs and commits each file that improved).
    Round 1 kept edits in 13 files (flare, femenuoptions, physics, camera, screencarselect, screencontroller,
    r3dcar, aiphysic, hrzsku, screencongrats, screenmain, screentrophyroom, aih_opp, femenuextended).
- Group/scope round (board 2037), bytes unchanged.
  - `Group::GetData()` / `GetNumElements()` are member inlines (records `this` of tag Group): chunk buffers
    (`stripBuf->GetData()`, `vertexBuf->GetData()`), BWorldSm_Init, object GetSimObj/FindObjInstanceFromSerialNum.
    Some sites are a FREE `Group_Data(g)` instead (variable-free pair); pass a global expression, never a bare
    local variable, or the inline parameter is recorded.
  - Record-less then/else blocks around returns = `const int result = f(); return result;` in each arm
    (BWorldSm_FindClosestQuadRez).
  - A LABEL record (`done`) plus a function-level block of locals = `if (!x) goto done; ... { locals ... } done:`
    rather than a nested if (FindClosestQuad).
  - A busy-wait on ticks has a scope holding the ticks pair when written `while (cond) {}` (do-while has none).
  - A loop-body `const` snapshot gives a record-less loop block (TransColorCheck).
- Round to board 2062, bytes unchanged.
  - A `tMenuItem` member inline cannot be added in femenu: that TU holds tMenuItem's key function, so every inline
    member is emitted out of line and the bytes move.  femenu uses free inlines only.
  - Menu-item flag writes are free enable/disable pairs across the frontend (screenpinkslips, screentracks,
    screencarselect DrawForeground, screenmemcard).
  - A sequence of checks that jumps past a later `if (keyval == Triangle)` = `else if` (screentracks).
  - Early-return functions whose failure path is the last block = `if (!ok) goto invalid; ... invalid: return 0;`
    (VIDEO_updateframexy); `while (!done()) { ...; if (timeout) { reset(); return 0; } } return 1;` (videodecode).
  - An explicit `if (p) delete p;` adds retail's two scopes around an inline destructor (Anim_Restart).
  - CAudioList::Elems() member (guarded) vs a free accessor: pick by whether retail records `this`; a free accessor
    inside a loop records its parameter.
- Round to board 2069, bytes unchanged.
  - femenudefs is now edited with per-function verify_asm plus var_fn's `-g` probe (blocks), then one full gate:
    GoToGarage (tListIteratorCar::SetFilter member on the femenudefs surface), GenericMenuLoadGame
    (tScreenMemcard::SetMessage pairs), AskTheUserToSaveTheGame (free Dialog_AsYesNo on the chained SetString
    result), Finished*GetName (stats-list pair).
  - Carriers that "keep a constant loop-live" or "snapshot a field" were often only needed for an older loop or
    control-flow spelling: DrawTVLines (a plain `for` with the literal gets retail's hoisted s2) and CheckConfigs
    (all snapshots removable) compile identically without them.
  - Tool: `build/tmp/inline_sweep.py` (+ `inline_sweep_all.sh`) substitutes a single-assignment, single-read carrier
    at its read when nothing between them writes memory or calls, keeps it only on verify_asm PASS and a
    disappearing EXTRA; round 1 committed 8 files (EXTRA 949 -> 937).
- Fourth round of the same family. Byte-unchanged (symloop) and native CLEAN:
  `HudPmx_InitTextures` (the digit loop is a `for` inside the explicit block, the two `alpX`
  loops declare their `static char alph[5]` directly in the loop body, the explicit wrappers
  around the three later loops are gone) and `Collide_DoObjectObjectCollision` (`zone`/`impulse`
  declared straight in the `objID < 0x200` compounds, no inner block). Byte-unchanged but still
  DIRTY, kept as verified partial restorations: `Track_LoadObjectKillData` (early return on a null
  file, `for (int i ...)`; 20 vs 19 scopes -- retail's `inst` block closes at +0a0 before the
  `index` and `simGroup` blocks, which are its siblings, so retail's `inst` cannot be the pointer
  those later blocks walk; unresolved), `Cars_DoExtraCarCollisionProcessing` (the six pull-over
  tests are three `&&` ifs, and `surfaceType == 1 && (random() & 3) == 0` is one if; 23 = 23
  scopes but retail opens its first level at +0a8 BEFORE the blowout re-read, i.e. its first
  condition is `blowout == 0 && pullOver == 0` with no goto -- that spelling passes verify_asm
  but symloop reports BYTES MOVED, the entry guard retargets, so the goto stays),
  `AIPhysic_SimplePhysics_LatVel` (`right` at function scope like retail; tree now exact, the
  remaining issue is carSpeed's register home), `RaceSummary` (`char string[40]` declared right
  after `i` as retail's AUTO order shows, and the per-car loop is a `for` whose level opens at
  +280 like retail's; the `w2` carrier block remains). Falsified: `CalcObjDefPtrs` with the loop
  body reading `(int *)(gObjDefOffsetsGroup + 1)` instead of `GetData()` (8 diffs);
  `Night_SetCopColor` with `copColors`/`col1`/`col2` at function scope (32 diffs, as the older
  note already said). Board 1805 -> 1807. Legacy symloop references for hudpmx, aiphysic and
  overlays were adopted/refreshed on pristine source (`ref_refresh.py --proven`).
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
| `symloop.py <rel path> [...] [--quiet] [--ref-only]` | Guarded per-file loop. `--ref-only` **freshly rebuilds** before capturing a missing reference or verifying an existing one; run it **before editing**, including once to adopt a legacy reference's section-layout companion. Normal runs require references, unchanged section bytes/layout, fresh successful debug/native-link outputs and complete selected-function coverage. Failures return nonzero without a success token. `BYTES: UNCHANGED` is printed only after the full pipeline succeeds. Logs and quarantined objects of the newest 20 runs are kept in `build/symloop_runs/` (older runs are pruned automatically; `SYMLOOP_KEEP_RUNS` overrides the count). |
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
- Line layout is compared by `tools/psyq_pipe/sldtree_cmp.py`: instruction-relative tags, block lines and function-end
  deltas. The 2026-10-01 snapshot is 427/2565 exact, so most source-line ownership remains to be restored.
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

## 2026-09-30 SLD checkpoint

- `AIDataRecord_CurveSpeedTable_t::Get`: the negative-curve guard has no retail lexical sub-block. Removing its braces
  while retaining the first statement's line position yields 0/13 SLD-tag differences, matching block lines and function
  end, with 13/13 byte PASS and native CLEAN.
- `tScreenTrackSelect::Cleanup`: separate the base-class cleanup call from the memory purge, then use implicit void
  fallthrough. This yields 0/16 SLD-tag differences, matching block lines and function end, with 16/16 byte PASS and
  native CLEAN.
- Both owning TUs remain byte-unchanged under `symloop`; strict full compile and GNU measurement link recover
  299819/299819 reconstructed image words, zero masked mismatches, and zero dropped text objects. The vtable audit
  passes 1314 files. `Font_SwitchFont`'s direct `currentfont` view was tested and reverted (13 diffs, 28/27 words).

## 2026-10-01 source-only carrier checkpoint

`R3DCar_GetCarName`'s mutable `copIdx` created a source-only `REG $16` local. A single-assignment
`const u_int` snapshot keeps its needed pre-`sprintf` value in `$16` without emitting a debug local:
37/37 byte PASS, unchanged whole-TU sections, and native local/scope records CLEAN. Moving the
explanatory comment before the function also reduces its SLD tag differences from 30 to 24 and
matches the retail function-end delta. The remaining SLD tags and block-line positions are not
exact; the original spelling of this debug-elided value is not proved. Reusing `carType` and
recomputing the index were previously byte-regressive. The analogous two-branch `const col`
trial in `Hrz_LightningFlicker` was four instruction diffs and was reverted.

The `tPMenu` variadic constructor is also 19/19 byte-PASS, native CLEAN and fully SLD-exact
after dropping the zero-code `va_end(ap)` and separating its base-constructor call from
`va_start` by one source line. Its 19 instruction tags, root block line and function-end
delta now agree with retail. This supports the shorter source form but does not prove the
original whitespace or whether a source-level no-op macro was present.

## 2026-10-01 empty-asm source-restoration audit

The next removal lane is zero-instruction game/frontend `__asm__("")` fences, not
hardware GTE/COP0 instructions, BIOS thunks or SDK assembly. Two live sites were
retested against the detailed byte oracle without retaining a regression:

- `FEInput_GetNoDebounceKey` (159/159 PASS with one remaining fence): replacing
  the `return_mask` fence with a direct jump to the existing `return_one` tail
  yields 155/159 and six diffs. A shared zero-return label yields 154/159 and
  thirteen diffs. Masking `result` in place before an if/switch gives 157/159
  and four diffs (GCC folds the two returns to `sltu`); a jump from that form
  is again 155/159. The return funnel needs another source shape; these tests
  do not justify deleting the fence yet.
- `CarIO_CopyToShape` (42/42 PASS with its empty tail fence): removing it merges
  the two outer-loop tails and yields 40/42. Identity expressions on `mirror`
  or `i` remain 40/42; a source-pointer absorption changes allocation and
  yields 24 diffs at 40/42. An explicit `goto` loop-back, byte-pointer `+24`,
  and `source -= -12` also stay at 40/42. GCC 2.8.1 `jump.c`'s
  `find_cross_jump` explicitly refuses `ASM_INPUT`/volatile asm but compares
  the ordinary tail patterns after skipping notes; these source variants
  canonicalize to the same tail. The outstanding problem is the cross-jump
  decision, not the nibble-copy body. All trial sources were reverted and
  their objects rebuilt before the zero-diff linked-image gate.

The second counter-use fence in `Chunk::InstanceGroup` was also tested via
the natural `if (i == 0)` guard, with `numElements = i` on either side of it.
Both 329-word variants rotate the global register assignment (68 and 60
diffs respectively), rather than replacing the original weighted reference.
The 329/329 source was restored. The instrumented `cc1plus` and GCC
`local-alloc.c` remain available for a focused ref/live explanation before
another source rewrite; neither a no-op asm deletion nor a fake identity is
being kept as a solution.

## 2026-10-01 typed C opacity replaces two empty asm fences

A source-level save/dead-set/restore can supply GCC's pre-flow second SET and
then disappear at zero emitted bytes, but the temporary must retain the
original scalar width. This is the `Hud_BuildString` device applied to two
new sites, with their other source expressions unchanged:

- `CarIO_CreateLicense`: replace `__asm__("" : "=r"(ascii) : "0"(ascii))`
  with a same-scope `char` save, dead zero assignment and restore. The `int`
  save rotated registers (34 diffs at 229/229); the `char` save is 229/229
  PASS. Whole `cario.cpp` bytes and existing native comparison remain
  unchanged; no `savedAscii` debug row survives.
- `MenuNFS4_DrawTextBox`: the same pattern with a same-scope `short` save
  removes the `selFade` identity fence while preserving 293/293 PASS and whole
  `femenuextended.cpp` bytes. An `int` save had four diffs; the correct-width
  `short` save has none and adds no saved-local debug row. The separate `fade`
  fence remains: replacing it with a C save/restoration shifts the `dist`
  addition across the `jal` delay slot by four diffs in this basin. No full
  native/SLD seal is claimed for either function. Keeping each save in its
  existing lexical scope rather than adding braces is also byte-exact and
  removes one artificial native scope from each experimental block.
