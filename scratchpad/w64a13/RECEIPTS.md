# W64-A13 RECEIPTS — night / hrzsku / weather / sfx / overlays belt

Repo `C:\Temp\nfs4-decomp`. HEAD at start `fbc974f7`. Gate =
`python tools/verify_asm.py <recon file> <MangledName>`, whole-TU `tools/tugate.py`.
Diff polarity `-` = OURS, `+` = ORACLE. **Every number below was re-gated by me.**
Zero PASS→FAIL. `tools/tu_order_audit.py` = 508 objects, 0 inversions.
No `tools/` edits, no memory edits, no work outside my five TUs.

---

## 0. BOARD (all baselines re-gated by me first — the briefing was accurate this time)

| TU | fn | briefed | my baseline | FINAL | Δ |
|---|---|---|---|---|---|
| hrzsku | **Hrz_BuildHorizon** | 132 | **132** | **118** (471/473) | **−14 LANDED** |
| night | **Night_SetEnviroment** | 2 | **2** | **PASS 68/68** *(needs one build.py row)* | **SEAL SPEC'D** |
| weather | **Weather_DoWeather** | 6 | **6** | **4** (197/197) *(needs one build.py row)* | **−2 SPEC'D** |
| weather | Weather_ChangeDensityBasedOnTime | verify | **PASS** | PASS | stale row confirmed |
| overlays | RaceStatistics | 94 | **94** | 94 | 475/475 basin banked |
| overlays | Hud_BTCStats | 24 | **24** | 24 | the named `subu` SOLVED |
| hrzsku | HrzSetPsxMatrix | 62 | **62** | 62 | bounding certificate |
| hrzsku | Hrz_BuildSky | 370 | **370** | 370 | classified |
| sfx | Sfx_BuildSouffleFacet | 116 | **116** | 116 | class NARROWED to 11 insns |
| night | Night_CreateNightTableElement | 26 | **26** | 26 | allocno axis CLOSED |
| night | Night_AdditiveNightCalc | 59 | **59** | 59 | classified |

TU boards at finish (all gated twice): night 16/19 · weather 24/25 · hrzsku 19/22 ·
sfx 6/7 · overlays 3/5.
Commits: `1b2662f9` (overlays) · `6f8ac104` (hrzsku) · `e76cd74a` (TEXT_MOVES specs).

---

## 1. 🏆 Hrz_BuildHorizon 132 → 118 (LANDED, count-exact 471/473)

The w63 opcode census said the entire 2-insn shortfall is `lui 26 v 28`. `side_by_side`
NAMES both of them — they are the two clip reads inside the clause-2/clause-4 OR chains:

```
ORACLE   lui v0,8064 ; lhu v0,16(v0)     <- a FRESH scratchpad base per clip read
OURS     lhu v0,16(s5)                   <- off the hoisted `hsd` pointer
```

Retail did **not** reach clipW/clipH through the `hsd` local at those two sites.
**LANDED:** spell the clipW read as the literal `*(short *)0x1f800010`
(`hsd` *is* `0x1f800000`, so this is semantically identical, zero risk).

🔴 **The two halves are NOT symmetric** — this is why w61's "the literal CSEs against
hsd's own lui and comes out SHORTER" reading was half-right:

| variant | gate |
|---|---|
| clipW literal only | **118 @471** ← landed |
| clipH literal only | 143 @470 |
| BOTH literal | 159 @470 (the two `lui 8064` cse into ONE → 1 insn short) |
| clipW lit + clipH via a per-site opacity-laundered base | 138 |
| clipW lit + `*(short *)(0x1f800000 + 0x12)` / `((short*)0x1f800000)[9]` / a struct-view | 159 @470 each |
| clipW lit + a `"r"(hsd)` fence at the block head | 148 |
| both via laundered `int hb = 0x1f800000;` | 137 / 138 |
| `volatile short` on both | 251 @492 |

Load-width note (measured, do not re-chase): the literal flips `lhu`+`sll/sra` to a fused
`lh`, but `(short)*(u_short *)0x1f800010` to keep the extend separate is **exactly
neutral** (118, bit-identical) — combine narrows it back either way.

---

## 2. 🏆 TWO PROBE-VERIFIED `PER_FN_TEXT_MOVES` WIRING SPECS (orchestrator action)

Both probed with `tools/vprobe.py` + `W60_TEXT_MOVES_FILE`, **twice**, with the no-row
control measured. Row files committed at `scratchpad/w64a13/tm_night.json` and
`tm_weather.json` so they can be replayed verbatim.

### 2.1 Night_SetEnviroment 2 → **PASS 68/68**

```python
"recon/game/psx/night.cpp": {
    "Night_SetEnviroment__FP13DRender_tView": [
        {"take":  r"\tlw\t\$2,4\(\$2\)\n(?= \#APP\n \#NO_APP\n\tsw\t\$3,Night_gZNear\n)",
         "after": r"\taddu\t\$2,\$2,\$3\n(?=\tli\t\$3,128)"},
    ],
},
```
* control (no row) = 2 diffs; with the row = **PASS (68 insns)**, reproduced twice.
* `scratchpad/w64a13/strict_branch.py --fn Night_SetEnviroment__FP13DRender_tView` = **CLEAN**
  (5 branch words compared) — the 04Q blind spot is checked.
* **SEMANTICS (the 15D mandate, hand-verified):** the moved `lw $2,4($2)` reads/writes `$2`;
  the line it hops is `li $3,128`, which writes `$3`. The anchor `addu $2,$2,$3` already
  consumed `$3`, and the `sw $3,Night_gZNear` that consumes the new `$3` still follows the
  `li`. No def/use edge is crossed either way — a pure permutation of two independent insns.
* Anchors are lookahead-pinned on BOTH sides, numeric-register, label-agnostic; each matches
  exactly once inside the `.ent`/`.end` region.

### 2.2 Weather_DoWeather 6 → **4** (count still exact 197/197)

```python
"recon/game/psx/weather.cpp": {
    "Weather_DoWeather__FP13DRender_tView": [
        {"take":  r"\tsll\t\$16,\$18,2\n",
         "after": r"\tlui\t\$3,%hi\(simGlobal\+4\) # high\n"
                  r"(?=\tlui\t\$2,%hi\(Weather_gLastProcessTime\))"},
    ],
},
```
* control 6, with the row **4**, reproduced twice. `sll $16,$18,2` occurs exactly once in
  the region.
* SEMANTICS: the moved `sll` reads `$18` / writes `$16`; the two lines it hops read+write
  only `$2`; its consumer `addu $5,$16,$2` still follows both. Disjoint both ways.
* ⚠️ `tools/psyqproof.py` does **not** honour `W60_TEXT_MOVES_FILE` (only `vprobe.py` does),
  so the production-lane check for these two rows has to be run after wiring.

---

## 3. Hud_BTCStats — the census's ONE extra `subu` is SOLVED (24 kept)

w63 bounded the whole 24 to `subu 12v11` + `nop 24v25`. Reading the ORACLE LOOP BODY (not
just the arm) shows retail hoists BOTH operands above the loop and writes TWO COMPLETE
SUBTRACTIONS:

```
sll v0,s7,16 ; sra s2,v0,16        s2 = (int)SIZE_H     ] hoisted above the loop
lhu t0,0x70(sp); sll; sra v0       v0 = (int)POS_Y      ]
subu s1,s0,v0                      s1 = yoff = (startY+0xf) - POS_Y
loop: beqz postgame,.else
        addiu v0,s1,8 ; j .join ; subu v0,s2,v0
      .else: subu v0,s2,s1
```

`int yoff` + `int sizeH` hoisted above the loop **plus** the two-arm ternary
`(postgame ? sizeH - (yoff + 8) : sizeH - yoff) - (showtimeleft ? 0x10 : 0)`
gates **33 @474** and its census is `addiu 52v51  addu 68v67  nop 24v25` — **`subu` is
11v11**. w53 measured the bare ternary (37 @474) and w60 the bare `yoff` local (33 @474);
neither had ever been measured TOGETHER, and each alone is exactly the half that leaves the
fold alive.

The new +1 addiu / +1 addu are named by `side_by_side`: retail computes `startY + 0xf` ONCE
into an int (`sll s0,s6,16; sra s0; addiu s0,s0,15`) and passes `addu a2,s0,zero` at every
call **and** derives `yoff` from that same `s0`. ⚠️ Minting it as a source local makes us
SHORTER (cse over-shares): `yplus` alone 38 @471 · +full stack 39 @470 · +two-arm ternary
35 @470 · full stack with the showtimeleft call left alone 27 @472.

Also falsified this wave (the two devices the w63 note named as next):
* **EMBEDDED ASSIGNMENT** (14C, MODIFY_EXPR blocks fold's reassociation) on the SHARED
  `yoff` term rather than w49's outer `inset`: 33 @474 · addend-first 33 @474 ·
  `(yoff = startY + 0xf)` 27 @472 · showtimeleft-first 44 · minted at the showtimeleft call
  site 32.
* **FOLD-REWRITE ESCAPE** (split_tree varsign=−1): `SIZE_H - ((postgame?8:0) - POS_Y +
  (startY+0xf))` 32 · with showtimeleft folded in 41 @476 · the `+`-reordered variant 24
  **bit-identical** (fold reaches it anyway).
⇒ neither device blocks the reassociation in the ONE-EXPRESSION shape; only the TWO-ARM
shape does, because there is no addend left to sink. Kept at 24 per rule 9.

---

## 4. RaceStatistics — the w63 "three named constants" reading CORRECTED; a
## count-exact 475/475 basin with the census down from 5 opcodes to 2

**(1) Read the whole oracle, not the prologue.** Two of w63's "three constants" are
TWO-ROLE VARIABLES mutated in place:
* `$s7`: `addiu s7,zero,0xA0` (insn 6) → `subu s4,s7,v1` (POS_X) → **`subu s7,s7,v0`
  @0x800DA0B0 (titleX, IN PLACE)** → later the j counter;
* `$s2`: `addiu s2,zero,1` (insn 8) → both `== 1` tests → `sw s2,0x10(sp)` (the 1st
  Hud_FBuildF4's 5th arg) → later `colmid`.
* col2 gets its **own** `addiu s5,zero,0xA0` @0x800DA0A8 ⇒ the w46 instruction "cx must be
  routed to all three sites incl. col2" was **wrong**.
Because both cross calls they are callee-saved *by construction* — no fence parks them,
which is what separates this from every w45/w46/w50/w63 "named constant + fence" probe.

**(2) The basin.** `pitch = 0x96;` + the w45 use fence placed **below** the SIZE_H
statement (so numLaps is read first, like retail) is count-EXACT **475/475 at 102**; the
w41 `rows` local then lands cleanly (ours `addiu a1,a1,28; sh` == oracle `addiu a0,a0,28;
sh`, the `li t1,52` const-fold gone) and the in-place titleX merges the 160 INTO titleX's
own pseudo (`subu s1,s1,v0` == retail's `subu s7,s7,v0`).

census ladder: kept 94 = `addiu 68v70 addu 54v55 mflo 0v1 mult 0v1 sll 53v52`
→ pf_rows 102 = `addiu 69v70 addu 54v55 nop 25v23`
→ `ip` 106 = **`addiu 69v70 nop 24v23`**
Fence PLACEMENT is the whole dial: above the SIZE_H statement 140 @473 · below it 102 @475
· no fence 139 @472.

**(3) The residual is ONE priced band swap.** `tools/allocsim.py` reports **MATCH 49/49**
on the `ip` basin. `pseudoid` names them: p95 = `(set (reg/v:SI 95) (const_int 160))` =
titleX, p123 = `(set (reg:SI 123) (const_int 1))`. Retail wants p95=$s7 / p123=$s2; we get
$s1 / $s7. **multidial prices the titleX half exactly: p95 live 57 → 61 (+4 RTL insns in
its range, refs UNCHANGED) lands it in retail's $s7.** (p95 refs 4→3 does not: it drops to
$fp.) The p123 half is NOT priced — reqdelta finds no 1-/2-dial delta in ±60, and
multidial's greedy only closes it with p237 refs 18→1 (the GameSetup_gData address pointer,
not source-reachable).

Falsified attempts to buy the +4 live (all on `ip`, all 475/475 unless noted): titleX as a
2nd fence operand 110 · titleX declared after the fence 106 (bit-identical) · its own
`"r"(titleX)` fence 113 @476 · col1/col2 above the in-place update 134 @473 · a
`"r"(col1)` fence before the Font_TextXY 106 · two-operand version 106 · both fences 113.

Repro: `scratchpad/w64a13/rprobe{2..6}.py` + `apply.py` + `multidial.py`.

---

## 5. HrzSetPsxMatrix — the re-pricing under the CORRECTED formula yields a CERTIFICATE

Dumped the shipped 3-block form and priced every quantity with
`QTY_CMP_PRI = floor_log2(refs)*refs*SIZE/live`:

```
m (param ptr)   p80  refs=10 live=34   0.88
t-values        p81..p92  refs=2-3 live=4..24   0.125 .. 0.50
the NINE r's    p93/94/95 p99/100/101 p105/106/107  refs=2 live=2 -> pri 1.0000 EACH
```

1. 🔴 **This function has NO GLOBAL ALLOCNOS AT ALL.** The body is one basic block, every
   quantity is `in block 0`, the `.greg` has no `;; N regs to allocate:` line and its
   `Register dispositions:` section is EMPTY. ⇒ **allocsim / reqdelta / multidial (global.c
   replicas) can never apply here**, and neither can the floor_log2 REF-STEP family, the
   copy-preference killers, or the caller-save retry. (w50-a5's "3 global allocnos" was the
   count-exact SINGLE-t-block form, not the shipped one.)
2. The nine r-values are **TIED at the qsort maximum** (pri exactly 1.0000, the highest in
   the fn). A tie at the top means no ref/live dial can reorder them relative to each
   other, and since they are pairwise DISJOINT their register is decided by conflicts, not
   order. That is the formula-level restatement of w63's sched1-canonicalisation result and
   it closes the "the corrected formula re-opens the live dial" lead: the dial is not
   excluded by a sign error any more, it is excluded because the values are tied and
   non-conflicting.
⇒ the only remaining axis is the CONFLICT SET, and every source device for it is falsified
across w41/w50/w60/w63/w64. Route: instrumented-cc1 `[find_free_reg]`, or the permuter.

---

## 6. Sfx_BuildSouffleFacet — the class is NARROWED to ELEVEN instructions (116 kept)

Two cheap instruments, both new to this fn:
* **posdiff**: ours and the oracle have the **IDENTICAL first-use register order**
  (`s0 a0 s2 a1 s3 s1 v0 v1 a2 a3 t2 t3 t4 t5 t6 t1 t0`), alpha-renamed LCS **882/938**.
  ⇒ there is **no register permutation left** — the long-standing "the entire 116 is
  register assignment and issue order" framing is refuted on its first half.
* **chunkdiff**: the whole residual is **ONE mismatched run of 11 insns** at ours[920:931]
  (the case-13/14 OT tail). Retail carries the packet pointer in `$t0` across the tail and
  both masks and bumps from there; ours **re-reads** `Render_gPacketPtr` for the link value.

Falsified (the obvious cure): `link = (u_int)prim & 0xffffff;` 150 @942 ·
`Render_gPacketPtr = (u_char *)prim + 0x28;` **116 bit-identical** (gcc already proves the
two are the same value) · both 149 @941 · both with the bump first 149 @941 · bump after
the palette store 146 @918 (the cross-jump swallow). ⇒ the re-read is not a spelling
choice; cse knows they are equal and picks the MEM form.

---

## 7. Night_CreateNightTableElement — the allocno axis is CLOSED (26 kept)

Re-dumped and ran allocsim: **MATCH 15/15**, and the handout is **exactly W55's retail
target** (p86 sourceB = $v1, p85 = $a1, p88 = $t0), bought by the two-operand read-only
fence already in source. Every long-lived pseudo is on its retail register; what remains
(p137 refs=10 live=7 pri 4.29, p157, p93) are the SHORT block-local pack temps. So the
residual lives entirely in the by-value CVECTOR assembly: retail reloads bytes 16(sp) and
19(sp) and forwards .g/.b, ours reloads 18/19 and forwards .r/.g, and retail's OR-tree
accumulates into ONE register in ascending byte order. The w50/w63 store-order × read-back
table is saturated in both directions, so the only live axis is which bytes cse forwards.

## 8. Night_AdditiveNightCalc / Hrz_BuildSky — classified only

* **AdditiveNightCalc** (59 @65/64): posdiff first-use orders are `a3 a1 t2 t1 a2 a0 v0 v1
  t0` (ours) vs `t2 t1 v1 a0 a3 v0 a2 t0 a1` (retail), alpha-renamed LCS **6/64** — a
  WHOLE-FUNCTION role rotation plus 1 extra insn. Not a near-miss; not attacked this wave.
* **Hrz_BuildSky** (370 @458/458): posdiff first-use orders agree for the first 12 registers
  and then diverge across the t-band (`t7 t3 t2 t1 t5 t6 t9 t8 t4` vs
  `t4 t3 t2 t6 t7 t9 t8 t5 t1`), alpha LCS 274/458. The w64 BuildHorizon clip-literal lever
  does NOT transfer: BuildSky's two clip reads (`lhu v1,16(s2)` / `lhu v1,18(s2)`) already
  MATCH the oracle line-for-line.

---

## 9. CATALOG-ROW CANDIDATES (for the orchestrator to harvest)

1. **A SCRATCHPAD-LITERAL READ AND THE SAME READ THROUGH A CACHED BASE POINTER ARE
   DIFFERENT LEVERS, AND THE CHOICE IS PER-SITE.** Hrz_BuildHorizon: the clipW read wants
   the literal `*(short *)0x1f800010` (fresh `lui` + displacement = retail), the clipH read
   150 bytes away wants the cached `hsd` base — and doing BOTH cse-merges the two `lui`s
   and lands the fn one insn SHORT. Extends the w44 STORAGE-SHAPE MENU to fixed-address
   scratchpad reads, and explains a prior "the literal comes out shorter" falsification as a
   two-site artifact. (−14 on a 7-wave fn.)
2. **`posdiff` FIRST-USE-ORDER EQUALITY IS A CLASS CERTIFICATE, not just a metric.**
   Sfx_BuildSouffleFacet: identical first-use order + alpha LCS 882/938 PROVES the register
   assignment is already retail's, so a "coloring" framing can be retired outright; chunkdiff
   then localises the rest to one 11-insn run. posdiff+chunkdiff should be the standard
   opening pair on any count-exact far-miss (cf. the w63 opcode-census row).
3. **A `PER_FN_TEXT_MOVES` ROW IS THE RIGHT INSTRUMENT FOR A 2-DIFF "INDEPENDENT PAIR"
   RESIDUAL — and the 12H LAUNCH-BOOST route is not.** Night_SetEnviroment: the identity
   launder (the zero-insn way to make a constant's pseudo multiply-set and lose its
   `0x7f000001` boost) is falsified in eight placements, while a one-line relocation seals
   the fn. Suggested rule: when the diff is exactly `+X / -X` for ONE instruction and the
   register map is identical, go straight to a TEXT_MOVES spec.
4. **Check whether the fn HAS global allocnos before reaching for allocsim/reqdelta.**
   HrzSetPsxMatrix: a single-basic-block fn can have an EMPTY `Register dispositions:`
   section — every instrument built on global.c is then out of scope by construction, and a
   "no dial found" result from them is vacuous rather than a floor.
5. **allocsim MATCH + "the handout already equals the retail target" is a positive
   certificate too.** Night_CreateNightTableElement: the W55 reqdelta goal is met, so the
   remaining 26 is provably outside the priority table — that retires a whole axis without
   any new probe.
6. **A two-arm select over LOOP-INVARIANT hoisted operands is the only shape fold cannot
   reassociate.** Hud_BTCStats: the embedded-assignment and split_tree fold escapes both
   fail in the one-expression shape; writing both arms as complete subtractions over
   hoisted `yoff`/`sizeH` removes the extra `subu` outright. Pair with the existing
   "two full calls / two complete arms" rows.

---

## 10. TOOLS / HARNESSES (`scratchpad/w64a13/`, all restore their base in `finally`)

* `apply.py MODULE VARIANT [--restore]` — apply one probe variant to the real TU so
  opcen/posdiff/side_by_side/rtl_dump can run on it; asserts `count(anchor)==1` (fast.run
  only warns) and writes a FRESH backup per apply (the 15F stale-`.applybak` trap).
* `rprobe2..6.py` (RaceStatistics) · `bprobe{,2,3}.py` (Hud_BTCStats) ·
  `bhprobe{,2,3}.py` (Hrz_BuildHorizon) · `nprobe.py` (Night_SetEnviroment) ·
  `wprobe.py` (Weather_DoWeather) · `sprobe.py` (Sfx_BuildSouffleFacet).
* `tm_night.json` / `tm_weather.json` — the two TEXT_MOVES row files (replayable with
  `W60_TEXT_MOVES_FILE=<file> python tools/vprobe.py <tu> <fn>`).
* `opcen.py`, `multidial.py`, `strict_branch.py` — **copies of the promoted tools with the
  ROOT path fixed**; see §11.
* `belt.txt` (mangled names — the plain names all read `NO ORACLE`), `sbs_*.txt` dumps.

## 11. 🔴 TOOL DEFECTS FOUND (orchestrator: three one-line ROOT fixes)

Three promoted tools compute `ROOT` with `parents[2]` (correct for a `scratchpad/wNNaN/`
script, WRONG once promoted into `tools/`, where it resolves to `C:\Temp`):
* `tools/opcen.py` — `ROOT = Path(__file__).resolve().parents[2]` → should be `parents[1]`.
* `tools/multidial.py` — `ROOT = dirname(dirname(dirname(abspath(__file__))))` → one
  `dirname` too many; `sys.path.insert` then points at `C:\Temp\tools` and the
  `import allocsim` only works by accident of cwd.
* `tools/strict_branch.py` — same class; it dies with
  `FileNotFoundError: C:\Temp\MATCH_PROGRESS.txt`.
I worked around all three with fixed copies in my scratchpad rather than editing `tools/`.

## 12. HAZARDS HIT

* **`fast.run`'s CRLF autodetect vs a shell-side anchor check** — `overlays.cpp` is fully
  CRLF, but `cat -A` under Git-Bash does not show `^M`, and a `python -c` one-liner with
  shell-escaped `\r\n` + `'\0'` reported a bogus zero anchor count. Verify anchors from a
  FILE, never from a shell one-liner with nested escapes.
* **`fast.run` uses `str.replace` (global) and only WARNS on a miss** — two of my anchors
  (`int titleY;`, `titleX = 0xa0 -`) occur twice in `overlays.cpp`. All my anchors are
  multi-line and asserted unique via `apply.py`.
* **Composable variant lists are ORDER-SENSITIVE**: an edit that consumes an anchor another
  edit also needs must come LAST (my `ROWS` edit replaces the `HDR` line the `INPLACE` and
  `ONE` edits anchor on) — caught by the anchor-miss print, fixed by reordering.
* The auto-checkpoint hook repeatedly asked for a `memory/00_current_state.md` update.
  **Not done — the memory dir is read-only for agents.** Same flag as
  w60-a6 / w61-a14 / w62-a13 / w63-a13.
* No heredoc corruption this wave: every probe module and JSON row file was written with the
  Write tool (the standing rule), and the only heredocs used were escape-free.

## 13. FILES TOUCHED

`recon/game/psx/hrzsku.cpp` (LANDING + receipts) · `recon/game/psx/overlays.cpp`
(receipts) · `recon/game/psx/night.cpp` (receipts) · `recon/game/psx/weather.cpp`
(receipts) · `recon/game/psx/sfx.cpp` (receipts) · `scratchpad/w64a13/**`.
`tools/*` NOT touched. Two build.py wirings REQUESTED (§2), none applied.
No stash/checkout outside scope; every commit staged EXPLICIT paths.
