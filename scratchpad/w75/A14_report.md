# W75-A14 — libc / libmath belt (sprintf, __adddf3, __divdf3)

**Headline: 1 SEAL, 1 big reduction, 1 REAL SHIPPED BUG REMOVED FROM THE BUILD WIRING,
2 gcc-source-cited NEW LAWS, 1 multi-wave verdict REFUTED, 1 instrument-law correction.**

| fn | TU | baseline | final | state |
|---|---|---|---|---|
| `__adddf3` | `recon/syslib/psx/libmath/ADDDF3.c` | 2 @221/221 | **PASS 221/221** | 🏆 **SEALED** (gated 2x, tugate 1/1 twice) |
| `__divdf3` | `recon/syslib/psx/libmath/DIVDF3.c` | 12 @184/184 | **6 @184/184** | reduced −6, count-exact; TU 1/2 (the other fn `_comp_mant` was and stays PASS) |
| `sprintf`  | `recon/syslib/psx/libc/SPRINTF.c`      | 28 @545/545 | **25 @546/545** | reduced −3 **and a real runtime bug removed** (the +1 insn is the price of correctness, see §3) |

Zero PASS→FAIL anywhere. Regression-checked the sibling TEXT_MOVES TUs after the build.py
edit: `MULDF3.c` 2/2 PASS, `PADSEQD.c` 5/5 PASS, `ADDDF3.c` 1/1, `DIVDF3.c` 1/2 (unchanged).

Files touched: the three recon TUs + **one row removed** from `tools/build.py`
(`PER_FN_TEXT_MOVES["recon/syslib/psx/libc/SPRINTF.c"]`). The foreign uncommitted build.py
edits (psxcontroller row removal, the W75-A16 INTR.c ver-splice) were re-read immediately
before the edit and are PRESERVED; `ast.parse` gate run after the write. No commits, no staging.

---

## 1. `__adddf3` — SEALED. NEW LAW: the reload_cse CLOBBER ESCAPE

The W74-A19 receipt had closed this row as a **1-instruction hardness certificate**: ours
`addu $s0,$v1,$zero` where retail re-materializes `lui $s0,0xE000`, caused by
`reload_cse_simplify_set` (reload1.c:8178) rewriting `(set hardreg CONSTANT)` into a copy from
a hard reg already holding the value. Its escape list was **CODE_LABEL / CALL / register
overwrite / rung / flag**, each shown blocked, and it asked for a brand-new
`PER_FN_TEXT_REWRITE` build.py mechanism.

**The escape list was incomplete.** "Register overwrite" was read as *"nothing writes `$v1`
there"* when the right question is *"nothing writes `$v1` there **yet**"*.

### 🔑 NEW LAW (gcc-source-cited, zero insns)

`reload_cse_regs` invalidates its value table on **any CLOBBER**, not only labels and calls:
`reload1.c:7995-8007` walks a PARALLEL body and for every element that is **not** a SET calls
`note_stores (x, reload_cse_invalidate_rtx)`; `reload_cse_invalidate_rtx` (:7786) →
`reload_cse_invalidate_regno` (:7610) drops `reg_values[regno]`. An `__asm__` carrying a
hard-register clobber **is** such a PARALLEL — `(parallel [(asm_operands …) (clobber (reg $3))])`
— and it costs **zero bytes**. So a 20B-family clobber placed between the donor's set and the
constant's set makes reload_cse re-materialize, exactly like a rung without the pass.

### 🔑 THE PLACEMENT RULE — three constraints, each measured

1. **AFTER the donor's `(set $N CONSTANT)` and BEFORE the constant's second set.**
2. **ANCHORED BY A DATA DEPENDENCE.** A clobber-only `__asm__("" : : : "$3")` has *no operands*,
   so at sched1 it depends on nothing (the clobber names a HARD reg while the donor is still a
   pseudo — no output dependence exists yet) and the scheduler hoists it to the head of the
   block, ahead of the donor ⇒ **INERT** (measured: 2, the baseline; the `#APP` marker sat at
   `$L11` before the `lw`). Listing a live value as a read-only operand pins it.
3. **BEFORE THE BRANCH, never in the preheader.** `stop_search_p` (reorg.c:685-712) returns 1 at
   ANY asm, so an asm between the branch and the preheader kills the fall-through-thread steal
   that puts retail's `lui $s0` in the branch's delay slot ⇒ **3 diffs @222** (`nop` + the `lui`
   one line late). Put it before the branch and reorg's forward scan is unobstructed.

### The landing (source only, no wiring, no ladder change)

```c
normTest = A[1] & 0xE0000000;
__asm__("" : : "r"(normTest) : "$3");
if (normTest == 0) { do { _dbl_shift(...); ae -= 1; } while ((A[1] & 0xE0000000) == 0); }
```
The `do/while` peel is codegen-neutral on its own (W72 measured it inert at 2); the fence lands
the row. `$3` is the donor the W74 RTL localisation had already named.

**Measured ladder of the device:** baseline 2 · clobber-only asm inside the peeled block 3 @222 ·
clobber-only asm after a split `normTest` (no operand) 2 (hoisted, inert) ·
**read-only-operand fence + `"$3"` clobber before the branch → PASS 221/221.**
`psyqproof`: `INAPPLICABLE-LANE` (the TU is `cc1_alt: 2.7.2-970404`; the prover only drives psq43),
which is the expected state for the whole vendor-object libmath cluster.

### Transferability (this is the real prize)

Every remaining *"ours `addu rD,rS,zero` where retail re-materializes a constant"* row on a
**970404 / 2.8.0 / 2.8.1** lane is now a **one-fence job**: read the donor hard register off the
diff, find a live value defined between the two sets, fence it with that register clobbered.
NOT applicable on 2.6.x / 2.7.2 / 2.91 / 2.95 rungs (no reload_cse — W74's fingerprint table);
in particular **not** on DIVDF3, which is a 2.7.2 lane and whose row (a) W74 had already
cross-checked as a different class (that cross-check stands, and this wave solved row (a) by
other means — §2).
⚠️ The W74 "DO NOT re-spend budget on fences/launders/dials, they act on PSEUDOS" warning stays
correct for *pre-reload* devices; the clobber is different because it survives into the
post-reload insn stream as a real CLOBBER rtx.

---

## 2. `__divdf3` — 12 → 6, and a 3-wave verdict REFUTED

### 🔴 The W62/W72 "writes `ur.w.hi` twice ⇒ re-materialises the whole union head" verdict is FALSE

It is a **diagnosis error, not a mechanism**. The 64/70-diff readings for the 13C
inverted-default form are a clean **3-way register rotation and nothing else**:
`sbs` shows ours `{ur = $s0:$s1, n = $s2, exp = $s3}` against retail
`{n = $s0, exp = $s1, ur = $s2:$s3}` with **every other word identical**.
Nobody had ever run `sbs` on the falsified variant — the raw diff COUNT was taken as the verdict.
(Catalog 09K / 21E-3 restated: judge a structural move on the sbs, never on the count.)

### Landing 1 — the shape

Retail's div-by-zero arm IS the 13C inverted default:
```c
ur.w.hi = -1;
if (sign == 0) ur.w.hi = 0x7FFFFFFF;
ur.w.lo = -1;
```
giving retail's `bnez $s4` polarity, `li $s3,-1` backward-stolen into its delay slot, the FRESH
`lui $s3,0x7FFF; ori` on the fall-through and `li $s2,-1` in the `j` slot. The ternary's funnel
copy `addu $s3,$v0,$zero` and its cse-shared `lui $v0,0x7FFF` both disappear.

### Landing 2 — the seat, predicted from the dump then measured

`ur` is ONE DFmode pseudo and a `(set (subreg:SI (reg:DF)) …)` is a **partial write**, so flow
keeps the pair live from function entry (dump reg 76: 19 refs / 159 insns / crosses 11 calls) —
that is why the result pair is callee-saved at all. Each `ur.w.X = …` therefore costs **two**
refs, and the extra store moves 17 → 19 and lifts `ur` past `n` in the serving order.

**🏆 INSTRUMENT-LAW CORRECTION (12A / `tools/qty272.py`): this lane's priority formula HAS the
SIZE term.** Measured on `scratchpad/w75/rtl/DIVDF3.i.greg` (cc1 = `windows-gcc-psx/gcc-2.7.2-psx`,
the wired rung):

```
pri = floor_log2(refs) * refs / live_length * SIZE      (size in words)
```
The printed `;; 11 regs to allocate: 74 (2) 75 (2) 76 (2) 79 130 127 78 80 117 81 77` is
reproduced **11/11** by the SIZE form and **not** by the size-free form (which would rank 79 and
130 ahead of 74/75/76). `qty272.py`'s `pri()` docstring claims the size-free rule "for the 272
lane"; that was validated on PsyQ **CC1PSX** — it does **not** hold for the windows-gcc-psx
2.7.2 rung. **Re-derive the formula per cc1 binary, not per "lane".**

**🔧 TOOL BUG (one-liner, for the owner):** `qty272.parse_greg` crashes on any dump containing a
multi-word allocno — the `;; N regs to allocate:` line prints a ` (2)` word-count suffix that
`ALLOC_RE`/`int()` reject (`ValueError: invalid literal for int() with base 10: '(2)'`).
`reqdelta272.py` inherits the crash. All numbers above were read by hand.

**Pricing:** `pri(76 = ur) = 4·19/159·2 = 0.956` vs `pri(79 = n) = 3·8/28·1 = 0.857`.
**One extra reference on `n`** gives `3·9/28 = 0.964 > 0.956` and flips the pair. Delivered by
adding a **second `"r"(n)` operand to the 05C ref-fence that was already there** — zero insns, no
new asm, no new local. `find_free_reg` then hands `$s0` to `n`, the lowest free EVEN pair
`$s2:$s3` to `ur`, and `$s1` to `exp` — retail exactly.

**Measured:** baseline (ternary) 12 · inverted default alone 64 @184 (the rotation) ·
+ `"r"(exp)` ×1/×2/×3 on the fence 64/64/64 (**wrong allocno** — `exp` is reg 78, priority 0.248,
nowhere near the boundary; recorded so the operand choice is not re-guessed) ·
**+ a second `"r"(n)` → 6 @184.**
Also falsified: splitting the result into two scalar `int rhi, rlo;` assembled once at the exit
→ 29 @183 (they cross NO calls so they land caller-saved `$v0/$v1`; retail's `$s2:$s3` pair is
positive proof the result IS the partially-written DFmode union, not two ints).

### Residual 6 — both rows are the SAME reorg mechanism

Two `!own_thread` **target steals** that reorg performs for retail and declines for us:
* idx 27 — retail copies `lui $v0,0x7FFF` (the ua-guard mask's first half, which also stays at
  its home idx 34) into the `bnez $t2,$L2` delay slot and re-points that branch one insn later;
  we emit `nop`. `$L2` has TWO predecessors ⇒ this is the COPY path
  (`reorg.c:3635 temp = own_thread ? trial : copy_rtx (trial)`), gated by
  `! insn_sets_resource_p (trial, &opposite_needed, 1)` (:3574) with
  `opposite_needed = mark_target_live_regs(fall-through)`. Prediction is fine
  (`mostly_true_jump` returns 1 for NE, reorg.c:3961), so the refusal is a liveness claim on
  `$v0` at arm 1's head — and `mark_target_live_regs` is CFG-stale (13E).
* idx 133/145 — the same copy at the `exp >= 0` arm's `j`, where retail puts the join's
  `addiu $a0,$sp,24` in the `j` slot AND keeps a copy that arm 2 falls through.

**NAMED NEXT ANGLE:** dump `-dd`/`-dR` on this rung and read which resource makes
`opposite_needed` claim `$v0`; the source lever, if any, is to kill a `$v0` use at arm 1's head.
A fence cannot help (13B: a fence blocks theft, never supplies it). Mechanism-wise both rows need
a **COPY, not a move**, so `PER_FN_TEXT_MOVES` cannot express them — that is the 11B
"TEXT_MOVES COPY variant" ask, and under the new user policy it is not a route anyway.
W72's four duplicate-the-call / per-arm-pointer / launder spellings (52-84) were priced when
row (a) still cost 6 insns; 04Z says re-price before trusting them. **NOT a floor.**

---

## 3. `sprintf` — a REAL SHIPPED BUG, one landing, and the biggest class RTL-localized

### 🔴 (A) The w63-a9 `PER_FN_TEXT_MOVES` row was a GATE-BLIND DEAD-CODE BUG — REMOVED

The row moved `la $7,$LC0` into the `j $L98` delay slot with `slot: True`. **`la` is a
two-instruction MACRO**: gas expands it to `lui $7,%hi; addiu $7,$7,%lo`, so the wrapper put
`lui` in the slot and left the `addiu` **after the taken jump**, where it never executes:

```
59c: 0800016b  j     5ac
5a0: 3c070000  lui   a3,0x0        <- delay slot
5a4: 24e70000  addiu a3,a3,0       <- UNREACHABLE
```
⇒ on the `%X` and `%p` paths `hexChars` kept only the `%hi` half of the string address — a
64K-aligned garbage pointer that `hexChars[num % 16U]` then dereferences. Same class as
`_padInitDirSeq` (15D) and `HeliCam` (17C); **4th firing**.

**🔑 NEW STANDING SAFETY LAW** (banked as a comment at the removal site in `tools/build.py`):
> a `slot: True` TEXT_MOVES row may only take a line that assembles to **exactly one machine
> word** — never `la`, never a 32-bit `li`, never an absolute `lw`/`sw`/`div` macro
> (cf. 23C-6). **Audit every existing `slot` row against this.**

gcc had refused that slot **on purpose**: under `-mno-split-addresses` the address load is one
RTL insn of `length` 2 and `eligible_for_delay` rejects it. The row overrode a correct compiler
decision at the text level. (The removal is also aligned with the new user policy on
post-recompile rewrite rows — I removed one and added none.)

**Cost, probe-verified 2×: 28 @545 → 29 @546** (the slot becomes a `nop`). Correct code.

**🔑 …and it re-opens the flag question.** Retail's three words are
`lui $a3,%hi ; j $L98 ; addiu $a3,$a3,%lo [slot]` = a **split-address pair** whose second half
reorg legally sinks into the slot ⇒ **retail was built with split addresses at this site**, and
`no_split_addresses` is a *paper-over* of the w59 `lui $v0; addiu $a3,$v0` self-temp class (the
§3.15-CORRECTION HI-scratch class — a **declaration-shape** question) that makes retail's shape
unreachable here by construction. Measured (row removed in all three):

| lane | gate |
|---|---|
| `no_split_addresses` ON (wired) | **25 @546** |
| `no_split_addresses` OFF | 46 @545 (count-exact) |
| OFF + `g_value` 4 / 8 | 46 / 46 — `-G` inert (the literals are `.rdata`, so 22A-5's small-data gate never fires) |

**ORCHESTRATOR CALL:** the honest next step for this TU is to fix the self-temp class on the
SPLIT lane (unsized-array / storage-shape levers, §3.12 #5) and then drop the flag, rather than
keep buying 18 diffs with a papered-over address form.

### 🏆 (B) The case-'c' slot row SOLVED (−4): split the cursor advance

`args` is memory-homed (its address escapes through `va_start`), so `args += 4;` is ONE statement
expanding to lw/addiu/sw, and sched2 keeps the addiu and the sw adjacent; the `j`'s backward slot
fill then takes the block's last insn, `sb $v1,0($s1)`. **Retail's slot is the args STORE.**
Naming the new cursor splits the halves so each lands where retail put it:

```c
argChar = *(unsigned char *)args;
nextArgs = args + 4;          /* addiu -> the lbu's LOAD-DELAY slot */
*bufPtr  = argChar;           /* sb                                 */
args     = nextArgs;          /* sw   -> the j's delay slot         */
```
29 → **25**. The three plain store-order permutations the w61-a9 receipt priced at 62 are all
**35 @548** on this basin (the addiu leaves the load-delay slot ⇒ two `nop`s); `len = 1` position
is inert. Reusable anywhere a memory-homed cursor's advance must straddle another store.

### (C) The format-pointer cluster (16 of the 25) — RTL-localized, angle sharpened

The standing note said only *"post-RTL base-reuse choice"*. The cse dump
(`scratch/rtl_a5/SPRINTF.i.cse`, insns 309/311/315/317) shows every `ch = *++f;` site has the
identical and already-correct shape:

```
(set (reg N)   (mem (addressof f)))            ; reload f
(set (reg N+1) (plus (reg N) 1))               ; f+1
(set (mem (addressof f)) (reg N+1))            ; store f
(set (reg QI)  (mem:QI (plus (reg N) 1)))      ; load off the RELOADED base
```
i.e. cse already canonicalises the load base to the reloaded `f`, not to the increment. The
divergence appears only where a SECOND site follows a first with no memory kill between: the
reload pseudo is store-to-load forwarded, and then **the `addiu` operand folds TWO levels**
(`reg143 + 2` = retail's `addiu $v0,$a2,2`, which **we also emit**) while **the MEM address folds
only ONE** (`reg144 + 1` = `lb $a1,1($a3)`; retail keeps folding to `2($a2)`). That asymmetry is
cse's `canon_reg` + `find_best_addr` pair: canon_reg rewrites the address base to its quantity's
FIRST register (the earlier increment pseudo) and find_best_addr only replaces an address when a
candidate is **strictly** cheaper — `(plus reg144 1)` and `(plus reg143 2)` cost the same, so the
incumbent wins.

⇒ **the `$a3`-vs-`$v0` register half is a CONSEQUENCE, not a cause**: with the a2-based address
the increment pseudo dies at its store and takes the lowest free caller-saved reg. This retires
the w74-a16 §4 reading that the two halves are separate classes.

Re-falsified on this basin (04Z, `scratchpad/w75/A14_spr.py`): `f = f + 1; ch = *f;` at the two
second-read sites 28 (inert) · `ch = *(f += 1);` 28 (inert) · `ch = f[1]; f = f + 1;` 41 @544 ·
`f = f + 1; ch = *f;` at ALL NINE sites 28 (inert) · `ch = f[1]; f = f + 1;` at all nine 78 @537.

**NAMED NEXT ANGLE (not a spelling):** break the store-to-load forwarding chain for the ADDRESS
while keeping it for the `addiu`. An opacity fence on `f` cannot do it (it kills both halves).
Remaining routes: a cse-table instrument read on the psq43 2.8.0 lane, or the SPLIT-address lane
of §3(A), where the whole address basin is different.

### (D) 04Z flag re-ladder on the 25-basin

`cc1_ver 2.8.1` 25 (identical) · `no_strength_reduce` 25 (inert) · `no_builtin` 25 (inert) ·
`no_schedule_insns2` 55 @548.

### Remaining 25, by row
format-pointer cluster 16 (C) · `li $s3,48` emission order 2 (closed: an appearance-order
property of the LICM preheader group — the three flag literals are born inside the loop,
`flagZero` before it) · `la`/`j`/`nop` slot 3 (A — a SPLIT-lane row, and correct code as it
stands) · the two `li $v0,42` / `nop` slot rows 4 (downstream of C). **NOT a floor.**

---

## 4. Orchestrator items addressed

* **`[reload_pick]` (A20):** read the report + recipe. **Lane check done — and the instrument
  does not serve any residual row on this belt.** `SPRINTF.c` is a 2.8.x lane (default psq43
  CC1PSX 2.8.0), so it would be *usable*, but its remaining rows are decided **pre-reload**:
  §3(C) proves the format-pointer row is a cse `canon_reg`/`find_best_addr` address choice, and
  W74-A16 §4's far-away-clobber experiment had already shown the temp is **not** a reload
  register (it moves under an in-loop fence, not under a function-wide clobber). `ADDDF3.c` and
  `DIVDF3.c` are `cc1_alt` 2.7.2-family lanes, where the report itself says fidelity is useless
  (1/26). No ±1 uniform scratch rotation exists in any of the three diffs.
* **No new post-recompile rewrite rows** (user policy, 75be7d4c): complied — I **removed** one
  TEXT_MOVES row (a dead-code bug) and added none. Both landings this wave are pure source.
* `tools/posmis.py` noted; all three fns are count-exact or +1, and every residual here is a
  named row rather than a positional-drift cloud, so `sbs` was the working instrument.

## 5. Catalog rows proposed

1. **reload_cse CLOBBER ESCAPE** (§1) — the 3-part placement rule; supersedes the W74-A19
   "no escape / needs PER_FN_TEXT_REWRITE" certificate on ADDDF3 and generalises to every
   `addu rD,rS,zero`-vs-re-materialized-constant row on a 970404/2.8.x lane.
2. **`slot: True` SINGLE-WORD SAFETY LAW** (§3A) — plus: an existing wired row can be a
   *shipped* bug; audit all `slot` rows for macro takes.
3. **A DIFF COUNT IS NOT A DIAGNOSIS** (§2) — a 64-diff "falsified" variant was a 3-way seat
   rotation over an otherwise-identical stream. Run `sbs` on every falsified structural variant
   before banking the verdict; 3 waves were spent on the wrong axis here.
4. **`qty272` SIZE-TERM CORRECTION + the multi-word parse crash** (§2) — the priority formula is
   per-cc1-binary, not per-lane.
5. **SPLIT A MEMORY-HOMED CURSOR'S ADVANCE** (§3B) — `p = q + N; …; q = p;` puts the addiu in a
   load-delay slot and the sw at the block tail; a sched2 dial with no insn cost.
6. **PARTIAL SUBREG WRITE ⇒ WHOLE-FUNCTION LIVENESS + DOUBLE REFS** (§2) — a `union.word = x`
   store to a DFmode pseudo is a read-modify-write: it costs 2 refs and makes the pair live from
   function entry. That is why soft-float result unions are callee-saved, and it is the
   quantity to price before adding or removing such a store.

## 6. Artifacts (all untracked, under `scratchpad/w75/`)

`A14_ADDDF3_base.c.bak`, `A14_DIVDF3_base.c.bak`, `A14_SPRINTF_base.c.bak` (pre-wave backups) ·
`A14_probe.py`, `A14_probe_sbs.py`, `A14_spr.py`, `A14_spr2.py`, `A14_spr3.py` (probe harnesses,
restore-on-finally) · `A14_div_v1..v6.c` (variants) · `A14_div_sbs.txt`, `A14_div_v2_sbs.txt`,
`A14_div_v6_sbs.txt`, `A14_sprintf_sbs.txt`, `A14_spr_25_sbs.txt` · `A14_moves_empty.json` ·
`A14_rtldump.py` (rtl_dump_alt at the correct root depth — `tools/rtl_dump_alt.py` still carries
the `parents[2]` promotion bug and resolves ROOT to `C:\Temp`) · `rtl/DIVDF3.i.{greg,lreg}`.
