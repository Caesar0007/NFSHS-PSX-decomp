# W75-A10 report — newton + stats belt (NFS4-PSX matching decomp)

Repo `C:\Temp\nfs4-decomp`. Mandatory reads done in full (MIPS ISA ref, PSX→C++ methodology,
asm-pattern-catalog tail §18–§23, both target receipts). No git operations. Memory dir untouched.
No build.py rows added; `tools/build.py`'s foreign uncommitted edit preserved (never opened for write).

## Bottom line

| fn | TU | baseline | final | landed |
|---|---|---|---|---|
| `Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef` | game/common/newton | **23** @105/106 | **23** @105/106 | receipt only |
| `Stats_TrackEndGame__Fv` | game/common/stats | **12** @232/232 | **12** @232/232 | receipt only |

- **Neither sealed.** Both produced a NEW NAMED ANGLE with compiler-source-grounded mechanism.
- **ZERO PASS→FAIL.** Whole-TU gate run TWICE before and TWICE after the (comment-only) edits:
  `newton.cpp 31/32 PASS`, `stats.cpp 6/7 PASS` — identical every run.
- Only edits to the tree: the two `/* W75-A10 ... */` receipt blocks (comments; both TUs re-gated
  twice after, unchanged; CRLF preserved, ASCII-only, byte-mode write + size assert + `os.replace`).
- Every probe used a harness that restores the TU byte-for-byte (`scratchpad/w75/a10_probe.py`,
  `a10_sbs.py`), verified with `cmp` against untracked backups
  (`a10_newton_orig.bak`, `a10_stats_orig.bak`). Windows `TMPDIR/TMP/TEMP` set for every cc1 run.

---

## 1. Newton_DoPostBarrierCollisionHandling — THE KEYSTONE (c) IS SOLVED STRUCTURALLY

W74 left the fn at 23 with a mapped residual whose keystone (c) was "retail emits the normal.y
divide BETWEEN the x-quotient and barrierVec.z's shift/store … every spelling pays a REGISTER
ROTATION worth 6-14 diffs".

**New result: the structure is now reproduced EXACTLY** — retail's insns 19..30

```
addu a3,a1,zero / bgez a3 / addu vN,a3,zero [slot] / addiu vN,a3,255 /
sw zero,28(sp)  / sra <q>,vN,8 / addu v0,a2,zero / bgez a2 /
sll t3,<q>,8 [slot] / addiu v0,a2,255 / sw t3,32(sp) / sra a1,v0,8
```

appear in retail's ORDER **and with retail's BLOCK MEMBERSHIP** (barrierVec.y's store at the
x-divide JOIN, barrierVec.z's store at the y-divide JOIN, the `sll` backward-filled into the
y-divide's `bgez` slot) for the first time in 8 waves. Spelling (`scratchpad/w75/a10_r2.py`):

```c
nx = normal.x;  nxq = nx / 0x100;  __asm__("" : : "r"(nxq));
barrierVec.y = 0;  t3 = nxq * 0x100;
ny = normal.y;  nyq = ny / 0x100;  __asm__("" : : "r"(ny));
barrierVec.z = t3;
distRetreat = nxq*(lvx/0x100) + nyq*(lvy/0x100) + (nz2 = *(volatile int*)&normal.z)/0x100*(lvz/0x100);
```

### NEW LAW 1 — the DIVIDE-COPY LAW generalises to the second divide
W74 proved it for `nz` only. A named `ny` + a **read-only fence AFTER the divide statement** mints
the y-divide's `addu vN,a2,zero` copy — same mechanism, cited: `expmed.c:3026` always emits
`copy_to_mode_reg`; survival is decided by `local-alloc.c:470-477` (`reg_qty = -1` when
`REG_BASIC_BLOCK < 0`) and `combine_regs` bailing at `local-alloc.c:1866`. Measured worth:
**exactly 2 insns inside the split** (35 @103 without → 33 @105 with); on the shipped unsplit basin
the copy only replaces the `bgez a2` delay-slot `nop`, so it is 29 @105 (no count gain).

### NEW LAW 2 — the split basin's residual is ONE ALLOCNO SEAT, not structure
Retail seats the x-quotient in `$v1` and the x-divide temp in `$v0`; the temp **dies at**
`sra v1,v0,8`, so the y-divide's temp re-uses `$v0`. Ours colours the x-quotient `$a0`, which it
**shares with the dot's ACCUMULATOR** (`mult a0,v0` then `mflo a0`); that pushes the x-divide temp
off `$v0` and cascades into (i) the lvy-divide schedule (ours hoists `lw ..,176(s1)` above `mflo`,
eating retail's two `nop`s) and (ii) cluster (e), the accumulator seat. Adding the read-only fence on
`nxq` already fixes the temp onto retail's `$v0` (33 → 29); only the quotient seat is left.

### Measured this wave (all real gate runs, all restored)
```
split, statement-order sweep {nxq,bvy,t3,ny/nyq,bvz}      33 @105
  t3 before bvy 33 | t3 after the y-divide 33
  without the `ny` fence 35 @103 | plain `nyq=normal.y/0x100` (no carrier) 35 @103
split + read-only fence on nxq (+1 ref, zero insn)        29 @105   <- basin FLOOR
split + "r"(nxq)+"$4" 31 | +"$4","$5" 39 | +"$2" 29 | +"$8" 29
split + "$4" clobber at the dot 31 | "$4" clobber alone before the dot 31
split + void fence between t3 and the y-divide 31
split + volatile view on linearVel.y 29 | barrierVec.y after t3 29
`ny` + fence on the SHIPPED (unsplit) basin               29 @105
dot as `+=`: three statements 31 | two statements 23 (BIT-IDENTICAL to shipped)
  two statements + `__asm__("" : : "i"(0) : "$5")` 34 @106/106 (COUNT-EXACT, band rotates)
  + `"r"(distRetreat)`+"$5" 34 @106 | plain `"r"(distRetreat)` 29 | `"i"(0)`+"$4" 29
split + `+=` 29 | split + `+=` + "$5" 50 @106 | split + "$5" before the dot 31
```

**NOT LANDED** (hard-floor-basin rule: 29 > 23). Next angle, now structure-free: give the
x-quotient `$v1` while keeping the accumulator off it. Both are compiler temps at source level, so
the reachable instruments are (a) the `[reload_pick]`/qtytrace lane run **on the split basin's own
dump** (04Z — the cell table is basin-relative), or (b) a clobber whose live-range window ends
BEFORE `mflo` (22B-1 placement law); every whole-statement position measured above is either inert
or hits the accumulator too.

---

## 2. Stats_TrackEndGame — the W74 route run to its end; a QUANTIFIED BOUNDARY + a new law

W74 left 12 @232/232, residual = 4 instructions (the min's false arm RE-LOADS where retail COPIES),
route = "a base un-merge that is independent of the min statement".

### NEW DIAGNOSTIC — the six insns the volatile buys are now enumerated, not guessed
Removing the min's volatile gives 76 @226. Off the sbs:
```
-4  the abs arm's INDEX-FORM base rematerialization
    retail: addiu t5,t5,0 / addu v0,s6,t5 / lw v0,0(v0) / nop / lw v0,1056(v0)
    ours  : ONE  lw v0,1056(v1)   (re-uses the min's own element pointer)
-1  the min's SECOND store — without the volatile gcc uses the TARGET as the compare temp:
    lw s3,848(v1) / slt v0,a1,s3 / beqz / addu s3,a1,zero   (one load, one store, no copy)
    (sharpens W72-A13: it is not only the ARM that expands into the target, the COMPARE
     reads through it too)
-1  the `lui t5,0` retail parks in the `beq PlayerPosition==1` delay slot
```
…and the whole `s3/s4/s5/s6/s7/fp` band rotates with them (PlayerSlice stops spilling to 20(sp)).
So the volatile is not one of two carriers — it carries the entire basin.

### *** NEW LAW — why every alternative device stalls at the same 228 plateau
The volatile at the **sliceTotal USE SITE** is the only device that produces the abs arm's INDEX
form. A `"memory"` clobber or a volatile ELEMENT view does force the arm to RE-LOAD the element, but
it re-loads through the loop's **GIV WALKER** (`lw v0,0(s0)`), never through `(j<<2) + base`. Only an
unmovable volatile MEM at the min's use site stops loop.c strength-reducing that second address into
the walker — and only then does the 'm'-fence (21A-5) have a `%hi` pseudo to dial (which is exactly
why W74 measured the 'm'-fence "ineffective alone"). This retires the whole "find another un-merge
device" line of attack.

### Measured this wave (all real gate runs, all restored)
```
plain min                                                76 @226
plain-temp min                                           76 @226
plain-temp + "memory" clobber at the abs-arm head        78 @228
plain-temp + "memory" right after the min                65 @229
plain-temp + "memory" after the min, 'm'-fence deleted    79 @229
plain min + "memory" at the arm head + 'm'-fence         78 @228
plain min + volatile ELEMENT view in the abs arm         78 @228
plain min + both                                         78 @228
volatile ELEMENT view INSIDE the min (Car_tObj *car = *(Car_tObj *volatile*)&...)  78 @228
the same through a `Car_tObj *volatile *slot` local      78 @228
compare-read volatile + plain false arm                 100 @236
temp + 20B tied launder w/ "$23" / "$22" clobber          72 @226
temp + read-only fence w/ "$23"                           69 @227
temp + read-only fence w/ "$23","$22","$21","$20"        107 @227
```

### DEVICE-REMOVAL RE-TEST (23B-3, run as the brief asked)
Dropping the 'm'-fence from the shipped basin is W74's 93 @233; dropping the volatile is 76 @226.
**Neither device is redundant — both are load-bearing.** (Contrast HrzSetPsxMatrix/TimeSprites,
where removal was the seal.)

**Open ask, now singular:** force the ABS ARM's element address into the INDEX form while the min is
PLAIN. Cast-int spellings cannot (fold rebuilds the ARRAY_REF, W72-A13), so the lever is loop.c-side
— an index expression loop.c cannot strength-reduce (a non-BIV-derived index) — or the 06E
local-alloc/qtytrace lane run on the 228 dump.

---

## 3. Falsified angles (named, do not re-run)

**newton:** every split statement-order permutation (33); the split without the `ny` fence (35 @103);
`nyq` without an `ny` carrier (35 @103); `"$4"`/`"$4","$5"`/`"$2"`/`"$8"` clobbers on the nxq fence
(31/39/29/29); a `"$4"` clobber at the dot (31); a void fence between `t3` and the y-divide (31); a
volatile view on `linearVel.y` (29); the `+=` accumulation in all three forms (31 / 23-bit-identical /
50); the `"i"(0):"$5"` accumulator clobber (34 @106 count-exact but band-rotated).

**stats:** plain min and plain-temp min (76 @226); `"memory"` clobbers in four positions (65-79 @228-229);
volatile ELEMENT views on the min's element and on the abs arm's base, alone and stacked (78 @228);
`Car_tObj *volatile *slot` local (78 @228); compare-volatile + plain arm (100 @236); 20B tied launder
with `$s7`/`$s6` clobbers on a `sliceTot` temp (72 @226); read-only fences with 1 and 4 callee-saved
clobbers (69 @227 / 107 @227).

## 4. Artifacts
`scratchpad/w75/` — `a10_probe.py` (restoring gate harness), `a10_sbs.py` (restoring side-by-side),
`a10_{newton,stats}_orig.bak` (untracked backups), `a10_*_sbs.txt` (baseline + key basins),
`a10_{n1,n3,n5..n8,r1..r4,v1..v3,w1..w3,e1..e6,f1..f3,s1..s20}.py` (every measured variant, replayable),
`a10_receipts.py` (the comment-only patch that was applied).
