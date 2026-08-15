# W63-A1 RECEIPTS — belt: `recon/game/psx/hud.cpp`

Gate = `python tools/verify_asm.py recon/game/psx/hud.cpp <Mangled>` (sole authority);
whole-TU = `python tools/tugate.py recon/game/psx/hud.cpp`. Every number below was re-gated
by me, twice around every landing. Zero PASS→FAIL. `tu_order_audit.py` = 508 objects,
0 inversions at finish. Only `recon/game/psx/hud.cpp` was ever staged; no `-A`, no push,
no `tools/` edits, no memory-dir writes.

Probe driver `scratchpad/w63a1/probe.py` (byte mode, CRLF regime derived at probe time,
every replace asserts its match count, `finally:` restore). Variant files `v_*.py`
(~70 variants, zero corruption).

---

## 0. BOARD (all re-gated by me at HEAD `10e1a01b`)

| fn | board % | re-gated baseline | FINAL | Δ |
|---|---|---|---|---|
| **Hud_Draw321Num__Fiiiiii** | 98.06 | **2** | **PASS 111/111** | **SEALED (dual-lane)** |
| **Hud_BuildTach__Fi** | 89.19 | **40** | **20** (count EXACT 269/269) | **−20** |
| Hud_RenderHudView__Fv | 99.98 | 4 | 4 | mechanism CITED (§3), 22 falsifications |
| Hud_Init__Fv | 98.67 | 12 | 12 | not worked |
| Hud_RenderTacView__Fv | 92.52 | 13 | 13 | not worked (w62 angle stands) |
| Hud_BuildTimeSprites__FP4SPRTPcii | 95.23 | 21 | 21 | 9 new falsifications (§5) |
| Hud_BuildCdPlayer__Fii | 96.36 | 58 | 58 | hotspot map only (§6) |
| Hud_BuildMapMarkers__Fi | 89.98 | 81 | 81 | not worked |
| Hud_BuildNumbers__Fi | 93.52 | 208 | 208 | hotspot map only (§6) |
| Hud_BuildString__FPciiiib | 99.98 | **already PASS** | PASS | **board row stale for the 4th consecutive wave** |

TU board **53/62 → 54/62**. Belt diffs **439 → 417**.
Commits: `c5687f6d` (Draw321Num seal), `17f07fc0`, `ae40a423`, `ae2bc572` (Tach).

---

## 1. 🏆 SEAL — Hud_Draw321Num 2 → PASS, and the gcc law behind it

**NEW LAW: THE loop.c GIV-BENEFIT RAZOR (all cites `C:/Temp/gcc-2.8.1-src/extracted/loop.c`).**

The three-wave residual (the POSITION of `addu s4,a1,zero`, the `y` walker seed: ours before
the LICM-hoisted `&Hud_Character[num]` chain, retail after) was never a statement-position
question. `move_movables` inserts hoists immediately before `loop_start` (loop.c:1538), and
`strength_reduce` appends giv inits after them — so **retail's copy sits where a loop.c-GENERATED
giv init sits**, and the only way to put a register copy there is to make `by` a reduced giv.

Why the natural `by = y + i * 9;` refuses:

```
3877  if (! v->replaceable && ! bl->eliminable && REG_USERVAR_P (v->dest_reg))
        benefit -= copy_cost;          /* copy_cost = 4   (loop.c:316) */
3881  benefit -= add_cost * bl->biv_count;   /* add_cost = 4 (loop.c:310) */
3914  if (v->lifetime * threshold * benefit < insn_count) -> v->ignore = 1
```

`by` is a USER VARIABLE and is NON-REPLACEABLE (the w50 read-only fence after the loop keeps
it live past `loop_end`), so it pays `copy_cost`. `simplify_giv_expr` accumulates sub-giv
benefits (loop.c:5456) plus `rtx_cost (orig_x, SET)` (loop.c:5216), so the 2-op spelling
`y + i*9` totals **8** → `8 − 4 − 4 = 0` → `-dL` prints literally
`giv of insn 228 not worth while, 0 vs 25`. loop.c then reduces only the inner `i*9` giv
(base 0) and leaves `by = y_reload + giv` in the loop → 5 diffs @112 with a per-outer-iteration
`lw t0,76(sp)` ARG-HOME reload.

**Because `benefit == 0` makes the product 0, this razor is NOT a lifetime dial and NOT a ref
dial — the ONLY reachable input is the raw op count of the giv expression.** Any THREE-op
spelling of `9*i` reaches benefit ≥ 12, clears the razor, and loop.c reduces `by` itself:
`emit_iv_add_mult` puts `addu s4,a1,zero` in the preheader **after** the hoists (retail's exact
slot), the non-replaceable path emits `addu s5,s4,zero` at the outer-body head, and the biv bump
`addiu s4,s4,9` lands at the outer bottom. That is retail's whole shape, count unchanged.

**Landed:** `by = y + i * 5 + i * 4;` (5-pixel glyph row + 4-pixel gap of the 5×5 grid this
loop walks; the halo/sprite offsets +4/+1 are the same cell geometry).
**Equally PASSing (spelling is free, OP COUNT is the dial):** `y + i*4 + i*5`, `y + 4*i + 5*i`,
`(y + i*4) + (i*5)`, `y + i*3 + i*6`, `y + i*10 - i`, `y + i*9 + i - i`.

**Dual-lane seal:** gate `PASS (111 insns)` + `psyqproof` `111 words (-G8), REAL=0 RELOP=0`.

**FALSIFIED (all re-measured in this basin):**

| variant | gate |
|---|---|
| 2-op `y + i*9` / `9*i` / `i*9 + y` | 5 @112 |
| `y + i*8 + i` | 4 @111 |
| `y + i*9 + 1` (+ call arg `by + 3`) — the w62 shape | 4 @111 |
| `y + i*9 + 4` with the call arg `by` | 4 @111 |
| `y + (i*3)*3` | 5 @112 |
| `y + i + i*8`; `by = i*9; by = by + y;` | 51 @110 (giv replaced away) |
| `by = y; by = by + i*9;` (consec sets) | 5 @112 |
| **`y + i*9 + j*0` / `+ k*0`** — the w62 "outer additive term of ZERO" question | 5 @112: **fold eats them, the +0 door is CLOSED** |
| 2 / 3 read-only fence operands on `by`; fence moved before `Hud_BlackThinBox` | 5 / 27 / 5 @112 — **benefit==0 ⇒ no lifetime dial can help** |
| separate loop-2 counters `i2` (+`j2`/`k2`) to make loop 1's biv eliminable and dodge the `! bl->eliminable` guard | 26 / 27 / 53 — **that door is closed too** |

⚠️ **Honesty note for the orchestrator:** the mechanism is oracle-proven, but the *spelling*
(`i*5 + i*4` vs any of the six equivalents) is NOT oracle-evidenced — the oracle only proves the
giv was reduced. This is the methodology §3.14 "keep arithmetic un-simplified" family, not a
no-op scaffold: the expression is value-identical and every equivalent lands the same bytes.

---

## 2. 🏆 Hud_BuildTach 40 → 20, three independent landings

### 2a. 40 → 30 — THE 14D ALIAS-DEPENDENCE DIAL, first hud application
The eight `*(short *)(prim + 0xNN)` / `(prim2 + 0xNN)` vertex stores and the three `+2` tail
RMWs are **POLY_F3 MEMBERS** (`tag` 0 · `r0/g0/b0/code` 4 · `x0` 8 · `y0` 10 · `x1` 0xc ·
`y1` 0xe · `x2` 0x10 · `y2` 0x12). Spelling them as COMPONENT_REFs sets `MEM_IN_STRUCT_P`, so
`sched.c`'s `fixed_scalar_and_varying_struct_p` (sched.c:846-56) proves them INDEPENDENT of the
fixed frame slots `sin`/`cos`/`color` at 24/28/40(sp). The cast-int deref is a plain MEM and
CHAINS them — that chain is what pinned the two `fixedmult` arg-setup groups BELOW the vertex
stores and left `li a1,32` as reorg's delay-slot steal (blocks 8-13 of the w62 diff).
Zero insn change (269/269 throughout).
**SIDE EFFECT:** the w50-a1 statement-ORDER sensitivity of the `+2` tail is GONE — all six
orders (y0/y1/y2 × tp3 position) now measure identically. **The w50 order table is superseded;
it was an artifact of the aliasing chain, not a scheduling preference.**
Falsified here: tp9 x0/y0/x1/y1 as members (neutral 30) · `((POLY_F3*)tp9)->code = 3` (32) ·
the tp9 rgb word via `&->r0` (32) · `prim[7] &= 0xfd` as `->code` (neutral).

### 2b. 30 → 22 — statement ORDER of the tp9 vertex block (count EXACT)
Retail SLD 1418 emits the whole colour chain (`lw color; lui 0x4200; addu; or`) as ONE group
before any vertex store; with the colour store third, sched1 fills its load-delay slot with the
y1 `sh`. Moving the colour word to the head of the block is the whole edit.
Measured (code first unless noted, 269/269 unless marked):
`code,x0,rgb,y0,y1,x1` 30 (old) · **`code,rgb,x0,y0,y1,x1` 22 (kept)** · `rgb,code,…` 26 ·
`code,rgb,y0,x0,y1,x1` 28 · `code,rgb,x0,y1,y0,x1` 22 · `code,x0,y0,rgb,y1,x1` 32 ·
`rgb,x0,y0,y1,x1,code` 25 @268 · `code,rgb,x0,y0,x1,y1` **19 @268** ·
`code,rgb,x0,x1,y0,y1` and `code,rgb,x1,y1,x0,y0` 25 @268 — the three sub-19 forms are all
1 insn SHORT, so 22 @269 is the better (count-exact) basin per the standing rule.
🔴 **A void fence `("" : : "i"(0))` ANYWHERE inside this packet block is CATASTROPHIC**
(263-273 diffs at 259-266 insns) — it walls off the whole packet-store region. New boundary
row for the fence toolkit.

### 2c. 22 → 20 — read-only fence keeps `ts1` live past its last use (count EXACT)
Retail COPIES `ts1` into a fresh caller-saved reg before adding 2 (`addu v1,s1,zero`
@0x800d4220, then `addiu v1,v1,2` @0x800d4240); we mutated `ts1`'s own home in place
(`addiu s1,s1,2`). A zero-insn read-only fence extending `ts1` past the `+2` store denies the
addition `ts1`'s register, so it takes a fresh dest and the copy materializes.
Position ladder: **after the store 20** · before the `gSprt1[2]` link block 20 · **BEFORE the
store 22 (inert — the range must extend PAST the use)** · after `tp3 =` 24. Second operand
buys nothing (20). FALSIFIED: identity fence on ts1 (83 @270 — it adds def+use and costs an
insn) · an explicit `ts2 = ts1;` copy variable (22, cse propagates it away) · a block-local
`short t = ts1;` at the +2 site (22).

### Residual 20 — named angles
`clut = clut | (x + 0x1d)` 2 (retail computes `addiu v1,s7,29` at insn 89, *above* the
`player` branch; hoisting it to a source-level `xd` local measures 25 @270) · the `+2` tail
1436/1437/1438 cluster 5 (statement order now fully insensitive — 9 permutations all 20-22) ·
`Render_gPacketPtr = prim + 0x14` 1 · tp9 y1/x1 1 each.

---

## 3. Hud_RenderHudView 4 — the mechanism is now CITED, not guessed

`tools/diffsrc.py` pins all 4 to ONE statement, `hud.cpp:4700`
`*(u_int *)pal = *(u_int *)pal & 0xff000000 | (u_int)tagp & otmask;`:
ours `and v0,v0,t1 / or v1,v0,a0`, retail `and v1,v0,t1 / or v1,v1,a0` — retail gives the AND
a **fresh dest** (tied to the OR's dest); ours ties it to the AND's dying SOURCE.

**The gate is local-alloc's qty eligibility, `local-alloc.c`:**
```
470-477  if (REG_BASIC_BLOCK (i) >= 0 && REG_N_DEATHS (i) == 1 && ...) reg_qty[i] = -2;
         else reg_qty[i] = -1;
1866     if ((ureg >= FIRST_PSEUDO_REGISTER && reg_qty[ureg] < 0) ... ) return 0;   /* combine_regs */
```
i.e. `combine_regs` refuses to tie only when the SOURCE pseudo is **not local to its basic block
OR dies more than once**. Retail's loaded pal-word satisfies that; ours does not.
**NAMED ANGLE (unchanged, now exactly stated): make ONLY this site's pal-word pseudo fail
`REG_BASIC_BLOCK>=0 && REG_N_DEATHS==1` at ZERO instructions.** The sibling `if (HudTach)`
RMW 14 insns later is tied IN PLACE in retail too (`and v1,v1,t0` @311-315), so a
whole-region multi-block variable is the wrong instrument.

**FALSIFIED (22 variants, all 606/606 unless noted):** word-RMW spelling · named `pw` · named
`ph` (the high half) · identity fence on `pw` / on `ph` (5 @607 — the fence's own output is a
fresh once-dying pseudo, so the tie survives AND it costs a nop) · identity fence on the addr24
(53 @609) · OR operand swap (canonicalised) · bitfield `((Hud_PTag*)pal)->addr = (u_int)tagp`
(18 @608) · no-op re-mask of the loaded word · addr24-EARLY and addr24-LATE temps ·
named `tw` for the S1 tag read · read-only fence on `pal` (4) / on `tagp` (6) · void fence
between S1/S2 · `tagp` via an int temp · S2 through a `u_int *palw` local ·
`pw` shared with the sibling if-block (9 @607) · `pw` + a DEAD read-only fence on it inside the
if-block (6 @606 — it *does* globalize the pseudo but drags the sibling site with it) ·
**A2's foreign-operand fence** with operands `otmask` / `tagp` / `pal` (all 4, inert) and `j`
(66-72 — `j` is the outer callee-saved index, fencing it rotates the whole band).
⇒ the A2 live-length instrument does NOT reach this residual, and that is *predicted* by the
mechanism: the blocker is a qty-**eligibility** bit, not a priority razor.

---

## 4. Hud_BuildString — board row stale for the 4th wave
`99.98%` on the board; re-gated **PASS**. w60/w61/w62 each reported this. Please fix the row.

## 5. Hud_BuildTimeSprites 21 — 9 new falsifications, w62's parked 20@77 unchanged
Residual re-derived with diffsrc: (a) blocks 1-5 — retail defers the `y→$fp` and `sprt→$s3`
param copies to the LOOP PREHEADER (SLD 910), we emit them in the prologue (SLD 883);
(b) block 6 — retail keeps 77 in `$s7` and REMATERIALISES 83 in the `bne` delay slot
(`li v0,83`), we hoist both (77→`$fp`, 83→`$s7`) and pay a `nop`; (c) block 8 — `lw a3,84(sp)`
vs `addu a3,fp,zero`. w62's `sc` loop-body local fixes (b) but the SYM 8c block forbids it.
**A2's foreign-operand fence measured on 9 placements/operands: `y`/`sprt`/`x`/`str` in the
preheader (36/44/44/32 @79), `y`/`sprt` at the loop-body head (29/33 @78), `y` before the call
(34 @79), `y` before `langMin` (31 @80) — ALL NEGATIVE.** Consistent with §1's razor law and
with loop.c:697-702: the movable gate is `!REG_USERVAR_P && !REG_LOOP_TEST_P` (case 2) OR
`reg_in_basic_block_p` (case 3) — a *predicate*, not a priority, so no live-length dial reaches
it. The only known lever remains a REG_USERVAR_P constant, which the SYM forbids.

## 6. Not worked — hotspot maps banked for the next wave
- **Hud_BuildCdPlayer 58** — distributed, NOT the alias class. Top statements: `:3403`
  `w = HudPmx_gShapes[w].width + 1;` (5) · `:3431`/`:3446` the two `Hud_BuildString(...,0xbebe,0,false)`
  arg tails (3+2) · `:3349` the scroll guard (2) · `:3381` `while (1)` (2). ~14 more single-insn sites.
- **Hud_BuildNumbers 208** — count-exact, ~40 statements × 1-2 diffs each; a pure band rotation
  spread over the whole body (w41's find_reg cost-pass class). Needs allocsim/reqdelta, not spelling.
- **Hud_Init 12 / Hud_RenderTacView 13 / Hud_BuildMapMarkers 81** — w62's analyses stand
  unchanged; no new measurements this run.

## 7. TEXT_MOVES / flag / version specs for the orchestrator
**None.** Draw321Num's residual WOULD have been a clean one-line TEXT_MOVES
(move `addu $s4,$a1,$zero` after the `%hi/%lo` hoist group), but the source-level giv route
landed instead and is production-true (`psyqproof REAL=0`), so no shim is requested.
**HEADER-WISH: none.**

## 8. Catalog-row candidates (orchestrator harvest)
1. **THE loop.c GIV-BENEFIT RAZOR** — §1 above. Symptom: a walker/row-base whose SEED copy
   sits before the LICM hoists where retail has it after; `-dL` says
   `giv of insn N not worth while, 0 vs M`. Fix: raise the giv expression's RTL OP COUNT to ≥3
   (benefit ≥12 clears `copy_cost + add_cost`). Not reachable by fences, lifetimes, ref dials,
   `+0` terms, or biv-eliminability — benefit==0 zeroes the whole product.
2. **THE ALIAS-DEPENDENCE DIAL ON PACKET/PRIM STORES** — §2a. Any `*(short *)(prim + 0xNN)`
   cast-deref of a real POLY_*/SPRT field CHAINS against every addressed frame local and pins
   call-arg setup below the stores. COMPONENT_REF spelling is zero-insn and can dissolve a
   whole statement-order table (Tach's `+2` tail became order-insensitive). Tree-wide grep class:
   `\*\(u?_?short \*\)\((prim|p|sprt)`.
3. **VOID FENCE INSIDE A PACKET-STORE BLOCK IS CATASTROPHIC** (§2b) — new boundary row for the
   fence toolkit: −3 to −10 insns and 260+ diffs, it walls the whole region.
4. **READ-ONLY FENCE PAST THE LAST USE MINTS RETAIL'S REG-REG COPY** (§2c) — when retail
   `addu vN,sM,zero` then `addiu vN,vN,K` where we emit `addiu sM,sM,K`. The fence must sit
   AFTER the consuming statement (before it is inert); the identity fence is the WRONG device
   (+1 insn) and an explicit copy variable is cse-propagated away.
5. **combine_regs ELIGIBILITY vs PRIORITY** (§3) — a "retail gives the AND/OR a fresh dest"
   residual is `local-alloc.c:470-477` + `:1866`, i.e. a BIT (`REG_BASIC_BLOCK`/`REG_N_DEATHS`),
   not a razor; fences and every live/ref dial are predicted-inert there. Useful triage rule.

## 9. PROCESS / HAZARDS
- 🔴 **`apply.py`'s single `.applybak` goes STALE across a landing** — restoring it after a
  committed landing silently REVERTED that landing (caught by `git diff --stat`, recovered with
  `git checkout --`). Fixed by deleting the backup after every landing; the driver should stamp
  the backup per-variant-file.
- `hud.cpp` is uniformly CRLF; every probe derived the regime at probe time and asserted each
  replace's match count. Two anchor collisions were caught by the assert and skipped, not
  mis-edited.
- ⚠️ A receipt containing an inner `/* … */` inside a block comment closed the host comment
  (caught immediately); rewrote the gcc-line cites with `[...]` brackets.
- The auto-checkpoint hook repeatedly asked for a `memory/00_current_state.md` update.
  **Not done — the memory dir is read-only for agents.** Fourth consecutive wave reporting this.
