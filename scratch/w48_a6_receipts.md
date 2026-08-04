# WAVE-48 a6 — syslib/libcd part B receipts

Worktree `C:/Temp/nfs4-wt48-a6`, branch `w48-a6`, base `a12f7b8b`.
Gate = `python tools/verify_asm.py <file> <names>` from worktree root. Sole authority.

## 0. RE-GATED BASELINE (2026-08-04) — worklist %% wrong on multiple rows again

| fn | TU | worklist %% | GATED baseline | note |
|---|---|---|---|---|
| _read_sync | cdread.c | 95.31 | FAIL 4 (13/13) | count-exact |
| _read_int | cdread.c | 86.17 | FAIL 115 (156/157) | |
| _read_data_int | cdread.c | 92.98 | FAIL 7 (53/52) | ours +1 |
| _read_issue | cdread.c | 76.07 | FAIL 64 (120/122) | ours -2 |
| CdRead | cdread.c | 69.95 | FAIL 43 (94/103) | ours -9 |
| CdReadSync | cdread.c | 89.57 | FAIL 31 (66/65) | ours +1 |
| CdRead2 | cdread2.c | 90.30 | FAIL 5 (34/33) | ours +1 |
| StClearRing | stream.c | 85.00 | FAIL 5 (23/24) | ours -1 |
| StSetStream | stream.c | 63.18 | FAIL 18 (33/33) | count-exact |
| StSetRing | stream.c | 74.55 | FAIL 9 (12/11) | ours +1 |
| StCdInterrupt | stcdint.c | 90.62 | FAIL 214 (591/583) | |
| _st_dma | stcdint.c | 45.55 | FAIL 143 (91/106) | ours -15 |
| StUnSetRing | streamhelp.c | 91.25 | FAIL 9 (33/32) | ours +1 |
| StGetNext | streamhelp.c | **0.00** | FAIL 7 (47/46) | worklist 0%% = WRONG, real 7 |
| StFreeRing | streamhelp.c | 75.21 | FAIL 35 (42/43) | ours -1 |
| data_ready_callback | streamhelp.c | 70.00 | FAIL 21 (36/35) | ours +1 |
| StSetMask | streamhelp.c | 77.14 | FAIL 3 (8/7) | ours +1 |
| CdSearchFile | iso9660.c | 81.38 | FAIL 92 (166/182) | ours -16 |
| CD_newmedia | iso9660.c | 75.50 | FAIL 146 (171/177) | |
| _cd_find_path | iso9660.c | 89.95 | FAIL 15 (40/41) | ours -1 |
| CD_cachefile | iso9660.c | 85.05 | FAIL 99 (162/167) | |
| CD_Read | (iso9660) | **0.00** | **ALREADY PASS** | see §1 |

## 1. CD_Read — WORKLIST MIS-ATTRIBUTION, zero work (the predicted w45/03I class)

Worklist row 107 attributes `CD_Read @0x800FA678` to `syslib/psx/libcd/iso9660`. It is NOT
an iso9660 function at all:

- `configs/symbol_addrs.txt` has BOTH `CD_Read = 0x800FA678` and `cd_read = 0x800F9984`
  (two different functions, differing only in case). iso9660.c owns the lowercase
  `cd_read` @0x800F9984 (CdIntToPos/CdControl/CdRead/CdReadSync wrapper).
- `CD_Read.s` body references `Cdinfo`, `CD_timerfunc`, `timerhz`, `g_currentthread`,
  `blockmove`, `addtimer`, `deltimer`, `savegp`, `restoregp` — the EA eacpsxz CD file
  system, not PsyQ libcd.
- True owner = `recon/eaclib/psx/eacpsxz/cdfs.c:366` (and `src/eaclib/psx/eacpsxz/cdfs.c`
  carries its INCLUDE_ASM), sealed by w47-a5.

GATE PROOF: `verify_asm recon/eaclib/psx/eacpsxz/cdfs.c CD_Read` -> **PASS (163 insns)**.

=> The 0.00%% row is a worklist ATTRIBUTION defect, not a missing body. No edit needed.
   Same class as `StGetNext`'s bogus 0.00%% (real: 7 diffs). Flag for a9/consolidator:
   the worklist extractor attributes by name-lookalike, and case-differing duplicate
   names (`CD_Read` vs `cd_read`) collide in it.

## 2. LEVER LEDGER

(appended per lever)

## 3. FLAG AXIS — per-fn `-fno-delayed-branch` splice probe (build.py PATCHED-IN-PLACE, MEASURED, REVERTED)

Mechanism = the existing `PER_FN_NO_DELAYED_BRANCH` table (w25 splice infra).
Probe harness: `scratch/w48_a6_ndbprobe.py` (restores build.py in a `finally`).
build.py is UNMODIFIED on my branch — these are WIRING RECOMMENDATIONS for the consolidator.

### 3.1 Whole-TU sweep (splice = every epilogue-residual fn in the TU)

| TU | fn | before | after |
|---|---|---|---|
| stream.c | StClearRing | 5 | 5 |
| stream.c | **StSetRing** | 9 | **3** BETTER |
| stream.c | StSetStream | 18 | 24 worse |
| streamhelp.c | StUnSetRing | 9 | 15 worse |
| streamhelp.c | StGetNext | 7 | 11 worse |
| streamhelp.c | StFreeRing | 35 | 38 worse |
| streamhelp.c | **data_ready_callback** | 21 | **18** BETTER |
| streamhelp.c | StSetMask | 3 | 3 |
| cdread.c | _read_sync | 4 | 6 worse |
| cdread.c | _read_data_int | 7 | 20 worse |
| cdread.c | CdRead | 43 | 76 worse |
| cdread.c | CdReadSync | 31 | 54 worse |
| iso9660.c | _cd_find_path | 15 | 30 worse |
| iso9660.c | CD_cachefile | 99 | 198 worse |
| iso9660.c | CD_newmedia | 146 | 187 worse |
| iso9660.c | CdSearchFile | 92 | 139 worse |
| cdread2.c | CdRead2 | 5 | 5 |
| stcdint.c | _st_dma | 143 | 151 worse |
| stcdint.c | StCdInterrupt | 214 | 335 worse |

### 3.2 ISOLATED per-fn re-probe (each fn spliced ALONE, whole-TU gated)

- `stream.c` splice `{StSetRing}`   -> StSetRing **9 -> 3**, StClearRing 5->5, StSetStream 18->18. ZERO collateral.
- `streamhelp.c` splice `{data_ready_callback}` -> data_ready_callback **21 -> 18**; StUnSetRing/StGetNext/
  StFreeRing/StSetMask/init_ring_status ALL unchanged. ZERO collateral.
- `streamhelp.c` splice `{StSetMask}` -> no delta anywhere (the flag does not reach its class).

**RECOMMEND WIRING (consolidator):**
```python
"recon/syslib/psx/libcd/stream.c":     {"StSetRing"},
"recon/syslib/psx/libcd/streamhelp.c": {"data_ready_callback"},
```
Both reproduced twice (whole-TU sweep + isolated re-probe), both zero-regression.
Per the w47 IDENTITY BAR these are NUDGES, not identities (neither converts FAIL->PASS on
its own) -- but StSetRing's post-splice residual is a SINGLE named assembler class (below),
i.e. it is one maspsx fix away from PASS.

### 3.3 FOR a9/a10 — TU-wide flag signature of this cluster
The libcd-B cluster is **NOT** a per-TU `-fno-delayed-branch` module: on every TU the flag is a
net LOSS when applied TU-wide (iso9660 +122, stcdint +129, cdread +55). It is per-FUNCTION,
and only on the two Tier-1 epilogue-only shapes above. This matches the w25-a1 taxonomy and is
evidence AGAINST the "Sony built syslib with -fno-delayed-branch" module-level hypothesis for
libcd -- at least for CDREAD/ISO9660/STCDINT/STREAM.

## 4. ASSEMBLER CLASS FOR a10 — "macro SPLIT into a delay slot" (distinct from backward jal fill)

Named here because it is the SOLE residual of StSetRing (post-splice) and StSetMask, and a
component of StUnSetRing / StClearRing / data_ready_callback.

The oracle repeatedly shows **half of a store MACRO before a branch and the other half IN the
delay slot**:

```
StSetMask (oracle, 7 insns):        StSetRing (oracle, tail):
  lui   $at, %hi(StEndFrame)          lui  $at, %hi(StRingSize)
  jr    $ra                           jal  StClearRing
   sw   $a2, %lo(StEndFrame)($at)      sw   $a1, %lo(StRingSize)($at)
```

`$at` is PROOF the compiler emitted the one-line assembler macro `sw $a2,StEndFrame`
(cc1 never allocates `$at`). A macro cannot be scheduled by cc1 -- so the SPLIT was done by the
ASSEMBLER, which moved the macro's second half into the slot and left the `lui` behind.

Ours cannot reproduce it: maspsx forces `.set noreorder` on every function (build.py's own w25-a9
note) and unconditionally appends `nop` after a branch in reorder mode, so GNU-as's reorder-fill
never runs.

**This is NOT the 04C-falsified "backward-fill a jal slot with a whole independent instruction"
claim** -- it is macro SPLITTING, a different aspsx mechanism, and it is still UNTESTED against
the real assembler. Concrete test for a10: assemble
`lui $at,%hi(S) / sw $a2,S / jr $ra` ... actually just feed real ASPSX the cc1 `.s` for
`StSetMask` (3 macro stores + `jr $ra`, `.set reorder`) and see whether it emits 7 or 8 words.
If ASPSX emits 7 => assembler-side, spec a maspsx `--aspsx-macro-split` fix; if 8 => the premise
is dead and these are a compiler mystery.

Affected in my scope: StSetMask (3, ALL of it), StSetRing (3 post-splice, ALL of it),
StClearRing (part), StUnSetRing (part), data_ready_callback (part), StGetNext (part).

## 4b. 🔴🔴 CORRECTION TO §4 — I TESTED IT AGAINST THE REAL ASPSX (per the 04C law). Result: my §4 attribution was WRONG, and the true mechanism is now PROVEN.

Test corpus (`C:/Temp/w48a6/`, CRLF-converted `.s`, SN `-o<name>` syntax):

Input = the EXACT cc1 output for `StSetMask`
(`build/recon/syslib/psx/libcd/streamhelp.c.s`), which is:
```
	sw	$4,StSTART_FLAG
	sw	$5,StStartFrame
	sw	$6,StEndFrame
	j	$31
```
(three one-line assembler MACROS, no `.set` directive, delay slot left to the assembler).

| assembler | mode | .text size | words | shape |
|---|---|---|---|---|
| **ASPSX 2.77** (`psq43/PSSN`) | default | 0x20 | **8** | 3 macro pairs, `jr ra`, **`nop`** |
| **ASPSX 2.77** (`psq43/PSSN43/pssn`) | default | 0x20 | **8** | identical |
| **ASPSX 2.79** (`psq45/BIN`) | default | 0x20 | **8** | identical |
| ASPSX 2.77, macro written INTO the slot, `.set reorder` | | 0x20 | 8 | macro pushed BACK out of the slot, `nop` inserted |
| ASPSX 2.77, macro written INTO the slot, `.set noreorder` | | 0x1C | 7 | **`jr ra; lui $at; sw`** — only the `lui` in the slot (semantically dead store; NOT the oracle) |
| **GNU as** `-EL -march=r3000 -G0`, `.set reorder` | | 0x1C | **7** | **`lui $at,%hi(EF); jr $ra; sw $a2,%lo(EF)($at)` = THE ORACLE, byte-for-byte** |

### Verdict
1. The "macro SPLIT into a delay slot" mechanism is **REAL and CONFIRMED** — but **ASPSX 2.77/2.79
   DO NOT DO IT** (they insert `nop`, exactly like our maspsx pipeline). My §4 claim
   "the assembler split it, test ASPSX" is therefore **half right / half wrong**: the split is
   an assembler behavior, but *not this assembler's*.
2. **GNU as in `.set reorder` reproduces the retail bytes EXACTLY** from our own unmodified cc1
   output. So the retail bytes are NOT unreachable — they are one `.set` directive away.
3. Our pipeline cannot get there because **maspsx forces `.set noreorder` on every function**
   (build.py's own w25-a9 note), so GNU as's reorder-fill never runs. `maspsx.py --help` has NO
   option for this (`--dont-force-G0`, `--expand-div`, `--macro-inc`, `--jtbl-at-fusion`, ...).
4. Corollary that matters for the WHOLE wave: since ASPSX 2.77/2.79 provably cannot emit
   retail's shape here, **the retail libcd objects were not produced by an ASPSX-2.77-class
   reorder pass**. Either Sony assembled the PsyQ libraries with a MIPS/GNU-lineage `as`
   (IDT Ch9 assembler = GAS's ancestor, methodology §3.17), or with an ASPSX build we do not
   have. This is a *second*, independent data point next to 04C's "no backward jal fill".

### maspsx fix SPEC (not implemented — out of an a1-a8 agent's scope)
Add `--aspsx-reorder-fill` (opt-in, per-TU): when cc1's `.s` leaves a branch/jump delay slot
empty in a region cc1 did NOT mark `.set noreorder`, emit `.set reorder` for that region instead
of `noreorder`+`nop`, and let GNU as fill it. Gate: it must be OPT-IN per TU, because the same
change would re-fill slots in TUs whose oracles genuinely carry `nop` there.
Expected immediate yield in my scope alone: StSetMask 3->0 (PASS), StSetRing 3->0 (PASS, with
the `-fno-delayed-branch` splice from §3.2), plus partial credit on StClearRing / StUnSetRing /
StGetNext / data_ready_callback.

**Repro kit committed: `scratch/w48_a6_asmdiff.md` + the .s inputs.**

## 5. LANDED EDIT — cdread.c `_read_data_int` 7 -> 4, COUNT-EXACT 52/52 (+ a runtime bug)

**CORRECTNESS BUG (4th found by matching in 3 waves).** The oracle:

```
  lui   $v1, %hi(CD_cbread)
  lw    $v1, %lo(CD_cbread)($v1)
  addiu $v0, $zero, 0x1
  beqz  $v1, .L80108BE4
   sw   $v0, 0x24($s0)      <-- DELAY SLOT: executes on BOTH paths
```

`_cdr.w24 = 1` ("read in progress") is **UNCONDITIONAL**; the recon had it inside
`if (CD_cbread != 0) { ... }`, so with no user CdReadCallback installed the flag was never set
and CdReadSync would observe the wrong state. Delay-slot placement is semantics
(methodology 3.1; same class as w47's FILE_callbackop fix).

**MATCH LEVER on top of it (3.25-3c):** hoisting the store out of the guard alone left it at 7 —
gcc's reorg refuses to slot-fill a **volatile** MEM (resource_conflicts_p), and `_cdr` is
`extern volatile CdrEnv`. Casting volatile away on **that one store**
(`*(int *)&_cdr.w24 = 1;`) restored the fill: **7 -> 4, ours 53 -> 52 = oracle-exact.**
Whole-TU gate: every other cdread fn unchanged.

Residual 4 = the prologue {high, lo_sum} pair: ours `lui $v0 / addiu $s0,$v0,0` (separate
scratch, because sched2 placed the lui BEFORE the `sw $s0,16($sp)` save so $s0 was still live),
oracle `lui $s0 / addiu $s0,$s0,0` (self-temp, placed after the save). Named class: combine_regs
cannot tie a block-local `high` qty to a **global** allocno destination (w47-a2 `reg_qty[sreg] >= -1`
refusal). Not attacked further this wave.

### FALSIFIED on _read_data_int / _read_sync (basin: post-bug-fix tree)

- `extern CdrEnv _cdr` (drop volatile TU-wide): _read_sync 4->7, _read_int 115->128,
  _read_data_int 4->17, _read_issue 64->66, CdReadSync 31->30, CdRead 43->43. **Net much worse
  — volatile stays.** It also did NOT change CdRead's base-anchor form, refuting my
  "volatile defeats TARGET_SPLIT_ADDRESSES" hypothesis for that residual.
- `_read_sync` 10-variant sweep (scratch/w48_a6_v_readsync.py): plain member / ptr-local /
  split-load / struct-ptr-anchored-at-w28 / non-volatile ptr / two ptr locals / array-view —
  **8 of 10 tie at 4**, ptr-reused-for-store = 7, `volatile int *volatile` = 16. The ptr-local
  form (`volatile int *saved = &_cdr.w28;`) reproduces the oracle's STRUCTURE exactly (anchor at
  &_cdr.w28, `addiu $s0,$s0,-40` re-base in the jal slot) but gcc folds the lo_sum into the load
  and rematerializes the addiu in the delay slot. **Opacity fence `__asm__("":"=r"(p):"0"(p))`
  REGRESSES it hard (4 -> 12+): it breaks cse's related_value derivation of &_cdr from
  &_cdr.w28, so the second access re-materializes its own lui/addiu and the pointer drops out of
  a callee-saved reg.** Left as the plain member form (equal count, simpler source).

## 6. TU-WIDE FLAG SIGNATURES (report-only, for a9) — scratch/w48_a6_flagscreen.py

Every cell = whole-TU gate, build.py patched-in-place and restored in a `finally`.

| TU | fn | base | -fno-sched-insns2 | -fno-sched-insns | -fno-delayed-branch | -G0 | -mno-split-addr |
|---|---|---|---|---|---|---|---|
| stream | StClearRing | 5 | 8 | 5 | 5 | 35 | 5 |
| stream | StSetRing | 9 | 9 | 9 | 9 | 12 | 9 |
| stream | **StSetStream** | 18 | **8** | 18 | 18 | 36 | 18 |
| streamhelp | StFreeRing | 35 | 35 | 45 | 45 | 48 | 35 |
| streamhelp | StGetNext | 7 | 11 | 32 | 32 | 33 | 7 |
| streamhelp | StSetMask | 3 | 3 | 3 | 3 | 12 | 3 |
| streamhelp | StUnSetRing | 9 | 9 | 9 | 9 | 15 | 9 |
| streamhelp | data_ready_callback | 21 | 24 | 46 | 46 | 43 | 21 |
| streamhelp | init_ring_status | PASS | PASS | 4 | 4 | 4 | PASS |
| cdread | CdRead | 43 | 54 | 57 | 76 | 43 | 39 |
| cdread | CdReadSync | 31 | 41 | 35 | 54 | 31 | 33 |
| cdread | _read_data_int | 4 | 6 | 24 | 19 | 8 | 27 |
| cdread | _read_int | 115 | 115 | 113 | 148 | 122 | 107 |
| cdread | _read_issue | 64 | 65 | 62 | 139 | 64 | 81 |
| cdread | _read_sync | 4 | 4 | 6 | 6 | 4 | 4 |
| iso9660 | CD_cachefile | 99 | 110 | 101 | 198 | 107 | **85** |
| iso9660 | CD_newmedia | 146 | 148 | 148 | 187 | 153 | 149 |
| iso9660 | CdSearchFile | 92 | 103 | 95 | 139 | 117 | 93 |
| iso9660 | _cd_cmp_name | PASS | 3 | PASS | 6 | PASS | PASS |
| iso9660 | **_cd_find_path** | 15 | 25 | 25 | 30 | 15 | **8** |
| iso9660 | cd_read | 4 | 6 | 18 | 19 | 4 | 4 |
| stcdint | StCdInterrupt | 214 | 242 | 366 | 366 | 799 | 214 |
| stcdint | _st_dma | 143 | 143 | 146 | 146 | 151 | 146 |
| cdread2 | CdRead2 | 5 | 11 | 5 | 5 | 12 | 11 |
| cdread2 | _cdread2_ready | PASS | PASS | PASS | PASS | PASS | PASS |

### 6.1 RECOMMEND WIRING: `iso9660.c` -> `{"no_split_addresses": True}`

Reproduced **2x** (screen + dedicated re-run), identical both times:
`_cd_find_path 15->8`, `CD_cachefile 99->85`, `CdSearchFile 92->93`, `CD_newmedia 146->149`,
`cd_read 4->4`, `_cd_cmp_name PASS held`. **Net 356 -> 339 (-17), ZERO PASS regressions.**
`+G0` on top changes only CD_cachefile 85->84 — below the noise bar, not recommended.
Consistent with w33-a10's finding that `-mno-split-addresses` is genuinely PER-OBJECT.
(This is a NUDGE by the w47 identity bar, not an identity — no FAIL->PASS conversion.)

### 6.2 SIGNATURE: this cluster is NOT a `-G0` module

`-G0` is catastrophic on every TU (StCdInterrupt 214->799, StClearRing 5->35, StSetStream 18->36,
StSetMask 3->12, CdRead2 5->12, init_ring_status PASS->4). The libcd-B objects use the stock -G
setting. Rules out the briefing's -G0 suspicion for THIS cluster (it was raised for libmcrd/a1).

### 6.3 OPEN INFRA REQUEST (for the consolidator / a9)

`StSetStream 18 -> 8` under `-fno-schedule-insns2` is the biggest single-flag delta in my scope,
but it is per-FUNCTION (its TU-mate StClearRing goes 5 -> 8), and the tree's splice infrastructure
(`PER_FN_NO_DELAYED_BRANCH` + `_apply_fn_splice`) only supports `-fno-delayed-branch`.
**Extending the existing per-fn .ent/.end splice to an arbitrary flag set would immediately bank
StSetStream 18->8.** The mechanism is already generic
(`_apply_fn_splice(rel, s_file, i_file, CC1, cc1_flags)` recompiles with an extra flag and splices
the region) — only the TABLE is flag-specific.

## 7. STATUS AFTER MY WAVE (final re-gate on my tree, all 22 rows)

| fn | baseline | final | note |
|---|---|---|---|
| _read_sync | 4 | 4 | 10 spellings tie; fence falsified |
| _read_int | 115 | 115 | untouched |
| **_read_data_int** | **7** | **4** | count-exact 52/52 + BUG FIXED |
| _read_issue | 64 | 64 | untouched |
| CdRead | 43 | 43 | per-region base-anchor rematerialization (analysed, S8) |
| CdReadSync | 31 | 31 | untouched |
| CdRead2 | 5 | 5 | 3 = assembler class, 2 = no-copy-prop identity (S8) |
| StClearRing | 5 | 5 | epilogue-reload hoist + jr-slot |
| StSetStream | 18 | 18 | -fno-sched-insns2 would give 8 (needs infra, S6.3) |
| StSetRing | 9 | 9 | **3 with the recommended splice**; residual = assembler class |
| StCdInterrupt | 214 | 214 | untouched |
| _st_dma | 143 | 143 | untouched |
| StUnSetRing | 9 | 9 | |
| StGetNext | 7 | 7 | worklist said 0.00% (wrong) |
| StFreeRing | 35 | 35 | |
| data_ready_callback | 21 | 21 | **18 with the recommended splice** |
| StSetMask | 3 | 3 | 100% assembler class (S4b) — PASSes with a maspsx reorder-fill |
| CdSearchFile | 92 | 92 | |
| CD_newmedia | 146 | 146 | |
| _cd_find_path | 15 | 15 | **8 with the recommended -mno-split-addresses** |
| CD_cachefile | 99 | 99 | **85 with the same** |
| CD_Read | 0.00% | **PASS** | worklist mis-attribution (S1) |

ZERO REGRESSIONS: every non-target row re-gated identical on the final tree; the three TU-mates
outside my worklist (`_cdread2_ready`, `init_ring_status`, `_cd_cmp_name`) all still PASS.

## 8. NAMED ANGLES for the next pass (NO-FLOORS: every open fn has one)

- **CdRead (43, ours 94 / oracle 103 = 9 SHORT).** The oracle materializes a FRESH
  `%hi/%lo(_cdr+field)` anchor PER REGION and derives siblings by displacement
  (`lui $s0/addiu $s0` at `_cdr+0x24` with disp 0; a second `lui $a0/addiu $a0` at `&_cdr` for
  disp 12/16; a third at `_cdr+0x28` then `addiu $s0,$s0,-40`). Ours hoists ONE `&_cdr` global
  allocno and uses displacements everywhere. FALSIFIED: dropping volatile (no change, 43->43).
  NEXT ANGLE: per-BLOCK base assignment (catalog "ASSIGN a base pointer PER-BLOCK to force
  rematerialization into a shared tail") or splitting the accesses so cse's related_value chain
  restarts per region.
- **CdRead2 (5).** 3 diffs = the S4b assembler class (`lui $at; j; sw ...($at)`). 2 diffs =
  `addu $a2,$a1,$zero` (ours, copy-prop of the shared 0) vs `addu $a2,$zero,$zero` (oracle) on
  `CdControl(0x1B,0,0)` — the w47 "still-live-constant rematerialization / no-copy-prop"
  identity. Ceiling without a maspsx fix = 2.
- **_cd_find_path (15 -> 8 with -mno-split-addresses).** Oracle runs TWO induction variables: a
  raw byte OFFSET $s1 (0, +44) consumed as `lui $v0,%hi(tbl+4); addu $v0,$v0,$s1; lw $v0,%lo(...)`
  for `.parent`, and a separate walking POINTER $s2 (+44) for `.name`. Ours lets combine_givs
  merge them onto one entry pointer (`lw $v0,4($s1)`, `$s2 = $s1+12`). ANGLE = the catalog's
  "explicit pointer walkers are the only faithful shape" / multi-giv rows.
- **StClearRing (5) / StSetStream (18) / StGetNext (7) / StUnSetRing (9).** Shared signature:
  sched2 HOISTS the epilogue `lw $ra` / `lw $sN` reloads ABOVE the function's trailing store run
  (to cover their load delays); the oracle emits all trailing stores first and keeps the epilogue
  reloads contiguous. `-fno-schedule-insns2` reaches it on StSetStream (18->8) but not the others.
  ANGLE = the w45 USE-FENCE as a sched-issue-position fixpoint placed at the head of the store run.
- **StSetMask (3).** 100% S4b. PASSes the moment a maspsx reorder-fill exists — no source angle
  exists (verified: cc1's `.s` for it is 4 lines, three macros + `j $31`).
- **StCdInterrupt (214, ours 591/583) / _st_dma (143, ours 91/106 = 15 SHORT).** Not attacked.
  `_st_dma` being 15 SHORT with an intact call skeleton is the classic "SYM-locals not wired /
  collapsed inline math" signature (catalog: run the call-skeleton diff first).
- **CdSearchFile (92, ours 166/182 = 16 SHORT), CD_cachefile (99), CD_newmedia (146).** Not
  attacked. Wire S6.1 FIRST and re-baseline before any source work — falsifications are
  basin-relative (w45 LAW).
