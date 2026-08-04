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
