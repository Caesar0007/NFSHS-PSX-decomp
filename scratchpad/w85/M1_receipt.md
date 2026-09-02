# W85-M1 receipt — FntFlush (recon/syslib/psx/libgpu/FONT.c) + FONT.c device audit

Belt scope: FntFlush FAIL 6 @199/199 (board certificate), plus the wave's device audit of
FONT.c's flagged `asm` lines.  File WAS editable this wave; every experimental edit below was
gated and reverted.  The only change left in the tree is a **comment-only** mechanism addendum
(§7): with all `/* */` stripped, FONT.c is line-for-line identical to
`scratchpad/w85/M1_FONT_baseline.c`, and the gate is unchanged before and after.

Gate command (authoritative, run at start and end):
```
python tools/verify_asm.py recon/syslib/psx/libgpu/FONT.c FntFlush,FntPrint,FntLoad,FntOpen
```

## BASELINE / FINAL STATE (identical — no regression, no gain)
```
FntFlush: FAIL 6 diffs (ours 199 / oracle 199)
    +sw a2,28(sp) +sw a2,32(sp)      (ours emits the two colour defaults late)
    -sw a2,28(sp) -sw a2,32(sp)
    -addu a0,a2,zero  +lw a0,16(sp)  (reload_cse forwards the just-spilled dr)
FntPrint: PASS (240 insns)
FntLoad:  NO ORACLE   (not a FONT.OBJ function — the gate names do not exist in this TU)
FntOpen:  NO ORACLE
```
`FntLoad` / `FntOpen` are **not in FONT.c** and have no `asm/nonmatchings/main/*.s`; the TU
contains exactly two functions.  Nothing to gate there.

---

## 1. DEVICE AUDIT of FONT.c (the wave's classification applied line by line)

| line | text | class | disposition |
|---|---|---|---|
| 70 | `extern struct Font _fnt[8] __asm__("Font");` | **asm-NAME attribute** (symbol alias) | **KEEP** |
| 71 | `extern int _fnt_count __asm__("D_80135FD8");` | asm-NAME attribute | **KEEP** |
| 72 | `extern int _fnt_active __asm__("D_80135FDC");` | asm-NAME attribute | **KEEP** |
| 138, 229, 346 | `__asm__(...)` inside `/* */` | **comment text** (falsified-angle records) | not code |
| 561 | `__asm__("" : : "i"(0));` | **void-tail fence** (CLEAR list) | removal measured, **RESTORED** |
| 683 | `__asm__("" : "=r"(peel) : "0"(peel));` | **identity launder** (CLEAR list) | removal measured, **RESTORED** |

Lines 70–72 are **not codegen devices**: `__asm__("name")` on a declaration only renames the
link symbol (the W66-A3 alias onto splat's `Font` / `D_80135FD8` / `D_80135FDC` blob labels).
They emit no instruction, cannot influence scheduling or allocation, and removing them makes the
TU reference `_fnt`/`_fnt_count`/`_fnt_active`, which do not exist.  They are the same class as
the sanctioned BIOS-thunk symbol names, and stay.

Other device classes: **`volatile` = 0 in code** (all 7 hits are comment text), **`register …
asm("$N")` pins = 0**, **`&&label` V2 devices = 0** (all 6 `&&` are logical AND; the seventh is a
comment).  So the only true devices in FONT.c are the two FntPrint fences.

### 1a. Both FntPrint devices removed — measured
```
FntPrint: FAIL 3 diffs (ours 239 / oracle 240)
    +nop                              <- device @561's job (reorg delay-slot steal)
    -addu a2,v0,zero  +li a2,-1       <- device @683's job (the -1 sentinel)
```
The two residuals are **independent** (each device fixes exactly one; neither interacts).

---

## 2. 🔴 NEW LAW — FntPrint's `-1` residual is **reload_cse_regs**, NOT cse (corrects W63-A3)

The in-file W63-A3 note attributes the `addu a2,v0,zero`-vs-`li a2,-1` diff to *"cse's
constant-sharing"*.  **That attribution is wrong**, and every source spelling that was tried
against it was therefore aimed at the wrong pass.

RECEIPT — per-pass RTL dumps (`python tools/rtl_dump_c.py recon/syslib/psx/libgpu/FONT.c -ds -dL
-dt -dc -dJ -dg`, dumps in `scratch/rtl_a5/FONT.i.*`).  The two `-1`s survive as **two
independent constant loads** through cse, loop, cse2, combine **and greg** (greg is printed by
toplev.c *before* `reload_cse_regs`):
```
(insn 641 (set (reg/v:SI 5 a1) (plus (reg a1) (const_int -1))))      ; len--
(insn 644 (set (reg/v:SI 2 v0) (const_int -1)))  REG_EQUIV -1        ; peel sentinel
(jump_insn 647 (if_then_else (eq (reg a1) (reg v0)) ...))            ; REG_DEAD v0
;; End of basic block 48 / Start of basic block 49
(insn 651 (set (reg/v:SI 6 a2) (const_int -1)))  REG_EQUIV -1        ; loop sentinel
```
i.e. **post-reload we already emit retail's stream verbatim** (`addiu a1,-1; li v0,-1; beq;
li a2,-1`).  `reload_cse_simplify_set` (reload1.c:8178) then rewrites insn 651's source into the
lowest-numbered hard reg whose recorded value equals `(const_int -1)` — `$v0` — producing the
copy.  Gated only by `MEMORY_MOVE_COST >= 2` / `REGISTER_MOVE_COST == 2`, both hard-wired on MIPS
(mips.h:3172/3188, `MEMORY_MOVE_COST` is **mode-independent**), and by `optimize > 0` — **no `-f`
switch**.

Why the @683 launder works, mechanically: the asm **SETS** the `peel` pseudo, so `note_stores`
→ `reload_cse_invalidate_rtx` (reload1.c:7786) clears `reg_values[$v0]` — a **zero-instruction
register-value invalidator**.  That is the only thing it does.

⇒ This is the **same pass** as FntFlush's certificate (catalog 23A-2 / W75-A15).  FntPrint's
`-1` is its CONST_INT flavour; FntFlush's `addu a0,a2,zero` is its MEM flavour.  **One defect,
two functions, one TU.**

### 2a. Falsified source spellings for the `-1` (all gated, all reverted)
| spelling | FntPrint |
|---|---|
| `for (len--; len != -1; len--) WriteChar(*bufPtr++);` (plain, no scaffolding) | **3** (= device-free baseline) |
| `len--; while (len != -1) {…}` | 3 |
| `len--; if (len != -1) do{…}while(len != -1);` | 3 |
| peel var + inner `~0` | 3 |
| peel var + inner `do{neg1=-1;}while(0)` LICM shield | 3 |
| inner cond `len + 1 != 0` | **5** @239 (peel kept `li v0,-1`, loop becomes `addiu v0,a1,1; bnez`) |
| `for (len--; len >= 0; len--)` | **9** @237 (loses both `li -1` and the `beq` form) |

Note the useful side result: **the whole nested `{ { int peel; … int neg1; … } }` scaffolding is
inert once the launder is gone** — the flat `for (len--; len != -1; len--)` measures identically
(3).  The scaffolding exists only to give the launder a variable to attach to.

### 2b. Why no source vehicle exists
`reload_cse_regs` runs on the **final hard-register stream**.  `reg_values[$v0]` is cleared in
exactly three places: a `CODE_LABEL` (:7899), a `CALL_INSN` (:7929), and `note_stores` →
`reload_cse_invalidate_rtx` for any insn writing `$v0` or storing to an aliasing MEM (:7786).
Between insn 647 (the peel branch) and insn 651 there is **no label** — basic block 49 begins by
fall-through, and gcc does not emit a `CODE_LABEL` for a fall-through block.  Every C construct
that plants a surviving `CODE_LABEL` there needs a real reference (jump.c deletes a label whose
only reference is a fall-through `goto`, before reload — recorded in W75), and every C construct
that writes `$v0` there is an instruction.  A `-1` in a narrower mode would defeat
`reload_cse_regno_equal_p`'s CONST_INT mode guard (:8060), but MIPS `PROMOTE_MODE` forces SImode.

---

## 3. 🔴 NEW LAW — FntPrint's `+nop` is reorg `fill_eager`, with an **exhaustive** blocker list

The stolen insn is `li $20,37` (`percent`), the first insn of the **fall-through thread** of
`beq $4,$0,$L50`.  Read off reorg.c (gcc-2.8.1):

* `fill_eager_delay_slots` (:3899) computes `own_fallthrough = own_thread_p (NEXT_INSN (insn),
  NULL_RTX, 1)`.  With `label == NULL_RTX`, `own_thread_p` returns **0 if ANY `CODE_LABEL` sits
  between the branch and the next active insn** — and with `own_fallthrough == 0` and
  `prediction <= 0` the fall-through fill is **skipped entirely**.
* inside `fill_slots_from_thread` (:3514) the loop condition is
  `! stop_search_p (trial, ! thread_if_true) && (! lose || own_thread)`; for a fall-through thread
  `labels_p == 1`, so a `CODE_LABEL` **also** stops the scan, and `stop_search_p` returns 1 at any
  `ASM_INPUT`/`asm_noperands` insn — **that is exactly why the @561 fence works, and it is the
  only reason.**
* an *ineligible* candidate does **not** stop the scan (`lose = 1` but `own_thread == 1`), so
  making the thread head the 2-word `li $21,0xCCCCCCCD` does **not** protect `li $20,37`
  (measured: X1/X3/X5 below all still `+nop`).
* the one remaining refusal is `insn_sets_resource_p (trial, &opposite_needed, 1)` — the trial
  must not set a register live at the **branch target**.

✅ **PROOF PROBE** (`scratchpad/w85/M1_probe.py`, cc1 `.s` inspected directly): making `percent`
live at `fnt_done` (`return fs->written + (percent & 1);`) produces
```
	#nop
	beq	$4,$0,$L50
	li	$20,37
```
— the slot comes out EMPTY and `li $20,37` stays put, i.e. **the mechanism is confirmed by
experiment**.  The probe costs instructions (248 @240) so it is a diagnostic, not a fix.

### 3a. Falsified source spellings for the `+nop` (all gated, all reverted)
| spelling | FntPrint |
|---|---|
| `percent = '%';` (drop the W56 xor dependency shape) | **15** @239 — s4/s5 swap; the xor shape is load-bearing |
| `percent = '%';` computed **before** the zero-test | 15 @239 |
| `percent` computed inside the loop under a `do{}while(0)` LICM shield | 15 @239 |
| `percent = (ch ^ ch) ^ '%'` | 15 @239 |
| xor shape kept, `{ }` block braces dropped | **3** (identical — the braces are inert) |

⇒ zero-instruction vehicles for this slot are: an `asm` (what @561 is), or a **surviving
`CODE_LABEL` immediately after the branch**.  No C construct produces the latter for free here.

---

## 4. 🔴🔴 NEW LAW — FntFlush's 199-insn COUNT **depends on `reload_cse_regs`**; the standing
## "acquire a 2.8-shape cc1 WITHOUT reload_cse_regs" angle is **refuted as stated**

`-dg` shows that reload turns the three spilled colour defaults into **three separate
`li $6,128` insns**, one per store:
```
(insn 11  (set (mem sp+20) (const_int 0)))          ; xscreen
(insn 14  (set (reg:SI 6 a2) (const_int 128)))  (insn 538 (set (mem sp+28) (reg a2)))   ; r
(insn 16  (set (reg:SI 6 a2) (const_int 128)))  (insn 541 (set (mem sp+32) (reg a2)))   ; g
(insn 18  (set (reg:SI 6 a2) (const_int 128)))  (insn 544 (set (mem sp+36) (reg a2)))   ; b
(jump 21  bltz a0 ...)
```
Counted across the dumps (`awk '/;; Function FntFlush/,/;; Function FntPrint/' … | grep -c
"const_int 128"`, 2 hits per insn):
| dump | when | `li 128` insns in FntFlush |
|---|---|---|
| `FONT.i.greg` | after reload, **before** `reload_cse_regs` | **3** |
| `FONT.i.jump2` | after `reload_cse_regs` | **1** |
| final `.s` | — | **1** (== retail) |

`reload_cse_regs` is the **only** pass between those two dumps (toplev.c:3501), and the deleter is
`reload_cse_noop_set_p` (:8079) — the **same-register** branch of the pass, which drops
`(set (reg X) V)` when reg X already holds V.

⇒ **A cc1 that simply lacks `reload_cse_regs` would emit 201 insns for FntFlush, not 199.**
W76-A15's sufficiency lab reported "the two colour stores move to retail's early position", which
is exactly what three surviving `li/sw` pairs look like — the two extra `li`s were not counted.
The retail FONT.OBJ compiler therefore does **not** simply lack the pass; it must run the
**same-register noop deletion** (`reload_cse_noop_set_p`) while **not** running the
**cross-register substitution** (`reload_cse_simplify_set`).  Those are two separate functions in
reload1.c and are separable in principle.

**Revised acquisition/fingerprint target** (replaces W84-C1's "NAMED NEXT ANGLE" wording):
a 2.8-shape cc1 whose `reload_cse_regs` deletes redundant same-register constant loads but does
**not** substitute a register for a MEM or a CONST_INT into another hard register.  Two one-compile
acceptance tests, both on this TU:
1. `grep -c 'li\t\$6,128'` in the FntFlush `.s` **== 1** (noop deletion present), and
2. the region reads `sw $6,16($sp) ; lw $4,16($sp)` (no MEM substitution), and
3. FntPrint's sentinel reads `li $6,-1`, not `addu $6,$2,$0` (no CONST_INT substitution).

---

## 5. FntFlush — the three assigned angles, measured

### (a) "remove the spill/reload pair / attack the frame pressure" — **structurally self-defeating,
### now with the allocno numbers**
The `-dg` allocno data for FntFlush:
```
;; 23 regs to allocate: 93 94 165 170 164 92 103 83 80 215 82 91 84 87 89 88 90 81 85 99 98 97 86
;; Register dispositions: 80→$4 82→$19 83→$17 84→$21 87→$18 88→$23 89→$22 90→$30 91→$20 92→$16 …
;; Hard regs used: 2 3 4 5 6 16 17 18 19 20 21 22 23 30 31
```
Pseudos **81, 85, 86, 97, 98, 99** get **no disposition** — those are the six spills, and they are
exactly the six frame slots `dr@0x10 xscreen@0x14 max_y@0x18 r@0x1C g@0x20 b@0x24`, i.e. **retail's
frame, offset for offset, at retail's 0x50 size**.  All nine callee-saved registers (s0–s7, fp) are
already in use, so no register can be freed for `dr` without changing the frame — and the oracle
*contains* the spill pair (`sw a2,16(sp)` / `lw a0,16(sp)`).  Removing the spill would emit
`addiu a0,s3,16` and land at **198** insns.  ⇒ the premise "if no spill exists reload_cse has
nothing to rewrite" cannot reach the oracle: retail spills too.  The defect is the *rewrite*, not
the spill.

Colour-block shapes tried against the 4-diff half (all gated, all reverted):
| shape | FntFlush |
|---|---|
| `{ int c = 0x80; r = c; g = c; b = c; }` | 6 (cse folds it back to three const defs) |
| `r = 0x80; g = r; b = r;` | 6 |
| `b = 0x80; g = b; r = g;` | **8** |
| `xscreen = 0;` moved after the colours | **10** |
| `int rgb[3]` array (one `li` + three real stores) | **106 @201** — frame grows 0x50→0x58 (the array gets its own frame pool, 16A) |
(these join the six init-order permutations of W52, the five orders + three fence placements of
W53, and W55's `volatile` views — all already 6.)

### (b) instrumented-cc1 traces
Not needed and not used: the **stock** `-dg`/`-dl`/`-ds`/`-dt`/`-dc`/`-dJ` dumps from the *wired
retail* CC1PSX already isolate the actor to a single named pass and a single named function, and
they do it with a **retail binary** (no self-built compiler is involved anywhere in this receipt).
That is strictly stronger evidence than a trace from an instrumented build under the retail-purity
ruling.

### (c) RAW rewrite of FntFlush from scratch — **excluded by the dump, not by opinion**
The `.greg` dump proves our current C already produces **retail's post-reload instruction stream
verbatim at the defect site**:
```
(insn 75  (set (reg:SI 6 a2) (plus (reg s3) (const_int 16))))   ; addiu a2,s3,16
(insn 547 (set (mem:SI (plus (reg sp) (const_int 16))) (reg a2))) ; sw a2,16(sp)
(insn 117 (set (reg:SI 4 a0) (mem:SI (plus (reg sp) (const_int 16))))) ; lw a0,16(sp)
```
A different source can only change what reload produces; it cannot change what `reload_cse_regs`
does to a stream that is **already correct**.  Any rewrite that still spills `dr` hits the same
pass; any rewrite that does not spill `dr` misses the oracle by an instruction (see (a)).
⇒ angle (c) is falsified at the RTL level, for every possible rewrite, not sampled.

---

## 6. VERDICT / END STATE
* **FntFlush stays FAIL 6 @199/199** — the certificate holds, and it is now *sharper*: the actor is
  `reload_cse_regs`, both of its halves ((a) colour-store position **and** (b) the `dr` copy) are
  that one pass, and the retail fingerprint is refined from "lacks the pass" to "runs
  `reload_cse_noop_set_p` but not `reload_cse_simplify_set`" (§4).
* **FntPrint stays PASS 240/240** with its two fences **restored verbatim** (Iron Rule).  Both are
  KEEP-with-reason: each is a **zero-instruction invalidator/barrier for a post-reload pass**
  (`reload_cse_regs` value record @683; reorg `stop_search_p` @561), and both mechanisms were shown
  above to have **no zero-instruction C vehicle**.  They are not allocator crutches and no source
  spelling replaces them — 12 spellings measured across §2a/§3a, best 3 diffs vs PASS.
* **FntLoad / FntOpen**: NO ORACLE — not functions of this TU.
* No git operations, no `tools/*.py` edits, no memory edits, no new devices, no post-compile moves,
  no `volatile`, no self-built compiler.  `recon/syslib/psx/libgpu/FONT.c` is byte-identical to
  `scratchpad/w85/M1_FONT_baseline.c`.

Artifacts (all under `scratchpad/w85/`): `M1_FONT_baseline.c` (pristine copy), `M1_nodev.c`
(device-free working base), `M1_edit.py`, `M1_run.py`, `M1_batch.py`, `M1_batch2.py`,
`M1_probe.py` (cc1 `.s` region printer), `v1.json`…`v6.json` (the measured variant sets).

---

## 7. FILE CHANGES MADE (comment-only)
`recon/syslib/psx/libgpu/FONT.c` carries a **comment-only** W85-M1 addendum in three places —
the FntFlush header (§4/§5 above), the FntPrint `-1` block (the §2 attribution correction,
because the standing note there says "cse's constant-sharing" and that is wrong), and the
FntPrint delay-slot fence block (the §3 exhaustive blocker list).  Verified: with all `/* */`
stripped, the file is **line-for-line identical** to `scratchpad/w85/M1_FONT_baseline.c`, and the
gate is unchanged (FntFlush FAIL 6 @199/199, FntPrint PASS 240/240) before and after.
No other tracked file was touched by this belt.
