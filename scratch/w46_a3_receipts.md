# WAVE-46 a3 — drawc.cpp (THE PRIM PRIZE ROUTE) — RECEIPTS

Base `main@6a43ac79`, branch `w46-a3`, worktree `C:/Temp/nfs4-wt46-a3`.
All numbers re-gated from the worktree root with `tools/verify_asm.py`
(worklist numbers not used).

## LEDGER

| fn | re-gated base | final | insns (ours/oracle) |
|---|---|---|---|
| `DrawC_ShowroomPrims` | 4 | **PASS** | 297/297 |
| `DrawC_NightHeadlight` | 36 | **4** | 107/107 (count-exact) |
| `DrawC_PrimMenu` | 95 | **58** | 486/480 |
| `DrawC_PrimStart` | 86 | **70** | 976/976 (count-exact) |
| `DrawC_PrimHalo` | 29 | 29 (parked) | 295/298 |
| `DrawC_Prim` | 746 | 746 (parked) | 1403/1389 |
| `DrawC_PrimClip` | 857 | 857 (parked) | 1892/1877 |

Full-TU gate after every landed edit: **12 PASS** (was 11), zero regressions.

---

## 1. `DrawC_PrimMenu` — the 3-cycle SOLVED (95 -> 58)

### The required-delta receipt (tools/allocsim.py, MATCH 43/43 on this fn)

Pseudo identification (`tools/pseudoid.py`):

| pseudo | RTL def | source | ours | retail |
|---|---|---|---|---|
| p146 | `zero_extend(mem:QI (p145+3))` | `id0` | `$a1` | **`$t2`** |
| p147 | `zero_extend(mem:QI (p145+4))` | `id1` | `$t1` | `$t1` |
| p148 | `zero_extend(mem:QI (p145+5))` | `id2` | `$t2` | **`$a2`** |
| p144 | `ashiftrt(p177,16)` | `overlayFlag` | `$a2` | **`$a1`** |
| p205 | `mem:QI (p146+214)` | envmap `u0` | `$v0` | `$t4` |
| p206 | `mem:QI (p146+215)` | envmap `v0` | **`$a1`** | `$t5` |

Base priority table (`floor_log2(refs)*refs/live`):

```
 4: p205  v0  refs=12 live=12  3.0000
 5: p206  a1  refs=12 live=14  2.5714   <-- STEALS $a1 from overlayFlag
11: p144  a2  refs=29 live=64  1.8125   <-- overlayFlag, wants $a1
25: p146  a1  refs=18 live=91   .7912   <-- id0
27: p147  t1  refs=18 live=98   .7346   <-- id1
28: p148  t2  refs=18 live=101  .7128   <-- id2
```

**TWO INDEPENDENT REQUIRED DELTAS** (both verified by `--what-if`, then in the
real compiler):

* **PART 1 — p206 must rank BELOW all three ids** (pri < .7128), i.e.
  `refs 12 -> <= 4` **or** `live 14 -> >= 51`.  Demoting it only below p144
  (`live -> 20`, `refs -> 8`) is NOT enough: p206 then takes `$a2` and blocks
  id2.  `reqdelta` single-dial hits for the partial goal `p144=a1`:
  `p206 refs 12->1`, `p206 live 14->20`, `p144 refs 29->33`, `p144 live 64->34`.
* **PART 2 — the ids' priority order must REVERSE** (id2 > id1 > id0).  All
  three have refs 18, so the dial is the `floor_log2` REF-STEP:
  `id1 18->20` and `id2 18->22` gives `.7912 / .8163 / .8712`.
  Alternatives found by the pair search: `id0 live 91->>=99` + `id2 live
  101-><=89`; `id0 refs 18->16` + `id2 18->20`.

### What landed

* PART 2 = three `do { ... } while (0)` depth wrappers on `id1 += sd`,
  `id2 *= 8`, `id2 += sd`.  **Verified in the real `-dl` dump**: refs went
  18 -> 20 / 22 exactly as the model predicted (zero instructions).
* PART 1 = **merge the `u0`/`v0` envmap byte pair into ONE temp**, so there is
  only one uv global allocno and `$a1` stays free.
  Result: `allocsim` reproduces retail's handout EXACTLY
  (`overlayFlag $a1, id2 $a2, id1 $t1, id0 $t2`) and the diff is 95 -> 58.

### Residual 58 = the envmap uv block ONLY — NEW NAMED ANGLE

Ours is **+6 insns** (486 vs 480): the merged temp costs one load-delay `nop`
per byte, where retail keeps TWO values in flight (`$t4`/`$t5`) and pairs the
two `lbu`s.  Retail's whole uv group sits in `$t4-$t7`
(`t6 = ePmx0.u0+0x40`, `t7 = ePmx0.v0`, `t4/t5` = per-vertex) — i.e. all four
are handed out AFTER `$v0..$t3`.

**The exact bar for a second uv pseudo:** it must be a GLOBAL allocno with
pri < .7578 (below id0 in the merged basin) — with refs 12 that means
**live >= 48**.  Every shape that makes it a LOCAL qty loses, because
local_alloc runs first and hands it `$a1` before `global_alloc` ever sees
overlayFlag.

FALSIFIED at this basin (all measured, gate numbers in-source):
6 per-vertex temps 201 / 197 · v-only split 240 / 244 · in-place sums 95 / 97 ·
`do{}while(0)` on the gte load statements 97.

**NEXT ANGLE (untried, flagged by w46-a10 intel):** count the QTYs in the
envmap join block from `-dl`.  If it is a <=3-qty block, local-alloc.c:1588's
hand-rolled comparator applies and the dial is BIRTH ORDER / crossing the
3-to-4 qty boundary, not refs.  Also worth trying: software-pipelining the
v-load one vertex early (lengthens the second pseudo's live range past 48 at
zero insn cost but changes emission order — measure).

### Why retail's own numbers cannot be ours (recorded so it is not re-derived)

Retail's id refs/lives are provably identical to ours (same 9 references, same
instruction spacing — checked against the oracle `.s`), so retail's allocator
would also order id0,id1,id2 and hand id0 the LOWEST free register.  Retail
gives id0 `$t2`.  ⇒ retail's source carried EXTRA, CSE-FOLDED references to
id1/id2 (zero-instruction refs, the w44 inflator family) that our
transcription does not.  The `do{}while(0)` wrappers are a faithful stand-in
for whatever those were; finding the natural spelling is open.

---

## 2. `DrawC_ShowroomPrims` — 4 -> PASS

Two independent single-slot sched2 drain points, both cracked:

1. **Zero-insn fence, position IS the dial** (w45 fence grammar).  A bare
   `__asm__("" : : )` placed BETWEEN the three vt0 loads and the three vt0
   stores pins retail's x-before-y load order.
   Measured: before-block 4 · after-t1 14 · **HERE 2** · after-block 6 ·
   extra-t1-consumer 14 · pointer-local 4.
2. **`signed char m1 = -1;` declared BEFORE `index = 0x1f;`** so retail's
   `li v1,-1` precedes `li t0,31`.

🔴 **(2) is recorded FALSIFIED in the w45 in-source receipt.**  It only lands
AFTER (1) changes the basin — a clean, independent confirmation of the w45
LEVER-ORDER / BASIN-RELATIVE law.  Fences alone at four fill-loop positions:
all 2.  `m1` alone (pre-fence basin): the w45 receipt's 4.

---

## 3. `DrawC_NightHeadlight` — 36 -> 4 (count-exact)

The RGB tint block's 3-way sum/copy rotation. TWO edits, neither works alone:

* `__asm__("" : : )` in front of the three sums;
* `lp[N] + wc[N]` operand order at all three channels (each sum's dest becomes
  the first-loaded `lp` register, as retail: `lbu a0,0x68(sp); lbu v0,0(v1);
  addu a0,a0,v0`).

Measured ladder: wc-first + no fence **36** (the w45 basin) · lp-first + no
fence 38 · G-only lp-first 34 · B-only 36 · R-only 40 · fence-after-sums 32 ·
fence-before-sums + lp-first everywhere **4**.

The w45 "**G keeps both addends live**" angle is REAL — on its own it is
36 -> 24, and 24 -> 20 with R lp-first — but once the fence lands it is
**+6 WORSE** than the plain lp-first form (10 vs 4).  Second basin law hit.

**Residual 4 = ONE sched2 ready-list drain tie**: `addiu v0,v0,0` (the
`%lo` of `&Night_gWeatherColor[type]`) vs `lbu a0,104(sp)` (`lp[0]`).
FALSIFIED at this basin: decl swap, fence between the decls, fence before the
decls, a second fence, per-channel keep-alive blocks.
**NEXT ANGLE:** the a10 <=3-qty block law — count the block's qtys and try
crossing the 3-to-4 boundary with one extra/removed block-local.

---

## 4. `DrawC_PrimStart` — 86 -> 70 (count-exact 976/976)

**Variable identity, the ShowroomPrims lever transcribed.**  The
`signalLight[]` mirror index was carried in the Ghidra-invented fn-scope
`shadow_align_b`, which is REUSED for four unrelated values later in the
function; as one long-lived pseudo it out-ranked the address temp and took
`$a1` where retail has the index in `$a0` and the address in `$a1`.
A block-local `u_int mir` born and dead inside the region wins `$a0`.

Measured: block-local `u_int mir` **70** · block-local `int mir` 70 ·
a SECOND name for the xored value **88** (retail mutates one pseudo in place,
`xori a0,a0,1`) · four zero-insn fence positions around the block: all 86.

**Residual 70, NEW NAMED ANGLE:** the next visible cluster is `lb s0,124(s2)`
(ours, callee-saved) vs `lb a3,124(s2)` (retail, caller-saved) and
`sra s0,v0,16` vs `sra v0,v0,16` — i.e. a value we park in `$s0` that retail
keeps in a dying caller-saved temp.  Same variable-identity family: find which
Ghidra fn-scope name carries it and give it a block-local identity, then
re-run `allocsim`/`prio.py` on the fn (it has a large global allocno table).

---

## 5. `DrawC_PrimHalo` — 29, PARKED (ours 295 / oracle **298**, 3 SHORT)

Residual shape, ×3 identical sites (the `DrawC_gOverlay[...]` halfword decode):

```
retail:  lhu v0,0(v0)      <- loaded into the ADDRESS's own dying register
         nop               <- the load-delay nop we do not pay  (x3 = the 3 short)
         sll a0,v0,16      <- widened into a FRESH register
         sra v1,a0,16 / sra v1,a0,24   <- BOTH derived from that one shift
ours:    lhu v1,0(v0)
         sll v1,v1,16      <- in-place, then chained sra's
```

FALSIFIED this wave: an explicit fresh shift temp
(`u_int ov = ...; int ovs = (int)(ov << 16);`) at both sites **38**, at site 1
only **33**, fully inlined **38** — all of them make us 1 insn SHORTER still.

**NEW NAMED ANGLE:** the briefing's allocno route is right but the target is
the ANTI-DEPENDENCE, not the shift temp: retail loads the halfword into the
register that currently holds the ADDRESS (`lhu v0,0(v0)`), which is what
creates the hazard and forces the `nop`.  Ours picks a different destination,
so the hazard vanishes and we come out short.  So the dial is *who owns `$v0`
across this block*: dump `-dg`, find the pseudo that owns `$v0` at the overlay
load, and use the ref-step family to move the halfword temp ONTO it (a
zero-insn `ov = ov | (ov & 0);` re-mask, or a `do{}while(0)` around the
two-site block).  Do NOT keep spelling the shift differently — three spellings
are now falsified and all three go the wrong way on the count.

---

## 6. `DrawC_Prim` (746) / `DrawC_PrimClip` (857) — PARKED, route confirmed

`chunkdiff` on `Prim`: 14 mismatched runs, 200 insns, and the largest runs are
the SAME envmap tint blocks:

```
ours:   lbu v1,116(s1)  lbu a1,117(s1)  lbu v0,174(s1)  lbu a0,132(s1) ...
retail: lbu t6,116(s1)  lbu t7,117(s1)  lbu t5,132(s1)  lbu t4,174(s1) ...
```

i.e. **the identical `$t4-$t7`-vs-`$v0/$v1/$a0/$a1` class as PrimMenu's uv
block**, plus the head rotation (`prim` ours `$a2` / retail `$a1`, ids ours
`$t0-$t2` / retail `$t1,$t0,$a3`, facet retail `$a2`).

The in-source w44-a8 receipt already reached the same conclusion
("attack the ID/PRIM placement first and the tint band follows for free") and
this wave's PrimMenu work now supplies the MECHANISM and the instrument:

* Prim's allocsim table is 89 allocnos and reproduces 89/89.  The two id
  triples are `p356/p357/p358` (t0,t1,t2 — refs 14, lives 138/143/146) and
  `p600/p601/p602` (t2,t8,t9 — refs 14, lives 184/189/192): **the exact same
  "equal refs, ascending lives, ascending registers" signature as PrimMenu**.
* ⇒ the transcription is: (a) run `reqdelta --want` for the receipt's target
  handout (`prim=$a1, id0=$t1, id1=$t0, id2=$a3, facet=$a2`), (b) apply the
  `do{}while(0)` ref-step to the id-morph statements exactly as in PrimMenu,
  (c) merge/demote the tint byte pair the same way.
* Budget note: this was NOT started this wave — PrimMenu's PART 1 (the uv
  pseudo demotion) is still open, and landing the Prim/PrimClip transcription
  before it is solved would bake in the same +6-insn cost at 4 more sites.

---

## 7. TOOLS / PROCESS

Committed under `scratch/`:

* `try.py` / `tryset.py` — single- and multi-variant harnesses (apply edits,
  gate, restore in `finally`; anchor-count assertion; `newline=''` throughout
  because drawc.cpp is 100% CRLF).
* `probe.py` / `probe_s.py` / `probe_d.py` — apply a variant then dump
  `allocsim` / our own objdump / the full verify diff, and restore.
* `pm_search*.py` — the multi-pseudo `--what-if` searches that produced the
  PrimMenu required delta (`reqdelta.py` only does single-pseudo, single-dial
  and reported "no delta" for this 4-register goal).

Hazards that fired and were caught by the mandated checks:
* `reqdelta.py` with a 4-register `--want` runs > 120 s — background it.
* short anchors are NOT unique in drawc.cpp (`(sd->vt0).x = t1;` occurs 8×) —
  the harness asserts `count == 1` and refused three variants before they ran.
