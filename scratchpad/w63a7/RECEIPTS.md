# W63-A7 — libpad-A belt (PADSEQD / PADPORTD / PADMAIN + eaclib pad.c)

Base HEAD at start: `10e1a01b`. All numbers below are **my own re-gates** (`tools/verify_asm.py`
/ `tools/tugate.py`); every landing was gated twice and committed per-TU.

## 0. BASELINE RE-GATE (briefed % vs gate truth) — 1 of 9 rows was stale

| fn | TU | briefed | RE-GATED baseline | final |
|---|---|---|---|---|
| `_dirCheck` | PADSEQD.c | 99.09 | FAIL 4 @11/11 | **FAIL 1 @12/11** (+ a PROVEN TEXT_MOVES row → PASS 11/11) |
| `_dirFailAuto` | PADSEQD.c | 98.09 | FAIL 3 @56/55 | **PASS 55/55** |
| `_dirSendAuto` | PADSEQD.c | 99.92 | **already PASS** (stale row) | PASS |
| `_padInitDirSeq` | PADSEQD.c | 87.69 | FAIL 3 @14/13 | FAIL 3 — vendor certificate RE-VERIFIED |
| `_pad_failall` | PADPORTD.c | 93.57 | FAIL 17 @60/61 | FAIL 17 — certificate re-verified, 1 route named |
| `_pad_filter` | PADPORTD.c | 98.36 | FAIL 4 @159/159 | **FAIL 3 @158/159** (class (b) closed) |
| `_pad_getbyte` | PADPORTD.c | 92.13 | FAIL 5 @44/47 | FAIL 5 (re-gated only; see §6) |
| `_padInitSioMode` | PADMAIN.c | 98.67 | FAIL 24 @203/205 | FAIL 24 — residual DECOMPOSED |
| `PAD_update` | eaclib/psx/pad.c | 96.97 | FAIL 2 @66/66 | FAIL 2 — residual re-quantified |

Whole-TU, start → end: PADSEQD **2/5 → 3/5**, PADPORTD 5/8 → 5/8 (−1 diff),
PADMAIN 10/11 → 10/11, pad.c 4/5 → 4/5. **Zero PASS→FAIL anywhere.**
`tools/tu_order_audit.py`: 508 objects, **0 inversions**.

## 1. SEAL — `_dirFailAuto` 3 → PASS 55/55  (commit `f641ca02`)

Five waves had the mechanism right (two pseudos where retail has one, minted by cc1's own
expander: `li $v0,255 / move $v1,$v0 / j / sb $v1,0x46($s0)`) and the cure one step away.
**The shared-constant carrier is necessary but not sufficient** — on its own cse copy-propagates
it straight back into the two mode-specific pseudos (control `r = 0xff; info[0x46] =
(unsigned char)r; return r;` = **16 @57**). Adding the zero-insn **identity launder** between the
carrier's init and its two consumers seals it:

```c
info[0x49] = 2;
r = 0xff;
__asm__("" : "=r"(r) : "0"(r));   /* 13B: pseudo now dies twice -> combine_regs refuses */
info[0x46] = r;
return r;
```

The old `__asm__("" : : "r"(info))` use-fence is **retired** by this (PASS with or without it).
Falsified alongside: launder AFTER the store (3), read-only fence instead of identity (12 @57,
wrong direction per 12E), `unsigned char` carrier laundered (5), `return (info[0x46] = 0xff);`
with (3) / without (7) the info fence, plain shared-constant carriers (3/12/16), F5 `cnt` carrier
(5).

**LAW (catalog candidate).** 13B says "the copy IS the mechanism — copy dials exist only where the
emitted code already carries a real reg-reg copy". This is the same law read in the *opposite*
direction: **when the residual is an EXTRA reg-reg copy that `delete_noop_moves` will not remove,
the cure is not another spelling of the value — it is to make the SOURCE pseudo un-provable to
cse, i.e. the identity launder.**

## 2. `_dirCheck` 4 → 1  (commit `19ab2632`) + a PROVEN build.py row (§5)

The w62 conflict-set receipt was right about *why* `int ff = 0xff;` can never reach `$v0` (born
before the `lhu`, so it conflicts with the lhu's block-local qty which local_alloc homes in `$v0`)
— what it missed is that **retail's 0xFF and retail's returned 0 are the SAME pseudo**. One
variable that is (a) born inside the guard, (b) carries the compare constant, (c) is zeroed and
**returned** gets a `$v0` copy-preference from the return copy (13A SET_PREFERENCE) and is
multi-block, so *global_alloc* — not local_alloc — assigns it:

```c
int r;
if (*(unsigned short *)(info + 0xe6) != 0) {
    r = 0xff;
    if (info[0x46] == r) { r = 0; return r; }
}
return 1;
```

Every oracle instruction is now reproduced, `li $v0,255` in the beqz slot included. Residual 1 =
our reorg duplicating the shared return (`make_return_insns`, reorg.c:4289). 14 new
falsifications recorded in-source (goto-shared-exit 14 @13, else-arm single exit 14 @13, `if (0)
{ out: }` exit-block device 14 @13, early-out chains 5 @14, carrier at fn scope 7 @12, modeword
carrier 8 @11, literal-0 return 6 @11, …).

## 3. `_pad_filter` 4 → 3 @158/159 — class (b) CLOSED  (commit `6e576abb`)

`int e8 = info[0xe8];` kills the `andi …,255` remask (exactly as w61 measured) and the reason it
could not be landed then — cse SHARES that load with the `info[0xe8] == 3` arm, leaving us 1
short — is cured by a **zero-instruction opacity fence on `info`** at the head of that arm
(laundering the base makes the arm's MEM a different rtx). Measured: `int e8` alone 5 @158, +the
fence **3 @158**, fence alone 4 @159 (inert), laundered alias pointer `i2` 7 @158.
**Note the count:** 158 is the honest count — the old 159 had the *wrong* `andi` standing in for
the missing `slt` of class (a).

Class (a) re-read off the oracle: retail's first search loop **is** the guarded do-while
(`beqz $t1` entry guard @0x800FE144 + `slt $v0,$v1,$t1; bnez` back-edge @0x800FE174) — literally
the shape our *second* search loop already uses and matches. Re-falsified in the post-(b) basin:
that same shape on loop 1 = **43 @162** (with braces / without / with `*map++` fused, all
byte-identical), `while (i < nmask)` = 3 @160. **Named angle: the `break` is the discriminator** —
loop 1 has an early exit, loop 2 does not; the guarded-do-while+break combination adds 4 insns and
rotates the `$a2/$a3` band. Instrumented-cc1 job.

## 4. CERTIFICATES RE-VERIFIED

### `_padInitDirSeq` (vendor at-macro-split) — STANDS, and now MEASURED
* residual re-gated 3 @14/13, shape unchanged (oracle `lui $at,%hi(SYM); jr $ra; sw
  $v0,%lo(SYM)($at)`).
* **2.7.2-rung whole-TU A/B re-run in the NEW basin** (04Z — the previous A/B predated my
  `_dirCheck`/`_dirFailAuto` landings): DEFAULT **3/5 PASS, 4 diffs total** vs the rung **1/5 PASS,
  36 diffs** (`_padInitDirSeq` PASS but `_dirSendAuto` PASS→3, `_dirFailAuto` PASS→4, `_dirCheck`
  1→4, `_dirRecvAuto` PASS→25). Lane stays off.
* **NEW, and it strengthens the certificate:** the "TEXT_MOVES cannot express it" claim was
  *reasoned*; I measured it. Slotting the macro line (`take` the `sw $2,_padFuncRecvAuto`, `after`
  `j $31`, `slot:1`) gates **2 diffs at COUNT-EXACT 13/13** — but `objdump` shows maspsx expanded
  **both** halves after the branch (`jr ra; lui $at; sw $v0,0($at)`), so the store lands *past the
  return* and `_padFuncRecvAuto` is **never written**. A semantically dead function the gate scores
  2/13. **Do not wire that row.** The POST-maspsx rule spec'd in-source stays the only route.

### `_pad_failall` — STANDS; one route named that the certificate does not cover
Re-gated 17 @60/61, shape unchanged. Both closed routes hold as written. The certificate's
`prune_preferences` law bars a lower-priority rival from *pruning* a register the allocno itself
prefers — it does **not** stop a **higher-priority conflicting allocno from simply TAKING `$a0`
first** (find_reg then skips it as occupied; no preference question arises). So the open family is
"manufacture a higher-priority allocno that CONFLICTS with `flag`'s insn-1..20 window and lands
`$a0`", not "give a rival the `$a0` preference" (that one is closed). Everything live in that
window today is homed callee-saved (s0–s3), which is why w62's `nextp` probe did not conflict.
**Un-measured** — this belt ran out of budget before pricing it with allocsim/reqdelta272.

## 5. ORCHESTRATOR ACTION — one PER_FN_TEXT_MOVES row, proven

`scratchpad/w63a7/SPEC_text_moves_dirCheck.json` (also `tm_dircheck.json` = the bare probe file).

* WITH the row (`vprobe.py` + `W60_TEXT_MOVES_FILE`, **run twice, identical**):
  `_dirCheck` **PASS 11/11** | `_dirSendAuto` PASS | `_dirRecvAuto` PASS | `_dirFailAuto` PASS |
  `_padInitDirSeq` FAIL 3 (the certified class) ⇒ **4/5 PASS**.
* WITHOUT (tugate): `_dirCheck` FAIL 1, `_padInitDirSeq` FAIL 3 ⇒ 3/5 PASS. **Net +1 PASS, zero
  PASS→FAIL.**
* Anchors label-agnostic; the `after` anchor is lookahead-pinned on its `j $31` so it cannot grab
  either earlier `.set nomacro` (both followed by a `beq`); the `li` take carries `[^\n]*` for
  cc1's hex comment.
* **Semantics objdump-verified** (the `_padInitDirSeq` lesson): the spliced object is retail's
  exact 11 words with both branch targets landing on the oracle's labels.
* `recon/syslib/psx/libpad/PADSEQD.c` is **not** yet a key in `PER_FN_TEXT_MOVES` — grep before
  adding (12F duplicate-key shadowing).

## 6. RESIDUALS RE-QUANTIFIED (no landing, sharper receipts in-source)

* **`_padInitSioMode` (24 @203/205).** The w62-a5 launder device was re-applied, its paired
  follow-ups completed, then **unwound** per the hard-floor basin rule (26 > 24). What the detour
  bought: with the device the instruction stream is retail's **except two things** — (i) the frame
  (`-40/24/32/28` vs `-32/16/24/20`, 8 diff lines) and (ii) **one register**, `lbu $v0,54($s0)` vs
  retail `lbu $v1`, which mis-aligns the whole 8-insn tail in the LCS and costs **18 of the 26**.
  Two dials, not one; (ii) is the cheaper. Nine new falsifications: for (ii) named `int b` /
  laundered `int b` / `unsigned char b` test temps and a read-only fence on `one` (all 26 @205,
  byte-identical — the tail is canonicalized); for the phantom frame, naming the `JOY_CTRL` RMW
  operand, the `|=` spelling, and dropping `!= 0` from both `(JOY_STAT & 0x200)` tests (all 26,
  `vars=8` survives) ⇒ **the volatile-MMIO expressions are NOT the dangling-use owner** (13E),
  joining w62's list (`fix`, the JOY_DATA8 discards, the ternaries, block scope). `-dl`/`-dg` on
  the wired 2.7.2 rung remains the named next angle.
* **`PAD_update` (2 @66/66).** Position AND content of `btnOff`'s preheader init are **one** cause:
  retail's `btnOff` is a loop.c **giv** (giv preheader inits are appended after everything already
  there, in reverse creation order — the same law behind item 1's `$s2/$s1/$s0` order), so it is
  created after cse has run and there is no live 0 to copy; ours is a source **biv** whose init has
  the lowest luid, which cse rewrites into `addu $a3,$t0,$zero`. Re-measured in the post-TEXT_MOVES
  basin (the w50/w59 index numbers are basin-stale): `[i * 8]`, `[i << 3]`, `gPadinfo.buf[i].nopad`,
  and `btnOff = i * 8;` / `i << 3` assigned **inside** the body (giv candidate, not a biv) — **all
  five 13 @65**; explicit state walkers 12 @66, walkers with both inits in the header 4 @66,
  identity launder on `i` 21 @71 (×2 placements). Not TEXT_MOVES-expressible either (the line's
  *content* is wrong and TEXT_MOVES re-inserts what it took).
* **`_pad_getbyte` (5 @44/47).** Re-gated only; the residual is w61/w62's `do_cross_jump` DIRECTION
  class for case 0 (retail keeps case 0's own `lw 40; nop; addu; lbu` copy and lets the other arms
  jump into it). ~12 spellings already falsified across three waves and confirmed
  source-invariant; I added none and spent the budget on the bigger prizes.

## 7. PRODUCTION LANE (eaclib only; syslib = gate-parity per the brief)

`tools/psyqproof.py recon/eaclib/psx/pad.c PAD_update` → **REAL=10 RELOP=4** (65 words,
`-G4 -mno-split-addresses`, +1 padding word). The diffs are dominated by the two *gate-lane
mechanisms* this fn depends on: words 3–8 = the `PER_FN_TEXT_MOVES` prologue relocation, words
63–64 = `PER_FN_EPILOGUE_UNFILL` — i.e. `PAD_update` is a member of 14A's **shim-masked** class,
not a source divergence. No dual-lane seal is claimed (it is not gate-PASS either).

## 8. HAZARDS THAT FIRED

* **A receipt paragraph ending in `*/` closed its host comment** (PADMAIN.c) — the file compiled
  as garbage with errors pointing 90 lines away from the real cause. Caught by the mandatory
  post-edit gate. (3rd+ recorded firing; ends the paragraph with a `.` now.)
* **git index.lock contention** with a concurrent belt — retried with a back-off loop, no damage.
* Byte-hygiene (`\x00` / control-byte / CRLF-count) checked after every scripted edit; all four
  TUs stayed pure-CRLF.

## 9. FILES

* Touched (all committed): `recon/syslib/psx/libpad/PADSEQD.c`, `.../PADPORTD.c`, `.../PADMAIN.c`,
  `recon/eaclib/psx/pad.c`. Commits `19ab2632`, `f641ca02`, `f6d7cd03`, `168d3842`, `6e576abb`,
  `410827cf`, `d1cc53c8`.
* Scratchpad: `probe.py` (generic in-place variant probe — patches the REAL path, restores in
  `finally`, writes a restore log before any print), `sbsprobe.py`, `v_*.py` (the variant sets, so
  every falsification above is re-runnable verbatim), `SPEC_text_moves_dirCheck.json`,
  `tm_dircheck.json`, `tm_padinitdirseq_probe.json` (the falsified one — kept as the receipt),
  `orig.bak` / `probe_out.txt` / `sbs_out.txt` (last probe outputs).
* **Not touched:** `tools/*.py`, the memory dir, the user-live TUs, `PADMAIN.c.*.bak` (the user's
  `best42` basin file was read for context and left alone — the current source is far better at 24).
