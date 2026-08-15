# W63-A5 — libcd-A belt (recon/syslib/psx/libcd: drv.c, cdcont.c, toc.c)

Lane: `cc1_272` (PsyQ 4.0 CC1PSX = FSF 2.7.2) + direct GNU-as reorder, no maspsx.
Syslib = Sony vendor-prebuilt ⇒ **gate-parity only**; psyqproof not run (per brief).
Baselines re-gated by me before any edit; board rows were accurate this time.

## LEDGER

| fn | TU | re-gated baseline | final | lever |
|---|---|---|---|---|
| `CD_sync` | drv.c | 8 (160/160) | **PASS** | ALARM-AS-ONE-STRUCT |
| `CD_ready` | drv.c | 8 (178/178) | **PASS** | ALARM-AS-ONE-STRUCT |
| `CD_datasync` | drv.c | 8 (90/90) | **PASS** | ALARM-AS-ONE-STRUCT |
| `CdControl` | cdcont.c | 4 (79/79) | **PASS** | preamble-named compare constant → 10th global allocno → caller-save retry |
| `CD_cw` | drv.c | 49 (260/259) | **40, count-EXACT 259/259** | alarm struct (−8) + split count-table base derivation (−1, count exact) |
| `CD_init_80108140` | drv.c | 10 (120/120) | 10 | decomposed into two named items (below) |
| `CdGetToc2` | toc.c | 4 (139/137) | 4 | W62 mechanism REFUTED, real one read off `-dL` |

TU totals: `drv.c` 8/13 → **11/13**, `cdcont.c` 18/19 → **19/19 (complete)**, `toc.c` 1/2.
Zero PASS→FAIL anywhere; every TU gated 2×; `tu_order_audit.py` 0 inversions;
host `gcc -m32 -fsyntax-only -std=gnu89` clean on all three; NUL-free, line-ending
regime preserved per file (drv.c/cdcont.c LF, toc.c CRLF — verified byte-wise).

Commits: `e638e412`, `5bf362d2`, `70f0ba3b`, `86249e34`, `ef1ecd8b`.

---

## 1. 🏆 THE ALARM-AS-ONE-STRUCT LEVER (3 seals + −8 on a 4th) — catalog candidate

**Corpus-sourced, exactly as the brief directed.** The three globals
`D_801489B4 / B8 / BC` (timeout deadline / spin counter / current-op name) were
modelled as three separate scalars. **Both** matched sibling libcd decomps model
them as ONE 12-byte object:

* `C:/Temp/ps1-decomp-refs/sotn-decomp/src/main/psxsdk/libcd/bios.c` —
  `volatile Alarm_t Alarm;` accessed `((Alarm_t*)&Alarm)->unk0/unk4/unk8`
* `C:/Temp/rage-racer-decomp/src/main/PAL/lib/libcd/command_write.c` —
  `((CdAlarm *)&g_CdTimeoutDeadline)->name`

Landed as a **struct VIEW** at `&D_801489B4` (the three data symbols keep their
existing ownership; every access becomes `%hi/%lo(D_801489B4 + N)`, byte-identical
after link and invisible to verify_asm's `%lo` normalisation).

**Why it moves codegen — 14D ALIAS-DEPENDENCE DIAL.** A struct-member MEM carries
`MEM_IN_STRUCT_P`, changing `sched.c`'s `true_dependence` / `rtx_addr_varies_p`
verdicts against the other MEMs in the timeout arm. That is precisely the pass
that was misplacing the printf's `$a0` load (see §2) — the residual it fixed had
resisted two prior waves.

**Generalisation for the catalog:** *N consecutive same-typed scalar globals that
are always written together are a candidate STRUCT; model them as one object even
when the data blob owns them individually — the alias class alone is a codegen
dial.* Detection: consecutive VAs + always co-assigned + a sibling decomp that
spells them as one object.

## 2. The `CD_sync`/`CD_ready`/`CD_datasync` residual — RTL PROOF, and W62's certificate corrected

Before the struct landed, all three carried an identical 4-line residual:
ours `lbu a3 / sll a3 / addu a3 / lw a3,0(a3)`, retail `lbu a0 / sll a0 / addu a0 /
lw a3,0(a0)` — the sync-string index chain in `$a3` instead of `$a0`.

W62 filed this as *"a sched1 ready-list pick forced by the MIPS-I load-delay hazard
on the CD_com load"*. **That is the wrong object**: ours and the oracle were
instruction-for-instruction identical in that block; only the register differed, so
it was an ALLOCATION residual, not an order residual.

I proved the real cause from the `.lreg` RTL (`tools/qty272.py --keep`): sched1 had
placed

```
(insn 120 106 118 (set (reg:SI 4 a0) (symbol_ref:SI ("*$LC5"))))
```

— the printf **format-string** hard-reg move — in the MIDDLE of the arg block,
before insns 114/116 (the chain's `sll`/`addu`). `find_free_reg`
(local-alloc.c:2213, `for (ins = born_index; ins < dead_index; ins++)
IOR_HARD_REG_SET (used, regs_live_at[ins]);`) therefore excluded `$a0` for the
chain's qtys 92/106/107, and the ascending numeric scan fell through to `$a3`.
Retail's RTL had that move after the chain. Fixed as a side effect by §1.

**Falsified before the struct landed** (all re-gated, CD_datasync, 8 = baseline):
hoisted `syncName` local 17@91 · assignment-order swap 20 · 1-/2-operand read-only
fence on `syncIdx` 17@91 (the fence is NOT zero-insn here) · `syncIdx` typed
`unsigned char` / `unsigned int` INERT · sync index fully inline 20 · both indices
named 22 · named `comIdx` INERT · named format-string local INERT · named
`D_801489BC` local INERT · `*(intstr + i)` pointer spelling INERT ·
`puts` moved after the assignments 53@93 · `readyName`-first + named name 20 ·
per-fn `-fno-schedule-insns` 14 / `-fno-schedule-insns2` 37@93.

## 3. `CD_cw` 49 → 40, count-EXACT — SPLIT COUNT-TABLE BASE DERIVATION

`_cd_result_flag[0x40 + com]` folded to one `la sym+256` (2 insns) where retail
derives it from a base register:
`la tbl / addiu cnt,tbl,256 / addu idx,a0,cnt / lw 0(idx)`.
The `+ 0x40` must be **its own statement on a base pointer local**:

```c
tbl = _cd_result_flag;      /* own `la`, which GNU-as reorder-mode then SPLITS
                               across the following beqz -- filling our two nops */
...
cnt = tbl + 0x40;           /* the addiu */
if (cnt[com] > 0) do { ... } while (i < cnt[com]);
```

With `tbl[0x40 + com]` the index add happens first and the 256 folds into the
**load displacement** (`lw v0,256(v1)`) instead — a different, wrong shape.

**The unlaundered control won** (13B): identity-fenced `tbl` 44@261 vs plain 40@259.
Falsified (all re-gated *after* §1 — the w52/w62 receipts for these were
basin-stale): `tbl` for the flag too 49 · `tbl = _cd_result_flag + 0x40` 46@257 ·
index-first cast on the count 49 · SOTN's `[com + 0x40]` operand order INERT ·
read-only fence on `tbl` 42@261 · `tbl` before `ip` 40 (inert) · dropping the `ip`
identity fence 47 · `ip` read-only instead of identity 47 · double fence 52@261.

**Residual 40 = a 3-way LOCAL-ALLOC QTY ROTATION, no structure left.**
ours `{ip=$v1, tbl=$a1, maskedCom/idx=$a0 mutated in place}`;
retail `{ip=$a1, tbl=$v1 (reusing the register the masked com just vacated),
maskedCom=$v1 with a FRESH-DEST sll a0,v1,2}`. Two named sub-angles: (a) the
fresh-dest shift (W43 qty birth-order/fresh-dest pair — cse merges the `== 0xe`
mask and the index mask into one dying pseudo that `combine_regs` ties to the
shift's dest); (b) the `ip`/`tbl` `$v1↔$a1` swap, which is their local-alloc
priority order and moved under NO fence permutation — price it off the `-dl` qty
table before dialing further.

## 4. 🏆 `CdControl` 4 → PASS — predict-before-probe off the allocator dumps

Residual: the `command != 1` compare constant, retail `$t0`, ours `$v0`.

**Quantified first, dialed second** (`tools/qty272.py`):
* `.lreg` — every block-local qty in this fn is alone in its block, so
  `find_free_reg`'s ascending numeric scan can only ever return `$v0`. `$t0` is
  **unreachable from the local-alloc layer at any priority** (13A UNREACHABILITY
  TRIAGE).
* `.greg` — **nine** call-crossing allocnos already fill `s0–s7 + $fp`. A TENTH
  finds no callee-saved register, so `global.c` falls into its
  `CALLER_SAVE_PROFITABLE` retry and hands out a caller-saved temp — `$t0`, the
  first one not tied up by the loop's three calls' arg/return registers.

⇒ the constant must become a **call-crossing GLOBAL allocno**: name it and set it
in the preamble. **POSITION is the dial** (13A: both allocator layers tie-break on
pseudo number = first-use order) — as the **first statement of the function** →
PASS; one statement later → 9; inside the loop it stays block-local and cse
const-props it back → INERT 4.

Falsified: read-only fence 29 · identity launder 53 · `do { one = 1; } while (0)` 9 ·
Yoda `1 != command` INERT · `(unsigned char)cmd != 1` 25@80 · a second named
constant for the CdlSetloc `2` 7@80.

The pre-existing `PER_FN_TEXT_MOVES` row for `CdControl`/`CdControlB` **stays** (it
fixes the parm-copy order); its in-table note *"residual = a li v0/t0 register
substitution TEXT_MOVES cannot reach"* is now **closed from the source side** — no
new shim, no production-lane debt.

## 5. `CdGetToc2` — W62's cited mechanism REFUTED, the real gate read off `-dL`

W62-A6 blamed loop.c `scan_loop`'s "potential lossage" rule (2.8.1 loop.c:738-755)
substituting the division's own `0x66666667` into the `mult` and deleting the set.
**That rule never fires here.** The `-dL` loop dump (CC1PSX accepts it — W60-A1;
`tools/qty272.py` already writes the `.loop` file, so the instrument W62 asked for
already existed) prints:

```
Loop from 147 to 250: 31 real insns.
Insn 154: regno 117 (life 1), move-insn savings 1 not desirable
Insn 154: possible biv, reg 117, const = 1717986919      <- 0x66666667
```

The constant **is** entered as a movable; `move_movables` (loop.c:1640) declines it
on the budget inequality

```
already_moved[regno] || (threshold * savings * m->lifetime) >= insn_count
```

with `threshold = (loop_has_call ? 1 : 2) * (1 + n_non_fixed_regs)` (loop.c:535 —
this loop has a call, so the ×2 is lost), `savings = 1`, `lifetime = 1`,
`insn_count = 31`. **Shortfall = ONE unit of `savings` or `lifetime`** on that
movable; `force_movables` (loop.c:1195-1232, doubles savings and adds lifetimes)
and `combine_movables` are the named routes.

**Measured re-entry point:** `magic = 0x66666667;` moved INSIDE the loop makes it a
second movable that `combine_movables` merges with reg 117 — the hoist LANDS and
the count becomes **EXACT 137/137** — but the s-band rotates (54). Fence variants
in that basin: 1-operand `track_first` 18@135 · 3-operand 18@135 · magic-only 70 ·
no fence 64@135 · fence-before-assignment 22@137. That basin is structurally right
and 14 diffs from beating the current one.
Also falsified this pass: named `tens` BCD split INERT · 3-operand fence listing
`magic` twice 32@139 · duplicated `magic` assignment 32@139.

## 6. `CD_init_80108140` — the 10 decomposed

* **R1 (2 diffs) — pure CODE MOTION.** Retail emits `li $a0,1; move $a1,$0` (the
  `CD_cw(CdlNop,…)` arg setup) BEFORE the `la` of the Intr base; ours four insns
  later. Everything else identical ⇒ a `PER_FN_TEXT_MOVES` take/after row.
  **Spec drafted at `scratchpad/w63a5/moves_cd_init.json` but NOT submitted** — the
  anchors were derived from the `-dl` dump's `out.s` and did not fire against the
  build pipeline's `.s` (probe via `W60_TEXT_MOVES_FILE` showed no change), so it
  lacks the mandatory probe proof. Re-derive the anchors from the pipeline `.s`.
* **R2 (4 diffs) — 09L DELAY-SLOT CONFLICT, not a bare no-copy-prop artifact.**
  Retail's `li $v0,-1` sits in the FINAL `bne`'s delay slot; reorg can never fill a
  slot with an insn writing a register the branch READS
  (`reorg.c insn_sets_resource_p`), so retail's `addu $a0,$v0,$zero` copy is a
  CONSEQUENCE of that fill. The cure must stop reorg stealing the `-1` into the
  EARLIER CdlDemute `bnez` slot so it is still available for the `bne` — that
  reframes W62's falsified 12D staging attempts (they targeted the copy, not the
  steal).
* Re-gated (04Z): the `c` identity fence is now **INERT** (10 with and without);
  the `state` identity fence IS load-bearing (10 → 19@123 without).
* **Corpus angle certified equivalent, not a lever:** our store/reload/store Intr
  triple, sotn's chained `state[1] = state[2] = 0;` and psyz's two-statement
  `state[2] = 0; state[1] = state[2];` all gate identically at 10 @120/120.

## 7. Corpus notes (read-only, cited)

* `C:/Temp/psyz` @ `6d47e5e` — **CD_sync/CD_ready/CD_cw/CD_datasync are still
  `INCLUDE_ASM`** in `decomp/src/libcd/bios.c` (the orchestrator's mid-wave lead is
  correct to ignore psyz for those). psyz DOES carry matched `CD_init`
  (`bios.c:161`), `CdGetToc2` (`toc.c:6`) and the `cd_cw`/`CdControl` chain
  (`sys.c:100-140`).
* `C:/Temp/ps1-decomp-refs/sotn-decomp` @ `26390a0` —
  `src/main/psxsdk/libcd/bios.c` has ALL FOUR matched (`CD_sync:232`,
  `CD_ready:260`, `CD_cw:291`, `CD_datasync:459`) plus `set_alarm`/`get_alarm`.
  ⚠️ **Its PsyQ generation differs from NFS4's**: sotn/RR put the `com == CdlSetmode`
  test in the TAIL (`if (Intr.sync == CdlComplete && com == CdlSetmode)`), NFS4's
  oracle has it EARLY, before the sync clear. Port shapes selectively.
* `C:/Temp/rage-racer-decomp/src/main/PAL/lib/libcd/command_write.c` — byte-exact
  `CD_cw`; its `g_CdCommandClearsReady[command]` / `[0x40 + command]` two-window
  single table is the shape we already carry.

## 8. Hazards encountered

* `tools/qty272.py` has **no `--rtl` flag** (the docstring advertises one); use
  `--keep <dir>` and read `<tu>.i.lreg` / `.greg` / `.loop` directly.
* The three `CdControl*` bodies in `cdcont.c` are textually IDENTICAL in their
  preamble — every naive anchor hits 3 matches. Probe harnesses must slice the
  function region first (`scratchpad/w63a5/ccprobe.py` does).
* `toc.c` is CRLF while `drv.c`/`cdcont.c` are LF — checked byte-wise after every
  edit; the Edit tool preserved both regimes here, but `git diff --numstat`
  confirmed no whole-file rewrite.
* Concurrent-agent commits landed between my `git commit` and `git log -1`; my
  commits are intact (verify with `git log -- <file>`, not `-1`).

## 9. Files

* Source: `recon/syslib/psx/libcd/drv.c`, `cdcont.c`, `toc.c`.
* Backups/probe kit (this dir): `drv.c.bak` (pre-wave), `probe.py`, `probe2.py`,
  `ccprobe.py`, `alarmstruct.py`, `mkspecs*.py`, `spec_*.json`,
  `moves_cd_init.json` (UNPROVEN spec, do not wire as-is), `d2/`, `d3/` (dumps).
