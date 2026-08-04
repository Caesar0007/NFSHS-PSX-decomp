# WAVE-48 agent a1 — syslib/libmcrd cluster receipts

Worktree `C:/Temp/nfs4-wt48-a1` (branch w48-a1, base a12f7b8b).
Gate = `python tools/verify_asm.py <file> <names>` from worktree root. ~0.4 s/TU (C lane, fast).

## 0. RE-GATED BASELINE (2026-08-04) — worklist rows vs reality

The worklist's 33 rows for this scope are WRONG on 2 rows and the fuzzy% is informational only.

### 0a. Worklist misattributions (2 rows removed from scope)
- `0x800FA394 CD_Init` listed under `syslib/psx/libmcrd/BIOS` — it is owned by
  `recon/eaclib/psx/eacpsxz/cdfs.c` and **already PASSes (69 insns)**. Not a libmcrd fn.
- `0x80107080 CD_get_intr` listed under `syslib/psx/libmcrd/BIOS` at 0.00% — it is **not
  reconstructed at all** (`src/syslib/psx/libmcrd/BIOS.c` still `INCLUDE_ASM`s it, and
  `recon/.../BIOS.c` has no such function). 0.00% = "no recon body", not a near-miss.
  Note `recon/syslib/psx/libcd/drv.c` also carries a `CD_get_intr` note — attribution needs a
  decision before anyone reconstructs it (see §4).

### 0b. RE-GATED whole-TU baselines

BIOS.c — 17 fns, **13 PASS / 4 FAIL**:
| fn | gate |
|---|---|
| funcEvSpIOE/Error/Timeout/Newcard(+x) ×8 | PASS (5 insns each) |
| _card_open | PASS (12) |
| _card_close | PASS (8) |
| _card_stop | PASS (45) |
| _chk_card_event / _chk_card_event_x | PASS (15 each) |
| _clr_card_event | FAIL 5 (ours 65 / oracle 66) |
| _card_start | FAIL 31 (120/119) |
| _get_card_event | FAIL 6 (54/54 count-exact) |
| _get_card_event_x | FAIL 6 (54/54 count-exact) |

USERFUNC.c — 4 fns, **1 PASS / 3 FAIL**:
UserFuncInit FAIL 3 (5/4) · UserFuncOpen FAIL 33 (32/31) · UserFuncExecute FAIL 23 (28/27) ·
UserFuncComplete PASS (4).

LIBMCRD.c — 26 fns, **2 PASS / 24 FAIL** (MemCardEnd 8, MemCardCallback 5 = PASS):
EventToRslt 3 (20/21) · MakeDevname 33 (18/23) · Exist_cb 144 (95/117) · Cmd_cb 137 (120/141) ·
ReadData_cb 72 (69/79) · WriteData_cb 77 (70/79) · ReadFile_cb 57 (59/66) · WriteFile_cb 57 (59/66) ·
Start_cb 29 (28/33) · Init 12 (11/11) · Start 8 (20/20) · Stop 12 (16/16) · Exist 8 (26/26) ·
Accept 8 (26/26) · ReadData 55 (45/46) · WriteData 55 (45/46) · ReadFile 70 (68/70) ·
WriteFile 70 (68/70) · Sync 42 (59/71) · CreateFile 104 (102/130) · DeleteFile 96 (81/111) ·
Format 28 (35/35) · Unformat 28 (41/45) · GetDirentry 180 (144/152).

## 1. FALSIFICATION — the briefing's priority-1 lever is MOOT (catalog row is STALE)

**Briefing §3 a1 / catalog §G row "aspsx 2.77 absolute `lui $at; sw` vs our gp-relative `.lcomm`
≤4B — libmcrd BIOS funcEvSp* ×8 + MemCardCallback + DsReadyCallback + UserFuncInit" and the
briefing's "probe -G0 on the TU FIRST".**

RE-GATE VERDICT: **the whole funcEvSp* class already PASSes** (8/8, 5 insns each), and so do
`_card_open`, `_card_close`, `_card_stop`, `_chk_card_event(_x)` and `MemCardCallback`.
The floor was already fixed IN SOURCE (not by a flag) — `BIOS.c` gives every one of the 16
`_card_evhandleN` / `_card_evflagN` scalars an explicit
`__attribute__((section(".data"))) = 0` definition, which keeps them out of maspsx's `-G4`
`.lcomm`→sbss promotion and reproduces aspsx's absolute `lui $at; sw %lo(sym)($at)`.
⇒ **No -G0 probe is warranted for the .lcomm class here — there is nothing left to fix.**
(This is the catalog §I-addendum "section lever, SINGLE-ACCESS scope" applied and landed;
the catalog row 132 + the briefing bullet should both be marked CLOSED.)
Nothing in the remaining 31 FAILs is a gp-rel-vs-absolute diff (verified by inspecting each
diff list: zero `N(gp)` vs `%lo` pairs).
