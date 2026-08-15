# W63-A13 RECEIPTS — night / hrzsku / weather / sfx / overlays belt

Repo `C:\Temp\nfs4-decomp`. HEAD at start `10e1a01b`. Gate =
`python tools/verify_asm.py <recon file> <MangledName>`, whole-TU `tools/tugate.py`.
Diff polarity `-` = OURS, `+` = ORACLE. **Every number below was re-gated by me.**
Zero PASS→FAIL. `tools/tu_order_audit.py` = 0 inversions before and after.
No `tools/` edits, no memory edits, no work outside my five TUs.

---

## 0. BOARD (re-gated baselines, mine)

| TU | fn | briefed | my baseline | FINAL | Δ |
|---|---|---|---|---|---|
| weather | **Weather_DoWeather** | 96.37% | **18** | **6** (197/197) | **−12** |
| night | **Night_SetEnviroment** | 94.04% | **6** | **2** (68/68) | **−4** |
| weather | Weather_ChangeDensityBasedOnTime | 99.91% | **PASS** | PASS | stale row |
| night | Night_CreateNightTableElement | 95.28% | 26 | 26 | falsified set |
| night | Night_AdditiveNightCalc | 83.88% | 59 | 59 | falsified set |
| hrzsku | HrzSetPsxMatrix | 68.80% | 62 | 62 | hypothesis CLOSED |
| hrzsku | Hrz_BuildHorizon | 95.71% | 132 | 132 | falsified + census |
| hrzsku | Hrz_BuildSky | 93.53% | 370 | 370 | GTE audit CLEAN |
| sfx | Sfx_BuildSouffleFacet | 98.09% | 116 | 116 | class CERTIFIED |
| overlays | Hud_BTCStats | 99.03% | 24 | 24 | census-bounded |
| overlays | RaceStatistics | 93.65% | 94 | 94 | 3-constant reading |

TU boards at finish (all re-gated twice): night 16/19 · weather 24/25 · hrzsku 19/22 ·
sfx 6/7 · overlays 3/5.
Commits: `a3995a6e` (night) · `dfa66791` (weather) · `393d0f6f` (hrzsku) · `6056c330`
(overlays+sfx).

---

## 1. 🔴🔴 LAW CORRECTION — THE ALLOCATOR PRIORITY FORMULA HAS NO `- SIZE` TERM

The catalog's W45 §A row and three in-source receipt stacks on this belt state the
allocno/qty priority numerator as `floor_log2(refs)*refs − SIZE`, and derive from it that
"any 2-ref 4-byte pseudo is NEGATIVE, so the live-length dial INVERTS (longer life RAISES
priority)". **That is wrong.** Read from the sources, not guessed:

`C:/Temp/gcc-2.8.1-src/extracted/global.c:600` (`allocno_compare`):
```c
  pri1 = (((double) (floor_log2 (allocno_n_refs[v1]) * allocno_n_refs[v1])
           / allocno_live_length[v1]) * 10000 * allocno_size[v1]);
```
`C:/Temp/gcc-2.8.1-src/extracted/local-alloc.c:1727` (`QTY_CMP_PRI`):
```c
#define QTY_CMP_PRI(q)  ((int) (((double) (floor_log2 (qty_n_refs[q]) * qty_n_refs[q] \
                                           * qty_size[q]) / (qty_death[q] - qty_birth[q])) * 10000))
```
⇒ **SIZE MULTIPLIES.** Both layers agree (which is the W45 §A0 row's real content, and
that row quotes the formula correctly — the `- SIZE` variant appears in the *other* W45
row and is what propagated). Consequences:

* no priority is ever negative; **more refs and a shorter live range always raise
  priority**, with no inversion band anywhere;
* for a function whose pseudos are all 4-byte ints the *ordering* is unchanged (the `*4`
  is a common factor), so w41-era orderings derived without the size term still stand —
  but every "how far away is the flip" number derived from the `- SIZE` form is wrong;
* the concrete casualty on this belt is **HrzSetPsxMatrix's w50-a5 verdict** ("a 2-ref
  r-value is NEGATIVE while the 6-ref t is POSITIVE, so NO live-length dial can put an r
  above a t"). Correctly: r = 1·2·4/live = 8/live, t = 2·6·4/live = 48/live, so an r at
  live 3 (2.67) already TIES a t at live 18 (2.67). The dial was never excluded by the
  formula. (It is excluded for a different, stronger reason — §4.)
* Night_AdditiveNightCalc's w49-a5 block carries the same error; corrected in place, with
  the re-derived flip targets.

**Catalog action:** correct the W45 §A "🔴 CORRECTION" row (it currently contradicts the
W45 §A0 row four rows above it) and flag the two in-tree receipts it cites — they are
exactly the two on this belt.

---

## 2. 🏆 Night_SetEnviroment 6 → 2 (count-exact 68/68) — a 6-wave floor broken

Every register AND every schedule position now matches retail except one adjacent pair.

**Landed shape** (both halves required, each measured alone):
```c
u_char *tgt = (u_char *)Camera_gInfo[Vi->player].target;   /* pointer NAMED, read early */
int zn2 = 0x80;
__asm__("" : : "r"(zn2));                                   /* RO fence BEFORE the store */
Night_gZNear = zn2;
if ((tgt[0x447] & 4) != 0) { ... }
```

**Why it is not the w50 use-fence walk.** That walk fenced the POINTER; its best position
(p4, between the store and the guard) reached 5 diffs but cost +1 nop because the fence
sat *between the store group and the guard*, so the store could no longer sink into the
`lw v0,4(v0)` load-delay slot. Placing the fence **before** the store leaves the group free
to sink → 68 insns preserved. *The fence's position relative to the value it is NOT
fencing is the dial.*

Ladder (all mine, all 68/68 unless noted): plain 8 · w61 constant launder alone 6 ·
named tgt + RO fence on tgt at the guard 5 @69 · named tgt + RO fence on tgt before the
store + launder 4 · one fence carrying both 2 · **RO fence on zn2 only 2 (landed)**.

Falsified from the 2 basin: operand order swap (2, bit-identical) · split decl/assign (2) ·
`__volatile__` (2) · extra operands (2) · `"i"(0)` added (2) · dropping the dead
`int mode;`/`int zn;` (2) · fence after the store (5 @69) · zn2 declared first (4) · TWO
separate fences (8 — the second barrier re-pins the group) · **dropping the `tgt` local
and fencing only zn2 (6 — the pointer local is load-bearing)** · byte hoisted to an
`int flg` (9 @67) · `"r"(tgt[0x447])` as the operand (**1 diff @69**, count-inexact,
rejected — but it proves the last pair is reachable).

Residual 2 = a sched2 issue-order pair of two independent insns (retail issues the
`.target` load before the `li 128`; both legal, register map identical).
psyqproof: REAL=2, the same two words — production and gate agree exactly.

---

## 3. 🏆 Weather_DoWeather 18 → 6 (count-exact 197/197) — two independent cracks

### 3.1 The 12D DEAD-PSEUDO STAGING LAW, SYM-proven (−6)
The SYM `8c` block lists `{n,wpt,wprevpt,wd,player,ab,clean_up,i,prim}` — **there is no
`mode` local**, and retail carries the `Camera_GetMode` result in `$a1`, which is `ab`'s
own register. `ab` is dead after `*plb = ab;`. Assigning into `ab` instead of adding a
`mode` pseudo mints retail's `addu a1,v0,zero` copy in the jal delay slot **for free** —
the copy that four waves of fences and launders on a separate `mode` could not manufacture
(w41 copy-through-local 96 @199 · w50 fence 49 @198 · w61 fence 39 @198 · w61 identity
launder 39 @198, all rejected on count). 12D reads exactly: *"do NOT add a variable — find
the EXISTING variable that owns that register."*

### 3.2 The head `li a2,1` hoist (−6) — TWO cooperating source facts
1. read `commMode` into a local **BEFORE the three server-array reads**, so its load is
   schedulable alongside them (retail interleaves: `lw s6`, `lw s7`, `lw v0`=commMode,
   `lw s4`). Left after them, the existing `__asm__("" : : "r"(player))` fence is a
   barrier that pins the load past all three → a load-delay `nop` (+1 insn). **That is why
   every earlier "name the constant" probe measured 198.**
2. name the compare's `1` (`int one = 1;`) immediately above that fence.

Position is the whole dial for (1): before the reads **6** · between reads 1-2 **22** ·
between 2-3 **22** · after them **5 @198** (rejected on count).

🔴 **04Z again:** w60 rejected the named `int one = 1;` as *"29 diffs but 198 insns"*. In
the post-(3.1) basin the identical declaration is count-EXACT and worth 6.

Also falsified (12 and 6 basins): RO fence / identity launder on `cm` (12, bit-identical) ·
2-operand `player` fence (12) · moving the player fence below the guard (18) · `cm` split
decl (6) · `*(volatile int *)&` on the commMode read (6) · `int gt = simGlobal.gameTicks;`
at the LastProcessTime guard (6) · index-term-first on `Weather_gLastProcessTimeA` (14).

Residual 6 = (A) the commMode base as a self-temp vs our separate `$a3` scratch;
(B) `sll s0,s2,2` one slot late (the surviving half of the w41 tie 2).
**psyqproof REAL=17 RELOP=10 BEFORE and AFTER** — a pre-existing production-lane
divergence in the prologue lui/addiu group, unchanged by this work (measured both ways by
swapping in the HEAD version of the file).

---

## 4. HrzSetPsxMatrix — the w60 "only remaining hypothesis" CLOSED (62 stays)

The staggered ONE-VALUE-PER-ROW CARRY was executed. The r-half was rewritten flat with
NINE distinct names (the carry cannot be expressed with three sibling blocks reusing one
name set) and the stores interleaved so that N values of row K are still unstored when row
K+1's first shift is computed.

| variant | gate |
|---|---|
| shipped 3-t-block base | 62 @52/56 |
| count-exact single-t-block seed | 72 @56/56 |
| 3-t + carry-1 / carry-2 / carry-1b | 62 / 62 / 62 — **all BIT-IDENTICAL** |
| 1-t + the same three carries | 72 / 72 / 72 — **all identical** |
| 3-t + 1 fence / 2 fences (pinned carry) | 68 / 74 |
| 1-t + 1 fence / 2 fences | 76 / 76 |

⇒ **sched1 canonicalises the emission order of independent shift/store pairs** — six
different interleavings produce byte-identical output, so the carry cannot be requested
from C at all. The fences are genuinely zero-insn here (counts stay 52/56) and still do
not create the overlap, consistent with the w60 walk's floor of 68.

Opcode census: ours vs oracle differ in **exactly one opcode, `lw 14 v 18`** — the four
missing instructions are precisely the four `lw NN(sp)` reloads and nothing else.

Next taker: RTL layer only (instrumented-cc1 `[qty_compare]`/`[find_free_reg]` on the
56/56 base). Do not spend more spellings.

---

## 5. Hrz_BuildSky — the briefed GTE-macro audit comes back CLEAN (370 stays)

Per-opcode census (`scratchpad/w63a13/opcen.py`, which loads `verify_asm.py`'s SOURCE and
reuses its normalizers — 12H anti-drift): the two streams differ in **exactly two
opcodes**, `addu 32v33` and `nop 59v58`, at an identical total of 458.
**Every GTE opcode matches one-for-one** (swc2 13/13, lwc2 10/10, zero mtc2/mfc2/ctc2/
cfc2/cop2 on either side). So `gte_ldv3 / gte_rtpt / gte_stsxy3 / gte_stsz3 / gte_ldv0 /
gte_rtps / gte_stSXY2 / gte_stsz / gte_stlvnl` are all the right forms and arities and
there is **no remaining gte_\* mis-selection**. The 370 is entirely the register
permutation w62 priced (~94 by permtest) + body scheduling + one addu/nop.

---

## 6. Hrz_BuildHorizon — mask-movable dial falsified; the shortfall is named (132 stays)

The w61 open dial (2) — *"make the 24-bit mask outrank the 8-bit one as a loop.c
movable"* — was attacked with the w44 zero-insn semantic no-op RE-MASK inflator and
catalog 13C's "LICM TIPS AT N OCCURRENCES". All @471, all re-gated:
`(*pal & 0xffffff) & 0xffffff` **132 bit-identical** · both ANDs re-masked **132
bit-identical** · the same on the 8-bit mask (negative control) **132 bit-identical** ·
named `pkt24` first **148** · pkt24 + re-mask **148**.

🔑 **MECHANISM / CATALOG-ROW CANDIDATE: the re-mask inflator is an ALLOCNO dial, not a
LICM dial.** cse folds a redundant AND against an already-masked value at *tree* level,
before loop.c ever builds its movable list, so the occurrence-count device reaches
flow.c's `REG_N_REFS` (which is why it works as a ref-step inflator elsewhere) but cannot
reach `combine_movables`. Worth a row so nobody re-derives it.

Census: ours vs oracle differ in **exactly one opcode, `lui 26 v 28`** — the whole 2-insn
shortfall is two missing address materialisations, i.e. w61's open items (2) and (3) are
the same two `lui`.

---

## 7. Sfx_BuildSouffleFacet — the structural family CERTIFIED CLOSED (116 stays)

Per-opcode census: **the opcode multiset is IDENTICAL to the oracle** — not one opcode
differs in count, at an identical total of 938. So in a 938-instruction function there is
no missing call, no missing arm, no width/signedness defect and no mis-selected GTE or
OT-link macro anywhere. The entire 116 is register assignment and issue order. Combined
with w62's negative alias-dial and cursor-re-read probes, the structural family is closed
and the residual routes to the allocator/scheduler lane only.

---

## 8. Hud_BTCStats — census bounds the residual to ONE instruction (24 stays)

Census: `subu 12 v 11`, `nop 24 v 25`, and **nothing else**, at 473/473. Ours spends one
extra `subu` in the col-loop postgame arm; retail spends one extra `nop` elsewhere. That
bounds a six-wave grind hard: there is no second defect under the 24, and any lever that
removes the extra `subu` without disturbing the rest is a seal.
Named next angle (never tried by this stack): the **FOLD-REWRITE ESCAPE** — both natural
spellings of `SIZE_H − ((startY+0xf + t) − POS_Y)` fold in *opposite* directions and
retail folded NEITHER (w60-a7), so the target is a form `fold` cannot touch, and
`split_tree`'s varsign=−1 rewrite (whose output fold never re-folds) is the device.

---

## 9. RaceStatistics — retail names THREE constants, not one (94 stays)

New reading of the oracle prologue: `addiu $a1,$zero,0x96` (insn 4), `addiu $s7,$zero,0xA0`
(insn 6), `addiu $s2,$zero,1` (insn 8). `$s7` is the POS_X centre (`subu s4,s7,v1` =
0xA0 − n·75) and `$s2` is the compare operand for **both** `== 1` tests. So the retail
source held pitch/centre/one in locals — which is what makes 0x96 a non-`CONST_INT`
operand at expand time and therefore a real `mult`. **Every earlier wave probed `pitch`
alone.**

Census prices the whole 4-insn shortfall exactly:
`mult 0v1 · mflo 0v1 · addiu 68v70 · addu 54v55 · sll 53v52`.

| variant | gate | insns |
|---|---|---|
| base | 94 | 471/475 |
| pitch alone | 139 | 472 |
| pitch + centre | 142 | 473 |
| **pitch + centre + one** | 152 | **473** (mult/mflo appear) |
| centre + one | 129 | 470 |
| pitch + one | 144 | 473 |

The SET moves the insn count the right way and produces retail's `mult`, but rotates the
head band. This is the AGENT_GUIDE rule-9 hard-floor-basin case and the *same pairing*
w41-a4 already flagged for the `rows` local. **Unwound** for lack of budget to complete
the paired step. Next taker: start from `all_three` (473/475), treat the head band as the
only remaining problem, and sweep the three initialisers' statement positions first —
retail's `$s7`/`$s2` ARE the two named constants, so the rotation is very likely a
consequence of where they sit.

---

## 10. Night_CreateNightTableElement (26) and Night_AdditiveNightCalc (59)

**CreateNightTableElement** — the w60 reframing confirmed from a new direction: the
SLD-natural r,g,b pack block costs +30 **no matter which bytes are forwarded**, so the
reverse store order is paying for the upstream allocno order, not for the pack block.
All count-exact 113/113: r,g,b + read-back of both .g and .b (retail's own forwarding
pair) **56** · + .b only **56** · + .g only **56** · shipped b,g,r + an extra .g read-back
**26 bit-identical** · g,b,r + read-back of .r **26 bit-identical**. The pack-block half is
saturated in both directions; the only live target is the b15↔sourceG allocno order.

**AdditiveNightCalc** — re-derived targets under the corrected formula
(x 3.20 > xdist 2.91 > z 2.00 = zfar 2.00 > znear 1.88 > color 0.47): demote x below 2.00
(shed one ref → 1.20, or stretch its live past 16 → 1.88) or promote z above 3.20 (needs
7 refs). Falsified, all @65/64: the stretch-and-add-a-ref dial as a late RO fence on `x`
(79 at the block end, 79 before the colour stores), on `xdist` (71), on both (79), on `z`
(71) — every one moves the gate the wrong way. And the receipt's OWN named mechanism
("find_reg skips $v1/$a0 because the conflicting `v` allocno prefers them") attacked with
the device that is supposed to delete a parm's copy preference: identity launder on `v`
alone **75** · before the color launder **59 bit-identical** · after it **59
bit-identical** · both tied on one asm **61** · RO fence on `v` **59 bit-identical** ·
launder below `z = v->vz;` **63**. Laundering `v` does not free $v1/$a0.
Named next angle executed same pass and also falsified: a block-scoped `VECTOR *vp = v;`
(59, bit-identical — cse copy-props the pointer copy away, so no block-local pseudo is
ever minted) and the same with a launder (65). The combine_regs route needs a device that
survives copy-propagation, not just a narrower scope.

---

## 11. CATALOG-ROW CANDIDATES (for the orchestrator to harvest)

1. 🔴🔴 **The `- SIZE` priority formula is wrong** — §1. Correct the W45 §A row (it
   contradicts W45 §A0), and re-open any floor whose arithmetic used it.
2. **The re-mask ref inflator is an ALLOCNO dial, NOT a LICM dial** — §6. cse folds it at
   tree level before `combine_movables` runs.
3. **Fence position relative to a value it does NOT fence** — §2. The barrier's cost is
   paid by whatever store group it separates from its sink target; moving the same fence
   from *after* to *before* an unrelated store recovered the +1 nop and kept the win.
4. **12D staging: check the SYM local list before adding ANY carrier variable** — §3.1. A
   fabricated local for a call result is what blocks retail's copy; the register retail
   uses names the existing variable to reuse. Four waves of fence/launder work on the
   fabricated local were all off-target by construction.
5. **Source statement order of independent shift/store pairs is canonicalised by sched1**
   — §4. Six interleavings byte-identical. Any "write the overlap in source order"
   hypothesis for a straight-line block of independent pairs is dead on arrival.
6. **The per-opcode census is the cheapest opening move on a count-exact far-miss** — §5,
   §7, §8. It certified one function's structural family closed, bounded another to a
   single instruction, and answered a briefed macro question in one run. Tool:
   `scratchpad/w63a13/opcen.py` (promote-worthy; ~1 s, loads verify_asm's SOURCE so the
   normalizers can never drift).

---

## 12. TOOLS / HARNESSES (scratchpad/w63a13/, all restore their base in `finally`)

* **`opcen.py CPP FN...`** — per-opcode census ours vs oracle using verify_asm's own
  normalizers. **Promote-worthy.**
* `nprobe.py` … `nprobe6.py` (Night_SetEnviroment), `cprobe.py` (CreateNightTableElement),
  `aprobe.py`/`aprobe2.py`/`aprobe3.py` (AdditiveNightCalc), `wprobe.py` … `wprobe7.py`
  (DoWeather), `hprobe.py`/`hprobe2.py` (HrzSetPsxMatrix), `bhprobe.py` (BuildHorizon),
  `rprobe.py` (RaceStatistics).
* `dump.py` / `alphacmp.py` / `regcount.py` / `permtest.py` / `vdiff.py` / `vasm.py`
  copied from w62a13.
* `gate.sh` + `belt.txt` — whole-belt re-gate in one call.
* Backups: `night.cpp.w63a13.bak`, `weather.base12.bak`, `weather.base6.bak`,
  `weather.cpp.NEW6.bak`, `weather.cpp.ORIG.txt`.

---

## 13. HAZARDS HIT

* **Heredoc backslash collapse, firing #16** — a `python - <<'PYEOF'` used to *generate* a
  probe module collapsed every `\n` inside byte-string literals into real newlines →
  `SyntaxError: unterminated string literal`. Caught immediately by the mandated
  `ast.parse` check; redone with the Write tool. Quoted heredocs are still not safe.
  (Plain `python - <<'PYEOF'` blocks that contain no backslash escapes worked fine and
  were used for the byte-mode source patches.)
* **`fast.picture()` returns `globals: (none)` on C++ TUs** — its cpp/cc1plus invocation
  does not pass `-fno-exceptions -fno-rtti` (the 12H lab-fidelity requirement) and its
  dump lookup missed the mangled name. The gate half of `fast.run` is unaffected; only
  the allocno picture is dead. Flagged, not fixed (tools are orchestrator-owned).
* Edit-tool "file modified on disk since last read" after a harness restore — expected
  (every harness restores byte-for-byte and asserts it); the edits applied cleanly.
* The auto-checkpoint hook repeatedly asked for a `memory/00_current_state.md` update.
  **Not done — the memory dir is read-only for agents.** Same flag as w60-a6/w61-a14/w62-a13.

## 14. FILES TOUCHED

`recon/game/psx/night.cpp` (landing + receipts) · `recon/game/psx/weather.cpp` (landing +
receipts) · `recon/game/psx/hrzsku.cpp` (receipts only) · `recon/game/psx/overlays.cpp`
(receipts only) · `recon/game/psx/sfx.cpp` (receipts only) · `scratchpad/w63a13/**`.
`tools/*` NOT touched. No build.py wirings requested. No stash/checkout outside scope.
