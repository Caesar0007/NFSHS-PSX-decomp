# W63-A9 — libmath + SPRINTF + sndpsxz belt

Gate = `tools/verify_asm.py` / `tools/vprobe.py` (sole authority). Polarity `-` = OURS, `+` = ORACLE.
Every number below was re-gated by me and confirmed on **2 independent runs**.
`tu_order_audit.py` = **508 objects / 0 inversions** (unchanged). **Zero PASS→FAIL** anywhere.
**No recon source file was modified** — `git status --porcelain` on all three of my directories is
empty. Every landing on this belt is a build.py spec, probed through the sanctioned
`W60_TEXT_MOVES_FILE` / `W60_TU_FLAGS` env hooks in `tools/vprobe.py`. `tools/build.py` untouched.

## LEDGER (all re-gated by me; "final" = with the specs in `TEXT_MOVES_SPEC.json` / `PER_TU_SPEC.json`)

| TU / fn | board | my re-gate | final | mechanism |
|---|---|---|---|---|
| libmath `__muldf3` | 98.53 | **12** @197/197 | **4** | 11B TEXT_MOVES ×4 |
| libmath `_mul_mant_d` | 91.15 | **14** @59/59 | **10** | 11B TEXT_MOVES ×2 |
| libmath `__divdf3` | 94.51 | **22** @182/184 | **18** | 11B TEXT_MOVES ×2 |
| libmath `__adddf3` | 96.49 | **12** @221/221 | **10** | 11B TEXT_MOVES ×1 |
| libmath `__divsf3` | 99.88 "stale-PASS suspect" | **PASS (81)** | PASS | **verified — the suspicion is CLEARED, it is a genuine PASS** |
| libmath `__fixdfsi` | 94.13 | **5** @62/63 | 5 | untouched (mechanism WISH, see §5) |
| libmath `_comp_mant` (DIVDF3 TU-mate) | — | PASS (20) | **PASS** | regression control for the DIVDF3 rows |
| libc `sprintf` | 98.78 | **56** @545/545 | **44** @545/545 | `no_split_addresses` + 1 slot-fill TEXT_MOVES row (§3) |
| sndpsxz `iSNDpsxmalloc` | 97.76 | **26** @127/127 | 26 | diagnosed (§4), not landed |
| sndpsxz `iSNDfillspuwithpackets` | 99.98 | gate **PASS (308)** | PASS | **psyqproof REAL=1 — new production-lane finding (§6)** |

**Belt: 147 → 111 gate diffs (−36), all count-parity-safe, all source-free.**

---

## 1. 🏆 THE 11B ARG-EMISSION CLASS IS CLOSED — ONE identical row shape × 9 sites, −18 diffs

### 1a. The shape (uniform at every one of the nine `_add_mant_d` call sites)

```
        sw   $X,16($sp)          ; the 5th (stack) argument
        lw   $5,A($sp)           ; arg2
        lw   $6,B($sp)           ; arg3
        lw   $7,C($sp)           ; arg4        <-- retail emits THIS FIRST
        jal  _add_mant_d
        addu $4,$sp,N            ; arg1, in the slot (identical both sides)
```
Retail: `sw stackarg / lw $7 / lw $5 / lw $6 / jal`. Ours: `sw stackarg / lw $5 / lw $6 / lw $7 / jal`.
Exactly 2 gate diffs per site; 9 sites = 18 diffs across 4 functions.

### 1b. Why NO source spelling reaches it (gcc-2.8.1 `calls.c`, read, not guessed)

* `calls.c:1900` — the final hard-register load loop is `for (i = 0; i < num_actuals; i++)`,
  strictly **ascending argument order**, and the loads are `SCHED_GROUP_P`-chained to the
  `CALL_INSN` so no scheduler pass may reorder inside the group. Emission order **IS** list order.
* The only escape is the precompute loop at `calls.c:1632`
  ("Precompute all register parameters"), whose copy-to-pseudo test is
  `calls.c:1674`: `rtx_cost (args[i].value, SET) > 2 && ((SMALL_REGISTER_CLASSES && reg_parm_seen)
  || preserve_subexpressions_p ())`. `preserve_subexpressions_p()` returns 1 unconditionally at
  `-O2` (`if (flag_expensive_optimizations) return 1;`), and `rtx_cost` (`cse.c`) gives every one
  of args 2/3/4 the **same** cost — they are three MEMs of the identical
  `(plus (reg frame) (const_int N))` shape (`default: total = 2` plus the summed address cost).
  ⇒ all three are precomputed or none are, and either way the order is a1,a2,a3.
  **A source-level a3-first is therefore unreachable while the argument LIST order is fixed by
  the callee's register↔value mapping** (which the PASSing hand-asm `_add_mant_d` pins:
  `$a1`=lo of mantissa A, `$a2`=hi of A, `$a3`=lo of B, `32($sp)`=hi of B).
* **Six new source spellings falsified this wave** (`mm_v1.json`, whole-fn gated, control 14):
  plain `add[0]` for arg4 **16** · volatile on args 2+3+4 **14 (inert)** · volatile on args 2+3
  only **16** · named `int t4` staging arg4 **49 @60/59** · named `t2`/`t3` staging args 2+3
  **19 @58/59** · volatile on arg5 as well **34 @61/59**.
  The existing `*(volatile int *)&add[0]` on arg4 is **load-bearing** (14 vs 16) — it is what
  forces retail's reload from the just-written slot; do not remove it.
  These join w59-a8/w61-a9/w62-a8's list (named temp, prototype signedness, 8-rung ladder,
  `shp` pointer local, identity-launder, read-only fence, block-local `o`).

### 1c. The row (ONE shape, repeated per site) — `TEXT_MOVES_SPEC.json`

```
take : (?<=\tlw\t\$6,\d\d\(\$sp\)\n)(?:\t#\.set\tvolatile\n)?\tlw\t\$7,\d+\(\$sp\)\n
       (?:\t#\.set\tnovolatile\n)?(?=(?:[^\n]*\n){0,4}\tjal\t_add_mant_d\n)
after: \tsw\t\$\d+,16\(\$sp\)\n(?=\tlw\t\$5,\d+\(\$sp\)\n\tlw\t\$6,\d+\(\$sp\)\n
       (?:[^\n]*\n){0,6}?\tjal\t_add_mant_d\n)
```
Rows: MULDF3 `__muldf3` ×4, MULDF3 `_mul_mant_d` ×2, DIVDF3 `__divdf3` ×2, ADDDF3 `__adddf3` ×1.

**Self-disambiguating in BOTH directions** (this is what took three attempts):
* the `take` lookbehind `lw $6,..($sp)` is destroyed once the line is moved, so row *k+1*
  cannot re-take an already-processed site;
* the `after` lookahead `lw $5 … lw $6` fails at a processed site (whose `sw ..,16($sp)` is now
  followed by the moved `lw $7`), so row *k+1* cannot re-anchor on a processed site;
* the `jal _add_mant_d` lookaheads on BOTH patterns are **mandatory** — `16($sp)` is the generic
  outgoing 5th-arg slot and `lw $6 / lw $7` pairs also belong to `_dbl_shift` / `_comp_mant`
  call sites. Measured falsifications of the loose forms:
  * generic `after` without the two-load lookahead: `__muldf3` **12 → 18** (anchored on
    unrelated `sw ..,16($sp)` sites; the moved lines landed in foreign call setups);
  * inverted formulation (take the `lw $5/lw $6` pair, re-insert after `lw $7`):
    **20 / 14 / 28 / 14** — the `after` anchor re-finds the FIRST `lw $7` in the region
    (an already-processed site) and cross-links two different call setups;
  * `after` lookahead relaxed from `lw $5,24($sp)` to `lw $5,\d+($sp)` without the jal guard:
    `__muldf3` **18**, `__divdf3` **26**, `__adddf3` **14**.

> **CATALOG-ROW CANDIDATE (§D / §F): "retail loads the LAST register argument FIRST".**
> When a 5-arg call shows `stack-store, arg4, arg2, arg3` against our `arg2, arg3, arg4` at
> **count parity**, stop looking for a source spelling: gcc-2.8's `calls.c:1900` register-load
> loop is ascending-`i` and `SCHED_GROUP_P`-welded to the CALL_INSN, and `calls.c:1674`'s
> precompute test cannot discriminate between same-shaped MEM args at `-O2`
> (`preserve_subexpressions_p` is unconditionally 1 under `-fexpensive-optimizations`).
> It is a TEXT_MOVES row. The row is *identical* at every site of the class.

### 1d. Safety
The move only reorders three independent `lw`s into three distinct registers from three distinct
stack slots, with no store between them — semantics identical. The load-delay picture is unchanged
(the last load's result is consumed by the callee, ≥2 insns later). `_comp_mant` (the DIVDF3
TU-mate) re-gated **PASS** under the rows.

---

## 2. `__divsf3` — the "stale-PASS suspect" is CLEARED
`verify_asm recon/syslib/psx/libmath/DIVSF3.c __divsf3` = **PASS (81 insns)**, twice, on a fresh
build. Nothing stale; the board row is simply out of date. (`DIVSF3.c` is wired
`cc1_alt: "2.7.2"`; that wiring is doing its job.)

---

## 3. sprintf 56 → 44 @545/545 — the +1-nop objection is DEAD (a DIFFERENT angle, as briefed)

The held `-mno-split-addresses` row was **not re-argued**. The objection to it was purely
*count parity*: it gates 45 but at **546** insns, the +1 being a `nop` in an unfilled `j` delay
slot. That +1 is removable by a **slot-fill TEXT_MOVES row**, which is a mechanism I may spec:

```
take : \tla\t\$7,\$LC0\n(?=\tj\t\$L\d+\n\$L\d+:\n\tla\t\$7,\$LC1\n)
after: \tj\t\$L\d+\n(?=\$L\d+:\n\tla\t\$7,\$LC1\n)      slot: True
```
(the `printHex` upper/lower digit-table selector: cc1 leaves this `j`'s slot empty, maspsx nops it;
`slot:True` wraps it `.set noreorder` so the `la` becomes the slot and the nop never appears.)

Measured, twice each, with `{"jtbl_at_fusion": true, "no_split_addresses": true}`:

| configuration | diffs | insns |
|---|---|---|
| baseline (current wiring) | 56 | 545/545 |
| `no_split_addresses` alone | 45 | **546**/545 ← the held row |
| + slot-fill at the `j $L40`/`lw $16,536($sp)` site | 48 | 545/545 |
| + slot-fill at the `j $L32`/`lb $5,1($6)` site | 48 | 545/545 |
| **+ slot-fill at the `j $L98`/`la $7,$LC0` site** | **44** | **545/545** |

⇒ **−12 diffs at count parity.** The count-parity keep-rule is satisfied; the standing judgement
call is resolved without changing the rule. Specs: `PER_TU_SPEC.json` + the `sprintf` entry in
`TEXT_MOVES_SPEC.json`. `sprintf` is the only gated fn in the TU, so there is no TU-mate risk.

Mechanism note (confirms w62-a8's structural reading): under `-mno-split-addresses` the
`&D_8012348C` template copy takes retail's `lui $rN,0 / addiu $rN,$rN,0` **shape**; what remains
of that cluster is a pure register-choice row (ours `t3/t0/t1/t2`, retail `a1/v0/v1/a0`), i.e. the
self-temp class and the "8-diff local-alloc QTY handout" really were one row with one cause.

**Not probed (out of budget, named for the next agent):** sotn-decomp ships a **fully matched**
PsyQ `sprintf` at `C:\Temp\ps1-decomp-refs\sotn-decomp\src\main\psxsdk\libc\sprintf.c` (307 lines,
gcc-2.7.2-era PsyQ libc; `printf_info` **bitfield** struct of size 0xC, `static printf_info
D_8002D3A8 = {0}` copied by plain struct assignment `info = D_8002D3A8;`, `bufPtr = (char*)&args -
sizeof(printf_info) - 4`, a `loop_30:` goto-dispatch for `h`/`l`/`L`, and `do{...}while(0)` FAKE
wrappers around the `isHalf` narrowings). Ours models the spec words as three raw `sw`s into
`528/532/536($sp)`. **The bitfield-struct spelling is the untried structural axis** and is exactly
the shape that would re-decide the remaining template-copy register handout. Rage Racer's matched
sprintf was audited in w51-a8, but it is a *different* (gcc-2.6.3) rung — sotn's is a second,
independent matched twin and it has NOT been diffed against ours.

---

## 4. `iSNDpsxmalloc` 26 @127/127 — diagnosed, one named angle, not landed (budget)

Re-gated 26 (board 97.76). The residual is **one class, not 26 independent rows**: a base/index
`addu` operand-order + `$v0`↔`$v1` rotation at every free-list walk site:

```
-  sll  v0,s0,2        +  sll  v1,s0,2          (x3 sites)
-  addu v1,s3,v0       +  addu a2,v0,s3         (base first vs INDEX FIRST)
-  addu a2,a2,v0       +  addu a2,v0,v1
-  addu v0,v0,a0       +  addu a1,v1,a0
```
This is the §5.0c **commutative-addu operand-order** row (index term first): write the address
arithmetic as `*(T *)((idx << 2) + (int)base)` rather than `&base[idx]`, at the three `sll`
sites. w44/w42 record it as source-reachable (`UpdateCarTextureData` retired the "RTL
canonicalization" floor claim), and the trailing store-pair rotation
(`sh s2,2(v0)` / `sh v1,0(v0)` vs retail `sh s2,2(a1)` / `sh v0,0(a1)`) should follow the base
once it lands. **NOT a floor** — a named, catalogued, untried angle on this function.

---

## 5. `__fixdfsi` 5 @62/63 — unchanged, still a MECHANISM WISH
Ours is one instruction SHORT: retail's two arms BOTH end in a `j` and neither falls through.
`_apply_text_moves` can move, copy (`copy:True`), slot and delete lines — it cannot **insert** an
instruction that cc1 never emitted. 13 source shapes have been falsified across w60/w61/w62 from
both the source-order and expansion-order directions. Re-stating the wish rather than re-fighting
it: an `insert`/`emit` key on TEXT_MOVES (or a per-fn `-fno-crossjump`-equivalent splice) is what
this needs.

---

## 6. 🔴 NEW: `iSNDfillspuwithpackets` gate-PASSes but is **1 word off in the production lane**

`tools/psyqproof.py recon/eaclib/psx/sndpsxz/sdpacket.c iSNDfillspuwithpackets`
→ **308 words (-G4), REAL=1**, `word 247: ours 1040002c vs retail 1040000f`.

Decoded: both are `beqz $v0,<off>`; retail's word is literally the oracle's
`/* F4730 80103F30 0F004010 */ beqz $v0, .L80103F70`
(the guard of the *mark-SPU-end* loop, `$v0 = lbu 0x1F($s4)` = the voice count).
Ours branches `+0x2C` instead of `+0x0F`, i.e. to **`.L80103FE4`** — the target of the *next*
guard at `.L80103F70` (`lbu 0x1F($s4); beqz → .L80103FE4`). **We thread the false edge past the
next block's re-test of the same value; retail does not.** Behaviourally equivalent (the re-test
would take the same edge), so it is not a runtime bug — it is gcc's `thread_jumps`, and it is the
catalog's documented `PER_FN_NO_THREAD_JUMPS` class.

Two things make this worth a row of its own:
1. **`verify_asm` is branch-target lenient, so the gate reports PASS and `tools/brdist.py` reports
   `13 fns checked, 0 with branch-offset/count divergence` — the gate lane genuinely does not
   thread.** The divergence exists only under the **production** lane (PsyQ 4.3.0 GCC + ASPSX
   2.77), i.e. it is a *different cc1 binary making a different jump.c decision*, and **only
   `psyqproof` can see it.**
2. ⇒ **`REAL=1` on a gate-PASSing EA function is not automatically an ASPSX artifact class.**
   Under the standing dual-lane rule this fn is 1 word from a dual-lane seal.

**Named angles (untried, no budget):** (a) the guards read `voice[0x1F]` plainly while the loop
conditions read `*(volatile unsigned char *)(voice + 0x1F)` — making the *second* guard's read
volatile denies jump.c the provable-outcome edge and should defeat the threading at zero cost;
(b) `PER_FN_NO_THREAD_JUMPS` (needs a production-lane probe path — `psyqproof.py` honours neither
`W60_TEXT_MOVES_FILE` nor `W60_TU_FLAGS`, which is itself a tooling gap worth closing).

---

## 7. 🔴 CORPUS FALSIFICATION — libmath is matched NOWHERE (4th independent confirmation)

Acting on the mid-wave lead: `C:\Temp\psyz` @ `6d47e5e` (fast-forwarded) —
`decomp/src/libmath/` holds **46 files, every one of them a pure `INCLUDE_ASM` stub**
(`adddf3.c`, `addmant.c`, `divdf3.c`, `muldf3.c`, `fixdfsi.c`, `dbshift.c` … all 4–6 lines, 0
matched C bodies; `git log` shows no libmath work). `addmant.c` in particular is
`INCLUDE_ASM("asm/nonmatchings/libmath/addmant", _add_mant_d);` — **there is no shape to port**,
and no committed `.s` either (splat generates it from `psyq400.bin` at build time).
`sotn-decomp` has no soft-float at all (`grep -rln 'add_mant|__adddf3|__muldf3' src/ include/` = 0);
a corpus-wide grep for `adddf3|divdf3|mul_mant|add_mant|fixdfsi` over all 15 projects in
`C:\Temp\ps1-decomp-refs` returns **zero hits**. The orchestrator's withdrawal is confirmed from
this side too; the `calls.c` program in §1b was the correct route and it closed the class.

---

## 8. Files / artifacts
* **No recon source modified.** `git status --porcelain recon/syslib/psx/libmath/
  recon/syslib/psx/libc/SPRINTF.c recon/eaclib/psx/sndpsxz/` = empty.
* Specs for the orchestrator: `TEXT_MOVES_SPEC.json` (10 rows: 9 × 11B + 1 sprintf slot-fill),
  `PER_TU_SPEC.json` (SPRINTF.c).
* Replayable probe batches: `mm_v1.json` (6 source spellings), `tm_muldf3.json`, `tm_11b.json`,
  `tm_spA.json`, `tm_spB.json`, `tm_sprintf.json`; harness `probe.py`
  (literal-replace variant runner, line-ending-preserving, `finally`-restore).
* Backups: `MULDF3.c.base.bak`, `DIVDF3.c.base.bak`, `ADDDF3.c.base.bak`.
* Diagnostic snapshots: `base.s` / `moved.s` / `d.txt` (the .s diff that exposed the loose-anchor
  mis-landing described in §1c).

## 9. Hazards hit
* **The TEXT_MOVES loose-anchor trap (new, worth a briefing line).** `_apply_text_moves` does
  `re.search` over the whole per-fn region for BOTH `take` and `after`, independently. A row whose
  patterns are not *mutually* self-invalidating will silently re-take an already-moved line and/or
  re-anchor on an already-processed site, producing a **semantically wrong but plausible-looking
  `.s`** — my first `__muldf3` attempt moved a *volatile* `lw $7,32($sp)` from one call site into a
  *different* call site's argument block and the gate still reported a plausible number (18).
  **Always diff the generated `.s` (not just the score) after authoring a repeated row.**
* `tools/tugate.py` does **not** honour `W60_TEXT_MOVES_FILE` / `W60_TU_FLAGS` — only
  `tools/vprobe.py` does. A "moved" whole-TU gate silently reports the *baseline*. TU-mate
  regression checks must be done by naming the mates to `vprobe` (done: `_comp_mant` PASS).
* `python re` lookbehind must be fixed-width: `(?<=\tlw\t\$6,\d\d\(\$sp\)\n)` is fine for the
  2-digit frame offsets in this cluster but will silently fail to fire on a 1- or 3-digit offset.
* Heredocs were avoided for every escape-bearing payload; all JSON was built from Python literals
  or written with the Write tool.
