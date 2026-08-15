# W64-A3 receipts — the libgpu vendor belt (`recon/syslib/psx/libgpu/SYS.c` + `FONT.c`)

Base `fbc974f7`. Gate = `tools/verify_asm.py` / `tools/tugate.py`; diff polarity `-` = ours,
`+` = oracle. Every variant ran through an ASSERTING prober
(`scratchpad/w64a3/probe.py`, `probe2.py`) that hard-fails on a missed anchor, so no reading
below can be a fake "inert". Syslib = Sony vendor-prebuilt ⇒ GATE-PARITY only (no psyqproof).

## 0. Ledger (every baseline re-gated by me first)

| fn | board row | my re-gated baseline | final | delta |
|---|---|---|---|---|
| **MoveImage** | 74.78% | **9** (ours 45 / oracle 46) | **PASS 46/46** | 🏆 SEALED |
| `PutDispEnv` | 98.99% | **38** (318/318) | 38 | — |
| `_drs` | 98.67% | **10** (160/160) | 10 | — |
| `_dws` | 98.94% | **8** (143/143) | 8 | — |
| `_gpu_que_drain` | 92.99% | **14** (152/152) | 14 | — |
| `_set_draw_mode` | 98.75% | **2** (8/8) | 2 (certificate re-verified) | — |
| `FntFlush` | 98.99% | **2** (199/199) | 2 | — |
| `FntPrint` | 99.31% | **PASS 240/240** (row STALE — the W63 TEXT_MOVES row is wired) | PASS | stale row |

`tugate recon/syslib/psx/libgpu/SYS.c`: **38/44 → 39/44**, run twice after every landing.
`FONT.c` 1/2 PASS unchanged. `tu_order_audit.py` clean for libgpu. Zero PASS→FAIL.
Both files stayed LF, 0 CR, 0 control bytes, non-ASCII count unchanged (SYS.c 70, FONT.c 0).

Commits (explicit paths only): `20e8d54b` · `8a1393d5` · `7d739e32` · `a6581016`.

---

## 1. 🏆 MoveImage 9 → PASS 46/46 — TWO landings, both mechanism-first

Five prior waves had this at 9 with a ~110-line falsification block whose standing verdict was
"a GLOBAL REGISTER ASSIGNMENT the anonymous mask temp owns; 06E gap". **That verdict was
wrong** — the register handout already matched retail exactly. The 9 was a CFG defect plus a
scheduler tie.

### 1a. Landing #1 (9 → 4, count EXACT 46/46): the opacity fence WAS the CFG

Ours was one insn SHORT: retail has `bnez $v0,BODY [slot: sll $v0,$s1,16]` + a live
`j EPI [slot: addiu $v0,$zero,-1]` block, ours has `beqz $v0,EPI [slot: li $v0,-1]` and no
block at all.

**Every guard SPELLING is inert** (measured: two separate `if`s / skip-goto / `!(a && b)` /
nested-if + goto body / both-guards-as-skip-gotos — all **9**). The `-dj` dump explains why:
at the `.jump` dump our RTL **already carries retail's exact CFG**
(`jump_insn 30 eq→39`, `jump_insn 36 ne→46`, `code_label 39`, `insn 42 v0=-1`,
`jump_insn 44 →100`, `barrier`, `code_label 46`) — jump.c's "conditional jump jumping over an
unconditional jump" transform (jump.c:1892-1901) already fired. The loss happens **inside
reorg**, so no front-end spelling can reach it.

**The mechanism (gcc-cited): `reorg.c:685-712 stop_search_p` returns 1 at ANY asm insn**
(`asm_noperands (PATTERN (insn)) >= 0`). Our opacity fence sat at the HEAD of the BODY thread
(RTL: `insn 105` = the payload anchor, then `insn 51` = the asm, then `insn 58` = the `sll`).
`fill_slots_from_thread` scans the target thread, cannot use the 2-insn anchor, hits the asm,
and stops — so guard2 gets no target-thread candidate, and reorg then inverts it and folds
retail's whole `li -1; j` block away.

**Cure: move the fence off the thread head** (after the dst-xy store). Statement order — and
therefore the whole register handout — is untouched, the anchor is still laundered, and reorg
gets its steal back. Measured, same basin:

| fence position | diffs |
|---|---|
| head of the body thread (before) | 9 (45 insns) |
| **after `p[1] = …` (dst-xy store)** | **4 (46/46)** |
| after `p[0] = …` | 28 (46) |
| after `p[2] = …` | 29 (47) |
| dropped entirely | 28 (46) |
| read-only fence after the stores | 28 (46) |

### 1b. Landing #2 (4 → PASS): a sched2 LUID tie, not coloring

Residual 4 = the `lui $a3 / lw $a3` (`GEnv_drv`) pair's position only. Retail emits the src
word load `lw $a1,0($s0)` and THEN the driver-table load, before `addiu $a2,$zero,0x14`; ours
emitted the table load after `lw $v0,4($s0)`. Both are loads of equal priority, so sched.c
breaks the tie on **LUID = RTL order = SOURCE order**. Naming the two values in retail's order
right after the anchor gives retail's order:

```c
p = &_move_prim[2];
srcxy = *(u_long *)rect;
drv   = GEnv_drv;
```

Measured ladder (all 46/46 unless noted):

| variant | diffs |
|---|---|
| nothing (landing #1 only) | 4 |
| `drv` alone, after the anchor | 2 |
| `drv` after p[0] / p[1] / the fence / p[2] | 4 each |
| `GpuTbl *drv = GEnv_drv;` decl-init at the top | 35 (49 insns) |
| named `dc` for `dma_chain` only | 14 |
| `srcxy` alone (no `drv`) | 4 |
| **`srcxy` then `drv`** | **PASS** |
| `drv` then `srcxy` (order is the dial) | 2 |
| `drv` + p[1]-store-before-p[0] | 24 |
| `drv` + read-only fence on `drv` | 9 / 45 insns ← an asm right after the anchor re-starves guard2, i.e. landing #1's law firing again |

Both locals are natural 1998 PsyQ spellings (a driver-table local + a source-word local).

---

## 2. `_gpu_que_drain` (14) — two more axes closed, no movement

Read off both streams: retail's three `_qout` reloads feed `.func`/`.arg`/`.extra`; ours feed
`.extra`/`.arg`/`.func`. That looks exactly like a read-order permutation, so all six were
measured — **falsified**:

| read order | diffs | | shape variant | diffs |
|---|---|---|---|---|
| func,arg,extra | 24 | | `func` local + args inlined | 24 |
| func,extra,arg | 16 | | `extra`/`arg` locals + `func` inlined | 14 (inert) |
| extra,func,arg | 16 | | decl-with-init form | 14 (inert) |
| arg,func,extra | 25 (151) | | `(*func)(arg, extra)` | 14 (inert) |
| arg,extra,func | 22 | | void fence before the `.func` read | 34 |
| decl func,arg,extra (read unchanged) | 14 | | void fence after the `.extra` read | 27 (153) |
| decl func,arg,extra + read func,arg,extra | 24 | | locals hoisted to fn scope | C89 error |

⇒ the reload→chain map is a **consequence** of the local-alloc handout, not of RTL emission
order. The class stands as the 06E gap. Receipted in-source.

## 3. `_dws` (8) / `_drs` (10) — the parm-order hypothesis, falsified as a cure

MoveImage's RTL taught me how the prologue is laid out: each callee-save `sw` is emitted
immediately before the parm copy that first uses that register, in PARAMETER order. So ours
must be emitting the `data` parm copy first because our `addu $s1,$a0,$zero` is the BODY
statement `saved = rect;` (the rect parm copy having been propagated away), not assign_parms'
own copy. Cure tried and **falsified**:

| variant | `_dws` | `_drs` |
|---|---|---|
| baseline | 8 (143/143) | 10 (160/160) |
| drop the `saved` alias, use `rect` | **38** | **42** |
| keep `saved`, one late `rect` use at the GP0 payload | 41 (144) | 45 (161) |
| `rect` at payload word 0 only | 51 (146) | — |
| `rect` for the clamps only | 41 (144) | 45 (161) |
| `saved` declared FIRST | 8 (inert) | 10 (inert) |
| read-only fence on `rect` at the top | 12 | — |

⇒ `saved` IS retail's shape; holding the parm pseudo live costs an insn. 06E gap confirmed.

## 4. `FntFlush` (2) — placement axis re-probed in THIS basin, mechanism sharpened

| variant | diffs |
|---|---|
| void-tail fence right after `dr = &fs->draw_mode;` | 2 (inert) |
| `dr` assigned just before the call | 2 (inert) |
| `TermPrim(dr)` hoisted above the whole field-load block | 27 (200) |
| identity launder on `dr` right before the call | 45 (200) |
| void-tail fence right before the call | 9 (198) |

**Mechanism (recorded in-source so the next belt does not restart from spellings):** the `dr`
pseudo is SPILLED, so its def emits an output reload into `$a2` plus the store, and
`choose_reload_regs` then satisfies the call-argument input reload by **INHERITING `$a2`**
(still validly containing the pseudo). Retail did not inherit ⇒ in retail `$a2` was invalid
there. Nothing in that block writes `$a2` (all eight following field loads are long-lived and
take callee-saved regs). **Named angle, precise:** manufacture a SHORT-LIVED value between the
spill and the call that the allocator must place in `$a2` (the 14C intruder-eviction device).
None exists in the source today; a hard-register clobber fence is pin-adjacent (user sign-off).

## 5. `_set_draw_mode` (2) and `PutDispEnv` (38) — certificates re-verified, not re-ground

* `_set_draw_mode` re-gated at 2 (8/8). The W61-A4 `set_preference` certificate (global.c:1584:
  op0 of the `ior` is the only operand given the dest's hard-reg preference; retail's `hi` must
  have CONFLICTED with `$v0`, and in an 8-insn leaf `$v0` is live only at the epilogue) is
  exactly the brief's "no third value to pin". No new mechanism found; per the brief I did not
  spend budget on spellings.
* `PutDispEnv` re-gated at 38, mismatch **positions** counted (19 positions × 2): 15 are the
  `hi`/command-constant `$v0`↔`$v1` swap plus the final-`or` operand order at sites 2 and 3,
  4 are the overscan `subu`/`addu` rotation. The W62 receipt's own measurement stands (every
  site-2 edit lands in the 134-148 basin; sites 2/3 are ONE joint problem). Budget went to the
  MoveImage seal and to the four falsification maps above.

## 6. CORPUS SWEEP (coordinator's mid-wave item) — libgpu MISS on all five new repos

Checked semantically, not by name-grep:

* **mgs_reversing** — no PsyQ source at all. `source/libdg/*` is Konami's own display library
  and `source/font/font.c` is MGS's font system; both `#include <libgpu.h>` and link the SDK.
  The `MoveImage`/`PutDispEnv` hits are CALL SITES.
* **TOMB5** — `EMULATOR/LIBGPU.C` is a PC re-implementation (VertexBuffer/TextureID/OpenGL),
  not Sony code. Zero codegen value.
* **VandalHearts-PcPort** — `platform/pc/src/libgpu.c` is an SDL2+OpenGL software rasteriser
  written from psx-spx; `vh/` is the game side. Same verdict.
* **KAIN2** — no `libgpu`/`psyq` paths at all.
* **xenogears-decomp** (coordinator's follow-up lead) — `src/slus_006.64/psyq/libgpu.c` is
  REAL Sony libgpu, but for this belt it is a **MISS**: `MoveImage` (line 306) and
  `PutDispEnv` (325) are `INCLUDE_ASM`, and `_dws`/`_drs`/`_exeque`/`_set_draw_mode` do not
  appear at all (their internal helpers are still `func_800xxxxx` placeholders). There is no
  `font.c` anywhere in the repo (`grep -rl 'FntFlush|FntPrint' src/` = 0 hits). Only the
  `SetDef*Env` builders and a handful of small publics are decompiled there.
  🔴 **AND THE REVISION PREMISE IS WRONG FOR NFS4:** xenogears `libetc/intr.c` is
  `$Id: intr.c,v **1.76** 1997/02/12`, but **NFS4's own intr.c is v1.75 1997/02/07**
  (`asm/data/rdata_80054548.rodata.s:4219`) — close, not identical. And xenogears' `libgpu.c`
  carries NO `$Id` line at all, so there is no revision evidence for its libgpu either way.
  (Worth passing to whoever owns `libetc/INTR.c`: our 1.75 vs xenogears 1.76 vs sotn 1.73.)

**$Id ladder for our two TUs (15F):** ours `sys.c,v 1.140 1998/01/12` (string at 0x80056CD8 in
`asm/data/rdata_80054548.rodata.s`); psyz `1.129 1996/12/25`; sotn `1.83 1995/05/25`. psyz is
the closest matched corpus by 11 revisions, sotn by 57 — and psyz leaves BOTH of this belt's
open library bodies (`_exeque` at `decomp/src/libgpu/sys.c:868`, `FntPrint` at `font.c:434`) as
`INCLUDE_ASM`. So for `_gpu_que_drain` and `FntPrint` **no matched body exists anywhere**.

---

## 7. Catalog-row candidates (orchestrator to harvest)

1. 🏆 **AN asm FENCE AT A BRANCH-TARGET THREAD HEAD STARVES reorg AND CHANGES THE CFG —
   fence POSITION is a CFG dial, not only a scheduling dial.** `reorg.c:685-712 stop_search_p`
   returns 1 at any asm, so `fill_slots_from_thread` cannot look past a fence sitting at the
   head of a conditional branch's target thread. With no candidate, reorg inverts the branch
   and `relax_delay_slots` folds the skipped block away — **ours comes out one insn SHORT with
   a different CFG**. SYMPTOM: ours shorter than the oracle by exactly the oracle's `j` (or its
   slot), the branch polarity flipped, and a whole `return K` block missing — in a function
   that contains a fence. TRIAGE: dump `-dj`; if the `.jump` RTL already carries the oracle's
   CFG, the loss is in reorg and **no guard spelling can help** (5 measured, all inert). CURE:
   relocate the fence one statement later so the thread head is fence-free. This retires the
   MoveImage "global register assignment / 06E" verdict that five waves had banked, and it
   generalises the 13B rule "a fence can only BLOCK slot theft, never SUPPLY the slot" — the
   blocked theft can cost you the whole basic-block structure, not just one slot.
2. **"OURS IS SHORTER" + the fn contains an asm ⇒ suspect row 1 BEFORE any allocator work.**
   A cheap tree-wide census: for every near-miss where `ours < oracle`, grep its recon fn for
   `__asm__` and check whether the fence precedes the first insn of a branch target.
3. **sched2's LUID tie-break IS a source dial for two equal-priority loads.** When the only
   residual is two loads emitted in the wrong order (same registers, same count), NAME both
   values in the oracle's order at the top of the block: `a = X; b = Y;`. MoveImage 4 → PASS.
   The ORDER is the dial (`drv` then `srcxy` = 2, `srcxy` then `drv` = PASS) and a decl-init
   (`T v = X;`) is NOT the same lever (35 vs PASS) — cf. 12D's decl-with-init demote.
4. **The prologue layout law, read off the RTL (useful for every parm-order residual):** each
   callee-save `sw` is emitted immediately before the parm copy that first uses that register,
   in PARAMETER order. So a `(save, copy)` pair that appears out of parameter order means that
   copy is NOT assign_parms' — it is a BODY statement, the parm copy having been propagated
   away. (The obvious cure — remove the body alias — is falsified on `_dws`/`_drs`: 38/42.)
5. **psyz's `libgpu/sys.c` leaves `_exeque` as INCLUDE_ASM** (`decomp/src/libgpu/sys.c:868`,
   inside their `#else __psyz` branch) — the same recording W63 made for `FntPrint`. Together
   with the five new corpora carrying no Sony libgpu at all, the libgpu corpus axis is CLOSED
   for `_gpu_que_drain` and `FntPrint`.

## 8. Hazards hit

* `verify_asm.py` takes a COMMA-separated symbol list, not argv-separated names — a
  space-separated call silently gates only the first symbol (it looked like the tool was
  ignoring the rest). Diff cap is `VA_MAX` (default 12), not a flag.
* `tools/ourdis.py` emits a `SyntaxWarning` on import (docstring escape) — cosmetic.
* SYS.c contains non-ASCII comment bytes, so a byte-mode patcher must decode UTF-8, not ASCII
  (an `ascii` decode aborts mid-landing). Both files are LF; `git add` warns about autocrlf —
  do NOT `git checkout` to "fix" it (W63 hazard, still true).
* `build/**` RTL dumps are another belt's leftovers; my `dump.py` writes to
  `scratchpad/w64a3/rtl/` instead (W63-A3's stale-dump hazard).

## 9. Files and artifacts

* Touched: `recon/syslib/psx/libgpu/SYS.c` (3 commits) and `FONT.c` (1 commit, comment-only).
* Backups: `scratchpad/w64a3/{SYS.c.bak0, SYS.c.bak1_mi4, SYS.c.bak2_mi_pass, FONT.c.bak0,
  FONT.c.bak1}` (fresh backup per landing, 15F).
* Tools left in `scratchpad/w64a3/`: `probe.py` (asserting multi-edit variant prober),
  `probe2.py` (same, uncapped diff via `VA_MAX`), `apply.py` (apply/restore one variant for
  objdump work, fresh backup per apply), **`dump.py` — RTL dump harness for the cc1_alt /
  cc1_272 lane** (replicates `_compile_c_272`'s exact command line, writes to a private dir;
  this is what produced the `.jump`/`.jump2`/`.dbr` evidence — **promotion candidate**, the
  existing `tools/rtl_dump_c.py` only drives the DEFAULT lane and cannot dump a `cc1_alt` TU),
  `land_mi.py` / `land_mi2.py` / `land_receipts.py` / `land_font.py`, and every measurement
  spec (`spec_mi_cfg.py`, `spec_mi_fence.py`, `spec_mi_drv.py`, `spec_mi_src.py`,
  `spec_qd.py`, `spec_qd2.py`, `spec_dws_parm.py`, `spec_dws_parm2.py`, `spec_ff.py`).
* No git operations outside my own two TUs; `tools/*.py`, maspsx, `build.py` and the memory dir
  untouched. No wiring requests this run (nothing needed one).
