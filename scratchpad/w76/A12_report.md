# W76-A12 REPORT — frontend belt (feapp / feaudio / front / psxcontroller)

Base: `52cd5920` (+ concurrent uncommitted belt/user edits, all preserved).
STEP 0 done: MIPS ISA ref + methodology (full) + catalog §§20–24 + BRIEF.md +
scratchpad/w75/A12_report.md + every target's in-TU receipt blocks.
No commits, no staging, no build.py edits, no memory-dir writes.  No pins, no
asm insertions landed (the one candidate lane was measured EMPTY, below).

## SCOREBOARD (every TU gated twice; ZERO PASS→FAIL tree-wide)

| fn | TU | baseline | final |
|---|---|---|---|
| `Redraw__14tFEApplication` | feapp | 10 @393/393 (posmis 25) | **PASS 393/393 — SEALED, device-free; TU 15/15 COMPLETE** |
| `FeAudio_InitViv__FPc` | feaudio | 2 @109/109 | 2 @109/109 HELD — vendor axes closed |
| `GetPSXPadValue__Fii` | front | 12 @222/222 (posmis 4) | 12 @222/222 HELD — fold class measured-closed |
| `InGame_GetPSXPadValue__Fii` | psxcontroller | 76 @235/233 | 76 @235/233 — READ-ONLY (user active) |

Whole-TU gates (2× each): feapp **15/15** · feaudio 9/10 · front 42/43 ·
psxcontroller 3/4.  `slotcheck` on feapp.cpp.o: bad = 0.  feaudio byte-identical
to HEAD after all probes; front.cpp carries only the concurrent W76-A20 belt's
vptr-dial landing (its 42/43 unchanged); psxcontroller carries only the USER's
own uncommitted edit (InGame_SetRamp comment/carrier note — preserved verbatim).

---

## 1. `Redraw__14tFEApplication` — 10 @393/393 → **PASS 393/393, SEALED (device-free)**

The W74/W75 named angle ("deny reorg the packet-store steal without an asm in
the block") is answered by THREE COUPLED SOURCE FACTS — a 23B-1 joint cell that
five waves had priced only axis-by-axis:

1. **MIDDLE STORE ORDER** (the oracle's own): retail's source had the packet
   bump BETWEEN the two prim-tag writes; the palette store is LAST, adjacent to
   the `SetDrawArea` jal, so reorg's backward scan takes IT for the slot —
   retail's pick — and the packet store is never a candidate.  Alone this order
   was 69 @400 (measured again this wave) because the intervening register-base
   store clobbers the palette MEM equivalence in no-TBAA cse.
2. **STRUCT-VIEW PACKET STORE (24A /s axis)**: `((tPacketCellView *)pc)->pkt =
   ...` is a COMPONENT_REF (MEM_IN_STRUCT_P set) — a varying STRUCT store does
   not invalidate the FIXED non-struct palette-pointer load, so the shared load
   survives (69 @400 → 46 @395 measured).  W64 had measured this axis INERT —
   but only in the last-store position, where it dials nothing.
3. **pal2 PRECOMPUTE (23A(3) LICM lifetime dial)**: naming the palette RMW
   result right after the daprim merge shortens the 0xFF000000 movable's luid
   span, keeping the mask under the LICM budget threshold so it stays in-loop
   in `$t0` like retail (without it the middle order hoists it callee-saved:
   46 @395, +s7 spill, +8 frame bytes).  The final `*(u_int *)Render_gPalettePtr
   = pal2;` is the bitfield RMW written out — semantics identical, and the seal
   is byte-proof.

Plus the already-banked arm-duplicated `pc` reads (W64-A16 two-SET anti-LICM)
for the `lui t0/ori t0,t0,4` window.  With (1)-(3) the entire 14-basin residual
((a) fYOffset $a1/$a2 + `addiu a1,sp,56` position, (b) the jal-slot pick)
DISSOLVES — both were downstream of the packet store's emission position.

**W76 falsification field** (all measured, all reverted): struct-view middle
w/o pal2 46 @395; plain `*pc` middle 69 @400 (historic number reproduced);
comma-3 vs separate statements EXACTLY inert (46/69 both ways — the DrawSlider
statement-count dial does not transfer); struct-view LAST 14 @393 (= W64's
inert reading, now scoped); fixed-address struct store 46 @395; pal2 + plain
`*pc` middle 23 @396; C14 control (W72 simplified recipe) 14 @393 reproduced.

**§24 re-pricing receipt (the prompt's ask)**: posmis inverts the basin
ranking — shipped 10-basin posmis 25, 14-basin posmis **15**.  The 14-basin was
positionally closer all along (23D(4)/24F(11): LCS non-monotonic); the seal
grew out of the 14-basin's source shape, confirming the metric.

Landed in `recon/frontend/common/feapp.cpp` with a full W76-A12 receipt block +
`tPacketCellView` typedef (file-local, no shared-header change, no rebuild
obligation).  TU gated twice: **15/15**.  Cross-verify: the byte-exact PASS vs
the linked-oracle stream subsumes the m2c structural check; slotcheck clean.

## 2. `FeAudio_InitViv__FPc` — HELD 2 @109/109; THE VENDOR-IDENTITY QUESTION IS ANSWERED

The W76 named angle (prompt): is the retail object from a different flag/version
lane?  **NO — every vendor axis is now measured-closed:**

* **Version lane (C++)**: PsyQ 4.0 ships `CC1PLPSX.EXE` = **gcc 2.7.2.SN32.3.7**
  (a real alternate C++ vendor rung; 4.3's is 2.8.0).  New harness
  `scratchpad/w76/A12/vpp40.py` splices it per-fn through the true
  maspsx pipeline (mirrors `_apply_cc1_ver_splice`).  Measured: current
  (device) source 42 @111; defenced (natural) source 45 @110; defenced +
  literal block-2 mask 43 @110.  Plus the structural argument: 9/10 fns of this
  TU byte-PASS under 2.8.0 in ONE compile — a TU is one cc1plus invocation, so
  the retail lane IS CC1PLPSX 4.3/2.8.0.
* **Flag lane**: 12 flags swept per-fn via `vprobe_flag.py` on the SHIPPED
  basin (-fno-{expensive-optimizations 15 @110, peephole 2, function-cse 2,
  thread-jumps 2, cse-follow-jumps 2, cse-skip-blocks 2, rerun-cse-after-loop 2,
  caller-saves 2, force-mem 2, strength-reduce 2, delayed-branch 33 @122}) and
  5 flags on the NO-FENCE basin (peephole 2, expensive 15, thread-jumps 2,
  cse-follow-jumps 2, caller-saves 2).  All inert-or-worse.  (W75 had closed
  the two scheduler flags.)
* **New device falsifications**: late read-only fence on a named byteMask at 3
  positions (6/24/32 — the 24D(3)/(4) "give the li a consumer chain" idea is
  dead: the fence's own latency-collapse and slot effects dominate); upstream
  `lumpyName` anchor moves (18 @111 ×2 — the address goes live-across-loop into
  a saved reg).
* **The LAST-RESORT asm-insertion lane is EMPTY, not merely undesirable**
  (why no PIN-SEALED row exists): (i) any volatile asm anywhere above the
  `reservememadr` call blocks the la hoist entirely (sched.c:1987 weld — the la
  originates AT that call and only reaches the loop-exit block because no
  barrier exists); (ii) the only non-barrier insertion shape — a non-volatile
  emission asm `("lui %0,255" : "=r")` — is rank-identical to the compiler's
  own li and measured **3 @110** (worse); (iii) pins do not reorder.  The sole
  mechanical fix remains W75's withdrawn TEXT_MOVES row — forbidden by policy
  and psyqproof-branded shim-masked (REAL=1).

**STATE**: 2 @109/109 is a *documented floor receipt under the current policy*
(24D(8) class): a pure sched2 stale-order two-line permutation, produced by no
compiler-input axis, no device, and ~75 spellings over 6 waves.

## 3. `GetPSXPadValue__Fii` — HELD 12 @222/222; the W61/W62 "cse/expression-identity device" ask is now MEASURED AND CLOSED

New oracle reading (banked): retail's G1 tail carries `lui v1,0x100` (the tag's
high half) + `ori v0,a2,1` — i.e. the tag is plain 0x1000000 and the `| 1` is
separate, exactly our current spelling; the historic "0x3000001 absorption" was
a property of the FOLD basin, not of retail.  Retail's `newControl` is born at
the `ori` (SYM $v0), meaning the fold shape (`newControl = expr | 1; return
newControl;`) is the retail source — it explodes for us because fold-const
merges the 1 into the tag constant (+1 insn/arm), the very thing 22A(1)'s
mutable-local escape was invented for on Hud_BTCStats.  **Measured this wave**:

* G1×3 fold + `one` escape, `one=1` before the switch: 111 @223.
* G1×3 fold + per-arm `one=1`: 106 @222.
* FULL 12-site fold + per-arm `one` (G1+G2+G4 pair kept device+`|one`, the
  0x53/0x200000 + 0x23 sites, compound arm `| one`): **200 @224**.

⇒ the fold class is closed WITH the escape device on board: the far-basin
change is not (only) constant absorption — the fold rewires every tail merge.
The prompt's other angle (per-group accumulation with the `player<<30` hoist
blocked) remains bounded by W75's P1/P2 (gcse CSE, 6-short) and W72's two-term
falsifications; no untried zero-insn spelling was identified that blocks PRE
without an in-arm asm (which kills the merges — W72's own boundary).

**STATE**: 12 @222/222 (posmis 4).  The residual = G1/G2 tails' last-`or` dest
(the priced +2 arm-1 cost of the G4-style clobber device, W74-atomic).  The
sharpest open instrument is unchanged: natural $v0/$v1 liveness over arm 1, or
the W75-3b qty-order demotion — with the new negative datum that acc-demote
via fold/`one` cannot pay it.

## 4. `InGame_GetPSXPadValue__Fii` — 76 @235/233, READ-ONLY (deliberately untouched)

Re-baselined twice: 3/4 PASS, `InGame_ResetPSXController__Fii` PASS 305/305,
fn at 76 @235/233 — exact match to the user's W78 receipt.  The user's session
is actively landing here (W76/W77/W78 receipt blocks dated today, uncommitted
working-tree edit in `InGame_SetRamp` preserved).  Their W78 receipt now COVERS
BOTH A12-named halves: the negative-tail role swap is freshly priced
(a2,a0,a1 → a0,a1,a2; named next angle = "a source use that attaches to the
EXISTING shared 0x80 qty, not another literal qty") and the +2 dispatch half is
subsumed in their "freshly priced two-tail/dispatch problem".  Per the fleet
rule + orchestrator directive, no probes were run on this fn.

Note for the cross-TU ledger: the front.cpp fold-class closure (sec. 3) prices
the same device family the twins share — W78's "putting |1 back inside
newControl 113/156" and my 106/200 are the same wall measured from both TUs.

## 5. ARTIFACTS

`scratchpad/w76/A12/`: `vpp40.py` (per-fn PsyQ-4.0 CC1PLPSX C++ ver-splice
harness — reusable for any cc1plus vendor probe), `probe.py` (W75 harness +
pluggable `W76_GATE` env), `viv40a.json`, `nofence.json`, `lf.json`, `up.json`,
`emit.json` (InitViv cells), `rd.json`, `rd2.json`, `rd3.json` (Redraw cells —
`rd3.json` K2 = the sealing shape), `pad.json`, `pad2.json` (front fold cells),
`probe_log.txt`.  All probes byte-mode, CRLF-preserving, restore-verified
(feaudio/front byte-clean vs HEAD modulo concurrent belts' own landings).

## 6. NEW LAW CANDIDATES (for the catalog harvest)

1. **24A×position joint cell**: MEM_IN_STRUCT_P on a STORE is inert unless the
   store sits where its alias edge is load-bearing (struct-view last = 14=14
   inert; struct-view middle = 69→46 live) — price the /s axis AT each store
   position, never once per fn (extends 23B-1, scopes W64's "exactly inert").
2. **The LICM statement-count dial has an RMW-precompute face**: naming a
   bitfield RMW's result early (store later) shortens a shared mask's movable
   lifetime at zero insns — the seal-completing member of the 23A(3) family.
3. **posmis basin-inversion receipt #2**: Redraw 10-basin posmis 25 vs 14-basin
   posmis 15 — the lower-LCS shipped basin was the WRONG basin; the seal came
   from the higher-LCS one (joins DrawC_PrimClip as evidence for posmis-first
   basin triage on count-exact fns).
4. **Vendor-rung inventory fact**: PsyQ 4.0 ships CC1PLPSX = gcc 2.7.2.SN32.3.7
   — a real C++ ladder rung; `vpp40.py` is the splice harness.  TU-identity
   (sibling fns byte-PASSing in one compile) is the cheap decisive argument
   against per-fn version stories inside a game TU.
5. **22A(1) boundary**: the fold-literal escape neutralizes constant-absorption
   but cannot rescue a basin whose change is TAIL-MERGE rewiring (front 200
   @224 with the escape on board) — the escape is a constant-shape device, not
   a block-layout one.
