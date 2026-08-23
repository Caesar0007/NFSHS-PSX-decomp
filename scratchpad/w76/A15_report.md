# W76-A15 REPORT — libgpu belt (`_gpu_que_drain`, `FntFlush`)

**Result: both fns HELD (`_gpu_que_drain` 6 @152/152, `FntFlush` 2 @199/199) — no seal, but
both residuals upgraded from "named angle" to MEASURED-SHUT + one 🏆 compiler-experiment
sufficiency proof.  Zero PASS→FAIL anywhere (SYS.c 43/44 and FONT.c 1/2 identical before/after,
gated twice each; slotcheck `bad = 0`).  Nothing shipped except receipt comment blocks; no
PIN-SEALED items (the pin lane proved structurally inapplicable to both residuals).**

| fn | unit | baseline | final | gate runs |
|---|---|---|---|---|
| `_gpu_que_drain` | syslib/psx/libgpu/SYS | FAIL 6 @152/152 | **HELD 6 @152/152** | 3× fn, 4× whole-TU |
| `FntFlush` | syslib/psx/libgpu/FONT | FAIL 2 @199/199 | **HELD 2 @199/199** | 3× fn, 4× whole-TU |

Attack order followed as mandated: (a) predecessor receipt angles → (b) catalog §20–24 ladder →
(c) sibling corpus → (d) zero-insn device families → (e) pin/insertion lane (reached, and shown
inapplicable — see below).  All probes ran through the W75 in-place probe harness
(`scratchpad/w75/a15_probe.py` byte-mode + restore-in-finally; per-TU recipes are path-keyed so
a sibling TU would compile in the wrong lane — same reasoning as W75-A15).

---

## 1. `_gpu_que_drain` — 27 new cells, all ≥ 19; the ORDER LEVER FOUND, with a joint-cell proof

Residual (unchanged): ours `[sll v1,v1,5][reload3][argload]` vs retail
`[argload][reload3][sll v1,v1,5]` — sched1 emission position, registers already retail's.

### 🏆 The order IS source-reachable — but only as half of a proven joint cell

`arg = _que.shared[_qout].arg;` (the **volatile** union view for the ONE field read; all else as
shipped) emits **retail's exact dispatch order** — argload(68-70), reload3(71-72), closing
sll(73) — the entire 6-diff permutation gone (`scratchpad/w76/a15_P16_sbs.txt`).  Mechanism:
volatile↔volatile ordering pins the argload above the third `_qout` reload, leaving the closing
shift as the only legal load-delay filler = retail's position 73.  **Cost: the register handout**
— reload1 $v0 / func-chain $a2 / reload3 $v1 (retail $a1/$v1/$a1) = 20 @152.  The clobber grid
re-run IN THIS BASIN per W75 law #2 (12 sets × 3 positions + 7 $a1-anchored pairs,
`scratchpad/w76/a15_grid3.txt`): **no cell below 19**, and only $5-containing cells hold count
152.  ⇒ order fix and handout fix are a **proven joint cell** (24F-12 PrimClip class): the
volatile read that buys the order changes the RTL that the $a1-denial cell needs.

### Falsified this belt (all gated, all reverted; case files `scratchpad/w76/a15_P*.json`)

* **Scale-deferral family (new cells):** raw `fidx = _qout` with `* 96` in the func statement —
  37 @155 with AND without the clobber; + volatile barrier 43 @155; `*3` first + `<<5`-in-func +
  barrier 21 @151.
* **Volatile empty barrier** (24D-3 order dial) after the arg stmt: 20 @152 — order partly
  retail but the handout breaks and a copy mints (`a15_P6_sbs.txt`).
* **6-basin re-prices (04Z law), previously measured only in the 10-basin:** extra-launder
  21 @151 · all-three launders 21 @151 · multi-output tied (arg,extra) 24 @152 · launder
  carrier=extra w/ $5 19 @151 · carrier=arg w/ $5 35 @151 · both-carrier w/ $5 32 @152 ·
  fidx-launder + `"r"(arg)` dep operand 29 @153 · + `"r"(extra)` 21 @153.
* **Double-set fidx** (qidx-launder between read and scale, clobber ∈ {none,$2,$2+$6,$6}):
  all 30 @154 — the second set still costs real copies (W74 REG_N_SETS law holds).
* **Corpus (brief angle b):** psyz `_exeque` is **still INCLUDE_ASM** at HEAD `6d47e5e`
  (checked 2026-08-23, `decomp/src/libgpu/sys.c:868`) — the brief's "psyz has matched sys.c"
  hint is stale for this fn; the W64 no-vendor-body note stands.
* **Pin/insertion lane (brief angle c):** structurally inapplicable — the residual is emission
  ORDER at exact count 152; a register pin cannot reorder emission, and any real inserted
  instruction breaks the count.  Zero-insn volatile barriers (the only zero-byte order device)
  were measured at every between-reads position (this belt + the W75 grid): all break the
  handout.

**VERDICT: 6 stands** as a sched1 filler-pick floor receipt (24D family) under the
no-post-compile-rewrite policy.  The volatile-arg basin is banked in the receipt for any future
device that can reach *its* handout.

## 2. `FntFlush` — held at 2; certificate upgraded to PROVEN-SUFFICIENT

### §24B family measured and falsified on this site (the brief's mandated first attack)

* Donor-clobber, A14 `__adddf3` recipe (`__asm__("" : : "r"(dr) : "$6")`): after
  `dr = &fs->draw_mode;` **68 @201**; just before `TermPrim(dr)` **69 @200**.
* Arg-launder (24B-2): **45 @200**; launder + `"$6"`: **68 @201**.
* Root cause of the blowups (confirming W64's 16B prediction by gate): the donor $a2 is a
  **RELOAD register** here — not an allocated pseudo's home as in `__adddf3` — so naming `"$6"`
  poisons `bad_spill_regs` function-wide and every reload re-deals; the launder alone costs the
  +1 the exact count cannot absorb.

### Other input-lane axes closed this belt

* **RAW40** (PsyQ 4.0 cc1 — reachable, FONT.c is a maspsx-lane TU; never tried by W75, which
  laddered FSF rungs only): whole-fn **84 diffs, frame 80 vs 120** — PADSEQD scope rule fails,
  lane inapplicable.  Probe note: the 1996 cc1 rejects `-mno-split-addresses`; any future RAW40
  wiring for a `no_split_addresses` TU must extend the `_flags40` filter (probe did, reverted).
* **FLAG axis** (15 rungs via `vprobe_flag.py`; never measured for this fn): 8 rungs inert at 2
  (-fcaller-saves, -fno-function-cse, -fforce-mem, -fno-peephole, -fno-defer-pop,
  -fno-cse-follow-jumps, -fno-thread-jumps, -fno-rerun-cse-after-loop); the rest worse
  (-fno-strength-reduce 4 · -fforce-addr 13 @198 · -fno-cse-skip-blocks 15 @204 ·
  -fno-schedule-insns2 21 @202 · -fno-delayed-branch 48 @215 · -fno-schedule-insns 52 @201 ·
  -fno-expensive-optimizations 92 @205).
* **Vendor comparandum (psyz FONT, brief angle):** psyz's *matched* FntFlush
  (`decomp/src/libgpu/font.c:303`) is **shape-identical** at the site (`dr = &font->draw_mode;`
  → the eight field loads → `TermPrim(dr);`) — the source shape is vendor-confirmed; the
  residual is toolchain identity, not source.

### 🏆 SUFFICIENCY PROOF — one-variable compiler experiment (the belt's headline)

The W75 standing angle ("a cc1 that is 2.8.0 in every pass except reload_cse_regs") is now
**proven sufficient**: `scratch/gccsrc/gcc-2.8.1/toplev.c:3501` env-guarded
(`getenv("GCC_NO_RELOAD_CSE")`, behavior unchanged when unset — instrument-tree convention),
cc1 rebuilt in `scratch/gccbuild-ecoff`.  On `build/.../FONT.c.i` (`-quiet -O2 -G4 -mgas`; the
lab segfaults on a LATER fn, FntFlush's region completes — known 23D-5 behavior):

* Pass ON: the lab reproduces our defect **verbatim** (`move $4,$6` above the `sw`) — region
  fidelity confirmed.
* Pass OFF: the **same binary** emits retail's `sw $6,16($sp); lw $4,16($sp)` — **and** the two
  colour-default stores `sw $6,28/32($sp)` move to retail's early position, i.e. exactly the
  two lines the wired w61-a4 `PER_FN_TEXT_MOVES` rows relocate.
* The whole-region diff is **exactly those two effects and nothing else**
  (`scratchpad/w76/a15_lab_{base,norcse}_fn.s`).

⇒ Sony's internal lib rung = a 2.8-shape cc1 **without** reload_cse_regs (a pre-970404 2.8-dev
snapshot; the shipped SDK's own CC1PSX.EXE — our default lane — HAS the pass, so the SDK
compiler ≠ the compiler Sony built LIBGPU.LIB with, the same internal-vs-shipped split already
proven for ASPSX).  A sanctioned no-rcse rung would seal FntFlush **and retire both TEXT_MOVES
rows**.  **Not wired** — a patched cc1 is not a historical rung; the lane decision belongs to
the user/orchestrator.  The patched lab cc1 + env guard stay in the (git-ignored) instrument
tree for one-command re-verification.

## 3. New laws / corrections for the catalog

1. **🏆 A volatile-view read on ONE field is an ORDER device** — volatile↔volatile ordering with
   an existing volatile load pins the field load above it in sched1's emission, and can
   reproduce a retail order no zero-insn fence reaches (fences barrier EVERYTHING; the volatile
   pairing constrains exactly one edge).  Cost axis: it changes fold/combine on that load, so
   the register handout re-deals — always re-run the clobber grid in the new basin (this belt:
   order EXACT, handout 20; joint cell proven).
2. **🏆 `GCC_NO_RELOAD_CSE` env guard** (lab toplev.c:3501) = the one-variable discriminator for
   ANY suspected 23A-2/24B residual: run the lab twice, diff the region.  First use turned a
   6-wave certificate into a proof and identified two TEXT_MOVES rows as compensation for the
   same missing-pass identity.
3. **24B scope refinement:** the donor-clobber escape requires the donor to be an *allocated*
   register; when the donor is a **reload register**, 16B `bad_spill_regs` makes every clobber
   spelling self-defeating (measured 45-69 diffs here vs the predicted certificate) — check
   `.greg` for whether the donor's set is a reload insn BEFORE building the escape.
4. **RAW40 flag filter gap:** the raw40 branch's `_flags40` strips only `-g1`; a
   `no_split_addresses` TU also needs `-mno-split-addresses` stripped (1996 cc1 rejects it).
5. Stale-hint corrections: psyz `_exeque` unmatched (brief said matched); psyz FntFlush IS
   matched and shape-confirms our source.

## 4. Files touched

* `recon/syslib/psx/libgpu/SYS.c` — W76-A15 receipt block only (no code change).
* `recon/syslib/psx/libgpu/FONT.c` — W76-A15 receipt block only (no code change).
* `tools/build.py` — **net zero from me** (RAW40/flag-filter probe edits byte-restored with
  asserts; the foreign hunks — w76-a4 probe row, W75-A16 comments, stale psxcontroller rows —
  preserved untouched, verified by `git diff`).
* `scratch/gccsrc/gcc-2.8.1/toplev.c` + `scratch/gccbuild-ecoff/cc1.exe` — env-guarded
  instrument patch (git-ignored lab tree; behavior unchanged without `GCC_NO_RELOAD_CSE`).
* `scratchpad/w76/a15_*` — probe cases, grids, side-by-sides, lab `.s` regions (untracked).
* No commit, no staging, no memory-dir writes.
