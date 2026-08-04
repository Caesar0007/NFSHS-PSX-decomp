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
