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
