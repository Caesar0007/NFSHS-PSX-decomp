# W75-A16 — libetc INTR belt (`recon/syslib/psx/libetc/INTR.c`, cc1_272 lane)

STEP 0 done: full read of `reference_mips_isa_asm.md`, full read of
`reference_psx_cpp_reconstruction_methodology.md` (all 1018 lines, paged), catalog tail
§18–§23 (20B family, 21A–21E, 22A–22D, 23A–23D). Memory dir untouched. No git commit/push.
No `PER_FN_TEXT_MOVES` / `RA_SINK` rows added (orchestrator policy 2026-08-23 honoured);
the one build.py row added is a COMPILER-INPUT lane row (`PER_FN_CC1_VER_SPLICE_272`).

## Headline

| fn | baseline | final | count | posmis | note |
|---|---|---|---|---|---|
| `_intrhand` | 24 diffs | **20 diffs** | 116/116 exact | **20 → 18** | −4 landed via a per-fn 2.6.3 rung |
| `_set_intr_callback` | 4 diffs | 4 diffs | 82/82 exact | 2 | unchanged; NEW named angle + mechanism certificate |
| whole TU | 11/13 PASS | 11/13 PASS | — | — | **zero PASS→FAIL**, gated twice (×4 in total) |

Neither function SEALED. `_intrhand` reduced 24→20 (posmis 20→18, monotone).

## Landed change

**`tools/build.py` — `PER_FN_CC1_VER_SPLICE_272` += `"recon/syslib/psx/libetc/INTR.c": {"2.6.3": {"_intrhand"}}`**
(+ a 16-line receipt comment). The pre-existing uncommitted foreign edit in build.py
(removal of the psxcontroller / SPRINTF TEXT_MOVES rows) was re-read immediately before the
edit and is **preserved** — `git diff tools/build.py` shows only my addition on top of it.

Probe evidence (the wiring bar: net improvement + zero PASS regressions + reproduced 2×):
* `_intrhand` 24 → 20, count-exact 116/116; posmis 20 → 18 measured **both ways** (row
  temporarily removed, re-measured, restored).
* whole-TU `tugate` 11/13 PASS **before and after**, run twice after each edit.
* Splice is region-scoped to `_intrhand`; the other 12 fns are byte-untouched.

## 1. `_intrhand` — the 2.6.3 rung is now CHARACTERISED, not just scored

The "2.6.3 −4" banked since W63-A8 was a bare score. Diffing the two cc1 outputs for the
whole function (`scratchpad/w75/a16_intrhand_272.s` vs `a16_intrhand_263.s`, 166 lines each):

```
2.7.2 (lane)                 2.6.3 (rung)              retail
lhu $3,0($5)   (*I_STAT)     lhu $2,0($5)              lhu $v0,0($a1)
lhu $2,0($6)   (*I_MASK)     lhu $3,0($6)              lhu $v1,0($a2)
```

**That is the ONLY codegen difference in the entire function.** Everything else is
`move $d,$s` vs `addu $d,$s,$0`, which the gate normalises. So the rung buys exactly the
closing-test cluster (`if ((I_STAT & I_MASK) != 0)`) — the 4 diffs that ~15 measured source
cells over 4 waves never moved — and nothing else. It cannot be masking a source lever.

**RUNG-ORTHOGONALITY LAW (new, measured on 5 source basins × 3 rungs):** the rung is a
constant −4 offset on every basin swept — shipped 24→20, mp-inline 26→22, block-local-`en`
32→28, `sp;en;store;mp` order 28→24, retail EN-INNER tree 38→34. 2.6.0 ≡ 2.6.3 everywhere;
970404 / 2.8.0 / 2.8.1 all go count-OFF (110 @114) on every basin. ⇒ future source work on
the pend blocks re-prices unchanged under the rung.

**VACUITY CLEARED (answers the brief's ⚠️):** the W74-A19 `LM<n>:`/`.loc` region-truncation
bug is **DEFAULT-LANE-ONLY**. The strip fix lives in `_apply_cc1_ver_splice` (build.py:2514)
and is *not needed* in `_apply_cc1_ver_splice_272`, because `_compile_c_272`'s cc1_flags are
`-quiet -O2 -G<n> -mgas` with **no `-g1`** (build.py:2585) — sub-2.8 rungs therefore emit no
COFF debug at all. Verified empirically: 0 `LM<n>:` and 0 `.loc` in the rung's `.s`, and the
gate reads the full 116/116. **Every earlier 272-lane sub-2.8 ver-splice number, including
W63-A8's ladder, was REAL.** (Re-run from scratch anyway, as the brief asked.)

## 2. `_intrhand` pend blocks — two corrections + one new law

### 🔴 CORRECTION to W72-A19(c) (banked certificate refuted with compiler source)
"a bare CLOBBER does not enter global.c's conflict set for an allocno local-alloc never saw"
is **false as a mechanism**. `global.c:1384 mark_reg_clobber` → `:1239 record_one_conflict`
**does** set `hard_reg_conflicts[j]` for every allocno `ALLOCNO_LIVE_P` at that insn, hard
regs included. The real reason those cells read inert is **placement**: a clobber-only
`__asm__("" : : : "$N")` has zero operands, and `sched.c:1987` gates the everything-barrier
on `code != ASM_OPERANDS || MEM_VOLATILE_P (x)` — a non-volatile `ASM_OPERANDS` with no
inputs has **no dependences at all**, so the insn floats to the **top of the block**
(verified in the `.s`: the `#APP` lands before the first pointer load), i.e. *outside* `en`'s
live range where the conflict is a no-op. Re-measured: `"$2"/"$3"/"$4"/"$5"/"$4","$5"/
"$4","$5","$6"` **all 24, bit-for-bit**. The forms that *do* stay put cost insns:
`__asm__ __volatile__("" : : : "$4")` 36 @118, bare `__volatile__("")` 30 @118, read-only
`("" : : "r"(en) : "$N")` 28–40 @118 (the fence pulls `en`'s load out of the load-delay gap
that `lhu a0,48(s1)` was filling → one nop minted per site).
⇒ **22B-1's clobber-live-range placement law needs a companion clause: a clobber-only asm has
no live range of its own. Give it at least one operand, or it is placed by the scheduler.**

### 🆕 NEW LAW — why the two pointer loads hoist above `state[1] = 1` (sched.c:830)
`true_dependence` treats a read X after a store MEM as dependence-FREE when
`MEM_IN_STRUCT_P(mem) && rtx_addr_varies_p(mem) && !MEM_IN_STRUCT_P(x) && !rtx_addr_varies_p(x)`.
`state[1] = 1` is an ARRAY_REF (`/s`) at a **pseudo** base (varying); `g_imask_ptr` is a plain
VAR_DECL (no `/s`) at a **symbol** (fixed) — the exclusion fires exactly, so sched1 may hoist
**both** pointer loads above the store wherever the source puts them. *This is why every
`mp`/`sp` statement reorder has measured inert since W62 — it was a DEPENDENCE fact, not a
scheduling tie* (confirmed: `-fno-schedule-insns` does **not** stop the hoist either, 26 @116).

**The dial:** respell the store as a cast INDIRECT_REF `*(unsigned short *)((char *)state + 2) = 1;`
→ `MEM_IN_STRUCT_P` clears, the exclusion stops firing, the hoist **disappears — at zero insns**.
With the `sp; en; store; mp` order this reproduces retail's entry-block SHAPE for the first
time in this campaign: `lui/lw $a0`(sp) | store | `lui/lw`(mp) | derefs — `sp` lands in
retail's own `$a0` and `mp` is materialised **after** the store (28 → 24). (A
`("" : : "r"(sp) : "$2","$3")` fence reaches the same 24 without the cast.)
**Not landed** — it ties the shipped 24. This is the scheduler-side twin of catalog 22C-3
(which used the same flag for cse alias-chaining).

### The residual, now a 1-element target
Retail's entry pend block spends only `$a0 + $v0` on local qtys, leaving `$v1` for `en`;
ours spends `$a0 + $v0 + $v1` because `*sp` (refs 2 / live 3, higher priority) grabs `$v0`
before `mp` can reuse the dead `li $v0,1` register — so `en`, a fn-scope **global** allocno
homed by global.c *after* local_alloc, takes the leftover `$a0`.
**NAMED NEXT ANGLE:** stand in the cast-store `sp; en; store; mp` basin (24, structurally
retail's) and make `*sp` land in `$a0`. That needs `$v0` **and** `$v1` unavailable at its
birth. A clobber cannot express it (it would also hit `mp`, whose ranges overlap), so it is
either (a) an allocation-ORDER dial demoting `*sp` below `mp` in local-alloc's qsort
(`tools/qty272.py`), or (b) making `en` a per-site LOCAL that local_alloc actually seats in
`$v1` — the block-local grid is 30–36 today and **has never been crossed with the cast-store
basin**.

### Falsified this pass (all gated, all reverted)
cast-store × {EN-OUTER, EN-INNER} × {no fence, sp-fence × 4 clobber sets, en-fence × 6} (24
best, 28–46 elsewhere); block-local `en` × cast store 32–36 (40–44 @118 when `en` is read as
`g_intr.enabled`); `sp;en;mp` 28, `en` first 24, mp-inline 26, retail-tree 38/40/42/46, the
`{en,mp}`-inner tree 46; per-fn flags `-fno-schedule-insns` 26 @116, `-fno-schedule-insns2`
30, `-fno-strength-reduce` 24, `-fno-cse-follow-jumps` 24, `-fno-delayed-branch` 29 @119;
rungs 2.6.0/2.6.3 = 20, 970404/2.8.0/2.8.1 = 110 @114.

## 3. `_set_intr_callback` — the chooser is named, the angle is re-aimed

W74 proved `find_best_addr` cannot RE-base an existing `(plus reg K)`. This pass found **what
FORMS the address in the first place**, and it is a different function with a different rule:

**🔑 `use_related_value` (cse.c:1812) is OLDEST-WINS.** Reached from `cse_insn:6672` under
`src_const && (GET_CODE (src_const) == CONST || (src_const_elt && src_const_elt->related_value != 0))`.
It starts at the class `RELT` of the bare SYMBOL_REF and on the **first iteration** takes any
REG in that class (⇒ `48($a2)` = retail's form); only if the symbol class has **no** register
does it step to `p = p->related_value`. `insert` (cse.c:1458-1460) links each new CONST just
*before* the base — *"so the element that follows SUBELT is the OLDEST one"* — so the step
lands on the **oldest related constant that owns a register**. Here that is `&g_intr.cb` =
sym+4 in `$a1`, minted at insn 5 for `oldCallback = g_intr.cb[idx]` ⇒ ours `44($a1)`. (The
same rule explains the guard's `lhu $v0,-4($a1)`, which **both** builds share.)

**🔴 Why our `$a2` does not count:** the 21A-5 `'m'` fence's base is materialised for the "m"
constraint *after* cse, so cse never sees a `(set reg (symbol_ref g_intr))` and the symbol
class stays register-less. ⇒ the residual is **not** a cost tie inside cse (the W72/W74
"cheapest equivalent base" reading) but a **table-content** fact: retail's cse had a REG in
the symbol class at that point and ours does not.

**Falsified this pass** (all gated + reverted, 4 @82 control re-measured each run): every
vehicle that puts `&g_intr` in a register *in source* pays a full `la` because cc1 does not
route the asm/pointer address through `use_related_value` — `__asm__("" : : "r"(&g_intr))`
15 @85 (the `.s` carries `la $6,D_80134AF8`, and arm 1 **still** reads `44($a1)`, proving a
live `$a2` is inert while outside the symbol class), `__volatile__` variant 16 @86,
`"r"(&g_intr.in_handler)` 15 @85, `"r"(&g_intr.enabled)` 15 @85, the `'m'` fence plus any of
those 4–7 @82/83, `IntrState *ctl = &g_intr` used in arm 1 only 9 @85 / both arms 30 @86 /
declared inside arm 1 9 @85 (fence) & 31 @87 (no fence), an `'m'` fence on `g_intr.enabled`
at the arm-1 head 4 (inert). Axes re-priced on the 4-basin, all inert or worse: rungs
2.6.0/2.6.3/2.7.2 = 4, 970404/2.8.0/2.8.1 = 64 @82; `-G4` 4, `-G8` 4,
`-fno-expensive-optimizations` 4 (independently re-confirming W74's reading that
`find_best_addr`'s expensive arm is not the path), `-fno-schedule-insns` 20 @80,
`-fno-schedule-insns2` 20 @82, `-fno-delayed-branch` 17 @83; `-mno-split-addresses`
re-confirmed **rejected** by the lane's CC1PSX (`Invalid option 'no-split-addresses'`).

**NAMED NEXT ANGLE (one question):** get a REG into cse's bare-SYMBOL_REF class for `g_intr`
before arm 1's address is formed, without paying a `la`. The only known zero-cost producer of
such a REG is `use_related_value` itself rewriting `(set reg (symbol_ref))` → `addiu reg,$a1,-4`
— exactly the insn retail has at slot 20 — so the question is which construct in cc1 2.7.2
still reaches `cse_insn:6672` with `src_const == (symbol_ref g_intr)`. Read the pre-cse RTL
(`-dc` / `rtl_dump`) for the `"r"(&g_intr)` cell: either the address is already expanded to a
lui/lo_sum pair there (⇒ the answer is a rung/flag that leaves it unsplit, and no 2.6/2.7
rung accepts the switch), or `src_const` is set and the symbol class is simply absent (⇒ a
cheap earlier offset-0 *reference*, not an address-take, is the vehicle).

## 4. Brief's extra checks

* **3.25-3b delayed-branch identity (aspsx filled slots itself):** does **not** apply to
  either target — both are already count-exact and `-fno-delayed-branch` mints an insn at
  each (`_intrhand` 29 @119, `_set_intr_callback` 17 @83). The TU's existing
  `PER_FN_NO_DELAYED_BRANCH` set (ResetCallback/InterruptCallback/DMACallback/VSyncCallbacks)
  stays as is.
* **🔴 RAW40 SCOPE RULE (new, both halves verified):** `PER_FN_RAW40_SPLICE` is **inert for
  any `cc1_272` TU**, twice over. (1) `compile_c` returns from `_compile_c_272`
  (build.py:2699) long before the raw40 block (build.py:2751), so a row on INTR.c would
  silently do nothing; (2) even if it ran, `CC1_PSYQ40` (build.py:980) and
  `_resolve_cc1_272` resolve to the **same binary** on this box
  (`C:/Temp/nfs3-clean/psyq400/COMPILER/CC1PSX.EXE`, PsyQ 4.0, 1997-05-20 — no
  `CC1PSX272.EXE` exists beside CC1) — the 272 lane already *is* the raw-4.0 macro-form cc1
  assembled by the lane's own GNU as. **Do not add RAW40 rows to cc1_272 TUs**; the
  equivalent axis there is the ver-splice rung.
* **A20 `[reload_pick]` / posmis:** consistent with A20's "single-member class pools are
  immune — libetc measured immune". Neither residual is a reload-pool ±1 rotation: both are
  count-exact with the *same* register set, and the mechanisms located here are local-alloc
  occupancy (`_intrhand`) and a cse equivalence-class content fact (`_set_intr_callback`).
  `tools/posmis.py` used as the honest metric on both.

## 5. Files

* Edited (uncommitted): `tools/build.py` (one ver-splice row + receipt),
  `recon/syslib/psx/libetc/INTR.c` (receipt comments only — zero code change).
* Scratch (untracked, `scratchpad/w75/`): `a16_probe.py`, `a16_cell.py`, `a16_grid.py`,
  `a16_run.py`, `a16_sbs.py`, `a16_setcb.py`, `g1..g12.py`, `s1..s5.py`, `e1..e5.py`,
  `b1..b4.py`, and the receipts `a16_intrhand_272.s` / `a16_intrhand_263.s` (the rung
  characterisation), `a16_272_base.s`, `a16_263_full.s`, `a16_sbs_*.txt`.
