# NFS4 PSX SYM restoration audit and backlog

Date: 2026-08-23

Trusted debug source: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`

Retail byte oracle: `rom/nfs4-f.exe`

This document is the durable ledger for the request to use every reliable SYM
record in the reconstruction.  A record is **resolved** only when its reliable
source-level meaning is represented in C/C++, its linkage/layout agrees with
the retail image where applicable, and the relevant authoritative matching
gate has not regressed.  Duplicate debug records are retained in the census;
they are not silently collapsed into a smaller denominator.

## Executive status

- The trusted dump contains **340,483 decoded records** in 15 opcode classes.
- All **2,581 function-start records** are accounted for: 2,459 are attributed
  to reconstructed source translation units and 122 are attributed to headers.
- The 122 header-attributed records are also closed: all have an exact config
  VA and extracted oracle; 55 map to demangled source methods, 15 map to
  explicit VA/ABI carriers, and 52 are compiler-generated bodies.  No raw
  GCC-v2 name remains as a C/C++ code identifier and there are no signature
  findings or unresolved records in that set.
- In the five source-attributed audit scopes, no mapped function is missing its
  SYM name, no source definition still uses a mangled linkage name as its C/C++
  identifier, and the current signature/type/storage comparison has zero open
  findings.
- All **1,087 object-owned data records** found in those five scopes are
  accounted for: 1,017 map to source definitions and 70 are explicitly
  byte/blob-backed.  No object-owned SYM global is missing.
- All **115 SYM `_vt.*` records** are mapped to reconstructed table definitions.
  Their 1,064 retail slots match `nfs4-f.exe` in order, target, and adjustment.
- Every one of the **340,483 decoded records** now has a durable disposition:
  exact source/binary audit evidence, a paired structural ledger entry, or an
  explicit per-record semantic-review row.  Nothing is silently dropped from
  the denominator.
- A strict compiler-emitted type-graph comparison now distinguishes retail
  subset coverage from actual per-object source visibility.  Sixty owners are
  semantically exact: `memcard.obj`, `mdec.obj`, `video.obj`, `FETexture.obj`,
  `textpix.obj`, `textpsx.obj`, `unpack.obj`, `fastrand.obj`, and
  `aiscript.obj`, `new.obj`, `paths.obj`, `textsys.obj`, `simplemem.obj`,
  `MathNfs.obj`, `quatern.obj`, `udff.obj`, `Group.obj`, `schedule.obj`,
  `HudPmx.obj`, `genericpmx.obj`, `anim.obj`, `spchevnt.obj`, `color.obj`,
  `clock.obj`, `MinFront.obj`, `input.obj`, `aidelaycar.obj`, `AIWORLD.obj`,
  `chunk.obj`, `simqueue.obj`, `stats.obj`, `aiperson.obj`, `dashHUD.obj`,
  `physics.obj`, `AITUNE.obj`, `control.obj`, `souffle.obj`, and
  `AIDATARECORD.obj`, `AITRIGER.obj`, `TRGSFX.obj`, `AILIFE.obj`, and
  `aicop.obj`, `audedit.obj`, `scene.obj`, `collide.obj`, `AISPEEDS.obj`,
  `audiomus.obj`, `audioeng.obj`, `audiotrk.obj`, `AIINIT.obj`, and
  `AIPHYSIC.obj`, `gmesetup.obj`, `AI.obj`, `aistate.obj`, `mpause.obj`, and
  `newton.obj`, `camera.obj`, `TrackSpec.obj`, `loading.obj`, and `texture.obj`.
  The remaining mapped C++
  units still expose reconstruction-only declarations through the monolithic
  `nfs4_types.h` include graph and therefore are not yet source-exact.
- Native C++ `bool` has been restored where the SYM emits `BOOL`, including
  member fields and frontend/common functions.  The project compatibility
  typedef `BOOL` remains available for records that really use the C-style
  integer ABI.
- The authoritative function-match totals are unchanged after the SYM fixes.
  The shared-header rebuild exposed two stale vtable source casts; correcting
  their return type removed both compile failures without changing any slot.
- The remaining restoration work is explicitly classified below.  The largest
  review class is per-object header/type visibility: the SYM repeats included
  definitions per translation unit, while the reconstruction still routes most
  C++ objects through one monolithic header.  Every retail named/anonymous type
  is covered in the mapped C++ units, but strict equality also requires removal
  of source-only declarations and restoration of each owner's typedef variants.
  Every remaining row is retained rather than presented as already corrected.

## Complete record census

| Opcode | Count | Decoded meaning | Current disposition |
|---:|---:|---|---|
| `0x01` | 127 | linker/section symbols | Complete: 127/127 MAP-exact; all 25 families and 10 section extents exact |
| `0x02` | 4,503 | public/address symbols | Complete: 4,503/4,503 MAP-exact and every VA has a config carrier |
| `0x06` | 372 | file-local/static name records | Complete ledger; 278 typed STAT rows and 94 untyped local labels; two storage fixes applied |
| `0x80` | 19,891 | increment SLD line | Per-record ledger complete; semantic source-statement review is S1 |
| `0x82` | 51,916 | increment SLD line by byte | Per-record ledger complete; semantic source-statement review is S1 |
| `0x84` | 56 | increment SLD line by word | Per-record ledger complete; semantic source-statement review is S1 |
| `0x86` | 7,276 | set SLD line | Per-record ledger complete; semantic source-statement review is S1 |
| `0x88` | 215 | begin SLD file span | Balanced 215/215 and ledgered; semantic source mapping is S1 |
| `0x8a` | 215 | end SLD file span | Balanced 215/215 and ledgered; semantic source mapping is S1 |
| `0x8c` | 2,581 | function start/debug frame | Fully inventoried; source-TU records clean, header cases H1 |
| `0x8e` | 2,581 | function end | Complete: all 2,581 end-start sizes equal extracted retail oracle sizes |
| `0x90` | 11,206 | lexical block start | 11,206 paired ledger rows, zero structural issues; semantic review is S2 |
| `0x92` | 11,206 | lexical block end | 11,206 paired ledger rows, zero structural issues; semantic review is S2 |
| `0x94` | 140,022 | scalar/simple debug definition | Every row ledgered; audited subsets and T1 review dispositions separated |
| `0x96` | 88,316 | compound/array/tagged debug definition | Every row ledgered; audited subsets and T1 review dispositions separated |

The reproducible census and all class/type subtotals are in
[`full_record_manifest_20260821.txt`](scratchpad/root_sym_audit/full_record_manifest_20260821.txt).
Its generator is
[`audit_sym_record_manifest.py`](scratchpad/root_sym_audit/audit_sym_record_manifest.py).

The independent closure reconciliation is
[`full_record_closure_reconciliation_20260821.txt`](scratchpad/root_sym_audit/full_record_closure_reconciliation_20260821.txt),
generated by
[`audit_sym_closure_reconciliation.py`](scratchpad/root_sym_audit/audit_sym_closure_reconciliation.py).
It checks the durable artifacts against the raw opcode census and proves the
exhaustive arithmetic: 5,002 low-opcode records + 79,569 SLD/file-span records
+ 5,162 function-boundary records + 22,412 lexical-block records + 228,338
definition records = **340,483/340,483**, with **0 unaccounted records**.

The `0x94`/`0x96` denominator includes 125,966 `MOS` member records, 40,875
typedef records, 14,561 end-of-structure records, 13,041 structure tags,
11,454 enum members, 12,673 register/parameter/automatic-local records, 3,390
external definitions, 2,218 bit fields, 1,348 enum tags, 1,038 file records,
720 union members, 545 arguments, 332 static definitions, 172 union tags, and
5 labels.  These are deliberately counted even when the same included type is
emitted in many object files.

## Function and object-data coverage

| Source scope | SYM functions | Mapped | Missing names | Open type/storage | Object globals | Source mapped | Blob-backed | Missing globals | Extra source globals |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| `frontend/common` | 781 | 779 + 2 compiler aggregates | 0 | 0 | 190 | 190 | 0 | 0 | 0 |
| `frontend/psx` | 85 | 85 | 0 | 0 | 46 | 28 | 18 | 0 | 0 |
| `game/common` | 1,193 | 1,193 | 0 | 0 | 547 | 547 | 0 | 0 | 177 |
| `game/psx` | 395 | 395 | 0 | 0 | 302 | 250 | 52 | 0 | 61 |
| `eaclib/psx` | 5 | 5 | 0 | 0 | 2 | 2 | 0 | 0 | 0 |
| **Total** | **2,459** | **2,459** | **0** | **0** | **1,087** | **1,017** | **70** | **0** | **238** |

The exact per-record queues, recognized ABI-equivalent encodings, oracle-backed
overrides, source-only compiler carriers, and ownership exceptions are in:

- [`final_record_frontend_common_20260821.txt`](scratchpad/root_sym_audit/final_record_frontend_common_20260821.txt)
- [`final_record_frontend_psx_20260821.txt`](scratchpad/root_sym_audit/final_record_frontend_psx_20260821.txt)
- [`final_record_game_common_20260821.txt`](scratchpad/root_sym_audit/final_record_game_common_20260821.txt)
- [`final_record_game_psx_20260821.txt`](scratchpad/root_sym_audit/final_record_game_psx_20260821.txt)
- [`final_record_eaclib_psx_20260821.txt`](scratchpad/root_sym_audit/final_record_eaclib_psx_20260821.txt)

The 238 extra source globals are **not missing retail data**.  They are an
exhaustive review queue of reconstruction-only carriers, aliases, vtable
arrays, split ownership definitions, or data-layout helpers that do not have a
  current object-owned definition record.  They must not be removed merely to
  make the source name set equal; each entry requires raw relocation/layout and
  matching evidence.  The game/common and game/PSX scope reports above list
  every entry.

## Vtable audit, including SYM lines 134–173

Lines 134–173 of the trusted text dump are exactly 40 consecutive `_vt.*`
opcode-2 records, from `_vt.11AIHigh_Base` through
`_vt.14tPListIterator`.  They are all included.  The audit also searches the
whole SYM and finds another 75 `_vt.*` records later in the file, for a total of
115.

For every one of the 115 records, the audit verifies:

1. the SYM symbol and virtual address;
2. the corresponding `configs/symbol_addrs.txt` entry;
3. the reconstructed array definition and slot count;
4. every raw `{this-adjustment, function-target}` pair from `nfs4-f.exe`;
5. every reconstructed slot target against the raw target address and symbol
   map.

Results:

- 115/115 SYM vtables mapped;
- 1,064/1,064 SYM-described slots parsed and matched;
- all retail `this` adjustments are zero;
- structural/target issues: 0;
- retail targets absent from the symbol map: 0;
- unsafe direct vtable-row indexing: 0 across 906 source files.

Evidence:

- [`full_record_vtables_20260821.txt`](scratchpad/root_sym_audit/full_record_vtables_20260821.txt)
- [`full_record_vtable_slots_20260821.txt`](scratchpad/root_sym_audit/full_record_vtable_slots_20260821.txt)
- [`audit_sym_vtables.py`](scratchpad/root_sym_audit/audit_sym_vtables.py)
- [`audit_sym_vtable_slots.py`](scratchpad/root_sym_audit/audit_sym_vtable_slots.py)

There are 17 additional reconstructed retail tables with valid raw addresses
but no opcode-2 `_vt.*` record in this SYM.  They remain explicitly
**binary-backed, not SYM-derived**:

- `AIHigh_kVtbl_80054dcc`, `AIHigh_None_vtable`;
- `AIDataRecord_CarTracking_t_vtable`,
  `AIDataRecord_CurveSpeedTable_t_vtable`,
  `AIDataRecord_TrackCurve_t_vtable`, `AIDataRecord_BestLine_t_vtable`;
- `AIHigh_BasicCop_vtable`, `AIHigh_BTC_Perp_vtable`,
  `AIHigh_Player_vtable`;
- `AIState_None_vtable`, `AIState_NonActive_vtable`,
  `AIState_Base_vtable`;
- `ObjectAnim_vtable`;
- `tDialogInteractive_vtable`,
  `tDialogMessageStringWithTimeout_vtable`;
- `tBlankMenuItemGoToMenuNFS4Button_vtable`,
  `tBlankMenuItemNFS4LeftRightChoice_vtable`.

Their file, line, size, and VA are listed in the slot report.  Future work must
not invent SYM provenance for them unless another debug image supplies it.

## Applied source corrections

The current source audits reflect these evidence-backed corrections:

- GCC-v2 names are linkage keys only.  Reconstructed C++ definitions use the
  demangled class/function spelling; explicit assembler labels are retained
  only where needed to preserve the retail symbol.
- Function parameters, return types, storage classes, named locals, register
  homes, and object ownership were corrected where the reliable `0x8c` and
  `0x94`/`0x96` records supplied evidence.
- SYM `BOOL` records produced by the C++ compiler were restored as native
  `bool`, including the member-field subset in `nfs4_types.h`.  Natural boolean
  expressions were used where possible; a source carrier is kept only where
  the authoritative assembly required the retail operation shape.
- Object-owned globals were moved or defined in their SYM-owning modules where
  linker/data evidence allowed it.  Raw table-only modules remain separate
  data/blob ownership rather than fabricated C definitions.
- Vtable method-pointer casts were corrected to the SYM method return type.
  This removed two compile failures while preserving all retail slot targets.
- Header-attributed return types missed by the original TU-only audit were
  restored: `tPMenuItem::IsEnabled`/`IsDisabled` and both blank-menu
  `TransitionIsFinished` methods now return native `bool`, while
  `tScreenPinkSlipStandings::ProcessInput` now has its SYM `void` return.
  `AIDataRecord_CarTracking_t::Get` now uses the SYM parameter name `slice`.
- The 15 header-attributed base `Speech::Speaker` bodies now use demangled
  `Speaker::Method` definitions.  Class declarations preserve their retail
  nested-class labels, and readable `Speech_Speaker_*` aliases are used only
  as data-table relocation carriers.  All 15 functions remain byte-exact.
- Opcode 6 exposed two file-static function-pointer globals that the original
  audit parser had incorrectly discarded as functions.  `Draw_gSyncCallback`
  and `gCurrentBlitter` are now `static` in their owning `draw.cpp` and
  `font.cpp` translation units, and their cross-TU `extern` declarations were
  removed.  All six functions that read or write them remain byte-exact.
- `memcard.obj`, `mdec.obj`, `video.obj`, and `FETexture.obj` now compile through
  owner-sized type headers instead of the monolithic game graph.  Their strict
  named, anonymous, and typedef semantics are exact; retail-only duplicate debug
  rows are retained as audit evidence rather than reproduced as illegal duplicate
  C declarations.
- The missing game/PSX C-unit include graphs are restored.  `unpack.obj` is exact
  at 13/13 named types and 39/39 typedefs; `textpix.obj` at 15/15 and 46/46;
  `textpsx.obj` at 17/17 and 53/53.  Their retail-specific `wchar_t` is
  `unsigned long`, while the exact frontend C++ owners retain the distinct
  `unsigned char` PsyQ variant.
- Two smallest game/common owners are isolated too.  `fastrand.obj` has the
  retail-empty 0/0/0 graph after removing unused global headers and spelling
  its built-in unsigned type directly.  `aiscript.obj` is exact at 4/4 named
  types with all enum/struct/array typedef semantics represented.  All ten
  functions across the two objects remain byte-exact.
- `new.obj` and `paths.obj` now share an owner-exact minimal game/common graph:
  21/21 named types, 2/2 anonymous types, and 60/60 typedef semantics in each
  object.  All four allocator wrappers and `Paths_StartUp` remain byte-exact.
- Four leaf game/common objects are isolated from the monolithic header too:
  `textsys.obj` is exact at 22/22 named, 2/2 anonymous, and 67/67 typedef rows;
  `simplemem.obj` at 22/22, 2/2, and all typedef semantics; `MathNfs.obj` at
  22/22, 2/2, and all typedef semantics; and `quatern.obj` at 23/23, 2/2, and
  all typedef semantics.  Their 25 functions remain byte-exact.
- `udff.obj` is exact at 23/23 named types, 2/2 anonymous types, and every
  typedef semantic; its four reader functions remain byte-exact.
- `Group.obj` is exact at 27/27 named types, 2/2 anonymous types, and every
  typedef semantic; all six `SerializedGroup` methods remain byte-exact.
- `schedule.obj` is exact at 27/27 named types, 2/2 anonymous types, and every
  typedef semantic.  Its SYM references `simGlobal` by tag without emitting the
  owner-only `Sim_tSimGlobalVar` body; the source now preserves that boundary
  with an incomplete external tag and a symbol alias for the proven word-1
  `gameTicks` field.  All six scheduler functions remain byte-exact.
- `HudPmx.obj` and `genericpmx.obj` now use shared owner-sized draw and
  GameSetup-component headers while retaining incomplete/aliased access to the
  large globals whose bodies their SYM objects do not emit.  They are exact at
  39/39 and 43/43 named types respectively, both anonymous graphs are exact,
  and every typedef semantic is represented.  All four functions—including
  the 661- and 593-instruction texture initializers—remain byte-exact.
- `anim.obj` is exact at 59/59 named types, 2/2 anonymous types, and every
  typedef semantic.  This restores its animation, track, kernel, scheduler,
  draw, and GameSetup include surface and corrects `tPA32` from an array of
  pointers to the retail pointer-to-array form.  All 18 functions remain
  byte-exact.
- `spchevnt.obj` has the retail-empty 0/0/0 graph after replacing 14
  reconstruction-only one-word wrapper structs and the extra `u_long` typedef
  with preprocessing-only semantic aliases.  Direct word access preserves the
  proven event ABI, and all 53 speech-event builders remain byte-exact.
- `color.obj` is exact at 71/71 named types, 2/2 anonymous types, and every
  typedef semantic after replacing the monolithic graph with its actual draw,
  Transformer, track, Newton, GameSetup, AI/speech, and car include surface.
  Its `Udff_tHandle` correctly retains an incomplete `Udff_tInfo` tag: the
  linked SYM resolves the owner-proven 12-byte referent size even though
  `color.obj` emits no body.  Both color/parser functions remain byte-exact.
- `clock.obj` and `MinFront.obj` now layer their actual one-record deltas over
  the exact color graph instead of including the monolithic game header.
  `clock.obj` is exact at 72/72 named and 2/2 anonymous types with its
  `Clock_tGameClock` body and `Input_tDeviceCall` typedef restored; all three
  timer functions remain byte-exact.  `MinFront.obj` is exact at the same
  72/72 and 2/2 counts with its `forceFocus_t` enum and device-call typedef;
  `MinFront_ParseOptions` remains byte-exact.
- `input.obj` is exact at 73/73 named types, 2/2 anonymous types, and every
  typedef semantic after replacing the monolithic graph with the exact color
  surface plus `Input_tResults`, `Sched_tSchedule`, and `Input_tDeviceCall`.
  The SYM omits the private 12-byte device-row body, so its source spelling is
  not uniquely recoverable; the reconstruction uses a documented existing
  three-word carrier and proven raw offsets for the similarly omitted
  `simGlobal`/`GameSetup_gData` bodies.  All eight input functions remain
  byte-exact, including the 868-instruction `Input_Update`.
- `aidelaycar.obj` is exact at 73/73 named types, 2/2 anonymous types, and
  every unique typedef semantic.  Its exact owner surface is the shared color
  graph plus `Sched_tSchedule`, `CarLogic_tObservations`, and the 60-byte
  `AIDelayCar` class.  All three methods remain byte-exact.
- `AIWORLD.obj` is exact at 72/72 named types, 2/2 anonymous types, and every
  unique typedef semantic.  Its slice pointer now follows the owner SYM's
  intentionally opaque declaration: the nine accesses use the proven 32-byte
  retail ABI directly instead of leaking a reconstruction-only `Trk_NewSlice`
  body.  All 22 AI-world functions remain byte-exact.
- `chunk.obj` is exact at 72/72 named types and 2/2 anonymous types with no
  source-only tag or typedef semantics.  Its owner header restores the retail
  pointer-to-array `tPA32` spelling and preserves the omitted large
  `GameSetup_tData` boundary through the proven `commMode` word access.  All
  four chunk functions remain byte-exact.
- `simqueue.obj` is exact at 74/74 named types and 2/2 anonymous types with its
  `VALIDITY`, `Input_tResults`, `sim_queue`, `SIM_QUEUE`, and device-callback
  records restored.  All seven existing PASS functions remain PASS and the
  count-exact 4-diff `SimQueue_SetCurrentInput` residual is unchanged.
- `stats.obj` is exact at 73/73 named types and 2/2 anonymous types with its
  schedule and race-position records restored.  The source accesses only the
  raw words of the externally owned GameSetup/simulation aggregates whose
  bodies retail `stats.obj` does not emit.  All six existing PASS functions
  remain PASS and the count-exact 44-diff `Stats_TrackEndGame` residual is
  unchanged.
- `aiperson.obj` is exact at 73/73 named types and 2/2 anonymous types.  Its
  concrete `Udff_tInfo`, schedule, and observation-array records are restored
  without leaking the absent `GameSetup_tData` owner body.  The documented
  180-byte row/1060-byte field carrier reproduces the retail global access and
  all eight personality functions remain byte-exact.
- `dashHUD.obj` is exact at 74/74 named types and 2/2 anonymous types.  Its
  owner header restores `Sched_tSchedule`, `forceFocus_t`, and the 108-byte
  `dashhud_info` without exposing the absent GameSetup/camera/simulation owner
  bodies.  The existing `BO_tNewtonObj::damage` int-array supplies a documented
  zero-insn carrier for the retail 180-byte GameSetup car-row walk and its
  1092/1096 HudSpeed pair.  All six dash-HUD functions remain byte-exact.
- `physics.obj` is exact at 74/74 named types and 2/2 anonymous types.  Its
  owner header restores `Sched_tSchedule`, concrete `Udff_tInfo`, the 48-byte
  wheel-accumulator record, device callback, and opaque `Trk_NewSlice` pointer
  exactly as emitted by the SYM.  Externally owned GameSetup/simulation bodies
  remain hidden behind proven word/row carriers.  `BWorldSm_slices` is retained
  as a loaded pointer to opaque 32-byte rows, preserving both the missing slice
  body and retail address-formation RTL.  All 22 physics functions remain
  byte-exact.
- `AITUNE.obj` is exact at 76/76 named types and 2/2 anonymous types.  Its
  owner surface adds only the SYM-emitted schedule and four tuning records plus
  the observation-array typedef to the shared color graph.  The external
  GameSetup and track-slice bodies remain opaque, with the loaded slice pointer
  and proven track word represented directly.  All seven tuning functions
  remain byte-exact.
- `control.obj` is exact at 77/77 named types and 2/2 anonymous types.  Its
  owner surface restores the schedule/focus, four sound-interface records,
  observation array, and device callback actually emitted by the SYM.  The
  absent simulation, GameSetup, and four-byte input bodies use proven external
  word/component carriers.  Both control functions remain byte-exact.
- `souffle.obj` is exact at 77/77 named types and 2/2 anonymous types.  Its
  owner surface restores `DRender_tView`, `Souffle_tISouffle`, schedule, and
  the three PsyQ kernel records actually present in this object.  The absent
  simulation/replay-interface bodies remain external word carriers.  All ten
  wind/particle functions remain byte-exact.
- `AIDATARECORD.obj` is exact at 80/80 named types and 2/2 anonymous types.
  Its owner header restores the two enums, base record, five derived record
  classes, schedule, and observation-array typedef with the SYM inheritance
  layouts.  The host-only `__nfs4_vtbl_ptr_t` compatibility carrier is filtered
  at the same compiler boundary as PsyQ `_physadr`: retail GCC owns the
  corresponding 8-byte `__vtbl_ptr_type` built-in and emits no application
  source tag, while the reconstruction compiler ICEs when that built-in is
  materialized as an extern array.  All 26 record functions remain byte-exact.
- `AITRIGER.obj` is exact at 82/82 named types and 2/2 anonymous types.  Its
  owner surface restores the trigger enums, parameter union, trigger/table,
  manager, schedule, and observation-array records while keeping the omitted
  simulation aggregate behind its proven word-1 `gameTicks` access.  All ten
  trigger functions remain byte-exact.
- `TRGSFX.obj` is exact at 83/83 named types and 2/2 anonymous types.  Its
  owner surface restores the draw/track, schedule, PsyQ kernel, skidmark,
  `tSkid`, and souffle records actually emitted by the object.  The absent
  simulation and GameSetup bodies remain proven word carriers.  All eleven
  trigger-SFX functions remain byte-exact.
- `AILIFE.obj` is exact at 83/83 named types and 2/2 anonymous types.  Its
  owner surface restores the draw/track, schedule, AI-physics, PsyQ kernel,
  skidmark, and observation-array records.  The SYM does not materialize the
  externally owned `Trk_NewSlice` or `GameSetup_tData` bodies, so the source
  retains their 32-byte slice rows and word-12 `reverseTrack` field as proven
  byte/word carriers.  All twenty life-cycle functions remain byte-exact.
- `aicop.obj` is exact at 85/85 named types and 2/2 anonymous types.  Its
  owner surface restores the cop-level/game records, crime and roadblock
  enums, spike-belt state, schedule, trigger variants/union, and observation
  array actually emitted by the object.  Retail keeps only opaque pointer
  identity for the externally defined 844-byte `AITrigger_TriggerManager`;
  the readable `AITrigger_Init` ABI alias preserves its exact member target
  without fabricating that absent class body.  The omitted GameSetup body uses
  its proven `cops` and `track` word carriers.  All four functions remain
  byte-exact.
- `audedit.obj` is exact at 84/84 named types and 2/2 anonymous types.  Its
  compact owner header restores the track-animation, scene/object-animation,
  audio-list, kernel-pair, and five font-callback typedefs actually emitted by
  the object.  Both audio-list functions remain byte-exact.
- `scene.obj` is exact at 84/84 named types and 2/2 anonymous types.  Its
  owner surface restores the same track/scene object family plus the exact
  `CSceneList` record; the externally owned GameSetup body stays hidden behind
  its proven word-15 `track` access.  All six scene functions remain
  byte-exact.
- `collide.obj` is exact at 84/84 named types and 2/2 anonymous types.  Its
  owner surface restores the track/scene object family, collision object list,
  and schedule actually present in the SYM.  `BWorldSm_slices` remains a
  loaded pointer to opaque 32-byte rows, preserving the omitted slice body and
  retail byte/word access widths.  All thirteen existing PASS functions remain
  PASS and the count-exact 8-diff `Collide_TestObjectVertices` residual is
  unchanged.
- `AISPEEDS.obj` is exact at 84/84 named types and 2/2 anonymous types.  Its
  owner surface restores the schedule, complete UDFF handle, acceleration and
  curve-speed record classes, AI-physics records, speed tables, upgrade/slot
  records, kernel pair, and callback typedefs actually emitted by the object.
  The linked `AIDataRecord_TrackCurve_t` remains an opaque pointer identity and
  its `Get` calls use the proven member ABI alias.  An incomplete simulation
  tag plus a word alias preserves both the absent owner body and the retail
  branch-delay fill; a plain integer-array view was rejected after creating one
  extra `nop`.  All twenty-nine speed functions remain byte-exact.

## No-regression receipts

| Scope | Modules | Compile failures | Functions with oracle | PASS | Near | Far |
|---|---:|---:|---:|---:|---:|---:|
| `frontend/common` | 49 | 0 | 838 | 827 | 4 | 7 |
| `frontend/psx` | 14 | 0 | 85 | 83 | 1 | 1 |
| `game/common` | 92 | 0 | 1,258 | 1,239 | 14 | 5 |
| `game/psx` | 35 | 0 | 395 | 366 | 5 | 24 |
| `eaclib/psx` | 1 | 0 | 5 | 4 | 1 | 0 |
| **Total** | **191** | **0** | **2,581** | **2,519** | **25** | **37** |

Receipts:

- [`bulkverify_frontend_common_final_sym_20260821.txt`](scratchpad/root_sym_audit/bulkverify_frontend_common_final_sym_20260821.txt)
- [`bulkverify_frontend_psx_after_type_isolation_20260821.txt`](scratchpad/root_sym_audit/bulkverify_frontend_psx_after_type_isolation_20260821.txt)
- [`bulkverify_game_common_after_type_isolation_20260821.txt`](scratchpad/root_sym_audit/bulkverify_game_common_after_type_isolation_20260821.txt)
- [`bulkverify_game_psx_after_c_type_restoration_20260821.txt`](scratchpad/root_sym_audit/bulkverify_game_psx_after_c_type_restoration_20260821.txt)
- [`bulkverify_eaclib_psx_final_sym_20260821.txt`](scratchpad/root_sym_audit/bulkverify_eaclib_psx_final_sym_20260821.txt)

`tools/audit_vtable_indexing.py` passes, and `git diff --check` reports no
content errors.  Line-ending notices are working-tree normalization warnings,
not malformed patches.

The full `tools/build.py` compile reaches the final linker, but the repository's
current full-image link still has a broad pre-existing unresolved-symbol set
(reconstructed jump-table labels, vendor symbols, and functions outside this
audit's source scopes).  Therefore it is not a valid clean-image receipt for
this SYM round.  The five scope-wide `bulkverify` reports above are the
authoritative no-regression receipts; they compile every audited translation
unit and compare each extractable function directly with the retail oracle.
The diagnostic full-build log is
[`full_build_after_header_sym_fixes_20260821.txt`](scratchpad/root_sym_audit/full_build_after_header_sym_fixes_20260821.txt).

## Resolved header-attributed function set

The 122 `0x8c` records attributed to 25 headers have a complete per-record
ledger in
[`full_record_header_coverage_20260821.txt`](scratchpad/root_sym_audit/full_record_header_coverage_20260821.txt),
generated by
[`audit_sym_header_coverage.py`](scratchpad/root_sym_audit/audit_sym_header_coverage.py).
The classifier strips comments and strings before checking raw names, handles
the deleting-destructor ABI argument separately from written C++ parameters,
and compares the reliable return/parameter records for demangled bodies.

Result: 122/122 exact config VAs, 122/122 extracted oracles, 55 demangled source
bodies, 15 VA/ABI carriers, 52 compiler-generated bodies, zero raw mangled code
identifiers, zero signature findings, and zero unresolved records.

## Unresolved backlog

The following queues cover every remaining record class that is not yet safe
to call semantically restored.

### Per-record semantic ledgers

The high-volume debug streams are preserved in three generated TSV ledgers:

- [`full_record_sld_ledger_20260821.tsv`](scratchpad/root_sym_audit/full_record_sld_ledger_20260821.tsv):
  all 79,569 line/file-span records, with retail VA, decoded file/line state,
  enclosing function, authoritative match class, and semantic disposition;
- [`full_record_block_ledger_20260821.tsv`](scratchpad/root_sym_audit/full_record_block_ledger_20260821.tsv):
  all 11,206 paired lexical scopes, representing all 22,412 block records;
- [`full_record_definition_ledger_20260821.tsv`](scratchpad/root_sym_audit/full_record_definition_ledger_20260821.tsv):
  all 228,338 definition records, including class, decoded type, size, name,
  owner/function context, extra offset/dimension data, and disposition.

They are generated by
[`emit_sym_semantic_ledgers.py`](scratchpad/root_sym_audit/emit_sym_semantic_ledgers.py),
with aggregate checks in
[`full_record_semantic_ledgers_summary_20260821.txt`](scratchpad/root_sym_audit/full_record_semantic_ledgers_summary_20260821.txt).
There are zero unclassified SLD rows and zero lexical-block structural issues.
The ledgers deliberately distinguish a structurally decoded record from a
source-semantic correction; `REVIEW` is a backlog item, not a claim of parity.

### F2 — Resolved exact function extents (2,581 pairs)

All function boundaries now have a per-record ledger in
[`full_record_function_extents_20260821.txt`](scratchpad/root_sym_audit/full_record_function_extents_20260821.txt),
generated by
[`audit_sym_function_extents.py`](scratchpad/root_sym_audit/audit_sym_function_extents.py).

Results: 2,581 starts pair with 2,581 ends; there are zero nested starts,
orphan ends, unterminated starts, non-positive extents, or alignment failures.
Every start VA has a config carrier and extracted retail oracle, and all
2,581 SYM `end-start` byte sizes equal the oracle's declared function size.
This certifies retail boundaries even for functions whose reconstructed body
is not yet byte-identical.

### S1 — SLD line/statement semantics

All 79,139 line-state records and both sides of the 215 file spans are now in
the per-record SLD ledger.  Its current dispositions are 66,348 rows inside
PASS functions (`BINARY_ORDER_EXACT_SOURCE_SEMANTICS_REVIEW`), 3,165 inside
NEAR functions, 5,481 inside FAR functions, and 4,575 outside a function;
there are zero unclassified rows.  PASS proves emitted instruction order and
extent, but it does not prove original statement spelling or grouping, so the
ledger deliberately retains that semantic review instead of manufacturing a
false source-level certificate.  Residual functions remain the first-priority
queue for SLD-guided matching.

### S2 — Lexical block reconstruction

The 11,206 block starts and 11,206 block ends are now matched by a stack parser
into 11,206 per-scope ledger rows.  There are zero orphan ends, unclosed starts,
or cross-function scopes.  Each row retains its start/end VA and source line,
owner function, match class, and `STRUCTURE_PAIRED_SOURCE_BRACES_REVIEW`
disposition.  Reconstructed brace spelling and exact local lifetime remain a
semantic queue because the debug records prove scope extents, not necessarily
the textual brace form that generated them.

### T1 — Canonical types, members, enums, and typedefs

Every definition record remains present in the definition ledger.  In addition,
each reconstructed TU is now compiled with the original compiler's full-debug
mode and its emitted `.def` graph is compared with the owning retail object.
The comparison checks tag kind, size, member order/type/offset, bit fields,
array dimensions, anonymous types, and typedef semantics.  Exact duplicate
retail tag/typedef rows are counted but canonicalized semantically because
repeating the corresponding C declaration would be invalid source.

Current strict results:

- `frontend/psx`: 4 exact (`memcard`, `mdec`, `video`, `fetexture`) and 4 DIFF
  (`drawshp`, `mmeffect`, `movie`, `psxfront`);
- `game/psx`: 6 exact (`textpix`, `textpsx`, `unpack`, `trackspec`, `loading`, `texture`), 21 DIFF, and one owner
  ambiguity for game `font.obj` versus the vendor `libgpu/FONT.obj`;
- `frontend/common`: 41 mapped units remain DIFF and the now-empty artificial
  `mcrd.cpp` unit needs its objdiff ownership removed or reassigned;
- `game/common`: 50 exact (`ai`, `aicop`, `aidatarecord`, `aidelaycar`, `ailife`, `aiperson`, `aiscript`, `aispeeds`, `aistate`, `aitriger`, `aitune`, `aiworld`, `aiinit`, `aiphysic`, `anim`, `audedit`, `audiomus`, `audioeng`, `audiotrk`, `camera`, `chunk`, `clock`, `collide`, `color`,
  `control`, `dashhud`, `fastrand`, `genericpmx`, `group`, `hudpmx`, `input`, `mathnfs`, `minfront`, `new`,
  `paths`, `physics`, `quatern`, `schedule`, `simqueue`, `simplemem`, `spchevnt`, `stats`,
  `scene`, `souffle`, `textsys`, `trgsfx`, `udff`, `gmesetup`, `mpause`, `newton`) and 25 DIFF.

The next 74-record candidate, `bworldSm.obj`, remains intentionally DIFF.  A
28-word raw view of its externally owned 112-byte `Chunk` rows removed the
extra type body but changed address formation/allocation in six of its 28 PASS
functions; that experiment was fully reverted.  Closure needs a graph-visible
field carrier that preserves the typed row/component RTL, not merely equivalent
byte offsets.

`replay.obj` also remains intentionally DIFF after a fully reverted owner-split
experiment.  Its omitted `camera_info` body still drives typed 272-byte row
induction and a 32-bit bitfield-container update in three PASS functions.
Equivalent raw row/offset carriers changed `Replay_GetInterfaceKey`,
`Replay_ReplayChooseCamera`, and `Replay_ReplayFindClosestCamera`; all replay
source was restored and its 16/16 PASS baseline reconfirmed.  Closure needs a
graph-visible carrier that preserves the common row base and word bitfield RTL.

`audioclc.obj` remains DIFF at its original 18/18 PASS baseline.  An isolated
owner graph reached strict equality, but replacing the hidden
`GameSetup_tData`/`camera_info` member views with scalar rows changed two
retail address forms (`mode` and `perpInfo[i].CarType`).  The best result was
still 2 and 6 instruction diffs, and zero-instruction pointer fences made both
worse.  The complete experiment was reverted; closure needs a source-visible
carrier that retains field-offset MEM operands without emitting either hidden
tag body.

`render.obj` now has no semantic dependency on the absent retail
`GameSetup_tData` tag: all six affected accesses use the exact
`GameSetup_gData` symbol and proven word offsets, and remain PASS.  Its two
reconstruction-only packet-tag types are still explicit follow-up work.  A
raw masked-word replacement was measured and fully reverted because it changed
`StampImage` from 87 to 90 instructions and `Render_InsertDepthOfField` from
120 to 134 instructions (35 and 144 diffs respectively).  The retained
bit-field carrier preserves both PASS bodies; closure needs an owner-graph
encoding with the same GCC bit-field RTL rather than an equivalent mask/update.
GCC 2.8.1 source inspection (`toplev.c:rest_of_decl_compilation` and
`rest_of_type_compilation`) confirms that this compiler emits every completed
local record/union through `TYPE_STUB_DECL`; it has no source-level `nodebug`
or `DECL_IGNORED_P` escape hatch.  `#pragma interface` controls vague-linkage
definitions, not local type debug emission.  The carrier therefore cannot be
made graph-exact by hiding the correct bit-field type with an attribute or
pragma; its source representation itself must map to a retail-visible type.

`camera.obj` is now strict-exact without importing the absent retail
`GameSetup_tData`, `Sim_tSimGlobalVar`, `Sim_tSimSystemVar`, `Trk_NewSlice`, or
replay aggregate bodies.  Its exact symbol-backed views use proven word/byte
offsets; retail-visible `Car_tObj::slide` and `linedef` component carriers retain
GCC's field/row RTL without adding a type record.  The oracle-required
prechecked loop in `Camera_OpponentLookBehind` restores the original 245-word
shape.  `Camera_NextMode` needs one documented post-cc1 scheduling relocation;
it moves, but does not add/remove/rewrite, the existing signed-%3 correction.
The final graph is 92/92 named and 2/2 anonymous with no extra type/typedef, all
38 camera functions remain PASS, and the vtable audit is clean across 910 files.

`TrackSpec.obj` is now strict-exact through an owner-specific type header.  Its
externally owned `GameSetup_tData` is represented by an exact-symbol word view
at the three retail-attested offsets (`track` 15, `Weather` 18, and `Time` 21),
so the foreign record body no longer leaks into this object's debug graph.  The
final graph is 35/35 named and 2/2 anonymous, with no extra typedef semantics;
all five TrackSpec functions remain PASS.

`loading.obj` is now strict-exact by composing the already-proven GameSetup
leaf and Draw leaf headers.  Its externally owned `GameSetup_tData` accesses
use the exact `GameSetup_gData` symbol at the retail-attested word offsets for
`mirrorTrack` (11), `track` (15), and `userSetting.language` (56), without
exposing the foreign owner body.  The final graph is 36/36 named and 2/2
anonymous with no extra typedef semantics, and all three loading functions
remain PASS.

`texture.obj` is now strict-exact through the same proven GameSetup/Draw leaf
surface plus its owner-local `Texture_pal8bit` record.  The final graph is
37/37 named and 2/2 anonymous with no extra typedef semantics.  All 24
reconstructed Texture functions remain PASS, including the 272-instruction
`Texture_LoadPmx` body.

The mapped C++ units cover all retail named and anonymous type bodies, but are
not source-exact while they expose unrelated monolithic-header declarations or
miss owner-specific typedef variants.  The three C units that previously had
genuine missing retail type sets are now exact.

Strict evidence:

- [`type_graph_frontend_psx_strict_after_round_20260821.tsv`](scratchpad/root_sym_audit/type_graph_frontend_psx_strict_after_round_20260821.tsv)
- [`type_graph_game_psx_strict_after_c_units_20260821.tsv`](scratchpad/root_sym_audit/type_graph_game_psx_strict_after_c_units_20260821.tsv)
- [`type_graph_frontend_common_strict_20260821.tsv`](scratchpad/root_sym_audit/type_graph_frontend_common_strict_20260821.tsv)
- [`type_graph_game_common_strict_after_aiworld_20260821.tsv`](scratchpad/root_sym_audit/type_graph_game_common_strict_after_aiworld_20260821.tsv)
- [`type_graph_game_common_strict_after_chunk_simqueue_stats_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_strict_after_chunk_simqueue_stats_20260822.tsv)
- [`type_graph_game_common_strict_after_aiperson_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_strict_after_aiperson_20260822.tsv)
- [`type_graph_game_common_strict_after_dashhud_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_strict_after_dashhud_20260822.tsv)
- [`type_graph_game_common_strict_after_physics_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_strict_after_physics_20260822.tsv)
- [`type_graph_game_common_strict_after_aitune_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_strict_after_aitune_20260822.tsv)
- [`type_graph_game_common_strict_after_control_souffle_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_strict_after_control_souffle_20260822.tsv)
- [`type_graph_game_common_strict_after_aidatarecord_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_strict_after_aidatarecord_20260822.tsv)
- [`type_graph_game_common_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_20260822.tsv)
- [`type_graph_game_common_after_aicop_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_aicop_20260822.tsv)
- [`type_graph_game_common_after_aicop_audedit_scene_collide_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_aicop_audedit_scene_collide_20260822.tsv)
- [`type_graph_game_common_after_aispeeds_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_aispeeds_20260822.tsv)
- [`type_graph_game_common_after_audiomus_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_audiomus_20260822.tsv)
- [`type_graph_game_common_after_audio_round_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_audio_round_20260822.tsv)
- [`type_graph_game_common_after_aiinit_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_aiinit_20260822.tsv)
- [`type_graph_game_common_after_aiphysic_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_aiphysic_20260822.tsv)
- [`type_graph_game_common_after_gmesetup_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_gmesetup_20260822.tsv)
- [`type_graph_game_common_after_ai_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_ai_20260822.tsv)
- [`type_graph_game_common_after_aistate_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_aistate_20260822.tsv)
- [`type_graph_game_common_after_mpause_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_mpause_20260822.tsv)
- [`type_graph_game_common_after_newton_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_newton_20260822.tsv)
- [`type_graph_game_common_after_camera_20260822.tsv`](scratchpad/root_sym_audit/type_graph_game_common_after_camera_20260822.tsv)
- exact owner receipts: [`memcard`](scratchpad/root_sym_audit/type_graph_memcard_semantic_exact_20260821.tsv),
  [`mdec`](scratchpad/root_sym_audit/type_graph_mdec_semantic_exact_20260821.tsv),
  [`video`](scratchpad/root_sym_audit/type_graph_video_isolated_20260821.tsv),
  [`fetexture`](scratchpad/root_sym_audit/type_graph_fetexture_after_wchar_variant_20260821.tsv),
  [`textpix`](scratchpad/root_sym_audit/type_graph_textpix_exact_20260821.tsv),
  [`textpsx`](scratchpad/root_sym_audit/type_graph_textpsx_exact_20260821.tsv),
  [`unpack`](scratchpad/root_sym_audit/type_graph_unpack_exact_20260821.tsv),
  [`fastrand`](scratchpad/root_sym_audit/type_graph_fastrand_exact_20260821.tsv),
  [`aiscript`](scratchpad/root_sym_audit/type_graph_aiscript_exact_20260821.tsv),
  [`new`](scratchpad/root_sym_audit/type_graph_new_exact_20260821.tsv), and
  [`paths`](scratchpad/root_sym_audit/type_graph_paths_exact_20260821.tsv),
  [`textsys`](scratchpad/root_sym_audit/type_graph_textsys_exact_20260821.tsv),
  [`simplemem`](scratchpad/root_sym_audit/type_graph_simplemem_exact_20260821.tsv),
  [`mathnfs`](scratchpad/root_sym_audit/type_graph_mathnfs_exact_20260821.tsv), and
  [`quatern`](scratchpad/root_sym_audit/type_graph_quatern_exact_20260821.tsv), and
  [`udff`](scratchpad/root_sym_audit/type_graph_udff_exact_20260821.tsv),
  [`group`](scratchpad/root_sym_audit/type_graph_group_exact_20260821.tsv), and
  [`schedule`](scratchpad/root_sym_audit/type_graph_schedule_exact_20260821.tsv),
  [`hudpmx`](scratchpad/root_sym_audit/type_graph_hudpmx_exact_20260821.tsv), and
  [`genericpmx`](scratchpad/root_sym_audit/type_graph_genericpmx_exact_20260821.tsv), and
  [`anim`](scratchpad/root_sym_audit/type_graph_anim_exact_20260821.tsv), and
  [`spchevnt`](scratchpad/root_sym_audit/type_graph_spchevnt_exact_20260821.tsv), and
  [`color`](scratchpad/root_sym_audit/type_graph_color_exact_20260821.tsv),
  [`clock`](scratchpad/root_sym_audit/type_graph_clock_exact_20260821.tsv), and
  [`minfront`](scratchpad/root_sym_audit/type_graph_minfront_exact_20260821.tsv), and
  [`input`](scratchpad/root_sym_audit/type_graph_input_exact_20260821.tsv), and
  [`aidelaycar`](scratchpad/root_sym_audit/type_graph_aidelaycar_exact_20260821.tsv), and
  [`aiworld`](scratchpad/root_sym_audit/type_graph_aiworld_exact_20260821.tsv).
  Owner receipts for this round are [`chunk`](scratchpad/root_sym_audit/type_graph_chunk_final_20260822.tsv),
  [`simqueue`](scratchpad/root_sym_audit/type_graph_simqueue_final_20260822.tsv), and
  [`stats`](scratchpad/root_sym_audit/type_graph_stats_final_20260822.tsv), plus
  [`aiperson`](scratchpad/root_sym_audit/type_graph_aiperson_final_20260822.tsv), and
  [`dashhud`](scratchpad/root_sym_audit/type_graph_dashhud_final_20260822.tsv), and
  [`physics`](scratchpad/root_sym_audit/type_graph_physics_final_20260822.tsv), and
  [`aitune`](scratchpad/root_sym_audit/type_graph_aitune_final_20260822.tsv), plus
  [`control`](scratchpad/root_sym_audit/type_graph_control_final_20260822.tsv), and
  [`souffle`](scratchpad/root_sym_audit/type_graph_souffle_final_20260822.tsv), plus
  [`aidatarecord`](scratchpad/root_sym_audit/type_graph_aidatarecord_final_20260822.tsv),
  [`aitriger`](scratchpad/root_sym_audit/type_graph_aitriger_final_20260822.tsv),
  [`trgsfx`](scratchpad/root_sym_audit/type_graph_trgsfx_final_20260822.tsv), and
  [`ailife`](scratchpad/root_sym_audit/type_graph_ailife_final_20260822.tsv), plus
  [`aicop`](scratchpad/root_sym_audit/type_graph_aicop_final_20260822.tsv),
  [`audedit`](scratchpad/root_sym_audit/type_graph_audedit_final_20260822.tsv),
  [`scene`](scratchpad/root_sym_audit/type_graph_scene_final_20260822.tsv), and
  [`collide`](scratchpad/root_sym_audit/type_graph_collide_final_20260822.tsv), and
  [`aispeeds`](scratchpad/root_sym_audit/type_graph_aispeeds_final_20260822.tsv), and
  [`audiomus`](scratchpad/root_sym_audit/type_graph_audiomus_final_20260822.tsv),
  [`audioeng`](scratchpad/root_sym_audit/type_graph_audioeng_final_20260822.tsv), and
  [`audiotrk`](scratchpad/root_sym_audit/type_graph_audiotrk_final_20260822.tsv), and
  [`aiinit`](scratchpad/root_sym_audit/type_graph_aiinit_final_20260822.tsv), and
  [`aiphysic`](scratchpad/root_sym_audit/type_graph_aiphysic_final_20260822.tsv), and
  [`gmesetup`](scratchpad/root_sym_audit/type_graph_gmesetup_final_20260822.tsv), and
  [`ai`](scratchpad/root_sym_audit/type_graph_ai_final_20260822.tsv), and
  [`aistate`](scratchpad/root_sym_audit/type_graph_aistate_final_20260822.tsv), and
  [`mpause`](scratchpad/root_sym_audit/type_graph_mpause_final_20260822.tsv), and
  [`newton`](scratchpad/root_sym_audit/type_graph_newton_final_20260822.tsv), and
  [`camera`](scratchpad/root_sym_audit/type_graph_camera_final_20260822.tsv), and
  [`trackspec`](scratchpad/root_sym_audit/type_graph_trackspec_final_20260823.tsv), and
  [`loading`](scratchpad/root_sym_audit/type_graph_loading_final_20260823.tsv), and
  [`texture`](scratchpad/root_sym_audit/type_graph_texture_final_20260823.tsv).

Required closure:

1. canonicalize identical definitions repeated through headers;
2. preserve conflicting definitions per owning translation unit instead of
   merging them blindly;
3. compare tag kind, total size, member order, byte/bit offset, array rank and
   dimensions, signedness, enum values, and typedef spelling;
4. emit a per-record result and patch only evidence-backed discrepancies;
5. rebuild all dependants and preserve every existing PASS function.

This queue includes 125,966 member rows and 2,218 bit-field rows, so a generated
machine ledger is mandatory; a name-only grep is not sufficient.

### L1 — Resolved linker/section record set (`0x01`, 127 records)

All 127 opcode-1 linker records now have a per-record ledger in
[`full_record_linker_symbols_20260821.txt`](scratchpad/root_sym_audit/full_record_linker_symbols_20260821.txt),
generated by
[`audit_sym_linker_records.py`](scratchpad/root_sym_audit/audit_sym_linker_records.py).

Results: 127/127 names and values match the independent retail `NFS4.MAP`;
all 25 `{obj,objend,org,orgend,size}` families are complete and arithmetically
exact; all 10 MAP section extents are exact; `__SN_GP_BASE` is 0x8013c54c;
and `__SN_ENTRY_POINT` is 0x800e402c, agreeing with the PS-X EXE header.  The
CPE's 3,478 load commands span exactly 0x80010000–0x8013dd7c, the initialized
image extent recorded by `_text_obj`/`_text_objend`.  Empty ctor/dtor/textpsx
and frontend sdata/sbss families are preserved as zero-sized linker metadata.

Only 10 of these names are carried in `configs/symbol_addrs.txt`; the other
117 are linker-output boundary aliases or absolute size values with no current
source relocation consumer.  They are deliberately not fabricated as C
globals or forced into the reconstructed linker: doing so would confuse
linker-generated metadata with original source declarations and provides no
layout evidence beyond the now-complete retail ledger.  There are zero
conflicting config carriers.

### L2 — Resolved public/address record set (`0x02`, 4,503 records)

All 4,503 opcode-2 rows now have a per-record ledger in
[`full_record_public_symbols_20260821.txt`](scratchpad/root_sym_audit/full_record_public_symbols_20260821.txt),
generated by
[`audit_sym_public_symbols.py`](scratchpad/root_sym_audit/audit_sym_public_symbols.py).

Every `(name,VA)` pair matches the independent retail `NFS4.MAP`, with zero
missing names or address conflicts.  All 3,390 typed rows pair with `EXT` and
are already covered by the 2,482 function and 908 object-data records in the
source audits.  The untyped remainder consists of 115 fully audited vtables,
767 public text/ABI symbols, and 231 public data/boundary symbols.  Those 998
non-vtable/vendor rows retain authoritative public name/address evidence but
do not have enough debug type information to invent original C declarations.

`configs/symbol_addrs.txt` carries 4,236 rows under the raw retail spelling;
all remaining rows have an exact-VA reconstructed alias, so every one of the
4,503 public addresses is represented and there are no conflicting carriers.
This includes repeated ABI entry aliases, sanitized deleting-destructor names,
and readable vtable identifiers whose raw GCC-v2 spelling is unsuitable as a
C/C++ identifier.

### L3 — Resolved local/static record set (`0x06`, 372 records)

All 372 opcode-6 rows now have a per-record ledger in
[`full_record_local_symbols_20260821.txt`](scratchpad/root_sym_audit/full_record_local_symbols_20260821.txt),
generated by
[`audit_sym_local_symbols.py`](scratchpad/root_sym_audit/audit_sym_local_symbols.py).

The storage distinction is proven across the complete typed subsets: all
3,390 typed opcode-2 rows pair with `EXT`, while all 278 typed opcode-6 rows
pair with `STAT`; there are zero `(VA,name)` overlaps and zero storage
contradictions.  Opcode 6 is therefore the file-local/static name lane.  Its
ledger comprises 99 typed static functions, 177 typed static data objects, two
typed static function-pointer objects, 60 untyped local text labels, and 34
untyped local data/BSS labels.  The 94 untyped rows are address/name evidence
only because no matching top-level type record is present.

This audit found and fixed the two omitted function-pointer objects described
above.  The refreshed game/PSX record audit now maps 250/302 globals plus 52
blob-backed globals, with zero missing, storage, or type findings.  The local
name lane is intentionally not forced into `NFS4.MAP`: that retail map omits
local names, which is consistent with this storage class.

### G1 — Blob-backed globals (70 records)

There are 18 frontend/PSX and 52 game/PSX object-owned globals represented by
measured binary data rather than C definitions.  Their names, ownership, sizes,
and bytes are accounted for, but original declaration syntax is unresolved.
The scope reports list every record.  Promote one to C only when type/layout and
link-order evidence reproduce the same bytes without moving neighbors.

### G2 — Source-only globals/carriers (238 records)

The 177 game/common and 61 game/PSX extra source definitions are exhaustively
listed in their scope reports.  Classify each as a necessary compiler/linker
carrier, a binary-backed table without an owning debug definition, a deliberate
alias, a split data-layout seam, or a removable reconstruction artifact.  Any
removal requires a linked-layout comparison and neighbor regression gates.

### V2 — Binary-only vtables (17 tables)

The 17 tables listed in the vtable section match raw bytes but lack `_vt.*`
records in this SYM.  They remain a separate provenance queue.  Search another
regional/build SYM or original object metadata before assigning a debug name;
raw address correspondence alone does not make the name authoritative.

## Closure rule

The exhaustive **record-census/backlog** subgoal is closed: S1, S2, and T1 have
generated per-record review ledgers; G1 and G2 have per-record scope-report
queues; V2 has an explicit table-by-table provenance queue; and all other opcode
classes have exact record-level audits.  The user's larger goal—fully SYM-exact,
fully source-restored code—is **not closed**.  The strict T1 results above prove
that most translation units still have non-retail source-visible type graphs,
and S1/S2/G1/G2/V2 retain semantic or provenance work.  Census closure means
nothing is hidden from the queue, not that queued information is already source.

Future corrections must preserve the same rule: a lower diff is not permission
to contradict reliable SYM information, and a SYM-looking name is not sufficient
proof of original source spelling when it is a GCC-mangled linkage key.
