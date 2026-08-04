# WAVE-48 agent a8 — syslib math/gte/libc/libpress receipts

Worktree `C:/Temp/nfs4-wt48-a8`, branch `w48-a8`, base `a12f7b8b`.
Gate = `python tools/verify_asm.py <file> <names>` from the worktree root (sole authority).
Helper: `scratch/w48_a8_gate.py <unit>...` (whole-TU gate from MATCH_PROGRESS fn lists),
`scratch/w48_a8_probe.py <unit>...` (per-TU flag probe, patch-in-place + `finally` restore).

---

## 0. RE-GATED BASELINES (2026-08-04, on the w48-a8 tree at base)

The worklist fuzzy% was, once again, wrong on essentially every row (e.g. `_patch_gte_handler_1`
"0.00%" is actually **NOT IN OBJECT**; `RotMatrix` "24.62%" is a 261-diff far-miss; `memmove`
"97.78%" is a 2-diff count-exact near-miss). All numbers below are gate numbers.

| unit | fn | baseline (gate) |
|---|---|---|
| libmath/FLTSIDF | `__floatsidf` | FAIL 50 (64/64) |
| libmath/LTDF2 | `__ltdf2` | FAIL 39 (54/55) |
| libmath/GTDF2 | `__gtdf2` | FAIL 54 (55/53) |
| libmath/MULSF3 | `__mulsf3` | FAIL 94 (76/80) |
| libmath/FIXSFSI | `__fixsfsi` | FAIL 12 (43/45) |
| libmath/EXTSFDF2 | `__extendsfdf2` | FAIL 69 (86/87) |
| libmath/TRUDFSF2 | `__truncdfsf2` | FAIL 109 (71/76) |
| libmath/ADDDF3 | `__adddf3` | FAIL 377 (230/221) |
| libmath/DIVDF3 | `__divdf3` | FAIL 305 (171/184) |
| libmath/DIVDF3 | `_comp_mant` | PASS (not on worklist) |
| libmath/FLTSISF | `__floatsisf` | FAIL 38 (43/45) |
| libmath/MULDF3 | `__muldf3` | FAIL 326 (189/197) |
| libmath/MULDF3 | `_mul_mant_d` | FAIL 95 (66/59) |
| libmath/DIVSF3 | `__divsf3` | FAIL 107 (78/81) |
| libmath/FIXDFSI | `__fixdfsi` | FAIL 80 (57/63) |
| libmath/FERR | `_err_math` | FAIL 2 (25/25) |
| libgte/COR_01 | `csincos` | FAIL 76 (73/71) |
| libgte/COR_02 | `ccos` | FAIL 12 (43/49) |
| libgte/COR_03 | `csin` | FAIL 85 (59/78) |
| libgte/FGO_01 | `RotMatrix` | FAIL 261 (146/163) |
| libgte/FGO_06 | `RotMatrixZ` | FAIL 166 (90/102) |
| libgte/FOG_01 | `SetFogNear` | FAIL 4 (25/25) |
| libgte/PATCHGTE | `_patch_gte_handler_1` | **NOT IN OBJECT** |
| libc/SPRINTF | `sprintf` | FAIL 174 (547/545) |
| libc/QSORT | `qsort` | FAIL 70 (84/84) |
| libc/MEMMOVE | `memmove` | FAIL 2 (27/27) |
| libc/MEMCMP | `memcmp` | FAIL 6 (17/19) |
| libc/BSEARCH | `bsearch` | FAIL 26 (48/48) |
| libds/DSCB | `DsReadyCallback` | FAIL 9 (6/5) |
| libds/DSCB | `DsDataCallback` | FAIL 6 (9/9) |
| libcard/CARDINIT | `StartCARD` | FAIL 4 (14/14) |
| libpress/LIBPRESS | `DecDCTin` | FAIL 4 (31/31) |
| libpress/LIBPRESS | `DecDCTinSync` | FAIL 6 (15/15) |
| libpress/LIBPRESS | `DecDCToutCallback` | FAIL 6 (9/9) |
| libpress/LIBPRESS | `MDEC_rest` | FAIL 28 (62/60) |
| libpress/LIBPRESS | `MDEC_in_sync` | FAIL 18 (37/37) |
| libpress/LIBPRESS | `MDEC_out_sync` | FAIL 18 (37/37) |
| libpress/LIBPRESS | `MDEC_status` | FAIL 2 (31/31) |

---

## 1. 🏆🏆 THE "aspsx SHARES ONE `la` BASE" FLOOR IS **FALSIFIED** — it is a COMPILER axis
### (`-mno-split-addresses` + a pointer local), proven against the REAL ASPSX 2.77

**The standing catalog claim** (§I-addendum SCOPE REFINEMENT, w30; quoted for `MemCardCallback` /
`DsReadyCallback` / the libmcrd `funcEvSp*` class): *"GNU-as expands each access independently
(self-temp-load + `$at`-store) while **aspsx-2.77 shares ONE `la` base across consecutive
same-symbol accesses** → `lui v1;addiu v1;lw v0,0(v1);sw a0,0(v1)`. So a 2-access (read+write)
absolute global is an assembler-expansion floor."*

**Real-ASPSX differential run (04C law, my own, independent of a10):**
`scratch/w48_a8_aspsx_t1.s` / `w48_a8_t2.s` fed to `C:/Temp/psq43/PSSN/ASPSX.EXE` (v2.77, CRLF
input mandatory — LF gives `Illegal character '\n'`), object decoded by hand:

```
input  (exactly what cc1 emits for the plain scalar):     produced by REAL ASPSX 2.77:
        lw   $2,ds_ready_cb                                  3c020000   lui  $2,%hi
        sw   $4,ds_ready_cb                                  8c420000   lw   $2,%lo($2)
        j    $31                                             3c010000   lui  $at,%hi
                                                             ac240000   sw   $4,%lo($at)
                                                             03e00008   jr   $ra
                                                             00000000   nop
```

⇒ **real ASPSX expands each access INDEPENDENTLY, byte-for-byte the same shape as GNU-as/maspsx.
It does NOT share an `la` base.** The catalog row's premise is dead.

**Where the oracle's shape actually comes from** (cc1 variant matrix, `scratch/w48_a8_dstest.c`,
7 declaration shapes × 4 flag settings, raw CC1PSX):

| source shape | `-G4` | `-G0` | `-G4 -mno-split-addresses` | `-G0 -mno-split-addresses` |
|---|---|---|---|---|
| plain scalar `G` | macro `lw $2,G` | `lui;lw %lo` | macro | macro |
| **pointer local `T *p=&G`** | macro | `lui;lw %lo` | macro | **`la $3,G; lw 0($3); sw 0($3)`** |
| unsized view `G_v[]` + `[0]` | `lui;lw %lo` | `lui;lw %lo` | **`la $3,G; …0($3)`** | **`la …`** |
| sized `[1]` view | macro | `lui;lw %lo` | macro | **`la …`** |

The oracle wants the **`la` form** = `(set reg (lo_sum (high sym) sym))` kept as a REGISTER VALUE.
Two independent conditions are needed and BOTH must hold:
1. the address must be written as a real **pointer local** (or an array-decay view) — otherwise the
   MEM eats the symbol directly; and
2. **`TARGET_SPLIT_ADDRESSES` must be OFF** (`-mno-split-addresses`) — with it ON, gcc lowers the
   pointer to `(high)` + folds the `lo_sum` back into both MEMs (`lui;lw %lo(sym)(r);sw %lo(sym)(r)`,
   1 insn SHORT of the oracle).

### RESULT — `DsReadyCallback` **PASS (5/5 insns), pin-free, natural C**
`recon/syslib/psx/libds/DSCB.c` rewritten to the pointer-local form (landed), with the TU flags
`{"g_value": "0", "no_split_addresses": True, "no_schedule_insns2": True}` (probe-measured,
**for the consolidator to wire** — build.py is report-only for me).

### CROSS-WAVE CONSEQUENCE (hand to a1 / a10 / the catalog)
Every fn whose residual was filed as *"oracle shares an `la` base / assembler-expansion floor"* is
**re-openable as a `-mno-split-addresses` + pointer-local question**. Named candidates from the
catalog's own row: libmcrd `BIOS.cpp funcEvSp*` (×8), `MemCardCallback`, `USERFUNC::UserFuncInit`,
and the `SetVideoMode` INVERSE case. The catalog row (§I-addendum, "RULE: … a read+write pair =
leave it (assembler floor)") must be retracted.

---

## 2. DSCB — whole-TU ledger

| fn | baseline | landed source | + probed TU flags | class of residual |
|---|---|---|---|---|
| `DsReadyCallback` | 9 (6/5) | 9 (neutral) | **PASS (5/5)** | — |
| `DsDataCallback`  | 6 (9/9) | 6 (9/9)      | **4 (9/9)**     | epilogue swap |

`-fno-schedule-insns2` fixes the prologue order (`sw ra` before the `a1=func` copy).
Remaining 4 = the canonical epilogue-swap signature: ours `lw ra; nop; jr ra; addiu sp` vs oracle
`lw ra; addiu sp; jr ra; nop`.

**Real-ASPSX evidence on the epilogue-swap class (independent reconfirmation of the 04C law):**
`scratch/w48_a8_t3.s` — a `.set reorder` block `…; li $4,3; jal DMACallback; lw $31,16($sp);
addu $sp,$sp,24; j $31` through real ASPSX 2.77 gives:
`addiu sp,-24 / addu a1,a0,zero / sw ra,16(sp) / addiu a0,zero,3 / jal / **nop** / lw ra / addiu sp
/ jr ra / nop`.
⇒ ASPSX **does NOT backward-fill the jal delay slot** (04C confirmed a 2nd time, different
instrument), but it DOES leave the epilogue as `lw ra; addiu sp; jr ra; nop` — i.e. exactly the
oracle's epilogue. So the oracle's fn = **jal slot filled by cc1 (delayed-branch ON) + return slot
NOT filled by cc1**. `-fno-delayed-branch` (per-fn splice, tested) gives the epilogue but LOSES the
jal fill (10 insns, 5 diffs) — the two halves cannot be expressed by one cc1 setting. Named angle,
not a floor: a per-BRANCH (not per-function) delayed-branch expression, or a cc1 generation whose
`dbr_schedule` declines the `return` slot. Routed to a3/a9/a10 (epilogue-swap class owners).

---

## 3. FLAG-AXIS RECEIPTS FOR a9 (report-only probes; build.py restored every time)

`scratch/w48_a8_probe.py` — 8 settings × whole-TU gate. **The briefing's prior that libmath is a
`-fno-delayed-branch` class object is FALSIFIED: the flag is strictly WORSE on every libmath TU
probed, and adds instructions (not the "Sony built the libs with it off" signature at all).**

| TU | baseline | -fno-delayed-branch | -fno-sched-insns | -fno-sched-insns2 | -G0 | -G8 | -mno-split | -fno-strength-reduce |
|---|---|---|---|---|---|---|---|---|
| libmath/MULSF3 | 94 (76) | **129 (87)** | 100 | 98 | 94 | 94 | 94 | 94 |
| libmath/FIXSFSI | 12 (43) | **28 (53)** | 28 (53) | 12 | 12 | 12 | 12 | 12 |
| libgte/COR_02 | 12 (43) | **26 (55)** | 26 (55) | 12 | 12 | 12 | 12 | 12 |
| libc/MEMCMP | 6 (17) | **10 (21)** | 10 (21) | 6 | 6 | 6 | 6 | 6 |
| libcard/CARDINIT | 4 | 3 (15/14) | 4 | 4 | 4 | 4 | 4 | 4 |
| libds/DSCB | 15 | 14 | 14 | 13 | **7** | 15 | 15 | 15 |

Reading: for the whole math/gte/libc band the `-O2` + delayed-branch-ON + scheduler-ON identity is
already correct; the only live per-TU axes found are `-G0`/`-mno-split-addresses` (address
materialization) and `-fno-schedule-insns2` (prologue order), both on **libds/DSCB only**.
