# W67-A8 RECEIPTS — frontend board belt (EA C++ dual-lane)

Base HEAD `77c09895`. Every number is my own re-gate (`tools/verify_asm.py`,
fresh `build.py --skip-asm` first). Harness: `scratchpad/w67a8/probe.py`
(byte-mode patch → gate → restore, asserts anchor count==1) + `show.py`
(one variant, VA_MAX full diff) + `sbs.py` (one variant, side_by_side).
Landed: **comment-only receipts** in 4 TUs + this file; zero codegen change;
all 5 belt TUs whole-gated 2×, **zero PASS→FAIL**.
User-live files (femenudefs.cpp, nfs4_types.h) never opened for writing.

## 0. LEDGER (briefed → my re-gated baseline → final)

| fn | TU | briefed | baseline | FINAL | outcome |
|---|---|---|---|---|---|
| StatChk_SaveTopTime__FP10Car_tStatss | statchk | 33 | **33** (417/416) | 33 | depth-wrapper axis fully priced: the 12E law reproduced on a SECOND instrument family (receipted) |
| FeAudio_InitViv__FPc | feaudio | 7 | **7** (110/109) | 7 | 🏆 the certificate's requested device FOUND (byteMask share → $a3, count-exact 8@109/109); basin trade 7@110 vs 8@109 → held; new blocker mechanism-named |
| FontUpsideDownBlit__FiiPviiP12charactertbli | psxfront | 20 | **20** (82/82) | 20 | qty half falsified in all 5 spellings; availability-loss certificate confirmed from the qty side |
| Draw__17tUserNameMenuItemb | femenuoptions | 8 | **8** (254/254) | 8 | the void-fence un-sharer FALSIFIED for the reload-remat angle (3 forms, all 67@253) |
| Redraw__14tFEApplication | feapp | 10 | **10** (393/393) | 10 | LAND-VS-HOLD decided: 14-basin stays BANKED (10 < 14 at equal count); decision receipted in-source |
| Front_InitOpponentCars__FR9tFEStream | front | verify | **PASS** (357) | PASS | w64a17 seal holds |
| DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii | psxfront | 7 | **7** (246/245) | 7 | w64a17 landing holds; mechanism-blocked residual, not touched |
| __15tGlobalMenuDefs | femenudefs | 3473 | **3473** (3182/3207) | 3473 | new-baseline confirmed post-vptr-wish; post-reload angle = instrument job, not attacked (alpha-rename receipt stands) |

Whole-TU gates after the receipt edits (each run 2×, tallies identical):
statchk 4/5 · feaudio 9/10 · femenuoptions 91/92 · feapp 14/15 · psxfront 23/25.

## 1. statchk SaveTopTime — the do-while(0) wrapper reproduces 12E (a second family)

Brief asked to combine the wrapper (non-fence ref instrument) with the register
half. Measured (all re-gated from 33 @417/416, all reverted):

| variant | diffs | insns |
|---|---|---|
| s2A wrapper replaces identity fence (RO carInfo kept) | 60 | 416 |
| s2C same, RO uBulkUnit fence dropped | 59 | 415 |
| s2D depth-2 wrapper | 60 | 416 |
| s2B wrapper + identity fence kept | 33 | 417 (inert) |
| s2E wrapper on the uBulkSz multiply, RO carInfo | **34** | **416** |
| s2F identity kept + wrapper on multiply | 33 | 417 (inert) |
| s2G s2F minus RO fence | 60 | 416 |
| s2H launder uBulkSz instead of uBulkUnit | 57 | 417 |
| s1F wrapper + identity-no-operand (uRecSz) | 110 | 416 |
| s1G wrapper, no fence | 111 | 413 |
| s1I depth-2, no fence | 111 | 413 |
| s1H wrapper + RO fence | 34 | 414 |
| s1J wrapper + full fence kept | 33 | 417 (inert) |

⚠️ s2E is count-EXACT but structurally FALSE: cse folds 20*8 through the
stripped phony loop into `li a2,160` — the retail `sll a2,t1,3` is gone. NOT
landed. ⇒ the wrapper buys only the count half (59–111), identical to every
other zero-insn device; the 12E certificate now stands on two instrument
families. Open item unchanged (retail's REG_EQUIV remat of the literal 20 —
instrumented-cc1 job).

## 2. 🏆 feaudio InitViv — the requested device EXISTS; certificate upgraded again

The W64-A16 corrected certificate asked for "a second live range whose SECOND
region does not add $a3 to the conflict set" and said none of the three
candidate block-2 words qualifies. **The un-tried 4th word qualifies**: sharing
the source word with block-2's `byteMask` (`swappedType = 0xff0000` + the three
mask uses) on the V4 read-only-result shape:

- **VJ = 8 diffs @ 109/109 COUNT-EXACT**, source word lands **$a3** on both
  sides (`lw a3,16(sp)`), carrier copy GONE.
- Residual 8 = ONE new mechanism-named blocker + one position pair:
  retail's last mask use is the dying-register triple
  `and a3,a1,a3 / srl a3,a3,8 / or a0,a0,a3`; ours keeps a fresh $v1 because
  **combine_regs cannot tie a fresh dest to a GLOBAL source pseudo**
  (local-alloc.c:1866 refuses `reg_qty < 0`) — the share that buys $a3 is
  exactly what blocks the tie. The in-place RMW spelling that would force the
  dest rotates the whole handout (46 @109). Position pair: retail floats the
  type `lw` between the la halves; ours is blocked by the "i"(0) fence.
- Basin trade: base 7 @110/109 vs VJ 8 @109/109 → **held at 7** (gate bar).
  VJ is the banked count-exact basin if the last-use tie is ever reached.

Falsified this wave (all re-gated): hlen shares at reservememadr/asyncload
sites (single foldable use → copy-propagated; 12 @109 = V4 control) VA/VC/VD;
fence-anchored def 66; full-addend carrier 26; no-fence share 34; VJ+numRMW 46;
VJ+hoist-load 13 @110; VJ+read-above-lumpyName 13 @110; VJ+fence-first 9 @110;
VE (share, no result fence) 34; VJ2 (share + identity kept) 26.

**CATALOG CANDIDATE:** *the 05D/§A "REG_BASIC_BLOCK < 0 promotion" device has a
composition boundary: the second-region value must not need a fresh-dest tie at
its own last use, because the promotion makes the pseudo global and
combine_regs then refuses every dying-register reuse of it
(local-alloc.c:1866). A share that buys the register can forfeit the dest.*

## 3. psxfront FontUpsideDownBlit — qty half closed at source level

All probes from the 20 basin (re-gated, reverted): named `nine` block-local
born before/after RMW2 = 20/20 (cse folds the synthetic constant back);
link value staged through dead `arg6` (bitfield store kept) = 20
(copy-propagated); RMW2 respelled scalar + staged through arg6 (12D route to
$v1) = 92 @78 — 4 insns SHORT (fold collapses the mask pair; same class as the
edgbla dv-split). ⇒ RMW2's read temp is anonymous and source-unreachable; its
$v0 ownership follows the tint's early death (the closed tint half). Route
unchanged: #E' instrumented-cc1 sched/find_free_reg trace.

## 4. femenuoptions Draw — the un-sharer axis closed

The screenmain void-fence %hi un-sharer probed as the wanted "stop cse sharing
one materialisation between the two blocks" device: literals + void fence at
block-2 head 67 @253; per-block unfenced decls + fence 67; fences at BOTH
heads 67; on top of the current fences 8 (inert). The volatile asm does not
invalidate cse's register-constant equivalence (unlike the cse2 cross-arm %hi
class it un-shared in screenmain). The reload-remat device still does not
exist at source level.

**CATALOG CANDIDATE:** *the void-fence un-sharer discriminates by CSE PASS:
it breaks cse2/-fcse-follow-jumps cross-arm register reuse (screenmain %hi)
but NOT cse1's in-path constant equivalence (femenuoptions 156) — check which
pass shares before spending it.*

## 5. Orchestrator actions
- NONE required for wiring. No build.py changes proposed this belt.
- femenudefs vptr item from w64a16 is DONE (new baseline 3473 confirms the
  header change landed).

## 6. Files / hazards
Touched (comment-only): `recon/frontend/common/{statchk,feaudio,femenuoptions,feapp}.cpp`,
`recon/frontend/psx/psxfront.cpp`. Byte-scan after every edit: 0 control
bytes, regimes preserved (statchk/feaudio/psxfront CRLF; femenuoptions/feapp LF).
Probe specs + harness: `scratchpad/w67a8/*.json`, `probe.py`, `show.py`, `sbs.py`,
`stt_base.diff`.
Hazards: none fired (Write tool only for escape-bearing content; no heredoc
probe scripts; probe harness restores verified by trailing re-gate each run).
