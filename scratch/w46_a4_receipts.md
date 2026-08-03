# WAVE-46 a4 — hud.cpp NEAR RESIDUALS (receipts)

Base `main@6a43ac79`, branch `w46-a4`, worktree `C:/Temp/nfs4-wt46-a4`.
Full-TU floor held at **44 PASS / 0 regressions** after every landed edit.

## LEDGER (verify_asm, re-gated from the worktree root — the worklist was NOT used)

| fn | base | final | note |
|---|---|---|---|
| `Hud_BuildETimeString__FP4SPRTi` | 10 | **6** | LANDED, count-exact 99/99 |
| `Hud_BustedOverlayOn__FiPcbs` | 19 | **10** | LANDED, count now EXACT 110/110 (was 111) |
| `Hud_BuildRadar__Fi` | 4 | 4 | parked, count-exact 450/450, 15 spellings falsified + angle |
| `Hud_BuildTimeSprites__FP4SPRTPcii` | 21 | 21 | parked, **required delta QUANTIFIED** (allocsim/reqdelta) |
| `Hud_RenderTacView__Fv` | 35 | 35 | parked, **loop.c -dL table read**, hoist-defeat route CLOSED |
| `Hud_BuildString__FPciiiib` | 52 | 52 | parked, reqdelta CORRECTED, both dials shown unreachable |
| `Hud_Draw321Num__Fiiiiii` | 37 | 37 | not probed (budget); prior receipts intact |
| `Hud_Init__Fv` | 43 | 43 | not probed; **43 localised to 6 one-insn position swaps** |

## LEVERS LANDED

1. **BuildETimeString — divide the CLAMPED PARAM, not the abs.** `temp1 = time / 0x40;`
   instead of `temp2 / 0x40`.  `time` is already clamped >= 0 so it is the same value, but
   it splits the two roles onto two pseudos: expand_divmod's copy stops being combine-folded
   into the `+63` guard, so we emit retail's in-place `addiu v0,v0,63`.  10 -> 6.
2. **BustedOverlayOn — fresh array read for the sprintf index.**
   `BTCPerpInfo[player][Hud_NextPerp[player]].name` instead of `...[*psVar3]...`.  The
   pointer-local deref tied the load to `psVar3`, so the `BTC_Countdown` load and the
   `FinalBTC_Countdown` store issued back-to-back and paid a load-delay `nop` (our 111th
   insn).  The array read lets the scheduler interleave the sprintf address chain between
   them, exactly as retail does.  19 -> 10 and count becomes exact.

## NEW GENERAL ROWS FOR THE CATALOG

- **§C — "divide the clamped param, not the abs" (coalescing-DIRECTION splitter).**
  When an oracle applies a divide's `2^k-1` bias IN PLACE (`addiu r,r,63`) but ours folds
  the copy into the add (`addiu rD,rS,63`), the survivor and the dividend are the same C
  variable.  If the value has an independent, provably-equal spelling (here the clamped
  parameter), divide THAT and keep the named local for the other role.  No copy is written
  in the source, so nothing is left for cse to propagate away.
- **§F — "pointer-local deref vs fresh array read" as a load-delay dial.**
  `*p` where `p` is a cached pointer local pins the load to the pointer's live range and
  can force a `nop`; the equivalent `arr[i]` read is schedulable and lets an unrelated
  address chain fill the delay.  Same family as the w45 storage-shape menu, but at the
  *local pointer* level rather than the global's declaration.
- **§B/§A — the loop.c hoist budget is NOT reachable for savings*life >= 4.**
  `move_movables` moves iff `threshold*savings*lifetime >= insn_count`, with
  `threshold = (loop_has_call?1:2)*(1+n_non_fixed_regs)` ~= 61 decaying 3 per move
  (gcc-2.8.1 loop.c:535/1640/1728).  Only movables with `savings*lifetime == 1` sit near the
  razor.  Also: the three-case gate at loop.c:698 never blocks a COMPILER TEMP, because case
  (2) `!REG_USERVAR_P && !REG_LOOP_TEST_P` is satisfied regardless of `maybe_never` — so
  "put the movable in a conditionally-executed block" cannot work for an anonymous constant.
  ⇒ selective-hoist-defeat is only a real lever at savings*life == 1.
- **§A (correction) — the floor_log2 step is at the pseudo's OWN ref count, so a
  "refs >= 16" claim must be recomputed:** `floor_log2(13) == 3` already, so refs 13 can beat
  a rival that refs 9 cannot.  A wrong step boundary parked BuildString's dial for two waves.
- **§A — a loop-CARRIED pseudo's live length is not a dial.**  It is live in every block of
  the loop by construction, so `live < K` targets below the loop's own extent are
  unreachable and should be ruled out before any spelling sweep.

## TOOLS

- `tools/varprobe.py` (promoted from scratch): variants-file driven probe harness.  Applies
  each variant to the REAL TU path (PER_TU flags are path-keyed), gates it, restores in a
  `finally`.  Anchors are authored with `\n` and re-punctuated to the file's own line ending,
  so one variants file works on both LF and CRLF TUs.  Supports multi-anchor variants.
  Variants files used this wave are in this directory (`v_*.py`).

## BUGS

None found.  All eight functions are semantically clean at this base; both landed edits are
value-identical rewrites (`abs(time) == time` after the clamp; `*psVar3 == Hud_NextPerp[player]`).
