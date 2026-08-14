# W60-A4 — ROUND 2 (resume) receipts

Baseline re-taken after the tree moved (fresh `build.py --skip-asm`), belt gated twice at
the end.  `iso9660.c` still USER-DIRTY → SKIPPED-USER-LIVE, never opened for write.

| TU | baseline (round-2 start) | final |
|---|---|---|
| cdcont.c | 18/19, CdControl 8 | 18/19, CdControl 8 (**4 with the wiring row below**) |
| cdread.c | 3/6, _read_int 15, _read_issue 22, CdRead 43 | unchanged (**CdRead 38 @103/103 with the wiring row below**) |
| drv.c | 7/13, CD_datasync 8, CD_ready 8, CD_sync 8, **CD_get_intr 10**, CD_init_80108140 10, CD_cw 84 | 7/13, **CD_get_intr 8** in-source (**PASS 343/343 with the wiring rows**) |
| stcdint / streamhelp / toc / others | unchanged | unchanged |

Zero PASS→FAIL. One source commit this round (`drv.c` void-tail fence).

---

## (1) `CD_get_intr` — **PROBE-PASSING TEXT_MOVES, hand-off ready.  PASS 343/343.**

Probe harness: `scratchpad/w60a4/vprobe.py` — a scratchpad COPY of `tools/verify_asm.py`
that patches `bld.PER_FN_TEXT_MOVES` (and `PER_TU_FLAGS` / `PER_FN_FLAG_SPLICE_272`, and a
generic per-fn flag splice) **in memory** from JSON files named by env vars.  It therefore
runs the REAL 272 pipeline and the REAL gate — `_apply_text_moves` is build.py's own, not a
replica, so there is no replication drift.  Env: `W60_TEXT_MOVES_FILE`, `W60_TU_FLAGS`,
`W60_FN_FLAGS`, `W60_FN_SPLICE_FILE`.  Generator for the tables: `scratchpad/w60a4/mkmoves.py`
(raw strings in a FILE — see the hazard note at the bottom).

**Ladder of evidence:** moves alone `10 → 2`; the in-source void-tail fence alone `10 → 8`;
**both → PASS 343/343**.  Whole-TU with the moves applied: CD_sync 8, CD_ready 8, CD_cw 84,
CD_datasync 8, CD_init_80108140 10, and CD_flush / CD_initvol / CD_initintr / CD_getsector /
CD_getsector2 / CD_set_test_parmnum / _cd_intr_dispatch all still PASS — i.e. **zero
PASS→FAIL, and the only row that changes is CD_get_intr.**

```python
PER_FN_TEXT_MOVES["recon/syslib/psx/libcd/drv.c"] = {
    "CD_get_intr": [
        # switch case 4: retail emits the _memcpy8 DEST `la` BEFORE the Intr-base `la`.
        {"take":  r"\tla\t\$2,D_8013C224\n(?= \#APP\n \#NO_APP\n\tla\t\$4,D_801489AC\n)",
         "after": r"\tla\t\$4,D_801489AC\n"},
        # switch case 5: same swap.
        {"take":  r"\tla\t\$2,D_8013C224\n(?= \#APP\n \#NO_APP\n\tla\t\$4,D_8014899C\n)",
         "after": r"\tla\t\$4,D_8014899C\n"},
    ],
}
```

**Both rows are LABEL-AGNOSTIC** (w60-a8 `$L` law): the disambiguation is a **lookahead** on
the following `la $4,<dest>` line, not a `$Ln` anchor.  `la $2,D_8013C224` occurs 6× in the
TU and 3× inside `CD_get_intr` alone, so the lookahead is load-bearing; the lookahead text
is NOT part of `tk.group(0)`, so only the one `la` line moves.  `la $4,D_801489AC` and
`la $4,D_8014899C` are each unique inside the function region (the other `D_8014899C`
references in the region are `la $3,…`).  The ` #APP\n #NO_APP\n` pair between them is the
empty identity fence that pins the Intr base — it must be matched, hence the `\#` escapes.

**Why a source lever cannot do it (falsified in-source):** a `dst` local declared before the
fenced base leaves the `.s` order unchanged (10); the same with the `_memcpy8` call pulled
inside the block (10); an identity fence on `dst` as well (32).  The identity fence on the
Intr base is a scheduling barrier the dest `la` cannot cross.

### The paired source landing (committed): the last 2 diffs
`li $2,5` was being **copied** into the `beq $2,$0` delay slot of the `_cd_status_ok` test
(reorg's `steal_delay_list_from_target`: the branch is redirected past the stolen insn, so
the label moves after it).  Retail has a plain `nop` there and only ONE `li v0,5`
(instruction multiset: ours 4× `li v0,5` / 30 nops, oracle 3× / 31).  A **zero-insn
void-tail fence at the HEAD of the `nReg == 5` thread** makes the thread unstealable (the
CdInit device).  Placed INSIDE the block instead of before it = 2 (the steal happens at the
thread head).

---

## (2) `CdControl` — **PROBE-VERIFIED TEXT_MOVES row, 8 → 4.  Not PASS.**

```python
PER_FN_TEXT_MOVES["recon/syslib/psx/libcd/cdcont.c"] = {
    "CdControl": [
        {"take":  r"\tsw\t\$20,32\(\$sp\)\n\taddu\t\$20,\$4,\$0\n",
         "after": r"\taddu\t\$18,\$6,\$0\n"},
    ],
}
```
Label-agnostic and unique (one `sw $20,32($sp)` and one `addu $18,$6,$0` in the region).
Moves the `cmd = com` parm-copy pair up two slots so the prologue reads
`s1 ← a1 · s2 ← a2 · s4 ← a0 · s0 ← 3` like retail, instead of ours' `… s0 ← 3 · s4 ← a0`.

**Residual after the row = 4 diffs = ONE 2-instruction register substitution:**
`li v0,1 / beq s3,v0` (ours) vs `li t0,1 / beq s3,t0` (retail) for the `command != 1`
constant.  A TEXT_MOVES cannot touch a register.  Source levers falsified this round (all
measured WITH the row applied): Yoda `1 != command` **4** · `command - 1 != 0` **4** ·
a named `int cmdNop = 1;` local **9** (and 78 insns, −1) · the same + a read-only fence
**29** · a void fence at the loop head **4**.  Earlier rounds: statement-order permutations
inert, Rage Racer's identity fence on `cmd` **22**, whole-TU `-fno-schedule-insns` worse.
⇒ receipted local-alloc handout of an anonymous constant (06E class).

---

## (3) `CdRead` — the w59-a7 wiring **RE-VALIDATED at the current basin: 43 → 38 @103/103**

The block RE-LAY I named last round turns out to be already spec'd in-source by w59-a7 and
it is a WIRING, not a source edit.  I re-priced it with a generic per-fn flag splice injected
into `_apply_fn_splice` from the scratchpad (`W60_FN_SPLICE_FILE`, `scratchpad/w60a4/splice1.json`):

```python
PER_FN_NO_SPLIT_ADDRESSES = {"recon/syslib/psx/libcd/cdread.c": {"CdRead"}}
# + one tuple in _apply_fn_splice's table list:
#     (PER_FN_NO_SPLIT_ADDRESSES, "-mno-split-addresses", "nosplit")
```
**Whole-TU with the splice, measured this round:** CdRead **43 → 38 and count-EXACT
103/103** (was 102/103), `CdReadSync` PASS, `_read_sync` PASS, `_read_data_int` PASS,
`_read_int` 15, `_read_issue` 22 — i.e. **zero PASS→FAIL and no other row moves** (the
2.8.1 per-fn version splice you wired for `_read_int`/`_read_issue` composes cleanly with it).
Whole-TU `no_split_addresses` remains a net loss, so it must stay per-FN.

Mechanism (w59-a7, re-confirmed by the sbs): the 5 missing instructions are cc1's PRE-SPLIT
`lui/addiu` address halves — three stray `lui $v1` copies scattered across the switch arms.
With split-addresses off cc1 emits the `la` MACRO and they collapse; retail's shape is one
`la $a0,_cdr` anchor materialized in the mode-check block and REUSED by all three error-exit
stubs, each of which carries **its own** `sw v0,16(a0)` tail (09J "each arm carries its own
tail") instead of our shared, re-materialized `sw v0,16(v1)` merge point.

Idiom cross-check (new corpora, read-only): `C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\read.c`
and `command_control.c` — RR spells the same libcd bodies we do; its byte-exactness is bought
with `register … asm("$N")` pins we cannot use, which is precisely why our anchors need the
w49 identity fences.  No new C idiom to import for CdRead.

---

## (4) THE 8×3 SHARED TIMEOUT-PRINTF RESIDUAL — **sched1 instrument run; HARDNESS CERTIFICATE**

Per the mid-run intel: the real lane binary
`C:\Temp\nfs3-clean\psyq400\COMPILER\CC1PSX.EXE` (2.7.2.SN32) **does accept `-dS`**.
Reproduce with the drv.c lane's exact flags:

```
cd scratchpad/w60a4/sched
CC1PSX.EXE -quiet -O2 -G0 -mgas -fno-strength-reduce -dS drv.i -o drv.s
#   -> drv.i.sched   (400 KB; per-BB ready-list trace + post-sched1 RTL)
```

### The evidence (CD_datasync, basic block 3 = the whole timeout-printf arg block)

Per-insn priority table from the dump:
```
;; insn[  86]: priority = 1   <- reg92 = Intr.sync            (lbu)      the SYNC CHAIN
;; insn[  94]: priority = 2   <- reg96 = reg93 << 2
;; insn[  96]: priority = 2   <- reg97 = reg96 + statusNames
;; insn[  98]: priority = 2   <- reg90 = *reg97               (readyName)
;; insn[ 106]: priority = 1   <- reg101 = zero_extend(mem CD_com)        a LOAD
;; insn[ 118]: priority = 3   <- mem(sp+16) = reg90           (5th arg)
;; insn[ 120]: priority = 1   <- (set (reg:SI 4 a0) (symbol_ref "*$LC5"))   <<< THE HOIST
```
gcc-2.7.2's MIPS sched1 is a **BACKWARD list scheduler** (T-1 = last insn of the block).
`insn 120` has the **lowest priority in the block (1) and ref_count 1**, so it sits unpicked
in the ready list from T-5 all the way to T-14, and then:

```
;; ready list at T-13: 118 (3) 120 (1), now 118 120
;; launching 106 before 118 with no stalls at T-14
;; ready list at T-14: 120 (1) 106 (7f000001)
;; blocking insn 106 for 1 cycles, now 120          <<<<<<
;; launching 106 before 120 with no stalls at T-15
;; ready list at T-15: 106 (7f000001) 98 (7f000001), now 106 98
```

**So the hoist is NOT a priority inversion — it is a LOAD-DELAY FILLER pick.**  At T-14 the
only two ready insns are the `CD_com` load (106) and the `$LC5` set (120); 106 is
**hazard-blocked for 1 cycle** (its consumer `109 = reg101 << 2` was already placed at
T-12, and MIPS-I exposes the load delay), so the scheduler is forced to take 120.  Backward
placement at T-14 = forward position BEFORE the whole sync chain ⇒ `$a0` is live across the
chain's qtys ⇒ local-alloc's numeric first-free scan skips `$a0/$a1/$a2` and lands the chain
on `$a3` (self-temp) where retail has the separate `$a0` scratch.  This confirms the W55-A5
diagnosis from the LANE'S OWN BINARY and sharpens it from "sched1 hoisted it" to the exact
cycle and the exact reason.

**Identical in all three functions** (same dump):
`CD_sync` insn 124 (`$LC5`) priority 1 / ref 1, `blocking insn 110 for 1 cycles, now 124`;
`CD_ready` insn 127 priority 1 / ref 1, `blocking insn 113 for 1 cycles, now 127`;
`CD_datasync` insn 120 priority 1 / ref 1, `blocking insn 106 for 1 cycles, now 120`.
One mechanism, three functions, 8 diffs each.

### Can any source lever starve the hoist? — the certificate

`INSN_PRIORITY` in gcc-2.7.2's sched is the length of the longest dependency path to the
block end.  The format-string argument's path is **1 by construction** (a `symbol_ref` move
straight into the outgoing arg register, consumed only by the `call`), so it will always be
the lowest-priority insn in the block.  It gets picked at T-14 **because it is the only other
ready candidate when the `CD_com` load is hazard-blocked.**  Therefore a lever must either

  (a) **raise insn 120's priority** — impossible without inserting a real instruction between
      the `la` and the call (every such insn is a new diff), or
  (b) **supply a THIRD ready insn at that cycle** — likewise a new instruction, or
  (c) **remove the load-use hazard on `CD_com`** so 106 is pickable at T-14.

(c) is the only free one, and it is now **FALSIFIED, dump-informed** (measured on
`CD_datasync`, the 8-diff instance, all count-exact 90/90):
`char *cmdName = CD_comstr[CD_com];` hoisted ABOVE `puts()` → **8** ·
`int comIdx = CD_com;` hoisted above `puts()` → **8** ·
`cmdName` assigned AFTER `puts()` but before the printf → **8**.
gcc regenerates the whole outgoing-argument block inside `expand_call`, so a source-level
hoist of the index/pointer is sunk straight back and the T-14 hazard is unchanged.

Together with the previously receipted falsifications (naming the format string as a local 8 ·
naming it first 8 · identity fence on it 47 · `unsigned char syncIdx` 8 · identity fence on
syncIdx 17 · naming `comstr[CD_com]` 22 · a `syncSlot` pointer 12 · per-fn
`-fno-schedule-insns` 14 · `-fno-schedule-insns2` 37 · `-fno-delayed-branch` 17) and the
re-run gcc ladder (2.7.2 == wired on all 7 drv.c fns; 2.6.0/2.6.3 equal-or-worse; every 2.8+
rung catastrophic — CD_datasync 77, CD_get_intr 271):

> **CERTIFICATE.** The 8×3 residual is a single sched1 ready-list pick forced by a MIPS-I
> load-delay hazard.  It is not reachable by any zero-instruction source device, because the
> only three ways to change the pick each require adding an instruction to the block, and the
> one free route (removing the `CD_com` load-use hazard from the source) is falsified — the
> arg block is re-expanded by `expand_call` after any source hoist.  The remaining routes are
> BUILD-SIDE and out of an agent's scope: a per-fn sched1 priority/tie-break dial, or an
> `-fsched-*` per-fn splice (the three whole-flag variants are all measured worse).

Note for the allocator side (per the mid-run intel): the downstream register choice here is a
**local-alloc `find_free_reg` numeric first-free scan**, not a global allocno — so it is
outside both `allocsim`/`reqdelta` and the new `qty272`/`reqdelta272` (which model the global
`.greg` table).  The `allocno_compare` SIZE-term correction does not apply: every pseudo in
this block is SImode/QImode-in-SImode, and the decision is made before global alloc runs.

---

## (5) Idiom-corpora sweep (read-only; nothing edited)

- `C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\initialization_and_toc.c :: CdGetToc2`
  spells the BCD conversion exactly as we do — `((firstTrack / 10) << 4) + (firstTrack % 10)`
  — i.e. **the plain `/10` is confirmed as the retail-era source form**, and RR buys its
  byte-exactness with `register u_char *ptr asm("$17")`, which we cannot use.  That validates
  this wave's magic-reciprocal fence as the pin-free substitute for RR's pin.
  🔑 **NEW NAMED ANGLE (unmeasured, basin-stale evidence):** the in-source receipt's "FULL
  Rage Racer body reaches the oracle's EXACT 137 instructions but rotates the whole s-register
  handout (71 → 112)" was measured **before** `$s5` was occupied by the hoisted magic.  The
  RR body + this wave's in-loop read-only fence is a joint cell that has never been tested;
  the s-band rotation RR caused may now be the CORRECT band.  Worth one probe next wave.
- `C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\command_control.c :: CdControl` — already
  mined (its identity fence on `cmd` is measured 22 here; RR needs the `$20` pin we don't).
- `C:\Temp\ps1-decomp-refs\*` — grepped for `CdGetToc`/`CdControlB`: the hits
  (`CTR-in-C/.../LOAD_InitCD_8007c208.c`, `ff7-decomp/src/main/psxsdk.c`,
  `mgs_reversing/...`, `parasite-eve-2-decomp/src/main/boot.c`) are all **CALLERS**, not
  matched libcd bodies.  No libcd twin beyond rage-racer and psyz.  Recorded so nobody
  re-greps.

---

## (6) TOOLS / HAZARDS (round 2)

- **`scratchpad/w60a4/vprobe.py`** now carries four in-memory hooks (`W60_TU_FLAGS`,
  `W60_FN_FLAGS`, `W60_TEXT_MOVES_FILE`, `W60_FN_SPLICE_FILE`).  The last one wraps
  `bld._apply_fn_splice` to run a GENERIC per-fn flag splice for any `{rel: {flag: [fns]}}`
  — that is how the `-mno-split-addresses` row above was priced without a build.py edit.
  `scratchpad/w60a4/vsbs.py` = the same trick over `tools/sbs.py`.  **Promotion candidates**:
  together they let any agent price a TU-flag / fn-flag / fn-rung / TEXT_MOVES wiring through
  the REAL gate with zero risk to `tools/`.
- ⚠️ **A3's `probe_272.py` REAL/reloc classification bug — CONFIRMED and AVOIDED.** Its rule
  `if a.split()[:1] == b.split()[:1]: reloc` calls any same-mnemonic word mismatch a reloc, so
  a pure REGISTER difference (`li v0,1` vs `li t0,1`, `lbu a3,..` vs `lbu a0,..`) is scored
  vacuously clean.  I did not reuse it: every number above comes from the real
  `verify_asm`/`tugate` gate through `vprobe.py`.  If it is kept, the fix is to mark a word
  mismatch `reloc` **only** when `objdump -dr` shows a relocation on that instruction.
- 🔴 **HEREDOC BACKSLASH COLLAPSE fired again (this wave's 3rd, the campaign's ~8th)** — and
  this time inside a *quoted* `<<'PY'` delimiter: a `b'...\\n...'` literal intended to match
  the C source's two characters `\` `n` arrived as a real newline, so a `.count(...) == 1`
  assertion failed with 0.  Had I not asserted, the replace would have been a **silent
  no-op** and I would have receipted three probes as "inert" that never ran.  (That exact
  false-inert did happen earlier this wave with `\r\n` patterns.)  `probe_sched.py` is
  therefore written with the **Write tool** and builds the backslash numerically
  (`BS = bytes([92])`).  **Standing rule reconfirmed: any probe whose pattern contains a
  backslash must be delivered by Write/Edit, never a heredoc — and every scripted replace
  must assert its match count before writing.**
- `tools/tugate.py`'s compile-error masking is fixed upstream this wave — confirmed working
  (a broken TU now reports the cc1 diagnostics instead of the `_name2addr` AttributeError).
