# W76-A5 — draww-A belt report

Unit `game/psx/draww`, TU `recon/game/psx/draww.cpp`. No git operations, no memory-dir
writes, no build.py edits, no pins, no new devices. Probe work done exclusively on an
untracked temp sibling `recon/game/psx/draww__a5probe.cpp` (byte copy of the live working
tree, baseline-verified bit-for-bit before every sweep, DELETED at the end — fleet rule).

## Headline

| fn | baseline | final | count | notes |
|---|---|---|---|---|
| `DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache` | 8 | **PASS 268/268** | EXACT | **CLEAN SEAL, device-free** |
| `Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark` | 20 | 20 | EXACT 353/353 | m-first basin + PIN lane priced to exhaustion; instrument angle named |
| `DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss` | 8 | 8 | EXACT 588/588 | fold-back family falsified; instrument angle sharpened with a new fact |

TU gate: baseline **29/35** → final **31/35 PASS** (my BuildSpikeBelt seal + agent A6's
`DrawW_BuildCustomObjectFacets` seal landing concurrently in the same working copy —
verified by git diff that our edits do not overlap). Gated TWICE at the end, byte-identical
FAIL lists. **Zero PASS→FAIL anywhere.** No asm was added anywhere (the seal is pure C), so
no slotcheck obligation was triggered.

---

## 1. `DrawW_BuildSpikeBelt` 8 → PASS — residual (ii) closed, with a compiler-source law

**The residual** (W75): the three copy-loop preheader cursor slots — retail emits the byte
cursor (`addu a2,zero,zero` / `li a3,72` / `li a3,144`) BEHIND the hoisted
`addiu $tN,$sp,16` base (and behind the dest giv in loop 1), and no source position of the
explicit `kk` biv can reach that slot (every entry-block statement precedes loop.c's
preheader insertions).

**The reading that cracked it:** retail's cursor inits are **loop.c giv inits**, i.e.
chain-emitted AFTER the hoisted movable — retail carried no `kk` at all. The known trap
(w61: full index form `vertex3d[i+8]` = 105 @259, and this wave `(i<<3)+(int)vertex3d+K` in
one expression = -1 insn/loop) is **giv combination**, and the refusal condition is in the
source: `combine_givs_p` (gcc-2.8.1 loop.c:5647-5674) merges two givs only when (a) their
mult_val AND add_val are identical, or (b) g2 is DEST_ADDR and `express_from(g1,g2)` is a
**valid memory address** no costlier than a register. With the sp-relative base folded into
the giv, two cursors differ by a constant → `express_from` = `(reg+8)` = valid address →
merged (the lost insn). **Naming the BARE OFFSET as its own int giv** —

```c
so = (i << 3) + K;                       /* K = -8 / 0x40 / 0x88 */
p  = (CCOORD16 *)((int)vertex3d + so);
```

— makes `express_from` yield a 3-term sp-based expression → `memory_address_p` fails →
both cursors survive, and `so`'s init is emitted by loop.c in retail's slot. Loop 1 needs
only this (dest stays the ARRAY_REF; retail walks the dest pointer there). Loops 2/3 (dest
also base+cursor in retail) additionally need the DEST offset as its own explicit giv
**defined before `so`** (giv discovery order = body insn order; `so`-first swaps the
a3/a2 pair, 44 diffs) with the two address adds written p-then-q:

```c
dof = (i << 3) + (K+8);  so = (i << 3) + K;
p = (CCOORD16 *)((int)vertex3d + so);  q = (CCOORD16 *)((int)vertex3d + dof);
q->x = *(u_short *)&p->x + wx;  ...
```

**Measured (probe TU, count @268/268 unless noted):** explicit-kk baseline 8 · named base
`int b`/`CCOORD16 *b` rerouted through the body +1 insn/loop (17/18 @269/270) · one-expression
giv form 15/28/26/44-75 @265 (merge, −1/loop; loop1-only cell = 15 → 6 after bare-offset) ·
bare-offset giv loop1 only **6** · + two-giv ds loops 2+3 **PASS** · two-giv sd (so first) 44.
m2c corpus (`func_800CA520.c`, `var_a3 = 0x48/0x90`) cross-checks the cursor semantics; the
rewrite is arithmetically identical to the old `kk` walk (so/dof ≡ 8(i+8), 8(i+9), 8(i+17),
8(i+18)).

**New catalog-row candidates:**
1. *(24-family, loop.c)* **GIV-MERGE ESCAPE = BARE-OFFSET NAMING**: a preheader cursor slot
   behind the hoists is loop.c-emitted; to keep TWO constant-difference cursors un-merged,
   name each cursor's bare offset (`so = (i<<3)+K`) so `express_from` is not a valid
   address (loop.c:5647-5674 receipt). The base-in-giv spelling always merges (−1 insn).
2. **GIV DISCOVERY ORDER** is a register-handout dial: reduced-giv regs follow the order the
   giv-defining insns appear in the body (`dof` before `so` ⇒ a3=src/a2=dst as retail).

## 2. `Draw_kCtrlSkidmark` — stays 20; the m-first basin AND the pin lane are now priced shut

Residual 20 = prologue emission order (m/t materializations at block top vs before first
use, + the `lw s5,48(s4)`-vs-`48(a0)` base, + the row-0 third chain riding along).
Emission here = SOURCE order at priority-0 ties (both scheds preserve their input, W75), so
the only route is making retail's m,t-first SOURCE order coexist with the w72 grey/m/ccount
priority band. Everything measured this wave (probe TU; falsified, do not re-run):

* **ccount-read-through-m ref transfer** (`((Draw_tCtrlSkidmark *)m)->count` — reproduces
  retail's `lw s5,48(s4)`) × retail order × fence grid (grey 2-3 × m 0-1 × t 1-2) ×
  {adjacent, tail} fence position: **58–94**. New independent breakage discovered: with the
  count read through m, cse MERGES fskid/m (offset-0 base) into one pseudo → the parm loses
  its ARG-home spill (`sw a0,88(sp)` → `sw s4,48(sp)`, frame 88→96).
* **Launder on m** to break the merge: the identity addu materializes (+1/2 insns, 23B-2)
  — 62–125 @354/355.
* **Read-only fence on fskid** to force the parm live: count drops to 352 — 73.
* **PIN LANE PRICED AND FALSIFIED** (so no last-resort pin can land here):
  `register int ccount_local asm("s5")` × retail order × ccM/ccF × fence grid = **58–108**.
  The pin buys the band but not the merge/spill structure.
* **20B denial on the row-0 temps** in the current basin (launder+`$2` clobber on r2/r0 to
  flip the third chain v0→a1): 24–29.
* **Per-fn FLAG-SPLICE lane** (allowed compiler-input; via the W61_TABLE hook):
  -fno-delayed-branch 66 @363 · -fno-thread-jumps 21 @352 · -fforce-addr 71 @362 ·
  -G8 21 @352 · -mno-split-addresses 64 @349 — all worse.
* Corpus: no EA skidmark sibling (CTR-in-C `VehGroundSkids` is a different toolchain/idiom).

**Named next angle (instrument task, not probe task):** diff the -dg allocno tables of the
current basin vs the m-first basin and identify the single allocator input (ref/live/
conflict-list) retail's basin satisfies that ours cannot; the receipt block in the TU
carries the full falsification table.

## 3. `DrawW_SubdividFacet` — stays 8; the fold-back family falsified, instrument fact added

The last untried source family: spell v4's index off the ALREADY-mutated `n` so the
statement can sit chain-after the new-n while cse folds the constant back to the old
register at zero insns. It does not fold — cse cannot simplify
`(plus (subreg:HI promoted-n) -K)` back through the PROMOTE_MODE truncation:

* `v4 = &r_div->v[(short)(n - 5)]` after `n = n + 4` ... 101 @589 (+1)
* `v4 = &r_div->v[(short)(n - 1)]` between q-block and `n+4` ... **9 @589** (+1 — order-wise
  the closest basin yet, exactly one dead addiu over)
* `(short)(n - 1)` right after `n+1` (w70 cell re-priced) ... 26 @588

**New fact for the named instrument:** retail's interleave
(`addiu n+1; sll s4; addiu n+4; sra; addu`) places `addiu t8,a3,4` INSIDE v4's 3-insn
scale chain — no statement order can produce that at expand time; with W75's proof that
both scheds preserved their input, the divergence must be created between expand and sched2
on the retail side only. Check the RELOAD-inserted ARG-home reloads first (the `lhu s4`
reload is a reload-pass insn, so sched2's luid picture differs from sched1's) before any
further source probing. Receipt block updated in the TU.

## 4. Edits made to `recon/game/psx/draww.cpp` (all byte-mode, file re-read before each write)

1. `DrawW_BuildSpikeBelt`: the three copy loops rewritten to the bare-offset-giv forms
   (loop 1 single `so`; loops 2/3 `dof`+`so`, ds order) + the W76-A5 receipt block with the
   loop.c citation and full price table. 8 → **PASS 268/268**.
2. `DrawW_SubdividFacet`: receipt-only (the three fold-back falsifications + the new
   reload/luid fact).
3. `Draw_kCtrlSkidmark`: receipt-only (m-first basin + pin-lane + flag-lane falsification
   tables, the cse fskid/m merge finding, the instrument ask).

One landing bug caught by the gate mid-landing: the loops-2/3 soff/doff arguments were
transposed on first application (gate 8 with `-li a3,80`); fixed immediately, gate PASS.

## 5. Files

`scratchpad/w76/`: `a5_skid_cell.py`, `a5_skid_r2.py`, `a5_skid_pin.py`,
`a5_skid_launder.py`, `a5_skid_mfirst2.py` (Skidmark sweeps), `a5_sb_giv.py`,
`a5_sb_base.py`, `a5_sb_offgiv.py`, `a5_sb_dof.py` (SpikeBelt), `a5_sf_fold.py`
(SubdividFacet), `A5_skid_base.txt`, `A5_skid_sbs.txt`, `A5_sb_sbs.txt`,
`A5_skid_cell_results.txt`, `A5_baseline_tugate.txt`, `A5_final_tugate{1,2}.txt`
(byte-identical). Probe TU deleted.
