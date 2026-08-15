# W64-A17 receipts (screens + psxfront belt, EA dual-lane)

Base HEAD `fbc974f7`. All numbers below are MY OWN re-gates (`tools/verify_asm.py`),
never briefed rows. Probe harness: `scratchpad/w64a17/probe.py` (byte-mode patch ->
gate -> restore, asserts every anchor count==1) + `show.py` (one variant, full diff).

## RE-GATED BASELINES (2026-08-15)
| fn | TU | briefed | RE-GATED | final |
|---|---|---|---|---|
| Front_InitOpponentCars__FR9tFEStream | front.cpp | 93.13 / 111 | FAIL 111 (358/357) | **PASS 357** ✅ DUAL-LANE |
| GetPSXPadValue__Fii | front.cpp | 99.86 / 18 | FAIL 18 (222/222) | 18 (certificate re-confirmed) |
| FontUpsideDownBlit__FiiPviiP12charactertbli | psxfront.cpp | 89.60 / 20 | FAIL 20 (82/82) | 20 (certificate sharpened) |
| DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii | psxfront.cpp | 98.68 / 11 | FAIL 11 (246/245) | **7** |
| StatChk_SaveTopTime__FP10Car_tStatss | statchk.cpp | 95.84 / 33 | FAIL 33 (417/416) | 33 (+1 itemised, scaffolding cut) |
| StatChk_IsTopTime__FP10Car_tStatss | statchk.cpp | verify | PASS 299 (stale row) | **PASS + REAL=0** ✅ DUAL-LANE (CFG bug fixed) |
| DrawBackground__11tScreenMain | screenmain.cpp | 99.40 / 12 | FAIL 12 (822/822) | **PASS 822** ✅ + CFG bug fixed |
| MCRD_handlecardevents | memcard.c | verify | PASS 211 (stale) | PASS (production item filed) |
| DrawBackground__25tScreenCarSelectTwoPlayer | screencarselect.cpp | 99.9x | PASS 342 (stale) | PASS |
| DrawOpponentVideoWall__20tScreenCarSelectDuels | screencarselect.cpp | 99.9x | PASS 73 (stale) | PASS |
| DrawVideoWall__20tScreenCarSelectDuels | screencarselect.cpp | 99.9x | PASS 86 (stale) | PASS (production item filed) |
| CalculatePrizes__23tScreenTournamentTrophy | screencongrats.cpp | verify | PASS 144 (stale) | PASS + REAL=0 |
| DrawMemCardStuff__14tScreenMemcards | screenmemcard.cpp | verify | PASS 343 (stale) | PASS (production item filed) |

7 of 13 briefed rows were ALREADY PASS (stale-row epidemic confirmed again).

TU gates after all landings (each run 2x, ZERO PASS->FAIL anywhere):
front 42/43 · statchk 4/5 · **screenmain 13/13 (TU COMPLETE)** · psxfront 23/25 ·
screencarselect 59/59 · screencongrats 28/28 · screenmemcard 15/15 · memcard.c 20/20.
`tu_order_audit.py` 508 objects / 0 inversions.

---

## 🏆 LANDED 1 — front.cpp `Front_InitOpponentCars` 111 -> PASS 357/357 (DUAL-LANE, psyqproof REAL=0)
Two edits. **The W61-A17 "carInfo needs +7 refs" allocator certificate was aimed at a SYMPTOM.**

1. **111 -> 6 @357/357 — THE FN-SCOPE ALIAS WAS THE WHOLE HANDOUT.**
   `carLineup = streamData->carLineup;` in the `oppNumber==1` arm was a Ghidra
   artifact: retail addresses that arm's slots straight off `streamData`
   (`sw zero,440(s2)` / `sw zero,444(s2)` / `sb v0,448(s2)` / `sw a3,452(s2)` /
   `sb t0,456(s2)` / `sb t1,457(s2)` / `sb v1,428(s2)` == 420+N), and never emits
   `addiu sN,s2,420`. Deleting the alias removed the +1 insn AND collapsed the
   s0<->s1 swap the certificate priced -- the alias had stretched the FN-SCOPE
   `carLineup` pseudo's live range across a whole arm that never needed it, which
   is what pushed `i` ahead of `carInfo` in QTY_CMP_PRI.
   Measured: declaring carLineup inside arm 1 instead = 6 (identical), so the
   SYM-true fn-scope declaration was kept.
2. **6 -> PASS — `numOpponents = 5` moved into an explicit ELSE ARM.**
   With the pre-assigned default, gcc materialised `&frontEnd` as a `la` at the
   raceType guard and read the field off it (`addiu a0,v0,0; lbu v1,4(a0)`), then
   copied that reg into the loop's `fp` (`addu fp,a0,zero`); retail keeps the
   guard read FUSED (`lbu %lo(frontEnd+4)(v0)`) and rematerialises `&frontEnd`
   fresh in the preheader (`lui v0,0; addiu fp,v0,0`). Same count either way --
   purely which lo_sum cse2 may share.
FALSIFIED from the 6 basin (all re-gated): `(byte)frontEnd.raceType == 2` cast 6
(neutral); in-loop `tier`/`raceType` test order swapped 14; an explicit
`tfrontEnd *fe = &frontEnd;` local for the three in-loop reads 8.

🔑 **CATALOG CANDIDATE (§A / §D):** *before pricing a priority dial, check whether one
of the two contested pseudos is live in a region the SOURCE does not require. A
fn-scope local aliasing a struct member is the cheapest way to inflate a live range
invisibly, and the allocator certificate reads as a hard floor while it is present.*
This lens is what produced every landing in this belt.

## 🏆 LANDED 2 — screenmain.cpp `DrawBackground` 12 -> PASS 822/822 (**TU COMPLETE 13/13**)
Four steps, each re-gated:
1. **12 -> 7 (823) — 12D DEAD-PSEUDO STAGING for the tvOrder bound.** Retail computes
   it in a caller-saved reg, TESTS it there, then copies into $s1
   (`sra v1,v0,16; bltz v1,T; ... addu s1,v1,zero`); ours coloured the sign-extend
   straight into $s1 with no copy. $s1 is the SYM home of `x` (SHORT) and
   `deltaTicks` (ULONG), both dead there. The value is provably 16-bit
   (`(e<<12)>>16` keeps bits 4..19 sign-extended) so the SHORT carrier is EXACT.
   `deltaTicks` (the other $s1 SYM local) = exactly neutral 12; inlining = 35 @827;
   the fabricated `iVar10` has no SYM record.
2. **7 -> 1 (821) — the video block's carrier is an INT, not the SHORT `j`.**
   Retail passes it `addu a2,s0,zero` and tests it `beqz s0`; a SHORT carrier makes
   cc1plus sign-extend at both sites (`sll;sra` + `sll;beqz`) = 4 diffs + 2 insns.
   `j` must stay SHORT for the tv/dot-grid loops, so retail used a different
   variable -- a fresh block-scope int. The two SYM INT $s0 locals are the WRONG
   carriers because both are LIVE across this region: re-gated shapeY arg-only 75 /
   flag-only 85 / both 82; TextCol arg-only 24 / flag-only 34 / both 31; mixed 102;
   `int j` declaration 118 @806; vy at fn scope 11 @821.
   Same step: the elapsed-tick subtraction as its OWN named value (`u_long el = ...`)
   -- folded into the compare cc1plus computes it into the carrier's register and
   loads `ticks` through the shared %hi; retail keeps it anonymous in $v0 with a
   SELF-TEMP ticks load. Yoda-flipping the compare instead = 11.
3. **1 -> PASS — the ON-DEMAND %hi UN-SHARER.** Both Credits arms materialise
   `%hi(FEApp)`; reorg slots the then-arm's copy into the `bne` delay slot, which
   executes on BOTH paths, so cse2 (-fcse-follow-jumps) lets the else arm reuse it
   and we came out one `lui v0,0` short. Retail keeps two pseudos and enters the
   second test block at TWO labels (`.L80037B44` WITH the lui for the beq path,
   `.L80037B48` WITHOUT it for the bne path). A zero-insn void fence at the head of
   the else arm is the only device that un-shares them without disturbing the
   compare's operand/register roles.
   FALSIFIED from the 1 basin: Yoda in the else arm 10 @822 (adds the lui but
   reverses `bne v1,v0` and the three loads) / then arm 11 / both 21; arms swapped
   19; block-local for the menuCredits address else-only 8 @822, both 17; a
   block-local for `FEApp` else-only / then-only / both, a `tMenu **cm` local, and
   an explicit nested `else { if ... }` -- all exactly 1.
4. 🔴 **REAL CFG FIX (11C class) — retail's Credits guard is a FLAT `&&`.**
   Found by `psyqproof.py` (REAL=2) + `brdist.py` on the now-PASSing body. Retail's
   `beq` (fState==Credits AND menu==credits) targets `.L80037B44` = the SECOND
   test's head, so retail RE-RUNS the menu test and calls SetState(Credits) on that
   path; our nested `if (fState==Credits) { if (menu!=credits) ... }` sent it to the
   join and SKIPPED the second test. Same instruction stream, different control flow.
   `if ((fState==Credits) && (menu!=credits)) {...} else if (menu==credits) {...}`
   reproduces retail's CFG; gate stays PASS, **REAL 2 -> 1**.
   Re-gated alternatives: two SEQUENTIAL ifs 5 @821 (retail's two SetState calls
   cross-jump onto one shared `jal` at .L80037B6C, ours emits two jals); the same
   with an explicit goto funnel 6 @820 (both spellings).
   RESIDUAL production item: **word 86**, ours `bne ...,+10` (target `.L80037B44`,
   re-executing the redundant `lui v0`) vs retail `+11` (target `.L80037B48`) --
   retail's reorg redirected the branch PAST the target insn it had already stolen
   into the delay slot. Semantically identical (idempotent `lui` into a reg the
   delay slot just set); one word, named.

## 🏆 LANDED 3 — statchk.cpp `StatChk_IsTopTime` DUAL-LANE SEAL (gate PASS 299 + REAL 1 -> 0)
🔴 **A REAL CFG BUG BEHIND A GREEN GATE, fixed.** `brdist` flagged `(25, 13, 4)`;
`psyqproof` confirmed word 224 ours `beqz $v0,+12` vs retail `+3`. Retail's
LASTPLACE/TOPLIST chain is FLAT: from the
`LASTPLACE[0]!=0 / LASTPLACE[1]==0 / TOPLIST[1]==0` path it FALLS THROUGH into the
THIRD test (`beqz $v0,.L8004A09C` @0x8004A08C), where our nested
`if (LASTPLACE[0]) {...} else if (...)` jumped straight to the join.
FIX = the flat 3-way chain
`if (L0 && L1) {...} else if (L0 && T1) {...} else if (L1 && T0) {...}`.
cse's `record_jump_equiv` (11B) deletes the repeated `LASTPLACE[0]` guard, so the
flat spelling is CODEGEN-IDENTICAL -- gate still PASS 299/299 and the branch word
now matches. ⚠️ HAZARD: the FIRST `psyqproof` run after the edit reported the OLD
word (stale `.psyq.s` cache, the W61 hazard); the second run showed REAL=0.

## LANDED 4 — psxfront.cpp `DrawGouraudShape` 11 -> 7
The vertex-2/3 V pair is written BEFORE the U pair. With the U stores first, sched
hoists `prim[0x30] = u + w1` up between the 0x18 store and the 0x19 read-back
(`sb v0,24; sb v0,48; addu v1,t4,zero; sb v1,25`) where retail has
`sb v1,24; sb t4,25; sb v1,48`; putting the V pair first lets the read-back keep its
slot. Re-gated from the 11 basin: 0x30-before-0x24 alone 11; read-back after 0x24 11;
void fence after the read-back 10 @247; fence before it 11; `prim[0x30]=prim[0x18]`
read-back 47 @248. From the 7 basin: 0x30-before-0x24 7 (neutral); fence after the
read-back 9; interleaved 0x25/0x24/0x31/0x30 114 @245; `prim[0x24]=prim[0xc]`
read-back 42 @247; `prim[0x19]=v` direct 32 @245.
RESIDUAL 7 = the receipted read-back copy (`addu a0,t4,zero` where retail stores
`$t4` directly; combine_regs refuses because `v` is loop-carried and never dies at
the copy) + the `sb s2,36(s0)` position echo.

## LANDED 5 — statchk.cpp `StatChk_SaveTopTime` scaffolding cut (gate-neutral 33 @417/416)
Fence-2 lost its INERT `uBulkSz` operand (`"r"(uBulkUnit),"r"(uBulkSz)` ->
`"r"(uBulkUnit)`), re-confirmed EXACTLY 33 @417.
**THE +1 IS NOW FULLY ITEMISED** (three sites, read off `side_by_side.py`):
site 1 (uRecSz*18) ours `li v0,20; lhu t0,96(sp); ... sll s0,v0,3; addu a1,s0,v0`
  vs retail `li t0,20; sll s0,t0,3; addu a1,s0,t0` => **+1** (the dead `lhu` = the
  price of fence-1's `"r"(nNumCars)` operand);
site 2 (uBulkUnit*8) ours `li t1,20; addu v0,t1,zero; sll a2,v0,3` vs retail
  `li t1,20; sll a2,t1,3` => **+1** (the identity fence's global-allocno copy);
site 3 (memcpy size) ours `li a2,20 ... mult v0,a2` vs retail
  `li t0,20; mult v0,t0; addu a2,t0,zero` => **-1**.  +1+1-1 = +1 == 417-416. QED.
NEW FALSIFICATIONS (all re-gated from 33): fence-2 dropped entirely 60 @416 (retail's
COUNT, wrong registers -- and the SAME 60@416 basin as dropping f3); the site-2
identity fence turned into a READ-ONLY fence (the one shape that should delete its
output copy) 35 @417 -- the copy is the 13B global-allocno price, not the fence's
output; read-only + fence-2 reduced 60 @416; fence-3 given a second read operand
(`uCopySz` / `copyDst`) 33 both. => the 12E certificate stands: EVERY zero-insn device
buys retail's COUNT with the wrong registers (60-115), every insn-costing operand buys
retail's REGISTERS at +1 count (33). Open item unchanged: retail's THIRD opacity
mechanism for the literal 20 (a REG_EQUIV constant rematerialised at the use, born
after the topPlacements loop in $t0) -- an instrumented-cc1 job, not a spelling.

## FontUpsideDownBlit -- 20 unchanged; the certificate is SHARPENED, one premise CORRECTED
Anatomy (unchanged, `side_by_side.py`): ours materialises the tint at 19-20 and stores
at 28; retail materialises at 33/36 and stores at 41, INTERLEAVED into the 2nd OT-link
RMW with RMW2 in `$v1` where ours reuses `$v0`.
🔑 **THE COUPLING IS AN AVAILABILITY LOSS, NOT A PRIORITY ONE** -- and 15A says
availability losses are NOT reachable by any priority dial. Ours' RMW2 read is free to
take `$v0` because the tint died at 28; retail's tint is LIVE across RMW2, which is the
only thing that occupies `$v0` there. Ours also fills RMW2's load-delay slot with
`addiu v1,t8,5` (arg6), which is what takes `$v1` away; retail fills that slot with the
TINT LOAD itself. So order and qty-assignment are one coupling with a single root: the
tint load's schedule position. Every "tint after the link" spelling is the receipted
108-134 basin -- re-confirmed from the 20 basin with THREE new variants: plain
tint-after-link **112 @82**, tint-after-link + an alias-dial (COMPONENT_REF) store
**112**, tint-after-link with len/code interleaved **108**.
🔴 **NEW LAW / PREMISE CORRECTION -- the fence family is not merely "blunt", it is
STRUCTURALLY UNUSABLE in the link region: a fence there DELETES 3 instructions.**
Every fence placed between the dv chain and the len/code stores gates at **79 insns**
(3 short): between the link halves 91, after the link 73, before the tint statement 135,
both fences 91. **CONTROL (new): removing the existing x0/y0 fence = 22 @82, and MOVING
that single fence into the link region still gives 79** (between halves 95, after the
link 79) -- so it is the POSITION, not "a second `__asm__`". Mechanism: an asm in that
region changes maspsx's `.set reorder` regions and it stops supplying 3 load-delay nops.
This retires the earlier "135 @79 = fold collapses the pair" reading.
Also measured: the tint store spelled as a COMPONENT_REF (14D alias-dial) = 22 (+2).
Route unchanged: the instrumented-cc1 sched/qty lane (`#E'`).

## GetPSXPadValue -- 18 unchanged, certificate re-confirmed
Re-gated 18 @222/222. No new spelling attempted: the W62-A15 `-dg` certificate plus the
W61/W60 tables already close the axis (block-scope shadow / anonymous / fold measured
BYTE-IDENTICAL at all five groupings, so gcc builds the same RTL for all of them), and
the residual requires the last `or` of three MERGED tails to write a BLOCK-LOCAL dest --
which is exactly what un-merges them. Cross-checked against the SYM: `newControl` is
`REG $2 (v0)` = the `|1` RESULT, so retail's accumulator is anonymous; every source form
that makes ours anonymous lands the whole-function fold's different basin (252/308).
Route stays qtytrace / instrumented-cc1.

---

## 🔴 PRODUCTION ITEMS FOUND (14A/11C class -- REAL divergence behind a GREEN gate)
`brdist.py` + `psyqproof.py` run over the whole belt. Two FIXED (above), three filed:

| fn | word | ours | retail | class |
|---|---|---|---|---|
| DrawMemCardStuff__14tScreenMemcards | 139 | `blez $v0,+0x12` | `+0xa5` | **jump-threading** -- retail threads the first loop's zero-trip guard PAST the second loop's identical re-test (`lw 0x6C(s1); lw 8(v0); blez`) straight to `.L80047224`; ours falls into `.L80046FD8` and re-tests. Semantically identical, one branch word. |
| MCRD_handlecardevents | 56 | `bne $v1,$v0,+0x93` | `+0x5d` | same class (re-verified cache-warm, REAL=1) |
| DrawVideoWall__20tScreenCarSelectDuels | 53 | `beqz $v0,+0xd` | `+0xe` | the benign redundant-target-insn skip (same shape as screenmain word 86) |
| CalculatePrizes__23tScreenTournamentTrophy | -- | -- | -- | brdist row is a nop/label artifact; **psyqproof REAL=0** |
| DrawBackground__11tScreenMain | 86 | `bne ...,+10` | `+11` | benign redundant-target-insn skip (named above) |

⚠️ `psyqproof.py` CACHES `.psyq.s`: the first run after a source edit can report the
PREVIOUS body's words. **Always run it twice.** (Cost me one false "the fix didn't
work" reading on IsTopTime.)

## HAZARDS ENCOUNTERED
- `psyqproof` stale-cache (above) -- new, worth a tool note.
- `tools/verify_asm.py` paths: statchk.cpp / front.cpp live under
  `recon/frontend/common/`, NOT `recon/game/common/` as briefed; memcard.c is
  `recon/frontend/psx/memcard.c`.
- `tools/alpha.py` still UNRUNNABLE as committed (imports a `probe` module that only
  exists in w49 scratchpads) -- `posdiff.py` is the substitute (unchanged from w63).
- psxfront.cpp remains CRLF-normalised (w63 hazard); all probes ran byte-mode and
  re-applied the file's own newline convention, `git diff` clean before/after.
- No heredoc used for any escape-bearing content (Write tool + generated JSON only).

## FILES TOUCHED / BACKUPS
`recon/frontend/common/front.cpp` · `statchk.cpp` · `screenmain.cpp` ·
`recon/frontend/psx/psxfront.cpp`.  Backups after every landing:
`scratchpad/w64a17/{front,statchk,statchk...land2,screenmain...land1..3,psxfront}.cpp.land*`.
Commits: `f0c8fd44` `4bdcf935` `e9c610d6` `ea8feaf9` `19866795` `7c65de7f` `6dc5da63`.
