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

> 🔴🔴 **THE NUMBERS IN THE TABLE BELOW WERE WRONG — see §9 for the corrected table and the
> probe bug that produced them.** `_set_draw_mode`'s `REAL=0` was FALSE and it is NOT wired;
> its 2-diff floor stands. `DrawOTag` and `_gpu_init_videomode` are genuine (independently
> confirmed by the orchestrator's real gate: SYS.c went 36/44 → 38/44). Every other row was
> wrong in one direction or the other. The table is kept only so the error is legible.

| fn | now | 2.7.2 per-fn splice | verdict |
|---|---|---|---|
| **DrawOTag** | 2 | 28/28, ~~REAL=0~~ | **PASS** (holds — §9) |
| ~~**_set_draw_mode**~~ | 2 | ~~8/8, REAL=0~~ | 🔴 **FALSE** — really 2 diffs (§9) |
| **_gpu_init_videomode** | 14 | 40/40, ~~REAL=0~~ | **PASS** (holds — §9) |
| _clearOTagR_dma | 2 | ~~REAL=13~~ | really 2 (§9) |
| _gpu_que_drain | 14 | ~~REAL=17~~ | really 24 (§9) |
| MoveImage | 9 | ~~REAL=18~~ | really 17 (§9) |
| _dws | 11 | ~~REAL=122~~ | really 59 (§9) |
| _drs | 13 | ~~REAL=124~~ | really 55 (§9) |
| _BlitClear | 2 | ~~REAL=113~~ | really 130 (§9) |
| PutDispEnv | 54 | ~~REAL=296~~ | really 106 (§9) |

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
* `SYS.c.bak0` / `SYS.c.bak_mi14` / `SYS.c.bak_pre_sdm` — per-landing backups.
  (`smove.py` deleted — superseded by `probe_moves.py`.)

---

# §9 — CORRECTION ROUND (coordinator-flagged). Two probe bugs, all numbers re-derived.

## 9.1 The bugs

**Bug A — vacuous reloc classifier (coordinator-flagged).** Both probes scored with a
home-grown split:

```python
if a.split()[:1] == b.split()[:1]:   # same mnemonic
    reloc += 1                       # ...so "not a real diff"
```

That excuses *any* same-mnemonic word mismatch. `_set_draw_mode`'s whole residual is
`or $2,$2,$3` vs retail `or $2,$3,$2` — same mnemonic, **zero relocations in the entire
function** — so it was counted as `reloc=1, REAL=0`. A commutative-operand floor was reported
as a seal. My "REAL" counter was also never the gate's metric (the gate is an LCS diff over
normalized text, not a positional word compare), so *every* number it produced was wrong in
one direction or the other — including ones that looked conservative.

**Bug B — found while fixing A: unsplit comma lists.** `fns = sys.argv[2:]` meant
`probe_272.py 2.8.0 a,b,c` produced one bogus name, `region()` missed, the script printed
`SKIP (no region)` and then **scored the unspliced object** — i.e. echoed the live tree and
looked like a plausible result. This is why an early multi-fn run "confirmed" 2.8.0 ≡ 2.8.1
on MoveImage (really 35 vs 9).

## 9.2 The fix — score with the gate itself, not a re-implementation

New `scratchpad/w60a3/gatecmp.py`: loads `tools/verify_asm.py`'s **source**, substitutes only
the compile step (`obj = Path(os.environ['GATE_OBJ'])`), and executes it. Every normalizer,
the `R_MIPS_LO16`/`GPREL16` addend zeroing, branch-target masking, the dead-`%hi` rule and the
difflib count are the gate's own. It hard-fails if verify_asm's compile block ever changes
shape, rather than drifting silently. Both probes now delegate to it, and a failed take/after
regex or a missing `.ent` region is **fatal** instead of silently vacuous.

**Validity checks (two, independent):**
* `GATE_OBJ=build/.../SYS.c.o gatecmp.py` reproduces `tugate` exactly on all 8 functions.
* `probe_moves.py _gpu_que_drain '[]'` (null move) → `FAIL 14 diffs (152/152)` = the live gate.
* `probe_272.py 2.8.1 …` (the wired rung = a control) reproduces the live numbers on all five
  open FAILs.

## 9.3 Corrected per-FN rung table (gate diffs; `—` = cc1/as failed on that combo)

| fn | live | 2.7.2 | 2.8.0 | 2.8.1 (wired) | 2.91.66 | 2.95.2 |
|---|---|---|---|---|---|---|
| DrawOTag | **PASS** | **PASS** | 2 | 2 | — | — |
| _gpu_init_videomode | **PASS** | **PASS** | 14 | 14 | — | — |
| _BlitClear | **PASS** (2.8.0 + TEXT_MOVES) | 130 | — | — | — | — |
| _clearOTagR_dma | **PASS** (TEXT_MOVES) | 2 | — | — | — | — |
| _set_draw_mode | 2 | **2** | **2** | **2** | **2** | — |
| MoveImage | 9 | 17 | **35** | **9** | 45 | 19 |
| _dws | 11 | 59 | 11 | 11 | 137 | 139 |
| _drs | 13 | 55 | 13 | 13 | 172 | — |
| _gpu_que_drain | 14 | 24 | 14 | 14 | — | — |
| PutDispEnv | 54 | 106 | 54 | 54 | 210 | 361 |

The two wired 2.7.2 seals **survive the correction** — they are also confirmed independently by
the orchestrator's real gate (36/44 → 38/44).

## 9.4 What the correction changes about my conclusions

* 🔴 **`_set_draw_mode` is NOT the 04M version axis.** It is **2 diffs on every rung that
  builds it** — 2.7.2, 2.8.0, 2.8.1 and 2.91.66 all emit `or $2,$2,$3` where retail has
  `or $2,$3,$2`. That is a much *stronger* statement than the floor the W56 receipt filed: the
  commutative-operand order here is **compiler-version-INVARIANT**, so the version axis is
  exhausted as well as the spelling axis. My in-source claim that 2.7.2 fixes it is deleted.
* ✅ **`DrawOTag` / `_gpu_init_videomode` conclusions stand**, including the mechanism reading
  (`reorg.c:4289 make_return_insns` only converts a *filled* jump to `end_of_function_label`).
* 🔴 **`_dws` / `_drs`: the version axis is now definitively closed** (assignment 4). 2.8.0 and
  2.8.1 are **byte-identical** on both functions — I diffed the two rungs' `.ent/.end` regions
  directly, not just their scores — so a default-lane/272-lane per-fn version splice has
  nothing to buy. 2.7.2 is 59/55 and the late rungs 137/172. **No rung to wire; do not spend
  orchestrator budget here.** (2.8.0 ≢ 2.8.1 on MoveImage, so the identity is per-function, not
  a blanket "2.8.0 ≡ 2.8.1 on this TU".)
* The `_BlitClear` and `_clearOTagR_dma` TEXT_MOVES rows were never affected — they are landed
  and PASS on the real gate.

---

# §10 — ROUND 2 (assignments 2–4 + the idiom-corpora directive)

Baseline on resume: **38/44** (the coordinator's wirings landed). Final: **38/44 with −6 diffs**.

| fn | on resume | now |
|---|---|---|
| _dws | 11 | **8** (count-exact 143/143) |
| _drs | 13 | **10** (count-exact 160/160) |
| _set_draw_mode | 2 | 2 (version axis now closed too) |
| MoveImage | 9 | 9 (diagnosis corrected — my own filed angle was wrong) |
| _gpu_que_drain | 14 | 14 |
| PutDispEnv | 54 | 54 (residual measured precisely, not estimated) |

## 10.1 `_dws` 11→8 and `_drs` 13→10 — the Rage-Racer corpus paid immediately

`C:/Temp/rage-racer-decomp/src/main/PAL/lib/libgpu/image_commands.c` carries **the same two PsyQ
functions**, byte-exact: `Gpu_LoadImage` = our `_dws` (GP0 A0h), `Gpu_StoreImage` = our `_drs`
(GP0 C0h). Three C shapes ported (their `register … asm("$N")` pins dropped — shapes port, pins
do not):

1. **shift into a fenced local, then COPY** — RR: `rem = transferValue >> 5; asm("" : "=r"(rem)
   : "0"(rem)); quotient = rem;`. Our comma-staged `quotient = to_write >> 4` folded to one
   in-place `sra $v1,$v1,5`; retail computes into a *different* register then copies
   (`sra $s0,$v1,5; addu $v1,$s0,$zero`). **This idiom alone is the entire count gap on both
   functions.**
2. **zero-trip-guarded `do/while` spin with the mask in a named local** inside the guard
   (RR's `readyMask`), replacing `while ((*GP1 & LITERAL) == 0)`. `_drs` has two spins
   (0x04000000 ready, 0x08000000 send) exactly as RR does.
3. **peeled transfer loop** — `n--; if (n != -1) { do { … } while (n != -1); }`, not `while (n--)`.

Falsified on top of the new basin (each gate-measured, each reverted): RR's entry opacity fence
on the rect pointer (inert, 8) · RR's `status = *GP1; status &= readyMask;` spin temp (inert, 8)
· a named `current` local for the data pointer in RR's decl order (inert, 8) · a void-tail
parm-spill pin before the first statement (10) · an identity fence on `readyMask` to break cse
constant-sharing (**52** — it rotates the whole saved-reg band) · a `sentinel` local re-assigned
`-1` before each loop test, per the W60 catalog "re-assign a fresh literal" row (15, and loses
the count).

Residual on both is now one story: (a) 3.25-3b old-gcc no-copy-prop constant rematerialization
(`lui $s3,1024` / `lui $s1,2048` / `li -1` vs our `addu` copies); (b) the two parm (save, copy)
pairs emitted in the opposite order to retail. Version axis closed (§9.4).

## 10.2 `PutDispEnv` — measured, not estimated (assignment 2)

New `scratchpad/w60a3/classify.py` buckets the **gate's own** normalized streams position by
position. 318 insns, **30 mismatched positions**:

| bucket | count |
|---|---|
| pure `$v0 ↔ $v1` role swap | 22 |
| that swap **+** a commutative-operand flip | 3 |
| one instruction rotated three slots (overscan span) | 4 |
| `andi $v0,$v1,4095` vs `andi $v1,$v1,4095` (dest only) | 1 |

So **25 of 30 are ONE coupled register-role decision** repeated at the three `send_gp1` sites —
the `_set_draw_mode` family, *not* three independent per-site floors. The coordinator's
hypothesis ("ceiling may be per-site 2s") is therefore **too pessimistic in structure and too
optimistic in count**: it is a single global decision worth ~25 positions, and if it ever cracks
PutDispEnv goes 54 → under 10. Re-test it the moment anything moves `_set_draw_mode`.

New falsifications: flipping only the final `or` to `hi | lo` at all three sites = **60** (order
right, registers still wrong — the same coupling `_set_draw_mode` shows); also swapping the
comma-staging so `lo` is assigned first = **124**.

## 10.3 `MoveImage` — the instrument lane, and my own filed angle FALSIFIED (assignment 3)

Recipe used (11A, no instrumented build needed — the real ladder cc1 accepts the dump flags):
compile the TU's own `.i` with `-dS -dR -dl -dg`, read `*.greg` (post-global-alloc RTL) and
`*.sched2` (ready lists). Artifacts in `scratchpad/w60a3/instr/`.

I had filed the residual as "anchor-vs-andi **emission order**, a sched2/local-alloc question".
**That is wrong.** In the 46/46 basin the body block is already, *at greg*:

```
 48 (set (reg v0) (ashift (reg s1) 16))                       <- the sll reorg steals
 49 (set (reg v1) (and (reg s2) 65535))                       <- the x mask -> $v1
 50 (set (reg v0) (ior (reg v0) (reg v1)))
106 (set (reg v1) (const (plus (symbol_ref "_move_prim") 8))) <- anchor REUSES $v1
```

and sched2's block-3 ready lists emit that quartet in RTL order — it never had a choice to make
there. The residual is a **global register assignment**: the allocator gives the anonymous mask
temp `$v1` and then recycles `$v1` for the anchor once the mask dies, where retail parks the mask
in `$a0` and the src word in `$a1` and leaves `$v1` to the anchor for its whole live range. The
3-register rotation is a *consequence* of that one handout — which is exactly why every
statement-order / split / fence-flavour / named-temp spelling was inert or worse.

It also explains the two "inert" readings exactly: `p` is the opacity fence's **output**, so
insn 106 is generated at the *fence's* position, not the assignment's — moving
`p = &_move_prim[2];` earlier while leaving the fence in place cannot move the anchor.

**Corrected next angle:** dial the mask temp's allocno refs so it loses `$v1` to the anchor
(05C/06B fences). Must be dialed empirically — `allocsim`/`reqdelta` do not model this lane
(11A) — and the mask is anonymous, while naming it costs +8, so the dial has to be applied to a
neighbouring *named* value. Left un-landed; MoveImage reverted to its authoritative 9.

## 10.4 `_dws`/`_drs` version axis (assignment 4) — closed, see §9.4

2.8.0 and 2.8.1 emit **byte-identical** `.ent/.end` regions for both functions (regions diffed
directly, not merely scored); 2.7.2 = 59/55; 2.91.66/2.95.2 = 137/172. **No rung to wire.**

## 10.5 Hazards hit this round (all catalogued classes, all mine)

* **`str.replace` with no assert silently no-op'd twice**, producing "inert" readings for edits
  that were never applied. Same family as the heredoc / dup-key hazards. Only the Edit tool or
  an asserting script gives an honest measurement.
* **`*/` closing a host comment** (methodology gotcha #1) — an appended receipt paragraph ended
  with `*/` inside an existing block, which detached the rest and broke the TU compile. Caught
  by the build, fixed, re-gated.
* A transient `build.py` mid-edit race produced a bogus "symbol already defined" wall on one run;
  the next run was clean. Re-run before believing a whole-TU build failure.

## 10.6 Tools added this round

* `gatecmp.py` — run verify_asm's own logic over an arbitrary `.o`. **Promotion candidate**: it
  is the thing that makes any scratch probe honest.
* `classify.py` — bucket a residual (register-role swap / commutative flip / other) using the
  gate's normalized streams. Promotion candidate.
* `instr/` — the `-dS -dR -dl -dg` dump artifacts for SYS.c (both MoveImage basins).
