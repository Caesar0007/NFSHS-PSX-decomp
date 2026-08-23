# W75-A4 — hud-misc belt (recon/game/psx/hud.cpp, unit game/psx/hud)

## Result

| function | baseline | final | note |
|---|---|---|---|
| `Hud_BuildMapMarkers__Fi` | FAIL 34 (310/308) | **PASS 308/308** | **SEALED**, gated twice |
| `Hud_BuildCdPlayer__Fii`  | FAIL 54 (475/475) | FAIL **15** (476/475) | 2 named residual items |
| `Hud_RenderTacView__Fv`   | FAIL 13 (72/71)   | FAIL **11** (72/71)  | 1 named residual item |
| `Hud_Init__Fv`            | PASS 624          | PASS 624             | already sealed, no edits |

TU gate: **57/62 → 59/62** (my contribution +1 = MapMarkers; `Hud_BuildTach__Fi` was
fixed concurrently by the w75-a3 session in the same working copy).
**ZERO PASS→FAIL** anywhere. Whole TU gated twice at close (identical both runs).
No `tools/build.py` rows added. No commits, no staging.

---

## 1. Hud_BuildMapMarkers__Fi — 34 → PASS (SEALED)

Three landings, all in-body (each carries its own `MATCH (w75-a4)` receipt).

### Lever 1 — cop loop: AIFlags read hoisted into a block-local placed *between the OT link
### and the cursor bump*  (34 → 21, ours 310 → 309)

The w74 receipt had the mechanism right and the cure wrong. Retail's cop block is

```
[lw carptr][lw AIFlags][addiu bump][andi][beqz][sw cursor (delay slot)]
```

i.e. the flag loads are issued *before* the cursor bump/store. sched1 cannot produce that
for us: the w64 identity launder on `pktcell` makes `*pktcell` a **varying non-struct** MEM,
so `true_dependence`'s fixed-scalar/varying-struct exemption (**gcc-2.8.1 sched.c:830-856**,
the `! (MEM_IN_STRUCT_P(x) && rtx_addr_varies_p(x) && … && ! rtx_addr_varies_p(mem))` clause)
refuses and the load stays pinned below the store.

**NEW LAW — when a device kills a sched1 hoist the oracle performs, do not try to restore the
exemption: remove the NEED for the hoist by putting the load first in SOURCE order.** reorg
then takes the store into the `beqz` slot by itself and both load-delay `nop`s vanish.
POSITION is the dial: the *same* read placed before the whole pktcell block was measured
50 @308 by w74 (the load then lands before the address materialization); after the OT link
it is exact.

### Lever 2 — race loop: the car POINTER and its `carFlags` word, both as block-locals in the
### same position  (21 → 14, ours 309 → 308, count exact)

`cflags` alone is **74 @310**; `car` + `cflags` is **14 @308**. The pointer local is what
keeps retail's single `lw a0,0(s6)` feeding both the `carFlags` read here and the `AIFlags`
read in arm 1 (oracle 244/252).

### Lever 3 — a `"$5"` ($a1) clobber added to the race loop's *existing* identity launder
### (14 → PASS)

The last 14 were an `$a1`↔`$a2` role swap between the cursor-address qty and the `0xff000000`
OT mask (retail mask=$a1, cursor=$a2), plus the mask's `lui` emitted one slot late as a
consequence. Both are block-local qtys, so `QTY_CMP_PRI` decides who is served first and
takes the lowest free register; the cursor's longer live range out-ranks the mask. The
**20B preference-killer used as an AVAILABILITY dial** — clobbering `$a1` on an asm that
already sits *inside the cursor's live range* (22B-1 clobber-live-range law) — denies exactly
that register at **zero instructions**. `"$6"` is inert (14); `"$5","$6"` is 54: the register
choice is the dial, not the presence of a clobber.

### Device-removal re-test (23B-3), all in the PASS basin
race launder → read-only fence 44 @310 · race launder → clobber-only 44 @310 · cop launder
removed 38 @312 · both launders removed 56 @310 · cop launder + an `$a1` clobber 48 @312.
**Both identity launders and exactly one clobber is the minimal device set.**

---

## 2. Hud_BuildCdPlayer__Fii — 54 → 15 (four landings)

### (4) THE FOLD-CONST ESCAPE IS A TWO-LEG CELL — w74 aimed at the wrong K  (54 → 40)

`fold`'s `associate:` block tries **`split_tree(arg0)` first** (fold-const.c:4292) and
**`split_tree(arg1)` second** (fold-const.c:4349). w74 made only the *subtrahend*'s `0x4c`
a mutable local, so leg 1 still fired on `x + dx + 10` and the fold happened anyway
(measured inert, 54). Making only the *addend* mutable lets leg 2 fire instead (64).

**Both legs must be blocked at once**, and `arg0` must additionally be spelled
`x + (dx + dxk)` so its top-level `PLUS` has no constant operand at all (a flat
`x + dx + dxk` re-associates: 62). RTL cse then const-props both carriers back, so the two
locals cost **zero instructions**, and both call sites emit retail's
`addiu v0,s3,10 / lw a1,0(gp) / addu v0,s7,v0 / addiu a1,a1,-76 / subu a1,v0,a1` byte-exact.

Note the count went 475 → 477 here: the previous "count exact" was **two errors cancelling**
(ours was 2 short in this cluster and 2 long elsewhere).

### (1) `artist = 0` — a shared-path store, not a per-arm store  (40 → 36, count exact again)

Retail has exactly TWO `addu s0,zero,zero`: one in arm 3 before its early-exit `bnez`
(delay slot), and one in the SHARED `jal TextSys_Word` delay slot. Writing `artist = 0`
inside each of the three arms gives THREE, because `cross_jump` stops at the arms' differing
`li a0,0x44/45/46` and can never reach a store behind it. **Staging the word id in a local
and putting the single `artist = 0` on the shared path** reproduces retail exactly (each arm
keeps `li a0,K` in its `j` delay slot — the w39 oracle reading stands).
Falsified: reusing the dead `bVar2` as the staging local 75 @476; dropping arm 3's own store
37 @474; hoisting one `artist = 0` above the whole cascade 42 @475.

### (2) The scroll-copy preheader is now BYTE-EXACT  (36 → 33 → 29 → 25 → 23)

Four sub-landings:

* **Global RMW tick loop** (36 → 33). The oracle's loop body reloads *and* stores
  `Hud_gCdScrollTitle` every iteration and there is no post-loop store at all — the loop exit
  branches straight to `dx = 0`. The w50/w72 `scroll` local was **basin-stale**: once
  clusters (1) and (4) were fixed the global form wins, and it is what puts the exit
  `addu s3,zero,zero` and the `slt v1` compare register where retail has them.
  (w72 measured the same shape at 57 @476 in the 54 basin — 21E-1 re-pricing law confirmed.)
* **`lt` local + `"$3"` ($v1) clobber on an identity launder placed BEFORE the branch.**
  Retail homes the loaded `Hud_gCdLastTick` in `$a0`; ours took `$v1`. The launder must sit
  *outside* reorg's fall-through thread — a clobber inside the `if` body eats the
  `addiu lt+4` that belongs in the `beqz` delay slot (reorg `stop_search_p` fires on any asm
  in the thread, reorg.c:685-712). Grid: no local 39 · local, no fence 43 · read-only fence
  + `$v1` 37 · launder, no clobber 43 · **launder + `$v1` 33** · +`$v0` 45 · `$v0` only 41 ·
  `$a0` 41 · clobber inside the body 34 @477.
* **INDEXED-GIV loop shape** (33 → 29, preheader ORDER becomes retail's).
  🔑 The SYM `8c` block for this function declares **no cursor and no counter local** for the
  scroll-copy loop (only `s`, the copy *destination*, at `$a2`). So retail indexed `title`
  and loop.c built the walker as a giv and **eliminated the counter biv** against
  `title + 0x3f` — which emits the bound in the giv/elimination group, i.e. *after*
  `move_movables`' `li t1,32` and `&HudPmx_gShapes` hoists. A declared `p` makes the bound
  test the FIRST movable found and emits it first. (12D-A7 / 23C-4 confirmed on a new fn.)
* **A zero-insn `"m"`-operand fence on `HudPmx_gShapes[0]`, POSITION-swept** (29 → 25 → 23).
  🔑 **NEW: the `m`-fence's POSITION is a movable-DISCOVERY-ORDER dial, not just a ref dial.**
  At the loop top it wins the `$a3`/`$t0` assignment (shapes → `$a3`, bound → `$t0`) but
  pushes `li t1,32` behind the shapes hoist (25). Placed **after the glyph block** it wins
  both and the whole preheader is byte-exact (23). Grid: none 29 · loop top 25 · after the
  bound test 25 · **after the glyph block 23** · both 25 · else-arm head 40 @477 · before the
  digit test 40 @477 · before the loop 32 @477 (there it materialises an address).

### (3) COMPUTED REF-STEP on the tick loop's `lastTick+4` qty  (23 → 15)

The loop body block holds exactly two local qtys: `lt4` (2 refs, live 2) and the scroll RMW
value (4 refs, live 3). `QTY_CMP_PRI = floor_log2(refs)*refs/live` = 1.00 vs 2.67, so the
scroll qty is served first and takes `$v0`; retail serves `lt4` first. **Predicted crossing
at a 2-operand read-only fence; measured n = 0/1/2/3/4/5 → 23/23/15/15/15/15.** Predicted ==
measured (21A-4). The fence must sit *before* the `Hud_gCdLastTick` store — after it every n
costs +1 insn (24 @477).

### Residual 15 — two named items

**(a) +1 insn: a `nop` in the `beqz s1` slot** where retail carries `addu a0,s1,zero`.
GCC-CITED MECHANISM: `fill_eager_delay_slots` only tries the fall-through when
`own_fallthrough` is true (**reorg.c:3936**), and `own_thread_p` (**reorg.c:2196**) returns 0
for **any `CODE_LABEL`** between the branch and the first active insn. Our join carries such
a label; retail's does not — retail's `bnez` from the index>0 arm (oracle 800D66A0) stole the
same insn first and reorg redirected `.L800D672C` past it. Source restructures are
codegen-neutral because jump.c re-normalises the CFG: an explicit `goto` to an added join
label = inert (33 → 33), hoisting the shared title test out of the `else` block = inert
(15 → 15). ⇒ **NAMED ANGLE: this is a LABEL-PLACEMENT item — the `PER_FN_BRANCH_RETARGET` /
`TEXT_MOVES` family (18A), not a source lever.**

**(b) the width chain** `addiu ?,v0,110 / sll / addu / sll / addu ?,?,a3 / lh v0,16(?)` runs
through `$v1`+`$v0` for us and `$v0`+`$v1` for retail. The glyph index is a **global allocno**
(defined in both arms of the digit test) while the address chain is a **block-local qty**, so
`local_alloc` places the chain first and it takes `$v0` unconditionally (16B HARD-REGS-ONLY
AVAILABILITY: a pseudo-held register cannot block the local scan). Falsified this wave: a
separate `g` temp (inert), `g` + identity launder (inert), `g` + `$v1`/`$v0` clobbers
(89-95), `$v0`/`$v1` clobbers before the width line (15 / 95), a 1..5-operand ref-step on `w`
(all inert), the byte-address `(g*20)+(int)HudPmx_gShapes` spelling (inert), in-arm
clobber/fence/launder on `g` or `w` (89-97 @478).
⇒ **NAMED ANGLE: make the glyph index a BLOCK-LOCAL qty (one basic block, one death) so
`local_alloc` orders the two together — a branchless spelling of the `+0x6e`/`+0x43` select
that still emits retail's two per-arm `lbu` re-reads.**

---

## 3. Hud_RenderTacView__Fv — 13 → 11

**Landing: the OT link written as the addPrim `P_TAG` bitfield pair** (the w45 lever already
used in `Hud_BuildMapMarkers` / `Hud_BuildWingmanInterface`) instead of explicit
`& 0xff000000` / `& 0xffffff` masks. With explicit masks `0xff000000` is the first
loop-invariant the body mentions, so LICM hoists it before the `0xffffff` pair (`$s5` emitted
one slot early); the bitfield store generates them in retail's order for free. 13 → 11, count
unchanged. Falsified with the masks kept: swapping the first `|`'s operands 19, both
statements' operands 23, the second only 17. (Both `P_TAG`-first mixes also give 11.)

**Residual 11 = exactly the w74 item, now CLOSED WITH A COMPILER-SOURCE CITATION.**
The entry and tail loads self-temp (`lui v0; lw v0,0(v0)`) where retail separate-temps
(`lui v1; lw v0,0(v1)`), so the body must pay its own `lui/addiu` where retail derives
`addiu v0,v1,%lo` from the still-live high (+1 insn).

🔑 **NEW LAW (local-alloc.c:1864-1867):** `block_alloc` ties the `SET_DEST` to *every*
register that DIES in the insn, and `combine_regs` refuses only when `reg_qty[ureg] < 0`,
which `local_alloc` sets for a pseudo that is **not local to one block OR has
`REG_N_DEATHS != 1`**. The `(high sym)` pseudo here is born and dies in the same insn pair,
so both conditions fail and the tie is unavoidable — and **a pseudo cannot die twice inside
one block**, so the ONLY escape is a cross-block reference to the high. Every C spelling that
supplies one also lets cse equate the two FULL `lo_sum`s (the w72 8-cell symbol-node matrix:
same node 14 @73 with the address parked callee-saved, different nodes 13 @72).

Falsified this wave (new): a `$v0` / `$v1` clobber added to the existing read-only fence on
`j` (both bit-identical 13 — the high is not live at that insn, so 22B-1's clobber-live-range
law says it cannot be denied there); the body's `dh` set hoisted above the `&&` (23) or moved
into the `&&`'s FIRST operand (23); the body read spelled index-first
`*(int *)((j << 2) + (int)dh + 28)` (13, bit-identical); a read-only fence on `dh` inside the
body (19); `dh = &DashHUD_view[0]` in the `&&` (14 @73).
⇒ **NAMED ANGLE (sharpened): the wanted device must add a reference to the `(high sym)` RTX
in ANOTHER BASIC BLOCK without naming the symbol in C** — e.g. 22B-3's tied MULTI-OUTPUT
launder over the entry load's dest and the body's base, or a maspsx/TEXT_MOVES-level rewrite.
The symbol-level axis is now exhausted on both the node axis (w72) and the structure axis
(w74).

---

## 4. New laws / levers (candidates for the catalog)

1. **SOURCE-ORDER SUBSTITUTE FOR A BLOCKED sched1 HOIST** (sched.c:830-856). When a matching
   device (identity launder, opaque pointer) removes `true_dependence`'s fixed-scalar /
   varying-struct exemption and the oracle's schedule depended on it, do not trade the device
   away — write the load *before* the store in source order. POSITION relative to the
   surrounding block is the dial. (MapMarkers cop + race; the two clusters were filed
   "mutually exclusive with every device tried so far" by w74.)
2. **fold-const's `associate:` is a TWO-LEG cell** (fold-const.c:4292 `split_tree(arg0)`,
   :4349 `split_tree(arg1)`). 22A-1's "make K a mutable local" escape must be applied to
   **every** constant leg simultaneously, and `arg0` must be parenthesised so its top-level
   `PLUS`/`MINUS` has no constant operand. One leg alone is inert or a loss.
3. **A store that must be SHARED cannot be written per-arm** when the arms differ *after* it:
   `cross_jump` merges suffixes only, so it never reaches a store sitting behind the arms'
   differing `li aN,K`. Stage the differing value in a local; put the store on the shared path.
4. **The `"m"`-operand fence's POSITION is a movable-DISCOVERY-ORDER dial.** 21A-5 recorded it
   as a zero-insn ref dial on an existing `%hi` pseudo; here the same fence at three legal
   positions gives 29 / 25 / 23 and only one of them gets *both* the register assignment and
   the constant-hoist order right. Sweep the position, not just the presence.
5. **`local_alloc` combine_regs is THE self-temp mechanism** (local-alloc.c:1864-1867):
   `lui rD; lw rD,%lo(rD)` is the tie of the load dest with the dying `(high)` pseudo; it can
   only be refused by a *cross-block* reference to the high (a pseudo cannot die twice in one
   block). This retires "self-temp vs separate-temp" as a coloring coin-flip and names the
   exact requirement.
6. **`own_thread_p`'s CODE_LABEL rule** (reorg.c:2196 + the `if (own_fallthrough)` gate at
   reorg.c:3936): a label between a conditional branch and the first fall-through insn makes
   an eager fall-through fill *impossible*, and jump.c re-normalises every source-level attempt
   to move that label. Such a `nop` is a `PER_FN_BRANCH_RETARGET`/`TEXT_MOVES` job by
   construction. (Complements 11B's `mostly_true_jump` EQ rule — the EQ/prediction-0 path
   still tries the fall-through, so the *label*, not the prediction, is the blocker.)
7. **21A-4's computed ref-step reproduced exactly** on a fresh site (predicted n=2, measured
   n=2) — and the fence must lie inside the target qty's *closing* range: after the consuming
   store every operand count costs +1 insn.
8. **Rule-8 confirmation:** the SYM's *absence* of a cursor/counter local is positive evidence
   for an indexed giv (23C-4 generalised to a string-walk loop, not just a parm walk).

## 5. Process notes

* 🔴 **A truncating pipe (`probe | tail`) left a probe variant applied on disk.** The harness
  restores in a `finally`, but `BrokenPipeError` at flush aborted it — W61-13F re-confirmed.
  All later grids write to a file and are `cat`'d.
* 🔴 **`TMPDIR`/`TMP`/`TEMP` must be set to a Windows path for the 1996-vintage cc1**, else
  compiles fail *intermittently* with bogus `parse error at end of input` / `'r' undeclared`
  in unrelated functions (and litter `cta*` files in the repo root — those files are present
  at HEAD and are the tell). Three probe rounds were wasted before wiring it into the harness.
* Concurrent session: the w75-a3 belt is editing the same TU (`Hud_BuildTach`,
  `Hud_BuildNumbers0`, flare/tach sites). Every landing here was applied with a fresh read of
  the file; the peer's edits are intact in the final diff.

## 6. Files

* `recon/game/psx/hud.cpp` — the only tracked file changed by this belt.
* `scratchpad/w75/` (untracked): `a4_grid.py` (variant runner), `a4_show.py` (per-variant
  sbsx), `a4_probe.py`, `a4_receipts.py`, `grid_*.py` (every measured grid), `a4_*_sbsx*.txt`
  (side-by-side snapshots at each basin).
