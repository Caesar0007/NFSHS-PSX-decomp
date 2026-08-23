# W76-A14 — libc / libmath belt (sprintf, __divdf3)

**Headline: 🏆 `__divdf3` SEALED — PASS 184/184, TU 2/2 (a 9-wave function: W55→W60→W61→W62→
W71→W72→W74→W75→W76 closed).  sprintf held at 25 with the W75 orchestrator call ANSWERED
(the split-lane/self-temp question closed with compiler-source mechanism + measurements);
1 new zero-insn device class (RCSE MEM-FENCE), 2 vendor-identity receipts, ~14 falsified
cells named.  Zero PASS→FAIL anywhere.**

| fn | TU | baseline | final | state |
|---|---|---|---|---|
| `__divdf3` | `recon/syslib/psx/libmath/DIVDF3.c` | 6 @184/184 | **PASS 184/184** | 🏆 **SEALED** (tugate 2/2 twice, slotcheck bad=0) |
| `_comp_mant` | same TU | PASS | PASS | held |
| `sprintf` | `recon/syslib/psx/libc/SPRINTF.c` | 25 @546/545 | 25 @546/545 | receipts only — every remaining row now carries a version- or vendor-identity receipt |

Files touched: the two recon TUs (code + receipts), `tools/build.py` (ONE row added to
`PER_FN_CC1_VER_SPLICE_272`; the user's foreign uncommitted hunks preserved, `ast.parse` clean).
No commits, no staging, no memory-dir writes.  Sibling regression gates after the build.py edit:
ADDDF3 1/1 · MULDF3 2/2 · PADCMD 19/19 · INTR 13/13 · cdcont 19/19 · SYS 43/44 (the one FAIL =
`_gpu_que_drain` 6, the W75 policy-withdrawn row — pre-existing).

NOTE: the session was cut and resumed mid-belt; the pre-cut DIVDF3 landings (6→2) were
committed by the orchestrator in `44bd4251`.  This report covers the whole belt.

---

## 1. `__divdf3` — 6 → 2 (pre-cut, in 44bd4251) → **PASS (this session)**

### Phase 1 (pre-cut): rows (ii)+(iii) solved at source, 6 → 2

* **The 05C ref-fence was sitting at the JOIN HEAD** — the first insn at arm1's `j` target.
  `stop_search_p` (reorg.c:685) fires at ANY asm, so it walled the thread scan that fills the
  `j` delay slot.  Moving the fence into the else arm (seat effect is position-independent)
  was worth 2 diffs alone: **6 → 4**.
* **Oracle fact that unlocked row (iii):** the join label `.L800F6020` sits at `sw $s0,0x10`,
  AFTER `addiu $a0,$sp,0x18` — retail's tail-call pointer was materialized PER-ARM (arm1's
  `j` slot = a backward-steal of its OWN a0-setup, NOT W75's "!own_thread COPY" reading).
  Landing = tail `_dbl_shift_us` DUPLICATED into both arms (cross_jump re-merges at exactly
  retail's label) + a DEAD `qp = 0;` cse-kill after each arm call (without it cse folds the
  in-arm `&q` into qp → cross-call value → callee-saved home → 48/86-diff s-band rotation)
  + arm2's tail pointer NAMED (`p2`) with an output-less order fence before `n += 1`
  (the sched2 critical-path tie — increment chain depth 4 via the /s-load false dep vs
  a0-setup depth 2 — is otherwise unwinnable).  **4 → 2.**
* Falsified en route (all measured, whole-fn gate): per-arm `p=(uint*)q` w/o kill 86 @186 ·
  dup w/o kill 48 @186 · `n+1` as 5th arg 65 @185 · `(n+=1)` embedded 4 (inert) · non-/s
  cast q loads 4 (inert) · 05C-before-n+=1 4 (inert) · W71 fence removed at this basin
  11 @183 (still needed) · V13-shape rung ladder: 2.7.2=2 | 970404/2.8.0/2.8.1=6 | 2.6.3=5.

### Phase 2 (post-resume): row (i) @27 = a RUNG-IDENTITY row, then SEALED via an allowed lane

* **Mechanism (gcc-2.8.1 source + measured 2.7.2-vs-2.8.x delta):** the `bnez $t2` slot copy
  of `lui $v0,0x7FFF` is gated by `!insn_sets_resource_p(trial, &opposite_needed)` (reorg.c:3574).
  For our fall-through target (inside block 0 — no BARRIER+label back to fn start, so
  `find_basic_block` returns 0) the block scan keeps $v0 claimed: its REG_DEAD only enters
  `pending_dead_regs`, which is flushed ONLY at a CODE_LABEL (none exists there).  gcc-2.8's
  `find_dead_or_set_registers` (reorg.c:2479) follows BOTH arms of the conditional at the
  target and discovers $v0 set-before-use; 2.7.2's inline forward scan stops at the first
  conditional jump.  Measured: every 2.8-lineage rung (970404/2.8.0/2.8.1) FILLS the slot.
* **The 970404 rung's ONLY divergence from the vendor = reload_cse** (present per the W74
  fingerprint): it forwarded the two `t[0]` arg reloads as `addu $a3,$s0/$v0,$0` where retail
  reloads `lw $a3,40($sp)`.  Lab experiment (A15's `GCC_NO_RELOAD_CSE` cc1): the no-rcse run
  restores `lw $7,40($sp)` at both sites — **LIBMATH shares the A15 "2.8-shape cc1 WITHOUT
  reload_cse" vendor identity** (the lab itself is hard-float mips-ecoff, unusable as a rung —
  `mfc1` doubles — so the gate experiment was flag-level only).
* **🔑 NEW DEVICE — the RCSE MEM-FENCE:** `__asm__ __volatile__("" : "=m"(t[0]) : "m"(t[0]));`
  after each `t[0]` store.  A zero-insn VOLATILE asm that "rewrites" the slot in place: its
  `"=m"` output makes `note_stores` invalidate the stored slot's reg↔mem association inside
  `reload_cse_regs`, so the frame reload survives.  Legal even when the donor register is
  LIVE (arm1's donor $s0 = `n` — the ADDDF3-style donor clobber is NOT legal there).
  Device ladder (all measured on the splice lane): `:::"memory"` barriers 70 @188 ·
  `"$2"`-clobber arm2 + reg-launder arm1 4 · volatile m-clobber arm2 2 · NON-volatile `=m`
  4 (sched-free, displaces the `sw $0,44` t[1] store) · two-slot `=m` 70 @188 ·
  **volatile `=m` both arms → PASS**.  Wired-lane control with the fences: 2 (inert).
* **Wiring:** `PER_FN_CC1_VER_SPLICE_272["recon/syslib/psx/libmath/DIVDF3.c"] =
  {"2.7.2-970404": {"__divdf3"}}` — an allowed compiler-input lane (real on-disk rung).
  Gated 2/2 twice; `slotcheck` bad = 0 (272 lane + asm devices + ver splice).

## 2. `sprintf` — 25 held; the W75 §(A) orchestrator call answered IN THE NEGATIVE, with mechanism

* **Split-lane row census** (flag OFF, default cc1: 42 @545 count-exact; sbs banked):
  format cluster + `li s3,48` carry over UNCHANGED; the la/j/nop + li-42 rows become retail's
  correct split-pair shape; the NEW class = HI-SCRATCH SELF-TEMP at 3 sites + a jtbl pair.
* **🔴 The self-temp class is COMPILER-STRUCTURAL, not declaration shape** — the §3.12#5
  route is closed by source citation + measurement: mips.md `movsi` uses a FRESH high temp
  at expand (`tem = (reload_in_progress|reload_completed) ? operands[0] : gen_reg_rtx`) —
  dest-reuse (retail's self-temp) exists only INSIDE reload; and combine_regs cannot tie the
  fresh high afterwards (cross-block dest → `reg_qty[sreg] == -1` refusal, local-alloc.c:1866;
  template site: the mem(lo_sum) combine fold gives the high a 2nd use).  Falsified: extern
  unsized-array digit tables (the oracle's own D_80056B38/D_80056B4C shape!) inert · tsrc
  read-fence inert · tsrc launder 49 @548 · per-case single-def locals inert.
  ⇒ **the wired `no_split_addresses` row is LOAD-BEARING, not a paper-over** — retail's
  self-temp split pairs are reload-time materializations = the vendor-internal cc1 again.
* **🔑 The 16-diff format-pointer cluster is VERSION-CURED on 970404**: split + cc1_alt
  2.7.2-970404 = 31 @546 with every format-pointer row GONE (the cse canon_reg/find_best_addr
  fold asymmetry is 2.8.0-specific).  Not wirable whole-fn: that basin pays li-'#'-position 3,
  jtbl at-fusion lost 5 (maspsx cap pattern no longer matches), self-temp 7 ⇒ 31 > 25.
  A 970404-cse + no-split rung does not exist (970404: "Invalid option `no-split-addresses'").
* 04Z flag re-ladder at 25: -fno-rerun-cse-after-loop 73 @556 · -fno-cse-follow-jumps 45 @548 ·
  -fno-cse-skip-blocks 82 @557 · -fforce-addr / -fno-function-cse 25 (inert).
* Remaining 25 unchanged in kind; the honest route = the A15-class sanctioned vendor rung
  (USER CALL).  No pin targets exist (no row is a register-allocation question).

## 3. Catalog rows proposed

1. **RCSE MEM-FENCE** (§1) — volatile `"=m"(x) : "m"(x)` self-rewrite = zero-insn reload_cse
   MEM-flavour escape, legal with a LIVE donor; volatility is load-bearing (non-volatile
   displaces sibling stores); completes the 24B family (constant flavour = donor clobber,
   MEM flavour = slot rewrite).
2. **fill_slots_from_thread liveness asymmetry** (§1) — 2.7.2 vs 2.8 `find_dead_or_set_registers`:
   an unfilled conditional-branch slot whose retail fill SETS a caller-saved reg, with the
   fall-through inside label-less block 0, is a rung-identity row; check the rung FIRST
   (pending_dead_regs flushes only at CODE_LABELs; 2.7.2's forward scan stops at the first
   conditional jump).
3. **Per-arm tail-call pointer** (§1) — when the oracle's join label sits AFTER an
   `addiu aN,sp,K`, the arm owned its own call setup: duplicate the shared tail call per arm
   + dead-set kill the stale address pseudo (cse otherwise re-folds it cross-call) + name the
   pointer with an order fence where the arm has a competing statement.
4. **Self-temp split-address pairs = reload-time materialization** (§2) — mips.md movsi
   dest-reuse happens only under reload; expand always mints a fresh high temp that
   combine_regs cannot tie to a cross-block dest (local-alloc.c:1866) or a fold-doubled high.
   A retail self-temp `lui X; addiu X,X` split pair on a symbol is vendor-cc1 evidence, not a
   declaration-shape ask.
5. **canon_reg/find_best_addr fold asymmetry is 2.8.0-specific** (§2) — the one-vs-two-level
   address fold divergence (sprintf's 16-row cluster) does not exist on 970404; re-check any
   "post-RTL base-reuse" row's rung before grinding spellings.

## 4. Artifacts (untracked, `scratchpad/w76/`)

`A14_div_v1..v20.c` (+ `.restore`) · `A14_div_sbs_base/v2/v3/v13/v16_sbs.txt` ·
`A14_spr_{s1,s2,s3,t1,t2}.c` · `A14_spr_sbs_base.txt`, `A14_spr_split_sbs.txt`,
`A14_spr_970404_sbs.txt`, `A14_spr_s3_sbs.txt` · `A14_rtldump.py` (w76 copy),
`A14_sbs2.py` (sbs through vprobe's env hooks — posmis/sbs themselves do NOT honor
W60_TU_FLAGS; a probe wrapper must go through vprobe_flag), `A14_sprprobe.py` ·
`rtl/DIVDF3*.{i,s,dbr,sched2}`, `rtl/SPRINTF.{i,s}` + `.greg/.lreg` (production-cc1 dumps,
25A-4 confirmed) · `ladder/gcc-labnorcse-psx/` (the A15 lab cc1 staged as a rung — hard-float,
NOT usable; kept as the negative receipt).
