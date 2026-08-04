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

### 2c. FALSIFICATION — the `-mgas` axis does not exist on CC1PSX
w47-a10 listed `-mgas` as a CC1PSX default. Probed the negation: **CC1PSX.EXE reports
`Invalid option no-gas`** — `-mno-gas` is not a recognized option in this build (`-mgas` IS
accepted and measures byte-identical to the default). So the "gcc emits the epilogue differently
under `-mno-gas`" hypothesis for the epilogue-swap class is UNTESTABLE with this compiler, not
merely untested. (Probe: `raw=` mode of `w48_a1_flagprobe.py`, which appends arbitrary flags to
`CC1_FLAGS`.)

## 3. LANDED LEVERS (all gated on the final tree, both basins where relevant)

| fn | before | after | lever |
|---|---|---|---|
| BIOS `_clr_card_event` | 5 (65/66) | **4 (66/66 count-EXACT)** | zero-insn `"i"(0)` sched2 fence at the tail |
| BIOS `_get_card_event` | 6 (54/54) | **2 (54/54)** | spelled-out clear chain + result-before-last-reload + 2 use fences |
| BIOS `_get_card_event_x` | 6 (54/54) | **2 (54/54)** | (same) |
| LIBMCRD `MemCardReadData` | 55 | **47** | flat descending guard chain (branch polarity) |
| LIBMCRD `MemCardWriteData` | 55 | **47** | (same) |
| LIBMCRD `MemCardReadFile` | 70 (68/70) | **59 (69/70)** | flat descending guard chain |
| LIBMCRD `MemCardWriteFile` | 70 (68/70) | **59 (69/70)** | (same) |
| LIBMCRD `MemCardSync` | 42 (59/71) | **21 (62/71)** | split-storage + volatile done-spin + snapshot-reads-after-guard |
| LIBMCRD `MemCardCreateFile` | 104 | **97** | split-storage |
| LIBMCRD `MemCardDeleteFile` | 96 | **89** | split-storage |
| LIBMCRD `MemCardStop` | 12 (16/16) | **10 (18/16)** | volatile async spin (also a RUNTIME BUG FIX, section 5) |
| LIBMCRD `MemCardGetDirentry` | 180 | **169** | (split-storage side effect) |
| LIBMCRD `MemCardStart_cb` | 29 | 32 | the ONE per-fn regression, from split-storage (net −86 elsewhere) |

**TU totals (default/BASE basin): BIOS 48 -> 39 · LIBMCRD 1385 -> 1302 · USERFUNC 59 (untouched).
PASS counts unchanged (13 / 2 / 1) — ZERO PASS regressions anywhere.**
Under the recommended `nosplit` basin: BIOS **20 -> 11**.

### 3a. The `"i"(0)` IMMEDIATE-OPERAND FENCE — a cheaper 4th fence spelling (NEW)
The w45/w46 fence rows use `"r"(x)` and note two boundaries: an operand-LESS `asm("")` is deleted
before reorg, and `"r"` costs a real instruction unless the value is already register-resident
(+1 lw for a stack AUTO, +1 addiu for `&global`). In a **void** function at the tail there IS no
register-resident value — so the fence looked unavailable. **`__asm__("" : : "i"(0))` closes that
gap:** an immediate operand makes the asm non-empty (so it survives to reorg and acts as the
volatile-asm scheduling barrier) while emitting NOTHING. Cost-profile row to add:
`"i"(const)` = **0 insns, no live value needed, works in a void tail**.
Landed on `_clr_card_event` (5 -> 4, count 65/66 -> 66/66).

### 3b. WHY the epilogue restore was hoisted at all (mechanism, reusable)
`_clr_card_event`/`_get_card_event` end with a long store chain whose loads have unfilled
load-delay slots. sched2 hoists the epilogue `lw ra`/`lw s0` ~10-25 instructions UP to cover them;
that in turn frees `addiu sp` to become dbr's filler for the `jr ra` slot — so ONE scheduler
decision produces BOTH halves of the classic "ours 1 short + epilogue swap" signature. Blocking
the hoist with a tail fence restores count parity and leaves only the genuine epilogue swap.
Confirmed independently by the flag axis: `-fno-schedule-insns2` alone also makes
`_clr_card_event` count-exact (65/66 -> 66/66) — same mechanism, TU-wide and lossy.

### 3c. FLAT DESCENDING GUARD CHAIN = the brcensus-clean shape (4 fns, −44 diffs)
`tools/brcensus.py` flagged `blez 0v1 bgtz 1v0` (+ `bltz 0v1 bgez 1v0`, + a beqz/bnez swap) on the
four `MemCardRead/WriteData/File` entry points. All of it is ARM ORDER, not coloring: the recon had
the success path as the `if`-body of a nest of `< 1` / `< 0` / `== 0` tests; the oracle branches TO
the success block and falls through the error arms. Rewriting each as a flat
`if (0 < cmd) err; else if (0 <= fd) err; else if ((bytes & 0x7f) != 0) err; else if ((ofs & 0x7f) == 0) { do it } else err;`
chain zeroed the whole branch census (and is what a 1998 programmer would write).
🔑 **The mask tests need MIXED polarity** — spelling BOTH as `!= 0` gives `beqz 2v1`; the oracle
wants the first as `!= 0` and the second as `== 0`. Read the census per opcode; do not uniformly flip.

### 3d. SPLIT-STORAGE CORRECTION inside a single "one aggregate" module
The TU header argued (correctly, for the 0x00..0x5C span) that the 19 `_mc_*` globals are ONE
aggregate, because multi-field functions reach everything off one materialized base. That reasoning
was over-extended to the three tail words. **Discriminator that settles it per symbol:** does ANY
oracle in the object reach it as a displacement off the aggregate's base?
`grep -n '0x48(|0x4C(|0x54(' asm/nonmatchings/main/MemCard*.s` -> the only hits are `$sp` frame
slots; every reference to `D_80147560/64/6C` is its own `lui %hi; addiu %lo` (MemCardSync,
MemCardStart_cb) or `lui $at; sw %lo($at)` (MemCardCreateFile). => separate objects.
**Storage-shape ladder MEASURED on the 4 consumers (271 -> 248):**
struct fields **271** · plain 4-byte statics **270** (they land in sbss => gp-relative, which the
oracle never uses — the trap the TU header itself warned about) · `__attribute__((section(".bss")))`
statics **248 (ADOPTED)** · one 8-byte `int[2]` pair **253** (better for MemCardStart_cb, which DOES
share a base across the two words, worse for MemCardSync, which materializes each separately — the
two consumers want opposite shapes; the +3 on Start_cb is the price).

## 4. NAMED ANGLES / FLOORS (every remaining fn ends PASS or with a named angle + numbers)

### 4a. THE `$at`-MACRO-SPLIT-ACROSS-A-DELAY-SLOT CLASS (maspsx gap, spec'd not implemented)
**Fns:** BIOS `_card_start` (3 diffs, 120/119 under nosplit — was 31), USERFUNC `UserFuncInit`
(3 diffs, 5/4). Both residuals are the SAME single instruction: an extra `nop`.
**Evidence (direct, from the oracle, not inferred):**

    _card_start   oracle: lui $at,%hi(h7) ; jal EnableEvent ; sw $v0,%lo(h7)($at)
                  ours:   lui $at,%hi(h7) ; sw $v0,%lo(h7)($at) ; jal EnableEvent ; nop
    UserFuncInit  oracle: li $v0,-1 ; lui $at,%hi(_uf_top) ; jr $ra ; sw $v0,%lo(_uf_top)($at)
                  ours:   li $v0,-1 ; lui $at,%hi(_uf_top) ; sw $v0,... ; jr $ra ; nop

The oracle's `$at` proves the store is the ASSEMBLER's `sw $r,sym` MACRO (gcc never allocates
`$at`), and its two halves STRADDLE the delay slot. maspsx `__init__.py:1064` unconditionally
appends `nop` after a branch in `is_reorder` mode and never splits a macro across it.
🔑 **This is a DISTINCT sub-class from the one w47-a6 / 04C falsified.** 04C tested whether the real
ASPSX *backward-fills* a jal delay slot with a pre-existing independent instruction (it does not).
Here nothing is backward-filled: the assembler is choosing WHERE TO PLACE THE TWO HALVES OF ITS OWN
MACRO EXPANSION, one of which legally lands in the slot. **a10: please test exactly this on the real
ASPSX** — assemble a `sw $r,sym` macro immediately before a branch and see whether 2.77 emits the
split form.
**Not source-reachable either way:** the store-side array-view lever (`extern int G[]; G[0]=v;`,
catalog section E) DOES restore count parity in the default basin (UserFuncInit 5/4 -> **4/4**) but
lands the base in `$v1`, not `$at` — 4 diffs instead of 3, measured. Under `-mno-split-addresses`
the lever is inert by construction (cc1 emits macro forms regardless of declaration shape).

### 4b. THE EPILOGUE-SWAP CLASS — quantified, and it is COMPILER-SIDE (agrees with 04C)
`addiu sp; jr ra; nop` (oracle) vs `jr ra; addiu sp` (ours), 4 diffs, count-exact, appears on
**~20 of the 24 LIBMCRD fns + USERFUNC `UserFuncExecute` + BIOS `_clr_card_event`** => roughly
**80-100 diffs in this scope alone**, the single largest residual class here.
**PROOF it is dbr, not the assembler:** with the 3a fence landed, `_clr_card_event` reaches
**PASS (66 insns)** under `-fno-delayed-branch` — the flag alone flips exactly this pair.
**Why it cannot just be switched on:** whole-TU `-fno-delayed-branch` is a heavy net loss
(BIOS 48 -> 92 diffs / 13 -> 2 PASS; LIBMCRD 1385 -> 1722; USERFUNC 59 -> 65) because every INTERIOR
branch then keeps a naked nop. That is exactly the Tier-1/Tier-2 split w25-a1 documented.
**ACTIONABLE, ONE PASS AVAILABLE NOW (build.py is report-only for me):**

    PER_FN_NO_DELAYED_BRANCH = {
        "recon/syslib/psx/libmcrd/BIOS.c": {"_clr_card_event"},   # FAIL 4 -> PASS (66/66)

Verified per-fn under whole-TU `-fno-delayed-branch` (= what the dual-compile splice takes):
`_clr_card_event` **PASS**, `_card_open`/`_card_close` stay PASS. Tier-1 by construction (8
straight-line jals, no interior conditional branches).
**Tier-2 NEGATIVES measured (do NOT splice these):** `UserFuncExecute` 4 -> 7, `_card_start` 3 -> 33,
`_card_stop` PASS -> 9, `_chk_card_event(_x)` PASS -> 3, `funcEvSp*` PASS -> 3, `_get_card_event`
2 -> 5, and every LIBMCRD fn probed (Init 12->9 but 12/11 insns; Start 8->6 at 22/20; Exist 14 vs 8;
Unformat 41 vs 28; Sync 82 vs 21 ...). The class needs the missing **post-splice ASPSX-style fill
pass**, not more per-fn flag entries.

### 4c. `_get_card_event(_x)` residual 2 — a DE-COUPLED sched/alloc pair (model floor-receipt)
The oracle schedules `sra $v0,$s0,1` into the load-delay slot of the final volatile reload; ours
issues it at the head of the same block. The two requirements point in OPPOSITE source directions:
- the ALLOCATION (the reload must take `$v1`, not `$v0`) requires the shift to be computed BEFORE
  the reload so the result is live across it — measured: shift-after = **8 diffs**;
- the SCHEDULE (shift inside the reload's delay slot) requires a barrier between reload and shift,
  which is exactly what destroys that allocation.
8 spellings measured (harness `scratch/w48_a1_gce.py`, variants v0-v7 x 3 flag configs):
v0 6 · v1 8 · v2 8 · v3 6 · **v4 2** · v5 2 · v6 8 · v7 8. This is the w44 "DE-COUPLED ORDERS"
shape; the remaining move is a permuter / ready-list job, not another spelling.

### 4d. MemCardCreateFile / MemCardDeleteFile CALL a function the oracle OPEN-CODES
`brcensus` reports `jal 12v11` (CreateFile) and `9v8` (DeleteFile) — ours has an EXTRA call — and
both are ~28 instructions SHORT (103/130, 82/111). Root cause found in the oracle:
`MemCardCreateFile.s` contains **no `jal MemCardSync`** at all (its call set is exactly
`MakeDevname, strcat, open x2, close x2, MemCardCallback x2, UserFuncOpen, printf x2` = 11).
Instead it open-codes the wait inline at 0x800FBD58: three dead `lw 0/4/8($s0)` (the snapshot reads
plus the guard), then `lui %hi(D_80147520); L: lw; beqz L` (the `done` spin), then
`sw $zero,0x8($s0)` and a DIRECT `lw` of `D_80147564` (sync_rslt) into the frame slot. Since
`MemCardSync` is an exported extern, gcc-2.8 at -O2 cannot have inlined it => **the original source
open-coded the sync in both functions.** Replacing the `MemCardSync(0, 0, &rslt)` call with that
inline sequence is the next concrete step and should recover both the extra jal and most of the
~28-instruction shortfall. (Not attempted here: a half-finished rewrite of a 130-insn function
scrambles the LCS metric, and the wave rule is one monster rewrite per pass.)

### 4e. Remaining LIBMCRD structure (census-derived, all with numbers)
- `MemCardExist_cb` 144 (95/117): `jal 5v7` = **2 dropped calls** plus
  `beqz 4v5 bnez 2v1 beq 1v2 bne 2v1 bgtz 0v1` — missing guards AND a polarity flip. Biggest single
  structural gap left in the TU.
- `MemCardCmd_cb` 137 (120/141): `beqz 5v8 bnez 3v0 bgtz 0v1 j 6v9` — ours uses `bnez` where the
  oracle uses `beqz` throughout (uniform polarity inversion of the FSM state dispatch) plus 3
  missing guards.
- `MemCardGetDirentry` 169 (145/152): `jal 12v13` = 1 dropped call plus `blez 1v2 bgtz 1v0`.
- `MemCard{Read,Write}{Data,File}_cb` 57-77: `beq/bne` deltas = the FSM `state == N` dispatch is
  spelled as inequalities; `j` deficits = shared-tail depth.
- `MemCardMakeDevname` 33 (18/23): 5 insns short, no branch delta — a value/expression shape gap.
- `MemCardEventToRslt` 3 (20/21), `MemCardStart` 8, `MemCardExist`/`Accept` 8 each, `MemCardFormat`
  28 (35/35), `MemCardInit` 12 (11/11): count-exact or near. `MemCardInit`'s residual is the
  address-CSE question — the oracle emits TWO independent `$at` store macros where cc1 CSEs one
  `la` base plus displacements: the storage-shape menu applied to a struct FIELD pair, untried.

### 4f. NOT-A-GAP closures
- `CD_Init` (worklist row, "0.00%") = owned by `recon/eaclib/psx/eacpsxz/cdfs.c`, **already PASS**.
- `CD_get_intr` (worklist row, "0.00%") = **genuinely unreconstructed** (still `INCLUDE_ASM` in
  `src/syslib/psx/libmcrd/BIOS.c`); `recon/syslib/psx/libcd/drv.c` carries a note that splat
  disambiguated a lowercase `CD_init` from it. Attribution (libmcrd/BIOS vs libcd/drv) needs a
  decision before anyone writes it — it is the only genuine BODY gap in this cluster.
- `MemCardOpen` / `MemCardClose` exist in PsyQ 4.3 `libmcrd.h` but have NO oracle `.s` in this image
  (not linked) — not a missing reconstruction. All 26 LIBMCRD + 17 BIOS + 4 USERFUNC oracles are
  accounted for.
- Signature audit against the real `C:/Temp/psq43/PSX43/psx/include/libmcrd.h`: every public
  prototype matches ours in arity and operand width (`MemCardSync(long,long*,long*)` vs our
  `(long,int*,int*)`, etc.). No arity bug in the public API.

## 5. RUNTIME BUG FOUND AND FIXED — `MemCardStop` spun forever on a stale value
The in-source note claimed the plain `while (mc.cmd != 0) ;` form was "correct and already
insn-count-exact", and explicitly rejected `volatile` as costing diffs. **The disassembly refutes
it:** the plain form compiled to `lui $v0; lw $v0,0($v0); beqz $v0,end; bnez $v0,self` — gcc hoisted
the LOAD out of the empty loop (exactly the hazard the note worried about, reached by a different
route), so with a command in flight `MemCardStop` never returns. `mc.cmd` is cleared ASYNCHRONOUSLY
by the VSync pump `MemCardStart_cb`. Fixed with a volatile-qualified read at the use site — which is
ALSO better on the gate (12 -> 10 diffs) because it removes gcc's zero-trip rotation guard and
reproduces the oracle's bare `L: lw; bnez L`. The same treatment was applied to `MemCardSync`'s
blocking `done` wait (+1 diff there, correctness-forward).
**LESSON (floor-hygiene, again): a recorded in-source "this form is correct" claim is falsifiable —
read the emitted loop, do not trust the comment.**

## 6. PROCESS / HAZARDS (for the wave log)
- **The 04G duplicate-key hazard bites PROBING, not just WIRING** — see 2b. Symptom to memorize:
  *a TU that measures IDENTICAL under every flag*. LIBMCRD.c read "inert on all six configs" purely
  because it already had a PER_TU_FLAGS entry and my probe prepended a second one.
- **The backslash-n collapse hazard fired again, by a NEW route**: a scripted rewrite that does
  `template.replace(newline, CRLF)` also rewrites the `\n` ESCAPES inside C string literals into
  real newlines. The result is illegal C that **cc1 accepts (warning only) while host g++ rejects** —
  so the GATE stays green and the seal build breaks later. 8 literals corrupted; caught only by
  running `g++ -m32 -fsyntax-only` after the edit. Fixer committed as `scratch/w48_a1_fixnl.py`.
  **Rule: run the host syntax gate after every scripted edit, and build templates line-by-line
  instead of newline-replacing a whole block.**
- Post-edit integrity sweep used: NUL count 0, 963 CRLF / 0 bare LF, host `-fsyntax-only` clean.
- `tools/brcensus.py` was the single highest-yield instrument in this scope: it turned four
  "coloring near-misses" into a mechanical arm-order fix and located two dropped-call bugs. Run it
  BEFORE any coloring work on a syslib TU.

## 7. HANDOFF SUMMARY
- **a9 / consolidator:** wire `no_split_addresses` for `BIOS.c` and `USERFUNC.c` (strong, 3x
  reproduced, 0 regressions); LIBMCRD.c is a weak −56 with per-fn mixed signs — my call is DO NOT
  wire it. Also wire
  `PER_FN_NO_DELAYED_BRANCH["recon/syslib/psx/libmcrd/BIOS.c"] = {"_clr_card_event"}` for +1 PASS.
  LIBMCRD.c already has a `jtbl_at_fusion` entry — MERGE, never add a second key.
- **a10:** 4a is a delay-slot question the 04C runs did NOT cover (macro-half placement, not
  backward fill). Two exhibits with exact expected/actual sequences are in 4a.
- **Catalog rows to add:** 3a (the `"i"(0)` fence spelling), 3b (epilogue-hoist mechanism),
  3c (mixed-polarity flat guard chain), 3d (the split-storage discriminator plus the 4-rung
  storage-shape ladder), 6 (both hazards).
