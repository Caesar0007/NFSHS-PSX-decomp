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

## State after 2026-11-14 (read this first)

Gate on HEAD: bytes 299819/299819, 0 masked, 0 stripped-list violations, 0 build SKIP, 0 debug failures, linked SYM
tree 2537 clean / 33 dirty (unchanged since the start), SLINK census 1331.

Census history: 436 with the fabrications -> 1662 after they were removed (phases 1-4) -> 1331 after the classes
were given ONE definition for every includer (phase 8). The single honest definition is measurably closer to retail
than the per-object member subsets were: tMenuItem alone moved the census by -306.

| Counter (`python tools/header_truth_counters.py`) | Start | Now |
|---|---|---|
| fake `*Inferred*Op*` members | 17 | 0 |
| `INFERRED` markers | 142 | 7 (naming notes, evidenced) |
| opaque `_storage` views | 3 | 0 |
| `*CodegenView` stand-in types | 20 | 1 (fMemCardInfo_def: no real definition in the tree) |
| macro-faked enum types (`#define tX int`) | 28 | 0 |
| classes defined more than once | 94 | 6 counted, 0 real |
| conditionals guarding class members | (116 by name) | 2 (`CAudioList::Elems`, `tUserNameMenuItem::SetUpP`) |
| per-object header conditionals | 176 | 145 |
| header conditionals, all kinds | 628 | 592 |
| stripped rows, non-SDK | 158 | 154 (139 before phase 8; +15 = key-object copies of real inline members) |
| view declarations of globals | 75 | 55 (all `GameSetup_gData`, kept - ruling 4) |
| asm-label aliases, all files | ~55 | 39 |

Done: phases 1, 2, 3, 4 (a-x), 4-B.1-4, 4-C.1-3, 5a, 6a-c, 7a-b, 8a-g.

Rules that came out of phase 8 (apply them to every class from now on):
1. One class body for every includer. Members are never selected per object.
2. An inline member whose class has a key object (the object that defines its first non-inline virtual) is
   declared with a `<CLASS>_KEY_STRIP` attribute that is `LINK_STRIPPED` only in that key object, and defined right
   after the class. The key object's standalone copy gets a `linkers/link_stripped.json` row. This replaces every
   "hide the member from the owner" block.
3. A body that retail records in exactly one object is declared in the class and defined in that object's own
   header (`tUserNameMenuItem::SetUserNameData` in femenudefs_externs.h).
4. Pure virtuals are pure everywhere; a derived copy that lacked the override is corrected.

Open work, in order: `SetUpP` (rule 3); phase 9 (record order - the remaining `*_SURFACE`, `OMIT`, `HOOK`, `LATE`
conditionals in the private `*_types.h` files are all "which types does this object see, and in which sequence",
i.e. phase 9 material, pilot on the AI objects); phase 10 (bodies); phase 11 (unknown bodies). Investigations
left open: the 16 scalars declared as unsized arrays in psxfront/front/screencarselect (those objects are already
`-G0`, so a per-object `-G` is not the explanation); EA-library prototypes.

## Phase 9 status (2026-11-14) - how the order hooks are being removed

Method (proven on the AI objects in 9a, gate-identical every time):
1. Cut the shared aggregator header at each hook point into plain, include-guarded parts
   (`aih_hier_triggers.h` / `_states.h` / `_classes.h`; `color_p0_draw.h` ... `color_p9_tail.h`).
2. The old header becomes the default list of its parts.
3. An object whose retail record order has its own types between two parts defines the aggregator's include guard
   and lists the parts itself, with its own header at that point (`tools/psyq_pipe/colorlist.py` does this for
   `color_types.h`). No `#include MACRO`, no "IN_HOOK" state in the aggregator.
4. When a hook has no user left its lines are deleted from the default list.
Every object's token stream is unchanged by construction, so bytes, census and inversions cannot move; the gate
confirms it each time.

Done (9a-9i): the AI hierarchy header, `color_types.h` (8 of 9 hooks) and `draw_leaf_types.h` (all 4 hooks) are
plain part lists. Computed includes tree-wide: 53 at the start of phase 9, 42 now; hook definitions
(`#define NFS4_*HOOK* "file"`): 109.

Fast check used for every step: `tools/psyq_pipe/ichk.sh <tu...>` recompiles on the debug lane and compares the
preprocessed source with a snapshot of a gate-passed state. Identical token stream = identical bytes, records and
record order; about 5 s per object. The full gate still runs once per batch before landing.

Pitfalls met:
- `NFS4_CORE_CCOORD16` is read by the core header as well as by the draw leaf: define it before `draw_leaf_core.h`.
- A hook macro was also used as a "which object am I" test (`#ifndef NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX` in
  psxcontroller_types.h). Removing a hook definition can flip such a test; look for `#ifdef`/`#ifndef` of the hook
  name outside the aggregator first.
- A hook defined inside `#ifndef <OMIT switch>` belongs to the standalone object only: the listed include must keep
  that condition (mpause/pausemenu).
- Objects that reach the aggregator through a chain set core switches on the way (`NFS4_CORE_POLY_GT4`,
  `NFS4_CORE_SUBDIV_TRKART`); a list placed earlier must set them first (cars, object).

Left, in this order:
| Item | Users | Note |
|---|---|---|
| pad hooks `NFS4_PADS_HOOK_AFTER` / `_BEFORE` | 17 headers (anim, chunk, clock, gmesetup, input, minfront, nfs3, physics, replay, simqueue, sim, track, draw, loading, overlays, psxcontroller) | the pad header is reached from draw_leaf_a_pads.h and from game_common_min_types.h; read both before cutting |
| core hooks in nfs4_types.h (`NFS4_CORE_HOOK_AFTER_CD`, `_BEFORE_CD`, `_AFTER_DRMODE`, `_AFTER_PADS`) | device, drawdbg, ... | root aggregator; same method |
| `NFS4_COLOR_HOOK_AFTER_CAR` | femenuoptions.h, screencontroller_keys.h, psxfront.h | last color_types.h hook; goes with the frontend work |
| chunk_types.h (3), audiocmn_types.h (3), gmesetup_types.h (1), aihigh.h (1), Transformer_z.h (1), fe_menu_game_surface.h (2) | few users each | |
| frontend: screendisplay_types.h (11), fe_core_cars.h (4), screencarselect (3), screendisplay_carblock_iters.h (2), fe_core_types.h, fe_track_types.h, screencongrats_tt.h, femenuoptions.h | the screen objects | largest remaining block |
| self-include second passes (`#include "<own>_types.h"` under an IN marker) | audedit, collide, scene, audiotrk, draww, bworld, object, night, render, textureprocess, drawc, hud, cars, nfs3, copspeak, audiocmn, audioclc, psxcontroller, screentrophyroom | turn each branch into a small plain header (`<obj>_after_bo.h`) |
| multi-user branches created in 9d-9i (night/render, draww/bworld, sim/object, gmesetup chain, audioclc chain) | 5 shared types headers | disappear when each object gets its own list instead of including another object's types header |

Counter note: the explicit branches raised `header_conditionals_all` from 581 to 597 and `per_object_conditionals`
from 145 to 152 during 9d-9i. They replace hidden computed includes one for one and fall away with the last row.

## Deep analysis 2026-11-13 and revised roadmap

Scope measured: recon/game, recon/frontend, recon/shared = 831 headers (35.7k lines) and 181 sources (146.7k lines).
Of the headers, 159 are per-object `*_types.h`, 146 per-object `*_externs.h`, 231 single-type `shared/*.h`.

### What the tree still does wrong (by layer)

**Layer 1 - class definitions (mostly fixed).** One definition per class now holds except the game-side menu
header (5 classes) and `tListIteratorIndexed`. `tMenuItem` / `tMenu` still switch members per object.

**Layer 2 - declarations are per object, and they disagree (NOT started).**
Every object has its own `*_externs.h` that re-declares the functions and globals it uses. Measured:
- 947 functions declared in externs; **96 are declared with more than one signature**
  (`AIWorld_ApxSplineDistance`: `(Car_tObj*,Car_tObj*)`, `(Car_tObj*,int)`, `(int,Car_tObj*)`, `(int,int)`;
  `CalcFadeVal` with 2, 3 and 4 arguments; `DrawSync`, `SetSp`, `GetTPage`, `sprintf`, `memset` in 3-5 forms);
- **129 prototypes are `(...)` only** (no parameter types at all);
- 491 globals declared `extern`; **36 with more than one declared type** - mostly "view" arrays:
  `GameSetup_gData` in 7 forms (`[650]`, `[50][13]`, `[325][2]`, `[]`, real `GameSetup_tData`), `simGlobal` as
  `int[6]` / `int[2]`, `Camera_gInfo`, `Cars_gList`, `highLevelAIObjs` as `AIHigh_Base*[]` vs `AIHigh_Traffic*[]`.

A wrong prototype compiles silently in C linkage and gives a wrong mangled name in C++ (the reason asm-label
aliases existed). Retail had one prototype per function in the defining module's header.

**Layer 3 - header conditionals (partly fixed).** 628 non-guard conditionals, 921 distinct `NFS4_*` macros:

| Kind | Count | Meaning |
|---|---|---|
| order / hook / pass | 271 | place a type at one point of one object's record order (53 computed includes, 21 self-including "type part" headers) |
| member visibility | 116 | a class shows different members per object (femenuoptions.h 18, screenmemcard_types.h 15, screentournselect_types.h 15, fe_core_tmenu.h 10, screencarselect_types.h 10, fe_core_types.h 8) |
| omit a type / record | 93 | a type is left out for one object (draww_types.h 14, audioclc_types.h 13, audiocmn_types.h 10) |
| owner / key object | 47 | strip marking or key-object exception (legitimate mechanism) |
| other / keyed on includer | 115 | mixed |

**Layer 4 - function bodies (NOT started; partly covered by standing rulings).**

| Construct | Count | Note |
|---|---|---|
| `SYM-CODEGEN-CARRIER` locals | 175 | draww 27, screencontroller 21, aih_cop 18 |
| `DEVICE (exact-only)` | 138 | allowed by ruling when BYTE+SYM+SLD exact |
| `goto` | 245 | retail had none (law: if/else + duplicated tail gives the same bytes); aistate 32, draww 27, collide 22 |
| `volatile` in sources | 270 | ruling allows it only for MMIO / ISR-shared with evidence; feapp 25, audiocmn 23 need review |
| `do { } while (0)` | 63 | allowed as scheduling barrier |
| asm statements | 52 | GTE / BIOS / EA templates are allowed; the rest to classify |
| asm-label aliases | 39 | none left in frontend headers; rest in .cpp and game headers |
| `__typeof__` | 22 | |
| decompiler names (`param_N`, `iVarN`, `in_`, `unaff_`) | 410 in 36 files | hrzsku 45, drawc 41, draww 38, r3dcar 31, front 29 |
| `D_8xxxxxxx` data names | 43 | |

**Layer 5 - comments.** 219 "Ghidra" mentions, 229 references to a `nfs4_types.h` that no longer describes the
layout, 170 "inferred" notes. Cosmetic, but they misdescribe the code.

**Layer 6 - unknown retail content.** The Open-mismatch table (inline bodies retail had and we cannot name).

### Revised roadmap

**Phase 6 - prototypes (audited 2026-11-14 with `tools/prototype_audit.py`; scope is much smaller than estimated).**
The tool demangles the 1388 C++ free functions of the retail link map and compares every prototype in the tree.
Result:
- C++ functions: 1313 declared in the tree, **all with a retail-compatible parameter list** except one
  (`SavePinkSlipsCars(tCarManager*, tSaveCarInfo*, short)` in fememcard_externs.h: no such retail function).
  The "96 conflicting signatures" of the first estimate are real retail overloads (5 functions, e.g.
  `AIWorld_ApxSplineDistance` has four) plus the C-linkage group below. Nothing to do beyond that one case.
- C-linkage functions (PsyQ, libc, EA library; the retail map has no types for them): 37 functions are declared
  `(...)` in 76 places and 33 are declared in more than one form.
  Important: PsyQ 4.3's own STRINGS.H / MEMORY.H declare `strcpy`, `strlen`, `strcmp`, `memcpy`, `memset` with an
  EMPTY parameter list ("to avoid conflicting"), which g++ 2.8 treats as unprototyped inside `extern "C"`.
  So `(...)` is the truthful spelling for those five; it is wrong for `sprintf` (PsyQ: `char *buffer, char *fmt,
  ...`), `DrawSync(int)`, `SetSp(unsigned long)`, `GetClut`, `GetTPage`, `SetDrawMode`, `SetDrawArea`,
  `SetSemiTrans`, `SetDefDispEnv`, `CdDiskReady`, the `SND*` and `PAD_*` functions.

Work:
1. Remove the `SavePinkSlipsCars` 3-argument declaration (call the member).
2. C-linkage: the truthful form is to include the real PsyQ 4.3 headers (STRINGS.H, STDIO.H, LIBGPU.H, LIBAPI.H,
   LIBGTE.H, LIBCD.H) and the EA library headers instead of re-declaring per object. The PsyQ headers also define
   types (RECT, DISPENV, DR_MODE ...) that the tree currently carries as `shared/*.h` with order hooks, so this
   belongs with phase 9 (record order). Until then: one `lib/psyq_protos.h` with the exact PsyQ 4.3 prototypes,
   included by the `*_externs.h` files in place of their private re-declarations.

Status 2026-11-14: 6a (sprintf, 86 declarations), 6b (20 PsyQ functions, 116 declarations), 6c (libc group, 80
declarations) landed. Observation from 6c: two unrelated places (audiomus.cpp `strlen(pattern) < 0x3d`,
memcard.c `0x20 < strlen(title)`) are UNSIGNED compares in retail. With PsyQ's `int strlen()` the bound has to
be written unsigned at the call site (done). If more such sites appear, the alternative reading is that these
files saw an unsigned-returning strlen (compiler built-in or an EA header) - revisit then.
Left in the C-linkage group: EA library functions (`SND*`, `PAD_*`, `padinit`, mdec helpers) which need the EA
headers as authority, and `atoi` / `qsort`.

Gate: bytes identical (a typed prototype changes argument promotion, so sweep every includer's assembly);
counters `C_VARIADIC` 76 -> the five truthful names only, `C_CONFLICT` 33 -> 0.

**Phase 7 - one type per global (audited 2026-11-14 with `tools/global_type_audit.py`).**
The retail SYM records a type for 668 globals. The tool checked the 1139 `extern` declarations of the 377 globals
the tree declares. 1022 agree. The exact remainder:

| Finding | Declarations | Globals | What it is |
|---|---|---|---|
| VIEW: `GameSetup_gData` | 56 | 1 | declared as `int[650]` (38), `int[]` (8), `int[50][13]` (4), `int[325][2]` (4), `int[8]`, `int[244]` instead of `GameSetup_tData` |
| VIEW: others | 19 | 15 | `simGlobal` as `int[6]`/`int[2]`; `Camera_gInfo`, `gCView`, `TrackSpec_gSpec`, `HudPmx_gHudNumberUV`, `BWorld_gChunkBuildList` as `int[]`; `Input_gSim`, `AICop_gRoadBlockState`, `AIHigh_CopGameType` as `int`; `Replay_ReplayInterface` as `int[8]`; `ginfo` as `char[256]`; `highLevelAIObjs` as `AIHigh_Traffic*[]`; three `void*`/`char*` for typed pointers |
| SCALAR | 4 | 2 | `HudBustedOverlay`, `gNight_renderNight` declared `int`, retail `unsigned char` |
| SHAPE: scalar declared as unsized array | 16 | 16 | `extern int inFrontEnd[]`, `Draw_gDoVSync[]`, `gFlip[]`, `gMaster*Level[]`, `R3DCar_InMenu[]`, ... (retail: plain `int`) |
| SHAPE: wrong dimensions | 2 | 2 | `AIPerson_ScriptData[]` vs `[9][7]`, `Anim_gInstanceFromIndex[8]` vs `[32]` |

Work, in this order:
1. The 19 "other" views and the 4 scalars: declare the retail type, adjust the access expressions
   (`simGlobal[1]` -> `simGlobal.gameTicks`), sweep. Same nature as the class views removed in phase 4-B.
2. `GameSetup_gData` (55 view declarations): KEPT, see ruling 4 (revised). The other views are done (7a, 7b).
3. The 16 unsized-array scalars are a code-generation lever: an unsized extern array is never addressed through
   `$gp`. Before touching them, find out why retail does not use `$gp` for these in those objects - if the same
   objects avoid `$gp` for all small data, the truth is a per-object `-G0` in the retail build, not 16 declarations.
   Investigation item (compare `$gp` use per object in the retail image).

**Phase 8 - finish the classes.**
- Game-side menu header -> frontend headers (5 classes + `tListIteratorIndexed`).
- `tMenuItem` / `tMenu` and the 116 member-visibility conditionals: flatten per class, keeping member order
  (4q law), sweeping every includer's generated assembly. Needs rulings 1 and 2.
- Key-object exceptions -> declare + LINK_STRIPPED + out-of-class body + link_stripped.json row.
- The 93 "omit a type" conditionals: each hides a type from one object because retail does not record it there.
  With real headers the type is visible; whether a record appears is the compiler's business. Remove them
  family by family and log the census effect.

**Phase 9 - record order (RULED 2026-11-14: keep order as a measurement, stop buying it with hooks).**
The order of type records in an object is a fingerprint of what that .cpp included and in which sequence - the
best evidence of the retail include graph - so it stays measured. The 271 order conditionals, 53 computed includes
and 21 self-including "part" headers write the answer in per object and hide the cause, which in retail is one of:
the .cpp included its headers in another sequence; the type lives in another header than we think; or the compiler
emitted the record at first use, not at definition (debug-request law).

Method:
1. One file per retail header (`FEMENU.H`, `AIHIGH.H`, `SCREENPOST.H`, ...), types in retail's in-file order. The
   existing `#line` anchors already give retail file names and line numbers for many classes.
2. One explicit include list per object, in the sequence that object's SYM implies. No macros.
3. Delete a hook only when the plain structure gives the same or fewer inversions for that object. Where it gives
   more, log the inversion under Open mismatches; never keep or add a hook to win one back.
4. Inversions are a tracked counter (SLINK lane), not a pass/fail gate.

Sequence: last, after phases 7 and 8 (each of those changes record order). The four objects that picked up
inversions in phase 4 (audedit, scene, screenaudio, screencontroller) are fixed here by include placement.
Pilot first on the AI objects (aihigh.h is already close to a real header): measure how many hooks disappear at
equal inversions before committing to the rest. Known limit: positions that depend on emission-at-first-use come
from code, not includes, and may not be reproducible from header structure alone.

**Phase 10 - bodies.** Per file, worst first (draww, drawc, aih_cop, aistate, collide, screencontroller):
remove `goto` (law says same bytes), carriers and devices where a natural spelling matches, decompiler names
-> SYM names (the SYM names every recorded local), review each `volatile` against the MMIO/ISR rule.
Gate per function: BYTE + SYM + SLD, as today.

**Phase 11 - recover unknown bodies** from the Open-mismatch table (FEMENU.H first), using NFS4-PC and line gaps.

### Rulings (decided 2026-11-14; the owner delegated them: "make a decision by yourself - what you think is right and correct")
1. `tMenuItem::IsEnabled()` two bodies: ONE name per body. `IsEnabled()` keeps `(fFlags & 1) == 0`; the
   `((fFlags ^ 1) & 1) != 0` body gets a descriptive second name and both are visible to every includer.
   The second retail name is unknown and is logged as such.
2. `virtual void Draw(bool) = 0` is pure for every includer (the retail vtable slot is `__pure_virtual`). Derived
   classes that are instantiated must declare their override; copies that do not are fixed, not exempted.
3. Record order: see phase 9 (measure it, replace hooks by real headers + per-object include lists, never keep a
   hook to win an inversion, pilot on the AI objects).
4. Globals get their retail type wherever that adds no type record retail lacks (REVISED 2026-11-14 after
   measurement). Done for 18 view declarations of 14 globals in phases 7a/7b at unchanged census. `GameSetup_gData`
   is the exception and KEEPS its word views in the ~40 objects whose retail SYM has no `GameSetup_tData`:
   - retail records the leaf types (`GameSetup_tCarData`, ...) in those objects but not `GameSetup_tData`, although
     shared inline bodies (`AICop_PerpChaseInfo` ctor) read `numLaps` / `commMode` there;
   - a used `extern GameSetup_tData GameSetup_gData` always records the type with this compiler; tried and measured
     on aiinit: plain struct, member function declared, constructor, virtual, static member, inline body - the
     record is emitted in every variant, so there is no debug-suppression explanation;
   - the real type would therefore add records retail lacks, against the standing "SYM exact, no new records" rule,
     and the owner approved exactly this view on 2026-11-08.
   How the original source reached these fields without the struct is unknown (logged under Open mismatches).
5. Function bodies (phase 10) are in scope, last, under the unchanged BYTE + SYM + SLD gate per function.

Standing principle for every remaining choice: the source says what the original source most plausibly said; a
measured mismatch that cannot be explained is logged, never fitted.

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
| 2026-11-12 | 65f574ba1 | Phase 4-C.2: constant-macro fakes of the text enums removed from 6 headers; tCheatCode real enum in fetourn/screencarselect/fecars/fecredits; WordWrapFade (RECT&) and FECheat_*(tCheatCode) real prototypes. No asm-label aliases left in frontend headers | 0 | 7 | 143 | 12 | 139 | 1662 |
| 2026-11-12 | db68d0bb7 | Phase 4-C.3:  /  removed (fe_menu_game_surface.h, nfs3_types.h, mmeffect_types.h); mpause_types.h uses the one definition. Macro-faked enum types: 0. Census unchanged | 0 | 7 | 143 | 12 | 139 | 1662 |
| 2026-11-12 | 7a756e5b7 | Phase 6a: sprintf declared in 12 spellings (27 of them ) -> the PsyQ 4.3 STDIO.H form everywhere; dead SavePinkSlipsCars(tCarManager*, tSaveCarInfo*, short) decl removed. All 1313 C++ prototypes audited compatible with retail mangled names | 0 | 7 | 143 | 12 | 139 | 1662 |
| 2026-11-12 | bec0e298d | Phase 6b: 20 PsyQ C functions declared in 2-4 different forms (many variadic) -> the exact PsyQ 4.3 prototype everywhere (116 declarations). Code identical in every object | 0 | 7 | 143 | 12 | 139 | 1662 |
| 2026-11-12 | 16da27075 | Phase 6c: strcpy/strlen/strcmp/memcpy/memset/strcat/strncpy/strchr/rand/puts/InitGeom in the PsyQ 4.3 forms everywhere. Two sites depended on an unsigned strlen (audiomus.cpp, memcard.c): bound now unsigned at the call site | 0 | 7 | 143 | 12 | 139 | 1662 |
| 2026-11-12 | 62e1241f6 | Phase 8a: shared/fe_menu_game_surface.h no longer defines classes (includes felist_classes.h + fe_core_types.h); nfs3 tListIteratorIndexed copy removed; tMenuCommandType 15 copies -> shared/tMenuCommandType.h. Classes defined more than once: 0 real | 0 | 7 | 143 | 6 | 139 | 1662 |
| 2026-11-12 | 411c89d9e | Phase 7a: 11 view declarations of 7 globals replaced by the retail types (member access instead of index/offset macros). Census unchanged - the views bought nothing. HudBustedOverlay / gNight_renderNight  are retail-true (bool in the owner, read as words elsewhere) | 0 | 7 | 143 | 6 | 139 | 1662 |
| 2026-11-12 | efbf1f126 | Phase 7b: the remaining 7 view globals now carry their retail types (member access instead of offsets; textureprocess needs no CSkySpec device with the real CTrackSpec). Input_gSim.steering is read through a signed char cast - plain char is unsigned in this build. Census unchanged | 0 | 7 | 143 | 6 | 139 | 1662 |
| 2026-11-12 | 5cc656026 | Phase 8b: tMenuItem flattened - no per-object member sets. Draw(bool) pure everywhere, the FEMENU.H:274/275 Transition bodies for all, 11 inline members declared once and defined after the class (key object FEMenu strips its copies; +3 strip rows IsActive/IsDisabled/ButtonImage). Ruling 1 refined: IsEnabled() is the xor body (owner, fedialog and the pause-menu twin use it), the (fFlags & 1) == 0 body is IsActive() (name unresolved). Census 1662 -> 1356: the uniform definition is closer to retail than the fitted subsets. Also AIPerson_ScriptData [9][7] and Anim_gInstanceFromIndex [32] dims; GameSetup_gData views kept (ruling 4 revised) | 0 | 7 | 143 | 6 | 142 | 1356 |
| 2026-11-12 | bf453ed17 | Phase 8c: tMenu flattened like tMenuItem - 8 member-visibility conditionals replaced by one declaration set, bodies after the class, the key object FEMenu strips its copies through one owner switch (TMENU_KEY_STRIP). Census unchanged at 1356 | 0 | 7 | 144 | 6 | 142 | 1356 |
| 2026-11-12 | 4d80cb5a2 | Phase 8d: 17 member-visibility conditionals in femenuoptions.h removed - every includer sees the full member declarations and the inline ctors. FEMenuOptions.obj (key object) emits 8 standalone copies -> .text.strip rows (owner switch FEMENUOPTIONS_KEY_STRIP). tUserNameMenuItem::SetUserNameData/SetPostGameNameData are declared in the class but defined in femenudefs_externs.h: retail records those bodies in FEMenuDefs.obj only. Census 1356 -> 1336; front.obj TPDEF tUserNameMenuItem flipped from +1 to -1 (logged, not fitted) | 0 | 7 | 145 | 6 | 150 | 1336 |
| 2026-11-12 | 880f2ca98 | Phase 8e: removed 32 macros that nothing tests any more (per-object member-set selectors of tMenuItem/tMenu/menu items, old Group setter selectors, unused TD/TU keys) - 68 #define/#undef lines in 30 files. No measured change | 0 | 7 | 145 | 6 | 150 | 1336 |
| 2026-11-12 | 80e881467 | Phase 8f: the three NFS4_KEY_OBJECT_* blocks that hid an inline member from the class key object are gone - the member is declared for every includer, the key object emits its standalone copy into .text.strip (+3 rows). Census 1336 -> 1333: retail's key objects do record these bodies | 0 | 7 | 145 | 6 | 153 | 1333 |
| 2026-11-12 | 5da57ed46 | Phase 8g: 4 of the 6 remaining member conditionals removed. aihigh.obj TPDEF Car_tObj extra 1 -> 2 (the declaration-only GetCarObj in the owner was a fit; logged). Kept: CAudioList::Elems (its owner audedit does not know AudioElem) and tUserNameMenuItem::SetUpP (feapp-only body) | 0 | 7 | 145 | 6 | 154 | 1331 |
| 2026-11-12 | 2df22b753 | Phase 8h: the feapp-only SetUpP member had the same statements as SetPostGameNameData; feapp now calls that name and both recording objects (FEMenuDefs, FEApp) include one definition (usernameitem_postgame_inline.h). One member conditional left in the tree: CAudioList::Elems | 0 | 7 | 145 | 6 | 154 | 1331 |
| 2026-11-12 | 12f9ef597 | Phase 9a (pilot): method proven on the AI objects - cut the shared header at each hook point into plain parts, the default wrapper lists them, an object with its own record order lists the parts itself with its types in between. The token stream of every object is unchanged, so inversions are equal by construction. NFS4_AIH_HIERARCHY_TRIGGERS_TAIL / _WINGMAN and both second passes are gone | 0 | 7 | 145 | 6 | 154 | 1331 |
| 2026-11-12 | e62e1d260 | Phase 4y: enums were never deduplicated (the class counter did not see them). tools/psyq_pipe/enum_dedup.py moves identical copies to shared/<Name>.h, line-neutral. Left: VIDEOSTATE, crimeType, one tCarClassType copy (texts differ - to review) | 0 | 7 | 145 | 6 | 154 | 1331 |
| 2026-11-12 | b81b9bef3 | Phase 9b: last hook of the AI hierarchy header removed (NFS4_AIH_HIERARCHY_HOOK_SCENE): sim_types.h includes its scene types between color_types.h and the hierarchy parts. The AI hierarchy is hook-free | 0 | 7 | 145 | 6 | 154 | 1331 |
| 2026-11-12 | 5d7993b30 | Phase 9c: the common type graph (color_types.h) is cut at its nine hook points into color_p0..p9; the wrapper lists them with the remaining hooks in between. souffle, audedit, audiotrk, bworldSm, collide, scene, skidmark, flare, fe3dmenu list the parts with their own header at the right place (tools/psyq_pipe/colorlist.py). Hooks BEFORE_GROUP, AFTER_SIMSLICE, AFTER_BWSM deleted. Left: 6 hooks used by chained includers (bworld/object/draww/drawc/render/night/textureprocess; the AFTER_CAR family) | 0 | 7 | 145 | 6 | 154 | 1331 |
| 2026-11-12 | 1d3003d11 | Phase 9d: 6 of the 9 color_types.h order hooks are gone (left: AFTER_SAVE and AFTER_BO for drawc, AFTER_CAR for 10 headers). Where two objects share one types header (night/render, draww/bworld, sim/object) the computed include became an explicit branch on the existing second-user switch, so the conditional counters rose by 5 - visible branches instead of hidden hooks. To do: turn the self-include second passes into small plain headers | 0 | 7 | 145 | 6 | 154 | 1331 |
| 2026-11-12 | 4727312d2 | Phase 9e: 8 of the 9 color_types.h hooks are gone; only AFTER_CAR remains (audio/cars chain and three frontend headers). gmesetup_types.h carries the explicit list with the drawc and hud passes (+3 visible conditionals) | 0 | 7 | 147 | 6 | 154 | 1331 |
| 2026-11-12 | 2da6fd419 | Phase 9f: cars, nfs3, copspeak, audiocmn, audioclc no longer use NFS4_COLOR_HOOK_AFTER_CAR; audioclc_types.h lists the parts and names the five owners at the Car_tObj point (+6 visible conditionals). Verified before the gate by identical preprocessed source per object (new fast check). Inventory: 46 computed includes left tree-wide (screendisplay_types.h 11, fe_core_cars.h 4, draw_leaf_types.h 4, nfs4_types.h 4, chunk_types.h 3, audiocmn_types.h 3, screencarselect 3, pads 2, others) | 0 | 7 | 148 | 6 | 154 | 1331 |
| 2026-11-12 | 4d71601ae | Phase 9g: draw leaf = draw_leaf_core.h + four parts; flare, souffle, dashhud, color, mpause, drawdbg, hrzsku, draw, trsproj, audio, input, fecntl, screentrophyroom, drawshp, fe3dmenu, fetools, mmeffect list the parts with their own header at the hook point (tools/psyq_pipe/leaflist.py). Verified per object by identical preprocessed source (tools/psyq_pipe/ichk.sh), then the gate. Each list still carries the phase-2 guard (+18 conditionals) - to be dropped where unnecessary. Hooks stay for: statchk, stattool, cars, object, fetextrender, r3dcar/drawc/hud/psxcontroller, draww/bworld | 0 | 7 | 148 | 6 | 154 | 1331 |
| 2026-11-12 | 8131d56bb | Phase 9h: the phase-2 guard around each draw-leaf list was unnecessary (identical preprocessed source without it) and is removed; cars_types.h and object_types.h list the parts after setting the two core switches their chain used to set later. Draw-leaf hooks remain for statchk, stattool, fetextrender, r3dcar/drawc/hud/psxcontroller, draww/bworld | 0 | 7 | 148 | 6 | 154 | 1331 |
| 2026-11-12 | c488eac66 | Phase 9i: the remaining draw-leaf hook users converted - draww/bworld, the drawc/r3dcar/hud/psxcontroller chain (list in gmesetup_types.h), statchk, stattool, fetextrender. psxcontroller_types.h tested 'is the draw-leaf hook defined' to know whether it is compiled standalone; that is an explicit condition now. Explicit branches in the two chained headers: +4 per-object conditionals | 0 | 7 | 152 | 6 | 154 | 1331 |
| 2026-11-12 | 4af8acc1f | Phase 9j: NFS4_PADS_HOOK_AFTER / _BEFORE are gone. The pad header is pads_records.h + pads_tail.h, the minimal core is game_common_min_core.h; anim, chunk, clock, gmesetup, input, minfront, nfs3, physics, replay, simqueue, sim, track, draw, loading, overlays, psxcontroller list them (tools/psyq_pipe/padlist.py). Verified by identical preprocessed source for every object, then the gate | 0 | 7 | 152 | 6 | 154 | 1331 |
| 2026-11-12 | 58f0ec78c | Phase 9k: nfs4_types.h = nfs4_core_0_kernel / _1_gpu / _2_shape / _3_cd / _4_tail. simqueue, device, audiotrk, drawdbg, font, video, drawshp list the parts with their own header at the hook point (tools/psyq_pipe/corelist.py). Hooks AFTER_PADS, AFTER_DRMODE, BEFORE_CD deleted; AFTER_CD stays for two frontend screen headers | 0 | 7 | 152 | 6 | 154 | 1331 |

## Open mismatches (left unexplained on purpose)

Phase 1 removals. Each is a retail type record our source no longer produces; restore only under the evidence rule.

| Object | Retail record left unmatched | What is known |
|---|---|---|
| aihigh.obj | ours records 2 more `Car_tObj` than retail (1 before phase 8g) | `AIHigh_Base::GetCarObj()` is an inline body for every includer now; the owner used to see a declaration only, which was a fit |
| front.obj | `tUserNameMenuItem` one record short (was one too many before phase 8d) | the class is one definition now; which body retail's Front.obj saw is unknown |
| audedit.obj / audiotrk.obj | `CAudioList::Elems()` is still visible to audiotrk only | the owner object audedit does not know `AudioElem`, so the member cannot be in the class as that object sees it; retail form unknown |
| hud.obj | `Car_tObj` (+ field walk) before Hud_BuildCdPlayer | HUD.CPP lines 795-800 owned by no retail function: a link-stripped function existed, name and body unknown |
| copspeak.obj | `Car_tObj` between CopSpeak_StartUp and CopSpeak_Request | COPSPEAK.CPP 975-1027 gap: link-stripped function, unknown |
| psxfront.obj | `Car_tObj shapetbl` before DoTitleScreen; `shapetbl` before FontUpsideDownBlit | PSXFRONT.CPP 98-141 and 1260-1338 gaps: two link-stripped functions, unknown |
| aidatarecord.obj | `Car_tObj` (+walk), `AIDataRecord_t` between StartUp2 and CleanUp1 | count only |
| aih_basiccop.obj | one more `Car_tObj` in the ctor group | count only |
| aih_btccop.obj | `Car_tObj` in the BTC_Perp run; `coorddef` after AIDataRecord_AccTable_t | count only |
| AI objects | one more `AIHigh_BTC_Perp` (this-only body); aihigh.obj one more `AIHigh_Base` | count only |
| aih_cop.obj | ours records 5 more `Car_tObj` than retail (aih_basicperp/aih_btcperp/aih_play: 1 more) | single SPEECH.H gives every AI object the same in-class Speaker defaults; retail difference unexplained (count only) |
| audioclc/audiotrk/camera.obj | one `Trk_AnimateInst` each | count only |
| `GameSetup_gData` word views | ~40 objects | retail has no `GameSetup_tData` there, yet reads its fields (even from shared inline bodies). No declaration form of the real type reproduces that; the original construct is unknown. Views kept (owner ruling 2026-11-08) |

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
