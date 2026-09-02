# W86-D1 receipt — re-pricing W85's KEPT devices with the new levers

Gate (authoritative, whole-TU): `NFS4_SOURCE_ONLY=1 python tools/tugate.py <file>`
Focused read: `NFS4_SOURCE_ONLY=1 python tools/verify_asm.py <file> <fn>`
Probe driver (mine, scratchpad-only): `scratchpad/w86/D1_probe.py` — applies text edits,
gates, ALWAYS restores in a `finally:`. Backups: `scratchpad/w86/d1_bak/`.
No git, no `tools/*.py` / `regiondiff/tools/*.py` / memory edits.

## BASELINE (measured first, before any edit) — 2026-09-02

| TU | gate |
|---|---|
| eacpsxz/unref.c | 2/2 PASS |
| eacpsxz/resize.c | 1/1 PASS |
| eacpsxz/vramfxya.c | 3/3 PASS |
| eacpsxz/stream.c | 32/32 PASS |
| sndpsxz/salloc.c | 4/4 PASS |
| sndpsxz/sdmemman.c | 3/3 PASS |
| sndpsxz/sdresolv.c | 2/2 PASS |
| spchpsxz/spchevnt.c | 16/16 PASS |
| spchpsxz/spchpick.c | 27/27 PASS |

SKIPPED per the assignment (compiler-source impossibility proofs, 33A-4):
`sbdload.c:90` (void-tail fence = `stop_search_p` returns 1 only for SEQUENCE/ASM),
`sserver.c:296` + `ssysserv.c:42` (assign_parms `$a0` copy-preference + prune_preferences).

---

## 🏆 1. eacpsxz/unref.c `unrefpack` — the 122-diff 4-operand fence CLEARED, 2/2 PASS

`__asm__("" : : "r"(src), "r"(op), "r"(op), "r"(op))` **DELETED**; replaced by two
**zero-instruction pure-C identities**. Count stayed EXACT 158/158 in every row measured.

### Decomposition of the fence (new measurement — W85 only priced it whole at 122)

| fence form | diffs (all 158/158) |
|---|---|
| full 4-operand fence (W85 baseline) | **PASS** |
| drop the `src` operand (3 op refs only) | 78 |
| drop 1 op operand | 92 |
| drop 2 op operands / `src` only | 120 |
| fence removed entirely | 122 |

⇒ it is a pure allocno REF-COUNT ranking dial on `{op, src, out}`
(`priority = floor_log2(refs)*refs/live_length`; the in-file W80 note records retail's
`op p97 48/91 -> s1, src p84 65/151 -> s2, out p85 55/111 -> s3`).

### The two pure-C dials (33A-1 generalised)

1. **`op`: nested-AND self-absorption.** `len = (int)(op & 0x3f) + 4;` →
   `len = (int)(((((op & 0x3f) & op) & op) & op) & op) + 4;`
   Semantically identity (`op & 0x3f` ⊆ `op`). Each `& op` is real RTL that `fold()`
   cannot remove at tree level (variable operand), so **flow counts the refs**; `combine`
   then collapses the whole chain via `(and (and X Y) Y) -> (and X Y)` at **zero bytes**.
2. **`src`: pointer absorption law.** inserted where the fence stood:
   `src = (unsigned char *)((unsigned int)src | ((unsigned int)src & 3u));`
   `X | (X & K) == X`; combine folds it away. `src & (src | K)` measured identical.

### Grid (rows = appended `& op` terms, cols = nested src absorptions); every cell 158/158

|  | src0 | src1 | src2 | src3 |
|---|---|---|---|---|
| +1 | 122 | 120 | 120 | 120 |
| +2 | 78 | 92 | 92 | 92 |
| +3 | 78 | 92 | 92 | 92 |
| **+4** | 78 | **PASS** | **PASS** | **PASS** |
| +5 | 78 | PASS | PASS | PASS |

**LANDED: `+4` / `src1`.** Whole TU re-gated **2/2 PASS** (`chase` unchanged).
`grep` after comment-stripping: **0** `__asm__` / `register…asm` / `volatile` in code.

### FALSIFIED on the way (all count-exact 158/158 unless noted)

| angle | result |
|---|---|
| `hi &= op;` ×3 after the `hi` if/else + src fence | **1 diff @ 159/158** — register assignment retail-EXACT, but the chain collapses to ONE surviving `and v0,v0,s1`; ×4 also 159 |
| same, ×1 / ×2 | 121 @159 / 93 @159 |
| arm-duplication of `shifted = op >> 8;` into both `advanced` arms | 122 — **no ref gain**: identical arms are merged before flow, so cross-jump duplication is NOT a ref inflator at this site |
| arm-duplication of `src += reverse;` into both arms | 123 @ **159** (costs an insn) |
| moving `lo`/`len` into the duplicated `hi` arms (full fence kept) | 14 — cross-jump does merge, but it re-schedules the whole lo/len block |
| `reverse = (op & 3) & op;` (2-byte arm) | 122 — one extra read is not enough anywhere |
| `len` self-mask ×1 | 122 |

**Key law learned:** the seed matters. `hi &= op` costs one instruction because `hi`'s
defining expression ends in a *constant* mask, so combine cannot absorb the first `& op`.
Spelling the inflator **inside an existing `X & C` expression** (`(op & C) & op & …`) makes
every added term absorbable ⇒ genuinely zero bytes. This generalises 33A-1's
`v &= mask; v &= mask;` to the case where no variable-mask carrier already exists.

---

## 🏆 2. sndpsxz/salloc.c `iSNDfreechan` — the 81-diff scan fence CLEARED, 4/4 PASS

`__asm__("" : "=r"(scan) : "0"(scan))` (W85 cost **81**) **DELETED**, replaced by

```c
scan = (unsigned char *)((unsigned int)scan | ((unsigned int)scan & 3u));
```

**Mechanism (new, generalises 33A-2b to loop.c's biv scan).** The fence's job was to keep
`scan` opaque to loop.c so the address givs are not re-anchored onto the LAST access
(`scan+0x36`). The absorption identity is a *second SET of `scan` inside the loop*, so
loop.c's `basic_induction_var`/`n_times_set` test never classifies `scan` as a basic
induction variable — the same anti-anchor effect — and `combine` folds the identity away at
zero instructions (110/110 count-exact). Whole TU **4/4 PASS**.

### `salloc.c:624` `gv` split-address fence (cost 5) — **KEPT (restored)**

New falsifications this wave, all **FAIL 5 @ 109/110** (identical to fence-removed):
`gv | (gv & 3)`, `gv & (gv | 3)`, `gv | (gv & 0x44)`, `gv ^ (gv & 0)`.
**Why the new levers cannot reach it:** every pure-C identity is folded by `combine`, and by
then `gv` is a plain `SYMBOL_REF` again, so `mips_check_split` takes the `%lo(sndgs+0x44)`
fold. The residual is retail's DUPLICATED `addiu %lo(sndgs)` on both incoming paths + a
displacement `lw 0x44(v0)`. **Named next angle:** the §5.0c per-block rematerialization
lever (assign the base separately in each of the two predecessor blocks) — not expressible in
the current single-block C tail; it needs the tail restructured so each incoming arm has its
own address materialization. Not a scheduling/allocation question.

## 🏆 3. sndpsxz/sdresolv.c `iSNDplatformresolve` — identity fence CLEARED, 2/2 PASS

`cur = scan; __asm__("" : "=r"(cur) : "0"(cur));` → one statement:

```c
cur = (struct SNDResolveEntry *)((unsigned int)scan | ((unsigned int)scan & 3u));
```

W85's mechanism note said no C spelling avoids cse's `make_regs_eqv` copy-propagation because
`+0` / `&scan[0]` / casts / `x-x` all fold in `fold-const` before expand. The absorption
identity does **not** fold there (variable operand), so `cur`'s def is an `IOR`, not a register
copy — `cur` becomes its own qty and retail's `addu a0,v1,zero` survives; combine then folds
the identity at zero bytes. Measured: fence 2/2 | removed 1/2 (7 diffs @126/127) | this form
**2/2 PASS count-exact**. `&`-absorption `X & (X | 3)` equivalent. **0 `__asm__` left in code.**

## 🟡 4. eacpsxz/vramfxya.c — 9 fences → **4**, still 3/3 PASS

S7's pure-C basin REPRODUCED exactly: fences removed + `(h=3, ym=2, xm=2)` inflators = **2
diffs, 165/165**, and the 2 diffs are exactly S7's `li s4,-4096` position.

**Landed (PASS):** the FIVE `maskHi` read-only fences deleted, replaced by the self-absorbing
nested mask in the CLUT tail `c[3] = (c[3] & maskHi & maskHi & maskHi & maskHi) | clutYm;`.
Partial-substitution grid (count-EXACT 165/165 everywhere):

| kept fences | pure-C dial | result |
|---|---|---|
| 5 maskHi | clut xm2/ym2 | **PASS** (xm1/ym1 14, xm1/ym2 10, xm2/ym3 12, xm3/* 14-22) |
| 4 clut | maskHi h3/h4/h5 | **PASS** (h2 = 12) |
| none | h3 ym2 xm2 | 2 (S7's basin) |
| none | none | 16 |

⇒ EITHER group is removable, not both. Landed the bigger removal (5 of 9).

### The last 2 diffs — LICM-vs-sched2 deadlock, new falsifications

The 33A-2(b) shield DOES fire, but not for free:

| shield at the loop head, on top of the (3,2,2) basin | result |
|---|---|
| `maskLo & (maskLo | 3)`, `maskLo | (maskLo & 3)`, duplicate `maskLo = ~0xFFF;` | 2 (inert — **cse constant-propagates `maskLo` and folds the second set away BEFORE loop.c**, so `n_times_set` is back to 1) |
| same with a RUNTIME operand: `& (unsigned int)c` / `*c` | 53 @ **164** (shield fires, one insn SHORT) |
| … `& clutXm` / `& clutYm` / `& imgX` | 59 / 65 / 37, all @164 |
| both masks redefined in-loop (lo,hi) / (hi,lo) / + preheader defs dropped | 6 / 6 / 6 |
| preheader def order swapped (hi,lo) | 2 |
| in-loop `maskLo` redef deleted | 10 |

🔑 **New law worth banking: a shield built from an absorption identity is only a shield if its
extra operand is a RUNTIME value.** With constant operands cse folds it before loop.c ever
runs, and the construct is completely inert. (This is the discriminator that makes the salloc
`scan` shield work — `scan` is a runtime pointer — and the vramfxya `maskLo` one fail.)

**Named next angle (unchanged in kind, sharper now):** the shield's cost is that the whole
`li` disappears from the loop (164). What is needed is a shield that blocks `move_movables`
while KEEPING the in-loop set live, i.e. an in-loop `maskLo` set whose SOURCE is
loop-variant-looking to loop.c but constant-folding to `~0xFFF` only after `loop` — a
`cse_after_loop`-timed fold. Not attempted: needs an operand whose value cse2 (but not cse1)
can resolve.

---

## 🏆 5. spchpsxz/spchevnt.c `iSPCH_InitEventQueue` — 2 devices → **1**, 16/16 PASS

The **identity fence on `slot`** is now pure C: `slot = base;` → `slot = (base | (base & 3));`
Same REG_EQUIV mechanism as sdresolv: a plain copy of an ADDRESS carries a REG_EQUIV, so
`update_equiv_regs` rewrites it away and retail's `addu $a0,$a3,$zero` is lost; the IOR def
carries none, and combine folds it back to exactly that copy at zero bytes.

| form (oracle 29) | result |
|---|---|
| both fences (W85 baseline) | PASS 29 |
| **`addr` fence kept + `slot` absorption (LANDED)** | **PASS 29** |
| both absorbed (ior or and) | 35 @ 28 |
| `addr` fence absorbed 4 ways (`base = addr|(addr&3)`, `addr` dead-reassign, `addr` absorb-set, ior/and) | 29 @ 28 |

⇒ the `addr` USE fence (a liveness/ref dial, not a copy-shape dial) still has to stay: every
pure-C form leaves the function one instruction SHORT (28 vs 29).

## KEPT after re-pricing (restored byte-identical; verified with `cmp` against the pre-wave backup)

| site | device | new angles tried this wave | why the new levers cannot reach it |
|---|---|---|---|
| `eacpsxz/resize.c:115` resizememadr | `__asm__("" : : "r"(tail))` | `tail = tail\|(tail&3)` → **2** (== removed) | target pass is **sched1 priority** (33B-5): a combine-folded identity is gone before sched runs, and priority is a real-insn dependency depth. Only a barrier that survives to sched works. |
| `eacpsxz/stream.c:748` restartstream | `__asm__("" : : "r"(uVar3))` | `uVar3` absorption → **12** (worse than removed's 2) | sched2 ready-list tie; same pass-ordering reason |
| `eacpsxz/stream.c:1400` STREAM_cancelrequest | `__asm__("" : : "i"(0))` | removed = 2; no C statement survives to jump2 at zero bytes | jump.c edge-forwarding artifact (jump2, post-reload) |
| `eacpsxz/vramfxya.c` ×4 (clutXm/clutYm) | read-only fences | full pure-C basin = 2 diffs (see §4) | LICM-vs-sched2 `li s4` position |
| `eacpsxz/vramfxya.c` | `volatile unsigned int clut24tail` | not re-probed (W85: plain/array/removed all 4) | frame-slot pad |
| `sndpsxz/salloc.c:624` | `__asm__("" : "=r"(gv) : "0"(gv))` | 4 absorption spellings → **5** (== removed) | `mips_check_split` re-folds `%lo(sndgs+0x44)` once combine restores the SYMBOL_REF |
| `sndpsxz/sdmemman.c:851` | identity launder on `entry_off` | ior/and absorb (2 constants + `table` + `entry`) → **14** (WORSE than removed's 6); `entry_off = entry_off;` → 6 | target pass is **local-alloc `combine_regs`**, which runs AFTER combine has folded the identity away |
| `spchpsxz/spchevnt.c:373` | `__asm__("" : : "r"(addr))` | 4 spellings → 29 @28 | liveness/ref dial; every C form loses the 29th insn |
| `spchpsxz/spchevnt.c:599/602` SPCH_AddEvent | 2 fences | base absorb 17 @81, off absorb 3 @81, off dead-reassign 3 @81, split multiply 15*4 3 @81, both 20 @80 | copy-elimination after combine |
| `spchpsxz/spchpick.c:1147` | `*(volatile unsigned short *)sentence` | plain 3 @82, absorption of the read 3 @82 | sched2 barrier (post-combine) |
| `sndpsxz/sbdload.c:90`, `sserver.c:296`, `ssysserv.c:42` | — | **not probed** | 33A-4 closed classes (assignment says skip) |

---

# 🔑 THE ORGANISING LAW THIS WAVE ESTABLISHES

A pure-C zero-instruction device is **only** available for passes that run **at or before
`combine`**, because `combine` is what makes the construct free:

```
expand -> jump1 -> cse1 -> loop(LICM/biv) -> cse2 -> FLOW(REG_N_REFS) -> COMBINE -> regclass
       -> sched1 -> local-alloc(update_equiv_regs, combine_regs) -> global-alloc -> reload
       -> jump2(cross-jump) -> sched2 -> reorg(delay slots)
```

| dial you need | reachable in pure C? | construct |
|---|---|---|
| tree-level shape | ✅ | ordinary spelling |
| cse1 value-numbering / copy-prop (`make_regs_eqv`) | ✅ | **absorption identity** `X\|(X&K)` — variable operand, does not fold in `fold-const` |
| loop.c biv/movable classification | ✅ **but only with a RUNTIME operand** | absorption identity = a 2nd SET (`n_times_set != 1`); with a CONSTANT operand cse1 folds it first and it is inert |
| flow `REG_N_REFS` (allocno ranking) | ✅ | **self-absorbing nested mask** inside an existing `X & C`: `(op & C) & op & op …` |
| anything AFTER combine (regclass, sched1, local-alloc, global-alloc, reload, jump2, sched2, reorg) | ❌ | needs a construct combine cannot delete — i.e. an `__asm__` |

Corollaries proved here: (a) the inflator's SEED must already be an `X & <same var>` shape or
one instruction survives (unref `hi &= op` = 159/158); (b) arm-duplication is NOT a ref
inflator when both arms are identical (they merge before flow); (c) a dead local read is not
one either (flow deletes it before counting).

# FINAL STATE

| TU | gate before | gate after | code devices before | after |
|---|---|---|---|---|
| eacpsxz/unref.c | 2/2 | **2/2 PASS** | 1 | **0** |
| eacpsxz/vramfxya.c | 3/3 | **3/3 PASS** | 9 fences + 1 volatile | **4 fences + 1 volatile** |
| eacpsxz/resize.c | 1/1 | 1/1 PASS | 1 | 1 (restored, `cmp` identical) |
| eacpsxz/stream.c | 32/32 | 32/32 PASS | 2 | 2 (restored, `cmp` identical) |
| sndpsxz/salloc.c | 4/4 | **4/4 PASS** | 2 | **1** |
| sndpsxz/sdresolv.c | 2/2 | **2/2 PASS** | 1 | **0** |
| sndpsxz/sdmemman.c | 3/3 | 3/3 PASS | 1 | 1 (restored, `cmp` identical) |
| spchpsxz/spchevnt.c | 16/16 | **16/16 PASS** | 4 fences | **3 fences** |
| spchpsxz/spchpick.c | 27/27 | 27/27 PASS | 1 volatile | 1 (restored, `cmp` identical) |

**Devices net −9 (2 TUs now fully device-free). ZERO PASS→FAIL anywhere.**
Siblings re-gated unchanged: nsync 10/10, nfile 27/27, cdfs 14/14, sbdload 1/1, sserver 6/6,
ssysserv 3/3, spchrule 9/9, spchdata 8/8.
No git operations, no `tools/*.py` / `regiondiff/tools/*.py` / board / MANIFEST / memory edits.
