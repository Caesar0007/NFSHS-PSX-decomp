# WAVE-48 a2 — syslib/psx/libgpu (SYS 31 + FONT 2 + P34 1)

Worktree `C:/Temp/nfs4-wt48-a2`, branch `w48-a2`, base `a12f7b8b`.
Gate = `python tools/verify_asm.py <file> <names>` from the worktree root.

---

## 0. RE-GATED BASELINE (2026-08-04, default flags — worklist fuzzy% ignored)

All 44 SYS.c oracles gated; 13 already PASS, 31 FAIL (= the worklist rows, confirmed).

| fn | diffs | ours/oracle |
|---|---|---|
| DrawOTag | 2 | 28/28 |
| _set_draw_mode | 5 | 9/8 |
| _get_gp1 | 5 | 6/5 |
| _gpu_arm_timeout | 5 | 12/13 |
| _que_ref | 6 | 9/9 |
| _send_gp1 | 8 | 9/9 |
| ClearImage | 8 | 36/36 |
| _install_drain_cb | 10 | 10/10 |
| _gpu_init_videomode | 11 | 39/40 |
| SetDispMask | 14 | 34/38 |
| _sync | 16 | 79/79 |
| DrawOTag2 | 19 | 54/63 |
| _set_clip_tl | 24 | 38/38 |
| _set_clip_br | 24 | 38/38 |
| ClearOTagR | 25 | 42/43 |
| PutDrawEnv | 26 | 48/48 |
| MoveImage | 27 | 45/46 |
| _clearOTagR_dma | 36 | 54/56 |
| _get_tw | 40 | 24/32 |
| _gpu_check_timeout | 42 | 77/81 |
| _reset | 61 | 79/84 |
| _image | 62 | 69/71 |
| ResetGraph | 73 | 88/93 |
| _gpu_que_drain | 85 | 127/152 |
| _dws | 99 | 136/143 |
| _drs | 102 | 152/160 |
| SetDrawEnv | 128 | 116/126 |
| _gpu_que_push | 150 | 162/172 |
| _set_drawenv | 179 | 133/156 |
| _BlitClear | 205 | 129/140 |
| PutDispEnv | 460 | 282/318 |
| **SYS total** | **1957** | |
| FONT FntFlush | 272 | 211/199 |
| FONT FntPrint | 92 | 238/240 |
| P34 SetDrawMove | 13 | 25/24 |

---

## 1. 🏆 FLAG-IDENTITY FINDING (for a9/consolidator) — SYS.OBJ + FONT.OBJ were built **`-mno-split-addresses`**

**build.py kept REPORT-ONLY per the w48 briefing: probe applied in-place, measured 2x, REVERTED.
Recommend the consolidator wire it.**

### Oracle-side proof (independent of the gate numbers)
Two SYS functions show the *assembler indexed-macro* address form that CC1PSX only emits with
split-addresses OFF (methodology §3.25 / build.py's own `no_split_addresses` docstring):

* `_get_gp1` oracle: `lui $v0,%hi(_gp1_shadow); addu $v0,$v0,$a0; lbu $v0,%lo(_gp1_shadow)($v0)`
  = the 3-insn expansion of `lbu $2,_gp1_shadow($4)`.
  Ours (split ON): `lui $v0,%hi; addiu $v0,$v0,%lo; addu $a0,$a0,$v0; lbu $v0,0($a0)` — 4 insns.
* `_send_gp1` oracle: `lui $at,%hi(sym); addu $at,$at,$v0; sb $a0,%lo(sym)($at)`
  = the `$at` STORE macro (the value register cannot be clobbered).

### Gate receipts (whole TU, both runs identical)
* **SYS.c: 1957 → 1743 diffs (−214), +1 PASS (MoveImage 27 → PASS 46/46), ZERO PASS→FAIL.**
  All 13 previously-PASSing fns re-gated PASS under the flag (SetTexWindow, SetDrawArea,
  SetDrawStp, SetDrawMode, DrawSync, LoadImage, StoreImage, _get_status, _send_gp0,
  _gpu_dma_chain, _get_gpuinfo, _memset, _set_draw_offset).
  Biggest movers: ResetGraph 73→44 · _gpu_que_push 150→103 · _image 62→46 · _drs 102→87 ·
  _dws 99→85 · _set_drawenv 179→165 · PutDispEnv 460→438 · SetDrawEnv 128→120 · DrawOTag2 19→12 ·
  PutDrawEnv 26→18 · SetDispMask 14→8 · _send_gp1 8→3 · _install_drain_cb 10→6 ·
  _gpu_check_timeout 42→38 · _reset 61→55.
  Counter-moves (all still FAIL, none PASS→FAIL): _set_clip_tl/_set_clip_br 24→29 each,
  _BlitClear 205→210, _get_gp1 5→6 (but insn count becomes EXACT 5/5 — the residual flips
  from a structural 4-vs-3 address form to a pure register pick), _get_tw 40→40.
* **FONT.c (must keep its existing `jtbl_at_fusion` key — same dict entry, duplicate-key hazard):
  FntFlush 272→250, FntPrint 92→80 (−34); FONT.c has only these 2 oracles, so no collateral.**
* **P34.c: SetDrawMove 13→13 (INERT) — do not wire P34.**

### Recommended wiring
```python
"recon/syslib/psx/libgpu/SYS.c":  {"no_split_addresses": True},
"recon/syslib/psx/libgpu/FONT.c": {"jtbl_at_fusion": True, "no_split_addresses": True},
```
w47 IDENTITY BAR check: exact-count conversions + a FAIL→PASS conversion + zero regressions ⇒
identity, not a nudge. (MoveImage lands count-exact 46/46; _get_gp1 becomes count-exact 5/5.)

---

## 2. FALSIFIED FLAG PROBES on SYS.c (numbers, for a9's ledger)

* **`-fno-schedule-insns2` — FALSIFIED (6 PASS→FAIL).** It DOES fix the prologue order
  (`subu sp; sw $31,16(sp); move $7,$6` = the oracle's `addiu sp,-0x18; sw ra; addu a3,a2,zero`),
  and improves _que_ref 6→4, _gpu_arm_timeout 5→4, _install_drain_cb 10→8, _reset 61→53,
  _set_drawenv 179→150, _BlitClear 205→191 — but it REGRESSES SetTexWindow, SetDrawArea,
  SetDrawMode, DrawSync, LoadImage, StoreImage from PASS to FAIL (6, 7, 12, 9, 8, 8) and
  ClearImage 8→22, ClearOTagR 25→36, MoveImage 27→35, DrawOTag 2→15, DrawOTag2 19→28.
  Fails the identity bar decisively. Do not wire.

* **`-fno-delayed-branch` — already TRIED+REVERTED for SYS.c in w25-a7** (build.py's
  PER_FN_NO_DELAYED_BRANCH comment block). **NEW 04C-relevant measurement (cc1 `.s` level,
  no build.py change):** the SYS epilogue fill IS `flag_delayed_branch`-controlled —
  `-fno-delayed-branch` turns our `j $31 / addu $sp,$sp,24` (filled, inside cc1's own
  `.set noreorder/.set nomacro` block) into the oracle's `addu $sp,$sp,24 / j $31` order.
  But the SAME flag also empties the `jal` slot, which the ORACLE has filled
  (`jal _gpu_que_push ; addu $a2,$zero,$zero`). **So SYS.OBJ's retail state is
  "jal slot filled + return slot NOT filled", which no single cc1 flag reaches.**
  Combined with the 04C verdict (real ASPSX does not backward-fill jal slots), the two
  candidate explanations left are (a) an SN-specific cc1 switch not in a10's option list, or
  (b) a gcc-2.8 `mips.c function_epilogue` condition we have not identified. **Handing to a9/a10.**
  Full evidence: cc1 `.s` regions for `_que_ref` under `{}, -fno-delayed-branch,
  -fno-schedule-insns2, -fno-delayed-branch -fno-schedule-insns2, }` — see §2a below.
  (`-mno-gas` is NOT accepted by CC1PSX: "Invalid option `no-gas'".)

### 2a. `_que_ref` cc1 `.s` matrix (oracle for comparison at the bottom)
```
default          : subu sp,24 / move $7,$6 / sw $31,16(sp) / [nore]jal;move $6,$0 /
                   lw $31,16(sp) / [nore]j $31;addu sp,sp,24
-fno-sched-insns2: subu sp,24 / sw $31,16(sp) / move $7,$6 / [nore]jal;move $6,$0 /
                   lw $31,16(sp) / [nore]j $31;addu sp,sp,24      <-- prologue now ORACLE
-fno-delayed-br  : subu sp,24 / move $7,$6 / move $6,$0 / sw $31,16(sp) / jal / lw $31 /
                   addu sp,sp,24 / j $31                          <-- epilogue now ORACLE
both             : subu sp,24 / sw $31,16(sp) / move $7,$6 / move $6,$0 / jal / lw $31 /
                   addu sp,sp,24 / j $31                          <-- prologue+epilogue ORACLE,
                                                                      jal slot EMPTY (oracle fills it)
ORACLE           : addiu sp,-0x18 / sw ra,0x10(sp) / addu a3,a2,zero / jal;addu a2,zero,zero /
                   lw ra,0x10(sp) / addiu sp,0x18 / jr ra ; nop
```

---

## 3. PER-FUNCTION WORK (default basin unless stated)

### DrawOTag — 2 diffs (28/28). OLD FLOOR NOTE REFUTED IN PART; new angle, not landed.
In-source note (and methodology §3.25-3b) called this "old-gcc no-copy-prop, not source-reachable":
oracle materializes both trailing zero args independently (`addu a2,zero,zero` …
`addu a3,zero,zero`), ours copies (`addu a3,a2,zero`).
**The w47 OPACITY/IDENTITY FENCE `__asm__("" : "=r"(x) : "0"(x))` DOES break the copy** — so the
"not source-reachable" half of that verdict is wrong. Measured (all reverted, baseline restored):
* fence on the 4th arg (`extra`): 2 → **6** (copy gone; a3 materialized FIRST, before the a1 copy)
* fence on the 3rd arg (`n`):     2 → **4** (copy gone; a2 pinned before the a1 copy)
* fence on `p=ot` **and** `n`:    2 → **3**, count 29/28 — everything aligns except the fenced
  `addu a2,zero,zero` sits one slot early and leaves the oracle's load-delay `nop` unfilled:
  ```
    ours: addu a2,zero,zero | addu a1,s0,zero | lui v0 | lw v0,0(v0) | NOP        | lw a0,24(v0) ...
  oracle:                     addu a1,s0,zero | lui v0 | lw v0,0(v0) | addu a2,0,0| lw a0,24(v0) ...
  ```
**NAMED ANGLE (open):** the fence is a POSITION PIN (w45 law), so it cannot deliver an opaque 0
*without* fixing where the 0 is materialized. What is needed is a **zero-insn opaque-constant
device that is schedulable** (so sched2 can sink it into the `lw v0,0(v0)` load-delay slot).
Candidates not yet tried: a non-`asm` opacity source (a `volatile`-free but cse-opaque expression),
or landing it in the `-mno-split-addresses` basin where the surrounding address form changes.
Baseline (2 diffs, count-exact) kept; count must stay exact.

### _get_tw — 40 diffs -> **PASS** (32/32)  [LANDED]
Three cooperating levers (full rationale now in the source comment):
1. **`int m[4]` local array, not four `int` scalars.** gcc-2.8 has no SRA, so every element
   assignment writes the stack home while cse forwards the stored value to the reader — that IS
   the oracle's four "dead" `sw 0/4/8/0xC(sp)` and the missing 8 instructions (ours was 24/32).
   Slot order proves the shape: 0=m[0] 4=m[1] 8=m[2] 0xC=m[3].
2. **Single-exit `ret` funnel with the NULL case as the `if` BODY** (`if (tw==0) ret=0; else {...}`)
   -> the oracle's `bnez $a0,body` + fall-through `j end; addu v0,0,0` + shared `jr ra; addiu sp`.
3. **OR-term order: `m[1]<<15` BEFORE `m[0]<<10`** (commutative; decides which shifted value's
   register the constant folds into = which pseudo becomes the accumulator).
   Six-order sweep, all count-exact 32/32: C,B,A,D,E = **PASS**; C,A,B,D,E = 10; C,A,B,E,D = 28;
   A,C,B,E,D = 28; C,E,A,B,D = 39; A,B,D,E,C = 55 (33 insns).
FLOOR-HYGIENE: the in-source note calling this a "register-pressure spill FLOOR ... not reachable
from source restructuring alone" was WRONG — it listed only 2 falsified angles, both tried WITHOUT
the array shape (a basin-relative falsification).

### _set_draw_mode — 5 -> 2 diffs, count-exact 8/8  [LANDED]
`lo = tpage & 0x9ff` must be written AFTER the `dtd` block: dbr's backward scan then takes the
`andi` as the `dfe`-`beqz` delay-slot fill (ours had hoisted it to the top and nop'd the slot).
The old note's "hi-first order = wrong coloring" verdict was basin-stale.
RESIDUAL 2 = the final `or $v0,$v1,$v0` operand order (ours `or $v0,$v0,$v1`), **invariant across
11 spellings, all count-exact 8/8**: lo|=hi, fresh result var, decl-order lo-first, separate `hi=`
assignment, `hi = dtd ? .. : ..` ternary, int-typed lo, int-typed lo+hi (all 2); `return hi|lo` in
any decl order (10, recolors lo into $a2).
=> RTL commutative-operand canonicalization = the w41 find_reg cost-pass model boundary.

### ClearImage — 8 diffs, count-exact 36/36. NAMED ANGLE (not landed).
Residual = the `b` PARM COPY position: the oracle sinks `addu $s0,$a3,$zero` into the `_image`
jal delay slot and hoists the `lui/addiu $a0` string address + `addu $a1,$s3,$zero` up to right
after the first parm copy; ours emits all four parm copies first.
FALSIFIED (all count-exact 36/36 unless noted): colour expression inlined into the call arg (8),
colour computed BEFORE `_image` (38, 30 insns), r|g<<8|b<<16 term order (24), split
`color = ..; color |= r&0xff` (8), opacity fence on `b` before `_image` (10), after `_image` (8),
fence on `r` (14). => sched2 parm-copy sink (w46 park class); w47-a1's "fence pins the parm copy"
works in the PIN direction, not the SINK direction. Next: allocsim/reqdelta on `b` vs `rect`.

### _gpu_init_videomode — 11 diffs (39/40). NAMED ANGLE (not landed).
The oracle is a SINGLE-EXIT funnel: each arm sets `$v0` DIRECTLY and `j`s to a shared
`jr ra; nop`; ours emits a separate `jr ra` per arm (1 insn short).
A `int ret; ... return ret;` funnel reaches **count-exact 40/40** but parks `ret` in `$a1` with an
`addu $v0,$a1,$zero` copy at every exit -> 28 diffs (worse LCS, better structure). Three orderings
measured: ret-before-dummy-read 28, ret-after 28, inverted `(mode&8)!=0` arms 30 (42 insns).
=> the funnel-vs-direct-return `$v0` reservation problem (catalog A: "return-literals expand
straight into the return reg; EVERY funnel form = a copy"). Needed: arms that write `$v0` directly
AND still share one epilogue — i.e. let cross-jump merge the three `jr ra`s rather than a source
funnel. Baseline (direct returns, 11) kept.

### P34 SetDrawMove — 13 diffs (25/24). NAMED ANGLE (not landed).
The oracle copies `p` into `$t0` as insn 1 and gives `len` the freed `$a0`; ours keeps `p` in
`$a0` and puts `len` in `$t1` — an exact `$a0`<->`$t0` role swap plus one `sb`/`lw` schedule slot.
**A count-EXACT base now exists**: declaring `int *w;` and assigning `w = (int *)p;` only AFTER
the len computation gives 24/24 at 20 diffs (baseline is 25/24 at 13) — its residual is *purely*
the register swap, which is the right shape to hand to allocsim/reqdelta.
FALSIFIED: w-late with all stores through `w` (20, 24/24), opacity fence on `p` at top (21,
25/24), fence on `w` after the assignment (24, 26/24), fence on `len` (22, 24/24), separate
`unsigned char *q` for the byte store (20, 24/24), `len` declared first (13, 25/24).
Kept the 13-diff baseline; the 24/24 w-late form is documented here as the better START basin.

### _sync — 16 diffs, count-exact 79/79. Observation only.
The whole residual is ONE 8-instruction block (the `D2_CHCR`/`GPU_GP1` poll) appearing at a
different position: the oracle emits the `lui/lw/nop/lw/lui 0x0400/and/bnez` group ~8 slots
earlier than we do. Suspect the `||` operand order in the poll loop
(`(*D2_CHCR & 0x01000000) != 0 || (*GPU_GP1 & 0x04000000) == 0`) — but swapping it CHANGES which
volatile MMIO read happens first, so it needs raw-oracle semantic adjudication before being tried
(per-mutation semantic review rule). Not touched.

---

## 4. FUNCTIONS BLOCKED ON THE FLAG (address-form dominated) — do not grind in the default basin

`_set_clip_tl`/`_set_clip_br`, `_BlitClear`, `_dws`, `_drs`, `_set_drawenv`, `SetDrawEnv`,
`PutDispEnv`, `PutDrawEnv`, `SetDispMask`, `_image`, `ResetGraph`, `_gpu_que_push`,
`_gpu_que_drain`, `_reset`, `_get_gp1`, `_send_gp1`, `DrawOTag2`, `_gpu_check_timeout`.

Evidence (`_set_clip_tl`, representative): the oracle materializes EVERY GEnv field access with
its own fused self-temp `lui $r,%hi(D_801236A0); lh $r,%lo(D_801236A0)($r)` — TWICE for the SAME
field inside one basic block (the signed `lh` read and the unsigned `lhu` read are different MEMs,
so cse cannot merge them). Ours CSE-hoists ONE `la $a3,GEnv` base and uses `lh $v0,4($a3)` /
`lhu $v0,4($a3)` displacements. That is exactly the split-addresses ON-vs-OFF divergence: with
`-mno-split-addresses` cc1 emits the `lh $2,GEnv+4` assembler macro, which maspsx/GNU-as expand to
the oracle's fused per-access self-temp form.
WARNING: the in-source GEnv struct comment ("modeled as a real struct so multi-field accesses
share ONE `lui %hi(GEnv)` base ... matching the oracle's addressing") is FACTUALLY WRONG — a
survey of all 17 GEnv-referencing oracles found ZERO shared-base accesses; every field access
re-materializes its own address. The struct model is still RIGHT for the DATA (ResetGraph clears
the whole 0x80 block with one `_memset`); it is the ADDRESSING that needs the flag, not per-field
scalars (per-element duals would be the w39 alias BUG CLASS).

---

## 5. HANDOFF

* **a9 / consolidator:** wire `no_split_addresses` for `recon/syslib/psx/libgpu/SYS.c` and
  `recon/syslib/psx/libgpu/FONT.c` (FONT keeps its existing `jtbl_at_fusion` in the SAME dict
  entry — duplicate-key hazard). Do NOT wire P34.c (inert). Expected: SYS +1 PASS / -214 diffs,
  FONT -34 diffs, zero regressions. Then RE-GATE this TU: the section-4 list becomes workable and
  several of those are probably one lever from PASS.
* **a9 / a10:** the SYS epilogue signature (jal slot FILLED + return slot NOT filled + `sw ra`
  before the parm copies) is not reachable by any single cc1 flag found here;
  `-fno-delayed-branch` gets the epilogue and loses the jal fill, `-fno-schedule-insns2` gets the
  prologue order and costs 6 PASSes. Affects `_que_ref` (6), `_gpu_arm_timeout` (5),
  `_install_drain_cb` (10) and the prologue half of most of the TU. Evidence in sections 2/2a.
* **NO-FLOORS bookkeeping:** two in-source floor notes refuted this session (`_get_tw`
  "register-pressure spill floor" -> PASS; `_set_draw_mode` "hi-first = wrong coloring" -> that
  IS the winning lever). Both were WEAK-form (single untested assertion / basin-relative
  falsification).
