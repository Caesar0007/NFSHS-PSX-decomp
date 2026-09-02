# W85-S10 receipt — VOLATILE audit of the game tree

Gate command for every number below (whole-TU, authoritative):

```
python tools/tugate.py <file>
```

## BASELINE (measured FIRST, before touching anything) — 2026-09-02

| file | gate |
|---|---|
| `recon/game/common/newton.cpp` | **32/32 PASS** |
| `recon/game/common/physics.cpp` | **22/22 PASS** |
| `recon/game/common/collide.cpp` | **14/14 PASS** |
| `recon/game/common/camera.cpp` | **38/38 PASS** |
| `recon/game/common/input.cpp` | **8/8 PASS** |
| `recon/game/common/cars.cpp` | **33/33 PASS** |
| `recon/game/common/bworld.cpp` | **21/21 PASS** |
| `recon/game/common/chunk.cpp` | **4/4 PASS** |
| `recon/game/common/r3dcar.cpp` | **27/27 PASS** |
| `recon/game/common/replay.cpp` | **16/16 PASS** |
| `recon/game/common/pausemenu.cpp` | **60/60 PASS** |
| `recon/game/common/sim.cpp` | **8/8 PASS** |
| `recon/game/psx/cario.cpp` | **11/11 PASS** |
| `recon/game/psx/sfx.cpp` | **7/7 PASS** |
| `recon/game/psx/overlays.cpp` | **5/5 PASS** |
| `recon/game/psx/psxcontroller.cpp` | **4/4 PASS** |
| `recon/game/psx/textureprocess.cpp` | **16/16 PASS** |

**Total 326/326 PASS.** Every assigned TU is fully sealed at baseline, so the IRON
RULE is the binding constraint: any device removal that cannot be re-cracked
source-only is RESTORED verbatim and receipted as KEEP-with-reason.

## DEVICE CENSUS (comment-masked; `scratchpad/w85/devcensus.py`)

### `volatile` in CODE (the named assignment) — 14 sites

| file:line | device | class |
|---|---|---|
| newton.cpp:1948 | `(nz2 = *(volatile int *)&normal.z)` in the DoPostBarrier dot | plain-state view |
| newton.cpp:2361 | `islandMatrix.m[6] = *(volatile int *)&barrierVec.x;` | plain-state view |
| newton.cpp:2362 | `islandMatrix.m[7] = *(volatile int *)&barrierVec.y;` | plain-state view |
| cars.cpp:1144 | `*(volatile int *)&point.y` (arg) | plain-state view |
| cars.cpp:1242 | `*(volatile int *)&point.y` (arg) | plain-state view |
| cars.cpp:1338 | `*(volatile int *)&point.y` (arg) | plain-state view |
| chunk.cpp:82 | `((volatile Trk_SimObject *)inst)[i].instIndex` | plain-state view |
| r3dcar.cpp:2894 | `*(volatile int *)&generic128HzClock + 6` | IRQ-clock candidate |
| pausemenu.cpp:465 | `*(volatile u_int *)&this->fFlags & 1` | plain-state view |
| pausemenu.cpp:472 | `*(volatile u_int *)&this->fFlags & 1` | plain-state view |
| pausemenu.cpp:663 | `*(volatile u_int *)&this->fFlags & 1` | plain-state view |
| sim.cpp:541 | `switch (*(volatile int *)&Replay_ReplayInterface.speed)` | plain-state view |
| camera.cpp:237 | `(*(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor)` | plain-state view |
| collide.cpp:1504 | `asm volatile("" : : "r"(rpx) : "a1")` | volatile fence |
| cario.cpp:387 | `__asm__ __volatile__("")` | volatile fence |
| textureprocess.cpp:473 | `__asm__ __volatile__("" : : "r"(k))` | volatile fence |

NOTE — `asm("<mangled name>")` on declarations (newton.cpp 43-79, newton.h 12-35,
overlays.cpp 23-24, newton.cpp 1239/1413 `static coorddef dummy asm("dummy.124")`)
are **symbol-name assignments, not register pins** — outside the CLEAR list
(the guide's CLEAR item is `register T x asm("$N")`). None present in this scope.

(sections appended per device below)

---

# PART 1 — VOLATILE AUDIT: RESULTS

## CLEARED (device removed, whole-TU gate held)

| file:line | device | replacement | gate after |
|---|---|---|---|
| cars.cpp:1144/1242/1338 | `*(volatile int *)&point.y` ×3 | plain `point.y` | **33/33 PASS** |
| pausemenu.cpp:465/472/663 | `*(volatile u_int *)&this->fFlags & 1` ×3 | `PMENU_ITEM_DISABLED(this)` = a 1-bit **bitfield view** `((tPMenuItemFlagBits *)&itm->fFlags)->fDisabled` | **60/60 PASS** |
| camera.cpp:237 | `(*(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor)->orientMat` | `Camera_gInfo[player].anchor->orientMat` | **38/38 PASS** |
| r3dcar.cpp:2894 | `*(volatile int *)&generic128HzClock + 6` (in-code cast) | moved to a **truthful declaration** `extern volatile int generic128HzClock;` in `r3dcar_externs.h` (0 in-code volatile left; same declaration `fe3dmenu_externs.h` already carries) | **27/27 PASS** |
| collide.cpp:1504 | `asm volatile("" : : "r"(rpx) : "a1")` | `__asm__(...)` — the `volatile` keyword is **redundant** on an output-less asm (gcc already treats it volatile); byte-neutral | **14/14 PASS** |
| cario.cpp:387 | `__asm__ __volatile__("")` | `__asm__("")` — same redundancy | **11/11 PASS** |
| textureprocess.cpp:473 | `__asm__ __volatile__("" : : "r"(k))` | `__asm__("" : : "r"(k))` — same redundancy | **16/16 PASS** |

**8 in-code `volatile` devices removed outright, 3 redundant `volatile` keywords
dropped, 1 relocated from a cast crutch to a truthful declaration. Zero
regressions — every TU still at its baseline PASS count.**

### The pausemenu crack (the one genuinely new lever)
The residual was **not** a re-read at all: ours emitted `lhu a2,0(this)`, retail
`lw a2,0(this)` + `andi a2,a2,1`. `fFlags` is `unsigned int` but the callee's
3rd parameter is `short disabled`, so combine's `gen_lowpart_for_combine`
(combine.c:8998) **narrows the non-volatile MEM to HImode**; `MEM_VOLATILE_P`
is one of only two things that stop it (the other is a mode-dependent address,
never true on MIPS). Reading the bit through a **1-bit bitfield view** is the
device-free cure — gcc-2.8.0 always reads a bitfield with a full WORD load, so
the narrowing never arises. Also measured device-free and PASSing: `fFlags % 2`
(60/60) and `fFlags & 1u ? 1 : 0` (60/60); the bitfield view was chosen as the
most faithful reading of a flags word. FALSIFIED (still 58/60): `(fFlags & 1) != 0`,
`(fFlags & 1U) != 0U`.

## KEPT (removal regresses AND the oracle proves the semantics)

| file:line | device | evidence it must stay |
|---|---|---|
| chunk.cpp:82 | `((volatile Trk_SimObject *)inst)[i].instIndex` | **Oracle proves a genuine RE-READ**: `lbu $v0,0x12($a1); nop; beq $v0,$t2,.L7; nop; lbu $v1,0x12($a1)` — retail loads the same byte TWICE. Removing it lets cse fold the 2nd load to `addu v1,v0,zero`, which reorg then steals into the branch delay slot (ours 328 vs oracle 329). This is the guide's own KEEP clause ("it breaks and the oracle shows real re-reads ⇒ semantic"). |
| sim.cpp:541 | `switch (*(volatile int *)&Replay_ReplayInterface.speed)` | Oracle re-loads `lw $v1,0x4($s4)` at `.L800B7138` after the `\|\|` chain already had speed in `$a0`; removal = 32 diffs **plus a whole `$s4`/`$s5` base rotation**. |
| newton.cpp:1948 | `(nz2 = *(volatile int *)&normal.z)` in the DoPostBarrier dot | removal = **67** diffs |
| newton.cpp:2361/2362 | `islandMatrix.m[6]/m[7] = *(volatile int *)&barrierVec.[xy]` | removal = **36** diffs; oracle reloads both from the frame (`lw t0,24(sp); lw t1,28(sp)`) |

## FALSIFIED ANGLES (each a real gate run this wave)

**chunk.cpp:82** (all leave the fn FAILing)
- byte-pointer 2nd read `*(u_char *)((char *)inst + i*20 + 18)` .......... 3 diffs
- separate byte-walker `u_char *instIdxByte = (u_char*)inst+18; instIdxByte[i*20]` ... **166** diffs
- *Compiler-source proof why these cannot work*: `canon_hash` (cse.c:1971) makes
  a MEM's hash depend only on its ADDRESS rtx — `MEM_IN_STRUCT_P` merely sets
  `hash_arg_in_struct`, it is NOT part of the hash, so no amount of re-spelling
  or re-typing the same address defeats the merge. Only `MEM_VOLATILE_P` sets
  `do_not_record`. ⇒ for a same-address re-read inside ONE cse basic block,
  volatile is the only C-level instrument.

**sim.cpp:541**
- plain `Replay_ReplayInterface.speed` ................................ 32 @319
- `((int *)&Replay_ReplayInterface)[1]` ............................... 32 (folds)
- `*(int *)((char *)&Replay_ReplayInterface + 4)` ..................... 32 (folds)
- swapped last `\|\|` arm operands + no volatile ....................... 28
- 4× nested `if (…) goto` guard chain + no volatile ................... 32
- swapped last `\|\|` arm operands *with* volatile (control) ........... 6 (regression)

**newton.cpp** (on top of the W72/W74/W76 falsification lists already in-file)
- `m[6]/m[7]` via a `const coorddef *bvp = &barrierVec;` pointer alias ... 27 (best non-volatile, still not 0)
- `m[6]/m[7]` via `*(int *)((char *)&barrierVec + 0/4)` ................ 36 (identical to plain)
- `nz2` via `((const coorddef *)&normal)->z` .......................... 67 (identical to plain)

## 🔑 NEW NAMED ANGLE for sim.cpp (rule 00b — not a floor)
The oracle's fresh `lw $v1,0x4($s4)` sits immediately after the CODE_LABEL
`.L800B7138` (the `bnez $a0` target from the last `||` arm). `cse_end_of_basic_block`
(cse.c) terminates a block at **any** CODE_LABEL — *unless* `-fcse-follow-jumps`
lets it walk THROUGH the branch, which it does only when
`LABEL_NUSES(JUMP_LABEL) == 1` **and the label is preceded by a BARRIER**.
Retail's label is preceded by a conditional `beqz` (fall-through ⇒ no barrier),
so retail's cse stops there and reloads. Our build must therefore be laying a
BARRIER before that label (an unconditional jump ending the preceding block),
which lets cse follow the jump and carry `$a0`'s equivalence in. **Next lever =
a block-LAYOUT change that makes the pre-switch block end in a conditional
fall-through rather than an unconditional jump** — i.e. an RTL-layout question
(jump.c/`cross_jump`), matching the in-file W62-A12 note ("the unexplored axis
is the LAYOUT pass, not the source"). Instrument: dump `-dj`/`-dJ` and check for
a BARRIER before the switch label.

---

# PART 2 — FENCE INERTNESS SWEEP (all `__asm__("")` devices in scope)

Method: `scratchpad/w85/fenceprobe.py FILE` deletes each code-level fence
*individually*, re-gates the WHOLE TU, and reports LOAD-BEARING / INERT. Every
fence in all 17 assigned TUs was probed (multi-line statements that the masker
mis-bounded were re-probed one line at a time with `/tmp/probe1.py`).

## INERT FENCES DELETED (16 devices, all gates held)

| file | lines | device |
|---|---|---|
| physics.cpp | 501 | `__asm__("" : : "r"(raw3), "r"(raw3));` |
| physics.cpp | 509 | `__asm__("" : : "r"(x1raw));` |
| physics.cpp | 521 | `__asm__("" : : "r"(velocityX), "r"(velocityX));` |
| physics.cpp | 530 | `__asm__("" : : "r"(centerZ), "r"(centerZ));` |
| physics.cpp | 1134 | `__asm__("" : : "r"(nextVelX));` |
| physics.cpp | 1435 | `__asm__("" : : "i"(0));` |
| physics.cpp | 1437 | `__asm__("" : : "i"(0));` |
| physics.cpp | 1602 | `__asm__("" : : "r"(diffFlywheelRpm), "r"(diffFlywheelRpm));` |
| physics.cpp | 1622 | `__asm__("" : : "i"(0));` |
| physics.cpp | 2788-2791 | `__asm__("" : : "r"(lookAhead) ×4);` |
| camera.cpp | 404 | `__asm__("" : : "i"(3));` |
| camera.cpp | 730-731 | `__asm__("" : : "r"(fallback) ×N);` |
| camera.cpp | 742 | `__asm__("" : "+r"(second));` |
| camera.cpp | 818 | `__asm__("" : : "r"(&Camera_gInfo[player]));` |
| collide.cpp | 2014-2016 | `__asm__("" : : "r"(newObj) ×N);` |
| r3dcar.cpp | 2769-2770 | `__asm__("" : : "r"(offset) ×N);` |

Gates after the bulk removal (all inert fences of a file dropped together, then
whole-TU re-gate): physics **22/22**, camera **38/38**, collide **14/14**,
r3dcar **27/27**. These 16 were pure residue from earlier waves' probing — they
had been left in place after the basin they were priced in moved on.

## LOAD-BEARING FENCES (probed, restored, cost recorded)

Files with **zero** inert fences (every device measured load-bearing):
chunk, bworld, sfx, psxcontroller, cario, textureprocess, sim, cars, pausemenu,
replay, newton, input, and the surviving physics/camera/collide/r3dcar fences.

Per-device removal cost (diffs, whole-TU re-gate):

| file:line | device | cost |
|---|---|---|
| replay.cpp:293/302/311/320 | `__asm__("" : "=r"(source) : "0"(source))` ×4 | 49 / 49 / 49 / 41 |
| replay.cpp:333 | `__asm__("" : : "r"(packedPtr))` | 4 |
| input.cpp:432 | `__asm__("" : : "r"(acc))` | **72** |
| input.cpp:433 | `__asm__("" : "+m"(r->flags))` | 4 |
| input.cpp:482 | `__asm__("" : : "i"(0))` | 2 |
| input.cpp:484-488 | `__asm__("" : "=r"(addressBlockerN))` ×5 | **105** each |
| input.cpp:496-500 | `__asm__("" : : "r"(addressBlockerN))` ×5 | 6 each |
| physics.cpp:1726 | `__asm__("" : "=r"(cmp) : "0"(cmp))` | 4 |
| physics.cpp:2630 | `__asm__("" : "=r"(lm) : "0"(lm) : "$2")` | 4 |
| newton.cpp:2788 / 2827 | `__asm__("" : "=r"(quadPt) : "0"(quadPt))` ×2 | 4 each |
| collide.cpp:1504 | `__asm__("" : : "r"(rpx) : "a1")` | 9 |
| cario.cpp:387 | `__asm__("")` | 2 |
| textureprocess.cpp:473 | `__asm__("" : : "r"(k))` | 12 |

## 🔑 NAMED ANGLE for input.cpp's 10-fence `addressBlocker` cluster (rule 00b)
The SYM block for `Input_Update__Fv` (`$8009c478 8c Function start`, fsize=184,
mask `$c0ff0000`) lists the complete fn-scope local set — `h`($18/s2),
`r`(AUTO -0x48), `acc`($21/s5), `menukeys`(AUTO -0x44), `i`($30/fp),
`j`($16/s0), `k`($4), `left`($17/s1), `right`($4), `iactive`(AUTO ARY CHAR[32]
@-0xa8) — and the interface-loop block (VA 8009d118..8009d19c) declares **NO
locals at all**. So `interfaceActive` and `addressBlocker1..5` are pure
inventions standing in for pressure the real declaration set should supply.
The recon already carries every SYM fn-scope name, so the missing pressure is
**STORAGE-SHAPE, not naming**: the SYM puts `active[17]` (block @line 51) and
`hactive[17]` (block @line 183) at the SAME AUTO offset `-0x88` — two
*block-scoped* arrays gcc overlapped — while the recon declares one FUNCTION-SCOPE
`hactive[17]` reached through an invented `activeBase` cursor. The prior wave's
falsification ("two separate `active[17]`/`hactive[17]` arrays = 855/868, 101
diffs") tried the two arrays but, per the in-file note, at FUNCTION scope. The
untried variant is **two arrays each in its own BLOCK scope matching the SYM's
`90 Block start line = 51` / `line = 183` boundaries**, so gcc's
`assign_stack_temp` overlaps them onto one slot exactly as retail's did — the
§3.12 #15 "declaration SCOPE is load-bearing" rule applied to arrays.

---

# END STATE

| file | baseline | after | devices cleared |
|---|---|---|---|
| newton.cpp | 32/32 | **32/32** | 0 (3 volatile KEPT, receipted) |
| physics.cpp | 22/22 | **22/22** | 10 fences |
| collide.cpp | 14/14 | **14/14** | 1 fence + 1 `volatile` keyword |
| camera.cpp | 38/38 | **38/38** | 1 volatile + 4 fences |
| input.cpp | 8/8 | **8/8** | 0 (all 13 load-bearing) |
| cars.cpp | 33/33 | **33/33** | 3 volatile |
| bworld.cpp | 21/21 | **21/21** | 0 |
| chunk.cpp | 4/4 | **4/4** | 0 (1 volatile KEPT — oracle-proven re-read) |
| r3dcar.cpp | 27/27 | **27/27** | 1 volatile cast (→ truthful decl) + 1 fence |
| replay.cpp | 16/16 | **16/16** | 0 |
| pausemenu.cpp | 60/60 | **60/60** | 3 volatile (→ bitfield view) |
| sim.cpp | 8/8 | **8/8** | 0 (1 volatile KEPT) |
| cario.cpp | 11/11 | **11/11** | 1 `volatile` keyword |
| sfx.cpp | 7/7 | **7/7** | 0 |
| overlays.cpp | 5/5 | **5/5** | 0 (only `asm("<symbol>")` renames) |
| psxcontroller.cpp | 4/4 | **4/4** | 0 — **the InGame seal is intact** |
| textureprocess.cpp | 16/16 | **16/16** | 1 `volatile` keyword |

**326/326 PASS at baseline → 326/326 PASS after. Zero regressions.**
**28 devices removed** (8 volatile views + 3 redundant `volatile` keywords +
1 volatile relocated to a truthful declaration + 16 inert fences).
**5 volatile views KEPT** with oracle/measurement evidence, each with the
falsified alternatives recorded above.

Cross-module check (gotcha #0): the only shared header touched is
`r3dcar_externs.h` (single includer, `recon/game/common/r3dcar.cpp`).
`python tools/bulkcompile.py recon/game/common` = **91/91 OK, 0 FAIL**;
`recon/game/psx` = **32/32 OK, 0 FAIL**.

Tools left in `scratchpad/w85/` for the rest of the wave:
`devcensus.py` (comment-masked device census), `try.py` (one swap + gate + revert),
`sweep.py` (N variants + gate + revert), `fenceprobe.py` (per-fence inertness).
