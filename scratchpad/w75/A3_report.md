# W75-A3 REPORT — hud-numbers belt (unit `game/psx/hud`, `recon/game/psx/hud.cpp`)

## HEADLINE

| fn | baseline | final | state |
|---|---|---|---|
| `Hud_BuildTach__Fi` | FAIL 17 diffs, ours 268 / oracle 269 | **PASS 269/269** | 🏆 **SEALED** (gated twice; TU gated twice) |
| `Hud_BuildNumbers__Fi` | FAIL 188, count-exact 758/758, posmis 147 | FAIL 188 (unchanged) | **4-cycle SOLVED on the allocation side**; new named angle + two new certificates |

TU: `recon/game/psx/hud.cpp` **57/62 → 59/62 PASS**, **zero PASS→FAIL**.
(The BuildTach seal is mine; `Hud_BuildMapMarkers` PASS and `Hud_BuildCdPlayer` 54→15 came
from the concurrent w75-a4 session working in the same clone — see PROCESS below.)

---

## 1. `Hud_BuildTach__Fi` — SEALED (17 → PASS)

Four source levers, no permuter, no new device class. **Every one of them re-priced a
"measured / falsified" line in the w49/w63/w72/w74 receipts** — catalog 04Z / 21E-1
(a falsification is basin-relative). Full detail is in the in-source receipt block.

### Lever 1 — CLUT-x HOIST **+ PIN** (17 → 13)
Retires the w49 verdict *"the 0x1d/0x75 ordering is NOT an arm-order question — it is
downstream of the 4-way rotation"*.

Retail computes the else-arm value `x + 0x1d` **before** the branch (`addiu v1,s7,29`, one
slot ahead of the y-term `addiu v0,s4,157`) and fills the `beqz` delay slot with the y-term
`or`. The w49 "hoisted-local" spelling **alone does not do it** (measured here: 20 @269) —
sched1 gives the hoisted `addiu` the shorter chain, sinks it to the bottom of the block, and
reorg's backward scan then steals **it** into the delay slot instead of the `or`.

**A zero-insn read-only fence immediately after the assignment is the w45 sched-issue-position
FIXPOINT**: the addiu can no longer sink past it, so it issues at the block head, `or` becomes
the last pre-branch insn (= reorg's steal), and the addiu lands in `$v1` exactly like retail
(`$v0` is still busy with the y-term). Cluster becomes **byte-exact**.

```c
u_long clutx;
clutx = x + 0x1d;
__asm__ ("" : : "r"(clutx));       /* the PIN — without it the hoist is worse than nothing */
clut = clut | (y + 0x9d) << 8;
if (player != 0) clut = clut | (x + 0x75);
else             clut = clut | clutx;
```
Measured: fence-after-assignment 13 · void fence there 13 · opacity fence 15 · fence after
the y-term 20 @269 · assignment moved up after `x = fixedmult(...)` 33 · both arms hoisted 18 ·
`int` instead of `u_long` 20 · `clutx ^ 0` 20 · **no fence at all 20 @269**.

### Lever 2 — CURSOR STORE **below** the palette store (13 → 11)
`Render_gPacketPtr = (u_char *)prim + 0x14;` moved under
`((Hud_PTag *)pal)->addr = (u_int)prim;`. Retail issues `sw t0,0(t3)` *inside* that store's
RMW group; written first, sched1 sinks it a whole group too far. Every fence spelling at that
site is catastrophic (63–117) — it is a statement-ORDER item, not a barrier item.

### Lever 3 — the `+2` tail as THREE re-read RMWs, source order **y0, y1, y2** (→ PASS)
🔑 **This is what mints retail's `addu v1,s1,zero` copy — the +1 insn the w72/w74 receipts
hunted for two waves.** The w72/w74 combine certificate is *correct about combine* but was
asking the wrong question:

* a **source-level** copy can never survive: `cse.c canon_reg:2577` rewrites every use to
  `qty_first_reg`, so `ts2 = ts1;` is always propagated out (the w63 "cse propagates it away"
  observation, now with the citation);
* retail's copy is **cse's STORE-FORWARD** of the just-stored `prim2->y2 = ts1;` into the
  re-read. It survives combine because the forwarded value is **HImode** (the `y2` slot is a
  `short` member), so the forward emits a copy feeding a widening add rather than the plain
  SImode `(plus ts1 2)` that `can_combine_p:917-931` folds;
* our spelling `prim2->y2 = ts1 + 2;` is an SImode add on the promoted local and **can never
  produce it** — that was the real blocker, not the combine guard.

⚠️ **ORDER IS THE WHOLE DIAL, and it is NOT retail's store order**: retail *stores* y0, y2, y1,
but the SOURCE order that reproduces it is **y0, y1, y2** (sched1 does the interleave).
Measured with levers 1/2/4 in place: `y0,y1,y2` **PASS** · `y0,y2,y1` posmis 7 · `y1,y0,y2`
posmis 4 · `y1,y2,y0` posmis 8 · `y2,…` 268 (the store-forward is lost when y2 leads).
The old `ts1` read-only fence must be **removed** (12 @269 with it).

### Lever 4 — void fence after `prim2->y2 = ts1;` (12 → 10, posmis 10 → 7)
Pins that store adjacent to its `prim` twin (retail `sh s1,18(s2); sh s1,18(s0)`); without it
sched1 sinks it 4 slots into the RMW group. Any fence *between* the RMW statements costs a
real insn (270) — measured for `"r"(ts1)`/`"r"(prim2)`/`"r"(tp3)`/void at five positions.

**Negative kept on record:** splitting the y2 RMW into `{int t2 = prim2->y2; prim2->y2 = t2+2;}`
breaks the store-forward outright (a real `lh v0,18(s0)` appears) — 8 diffs @269, posmis 5.

---

## 2. `Hud_BuildNumbers__Fi` — 188 stays, but the 4-cycle is SOLVED

### 2a. NEW CERTIFICATE — the dial search extended to NEGATIVE deltas
The w74 grids searched **positive** deltas only (`refs +1..+3`, `live +2..+40`).
Re-run against a protected dump (`scratchpad/w75/A3_base.{greg,lreg}`, signature verified
identical to `W74_A2_base`) over `{620 hun, 621 ten, 624 w1, 625 w2, 82 pSprt, 643 speed,
627 w7, 619 speed'}` with **refs −2..+3 and live −40..+40** (`scratchpad/w75/A3_search.py`):

* 1-dial: 360 combos, **0 hits**
* 2-dial: 56 700 combos, **0 hits**

⇒ in the base basin there is no one- or two-dial solution **in either direction**.

### 2b. 🏆 THE FULL RETAIL s-BAND HANDOUT IS NOW REPRODUCIBLE AT ZERO INSN COST
Variant `K_4x2` / `L5` (`scratchpad/w75/A3_num8.json`, `A3_num9.json`) lands
**hun=$s0 w1=$s3 w2=$s4 pSprt=$s5 ten=$s6 w7=$s7 — oracle-exact, count 758/758**:

1. move the `w2/w7/w3` group **and** the `x` block below `ten = ...`
   → w1 live 60→39, w2 live 16→10, ten live 51→56 (exactly the three live values the
   w72/w74 receipts named as required, reached by pure statement position — this is the
   brief's LIVE-EXTENDER/def-position lead, confirmed: `M1` (w-group above `speed`) moves
   w2 16→79 and `M2` (`speed` moved down) 16→46, so def position **is** a live dial);
2. drop the `do{}while(0)` on `x = x - w2` → w2 refs 4→3;
3. one `do{}while(0)` round the `x = x-1-width` + `Hud_BuildGT4` pair → hun refs 8→11;
4. **four hun-ONLY zero-insn use fences**, each in its own `do{}while(0)`:
   `do { __asm__("" : : "r"(hun)); } while (0);` ×4 → hun refs 11→23.

### 2c. 🔑 THE MECHANISM THAT WAS MISSING — **the ref-step dial is COUPLED at a shared site**
This is why six waves of ref dials never moved `hun`. Every wrapper big enough to lift hun
also encloses statements referencing `x` (p622) and `prim` (p629) — the two allocnos directly
**above** hun in the order — so their refs rise by the same loop-depth weight and hun never
overtakes them. Measured: a depth-4 wrapper gives hun refs 20 (pri .8696) but simultaneously
x 19→28 (.9333) and prim 25→28 (.8960), so hun still lands `$s2` **and it costs +8 insns**.

**Cure: use a reference site that mentions ONLY the target.** A `"r"(hun)` use fence is such
a site, it is zero-insn where the value is already register-resident, and wrapping each fence
in its own depth-2 phony loop makes it worth +2 refs. Ladder (fences × depth):
`1x2`→refs 14 · `2x2`→17 · `3x2`→20 · **`4x2`→23 (hun `$s0`)** · `5x2`→26 (also `$s0`) ·
`2x3`→19 (still `$s1`). `reqdelta` on the (1)–(3) basin had predicted exactly this
(`p620 refs 11 → 19`, the sole single-dial solution, REF-STEP floor_log2 3→4).

**Generalization (new catalog row candidate):** when a ref-step dial refuses to move a pseudo
past its neighbours, check whether the inflator's SITE also references them, and switch to a
**target-only site (a use fence)** rather than a bigger wrapper.

### 2d. Why it is NOT landed — and the next attack
The enabling moves relocate ~10 statements and the emission-order change costs more than the
registers gain. All count-exact 758/758; **posmis** (the honest metric here):

| variant | handout | posmis |
|---|---|---|
| base (landed) | 3 registers wrong | **147** |
| `K_4x2` / `L5` | **perfect** | 155 |
| `L4` (moves anchored at `hun`) | 4 of 6 right | 160 |
| `L3` (fences only, no moves) | hun+w7 right | 165 |
| `L2` (x block only) | hun+w1+w7 right | 180 |

⇒ the function is now a **pure scheduling problem in a basin whose allocation is already
oracle-exact** — a far better attack surface than the allocno cycle. Named next steps:
(i) reach w1 live 39 / w2 live 10 / ten live 56 **without moving the statements** (a
birth/last-use relocation device rather than a statement move); (ii) grind the `K_4x2`
schedule with the w45 fence-position sweep; (iii) the A20 `[reload_pick]` trace for any
residual uniform ±1 scratch rotation once the schedule is close.

### 2e. Falsified this belt (BuildNumbers, all count-exact 758/758 unless noted)
`w2` read-only fence at 8 statement positions (w2 live 16→17/58/63/70/79, never 29/30; the
fence lifts 4+ allocnos at once — it is not a single-pseudo dial) · `speed` moved down to
`hun` (484) · `SpeedColor/color2` moved to the call (200) · `hun/ten` moved above the packet
block / above the x block / below the call (188, INERT on the allocno table) · packet block
moved below `ten` (188, inert) · `w3` moved below `ten` (188, inert) · `y` moved below `ten`
(300) · x block ↔ y swap (188, inert) · x block moved after the packet block or after `hun`
(366; w1 live 37 — same as after `ten`).

---

## 3. TOOLS / PROCESS

New, under `scratchpad/w75/` (all untracked scratch names):

* **`A3_roles.py`** — prints the speed-block allocno ROLES (`refs`/`live`/hard reg/priority
  for hun, w1, w2, pSprt, ten, w7, speed) out of a `-dg`/`-dl` pair, keyed by **defining RTL
  pattern** rather than pseudo number, so it survives the renumbering every source edit
  causes. This is what made the search tractable — the gate is non-monotone across this
  4-cycle, the role table is not.
* **`A3_probe.py`** — apply variant → gate → (optionally) `posmis` → `rtl_dump` to a
  **protected per-variant name** → role table → restore. **Snapshot/restore PER VARIANT**
  (see the concurrency note below).
* **`A3_apply.py`** — apply one named variant, write `sbs` to a protected file, optional
  `--keep` for a landing.
* **`A3_search.py`** — the negative-delta dial search (2a).
* Protected dumps `A3_base.{greg,lreg}`, `A3_<variant>.{greg,lreg}`; side-by-sides
  `A3_sbs_*.txt`; variant sets `A3_tach{1..7}.json`, `A3_num{1..9}.json`.

**Hazards paid for:**

* 🔴 **A whole-run snapshot/restore harness is UNSAFE in a shared clone.** A concurrent human
  session (w75-a4) edits this same `hud.cpp`; a probe that snapshots once and restores at the
  end can clobber their landings. `A3_probe.py` now re-reads and restores **per variant**
  (≈1 s window). One collision was observed and both sides survived, but a later probe run
  still left a variant applied (state recovered by hand and re-verified: BuildNumbers back to
  188 @758, BuildTach still PASS). **Verify the base gate after every probe run** — the
  harness's own "restored ok" line is not sufficient evidence in a shared tree.
* `sbs.py` must be redirected with a shell `>`; capturing it inside the probe silently
  produced an empty file twice.
* `rtl_dump.py` writes the fixed path `scratch/rtl/hud.i.*` — every dump is copied to
  `scratchpad/w75/A3_<tag>.{greg,lreg}` immediately (the w74 stale-dump trap).
* Windows `TMPDIR/TMP/TEMP` set for every cc1 invocation (no `cta*` litter produced).

**Not done (policy):** no `git commit`/`push`/staging, no memory-file edits, no new
`build.py` rows (per the orchestrator's `75be7d4c` policy), no asm/value pins — the only
`__asm__` used are the established zero-insn fence/phony-loop device classes.
