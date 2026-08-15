# W64-A9 — libmath + SPRINTF belt (vendor gate-parity)

Gate = `tools/verify_asm.py` / `tools/vprobe.py`, sole authority. Polarity `-` = OURS, `+` = ORACLE.
Every number below was **re-gated by me twice** on a fresh build.
`tu_order_audit.py` = **508 objects / 0 inversions** (unchanged).
**No recon source and no `tools/*.py` was modified** — `git status --porcelain` on
`recon/syslib/psx/libmath/`, `recon/syslib/psx/libc/`, `tools/` is empty except the
pre-existing user-dirty `tools/bulkverify.py`. Every landing is a `build.py` spec probed
through the sanctioned `W60_TEXT_MOVES_FILE` / `W60_TU_FLAGS` hooks in `tools/vprobe.py`.

## LEDGER

| fn | briefed | my re-gate | final | mechanism |
|---|---|---|---|---|
| libmath `__muldf3` | 4 | **4** @197/197 | **PASS 197/197, objdump REAL=0** | TEXT_MOVES ×2 (§1) |
| libmath `_mul_mant_d` | 10 | **10** @59/59 | **8** @59/59 | TEXT_MOVES ×2 (§2) |
| libmath `__divdf3` | 18 | **18** @182/184 | **16** | TEXT_MOVES ×1 (§3) |
| libmath `__adddf3` | 10 | **10** @221/221 | **8** @221/221, objdump REAL=4 | TEXT_MOVES ×1 (§4) |
| libmath `__fixdfsi` | 5 | **5** @62/63 | 5 | mechanism RE-ATTRIBUTED (§5) |
| libmath `__divsf3` | verify | **PASS (81)** ×2 | PASS | re-confirmed, board row stale |
| libc `sprintf` | 44 | **44** @545/545 | 44 | sotn axis CLOSED + hardness certificate (§6) |
| libmath `_comp_mant` (DIVDF3 mate) | — | PASS (20) | **PASS** | regression control |

**Belt: 47 → 32 gate diffs (−15), +1 PASS, all count-parity-safe, all source-free, zero PASS→FAIL.**

Spec for the orchestrator: **`scratchpad/w64a9/TEXT_MOVES_SPEC.json`** (6 rows over 3 TUs;
it CONTAINS the already-wired w63-a9 11B rows — merge by REPLACING each fn's list, the
env hook `.update()`s per-file so a partial file would drop them).

---

## 1. 🏆 `__muldf3` 4 → PASS — two pure line relocations

The whole residual was two independent lines in ONE straight-line block:

```
$L8:                                  $L8:
    li   $2,10                            li   $5,1        <- up
    lw   $11,80($sp)          =>          li   $2,10
    li   $5,1                             sw   $2,16($sp)
    sw   $2,16($sp)                       lw   $6,24($sp)
    lw   $6,24($sp)                       lw   $11,80($sp) <- down
    lw   $7,28($sp)                       lw   $7,28($sp)
    addu $23,$11,-1023                    addu $23,$11,-1023
```

Rows (label-agnostic `$L\d+`, both lookahead-pinned, both `count==1` inside the fn region):

```
{"take": "(?<=\\tlw\\t\\$11,80\\(\\$sp\\)\\n)\\tli\\t\\$5,1[^\\n]*\\n",
 "after": "\\$L\\d+:\\n(?=\\tli\\t\\$2,10)"}
{"take": "\\tlw\\t\\$11,80\\(\\$sp\\)\\n",
 "after": "\\tlw\\t\\$6,24\\(\\$sp\\)\\n(?=\\tlw\\t\\$7,28\\(\\$sp\\)\\n\\taddu\\t\\$23,\\$11,-1023\\n)"}
```

Self-disambiguating: row 1's lookbehind is destroyed by its own move, so row 2's `take`
cannot re-fire on it; row 2's `after` lookahead pins the single site whose `lw $7` is
followed by the `addu $23,$11,-1023` consumer.

**SEMANTICS-VERIFIED (mandatory, per the 15D `_padInitDirSeq` trap):**
* the generated `.s` block was read back and is character-for-character the oracle order;
* `$5` is not read between the old and new positions; `$11`'s only consumer is
  `addu $23,$11,-1023`, still 1 insn after the load (load-delay respected, same as retail);
* `sw $2,16($sp)` cannot alias `80($sp)`;
* **`scratchpad/w64a9/wordcmp.py` (reloc-classified word compare): 197/197 words, REAL=0**
  — every differing word carries an `R_MIPS_26` on its own objdump line (17 unlinked
  `j`/`jal` targets). The function is byte-identical to retail.

## 2. `_mul_mant_d` 10 → 8 — hoist the arg out of the jal slot, put the real filler in

```
   move $19,$4                     move $19,$4
   sw   $0,28($sp)                 addu $4,$sp,24     <- up (retail's position)
   ...                    =>       sw   $0,28($sp) ...
   jal  _add_mant_d                jal  _add_mant_d
   addu $4,$sp,24  [slot]          srl  $16,$16,16    [slot]
   srl  $16,$16,16
```
Two rows; the second's `after` (`jal…(?=\t\.set\tmacro\n)`) only matches AFTER the first
row emptied that slot — self-disambiguating against the TU's second `_add_mant_d` site.
**Semantics:** `$4` is dead from `move $19,$4` to the call's own arg setup; `$16`=`$s0` is
callee-saved so the slot-executed `srl` survives `_add_mant_d` and reaches the following
`mult $18,$16` with the same value — which is exactly what retail does.

RESIDUAL (8, objdump REAL=6): retail stores the two result words through the SYM `out`
pointer still live in `$s3` (`lw v0,24(sp); lw v1,28(sp); sw v0,0(s3); sw v1,4(s3)`), and
re-loads the word it *just stored*; ours forwards the store, hoists `lw v1,24(sp)` above
`sw v0,28(sp)`, and stores through the RETURN copy `$v0`. Same store-forwarding /
value-reload class as `__adddf3` (b) and the TU's own documented (a) row. Not re-fought
this wave (budget), no new falsifications added.

## 3. 🔑 `__divdf3` 18 → 16 — **the 11B law is NOT `_add_mant_d`-specific**

The wired w63-a9 rows treat "retail loads the LAST register argument FIRST" as an
`_add_mant_d` row. The same shape appears at a `_dbl_shift` site in `__divdf3`:
ours `lw $5,24; lw $6,28; lw $7,40`, retail `lw $7,40; lw $5,24; lw $6,28`. One row:

```
{"take": "\\tlw\\t\\$7,40\\(\\$sp\\)\\n(?=\\t\\.set\\tnoreorder\\n)",
 "after": "\\tsw\\t\\$0,16\\(\\$sp\\)\\n(?=\\tlw\\t\\$5,24\\(\\$sp\\)\\n\\tlw\\t\\$6,28\\(\\$sp\\)\\n\\t\\.set\\tnoreorder\\n)"}
```
🔴 **HAZARD (cost one probe cycle, worth a briefing line):** my first formulation put
`\tlw\t\$7,40\(\$sp\)\n` inside the `after` LOOKAHEAD. `_apply_text_moves` searches
`after` in `region2` — the text *with the taken line already removed* — so the lookahead
could never match, the row was **silently skipped, and the gate reported the unchanged
baseline (18) as if the row were inert.** An `after` lookahead must never mention the
taken line. (Generalises w63-a9's loose-anchor hazard: that one mis-fired, this one
no-ops; both read as a plausible number.)

RESIDUAL (16): the `$L14` arm's `addu $16,$16,1` position and the `$L20` merge-point jal
slot pick (retail's slot = `addu $17,$0,$0`, ours = `addu $4,$sp,24`). Both are line
relocations in principle, but the block is a two-predecessor merge shared with the `$L2`
arm and the slot already contains an `#APP` fence — I did not risk an unverifiable splice
there. Named, not floored.

## 4. `__adddf3` 10 → 8 — prologue store relocation

Oracle: `addiu $sp,$sp,-0x60 ; sw $zero,0x30($sp) ; sw $s7,0x54($sp) ; …` — the
`rnd`/`uz` zero store is retail's **second** instruction; ours emits it 18th, after every
callee-save. One row (`take \tsw\t\$0,48\(\$sp\)\n`, `after \tsubu\t\$sp,\$sp,96\n`,
both unique in the fn region). Nothing between the two positions touches `48($sp)`.
**objdump REAL=4** afterwards — i.e. the ONLY real word differences left are the four
already-documented cse rows.

### 4b. The `__adddf3` cse value-sharing residual — the 15B "fenced named constant" axis is now CLOSED
The 4 residual rows are all "ours cse-shares a live value where retail re-materializes".
Catalog 15B says a falsified *plain* named temp does **not** close the axis because the
**fenced** named constant is a different lever. Probed (whole-fn gated, control 10):

| variant | diffs |
|---|---|
| fenced `int one = 1;` at `_dbl_shift(A,one,…,1)` site 1 | 12 |
| same at site 2 | 12 |
| both sites | 14 |
| void-tail fence between `rnd[0]=k;` and the `_add_mant_d` rounding call | 10 (inert) |
| fenced `unsigned normMask = 0xE0000000` around the normalise loop | 19 @222/221 |

The fence makes the *named* pseudo opaque, so the second use becomes a copy **from the
fenced pseudo** instead of from `$a1` — one copy either way, plus the fence's own
materialization. ⇒ 15B's escape clause does **not** apply to this class: it rescues a
*value* the compiler folds back, not a *constant the compiler is entitled to share*.
This confirms the standing W61-A9 verdict ("a cse COST-MODEL delta, not a spelling") from
the one direction the catalog said was still open.

## 5. `__fixdfsi` 5 — the standing mechanism attribution is WRONG (jump.c cited)

Three waves of receipts (W60-A5/W61-A9/W62-A8) name **jump.c's "conditional jump around an
unconditional jump" inversion** as the mechanism that eats retail's second `j`. **It is
not.** `jump.c:1894` gates that transform on
```
prev_active_insn (reallabelprev) == insn && no_labels_between_p (…) && simplejump_p (…)
```
i.e. the condjump must sit **immediately** before the simplejump. Our emitted stream is
`bnez $v1,Lshift / <v0=0> / j Lepi / Lshift:` — `prev_active_insn(j Lepi)` is the `v0=0`
store, **not** the condjump, so this gate never fires on our RTL at all.

The real difference, read off the oracle: **both** guards (`beqz $v0` at 0x800F68E8 and
`beqz $v1` at 0x800F68F0) target the SAME shared `return 0` block `.L800F6900`, and retail
places that shared block **after** the shift arm (so the shift arm needs its own `j`);
ours cross-jumps the two inline `return 0` sites into one block placed **before** the
shift arm (so the shift arm falls through). It is a **cross_jump merge-POSITION** question
(catalog W50 `do_cross_jump` "keeps the copy holding the LABEL"), not a branch inversion.

Answer to the briefed question — **does the 15D multi-line `drop_after` un-wrap express
the missing insn? NO**, and now with a reason: 15D's un-wrap makes the *assembler* supply
a **`nop`**; this residual needs a **`j` plus a new label plus a branch-polarity flip**.
`_apply_text_moves` can move, copy, wrap-as-slot and delete lines; `copy` can duplicate an
existing `j`, but nothing can mint the label it must target. The wish is therefore not for
an `insert` key — it is for a **block-placement / cross_jump-direction mechanism**.

Measured this wave (new, whole-fn gated, control 5 @62/63):
* void fence at the head of the shift block → **8 @63/63** — reaches oracle instruction
  COUNT, but by adding a `nop` (the fence blocks the branch's delay-slot fill), not by
  adding the `j`; the block order is unchanged. Recorded as a NEGATIVE with its
  mechanism, not landed (structurally further away).
* void fence after the shift / between the two `return 0` guards → 5, 5 (inert).

## 6. `sprintf` 44 — the sotn axis is CLOSED, and the 16-diff cluster gets a mechanism + a certificate

### 6a. The briefed "untried structural axis" does not exist
The w63-a9 note reported sotn's `sprintf` as having "`printf_info` as a BITFIELD STRUCT
copied by plain struct assignment from a static zero template where ours spells three raw
`sw`s". **Ours already is exactly that shape** — `recon/syslib/psx/libc/SPRINTF.c` declares
the 8-bitfield `printf_info` and does `info = D_8012348C;`; the three `sw`s are the
*codegen* (a `movstrsi` block move), not the source. A line-by-line diff of
`C:\Temp\ps1-decomp-refs\sotn-decomp\src\main\psxsdk\libc\sprintf.c` (307 lines) against
ours leaves only four real deltas, all probed (whole-fn gated, control 44):

| sotn delta | diffs |
|---|---|
| `u32 ch` instead of `int ch` | 44 (inert) |
| template as a sized `[1]` view + `D_8012348C[0]` | 44 (inert) |
| template as an unsized `[]` view + `D_8012348C[0]` | 44 (inert) |
| template through a `static … *const` pointer local | 44 (inert) |

(The other two deltas are ones where **ours is right and sotn is wrong for this oracle**:
`signed char *f` — this oracle uses `lb` — and the `flagZero` register variable, the
W-headline 327→179 lever, which sotn does not have. **$Id check:** the NFS4 image carries
`sys.c v1.140 / intr.c v1.75 / bios.c v1.86`; sotn carries `v1.83 / v1.73 / v1.77` — sotn
is a substantially older PsyQ drop, so shape divergence was expected and is what we see.)

### 6b. 🔑 The 16-diff template-copy cluster is a RELOAD SPILL-POOL row (two prior attributions retired)
`-dg`/`-dl` on the real CC1PSX say it outright:
```
;; Need 4 regs of class GR_REGS (for insn 72).
Spilling reg 8.  Spilling reg 9.  Spilling reg 10.  Spilling reg 11.
```
insn 72 is `(parallel [(set (mem/s:BLK …528(fp)) (mem/s:BLK (symbol_ref "D_8012348C"))) (clobber (scratch:SI))×4 …]) movstrsi_internal`.
The four registers are **reload scratches**, not allocnos — so:
* **W61-A9's "local-alloc QTY handout (the 06E gap)" attribution is wrong** (no qty is involved), and
* **W62-A8's "downstream of the split-address form" attribution is wrong** (the split form is
  already landed via `no_split_addresses`, and the handout did not move).

`reload1.c:3840 order_regs_for_reload` builds `potential_reload_regs` as: first every hard
reg with **zero pseudo-allocated `REG_N_REFS`** *and* `call_used`, **ascending regno**;
then the zero-use callee-saved; then the rest sorted by increasing use.
Our `-dg` register dispositions put pseudos in `$2,$3,$4,$5,$6,$7` (171 in `$v0` and 15 in
`$v1` from local-alloc alone) and **none** in `$t0-$t3` ⇒ our tier-1 pool starts at `$8`.
Retail's copy takes `$5` for the base and `$2,$3,$4` for the words — the identical
template ordering (words from the first three pool entries, base from the fourth), one
pool-head lower. This is the **same class as W42's `ReadIn` `$v0` wall** ("~150 pseudos
homed in `$v0`, so `order_regs_for_reload` never offers `$v0`"), i.e. a whole-function
allocation property.

### 6c. Hardness certificate (both routes measured)
* **Source route** — rewriting the copy so the four values are ordinary pseudos instead of
  `movstrsi` scratches: `const int *tp = …; ((int*)&info)[k] = tp[k];` **52** and its
  named-temp variant **52** (the shape survives — still `la` + 3 `lw` + 3 `sw` — and the
  registers move to `v0/v1/a0/v0`, ONE rotation from retail's `a1/v0/v1/a0`, but the
  block-local qty priority always births the base first so it takes `$v0`);
  `info = *(printf_info*)&D_8012348C` 44; a 3-int struct pun 44.
* **Pin-adjacent route** (EVIDENCE ONLY, not landed — needs the user sign-off the
  AGENT_GUIDE requires): banning the pool head with a hard-reg clobber fence
  `__asm__("" : : : "t0","t1","t2","t3")` at fn top **50**, before the copy **48**,
  and `t0-t9` at fn top **146 @557**. The pool's next candidates are simply the next
  t-registers; nothing reaches `$v0`.
⇒ retail's pool head requires `$v0…$a1` to carry **no allocated pseudos at all** in a
545-instruction function. **Not reachable by any local source change.** Named, quantified,
not a floor claim about the function — a certificate about this one 16-diff cluster.

### 6d. 04Z ladder, re-run on the CURRENT basin (both lanes; the briefed rung table was stale)
`cc1_alt` (272 recipe, no maspsx), with `no_split_addresses` off for the sub-2.8 rungs
(they reject the flag — the 12G `_cc1_flags_for_rung` filter is not applied on the
`cc1_alt` path for a PER_TU `no_split_addresses`, worth an orchestrator note):

| rung | cc1_alt | cc1_ver (maspsx route) |
|---|---|---|
| control (default lane, wired) | **44** @545/545 | 44 |
| control (nosplit OFF) | 56 | 56 |
| 2.6.0 | 193 @520 | — |
| 2.6.3 | 175 @528 | 176 @529 |
| **2.7.2-970404** | **41 @546** | 47 @534 |
| 2.7.2 | 162 @529 | 153 @518 |
| 2.8.0 / 2.8.1 | 44 / 44 | — / 56 |
| 2.91.66 / 2.95.2 | 383 @542 / 291 @542 | — |

`2.7.2-970404` — **the rung already wired for `MEMMOVE.c`**, consistent with the W59-11G
"libc.lib looks Sony-prebuilt" reading — removes the entire format-pointer base-reuse
cluster and the `li v0,42` row, but *re-introduces* the `$at` jump-table fusion (−5, a
maspsx-only property the alt lane bypasses) and the `la` self-temp class (−6), and costs
+1 instruction. Net 41 @546 vs 44 @545. **Recommendation: do NOT wire** — it fails count
parity and trades a known-correct default-lane property for a smaller diff.

---

## 7. CORPUS SWEEP (coordinator's mid-wave item) — falsified, with two NEW byte-level receipts
Swept the 5 new repos + a name/semantic sweep over all 20 in `C:\Temp\ps1-decomp-refs`:
* **`mgs_reversing` carries no PsyQ SDK** — its `lib*` trees are Konami's own engine
  (`libdg/libgv/libgcl/libfs/libhzd/libsio`); 1 file mentions `double`, zero IEEE-754
  constants; every `0x7FF` hit is an angle/coordinate wrap mask. Same for
  `VandalHearts-PcPort`/`vh` (`rcos(a + 0x7ff)`), `TOMB5` and `KAIN2` (no hits at all).
  (Independently matches A8's correction.)
* 🔑 **`ff8-decomp/src/psxsdk/softfloat.c` is the ONLY file in the whole 20-repo corpus that
  names the Sony soft-float symbols** (`__divsf3`, `__floatsidf`, `_dbl_shift_us`,
  `__ltdf2`, `__mulsf3`, `_err_math` + per-object trailing labels) — and it is **30
  `INCLUDE_ASM` lines with ZERO lines of C body**.
* 🔑 **`parasite-eve-2-decomp/lib/libmath/` ships 15 PREBUILT vendor objects** with exactly
  our TU names (adddf3, addmant, dbshift, dbshiftu, divsf3, ferr, fixdfsi, fixsfsi,
  fltsidf, fltsisf, mainasu, muldf3, mulsf3, negdf2, subdf3) — PE2 links them rather than
  decompiling. I decoded `muldf3.o`: `__muldf3` is **197 words, 180 byte-identical to our
  oracle, all 17 differences `j`/`jal` targets** ⇒ the same Sony vendor object, now
  confirmed at the byte level from a fourth SDK-consumer. (Its `.note` is only a
  `psyq-obj-parser`/pcsx-redux conversion stamp; no debug sections, no source oracle.)
⇒ **04X stands, now 6× confirmed and for the first time byte-level, not name-level.**

---

## 8. Files / artifacts
* **`scratchpad/w64a9/TEXT_MOVES_SPEC.json`** — the orchestrator deliverable (6 rows,
  3 TUs; includes the wired w63-a9 rows so the file can be applied whole).
* `scratchpad/w64a9/wordcmp.py` — reloc-classified object↔oracle word compare
  (anti-vacuity: a word counts as RELOC only when `objdump -dr` prints a relocation on the
  *adjacent* line, per the 12H defect). **Promote-worthy** — it is the cheap
  "is this splice actually byte-true" check the 15D trap asks for.
* `scratchpad/w64a9/probe.py` — literal-replace variant runner, `finally`-restore,
  **CRLF-aware** (it now rewrites `\n` anchors to `\r\n` when the file is CRLF; without
  that every anchor silently matched 0 times — the 9th firing of that hazard).
* Probe batches: `spr_v1/v2/v3.json`, `add_v1.json`, `fix_v1.json`,
  `tm_muldf3/tm_divdf3/tm_adddf3.json`. Backups: `SPRINTF.c.base.bak`, `FIXDFSI.c.base.bak`.

## 9. Hazards hit (all caught)
1. **`after`-lookahead self-invalidation** (§3) — a TEXT_MOVES row whose `after` lookahead
   names the taken line can never fire and reports the baseline as "inert".
2. **`probe.py` CRLF** — `bytes.decode()` does no newline translation while
   `open(..., encoding=…)` does, so an anchor verified in one and used in the other
   silently matches 0 times.
3. **`tools/rtl_dump_c.py` ignores the TU's wired rung** — it always drives the default
   `CC1PSX`, so for a `cc1_alt`/`cc1_272` TU (DIVDF3) its `.s` is NOT the one TEXT_MOVES
   operates on. Use `build/<tu>.s` after a real gate run instead. (Worth a docstring fix.)
4. `tools/sbs.py` does not honour `W60_TEXT_MOVES_FILE` — it always renders the BASELINE
   (same class as w63-a9's `tugate.py` note). Read scores from `vprobe`, not `sbs`.
