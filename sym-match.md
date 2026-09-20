# SYM match — making the source agree with the retail `NFS4.SYM`

Status as of 2026-09-21. Current full-debug board: `build/psyq_g/symtree_report.json`.

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
| **Match implemented function checks (CLEAN)** | **1641** |
| Differ (DIRTY) | 924 |
| Files whose compared functions are all CLEAN | 46 of 177 |

The effort started at 1499 clean. The 5 retail functions not compared are the EA pad library's `PAD.C`
(`recon/eaclib/psx/pad.c`), which is outside the two directories the debug compile covers.

Honest link: 299710/299710 words = 0 diff. Overlap audit: 0 masked RECON mismatch bytes
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
| `symtree_cmp.py build/psyq_g/nfs4_sym.txt [--list CLASS] [--fn NAME] [--retail-only]` | The whole-tree board. Compares frame, locals and scope tree of every function with the retail SYM and writes `symtree_report.json`. Normalises the lane's `___X` destructor spelling to retail's `_._X`, and anonymous tag numbers (`._148`), which only count the unnamed types seen earlier in the file. |
| `symfn_cmp.py <dump> <mangled name>` | One function, both sides next to each other: frame, every local with its home, and the scope tree with function-relative addresses and line numbers. The main tool for hand work. |
| `symlocals.py <name> ...` | Compact one-line view: the locals of a function in declaration order with scope depth and home, ours against retail. |
| `symtree_parse.py` | The dumpsym-text parser shared by the tools above. |
| `scope_probe.py <file.cpp>` | Compiles a small probe with the retail compiler and `-g` and prints each function's scope tree. Used to learn which source constructs create a debug scope (see "Scope rules"). Probe source: `build/tmp/gsym/scopes.cpp`. |
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
| BLOCKS | 740 | The scope tree differs. In 539 of them retail has **more** scopes than we do, in 172 fewer, in 29 the count is equal but nesting or addresses differ. |
| EXTRA | 480 (1301 locals) | We declare a local retail does not have: an invented carrier, a decompiler temporary, or an expression retail wrote through an inline call. |
| MISSING | 251 (359 locals) | Retail has a local we lack. 180 of the 359 are `this` of an inlined member call. |
| MOVED | 82 | Same name, different register or stack slot: our local plays a different role than retail's. |
| ORDER | 8 | Declaration order differs (only reported when no local is extra or missing). |
| TYPE | 1 | Same name and home, different type. |
| FRAME | 1 | Frame size differs. |

Most common combinations: BLOCKS only 292; BLOCKS + EXTRA 179; EXTRA only 138; BLOCKS + EXTRA + MISSING 110;
BLOCKS + MISSING 95.

Files with the most differing functions: `SPEECH.CPP` 44 of 87, `HUD.CPP` 33 of 62, `FEMENUOPTIONS.CPP` 33 of 83,
`FEMENUDEFS.CPP` 26 of 59, `DRAWW.CPP` 24 of 35, `PAUSEMENU.CPP` 22 of 58, `SCREENCARSELECT.CPP` 21 of 56,
`AISTATE.CPP` 20 of 42, `CAMERA.CPP` 19 of 38, `FETOURN.CPP` 18 of 35.

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

### 3. Scopes we have and retail does not (BLOCKS, 172 functions)

Usually braces added to steer code generation, or inline helpers of ours that retail did not have. 55 files also carry the
`if (0) sprintf((char *)0,"SimpleMem")` literal carrier in their first function; how retail got that unreferenced string
into each object is unsolved, and until it is, those functions cannot be fully clean by honest means.

### 4. Invented locals that are not inline calls (EXTRA)

Carriers introduced to get a register allocation or an instruction order (`SYM-CODEGEN-CARRIER` comments mark most). Each
is a real matching problem: the local has to go and the code has to stay. `Stats_TrackEndGame` (commit `ad44f8d0`) is the
model: the fix was the operand order of a `MIN`, after which two register pins, four asm statements and four invented
locals were all unnecessary.

Only 36 of the 1301 extra locals still have decompiler names (`iVar1`, `piVar2`); the rest look deliberate.

### 5. MOVED (82)

Same name, different home. The bytes match, so our variable of that name is not the quantity retail's was. Typical cause:
names swapped between two locals (`AIPhysic_HandleSignalling`: `lPos`/`lDes`; `DrawC_ShadowPrimClip`: `uv2`/`uv3` are
named by destination slot). Check for a swap first; 17 functions have MOVED as their only difference.

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
