# W60-A3 receipts — `recon/syslib/psx/libgpu/SYS.c`

Base commit `502c208d`. Gate = `tools/verify_asm.py` / `tools/tugate.py`, rebuilt
(`build.py --skip-asm`) and run TWICE around every landing. Diff polarity `-`=ours `+`=oracle.

## 0. Baseline (re-gated myself, not taken from the briefing)

`34/44 PASS`, FAIL set + diff counts:

| fn | diffs | ours/oracle |
|---|---|---|
| DrawOTag | 2 | 28/28 |
| _BlitClear | 2 | 140/140 |
| _clearOTagR_dma | 2 | 56/56 |
| _set_draw_mode | 2 | 8/8 |
| MoveImage | 9 | 45/46 |
| _dws | 11 | 142/143 |
| _drs | 13 | 159/160 |
| _gpu_init_videomode | 14 | 38/40 |
| _gpu_que_drain | 14 | 152/152 |
| PutDispEnv | 54 | 318/318 |

Briefing percentages were stale in the usual way; the counts above are the numbers I worked from.

## 1. LANDED — the 37 function-ORDER inversions (commit `5e543be0`)

Worst object-level inversion count in the tree. Mechanical reorder,
`scratchpad/w60a3/reorder.py`:

* all non-function file-scope text keeps its original **relative** order and now precedes
  every body;
* a forward-declaration block (each prototype byte-identical to its definition's own
  signature) inserted immediately before `static const GpuTbl _gpu_tbl` — that initializer
  names 15 of the functions, so the prototypes must precede it (my first attempt put the
  block after the skeleton and cc1 rejected it: "initializer element for `_gpu_tbl.get_status`
  is not constant");
* the 44 definitions follow in retail VA order.

**Codegen-neutral by construction.** I audited the pre-edit file for genuine
use-before-declaration calls first: there are **zero** — the "sub-group" layout had already
been arranged so every callee preceded its caller (all apparent hits were comment
references). So every added prototype duplicates a declaration already in scope at every
call site, and no call site's prototype changed.

* GATE: 34/44 PASS before **and** after, identical FAIL set, identical diff counts. Zero
  PASS→FAIL. `tu_order_audit.py` on `libgpu/SYS` now SILENT; tree 158 → 121 inversions.
* Receipted side effect: `.rodata` OFFSETS shift (the bodies' string literals now follow the
  named tables). Relative order among the named data objects is preserved and the gate is
  reloc-normalized. Not a new fidelity loss — this TU's section mapping already diverges from
  retail (`static const _gpu_tbl` lands in `.rodata` where retail keeps it in `.data`
  @0x80123654). Data order is not covered by `tu_order_audit.py`.

## 2. THE HEADLINE — three "floors" fall to a per-FUNCTION 2.7.2 splice

The W56 receipt in-source concluded *"the 2.7.2 rung is unreachable for this TU: the pre-2.8
cc1s reject `-mno-split-addresses` outright, so the SYS ladder is only {2.8.0, 2.8.1, 2.91.66,
2.95.2}"*. **That is wrong.** `-mno-split-addresses` is a WHOLE-TU wiring, not a property of
the rung — a per-FUNCTION splice can compile just one region with 2.7.2 and without the flag.

Probe driver `scratchpad/w60a3/probe_272.py`: compiles build.py's own `SYS.c.i` with
`gcc-2.7.2-psx/cc1.exe` under the 272 recipe MINUS `-mno-split-addresses`, applies build.py's
`move`→`addu` rewrite, splices only the named `.ent/.end` regions into the wired `.s`,
assembles with build.py's exact `as` line, and byte-diffs vs the oracle separating the
reloc/branch-target class (which verify_asm normalizes) from real word diffs.

| fn | now | 2.7.2 per-fn splice | verdict |
|---|---|---|---|
| **DrawOTag** | 2 | 28/28, **REAL=0** (8 reloc) | **PASS** |
| **_set_draw_mode** | 2 | 8/8, **REAL=0** (1 reloc) | **PASS** |
| **_gpu_init_videomode** | 14 | 40/40, **REAL=0** (12 reloc) | **PASS** |
| _clearOTagR_dma | 2 | 56/56, REAL=13 | worse |
| _gpu_que_drain | 14 | 152/152, REAL=17 | ~same/worse |
| MoveImage | 9 | 45/46, REAL=18 | worse |
| _dws | 11 | 140/143, REAL=122 | far worse |
| _drs | 13 | 159/160, REAL=124 | far worse |
| _BlitClear | 2 | 146/140, REAL=113 | far worse |
| PutDispEnv | 54 | 326/318, REAL=296 | far worse |

All three winners come from **unchanged source**. What they were previously filed as:

* **DrawOTag** — "cse constant-sharing, same class as the documented commutative-operand
  floors; not source-reachable" (correct that it is not source-reachable; wrong that it is a
  floor — it is the 04M/11B *compiler-version* axis, cse.c).
* **_set_draw_mode** — w59-a8 filed "operand order and the register map are COUPLED here, so no
  spelling reaches retail's `or $v0,$v1,$v0`". True — they are coupled to the COMPILER. 2.7.2
  emits retail's operand order from this exact source.
* **_gpu_init_videomode** — filed as a `-fno-delayed-branch` / return-duplication mechanism
  (and that splice was measured INERT in w55). It is neither: I read `reorg.c:4289
  make_return_insns` (gated 4586) and it only converts jumps to `end_of_function_label` whose
  slot is already FILLED, so retail's surviving `j <tail>` pair means retail's **jump.c** never
  redirected those arms into returns at all. 2.7.2 confirms it: 40/40, REAL=0.

### Wiring spec (orchestrator — I cannot edit `tools/*.py`)

```python
PER_FN_CC1_VER_SPLICE_272["recon/syslib/psx/libgpu/SYS.c"] = {
    "2.8.0": {"_BlitClear"},                                   # existing, keep
    "2.7.2": {"DrawOTag", "_set_draw_mode", "_gpu_init_videomode"},   # W60-A3
}
```

**One mechanism change is required**: the splice compile must DROP any flag the chosen rung
rejects (`-mno-split-addresses` for every pre-2.8 cc1 — it exits with "Invalid option", which
today kills the whole TU compile). Everything else in `_apply_cc1_ver_splice_272` already does
what the probe does. This also generalises: 11G already noted "sub-2.8 rungs REJECT
-mno-split-addresses => nosplit TUs have 4-rung ladders" — with flag-dropping those TUs get the
full 8-rung ladder back at per-function granularity.

## 3. TWO MORE — probe-verified `PER_FN_TEXT_MOVES` specs

`scratchpad/w60a3/probe_moves.py` replicates `_apply_text_moves` **verbatim** (same take/after/
copy/slot/drop_nop semantics), then assembles with build.py's `as` line. Both reach REAL=0.

### `_BlitClear` 2 → PASS (140/140)

cc1 emits `jal; lw $31; lw $18; lw $17; lw $16; addu $2,$0,$0`; retail puts the result copy
BEFORE the reload chain. The `jal`'s slot is already taken by the `la` split, so the relocated
line lands at the oracle's index 133 with no slot wrapper.

```python
"_BlitClear": [
    {"take":  r"\taddu\t\$2,\$0,\$0\n(?=\t\.set\tnoreorder)",
     "after": r"\tjal\t_gpu_dma_chain\n"},
],
```

### `_clearOTagR_dma` 2 → PASS (56/56)

**Both** of retail's slot insns WRITE `$v0` while their branches READ `$v0`, so per 09L gcc
reorg can NEVER place either — the shape is the assembler's. Retail COPIED the merge-point
`addu $v0,$s0,$zero` into the pre-loop `beqz` slot (idempotent on both paths, same `$s0`) and
MOVED it into the loop-back `bnez` slot. Same COPY class as the W59
AIPhysic_CalcAcceleration row.

```python
"_clearOTagR_dma": [
    {"take":  r"\taddu\t\$2,\$16,\$0\n(?=\$L\d+:\n\tlw\t\$31,24)",
     "after": r"\tbeq\t\$2,\$0,\$L\d+\n", "copy": True},
    {"take":  r"\taddu\t\$2,\$16,\$0\n(?=\$L\d+:\n\tlw\t\$31,24)",
     "after": r"\tand\t\$2,\$2,\$17\n\tbne\t\$2,\$0,\$L\d+\n", "slot": True},
],
```

Move 1 needs no slot wrapper (the `beq` already sits in cc1's own noreorder/nomacro block, so
the inserted line becomes its slot and the old slot `li $17` follows). Move 2 needs `slot` so
gas stops materializing its nop. Both take the SAME line; the lookahead is what keeps move 2
off move 1's copy. **Anchors are deliberately label-agnostic** — `$L` numbers renumbered in my
VA-order reorder, so a literal `$L<n>` (w60-a8's law) would silently no-op.

Note `_BlitClear` must KEEP its existing 2.8.0 version splice; the moves apply to the spliced
region (`_apply_text_moves` runs last, on the final `.s`).

## 4. MoveImage — the 46/46 basin re-walked, DIAGNOSED, then unwound

The in-source W59-A8 note offered a "named angle": edits (1) hoist `dstxy` to its own statement
and (2) store `p[1]` before `p[0]` give retail's CFG and 46/46 at 14 diffs. Re-applied and
confirmed: **14 diffs, 46/46, correct branch polarity, correct block set.** Then UNWOUND per
AGENT_GUIDE rule 9 — 14 never beat the authoritative 9. Tree is back at the 9-diff form and
re-gated.

What I added is the **diagnosis**: retail emits the payload ANCHOR (`la $v1,_move_prim+8`)
BEFORE the `andi`, so `$v1` is taken and the x-mask temp falls to `$a0` and the src word to
`$a1`; ours emits `andi` FIRST into the still-free `$v1`, then overwrites `$v1` with the
anchor, which frees `$v0` to double as the src scratch. One emission-order decision produces
the whole 3-register rotation.

New falsifications (all gate-measured in the 14 basin, all reverted):

| attempt | result |
|---|---|
| anchor assigned before `dstxy`, opacity fence left in place | 14 (inert — the FENCE, not the assignment, pins where the address materializes) |
| `dstxy` SPLIT across the anchor (`= y<<16` head, `\|= x&0xffff` after the fence — textually retail's own order) | 14 (sched2 re-merges the halves above the anchor) |
| that split + `__asm__ __volatile__` fence flavour (hard barrier) | 28 |
| named `xm` local for the mask | 22 (fresh pseudo re-colors the head) |
| read-only fence on `*(u_long *)rect` to force the early src load | 16 **and +2 insns** (48/46) — a multi-operand pointer fence is not zero-insn |
| dropping the opacity fence entirely (its rationale was written for the retired 272 lane) | 16 |
| anchor-first with the fence moved up too (the w51 "anchor-assigned-first" shape) | 33 — loses reorg's `sll` steal, CFG regresses |

**NEXT ANGLE (named, untried):** anchor-vs-andi emission order is a sched2/local-alloc question
inside ONE basic block = precisely the 06E qtytrace gap. Do not spend more spelling budget.

## 5. Other named angles / measurements

* **`_gpu_init_videomode` goto-funnel (falsified).** The proper 11D COMPLETE-THE-FUNNEL form
  (`int r; ... r=K; goto done;` with the arms ordered PAL-then-NTSC so the NTSC block precedes
  the shared exit) lands in the SAME basin as the plain funnel the W55 receipt already
  falsified: 31 diffs, ours 41, `r` colored `$a0` with an `addu v0,a0,zero` per arm. Moving
  `r = 0;` above the discarded `(void)*GPU_GP0` read is inert (31). Circular cause read off the
  oracle: retail's dummy GP0 re-read uses `$v1` *because* `$v0` already holds the result; ours
  takes `$v0` for the scratch, forcing `r` elsewhere. Superseded by the 2.7.2 splice above.
* **`_set_draw_mode` inline-ternary `hi` (falsified).** `return (dtd ? 0xe1000200u :
  0xe1000000u) | lo;` → 16 diffs, ours 12 insns (oracle 8). Superseded by the 2.7.2 splice.
* **`_dws` / `_drs` (11 / 13, unchanged).** Residual is dominated by the 3.25-3b "old-gcc
  no-copy-prop" class — retail rematerializes constants we copy-propagate (`lui $s3,1024` vs
  our `addu $s3,$v1,$zero`; `li $a0,-1` vs `addu $a0,$v0,$zero`) and computes into a fresh reg
  then copies (`sra $s0,$v1,5; addu $v1,$s0,$zero` vs our in-place `sra $v1,$v1,5`), plus a
  prologue `sw $s1`/`addu $s1,$a0` position swap. Same version axis as DrawOTag — but 2.7.2 is
  catastrophic on these two (REAL 122 / 124), because they are exactly the functions that need
  the `-mno-split-addresses` clamp identity. So the version axis is **per-function in both
  directions** on this TU. Untried angle: a rung between the two behaviours, or the
  flag-dropping splice combined with a 2.8.x rung — no such rung exists on disk today.
* **`_gpu_que_drain` (14, unchanged).** 152/152 exact. The residual is a pure interleaving of
  the three `_que[_qout]` address chains: retail starts the next index chain from the `$a1` it
  already holds BEFORE reloading the volatile `_qout`, ours reloads first and computes each
  chain strictly sequentially. Instruction-scheduling / local-alloc handout order — the 06E
  gap again, not a spelling.
* **`PutDispEnv` (54, unchanged).** 318/318 exact. Confirmed the residual is the SAME
  one-word class as `_set_draw_mode`, repeated at each `send_gp1` site: ours `or a0,a0,v1`,
  retail `or a0,v1,a0`, with the `$v0`/`$v1` roles swapped throughout (constant in `$v0`,
  shifted field in `$v1`). Since 2.7.2 fixes exactly that operand order on `_set_draw_mode`
  from unchanged source, this is very likely the same version axis — but the whole-function
  2.7.2 splice is far worse here (326 insns, REAL=296), so it needs the operand-order behaviour
  WITHOUT the rest of 2.7.2. **Named angle:** re-test PutDispEnv the moment the flag-dropping
  splice lands, at finer granularity than whole-function if the mechanism ever gains it.

## 6. Ladder (04Z — post-reorder table, `NFS4_FORCE_CC1_ALT=<v> tugate`)

| rung | result |
|---|---|
| 2.8.1 (wired) | 34/44 PASS — optimal |
| 2.8.0 | 34/44, identical except MoveImage 9 → 35 |
| 2.91.66 | far-miss across the TU |
| 2.95.2 | far-miss across the TU |

Sub-2.8 rungs cannot be laddered whole-TU at all (they reject `-mno-split-addresses`).
Per-function they are reachable — §2.

## 7. Skips / hazards

* **`recon/syslib/psx/libgpu/FONT.c` — SKIPPED-USER-LIVE.** `git status` shows it modified in
  the working tree; not touched, not gated, not staged.
* I committed ONLY `recon/syslib/psx/libgpu/SYS.c` (explicit paths, never `-A`/`-a`, never
  pushed). No `git checkout`/`restore`/`stash` at any point; the one revert I needed (MoveImage)
  was done with my own scratchpad backup + targeted rewrites, never a tree operation.
* `build.py --skip-asm` reported `SKIP recon/game/psx/drawc.cpp` (a warning-as-error on
  `COORD16 *` at drawc.cpp:4273) partway through the session; that file is the user's live work,
  appeared without any action of mine, and does not affect this TU.
* SYS.c is an **LF** file (not CRLF like much of the tree) — all scripted edits preserved LF and
  were byte-scanned afterwards (non-ASCII set unchanged: the pre-existing `§`/emoji bytes only,
  no control bytes).

## 8. Tools left in `scratchpad/w60a3/`

* `reorder.py` — the VA-order reorder (idempotent-ish; re-runnable on a fresh checkout).
* `sbs.py` — ours-vs-oracle side-by-side for one SYS.c symbol.
* `probe_moves.py` — PER_FN_TEXT_MOVES spec prober; exact `_apply_text_moves` semantics,
  build.py's `as` line, real-vs-reloc diff classification. **Promotion candidate** — it lets an
  agent verify a TEXT_MOVES row end-to-end without touching `tools/build.py`.
* `probe_272.py` — per-FN ladder-rung splice prober with flag-dropping. **Promotion candidate**
  for the same reason; it is what turned three standing floors into wiring rows.
* `smove.py` — single-move variant of `probe_moves.py` (superseded by it).
* `SYS.c.bak0` / `SYS.c.bak_mi14` / `SYS.c.bak_pre_sdm` — per-landing backups.
