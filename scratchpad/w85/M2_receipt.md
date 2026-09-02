# W85-M2 — `recon/syslib/psx/libmcrd/LIBMCRD.c`

**Headline.**
* Whole-TU gate **unchanged end-to-end: 24 / 26 PASS**, `MemCardFormat` FAIL 1
  (36/35), `MemCardGetDirentry` FAIL 6 (152/152). **Zero regressions.**
* **2 devices DELETED** (both priced inert, landed): a dead `volatile` in
  `MemCardGetDirentry` and a dead read-only fence in `MemCardDeleteFile`.
* **Every one of the file's 69 device statements is now PRICED by deletion**
  (`scratchpad/w85/M2_devprice.txt`) — the classification is measured, not
  asserted.
* 🏆 **The 2 forbidden `register asm("$N")` PINS in `MemCardCreateFile` are now
  reachable pin-free at FAIL 2** (was: the only known pin-free cell was 4, W76).
  The whole cell — early arg materialisation, the `$at`-macro split into the
  `jal open` slot, and the retail `$v0/$v1` RMW colouring — is reproduced by
  pure identity fences; the sole residual is ONE adjacent sched swap
  (`li $v0,1` ↔ `lw $a2,12($s2)`).  Because it is not yet PASS, the pins are
  **RESTORED verbatim** per the wave's iron rule, and the cell is banked below
  as the named next angle.

Gate (authoritative, used for every number here):
```
cd C:/Temp/nfs4-decomp
python tools/verify_asm.py recon/syslib/psx/libmcrd/LIBMCRD.c "$(cat scratchpad/w84/C3_fns.txt)"
```
Diagnostic dbr-ON lane (drops the per-fn `-fno-delayed-branch` splice without
touching `tools/`): `NFS4_SOURCE_ONLY=1 python tools/verify_asm.py ...`.

Harness (all under `scratchpad/w85/`, nothing in `tools/` touched):
`M2_LIBMCRD.orig.c` (pristine copy), `M2_try.py` (apply substitution → gate →
restore), `M2_probe.py`, `M2_devprice.py` (+ `M2_devprice.txt`),
`M2_verify_dbron.py`, and the ~60 `<id>.py` / `<id>.c` probe pairs.

---

## 1. LANDED CHANGES (2 devices removed, gate identical)

| site | device | price of deletion | disposition |
|---|---|---|---|
| `MemCardGetDirentry` L1379 | `offset = *(volatile long *)&ofs;` | **INERT** (6 → 6; whole TU unchanged) | **DELETED** → `offset = ofs;` |
| `MemCardDeleteFile` L2236 | `__asm__("" : : "r"(retry));` | **INERT** (`MemCardDeleteFile` stays PASS 111/111) | **DELETED** |

`ofs` is a plain parameter, not IRQ/DMA-shared state, so the `volatile` had no
semantic content either — a pure crutch that had stopped paying.  Note the
asymmetry banked in-file: `MemCardCreateFile`'s structurally identical
`"r"(retry)` fence is **not** dead (deleting it costs 26 diffs).

## 2. DEVICE CLASSIFICATION — the whole file, priced by deletion

`python scratchpad/w85/M2_devprice.py` deletes each `__asm__` statement in turn
and re-gates its owning function; the volatiles were priced separately
whole-TU.  Full table in `M2_devprice.txt`.  Summary:

**CLEAR-list classes present in this TU** (per `scratchpad/w85/GUIDE.md`):

| class | count | verdict |
|---|---|---|
| `register T x asm("$N")` PINS | **2** (`MemCardCreateFile` L1867/L1868) | best pin-free cell = **FAIL 2** (§4) → RESTORED, KEEP-with-reason |
| identity fences `__asm__("" : "=r"(x) : "0"(x))` | 38 | all load-bearing (price 1 … 83 diffs) |
| read-only fences `__asm__("" : : "r"(x)…)` | 15 | 14 load-bearing (16 … 42), **1 dead → deleted** |
| zero-insn void-tail barriers `__asm__("" : : "i"(0))` | 12 | all load-bearing (`GetDirentry` ×10 = 16 diffs as a block AND individually; `Cmd_cb` 19, `CreateFile` 4, `Start_cb` 22) |
| `&&label` V2 devices | **0** | — |
| `volatile` on plain state | **1** → **deleted** | — |

**KEEP-list classes present:**

| site | why KEEP | measured price of removal |
|---|---|---|
| `MemCardStop` L360 `while (*(volatile int *)&mc.cmd != 0)` | `mc.cmd` is cleared ASYNCHRONOUSLY by the VSync pump (`MemCardStart_cb`) — without `volatile` the loop reads a stale register and can never exit (the w48-a1 runtime bug) | `MemCardStop` 8 diffs |
| `MemCardSyncAt` L1653/1654/1664/1665, `MemCardSync` L1747 (`mc.cmd`/`rslt`/`done`) | §3.12 #13 volatile state-block: the oracle really re-reads these each pass; they are mutated behind the compiler's back by the callback pump | 1653 → 1+1 diffs & −1 insn; 1654 → 1+1; 1664 → 3+3; 1665 → 5+5; 1747 → 4 |
| cop0 / GTE macro blocks, BIOS thunks, DMPSX templates, `.ASM` transcriptions | — | **none in this TU** (no `0x1F80` MMIO, no cop0/cop2 here) |

Every KEEP volatile removal also DROPS the instruction count (129 vs 130, 110
vs 111, 69 vs 71) — i.e. the oracle genuinely contains the extra loads the
`volatile` restores.  That is the GUIDE's "oracle PROVES re-read" test passing.

Device statement count: **69 → 68**; `volatile` lvalue sites 7 → 6.

---

## 3. `MemCardGetDirentry` — FAIL 6 @152/152 (unchanged; new falsifications)

The cell is exactly W84-C2's: retail `lw $t0,0x5C($sp)` / `beqz $t0` /
`sw $s5,0($t0)` vs ours on `$a3`.  W84-C2 proved the register `$t0` requires
the value to be a **RELOAD** (`order_regs_for_reload` seeds the ring with
call-used regs whose `hard_reg_n_uses == 0`, so an allocno at `$t0` evicts the
function's three real reloads to `$t1` — measured 20).  This wave attacked the
**other** half (make the tail value a reload whose memory is the frame local at
92) and closed it from the source side.

### 3a. Mechanism, re-derived from the 2.8.1 sources (fixes C2's open question)
* A pseudo becomes a reload-from-memory only via `reg_equiv_memory_loc`, set by
  `update_equiv_regs` (`local-alloc.c` ~1067 `MEM = REG`, ~1136 `REG = MEM`).
  **Both clauses require `REG_BASIC_BLOCK (regno) >= 0`** — the pseudo must live
  in ONE basic block.
* `flow.c:311-322`: *the insn following any JUMP_INSN starts a new block.*  The
  tail value is loaded, tested by a conditional branch, and used after it, so
  its pseudo is unavoidably multi-block. ⇒ **no equivalence is possible for a
  single tail pseudo, on any 2.7/2.8 rung.**
* `assign_parms` (`function.c:4313-4348`) can only ever name the **incoming arg
  slot** (`reg_mentioned_p (virtual_incoming_args_rtx, …)`) = 156, never a
  frame local at 92 — matching C2's S3 measurement (8 diffs, `lw a3,156(sp)`).
  The one path that DOES call `assign_stack_local` for a parm
  (`function.c:4379-4382`, align **0** = 4-wide/4-aligned!) is gated on
  `stack_parm == 0`, which on MIPS needs a mode conversion on entry
  (`nominal_mode != passed_mode`) — impossible for a `long *`.
* ⇒ the 92-slot value must be an **expand-time frame local** (which is exactly
  what our `local` struct already produces — the oracle's `sw $a3,0x5C($sp)`
  and frame 144 match ours instruction-for-instruction), and the tail read of
  it is unavoidably an ALLOCNO.  🔴 **New certificate row: the retail register
  and the retail slot are provably mutually exclusive on the source side, not
  merely unmeasured.**

### 3b. NEW falsifications (all whole-TU gated, all restored)
| id | shape | gate |
|---|---|---|
| gA | `if (local.files != 0) *local.files = stored;` (no `output` local) | 6 |
| gB | tail wrapped in `do { … } while (0)` (32B-1 LICM-shield lever) | 16 |
| gC | early-return `if (output == 0) return 0; *output = stored;` | 6 |
| gD | guard read made `volatile` (defeat CSE → two loads) | 9 @155 — **both loads are still ALLOCNOS** (`$a3`,`$v0`): `validate_equiv_mem` rejects a volatile MEM, so no equivalence is created |
| gE | store read made `volatile` | 9 @155 |
| gF | 3-field `local` (`files`/`files2`, two distinct 4-byte slots → two genuinely single-block pseudos) | 64 @156 — **still allocnos** (`$a3`,`$v0`), frame 152 |
* gF is the decisive one: even a **single-block, non-volatile frame read** takes
  a hard register when registers are free.  A `REG_EQUIV` only lowers the
  pseudo's priority (`REG_LIVE_LENGTH *= 2`, local-alloc.c) — it does not force
  a reload.  Forcing the denial requires exhausting the call-used file, which is
  precisely the dial W84-C2 proved cannot win (`register = 2 + n`; n=6 puts the
  tail on `$t0` but moves the three real reloads to `$t1`, 20 diffs).
* Per-device prices for this function (from §2): the 5 `"=r"` dummies are worth
  **17 @153**, the ten `"i"(0)` barriers **16**, the `mcp` identity fence **55**,
  `"r"(idx)/"r"(retry)` **42**, `"r"(dir)` **34**, `"r"(stored)` **30**,
  `"r"(chan)` **26** — no device here is removable.

**Verdict:** 6 stands, now with a source-side impossibility proof to go with
W84-C2's reload-ring proof.  The only surviving angle remains the compiler
identity (a rung whose `alter_reg` uses the 2.8 `inherent_size == total_size ? 0
: -1` predicate while keeping 2.7.2 codegen) — unchanged from C2 §6d, and every
rung on the ladder was already priced there at 36-155.

---

## 4. 🏆 `MemCardCreateFile` — the 2 PINS are pin-free-reachable at FAIL 2

`MemCardCreateFile` is **PASS today only via two `register asm("$N")` pins**
(L1867/L1868) plus a volatile wall.  W76 recorded the pin-free floor as 4.
This wave reduced it to **2**, and — more importantly — identified WHICH THREE
independent sub-cells the pins were doing the work of, and solved two of them
with plain identity fences.

### 4a. The mechanism (why the pins were needed)
Retail: `addiu $a0,$sp,0x10 ; addiu $a1,$zero,1 ; <RMW> ; lui $at ; jal open ;
sw $v1,%lo(_mc_present)($at)` — the args are materialised EARLY, the call's
delay slot is left EMPTY by cc1, and GNU-as (reorder mode) backward-fills it by
SPLITTING the `sw` macro (the 32A-3 `$at`-macro-split, done by the assembler
here because our lane assembles with GNU as, not ASPSX).
Ours: `reorg`'s `fill_simple_delay_slots` backward scan (reorg.c:3082-3126)
refuses the length-2 store macro, then refuses the whole `_mc_present` RMW chain
(it is self-blocking: each trial's `mark_referenced_resources` puts the next
one's destination into `needed`), and takes the **arg** `li $a1,1`.
`stop_search_p` (reorg.c) halts only at `CODE_LABEL / JUMP_INSN / BARRIER /
SEQUENCE / asm` — and `calls.c` emits the arg moves LAST, so **no C statement
can be placed between them and the call**.  The pins sidestep that by making
`$a0`/`$a1` HARD-REG SETS emitted at the DECL, i.e. above the wall.

### 4b. The pin-free cell (measured, `scratchpad/w85/{pL,f4,h1,j1,…}.c`)
```c
{
char *dn = devname;
long  m1 = 1;
__asm__("" : "=r"(dn) : "0"(dn));            /* coalesces to $a0, def at the decl */
__asm__("" : "=r"(m1) : "0"(m1));            /* coalesces to $a1, def at the decl */
__asm__ __volatile__("" : : "i"(0));         /* stop_search_p wall (unchanged) */
{ long c = base[3]; _mc_present |= 1 << c; __asm__("" : : "r"(c)); }
fd = open(dn, m1);
}
```
gate **FAIL 2 @130/130**; residual = ONE adjacent pair:
```
ours    … li a1,1 ; lw a2,12(s2) ; li v0,1 ; lui v1 ; lw v1 ; sllv v0,v0,a2 …
oracle  … li a1,1 ; li v0,1 ; lw a2,12(s2) ; lui v1 ; lw v1 ; sllv v0,v0,a2 …
```
Everything else is retail-exact: both args early, the `jal open` slot carrying
the gas-split `sw $v1,%lo(_mc_present)($at)`, and the whole `$v0/$v1` RMW
colouring.

**Three sub-cells, and what solves each:**
1. *arg position + empty call slot* — solved by the two **identity fences**
   (`"=r"(x) : "0"(x)`): they create a copy chain local-alloc coalesces into
   `$a0`/`$a1`, so the materialisation stays at the DECL, above the wall.  A
   **read-only** fence does NOT do this (pJ = 14: `li a1,1` is still emitted at
   the call and stolen) — the identity/copy form is the load-bearing part.
2. *`$v0`↔`$v1` RMW colouring* — the two new qtys (`dn`,`m1`, 4 refs each,
   pri 13333) are allocated before the RMW qtys and flip the tie.  Solved by
   naming **only the chan** and giving it one extra ref
   (`long c = base[3]; … __asm__("" : : "r"(c));`).  ⚠️ It must be `c` and only
   `c`: naming the constant (`long one = 1`) or the loaded `_mc_present`
   (`long cur = …`) flips it back or breaks the schedule.
3. *`li v0,1` vs `lw a2,12(s2)` sched order* — **unsolved**, and provably
   anti-correlated with (2) on every shape tried: the extra ref that fixes the
   colouring is exactly what pulls the chan load ahead of the constant.

### 4c. Falsification table (all whole-TU gated, all restored)
| id | shape | gate |
|---|---|---|
| pB | no device at all | 4 |
| pA | wall only, no pins | 4 |
| pC/pF/pH | wall + PLAIN `char *dn` (+`long m1`) | 14 |
| pD | plain `dn`/`m1`, no wall | 4 |
| pJ | wall + **read-only** fences on `dn`,`m1` | 14 |
| pK/pL/pO/pQ/qJ | **identity** fences on `dn`,`m1` (± wall, ± order, combined) | **12** (args + call slot now retail-exact; residual = the RMW colour swap) |
| r1…r7 | 7 RMW re-spellings (`= a\|b`, named `bit`, `(unsigned)1`, named `c`, named `cur`, operand order) on the pL head | 12 (all) |
| d1-d4 / e1-e4 | 1-4 zero-insn dummy qtys to shift the qty NUMBERING | 12 (inert — the flip is not a numbering tie) |
| o1/o5 | identity fences doubled/tripled on `dn`,`m1` | 12 |
| s1-s4 | extra fences on the `base` anchor | 12 / 43 |
| pU/pV | ref-bump the OR RESULT (`nv`) | 12 (inert) |
| pX/pY/qA-qD | ref-bump the `_mc_present` LOAD (`cur`) | **4** — colouring FIXED, but the load is pulled 2 slots early |
| pW/f1/f5 | ref-bump the SHIFT (`bit`) | 15 @131 |
| f2/f3/g1/g2/g3/g5/g6/i1/i2/i3 | ref-bump the CONSTANT (`one`), alone or with `c` | 12 |
| **f4/g4/h1-h4/j1/j2/j4/k2/k3/k4/n1/n2/n3/n5/n6/o4/u3/u4** | ref-bump the CHAN (`c`) — 18 spellings/placements | **2** |
| j3/u1 | IDENTITY fence on `c` instead of read-only | 12 |
| u2 | **volatile** read fence on `c` | 12 (the fence must be schedulable) |
| n4 | `(1 << c) \| _mc_present` (or-operand order) | 6 |
| qE/qF/qG | fences moved BELOW the RMW | 13 @129 |
| qH/qI | `"+r"` constraint | cc1 2.7.2 rejects `+` |

### 4d. Disposition + the named next angle
Per the wave's iron rule ("don't leave breaked PASS in FAIL states"), the pins
are **RESTORED verbatim**; the file ships exactly as before on this function.
The remaining question is now a single, cheap, falsifiable one:

> **make gcc-2.7.2's sched emit `li $v0,1` before `lw $a2,0xC($s2)` while the
> chan pseudo carries one extra (non-volatile, schedulable) reference.**

Both insns are ready simultaneously and independent; `rank_for_schedule` breaks
the tie by `INSN_PRIORITY` then `INSN_REG_WEIGHT` then `INSN_LUID`, and source
order does **not** reach it (h1's `1 << (c = base[3])` gives the constant the
lower LUID and still loses).  Anything that lands that one swap converts
`MemCardCreateFile` to a **pin-free PASS** and removes the last two
`register asm("$N")` pins from the syslib tree's libmcrd TU.

---

## 5. `MemCardFormat` — FAIL 1 @36/35 (unchanged) + a build-table finding

Sole diff `-nop`: retail fills the `bnez $v0` slot with `addiu $v0,$zero,1`;
ours leaves it empty.

🔴 **This row is owned by a build table, not by the source.**
`tools/build.py:1084` pins `MemCardFormat` to `-fno-delayed-branch`
(`PER_FN_FLAG_SPLICE_272`).  With reorg disabled the `bnez` slot can only be
filled by GNU-as, and gas will never move an insn that WRITES the register the
branch READS (`addiu $v0,…` under `bnez $v0`) into the slot.  ⇒ **on the wired
lane the residual is structurally unreachable from C, for any source shape.**
(`tools/*.py` is out of bounds this wave, so the splice stays; the dbr-ON lane
was measured only diagnostically, via `NFS4_SOURCE_ONLY=1`.)

New falsifications (`F1`…`F9`), both lanes:

| id | shape | wired (dbr OFF) | dbr ON |
|---|---|---|---|
| — | baseline (shipped) | **1 @36/35** | 4 @35/35 |
| F1/F3 | identity fence on a `char *dn = devname` (+/- wall), §4a recipe | 21 | 20 |
| F2 | + chan ref-bump (`long c = base->chan`, §4b) | 7 | 6 |
| F4/F5/F7/F9 | split RMW (`nv = _mc_present \| …;` … `_mc_present = nv;`) so the wall can sit between the arg and the store macro | 10 @37 | 10 @37 |
| F8 | wall moved below the store | 23 @38 | 22 @37 |

Why the §4 recipe does **not** transfer here: in `MemCardFormat` retail reuses
`$a1` for BOTH the chan load (`lw $a1,0xC($v1)`, inside the RMW) and the arg
(`addiu $a1,$sp,0x10`, after it).  Materialising `dn` in `$a1` at its DECL —
which is what makes the CreateFile cell work — makes `dn` live ACROSS the RMW
and forces chan off `$a1`, recolouring the head (20/21 diffs).  Splitting the
RMW to free the ordering costs +2 instructions on a count-exact 35.
⇒ the CreateFile lever is **structurally inapplicable** to this function; the
row remains what W84-C3 certified, plus the new build-table observation above.

---

## 6. State left behind

* `recon/syslib/psx/libmcrd/LIBMCRD.c` — **2 dead devices removed**, both
  documented in-file with their measured price; the two `register asm("$N")`
  pins and every load-bearing fence/volatile restored verbatim.  Final gate
  **24/26 PASS**, `MemCardFormat` 1, `MemCardGetDirentry` 6 — byte-identical to
  the wave-entry board row.
* No `git` operations.  No edits under `tools/`, `regiondiff/tools/`, `configs/`,
  `src/`, `asm/`, `include/`, or the memory dir.  No new `volatile`, no new
  `__asm__`, no post-compile instruction moves; every probe was applied to a
  copy and the pristine file restored in a `finally:` block.
* Artefacts: `scratchpad/w85/M2_LIBMCRD.orig.c`, `M2_try.py`, `M2_probe.py`,
  `M2_devprice.py` + `M2_devprice.txt` (the priced device inventory),
  `M2_verify_dbron.py`, and the probe `.py`/`.c` pairs named in the tables.
