# W76-A9 report — AI belt (aih_basicperp, aih_btccop, aih_opp, aih_cop, aiphysic)

## Headline

**2 SEALS, 2 TUs COMPLETED, 0 PASS->FAIL.**

| TU | baseline | final | class |
|---|---|---|---|
| `recon/game/common/aih_basicperp.cpp` | 8/9 (CheckChaserPosition 2 @85/87) | **9/9 PASS** | **PIN-SEALED** (asm insertion, last-resort per policy) |
| `recon/game/common/aih_btccop.cpp` | 39/40 (HighExecute Wingman 4 @675/675) | **40/40 PASS** | **CLEAN SEAL** (faithful EA shape, no pin/device) |
| `recon/game/common/aih_opp.cpp` | 5/6 (CheckForWipeOut 9 @121/120) | unchanged | untouched (budget cut) |
| `recon/game/common/aih_cop.cpp` | 9/10 (HighExecute 20, posmis 9) | unchanged | untouched (budget cut) |
| `recon/game/common/aiphysic.cpp` | 41/42 (OutOfControlPhysics 5 @413/412) | unchanged | untouched (budget cut) |

Both sealed TUs gated twice post-edit (9/9, 9/9; 40/40, 40/40) and once more after
probe-TU cleanup. wordcmp REAL=0 on both sealed fns. slotcheck bad=0 on both TUs.
No build.py edits, no commits, no memory-dir writes. Temp probe TUs
(`zz_a9p.cpp`, `zz_a9p2.cpp`) deleted incl. their `build/` and `scratch/rtl/` artifacts.

---

## 1. CheckChaserPosition — SEALED (PIN-SEALED, 87/87, wordcmp REAL=0)

The 7-wave "cse value-range record" wall. This wave first EXHAUSTED the named angle
(a referenced CODE_LABEL in the preheader) with eight NEW source shapes, all probed on a
temp sibling TU, each gated:

| shape | result |
|---|---|
| V1 full backward-goto loop | 92 @81 (loses LOOP machinery) |
| V2 `switch (0 < pos) { case 1: ... }` (case label) | 34 @91 (+dispatch) |
| V3 `while` wrapper + break | 45 @90 |
| V4 `static void *p = &&anchor;` forced label | 49 @94 (forced label pessimizes) |
| V5/V5b `do{...}while(1)` + explicit second break (`for(;;)` same) | **2 @85 byte-identical to baseline** |
| V6 guard before loads | 28 @83 |
| V7 guard -> duplicated return block (`goto bail; bail: return pos;`) | 26 @85 |
| V13 goto-loop + bottom reloads | 73 @80 |
| V14 do-while(1) + bottom reloads + second break | 2 @85 (same basin) |
| V15 **mobile-faithful shape** (bottom reloads GUARDED `if(0<pos){reloads}`, single exit) | 2 @85 (same basin) |

gcc-2.8.0 canonicalizes EVERY guard-at-top spelling into the same rotated RTL
(duplicate_loop_exit_test copy in the pre-label preheader; cse folds it there). Dump
evidence this wave: V5's .jump shows the guard hoisted to preheader insn 265 even when
the source loop is `while(1)` (no simplejump after LOOP_BEG) — the copy/thread happens
regardless of loop spelling.

**Flag x shape joint cells (23B) newly measured:** per-fn `-fno-rerun-cse-after-loop`
(via `scratchpad/w75/vprobe_flag.py` W75_FN_FLAG) = the first count-exact basin **87/87,
posmis 21** — blez+nop restored but cse2's legitimate address-CSE lost (lui/addiu fp
remat + sll recomputes + s5/s6 swap; saved `scratchpad/w76/A9_bp_flag_posmis.txt`).
`-fno-cse-follow-jumps` / `-fno-cse-skip-blocks` inert on BOTH shapes. So the flag axis
stays closed even per-fn.

**NFSU2-mobile cross-check (orchestrator ask):** `nfsu2_x86_1.1.5/nfsu2.dll` contains
`AIHigh_BasicPerp::CheckChaserPosition` @0x1015daaf (disasm saved
`scratchpad/w76/A9_mobile_ccp.txt`). EA's original source shape read off it:
preheader loads; `do { if (pos<1) break; body; pos--; if (0<pos) { reloads } } while(1)`
— bottom reload-guard, single exit at top, unconditional back jump. That is V15 —
**measured 2 @85: even EA's literal shape folds in our lane.** (The retail survival remains
compiler-context, not source-shape; matches the receipt history's conclusion.)

**THE LANDING (policy order (a)-(e) exhausted -> (e)):**
`__asm__ volatile (".word 0x1A000028\n\tnop");` placed immediately after the (folded)
C guard `if (pos < 1) break;`. The word IS the oracle's never-taken
`blez $s0, .L8005C084` (raw bytes 28 00 00 1A @0x8005BFE0) + its unfilled delay nop —
byte-equality by construction, position verified count-exact (87/87), branch provably
never fires (pos>0 on both entry paths = the very record that folds the C guard).
Placement matters: the same asm BEFORE the guard (i.e. between the loads) = 35 @94
(it joins the loop-entry copy). Mnemonic spelling `blez $16,.+0x2c` = 1 @88 (assembler
emits an extra word) — the `.word` form is required.
Full falsification receipt in the TU comment block. slotcheck bad=0, wordcmp REAL=0.

## 2. HighExecute__18AIHigh_BTC_Wingman — SEALED CLEAN (675/675, posmis 0, wordcmp REAL=0)

**The 7-wave a2 wall was an INLINED TU-LOCAL DERIVED-STATE CTOR.** Chain of evidence:

1. posmis on the 4-diff baseline = **2**: exactly `addu a2,v0,zero` vs
   `addiu a2,sp,72/56` at the two freeze arms (idx 370/559).
2. Expand-level RTL (`-dr`, first time on this fn): the passing fp+40 arms set the
   memset/Newton arg regs DIRECTLY from `(reg 77)` = virtual-stack-vars (their
   trafficOffset sits at vsv+0); the failing arms need `(vsv)+32/+16` = a real add into
   a pseudo (reg 280/393) which then feeds BOTH calls -> cross-call allocno -> the s3 /
   489 basin under every address spelling. update_equiv_regs (local-alloc.c:1007ff)
   cannot rescue it (no REG_EQUAL note; frame-plus is not CONSTANT_P).
3. Newly falsified cells (each gated): volatile-qualified capture + &addr 525 @700;
   volatile capture + pass offset 28 @677; component-ref addresses
   (`&trafficOffset.x`) on both arms / memset-side / both sides — all 489 @698
   (the W74 one-arm 497 was indeed a half-cell, but the full cell is the same basin);
   hard-reg pin `register coorddef *p asm("$6"/"a2") = &trafficOffset` — 489 @698
   (the pin does NOT prevent the shared pseudo; recorded so nobody re-tries it).
4. **NFSU2-mobile twin (the decisive step):** `nfsu2.dll` HighExecute @0x1015faf8 shows
   case 0 as just `new(8) ctor(carObj)` + `SetState(p,7)`; the ctor 0x10161850
   (disasm `scratchpad/w76/A9_mobile_ctor.txt`) contains the ENTIRE arm payload:
   base-ctor, vf store, **coorddef LOCAL inside the ctor**, zero-init, `.y =
   carIndex*0xa0000`, `Newton_SetInitialSlicePositionOrientationEtc(&carObj_->N,0,&local,1)`,
   `carObj_->N.active = 0`. EA wrote a file-local AIState class (this obj's own
   NonActive-vtable copy D_80054F24) with an INLINE ctor; integrate.c inline expansion
   is what gives retail per-arm `addiu a2,sp,OFF` with no shared pseudo.
5. Recon: TU-local `struct AIState_BTCInactive : public AIState_Base` with that inline
   ctor (passes `&trafficOffset`); the two failing arms become
   `new(newState) AIState_BTCInactive(carObj);`. First measurement: count-exact 675
   with posmis 16 = the two a2 sites + frame 104->120 (the leftover flattened decls).
   Deleting the stale `coorddef *offset;` decls (both arms) + arm D's shadow
   `coorddef trafficOffset;` + case-4's now-unused `coorddef trafficOffset;` snapped the
   frame back to 104 -> **PASS 675/675, posmis 0**. Capture-variant of the ctor
   (`offset = memset(...)`; pass offset) = 30 @675 — the addr-variant is the match.
   No stray symbols emitted for the local class (objdump -t clean).

The case-0 and case-2 arms stay open-coded (they already PASS; W75 falsification
history retained in the TU receipt). Probe artifacts: `A9_btc_I4.variant`,
`A9_btc_I4_posmis.txt`, `A9_btc_z3dump.log`, RTL dumps referenced in the receipt.

## 3. Untouched targets (budget cut by orchestrator)

aih_opp / aih_cop / aiphysic: baselines re-verified at wave start (9 / 20 posmis-9 / 5,
identical to W75 finals); no edits, no receipt changes. Their W75 named angles
(LOG_LINKS edge 226->222 kill; 14C per-block ladder via copypref; the missing-insn hunt)
remain the next lenses.

**NOTE for the next wave:** the mobile DLL also contains `AIHigh_BasicPerp::*`,
`AIHigh_BTC_HumanCop::*` (RequestWingman/CheckForWingmanRequest/UpdateWingmanRole),
`AIHigh_BTC_Wingman::{CheckForActivation, UpdateFreezeModeAndPullOverMode,
SetupWingman, SetupBlockader}` — an ORIGINAL-SOURCE logic twin for the whole AI-high
cluster. The inline-ctor discovery generalizes: any near-miss whose payload repeats at
N state-transition sites should be checked against the mobile ctor bodies FIRST
(x86 fn location recipe: name-string xref -> backward scan for `55 8B EC`; script
pattern in this wave's transcript, disasms under `scratchpad/w76/`).

## New/refined laws for the catalog

1. **INLINE-CTOR IDENTITY (new, the wave's headline):** a near-miss whose residual is a
   per-arm `addu aN,v0,zero` vs `addiu aN,sp,OFF` at a repeated state/ctor payload is an
   INLINED TU-LOCAL CLASS CTOR, not an arg-spelling axis. Flattened source can never
   reproduce it: the flat `&local` spelling CSEs the frame address across the call into
   a callee-saved (the 489-class basins); the inlined ctor's local gets per-site slots
   and per-site remat. Detection: the NFSU2-mobile x86 twin (unoptimized MSVC = source-
   shaped) or any sibling with the same engine. Fix shape: TU-local
   `struct X : Base { inline X(...) { payload } }` + placement-new at the arms, and
   DELETE the flattened leftover locals (each unused decl re-grows the frame).
2. **virtual-stack-vars offset law:** `&local` of the FIRST stack slot (vsv+0) expands
   with no pseudo (arg regs set directly, per-use remat for free); any other slot needs
   `(vsv)+K` into a pseudo which, if referenced by two call args, becomes a cross-call
   allocno. Whether an address-arg near-miss is even reachable by spelling depends on
   the variable's SLOT POSITION — read the `-dr` dump before pricing spellings.
3. **cse guard-fold shape-independence (negative result, exhaustive):** for a rotated
   loop's duplicated entry guard, gcc-2.8.0 folds the copy under EVERY loop spelling
   (15 shapes incl. EA's literal original from the mobile twin) because the copy always
   lands in the pre-label preheader; only cse2-off restores it (at posmis 21 collateral).
   A referenced CODE_LABEL planted by source always costs more than the 2 insns it saves.
   => this residual class is asm-insertion territory by policy order.
4. **Hard-reg pin does NOT break expand-level address sharing** (`register T *p
   asm("$6") = &local` still routes through the shared pseudo) — the pin lane is useless
   against the 489-class; recorded as falsified.
5. **Process:** posmis on a "4-diff" LCS can be 2 (21E-3 again); the `.word` device's
   PLACEMENT is anchored by the folded C statement it shadows (after-guard = exact,
   before-guard = joins the loop-entry copy: 35 @94).

## Receipts / files

- TU receipts: `/* ==== W76-A9 ... */` blocks in `aih_basicperp.cpp` (PIN-SEALED, at the
  asm insertion) and `aih_btccop.cpp` (CLEAN, above the AIState_BTCInactive struct).
- Gates: `A9_base_*.txt`, `A9_bp_gate{1,2}.txt`, `A9_btc_gate{1,2}.txt` + final
  confirmation gates in-transcript (9/9, 40/40, slotcheck bad=0 both).
- Mobile disasms: `A9_mobile_wingman.txt`, `A9_mobile_ctor.txt`, `A9_mobile_ccp.txt`.
- Dumps: `A9_bp_dump_log.txt`, `zz_a9p*.i.{jump,cse,loop,cse2}` copies, `A9_btc_z3dump.log`.
- Variants: `A9_bp_V15.variant`, `A9_btc_I4.variant`; posmis files `A9_bp_flag_posmis.txt`,
  `A9_btc_posmis.txt`, `A9_btc_I1_posmis.txt`, `A9_btc_I4_posmis.txt`.
