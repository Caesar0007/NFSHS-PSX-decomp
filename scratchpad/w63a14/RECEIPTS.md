# W63-A14 RECEIPTS — drawc / psxcontroller / cario / r3dcar belt

Repo HEAD at start `10e1a01b`. Every number below re-gated by me with
`tools/verify_asm.py` (or `tools/vprobe.py` for wiring probes) on this tree.
Commits: `70e2d239`, `c0bfed9d` (drawc), `7c6c88b8`.

## 0. RE-GATED BASELINES (board rows vs truth)

| fn | board % | MY baseline | final |
|---|---|---|---|
| DrawC_PrimClip | 95.50 | 552 (1883/1877) | 552 (untouched) |
| DrawC_PrimStart | 97.42 | 54 (976/976) | **52** (976/976) |
| DrawC_Prim | 96.85 | 336 (1395/1389) | 336 (angle falsified + renamed) |
| InGame_GetPSXPadValue | 67.94 | 257 (212/233) | **168** (243/233) |
| InGame_SetRamp | 91.56 | 13 (99/98) | 13 (new priced angle) |
| CarIO_CreateLicense | 96.81 | 30 (229/229) | 30 (device negative) |
| CarIO_ReadInCarTextureData | 99.69 | 19 (492/491) | 19 (r/m/g sweep closed) |
| R3DCar_CalcCarDimensions | 99.95 | **PASS** (stale row) | PASS |
| R3DCar_InsertCarFacetMenu | 99.56 | 12 (1054/1054) | 12 (lever falsified) |
| R3DCar_InsertCarFacet | 99.52 | 9 (1143/1144) | **7** now / **PASS** with the wiring spec |

Stale board rows found: `R3DCar_CalcCarDimensions` was already PASS;
`InGame_ResetPSXController` was already PASS (an in-source receipt claimed 3).

## 1. SEALS / LANDINGS

### 1.1 R3DCar_InsertCarFacet — 9 -> PASS (COUPLED: source + wiring)
* **Source (landed, `70e2d239`)**: the replay base must stay an IN-LOOP reference.
  Retail's wheel-loop preheader emits `li $t1,2` BEFORE
  `la $t0,Replay_ReplayInterface`; that is loop.c movable DISCOVERY order (the
  literal 2 is first seen in `replayMode != 2`, the base only in the else arm's
  `->speed`). The hand-hoisted preheader local `replayInterface` made the base
  ordinary preheader CODE, which always precedes the LICM group, so the two
  materializations swapped and no dial could reorder them. Deleting the local +
  its read-only fence and spelling `Replay_ReplayInterface.speed` at both uses
  restores retail's order. 9 -> 7 alone, PASS with the wiring.
  Falsified: assignment moved after `replayMode = ...` (2); base kept + fenced (2);
  the old fence moved onto `Replay_ReplayInterface.speed` (1 @1145, +1 insn).
* **Wiring (SPEC, orchestrator)**: `scratchpad/w63a14/SPEC_r3dcar_jtbl.json` —
  drop `jtbl_at_fusion` from `PER_TU_FLAGS["recon/game/common/r3dcar.cpp"]`,
  keep `g_value: "8"`. Mis-attribution of the same class as w38-a5's sfx.cpp:
  neither InsertCarFacet nor InsertCarFacetMenu has a single `$at` jtbl macro in
  its oracle. Whole-TU sweep with the flag off: 27 rows, only InsertCarFacet moves.
* **Production lane**: `psyqproof.py` already reports **1144 words -G8 REAL=0
  RELOP=0** with the flag present -> ASPSX emits the split form natively; this is a
  gate-only artifact and the fn is a DUAL-LANE seal the moment the wiring lands.

### 1.2 InGame_GetPSXPadValue — 257 -> 168 (`70e2d239`)
Ported the cross-TU twin `recon/frontend/common/front.cpp:GetPSXPadValue`'s
EXPRESSION SHAPE wholesale. Three additive landings, each re-gated:
1. flatten the six tagged 0x53/0x73 arms (`player<<0x1e | TAG | hi | lo`, tag
   SECOND, no nesting) — 257 -> 208 @243
2. + flatten the two tagged 0x23 arms (0x4000 / 0x8000) — 197 @244
3. + the twin's TWO-STAGE compound spelling on 0x23/0x200000
   (`newControl = tag|hi; return (newControl |= lo) | 1;`) — **168 @243**

Fence set re-swept from EVERY new basin (04Z): after (1)+(2) the w62-a14 optimum
`{8,9}` is no longer optimal ({} 197@238, {8} 196@237, {9} 198@245, {8,9} 197@244);
after (3) the winner is `{8}` alone (168) vs {} 189. Arm 9's fence is **superseded
by** the two-stage spelling. Falsified: the same two-stage on arm 8 as well
({8} 196@245, {} 188@239 — the two 0x23 range arms are not symmetric).

### 1.3 DrawC_PrimStart — 54 -> 52, count still EXACT 976/976 (`c0bfed9d`)
Retail reads `sd->sub_otz` for the `world_otz` copy BEFORE loading `sort_carObj`
(`lw v0,64(s3); lw a0,2168(s2)`); our two statements were the other way round.
Falsified alongside: an `R3DCar_InMenu` block temp declared before
`shapeIdx = sd->sub_otz;` (54, inert — the asm-volatile `"memory"` barrier pins
the global load); `nabr_blend = 2;` above the envExtra guard (64); splitting
`iVar3 = (uVar5-1)<<16>>16` into its own decrement statement (55 alone / 53 with
the swap / 51 with both — all @977, so rejected on the count bar).

## 2. FALSIFICATIONS / RE-NAMED ANGLES

### 2.1 DrawC_Prim — the W62 "id0/1/2 DECLARATION SCOPE" angle is FALSIFIED
* whole decl group moved from `case 0:` scope into the `if ((envmap&2)==0)` arm:
  **336 BIT-IDENTICAL**
* only id0/id1/id2 moved into that arm: **336 BIT-IDENTICAL**
* id0/id1/id2 declared inside the `while(true)` BODY: **415 @1394** (worse; also
  plants the NOTE_INSN_BLOCK_BEG that 13D says blocks duplicate_loop_exit_test)

**Re-named angle:** id0 is LOADED before the `MPrimPtr <= PrimPtr` guard and
MORPHED after it, i.e. referenced in TWO basic blocks, so local-alloc.c:471-477
sets `reg_qty -1` and it is a GLOBAL allocno *whatever C scope declares it*. The
knob is the pseudo's BASIC-BLOCK SPAN (move the three `lbu` loads below the guard),
not the lexical scope — but retail ALSO loads them before its guard, so retail's
in-place `sll a2,a2,3; addu a2,a2,s1` must come from the 13A SET_PREFERENCE route
(id0's defining SET is `id0 = tmp + sd`, so it prefers tmp's home; ours puts tmp in
$v0 and id0 in $a0). Next instrument: a `-dg` preference/conflict read on this fn.

Separately: the W50 triage in-source says the dominant Prim/PrimClip cluster is the
per-vertex UV TINT block and that **DrawC_PrimMenu's uv pair must be cracked first**
— PrimMenu is now **PASS (480/480)**, so that transfer is unblocked and is the
highest-value remaining route for both heavies (the w60-a7 PrimMenu receipt has the
whole rule-8 recipe).

### 2.2 R3DCar_InsertCarFacetMenu — the index-term-first lever (12D-A6) is a NET LOSS
It FIXES the `sub_ot` cluster's addu grouping but pays more elsewhere: deleting the
`subOtRow = subOtStart[gFlip]` statement moves the gFlip global load after
`lw a0,0(s1)` (retail batches it before) and flips the two `sll`s. 12 -> 20.
Ten spellings measured, all >= 20 except the local-2-D form at 14:
idx-first 20 · gFlip-first 22 · parenthesised sum 20 · `<<` form 22 ·
via the `subOtStart` local 20/22 · natural 2-D 22 · with a `flipIdx`/`flipOff`
preheader temp 20/22/22/22 · local-2-D + temp 14.
Sibling cluster (`ppTVar21` = &LoadedScenePointer[cf][carType], identical retail
shape): `&R3DCar_LoadedScenePointer[cf][carType]` 24, byte-math index-first 22 —
both worse than the split-statement 12. **Spelling axis exhausted.**

### 2.3 CarIO_ReadInCarTextureData — the 4th dial (r/m/g) constraint sweep, CLOSED
From the 19 basin: `"r"` 19 @492 (kept) · `"g"` **186 @491 = the no-fence
baseline** (g lets gcc satisfy the operand from the register the value already sits
in -> no memory ref, no `hard_reg_n_uses` bump, dial INERT) · `"m"` 622 @499 ·
`"g"/"m"` on carType 186/233 · two `"m"` operands 633.
**LAW CANDIDATE:** on the spill-pool ref dial the constraint letter is not a free
choice — only `"r"` buys the dial, because the dial IS the forced reload; the +1
insn is STRUCTURAL to the instrument.
Also falsified: the fence moved INSIDE either/both arms of the `reload & 0x10`
if/else = 186 (inert — inside an arm the value is already in a register; only the
JOIN forces the reload); both arms + join 20 @493. Position re-swept from this
basin: join 19, textureOffsetV block end 41, `i = 0` 41.
**Named next angle:** place the fence so its `lw` MERGES with the reload retail
already has at `.L800BC974` (`lw t1,0x44(sp)` feeding `sll s1,t1,4` in the
Texture_ResetPaletteSharing jal delay slot) — that would buy the dial at zero net
insns. (My position probe could not reach it: the anchor text around
`Texture_ResetPaletteSharing()` is shared with the sibling functions in this TU.)

### 2.4 InGame_SetRamp — NEW PRICED ANGLE (the k axis of loop.c's threshold)
`threshold -= 3` after every accepted move (loop.c:1728/1913), so the &hoff pair is
declined iff `4*(T0 - 3k) < insn_count`, k = movables accepted BEFORE it. w45/w46
pushed `insn_count` (reached 67, never enough); w60 pushed the ORDER alone (k
unchanged, inert). **Nobody has pushed k.** With T0 ~= 28 and insn_count 58,
declining needs k >= 5 — two more accepted savings-2 movables than the three retail
keeps, ordered before &hoff. Candidate inflators: extra loop-invariant ADDRESS pairs
(each is savings 2 / life 2 by `force_movables`, so each is accepted and each decays
T by 3) whose hoisted result later dies. Cost warning: a surviving accepted movable
costs 2 preheader insns + a callee-saved reg. Not attempted (budget).

## 3. DEVICE-LAB CROSS-CHECK (A2's FOREIGN-OPERAND FENCE) — a BOUNDARY result

Requested mid-wave. Ran on both cario residuals.

* **Zero-insn claim CONFIRMED**: 1 and 3 fences beside the existing dial in
  ReadInCarTextureData keep the count at 492 (operands vx / vy / player). The
  "operand must be register-resident" gate also reproduces: `shpfile` costs one
  (493 @188). In CreateLicense, 1 and 3 fences at the 0x11800 block head keep
  229/229.
* **DIFF-INERT on both**: ReadInCarTextureData is EXACTLY 19 in every zero-insn
  configuration, and REPLACING the memory-operand dial with a foreign-operand fence
  measures 186 = the no-fence baseline. CreateLicense is EXACTLY 30 in every
  zero-insn configuration; one statement later (before the `->width` re-reads, or
  before the `CarIO_CopyFromShape` call) it costs an insn and regresses 41 / 63 @230
  (the reorg-barrier cost, not a dial).
* **Conclusion for the lab:** the 14C **spill-pool ref dial** and the A2 **live
  extender** are ORTHOGONAL instruments — what flips `order_regs_for_reload` here is
  the forced MEMORY REFERENCE (`hard_reg_n_uses`), not live length. Do not
  substitute one for the other. CreateLicense's residual is expand_call's
  precompute/luid identity (w53-a4), so a live-length instrument has nothing to bite
  on there either. Two clean negative witnesses for the live axis.

## 4. FILES TOUCHED / BACKUPS

`recon/game/common/r3dcar.cpp` · `recon/game/psx/psxcontroller.cpp` ·
`recon/game/psx/drawc.cpp` · `recon/game/psx/cario.cpp` (source + in-source
`MATCH:` receipts). No `tools/*.py`, no `build.py`, no memory dir, no user-live TU.
Backups: `scratchpad/w63a14/{r3dcar,drawc,psxcontroller}.cpp.base`,
`*.probebak` (written before every probe run).
Harnesses (all restore-on-finally): `probe.py` (str-pair patches), `probef.py`
(callable patches), `probe1.py` (single patch + context diff), `vctx.py` / `vpctx.py`
(verify_asm / vprobe with a `VA_CTX` context-diff mode), variant files
`v1-v4, d1, p1-p4, c1-c3, s1, s2, f1, f2`.

## 5. HAZARDS HIT

* **r3dcar.cpp had MIXED line endings** (2480 CRLF / 2849 LF). The Edit tool
  normalised the whole file to CRLF on first use. Codegen-neutral and git shows a
  clean 12/8-line diff; flagged because ASPSX wants CRLF anyway, but the byte-level
  churn is real — derive endings per anchor before any scripted patch here.
* Anchor uniqueness: `drawc.cpp` and `cario.cpp` both contain sibling functions
  with byte-identical statement runs; 4 probe rounds were lost to 2-match anchors.
  Always assert `count == 1`.
* `tools/vprobe.py`/`verify_asm.py` copied into a scratchpad need
  `sys.path.insert(0, ROOT/'tools')` and an absolute `ROOT` (they resolve `ROOT`
  from `__file__`).
