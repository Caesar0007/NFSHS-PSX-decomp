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
  subset coverage from actual per-object source visibility.  Seventy-six owners are
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
  `newton.obj`, `camera.obj`, `TrackSpec.obj`, `loading.obj`, `texture.obj`, and
  `Draw.obj`, `Sfx.obj`, `TrsProj.obj`, `CarIO.obj`, `platform.obj`, and
  `force.obj`, `audio.obj`, `overlays.obj`, `Weather.obj`, `rpause.obj`, and
  `hrzsku.obj`, `TextureProcess.obj`, `Skidmark.obj`, `fe3dmenu.obj`,
  `device.obj`, and `psxcontroller.obj`.
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
- unsafe direct vtable-row indexing: 0 across 925 source files.

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
- The PASS-only game/PSX local audit removed ten reconstructed temporaries
  from six functions while preserving every byte: `AudioCmn_LoadBank` now emits
  only SYM's `bankdata`/`pdata`; `Device_Fail` only its static `failtime[2]`;
  `Device_PSXPad` no locals; and both `CarIO_StartUp`/`CarIO_ReStart` only `i`
  in `$v1`.  `Device_Update` lost its call-result `iVar2` but retains a measured
  `iVar1` codegen carrier; deleting that carrier changes PASS 56 into 59
  instructions.  `Platform_InitMemory` likewise retains its measured `m`
  carrier after all no-local forms either deleted the retail recovery `addu` or
  produced a complete `$v0/$v1` swap.  Exact gates and falsified forms are in
  [`game_psx_passlock_receipt_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_receipt_20260823.md).
- A second PASS-only continuation removed another 36 reconstruction-only local
  names across `draw.cpp`, `force.cpp`, `font.cpp`, `hrzsku.cpp`,
  `overlays.cpp`, and `textureprocess.cpp`, with zero PASS regressions. The
  game/PSX declaration audit moved from 198 to 204 clean mapped functions and
  from 918 to 882 extra source-local names. All unmatched bodies remained
  locked; `RaceStatistics` was observed at its unchanged FAIL 71 baseline but
  was not edited. Exact per-function removals and gates are appended to the
  same PASS-lock receipt above.
- A third PASS-only continuation removed 11 more reconstructed locals from
  `texture.cpp`, `trsproj.cpp`, `weather.cpp`, and `trackspec.cpp`. Their four
  complete translation-unit gates are all PASS, and their named/anonymous SYM
  type graphs are exact. The cumulative PASS-lock series now improves the
  game/PSX declaration audit from 193 to 211 clean mapped functions and from
  928 to 871 extra source-local names (57 removed), without editing a locked
  unmatched body.
- A fourth PASS-only continuation removed ten more reconstruction-only locals
  from exact functions in `hrzsku.cpp`, `weather.cpp`, `textureprocess.cpp`,
  `flare.cpp`, `sfx.cpp`, `unpack.c`, and `texture.cpp`. The declaration audit
  is now 221/395 clean with 861 extra local names: cumulative movement from the
  series baseline is +28 clean functions and -67 names. Full translation-unit
  gates remained exact except for the two already-unmatched, untouched
  `hrzsku.cpp` functions. The root `tPA32` declaration is now SYM's pointer to
  an array of 32 shorts (`short (*)[32]`), rather than the inverse array of
  pointers; flare typedef coverage increased from 193/224 to 194/224. The
  remaining flare type-graph `DIFF` is the broader shared-header-extra queue,
  not a residual `tPA32` mismatch.
- A fifth PASS-only continuation restored `textnpixels::ch` to the C struct-tag
  spelling `struct charactertbl *` and `TP_gZPaletteSystem` to the canonical
  `TP_ZPaletteSystem` identity. Textpix is type-graph exact (15/15 named,
  46/46 typedefs), textureprocess remains OK (83/83 named, 2/2 anonymous), and
  all affected functions remain PASS. Narrow audit normalization now treats
  C's explicit `struct:tag` namespace and direct `R(*)(args)` declarations as
  their proven PsyQ STRUCT / PTR-FCN equivalents; this removes the false
  `Draw_gSyncCallback` data-pointer report without changing its already-correct
  source. Five tested allocation temporaries are now explicit
  `SYM-CODEGEN-CARRIER` records rather than generic review items. The game/PSX
  audit is 225/395 clean with 856 generic extras, one function type finding,
  and zero global type findings. The remaining function type finding belongs
  to locked, unmatched `DrawC_PrimClip` and was not edited.
- A sixth PASS-only continuation converted 86 additional generic local-name
  entries into explicit oracle-backed `SYM-CODEGEN-CARRIER` records across
  device, draw, platform, force, font, loading, trackspec, skidmark, sfx,
  texture, textureprocess, and weather. It also removed
  `Platform_SysStartUp::userRam` and `Force_Update::uVar3` entirely while
  preserving PASS 54/54 and PASS 278/278; the latter now uses the direct
  unsigned `(u_int)car->carIndex` expression required for retail's `sltiu`.
  Direct-form probes prove `Texture_CheckForSharedPalette::num` (16 register
  diffs at 77/77) and `Force_Update::controller` (11 diffs, 279/278) are real
  allocation/address-shape carriers. The current game/PSX audit is 263/395
  clean with 768 generic extras and 92 explicit source-only carrier names;
  cumulative PASS-lock movement is +70 clean functions and -160 generic names.
  Full affected-TU gates are PASS except for the already-unmatched, untouched
  `InGame_GetPSXPadValue` baseline.

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
- `game/psx`: 21 exact (`textpix`, `textpsx`, `unpack`, `trackspec`, `loading`, `texture`, `draw`, `sfx`, `trsproj`, `cario`, `platform`, `force`, `audio`, `overlays`, `weather`, `rpause`, `hrzsku`, `textureprocess`, `skidmark`, `fe3dmenu`, `device`), 6 DIFF, and one owner
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
38 camera functions remain PASS, and the current vtable audit is clean across 925 files.

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

`Draw.obj` is now strict-exact through its owner-specific PsyQ kernel, display,
cache, and view records plus the proven GameSetup/Draw leaf surfaces.  The
externally owned `GameSetup_tData::commMode` accesses use the exact symbol at
word offset 3.  Its reconstruction-only `fn_void` typedef was replaced by the
retail-equivalent direct function-pointer declarator.  The final graph is
42/42 named and 2/2 anonymous with no extra typedef semantics, and all 25 Draw
functions remain PASS.

`Sfx.obj` is now strict-exact through its owner-specific PsyQ/GTE, Draw, and
souffle record surface.  Its sole `GameSetup_tData::Time` access uses the exact
`GameSetup_gData` symbol at word offset 21.  The reconstruction-only
`Sfx_tTag` type was removed in favor of the byte-identical expanded P_TAG
mask/or operation, eliminating the extra anonymous tag and typedef.  The final
graph is 45/45 named and 2/2 anonymous with no extra typedef semantics, and all
seven Sfx functions remain PASS, including the 938-instruction
`Sfx_BuildSouffleFacet`.

`TrsProj.obj` is now strict-exact through an owner-specific projection/physics
type surface assembled from the SYM records.  Its only
`GameSetup_tData::commMode` access uses the exact `GameSetup_gData` symbol at
word offset 3.  The final graph is 50/50 named and 2/2 anonymous with no extra
typedef semantics, and all 11 TrsProj functions remain PASS.

`CarIO.obj` is now strict-exact by extending the already-proven color owner
surface with its local `CarIO_textureInfo` record.  Its sole foreign
`GameSetup_tData::mirrorTrack` access uses the exact `GameSetup_gData` symbol at
word offset 11, while the externally owned palette pointer is carried without
importing `Texture_pal8bit`.  The final graph is 72/72 named and 2/2 anonymous
with no extra typedef semantics.  Ten functions remain PASS and
`CarIO_ReadInCarTextureData` remains unchanged at its pre-existing 19-diff,
492-versus-491-instruction baseline.

`platform.obj` is now strict-exact through the proven color surface plus its
PsyQ kernel/card records.  The externally owned `tNfsSystemInfo` body is absent
from this retail object; its sole word-0 `userRam` access therefore uses the
exact `nfs_sysInfo` symbol through a retail-visible one-word aggregate carrier
and a semantic `Platform_nfsUserRam` macro.  This preserves the aggregate MEM
form without introducing an extra debug record.  The final graph is 76/76
named and 2/2 anonymous with no extra typedef semantics, and all eight platform
functions remain PASS.

`force.obj` is now strict-exact through the proven color surface plus its
scheduler, force-state, and PsyQ kernel records.  The hidden GameSetup controller
subobject is represented with the retail `GameSetup_tControllerData` member/index
shape and an explicit 96-byte owning-aggregate offset; this preserves the exact
base/index allocation in `Force_Update`.  The hidden `simGlobal.schedule32Hz`
and `GameSetup_gData.commMode` accesses retain their exact symbols and proven
word offsets.  The final graph is 76/76 named and 2/2 anonymous with no extra
typedef semantics, and all nine Force functions remain PASS.

`audio.obj` is now strict-exact through the proven color surface plus its nine
sound-system, music-entry, and PsyQ SPU records.  The externally owned
`gSndBnk` storage is represented by its exact symbol and three-word row layout,
because this owner's retail graph does not emit the foreign `SndBnk_t` tag.
This retains the original typed row addressing without adding a debug record.
The final graph is 80/80 named and 2/2 anonymous with no extra type or typedef
semantics, and all six Audio functions remain PASS.

`overlays.obj` is now strict-exact through the proven color surface plus its
scheduler, BTC-perpetrator, and font-kern records.  The externally owned
`GameSetup_gData` and `simGlobal` bodies are absent from this retail object, so
their five used fields retain the exact symbols through word offsets 0, 1, 3,
46, and 1 respectively.  The final graph is 74/74 named and 2/2 anonymous with
no extra type or typedef semantics.  Four functions remain PASS, while
`RaceStatistics` is unchanged at its pre-existing 71-diff,
474-versus-475-instruction baseline.

`Weather.obj` is now strict-exact through its exact PsyQ, world/track,
scheduler, rendering, and weather records.  The externally owned
`GameSetup_gData`, `simGlobal`, `TrackSpec_gSpec`, and `Camera_gInfo` bodies are
absent from this retail object; exact-symbol word/byte carriers retain only the
field offsets Weather actually uses.  A zero-byte camera-base use plus one
documented independent instruction relocation preserves the original
aggregate-copy lowering without emitting a foreign camera type.  The final
graph is 68/68 named and 2/2 anonymous with no extra type or typedef semantics,
and all 25 Weather functions remain PASS.

`rpause.obj` is now strict-exact through its exact compact Draw/PsyQ surface.
The externally owned `Draw_tView` and `dflip` bodies are absent from this
retail object, so exact-symbol byte-row carriers retain only the 200-byte view
stride and the display-environment offset actually used.  A fully inlined
address helper plus a zero-byte raw-base receipt preserves GCC's retail
row/flip/`+192` address tree without emitting a helper symbol or a foreign
debug type.  The final graph is 35/35 named and 2/2 anonymous with no extra
type or typedef semantics, and all three RPause functions are PASS.

`hrzsku.obj` is now strict-exact through its exact PsyQ, render, world/track,
GameSetup-leaf, horizon, and lightning surface.  The foreign 2600-byte
`GameSetup_tData` and 264-byte `CTrackSpec` bodies are absent from this object;
zero-storage views through retail-visible component records preserve the
attested `GameSetup+12`, raw TrackSpec, and horizon-subobject `TrackSpec+40`
address trees.  The latter has an explicit config carrier at retail address
`0x801232a4`.  Inline offset accessors emit no standalone code or foreign debug
type.  The final graph is 75/75 named and 2/2 anonymous with no extra type or
typedef semantics.  Twenty of 22 functions remain PASS; `Hrz_BuildSky` and
`Hrz_BuildHorizon` retain their exact pre-existing 150- and 20-diff baselines.

`TextureProcess.obj` is now strict-exact through the proven color graph plus
its exact track-environment, font-kern, palette, and fog records.  The foreign
completed `GameSetup_tData`, `CTrackSpec`, and `DRender_tView` bodies are absent
from this retail object; exact-symbol word views preserve the attested
GameSetup offsets 3, 15, 18, and 21, TrackSpec fog offsets 16, 20, and 24, and
the view translation at byte offset 8.  The retail palette typedef spelling is
restored as `TP_tZPaletteSystem` over tag `TP_ZPaletteSystem`.  The final graph
is 83/83 named and 2/2 anonymous with no extra type or typedef semantics, and
all 16 TextureProcess/Fog/CV functions remain PASS.  `CV_ColorTracks` now
reaches PASS from source through a zero-instruction post-call read-only
`contrast` use; the former `PER_FN_RA_SINK` post-compile relocation is disabled
and textureprocess has no post-recompile rewrite entry.

`Skidmark.obj` is now strict-exact through the proven color graph plus its
retail PsyQ packet, view, draw, track-art, kernel, skid-segment, chunk, and
control records.  The foreign completed `GameSetup_tData` body is absent from
this retail object; an exact-symbol word view preserves the sole attested
`commMode` access at word offset 3.  The final graph is 83/83 named and 2/2
anonymous with no extra type or typedef semantics.  All 11 Skidmark functions
remain PASS, all undefined references resolve to project definitions/configured
symbols, and neither `skidmark.cpp` nor any Skidmark function has a post-recompile
rewrite entry in `tools/build.py`.

`fe3dmenu.obj` is now strict-exact through the proven color graph plus its
retail packet, menu-view, car-cache, track-art, scheduler, focus, kernel, and
skid records.  The owner-specific surface removes all 462 unrelated named
records and 531 unrelated typedef semantics that leaked through
`nfs4_types.h`.  The scratchpad stack terminator remains a fixed-address lvalue
and therefore adds no linked storage or foreign type record.  The final graph
is 84/84 named and 2/2 anonymous with no extra type or typedef semantics, and
all three Fe3D functions remain PASS.  Its calls use precise C linkage rather
than variadic phantom-prone declarations, and neither the TU nor its functions
has a post-recompile rewrite entry in `tools/build.py`.

`device.obj` is now strict-exact through the proven `gmesetup.obj` frontend
surface with its two foreign owner records (`GameSetup_tData` and `FEI_tList`)
omitted, plus the retail `Input_tDeviceList` and `Sched_tSchedule` records.  The
foreign completed `GameSetup_tData`, `Sim_tSimSystemVar`, and
`tPadModuleState` bodies are represented by exact-symbol scalar/array views.
Two-dimensional views preserve GCC's retail comparison-as-subscript lowering
for `controllerConfig`, and its `gPadinfo + port*8` address tree with the
attested `+4/+5/+6/+8/+9/+10` field displacements.  The final graph is 88/88
named and 2/2 anonymous with no extra type or typedef semantics.  All ten
Device functions remain PASS, both `gmesetup.cpp` functions remain PASS after
the guarded shared-header refactor, and full-debug output contains the retail
`analogs` local without a synthetic carrier local or alias definition.  The TU
uses only its retail-proven `-G8` compiler input and has no post-recompile
rewrite entry.  The local, undefined-symbol, build-route, and gate evidence is
retained in the
[`device source-authority receipt`](scratchpad/root_sym_audit/device_source_authority_receipt_20260823.txt).

`psxcontroller.obj` is now strict-exact through the same guarded
`gmesetup.obj` surface, with the foreign owning `GameSetup_tData` and
`FEI_tList` bodies omitted.  Its two opaque external objects are represented
by exact-symbol scalar/array views: `GameSetup_gData` supplies the attested
word offsets without importing its foreign body, while `gPadinfo` preserves
the retail eight-byte row/index tree.  The final graph is 86/86 named and 2/2
anonymous with no extra type or typedef semantics.  `InGame_ResetPSXController`,
`InGame_GetDevice`, and `InGame_SetRamp` retain PASS; the detailed local-scope
receipt explicitly keeps two non-exact items open: `InGame_GetPSXPadValue`'s
`newControl` currently occupies `$a0` instead of retail `$v0`, and SetRamp's
load-bearing block-local `hb` has no retail record.  The current type-graph and
scope evidence is retained in
[`type_graph_psxcontroller_w78_current_20260823.tsv`](scratchpad/root_sym_audit/type_graph_psxcontroller_w78_current_20260823.tsv)
and
[`psxcontroller scope audit`](scratchpad/root_sym_audit/psxcontroller_scope_audit_20260823.md).

The mapped C++ units cover all retail named and anonymous type bodies, but are
not source-exact while they expose unrelated monolithic-header declarations or
miss owner-specific typedef variants.  The three C units that previously had
genuine missing retail type sets are now exact.

Strict evidence:

- [`type_graph_game_psx_after_psxcontroller_20260823.tsv`](scratchpad/root_sym_audit/type_graph_game_psx_after_psxcontroller_20260823.tsv)
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
- [`type_graph_game_psx_after_audio_20260823.tsv`](scratchpad/root_sym_audit/type_graph_game_psx_after_audio_20260823.tsv)
- [`type_graph_game_psx_after_overlays_20260823.tsv`](scratchpad/root_sym_audit/type_graph_game_psx_after_overlays_20260823.tsv)
- [`type_graph_game_psx_after_weather_20260823.tsv`](scratchpad/root_sym_audit/type_graph_game_psx_after_weather_20260823.tsv)
- [`type_graph_game_psx_after_rpause_20260823.tsv`](scratchpad/root_sym_audit/type_graph_game_psx_after_rpause_20260823.tsv)
- [`type_graph_game_psx_after_hrzsku_20260823.tsv`](scratchpad/root_sym_audit/type_graph_game_psx_after_hrzsku_20260823.tsv)
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
  [`texture`](scratchpad/root_sym_audit/type_graph_texture_final_20260823.tsv), and
  [`draw`](scratchpad/root_sym_audit/type_graph_draw_final_20260823.tsv), and
  [`sfx`](scratchpad/root_sym_audit/type_graph_sfx_final_20260823.tsv), and
  [`trsproj`](scratchpad/root_sym_audit/type_graph_trsproj_final_20260823.tsv), and
  [`cario`](scratchpad/root_sym_audit/type_graph_cario_final_20260823.tsv), and
  [`platform`](scratchpad/root_sym_audit/type_graph_platform_final_20260823.tsv), and
  [`force`](scratchpad/root_sym_audit/type_graph_force_final_20260823.tsv), and
  [`audio`](scratchpad/root_sym_audit/type_graph_game_psx_after_audio_20260823.tsv),
  [`overlays`](scratchpad/root_sym_audit/type_graph_game_psx_after_overlays_20260823.tsv),
  [`weather`](scratchpad/root_sym_audit/type_graph_game_psx_after_weather_20260823.tsv), and
  [`rpause`](scratchpad/root_sym_audit/type_graph_rpause_final_20260823.tsv), and
  [`hrzsku`](scratchpad/root_sym_audit/type_graph_hrzsku_final_20260823.tsv), and
  [`textureprocess`](scratchpad/root_sym_audit/type_graph_textureprocess_final_20260823.tsv), and
  [`skidmark`](scratchpad/root_sym_audit/type_graph_skidmark_final_20260823.tsv), and
  [`fe3dmenu`](scratchpad/root_sym_audit/type_graph_fe3dmenu_final_20260823.tsv), and
  [`device`](scratchpad/root_sym_audit/type_graph_device_final_20260823.tsv), and
  [`psxcontroller`](scratchpad/root_sym_audit/type_graph_psxcontroller_w78_current_20260823.tsv).

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

### P6 — Seventh game/PSX PASS-lock cleanup (`2026-08-23`)

The seventh PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers7_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers7_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit7_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit7_20260823.md).

It removes three source-only locals from byte-matched functions and classifies
ten proven source-only codegen/ABI carriers.  The game/PSX declaration result is
now 276/395 clean, with zero missing SYM names, 755 generic extra local names,
102 explicit source-only carriers, one function type finding, and zero global
type findings.  The only function type finding remains
`DrawC_PrimClip::facetFlag`; that function is unmatched and was kept read-only
under the user's current lock.

Detailed `tools/verify_asm.py` whole-TU gates confirm every edited function is
still PASS.  Existing unmatched rows in `hrzsku`, `cario`, `drawc`, `draww`, and
`hud` were observed but not edited.  They remain backlog work until the user
explicitly unlocks unmatched function bodies.

### P7 — Eighth game/PSX PASS-lock cleanup (`2026-08-23`)

The eighth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers8_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers8_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit8_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit8_20260823.md).

It removes seven source-only local names from byte-matched functions and
classifies seven oracle-measured source-only codegen carriers. The game/PSX
declaration result is now 286/395 clean, with zero missing SYM names, 741
generic extra local names, 109 explicit source-only carriers, one function type
finding, and zero global type findings. The only function type finding remains
`DrawC_PrimClip::facetFlag`; that function is unmatched and remained read-only.

Detailed whole-TU gates confirm all edited functions remain PASS. Existing
locked mismatches in `draww`, `hud`, and `night` were observed but not edited;
`textureprocess` is 16/16 PASS.

### P8 — Ninth game/PSX PASS-lock cleanup (`2026-08-23`)

The ninth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers9_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers9_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit9_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit9_20260823.md).

It removes two source-only declarations from byte-matched functions and
classifies eight oracle-measured source-only codegen carriers. The game/PSX
declaration result is now 292/395 clean, with zero missing SYM names, 731
generic extra local names, 117 explicit source-only carriers, one function type
finding, and zero global type findings. The only function type finding remains
the locked `DrawC_PrimClip::facetFlag` row.

Detailed whole-TU gates confirm all edited functions remain PASS. Existing
locked mismatches in `cario`, `drawc`, `draww`, and `hud` were observed but not
edited.

### P9 — Tenth game/PSX PASS-lock cleanup (`2026-08-23`)

The tenth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers10_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers10_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit10_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit10_20260823.md).

It removes eight source-only local names from byte-matched functions and
classifies fourteen oracle-measured source-only codegen carriers. The game/PSX
declaration result is now 303/395 clean, with zero missing SYM names, 709
generic extra local names, 131 explicit source-only carriers, one function type
finding, and zero global type findings. The sole function type finding remains
the locked `DrawC_PrimClip::facetFlag` row.

Detailed whole-TU gates confirm every edited function remains PASS. Existing
locked mismatches in `drawc`, `hrzsku`, `hud`, and `night` were observed but
not edited; `flare` and `weather` are fully PASS.

### P10 — Eleventh game/PSX PASS-lock cleanup (`2026-08-23`)

The eleventh PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers11_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers11_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit11_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit11_20260823.md).

It removes twelve source-only local names from byte-matched functions and
classifies sixteen oracle/compiler-measured source-only codegen carriers. The
game/PSX declaration result is now 313/395 clean, with zero missing SYM names,
681 generic extra local names, 147 explicit source-only carriers, one function
type finding, and zero global type findings. The sole function type finding
remains the locked `DrawC_PrimClip::facetFlag` row.

Detailed whole-TU gates confirm every edited function remains PASS. Existing
locked mismatches in `cario`, `draww`, `hud`, `night`, and `overlays` were
observed but not edited; `flare` remains fully PASS.

### P11 — Twelfth game/PSX PASS-lock cleanup (`2026-08-23`)

The twelfth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers12_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers12_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit12_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit12_20260823.md).

It removes sixteen source-only local names from byte-matched functions and
classifies seven oracle/compiler-measured source-only codegen carriers. The
game/PSX declaration result is now 320/395 clean, with zero missing SYM names,
658 generic extra local names, 154 explicit source-only carriers, one function
type finding, and zero global type findings. The sole function type finding
remains the locked `DrawC_PrimClip::facetFlag` row.

Detailed whole-TU gates confirm every edited function remains PASS. Existing
locked mismatches in `drawc`, `draww`, and `hud` were observed but not edited.

### P12 — Thirteenth game/PSX PASS-lock cleanup (`2026-08-23`)

The thirteenth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers13_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers13_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit13_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit13_20260823.md).

It removes nine unproven source names from byte-matched functions and classifies
six oracle/compiler-measured source-only codegen carriers. The two unused
`Hud_Draw321Num` formals retain their mangling-proven types and positions but no
longer assert names absent from the SYM. The game/PSX declaration result is now
325/395 clean, with zero missing SYM names, 643 generic extra local names, 160
explicit source-only carriers, one function type finding, and zero global type
findings. The sole function type finding remains the locked
`DrawC_PrimClip::facetFlag` row.

Detailed whole-TU gates confirm every edited function remains PASS. Existing
locked mismatches in `draww` and `hud` were observed but not edited;
`fe3dmenu` and `flare` are fully PASS.

### P13 — Fourteenth game/PSX PASS-lock cleanup (`2026-08-23`)

The fourteenth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers14_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers14_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit14_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit14_20260823.md).

It removes seven source-only locals from byte-matched functions and classifies
ten oracle/compiler-measured source-only codegen carriers. The game/PSX
declaration result is now 329/395 clean, with zero missing SYM names, 626
generic extra local names, 170 explicit source-only carriers, one function type
finding, and zero global type findings. The sole function type finding remains
the locked `DrawC_PrimClip::facetFlag` row.

Detailed whole-TU gates confirm every edited function remains PASS. The only
observed failures are unchanged locked rows in `drawc` and `night`.

### P14 — Fifteenth game/PSX PASS-lock cleanup (`2026-08-23`)

The fifteenth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers15_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers15_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit15_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit15_20260823.md).

It removes twelve source-only locals from byte-matched functions and classifies
five source-only codegen carriers backed by existing oracle/compiler receipts.
The game/PSX declaration result is now 333/395 clean, with zero missing SYM
names, 609 generic extra local names, 175 explicit source-only carriers, one
function type finding, and zero global type findings. The sole function type
finding remains the locked `DrawC_PrimClip::facetFlag` row.

Detailed whole-TU gates confirm every edited function remains PASS. Existing
locked mismatches in `draww`, `hud`, and `hrzsku` were observed but not edited.

### P15 — Sixteenth game/PSX PASS-lock cleanup (`2026-08-23`)

The sixteenth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers16_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers16_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit16_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit16_20260823.md).

It removes fourteen source-only locals from byte-matched functions and
classifies nine source-only codegen carriers backed by measured rejected forms
or existing oracle/compiler receipts. The game/PSX declaration result is now
338/395 clean, with zero missing SYM names, 586 generic extra local names, 184
explicit source-only carriers, one function type finding, and zero global type
findings. The sole function type finding remains the locked
`DrawC_PrimClip::facetFlag` row.

Detailed whole-TU gates confirm every edited function remains PASS. Existing
locked mismatches in `hud` were observed but not edited; `flare`, `weather`,
and `fe3dmenu` are fully PASS.

### P16 — Seventeenth game/PSX PASS-lock cleanup (`2026-08-23`)

The seventeenth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers17_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers17_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit17_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit17_20260823.md).

It resolves twenty-five generic source-local discrepancies in four byte-matched
functions, removing decompiler temporaries or classifying five measured
codegen carriers. The game/PSX declaration result is now 342/395 clean, with
zero missing SYM names, 562 generic extra local names, 189 explicit source-only
carriers, one function type finding, and zero global type findings. The sole
function type finding remains the locked `DrawC_PrimClip::facetFlag` row.

Detailed whole-TU gates confirm every edited function remains PASS. Existing
locked mismatches in `hud` and `overlays` were observed but not edited;
`weather` is 25/25 PASS.

### P17 — Eighteenth game/PSX PASS-lock cleanup (`2026-08-23`)

The eighteenth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers18_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers18_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit18_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit18_20260823.md).

It replaces hand-written ordering-table mask/OR reconstructions with the
canonical PsyQ 24-bit `P_TAG` field expansion in eight byte-matched functions,
removing thirty-three fabricated local names and classifying four independently
measured color-load carriers. The game/PSX declaration result is now 350/395
clean, with zero missing SYM names, 525 generic extra local names, 193 explicit
source-only carriers, one function type finding, and zero global type findings.

Detailed whole-TU gates confirm `flare.cpp` is 27/27 PASS and `hrzsku.cpp` is
20/22 PASS. The two horizon mismatches were observed read-only and remain locked.

### P18 — Nineteenth game/PSX PASS-lock cleanup (`2026-08-23`)

The nineteenth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers19_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers19_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit19_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit19_20260823.md).

It resolves twenty-five generic discrepancies in five byte-matched functions:
twenty source-only names were removed and five compiler-measured names were
classified as explicit codegen carriers. The game/PSX declaration result is now
355/395 clean, with zero missing SYM names, 501 generic extra local names, 198
explicit source-only carriers, one function type finding, and zero global type
findings. The sole function type finding remains the locked
`DrawC_PrimClip::facetFlag` row.

Detailed whole-TU gates confirm `flare.cpp` is 27/27 PASS, `hud.cpp` is 59/62
PASS, and `draww.cpp` is 31/35 PASS. All seven failures were observed read-only
and remain locked.

### P19 — Twentieth game/PSX PASS-lock cleanup (`2026-08-23`)

The twentieth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers20_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers20_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit20_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit20_20260823.md).

It removes six decompiler-only values from byte-matched `Hud_BuildSprite` and
classifies all six independently measured codegen carriers in byte-matched
`Hud_BuildString`. The game/PSX declaration result is now 357/395 clean, with
zero missing SYM names, 489 generic extra local names, 204 explicit source-only
carriers, one function type finding, and zero global type findings.

The whole-TU detailed gate confirms `hud.cpp` remains 59/62 PASS. Its three
failures were observed read-only and remain locked.

### P20 — Twenty-first game/PSX PASS-lock cleanup (`2026-08-23`)

The twenty-first PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers21_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers21_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit21_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit21_20260823.md).

It removes twenty-eight unused, non-SYM declarations from four byte-matched Hud
packet builders. The game/PSX declaration result is now 361/395 clean, with
zero missing SYM names, 461 generic extra local names, 204 explicit source-only
carriers, one function type finding, and zero global type findings.

The whole-TU detailed gate confirms `hud.cpp` remains 59/62 PASS. Its three
failures were observed read-only and remain locked.

### P21 — Twenty-second game/PSX PASS-lock cleanup (`2026-08-23`)

The twenty-second PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers22_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers22_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit22_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit22_20260823.md).

It reconciles twenty-one generic discrepancies across byte-matched
`Hud_BuildTimeSprites`, `Flare_CarShapedHalo`, and `Flare_Halo2`, using
canonical PsyQ tag fields, an unnamed ABI-only parameter, dead-declaration
removal, and explicit compiler-carrier evidence. The game/PSX declaration
result is now 364/395 clean, with zero missing SYM names, 442 generic extra
local names, 211 explicit source-only carriers, one function type finding, and
zero global type findings.

Detailed gates confirm `flare.cpp` is 27/27 PASS and `hud.cpp` is now **60/62
PASS**. `Hud_BuildNumbers` became PASS 758/758 without a body edit; the two
remaining Hud failures were observed read-only and remain locked.

### P22 — Twenty-third game/PSX PASS-lock cleanup (`2026-08-23`)

The twenty-third PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers23_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers23_20260823.md)
and the generated audit
[`game_psx_passlock_audit23_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit23_20260823.md).

It converts twenty-seven generic Hud discrepancies into explicit
compiler-measured carrier dispositions. The game/PSX declaration result reaches
368/395 clean, with zero missing SYM names, 415 generic extra locals, and 238
explicit source-only carriers. `hud.cpp` remains 60/62 PASS.

### P23 — Twenty-fourth game/PSX PASS-lock cleanup (`2026-08-23`)

The twenty-fourth PASS-only declaration wave is recorded in
[`game_psx_passlock_carriers24_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_carriers24_20260823.md)
and the refreshed generated audit
[`game_psx_passlock_audit24_20260823.md`](scratchpad/root_sym_audit/game_psx_passlock_audit24_20260823.md).

It restores natural indexed-array source in `Hrz_GetHorizonPixMap` and canonical
SYM loop locals in `Weather_Init`, resolving nineteen generic discrepancies.
The game/PSX declaration result is now 370/395 clean, with zero missing SYM
names, 396 generic extra locals, 240 explicit source-only carriers, one function
type finding, and zero global type findings.

Detailed gates confirm `hrzsku.cpp` is 20/22 PASS and `weather.cpp` is 25/25
PASS. The two horizon failures were observed read-only and remain locked.

### P24 — Canonical PsyQ `INTR_DMA.obj` internal names (`2026-08-24`)

`recon/syslib/psx/libetc/INTR_DMA.c` now uses the recovered PsyQ source
identifiers `trapIntrDMA`, `setIntrDMA`, and `DMA_memclr` instead of the
reconstruction-only identifiers `_dma_isr`, `func_80106878`, and `_bzero_w`.
The canonical PsyQ 4.3 archive proves the enclosing 672-byte
`startIntrDMA`/`INTR_DMA.obj` member; the internal name/order/body mapping is
independently corroborated by the SOTN, Xenogears, psyz, and Rage Racer PsyQ
reconstructions. Explicit asm-name aliases retain NFS4's existing retail
linker labels, so the source identifiers are restored without a post-compile
rewrite or an instruction-template body.

Two repeated detailed gates preserve `startIntrDMA` PASS 19/19,
`trapIntrDMA` (`_dma_isr`) PASS 96/96, and `DMA_memclr` (`_bzero_w`) PASS 9/9.
`setIntrDMA` retains its pre-existing 36-diff residual at 41/43 instructions;
the naming correction is codegen-neutral. `tools/slotcheck.py` reports
`bad = 0`, and the vtable indexing audit remains clean.

### P25 — Hud/DrawW source-semantic reconciliation (`2026-08-24`)

The current game/PSX declaration audit is recorded in
`scratchpad/root_sym_audit/game_psx_after_spike_reconcile_20260824.md`.
It advances the strict result from 370/395 to 372/395 declaration-clean
functions and reduces generic extra source-local names from 395 to 381.
Missing SYM names remain zero; the sole type finding remains the separately
receipted `DrawC_PrimClip::facetFlag` case.

`Hud_BuildCdPlayer` now spells its unused second `int` parameter without an
invented name. The `Fii` mangling proves the parameter's type and position,
while the function's complete SYM block names only `type`; the unnamed C++
parameter is therefore the strongest recoverable source form. Seven remaining
source-only compiler-shaping names now carry individual measured
`SYM-CODEGEN-CARRIER` receipts. In particular, directly testing the activation
condition removes `bVar2`/`uVar5` but is FAIL 5 at 474/475 instructions, so
that tempting cleanup was rejected rather than weakening the PASS.

`DrawW_BuildSpikeBelt` removes the fabricated `sdG` alias and uses the typed
view of the existing SYM parameter `sd` directly with unchanged codegen. Its
five remaining source-only GIV/allocation names have explicit W74-W76 receipts;
removing the `p`/`q` address pseudos was independently re-tested here and is
FAIL 145 at 279/268 instructions, so they are retained as proven codegen
carriers rather than generic review rows.

Two repeated detailed gates preserve `Hud_BuildCdPlayer` PASS 475/475 and
`DrawW_BuildSpikeBelt` PASS 268/268. Two repeated whole-TU gates preserve
`hud.cpp` at 61/62 PASS (only the unchanged `Hud_RenderTacView`, 11 diffs) and
`draww.cpp` at 31/35 PASS (the same four pre-existing residuals: 8/9/20/66).
`psyqproof.py` reports REAL=0 and RELOP=0 for both edited functions, and the
vtable indexing audit remains clean.

### P26 — Numbers/MenuColor source-identity reconstruction (`2026-08-24`)

The refreshed game/PSX audit is recorded in
`scratchpad/root_sym_audit/game_psx_after_menucolor_reconcile_20260824.md`.
It advances the strict result from 372/395 to 374/395 declaration-clean
functions and reduces generic extra source-local names from 381 to 368.
Missing SYM names remain zero; explicit source-only codegen carriers increase
from 252 to 260 because every retained name below now has a measured receipt.

`Hud_BuildNumbers0` removes two dead block declarations of `SPRT *p`. Its seven
formerly generic source-only identities are now individually falsified against
natural SYM-only rewrites: reusing `y` is FAIL 54, reusing `i` is FAIL 8,
duplicating the `etime` calls is FAIL 6, mutating `num` instead of `last` is
FAIL 6, merging `pal_2` is FAIL 44, and inlining the remaining `p` is FAIL 73
at 530/531. The precomputed `eSprt` already has the function's seal receipt.

`DrawC_MenuColorData` removes five reconstruction-only locals. The early
car-type check reuses the SYM `menuColor` variable before its later menu-color
assignment; `carInfo` fields are accessed directly; and the two final palette
calls are restored inside their natural branches, after which GCC cross-jumps
their common call tail exactly as retail. The sole retained source-only name,
`menuColorSlot`, has a current direct-index falsification of FAIL 26 at the
same 136 instructions.

Repeated detailed gates preserve `Hud_BuildNumbers0` PASS 531/531 and
`DrawC_MenuColorData` PASS 136/136. Repeated whole-TU gates preserve `hud.cpp`
at 61/62 PASS (only unchanged `Hud_RenderTacView`, 11 diffs) and confirm
`drawc.cpp` is 20/20 PASS. `psyqproof.py` reports REAL=0 and RELOP=0 for both
edited functions, and the vtable indexing audit remains clean.

### P27 — DrawW line-builder SYM reconciliation (`2026-08-24`)

The refreshed strict game/PSX declaration audit advances from 374/395 to
375/395 declaration-clean functions and reduces generic extra source-local
names from 368 to 359. Missing SYM names remain zero. The audit also exposed
and removed one inert duplicate `uVar5` declaration after the end of
`hud.cpp`; this returns the object-owned data result to its prior 0 missing / 61
extra definitions instead of silently counting the stray line as a global.

`DrawW_DoLines` now reuses the SYM-recorded `geomRez` local for the night-light
flag byte instead of inventing a separate `bVar1`. Its eight remaining
source-only identities have explicit oracle receipts: `m` and `m2` preserve
the measured mixed `matB` lvalue form; `posX`, `posY`, and `posZ` preserve the
retail pointer-chase statement/load-delay shape; and directly folding `tx`,
`ty`, and `tz` into the final subtractions is FAIL 6 at the same 199
instructions because it moves the translation loads.

Two repeated detailed gates preserve `DrawW_DoLines` PASS 199/199 and
`Hud_BuildCdPlayer` PASS 475/475. Two repeated whole-TU gates preserve
`draww.cpp` at 31/35 PASS (the same four pre-existing residuals: 8/9/20/66)
and `hud.cpp` at 61/62 PASS (only the unchanged `Hud_RenderTacView`, 11
diffs). Production PsyQ proof reports REAL=0 and RELOP=0 for both functions,
and the vtable indexing audit remains clean.

### P28 — License-builder source reconstruction (`2026-08-24`)

The refreshed strict game/PSX declaration audit advances from 375/395 to
376/395 declaration-clean functions and reduces generic extra source-local
names from 359 to 349. Missing SYM names remain zero, and the object-owned data
result remains 0 missing / 61 extra definitions.

`CarIO_CreateLicense` removes three decompiler-only value names without losing
their evaluation order. The header and CLUT copy loops now use natural chained
assignments, eliminating `hdr` and `tu3`; the first flag RMW uses its expression
directly, eliminating `f1`. Seven retained aliases are independently required
to express retail's may-alias scheduling: `p1`/`p2` preload both header-copy
bases before either chained store, `q1`/`q2` do the same for the flag RMW,
`r1`/`r2` form the separately allocated width-store pair, and `f2` keeps the
second flag byte live across the first store. Current SYM-variable reuse tests
are FAIL 78 for `q1`/`q2`, FAIL 58 for `r1`/`r2`, and FAIL 11 at 230/229 when
`f2` is tied to `r2`; all were rejected and restored before landing.

Two repeated detailed gates preserve `CarIO_CreateLicense` PASS 229/229. Two
repeated whole-TU gates preserve `cario.cpp` at 10/11 PASS, with only the
unchanged `CarIO_ReadInCarTextureData` residual (19 diffs). Production PsyQ
proof with the existing validated text-move recipe reports REAL=0 and RELOP=0,
and the vtable indexing audit remains clean.

### P29 — Hud-view tag-link reconstruction (`2026-08-24`)

The refreshed strict game/PSX declaration audit advances from 376/395 to
377/395 declaration-clean functions and reduces generic extra source-local
names from 349 to 340. Missing SYM names remain zero, and the object-owned data
result remains 0 missing / 61 extra definitions.

`Hud_RenderHudView` removes all three block-local `tagp` declarations by
restoring direct tag-link lvalues, and removes `viewp` by stopping the current
view before advancing the two source walkers. These natural forms remain
byte-exact. The stale claim that `viewOff`/`tpageOff` were compiler-generated
GIVs is corrected: replacing them with `j`-indexed expressions is measured
FAIL 248 at 604/606, proving that the walkers are source-significant.

The seven remaining source-only identities now carry explicit evidence.
`otmask` fixes the retail spill-declaration order; `ww2p1` prevents an unwanted
constant fold; `cdshow` preserves the measured default/override branch shape;
and `pw` is the two-reference local-allocation dial. Directly replacing `pal`
with `Render_gPalettePtr` in its three link blocks is FAIL 48/610, FAIL 11/607,
and FAIL 30/608 respectively, so the alias is retained as a measured carrier.

Two repeated detailed gates preserve `Hud_RenderHudView` PASS 606/606. Two
repeated whole-TU gates preserve `hud.cpp` at 61/62 PASS, with only the
unchanged `Hud_RenderTacView` residual (11 diffs). Production PsyQ proof reports
REAL=0 and RELOP=0, and the vtable indexing audit remains clean.

### P30 — Canonical PsyQ lens-flare tag linking (`2026-08-24`)

The refreshed strict game/PSX declaration audit advances from 377/395 to
378/395 declaration-clean functions and reduces generic extra source-local
names from 340 to 330. Missing SYM names remain zero, and the object-owned data
result remains 0 missing / 61 extra definitions.

`Flare_LensFlare` replaces the hand-masked `slot`/`pkt24`/`addr24_0` ordering-
table tail with the canonical PsyQ `addPrim` source shape, expressed through
the SDK-compatible `P_TAG` bitfield pair. This removes all three reconstruction
temporaries while preserving the exact 409-word retail function.

The seven retained source-only identities now have explicit current or
previously measured receipts. Literalizing the zero-valued `otz` loses the
retail shift/address chain (FAIL 6 at 407/409), and inlining `colw` is current
FAIL 24/409. `pp`/`cp` must be born before the head fence to force the retail
argument-slot reload; `otSize` keeps the view-size load separate from `-2`;
and fenced `vx0`/`vy0` materialize the two retail copies into `sx`/`sy` rather
than folding the loads directly into their homes.

Two repeated detailed gates preserve `Flare_LensFlare` PASS 409/409. Two
repeated whole-TU gates confirm `flare.cpp` is 27/27 PASS. Production PsyQ proof
with the existing validated text moves reports REAL=0 and RELOP=0, and the
vtable indexing audit remains clean.

### P31 — Simple-object source-identity reconstruction (`2026-08-24`)

The refreshed strict game/PSX declaration audit advances from 378/395 to
379/395 declaration-clean functions and reduces generic extra source-local
names from 330 to 320. Missing SYM names remain zero, and the object-owned data
result remains 0 missing / 61 extra definitions.

`DrawObjectSimple` removes the `shapeDef_p` alias and stores `Track_materials`
directly with unchanged code generation. The nine retained source-only
identities have explicit falsification receipts: direct `vertexCount` is FAIL
8/189; direct `gNight_renderNight` is FAIL 6/189; folding the target-position
splits is FAIL 38 at 185/189; folding the six view-translation loads into their
stores is FAIL 12/189; and replacing the mixed `m`/direct `matB` lvalues with
fully direct access is FAIL 4/189. The failed mixed-lvalue probe initially
touched the analogous sibling block in `DrawObjectTransform`; it was restored
and that neighbor was explicitly re-gated PASS 214/214 before landing.

Two repeated detailed gates preserve `DrawObjectSimple` PASS 189/189. Two
repeated whole-TU gates preserve `draww.cpp` at 31/35 PASS with the same four
pre-existing residuals (8/9/20/66). Production PsyQ proof with the existing
validated text moves reports REAL=0 and RELOP=0, and the vtable indexing audit
remains clean.

### P32 — Transformed-object inline-helper reconstruction (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_transform_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_transform_reconcile_20260824.md).
It advances the result from 379/395 to 380/395 declaration-clean functions and
reduces generic extra source-local names from 320 to 309. Missing SYM names
remain zero, and the object-owned data result remains 0 missing / 61 extra
definitions.

`DrawObjectTransform` removes the fabricated integer address carrier
`mat_local`. The matrix tail is now expressed as a second block-local
`MATRIX *m`, matching the inline-helper source scope already used in the night
matrix block. This preserves the retail `$s0` matrix base and remains byte-exact;
making the entire tail use direct `&sd->matB` expressions is current FAIL 4 at
the same 214 instructions.

The ten remaining source-only identities now carry explicit evidence. Directly
using `objDef->vertexCount` is current FAIL 4/214; directly testing
`gNight_renderNight` is FAIL 10/214; and replacing the early `shapeDef_p` load
and later store with direct `Track_materials` access is FAIL 12/214 at both
natural statement positions. The existing SLD/oracle receipt records the
three-axis `posX`/`posY`/`posZ` and `tX`/`tY`/`tZ` split-load shape: folding the
axes expands the function to 217 instructions against retail's 214. The two
block-local `m` declarations therefore represent one measured inline-helper
identity rather than the removed reconstruction-only integer alias.

Two repeated detailed gates preserve `DrawObjectTransform` PASS 214/214 and
`DrawObjectSimple` PASS 189/189. Two repeated whole-TU gates preserve
`draww.cpp` at 31/35 PASS with the same four pre-existing residuals
(8/9/20/66). Production PsyQ proof reports REAL=0 and RELOP=0, and the vtable
indexing audit remains clean.

### P33 — Custom-object source-identity reconstruction (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_buildcustom_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_buildcustom_reconcile_20260824.md).
It advances the result from 380/395 to 381/395 declaration-clean functions,
reduces generic extra source-local names from 309 to 299, and keeps missing SYM
names at zero. The object-owned data result remains 0 missing / 61 extra
definitions.

`DrawW_BuildCustomObjectFacets` removes three decompiler-only aliases without
changing its 200-word retail body. `objDef_p` is replaced by the direct
`Object_GetAnim(...) == 0` test; `instData_p` is replaced by the direct
`ObjectClipped(...) != 0` test; and the cached byte `tc5` is replaced by the
natural `objInstance->type` field tests. The virtual-dispatch receiver is moved
into its actual arm scope and renamed from Ghidra's `pOVar5` to source-level
`anim`.

Every remaining source-only identity has an explicit oracle receipt. Folding
`buildResult` into the distance guard is current FAIL 8 at 204/200. Removing
the integer `bVar7` control funnel changes the frame and is FAIL 146 at 196/200.
The shared `transMat` base is the measured 11-to-9 `sd` reference dial that
reproduces retail's argument spill; `t3` preserves the third fixed-multiply
result until its retail store slot; and the `g`/`zo` pair preserves the exact
offset-table allocation and load issue order. The arm-local `anim` is required
to evaluate `Object_GetAnim` once before its virtual call; optimized SYM does
not describe that transient source local.

Repeated detailed gates preserve `DrawW_BuildCustomObjectFacets` PASS 200/200,
`DrawObjectTransform` PASS 214/214, and `DrawW_BuildObjectFacets` PASS 189/189.
Two repeated whole-TU gates preserve `draww.cpp` at 31/35 PASS with the same
four pre-existing residuals (8/9/20/66). Production PsyQ proof reports REAL=0
and RELOP=0, and the vtable indexing audit remains clean.

### P34 — PrimClip promoted `facetFlag` proof (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_primclip_type_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_primclip_type_reconcile_20260824.md).
It closes the final raw type-comparison finding (1 -> 0), keeps all 395 SYM
functions mapped, and keeps missing SYM names at zero. The result remains
381/395 declaration-clean because `DrawC_PrimClip` still has separately queued
source-only identities, but its reliable type evidence is no longer left as an
unclassified contradiction.

SYM records `facetFlag` as `SHORT` in both the case-8 and case-9 source blocks.
Each block was recompiled independently with that exact spelling in the final
W76 source basin: either single-site change is FAIL 15 at 1878/1877, while both
together are FAIL 30 at 1879/1877. The mismatch consists of the extra narrow
reload/sign-extension path and its resulting register rotation. The byte-exact
body therefore retains an `int` promoted carrier at each site and now marks the
pair as an explicit oracle-proven SYM type override rather than ignoring the
debug records.

Repeated detailed gates preserve `DrawC_PrimClip` PASS 1877/1877 and its
`DrawC_Prim` sibling PASS 1389/1389. Two repeated whole-TU gates confirm
`drawc.cpp` is 20/20 PASS. Production PsyQ proof reports REAL=0 and RELOP=0,
and the vtable indexing audit remains clean.

### P35 — Subdivision `addPrim` source reconstruction (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_subdivid_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_subdivid_reconcile_20260824.md).
It advances the result from 381/395 to 382/395 declaration-clean functions,
reduces generic extra source-local names from 299 to 297, keeps raw type
findings at zero, and keeps missing SYM names at zero.

`DrawW_SubdividFacet` no longer invents a `pal` local in each of its four GT3
packet blocks. The OT link is restored as the canonical PsyQ 4.3 `addPrim`
setaddr/getaddr expansion: the OT expression appears directly in both tag
assignments, and GCC performs the commoning itself. This removes the four
decompiler-derived aliases with byte-identical output. The sole remaining
source-only identity, `q`, is explicitly receipted: its named `n + 1` pivot is
the measured allocation cell that reduced this function from 26 differences
to the current 8.

The authoritative residual remains exactly 8 differences at 588/588: four
identical `addiu` instructions occupy different positions in the `n`/`q`
index-chain schedule. Production PsyQ proof reports RELOP=0 and 13 real
position-sensitive words for that same residual. Repeated whole-TU gates keep
`draww.cpp` at 31/35 PASS with the same four residuals (8/9/20/66), the adjacent
`DrawW_AddSubdividPrimGT3` helper remains PASS 28/28, and the vtable indexing
audit remains clean.

### P36 — Tactical-view canonical index/tag reconstruction (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_tacview_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_tacview_reconcile_20260824.md).
It advances the result from 382/395 to 383/395 declaration-clean functions,
reduces generic extra source-local names from 297 to 293, keeps raw type
findings at zero, and keeps missing SYM names at zero.

`Hud_RenderTacView` removes three reconstruction-only aliases with no opcode
movement. Repeated `j * 4 + Hud_gTacView` expressions let GCC form the single
shared index itself, eliminating `j4`. The canonical PsyQ `addPrim` expansion
uses `Render_gPalettePtr` and `&gTPage1[j][2]` directly, eliminating `pal` and
`tp` while preserving the existing OT-tag and +0x30 GIV shapes. The remaining
source-only `dh` identity is explicitly receipted: direct `DashHUD_gInfo` and
`DashHUD_view` spellings were measured across the existing source grid at
FAIL 35-40 and lose the shared low-address sum.

The authoritative residual remains 11 differences at 72/71, confined to the
two self-temporary global loads and the missing cross-block high-half reuse.
Repeated whole-TU gates preserve `hud.cpp` at 61/62 PASS with only this same
function outstanding; the adjacent `Hud_RenderMapView` remains PASS 161/161,
and the vtable indexing audit remains clean.

### P37 — Sky-builder compiler-carrier classification (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_buildsky_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_buildsky_reconcile_20260824.md).
It advances the result from 383/395 to 384/395 declaration-clean functions,
reduces generic extra source-local names from 293 to 289, and preserves zero
missing SYM names and zero raw type findings.

`Hrz_BuildSky`'s four non-SYM identities are now tied to their existing
measured source/codegen receipts rather than left as generic review findings.
The block-local `hpb` split makes the pixmap-table address appear first to
loop.c while leaving the indexed load last (the measured 150-to-146 lever).
`c0` splits the first colour load from its packet store so the cursor bump fills
the load-delay slot. `slot` keeps each PsyQ OT cell single-evaluated across an
aliasing packet-pointer store; repeating the full expression adds 16
instructions. `tag` stages the FT4 OT word so that same packet-pointer store
can remain between the OT read and write.

The authoritative function remains count-exact at 458/458 with 146 differences;
this checkpoint classifies reliable SYM/source information without claiming
that the remaining allocation rotations are solved. Two whole-TU gates preserve
`hrzsku.cpp` at 20/22 PASS with the same `Hrz_BuildHorizon` 12 and
`Hrz_BuildSky` 146 residuals. The adjacent `Hrz_SetDitheringPrim` remains PASS
34/34, and the vtable indexing audit remains clean.

### P38 — Shadow-divider SYM block reconstruction (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_divshadow_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_divshadow_reconcile_20260824.md).
It advances the result from 384/395 to 385/395 declaration-clean functions and
reduces generic extra source-local names from 289 to 280 while preserving zero
missing SYM names and zero raw type findings.

`DrawC_DivideShadowPrim` now uses the retail SYM identities and scopes instead
of parallel Ghidra names. The previously unused block local `ot` replaces
`puVar6`; the recorded `clut` and `tpage` locals replace `uVar1` and the direct
CLUT path. Unused `uVar2`/`uVar3` are deleted, `iVar4` is folded into the natural
`sd->otz` update and guards, and `mlo`/`mhi` are restored as literal tag masks.
All of those changes remain byte-exact.

Only two source-only carriers remain, with direct-form receipts. The staged OT
cell `otp` avoids six extra address/reload instructions; repeating its full
expression is FAIL 16 at 128/122. The staged `color` load preserves the retail
load-delay/store register shape; a direct `sd->color` store is FAIL 5 at
123/122.

Repeated detailed gates preserve `DrawC_DivideShadowPrim` PASS 122/122 and
`DrawC_ShadowPrim` PASS 129/129. Two whole-TU gates confirm `drawc.cpp` remains
20/20 PASS. Production PsyQ proof reports REAL=0 and RELOP=0, and the vtable
indexing audit remains clean.

### P39 — Triangle-divider SYM block reconstruction (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_divprim_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_divprim_reconcile_20260824.md).
It advances the result from 385/395 to 386/395 declaration-clean functions and
reduces generic extra source-local names from 280 to 270 while preserving zero
missing SYM names and zero raw type findings.

`DrawC_DividePrim` now follows the retail SYM identities, types, and block
lifetimes. The function-local `prim`, the early `bfct` block, the clipping
`clipW`/`clipH` block, and the three packet-population blocks
(`xy0`/`xy1`/`xy2`, `color`/`code`, and
`uv0`/`uv1`/`uv2`/`clut`/`tpage`) correspond directly to the SYM records and
block addresses. Ten Ghidra-only declarations (`iVar6`, `puVar10`, `puVar5`,
`puVar7`, `sVar1`, `sVar2`, `uVar3`, `uVar4`, `uVar8`, and `uVar9`) are gone.
The OT-depth update is expressed naturally through `sd->otz`, and the packet
link uses the TU's documented fixed-register `DRAWC_OTLINK_FT3` macro with the
actual SYM `prim` output rather than an inline duplicate and synthetic pointer.

The PsyQ 4.3 manuals at `C:\Temp\PSYQ\psyq-430-doc` and canonical
`LIBGPU.H` corroborate the `POLY_FT3` packet and `addPrim` ordering-table source
semantics; the retail oracle remains the byte authority for EA's fixed-register
expansion. Detailed verification preserves `DrawC_DividePrim` PASS 153/153,
the whole `drawc.cpp` gate remains 20/20 PASS, production PsyQ proof reports
REAL=0 and RELOP=0, and the vtable indexing audit remains clean.

### P40 — Race-statistics spill/local reconciliation (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_racestats_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_racestats_reconcile_20260824.md).
It advances the result from 386/395 to 387/395 declaration-clean functions,
reduces generic extra source-local names from 270 to 256, and preserves zero
missing SYM names and zero raw type findings.

`RaceStatistics` no longer declares five decompiler spill names as source
locals. The measured removal ladder was deliberately non-monotonic: deleting
`halfH` held 70 differences, then deleting `posy`, `posyL`, and `barH8` walked
70 -> 76 -> 78 -> 81 (the last at 474/475 instructions); deleting `barH` then
collapsed the result to 54 differences at the exact retail count of 475/475.
The 176-byte frame remains unchanged. Consequently the old inference that its
unnamed stack gaps required these five C declarations is refuted: they are
compiler reload spills around the six actual SYM AUTO objects.

The nine remaining non-SYM names (`colX`, `sizeH16`, `titleX`, `titleY`, `one`,
`pitch`, `nh`, `colInset`, and `rowInset`) now carry explicit current-basin
code-generation receipts in the source and remain queued for eventual source
elimination. This is an improved source-restoration checkpoint, not a claim of
final source identity. Detailed verification reports 54 differences at
475/475; the whole `overlays.cpp` gate remains 4/5 PASS with no regression to
its four exact neighbors. Production PsyQ proof reports REAL=42, RELOP=3, and
87 relocation-site differences for the remaining residual. The vtable indexing
audit remains clean.

### P41 — Skidmark-controller SYM identity and scope reconstruction (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_skidmark_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_skidmark_reconcile_20260824.md).
It advances the result from 387/395 to 388/395 declaration-clean functions,
reduces generic extra source-local names from 256 to 240, and preserves zero
missing SYM names and zero raw type findings.

`Draw_kCtrlSkidmark` now uses twelve more retail source identities rather than
parallel decompiler aliases. The active names are `prim`, `ccount`, `i`,
`count`, `type`, and `save_pre_otz`; the synthetic `primPtr`, `ccount_local`,
`depth_skid`, `ti2`, `color_pack`, and `vt_y` declarations are gone. A natural
short-circuit break removes `bVar2`, `skidChunk_p`, and `vert_count`, while
subtrahend-first arithmetic removes `tx`, `ty`, and `tz`. The SYM/SLD lexical
blocks are also restored for `sm`, `td`/`ts`/`count`/`i`, `prim`,
`type`/`pmx`/`save_pre_otz`, and `depth_index`. Every one of these changes is
byte-neutral at the authoritative gate.

Four non-SYM code-generation carriers remain explicitly queued with current
receipts: `skidIdx` (natural pointer indexing is FAIL 227 at 354/353), `otz94`
(repeated literals are FAIL 36 at 353/353), `grey` (direct literals are FAIL 68
at 353/353), and `neg1` (a direct sentinel test is FAIL 24 at 353/353). The
complete PsyQ 4.3 headers/documentation also disprove the canonical Sony packet
macros for this exact site: `setPolyGT4` plus `setSemiTrans` measured 302
differences at 375/353, and `setcode` plus `setlen` measured 303 at 376/353.
The retail byte-store expansion is therefore kept as an EA-wrapper lead.

Detailed verification remains 20 differences at the exact 353/353 count, and
the whole `draww.cpp` gate remains 31/35 PASS with residuals 8/9/20/66.
Production PsyQ proof reports REAL=33 and RELOP=0. Correcting `prim` from the
synthetic `void *` to the SYM `POLY_GT4 *` also lets the instrumented gcc-2.8.1
compiler finish this function; its output is d308 from production here, so that
trace is retained only as a diagnostic and not accepted as an allocation
receipt. The vtable indexing audit remains clean.

### P42 — Canonical PsyQ interrupt callback names and types (`2026-08-24`)

The two private libetc interrupt members now use canonical PsyQ source
identities while retaining every NFS4 retail linkage label.  In
`INTR_VB.c`, the synthetic C identifiers `startIntrVSync_helper_1`,
`startIntrVSync_helper_2`, and `startIntrVSync_helper_3` are replaced by
`trapIntrVSync`, `setIntrVSync`, and `VSync_memclr`; explicit asm-name aliases
preserve the existing oracle/config symbols.  The unused reconstructed
`priority` parameter on `startIntrVSync` is removed.  Both the VSync and DMA
callback tables, setters, and temporaries now use a real `Callback` function
pointer type instead of integer carriers.

The PsyQ 4.3 archive index proves `INTR_VB.obj` as the 288-byte
`startIntrVSync` member and `INTR_DMA.obj` as the 672-byte `startIntrDMA`
member.  Matched PsyQ source from SOTN and corroborating Xenogears/Rage Racer
implementations supply the private routine spellings; `Libref.pdf` page 375
(manual page 7-129) independently fixes the public `VSyncCallback` API boundary
and prevents that public name from being reused for the private setter.

Detailed verification preserves all seven existing exact bodies:
`startIntrVSync` 22/22, `trapIntrVSync` 27/27, `setIntrVSync` 11/11,
`VSync_memclr` 9/9, `startIntrDMA` 19/19, `trapIntrDMA` 96/96, and
`DMA_memclr` 9/9.  `setIntrDMA` retains exactly its pre-existing 36-diff
residual at 41/43 instructions.  Whole-TU gates remain 4/4 PASS for
`INTR_VB.c` and 3/4 PASS for `INTR_DMA.c`; no PASS regressed.

### P43 — PsyQ 4.3 `INTR.obj` source identity and environment layout (`2026-08-24`)

The main libetc interrupt member now uses the stable PsyQ source identities
instead of its retail/debug labels.  `startIntr`, `trapIntr`, `setIntr`,
`stopIntr`, `restartIntr`, and `memclr` retain `_initIntr`, `_intrhand`,
`_set_intr_callback`, `StopCallback`, `RestartCallback`, and `_bzero_w` as
explicit emitted-name aliases.  This distinction is required because NFS4's
v1.75-derived member omits the public Stop/Restart compatibility thunks: the
retail `StopCallback` and `RestartCallback` labels name the real private
implementations.

The callback environment is restored as `intrEnv_t intrEnv`, with canonical
fields `interruptsInitialized`, `inInterrupt`, `handlers`,
`enabledInterruptsMask`, `savedMask`, `savedPcr`, `buf`, and `stack`.
Canonical PsyQ 4.3 `setjmp.h` proves `jmp_buf` is 12 words; the remaining
4096 bytes are `stack[1024]`, not reconstructed "filler" or an EvCB table.
Consequently `intrEnv.buf[1] = (long)&intrEnv.stack[1004]` produces the exact
retail `+0x1018` saved-SP address naturally.  The callback table and globals
are likewise restored as `Callbacks`, `callbacks`, `pCallbacks`, `i_stat`,
`g_InterruptMask`, `d_pcr`, and `trapMissedCount`, with storage-label aliases
for the NFS4 data image.

Function-pointer carriers now use `Callback` and `IntrSetter`, including the
public `InterruptCallback`, `DMACallback`, `VSyncCallback`, and
`VSyncCallbacks` boundaries.  The documentation hierarchy is recorded rather
than flattened: `Libref.pdf` pages 859/895/897/904 describe public semantics,
canonical `libetc.h` preserves several legacy `int` prototypes, and matched
PsyQ sources expose the internal pointer-returning implementations.  Where
those sources disagree, the retail body cannot uniquely prove a C return type;
the chosen spelling follows the matched member structure and the ambiguity
remains explicit here.

`tools\objtruth.py` and the existing W67 receipts prove the retained NFS4
member bodies byte-identical to the PsyQ 4.3 `INTR.obj` v1.75 member after
relocation masking.  After all source-name, type, and layout corrections,
`tools\tugate.py` remains **13/13 PASS** and `tools\slotcheck.py` reports
`bad = 0`; no matched function regressed.

### P44 — Horizon/HUD SYM local restoration and full PsyQ compiler references (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_hrz_hud_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_hrz_hud_reconcile_20260824.md).
It advances the result from 389/395 to 391/395 declaration-clean functions,
reduces generic extra source-local names from 220 to 177, and preserves zero
missing SYM names and zero type findings.

`Hud_Perp_OverlayOff` had no AUTO/REGPARM records at all.  Its 22 unused locals
were broad decompiler-context residue and are removed; detailed verification
remains exact at 6/6 instructions and the whole `hud.cpp` gate remains 61/62
PASS with only the pre-existing 11-diff `Hud_RenderTacView` residual.

`Hrz_BuildHorizon` now uses the actual nested SYM `i` for the max-search and
both 17-entry correction loops.  The dead `iVar6` and one-use `shape_short`
are removed, as are the duplicate `shape_overlap`/`shape_w_idx` counters.
The SYM locals `Draw_tPixMap *pmx` and `POLY_GT4 *prim` now carry the live
pixmap and packet pointers instead of synthetic `puVar14` and byte-pointer
`p`; the one-use `puVar1` address temporary is also gone.  All eight changes
are byte-neutral, preserving the authoritative 12-diff, count-exact 473/473
baseline.

All thirteen remaining non-SYM identities in `Hrz_BuildHorizon` now have
explicit oracle receipts.  Two decisive natural-source probes were retained
as falsification evidence: replacing `shape_visible`/`shape_idx` with direct
`hsd->array[i]` expressions regresses 12 @473 to 24 @475, while deriving
`iVar15`/`iVar18` directly from `i` regresses to 156 @469 and incorrectly
shrinks the retail 128-byte frame to 120 bytes.  These names remain measured
compiler-shaping carriers, not claimed retail debug identities.

The documentation index now routes compiler questions through the complete
PsyQ 4.3 corpus at `C:\Temp\PSYQ\psyq-430-doc`.  The April 1996 optimization
deck supplies direct SDK-era evidence for optimization-level behavior, ABI
register roles, delay-slot filling, `gp` short data, and GCC-selected register
allocation; `sdevtc.pdf` confirms the C/C++ pipeline and explicitly delegates
allocator internals to the GNU compiler documentation.  Thus these manuals
strengthen semantic/source interpretation while measured gcc-2.8.1 traces and
the retail oracle remain authoritative for exact allocation.

Whole-TU regression gates are 20/22 PASS for `hrzsku.cpp` (unchanged residuals
12 and 146) and 61/62 PASS for `hud.cpp`; both compiled objects pass delay-slot
safety (`bad = 0`).  Call-target audit reports zero proven wrong targets,
undefined-call audit reports `UNDEF=0`, TU-order audit reports 523 objects and
zero inversions, and the vtable indexing audit passes all 926 files.

### P45 — `DrawC_PrimClip` exact local-name/type reconciliation (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_primclip_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_primclip_reconcile_20260824.md).
It advances the result from 391/395 to 392/395 declaration-clean functions,
reduces generic extra source-local names from 177 to 161, and preserves zero
missing SYM names and zero type findings.

The first envmap transform now uses the debug identities `t1`, `t2`, `t3`,
`u`, and `v` instead of the parallel decompiler names `e1`, `e2`, `e3`,
`tvx`, and `absZ_envmap`.  Four non-SYM `otzSum` declarations are eliminated
by updating and testing `sd->otz` directly, and the non-SYM `noSub` temporary
is replaced by the source-level `envmap & 0x20` guard.  The subdivision
address carriers are restored from raw `int` values to `COORD16 *` and
`u_char *`, with unnecessary call-site casts removed.  Every correction is
byte-neutral.

The remaining nine audit-visible identities have explicit W72-W76 codegen
receipts in the function, and the same-spelled `u1`/`u2` pointer carriers are
now explicitly documented because nested SYM UV-byte locals would otherwise
hide them from a name-only audit.  They remain compiler-shaping carriers, not
claimed debug declarations.

Detailed verification remains exact at 1877/1877 instructions.  The complete
`drawc.cpp` gate is **20/20 PASS**, and its rebuilt object passes the illegal
branch-in-delay-slot check with `bad = 0`.

### P46 — `DrawC_Prim` scope cleanup and exposed typed-body queue (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_prim_scope_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_prim_scope_reconcile_20260824.md).
Generic extra source-local names fall from 161 to 119 while missing SYM names
remain zero.  The declaration-clean count remains 392/395 because removing a
large false function-scope declaration slab correctly exposes two previously
masked typed-body findings rather than hiding them behind same-spelled names.

`DrawC_Prim` now uses the first transform block's actual `t1`/`t2`/`t3` and
integer `u`/`v` identities instead of `e1`/`e2`/`e3`, `tvx`, and `absZ`.
The second transform walker is the SYM `COORD16 *vt` plus `PCOORD16 *tV`, and
the six ePmx vertex-copy blocks now use signed `short *z` and signed
`t1`/`t2`/`t3`.  Five non-SYM `otzSum` declarations are eliminated through
direct `sd->otz` updates.  Twenty-seven declaration-only decompiler names and
the unused function-scope duplicate slab are removed; the surviving lexical
declarations now live in their owning SYM blocks.

Four non-SYM source-shaping identities remain explicitly receipted:
`envmapUV_dst`, `overlayRaw`, `ff`, and `hi`.  The SYM `short facetFlag` was
also tested directly: it regresses exact output to 30 differences at
1391/1389, so the promoted `int` carrier is retained under an explicit
`SYM-TYPE-OVERRIDE` receipt while a source-shape solution remains open.

Two reliable type corrections remain intentionally queued: the five per-case
`facet` declarations are still raw `int` rather than
`Transformer_zFacet *`, and the five `prim` declarations remain `u_int *`
rather than `POLY_FT3 *`.  Correcting either requires a coordinated conversion
of every byte/word offset expression so C pointer scaling does not alter
semantics; this checkpoint does not waive or conceal those findings.

Detailed verification remains exact at 1389/1389 instructions.  The complete
`drawc.cpp` gate remains **20/20 PASS**, the rebuilt object reports delay-slot
`bad = 0`, and the vtable indexing audit passes all 926 files.

### P47 — `DrawC_Prim` typed facet and primitive reconciliation (`2026-08-24`)

The refreshed strict game/PSX declaration audit is recorded in
[`game_psx_after_prim_typed_reconcile_20260824.md`](scratchpad/root_sym_audit/game_psx_after_prim_typed_reconcile_20260824.md).
It advances the result from 392/395 to 393/395 declaration-clean functions,
preserves zero missing SYM names, and clears the final two game/PSX type
findings.  Generic extra source-local names remain at 119; the only remaining
review entries are the explicitly receipted source-shaping carriers in
`DrawC_PrimStart` and `DrawW_DrawQuad`.

All five per-case `facet` declarations in `DrawC_Prim` now use the SYM type
`Transformer_zFacet *`.  Raw byte offsets are replaced by the canonical
`flag`, `textureIndex`, `vertexId0`/`vertexId1`/`vertexId2`, and
`uv0`/`uv1`/`uv2` fields.  Packed UV halfword transfers retain an explicit
`u_short` view of each two-byte `Transformer_zUV`, preserving the original
single-load/single-store source shape without pretending the facet itself is
an integer address.

The five `prim` declarations now use the SYM type `POLY_FT3 *`.  Existing
packed packet construction keeps explicit `u_int *` word views only where the
source deliberately writes complete packet words or halfwords; packet identity
and all macro boundaries are now typed as the PsyQ primitive rather than as a
generic integer buffer.

Both coordinated conversions are byte-neutral: detailed verification remains
exact at 1389/1389 instructions, the complete `drawc.cpp` gate is **20/20
PASS**, and its rebuilt object reports delay-slot `bad = 0`.  Repository-wide
guards also remain clean: vtable indexing passes all 926 files, call-target
audit reports zero proven wrong targets, undefined-call audit reports
`UNDEF=0`, and TU-order audit reports 523 objects with zero inversions.

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
