# W76-A17 — libcd belt (report)

Targets: `_st_dma` (syslib/psx/libcd/stcdint.c), `_read_issue` (syslib/psx/libcd/cdread.c).
`CD_cw` (drv.c) SEALED — not disturbed, TU re-gated. Repo `C:\Temp\nfs4-decomp`.
**No git commit/push/stage. tools/build.py untouched. No memory-dir writes. No
post-compile mechanism added (policy 2026-08-23 honoured; the one asm PIN landed is
LAST-RESORT per the mandated ladder, receipted below).**

STEP 0 done: `reference_mips_isa_asm.md` (full), `reference_psx_cpp_reconstruction_methodology.md`
(full), `reference_asm_pattern_catalog.md` §§20–24, `scratchpad/w76/BRIEF.md`,
`scratchpad/w75/A17_report.md` + in-TU receipts.

## HEADLINE

| fn | baseline | final | outcome |
|---|---|---|---|
| **`_st_dma`** (stcdint.c) | 21 @107/106 | **1 @107/106** | −20, **PIN-SEALED residual-1** (floor receipted), gated ×2, slotcheck clean |
| `CD_cw` (drv.c) | PASS (sealed W75) | PASS 13/13 | untouched, re-gated |
| `_read_issue` (cdread.c) | 3 @121/122 | 3 (untouched) | NOT attempted — session budget cut by orchestrator after the _st_dma landing; W75 route receipt stands |

Zero PASS→FAIL anywhere. Final TU gates (twice each): `stcdint.c 2/3`, `drv.c 13/13`,
`cdread.c 5/6`. `tools/slotcheck.py build/recon/syslib/psx/libcd/stcdint.c.o` → bad = 0.

## 1. `_st_dma` — 21 → 1 (THE RAGE-RACER CELL)

### 1a. Missing-insn hunt (brief's first ask) — SOLVED with a compiler-source mechanism
The 107-vs-106 extra insn is a duplicated `li v0,1` in the busy-guard's `beqz` delay
slot. Retail fills that slot with the preheader `lui a2,1` (the 0x10000 poll limit);
ours duplicates the branch-target's `li v0,1` instead (label NUSES=2 → copy-steal,
+1 insn). Mechanism read from reorg.c + `-dL/-dS/-dR/-dd/-df/-dg` dumps on the REAL
CC1PSX (the 272 lane accepts all of them — 12A):
* the loop dump proves the 65536 IS hoisted to the preheader (insn 253, before
  LOOP_BEG) — the old "LICM didn't hoist" framing is wrong;
* the 65536 pseudo is **loop-carried** (flow: "dies in 0 places") so
  `mark_target_live_regs`' REG_DEAD walk believes $a2 live at the loop exit →
  `fill_slots_from_thread` refuses the fall-through steal (reorg.c "two ways to win"
  gate: `insn_sets_resource_p(trial, &opposite_needed)`);
* `fill_simple`'s backward scan cannot reach any earlier candidate — the **volatile
  busy-read blocks the scan**;
* so cc1's eager fill copy-steals the target's `li v0,1` = the +1.
Shape-invariance measured OUT-OF-TREE (`scratchpad/w76/a17_slotsweep.py`, never touched
the repo file): for-loop, guarded do-while, named limit in-loop, named limit pre-loop
(the entry-block `li $6,0x10000` lands ABOVE the branch and is STILL not taken) — all
emit the same stolen slot. ⇒ retail's slot is **ASPSX's own fall-through fill under
-fno-delayed-branch** (sec. 3.25-3b pipeline identity; per-fn `-fno-delayed-branch`
re-measured at 35 by W75 because GNU-as reorder can't reproduce ASPSX's other fills).
**No compiler input reaches 106/106; 1 is the wired-pipeline floor.**

### 1b. Sibling-corpus mining (brief's third ask) — the decisive hit
`C:/Temp/rage-racer-decomp/src/main/PAL/lib/libcd/dma_start.c` — the 100%-byte-exact
Rage Racer decomp's `CD_dmastart` IS this routine, and its matched source carries
`register long dv asm("$6")` (+ a bv pin): independent proof the dv→$a2 seat (W75's
"dv/idx QTY inversion") is pin-territory, not a missed source dial. (psyz's c_011
StCdInterrupt/dma_execute is INCLUDE_ASM-only — no source there. A Chill-leak grep hit
is only a StCdInterrupt caller.)

### 1c. The landing — a JOINT CELL (each half alone worse; all gated)
* pin dv→$6 alone (idx machinery kept) **35** · pin + drop idx fence **35** · pin +
  drop idx local **35**
* **FULL CELL = 1**: `register int dv __asm__("$6")` + drop the idx local/fence (p
  spelled `0x1F801080 + (ch << 4)`) + drop the two `bit` identity fences + drop the
  `dp` identity fence (23B-3: the W64/W75 devices were scaffolding for the wrong
  seating — removed, not kept)
* full cell + drop bv read-only fence **19** (bv fence is load-bearing) · bv PINNED
  instead of fenced **7** · keep the dp fence **15**
Landed with a loud in-TU receipt block listing the falsified alternatives (W75's full
dial ledger + these cells). Function classification: **PIN-SEALED residual-1** (not a
clean seal; the 1 is the receipted 3.25-3b floor). Whole-TU 2/3 held, gated twice;
`slotcheck` on the object: 0 flagged.

### 1d. Falsified/measured this wave (beyond W75's ledger)
* guard-slot shape sweep: V0 control / V3 for-loop / V4 guard+do-while / V1 lim-in-loop
  / V2 lim-pre-loop — slot invariant (V2 does move the 65536 into the entry block;
  still not taken — kills the "entry-block materialization = gas backfill" hope: the
  volatile read blocks gas too).
* limit=100 discriminator: slot unchanged ⇒ NOT an eligible_for_delay length effect.
* 2.8.1-source reading of fill_eager/mostly_true_jump/own_thread_p/find_basic_block
  banked in section 1a; note find_basic_block returns block 0 for the whole
  barrier-free head region, so the live walk runs from the function start (relevant to
  any future guard-slot question on this lane).

## 2. `_read_issue` — untouched (3 @121/122)
Orchestrator cut the session after the _st_dma landing. The W75-A17 route receipt
stands unchanged: RAW40 route priced to 1 with the slot-UB hazard blocking the land;
next angles (a)–(c) in `scratchpad/w75/A17_report.md` §3e remain the named frontier.
Note for the next belt: the rage-racer corpus carries matched `cdread.c` siblings too
(`src/main/PAL/lib/libcd/` — worth the same mining pass before any further dialing).

## TOOLS / ARTEFACTS (all under scratchpad/w76/)
* `a17_slotsweep.py` — OUT-OF-TREE shape sweeper (copies the TU to scratch, compiles on
  the lane recipe, prints the guard slot); the fleet-safe probe pattern for
  self-contained 272-lane TUs.
* `a17_dump272.py` — cc1_272-lane RTL dumper (cpp + CC1PSX + lane flags + -d flags);
  dumps in `scratchpad/w76/rtl/`.
* `a17_dma_pins*.json` + `scratchpad/w75/a17_srcprobe.py` runs — the pin-cell probe
  ledger (`a17_dma_pins_res.json`, `a17_dma_pins2_res.json`, `a17_p4res*`).
* `a17_land.py` — the CRLF-safe landing script (byte-mode, probe-proven anchors).
* Baselines: `A17_base_{stcdint,cdread,drv}_1.txt`, diff `A17_stdma_diff.txt`,
  side-by-side `A17_stdma_sbs.txt`.

## HAZARDS FIRED (caught)
* Python `"\xf0..."` escapes in a landing script write MOJIBAKE, not UTF-8 (21E-10
  family) — the landed receipt's emoji decoded to 8 garbage bytes; caught by a cat -A
  re-read, replaced with ASCII `[PIN]`. Rule: landing scripts write ASCII-only comments.
* The in-place probe harness was used only for short probe windows (shared-clone rule);
  all shape exploration ran on an out-of-tree copy.
