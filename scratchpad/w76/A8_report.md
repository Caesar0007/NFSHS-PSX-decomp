# W76-A8 — hrzsku belt report (2026-08-23)

Unit `game/psx/hrzsku`, TU `recon/game/psx/hrzsku.cpp`.
Session was cut early by a session limit and resumed with a reduced scope order
from the orchestrator ("finish the V6-vs-shipped comparison, land proven wins,
re-gate twice, report, stop -- no new sweeps").  BuildSky was therefore NOT
reached this wave; its W75 state is intact.

## HEADLINE

| fn | baseline | final | count | posmis |
|---|---|---|---|---|
| `Hrz_BuildHorizon__FP13DRender_tView` | 12 | **12 (unchanged)** | 473/473 EXACT | 9 |
| `Hrz_BuildSky__Fv` | 146 | **146 (untouched)** | 458/458 EXACT | 76 |
| whole TU | 20/22 PASS | **20/22 PASS** | — | — |

**NO source edits landed** (every probe measured worse-or-tied; the shipped
basin survives on merit).  **ZERO PASS -> FAIL** — whole-TU gate run twice at
session end, identical both times (and identical after a concurrent user-session
edit to the TU's comments/receipts: 28+/42- lines, gate-neutral, re-verified).
No commits, no staging, no memory-dir writes, `tools/build.py` untouched
(gprobe edits it transiently and restores; user hunks preserved — verified by
gprobe's own restore invariant).

Fleet rule followed: ALL probes ran on an untracked sibling TU
`recon/game/psx/hrzskuw76.cpp` (byte snapshot of the shared TU at session
start), gated via `scratchpad/w76/a8probe.py` / `a8apply.py`; the sibling and
its build/rtl artifacts were DELETED at session end.  The shared TU was never
written.  (Mid-session the user's session modified the shared TU — the sibling
snapshot != shared at cleanup time was exactly this; gate numbers re-confirmed
on the new shared content.)

## 1. THE VACUOUS "-G inert" VERDICT IS RE-RUN WITH THE FIXED gprobe (24F(2)) — now GENUINE

`python tools/gprobe.py recon/game/psx/hrzsku.cpp` (fixed accumulation bug,
all cells measured; `scratchpad/w76/a8_gprobe.txt`):

| cell | diffs | PASS |
|---|---|---|
| baseline | 158 | 20 |
| g_value=8 | **158** | 20 |
| g_value=0 | 690 | 10 |
| no_split_addresses | 946 | 9 |
| g8+nosplit | 946 | 9 |

=> hrzsku's -G identity is CONFIRMED at the default (-G8 bit-inert, -G0 and
nosplit regress heavily).  The w47-a7 "-G inert" row for hrzsku is no longer
vacuous — strike it from the 24F(2) re-run queue.

## 2. BuildHorizon [187-193] init-pair cluster — the GIV-INITIALISER angle EXECUTED and PRICED OUT (comprehensive falsification matrix, all compiler-cited)

The W75 named angle ("iVar15/iVar18 are loop.c GIV initialisers — index by i
and delete them") was run to ground.  Retail's preheader tail
(`addu s3,s6,zero; addu s2,s4,zero; li s5,4` AFTER the two hoists) is indeed
only reachable if BOTH counters are loop.c-emitted, and the machinery was read
from source:

**NEW LAWS (gcc-2.8.1-src/extracted/loop.c, all verified by probe):**
1. **DEST_REG giv benefit bar** (loop.c:3914 `lifetime*threshold*benefit <
   insn_count` → ignore): stored benefit = rtx_cost(SET_SRC) [flat
   COSTS_N_INSNS(1)=4 per operator on MIPS — RTX_COSTS returns without
   recursing, mips.h:2991] **plus inherited `v->benefit` of any GENERAL_INDUCT
   reg read by the src (loop.c:5456)**, minus `add_cost*biv_count` (:3881,
   add_cost=4), minus `copy_cost` (4) when the giv is a non-replaceable user
   var (:3875).  **A lone `sll` giv (i*4) nets exactly 0 and is NEVER
   reduced; a 2-insn chain nets 4 and always is.**  This is why retail's
   iVar18 (i*4+4) reduces (`li s5,4` + step landed byte-exact in probe V3)
   while iVar15 (i*4) cannot.
2. **DEST_ADDR givs have `v->lifetime` PINNED TO 1** (record_giv,
   loop.c:4577) — their bar is `threshold*benefit` vs insn_count, so an
   inherited benefit >= 12 on the feeding pseudo POISONS every dependent
   address site into reduction.  Measured: probe V7 (`iVar18=(i+1)*4;
   iVar15=iVar18-4`, benefit 12) exploded 12 -> 106 @481 — the colour-table
   DEST_ADDR sites grew their own reduced pointers + the mask spilled.
3. **cse1 is algebraically closed over +-const/×const chains of one biv**
   (mult/shift canonicalization): EVERY 2-insn source spelling of `4*i`
   collapses to one `sll` before loop.c ever runs.  Falsified: `i*2` then
   `*2` (consec sets), `iVar18-4` (derived; cse rewrites to a copy of the
   `sll` temp), `{int u2=i+i; iVar15=u2<<1;}` (helper local), `i+i` then
   `+itself`.  All gate 11 @472 with the identical signature (missing
   `addu s2,s4,zero` init + in-body `sll s2,s4,2` + missing `addiu s2,s2,4`
   step).  The consec-sets escape additionally eats copy_cost
   (non-replaceable by REGNO_FIRST_UID test, loop.c:4630) and dies at net 0.
   **The benefit window that would reduce iVar15 without poisoning the
   DEST_ADDR sites (stored benefit 5..11) is UNREACHABLE from source
   arithmetic on this lane.**
4. **reload_cse renders a preheader `iVar15 = 0` user init as
   `addu s2,s4,zero`** (copy from the reg holding i=0 — 23A-2's donor-copy
   face; the shipped basin already exhibits it, V6 confirmed it holds when
   iVar18 is removed).

**Probe ledger (sibling TU, all re-gated):**

| probe | shape | result |
|---|---|---|
| V3 `e_giv1` | body births `iVar15=i*4; iVar18=i*4+4`, counters deleted | 11 @472 (count SHORT; iVar18 reduced ✓, iVar15 not) |
| V4 `e_giv2` | iVar15 as consec `i*2;*2` | 11 @472 (cse collapse) |
| V5 `e_giv3` | `iVar18=i*4+4; iVar15=iVar18-4` | 11 @472 (cse fold to copy) |
| V6 `e_giv4` | iVar15 kept USER BIV, iVar18 body-born | **14 @473 posmis 9** |
| V9 `e_giv6` | V6 with `iVar15 = i;` copy-init | 14 @473 |
| V7 `e_giv5` | `(i+1)*4` + derived | 106 @481 (DEST_ADDR poisoning) |
| V13 `e_giv7` | consec `i+i; <<1` | 11 @472 |
| V15 `e_giv8` | helper `{int u2=i+i; iVar15=u2<<1;}` | 11 @472 |
| V16 `e_giv9` | consec `i+i; +itself` (benefit 12) | 11 @472 |

**V6-vs-shipped positional comparison (the orchestrator's ask): posmis is
IDENTICAL — 9 at the SAME positions (186-190 + 332-335) in both basins.**
Shipped window `[li s5][addu s2][fp pair][s3]`, V6 window
`[addu s2][fp pair][li s5][s3]`, retail `[fp pair][s3][addu s2][li s5]` —
both are 5-position rotations of the same multiset.  LCS: shipped 12 vs V6 14.
Tie on the honest metric, worse on LCS, and landing V6 would touch the
actively-shared TU for zero posmis gain => **NOT LANDED; shipped basin stays.**

**Residual verdict [187-193]:** the 5-insn preheader rotation is a pure
EMISSION-ORDER cell: user inits precede loop.c hoists by construction
(21B(3)), the giv-initialiser route is closed by laws 1-3 above, and W74/W75
already measured the sched1 fixpoint (fences/decl-order inert).  Under the
no-post-compile-edit policy this is a documented floor receipt unless a future
wave finds a cse-proof spelling with stored benefit in [5..11].

## 3. BuildHorizon [335-338] RMW1 tag-first — the pp $a1-vs-$a2 rotation MECHANISM READ (instrument receipt; not landed)

Tag-first (`*(u_int *)p = *(u_int *)p & 0xff000000 | *pal & m24;`) reproduced
at **36 @473** (W75's number).  `tools/rtl_dump.py` on the sibling in that
basin (-dg -dl; the .greg/.lreg pair) settles the rotation WITHOUT the
instrumented lab:

- **pp = pseudo 214**, a global allocno served 5th of 29; its conflict list
  carries hard regs **2 3 4 29 only** — find_reg's ascending scan hands it
  **$a1** (first free).  Retail's pp sits at $a2, which requires a $a1
  conflict we do not have.
- **the 0xff000000 mask = pseudo 353** — in the tag-first form it is
  generated FIRST in RMW1, so **loop.c hoists IT to the preheader** (insn
  1399 sits in the preheader region; W72(B)'s first-generated-movable law,
  now seen from the RTL side).  As a call-crossing global allocno it LOSES
  (every callee-saved reg taken — 353 absent from the disposition table) →
  spilled → **reload rematerializes it into pool reg $t1** (insn 1439,
  pattern -1 = reload-inserted).
- Retail instead keeps 0xff000000 **block-local**: local-alloc seats it at
  $a1 (after v0/v1/a0), which (a) puts $a1 into pp's conflict set → pp lands
  $a2, and (b) leaves $a1 zero-use at order_regs_for_reload time.  The whole
  4-register picture (pp/mask/scratches) follows mechanically from WHERE the
  mask constant lives (24E(1) pool law + 22A-style LICM budget).
- **NAMED NEXT ANGLE (not run — scope order):** make the tag-first
  0xff000000 LOSE the LICM budget to m24 — 23A(3) lifetime/statement-count
  dial or 21E(5) first-occurrence opacity fence on the literal.  If the mask
  stays block-local, the pp rotation and the W75 sibling-basin load-order win
  (10 @473) should compose.  W75's falsified device list (clobbers on the pp
  launder = uniform +4, bad_spill_regs) is UNAFFECTED by this route — it
  never touches an asm register list.

## 4. Files / hygiene

- `scratchpad/w76/`: `a8probe.py`, `a8apply.py`, edit lists `e_giv1..9`,
  `e_tag1.py`, dumps `sbs_giv{1,4,5,7,8}.txt`, `posmis_v6.txt`,
  `a8_gprobe.txt`, `tag1_dump.log`, `hrzskuw76.base` (session-start snapshot,
  kept for provenance).
- Sibling TU `recon/game/psx/hrzskuw76.cpp` DELETED (with its `build/` object
  and `scratch/rtl/hrzskuw76.*` dumps) — no duplicate-symbol hazard left.
- TU banner receipts NOT appended this wave: the shared TU is under active
  concurrent edit by the user's session; this file is the receipt of record.
- No git operations, no build.py rows, no pins, no devices landed.
