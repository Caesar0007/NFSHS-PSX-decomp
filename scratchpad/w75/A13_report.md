# W75-A13 -- night + overlays belt (NFS4-PSX matching decomp)

Base: repo `C:\Temp\nfs4-decomp`, shared clone (concurrent human/agent sessions active).
No commits, no staging. Memory dir untouched. `tools/build.py`'s foreign edit preserved
(verified byte-identical after every probe; a second foreign edit -- W75-A15 TEXT_MOVES rows --
landed under me mid-belt and was NOT clobbered).

## RESULT (headline)

| fn | TU | baseline | final | count |
|---|---|---|---|---|
| `Night_CreateNightTableElement__FiliPUc` | game/psx/night | 26 | **26** | 113/113 (exact) |
| `RaceStatistics__Fv` | game/psx/overlays | 71 | **71** | 474/475 |

TU gates, run TWICE before and after every edit: `night.cpp 18/19 PASS`, `overlays.cpp 4/5 PASS`.
**ZERO PASS -> FAIL anywhere.** No fn sealed this belt; both targets produced a NEW NAMED ANGLE
with compiler-source citations, and one of them REFUTES the standing verdict. Source edits are
receipt comments only; one real tool bug was found and fixed.

---

## 1. Night_CreateNightTableElement -- the W72/W74 "codegen identity" verdict is REFUTED

The banked verdict was: *"the by-value CVECTOR OR-tree accumulator's home is a 2.8.0-vs-2.8.1
identity inside `extract_split_bit_field`; no source spelling can reach it."*
That is wrong in its mechanism. The real cause is a **local-alloc ELIGIBILITY GATE**.

### Measurement (both compilers, the SAME `.i`)

`CC1PLPSX` (PsyQ 2.8.0) and `C:/Temp/nfs4-instr-cc1/cc1plus-ecoff.exe` (FSF 2.8.1,
`-funsigned-char`), both `-O2 -G8`, dumps `-dc -dl`. Copies under `scratchpad/w75/A13/`
(`psyq/`, `instr/`, `psyq_fn.s`, `i281_fn.s`, `psyq_comb.txt`, `i281_comb.txt`,
`psyq_lreg.txt`, `i281_lreg.txt`).

* The two `.s` bodies differ in **exactly the accumulator register**: 2.8.0 runs the OR-tree in
  `$v1` and ORs into `$a0` only on the last term; 2.8.1 runs it in `$a0` throughout (= retail).
  Same insn count, same schedule, same everything else.
* The **combine dumps are insn-for-insn identical, same pseudo numbers**, with ONE exception:
  2.8.0 carries an extra insn

      (insn 320 139 141 (use (reg:SI 137)) -1 (nil)
          (expr_list:REG_DEAD (reg:SI 137) (nil)))

  parked immediately after `(code_label 139)` = the join label of the `newB` clamp = the head of
  the pack block's basic block. `reg 137` IS the ior accumulator (set at insns 196/202, consumed
  by `(set (reg a0) (ior 137 150))` at insn 205).

### Provenance of that insn (cited)

`combine.c distribute_notes`, REG_DEAD case: the backward walk
`for (tem = prev_nonnote_insn (i3); place == 0 && tem && (INSN || CALL_INSN); tem = prev_nonnote_insn (tem))`
(2.8.1 `combine.c:11298`) finds no home, stops on the CODE_LABEL, and `combine.c:11396` does
`place = emit_insn_after (gen_rtx (USE, VOIDmode, XEXP (note, 0)), tem)`, hanging the death note
on a synthetic USE.

The only 2.8.0 -> 2.8.1 ChangeLog entries touching that code are
`combine.c (distribute_notes, case REG_DEAD): ... use reg_bitfield_target_p` (Sat Feb 14 1998) and
`combine.c (distribute_notes): Completely check for note operand being only partially set on
potential note target` (Thu Feb 12 1998). **There is NO `expmed.c` entry in the 2.8.0..2.8.1
window at all** -- `extract_split_bit_field` is the same code in both, exactly as the dumps show.
(ChangeLog extracted to `scratchpad/w75/A13/gcc-2.8.1/ChangeLog`; 2.8.0 released Wed Jan 7 1998
line 657, 2.8.1 Mon Mar 2 1998 line 1.)

### Why the extra USE costs the register (cited)

It makes `REG_N_DEATHS(137) == 2` -- `.lreg` prints
`Register 137 used 10 times across 7 insns in block 6; dies in 2 places` (2.8.0) vs
`Register 137 used 10 times across 6 insns in block 6` (2.8.1).
`local-alloc.c:472` admits a pseudo to LOCAL allocation only when

    REG_BASIC_BLOCK (i) >= 0 && REG_N_DEATHS (i) == 1

so 2.8.0 sets `reg_qty[137] = -1` and skips it. **The handouts prove it**: the 2.8.1 `.lreg` prints
`;; Register 137 in 4.` ($a0 = retail's accumulator home) and the 2.8.0 `.lreg` prints no line for
137 at all. What follows is forced: local-alloc hands the block-local byte temps their registers
first (`reg 139 -> $v1`; `reg 150`, the `lbu 19(sp)` byte, `-> $a0` INSIDE 137's live range), and
`global_alloc` -- which DOES record a `hard_reg_preference` of `$a0` for 137 (`global.c:1351`
`mark_reg_store` -> `:1538` `set_preference`, the `'e'`-format branch off the IOR, `copy = 0`) --
finds `$a0` occupied across 137's whole range and prunes it (`global.c:1033`). 137 -> `$v1`.
That is the entire 26.

### The bound (why no 2.8.0 spelling reaches it)

* The orphan is invariant under the shape. Death-count instrument (added to
  `scratchpad/w75/A13/probe.py --rtl`): SHIPPED basin 2 deaths, SLD-natural r,g,b basin 2 deaths,
  and a **branchless `newB` clamp that deletes the clamp-join CODE_LABEL outright** still 2 deaths
  (63 diffs @114) -- the walk simply stops at the next label up. `combine.c:11396` fires whenever
  `tem != 0`, i.e. anywhere but the very first insn of a function.
* `$a0` cannot be freed for 137 by the 20B family: `reg 150` is born AND dies strictly inside 137's
  live range, so any zero-insn clobber denying `$a0` to 150 denies it to 137 too (22B-1
  clobber-live-range placement law).

### New axes swept and falsified this wave (on top of w50/w63/w71's 123 cells and W74's four)

| axis | result |
|---|---|
| 23A-3 STATEMENT-COUNT LIFETIME DIAL: the three pack stores merged into ONE comma statement -- rgb / rgb+readback / bgr+readback / bgr+readback+`newR` all in the comma | 56 / 56 / 26 / 26; the last two **BIT-IDENTICAL** to the shipped form (the three stores are already one basic block, so no luid moves) |
| branchless min for the last clamp (`d = newB-0xff; newB = 0xff + (d & (d>>31))`) | 63 @114, deaths still 2 |
| `newColor.cd = 0` (does make cse forward all four bytes) | 20 diffs but **@111, three insns SHORT** and unfaithful -- retail's oracle reloads `0x13(sp)` with no preceding store |
| 23A-1 scratch write-through / 23A-2 reload_cse donor re-checked against this basin | neither applies: no `movstrsi` block move in the fn, and the residual carries no `addu rD,rS,zero`-for-a-constant tell |

### NAMED ANGLE (replaces "wire a 2.8.1 cc1plus for the pack block")

The wanted effect is **`REG_N_DEATHS(accumulator) == 1`**, i.e. keep combine from orphaning that
one death note. The instrument that would settle it is a **`[distribute_notes]` trace** on the
instrumented cc1plus naming the `(i3, from_insn)` pair whose `REG_DEAD (reg 137)` goes homeless --
same class of named instrument ask as 23D-1's `[reload_pick]`. A whole-function cc1plus version
splice would of course also fix it, but it is no longer the only description of the problem, and
the pending USER DECISION on wiring an FSF 2.8.1 cc1plus is now a decision about a *convenience*,
not about the only known route. **No compiler binary was wired; `build.py` untouched.**

Receipt written into `recon/game/psx/night.cpp` above the `newB` clamp.

---

## 2. tools/gprobe.py MEASURED VACUOUSLY -- found, reproduced, FIXED (ledger impact)

`tools/gprobe.py` (the per-TU `-G` / `-mno-split-addresses` identity prober) re-read the
**already-patched** `tools/build.py` in `with_flags()` instead of the pristine text. Each
candidate's `PER_TU_FLAGS` row therefore ACCUMULATED at the top of the dict literal; with
duplicate keys the LAST (= oldest-inserted) row wins, so **every cell after the first
non-baseline one silently re-measured candidate #2**.

Repro on `recon/game/psx/overlays.cpp`: old tool printed `71 / 71 / 71 / 71 / 71`; an instrumented
copy shows the file growing `183686 -> 183740 -> 183794 -> 183860 -> 183942` bytes across the five
cells. The TRUE ladder (independent byte-mode prober `scratchpad/w75/A13/flagprobe.py`, then the
FIXED gprobe, agreeing exactly) is:

    baseline 71 . g_value=8 71 (BIT-IDENTICAL) . g_value=0 215 . no_split 598 . g8+nosplit 598

Fixed in `tools/gprobe.py` (`src = orig`, with the mechanism written into the comment).

**LEDGER CONSEQUENCE (for the orchestrator):** any "-G INERT" verdict produced with the old tool is
trustworthy only for its `g_value=8` cell. In particular `tools/build.py`'s own w47-a7 census
comment -- *"INERT (no gate delta, left at default): aih_play, dashhud, mpause, hrzsku, overlays,
psxcontroller, textureprocess"* -- says nothing about `g_value=0` / `-mno-split-addresses` /
`g8+nosplit` on those seven TUs. Worth a re-run sweep with the fixed tool.

---

## 3. RaceStatistics -- 71 stays, three re-priced/reclassified clusters

Residual anatomy (`scratchpad/w75/A13/rs_sbs.txt`, 51 X-lines):
head/prologue 25 . `Cars_gHumanRaceCarList` addresses 18 . `fp<->s1` pair 6 . col1 copy 2
(the col1 copy is the one insn we are short: retail `addiu v1,s4,10; addu s6,v1,zero`).

### (a) Flag-identity axis honestly closed (fixed tool + independent prober, 2x)

baseline 71 . `g_value=8` 71 (bit-identical) . `g_value=0` 215 . `-mno-split-addresses` 598 .
g8+nosplit 598 . `-fno-schedule-insns` 744 . `-fno-schedule-insns2` 416 .
`-fno-delayed-branch` 634. (Whole-TU totals over the 5 gated fns.)

### (b) 04Z re-pricing from the 71 basin (the W72 ledger was priced at 77 and it MOVED)

| cell | W72 basin | W75 basin |
|---|---|---|
| `rows` named local (product kept live for both SIZE_H arms) | 81 @472 | **73 @474** |
| rows x pitch-fence at the assignment / after SIZE_W / after POS_X / after the raceType arm | -- | 73 / 77 / 75 / 73 |
| named `cx` = 160 + fence | 82 | 104 @475 |
| col1 explicit temp | 87 | 98 @477 |
| col1 temp + availability fence on the temp | -- | 89 @474 |
| col1 temp, fence sunk one statement (outside the block, per 23A-4) | -- | 87 @474 |
| fence on the re-read `POS_X + 0xa` expression | -- | 93 @474 |

With `rows` the head becomes structurally retail's -- `addiu a1,a1,28; sh a1,88(sp)` == oracle
`addiu a0,a0,28`, replacing the const-folded `li t1,52` -- and the only residual there is the
`a0/a2/v1/a1` band rotation. **No col1 spelling mints retail's `addu s6,v1,zero`** (all stay 474).

### (c) The 18-diff address cluster is RECLASSIFIED (the useful part)

It is neither an access spelling (W71 already falsified index-term-first) nor an allocno question.
A zero-insn **reload-POOL PROBER** (catalog 23D-3) `__asm__("" : : "i"(0) : "$9")` rotates EVERY
one of our four `lui/addiu $t1` symbol materializations to `$t2` in ONE step (201 diffs) --
proving `$t1` there is the **reload spill pool, not an allocated pseudo**. Retail materializes the
same four addresses in `$v0`/`$v1`. So the cluster is 22A-4's **RELOAD ROUND-ROBIN ROTATION**
(`allocate_reload_reg` walks `spill_regs` from a function-global cursor) and is **DOWNSTREAM of an
earlier reload-count divergence** -- the obvious candidate being the one insn we are short, the
col1 copy.

Corroborating (22B-7: nothing to dial when there is no already-existing `%hi` pseudo): an
`'m'`-operand fence on `Cars_gHumanRaceCarList[0]` costs +2 insns (77 @476) and an `"r"` fence +3
(78 @477).

**=> Do not spend more on the four access sites; they are a symptom. Named instrument: 23D-1's
`[reload_pick]` trace.**

### (d) The fp<->s1 pair is not priority-reachable

`allocsim` MATCHES 50/50 (order-vs-dump IDENTICAL) on this basin, so the model is trustworthy;
`reqdelta --want "p164=s1,p191=fp"` (p191 refs=6 live=41 -> fp, p164 refs=3 live=27 -> s1) finds
**no single-dial and no same-pseudo two-dial delta within +-40** on refs/live/calls.

Receipt written into `recon/game/psx/overlays.cpp` above `RaceStatistics`.

---

## 4. build.py rows added

**None.** No `PER_TU_FLAGS` / `PER_FN_TEXT_MOVES` / splice row is proposed: every flag cell on
overlays.cpp is a net loss or bit-identical, and the night residual is not a text-move class.
`tools/build.py` is byte-identical to what the concurrent session left there.

## 5. Tooling notes / hazards hit

* `tools/gprobe.py` vacuous-measurement bug (section 2) -- **fixed**.
* The recon TUs have **MIXED line endings** (bare-LF lines inside otherwise-CRLF files:
  `overlays.cpp` lines 438/597/607 are LF, the rest CRLF). Any spec/anchor tool that assumes one
  ending silently fails to match. `scratchpad/w75/A13/probe.py` now matches line-by-line with an
  `\r?\n` joiner; worth promoting.
* `tools/rtl_dump.py` writes a FIXED path -- every dump quoted here was copied to a protected
  untracked name under `scratchpad/w75/A13/` before the next dump.
* The instrumented 2.8.1 `cc1plus` needs Windows-style `TMPDIR/TMP/TEMP` (else `\/ctaNNNNN`) and
  `-funsigned-char` (PsyQ's cc1plus defines `__CHAR_UNSIGNED__`, the FSF build does not).
* `reqdelta.py` on a 50-allocno function exceeds a 120 s foreground budget -- background it.

## 6. Files (all untracked, under `scratchpad/w75/A13/`)

`probe.py` (spec probe + death-count instrument), `sbsprobe.py`, `flagprobe.py`,
`gprobe_instr.py` (the instrumented copy that proved the gprobe bug), `build.py.a13bak`,
`psyq/` + `instr/` (both compilers' dumps), `psyq_fn.s` / `i281_fn.s`,
`psyq_comb.txt` / `i281_comb.txt`, `psyq_lreg.txt` / `i281_lreg.txt`,
`night_sbs.txt`, `night_rgb_sbs.txt`, `rs_sbs.txt`, `rs_r1_sbs.txt`,
`gcc-2.8.1/ChangeLog`, and the `*.spec` cells (`d1 n2 n3 c1-c4 p1 p3 p4 r1-r7 rf0-rf4`).
