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
Member ORDER matters too (4q): reordering a class's member declarations changed code generation in another file that inlines its constructors. Keep the member order that already matches for the non-owner includers; add owner-only pieces under one owner switch. Always diff the generated .s of the heaviest includer (not only the owner) before gating; a `git stash` build in the gate tree gives the baseline.
Polymorphic families first (tMenuItem family, tMenu, tListIterator, AIHigh_Base), then
tFEApplication, AnimScript, Object*Anim, AIDataRecord_*. Per-object copies replaced by the single
reconstructed retail header; differences between objects explained by include graph only.

### Phase 4-B - fake call forms (after the duplicates; found 2026-11-13)
These exist because a calling file did not see the real class. With single definitions they can become ordinary C++:
- two opaque views in front_types.h (`tGlobalMenuDefs` char[15128], one char[8]);
- `*CodegenView` stand-in types in 16 frontend headers (e.g. `#define tScreenMemcard FEMemcard_ScreenMemcardCodegenView`);
- about ten fake constructor functions in front_externs.h (`tScreenMemcard *tScreenMemcard_ctor(...)`) used instead of `new`;
- nine asm-label aliases that call a member function as a free function with an explicit object (`GetTrophyName(tTournamentManager *, ...) asm("GetTrophyName__18tTournamentManager...")`, `DisplayHelp`, `GetCarFromSimID`, `FECheat_*` with int for an enum);
- key-object exceptions (`NFS4_KEY_OBJECT_*`, owner strip switches): the fuller model is declare + LINK_STRIPPED + out-of-class body + a link_stripped.json row for the owner.

### Phase 4-C - macro-faked enums (found 2026-11-13)
17 frontend headers replace enums by macros (`#define tMenuTextState int`, `#define tMenuTextType int`, `#define textState_Hilighted 2`, also `tPlayer`, `tInputKeyType`, `tCheatCode`, earlier `tTrophySize`). With `int` the C++ mangled name of every function taking the enum changes, which is why asm-label aliases (FETextRender_WordWrapFade, FECheat_*) and int-typed virtual signatures (shared/fe_menu_game_surface.h) exist. Fix = include the one real enum definition (fetextrender_types.h, fe_player_types.h, fe_input_enums.h, fecheats_cheatcode.h) and drop the macros; expect ENTAG census changes in many objects - retail objects that call these functions without recording the enum are an open question.

### Phase 5 - gate and comments (5a DONE: counters tool + stale comments)
Run `python tools/header_truth_counters.py --check` in every gate; `--save` only after a counter went down. Baseline 2026-11-13: fake ops 0, INFERRED 7, opaque views 0, codegen views 5, classes defined more than once 16 (about 10 real), per-object conditionals 143, stripped rows 139, asm-label aliases 43 (all files), macro-faked enum types 28.
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
| 2026-11-12 | d636d4fd3 | Phase 4g: AnimScript = ONE definition (was 13). The real inline dtor explains retail's AnimScript/AnimScript/Trk_AnimateInst run that the removed AnimScript_FreeInst fake imitated; census 1758->1751 with no invented source (draww.obj +1 Trk_AnimateInst) | 0 | 8 | 145 | 81 | 139 | 1751 |
| 2026-11-12 | c0216e80a | Phase 4h: OBJECT.H animation classes = ONE definition each (owner's full block moved to object_anim_classes.h; 10 reduced copies and NFS4_CHUNK_SIGN_CTOR removed). Census 1751->1737, no census regressions; record ORDER worse in audedit.obj and scene.obj (inversions 0->2 each, accepted) | 0 | 8 | 146 | 78 | 139 | 1737 |
| 2026-11-12 | 7f9fea8a1 | Phase 4i: AIDataRecord family = ONE definition each (owner block moved to aidatarecord_classes.h, 9 copies removed). Found: AIDataRecord_BestLine_t::Get lived only in ai_types.h (now shared); aiinit used asm-label ctor aliases with int params (removed, real enum constants at the call sites) | 0 | 8 | 147 | 74 | 139 | 1733 |
| 2026-11-12 | 270f88a75 | Phase 4j: tFEApplication = ONE definition (was 10, each with a different accessor set, one an opaque char[896] view). Three GetPlayer() return-type variants resolved to GetPlayer (u_char) / CurrentPlayer (tPlayer); int-argument call sites use kPlayerOne; tAppCommand enum in shared/tAppCommand.h replaces a front-only #define. fecheats.obj +1 tDialogMessageStringWithTimeout | 0 | 8 | 147 | 73 | 139 | 1691 |
| 2026-11-12 | 6a02a8be4 | Phase 4k: tCarManager = ONE definition (was 6). Removed: per-surface method switches in fe_core_cars.h, asm-label alias for GetClassList, plain/typedef form selector. tCarClassType copies all honour one guard. front.obj and screencarselect.obj +1 tCarManager (typedef form) | 0 | 8 | 144 | 72 | 139 | 1660 |
| 2026-11-12 | c1cb943c4 | Phase 4l: tTournamentManager = ONE definition (was 8 incl. two in screentrackinfo_types.h). tTournamentManager_inl.h has no per-object switches; #define tTrophySize int / ts_* macro fakes replaced by the real enum; screentrophyroom.obj +1 tTourneyInfo | 0 | 8 | 140 | 71 | 139 | 1660 |
| 2026-11-12 | 1df371134 | Phase 4m: AIPhysic_BrakeInfo = ONE definition (was 9 copies of the same class in different formatting) | 0 | 7 | 140 | 70 | 139 | 1660 |
| 2026-11-12 | 721f45f8f | Phase 4n/4o: Group (7 copies), AITrigger_TriggerManager (6) + triggerType (3), AIDelayCar (3), Chunk (4) = ONE definition each. Group::SetNumElements body now visible everywhere: +1 Group record in 7 objects (accepted, see open mismatches); aih_traf int-for-enum signature gone | 0 | 7 | 140 | 66 | 139 | 1662 |
| 2026-11-12 | 3481893dc | Phase 4p: extended menu family (tMenuItemGoToMenuNFS4Button .. tMenuOptions) extracted from screendisplay_types.h to femenuextended_classes.h, members unconditional (were switched by NFS4_FEMENUDEFS_SURFACE), FEApp asm-label alias gone; 3 data-only copies removed | 0 | 7 | 140 | 66 | 139 | 1658 |
| 2026-11-12 | 0b03017dc | Phase 4q: extended menu family = ONE definition each (owner copy + screentrackinfo copy removed). LAW: member declaration order of a class changes codegen in other files that inline its ctors (femenudefs) - the shared header keeps the passing non-owner order; owner-only strip pieces under one owner switch | 0 | 7 | 145 | 56 | 139 | 1654 |
| 2026-11-12 | 292f1ce64 | Phase 4r: options-menu family (17 classes) = ONE definition each; member switches (FEMENUOPTIONS_SURFACE / CONTROLLER_METHODS / ScreenPost exclusion) removed. +1 tOptionsMenu in feapp/screenaudio/screentrackinfo.obj, +2 records in screenpost.obj (inline tInsideBoxMenu ctor now visible there) | 0 | 7 | 144 | 39 | 139 | 1657 |
| 2026-11-12 | b1ee69124 | Phase 4s: list iterators Car/CarColor/Track/Tournament = ONE definition each (7 copies removed); SCREENCARSELECT asm-label aliases for Increment/Decrement gone; owner strip switch for SetFilter | 0 | 7 | 143 | 35 | 139 | 1652 |
| 2026-11-12 | c8051621f | Phase 4t: managers tTrackManager (4 copies), tMissionManager (2), tCreditManager (4, one an opaque char[56] view), tVideoWall (4) and enum tTrackClassType (2) = ONE definition each; TransitionDirection/GetTransitionDirection name duplicate resolved | 0 | 7 | 143 | 31 | 139 | 1651 |
| 2026-11-12 | 027ade1a3 | Phase 4u: tScreenControllerConfig, tScreenBeTheCopCongrats, tScreenTournamentCongrats, tScreenTournamentTrophy, tScreenPinkSlipsCarSelect, tScreenPinkSlipStandings, tScreenCarSelectDuel = ONE definition each (cls_<name>.h, included where each copy stood, so record order is unchanged). Found: Front's copy declared DrawOpponentVideoWall non-virtual while the owner declares it virtual | 0 | 7 | 143 | 24 | 139 | 1651 |
| 2026-11-12 | 707a74697 | Phase 4v: tScreenUserName (3 copies), tScreenMemcard (2), tScreenTournamentStandings (3), ...3item (3) = ONE definition each. Ctors declared unconditionally; SetCallingMenu / SetMessage / SetDrawMoney in-class for all but the key object (explicit NFS4_KEY_OBJECT_* marker in the owner .cpp: cc1plus would emit a standalone copy there) | 0 | 7 | 143 | 20 | 139 | 1647 |
| 2026-11-12 | d126d00a5 | Phase 4w: front_types.h opaque tGlobalMenuDefs char[15128] and Front_MissionManagerCodegenView (3 asm aliases) replaced by the real classes; SaveSurface / SNDSAMPLEFORMAT / Udff_tInfo = ONE definition each. cars.obj -1 Udff_tInfo (was typedef form), front.obj +1 tUserNameMenuItem | 0 | 7 | 143 | 16 | 139 | 1649 |
| 2026-11-12 | afeff0f7c | Phase 4-B.1: asm-label aliases for tTournamentManager::GetTrophyName (3 files), tCarManager::GetCarFromSimID, tFEApplication::DisplayHelp replaced by member calls. Found: 17 frontend headers fake enums with  etc. (changes mangled names; reason for the remaining aliases) - Phase 4-C | 0 | 7 | 143 | 16 | 139 | 1648 |
| 2026-11-12 | 07a427ee6 | Phase 4-B.2: X_GlobalMenuDefsCodegenView in 9 headers -> real tGlobalMenuDefs; dead t*_ctor/_dtor(...) decls removed. Census +18: the real class's field walk records tUserNameMenuItem / tTrackManager / tTrackInformation in 7 objects that retail lacks; screenaudio.obj order inversions 0->7 (accepted, open mismatch) | 0 | 7 | 143 | 16 | 139 | 1666 |
| 2026-11-12 | 7d8c13f8c | Phase 4-B.3: five more CodegenView stand-ins replaced by real classes (screencontroller/screenmemcard tFEApplication, fememcard tScreenMemcard, femenudefs tScreenMain incl. its SwapBackground asm alias, femenuoptions tScreenAudio). screencontroller.obj order inversions 0->10 (accepted) | 0 | 7 | 143 | 16 | 139 | 1662 |
| 2026-11-12 | 1b1860944 | Phase 5a: counters tool tools/header_truth_counters.py + docs/header_truth_counters.json (--check fails on any rise); stale manual-vtable header comments fixed in 23 files; dead define removed | 0 | 7 | 143 | 16 | 139 | 1662 |
| 2026-11-12 | d35f4d8fa | Phase 4-B.4: FEScreen_DFlip/DrawView and PSXFront_DFlip/DRender codegen views -> shared real types (one view left: FEMemcard_MemCardInfoCodegenView, no real definition in the tree yet) | 0 | 7 | 143 | 16 | 139 | 1662 |
| 2026-11-12 | bdbae86fe | Phase 4x: AIHigh_BTC_AIPerp = ONE definition; orphan shared/CarBank.h, LocationBank.h, CallSignBank.h (no includers) deleted | 0 | 7 | 143 | 15 | 139 | 1662 |
| 2026-11-12 | 298af5835 | Phase 4-C.1: tMenuTextType / tMenuTextState = ONE enum definition each (shared/);  + constant macros removed from 11 headers; macro-faked enum count 28 -> 7; census unchanged | 0 | 7 | 143 | 12 | 139 | 1662 |

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
| audedit.obj, scene.obj | type-record ORDER: 2 inversions each since 4h | the shared OBJECT.H class block sits at a different point of their include order than retail's; fix by include placement, not by a private copy |
| draww.obj | one more `Trk_AnimateInst` than retail since 4g | AnimScript inline dtor visible there; unexplained |
| ai, aih_basiccop, anim, bworld, bworldsm, chunk, track .obj | one more `Group` than retail since 4n | retail has Group's third inline body (SetNumElements) only in object.obj / draww.obj; where retail really defined it is unknown - not restored by a per-object switch |
| feapp, screenaudio, screencarselect, screenmain, screenmemcard, screenpinkslips, screenpost .obj | +1 each of `tUserNameMenuItem`, `tTrackManager`, `tTrackInformation` since 4-B.2; screenaudio.obj 7 order inversions | they now see the real tGlobalMenuDefs instead of a padded partial view; retail does not record those member types there - how retail's objects referenced menuDefs members without them is unknown |
