# W75-A2 — psxfront font belt (`FontUpsideDownBlit__FiiPviiP12charactertbli`)

Repo `C:\Temp\nfs4-decomp`, unit `frontend/psx/psxfront`, TU
`recon/frontend/psx/psxfront.cpp`.  Board 89.60% at brief time.

## BASELINE (re-gated from HEAD `a604a578`, before any edit)

| item | value |
|---|---|
| `tools/tugate.py recon/frontend/psx/psxfront.cpp` | **24/25 PASS** |
| the one FAIL: `FontUpsideDownBlit__FiiPviiP12charactertbli` | **20 diffs @ 82/82** |
| W74's "true basin" body (tint-late, dv-first, split view) re-gated | **44 diffs @ 82/82** (reproduces exactly) |

Live TU byte-identical to `scratchpad/W74_A8/psxfront.cpp.W74A8_landed`; snapshot
kept at `scratchpad/w75/A2_psxfront.cpp.base`.  **No file was left modified —
final `tugate` re-run at the end is identical to the baseline (24/25, 20).**

## 1. THE BRIEF'S DECISIVE TEST — TEXT_MOVES PRE-FLIGHT: **ILLEGAL, both basins**

Tool written for this: `scratchpad/w75/A2_preflight.py` (reads a `tools/sbs.py`
dump, computes the line MULTISET difference, then checks the moved lines for
labels/`.set`/branches).  Catalog 23D-2 says a `PER_FN_TEXT_MOVES` row is legal
only if the residual is a pure line-multiset PERMUTATION.

```
20 basin (HEAD)   ours 82 / oracle 82   lines only in ours 6 / only in oracle 6  -> NOT a permutation
44 basin (W74)    ours 82 / oracle 82   lines only in ours 9 / only in oracle 9  -> NOT a permutation
```

The asymmetric lines are the **same 6 in both basins** — a `$v0`↔`$v1` role swap
on the RMW2 (palette-cell) read/modify/write plus the `li 9`/`sb 3(t1)` setlen
pair:

```
ours    and v0,v0,t5 | li v0,9 | lw v0,0(t2) | or v0,v0,t3 | sb v0,3(t1) | sw v0,0(t2)
oracle  and v1,v1,t5 | li v1,9 | lw v1,0(t2) | or v1,v1,t3 | sb v1,3(t1) | sw v1,0(t2)
```

plus, in the 44 basin only, `gFontClut` in `$a2` (ours) vs `$v0` (retail).

**VERDICT: no TEXT_MOVES row can express this residual — it is a REGISTER
difference, i.e. real allocation.**  The queued W74 "sched2/TEXT_MOVES pass" is
therefore closed as *statically refuted*, and the belt moved to source dials, as
the brief instructed.  Files: `A2_preflight_20.txt`, `A2_preflight_44.txt`.

## 2. 🏆 THE NEW NAMED ANGLE — THE `true_dependence` ALIAS ESCAPE (gcc-cited, WORKS)

### The blocker, read off the RTL (not guessed)

`scratchpad/w75/A2_k44_psxfront.i.lreg` (protected copy of the fixed-path
`rtl_dump.py` output for the 44 body):

```
(insn 119 (set (reg 125) (high (symbol_ref "*font_tint"))))
(insn 122 (set (reg 126) (mem/s:SI (lo_sum (reg 125) (symbol_ref "*font_tint")))))
          deps: 105, 116, 119          <-- 116 IS RMW2's STORE
(insn 116 (set (mem/s:SI (reg 88)) (reg 122)))        = pal->addr = (uint)prim
```

The tint LOAD carries a **true dependence on the palette-cell STORE**, so no
scheduler pass can ever put it where retail has it (oracle slot 34, i.e. between
RMW2's read at 33 and RMW2's `and` at 35).  That single edge is the whole
`$v0`/`$v1` wall: retail's `lui %hi(font_tint)` is issued at slot 31, occupies
`$v0` across RMW2's window, and forces RMW2's temp onto `$v1`.

### The escape, from the compiler source

`gcc-2.8.1/sched.c` `true_dependence()` (≈ lines 830-856) returns 0 when

```
   MEM_IN_STRUCT_P(store) && rtx_addr_varies_p(store)  &&  GET_MODE(store)!=QImode
&& !MEM_IN_STRUCT_P(load)  && !rtx_addr_varies_p(load)
```

* `rtx_addr_varies_p(load)` is **0 for a split address** — `rtlanal.c:108`
  `case LO_SUM: return rtx_varies_p (XEXP (x, 1));` and operand 1 is the
  `symbol_ref`, which never varies.  So the split form already satisfies half of
  the guard.
* the blocker was `MEM_IN_STRUCT_P(load)`, which the W74 view sets because
  `font_tint_v[0]` is an **ARRAY_REF**.  `expr.c:5531` sets `MEM_IN_STRUCT_P` on
  an `INDIRECT_REF` only when the address is a `PLUS_EXPR`, the type is
  aggregate, or the operand is a **bare `ADDR_EXPR` of an aggregate** — so
  `*font_tint_v` and `*(u_long *)font_tint_v` do NOT escape (the decayed array is
  still an `ADDR_EXPR` of an `ARRAY_TYPE`; measured, and confirmed in the dump:
  still `mem/s`).

### The device that satisfies both legs

```c
extern double font_tint_d __asm__("font_tint");     /* 8 bytes -> NOT small data */
...
*(u_long *)&prim->r0 = *(u_long *)&font_tint_d;     /* cast INDIRECT_REF -> no /s */
```

* 8 bytes > `-G4` ⇒ `mips_check_split` (`mips.c:893`, gated on `SYMBOL_REF_FLAG`
  = small-data) still splits the address ⇒ the real `lui %hi` / `lw %lo` pair
  retail needs (a 4-byte scalar extern can NEVER split, and no maspsx/ASPSX macro
  expansion can separate the halves — the W72 finding, re-confirmed);
* the cast makes it an `INDIRECT_REF` of a **non-aggregate** through a
  `NOP_EXPR`, not an `ADDR_EXPR` of an array ⇒ `MEM_IN_STRUCT_P` **clear**.

RTL after the change (`A2_D4_double_view_psxfront.i.lreg`):

```
(insn 122 (set (reg 126) (mem:SI (lo_sum (reg 125) (symbol_ref "*font_tint")))))
          deps: 119                     <-- the RMW2-store edge is GONE, and no /s
```

### Result — the multi-wave wall is dissolved

cc1 now emits retail's interleave verbatim, RMW2 in `$v1`:

```
ours(D4)                          retail
lui  v0,%hi(font_tint)            31 lui v0,0
sw   v1,0(t1)   RMW1 store        32 sw v1,0(t1)
lw   v1,0(pal)  RMW2 read  -> v1  33 lw v1,0(t2)
lw   v0,%lo(font_tint)(v0)        34 lw v0,0(v0)
and  v1,v1,<0xff000000>           35 and v1,v1,t5
or   v1,v1,t3                     36 or  v1,v1,t3
sw   v1,0(pal)  RMW2 store        37 sw  v1,0(t2)
sw   v0,4(t1)   tint store        39 sw  v0,4(t1)
```

This is the residual that W62/W67/W71/W72/W74 all filed as "the tint/RMW2 $v0-$v1
role swap; route = the instrumented-cc1 sched/find_free_reg trace".  It was never
an allocator question at all — it was **one alias-dependence edge created by the
declaration shape of `font_tint`**.

### The side effect, and its cure (20B, zero-insn, pin-free)

Alias-freedom lets the palette pointer coalesce onto the dead `y` REGPARM `$a1`
instead of retail's `$t2`; the function then needs 15 registers instead of 16,
never spills `v` to a callee-saved home, and **loses its whole frame** — 78 insns
vs retail's 82 (`subu sp` / `sw s0` / `lw s0` / `addu sp`).

Cure = catalog **20B** non-volatile tied launder + hard-reg clobber (zero insns,
NOT a sched1 barrier), placed inside the pal pseudo's live range (22B-1):

```c
pal = (PSXFront_PTag *)Render_gPalettePtr;
__asm__("" : "=r"(pal) : "0"(pal) : "$5");        /* deny $a1 */
((PSXFront_PTag *)prim)->addr = pal->addr;
__asm__("" : "=r"(pal) : "0"(pal) : "$5");        /* second site: the 0xff000000
                                                     mask took $a1 otherwise */
pal->addr = (uint)prim;
```

ONE launder alone: `pal` moves to `$t2` (retail) but the `0xff000000` mask takes
the freed `$a1` — still 78 insns.  BOTH launders: **count-exact 82/82 again, and
`v` is back on `$s0` with the frame**.

## 3. MEASURED LADDER (every row re-gated; nothing landed)

| variant | gate | note |
|---|---|---|
| HEAD (landed body, tint-early) | **20 @ 82/82** | store order != retail's; W74 proved it cannot PASS |
| W74 44-body (array view) | 44 @ 82/82 | control, reproduces |
| 44-body + `*font_tint_v` / `*(u_long*)font_tint_v` / `*(u_long*)&font_tint_v[0]` | 44 | `/s` survives — the ADDR_EXPR-of-array arm of expr.c:5531 |
| 44-body + `u_long font_tint_2[2]` (deref or index) | 44 | same |
| **44-body + `double` view (D4)** | 78 @ **78**/82 | alias edge gone, tint/RMW2 cluster EXACT, frame lost |
| D4 + one `"$5"` pal launder | 80 @ 78/82 | pal -> `$t2` ✓, mask steals `$a1` |
| **D4 + TWO `"$5"` pal launders (G2)** | **48 @ 82/82** | count-exact, frame back, `v`->`$s0`, pal `$t2`, mask `$t5`, RMW2 `$v1` |
| **G2 + the same view on `gFontClut` (I1)** | **46 @ 82/82** | best of the true basin this belt; the clut HIGH is now `$v0` too |

Residual anatomy of the I1 basin (46) — three independent 2-register swaps, no
structural diffs left in the tint/link cluster:

* (a) `yoff` `$t3` vs retail `$t4` and the `0x00ffffff` P_TAG mask `$t4` vs retail
  `$t3` (9 lines).  A qty **serving-order inversion**: with
  `floor_log2(refs)*refs*SIZE/live`, `yoff` prices .33 (refs 3, live 14) against
  the mask's .11 (refs 3, live 29), so ours serves `yoff` first and it takes the
  lower `$t3`.  Retail's `yoff` must therefore have had a LONGER live range —
  consistent with retail's y-chain tail sitting at slots 42/46 vs ours at 30/31.
* (b) the `gFontClut` VALUE `$a2` vs retail `$v0` (2 lines).  Our clut value is
  live 24 slots (load early, store late); retail's is live 2, so retail's value
  reuses the high pseudo's `$v0` and ours cannot.
* (c) the `li 9` setlen constant and `addiu ?,t8,5` `$v0` vs retail `$v1` (3 lines).

**46 still loses to the landed 20-diff lookalike and to W74's 44 body, so nothing
was landed.**  The trade is honest and worth recording: the new basin exchanges
the 4-line RMW2 class (a 5-wave structural wall) for the 9-line `$t3`/`$t4`
class (a fresh 2-qty serving-order tie).

## 4. FALSIFIED THIS BELT (all re-gated; do not retry)

* **tint carrier SPLIT into load + store statements** so its live range straddles
  the addPrim pair (the shape W72-A8's instrumented handout asked for, never
  probed in the 44 basin): load before `add` / before `pal` / before `prim`,
  store after `add` / after `tpage` / after `clut` / last, and both `tintv`
  declaration positions — **142 / 142 / 142 / 150 / 138 / 146 / 142**, macro
  form 86 @78.  A named tint carrier is a whole-body rotation here.
* `*font_tint_v`, `*(u_long *)font_tint_v`, `*(u_long *)&font_tint_v[0]`,
  `u_long font_tint_2[2]` deref/index: all exactly 44 — `MEM_IN_STRUCT_P` is NOT
  cleared by dereferencing a decayed array (expr.c:5531's ADDR_EXPR-of-aggregate
  arm).  **Only the non-array 8-byte scalar view clears it.**
* D4 basin statement orders: `pal`/`prim`+`bump` hoisted ahead of the y-chain
  (82 @78), `pal` first (78), `pal` before y (78), `prim`+`pal` first (130),
  `dv` after the alloc (124), the natural `code` position (122).  The pal load
  is emitted one slot AFTER the y-chain `subu` in every source order — source
  luid does not move that tie.
* single `"$5"` denials on `prim` (126), on `prim` after `bump` (77 @79), on
  `width` (125 @79); `"$2"`/`"$3"` on `pal` (78, inert); `"$5"` on `pal` placed
  after `add` (78, outside the range — 22B-1 confirmed).
* the `$t3`/`$t4` swap (residual (a)): a named `yoff` local is exactly neutral
  (48); `"$11"` clobbers on a `yoff` carrier 135/132/139 @83-85; `"$5","$11"` on
  the first pal launder 50, on the second 72, on both 72; `"$5","$12"` 52;
  `"$11"` on `prim` 114, on `width` 74; and from the I1 basin a THIRD launder
  with `"$11"`/`"$12"` on `height`/`width`/`dv` carriers at 4 sites each — 64 /
  72 / 99-104, none below the 46 control.  Not reached this belt.
* **def-use-guarded single-move statement climb from the G2 basin**
  (`A2_climb.py`, 141 valid orders gated): **every one is exactly 48**.  48 is a
  single-move positional optimum, exactly as 50, 48 and 22 were in the older
  basins — position stays a closed dial for this function in every basin tried.
* `code`+`clut` swept adjacent as a PAIR through the whole tail from the I1 basin
  (18 compound orders): 48 / 52 / 92 / 99 / 114 / 123-132; reversed pair last 48;
  splitting the len/code comma into two statements 132.  None beat 46.
* the y-tail-late family re-priced in the I1 basin (04Z): `y2`+`y3` moved TOGETHER
  to every legal slot (the single-move climb cannot reach a pair) 46 / 105 / 108 /
  115 / 139 / 141, whole y-chain late 137.  Retail's late `addiu v1,t8,5` /
  `subu t8,v1,t4` remain unreachable from source order.
* `gFontClut` as an unsized `u_short[]` asm-label view (the array form) 98 @84 —
  only the non-aggregate 8-byte view pays; `clut` moved to retail's late slot in
  both spellings 48.
* `"$2"`/`"$3"`/`"$2","$3"` clobbers on a `prim` carrier for residual (c): 52 at
  the tint site, 114 @84 at the clut site.

## 5. WHAT CHANGED IN THE PICTURE (for the receipts)

1. The queued TEXT_MOVES step is **statically refuted** — pre-flight tool banked.
2. The 5-wave "tint/RMW2 $v0-$v1 role swap → instrumented-cc1 trace" verdict is
   **retired**: it was an alias-dependence edge, curable from the declaration.
3. **Storage shape is not one axis but two**: `-G`-eligibility decides whether the
   address SPLITS (`mips_check_split`), and aggregate-ness decides
   `MEM_IN_STRUCT_P`, i.e. whether the load can CROSS an indirect store.  The
   W72/W74 array view bought only the first; the 8-byte scalar view buys both.
   Tree-wide: any near-miss whose oracle interleaves a global load into an
   indirect-store window is this class.
4. The 44 basin's "EVERY REGISTER MATCHES RETAIL" claim (W74-A8) is **narrower
   than stated** — it holds for the named locals, but the anonymous temps
   (`gFontClut`, RMW2's temp, the setlen constant) were still 9 lines wrong;
   the pre-flight multiset print is the honest census for that claim.

## 6. STATE AT CLOSE

* **No code landed.** The best new body (I1, 46 @82/82) is still worse on the
  gate than both the landed 20-diff lookalike and W74's 44 body, so the function
  body is left byte-identical to HEAD.  The ONLY edit to a tracked file is a
  **comment-only receipt block** appended to the existing `/* W.. */` chain above
  `FontUpsideDownBlit` in `recon/frontend/psx/psxfront.cpp` (ASCII-only,
  CRLF-preserved, byte-scanned: 1973/1973 CRLF, 0 NUL, 0 stray control bytes,
  non-ASCII count unchanged at 169).
* `tugate` re-run TWICE after that edit: **24/25 PASS, FontUpsideDownBlit 20** —
  identical to baseline, **zero PASS→FAIL**.  No other file in the tree was
  touched (several TUs carry a concurrent session's edits; none of them mine).
  No `git add`/`commit`/`stash`.
* Harness (all UNTRACKED, under `scratchpad/w75/`): `A2_probe.py` (snapshot
  install/gate/restore), `A2_r1..A2_r10.py` (the probe rounds), `A2_climb.py`
  (def-use-guarded order climb), `A2_sbs.py`, `A2_dump.py`/`A2_dump2.py` (RTL
  dumps copied to protected names), `A2_preflight.py` (the TEXT_MOVES legality
  test).  Protected dumps: `A2_k44_psxfront.i.{lreg,sched,greg,loop}`,
  `A2_k44.s`, `A2_D4_double_view_psxfront.i.lreg`, `A2_D4.s`, `A2_D1/D2_*`.
  Side-by-sides: `A2_sbs_{base,d4,e1,e3,fpal5,g2,i1}.txt`.
* No build.py rows were added (the pre-flight proves no TEXT_MOVES row is legal
  here).  `tools/build.py`'s uncommitted foreign edit was never touched.
* **NEXT** (named, in order): (1) close residual (a) — the `$t3`/`$t4` serving-
  order tie between `yoff` and the `0x00ffffff` P_TAG mask; the mask is anonymous
  so the dial is either a ref-step on `yoff` or a P_TAG RMW respelling that
  changes the mask's ref count; (2) residual (b) `gFontClut` — it is emitted as
  the one-insn small-data macro (`lhu $6,gFontClut`), so the same two-axis
  storage-shape question applies to it; (3) residual (c) the setlen constant.
  With (a)-(c) closed this basin is byte-exact: it already reproduces retail's
  frame, store order, link cluster and tint interleave.
