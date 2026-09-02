# W86-D2 receipt — re-pricing the KEPT devices of the game tree with the W85 levers

Agent W86-D2. Gate for every number below = `python tools/tugate.py <file>` (whole-TU,
authoritative). Backups of every as-found file: `scratchpad/w86/D2_bak/<name>.cpp.bak`.
Probe drivers (scratchpad-local, **no `tools/*.py` was edited**):
`D2_try.py` (variant list + whole-TU gate + restore), `D2_auto.py` (per-launder battery),
`D2_combo.py` (cartesian combination pricing, 33A-3), `D2_refs.py` (variant -> `tools/rtl_dump.py`
+ `tools/prio.py` allocno table), `D2_census.py` (comment-masked device census).
No git, no memory edits, no new devices.

## 0. BASELINE (measured FIRST, 2026-09-02)

| file | gate |
|---|---|
| recon/game/psx/draww.cpp | 35/35 PASS |
| recon/game/psx/hud.cpp | 62/62 PASS |
| recon/game/psx/drawc.cpp | 20/20 PASS |
| recon/game/psx/flare.cpp | 27/27 PASS |
| recon/game/psx/night.cpp | 19/19 PASS |
| recon/game/psx/weather.cpp | 25/25 PASS |
| recon/game/psx/hrzsku.cpp | 22/22 PASS |
| recon/game/common/input.cpp | 8/8 PASS |
| recon/game/common/aih_btccop.cpp | 40/40 PASS |
| recon/game/common/aistate.cpp | 52/52 PASS |
| recon/game/common/aiphysic.cpp | 42/42 PASS |
| recon/game/common/sim.cpp | 8/8 PASS |
| recon/game/common/newton.cpp | 32/32 PASS |
| **total** | **326/326 PASS** |

---

## 1. 🏆 THE WAVE'S NEW LEVER, NAMED AND MEASURED — "PURE-C DEAD SET" replaces the IDENTITY LAUNDER

The identity fence `__asm__("" : "=r"(V) : "0"(V))` does two things at once: it gives the
pseudo an EXTRA SET (so loop.c cannot build a movable for it and cse cannot value-number
it), and it is +2 unweighted `REG_N_REFS`. Both halves are reachable in pure C, **but only
with a set whose value cse cannot prove equal to the live one**:

| shape | works? |
|---|---|
| `V = K; V = K;` (same constant, consecutive or not) | ❌ cse deletes the 2nd set before loop.c — measured identical to plain removal |
| `V = <other>; V = K;` (DEAD FIRST SET, different value) | ✅ `off7d` PASS |
| `V = <real>; { T t = V; V = 0; V = t; }` (save / dead set / restore) | ✅ two sites PASS |
| `V = 0;` after V's last read (pure dead reassignment, S7's nsync law) | ✅ fires (big moves), landed nowhere here yet |
| `V = 0;` BEFORE the real assignment, no restore | ❌ inert (34, = removal) |

The discriminator is the same one S7 recorded for the inflator: *the extra set must survive
cse as a real RTL insn*; a redundant constant store does not.

## 2. 🔴 THE 33A-1 REF INFLATOR DOES **NOT** REACH A POINTER REF DIAL — measured on RTL, not guessed

Assignment named `draww.cpp`'s 66-ref `sd` dial (`DrawW_DrawQuad`, removal = 194) as
"exactly a ref dial: try matching its ref count device-free". Done, with the allocno table
itself as the instrument (`tools/rtl_dump.py` + `tools/prio.py`, read-only use):

```
BASELINE (66 fences)  p80(sd) -> $s0  refs=128 live=1002 pri=0.8942   [beats p87(prim) .8421]
60 fences + `int sdr = (int)sd; sdr &= (int)sd;` xN  (N = 2,4,6,8,12,20, at the FUNCTION HEAD)
                      p80(sd) -> $s1  refs=122 live= 990 pri=0.7394   for EVERY N
```
**refs are literally unchanged at 122 for every N** — the whole chain is gone before flow
counts anything, and the gate is 194 in every case. Same at the function TAIL (`sd` is dead
there, so the chain is dead code). Mechanism, and the generalisation this earns:

> **The idempotent-op inflator needs a HOST OP.** It fires only where the dial variable is
> already an operand of a REAL binary RTL insn, so that the extra copy is `(ior (ior A x) x)`
> / `(and (and A m) m)` — a form cse cannot fold but **combine** can (combine runs AFTER
> flow, so the reference is counted and the bytes are not emitted). A pointer that is only
> ever a load/store BASE has all of its arithmetic folded into load displacements: there is
> no host op, so `x &= x`-style chains are pure copies that cse deletes before flow.
> ⇒ pointer ref dials (draww `sd`, drawc `ovs`/`facet`, hrzsku `pp`) are NOT inflator targets;
> only dials on a variable with a real AND/OR/arith host op are.

Also re-confirmed from the in-file ledger (not re-measured): the do{}while(0) DEPTH wrapper
moves AWAY from the razor here (D=2/3 → 204, D=4..7 → 234), and the live-length route and
the register it needs are mutually exclusive. The named open angle stays the **prim REF-SHED
to ≤ 11 refs** (3*11/114 = .289 < sd's 5*62/990 = .313), not the sd ref route.

---

## 3. draww.cpp — 3 devices CLEARED (35/35 PASS before and after)

| line | device | removal cost | device-free replacement |
|---|---|---|---|
| 2780 | `__asm__("" : "=r"(off7d) : "0"(off7d))` — the loop.c movable breaker for the four `sd->offset = 0x7d` stores | 44 | `int off7d = 0; off7d = 0x7d;` (dead first set) |
| 3412 | `__asm__("" : "=r"(objInstance) : "0"(objInstance))` — walker init launder | 34 | `{ Trk_SimpleInst *oi = objInstance; objInstance = 0; objInstance = oi; }` |
| 3920 | `__asm__("" : "=r"(objInstance) : "0"(objInstance))` — out-of-loop ref launder | 44 | same save/dead-set/restore |

Ladders measured for 2780 (`DrawW_DoTrough`): removed 44 · `0x7d` twice consecutive 44 ·
`0x7d;0;0x7d` 73 · **`0;0x7d` PASS** · `0x7d; store; off7d=0;` PASS (equivalent, the
dead-set-after-last-read form).
For 3412/3920: `objInstance = 0;` BEFORE the real assignment 34/44 (inert) · dead-set AFTER
38/44 · **save/dead-set/restore PASS** with 0, 1 and -1 as the dead value (all three PASS).

A 9th regex hit at line 6337 is `__asm__` text **inside a comment** (a recorded falsification),
not a device — noted so a future census does not "clear" it.

### draww devices re-priced but KEPT (restored verbatim)

| line | device | removal | best pure-C this wave |
|---|---|---|---|
| 1026 | 5× `"r"(sd)` ref dial (`DrawW_SubdividFacet`) | 94 | — pointer dial, no host op (§2) |
| 1313 | `"=r"(lt)` launder (`Night_NightCalc`) | 2 | save/dead-set/restore 2, dead-set-post 6 |
| 2196-2206 | the 66-ref `sd` dial (`DrawW_DrawQuad`) | 194 | inflator refuted on RTL (§2) |
| 3500 | `"=r"(g)` launder (`DrawW_BuildObjectFacets`) | 6 | dead0-post **4** |
| 3571 | `"=r"(objInstance)` loop-tail launder | 37 | save/dead-set/restore **5** |
| 4008 | `"=r"(g)` launder (`DrawW_BuildCustomObjectFacets`) | 68 | dead0-post **5** |
| 4116 | `"=r"(objInstance)` loop-tail launder | 45 | save/dead-set/restore **5** |
| 1981, 3486, 3929, 4615 | `"i"(0)` void fences | 5/4/1/1 | SKIPPED — `reorg.c:stop_search_p` impossibility class |

**COMBINATION PRICING (33A-3), both multi-launder functions, full 4×4 cartesian sweep
(`D2_combo.py`): no pair is jointly removable.** `DrawW_BuildObjectFacets` {3500,3571}: best
non-keep cell = 4 (dead0/keep); every joint substitution is worse than either alone (rm/rm 43,
save0/save0 11). `DrawW_BuildCustomObjectFacets` {4008,4116}: best 5; joint removal 111 vs
68/45 alone — i.e. these two are *jointly breaking*, the opposite of front.cpp's clobber pair.

---

## 4. 🏆🏆 THE LEVER THAT CHANGED THE WAVE — the ABSORPTION IDENTITY (relayed from W86-D1, applied here)

`V = (T)((unsigned int)V | ((unsigned int)V & 3u));`  — algebraically `X | (X & K) == X`.
Both operands are the SAME VARIABLE, so `fold-const` cannot remove it at tree level; it
survives as real RTL through **cse1 / loop.c / flow** (so it is counted as references AND as a
second SET), and **combine** then folds `(ior X (and X K))` back to `X` — combine runs AFTER
flow, so the instruction is never emitted. `X & (X | 3)` is equivalent.
It therefore reproduces, in pure C, all three things the zero-insn `__asm__` devices were
bought for: **+REG_N_REFS**, a **second SET** (loop.c movable/biv shield, cse value-number
kill) and an **IOR def instead of a register copy**.
⚠️ It also **splits the carrier's live range** at the set — which is a second, independent
effect, and at some sites it is the effect that matters (draww) while at others it is the
effect that costs (night's 5th reference).

### 4.1 draww.cpp `DrawW_DrawQuad` — the 66-fence `sd` REF DIAL is GONE (194 -> PASS)

All 66 `__asm__("" : : "r"(sd))` statements deleted; ONE absorption statement placed after
`geomVertices = sd->vertices;`. Whole TU **35/35 PASS**, function count-exact 592/592.

| | p80(`sd`) | rank | p87(`prim`) |
|---|---|---|---|
| 66 asm fences (old baseline) | refs=128 live=1002 pri=0.894 -> `$s0` | 6 | 0.842 -> `$s1` |
| 1 absorption statement (landed) | refs=125 live=**495** pri=**1.52** -> `$s0` | 1 | unchanged |

So it does NOT win by crossing the documented 2^7 reference razor — it wins by **splitting
sd's live range at the second SET**, which is why the ladder is flat in the count
(1/2/3/4/6/10/16/22/33/44 copies all gate identically) and sharp in the POSITION:

| absorption position (all 66 fences removed) | gate |
|---|---|
| function head, before the vertex block | 2 (prologue parm-copy order: ours `addu t4,a1,zero` before `addu s0,a0,zero`, retail after) |
| after `t2 = *(u_char *)(inQuad+3);` | 2 |
| **after `geomVertices = sd->vertices;`** | **PASS** <- landed |
| after `tx = (sd->trans).x;` | PASS (equivalent) |
| function tail (where the fences were) | 194 — `sd` is dead there, so any pure-C chain is dead code |
| absorption on `inQuad` instead | 194 (inert) |
| absorption on `sd` **and** `inQuad` | 2 (re-breaks the prologue order) |

### 4.2 night.cpp `Night_SetEnviroment` — 5 devices -> 1 (19/19 PASS)

The W80 QTY_CMP_PRI dial was `"r"(tgt)` x4 + `"r"(zn2)`. **Four of the five are now
absorptions**; the first reference must stay asm. Full 2^5 sweeps, both directions:

| configuration | gate |
|---|---|
| 5 fences (old baseline) | PASS |
| **1 fence + 4 absorptions (landed)** | **PASS** |
| every subset of {keep, absorb} that keeps fence #1 | PASS |
| 0 fences + any 1..4 absorptions (all 32 cells) | 8 |
| 0 fences, no replacement | 8 |
| 0 fences + save/dead-set/restore or dead-set, all 3^5 = 243 cells | best 8 |

Reason the last one resists: an absorption also SETS the carrier and splits its live range;
with no fence left, the split costs more than the reference buys. Named, not a floor.

### 4.3 draww.cpp `DrawW_SubdividFacet` — the 5-operand `"r"(sd)` REF DIAL is GONE (94 -> PASS)

The w64-a2 "PRICED REF DIAL (predicted N=5, measured N=5)" fence replaced by ONE absorption
statement in its place. Whole TU **35/35 PASS**, count-exact 588/588. One / two / four
absorptions and the `X & (X | 3)` form all PASS. This retires the "natural-source
alternative ... is the open angle that would retire this device" note in that ledger.

### 4.4 weather.cpp — 2 more devices cleared (25/25 PASS)

| line | device | removal | replacement |
|---|---|---|---|
| 1463 | `__asm__("" : "=r"(q) : "0"(q))` (`Weather_DoSplats`) | 36 | one absorption on `q` (2 or 4 absorptions = 28, so the count IS a dial here) |
| 1772 | `__asm__("" : : "r"(player), "r"(wdp))` (`Weather_DoWeather`) | W85-S4 measured **16** | **now INERT — simply deleted** (the later `cm`/`one` staging subsumed it). W85-S1's "receipts go stale" rule firing again. |

### 4.5 hrzsku.cpp — 2 devices cleared (22/22 PASS)

| line | device | removal | replacement |
|---|---|---|---|
| 163 | `__asm__ __volatile__("" : : "r"(i))` (`Horizon_InterpolateLineSCoords`) | 26 | one absorption on `i` |
| 2704 | `__asm__("" : "=r"(q) : "0"(q))` (`Hrz_BuildHorizon`) | 48 | one absorption on `q` |

### 4.6 hud.cpp — 1 device cleared (62/62 PASS)

`Hud_BuildString`'s third identity fence `"=r"(str)` (removal 33) -> save/dead-set/restore
`{ char *s_ = str; str = 0; str = s_; }`. Dead value 0, 1 and -1 all PASS; the plain
dead-set-after-last-read form is 33 (inert).

---

## 5. input.cpp — 🔑 the `addressBlocker` cluster is JOINTLY worth **6**, not 105 each (33A-3, the assignment's untried axis)

W85-S10 priced the 10-fence cluster ONE AT A TIME: each `"=r"(addressBlockerN)` producer
removal = **105**, each `"r"(addressBlockerN)` consumer removal = 6. Removing them as a SET
is a completely different number:

| configuration (`Input_Update`, all count-exact 868/868) | gate |
|---|---|
| all 10 fences (baseline) | PASS |
| **all 10 removed (5 producers + 5 consumers)** | **6** |
| keep 1 / 2 / 3 / 4 of the five pairs | 6 |
| all 5 consumers removed, producers kept | 6 |
| all 5 producers removed, consumers kept | 113 |
| producers -> absorption on the (uninitialised) blockers | 118 |
| consumers -> absorption | 6 |
| both -> absorption | 6 |

⇒ the cluster is a **matched pair set**: the 105 is the cost of an *unbalanced* cluster, not
of the pressure it supplies. Singly-priced device ledgers are systematically misleading for
symmetric device sets — always subset-sweep (33A-3, and D3's "jointly-priced triples").

**The residual 6 is ONE named item** (`vdiff`, ours 868 / oracle 868):

```
ours:   [before the loop]  lui v0,0 ; addiu s3,v0,0        ... addu v0,v0,s3
oracle: [inside the loop]                                   lui t3,0 ; addiu t3,t3,0 ; addu v0,v0,t3
```
i.e. loop.c hoists the `Device_gDeviceList` table base out of the interface loop into a
callee-saved `$s3`; retail rematerialises it inside the loop in a caller-saved `$t3`. The 5
blockers exist to deny that callee-saved seat. **Not landed** — the iron rule forbids
shipping a 6-diff regression, so all 10 fences were RESTORED verbatim.

FALSIFIED against that residual this wave (each a real whole-TU gate, cluster dropped):
index-term-first address `((*h & 0xff) * 12) + (int)Input_DeviceRows` 6 · `do{}while(0)`
around the whole loop body 110 · both 110 · a `rows` base local + absorption (in-loop decl 28,
single-statement 33, outer decl 10, dead-first-set 28) · splitting the `&&` chain so the row
address sits in its own block (plain 13, `do{}while(0)` 17, index-first 13, absorption 13) ·
a pre-loop absorption on each of h/left/menukeys/interfaceActive/i/r/acc/right/j/k/one
(6 for all of them, 7 for menukeys).

**S10's named SYM angle (two BLOCK-SCOPED overlapping arrays) — NOT executed, and here is
the honest reason.** The SYM has `active[17]` (block @line 51) and `hactive[17]` (block @line
183) sharing AUTO offset `-0x88`, while the recon has `hactive[17]` at FUNCTION scope reached
through the invented `activeBase` cursor plus a block-scoped `active[40]`. Two blockers found
in this pass that the angle has to solve first: (a) `activeBase` is read in BOTH mode arms
(lines 198/229/246 and 352/376/394), so `hactive` cannot simply be moved into one block
without losing the pointer retail reuses across the arms; (b) our `active` is indexed to
`j + 23` with `j < 17`, i.e. it genuinely needs 40 bytes, so it is NOT the SYM's `active[17]`
— the recon has fused two SYM arrays into one. The angle is therefore a *storage-shape*
rewrite of a 400-line function, not a scoping tweak, and it should be sized as such. It stays
the named next angle, now with its two preconditions written down.

---

## 6. 🔴 CORRECTION to §2 and §3 (read them together)

§2's verdict ("a pointer ref dial is not an inflator target") is TRUE for the *self-mask*
inflator `v &= v` and is the measurement that motivated the search — but it is NOT a floor
verdict for the dial. The **absorption identity** of §4 reaches exactly those pointer dials,
and it retired BOTH of draww's `sd` dials (66-fence, 194 → PASS; 5-operand, 94 → PASS). The
generalisation that survives is the narrower one:

> the inflator must be an operation **cse cannot fold but combine can**. `v &= v` / `v |= v`
> is folded by cse (or by `fold-const`) and contributes nothing; `v | (v & K)` survives cse
> and loop.c and flow, and dies in combine. Everything else in §2 (the tail is dead ground,
> the do{}while(0) depth wrapper moves away from the razor) still stands.

§3's "KEPT" table is likewise superseded for lines 1026 and 2196-2206 — both are cleared.

## 7. drawc.cpp — 9 devices CLEARED in one greedy pass (20/20 PASS)

Driver: `D2_greedy.py` — walk every zero-insn device, try
`removed | X|(X&3) | X&(X|3) | 2x absorption`, keep the first candidate that holds the whole
TU, continue in the NEW basin (so later sites are priced after earlier ones land).

| line (pre-edit) | device | old removal cost | landed |
|---|---|---|---|
| 1233 | `"=r"(envMapOffset)` 3-operand launder | 28 | absorption on `envMapOffset` |
| 2372 | `"=r"(facet_flag)` launder | (part of 31) | `X & (X | 3)` on `facet_flag` |
| 2372 | `"=r"(ff)` launder | | absorption on `ff` |
| 2587 | `"=r"(facet_flag)` launder | 120 | `X & (X | 3)` |
| 2587 | `"=r"(ff)` launder | | **removed — INERT in the new basin** |
| 3889 | `"=r"(ff)` launder | 31 | absorption on `ff` |
| 4100 | `"=r"(facet_flag)` launder | 99 | `X & (X | 3)` |
| 4100 | `"=r"(ff)` launder | | **removed — INERT in the new basin** |
| 4877 | `"r"(facet)` ref fence | 26 | absorption on `facet` |

KEPT in drawc (each re-probed with the full battery in the final basin):
`2546` the 5-operand `"r"(i)` ref dial (removal 194) — absorption reaches **26** and then
SATURATES (x1 220, x2/x3/x5/x6/x8/x10 all 26, fence+absorption 26: D3's "ref gain saturates
~1" confirmed) · `3898`/`4238` `facet_flag` launders · `4604` `"r"(tex)` · the four `"r"(ovs)`
fences (5072/5080/5085/5093 — full 3^4 K/R/A combination sweep: **not jointly removable**,
best cell is all-keep) · `5707` the bare load-order fence.

## 8. newton.cpp — 4 devices CLEARED (32/32 PASS), and the volatile keeps re-priced

`Newton_DoBarrierCollision`'s `"r"(nz)` and `"r"(ny)` ref fences became absorption identities;
with `nz` converted, the **two `"i"(0)` void fences that sat on the next two lines went inert
and were deleted** — a combination effect, not a single-device result (they were priced as
load-bearing when measured alone in the old basin).

The 3 `volatile` views S10 kept were re-priced in this new basin (assignment: "only re-touch
if an inflator shape can substitute"):

| device | S10 cost | cost NOW | absorption substitute |
|---|---|---|---|
| `(nz2 = *(volatile int *)&normal.z)` | 67 | **20** | plain 20, plain+absorption 20, absorb-after 21 |
| `islandMatrix.m[6]/m[7] = *(volatile int *)&barrierVec.x/y` | 36 | 36 | plain 36, plain+absorption 36 |

⇒ KEPT. The absorption cannot substitute for these by construction: they force a MEM RE-READ,
and the absorption only touches a register's value number — cse's `canon_hash` keys a MEM on
its address rtx and only `MEM_VOLATILE_P` sets `do_not_record` (S10's own compiler-source
proof). The `nz2` cost dropping 67 → 20 is a pure basin effect of the 4 clears above.

## 9. aistate.cpp — 2 devices cleared · aih_btccop / aiphysic / flare / hrzsku / sim / input — re-priced, KEPT

**aistate (52/52 PASS):** `"r"(search)` in `~AIState_Purgatory` (removal 14) and the W54-A15
`"r"(inRange)` REF-STEP in `AIState_GotoSlice::Execute` (removal 18) both became absorption
identities. Kept: `"=r"(latBias)` (15), the `"i"(0)` void fence (67), `"=r"(otherCarObj)`
(2 — the `reload_cse_regs` compiler-identity class, S1), `"r"(carObj)` (16, absorption 24/16).

**aih_btccop (40/40 PASS)** — all four kept, absorption inert at every one:
`"r"(addToSlice),"r"(startSlice)` 25 · `("" : : : "memory")` 12 · `"+r"(initSliceCandidate)`
20 · `"+r"(slice)` 28. Combination sweep of the two `SetupBlockader` fences (3^2 K/R/A cells)
finds no joint removal.

**aiphysic (42/42 PASS)** — `AIPHYSIC_KEEP_LAT_CLAMP`'s `"r"(r),"r"(limit)` (removal 136):
absorption on `r` reaches **93**, on `limit` 136, on both 93 — a real move, not a clear. The
`"m"(AIPhysic_GameSetupWords[0])` fence (8) is the W64-A12 certificate (an `"m"` operand is
the only zero-insn way to keep the `%hi` base pseudo live at a dead `lw`); untouched. The 3
`AIPhysicConfig` address-materialisation blocks in `OutOfControlPhysics` are
instruction-EMITTING asm, not zero-insn devices, and are outside this battery.

**flare (27/27 PASS)** — 5 kept; absorption is inert or worse at every one (707 `c` 3/3,
1184 `rgb` 2→10, 1953 `pp,cp` 2→11, 1958 `vx0,vy0` 12→19/12, 1961 `otSize` 4/4). All five
residuals are sched1/sched2 issue-order ties, i.e. **post-combine ⇒ pure C cannot reach them**
(the organising law relayed from D1). Triage verdict, not a grind.

**hrzsku (22/22 PASS)** — 7 kept after the 2 clears. Absorption inert at 2458 `i` (52), 2590
`cw` (19), 2606 `ch` (44), 2629 `pp` (72); worse at 406 `height,radius` (16 → 54..130) and
2655 `m24` (18 → 69..119). Full 2^5 K/A subset sweep of the five `Hrz_BuildHorizon` devices:
no cell but all-keep passes.

**sim.cpp (8/8 PASS)** — the `switch (*(volatile int *)&Replay_ReplayInterface.speed)` view
(removal 32) KEPT. S10's named BLOCK-LAYOUT angle was executed: inverting the `||` guard so
the switch block becomes a BRANCH TARGET (retail's shape, with an explicit label) leaves the
plain read at **32**, exactly as the un-inverted form — and the inverted guard WITH the
volatile still PASSes, so the layout change is byte-neutral and is NOT the dial. A pre-switch
absorption on `one` is also 32. ⇒ the reload is not reachable from block layout; it is the
cse MEM-equivalence question of S10's compiler-source proof, and `MEM_VOLATILE_P` remains the
only C-level instrument. (`sim.cpp:458` `"r"(gameSetup)` also re-probed, kept.)

---

## 10. END STATE — 45 devices cleared, ZERO PASS lost

| file | gate before | gate after | zero-insn devices before | after | cleared |
|---|---|---|---|---|---|
| recon/game/psx/draww.cpp | 35/35 | **35/35** | 29 | 9 | **20** |
| recon/game/psx/hud.cpp | 62/62 | **62/62** | 15 | 13 | **2** |
| recon/game/psx/drawc.cpp | 20/20 | **20/20** | 18 | 9 | **9** |
| recon/game/psx/flare.cpp | 27/27 | **27/27** | 5 | 5 | 0 |
| recon/game/psx/night.cpp | 19/19 | **19/19** | 5 | 1 | **4** |
| recon/game/psx/weather.cpp | 25/25 | **25/25** | 3 | 1 | **2** |
| recon/game/psx/hrzsku.cpp | 22/22 | **22/22** | 9 | 7 | **2** |
| recon/game/common/input.cpp | 8/8 | **8/8** | 13 | 13 | 0 |
| recon/game/common/aih_btccop.cpp | 40/40 | **40/40** | 4 | 4 | 0 |
| recon/game/common/aistate.cpp | 52/52 | **52/52** | 6 | 4 | **2** |
| recon/game/common/aiphysic.cpp | 42/42 | **42/42** | 2 | 2 | 0 |
| recon/game/common/sim.cpp | 8/8 | **8/8** | 1 | 1 | 0 |
| recon/game/common/newton.cpp | 32/32 | **32/32** | 10 | 6 | **4** |
| **total** | **326/326** | **326/326 PASS** | **120** | **75** | **45** |

(the draww "29" counts source-level `__asm__` statements; the `DRAWW_SD_REF10` macro body is
10 of them and expanded to **66 emitted fence statements**, all now gone.)

Cross-module check (methodology gotcha #0): `python tools/bulkcompile.py recon/game/common`
= **91/91 OK, 0 FAIL**; `recon/game/psx` = **32/32 OK, 0 FAIL**. No shared header was touched.
Every landed replacement is documented in-source at its site with a `W86-D2` tag carrying the
measured ladder, so no falsification is lost. Every probe that did not land was restored
verbatim (`D2_try.py`/`D2_auto3.py`/`D2_greedy.py` all restore in a `finally:`).

## 11. LAWS EARNED (catalog candidates)

1. **🏆 The ABSORPTION IDENTITY is the general zero-byte device replacement** —
   `V = (T)((unsigned)V | ((unsigned)V & 3u));` (or `V & (V | 3)`). It works on POINTERS as
   well as ints, and it supplies all four things the zero-insn `__asm__` devices were bought
   for at once: +REG_N_REFS, a second SET (loop.c movable/biv shield + cse value-number kill),
   an IOR def instead of a register copy, and a LIVE-RANGE SPLIT at the set. 45 devices in 13
   game-tree TUs fell to it, including two "priced ref dial" ledgers with multi-wave receipts.
2. **A ref dial's COUNT is often not the dial — POSITION and the live-range split are.**
   draww's `sd` dial was documented for eight waves as a `floor_log2` 2^7 reference razor
   (65 refs FAIL194 / 66 PASS). One absorption gives refs 125 (BELOW 128) and PASSes, because
   it halves the live range (1002 → 495) and so wins the same rank. The count ladder is flat
   (1..44 identical); the POSITION ladder is sharp (head 2, after the first `sd->` read PASS,
   tail 194). Always sweep position before count.
3. **The self-mask inflator (`v &= v`) contributes ZERO references** — proved on the allocno
   table (refs 122 for every chain length 2..30), because cse proves the equality and deletes
   the chain before flow. Only a form cse cannot fold but combine can is an inflator.
4. **A DEAD FIRST SET with a DIFFERENT value is a pure-C loop.c movable breaker**:
   `int k = 0; k = K; use(k);` (`V = K; V = K;` is folded by cse and is inert).
5. **Symmetric device SETS must be priced as a set.** input.cpp's `addressBlocker` cluster is
   105 diffs per producer removed ALONE and **6 for all ten removed together** — the 105 is
   the cost of an unbalanced cluster, not of the pressure. A singly-priced device ledger can
   overstate a cluster's value by 17x.
6. **The dead-code rule for pure-C devices**: a device placed where the carrier is DEAD is
   deleted before flow counts anything (draww tail: refs unchanged at 122 for every chain
   length). A pure-C device must sit where its carrier is live; an `__asm__` operand does not
   have to.
7. **Triage first (D1's organising law, confirmed on 5 files here)**: flare's five residuals,
   hrzsku's `pp`/`ch`, aih_btccop's four and drawc's `ovs` quartet are all sched1/sched2/reorg
   ties — post-combine, therefore unreachable from C. Recognising that saved the budget that
   found the 45.

## 12. NOTE ON SPELLING

The greedy driver emitted the replacements as
`V = (__typeof__(V))((unsigned int)V | ((unsigned int)V & 3u));`. `__typeof__` is a GNU
extension the ccpsx front end accepts (every one of these TUs compiles and gates), and it
keeps the statement correct for pointer and integer carriers alike. Hand-landed sites
(draww, night, weather, hrzsku, aistate, newton, hud) use the explicit type instead. If a
later wave prefers uniformity, swapping `__typeof__(V)` for the declared type is
byte-neutral — re-gate anyway.

## 13. NAMED OPEN ANGLES (rule 00b — none of these is a floor)

1. **input.cpp** — the cluster is jointly worth 6; the whole residual is loop.c hoisting the
   `Device_gDeviceList` base out of the interface loop into a callee-saved `$s3` where retail
   rematerialises it in-loop in `$t3`. Needs either a LICM shield that survives the `&&`
   short-circuit (every shape tried in §5 failed) or the SYM storage-shape rewrite, whose two
   preconditions are now written down in §5.
2. **draww `DrawW_BuildObjectFacets` / `DrawW_BuildCustomObjectFacets`** — the four surviving
   launders sit at 4/5/5/5 with the pure-C forms (from 6/37/68/45). Four functions' worth of
   near-misses; a 4×4 combination sweep is already exhausted, so the next move is a
   position sweep of the absorption inside those loops (the lever that cracked `DrawW_DrawQuad`).
3. **aiphysic `KEEP_LAT_CLAMP`** — 136 → 93 with one absorption on `r`. The remaining 93 was
   never priced against a position sweep; do that before calling it.
4. **drawc `DrawC_Prim`'s `"r"(i)` dial** — absorption saturates at 26 from 194. Same
   position-sweep move as (2)/(3): the count is not the dial (law 2).
