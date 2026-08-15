# W64-A5 — libcd-A belt (drv.c, toc.c, iso9660.c, cdcont.c, libapi/FIRST.c)

Lane: `cc1_272` (PsyQ 4.0 CC1PSX = FSF 2.7.2) + direct GNU-as reorder, no maspsx.
Syslib = Sony vendor-prebuilt ⇒ **gate-parity only** (psyqproof not run, per brief).
Every baseline re-gated by me before any edit; all matched the briefing exactly this time.

## LEDGER

| fn | TU | re-gated baseline | final | lever |
|---|---|---|---|---|
| `CdGetToc2` | toc.c | 4 (139/137) | **PASS 137/137** | loop.c lifetime dial + 2 priced .greg deltas |
| `CD_cw` | drv.c | 40 (259/259) | **18, count-EXACT** | 2 zero-insn fences, conflict-graph-solved |
| `CD_newmedia` | iso9660.c | 11 (178/177) | **6, count-EXACT 177/177** | identity launder + W48-A7 guard |
| `CD_init_80108140` | drv.c | 10 (120/120) | 10 | 2 devices falsified WITH mechanisms |
| `CdSearchFile` | iso9660.c | 19 (181/182) | 19 | 09I device falsified per-use |
| `firstfile` | libapi/FIRST.c | 5 (104/103) | 5 | flip priced; fence axis measured inert |
| `CD_sync`/`CD_ready`/`CD_datasync`/`CdControl` | drv.c/cdcont.c | PASS | **PASS** | held |

TU totals: **toc.c 1/2 → 2/2 (COMPLETE)**, drv.c 11/13, iso9660.c 4/6, cdcont.c 19/19, FIRST.c 1/2.
Net −31 diffs, +1 gate seal, **zero PASS→FAIL**. All TUs gated 2×; `tu_order_audit` 0 inversions;
host `gcc -m32 -fsyntax-only -std=gnu89` clean; 0 control bytes; line-ending regime preserved
per file (drv.c LF; toc.c/iso9660.c/FIRST.c CRLF — byte-checked after every scripted edit).

Commits: `db6df61c` (CdGetToc2), `93263348` (CD_cw), `b9064974` (CD_newmedia), `ecbb2738` (receipts).

---

## 1. 🏆 `CdGetToc2` 4 → PASS — the loop.c budget solved from the source, then priced

### (a) THE HOIST — the brief's mechanism completed
`-dL` says the division's own `0x66666667` movable is DECLINED at loop.c:1640 on
`(threshold * savings * m->lifetime) >= insn_count`. The brief said "the shortfall is ONE
unit of savings or lifetime". **`savings` is NOT source-reachable**: loop.c:600 copies
`n_times_set` into `n_times_used`, so `m->savings` (loop.c:795) is the number of SETS in the
loop = 1 for any single-set invariant. `force_movables` (which doubles savings) needs the
reg to DIE in another *movable*, and it dies in the `mult`, which is not invariant.
⇒ **the only reachable input is `m->lifetime`** (loop.c:793 = the luid distance from the set
to the last use), which is 1 *only* because `expand_divmod` emits the constant immediately
before the multiply.

**Cure = two statements, both required:**
1. `magic = 0x66666667;` as the FIRST statement of the loop BODY — cse merges it with the
   division's own constant because they are now in the SAME basic block (the old preheader
   spelling could not: the loop body is a multi-predecessor block and cse works per extended
   basic block — that part of the W63 note was right).
2. exactly ONE zero-insn insn between that set and the division — the read-only fence.
   `-dL` then prints `Insn 149: regno 79 (life 2), move-insn savings 1  moved to 371`.

The hoist also lands in retail's PREHEADER ORDER for free (const first, giv init second):
`move_movables` runs before `strength_reduce` and both `emit_insn_before(..., loop_start)`.

### (b) THE BAND — reqdelta272/.greg-priced, predict-before-probe
gcc-2.7.2 allocno priority = `floor_log2(refs)*refs/live` (no size term, W60 12A). With the
hoist landed the handout was still rotated; both required deltas are bought by ONE post-loop
2-operand read-only fence:

| pseudo | before | after | effect |
|---|---|---|---|
| `track_first` p74 | 17 refs / 59 live = 11724 | **18 refs = 12203** | beats the loop cursor p169 (11785) → `$s0`, cursor → `$s1` |
| `magic` p79 | 5 refs / 30 live = 3333 | **4 refs / 77 live = 1038** | drops below `loc` p73 (1428) → `loc` `$s4`, magic `$s5` |

Moving the fence operand OUT of the loop does both at once: −1 loop-weighted ref on magic AND
+47 live (the range now reaches past the loop), and +1 out-of-loop ref on track_first.
Result: retail's handout register for register, PASS 137/137.

**Measured table** (count-EXACT 137 unless noted): in-loop `fence(magic,track_first)` 54 ·
fence written BEFORE the set 22 · + an extra preheader `fence(loc)` **2** · no magic operand
18 @135 (no hoist) · post-loop `fence(magic)` alone 32 · post-loop fence moved INSIDE the
guard 30 · **post-loop `fence(magic,track_first)` PASS** · in-loop `fence(tf,tf)` + post-loop
`fence(magic)` also PASS. Falsified as dials: promoting `loc` with extra operands 24; a 3rd/4th
`track_first` operand 22; two separate in-loop fences 22; a preheader copy of the assignment 54.

⚠️ The post-loop fence names `magic`, which is indeterminate when the guarded loop never runs.
The template is empty (nothing emitted or read); both placements that avoid it measured WORSE
(30 / 54). Documented in-source.

## 2. 🏆 `CD_cw` 40 → 18, count-EXACT, ZERO instructions — a wrong-LAYER verdict corrected

W63-A5 filed the residual as "a 3-way LOCAL-ALLOC QTY rotation". **That is the wrong layer.**
All four fighting values (`ip`, `tbl`, the masked `com`, `com<<2`) span the ready-clear branch,
so `REG_BASIC_BLOCK == -1` and local-alloc.c:470-77 never considers them — they are GLOBAL
allocnos, and the rotation is fully decided by global.c priority + `find_free_reg`'s ascending
numeric scan.

Read off the `.greg` conflict lists: `ip` conflicts with all three; `maskedCom` conflicts with
neither `tbl` nor `idx`; `tbl`↔`idx` DO conflict; all four conflict with hard `$v0`.
**Solving the scan against retail's handout {maskedCom=`$v1`, tbl=`$v1`, idx=`$a0`, ip=`$a1`}
yields exactly two ordering constraints — `tbl` before `idx`, and `ip` LAST — and proves the
other 22 orders unreachable** (with `tbl` after `idx`, `idx` takes `$v1` and `tbl` is pushed to
`$a0`; with `ip` anywhere but last it takes `$v1` or `$a0`).

Both constraints bought with zero-insn read-only fences, `reqdelta272`-priced first:
* **ip LAST** — fence on `ip` immediately before the `CD_com` store (the last point before the
  next call, so `ip` stays caller-saved): refs 5→6 AND live 8→26, priority 1.2500 → 0.4615,
  below `tbl`. **40 → 34.**
* **tbl BEFORE idx** — `reqdelta272 --flip 82 115` prints *"refs 2->4 (+2, CROSSES a floor_log2
  step)"*. **POSITION is the difference between free and +2 insns:** at the `tbl = _cd_result_flag;`
  statement the fence forces a second materialisation (44 @261); at the CONSUMER, immediately
  before `cnt = tbl + 0x40;`, it is zero-insn. **34 → 18.** 1 operand is an under-dial (34); 3
  operands = the same 18.

Falsified: every tbl-live-SHORTENING spelling (assignment moved to the guard / after the guard /
to the `cnt` statement) costs the `la`-split-into-the-`beqz`-slot, +1 insn, 35 @260.

**Residual 18** = (a) 2 diffs, the parameter loop's saved count-address in `$a2` vs `$a1`;
(b) ~14 of pure EMISSION ORDER in the ALARM block (retail materialises the `la &Intr` for the
while-entry test before the deadline store and puts the `bnez` ahead of the `cmdNames` `la`).
**All 6 source orderings of the four ALARM statements measured INERT at 18** ⇒ (b) is a
scheduler decision, not a statement-order one; next instrument is a `fencesweep` over that block.

## 3. 🏆 `CD_newmedia` 11 → 6, count-EXACT 177/177 — two multi-wave verdicts retired

### (a) THE IDENTITY LAUNDER CRACKS THE lwl/lwr BASE-FOLD
Retail reads the misaligned path-table LBA off the SAME base register as every other `buf`
reference (`lwl 143(s0)/lwr 140(s0)`); gcc-2.7.2 const-folds `buf` back to the symbol and emits
its own `la _cd_secbuf+140` + `lwl 3()/lwr 0()` (+2 insns). w51-a4 / W56 / W63-A6 all attacked
the **ACCESS** (casts, the psyz/sotn matched-twin PVD struct + COMPONENT_REF, `-fforce-addr`,
`-fforce-mem`, decl order, a whole-function void-barrier position sweep) and filed it
unreachable. Every one of those leaves `buf` PROVABLY EQUAL to `&_cd_secbuf`, so cse substitutes
the symbol however the load is spelled. **Attack the POINTER instead:** 13B's identity launder
`__asm__("" : "=r"(buf) : "0"(buf))` makes the pseudo die twice, cse can no longer prove the
equality, and both `la` insns vanish — 178 → 176. It REPLACES the w61-a8 read-only fence on the
same line and keeps that fence's allocno-demote effect (`buf` still `$s0`, `r` still `$s1`).

⇒ **the 13B rule in its strongest form: ALWAYS GATE THE UNLAUNDERED CONTROL.** A read-only fence
sitting on the very variable that needed laundering masked a reachable fold for three waves.

### (b) THE RE-OPENED W48-A7 TWO-VARIABLE ZERO-TRIP GUARD
The launder left us 1 SHORT (176/177) with a clean 19-diff residual, exposing the missing
`addu s5,v1,zero` end-copy. W62-A7 had FALSIFIED the W48-A7 shape here (goto 64 / while-kept 15)
and blamed the two `break`s. **04Z: those were pre-launder numbers.** In the laundered basin the
WHILE-KEPT form is the winner: `lim = buf + 0x800; if (rec < lim) { end = lim; while (rec < end)
{...} }` → **19 → 6, count EXACT**, and it supplies the copy (make_regs_eqv: the destination
outlives its source). do-while 18 @181; goto does not compile; without the launder 24 @183.
Other dials in the laundered basin: identity/read-only fence on `end` or `rec` all 25-27 @178-180;
all three init orders inert at 19.

**Residual 6** = pure CODE MOTION of instructions we already emit (the `li a0,1; li a1,16`
cd_read arg pair before vs after the first callee-saved store; the end-copy 3 slots later) —
11B arg-emission ties, TEXT_MOVES class, not allocation.

## 4. `CD_init_80108140` (10) — two devices falsified WITH mechanisms; R2's angle re-aimed

* **13B identity launder on the CD_sync result — INERT** (10 in five spellings; dropping the
  store-flag void fences with it 15 @117). This is the device W62's "plain named result temp
  INERT" note never gated, and 13B says to gate it before believing such a note. **Mechanism why
  it cannot reach:** the value is set FROM A HARD REG (the call's `$v0`), so `combine_regs` takes
  the hard-reg branch (local-alloc.c ~1895) and records `qty_phys_sugg = $v0` for the pseudo
  *instead of tying it* — a suggestion no die-twice trick removes.
* **R2 angle re-aimed (was "stop reorg stealing the -1"):** the two builds differ only in what
  fills the CdlDemute `bnez`'s slot — retail takes `addu $a0,$zero,$zero` from the FALL-THROUGH
  thread, ours eager-steals `li $v0,-1` from the TARGET thread. `fill_eager_delay_slots`
  (reorg.c:3901) picks the thread from `mostly_true_jump`, which for this NE branch returns 1
  (likely taken) once `rare_fallthrough - rare_dest` is 0. The question is therefore precisely
  *why retail's target thread yields nothing* — a `-dj`/reorg trace on the two `return -1`
  predecessors, **not** another source spelling.
* R1 (2 diffs, the `li $a0,1; move $a1,$0` code motion) confirmed still a TEXT_MOVES row; I
  re-derived the pipeline `.s` (`scratchpad/w64a5/dinit/out.s`, lines 71-90) and the take/after
  anchors are `\tli\t\$4,0x00000001[^\n]*\n\tmove\t\$5,\$0\n` moved after `\tbne\t\$2,\$0,\$L\d+\n`.
  **NOT submitted**: I could not probe it to a verified gate delta before running out of belt
  budget, and the wave rule is probe-proof-or-nothing. The w63 `moves_cd_init.json` remains
  UNPROVEN and must not be wired.

## 5. `CdSearchFile` (19) — the named angle's device falsified per-use

The brief's angle was "defeat the lb/lbu fusion without 13E phantom-frame growth". The 09I
DISTINCT-EXTENSION device is the device that asks for, and it is falsified **per-use** as well as
cached (W63 only measured cached forms): zero test through `!*(u_char *)s` **19 INERT** · that
plus an explicit `*(signed char *)s` sep compare 19 · the sep compare through `*(u_char *)s`
42 @180 · u_char zero test + signed re-read at the advance 19 · storing `*(signed char *)s` and
advancing separately 55 @177. **The two reads are the SAME MEM in the SAME block**, so cse merges
them whatever mode each use asks for. The CD_newmedia cure does NOT transplant (identity launder
on the cursor `s`: 58 @184, +3 insns) — laundering splits a pointer from a SYMBOL, not one MEM
from another.

## 6. `firstfile` (5) — the named angle PRICED, the fence axis measured inert

The `scan`-before-`p` basin is count-EXACT 103/103 at 18 and its residual is a clean TWO-REGISTER
swap (retail scan=`$v1`/p=`$a0`, ours p=`$v1`/scan=`$a0`). Priced off `.greg`: p (p78, refs 9 /
live 12 = **2.2500**) is allocated first and takes `$v1`; scan (p77, 8/11 = **2.1818**) gets `$a0`.
They conflict, so the first-ranked takes the lower register; the flip needs scan refs 8→9, or scan
live 11→10, or p refs 9→8 / live 12→13.
**FALSIFIED:** a read-only fence on `scan`, `p` or `name` placed after the prefix loop, before the
terminator store, or after it — **ALL INERT at 18** (1- and 2-operand forms identical); the same
fences in the ctl basin are inert at 5; only the between-inits position costs insns (8 @105).
**NAMED ANGLE (sharpened):** the dial is one ref or one live-unit on a pseudo whose refs the fence
provably fails to change — a one-run `-dl`/`-dg` question (candidate: the operand is a copy cse
folds back into `name`, so the ref lands on p73, not p77), not another spelling sweep.

## 7. The brief's N-CONSECUTIVE-GLOBALS STRUCT-VIEW SCAN — run, and negative with evidence

Applied the ALARM-AS-ONE-STRUCT detection rule (consecutive VAs + always co-assigned) over the
belt:
* **drv.c `CD_cbsync`(0x8013BF48) / `CD_cbready`(BF4C) / `CD_status`(BF54) / `CD_status1`(BF58)** —
  four adjacent 4-byte ints zeroed together in `CD_init` (xenogears' `CD_initintr` does the same
  four): the strongest candidate on the belt. **FALSIFIED BY THE ORACLE ITSELF** — the sbs shows
  retail emitting the *same* per-store `lui $at; sw zero,0($at)` macros we already emit
  (CD_init insns 11-23 identical both sides). There is no shared base to model.
* `CD_mode`(BF64)/`CD_com`(BF65) adjacent byte pair, written together — same verdict, same evidence.
* `_cd_result_flag`(0x8013C08C) / `_cd_param_count`(0x8013C18C) — already the ONE-table form
  (`tbl` / `tbl + 0x40`), landed w63; that IS this law applied.
* iso9660 `_cd_dir` / `_cd_pathtbl` / `_cd_secbuf` are consecutive but never co-assigned;
  `_cd_cached_dir`(0x80136C68) / `_cd_search_nopen`(0x80136C6C) are adjacent but written in
  different functions. No candidates.

⇒ the law generalises, but on this belt it is EXHAUSTED. Useful corollary for the catalog: the
cheap FALSIFIER for a struct-view candidate is the oracle's own store form — if retail emits the
per-store `$at` macro, there is no struct.

## 8. CORPUS SWEEP (capped, per the two coordinator messages)

* **mgs_reversing** `source/libfs/cdbios.c` = MGS's own CD *task* layer (`CDBIOS_*`, a libcd
  CLIENT), **not** Sony's lib. No SDK source anywhere in the repo. Drop.
* **VandalHearts-PcPort** `platform/pc/src/libcd.c` (881 lines, SDL/file-based) and
  **TOMB5** `EMULATOR/LIBCD.C` (459 lines, Win32) are hand-written PC re-implementations of the
  libcd API — zero PSX codegen authority. **KAIN2 / vh**: no libcd sources.
* 🏆 **xenogears-decomp `src/slus_006.64/psyq/libcd/`** IS a real twin: `bios.c` (583 lines,
  **zero INCLUDE_ASM**) carries matched `CD_cw` (:378), `CD_init` (:498), `CD_sync`, `CD_ready`,
  `CD_datasync`, `CD_flush`, plus `cdread.c`, `sys.c`, `event.c`. **No `$Id` strings**, so per 15F
  I judged by CFG, and the coordinator's one-rev-off caution applies (their libetc is v1.76 vs
  our v1.75).
  * `CD_init`: **CFG DIFFERS** (theirs delegates to `CD_initintr()`/`CD_flush()`, has no CDREG
    spin loop and no Intr triple) → not ported, per 15F.
  * `CD_cw`: CFG matches closely. Two portable shapes probed and **both FALSIFIED on our lane**:
    their single-array `ComAttr[0x40 + arg0]` count spelling (`xg_for_tbl` **60 @257**) and their
    plain `for (i = 0; i < ComAttr[0x40+arg0]; ++i)` param loop (`xg_for` **54**, guarded variant
    22 @261) vs our 18.
  * ✅ **Positive**: their `set_alarm()` writes `((Alarm_t*)&Alarm)->unk0/unk4/unk8` — an
    **independent THIRD corpus witness** for the ALARM-AS-ONE-STRUCT law (after sotn-decomp and
    rage-racer), and the first from a repo nobody had checked for it.
  * ❌ No `toc.c` and no `iso9660.c` there ⇒ still **no twin** for `CdGetToc2`, `CdSearchFile` or
    `CD_newmedia`.

## 9. CATALOG-ROW CANDIDATES (for the orchestrator to harvest)

1. **`savings` IS NOT THE USE COUNT** (loop.c:600 copies `n_times_set` into `n_times_used`) ⇒ for a
   declined LICM movable the only source-reachable input is `m->lifetime`, and ONE zero-insn insn
   (a fence) between the invariant's set and its single use flips the loop.c:1640 budget. Pairs
   with: put the invariant's assignment in the SAME BLOCK as its consumer so cse merges it (the
   preheader spelling cannot — cse is per extended basic block).
2. **THE CONFLICT-GRAPH SOLVE.** When N global allocnos rotate, don't dial blindly: read the `.greg`
   conflict lists and SOLVE `find_free_reg`'s ascending scan for retail's handout. It returns the
   minimal set of ORDERING constraints (and proves the rest unreachable), which reqdelta then
   prices. CD_cw: 24 candidate orders → exactly 2 constraints → 2 fences → 40→18.
3. **A REF-BUYING FENCE'S POSITION DECIDES FREE-vs-COSTLY.** Same 2-operand fence on the same
   variable: at the variable's ASSIGNMENT it forces a second materialisation (+2 insns); at its
   CONSUMER it is zero-insn. Sweep position before concluding a fence "costs instructions".
4. **AN OUT-OF-LOOP FENCE OPERAND IS A DOUBLE DIAL**: −1 loop-weighted ref AND +live-length, i.e.
   it DEMOTES its operand hard, while giving any second operand a clean +1. That single fence bought
   both of CdGetToc2's required deltas.
5. **IDENTITY-LAUNDER THE POINTER, NOT THE ACCESS**, when cse const-folds a pointer back to its
   symbol (symptom: the oracle reads through a live base register, ours emits its own `la sym+N`).
   Every access-side spelling is dead by construction. And: a read-only fence already sitting on
   that variable MASKS the fix — gate the unlaundered control (13B, strongest form).
6. **The struct-view candidate's cheap falsifier** is the oracle's own store form: per-store
   `lui $at; sw` on both sides = there is no shared base.
7. **NEGATIVE, with mechanism**: an identity launder cannot move a pseudo set FROM A HARD REG —
   `combine_regs` takes the hard-reg branch and records `qty_phys_sugg`, which die-twice does not
   remove. (Reach for a different device on any call-result copy.)

## 10. HAZARDS ENCOUNTERED

* **Heredoc backslash collapse fired (#N)**: `'\0'` inside a bash heredoc python string planted a
  raw NUL in FIRST.c. Caught by the mandated post-edit control-byte scan, fixed. All later scripted
  content avoided escapes.
* **Line-ending regime**: a comment block inserted with plain `\n` into CRLF `iso9660.c` created 18
  mixed lines; caught by the same post-edit scan and normalised (the file is 100% CRLF at HEAD).
* **`git log -1` showed a PEER's commit** right after my own `git commit` — verify with
  `git log -- <file>` (known W63 hazard, fired again).
* `python open(...,'w').write()` on a `\r\n`-bearing extract doubles the newlines; extract loop
  bodies in BINARY and normalise explicitly.
* `tools/qty272.py --keep <dir>` is the working form (the `--rtl` flag in the docstring does not
  exist — w63a5's note confirmed).

## 11. FILES

* Source: `recon/syslib/psx/libcd/{toc.c,drv.c,iso9660.c}`, `recon/syslib/psx/libapi/FIRST.c`
  (receipt-only).
* Probe kit (this dir, reusable): `pv.py` / `pv2.py` (single- and multi-edit variant probers,
  auto line-ending, restore-in-`finally`), `pd.py` (uncapped diff for one variant), `pq.py` /
  `pq2.py` / `prun.py` (run any tool under a variant), `spec_*.py` (every measured grid),
  `nm_body.txt`, dumps in `d1/`, `dT/`, `dcw/`, `dinit/`, `d_A_in_mt/`, `d_C_in_t/`.
