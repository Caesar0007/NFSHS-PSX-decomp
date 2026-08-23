# W75-A7 — drawc belt report (unit `game/psx/drawc`, TU `recon/game/psx/drawc.cpp`)

## Headline

| fn | baseline | final | note |
|---|---|---|---|
| `DrawC_Prim__FP10matrixtdef…` | **16** diffs / posmis 10 (count-exact 1389/1389) | **PASS 1389/1389** (posmis 0) | **SEALED**, gated 5x, source-side only |
| `DrawC_PrimClip__FP10matrixtdef…` | **66** diffs / posmis 341 (count-exact 1877/1877) | **49** diffs (ours 1876 / oracle 1877) | −17 gate, one **real behavioural bug** fixed |

TU: `18/20 PASS` → **`19/20 PASS`**. Zero PASS→FAIL anywhere; whole TU gated twice at
the end (plus 3 extra confirmation runs). `brdist`: `DrawC_Prim` **clean**; only the
still-failing `DrawC_PrimClip` shows offset divergence (4 rows, expected on a FAIL).
Ghidra-ism / bare-VA scan on the TU: 0.

**No `build.py` rows are wired by this belt** (see "Policy compliance").

---

## Policy compliance (mid-belt orchestrator directive)

Before the directive arrived I had wired **4 `PER_FN_TEXT_MOVES` rows** into
`tools/build.py` (2 for `DrawC_Prim`, 2 for `DrawC_PrimClip`) inside the existing
`"recon/game/psx/drawc.cpp"` key — deliberately merged into that key, never a second
key, because of the 12F duplicate-key hazard (the `PrimStart` rows live there).
On receipt of the directive **all four rows were removed** with a surgical
byte-level splice that touched only my own block; `ast.parse` clean, and the
pre-existing rows (`DrawC_NightHeadlight`, `DrawC_PrimStart`) plus the peer agents'
concurrent edits to `build.py` (W75-A14 SPRINTF removal, W75-A16 INTR rung,
the psxcontroller row removal) are all intact. `grep -c "W75-A7" tools/build.py` = 0.
`DrawC_PrimStart` still PASSes.

The rows are documented (as *historical, do-not-wire*) in the in-source receipt.
They measured `Prim 16 → 12` and `PrimClip 66 → 62`, brdist clean — but the
source-side lever found afterwards ((B) below) closes the **same** class for free
and goes further, so **no row ask is outstanding for that class**. The one place a
row could still buy something is the `PrimClip` switch-dispatch `li $2,8` eager
steal (2 diffs + the missing `nop`); I am **not** asking for it.

---

## Landings

### 1. `DrawC_Prim` — (A) the id-morph SPLIT × the `i` REF-STEP is ONE CELL (23B-1)

The 12-of-16 residual was `sll $v0,$tN,3; addu $tN,$v0,$s1` (ours) vs retail's
in-place `sll $tN,$tN,3; addu $tN,$tN,$s1` at the 5th (fused) id-morph site.
The **split** spelling is what mints the in-place pair — and it had been measured
at **198 / 206 / 216** across **four waves** (w55-a9, w62-a14, w63-a14, w72-a3
"STRONG floor", w74 "do not re-run"), always as a single axis.

Compiler-source proof of why (gcc-2.8.1 `global.c:594` `allocno_compare`,
`pri = floor_log2(refs)*refs / live * 10000 * size`; receipts
`scratchpad/w75/A7_alloc_fused.txt` / `A7_alloc_split.txt`, allocsim **MATCH 97/98,
order-vs-dump IDENTICAL** on both dumps):

```
fused  i p149 55/829 = .3317 > id2 p562 12/153 = .2352 > id1 p561 = .2307 > id0 p560 = .2292   (== retail)
split  id2 .4183 > id1 .4102 > id0 .4076 > i .3317                                             (one-seat rotation)
```

The split adds **+2 mentions ⇒ +4 loop-weighted refs (12→16)** to each id, crossing
the `floor_log2` 3→4 step and lifting all three ids above the fn-scope counter `i`.
Everything downstream (`i` $t2→$t9, the `li 36/38` constants, the s-band) follows.

**Cure = restore `i` to the head of the order**: the what-if ladder puts the crossing
at `refs ≥ 64` (`5*63/829 = .380 < .4183`, `6*64/829 = .4632 > .4183`), i.e. **+9**
over 55. The site is at loop depth 1, so `flow.c` weights each mention ×2 ⇒
**five** read-only fence operands, not four.

**PREDICTED == MEASURED**: n=3 → 194, n=4 → 194, **n=5 → PASS**, n=8 → PASS, n=10 → PASS.
Position is a separate dial and was swept: at the loop head or after `facet = …` the
fence costs a real insn (1390 — it walls off a delay-slot fill); only the two
placements bracketing the morph block are zero-insn, and both PASS at n ≥ 5.

Device-removal re-test (23B-3): fused morph + no fence = **12**; split + no fence =
**194**. Both halves load-bearing — a genuine joint cell.

Falsified on the way (each measured at the 16 basin): `idN *= 8, idN += (int)sd;`
(comma), `idN <<= 3; idN += …`, `idN *= 8; idN += …` — **all three are the split**
(198), so the w74 "in-place spelling that adds NO statement" angle is closed;
`(idN << 3) + (int)sd` and `(int)sd + idN * 8` are **bit-identical** to the fused
form (16).

### 2. `DrawC_Prim` — (B) 🏆 THE LAUNDER POSITION IS THE DELAY-SLOT DIAL

The other 4-of-16 class (`addu $9,$3,$0` before the `beqz` in ours, in its **delay
slot** in retail, at both facetFlag sites) had been filed by w72-a5 as *"a DIRECT
COST OF THE LAUNDER DEVICE … a measured, not assumed, trade"* — trading 4 diffs for
the 20+ the 20B launders buy.

**It is not a cost of the device, it is a cost of WHERE the device sits.**
`reorg.c:685` `stop_search_p` fires at **any** asm, so a zero-insn launder standing
between `facet_flag = ff;` and the guard branch walls reorg's backward scan off from
the copy, and it eager-steals the following `srl $2,$3,4` from the target thread
instead. Moving **both launders INSIDE the `if (hi != 0)` body** keeps their only
real job (stopping cse collapsing `ff`/`facet_flag`, which is what would delete
retail's copy) while clearing the scan path.

`4 → 0`. **SITE-JOINT**: the device must land at *both* facetFlag sites — either
alone leaves 2 (`G_L6_ORIG` = 2, `G_ORIG_L6` = 2, `G_L6_L6` = **PASS**).
Falsified at this basin: launder *before* the copy (34), only the `ff` launder
before (34), read-only fence instead of launders (16), mixed forms (107–121 @1390).

> **New transferable law (catalog candidate):** *the 20B launder's POSITION is a
> reorg dial independent of its cse-breaking function.* A launder that must survive
> to keep a copy alive can usually be pushed **into the guarded block** the copy
> feeds — the cse collapse is still broken, but reorg's backward scan from the guard
> reaches the copy. Any receipt that prices "the copy-in-slot residual" as an
> inherent cost of a launder should be re-opened.

### 3. `DrawC_PrimClip` — 🔴 REAL BEHAVIOURAL BUG (and it *was* the "coloring" class)

`gte_ldv0((char *)sd + 0xd0)` in loop-2 loaded the vector to transform from
**`tV[0]` forever** instead of the **current** `tV`. Oracle proof: its base `$a3` is
the same register the loop stores `tV->x` through, and it carries `addiu $a3,$a3,8`
in the loop's `j` delay slot. From iteration 2 on, the recon re-transformed vertex 0
for every vertex.

cc1 had been reporting the defect all along: a *bogus loop-invariant* address had to
be hoisted and **copied** (`addu $10,$a3,$0`) because `$a3` is mutated. That copy —
plus "`-1` parked in `$t3` instead of `$t2`" — is exactly the "case-1 loop head
(3 + 4)" residual the w72/w74 receipts filed as a coloring class and declared "naming
either address as a local is a net loss".

Fix `gte_ldv0((char *)tV);` → **58 → 49**, −5 diff lines. The count goes 1876 vs 1877
because the copy genuinely was a surplus instruction; the compensating −1 is the
separate switch `li $2,8`/`nop` class, which had been masking it.

### 4. `DrawC_PrimClip` — loop-1 (a)+(b) port RE-PRICED (04Z)

The w53-a2 receipt recorded the `DrawC_Prim` loop-1 shape as *"MEASURED NO-OP on
DrawC_PrimClip (626 → 626), NOT landed"*. Basin-relative. At the post-launder basin
it is **−4**: one `COORD16 *vt` cursor + a block-local `{t1,t2,t3}` triple instead of
the two-cursor `psVar8`/`vert_yz_iter` form, with `vt` assigned **above** the two
`gte_Set*Matrix` macros. `loop.c` then strength-reduces the y/z cursor itself, so its
init `addiu $a1,$s3,4` is emitted in the **giv group — after** the LICM movables
(`li -1`, `addiu $t1,$s1,172`, `addiu $t0,$s1,156`), which is where retail has it;
the source-assigned pointer was emitted in the entry block, before all three hoists.
`vt` assigned *below* the macros (K2/K3) is +2.

### 5. `DrawC_PrimClip` — the launder-position lever (as in 2)

`66 → 62`, posmis 341 → 338, both sites jointly.

---

## 🏆 Quantified required-delta certificate — the `PrimClip` t1↔t8 permutation

This is the dominant remaining class (19 of the residual positions: `id2` and
`facet_flag` in the case-8 loop, plus `id2`'s `lbu`/`sll` emission order).
allocsim on the **current** dumps (`scratchpad/w75/A7_now.{greg,lreg}`,
**MATCH 107/107, order-vs-dump IDENTICAL**):

```
p816 id0        refs 18 live 199 pri .3618 -> $t3   (retail $t3  OK)
p817 id1        refs 18 live 196 pri .3673 -> $t2   (retail $t2  OK)
p818 id2        refs 18 live 200 pri .3600 -> $t8   (retail $t1)
p819 facet_flag refs 18 live 129 pri .5581 -> $t1   (retail $t8)
```
`facet_flag` identified from the .lreg RTL (`insn 3749 (set (reg/v:SI 821) (asm_operands …))`
— the launder's output), not guessed. Retail's serving order is
`p818 > p817 > p816 > p819`. **Minimal joint delta** (what-if verified; all four
seats land exactly on retail's):

```
p818  REG_N_REFS      18 -> >=19   (one loop-weighted mention = +1 unweighted = +2)
p819  REG_LIVE_LENGTH 129 -> >=200 (ties break by lower pseudo, 818 < 819)
      OR  REG_N_REFS  18 -> <=14   (two mentions removed)
```

**Falsified realizations (all measured this belt — do not re-run):**
* multi-operand read-only fences on id0/id1/id2 — the full ref ladder, 7 cells
  including the model's own (5,5,6): **68 … 118**, all worse than 62. The fence
  insn's own live-length contribution rotates the rest of the table, which a
  single-pseudo what-if does not model. *(Method caveat worth banking: a
  reqdelta/what-if receipt is only valid for a dial that does not itself add an
  RTL insn — fences do.)*
* 20B hard-reg clobbers `"$24"` / `"$11"` / `"$10"` on a site-local inline copy of
  the `DRAWC_VTZ` expander template: **+1 insn each** (265…291). `"$9"` bit-inert
  (facet_flag is not yet live at the VTZ).
* 20B clobber on `facet_flag`'s launder at that site: **+1 insn** (267…295).
* the **full 6×6 id-load × id-morph statement-ORDER sweep** (36 cells): the shipped
  `(id2,id0,id1)` / `(id2,id0,id1)` pair is the joint minimum — 66; nothing beats it
  (best alternatives tie at 66 with worse posmis).

**Named next angle:** a *zero-insn* way to add ≈71 to `facet_flag`'s
`REG_LIVE_LENGTH` — a 15A foreign-operand fence lengthens every range crossing it by
one insn, so it must sit ~70 RTL insns past `facet_flag`'s last use — **or** a
−2-mention reshape of its nine mentions. Do **not** re-run the ref ladder on the ids.

---

## `PrimClip` residual map (49 diffs, ours 1876 / oracle 1877)

| class | lines | status |
|---|---|---|
| t1↔t8 permutation (id2 / facet_flag) + id2 emission order | 19 | certificate above |
| switch-dispatch `li $2,8` reorg eager-steal + the missing `nop`, and the `sw $t9,32($sp)` spill position | 6 | dispatch blocks are compiler-generated — there is no source statement at the branch-target thread head to fence (13B/16C cure unreachable) |
| `addiu $a2,$s1,215` one hoist-group late | 2 | angle recorded at the loop: make the UV byte cursor a **giv** anchored at `&sd->tV[0].v` (+215 with `[-1]` for `.u`; `DrawC_Prim`'s typed `Draw_CarVertex *` walker is +214 and must NOT be ported) |
| `li $t3,38` off by one position | 2 | unattacked |

---

## Edits made

* `recon/game/psx/drawc.cpp` — 6 code edits + receipts:
  1. `DrawC_Prim` site-5 morph: fused → split, plus the 5-operand read-only ref-step
     fence on `i` (with the full allocsim receipt in-source).
  2. `DrawC_Prim` facetFlag sites ×2: both launders moved inside the `if (hi != 0)` body.
  3. `DrawC_PrimClip` facetFlag sites ×2: same launder move.
  4. `DrawC_PrimClip` loop-1: single `COORD16 *vt` cursor + block-local triple, `vt`
     assigned above the gte macros.
  5. `DrawC_PrimClip` loop-2: `gte_ldv0((char *)sd + 0xd0)` → `gte_ldv0((char *)tV)` — **bug fix**.
  6. Receipt blocks: W75-A7 summary above `DrawC_Prim`; the superseded/forbidden
     TEXT_MOVES row spec marked DO-NOT-WIRE; the full PrimClip receipt +
     required-delta certificate above `DrawC_PrimClip`; the loop-1 re-price note.
* `tools/build.py` — **net zero**. 4 rows added, then fully removed on the policy
  directive; peers' concurrent edits preserved.
* `scratchpad/w75/` — `A7_probe.py` (edit-apply → verify_asm + posmis → always
  restore, with nth-occurrence support), `A7_sbs.py`, `A7_report.md`, the alloc
  dumps `A7_alloc_{fused,split,clip,now}.txt`, `A7_{now,split}.{greg,lreg}`, sbs
  snapshots `A7_{prim,clip}_*.txt`, and the `e_*.json` edit sets (all untracked names).

## Process notes
* One `tugate` run mid-belt reported a spurious `parse error at end of input`;
  brace balance verified 0 and **five** subsequent runs are identical at 19/20 —
  the known cc1plus intermittent-gate flakiness (08E), not a source defect.
* `rtl_dump.py`'s fixed output path was copied to protected `A7_*` names
  immediately after each dump (a peer was dumping into the same directory).
* Every probe ran through a harness with a `finally:`-restore + a byte-equality
  assert; the TU on disk was never left patched.
