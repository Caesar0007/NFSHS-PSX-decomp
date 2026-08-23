# W75-A8 — hrzsku belt report (2026-08-23)

Unit `game/psx/hrzsku`, TU `recon/game/psx/hrzsku.cpp`.
Re-baselined AFTER the concurrent session's commit `d9de218c` "Restore exact SYM type graph
for hrzsku" and re-read the whole TU + both W74 receipt blocks before touching anything.

## HEADLINE

| fn | baseline | final | count | posmis |
|---|---|---|---|---|
| `Hrz_BuildHorizon__FP13DRender_tView` | **20** | **12** | 473/473 EXACT | 48 -> **9** |
| `Hrz_BuildSky__Fv` | **150** | **146** | 458/458 EXACT | 81 -> **76** |
| whole TU | 20/22 PASS | **20/22 PASS** | — | — |

Neither function SEALED. **ZERO PASS -> FAIL** (whole-TU gate run twice, identical both
times; `HrzSetPsxMatrix` re-confirmed PASS 56/56). No commits, no staging, no memory-dir
edits. `tools/build.py` untouched (the foreign uncommitted edit is preserved).

Three multi-wave residuals were CLOSED: the BuildHorizon clipW load-delay nop, the
BuildHorizon clipH `lui` (standing since w64, 4th basin), and the BuildSky preheader hoist
order (the whole hoist list is now byte-exact).

## NEW LAW (the wave's main find)

**A ZERO-BYTE ASM IS A REAL SCHEDULING INSN AND WILL EAT A LOAD-DELAY SLOT — and the cure
is an EXTRA INPUT.**

A non-volatile launder `__asm__("" : "=r"(x) : "0"(x))` is an RTL insn that emits **no
bytes**. sched sees it become ready one cycle after the load that feeds it, parks it in that
load's delay gap, and reports the latency satisfied — but because it assembles to nothing,
the slot is emitted as a `nop`. At the BuildHorizon clipW site that was exactly the one insn
retail spends on `lh v1,40(sp)` (`mpts[0].vx`).

This is a **distinct** cost from catalog 23B(2) ("an identity launder is not free: its `addu`
lands in whatever delay slot is nearby") — here the launder emits *nothing at all* and still
costs a slot.

CURE, zero insns: hand the asm the value you want in the slot as an extra input —
`__asm__("" : "=r"(cw) : "0"(cw), "r"((int)mpts[0].vx));`. The `lh` must then be scheduled
ABOVE the asm, so it lands in the slot; the asm moves to a spot with no stall. The operand is
free (it is the `lh`'s own destination register).

GENERALISES: any "ours has a `nop` where retail fills the slot" sitting next to an existing
zero-byte fence/launder is this law; the extra-input form is the fix. Worth sweeping the
tree for `__asm__("" : "=r"` devices adjacent to an unfilled load-delay slot.

Compiler-source basis: the asm pattern is a normal `insn` in the RTL chain (`sched.c`
priority/ready-list machinery makes no exception for empty asm templates), and 22B(5) already
established that a non-volatile launder is *not* a sched barrier — so it is freely
schedulable, which is precisely what lets it drift into the delay slot.

## Hrz_BuildHorizon — 20 -> 12 (three landed edits)

Ledger (verify_asm, all count-exact 473/473; posmis via `scratchpad/w75/posmis.py`):

| step | diffs | posmis |
|---|---|---|
| W74 shipped baseline | 20 | 48 |
| + clipW extra-input launder (alone: 17 @472, count short) | — | — |
| + clipH `int ch` + extra-input launder (alone: 17 @474, count long) | **14** | 10 |
| + `int q = iVar15 + (int)hsd;` (index-first int sum, 12D) | **12** | **9** |

1. **The +-1 TRADE CELL (23B(1)).** The clipW nop (+1) and the clipH missing `lui` (-1) are
   one cell; W74 had priced each half alone and rejected both. Together they are exactly
   count-neutral and both residuals vanish.
2. **The clipH spelling.** Retail reads clipH the same way it reads clipW — a fresh
   `lui 0x1F80` + **`lhu`** + an UNFUSED `sll 16 / sra 16` — i.e. retail did *not* reach
   clipH through the `hsd` pointer (which is why ours emitted the single `lhu v0,18(s6)`).
   The two previously-falsified spellings both fail for the same reason: they produce a
   **signed** `lh` and the extend folds away.
     - `*(short *)0x1f800012` -> 61 @472 (`lh` + no sll/sra)
     - `int ch = *(u_short *)0x1f800012;` (no launder) -> 61 @472 (combine re-fuses to `lh`)
     - `int ch` + extra-input launder -> 17 @474 = **the right shape**
3. **`iVar15 + (int)hsd`** (12D index-first). W74: "INERT in three basins (fold reassociates
   it back)". FALSE once the clip residuals are closed — 04Z / 23B(7) re-pricing, worth 2.

### Remaining 12, named

- **[187-193] the `iVar18`/`iVar15` init pair vs the two loop.c hoists (4 lines).** Retail
  emits the HOISTS first (`lui/addiu fp`, `addu s3,s6,zero`) and the two inits after.
  **NEW NAMED ANGLE (not run — out of budget):** loop.c appends its hoists at the END of the
  preheader, so a PRE-LOOP assignment can never come after them (21B(3)). Retail's
  `addu s2,s4,zero` / `li s5,4` are therefore very likely loop.c's own **GIV initialisers** —
  i.e. `iVar15`/`iVar18` are not source variables at all (they are absent from the SYM, which
  lists only `right`/`prim`/`pmx` in that block) but strength-reduced `i`-indexed accesses
  (23C(4)/(5), the TimeSprites/BuildSpikeBelt class). The rewrite: index every
  `hsd + iVar15 + K` / `+ iVar18 + K` by `i` / `i+1` and delete both counters.
  Cheap falsifications done first: init order swapped **16**; `iVar15 = i; iVar18 =
  iVar15 + 4;` **16**; a 2-operand read-only fence before the pair **74 @475**.
- **[335-338] the RMW1 evaluation order (8 lines).** ORACLE-READ TRUTH: retail's RMW1 is
  **TAG-FIRST** — it loads `*(u_int *)p` first (`lw v1,0(s0)` before `lw v0,-8(a0)`), ANDs it
  with `$a1`=0xff000000, and the OR's dest is that same register. Our 24-bit-first spelling
  is provably not retail's. Writing it tag-first makes **all four** of those lines match and
  is blocked by exactly ONE local-alloc slot rotation (ours then gives `pp` `$a1` and the
  0xff000000 hoist `$t1` where retail has `$a2`/`$a1`): 36 @473, posmis 18.

## Hrz_BuildSky — 150 -> 146 (one landed edit, device-free)

**THE LEVER: split the pixmap-table ADDRESS off its LOAD.**

```c
Draw_tPixMap **hpb = gHorizonPixmap;   /* FIRST statement of the GT4 block */
prim = ...; slot = ...; pmx = hpb[gSkyPixmapIndex[i]];
```

loop.c walks movables in RTL-generation order, so the **preheader hoist ORDER is decided by
FIRST APPEARANCE in the loop body**. W74 could only put retail's `lui/addiu s3`
(`gHorizonPixmap`) at the head of the hoist list by moving the whole `pmx` STATEMENT to the
front, which costs 58 elsewhere (the `pmx` load must stay last). Naming the base as a
block-local **decouples the two halves**: the address appears first, the load stays last. The
local is born in the loop so loop.c hoists it (21B(3)); zero insns. The preheader is now
byte-exact — the W74 "[143-147]" residual is closed. The FT4/G4 twin is redundant (GT4 is
generated first) — measured bit-identical.

### Falsified / re-priced this pass (all re-gated in the NEW basin)

- The same first-appearance effect via a **fence** — `__asm__("" : : "r"(&gHorizonPixmap[0]))`
  at the loop top / in the GT4 head / after `temp` — **180-181 @461-462**: an output-less asm
  is a sched1 barrier at the loop head (20A) and costs 3-4 insns. The launder-carrier form on
  `temp` with the address as an extra input: same 180. (So the device family is the WRONG
  tool for a hoist-order question; the source-shape split is.)
- **G4 `slot` as an INT-typed index-first sum (12D):** +11 insns (469) at the G4 site ALONE,
  and still +11 with all three sites converted — so it is NOT the FT4/G4 cross-jump group
  (23B(5)) but the G4 arm itself. GT4 site = BIT-IDENTICAL; FT4 site = count-exact but posmis
  458. W74's global verdict now confirmed per site.
- **G4 `prim` 20B hard-reg conflict** to force retail's `prim=$a1`/`slot=$a0`: every spelling
  (`"$4"` launder, `"$4"` void, `"$5"` launder) costs the SAME **+11 insns (469)**. That is
  20B LIMIT (2) — `reload1.c` puts every asm-used hard reg into `bad_spill_regs`
  FUNCTION-WIDE and this function needs `$a0` as a spill reg. **=> the G4 `$a0<->$a1` tie is
  CERTIFIED unreachable by the whole 20B family**; it has to be attacked from the
  ref-count / live-length side. (Quantified certificate, W74's "cheapest residual" retired as
  a device target.)
- Statement order re-priced: G4 slot-first BIT-IDENTICAL, FT4 slot-first BIT-IDENTICAL, GT4
  slot-first 150, all three 150. Named `int px = gSkyPixmapIndex[i]` (with or without `hpb`)
  BIT-IDENTICAL. Index-first byte form `*(Draw_tPixMap **)(px*4 + (int)hpb)` 206. `pmx`
  moved to 2nd or 3rd in GT4 206.
- GT4 `pmx` 20B launder, all of `"$3"/"$5"/"$6"/"$7"`: 216-230 (over-denial).
- **DEVICE-REMOVAL RE-TEST (23B(3))** on the FT4 `"$7"` conflict: still LOAD-BEARING —
  deleting it gates **308 @456** (364 with a GT4 twin added). KEEP IT.

### Remaining 146, named

`[278-304]` GT4 head, `[349-390]` FT4 head, `[391-441]` G4 (pure `$a0<->$a1`). All three are
ONE question: retail serves `index -> slot -> prim` (index=`$v1`, slot=`$a0`, prim=`$a1`)
while we serve `prim -> index -> slot` (`$a0`/`$a1`/`$a2`). Retail's `prim` is served LAST
despite having ~14 refs to `slot`'s 3, so retail's `prim` qty must carry a longer live length
(or fewer refs) than ours. **NEXT TAKER: this is now a pure local-alloc PRIORITY question —
read the instrumented `[qty_order]` trace for the GT4 block (`C:/Temp/nfs4-instr-cc1`,
validate per-basin fidelity first) rather than probing spellings.** Every spelling axis above
is exhausted and the 20B axis is certified closed by the +11 `bad_spill_regs` result.

## MEASURED SIBLING BASIN, DELIBERATELY NOT SHIPPED (BuildHorizon)

```c
u_int tv = *(u_int *)p;
__asm__("" : : "r"(tv));
*(u_int *)p = *pal & m24 | tv & 0xff000000;   /* unchanged 24-first */
```
gates **10 diffs @473** — the two `lw` and the two `and` all become byte-exact — but
**posmis rises 9 -> 16**: the volatile fence is a sched1 barrier, so `lui a1,65280` slides 7
positions into the block and the OR's dest flips. Per the BRIEF's rule ("posmis is the honest
metric on count-exact fns; LCS diff counts are noise there") the 12/posmis-9 basin is shipped
and this one is recorded in the TU receipt as a real alternative basin for whoever cracks the
`pp` `$a1`-vs-`$a2` rotation, since it already owns the load order. Also measured there:
fence one statement later 34; fence next to the `m24` fence 20; 2-operand fence before the
RMW 54; tag-first on top 36. Device-free birth-order forms (`u_int pv = *pal;` after `tv`, or
moving the `pal =` statement below `tv`) are BIT-IDENTICAL — cse re-folds them; the volatile
fence is the only thing that holds the order.

## Other falsifications (BuildHorizon, all re-gated)

- clause-2 comparison written mpts-first (`mpts[0].vx <= (short)cw`): BIT-IDENTICAL.
- read-only fence instead of the clipW launder: 38 @473.
- named `u_int m8 = 0xff000000` (+/- its own one-operand read-only fence), with tag-first:
  36 @473 — unchanged, the mask hoist keeps `$t1`.
- clobbers of ANY register added to the `pp` launder (`"$4"`,`"$5"`,`"$6"`,`"$7"`, singly or
  paired): a uniform **+4 insns (40 @477)** — same `bad_spill_regs` mechanism as BuildSky's
  G4 result. Deleting the `pp` anchor instead: 80 @475 (the anchor is required).
- laundering `pal` with `*(u_int *)p` as an extra input: 39 @476; the same on `p`: 35 @474.
- `__asm__("" : : "r"(*(u_int *)p));` before an unnamed RMW1: 34 @475.
- a 2-operand zero-byte fence before the init pair carrying `(int)hsd` and
  `(int)&gHrzRingColor[0][0]`: 74 @475.

## Files

- `recon/game/psx/hrzsku.cpp` — 3 landed edits + 1 landed edit + two full W75 receipt
  sections appended to the two function banners (every number above is in-TU).
- `scratchpad/w75/` — `probe.py`, `posmis.py`, `sbsdump.py` (protected-name sbs dumper),
  `land_c1.py`, `land_d2.py`, `land_t1.py`, `land_receipts.py`, edit lists
  `e_{a1..a3,b1..b4,c1,d1..d5,f1..f5,g1..g6,h1..h5,i1..i3,j1..j3,k1,k2,l1..l4,s1..s3,t1..t3,u1..u5,v1..v4,w1..w5,x1..x5,y0..y6}.py`,
  and the protected side-by-side dumps `sbs_*.txt`.

No `build.py` device rows were added. No git operations performed.
