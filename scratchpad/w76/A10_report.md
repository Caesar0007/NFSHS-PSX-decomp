# W76-A10 report — newton + stats belt (NFS4-PSX matching decomp)

Repo `C:\Temp\nfs4-decomp`. STEP 0 done in full: MIPS ISA ref, PSX->C++ methodology,
catalog §§20–24, BRIEF.md, W75-A10 receipt + both in-TU receipt blocks, replayable
W75 variants read before any probe. No git operations. Memory dir untouched.
`tools/build.py` never opened for write. NOTE: session was cut by a session limit
mid-experiment and resumed under a constrained budget on orchestrator order
(finish proven cells, land, close out) — the Newton residual-2 angle and all Stats
probing are handed off with named next steps.

## Bottom line

| fn | TU | baseline | final | landed |
|---|---|---|---|---|
| `Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef` | game/common/newton | **23** @105/106 | **2** @106/106 count-exact, posmis=2 | **YES (V4)** |
| `Stats_TrackEndGame__Fv` | game/common/stats | **12** @232/232 | **12** @232/232 | no change (budget cut before any stats probe; W75 receipt state stands) |

- **ZERO PASS→FAIL.** newton.cpp 31/32 PASS x2 before and x2 after, PASS **list**
  (not just count) diffed identical. stats.cpp 6/7 PASS x2 (untouched).
- `tools/slotcheck.py build/recon/game/common/newton.cpp.o` = **bad 0** (new
  zero-insn asm devices audited for the 24F jal-in-slot UB).
- No pins. All landed devices are the established zero-insn fence family
  (order of attack respected: receipt angle (a) conflict-list first -> catalog ->
  device family; no last-resort asm insertion that emits bytes, no PIN-SEALED items).

---

## 1. Newton 23 -> 2: the W75 "one allocno seat" was DOWNSTREAM of ONE sched1 hoist

W75 left the split basin at a 29 floor (> shipped 23) with the named angle
"[reload_pick]/qty trace on the split basin's dump / a clobber ending before mflo".
Step (a) of that angle — READ THE CONFLICT LIST (24E-4) — solved it without the
instrumented lane: the **production CC1PLPSX itself accepts -dl/-dg** (§3.12b), so
`scratchpad/w76/a10_dump.py` (new harness, arbitrary source + edit-file, private
copy, never touches the shared TU) produced ground-truth `.lreg/.greg` dumps of the
exact gate compilation (fidelity = definitional; head + mult regions verified
against the gate sbs line by line).

**The mechanism, read off `nsplit.i.greg` (split basin):**
- pseudo 87 = x-quotient (nxq), disposition $a0; pseudo 107 = the lvy load
  `lw ..,176(s1)`; pseudo 103 = lvx dividend ($v0), 104 = first product (LO-pref).
- sched1 had hoisted insn 133 (lw 107) ABOVE insn 129/131 (sra/mult) to fill the
  mult latency -> 107 overlaps 87 and 103 -> `107 conflicts: ... 87 ... 103 ...`
  -> 107 (allocation order position 5) takes $v1 -> 87 (position 15) is denied
  v0 (hard-2 + 100/103), v1 (107), a1 (90), a2 (89 + hard 6), a3 (84), t3 (88)
  -> first free = **$a0** — exactly the wrong seat, and every W75 cluster
  ((c) order, the lw-between-mult-and-mflo, (e) accumulator band) cascades from it.
- Retail has NO hoist (its lw sits after mflo with two nops; its lvy dividend
  takes the freed $v0; quotient $v1). Same compiler => the hoist is source-reachable.

**The landed cell (3 coupled devices, all zero-insn):**
1. **stmt-expr fence inside the dot**:
   `dsum = ({ int p1 = nxq*(lvx/0x100); __asm__("" : : "i"(0)); p1; }) + y + z;`
   — a volatile-asm sched barrier placed AFTER the x-mult *inside the expression*
   blocks the lvy hoist. A statement split (`+=`) cannot do this job: it hands the
   sum web the call-arg $a1 preference (see 2) and the e3/e6/f2-class fences sit in
   the wrong spot. Side-effect-first expansion (23A-8) is safe here: the
   side-effecting operand is op0 of the outer plus, so order is preserved.
2. **`dsum` rename** — the dot+abs carrier must NOT be the variable passed to
   `Physics_AttenuateVelocity` (arg pref $a1 was seating the partial sums in $a1;
   retail: addu a0,a0,t4 / addu v0,a0,t4 / negu v0,v0). SYM check: retail's
   `distRetreat REG $3` binds to the POST-/16 value — our `distRetreat` keeps
   exactly that role, `dsum` is the compiler-temp-equivalent of retail's anonymous
   sum web (no SYM local invented).
3. **fence POSITIONS**: `r(nxq)` moved AFTER `barrierVec.y = 0;`, `r(ny)` AFTER
   `barrierVec.z = t3;` — sched1 emits both divide-join pairs in retail's
   [sw, sra] order (verified in nv4.i.greg: insns 89<85, 116<112); an output-less
   fence BETWEEN a pair anti-deps the store and pins the wrong [sra, sw].

### NEW LAWS (with evidence)
- **L1 (instrument):** the production CC1PLPSX -dl/-dg dump is a zero-fidelity-risk
  allocator/scheduler oracle for C++ lane fns — no instrumented-lab fidelity check
  needed (it IS the gate compiler). Use it before the [reload_pick] lab.
- **L2 (sched1-hoist conflict class):** a "wrong allocno seat" whose conflict list
  contains a pseudo born LATER in source order = check for a sched1 hoist first;
  the cure is a volatile fence inside the expression (stmt-expr), not an allocator
  dial. (This retires W75's structure-free framing of the (c)+(e) residual.)
- **L3 (fence-in-join-block law, extends 23C-8/24D):** an output-less fence placed
  between a join block's {store, sra} pair anti-deps the store and forfeits
  retail's store-first order; placed after BOTH, sched1's [sw, sra] survives —
  but only if the fence reads the sra's own output (x-join r(nxq) survives sched2;
  y-join r(ny) does not — see residual).
- **L4 (carrier-variable preference law, the (e) fix):** a dot/abs computed in the
  variable later passed as a call argument inherits the arg-register preference on
  its WHOLE web (partial sums included). Retail's anonymous-sum seats need a
  carrier variable distinct from the argument variable.

### Measured this wave (all real gate runs; probe harness restores byte-exact)
```
split(a10_r2, W75 floor 29)
V1 split + stmt-expr fence ................. 14 @106
V2 split + dsum rename ..................... 19 @105
V3 = V1+V2 ................................. 4  @106
V4 = V3 + fences after the stores .......... 2  @106  <- LANDED
V5 = V4 w/ r(ny) before bvz ................ 2  @106
V6 = V4 minus r(nxq) ....................... 14 @106  (load-bearing)
V7 = V4 minus r(ny) ........................ 26 @104  (load-bearing)
V15 bvz before the y-divide ................ 6
V23 r(ny) after the dot .................... 7  @105  (copy lost)
V32 ny carried by the stmt-expr fence ...... 7  @105  (y-div temp -> a0, sra sinks)
V33 y-fence r(ny),r(nyq) ................... 8        (+1 ref recolors)
V34 y-fence r(nyq) only .................... 25 @105  (copy lost + cascade)
V36 two y-fences r(nyq); r(ny) ............. 8
V43 ny born before the x-divide, no fence .. 26 @104  (copy-propagated away)
```

### Residual 2 @106/106 (posmis=2) + the named next angle
ONE adjacent swap at the y-join: retail `sw t3,32(sp)` THEN `sra a1,v0,8`; ours
sra-first. sched1 already emits retail's order (nv4.i.greg 116 before 112) — the
re-swap is post-reload (sched2). The x-join pair survives sched2 because its fence
reads the sra's own output (true dep couples the pair); the y-fence reads only
`ny`, so the y-sra escapes the fence's dep cone and sched2 re-ranks it above the
store. Every spelling that couples them adds a ref and recolors (V33/V36 = 8).
NEXT ANGLE: sched2-side trace on the V4 dump (name the exact rank flip), or a
y-side device whose dep cone contains the sra WITHOUT a new ref on nyq — none of
the 8 spellings tried this wave reaches it.

### Falsified this wave (do not re-run)
V6/V7 device removals (both fences load-bearing); V15/V30-class store-luid moves
(store lands in the pre-branch block); V23/V32 deferred ny carriers (copy lost /
temp recolor); V33/V34/V36 nyq-reading y-fences (ref recolor / copy lost); V43
early-born ny (cse copy-props the carrier; the fence's +1 ref is essential, not
just the BB-crossing).

---

## 2. Stats_TrackEndGame — untouched (12 @232/232, x2 re-gated)

The session limit + constrained-budget resume order landed before any Stats probe
ran. The W75-A10 receipt state stands in full: the 228-plateau quantification
(volatile carries the entire basin, all 13 alternative devices land at 228), the
new law (only an unmovable volatile MEM at the min's USE SITE stops loop.c
strength-reducing the abs-arm's second address into the giv walker), and the open
ask remains loop.c-side: an index expression loop.c cannot strength-reduce
(non-BIV-derived index), the §24A MEM_IN_STRUCT_P store-side cast trick, and
corpus-mining stats/timer loops (`C:\Temp\ps1-decomp-refs`) for the same
min+abs-arm shape. Last resort per policy: a minimal asm insertion planting the
unreducible index (would be PIN-SEALED class).

## 3. Artifacts
`scratchpad/w76/`: `a10_dump.py` (NEW reusable -dl/-dg dump harness: arbitrary
src + a10_probe-format edit file, private copy, TU-dir include path),
`nsplit.i.{lreg,greg}` + `nsplit.s`/`nsplit_fn.txt` (split-basin dumps, the
conflict-list evidence), `nv4.i.{lreg,greg}` + `nv4.s` (landed-basin dumps, the
sched1-order evidence), `a10_n_v*.py` (every measured variant, replayable via
`scratchpad/w75/a10_probe.py`), `a10_n_v3_sbs.txt` / `a10_n_v4_sbs.txt` /
`a10_n_v32_sbs.txt` (side-by-sides), gate transcripts
`a10_newton_{gate1,gate2,final1,final2}.txt`, `a10_stats_{gate1,gate2,final1,final2}.txt`.
Landed edit = `a10_n_v4.py` applied via probe `--keep` + receipt blocks
(W76-A10 in-TU receipt + inline device comments; CRLF preserved).
