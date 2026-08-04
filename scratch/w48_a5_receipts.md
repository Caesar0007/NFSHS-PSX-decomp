# WAVE-48 a5 receipts — syslib/libcd part A (cdcont 9 / drv 9 / event 5 / TYPE 2 / toc 2 = 27 fns)

Worktree `C:/Temp/nfs4-wt48-a5`, branch `w48-a5`, base `a12f7b8b`.
Gate = `python tools/verify_asm.py <file> <names>`; whole-TU helper `scratch/w48_a5_tugate.py`.

## 0. RE-GATED BASELINE (2026-08-04) — worklist fuzzy% ignored per standing rule

| TU | PASS | FAIL | DIFFSUM |
|---|---|---|---|
| TYPE.c   | 0  | 2 | 59  |
| cdcont.c | 10 | 9 | 281 |
| drv.c    | 3  | 9 | 673 |
| event.c  | 0  | 5 | 64  |
| toc.c    | 0  | 2 | 93  |
| **total**| 13 | 27| 1170|

Per-fn baseline (my 27): CdDiskReady 5 · CdGetDiskType 54 · CdLastPos 3 · CdSetDebug 3 ·
CdSyncCallback 3 · CdReadyCallback 3 · CdControl 62 · CdControlF 67 · CdControlB 69 ·
CdDataCallback 6 · CdIntToPos 65 · CD_sync 106 · CD_ready 131 · CD_cw 261 · CD_flush 17 ·
CD_initintr 15 · CD_datasync 61 · **CD_getsector = ALREADY PASS** (worklist said 99.92%) ·
CD_set_test_parmnum 3 · _cd_intr_dispatch 25 · CdInit 42 · _cd_event_init 4 ·
_cd_event_sync/_ready/_read 6 each · CdGetToc 6 · CdGetToc2 87.

Worklist-fuzzy% wrong again: CD_getsector listed 99.92% is a PASS; CdInit listed 0.00% is 42 diffs
at 40-vs-36 insns (not "no match"); CdLastPos listed 46.67% is a 3-diff single-instruction shift.
