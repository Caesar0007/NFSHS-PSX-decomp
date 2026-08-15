# W64-A1 RECEIPTS — belt: `recon/game/psx/hud.cpp`

Gate = `python tools/verify_asm.py recon/game/psx/hud.cpp <Mangled>` (sole authority);
whole-TU = `python tools/tugate.py recon/game/psx/hud.cpp`. Every number below was re-gated
by me, twice around every landing. Zero PASS→FAIL. `tu_order_audit.py` = 508 objects,
0 inversions at finish. Only `recon/game/psx/hud.cpp` was ever staged (explicit path, never
`-A`); no `tools/` edits, no memory-dir writes, no stash/checkout outside my scope.

Probe driver `scratchpad/w64a1/probe.py` (byte mode, CRLF regime derived at probe time,
every replace asserts its match count, `finally:` restore). Variant files `v_*.py`
(~55 variants, zero corruption, zero anchor mis-hits — two anchor collisions were caught by
the count assert and skipped).

---

## 0. BOARD (all re-gated by me at HEAD `fbc974f7`)

| fn | brief | my re-gated baseline | FINAL | Δ |
|---|---|---|---|---|
| **Hud_RenderHudView__Fv** | 99.98 (4) | **4** | **PASS 606/606 — DUAL-LANE SEAL** | **SEALED** |
| **Hud_BuildMapMarkers__Fi** | 89.98 (81) | **81** @313 | **54** @310 | **−27, −3 insns** |
| **Hud_BuildNumbers__Fi** | 93.52 (208) | **208** | **200** (count exact 758/758) | **−8** |
| **Hud_Init__Fv** | 98.67 (12) | **12** | **8** (count exact 624/624) | **−4** |
| Hud_BuildTach__Fi | 95.17 (20) | 20 (exact 269/269) | 20 | 7 falsifications (§6) |
| Hud_BuildTimeSprites__FP4SPRTPcii | 95.23 (21) | 21 @78/77 | 21 | angle re-aimed (§7) |
| Hud_BuildCdPlayer__Fii | 96.36 (58) | 58 (exact 475/475) | 58 | 12 falsifications (§8) |
| Hud_RenderTacView__Fv | 92.52 (13) | 13 @72/71 | 13 | 13 falsifications (§9) |
| **Hud_Draw321Num__Fiiiiii** | verify PASS | **PASS 111/111** | PASS | held |
| Hud_BuildString__FPciiiib | — | **already PASS 215/215** | PASS | **row stale for the 5th wave** |

TU board **54/62 → 55/62**. Belt diffs **417 → 374** (−43) plus one seal.
Commits: `5529c501` (Init), `4d182596` (MapMarkers), `ec1931e1` (BuildNumbers),
`00f31c2f` (RenderHudView SEAL).

---

## 1. 🏆 SEAL — Hud_RenderHudView 4 → PASS 606/606, DUAL-LANE

The w63 receipt had already CITED the mechanism; this wave executed it.

Residual (all 4 diffs, one statement, `hud.cpp` `*(u_int *)pal = *(u_int *)pal & 0xff000000
| (u_int)tagp & otmask;`): ours `and v0,v0,t1 / or v1,v0,a0`, retail `and v1,v0,t1 /
or v1,v1,a0` — retail gives the AND a **fresh dest** (tied to the OR's dest), ours ties it to
the AND's **dying source**.

**The gate is a BIT, not a razor** — `local-alloc.c`:
```
470-477  reg_qty[i] = -2  iff  REG_BASIC_BLOCK (i) >= 0 && REG_N_DEATHS (i) == 1
1866     combine_regs refuses the tie for anything else
```
So no live-length / ref-step / priority dial can reach it — which is exactly why the w63
sweep of 22 variants (word-RMW spellings, named `pw`, named `ph`, identity fences on
`pw`/`ph`/addr24, OR-operand swap, bitfield `Hud_PTag` view, no-op re-mask, addr24-EARLY/LATE,
`tw`, read-only fences on `pal`/`tagp`, void fence between the two stores, A2's
foreign-operand fence) came back inert or worse.

**THE DEVICE (zero instructions, 606/606 both sides):** name the loaded pal word and keep it
live **PAST** the consuming store with a **TWO-OPERAND read-only fence** —

```c
pw = *(u_int *)pal;
*(u_int *)pal = pw & 0xff000000 | (u_int)tagp & otmask;
__asm__("" : : "r"(pw), "r"(pw));
```

`pw` no longer dies at the AND ⇒ `REG_N_DEATHS`/liveness fails combine_regs' eligibility ⇒ the
AND takes a fresh dest = retail. Both dials are load-bearing and were measured:

| variant | gate |
|---|---|
| `pw` + **2-operand** read-only fence AFTER the store | **PASS 606** |
| `pw` + **1-operand** read-only fence after the store | 10 @606 |
| `pw` + read-only fence BEFORE the store | 5 @607 (+1 insn) |
| read-only fence on a re-loaded `*(u_int *)pal` (no named local) | 4 @606 (inert) |
| named `pw` alone (w63) | 4 (inert) |

**Dual-lane:** gate `PASS (606 insns)` + `psyqproof` `606 words (-G8), REAL=0 RELOP=0`.

⚠️ The three sibling `*(u_int *)pal = *(u_int *)pal & 0xff000000 | … & otmask;` sites in the
same function already match — do NOT propagate the device to them.

---

## 2. 🏆 Hud_BuildMapMarkers 81 → 54 (313 → 310 insns), two landings

### 2a. 81 → 63 — THE w45/w46 NAMED ANGLE EXECUTED: attack the CSE, not the `$fp` occupant
The four-wave `$fp` item: ours parks the cross-loop-CSE'd literal `0x1F800004` in `$fp`
(prologue `lui $fp,0x1f80; ori $fp,$fp,4`, +2 insns) and const-propagates `mapy` to a
`li $t0,24` at each of the four `mapy - z` call-arg sites (+4); retail parks **`mapy`** in
`$fp` (`li $fp,24`, SYM `REG $0x1e`) and rematerialises the cursor address **per loop**.
w45/w46 measured ALL FIVE ways of giving `mapy` an allocno negative (distinct address rtx,
plain use fence, 1/2/3/4 identity fences, per-loop storage split) and then named the right
target: *"attack the CSE from the STORAGE-SHAPE menu instead of from mapy"*.

The storage-shape route is structurally unavailable here (an `asm`-label extern would emit
`%hi/%lo` where verify_asm resolves the true 16-bit halves for the `0x1F80xxxx` range — the
w9-a10 normalizer fix — so a symbol view can never match). **The reachable device is the
identity launder on the per-loop `pktcell` pointer**, zero instructions:

```c
pktcell = (u_char **)0x1F800004;
__asm__("" : "=r"(pktcell) : "0"(pktcell));   /* cop loop: BEFORE the sprt read   */
...                                            /* race loop: AFTER the sprt read   */
```
cse can no longer prove the two loops' address pseudos equal, the fused value stops living
across the whole function, `$fp` is freed and `li $fp,24` + `subu $a3,$fp,$s0` return.

**Position is its own dial** (measured, all at 313 insns):
cop=Before/race=Before 65 · **cop=B/race=After 63 (kept)** · cop=A/race=B 101 · cop=A/race=A 65.
Post-landing re-sweep (04Z): cop=End/race=A 54 · cop=B/race=End 54 · cop=E/race=E 54 —
flat, current form kept.
FALSIFIED: fence in ONE loop only (82 @314, +1 insn — the launder must break BOTH ends of the
cse pair) · a plain read-only fence on `pktcell` in both loops (91) · the race loop through
`&Render_gPacketPtr` (81, inert — gcc folds the macro to the same tree).

### 2b. 63 → 54 (−3 insns) — `x + mapx` OPERAND ORDER at the three RACE-loop sites
Retail: `addiu $a2,$s3,0x16` then `addiu $a2,$a2,-0x3` (@0x800D5F20/24) — two un-folded
addiu's. Ours: `li $t0,22; addu $a2,$t0,$s3` — the const-propagated `mapx` materialised into a
register first (+1 insn per site). Writing the variable **second** (`x + mapx + -3`) lets the
const-propagated `mapx` land in the addiu immediate.
🔴 **SITE-SELECTIVE**: the COP-loop site must KEEP `mapx + x` — retail is li+addu THERE
(`addiu $t0,$zero,0x16; addu $a2,$t0,$s3` @0x800D5D04). Swapping all four = 57 @309 (−3 worse).
FALSIFIED: `mapx + (x + K)` 70 @312 · literal `0x16` at the 3 race sites 109 @307 · literal at
all 4 sites 113 @305 (the tree folds `0x16 + x - 3` into one immediate = 2 insns SHORT).

### Residual 54 (+2 insns) — named angles
(a) COP loop: the cursor-bump store `*pktcell = sprt + 0x14` must sink into the AIFlags
`beqz`'s delay slot (retail `lw v1,1392(v0); addiu v0,a2,20; andi; beqz; [ds] sw v0,0(a1)`);
ours emits the bump first. The launder's barrier property is the prime suspect — a
non-barrier cse-breaker would test it. (b) RACE loop: `a1`↔`a2` role swap on
{pktcell, 0xff000000 mask} plus their emission order (`lui a2/ori a2/lui a1/lw a3` vs ours
`lui a1/ori a1/lw a3/lui a2`). (c) the tail `jal`/`nop` pair.

---

## 3. 🏆 Hud_BuildNumbers 208 → 200 — the fold-association law, first hud application

`pSprt[37].x0 = (A + B + HudPmx_gShapes[0x2c].width + -2) - HudPmx_gShapes[pos + 0x2c].width;`
gcc's fold reassociates `(X + -2) - P` into `X - (P + 2)` — ours emits `addiu v0,v0,2` on the
SUBTRAHEND; retail keeps the `-2` on the width (`lhu a1,896(a2); addiu a1,a1,-2` at oracle
277/279, i.e. computed EARLY) and then `addu a0,a0,a1; subu a0,a0,v0`.
Parentheses do nothing (fold is statement-granular) — **the dial is which term LEADS**:

| spelling | gate |
|---|---|
| `(A + B + W + -2) - P` (control) | 208 |
| `(W + A + B + -2) - P` **(kept)** | **200** |
| `(W - 2 + A + B) - P` | 200 |
| `W - 2 + A + B - P` (no outer paren) | 200 |
| `(A + B + (W - 2)) - P` | 208 (paren is a no-op, as the law says) |
| `(A + B) + (W + -2) - P` | 208 |

Same lever measured NEGATIVE on the sibling statements (basin receipt): `w1 * 2` leading in
`x = (g1x + g1cx + 4) + w1*2` 228 · flat `+4` last 202 · `hun * -10` leading 200 (inert) ·
`speed/10 - hun*10` 200 · `x - width - 1` 200 · `(x-1) - width` 200 · `splitY` leading 200.

### Residual 200 — the class is unchanged and quantified
`posdiff` first-use order shows a **saved-register 4-cycle** — ours→retail
`w1: s6→s3`, `w2: s0→s4`, `ten: s4→s6`, `hun: s3→s0` — the exact cycle w46-a5's reqdelta
proved has **no 1- or 2-dial solution**; plus a caller-saved `a1/a2 ↔ a2/t2` band shift and a
big LCS-misaligned `hun != 0` arm (block ORDER, not content). Route: `dialsearch.py`/
`multidial.py` for a ≥3-dial set, not spelling.

---

## 4. Hud_Init 12 → 8 — the SLD statement order (05A)

`diffsrc` pinned all 12 to four one-instruction moves. The SLD grouping decoded retail's
source order in the replay-sprite preamble:
oracle 546 `ori v0,32896` [SLD 1121] · 547 `li a1,111` [1123] · 548 `lw s1,0(gp)` [1115] ·
549 `addu fp,zero,zero` [**1145**] · 553 `lw v0,0(gp)` [1116]
⇒ retail's statements are `spriteReplay`(1115), `baseX`(1116), `baseY`, … `colour`(1121),
`transparent`(1122), the call(1123) — and **`i = 0` is at line 1145**, i.e. immediately before
the `PerpOverlayOn[]` loop (whose preheader address pair is also tagged 1145), not up with the
sprite setup. Landing both halves: **12 → 8**, count exact 624/624.
(The colour/transparent-first order was a w61-a1 landing worth −2; the SLD says the opposite
order plus the `i = 0` relocation, and that is worth −4.)

### Residual 8 — three one-instruction sched positions, two of them CLOSED
- **`li s3,60` (`w2 = 0x3c`)**: retail emits it right after the previous `jal`'s delay slot,
  before the next call's `a0/a1`; ours two slots later. 🔴 **PROVEN EITHER/OR**: hoisting
  `w2 = 0x3c` above its sprite call gives 58 (+50) *while `w2 = 0x1d` is hoisted*, and the
  mirror image (un-hoist `0x1d`, hoist `0x3c`) also gives 8 — the PAIR rotates `w2`'s allocno
  band, exactly one may be hoisted. Un-hoisting `0x1d` alone = 10. Fusing `w2 = 0x3c` onto the
  `x = x + w1` source line (line-note only) = 8 (inert, as the line-note theory predicts).
  ⇒ the open side is `w2`'s band, not the statement position.
- **`addu s0,s0,s4` / `li a1,1`** (the `HudG4+2` / `HudF4+3` call sites): retail emits the
  `x += w1` / `x += w2` update BETWEEN the call's `a1` and `a2` loads (SLD says both are on the
  CALL's source line, 1043/1045, while the four sibling sites have them on their own lines).
  FALSIFIED: `x = x + w1` inline as the 3rd argument (8, byte-identical) · `x += w1` inline (8)
  · operand swap `w1 + x` (8) · a void fence between the update and the call (58) · a read-only
  fence on `x` after the call (58). Arg0-in-a-local needs a new local (compile error without a
  decl; not pursued — the SYM 8c list is the budget).

---

## 5. Hud_Draw321Num / Hud_BuildString — held / stale
`Hud_Draw321Num` re-gated **PASS 111/111** (the w63 giv-benefit-razor seal holds).
`Hud_BuildString` re-gated **PASS 215/215** — the board row has been stale for FIVE waves now
(w60/w61/w62/w63/w64 all reported it). Please fix the row.

## 6. Hud_BuildTach 20 — 7 new falsifications, count still exact 269/269
Residual, `diffsrc`-pinned: (a) `clut = clut | (x + 0x1d)` — retail computes `addiu v1,s7,29`
at insn 89, *above* the `player` branch (a speculative hoist), ours at 96 · (b) the
`y0/y1/y2 + 2` tail (SLD 1436/1437/1438) — retail's emission is y0-store, y1-load, y2-store,
y1-add · (c) `Render_gPacketPtr = prim + 0x14` one slot · (d) tp9 `y1`/`x1` one each.
MEASURED THIS WAVE (all 20 @269 unless noted): source order `y0` before `y1` (20) · the w63
`ts1` read-only fence at 2 operands (20) and 3 operands (20) · y-swap + 2-operand fence (20) ·
`xd = x + 0x1d` hoisted with the then-arm rewritten `xd + 0x58` so the value has two uses
(**23 @270**) · `xd` used only in the else-arm (23 @270).
⇒ the (a) hoist is confirmed to cost an instruction in every naming form tried (w63's `xd`
25 @270, this wave's two-use form 23 @270); the y-order sensitivity really is gone (w63's
alias-dependence landing superseded the w50 order table, re-confirmed here).

## 7. Hud_BuildTimeSprites 21 — the angle re-aimed (no new grind)
The brief's "the fence does not apply, find another route" is right and the route is now
named. w46-a4's reqdelta certificate says the 0x53 pseudo needs `live 40 → ≥67`, i.e. it must
be BORN BEFORE the two `char sep[6]` rodata→stack aggregate copies; w50-a1's count-exact
basin says the residual is a 2-register swap between `y`, the 0x4D constant and the 0x53
constant. **The un-attacked input is the PARM-COPY POSITION**: retail's `addu fp,a3,zero`
(`y`) and `addu s3,a0,zero` (`sprt`) sit at oracle insns 41/43 tagged **SLD:910** — the LOOP
PREHEADER — not in the prologue (SLD:883) where assign_parms puts ours. That single fact is
what makes retail's `y` live-length ~26 instead of our 66 and therefore beat the 0x53
constant; every ref/live dial measured so far was computed on the prologue-copy basin.
w47-a1 proved a fence can PIN the parm copy at the prologue (`FILE_callbackop`); the wanted
device is the OPPOSITE (sink it), which w46-a7 parked as "only sched dependence-chain depth
reaches assign_parms". ⇒ **NAMED ANGLE for the orchestrator: a parm-copy SINK — either a
source shape that gives the first basic block a dependence chain deep enough for sched1 to
sink the two parm copies to the loop preheader, or a `PER_FN_PROLOGUE_UNSINK`-family
mechanism run in the opposite direction.** Everything downstream is already quantified.

## 8. Hud_BuildCdPlayer 58 — 12 falsifications, count exact 475/475
`diffsrc` splits the 58 across 21 blocks; the two structured classes I attacked:
- **the two `Hud_BuildString(strscrolltitle,(x + dx + K) - (Hud_gCdScrollTitle - 0x4c), …)`
  offsets** (K = 10 and 0x16): retail emits `addiu v0,s3,K` · `addu v0,s7,v0` · `addiu
  a1,a1,-0x4c`; ours folds K into the subtrahend constant (`addiu a1,a1,-86` / `-98`). The
  fold-association lever that paid on BuildNumbers does NOT pay here — site 1 with
  `x + (dx + 10)` costs an instruction (103 @476), site 2 is count-neutral but worse (64),
  both together 109 @476, `dx + K + x` identical, `0x4c - scroll + (x+dx+K)` 68,
  `(x+dx+K) + (0x4c-scroll)` 58 (inert), `x + (dx+K) - scroll + 0x4c` 110 @477.
- **the compare `Hud_gCdScrollTitle < Hud_BuildString(...) + 0x4c`** (retail gives the `slt`
  a fresh dest `slt v1,v1,v0`, ours `slt v0,v1,v0`): the §1 device does NOT transfer —
  a named `tw` for the call result 58 (inert), + a 1- or 2-operand read-only fence inside the
  guarded block 80.
- **`artist = (char *)0x0` in the three `index` arms**: retail merges all three into one
  delay-slot `addu s0,zero,zero` at oracle 208; hoisting it above the if-chain 60 @473
  (−2 insns), hoisting it with the `sprintf` 83 @464 (−11 insns) — both go count-SHORT, so
  the arms' duplication is load-bearing (cross-jump merges them in retail).
⇒ the residual is distributed micro-placement, not one class; next instrument is
`chunkdiff.py` + `allocsim` rather than more spellings.

## 9. Hud_RenderTacView 13 — the symbol-node matrix CLOSED, angle sharpened
The w62/w63 mechanism (retail shares the `(high DashHUD_gInfo)` pseudo between the entry/exit
test loads and the body's `lo_sum`, re-defining it at the LOOP TAIL so it never lives across
the four jals; ours either merges the whole value into a callee-saved reg or shares nothing
and pays one extra `lui`) is now bounded by a complete 2×2×2 measurement over the three
sites' symbol spelling (`&DashHUD_gInfo` vs the `DashHUD_view` asm-label alias):

| entry / body / tail | gate |
|---|---|
| v/g/v (control), g/g/v, v/v/g, g/v/g | **13 @72** (body and tail on DIFFERENT nodes) |
| v/v/v, g/g/g | 14 @73 (same node ⇒ cse merges ⇒ 7th callee-saved reg) |
| g/v/v, v/g/g | 18 @73 |

⇒ the entry spelling is codegen-invisible; the body/tail node identity is the only axis and it
is a strict either/or. ALSO FALSIFIED this wave: nested-`if` instead of the `&&` comma (13,
byte-identical, both node settings) · an identity launder on the body's `dh` (13 / 18) ·
**a `goto` back-edge loop (75 @72 — kills loop.c wholesale, both node settings)**.
**SHARPENED ANGLE:** in the same-node (14) basin the tail's lone `lui` movable IS hoisted;
retail's is not. That is loop.c's `savings == 1` budget razor (`threshold*savings*lifetime >=
insn_count`, w40's STATEFUL-budget row), and the reachable input is the movable's LIFE — read
it off `-dL` (`Insn N: regno R (life L), savings 1`) and shorten it. No spelling axis remains.

---

## 10. Catalog-row candidates (orchestrator harvest)
1. **combine_regs ELIGIBILITY IS REACHABLE — the fresh-dest device** (§1). Symptom: retail
   gives an AND/OR/slt a FRESH dest while ours ties it to the operation's dying source; every
   priority dial is inert (correctly — `local-alloc.c:470-477` + `:1866` is a BIT). Fix: name
   the dying value and keep it live PAST the consuming statement with a **read-only fence,
   operand count ≥ 2, placed AFTER the consumer**. Zero instructions. This upgrades w63's
   catalog row #5 from a triage rule ("predicted-inert") to a LANDED lever, and it is the
   first device that flips the eligibility bit rather than trying to out-rank it.
   ⚠️ 1 operand is NOT enough (10 vs PASS) and BEFORE the consumer costs an insn.
2. **IDENTITY LAUNDER AS A CROSS-LOOP CSE BREAKER for a scratchpad literal** (§2a). Symptom:
   two sibling loops reach the same fixed scratchpad address; cse fuses the address pseudos
   into one value live across the whole function, which parks it in a callee-saved reg and
   evicts a real variable. Fix: `__asm__("" : "=r"(p) : "0"(p))` on the per-loop pointer in
   BOTH loops (one loop alone costs +1 insn), position dialled per loop. Zero instructions.
   Note the storage-shape menu is UNAVAILABLE for `0x1F80xxxx` (verify_asm resolves the true
   16-bit halves there, so an asm-label symbol view can never match) — this is the substitute.
3. **FOLD-ASSOCIATION: THE LEADING TERM IS THE DIAL** (§3). `(A + B + W + -2) - P` folds the
   `-2` onto the subtrahend; putting `W` FIRST keeps retail's `addiu W,-2`. Parentheses and
   sub-grouping are no-ops (statement-granular fold) — only the ORDER of the addends moves it.
   Tree-wide grep class: any `(… + X + <negative literal>) - Y` where the oracle shows the
   literal on the minuend side.
4. **SLD DECODES A STATEMENT'S TRUE HOME, NOT JUST ITS ORDER** (§4). `i = 0` emitted 100+
   insns before its loop still carries the loop's SLD line — read the SLD line of every
   constant-init insn before assuming its source position; relocating one statement to its
   SLD-implied home was worth −4 with zero other changes.
5. **`x + mapx` vs `mapx + x` decides addiu-vs-li+addu for a const-propagated variable**
   (§2b) — and it is SITE-SELECTIVE within one function (retail itself uses both forms).

## 11. Orchestrator actions requested
- **MATCH_PROGRESS**: `Hud_BuildString__FPciiiib` is PASS and has been for five waves.
- **No TEXT_MOVES / flag / version specs** from this belt — every landing is source-level and
  production-true (`Hud_RenderHudView` psyqproof `REAL=0 RELOP=0`).
- **HEADER-WISH: none.**
- **Next-wave routing**: BuildTimeSprites → the parm-copy SINK mechanism (§7); BuildNumbers →
  `multidial`/`dialsearch` on the 4-cycle (§3); RenderTacView → `-dL` movable-life on the
  same-node basin (§9); MapMarkers → a NON-BARRIER cse breaker for the cop loop (§2 residual).

## 12. PROCESS / HAZARDS
- `hud.cpp` is uniformly CRLF; the probe driver derives the regime at probe time and asserts
  every replace's match count. Two anchor collisions (a 3-way-duplicated
  `w1 = HudPmx_gShapes[0x6b].width;` line) were caught by the assert and skipped, not
  mis-edited — the count assert is doing real work.
- Concurrent-belt reality check: the working tree grew from 7 to ~55 dirty files during my
  run (peers). Every commit staged `recon/game/psx/hud.cpp` by explicit path only.
- `verify_asm`'s diff print is capped; `VA_MAX=<n>` uncaps it. `tools/diffsrc.py` +
  `tools/posdiff.py` were the two decisive instruments on this belt — diffsrc's
  SOURCE-STATEMENT HOTSPOTS table turned three of the four landings into one-line edits.
- The auto-checkpoint hook again asked for a `memory/00_current_state.md` update.
  **Not done — the memory dir is read-only for agents.** Fifth consecutive wave reporting this.
