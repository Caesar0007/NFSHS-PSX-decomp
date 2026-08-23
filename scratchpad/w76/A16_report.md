# W76-A16 — libetc INTR belt (`recon/syslib/psx/libetc/INTR.c`, cc1_272 lane)

STEP 0 done: full read of `reference_mips_isa_asm.md`, full read of
`reference_psx_cpp_reconstruction_methodology.md` (all 1018 lines, paged), catalog
§§19–24 (tail rows 19A..24F read in full), `scratchpad/w76/BRIEF.md`,
`scratchpad/w75/A16_report.md` + every `/* W7x-* */` receipt block in the TU.
Memory dir untouched.  No git commit/push/stage.  build.py NOT edited (its
pre-existing uncommitted user/W75 hunks verified intact — my session added zero
hunks).  No TEXT_MOVES/RA_SINK/SLOT_UNFILL/BRANCH_RETARGET anywhere (policy 1).

## Headline — THE TU IS COMPLETE: 13/13 PASS

| fn | baseline | final | note |
|---|---|---|---|
| `_set_intr_callback` | 4 @82/82, posmis 2 | **PASS 82/82** | **PIN-SEALED** (1 seat pin `$6` + tied launder) |
| `_intrhand` | 20 @116/116, posmis 18 | **PASS 116/116** | **PIN-SEALED** (2 seat pins `$3`,`$2`; six-ingredient joint cell) |
| whole TU | 11/13 | **13/13 PASS** | gated 2× after each landing; **zero PASS→FAIL**; `slotcheck` bad = 0 |

Both seals verified twice per-fn AND at whole-TU level; `tools/posmis.py` reads
PASS/PASS; `tools/slotcheck.py` on the freshly built object: `bad = 0` (mandatory
after asm devices — both landed forms carry zero-insn `__asm__`).

## Orchestrator item: the xenogears `-O3` vendor-identity probe — FALSIFIED

xenogears' PSY-Q preset builds libetc at `-O3 -G0` (aspsx 2.56).  Measured via
`vprobe_flag` + `PER_FN_FLAG_SPLICE_272` on BOTH fns (the lane is already `-G0`,
so `-O3 -G0` ≡ `-O3`): `_set_intr_callback` 4→4, `_intrhand` 24→24 (rung-less
region), fenceless body 12→12.  Also swept (fenceless × {2.7.2, 2.6.3} ×
{plain, `-g -gcoff`, the full sotn cc1-psx-26 flagset
`-w -funsigned-char -fpeephole -ffunction-cse -fpcc-struct-return -fcommon
-msoft-float -mcpu=3000 -fgnu-linker -g -gcoff`}): all six cells emit
byte-identical arm words (`.s`-level check, `scratchpad/w76/a16_dumps/setcb_*.s`).
The twin repos match THEIR OWN 4.0/3.x-era streams (W67: the member was rebuilt
between revisions); their configs do not transfer.  Axis retired with receipts.

## 1. `_set_intr_callback` 4 → PASS — the mechanism, finally read to the bottom

The W75 named angle ("which construct still reaches cse_insn:6672 with
src_const == (symbol_ref g_intr)") was run with the 272-lane's own RTL dumps —
the lane's PsyQ 4.0 CC1PSX accepts `-dr/-ds/-dt/-dc` (`.rtl/.cse/.cse2/.combine`
dumps; new lane fact, `scratchpad/w76/a16_dump.py`).  Three findings, each
correcting a banked claim:

1. **W75's premise was wrong: cse DOES see a bare-symbol SET.**  Pre-cse RTL
   (insn 46) carries `(set reg86 (symbol_ref D_80134AF8))` for the 'm' fence's
   base — expand materializes an "m"-constraint address at expand time (only
   plain `"r"(&g_intr)` constants defer to reload).  And cse1's output is
   ALREADY retail-shaped: BOTH arms read `enabled` as `(plus reg81 48)` off the
   struct base (use_related_value working exactly as W75 described).
2. **The real villain is cse.c:5693 `from_plus` RE-ASSOCIATION, in cse2** (the
   `.cse` vs `.cse2` dumps pin it): any pseudo whose cse class carries
   `(plus regCB -4)` — which every plain-C `&g_intr` acquires, because
   use_related_value REWRITES its set into exactly that form — has its
   `(plus reg 48)` uses folded onto the cb base (`48-4=44`) via
   `lookup_as_function(folded_arg0, PLUS)` + constant re-association.  That is
   what un-bases both arms, and why W71's `ctl` cells scored la-and-worse:
   find_best_addr (W74's law) was never the applier.  This also explains the
   W72 fence's DEAD `$a2`: its base enters the table carrying the `-4` form, so
   every use folds away from it.
3. **The escape is an asm-OUTPUT: unrecordable in cse.**  A tied zero-insn
   launder makes the laundered pointer's class PLUS-free, so from_plus cannot
   fire on arm 1 — while arm 2's plain access still folds to `44($a1)` =
   retail's exact mixed pair, at count 82 with the addiu landing in the beqz
   delay slot like retail.

**Measured ladder to the seal** (every cell gated, ~20 cells, all reverted):
ctl+launder no-clobber 7 @83 (reload tie copy `move $4,$6`; combine_regs
refuses a global-allocno source, 19B); + 20B clobbers `"$4","$5"` 2 @82
posmis 3 (clobber grid: `$4` 7, `$2$3$4` 7 → seat falls to $5, `$4$5` 2,
`$2$3$4$5` 2) — the residual 2 is the DEVICE'S OWN artifact: post-alloc the
`$4` clobber anti-deps the cb store (`sw` reads hard $4) and sched2 hoists it
above `li/sllv` (retail order li,sllv,sw); launder position: arm-1 head 2,
after-cb 2, after-nNewMask 12, pre-branch 29 @81 (arm 2 collapses onto the
opaque reg); named `bit` input 12, `"r"(1<<idx)` input 12 (recolor);
statement swap 2; `-fno-schedule-insns2` splice 16.  The clean seat needs
$2..$5 denied at the asm WITHOUT clobbering $4 — no zero-insn C vehicle exists
(the not-yet-colored global slot-ptr is invisible to local-alloc's scan,
24E-W74, so $4 always reads free).  **Last resort per the policy ladder
(a)→(d) exhausted: `register IntrState *c2 __asm__("$6")` seats the launder
output in retail's $a2 → PASS 82/82, zero added insns, no clobbers, no sched
artifact.**  Landed with a loud receipt block; PIN-SEALED.

## 2. `_intrhand` 20 → PASS — the seven-wave pend wall falls as a JOINT CELL

The W75 named angle ("make `*sp` land in $a0") plus the same
invisible-global-allocno lens from target 1.  W74-A17(2) had already proven no
C shape can make $v0/$v1 busy at the derefs' births (fn-scope pend anchors are
global allocnos, invisible to local-alloc's `find_free_reg` scan,
local-alloc.c:2214).  ~250 clean cells over W60..W75 + this wave's flag/corpus
falsifications = the clean ladder exhausted.  The seats were bought with two
pins, and with the seats fixed, TWO previously-falsified structural pieces
snapped in (they had been abandoned only because the un-pinned homes rotated):

**The six load-bearing ingredients** (ablation-priced; drop any one → FAIL):
1. `register unsigned short en __asm__("$3")` (retail's $v1 seat) — without: 20
2. `register volatile unsigned short *mp __asm__("$2")` ($v0) — without: 36
   (both dropped: 34)
3. the W75 cast store `*(unsigned short *)((char *)state + 2) = 1;`
   (MEM_IN_STRUCT_P clear → kills the true_dependence hoist) — without: 16
4. entry order `sp; en; store; mp` — mp-first: 18
5. loop order `sp; en; mp` — unchanged order: 4
6. retail's EN-INNER tree `pend = *mp & (en & *sp)` at BOTH sites
   (W74-A17(1)'s stream read; scored 38-46 un-pinned) — EN-OUTER: 18

Result: PASS 116/116 — including `lhu a0,0(a0)` / `lhu v0,0(v0)` (each deref
reusing its own pointer's dying register) and the closing-test pair.

**The 2.6.3 ver-splice rung is now INERT**: the sealed fn PASSes with AND
without the `PER_FN_CC1_VER_SPLICE_272` row (verified by an in-memory table
pop) — the pins also fix the closing-test `lhu` pair the rung was bought for.
The row stays per W76 policy 3 ("existing wired build.py rows stay"); the
receipt in the TU notes its inertness so a future wiring cleanup can drop it.

## 3. New laws / corrections for the catalog (all gcc-source-cited + dump-verified)

* **24C-3 EXTENDED — `use_related_value` is only half the chooser: cse.c:5693
  `from_plus` re-association overrides it in cse2.**  A base pseudo whose class
  carries `(plus regOther K)` has every `(plus base K2)` use re-associated onto
  regOther (K2+K folded) — a class-CONTENT fact use_related_value's oldest-wins
  never sees.  The zero-insn escape: define the base as an ASM OUTPUT (tied
  launder) — asm sources are unrecordable, the class stays PLUS-free, and the
  fold cannot fire.  Discriminator dumps: `.cse` (retail-shaped) vs `.cse2`
  (folded) — one run.
* **The 272 lane is NOT instrument-dark for RTL streams**: PsyQ 4.0 CC1PSX
  accepts `-dr -ds -dt -dc -dL -dl -dg` (rtl/cse1/cse2/combine/loop/lreg/greg).
  `scratchpad/w76/a16_dump.py` drives it with the lane's exact flags.
* **20B clobber side-effect, post-alloc face (extends 22B-1/24D):** a launder
  clobbering `$N` anti-deps every insn that READS hard `$N` after allocation —
  sched2 then hoists those insns above the asm.  A clobber whose denial target
  is also a LIVE hard reg in the block buys the seat but perturbs the schedule;
  the artifact is invisible pre-alloc.  (This is why the `"$4","$5"` cell
  plateaued at 2 @82: the fix and the perturbation were the same clobber.)
* **Seat-pin composition law (both seals):** when the missing occupancy is a
  global allocno invisible to local-alloc (24E-W74), a `register ... asm("$N")`
  seat pin is composable with the structural levers the un-pinned basin
  falsified — re-price the WHOLE falsified structure grid after pinning (the
  EN-INNER tree went 38→PASS; the tree, order, and cast cells all flipped from
  inert/worse to load-bearing).  Price basins, not axes (23B-1), now with pins
  as a lawful axis.
* **-O3 axis (new, falsified here):** first `-O3` probe in the project;
  `optimize=3` is inert on both fns in this lane (and the flag-splice
  mechanism handles `-O2 ... -O3` last-wins cleanly).

## 4. Falsified this pass (all gated, all reverted)

_set_intr_callback: -O3 (fence 4 / fenceless 12), the 6-cell
{2.7.2,2.6.3}×{plain,-g,-sotn-flagset} sweep (arm words byte-identical),
ctl-without-launder rebuild 7 @83, clobber grid (above), launder position grid
(above), named-bit / shift-input variants 12, statement swap (inert),
-fno-schedule-insns2 16.  _intrhand: pins-on-shipped-basin 26, pins-minus-mp
36, pins-minus-en 20, no-pins joint cell 34, plain-store joint cell 16,
mp-first entry 18, unreordered loop 4, EN-OUTER tree 18.

## 5. Files

* Landed: `recon/syslib/psx/libetc/INTR.c` ONLY (two seal edits + receipt
  comment blocks; byte-mode CRLF-preserving writes; re-read before each write).
* build.py: untouched by me (user/W75 uncommitted hunks preserved verbatim).
* Scratch (untracked, `scratchpad/w76/`): `a16_dump.py` (272-lane RTL-dump
  driver, promotable), `a16_cell.py` (edit+env-splice+gate probe),
  `a16_e_*.py` / `a16_i*.py` (cell edit files incl. the ablation set),
  `a16_dumps/` (`.rtl/.cse/.cse2/.combine` receipts for base/ctl/c2/p1 +
  the 6-cell flag-sweep .s files), `a16_i2_sbs.txt`, tugate baselines.
* No probe TUs in `recon/**`; no leftover `.w76tmp` files; `git status` on
  syslib shows only INTR.c.

## 6. PIN-SEALED ledger (per policy 2 — counted separately from clean seals)

1. `_set_intr_callback` — 1 pin (`c2` → `$6`), zero clobbers, zero insns;
   receipt block lists the exhausted (a)–(d) ladder.
2. `_intrhand` — 2 pins (`en` → `$3`, `mp` → `$2`), zero insns; six-ingredient
   joint-cell receipt with full ablation table.

Clean seals this belt: 0.  PIN-SEALED: 2 (= the TU's last two fns; INTR.c
13/13 COMPLETE).
