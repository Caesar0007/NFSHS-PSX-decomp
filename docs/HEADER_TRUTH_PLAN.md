# Header-truth plan (NFS4 PSX)

Started 2026-11-12. Owner ruling (2026-11-12): keep commits 7838ab858..2ac4bd057, remove the
fabrications selectively, follow this plan, keep this document updated as work lands.

## Why

The 2026-11-08/09 type-record rounds lowered the SLINK census (1650 -> 436) partly by *fitting*:
source was invented so the compiler would emit one more record. The census cannot tell an invented
inline from the real one, so the number stopped measuring closeness to the retail headers.

Vtables are NOT hand-made: every polymorphic class uses real `virtual` members and cc1plus emits
the tables (0 live `_vf` lines; about 20 file-header comments still say "manual _vf vtable").
The real vtable risk is duplicated class definitions that must agree by hand.

## Baseline (HEAD 2ac4bd057)

| Counter | Value | Direction |
|---|---|---|
| Code bytes | 299819/299819 | must hold |
| Fake `*Inferred*Op*` members/functions | 17 sites | -> 0 |
| `INFERRED` markers (game/frontend/shared) | 142 | down; each survivor needs evidence |
| Header conditionals keyed on the including object | 176 | down |
| Classes defined in more than one header | 94 | down, polymorphic ones first |
| `link_stripped.json` rows (non-SDK) | 158 (85 added since 1e8cf3499) | only evidence-backed rows stay |
| SLINK census | 436 | reported, no longer a target; may rise |

## Evidence rule (replaces "the count needs one more")

An inline body, member or out-of-line copy stays only with at least one of:
1. a call site in byte-matched code (zero-length `this` pair or line record in retail SYM);
2. a retail SYM record naming it;
3. the named twin in NFS4-PC / NFS2-PC / NFS3 sources or debug info;
4. compiler-mandated emission from an evidenced body (out-of-line copy of an evidenced in-class
   inline in the class's key object, removed by the retail link).

A TPDEF count or run pattern alone is not evidence. Without evidence the mismatch stays and is
listed under "Open mismatches" below.

## Phases

### Phase 1 - remove pure fabrications (the 17 `*Inferred*Op*` sites)
aidatarecord.cpp, aihigh.h, aih_basiccop.cpp, aih_btccop_types.h (x2), aih_hierarchy_types.h,
audioclc_types.h, audiotrk_types.h, camera_types.h, copspeak.cpp, speech_speaker_virtuals.inc (x4),
hud.cpp, psxfront.cpp (x2). Their link_stripped rows go with them.

### Phase 2 - Speech pilot: one SPEECH.H (DONE except the speech.cpp branch)
Remaining branch in `speech_speaker_virtuals.inc`: speech.cpp declares the 15 defaults and defines them in the .cpp under SPEECH.H line anchors (line-record mechanism, not a census fit). Finding: a class that only one retail object records was defined in that object's .CPP, not in the shared header - check this first for every per-object class variant.
`speech_speaker_virtuals.inc` loses its per-object branches (one member list for every includer);
speech_class.h inferred accessors audited against the evidence rule.

### Phase 3 - audit the remaining INFERRED bodies (DONE 2026-11-12, 3a-3g)
Method that worked: count call sites first; a member matched code calls stays, an uncalled one goes. Kept as evidenced: ctors in ctor-sized source-line gaps, in-class ctors called from femenudefs, unused local declarations inside one function's record range. The 15 remaining markers are class-copy duplicates in aih_btccop_types.h / aih_*_externs.h / aistate.h (phase 4) and naming notes.
Per file: keep (cite evidence in the comment) or remove. Macro-packed bodies in
`shared/tpdef_keys.h` move back into their class headers as ordinary members or go away.

### Phase 4 - one definition per class (IN PROGRESS; 4a done: aih_btccop on the shared AI headers)
Method (4a): replace the private copy by the shared include, compile, and treat every error as a finding - the copy usually holds real members the shared header lacks (move them in), a duplicate under another name (pick one), or inline bodies switched on per object (make them unconditional). Then diff the generated .s against the committed build before gating. Key-object strip marking is the one legitimate per-object switch.
Polymorphic families first (tMenuItem family, tMenu, tListIterator, AIHigh_Base), then
tFEApplication, AnimScript, Object*Anim, AIDataRecord_*. Per-object copies replaced by the single
reconstructed retail header; differences between objects explained by include graph only.

### Phase 5 - gate and comments
Add the counters above to the gate (must not rise). Fix the stale "manual _vf" file headers.

## Gate per change
bytes 299819/299819, 0 masked, gdebug 0 FAILED, every including TU PASS, SLINK lane builds.
Census/inversions are recorded, regressions caused by removing a fabrication are accepted and
re-baselined (head.json / slink_head.json).

## Progress log

| Date | Commit | Change | Fake ops | INFERRED | Per-object conds | Dup classes | Stripped rows | Census |
|---|---|---|---|---|---|---|---|---|
| 2026-11-12 | 2ac4bd057 | baseline | 17 | 142 | 176 | 94 | 158 | 436 |
| 2026-11-12 | 8f7a392df | all 17 fake `*Inferred*Op*` sites + their 4 stripped rows removed; bytes 299819/299819, SLINK symtree no regressions | 0 | 125 | 175 | 94 | 154 | 487 |
| 2026-11-12 | f3d2cf30c | Speech: one class definition for every includer. `MobileSpeaker`/`DispatchSpeaker` moved to speech-private `speech_speakers.h` (retail defined them in SPEECH.CPP: no other object records them); aih_cop Speaker variant, copspeak out-of-class defaults variant, `NFS4_SPEECH_AI_VIEW` and unused `ResetStatus()` removed | 0 | 124 | 167 | 94 | 154 | 487 |
| 2026-11-12 | b88950b72 | Phase 3a: fedialog.h inferred accessors + body macros + tpdef_keys opt-out block removed; both SetChoices overloads for every includer; invented filler functions removed from 8 .cpp files | 0 | 115 | 167 | 94 | 154 | 513 |
| 2026-11-12 | 9c6db3461 | Phase 3b: AnimScript_FreeInst x7, InheritMultiAnimState x10 (+NFS4_DRAWW_MULTI_COORD_PARAM), AIDelayCar GetPosition/GetLaneIndex, SimpleMem::FreeMemSize, AITrigger_NoTrigger/SwapTriggerPair removed; TriggerType unconditional. Gate now also fails on build SKIP (compile error = stale object) | 0 | 93 | 165 | 94 | 154 | 610 |
| 2026-11-12 | c99f4e063 | Phase 3c: 10 unused game-side inferred members removed (call-site check first; members matched code calls stay); IgnoreCops stripped row removed | 0 | 84 | 165 | 94 | 153 | 637 |
| 2026-11-12 | 0def7381d | Phase 3d: 21 unused frontend members removed (tFEApplication/tScreen/tMenuItem/tMenu accessors), macro bodies out of tpdef_keys.h, fe_menu_game_surface.h copies, 12 stripped rows. Census jump = tMenu/tMenuItem x16 in ~45 objects: retail really had ~9 more inline bodies in FEMENU.H, names unknown | 0 | 70 | 162 | 94 | 141 | 1137 |
| 2026-11-12 | 54ce593c1 | Phase 3e: tCarManager CarCount/CarIndex x6, tTournamentManager x5 (incl. per-object body variants), tListIteratorCar IsFilter/CarListFilter, EnableValue, 2 stripped rows, NFS4_FE_CORE_CARS_INDEX_INT removed. CORRECTION to the 3a row above: its fedialog.h / tpdef_keys.h part did NOT land in b88950b72 (edit script stopped early); redone as 3f | 0 | 56 | 154 | 94 | 139 | 1507 |
| 2026-11-12 | 256f4afa5 | Phase 3f: fedialog.h inferred accessors (GetOffsetX/Y, GetMaxW, Variant, NumItems, HelpControllers, LeftText, GetString, IsCentered, FadeText, Set/TimeoutTicks, IsRunning) + body macros + tpdef_keys opt-out block removed; per-object SetChoices split removed | 0 | 36 | 145 | 94 | 139 | 1780 |
| 2026-11-12 | 821eed9ed | Phase 3g: CarBank::Make removed; gap-evidenced ctors (femenu iterators, aistate RovingTraffic/Donuts) and called in-class menu-item ctors relabelled; draww unused declarations kept as evidenced. PHASE 3 DONE | 0 | 15 | 145 | 94 | 139 | 1790 |
| 2026-11-12 | 2ec80548d | Phase 4a: aih_btccop_types.h private copy of 9 AI classes replaced by the shared aih_hierarchy_types.h/aihigh.h. Shared headers completed from it: AIHigh_BTC_Wingman (AIHIGH.H:548), static lastInputRequestTick_, strip marking for the BTC cop accessors; AIState_Chase inline bodies unconditional; Crime()/GetCrime() duplicate resolved; aihigh_types.h Wingman copy removed. Census improved with no invented source | 0 | 8 | 145 | 85 | 139 | 1758 |
| 2026-11-12 | b3551b8f3 | Phase 4b: private tMenuItemLeftRightChoice / tMenuItemGoToMenuButton copies in fecredits_types.h, fetools_types.h, screentrophyinfo_types.h replaced by screendisplay_menuitems.h; census unchanged (the copies bought nothing) | 0 | 8 | 145 | 85 | 139 | 1758 |
| 2026-11-12 | 759d6b341 | Phase 4c: screentrackinfo_types.h copies of tMenuItemLeftRightChoice / tMenuItemLeftRightSlider / tMenuItemGoToMenuButton replaced by screendisplay_menuitems.h; census unchanged | 0 | 8 | 145 | 85 | 139 | 1758 |
| 2026-11-12 | 4c67ce772 | Phase 4d: fOnButtonPress was (tMenuCommand &) in FEMenu and (void *) elsewhere - now the real type everywhere; member declarations of the shared menu-item classes unconditional; femenu_types.h copies removed | 0 | 8 | 145 | 84 | 139 | 1758 |
| 2026-11-12 | c4aeadd5c | Phase 4e: femenuextended_types.h copies removed; tMenuItemLeftRightChoice, tMenuItemGoToMenuButton, tMenuItemLeftRightSlider = ONE definition each (were 7/7/3) | 0 | 8 | 145 | 82 | 139 | 1758 |
| 2026-11-12 | 34ea40d82 | Phase 4f: seven identical data-only AnimScript copies -> shared/AnimScript.h | 0 | 8 | 145 | 82 | 139 | 1758 |

## Open mismatches (left unexplained on purpose)

Phase 1 removals. Each is a retail type record our source no longer produces; restore only under the evidence rule.

| Object | Retail record left unmatched | What is known |
|---|---|---|
| hud.obj | `Car_tObj` (+ field walk) before Hud_BuildCdPlayer | HUD.CPP lines 795-800 owned by no retail function: a link-stripped function existed, name and body unknown |
| copspeak.obj | `Car_tObj` between CopSpeak_StartUp and CopSpeak_Request | COPSPEAK.CPP 975-1027 gap: link-stripped function, unknown |
| psxfront.obj | `Car_tObj shapetbl` before DoTitleScreen; `shapetbl` before FontUpsideDownBlit | PSXFRONT.CPP 98-141 and 1260-1338 gaps: two link-stripped functions, unknown |
| aidatarecord.obj | `Car_tObj` (+walk), `AIDataRecord_t` between StartUp2 and CleanUp1 | count only |
| aih_basiccop.obj | one more `Car_tObj` in the ctor group | count only |
| aih_btccop.obj | `Car_tObj` in the BTC_Perp run; `coorddef` after AIDataRecord_AccTable_t | count only |
| AI objects | one more `AIHigh_BTC_Perp` (this-only body); aihigh.obj one more `AIHigh_Base` | count only |
| aih_cop.obj | ours records 5 more `Car_tObj` than retail (aih_basicperp/aih_btcperp/aih_play: 1 more) | single SPEECH.H gives every AI object the same in-class Speaker defaults; retail difference unexplained (count only) |
| audioclc/audiotrk/camera.obj | one `Trk_AnimateInst` each | count only |

The four "gap" rows are the best candidates for real recovery: check NFS4-PC / NFS3 for a function at that position.
| every frontend object (~45) | `tMenu` x16, `tMenuItem` x16 | FEMENU.H had about nine more in-class inline bodies than matched code calls; names unknown. Biggest single census item (+500) |
| every frontend object | `tFEApplication` x9 (ours 3), `tCarManager` run, `tTournamentManager` 16-record run, dialog class runs | more in-class inline bodies in the retail headers; names unknown |
| FEScreen.obj | `tScreen` 25 (ours 19) | six more bodies, names unknown |
| ~10 game objects | `ObjectFinishedMultiAnim` x4 + `Trk_SimObject`/`Trk_CollideBoomInst`/`Trk_ObjectDef` params; `AnimScript AnimScript Trk_AnimateInst` | one static/inline body in OBJECT.H with that signature, and an AnimScript dtor-like body; consistent across objects, names unknown |
| mathnfs/quatern/udff/texture/newton/draw/fe3dmenu.obj | extra `matrixtdef` / `tQuat` / `Udff_tInfo` / `Draw_tPixMap` / `coorddef` requests between functions | udff (124-202) and texture (708-725) sit in source-line gaps: link-stripped functions; others count only |
| group.obj | `SerializedGroup` x12 (ours x11) + unit in SLD gap 134-165 | link-stripped members in the gap, names unknown |
