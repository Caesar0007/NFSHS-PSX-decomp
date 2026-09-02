# W84-C2 — MemCardGetDirentry (syslib/psx/libmcrd/LIBMCRD)

## 0. Setup (done)
- `scratchpad/w84/C2_verify.py` = copy of `tools/verify_asm.py` + THREE local edits
  (no tool under `tools/` was modified):
  1. `ROOT = Path(__file__).resolve().parents[2]` (script sits two levels deeper).
  2. `sys.path.insert(0, ROOT/'tools')` so `build.py`'s own `import fix_symsizes` resolves.
  3. **LANE ALIASING** (pattern = `regiondiff/tools/verify_region.py` ~L120-130): the
     candidate is copied to a temp file NEXT TO the base TU
     (`recon/syslib/psx/libmcrd/LIBMCRD__c2_gate.c`), every exact-rel-keyed module-level
     dict in `bld` carrying `recon/syslib/psx/libmcrd/LIBMCRD.c` is aliased onto the temp
     rel path, and the temp is unlinked after objdump. This gives the candidate the TU's
     real lanes (`CC1_LANE cc1_272`, the `-G0` syslib class rules, the `PER_FN_*` splices).
     The user-live base TU is never written.
- `scratchpad/w84/C2_LIBMCRD.c` = verbatim copy of the USER-LIVE
  `recon/syslib/psx/libmcrd/LIBMCRD.c` (uncommitted probes), taken 2026-09-02.

Gate command (all measurements below use it):
```
cd C:/Temp/nfs4-decomp
NFS4_SOURCE_ONLY=1 python scratchpad/w84/C2_verify.py scratchpad/w84/C2_LIBMCRD.c <FN[,FN...]>
```

## 1. BASELINE (user-live probe, unedited) — the board row is already 8 -> 6
```
MemCardGetDirentry: FAIL 6 diffs (ours 152 / oracle 152)   <-- count-EXACT
    -lw   a3,92(sp)     +lw   t0,92(sp)
    -beqz a3,T          +beqz t0,T
    -sw   s5,0(a3)      +sw   s5,0(t0)
```
Whole-TU control (same run): 24 of 26 LIBMCRD fns PASS.
`MemCardFormat: FAIL 4` (board says 1) — NOT my row; the user's live probe rewrote its
`_mc_present |= ...` into the `MemCardMakeDevname((...,chan), devname)` comma form. Flagged
for the orchestrator, untouched by me.

**The residual is now ONE cell and it is NOT the W74-certified rung floor.** The user's
live rewrite ALREADY landed the 4-aligned slot: the tail reload reads `92(sp)` = retail's
slot (W64-A4/W74-A15's `156(sp)` vs `92(sp)` class (a) is GONE, frame is retail's).
What is left is purely WHICH register the `files` pointer lands in for its 3-insn tail:
ours `$a3`, retail `$t0`. 3 insns x 2 sides = 6 diffs.

## 2. MECHANISM READ-OFF (new; the cell is now fully named)

`tools/qty272.py recon/syslib/psx/libmcrd/LIBMCRD.c MemCardGetDirentry --all`
(run READ-ONLY on the user-live file, which is byte-identical to the candidate):

```
LOCAL-ALLOC QTYS (block 20 = the tail block)
  86 refs2 live3 -> $a2 | 87 -> $a1 | 88 -> $a0 | 89 -> $v1 | 90 -> $v0   <-- d0..d4
GLOBAL ALLOCNOS
  rank 6  pseudo 85  refs 3  live 4  pri 7500  home $a3   conflicts: 80 85 2 3 4 5 6 29
SPILLED: [82, 121, 77]
```
* pseudo **85** = the tail `output` pointer. It is an ALLOCNO with a hard reg.
  Its only hard-reg conflicts are `2 3 4 5 6` (= the five `d0..d4` dummies) so
  global.c's ascending scan hands it **$a3 = 7**.
* pseudos **77 / 82 / 121** (= `max`, `command`, the movstrsi end pointer) are
  **SPILLED**; their uses are RELOADS, and they all take **$t0** — matching retail.

### 2a. THE DUMMY DIAL IS EXACTLY LINEAR (measured, whole-TU gated)
n `"=r"` dummies at the tail -> the tail pointer's register:
```
n=0 $v0 (17 diffs, 153 insns)   n=1 $v1 (6)   n=2 $a0 (6)   n=3 $a1 (6)
n=4 $a2 (6)   n=5 $a3 (6, SHIPPED)   n=6 $t0 -> 20 diffs
```
`register = 2 + n`. n=6 DOES put the tail pointer on `$t0`, but then the OTHER
three $t0 users move to `$t1` (20 diffs). **This is not a dial that can win.**

### 2b. WHY n=6 CANNOT WIN — the reload-ring proof (gcc-2.8.1 `reload1.c`
`order_regs_for_reload`, lines 3840-3953, read this wave)
`potential_reload_regs` is seeded with **every call-used hard reg whose
`hard_reg_n_uses == 0`, in ascending regno order**, and only then with the
used ones sorted by ascending use count:
```
  for (i = 0; i < FIRST_PSEUDO_REGISTER; i++)
    if (hard_reg_n_uses[i].uses == 0 && call_used_regs[i])
      potential_reload_regs[o++] = i;
```
and `hard_reg_n_uses[regno] += REG_N_REFS(pseudo)` for every pseudo allocated
to `regno`. So:
* today `$2..$7` carry allocnos/qtys and `$t0` has **uses == 0** -> `$t0` is the
  first spill reg -> the three reloads land on `$t0` (= retail).
* the moment ANY allocno is homed at `$t0` its `uses` becomes non-zero, `$t0`
  drops out of the zero-use prefix and `$t1` becomes the first spill reg -> the
  three reloads move to `$t1`. Measured exactly (n=6 = 20 diffs).

**=> AN ALLOCNO AT `$t0` AND RELOADS AT `$t0` ARE MUTUALLY EXCLUSIVE BY
CONSTRUCTION. Retail's `lw $t0,0x5C($sp)` is therefore NOT an allocno: it is a
RELOAD of a spilled pseudo, sharing the same ring slot as `max`/`command`/the
end pointer.** This retires the whole "dial the tail register" family (W74's
subtractive clobber ring AND its unclaimed "additive uses" angle: adding uses to
`$2` cannot help, because the target register must keep `uses == 0`).

## 3. BASIN S1 — the OTHER half of the cell, measured for the first time
Source: delete the `local` struct, keep `int result;` (address-taken -> slot 88),
let the PARAMETER `files` be the tail value (`output = files;`). No other change.
```
S1 (cc1_272 lane): FAIL 70 diffs (ours 152 / oracle 152)  -- COUNT-EXACT
  16  sw a3,96(sp)    vs retail  sw a3,92(sp)
 135  lw t0,96(sp)    vs retail  lw t0,92(sp)     <-- REGISTER IS RETAIL'S $t0
  frame 152 vs retail 144; every displacement >= 96 shifted +8 (that IS the 70).
```
So the two halves of the cell are each individually reachable and MUTUALLY
EXCLUSIVE on this rung:
| | slot | register | gate |
|---|---|---|---|
| shipped (expand-time local at 92) | **92 = retail** | `$a3` (allocno) | **6** |
| S1 (param spilled -> reload) | 96 (8-aligned) | **`$t0` = retail** | 70 |

### 3a. S1 IS AN INDEPENDENT EMPIRICAL CONFIRMATION OF THE W74/30E-1 CERTIFICATE
In S1 the expand-time locals end at **92** (devname@16+32, ent@48+40, result@88+4),
i.e. a 4-aligned slot at 92 was available and free. The lane's `alter_reg` put the
`files` spill at **96** anyway, and the second spill (movstrsi end pointer) at 104.
=> cc1_272's `alter_reg` really does pass `align == -1` (BIGGEST_ALIGNMENT = 8,
`CEIL_ROUND(size,8)` = 8 wide), exactly as 30E-1 states, now proven from a basin
that has nothing to do with the one the certificate was derived on.
Retail's map (files 4-wide @92, end pointer 8-wide @96, frame 144) is the
`inherent_size == total_size ? 0 : -1` behaviour of 2.8.x `alter_reg` (reload1.c
lines ~2499-2515).

## 4. FALSIFIED: THE PER-FN RETAIL RUNG SPLICE, ON *BOTH* BASINS (new measurement)
`NFS4_FORCE_CC1_ALT=<ver>` over the whole ladder (`C:/Temp/windows-gcc-psx` +
the retail PsyQ 4.4/4.5 `2.8.1-sn` CC1PSX). W74-A15 priced this on the OLD
(m-fence/param-home) basin only; both current basins are new:
```
rung            BASIN A (shipped, 6)      BASIN S1 (param spill, 70)
(TU lane 2.7.2)      6                         70
2.6.0               36                         92
2.6.3               36                         92
2.7.2-970404       121  (149 insns)           123  (149 insns)
2.7.2                6                         70
2.8.0              155  (151 insns)           157  (151 insns)
2.8.1              155  (151 insns)           156  (150 insns)
2.8.1-sn (retail)  155  (151 insns)           156  (150 insns)
2.91.66            151  (161)      2.95.2     178  (162)
```
=> the rungs that own the 4-aligned spill map (2.8.x, incl. Sony's own retail
2.8.1-sn) cost 150+ elsewhere on BOTH basins. The rung route is closed for this
function, now on the post-W76 source as well as the pre-W74 one.

## 5. SOURCE-SHAPE SWEEP ON THE SHIPPED BASIN (all whole-TU gated, all restored)
Every shape below reproduces the SAME 3-instruction residual (`$a3` vs `$t0`),
i.e. the residual is invariant to how the tail is spelled:

```
shipped  output = local.files; if (output) *output = stored;            6
T1       if (local.files) *local.files = stored;  (no `output` local)   6   (CSE folds the 2 reads)
T2       long **pp = &local.files; if (*pp) **pp = stored;              6
L1       label between the test and the store (defeat cross-block CSE)  6   (jump.c deletes the label)
L2       two block-scoped copies separated by a label                   6
L3       switch (local.files != 0) { case 1: ... }                      6
V1       `output = local.files;` HOISTED to the top (long live range)   69 @153, frame 152
S2       no struct + `(void)&files;` + no dummies                       19 @153
S3       no struct + `(void)&files;` + dummies                           8 (`sw a3,156` / `lw a3,156`)
S1/S4    no struct, param spilled                                       70 @152, frame 152
```

The dummy block is doing TWO jobs, not one: without it the basin also loses the
`s4`/`s5` init-emission order (T1b = 17 @153, tail `lw v0,92`).

## 6. VERDICT + THE NEXT NAMED ANGLE (no floors)

### 6a. The row is 6, not 8 (board update)
`MemCardGetDirentry` stands at **FAIL 6 @152/152** on the user's live basin, in
BOTH gate modes (`NFS4_SOURCE_ONLY=1` and wired). Whole-TU control, wired mode:
**24 / 26 PASS**; `MemCardFormat` 1 (its wired `-fno-delayed-branch` splice; it
reads 4 under `NFS4_SOURCE_ONLY=1` because SOURCE_ONLY clears that splice - NOT a
regression, and the user's new comma-form `MemCardMakeDevname((_mc_present |= ...,
chan), devname)` is diff-INERT there: 4 either way).

### 6b. THE CELL, RESTATED AS A TWO-WAY IMPOSSIBILITY (this wave's contribution)
Retail's tail is `lw $t0,0x5C($sp); nop; beqz $t0; addu $v0,0,0; sw $s5,0($t0)`.

* the register `$t0` requires the value to be a **RELOAD** (sec. 2b: any allocno
  homed at `$t0` moves the function's three real reloads to `$t1`; measured 20);
* a reload needs either a spill slot at 92 - **arithmetically impossible on this
  rung** (sec. 3a: `alter_reg` passes `align == -1`, 8-aligned / 8-wide) - or a
  `reg_equiv_memory_loc` pointing at the frame local at 92;
* `reg_equiv_memory_loc` for a frame local comes ONLY from `update_equiv_regs`
  (local-alloc.c:1064-1080 `MEM = REG`, and :1136-1141 `REG = MEM`), and BOTH
  clauses require `REG_BASIC_BLOCK (regno) >= 0` - a **single-basic-block**
  pseudo. The value is loaded, tested by a conditional branch, and used AFTER
  that branch, and `find_basic_blocks` starts a new block at the insn following
  any JUMP_INSN, so the pseudo is unavoidably multi-block. Verified empirically:
  L1 / L2 / L3 (labels, block scopes, switch) all fold back to the same pseudo.
* the only OTHER REG_EQUIV producer, `assign_parms` (function.c:4306-4348), is
  gated on `reg_mentioned_p (virtual_incoming_args_rtx, XEXP (stack_parm, 0))`,
  i.e. it can only ever name the **incoming arg slot** (156) - measured as S3's
  `sw a3,156(sp)` / `lw a3,156(sp)`, which is 8, worse than 6.

### 6c. WHAT IS RETIRED BY THIS
* W74-A15's unclaimed **"additive ring dial"** ("give `$2` more uses so
  `order_regs_for_reload` demotes it") - dead by construction: the target
  register must keep `hard_reg_n_uses == 0`, so nothing may be allocated to it.
* the whole **subtractive clobber / occupancy family** (W74's `"$2"`.. ring walk,
  and this wave's exact `register = 2 + n` dummy law) - it CAN put the value on
  `$t0` (n = 6) but only by breaking the three reloads (20 diffs).
* the **per-fn retail rung splice**, now falsified on the post-W76 basin AND on
  the S1 basin, including Sony's own retail `2.8.1-sn` CC1PSX (sec. 4).
* `alter_reg` **spill-slot sharing** (the briefing's named target): reload1.c
  :780 and :1007 call `alter_reg (i, -1)` for every pseudo that never held a
  hard register, and the `-1` path is documented in-source as *"No known place
  to spill from => no slot to reuse"*. Sharing (`spill_stack_slot[from_reg]`,
  :2521-2529) is reachable ONLY from `spill_hard_reg`'s `alter_reg (i, regno)`
  (:3728), i.e. only for a pseudo global.c DID home in a hard reg and reload then
  evicted. All three of this function's spilled pseudos (77 `max`, 82 `command`,
  121 the movstrsi end pointer) are never-allocated, so they take the
  `from_reg == -1` path and cannot share. **And sharing would not reproduce
  retail anyway**: retail's `files` (92) and end pointer (96) sit in DIFFERENT
  slots, so retail did not share either.

### 6d. THE NEXT ANGLE (unclaimed, precisely stated)
The residual is now a single compiler-identity question with a one-line
predicate: **does this TU's real compiler's `alter_reg` pass
`inherent_size == total_size ? 0 : -1` (4-aligned, 4-wide for a plain SImode
pseudo) rather than an unconditional `-1`?** Retail's frame map is exactly that
behaviour and nothing else explains it:

```
  16..47  devname[32] | 48..87 ent | 88..91 err (address-taken)
  92..95   files            <- 4 wide, 4-aligned  (inherent == total)
  96..103  movstrsi end ptr <- 8 wide, 8-aligned  (paradoxical ref -> align -1)
  104..143 s0-s7, fp, ra                             frame 144
```

BOTH slot widths in ONE function - that is the signature of the 2.8.x predicate,
not of a uniform 8-align. Every ladder rung that HAS that predicate costs 150+
here (sec. 4), so the open question is whether a **retail** compiler exists with
2.7.2-lineage codegen and the 2.8-lineage `alter_reg` gate. Concretely, the two
untried retail binaries are `C:/Temp/psq43/COMPILER/CC1PSX.EXE` and
`C:/Temp/psq44/pssn/bin/CC1PSX.EXE` driven through the **272 recipe** (macro cc1
+ direct GNU-as reorder mode, `-G0`) rather than through their own maspsx lane.
`NFS4_FORCE_CC1_ALT` only reaches the `windows-gcc-psx` ladder, so this needs a
`CC1_SPECIAL_RUNGS` entry in `tools/build.py` - orchestrator work, not mine.
If that predicate is not found in a retail binary, the 6 rows are a QUANTIFIED
RUNG FLOOR with the arithmetic proof above - the same certificate class as
W74's class (a), but 6 rows instead of 8 and derived twice independently.

## 7. STATE LEFT BEHIND
* `scratchpad/w84/C2_LIBMCRD.c` - byte-identical to the user-live
  `recon/syslib/psx/libmcrd/LIBMCRD.c` (verified with `diff -q`). Nothing beat
  its 6, so it is left in its best-gated state, unedited. The user-live file was
  never written to; the only file ever created under `recon/` was the gate's own
  temp sibling `LIBMCRD__c2_gate.c`, unlinked after every run (removed).
* `scratchpad/w84/C2_verify.py` (lane-aliasing gate copy; adds `C2_DUMP=1` for a
  side-by-side ours/oracle listing) and `scratchpad/w84/C2_probe.py` (A/B prober).
* No git operations; no edits under `tools/`, `regiondiff/tools/`, `configs/`,
  `src/`, `asm/`, `include/` or memory. No new `volatile` and no new `__asm__`
  were added by me; every device measured above is the user's own, and every
  probe edit was restored from a backup in a `finally:` block.

### Gate commands used (verbatim)
```
cd C:/Temp/nfs4-decomp
NFS4_SOURCE_ONLY=1 python scratchpad/w84/C2_verify.py scratchpad/w84/C2_LIBMCRD.c MemCardGetDirentry
NFS4_SOURCE_ONLY=1 C2_DUMP=1 python scratchpad/w84/C2_verify.py scratchpad/w84/C2_LIBMCRD.c MemCardGetDirentry
VA_MAX=0 python scratchpad/w84/C2_verify.py scratchpad/w84/C2_LIBMCRD.c <all 26 MemCard* fns>
NFS4_SOURCE_ONLY=1 NFS4_FORCE_CC1_ALT=<rung> python scratchpad/w84/C2_verify.py scratchpad/w84/C2_LIBMCRD.c MemCardGetDirentry
NFS4_SOURCE_ONLY=1 python tools/qty272.py recon/syslib/psx/libmcrd/LIBMCRD.c MemCardGetDirentry --all   (read-only)
```
