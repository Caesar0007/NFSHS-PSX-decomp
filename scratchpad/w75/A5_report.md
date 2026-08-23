# W75-A5 — draww-A belt report

Unit `game/psx/draww`, TU `recon/game/psx/draww.cpp`. No git operations, no memory-dir edits,
**no new build.py rows** (orchestrator policy acknowledged: post-recompile instruction rewrites
are forbidden; the one place a rewrite row would have fit is DOCUMENTED, not wired — see §3).

## Headline

| fn | baseline | final | count | posmis |
|---|---|---|---|---|
| `Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark` | 28 | **20** | EXACT 353/353 | 33 |
| `DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache` | 30 | **8** | EXACT 268/268 | 23 → **7** |
| `DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss` | 8 | 8 | EXACT 588/588 | 13 |

TU gate: **29/35 PASS before and after** (baseline was 28/35; the +1 is agent A6's
`DrawW_BuildObjectFacets` seal landing in the same working copy, not mine).
Gated twice at the end, identical. **Zero PASS→FAIL anywhere.**
Net on my three targets: **66 → 36 diffs, all three count-exact.**

Baseline note: HEAD `a604a578` already carried the user session's
"Restore exact SYM graph for Skidmark" (`9467e6e5`). It creates
`recon/game/psx/skidmark_types.h` for `skidmark.cpp` only; `draww.cpp` includes
`nfs4_types.h` + `draww_externs.h` and is untouched by it — re-baselined and the
w72 receipt numbers reproduced exactly (28 @353/353), so the old receipts still applied.

⚠️ Process: this clone is being edited by ~20 concurrent belts, and A6 landed a
`DrawW_BuildObjectFacets` change into `draww.cpp` while my first sweep was running.
After that I moved **all** probing to an untracked copy `recon/game/psx/draww__a5probe.cpp`
(same directory so the relative includes and per-TU flags resolve identically; verified it
reproduces the three baselines bit-for-bit) and only applied proven winners to the real TU
with surgical edits. The probe copy is deleted. **Recommend this as a fleet rule for any
snapshot/restore sweep on a shared TU** — a whole-file restore from a stale snapshot silently
reverts another belt's landed work.

---

## 1. `DrawW_BuildSpikeBelt` 30 → 8 — the six-wave `fx/fy/fz` cluster (a) is CLOSED

**The lever (landed):** there is no temporary at all. Retail loads each signed byte straight
into the *short AUTO's own pseudo* and shifts it **in place**, which is why it holds three
distinct callee-saved registers (`$s4/$s3/$s2`) where we held one reused raw temp plus three
separate shift destinations.

```c
fx = (signed char)BWorldSm_slices[slice].forward[0]; fx++; fx--; fx >>= 1;
fy = (signed char)BWorldSm_slices[slice].forward[1]; fy++; fy--; fy >>= 1;
fz = (signed char)BWorldSm_slices[slice].forward[2]; fz++; fz--; fz >>= 1;
```

Same `t++; t--;` net-zero merge blocker the file already used — but applied to the
**destination short** instead of to an int carrier, with the shift as the in-place `>>=`.
MIPS `PROMOTE_MODE` keeps a short pseudo sign-extended in its SImode register, so `fx >>= 1`
needs no re-extension and emits retail's bare `sra $sN,$sN,1`.

**NEW NAMED LAW — the +N-insns-of-one-repeated-idiom discriminator.** The no-temp form with
*no* blocker already reproduces retail's registers, order and interleave **exactly** and gates
23 — but at **271, three insns over**, because combine re-merges the sign-extend into
`lbu; sll 24; sra 25` once per axis. *A residual that is +N insns of one repeated
3-insn-vs-2-insn idiom, with everything else positionally exact, is a MERGE question, not an
allocation one: price the blocker, not the pseudo graph.* Four waves (w53/w61/W70/w74) priced
the pseudo graph — every 3-temp spelling gates 40 — because the blocker was welded to the
carrier variable and nobody separated the two axes.

Measured on the no-temp form (all reverted except the winner):

| spelling | gate |
|---|---|
| no blocker, `fx >>= 1` | 23 @271 |
| no blocker, `fx = (u_short)((short)fx >> 1)` | 23 @271 |
| no blocker, loads grouped then shifts grouped | 23 @271 |
| no blocker, software-pipelined | 23 @271 |
| `fx |= zeroShort;` runtime-zero blocker | 23 @271 (folded) |
| opacity launder `__asm__("":"=r"(fx):"0"(fx))` | 140 @290 |
| read-only fence `__asm__("":: "r"(fx))` | 93 @285 |
| **`fx++; fx--;`** | **8 @268 — LANDED** |
| `fx++; fx--;` + explicit `(u_short)((short)fx>>1)` | 8 @268 (byte-identical) |

**Secondary law (measured, worth a catalog row):** an `__asm__` operand on a **`short`** is NOT
zero-insn — +22 insns across 3 sites here, i.e. the same ~+2-per-site the w70 `SubdividFacet`
fence walk measured on a short. The 20B/21A zero-insn device family is **SImode-only**; do not
price it on a narrow-typed pseudo.

**Also landed (separately, 30 → 28 before the above):** the three copy-loop byte cursors must be
initialised **after** `i`, not before. `{ int kk = C; i = 1; ... }` makes the cursor store the
block's first statement and 21B(3) appearance order emits it ahead of `li $a1,1`; splitting the
declaration from the assignment (`{ int kk; i = 1; kk = C; }`) moves it behind `i` at zero insns.
Fixed the `li $a3,72` / `li $a1,1` slots in loops 2 and 3. Measured: base 30 · split decl 28 ·
`i` lifted out of the block 28 · both split 28 · `i = 1, kk = C` comma 28 · **`kk` promoted to a
function-scope int shared by all three loops 74** (the w74 variable-identity law again).

**Residual 8** = the three loop-preheader cursor slots: `kk` still needs to be emitted *behind*
the two loop.c givs (`addiu $a3,$sp,16` base + `addiu $a0,$sp,24` dest), which no source position
reaches — every pre-loop source assignment lands in the entry block ahead of the preheader
hoists, and naming the base to drag it forward costs +2 insns (`CCOORD16 *b = vertex3d;` 38 @270,
`int b = (int)vertex3d;` 38 @270, declared-last 38 @270). Retail's cursor is emitted by loop.c
itself; `kk` cannot be a movable because `kk += 8` gives it `n_times_set == 2` (loop.c:779).
Re-confirmed inert this wave: for-comma init, `kk` after the `do`, `i = 1` outside the block.

---

## 2. `Draw_kCtrlSkidmark` 28 → 20 — the w72 residual class (B) is CLOSED

**The lever (landed):** the EA OT-link template's output operand. `%0` landed in `$v0` where
retail has `$a2` because the output was a fresh block-local `void *primOut` — but `lw %0,4(%1)`
re-reads exactly the value the enclosing block already named: `primPtr = Render_gPacketPtr;`
**is** `sd->head.cprim.PrimPtr`, the same word the template loads. Writing the output back into
`primPtr` (`: "=&r"(primPtr)`, dropping `primOut`) makes it **one pseudo instead of two**, so the
dead `primPtr` register — `$a2`, dead after the `sh v0,14(a2)` clut store — is reused for the
template's result exactly as retail does (`lw a2,4(s1)` / `addiu t6,a2,52` / `sll t4,a2,8` /
`sw t6,0(a2)`). This is **variable identity** (23C(2) / the w74 BuildSpikeBelt cure), not a
device: no clobber, no fence, and semantically the assignment the EA macro itself performs.

**Residual 20 = the w72 class (A) alone, the prologue emission order. Re-priced at the new
(post-`primPtr`) basin per 21E(1); every sweep falsified again, 20 is the minimum of all of them:**

* all **120** permutations of the five init groups — min 20 = current;
* all **720** permutations of the **six** init statements (otz / sd / grey / ccount / m / t, i.e.
  `grey` and `ccount` split apart — a sweep no earlier wave had run) — min 20 = current, and
  **every `m`-first or `t`-first order sits at 58–70**, so retail's `m,t`-first prologue is a
  strictly *worse* basin for us, not a nearby one;
* the fence grid (grey 1–3 × m 1–3 × t 1–2) crossed with the `m,t`-first orders — min 58;
* the `skidIdx` multiply position, before/after each of the three matrix blocks — **inert**, 20 at
  all four positions;
* all 6 row-0 load × all 6 row-0 store permutations — min 20 = current `ld012/st012` (22 and 24
  elsewhere).

**Compiler-source contribution to the standing "live-extender" ask (13B 4-witness request).**
`REG_LIVE_LENGTH` is defined in exactly two places: `flow.c:1594` (incremented once per insn the
pseudo is live over) and `flow.c:1975` (once more for the set insn). Both increments sit **inside**
the `else if (GET_RTX_CLASS (GET_CODE (insn)) == 'i')` arm of `propagate_block`'s insn loop — the
`GET_CODE (insn) == NOTE` arm above it does not count. ⇒ **NOTEs are provably inert for this dial**:
lexical blocks, loop notes, `NOTE_INSN_DELETED` and every other note-only construct cannot lengthen
a live range. The only two reachable ends are the **DEF position** and the **LAST USE**, and both
are source-order facts. Here the def cannot move (`ccount_local` must stay above `m` to keep the
grey/m/ccount priority band, which is exactly what forces our `m`/`t` pair to be emitted last).
So the ask should be restated as: *a device that adds an `'i'`-class insn inside the range which
`final` then deletes* — nothing in the 20B family does that.

---

## 3. `DrawW_SubdividFacet` — stays 8, but the w74 receipt is CORRECTED in two places

The residual is four index `addiu`s issued one group later than retail. The w74 receipt named
"the -dS (sched1) ready lists" as the next instrument. **Ran it. Two refutations:**

1. **TIE DIRECTION REFUTED.** `rank_for_schedule` (sched.c:2455-2458) returns
   `INSN_LUID (tmp) - INSN_LUID (tmp2)` with `tmp = *y`, `tmp2 = *x`, so the sort is
   **descending** by LUID and the pick is `ready[0]` — the **higher** LUID wins, i.e. the insn
   appearing *later* in the pass's input chain is picked first and therefore **placed later**.
   w74 recorded "lower LUID picked first"; every conclusion drawn from that direction is inverted.
   Correct statement: we pick 325 at T-31 because `LUID(325) > LUID(264)`; to match retail the v4
   **address** must sit *after* `n = n + 4` in the pass's input.
2. **SCHED1 MAKES THE IDENTICAL CHOICE, so it is not the dial either.** `-dS`, same basic block 21
   (258..360): `ready list at T-31: 325 (1) 264 (1), now 325 264` — bit-for-bit the sched2 picture,
   and the sched1 **output** chain reads `(insn 268 264 325 ...)`, i.e. plain source order. Neither
   scheduler moved anything; both preserved the chain they were handed. **The dial is the
   pre-sched1 (cse/loop/combine) chain order, which is source order.**

**The reorder IS reachable but is contradictory with the count.** Moving `v4 = &r_div->v[n]` below
`n = n + 4` via a `short n0 = n` snapshot **does** flip the pair — the emitted head becomes
`addiu a3,v0,1; addiu s4,a3,4; sll v0,v0,16`, retail's addiu-before-sll shape — but every snapshot
spelling lands at **587, one insn short**, losing the same insn the w70 "single-chain-base" form
lost (the in-place `n = n + 1` that mints retail's `$a3` and the ARG-home store pairing):
`n0`+v4-last 235 @587 · `+q` first 235 @587 · v5 off `(short)(q-1)` 235 @587 · `n0`+`nb`+dedicated
`newn` with `n = newn` last 143 @587 · same with q first 143 @587 · `n0` in place after `n = n + 1`
101 @589.

**Also measured inert here (new):** the 21C(3)/(4) access-spelling axis — `v4 = (Draw_SVertex *)
(((int)n * 16) + (int)r_div->v)`, the `<< 4` variant, the reversed-operand variant and the
`(int)r_div` variant are **all byte-identical at 8 @588**. The lever that sealed
`Hud_BuildNumbers0` / `InGame_GetPSXPadValue` does not reach this site. Also inert: `short nb = n;
n = n + 4;` hoisted above v5..v8 (8, byte-identical); the four indices as three named temps
interleaved with their uses (28).

**Documented ask, NOT wired (per the orchestrator's policy).** This residual is a pure
line-multiset **permutation** of five adjacent insns with no `.set`, label or branch moving —
i.e. it satisfies the 23D(2) TEXT_MOVES pre-flight exactly. Under the old policy it would be a
two-row `PER_FN_TEXT_MOVES` entry. It is left unwired and recorded here as the ask.
Next instrument (named, and it is now a **pre-sched** question): `-df` / `-dc` on this block, to
find whether the one insn every snapshot form loses (the in-place `n = n + 1`) can be preserved
while the v4 address still moves below the new `n` — that is the exact contradiction to break.

---

## 4. Edits made (all in `recon/game/psx/draww.cpp`, all gated)

1. `Draw_kCtrlSkidmark`: OT-link template output `"=&r"(primOut)` → `"=&r"(primPtr)`, `void
   *primOut;` deleted. 28 → 20. + receipt block (re-pricing table, the flow.c live-length proof).
2. `DrawW_BuildSpikeBelt`: three copy-loop heads `{ int kk = C; i = 1;` → `{ int kk; i = 1; kk = C;`.
   30 → 28. + receipt.
3. `DrawW_BuildSpikeBelt`: the `{ int t; ... }` fx/fy/fz block → the no-temp destination-in-place
   form. 28 → 8. + receipt (discriminator, the full price table, the short-asm-is-not-zero-insn law).
4. `DrawW_SubdividFacet`: receipt only (no code change) — the two refutations, the snapshot price
   table, the access-spelling falsification, the corrected next instrument.

No `build.py` rows added or changed. No `register ... asm("$N")` pins. The two `__asm__` devices
already in `Draw_kCtrlSkidmark` (the grey/m/t read-only fences and the `-1` sentinel launder) were
left untouched; device removal was re-tested implicitly by the 720-order + fence-grid sweep (every
lower fence count regresses).

## 5. Files

`scratchpad/w75/` (untracked): `a5_initperm.py`, `a5_initsweep.py`, `a5_init6.py` (skid init
sweeps), `a5_skid2.py` (multiply position / row-0 permutations), `a5_sf.py` (SubdividFacet index
chain), `a5_sb.py`/`a5_sb2.py`/`a5_sb3.py` (SpikeBelt), `A5_skid_sbs.txt`, `A5_sf_sbs.txt`,
`A5_sf_sched1.txt`, `A5_sf_sched2.txt`, `A5_sb_sbs*.txt`, `A5_baseline_tugate.txt`,
`draww_A5_base.cpp.bak`.
