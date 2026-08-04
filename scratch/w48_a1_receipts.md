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

## 2. FLAG AXIS — `-mno-split-addresses` is the libmcrd cluster's identity (3× reproduced, incl. cross-agent)

Probe harness: `scratch/w48_a1_flagprobe.py` (patches PER_TU_FLAGS in place, gates the WHOLE TU,
restores build.py in `finally`). 🔴 It MERGES into an existing entry rather than prepending —
see §2b.

Whole-TU gate ledger (PASS / total diffs), all 3 TUs × 6 configs:

| TU | BASE | nosplit | nosched2 | nosched1 | nodelay | -G0 | -G8 |
|---|---|---|---|---|---|---|---|
| BIOS.c (17 fns)    | 13 / 48   | **13 / 20**   | 11 / 51   | 11 / 132  | 2 / 92    | 2 / 367   | 13 / 48 |
| USERFUNC.c (4)     | 1 / 59    | **1 / 14**    | 1 / 67    | 1 / 55    | 0 / 65    | 1 / 77    | 1 / 59 |
| LIBMCRD.c (26)     | 2 / 1385  | **2 / 1329**  | 2 / 1413  | 2 / 1480  | 1 / 1722  | 2 / 1392  | 2 / 1385 |

- `-mno-split-addresses` = the ONLY non-regressing config; −28 / −45 / −56 diffs, **0 PASS
  regressions on all three TUs**, reproduced 2× locally and independently by **w48-a9's 64-TU
  ladder** (identical BASE/nosplit numbers 48→20, 59→14, 1385→1329). a9 also censused the ORACLE:
  BIOS 84 `$at` sites / LIBMCRD 66 / USERFUNC 14 — `$at` is the ASSEMBLER's macro scratch, i.e.
  the oracle is FULL of `la`/`sym($reg)` macro expansions, which is the structural fingerprint of
  a compiler that did NOT pre-split addresses. Same family as the already-wired
  `SYS.c / INTR / FIRST / PAD` set (catalog §G "GENUINELY PER-OBJECT").
- **PER-FN identity evidence beyond the diff totals** (the w47 bar's count leg):
  `UserFuncExecute` 28/27 → **27/27 count-EXACT**; `_card_start` 31 diffs → **3** (120/119).
- **RECOMMENDATION for the consolidator/a9: wire `{"no_split_addresses": True}` for
  `recon/syslib/psx/libmcrd/{BIOS,USERFUNC,LIBMCRD}.c`.** ⚠️ LIBMCRD.c already has a
  `{"jtbl_at_fusion": True}` entry — the key must be MERGED into it, never added as a second
  dict entry (04G duplicate-key hazard).

### 2a. -G axis is STRUCTURALLY BLIND here (w47-a8-A5 confirmed on a 3rd cluster)
`g_value=0` alone on BIOS.c = catastrophic (48 → 367 diffs, 13→2 PASS). But
`no_split_addresses + g_value=0` measures **exactly identical to `no_split_addresses` alone**
(20 diffs, 13 PASS) — with split-addresses OFF, cc1 emits the assembler macro forms and the whole
-G sensitivity disappears. a9's gp-census calls all three TUs "-G0 CANDIDATE" on 0 `%gp_rel` in
the oracle; that signal is VACUOUS once nosplit is adopted. **Never census -G without pinning the
split-addresses state first.**

### 2b. 🔴 PROBE-HARNESS DEFECT FOUND AND FIXED (the 04G duplicate-key hazard, live)
My first LIBMCRD.c sweep returned **`PASS=2 totaldiffs=1385` for ALL SIX configs** — a perfect
"flag axis is inert" reading. It was a harness bug: LIBMCRD.c already owns a PER_TU_FLAGS entry
(`jtbl_at_fusion`), and my probe PREPENDED a second entry for the same path. `PER_TU_FLAGS` is a
python dict LITERAL, so the LATER (pre-existing) entry silently won and my flags never reached
cc1. After teaching the harness to MERGE, LIBMCRD moved (nosplit 1329, nodelay 1722, ...).
**Generalization: "this TU is inert to every flag" is a HARNESS SYMPTOM, not a result — any
probe that prepends to a keyed dict literal is vacuous for the ~40 TUs that already have entries.**
(w47 recorded this hazard for WIRING; it bites PROBING identically.)
