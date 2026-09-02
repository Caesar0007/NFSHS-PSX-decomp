# W85-S1 receipt — game/common AI cluster device clearance

Agent W85-S1.  Gate = `python tools/verify_asm.py`; whole-file sweeps via `tools/tugate.py`
(a thin wrapper that calls verify_asm's own `ours()`/`oracle()` — same normalizer, no
weaker survey heuristics).  No git, no edits to `tools/*.py`, no memory-file edits.
Backups of every as-found file: `scratchpad/w85/S1_backup/<name>.cpp`.

## 0. HEADLINE

| | before | after |
|---|---|---|
| gate (12 files) | 100% PASS | **100% PASS** |
| live device sites | 46 | **36** |
| register `asm("$N")` pins in the cluster | 3 | **0** |
| instruction-EMITTING `__asm__` blocks cleared | — | **2** (aih_opp) |

**10 devices removed, 0 added, 0 PASS lost.**  Every removal that could not be re-cracked
source-only was restored verbatim and is receipted below as KEEP-with-reason.

## 1. BASELINE (recorded BEFORE touching anything)

aih_cop 10/10 · aih_opp 6/6 · aiphysic 42/42 · aih_basicperp 9/9 · aih_btccop 40/40 ·
aih_btcperp 26/26 · aih_play 10/10 · aihigh 14/14 · aistate 52/52 · AIWORLD 22/22 ·
aitriger 10/10 · aispeeds 29/29 — all PASS.

Pre-check: none of these 12 files appears in any `PER_FN_*` table in `tools/build.py`
(no flag/version splices), so the default gate already IS the source-only gate.

## 2. CLEARED

### 2.1 aih_opp.cpp — `AIHigh_Opponent::CheckForWipeOut` — the 3 assigned pins + 2 emitting asm

REMOVED: `register int speedLimit asm("$5")`, `register int carIndex asm("$2")`,
`register int field1380 asm("$3")`, `__asm__("ori %0,%0,21844")`, and the 3-instruction
`__asm__("lw %0,1380(%2) / sll %1,%1,2 / addu %1,%1,%3")` block.  ADDED: nothing.
Final gate 6/6 PASS, 120/120 byte-exact.

Replacement (plain C):

```c
speedLimit = 0xd0000;
do { thisPlayerObj = Cars_gHumanRaceCarList[hLoop];
     speedLimit = speedLimit | 0x5554; } while (0);
int carIndex  = *(int *)((char *)thisPlayerObj + 596);
int field1380 = *(int *)((char *)thisPlayerObj + 1380);
int slotAddr;
do { slotAddr = (carIndex << 2) + (int)hlai; } while (0);
int absField = __builtin_abs(field1380);
AIHigh_Player *thisPlayer = *(AIHigh_Player **)slotAddr;
...
if (speedLimit < absField) {
```

Three independent mechanisms, each isolated by measurement:

* **SPLIT CONSTANT, not a pin.**  Retail materialises `0xD5554` as `lui a1,0xD` (in the
  `beqz` delay slot) + `ori a1,a1,0x5554` (in the `lw a0,0(a2)` load-delay slot).  Writing
  `0xd0000` then `| 0x5554` gives two independently schedulable insns; putting the OR
  inside the SAME pre-existing `do{}while(0)` as the list-element load keeps both in one
  basic block so the `ori` can reach that load's slot.  With the OR outside that block the
  `ori` sinks below the two field loads and a `nop` appears (5 diffs @121).
* **ADDRESS-IN-A-PHONY-LOOP = the deleted block's `"r"(hlai)` operand, in C.**  That
  operand was a +1 `REG_N_REFS` step (flow.c weights a ref by 1+loop_depth) lifting the
  `highLevelAIObjs` base allocno over `oppFines`/`oppLevel` into retail's `$t5`.  Wrapping
  only the ADDRESS arithmetic in a `do{}while(0)` reproduces it at zero insns.
  🔴 The DEREF must stay OUTSIDE: inside, the phony block ends before `lw v0,0(v0)` can be
  scheduled after the abs — exactly 2 diffs.
* **NAMED `absField`, computed after the address arithmetic and before the deref**, fixes
  the `$v0`/`$v1` ownership of the two field loads.

Ladder (each rung a real gate run; oracle 120 insns):

| variant | diffs |
|---|---|
| naive plain-C replacement of all 5 devices | 26 @120 |
| decl-order swaps / `hlai[carIndex]` / base-first `addu` / Yoda / ternary-abs / inline-abs-load | 26 (all inert) |
| named `absField` before the deref (**B**) | 16 |
| B + `hlai` decl moved below both fences (pure-source live trim 104→102) | 12 |
| B + drop the `hlai` local (loop.c hoist lane) | 12 |
| B + `"r"(hlai)` appended to the existing fence2 *(probe only, not kept)* | 6 |
| B + phony loop around the whole thisPlayer statement (**H1**) | 5 @**121** |
| H1 + OR inside the first phony loop (**K4**) | 2 @120 |
| K4 but only the ADDRESS in the phony loop (**L1**) | 2 @120 |
| **L1 + `absField` before the deref (L2)** | **PASS 120/120** |

Allocno evidence (`tools/fast.py` picture, `-dl/-dg` on the real CC1PLPSX): the band
residual was p132(hlai) refs 3 live 104 pri .0288 → `$t7` vs p84(oppFines) .0300 → `$t5`
and p83(oppLevel) .0291 → `$t6`; retail wants hlai first.  Moving the decl below the two
fences trims live 104→102 (.0294, beats oppLevel only); the ref step is what crosses
oppFines.  L2 supplies that step in C.

### 2.2 aih_cop.cpp — 2 fences cleared (10/10 PASS)

* **`__asm__("" : "=r"(co) : "0"(co))`** (the W72-A11 pointer opacity fence in
  `HighExecute`): **DEAD on today's body** — removed, TU re-gates 10/10 byte-identical.
  Its "38 → 26" receipt predates later edits to that block.  In-source note added.
* **`__asm__("" : "=r"(wrongWayHit) : "0"(wrongWayHit))`**: replaced by the SEMANTICALLY
  CORRECT source form.  Retail's `bnez rev; nor(delay); xori; .L: sltiu v0,v0,1; bnez` is
  gcc-2.8 lowering `dir == -1` (`nor` + `sltiu`) and `dir == 1` (`xori` + `sltiu`) in the
  two arms of the reverse-track select, with the shared `sltiu` CROSS-JUMP-MERGED into the
  join.  So the arms compute the wrong-way BOOLEAN directly instead of building an
  intermediate `rev` and testing it for zero:

  ```c
  int wrongWayHit;
  if (rev == 0) wrongWayHit = (dir == 1);
  else          wrongWayHit = (dir == -1);
  ```
  Control (old shape, fence dropped, plain temp): 3 diffs @1459 — ours folds the compare
  into the branch (`xori; beqz`) where retail materialises it.  New shape: PASS 1460/1460.

### 2.3 aih_basicperp.cpp — 2 fences cleared (9/9 PASS)

The two 11-operand zero-insn `__asm__("" : : "r"(this) x6 / x5)` ref-step fences in
`CheckChaserPosition`'s caught-distance block are **DEAD** — removed singly AND together,
the TU re-gates 9/9 byte-identical.  In-source note added.

### 2.4 aih_btccop.cpp — 1 fence cleared (40/40 PASS)

`__asm__("" : "+r"(initSliceCandidate))` in `SetupBlockader`'s **first** (`-1 < side`)
branch is **DEAD** (removed → 40/40 byte-identical).  Its twin in the `else` branch is
LIVE (20 diffs) and the `+r` fence on `slice` further down is LIVE (28 diffs); the stale
carrier comment was corrected to say so.

## 3. KEPT (probed, could not be re-cracked source-only, RESTORED VERBATIM)

| file / fn | device | cost of removal | fresh angles falsified this wave |
|---|---|---|---|
| aih_cop `HighExecute` | `static void *aihCopFlagsBoundary_ = &&aih_cop_flagsGuard;` | 10 @1460 | 5 label-planting C shapes all inert at 10: `do{}while(0)`, explicit `goto`/label pair, `for(;;){…break;}`, `while(1){…break;}`, `switch(0){default:}`; also a separate named `four` local for the second guard.  Mechanism confirmed: cse's AROUND path keeps the constant 4 in `$s2` alive into the second mode guard; only a *forced* CODE_LABEL ends the block. |
| aih_cop `HighExecute` | `*(AIHigh_Player *volatile *)&this->perpTarget_` | 12 @1456 (ours 4 insns SHORT — retail re-derives the whole `perpTarget_->carObj_->currentSpeed` chain) | byte-base cast on the second read; byte-base cast on the first read; `GetCarObj()` accessor on the first read — all inert at 12 (adds to the W71 falsification list, which already had identity-launder 65 / read-only fence 69 / block-scoped locals 69) |
| aih_cop `CheckForNewTriggers` | `*(copLevel_t * volatile *)&…chaseLevel_` **and** `*(volatile copType *)&this->type_` (one coupled pair) | 4 @202 either alone or both — a pure sched2 swap of `lw a1,156(s0)` vs `lw s2,132(s0)` | all 3 statement permutations of {pLevel, type, fRandomChance}; `fRandomChance` after `got`; a `newTriggerProb` inline accessor; dropping the `type` local entirely (SYM has no such local) and inlining `this->type_` at all 3 sites; `type` as a plain local.  All exactly 4. |
| aiphysic `CheckDesiredDirection` | `*(volatile int *)&AIPhysic_GameSetupWords[0]` + `__asm__("" : : "m"(…))` | fence alone 8 @18; both 13 @11 | the `"m"` fence is the only known ZERO-INSN way to keep the `%hi` base pseudo live at the dead `lw` (an `"r"` operand needs a pointer VALUE and costs an `addiu`).  W64-A12 certificate stands. |
| aiphysic `OutOfControlPhysics` | 3 address-materialisation `__asm__` blocks (`lui %hi` / `lw %lo` / `addiu %lo` of `AIPhysicConfig`) | 19 @413 | plain `cfg = &AIPhysicConfig; latvelcalcLookahead = AIPhysicConfig.latvelcalc_lookahead;` in 4 placements (early, late at retail's slot, after the store, via `cfg->`) — all 19.  Owner is the W74-A10 cse fold (the head ARG access leaves a full-address pseudo that cse resurrects as `cfg`), which no statement position reaches. |
| aiphysic `InControlPhysics` | `__asm__("" : : "r"(r), "r"(limit))` in `AIPHYSIC_KEEP_LAT_CLAMP` | **136 @533/557** | — (massively load-bearing across every clamp expansion) |
| aih_basicperp `CheckChaserPosition` | `__asm__ volatile(".word 0x1A000028 / nop")` | 2 @85/87 | the W76-A9 hand-inserted never-taken `blez $s0` (retail line 378, folded by cse's `record_jump_equiv` off the outer `if (0 < pos)` in every source spelling).  **This is the wave's most objectionable survivor** — an emitted instruction, not a fence.  Its axes were closed by a 26-flag cc1 sweep + 6 waves of spellings; the one untried angle it names (a zero-cost `X` in `if (X \|\| 0 < pos)` that plants a referenced CODE_LABEL) still has no zero-cost `X`.  Changing the OUTER guard's comparison code (e.g. `pos != 0`, which would NOT dominate the copied `blez`) is a NEW untried lens, but it changes the outer branch from `blez` to `bnez` and so cannot be byte-right on its own — it would need to be paired with something that restores `blez`. |
| aih_btccop | `"r"(addToSlice),"r"(startSlice)` fence (25) · `("" : : : "memory")` (12) · `"+r"(initSliceCandidate)` else-branch (20) · `"+r"(slice)` (28) | as listed | probed only (removal-cost measured); left verbatim |
| aih_btcperp `IsFalseArrest` | 3 × `__asm__("" : : "i"(0))` scheduling barriers | 3 each; all three 6 @134/157 | W54-A12 three-receipt seal; probed, restored |
| aih_btcperp `NewStage` | `("" : "=r"(placementSide) : "0"(placementSide))` | 24 | probed only |
| aih_play `AIHigh_Player::ctor` | `__asm__ __volatile__("" : : : "memory")` | 2 @129 (a `sw v1,4(a1)` / `addu v0,v1,zero` swap) | re-read of `pInfo->copGameInfo_` instead of the local (2); assignment-expression value `copy = (pInfo->copGameInfo_ = copGameInfo)` (2); fence-after-both (2); re-read with NO asm at all (17 @128) |
| aih_play | `"r"(requestSpikeBeltAtSlice)…` fence (52) · `("" : "=r"(copGameInfoCopy) : "0"(…))` (15) | as listed | probed only |
| aihigh `AIHigh_StartUp` | `__asm__("" : : "r"(copCarFlag), "r"(copCarFlag))` | 8 @234 | W62-A10 `floor_log2` REF-STEP dial (refs 4→8 flips `block_alloc`'s hand-rolled `case 3:` ladder).  A pure-C step needs 4 more loop-depth-weighted refs; nested `do{}while(0)` gets to 6 (already falsified as insufficient: "refs 6 → floor_log2 still 2") and deeper nesting would inflate the neighbouring pseudos.  KEPT. |
| aistate | `("" : "=r"(latBias)…)` (15) · `("" : : "i"(0))` (67) · `("" : : "r"(search))` (14) · `("" : "=r"(otherCarObj)…)` (2) · `("" : : "r"(carObj))` (16) · `("" : : "r"(inRange))` (18) | as listed | the 2-diff one (`CheckIfCarIsNearbyAndStop`) is the **reload_cse_regs** class — retail keeps `addu a1,s0,zero` in the first `jal` slot where gcc-2.8's `reload_cse_regs` deletes it because `$a1` still holds the incoming argument.  That is a compiler-identity question (catalog 29A-1 / W74 "the real 3.25-3b"), not a source shape; no per-fn splice is permitted this wave. |
| AIWORLD `CalculateDeltaRoadYaw` | `__asm__("" : : "i"(0))` | 16 | probed only |
| aitriger `CheckForTriggerAtSlice` | `*(volatile int *)lastTrigger` in the break test | 20 | plain deref and Yoda both regress; the volatile forces retail's fresh `lw v1,0(s1)` re-read (w55-a12 receipt confirmed) |
| aispeeds `BTCGetGlueFactor` | `("" : "=r"(closestHumanCarObj) : "0"(…))` | 2 @111 (cse rewrites `humanLoop = 0` into `addu s3,s4,zero`, a copy of the null-pointer register; retail rematerialises the zero) | `for (humanLoop = 0; …)` (2, inert); decl-init `int humanLoop = 0;` (2, inert); moving the null init inside the `if` (28, worse) |
| aispeeds `GetLegalSpeed` | `((volatile speedData_t *)speedData)->speedMPS` | 3 @16/17 | plain deref, named temp, index-term-first byte cast, `speedData[0].speedMPS`, `speedData -= 1` — ALL 3 @16.  This is catalog §B row 56's documented `p--; p->f` fold floor (gcc folds to `lhu -K(p)`, retail keeps `addiu p,-4; lhu 2(p)`). |

## 4. FINAL STATE

All 12 files re-gated after every edit and at the end:

aih_cop 10/10 · aih_opp 6/6 · aiphysic 42/42 · aih_basicperp 9/9 · aih_btccop 40/40 ·
aih_btcperp 26/26 · aih_play 10/10 · aihigh 14/14 · aistate 52/52 · AIWORLD 22/22 ·
aitriger 10/10 · aispeeds 29/29 — **all PASS**.

Every removal is documented in-source at its site (`W85-S1` tags) so the falsification is
not lost, and every stale "this device is required" comment for a removed device was
corrected.

## 5. NEW CATALOG ROWS EARNED

1. **§A/§F — PHONY-LOOP SCOPE IS THE DIAL, NOT THE STATEMENT.**  A `do{}while(0)` used as a
   zero-insn `REG_N_REFS` step must wrap ONLY the address arithmetic, never the dependent
   LOAD: the phony block boundary stops the load from being scheduled past a later insn
   (aih_opp: address-only PASS, whole-statement 2 diffs, and +1 insn if it also swallows
   the constant OR).  Corollary: an OR/AND that must land in a preceding load's delay slot
   has to share the SAME phony block as that load.
2. **§C — A SPLIT CONSTANT IS SOURCE-REACHABLE.**  `x = 0xd0000; … x |= 0x5554;` gives the
   two schedulable halves that a `register asm("$N")` pin + an `__asm__("ori")` were being
   used for.  Writing the value as one literal keeps gcc's `li` macro whole (77 diffs).
3. **§C — `x == 1` / `x == -1` are the `xori;sltiu` / `nor;sltiu` MATERIALISED BOOLEAN.**
   A two-arm select that assigns those comparisons tail-merges on the shared `sltiu`,
   which is what identity fences on a `(rev == 0)` temp were faking (aih_cop
   `HighExecute`).  Re-derive the comparison the two arms really make before reaching for
   an opacity fence.
4. **PROCESS — a "SYM-CODEGEN-CARRIER / DO NOT SIMPLIFY" fence receipt goes STALE.**  Two
   of the four devices cleared here (aih_cop `co`, aih_btccop first-branch
   `initSliceCandidate`) carried confident multi-wave receipts and were byte-inert on
   today's body.  Re-probe every fence in a TU that has been edited since its receipt was
   written; the probe is one gate run.
