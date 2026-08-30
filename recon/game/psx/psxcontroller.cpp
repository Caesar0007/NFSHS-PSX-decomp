/* game/psx/psxcontroller.cpp -- RECONSTRUCTED (NFS4 in-game PSX controller mapping; C++ TU)
 *   4 fns: InGame_ResetPSXController (map pad+config -> Input_gHandler[]), InGame_GetPSXPadValue
 *   (axis selector -> packed control word, per controller type + per-player range cal),
 *   InGame_GetDevice (control & 0xff), InGame_SetRamp (digital-input -> disable analog ramp). No GTE.
 */
#include "psxcontroller_externs.h"

/* ---- InGame_ResetPSXController__Fii  [PSXCONTROLLER.CPP:97-163] SLD-VERIFIED ----
 * w39-a7: 334 -> 254 diffs, instruction count now EXACT 305/305.  Four fixes, each
 * gate-measured in isolation (all against the raw oracle, not a guess):
 *  (1) `h = Input_gHandler;` moves to right after `type = ...ID` -- the oracle
 *      materializes $s4 = %hi/%lo(Input_gHandler) BEFORE the type classification,
 *      i.e. it is the second statement of the function, not a late one.  (-14)
 *  (2) carFlags arm SWAP: oracle is `beqz` on `carFlags & 0x200`, so the flag-SET
 *      case (the single `h[0x81]` store) is the FALL-THROUGH and the flag-clear case
 *      (0x7d/0x7e/0x82) is the branch target -- write `if ((..&0x200)!=0){0x81}
 *      else {0x7d;0x7e;0x82}`.  (-12)
 *  (3) GameSetup_gData.Time arm SWAP, same reasoning (oracle `beqz` on the loaded
 *      Time word => the Time!=0 body falls through).  (-32)
 *  (4) the shared `u_int v` local was a FABRICATION -- the SYM lists exactly two
 *      named locals for this function, `h` (REG $0x14 = $s4, PTR INT) and `type`
 *      (REG $0x13 = $s3); there is no `v`.  One long-lived `v` spanning both
 *      carFlags arms forced a copy trio (`addu a0,a1,zero; ori a1,a1,6; addu
 *      a0,a1,zero`) at each of the three `| 6` sites where the oracle ORs in place
 *      (`nop; ori a0,a0,6`).  At this intermediate wave, giving each site a
 *      block-scoped `int m` collapsed them and made the count exact; W76 later
 *      recovered the same code with SYM-exact conditional call arguments.
 *      (-50, 307->305 insns)
 *      The remaining function-scope `v` is real: the Time if/else assigns it in
 *      both arms and it is consumed after the join (h[0x54]).
 *  (5) the 3-way type classification is spelled as a NESTED if (`if (type != 0x23)
 *      { if (0x53||0x73) 1 else 2 } else 0`), which matches the oracle's `beq` on
 *      the 0x23 test; the flat else-if chain inverts it to `bne` and a ternary
 *      funnel is much worse (302).  (-4)
 * w40-a7: 254 -> 216 diffs, still count-exact 305/305.
 *  (6) the `u_int v` local was ALSO a fabrication (SYM lists ONLY `h` $s4 and `type`
 *      $s3 -- see the 8c block at nfs4-f-v3.txt:454880).  Deleting it and DUPLICATING
 *      the `h[0x54-hoff[player]] = InGame_GetPSXPadValue(m,player)` call site into BOTH
 *      GameSetup_gData.Time arms (each with its own block-scoped `m`) lets gcc's
 *      cross-jump pass re-merge the two tails by itself -- the same treatment the two
 *      carFlags arms already get.  (-38)
 * w41-a7: 216 -> 40 diffs, still count-exact 305/305.  The w40 note (kept below) called
 * the residual a 6-way callee-saved ROTATION and blamed the `player*4` giv's live length.
 * The -dl/-dg dumps say something sharper: the giv (pseudo 121) was BLOCK-LOCAL --
 * "used 5 times across 86 insns IN BLOCK 8; crosses 8 calls" -- so LOCAL-alloc, which runs
 * BEFORE global-alloc and must give a call-crossing quantity a callee-saved reg, grabbed
 * $s0 for it, and global-alloc then had only $s1..$s6 for the six real allocnos.  Retail's
 * giv is a GLOBAL allocno that ranks LAST (its priority 2*5/86 = 0.116 sits below every
 * other saved-reg allocno except `config`), which is why retail parks it in $s5.
 * TWO edits, both gate-measured in isolation on top of each other:
 *  (7) move `GameSetup_gData.controllerData.controllerConfig[player] = config;` ABOVE the
 *      frontEnd.controlType if.  That puts the giv's DEF in the pre-branch block and its
 *      uses in the merge block => it stops being block-local, goes to global-alloc, and
 *      lands in $s5 exactly like retail; every other saved reg then falls into retail's
 *      slot (s0=mappings row, s1=&hoff[player], s2=player, s3=type, s4=h, s6=config).
 *      (216 -> 113, 304 insns)
 *  (8) the 3-way type classification as a TERNARY, `type = (type==0x23) ? 0 :
 *      ((type==0x53||type==0x73) ? 1 : 2);`.  This is retail's type-select FUNNEL: the
 *      three constants land in one scratch (`li $v0,0/1/2`) which is then copied into
 *      $s3 (`addu $s3,$v0,zero`), where the nested-if form writes $s3 directly.  An
 *      explicit `int t; ...; type = t;` funnel local measures IDENTICAL (40), so the
 *      ternary is preferred -- it needs no local the SYM does not list.  (113 -> 40,
 *      count back to 305)
 *      NOTE the w39/w40 notes had BOTH of these on their falsified lists -- they were
 *      measured on the pre-(7) base, where they are indeed worse (the flat else-if chain
 *      still is: 117).  This is the catalog's BLOCKING-REGISTER-CASCADE rule: re-test
 *      shelved leads after any structural fix.
 * RESIDUAL 40, in three clusters: (a) ~12 lines because our controllerConfig store now
 * EMITS before the controlType compare while retail emits it after (retail's giv is global
 * without the source move -- the open question is what else made it cross a block; every
 * cheaper spelling tried below is worse); (b) 3 x `sll $aN,$s2,2` scheduled one insn
 * earlier than retail; (c) the funnel copy's scratch ($a1 vs $v0).
 * FALSIFIED on the 40 base: original store position + ternary (266) -- the store move is
 * load-bearing, not cosmetic; a `int *cfg = ...controllerConfig + player;` pointer hoisted
 * above the if with `*cfg = config;` after (133); the store hoisted above `h =
 * Input_gHandler` (291, 306 insns); flat else-if type chain (117).
 * OLD w40 note: RESIDUAL 216 = a 6-way CALLEE-SAVED ROTATION, count-exact and otherwise
 * instruction-for-instruction identical.  ours {s0=player*4, s1=&mappings-row,
 * s2=&hoff[player], s3=type, s4=player, s5=h, s6=config} vs retail {s0=&mappings-row,
 * s1=&hoff[player], s2=player, s3=type, s4=h, s5=player*4, s6=config} -- i.e. our
 * allocno priority puts the `player*4` giv FIRST where retail ranks it LAST, which
 * rotates every other saved allocno up by one.  Mechanism: gcc-2.8 global.c priority is
 * floor_log2(n_refs)*n_refs/live_length; both builds give the giv 3 refs, so the
 * divergence is its LIVE LENGTH -- ours ends at the `Cars_gHumanRaceCarList[player]`
 * access (gcc reuses the giv's own register as that address's destination,
 * `addu $s0,$s0,$v0`), retail keeps it live past that point (`addu $v0,$s5,$v0`).
 * Downstream of the rotation, retail also needs a type-select FUNNEL (`li $v0,0/1/2`
 * then `addu $s3,$v0,$zero`) where ours writes $s3 directly.
 * FALSIFIED this wave (all re-measured on the post-(6) base, none reach below 216):
 * block-scoped/ternary/flat-chain funnels for the type select (266/266/220), a named
 * `int *hp = hoff + player` walker (251 but 11 insns SHORT -- structurally wrong),
 * `*(h + 0xae + player)` deref spelling (254), signed-vs-unsigned carFlags mask (254),
 * and all three declaration orders of {h, type, v} (254 each). */
void InGame_ResetPSXController(int player,int config)

{
  int type;
  int *h;

  type = PSXController_gPadBytes[player * 4][5];
  h = Input_gHandler;
  type = (type == 0x23) ? 0 : (((type == 0x53) || (type == 0x73)) ? 1 : 2);
  /* Exact-SYM lifetime probe: express every related address from the same
     player-scaled byte offset without introducing a source local. */
#define INGAME_PLAYER_OFFSET (player << 2)
#define INGAME_CONTROL_TYPE (frontEnd.controlType[player])
#define INGAME_PAD_ID (PSXController_gPadBytes[INGAME_PLAYER_OFFSET][5])
  if (INGAME_CONTROL_TYPE != (u_short)INGAME_PAD_ID) {
    INGAME_CONTROL_TYPE = (u_short)INGAME_PAD_ID;
  }
  ((GameSetup_tControllerData *)(INGAME_PLAYER_OFFSET +
                                 (int)&GameSetup_gData))
      ->controllerConfig[24] = config;
#undef INGAME_PAD_ID
#undef INGAME_CONTROL_TYPE
#undef INGAME_PLAYER_OFFSET
  /* w46-a8 (40 -> 21): the store is BACK at retail's position (after the controlType if)
     and the w41 lever-(7) job -- making the `player*4` giv a GLOBAL allocno instead of a
     block-local qty that steals $s0 pre-global-alloc -- is done by a ZERO-INSN USE FENCE
     in the pre-branch block instead.  The fence gives the giv a def/use pair that straddles
     the branch (catalog w41 §A: "move one statement so def/uses straddle a branch"), but
     unlike the statement move it does NOT drag the controllerConfig store ahead of the
     compare, which was ~12 of the 40 residual lines.  MEASURED (all with the store restored
     after the if): `&hoff[player]` 21 @306 (kept -- cheapest, +1 insn), `&controllerConfig
     [player]` 21 @308, +`h`/+`config`/+`type`/+`player` as extra operands 21 @306 (neutral),
     `controllerConfig[player]` VALUE 27 @306, `&Cars_gHumanRaceCarList[player]` 33,
     `hoff[player]` value 22, `h - hoff[player]` / `&h[-hoff[player]]` 32 @309,
     `&frontEnd.controlType[player]` 263, `&gPadinfo.buf[player*4].ID` 265,
     `&controllerConfig[0]` 243, `player` alone 241, no fence + store after the if 266.
     Keeping the store where w41 put it and fencing there instead: 28/32/44/48/52.
     w49-a6 (21 -> 15): the fence OPERAND was over-specified.  `&hoff[player]` forces the
     whole ADDRESS (`sll; lui; addiu; addu`) into the pre-branch block, where retail
     materializes only the `sll s5,s2,2` giv there and builds `s1 = s5 + %hi/%lo` AFTER the
     first jal.  Fencing the GIV ITSELF -- `player * 4` -- still straddles the branch (same
     global-allocno effect) but leaves the address materialization at its use.  `player << 2`
     identical; extra operands (type/h) neutral; a do{}while(0) wrapper round it 157.
     w53-a4: the residual 15 is now known to be the fence's own POSITION, and the position
     is CLOSED.  The 15 diffs are entirely the emission slot of the three `sll rN,s2,2` giv
     copies (retail materializes them AFTER the controlType compare's `beq`, ours before it)
     plus the one insn the fence costs (306 vs 305).  The fence was swept through the whole
     pre-loop region: pre-branch (kept) 15 @306; AFTER the if-block 266 @305; after the
     controllerConfig store 270 @305; INSIDE the if body 267 @306; pre AND post 15 @306;
     no fence at all 266 @305.  Everything except the pre-branch slot collapses to the
     no-fence baseline -- i.e. the fence only does its global-allocno job (the 251-diff win)
     from the pre-branch block, and from there the sll cannot be pushed past the compare.
     Also neutral this pass: a named `int p4 = player * 4;` local fenced instead of the
     expression, with the gPadinfo reads indexed off it (15 @306); a doubled operand list
     `"r"(player*4),"r"(player*4)` (15); the if-block written without braces (15); fencing
     `hoff[player]`'s VALUE instead 22 @307.
     ===== w59-a6: 15 -> 3 (count unchanged 306 vs 305).  THE `sll` SLOT WAS NOT A SCHED
     TIE -- IT WAS THE ADDRESS-BLOCK ORDER (catalog 09I CAST-INT ARRAY SUBSCRIPT).  Twelve
     of the fifteen diffs were three sites where the oracle emits `sll aN,s2,2` BEFORE the
     `lui/addiu %hi/%lo(hoff)` pair and ours AFTER it; all three are the FIRST statement of
     a basic block that follows a `jal` (the two `h[0x73 - hoff[player]]` arms of the
     `GameSetup_gData.Time` if/else, and `h[0x66 - hoff[player]]`).  Spelling just those
     three as the byte-base form `*(int *)((player << 2) + (int)hoff)` pins the scaled index
     as the first operand of the address block and issues it first: 15 -> 3.  Spelling ALL
     ~20 sites that way measures the same 3 (the other sites already match, so the minimal
     three-site edit is kept); spelling only ONE site = 11.
     RESIDUAL 3 = the read-only fence's OWN insn (306 vs 305): retail materialises
     `sll s5,s2,2` in the controlType `beq`'s DELAY SLOT (reorg's backward eager-steal takes
     it because it is the LAST pre-branch RTL insn), while our fence pins it FIRST in the
     block so reorg steals a `lui v0,0` from the fall-through instead.  RE-MEASURED IN THIS
     BASIN (the w53 fence sweep re-run): no fence 254 @305 -- so the fence is still load-
     bearing; identity fence 4 @307; void-tail fence 229 @306; non-volatile read-only fence
     3 @306 (identical); a SECOND fence before the controllerConfig store 3 (neutral); Yoda
     compare on the controlType test 31; a statement-expression fence placed after the
     compare's operand evaluation 22 @303.  Open angle unchanged: a device that makes
     `player * 4` a global allocno WITHOUT being the block's first insn.
     ---- w60-a7 (2026-08-14): 3 STAYS (306 vs 305).  The residual is now MECHANISM-
     COMPLETE and the open angle above is proved to be the only one left.  WHAT THE
     ORACLE DOES: reorg fills the controlType `beq`'s delay slot by a SIMPLE FILL of the
     `sll s5,s2,2` that is the LAST pre-branch RTL insn -- no duplication, hence 305.
     Ours has that sll as the FIRST insn of the block, so reorg's backward scan stops at
     `lbu v0,5(a0)` (it sets the branch's own operand) and the sll is unreachable; reorg
     then EAGER-STEALS `lui v0,0` from the branch TARGET, duplicating it -> 306.  The fix
     must put the sll's DEF pre-branch (for the global allocno) AND make it the LAST
     pre-branch insn.  Every device tried moves one or the other, never both:
       * THE GLOBAL-ALLOCNO JOB IS PRE-BRANCH-ONLY.  A fence on `player*4` placed after
         the last h[] store 260, ditto non-volatile 260, inside the carFlags then-arm
         33 @310 -- a LATE def/use pair does NOT make the pseudo global (no fence = 254).
       * FENCE AFTER THE COMPARE'S OPERANDS (aimed at making the sll last): condition
         hoisted to `int ne = ...;` + fence + `if (ne)` 28 @307; the same written as a
         statement-expression `if (({ int _ne = ...; __asm__(...); _ne; }))` 28 @307
         (volatile and plain identical); the fence inside the compare's SECOND operand
         22 @303.
       * NAMED `int p4 = player * 4;` defined after the if with the hoff sites indexed
         off it: 123 @302 / 121 @302 (cfg store left plain) / 141 @306 (hoff untouched);
         with the existing fence kept and p4 fenced instead of the expression 24 @303.
         All of them SHED instructions (302) -- retail rematerialises the address at
         every hoff site, so one shared p4 is structurally wrong.
       * 09I CAST-INT SUBSCRIPT on the controllerConfig store, to put the sll at the
         merge block's head so reorg would steal IT instead of the lui: without the fence
         260 (`player << 2` and `player * 4` identical), with the fence 5.  Spelling ALL
         ~28 hoff sites cast-int: without the fence 254, with the fence 3 and
         bit-identical to the kept minimal three-site form -- so the minimal edit stays.
   ---- W76 SYM-exact source correction (2026-08-23): **PASS 305/305**, no helper,
   no fence, and no post-compile text move.  The load-bearing spelling is a macro-only
   source quantity `INGAME_PLAYER_OFFSET = player << 2`, used both as the gPadinfo row
   index and as the later GameSetup owner offset.  Unlike `player * 4`, gcc does not fold
   this spelling back into ARRAY_REF before allocation: it remains live across the
   controlType branch, becomes the retail `$s5` global allocno, and reorg places its
   `sll $s5,$s2,2` in the branch delay slot.  Natural `frontEnd.controlType[player]`
   keeps the retail address/load shape.  The exact-graph owner-base carrier stores via
   controllerConfig[24] (owner byte 0x60) without importing absent GameSetup owner types.
   The earlier inline-helper PASS was a useful allocation proof but emitted an extra
   full-debug inline scope and is superseded.

   The four reconstruction-only block locals named `m` were also removed.  Their exact
   retail spelling is the conditional call argument `(type == 1) ? (mapping | 6) :
   mapping` (and `(type == 1) ? 6 : 0`); all four substitutions are byte-neutral.
   Full-debug scope proof now contains only REGPARM `player`=$s2, `config`=$s6 and the
   one retail function block with REG locals `type`=$s3 and `h`=$s4.  Type-graph gate:
   named 86/86, anonymous 2/2, no source extras. */
  h[0x4f - hoff[player]] = InGame_GetPSXPadValue(mappings[config][0][type],player);
  h[0x50 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][1][type],player);
  h[0x51 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][2][type],player);
  h[0x52 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][3][type],player);
  h[player + 0xae] = InGame_GetPSXPadValue(mappings[config][8][type],player);
  h[0x75 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][7][type],player);
  h[0x65 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][7][type],player);
  h[0x53 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][4][type],player);
  if ((Cars_gHumanRaceCarList[player]->carFlags & 0x200U) != 0) {
    h[0x81 - hoff[player]] = InGame_GetPSXPadValue(
        (type == 1) ? (mappings[config][10][type] | 6)
                    : mappings[config][10][type],
        player);
  }
  else {
    h[0x7d - hoff[player]] = InGame_GetPSXPadValue(mappings[config][0][type],0);
    h[0x7e - hoff[player]] = InGame_GetPSXPadValue(mappings[config][1][type],0);
    h[0x82 - hoff[player]] = InGame_GetPSXPadValue(
        (type == 1) ? (mappings[config][10][type] | 6)
                    : mappings[config][10][type],
        player);
  }
  /* w59-a6: the three `hoff[player]` reads below are spelled as the byte-base form
     `*(int *)((player << 2) + (int)hoff)` ON PURPOSE (catalog 09I) -- they are the first
     statement of a post-`jal` block and the plain subscript issues the `lui/addiu` pair
     ahead of the `sll`, which retail does not.  Do NOT "simplify" them back to
     `hoff[player]`: that costs 12 diffs.  Every other site in this fn stays natural. */
  if (GameSetup_gData[21] != 0) {
    h[0x73 - *(int *)((player << 2) + (int)hoff)] = InGame_GetPSXPadValue(mappings[config][9][type],player);
    h[0x54 - hoff[player]] = InGame_GetPSXPadValue(
        (type == 1) ? 6 : 0, player);
  }
  else {
    h[0x73 - *(int *)((player << 2) + (int)hoff)] = InGame_GetPSXPadValue(0,player);
    h[0x54 - hoff[player]] = InGame_GetPSXPadValue(
        (type == 1) ? (mappings[config][9][type] | 6)
                    : mappings[config][9][type],
        player);
  }
  h[0x66 - *(int *)((player << 2) + (int)hoff)] = InGame_GetPSXPadValue(mappings[config][5][type],player);
  h[0x67 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][6][type],player);
  h[0x68 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][0xc][type],player);
  h[0x4d - hoff[player]] = InGame_GetPSXPadValue(mappings[config][0xb][type],player);
  return;
}

/* ---- InGame_GetPSXPadValue__Fii  [PSXCONTROLLER.CPP:197-332] SLD-VERIFIED ----
 * w38-a9: rewritten as the NESTED SWITCH the oracle proves.  The oracle's
 * dispatch on `type` is gcc-2.8 `balance_case_nodes` output for exactly THREE
 * case nodes: root 0x53 (`beq`), bound test `slti $v0,$v1,0x54`, left child
 * 0x23, right child 0x73 -- a signature only a `switch` produces (an if-chain
 * has no reason to emit the `< 0x54` bound test).  Likewise the two inner
 * dispatches on `value`: 8 nodes (root 0x400000, signed `slt`, so 0x80000000
 * sorts FIRST as INT_MIN) and 5 nodes (root 0x8000, 2-node leaves stay
 * linear).  Case BODIES emit in SOURCE order, so the case order below is read
 * straight off the oracle's block VAs (0x800000, 0x200000, 0x100000, 0x400000,
 * 0x80000000, 0x20000000, 0x10000000, 0x40000000 / 0x800000, 0x200000, 0x4000,
 * 0x8000, 0x400); the shared tails (.L800DCC68 / .L800DCB9C / .L800DCBAC /
 * .L800DCBD8 / .L800DCBE8 / .L800DCCEC / .L800DCCF4) are gcc CROSS-JUMPING the
 * inline per-case expressions -- do NOT hand-funnel them.
 * SYM locals = exactly {c $s0, newControl $v0, type $v1} -> `type` is an INT
 * (oracle `slti ...,0x54` is SIGNED and there is no `andi 0xff` re-mask; a
 * u_char local emitted both).
 *
 * w39-a7 re-audit (unchanged at 329; ours 230 / oracle 233).  The STRUCTURE is
 * verified correct and is NOT the problem:
 *   - outer BST over {0x23, 0x53, 0x73}: our dispatch is instruction-for-instruction
 *     the oracle's (root 0x53 + `slti $v0,$v1,0x54` bound + 0x23/0x73 children);
 *   - inner 8-node BST (root 0x400000, signed order so 0x80000000 sorts first) and
 *     5-node BST (root 0x8000) both match, and the case-BODY emission order read off
 *     the oracle's block VAs is exactly the source order used here.
 * The residual is the ORACLE'S CROSS-JUMPING of the case tails: retail merges the
 * structurally identical case bodies into six shared tails (.L800DCC68 / .L800DCB9C /
 * .L800DCBAC / .L800DCBD8 / .L800DCBE8 / .L800DCCEC / .L800DCCF4), which is why each
 * case's OR-accumulator lives in a DIFFERENT caller-saved register ($a0 / $a1 / $a2 --
 * whichever the tail it jumps into expects) and why `sll $aN,$s1,2` (player*4) and
 * `sll $aN,$s1,30` (player<<30) end up speculatively computed in the BST branch delay
 * slots.  Our build emits every case body standalone with the chain in $v0, so the
 * jump2 cross-jump pass never fires -- gcc-2.8 cross-jumps only byte-identical tails,
 * i.e. AFTER register allocation, so this is allocator-conditioned, not a statement
 * shape.  Falsified this wave (all EXACTLY 329, i.e. jump-opt canonicalization):
 * `type = 0; if (nopad==0) type = ID;`, the ternary form, the inverted
 * `if (nopad != 0) type = 0; else ...` form, and `c = value; switch (c)`; a
 * `PAD_COMMON *p = &gPadinfo.buf[player*4];` entry pointer is slightly WORSE (331).
 * Also exactly neutral: all four PER_TU flag keys and g_value=8 on this TU.
 *
 * w40-a7 FLOOR RECEIPT (unchanged at 329; ours 230 / oracle 233).  Floor-bar items:
 *  - PROTOTYPE AUDIT vs SYM (nfs4-f-v3.txt:45493f, fsize 32, mask $80030000 = ra,s1,s0):
 *    REGPARM `value` $4($a0), REGPARM `player` $0x11($s1); locals `c` $0x10($s0),
 *    `newControl` $2($v0), `type` $3($v1).  Our build matches the frame, the save mask,
 *    both parameter homes and the return register exactly -- there is no arity, return
 *    or width error hiding here.  (`c` is the SYM's name for the `$s0` copy of `value`
 *    that gcc makes anyway; spelling `c = value; switch (c)` is measurably neutral.)
 *  - TRICHOTOMY on the nopad select, all re-measured this wave: default+override 329,
 *    if/else 329, explicit `goto`/label form 329, ternary 329, `type = ID; if (nopad)
 *    type = 0;` 322 but one insn SHORTER (229) -- i.e. every spelling collapses to the
 *    same jump-opt canonical layout and none reproduces the oracle's out-of-line
 *    `j .Lend; nop` else-block.
 *  - MECHANISM: gcc-2.8 `jump2` cross-jumps only tails that are BYTE-identical, i.e.
 *    after register allocation.  Retail's allocator happened to colour the per-case OR
 *    accumulators into $a0/$a1/$a2 so six case tails merged; ours colours them $v0/$v1
 *    (newControl's own home) so nothing merges and the `sll $aN,$s1,2` / `sll $aN,$s1,30`
 *    speculative fills never appear.  The dependency runs allocation -> cross-jump, so no
 *    statement shape can request it.
 *  - -G/flag identity: recorded neutral above (four -f keys + g_value=8).
 *  The permuter is the only remaining instrument and is blocked for C++ TUs (w38 s2F).
 *
 * w45-a3: 329 -> 279 (ours 212 / oracle 233).  THE w40 "ALLOCATION -> CROSS-JUMP, NO
 * STATEMENT SHAPE CAN REQUEST IT" VERDICT IS REFUTED.  Moving the final `| 1` OUT of the
 * case bodies and onto the return -- `newControl = <chain>; return newControl | 1;`
 * instead of `newControl = <chain> | 1; return newControl;` -- makes gcc's jump2 pass
 * cross-jump the case tails exactly the way retail's do.  Gate 329 -> 279, and the
 * ALPHA-RENAMED structural residual (tools/posdiff.py, the honest metric on a far-miss)
 * more than halves: LCS match 57/233 -> 98/233, residual 176 -> 135.  So cross-jumping IS
 * source-reachable here; it is the SHARED TAIL'S CONTENT, not the allocator, that decides.
 * This is the w44 catalog rule read in the right order: a cross-jump merge is compared on
 * RENUMBERED regs, so you shape the tail and let the allocation follow, not the reverse.
 * CURRENT RESIDUAL = OVER-merging: 212 vs 233 insns, i.e. we now merge 21 insns MORE than
 * retail, all in ONE region (chunkdiff `delete size 21  ours[61:82]` -- the 0x23/plain-pad
 * group's J1MIN/J1MAX pair).  Retail's shared tail is only the single `ori v0,a0,1`; ours
 * also merged that group's two `lw ...136/144(a0)` range-cal loads and its `sll s1,2`.
 * NEXT NAMED ANGLE (untried): DE-merge exactly that one group.  Two instruments, in order:
 *  (1) the arsenal 2b.5 USE fence -- `__asm__ volatile("" : : "r"(newControl));` at the end
 *      of the over-merged group's arms makes those tails differ so jump2 declines them,
 *      while leaving the other groups merged (this is the sanctioned fence class, not a
 *      register pin).  Apply to the SMALLEST set of arms that restores 233.
 *  (2) failing that, put the `| 1` back inline for that ONE group only and keep it at the
 *      return for the others -- the dial is per-group, and nothing requires all three
 *      switch groups to use the same spelling.
 * Also re-open from the 279 base (LEVER-ORDER meta -- the falsified lists above were all
 * measured in the 329 basin): the nopad trichotomy spellings and the parameter first-use
 * order (ours copies value->$s0 before player->$s1, retail the reverse; posdiff
 * `s0 a0 s1 a1` vs `s1 a1 s0 a0`).
 * Measured this session on the 329 base: `| 1` at the return 279 (adopted), `c = value;
 * switch (c)` 374, direct `return <expr>` per case (no newControl local) = compile error
 * (the local is referenced by the outer-switch fallthrough path).
 * ---- w50-a6 BRANCH CENSUS (tools/brcensus.py, the cheap structural check the de-merge
 * plan should be driven by).  Re-gated 264 diffs, ours 209 / oracle 233 (= 24 short):
 *     beqz 2 v 1 . bnez 4 v 5 . j 18 v 20
 * Reading: (a) `j` 18-vs-20 says the over-merge is exactly TWO un-taken arm tails -- the
 * de-merge target is 2 tails, not a diffuse 24 insns, so instrument (1) above should be
 * applied to precisely two arms and gated after each; (b) beqz/bnez 2/4 vs 1/5 at an equal
 * TOTAL of 6 is a single GUARD POLARITY flip (catalog: "beqz<->bnez swap at equal totals =
 * an arm-order flip"), and it is a separate, cheaper defect than the merge -- find the one
 * guard whose arms are inverted and fix it FIRST, since a polarity flip changes which tail
 * is the fall-through and therefore which tails jump2 is even offered.
 * No spellings were attempted this wave (budget went to the cario/fe3dmenu conversions);
 * the census is the deliverable and it makes the next pass a 2-arm search, not a 24-insn one.
 * ---- w53-a4 (still 264, ours 209 / oracle 233): the census's TWO named leads, executed.
 *  (a) THE GUARD-POLARITY LEAD IS DEAD AS A SPELLING.  diffsrc's oracle SLD proves what the
 *      polarity actually is: retail emits `lbu nopad; nop; bnez v0,L` [SLD 206] with the
 *      `lbu ID` on the FALL-THROUGH and `j` over it [207], i.e. the ID load lives INSIDE the
 *      not-taken arm; ours loads the ID unconditionally before a `beqz`.  Every C form of
 *      that if/else was gated FROM THIS BASIN and all five are +1 insn and worse: `if(nopad
 *      ==0) type=ID; else type=0;` 271@210, `if(nopad!=0) type=0; else type=ID;` 271@210,
 *      ternary 271@210, `type=0; if(nopad==0) type=ID;` 271@210, the `== 0` (int) spelling
 *      271@210.  gcc-2.8's jump-opt canonicalizes all of them to the unconditional-load
 *      layout; the default-then-override form (kept) is still the unique optimum at 264.
 *      => the beqz/bnez census delta is NOT a source-shape defect on this guard.
 *  (b) THE PER-GROUP `| 1` DIAL (the w45 receipt's untried "instrument (2)") IS WORSE, and
 *      posdiff is the reason to believe it: putting `| 1` back INLINE in the eight
 *      0x53/0x73 arms lands the INSTRUCTION COUNT almost exactly (235 vs retail 233, vs our
 *      209) -- which looks like the 24-insn de-merge the census asked for -- but the
 *      ALPHA-RENAMED structural residual gets WORSE, 138 -> 154 (posdiff LCS 95 -> 79), and
 *      the gate goes 264 -> 294.  So the count shortfall is NOT the same defect as the
 *      structural residual: the merged 209-insn body is structurally CLOSER to retail than
 *      the un-merged 235-insn one.  Do not chase the count.  (Fences on/off re-measured
 *      alongside: cur+fences 264 is still the optimum, cur-nofences 272@211.)
 *  NEXT INSTRUMENT (unchanged, and now better motivated): posdiff's first-use line is the
 *  one clean structural fact left -- ours `s0 a0 s1 a1 ...`, retail `s1 a1 s0 a0 ...`, i.e.
 *  retail's PLAYER parm copy is emitted before VALUE's (retail: `sw s1,20(sp); addu s1,a1`
 *  in the prologue with `addu s0,a0` deferred into the jal delay slot; ours the mirror).
 *  That is an assign_parms emission-order question (catalog: NARROW-PARAM lever / parm-copy
 *  sink), not a switch-shape one, and every case body's register roles hang off it. */
/* W75 exact-SYM carrier.  psxcontroller.obj contains GameSetup_tControllerData but
   not its GameSetup_tData owner.  Keep the player-scaled owner-base address explicit,
   then express owner offset 0x60 plus the selected controller field through the known
   controllerConfig word array.  Moving 0x60 into the pointer expression makes gcc emit
   %hi/%lo(GameSetup_gData+96) and costs 22 authoritative diffs; this form keeps the
   relocation on GameSetup_gData and the complete offset in each load displacement. */
#define INGAME_CD_VALUE(field) \
  (((GameSetup_tControllerData *)((player << 2) + (int)&GameSetup_gData)) \
       ->controllerConfig[24 + \
          (int)&((GameSetup_tControllerData *)0)->field / 4])
int InGame_GetPSXPadValue(int value,int player)

{
  int c = value;
  int newControl;
  int type;

  PAD_update();
  value = 0x80;
  /* w46-a8 (279 -> 264, with the two de-merge fences below): the nopad trichotomy
     RE-OPENED from the w45 `| 1`-on-the-return basin.  In the OLD 329 basin this
     spelling measured 322 and was rejected; in the 279 basin it is the BEST of the
     four (264 vs 271/271/271 for if/else, ternary and default-then-override) --
     a textbook basin-relative falsification (catalog w45 LEVER-ORDER law). */
  /* w61-a15 (264 -> 257): the nopad select transferred from front.cpp's
     sealed-adjacent GetPSXPadValue (18-diff twin).  The GOTO form + the
     zero-insn `__asm__("")` on the ID path reproduces retail's
     `bnez; li 0x53; lbu ID; j; nop; type=0` layout and lets gcc reuse the
     single 0x53 materialization at the switch join.  MEASURED from the 264
     basin: goto+fence 264 -> 257 (@212 insns), goto WITHOUT the fence 271
     (@210).  This is the device the w53-a4 "guard-polarity lead is dead"
     receipt never tried -- it swept plain if/else spellings only. */
  /* w62-a14 (still 257 @212 vs 233): THE DE-MERGE FENCE CONFIGURATION WAS
     RE-SWEPT FROM THE 257 BASIN (the w46-a8 sweep below was measured at 264;
     04Z basin-relativity).  All 12 `return newControl | 1;` arms enumerated,
     harness scratchpad/w62a14/fence.py (rebuilds the body with a fence before an
     arbitrary SET of arms, control reproduces 257 exactly).  {8,9} SURVIVES as the
     unique optimum: none 265 @214 . every singleton {0}..{7} 266-270 @221 . {8}
     261 @212 . {9} 259 @214 . {10} / {11} 269 @218 . {8,9}+one of {0,1,2,3} 260-264
     @219 . {8,9}+{4,5,6,7} 269-273 @226-228 . {8,9}+{10} / +{11} / +{10,11} 261 @216
     . all 45 {8,9}+two-arm pairs 264-285 @223-242.  => the over-merge is NOT a
     fence-placement question any more; the count shortfall and the structural
     residual are the same two facts w53-a4 separated (the merged 212-insn body is
     structurally closer than any 233-insn de-merged one).  What the sweep DOES
     newly show: 14 of the 66 configurations reach retail's exact 233 count and
     every one of them scores 272-285, i.e. the count is now REACHABLE and
     PROVABLY not the defect.  The live route is unchanged: retail's dispatch
     delay slots carry `sll aN,s1,2` (player*4) + `li a0,0x80` speculatively while
     ours carry `sll aN,s1,30` (player<<30), and retail's prologue copies PLAYER
     before VALUE (`sw s1,20(sp); addu s1,a1` with `addu s0,a0` in the jal slot;
     ours mirrored) -- an assign_parms/sched1 emission-order question. */
  /* w63-a14 (257 -> 168 @243 vs 233): THE CROSS-TU TWIN'S EXPRESSION SHAPE,
     PORTED WHOLESALE.  recon/frontend/common/front.cpp's GetPSXPadValue (the
     18-diff near-sealed twin) writes every tagged arm as ONE FLAT OR chain with
     the tag constant SECOND -- `player<<0x1e | TAG | hi*0x10000 | lo*0x100` --
     whereas this fn had the tag nested inside the hi term
     (`(hi*0x10000 | TAG)`).  Its own receipt says that flattening is what took
     front.cpp 160 -> 18, and it transfers: three independent, additive landings,
     each re-gated here from the 257 basin:
       (a) flatten the six tagged 0x53/0x73 arms          257 -> 208 @243
       (b) + flatten the two tagged 0x23 arms (0x4000/0x8000) -> 197 @244
       (c) + front.cpp's TWO-STAGE compound spelling on the 0x23/0x200000 arm
           (`newControl = tag|hi; return (newControl |= lo) | 1;`)   -> 168 @243
     The de-merge fence set was RE-SWEPT from each new basin (04Z): after (a)+(b)
     the w62-a14 optimum {8,9} is no longer optimal -- {} 197 @238, {8} 196 @237,
     {9} 198 @245, {8,9} 197 @244 -- and after (c) the winner is {8} alone
     (168 @243) vs {} 189 @244.  So arm 9's fence is SUPERSEDED BY the two-stage
     spelling: the compound assignment is what keeps that tail from over-merging,
     and the fence becomes redundant.  Falsified from the (c) basin: the same
     two-stage spelling applied to arm 8 as well ({8} 196 @245, {} 188 @239 --
     both worse), i.e. the two 0x23 range arms are NOT symmetric; retail keeps
     one fenced-shaped and one compound.
     LAW CANDIDATE (catalog): when two TUs carry the SAME retail function under
     different names (a frontend/in-game pair), the near-sealed twin's EXPRESSION
     SHAPE is a first-class oracle -- port it before dialing.  Here it beat six
     waves of fence/basin sweeps that never questioned the OR-tree nesting.
     The residual 168 is the structural pair the census already named: retail's
     dispatch delay slots carry `sll aN,s1,2` (the int-array index player*4) and
     `li a0,0x80` SPECULATIVELY where ours carry `sll aN,s1,30`/`lui`, and the
     prologue parm-copy order is mirrored (retail `sw s1,20(sp); addu s1,a1`
     first, `addu s0,a0` in the jal slot).  Both are emission-order, not shape.
     ===== w64-a14: THE +10 COUNT GAP IS SOLVED AND PRICED (not landed) =====
     The gap is ONE fact repeated at ~10 arm sites: retail's per-arm address is
     `<index reg> = player*4` MUTATED IN PLACE by the base
     (`addu aN,aN,v0; lw v1,136(aN)`) -- each arm returns, so the index pseudo is
     dead after its own use and gcc may clobber it -- while ours preserves the
     index and mutates the BASE (`sll a0,s1,2; addu a0,a0,v0`), one insn more per
     site.  Rewriting the arms as `po = po + (int)&GameSetup_gData;` +
     `((GameSetup_tData *)po)->controllerData.F[0]` with `po = player * 4;` before
     the switch reaches retail's COUNT EXACTLY -- 233/233 -- and the whole
     per-arm stream becomes count- and offset-exact.  It gates 210, i.e. WORSE on
     the authoritative metric than the current 168, because a fn-scope `po` is ONE
     global allocno that takes ONE register ($a2) at every site, whereas retail's
     nine `sll <reg>,$s1,2` (census:
     `grep -cE 'sll +\$[av][0-9], \$s1, 2$' asm/nonmatchings/main/InGame_GetPSXPadValue__Fii.s`
     = 9) each land in a DIFFERENT register ($a0/$a1/$v1/$a2) -- i.e. retail
     REMATERIALIZES the scaled index per arm into a fresh BLOCK-LOCAL qty.  So the
     next angle is NOT a hoist: it is per-arm block-local index pseudos that gcc is
     allowed to clobber (the 3.12 #14 in-place-dead-pointer-store shape applied to
     an INDEX, not a base).  Measured this wave, all from the 168 basin:
     `po` hoisted before the switch 225 @230 (3 SHORT) . `po` at the top after
     PAD_update 225 @230 . the in-place mutation form 210 @233 COUNT-EXACT .
     OR-tree operand order: `player << 0x1e` moved LAST 306 @259, moved SECOND
     198 @243 (the twin's tag-second rule does NOT extend to the player term).
     ===== W71-A6 (2026-08-21): 168 -> 114 @239 vs 233.  TWO ADDITIVE LANDINGS. =====
     (1) INDEX-TERM-FIRST ADDRESS SPELLING (methodology 3.12-fusion / W60-A6
         Hud_BuildNumbers0 refutation), applied through the INGAME_CD macro:
         `((GameSetup_tData *)((player << 2) + (int)&GameSetup_gData))->controllerData.F[0]`
         instead of `GameSetup_gData.controllerData.F[player]`.  168 -> 126 @241.
         WHY IT WORKS -- this is the w64-a14 "+10 count gap" item solved WITHOUT the
         fn-scope `po` hoist that cost 210: spelling the index term FIRST makes the
         arm block OPEN with `sll aN,s1,2`, which is exactly the insn retail's reorg
         STEALS into the dispatch `beq`'s delay slot (retail: `beq s0,v0,.Larm;
         sll a1,s1,2`).  The stolen copy is then live across the fall-through path,
         so several arms REUSE one scaled index -- retail has only 9 `sll ?,s1,2`
         for 12 index-using arms.  With the natural `F[player]` spelling gcc emits
         `lui/addiu` first and the sll last, so nothing is stealable and every arm
         pays its own sll.
         🔴 THE SHIFT SPELLING IS LOAD-BEARING: `player * 4` is folded straight back
         into an ARRAY_REF by fold() and measures 168 (identical to the old base);
         only `player << 2` survives.  `(int)&GameSetup_gData + (player << 2)`
         (base written first) is byte-identical to the index-first form -- fold
         canonicalizes the operand order, so it is the MULT-vs-SHIFT that is the
         dial, not the textual side.
     (2) TWO-STAGE COMPOUND on the 0x53/0x200000 arm (the same device already on
         0x23/0x200000): `newControl = tag|hi; return (newControl |= lo) | 1;`
         126 -> 114 @239.  Re-swept ALL 10 remaining `return newControl | 1;` arms
         from the 126 basin -- arm1 (0x53/0x200000) is the unique winner (114); the
         others land 131/150/131/146/137/160/135/142/143 -- and re-swept AGAIN from
         the 114 basin: no second compound helps (119..160).
     04Z re-sweeps done from EVERY new basin (both are basin-relative):
       - fence set: from 126, singletons {}=154 {0}=169 {1}=154 {2}=169 {3}=153
         {4}=179 {5}=152 {6}=179 {7}=144 {8}=126 {9}=160 {10}=160, pairs {8,x}
         126..145 -> {8} unique optimum; from 114 (indices shift by one after the
         arm-1 compound) {}=142 and singletons 114..167 -> the SAME arm
         (0x23/0x800000) is still the unique optimum, pairs {7,x} 119..143.
       - OR-term order re-measured in the 126 basin: player-term LAST 272 @255,
         SECOND 143 @240, tag-first byte-identical (126) -- the w64 verdict holds
         across the basin move.
     FALSIFIED THIS WAVE (all from the 126/114 bases): a fn-scope
     `GameSetup_tData *gp` assigned once after PAD_update 296 @197 (cse collapses
     all 12 address materializations into one saved reg -- the same failure mode as
     w64's `po`); a BLOCK-SCOPE `GameSetup_tData *gp` declared per arm 155 @240
     (a fresh pseudo per arm, but the decl-init is emitted BEFORE the `player<<30`
     chain-start and steals the arm's a0, inverting every arm's register roles);
     the SYM's `c` local (`c = value; switch (c)`) at three positions 233/233/133.
     RESIDUAL 114 @239 (+6): opcode census `or 17v16  sll 49v46  subu 7v5`.
     Named: (i) 3 arms still pay their own `sll ?,s1,2` (reorg declines the steal
     where the dispatch slot is already filled from the fall-through `j` block);
     (ii) the 0x23/0x800000 tail is still un-merged with 0x53/0x800000 (retail's
     .L800DCC68), which is the SAME last-`or`-dest defect front.cpp's 18-diff twin
     is stuck on: our chain accumulates in $a1 and the final `or` writes
     newControl's global home $a0 (`or a0,a1,v0`), retail accumulates IN newControl's
     own register from the first term (`sll a0,s1,30; or a0,a0,v1; or a0,a0,v0`) so
     its tails are byte-identical and cross_jump merges them.  ⇒ the twin's
     "keep the 1 out of the tag constant / cse-identity device" angle is the shared
     next instrument for BOTH functions; it is worth ~6 insns and ~40 diffs here.
     (iii) prologue parm-copy order still mirrored (retail copies PLAYER first).
     ===== W72-A15 (2026-08-22): 114 -> 108 @239.  RESIDUAL (iii) IS SOLVED AND THE
     PROLOGUE IS NOW BYTE-EXACT (addiu sp,-32 / sw s1,20 / addu s1,a1 / sw s0,16 /
     sw ra,24 / jal PAD_update / addu s0,a0 -- all six words).
     THE DEVICE: the SYM's `c` local, DECLARED-AND-ASSIGNED BEFORE THE CALL, with both
     inner dispatches and the fall-through expression reading `c` instead of `value`.
     WHY (read off the SYM, not guessed): the 8c block at nfs4-f-v3.txt:45493f gives
     REGPARM `value` = $4 (**$a0**, i.e. value NEVER gets a callee-saved home) and a
     separate REG local `c` = $0x10 ($s0).  So retail's `addu $s0,$a0,$zero` is a BODY
     STATEMENT (`c = value;`), NOT an assign_parms parm copy -- which is exactly why it
     is emitted AFTER `player`'s parm copy and therefore becomes the LAST pre-jal insn,
     the one reorg's backward `fill_simple_delay_slots` scan takes for PAD_update's slot.
     With `switch (value)` the parm itself must live across the call, so assign_parms
     emits ITS copy first (decl order value,player) and reorg steals player's instead --
     the mirrored prologue.  Parm-copy ORDER is fixed at declaration order and is NOT
     reachable by any statement move; the reachable dial is whether a parm needs a copy
     AT ALL.  (Catalog candidate: "a SYM REGPARM record naming an ARG register proves
     that parameter has no callee-saved home -- the sN copy you see is a body-statement
     local, so give it one.")
     MEASURED (all from the 114 basin): `c = value;` BEFORE PAD_update + switch(c) 108
     @239 (kept) . the same + an identity launder on c 111 @240 . `c = value;` AFTER
     PAD_update 114 (inert -- a0 is dead by then, gcc folds it back) . after + launder
     169 @242 . the copy alone with `switch (value)` kept 114 / +launder 114 @241 (both
     inert: cse merges the two pseudos) . read-only fence on `player` before the call
     113 @240 . read-only fence on `value` after the call 114.  NOTE the w63/w71 note
     above recorded "`c = value; switch (c)` at three positions 233/233/133" -- that
     sweep did NOT rewrite the trailing `player << 0x1a | value << 8 | 2` default arm,
     so `value` stayed live across the call and the parm copy stayed.  The rewrite must
     be TOTAL for the lever to fire.
     04Z RE-SWEEPS FROM THE NEW 108 BASIN (both axes re-priced, both CLOSED):
       - de-merge fence set: none 136 @241 . +{0} 122 . +{1} 133 . +{2} 113 . +{3} 137 .
         +{4} 119 . +{5} 137 . +{6} 119 . +{7} 108 (the arm that already carries it) .
         +{8} 114 . +{9} 114  => the single 0x23/0x800000 fence is still the unique
         optimum and is still load-bearing (-28 vs none).
       - two-stage compound set: {0} 125 . {1} 144 . {2} 113 . {3} 140 . {4} 119 .
         {5} 154 . {6} 117 . {7} 159 . {8} 124 . {9} 136  => no second compound helps.
       - OR-chain ACCUMULATION SHAPE (new axis this wave, falsified): three-stage
         `newControl = player<<0x1e[|TAG]; newControl |= HI; return (newControl |= LO)|1;`
         on all arms 230 @227 / on the 0x53 group only 208 @215 . two-stage on ALL arms
         145 @236 . start-alone + one big compound 227 @232 . start-alone + two compounds
         224 @225.  The receipt's "accumulate in newControl's own register from the first
         term" reading is CORRECT about retail but is NOT reachable by compound spelling
         -- every |= form sheds instructions (225-236 vs retail's 233) because gcc folds
         the chain into fewer pseudos, not more.
     RESIDUAL 108 @239 (+6) = the a0<->a1 ARM ROLE SWAP, quantified: in ~9 of the 13 arms
     ours puts the SCALED INDEX (`sll aN,s1,2`, mutated in place by `addu aN,aN,v0`) in
     $a0 and the `player<<0x1e` chain in $a1, while retail has index=$a1 / chain=$a0 --
     and in the 0x800000 arms (both groups) retail agrees with us (index=$a0, chain=$a1).
     Both pseudos are BLOCK-LOCAL qtys born in the arm block (the `sll` only reaches the
     dispatch delay slot in reorg, POST-allocation), so this is a local-alloc
     QTY_CMP_PRI / 3-qty-ladder question per arm, driven by which shared tail the arm
     cross-jumps into (retail has TWO tails, one expecting the chain in $a1
     (.L800DCC68 -> `ori v0,a1,1`) and one in $a0 (.L800DCCF4)).  NEXT INSTRUMENT (named,
     not run this wave): the instrumented-cc1 [qty_order]/[find_free_reg] trace on one
     arm block (C:\Temp\nfs4-instr-cc1) -- read which qty is served first and by how much,
     then price a ref/live dial on the chain pseudo.  Do NOT re-sweep fences, compounds or
     accumulation spellings; all three are closed in this basin.
     -dl/-dg RECEIPT taken this wave (tools/rtl_dump.py, real CC1PLPSX):
       `;; 9 regs to allocate: 82 83 84 89 269 272 277 348 81`
       Register 81 = player, 28 refs / 232 insns / 1 call -> hard reg 17 = $s1  (retail $s1)
       Register 83 = c/value, 19 refs / 62 insns / 1 call -> 16 = $s0            (retail $s0)
       Register 82 = **newControl**, 33 refs / 31 insns / DIES IN 12 PLACES -> 4 = $a0
       => newControl already lives in retail's $a0, and both parms are in retail's homes.
       Everything else in the arms (registers 97..361, ~250 pseudos, each "2-3 times
       across 2-12 insns IN BLOCK N") is a BLOCK-LOCAL qty decided by local_alloc's
       QTY_CMP_PRI/3-qty ladder, per arm.  So the a0<->a1 swap is NOT a global-allocno
       question at all -- it is which of an arm's 2-3 local qtys local_alloc serves first.
       That also explains why retail's index register VARIES per arm ($a1 in most,
       $a0 in the 0x800000 arms, $v1 at one dispatch): retail rematerializes a fresh
       per-arm index qty, exactly as the w64-a14 note predicted.
     ADDITIONAL FALSIFICATIONS THIS WAVE (all from the 108 basin):
       - PER-ARM three-stage accumulation (`newControl = player<<0x1e[|TAG];
         newControl |= HI; return (newControl |= LO) | 1;`), swept one arm at a time:
         125/152/142/157/140/153/144/159/142/141 -- every arm worse, so the "accumulate
         in newControl's own register from the first term" shape is unreachable per-arm
         as well as globally.
       - NAMED 0x80 CARRIER (retail hoists `addiu $a0,$zero,0x80` into a dispatch delay
         slot and shares it): `int k80 = 0x80;` before the switch, applied to the
         subtrahend sites 198 @241, to the addend sites 135 @238, to both 224 @241;
         declared/assigned at the top of the fn 206/238.  Naming the constant hands
         gcc a fn-scope allocno and costs far more than the sharing buys.
     CORPUS MINING (user directive; C:\Temp\ps1-decomp-refs), two cited results:
       (1) parasite-eve-2-decomp/DECOMPILATION_LEARNINGS.md "Large sparse switches:
           case order and shared handlers" -- gcc-2.8.1 emits case BODIES in an order
           tied to the binary-search tree, and when the decision tree matches but the
           handler tails are shuffled you reorder the `case` LABELS to the target's
           leaf-emission order.  RE-VERIFIED here against the current oracle by walking
           the block VAs and matching each block's content signature (tag constant /
           +0x80-vs-0x80- / J1-vs-J2 offsets 0x88,0x90 vs 0x98,0xA0): .L800DCAA0 =
           0x800000, .L800DCAC0 = 0x200000, .L800DCAF0 = 0x100000, .L800DCB1C =
           0x400000 ... -- i.e. our source order IS the oracle's leaf order and this
           axis is already correct.  (The same doc's flag-compare recipe uses a
           `register ... asm("v0")` pin and is out of bounds under the no-pins rule.)
       (2) The FRONTEND TWIN's oracle (asm/nonmatchings/front/GetPSXPadValue__Fii.s)
           was diffed against ours instruction-for-instruction.  RESULT: the two retail
           functions read DIFFERENT DATA SHAPES -- front's controller table is a
           BYTE array indexed by `player` at stride 1 (`addu $v1,$s1,$v1; lbu
           $v0,0x353($v1)`, fields 0x349/0x34B/0x34D/0x34F/0x351/0x353/0x355/0x357 and
           a 0x7F bias), ours is an INT array at stride 4 (`sll $aN,$s1,2; addu;
           lw 0x88($aN)`, fields 0x68..0xA0 and a 0x80 bias).  So the twin's per-arm
           ADDRESSING cannot transfer -- only its OR-chain flattening did (W63-A14),
           and there is nothing further to port.  Do not re-open the twin as an
           addressing oracle.
     ===== W74-A12 (2026-08-22/23): 108 -> 97 @234 vs 233.  THE FRONT TWIN'S W72-A8
     COUPLED DEVICE TRANSFERS, AND IT TRANSFERS EXACTLY ON THE PAIR THE W71 RECEIPT
     NAMED (retail's .L800DCC68 = 0x53/0x800000 + 0x23/0x800000).
     THE DEVICE (front.cpp GetPSXPadValue, W72-A8, verbatim shape):
         { int acc = player << 0x1e;
           __asm__("" : : "i"(0) : "$2","$3");
           return (acc | <hi> | <lo>) | 1; }
     Both halves are load-bearing here exactly as they are there: the BLOCK-LOCAL `acc`
     lets local-alloc.c's combine_regs tie the last `or`'s dest to its own first operand
     (`or aN,aN,vM`) -- the one global `newControl` allocno can never be tied (:1841
     rejects a source with reg_qty < 0, :1874 a dest with reg_qty == -1) -- and the
     zero-insn hard-reg CLOBBER pushes the resulting block-local qty off find_free_reg's
     ascending $v0/$v1 landing onto retail's register, so the two arms' tails stay
     byte-identical and jump2's cross_jump still merges them.  Without the clobber the
     pair measures 135 (the un-merge); with it 97.  The pair is ATOMIC (arm 0 alone 122,
     arm 7 alone 98, both 97), and it also RETIRES the w46-a8 de-merge fence that had
     been the unique optimum for five waves (bit-neutral once the acc is there).
     MEASURED THIS WAVE (all re-gated; arm indices = the 10 `return newControl | 1;`
     arms in source order: 0..6 = the 0x53/0x73 group, 7 = 0x23/0x800000,
     8 = 0x23/0x4000, 9 = 0x23/0x8000):
       clobber sets on the {0,7} pair: {$2,$3} 97 @234 <== LANDED . {$2} 97 (identical) .
         {$2,$3,$4} 97 . {$2,$4} 97 . {$2,$5} 99 . {$2,$3,$5} 99 . {$3} 135 . {$4} 135 .
         {$5} 135 . none 135 -- denying $v0 is the whole effect; $v1 is free either way.
       every OTHER singleton, with {$2,$3} and with no clobber (18 cells): 112-175 @239-249
         (0:122/120 . 1:175/146 . 2:117/114 . 3:132/142 . 4:136/120 . 5:115/139 .
          6:130/134 . 8:118/120 . 9:112/126) -- the COUNT blows up in every one, i.e. a
         lone acc arm ALWAYS un-merges; only a whole cross-jump group may be converted.
       all 10 arms at once: {$2,$3} 153 @240 . no clobber 234 @235.
       triples {0,7}+X with {$2,$3}: +1 164 . +2 103 . +3 121 . +4 110 . +5 104 . +6 119 .
         +8 107 . +9 101 . {0,7,2,9} 107 . {0,7,8,9} 151  => {0,7} is the unique optimum.
     🔑 LAW CANDIDATE (catalog): the 20B/21A preference-killer's PARTNER is the arm's own
     cross-jump GROUP -- convert every arm of one retail shared tail together, or not at
     all.  A singleton conversion is not a weaker version of the cure, it is a DIFFERENT
     (un-merging) transform, which is why five waves of singleton/all-arm sweeps read the
     device as inapplicable to this function.
     RESIDUAL 97 @234 (+1) = the SAME a0<->a1 role swap in the two REMAINING retail
     tails.  From the side_by_side those are:
       (i)  the tail ending `or a1,a1,v1 ; j ; ori v0,a1,1` (ours `or a0,a1,v1 ; ori
            v0,a0,1`) -- the 0x53/0x400000 family;
       (ii) the tail ending `or a2,a2,a0 ; j ; ori v0,a2,1` (ours `or a0,a2,a0`) -- the
            0x3000000/subtract group, which wants $a2, i.e. a clobber set that denies
            $v0,$v1 AND $a0,$a1 without costing the arm its address pair.
     That is the front twin's OWN standing residual (its G1 wants $a2, its G2 wants $a1,
     and there the clobber costs +2 address-rematerialisation insns).  => the two
     functions are still ONE problem.  NEXT TAKER: do the GROUP DISCOVERY first -- for
     each retail shared tail walk the oracle's `.L800DC*` labels and list the arms that
     jump into it, then convert that exact set with the smallest clobber that denies the
     registers below the wanted one.  Do NOT sweep singletons again.
     W77 GROUP/QTY RECEIPT (2026-08-23): updated per-function m2c plus the raw oracle
     partitions the remaining arms as {0x400000,0x20000000,0x40000000} -> $a0 tail,
     {0x100000,-0x80000000,0x10000000} -> $a2 tail, and
     {0x53/0x200000,0x23/0x200000,0x23/0x4000,0x23/0x8000} -> the other $a0 tail.
     The current instrumented-cc1 trace prices the first positive group's chain qty at
     refs/life 4/24 (priority .3333) behind the address qty at 7/18 (.7777): exactly
     +4 chain references are required to take $a0.  A block-local `acc` plus two tied
     zero-insn uses crosses that threshold and improves 97 -> 85; spelling the indexed
     controller pointer before the carrier improves once more to 84 @235.  Both forms
     were intentionally UNWOUND because they add non-retail `acc`/`cd` debug locals.
     One tied use misses the threshold (107); moving the uses after the expression costs
     107 @244; the complete $a2 block-local conversion is 103 alone and 88 atop the 84
     basin.  Next: reproduce the +4-ref qty change with a DECL_IGNORED compiler temporary
     or a source identity that leaves no SYM local; do not re-run the named-carrier grid. */
  /* W78 SYM-SAFE ANONYMOUS QTY LANDING (2026-08-23): 97 @234 -> 76 @235.
     GCC 2.8.1 source closes W77's DECL_IGNORED route: every DECL_IGNORED_P setter in
     the C++ front end is for compiler-created/type declarations, never a user variable
     or variable attribute (`unused` retains all three `acc` debug records).  The same
     allocation is nevertheless reachable without a source local.  In every arm of the
     exact retail positive shared-tail group {0x400000,0x20000000,0x40000000}, first
     expose the common player-indexed controller address as an unnamed input, then give
     the already-CSE'd `player << 0x1e` quantity two unnamed uses.  Keeping the address
     and value fences separate is load-bearing: one combined address+2 package is 102;
     separate address+2 is 76.  Each arm is atomic (dropping the first arm to one use is
     82 @239, the second 94 @245), while a third/fourth use is byte-neutral at 76.
     Full `-g` CC1PLPSX output introduces NO local/block records.  Reordering the source
     declarations from `newControl,c,type` to the SYM's `c,newControl,type` is byte-neutral
     and makes the emitted record order exact: value, player, c, newControl, type.
     CLOSED from this basin: OR associations 117/120; pointer-last operand order 106;
     duplicate address input 102; `m` instead of the address `r` input byte-neutral 76;
     applying the same dial to the other four-arm $a0 tail 128 @233 (compound pair alone
     93 @232); direct-return conversion of that tail 107 @232; direct-return conversion
     of the $a2 tail 120 @237; putting `|1` back inside newControl on the positive/$a2
     groups 113/156.  A fresh trace prices the negative-tail rotation as shared-0x80,
     address,chain = a2,a0,a1 -> desired a0,a1,a2, but a literal asm input creates a NEW
     constant qty instead of adding refs to the shared one (one per arm 108 @239, three
     per arm 133 @244).  Duplicating a high term is 137 @238 and duplicated returns are
     183 @250; tag-first and `-(field-0x80)` are byte-neutral.  W78's reference-catalog
     follow-up also closes a tiny inline subtraction helper (142 @239) and the equivalent
     `~field+0x81` spelling (148 @235); `0x100-(field+0x80)` and `0x7f-field+1` compile
     byte-identically at 76.  The remaining 76 is thus a freshly priced two-tail/dispatch
     problem; its negative-tail route requires a source use that attaches to the EXISTING
     shared 0x80 qty, not another literal qty. */
  /* W76 SYM correction (2026-08-23), byte-neutral at 97 @234: the explicit nopad
     gotos/labels are replaced by their natural if/else, removing the non-retail label
     debug record.  In the two atomic 0x800000 arms, repeating `player << 0x1e` as both
     a zero-insn asm input and the return term makes gcc CSE one unnamed block-local
     quantity across the barrier.  It allocates exactly like W74's named `acc`, but no
     source local or nested debug block is emitted.  Full-debug names/types/scopes now
     match retail: REGPARM value=$a0, player=$s1, and one function block containing only
     c=$s0, newControl and type=$v1.  The still-nonmatching build colors newControl=$a0;
     retail's SYM says $v0, so that register home remains part of the binary residual. */
  if (PSXController_gPadBytes[player * 4][4] == '\0') {
    type = PSXController_gPadBytes[player * 4][5];
    __asm__("");
  }
  else {
    type = 0;
  }
  switch (type) {
  case 0x53:
  case 0x73:
    switch (c) {
    case 0x800000:
      return ((0x80 - INGAME_CD_VALUE(J1MIN[0])) * 0x10000 |
              (0x80 - INGAME_CD_VALUE(J1MAX[0])) * 0x100 |
              (player << 0x1e) ) | 1;
    case 0x200000:
      newControl = player << 0x1e |
                   (INGAME_CD_VALUE(J1MIN[0]) + 0x80) * 0x10000;
      return (newControl |= (INGAME_CD_VALUE(J1MAX[0]) + 0x80) * 0x100) | 1;
    case 0x100000:
      newControl = player << 0x1e |
                   0x1000000 |
                   (0x80 - INGAME_CD_VALUE(J1MIN[0])) * 0x10000 |
                   (0x80 - INGAME_CD_VALUE(J1MAX[0])) * 0x100 ;
      return newControl | 1;
    case 0x400000:
      __asm__("" : : "r"((GameSetup_tControllerData *)
                           ((player << 2) + (int)&GameSetup_gData)));
      do { newControl = player << 0x1e |
                   0x1000000 |
                   (INGAME_CD_VALUE(J1MIN[0]) + 0x80) * 0x10000 |
                   (INGAME_CD_VALUE(J1MAX[0]) + 0x80) * 0x100 ; } while (0);
      return newControl | 1;
    case -0x80000000:
      newControl = player << 0x1e |
                   0x2000000 |
                   (0x80 - INGAME_CD_VALUE(J2MIN[0])) * 0x10000 |
                   (0x80 - INGAME_CD_VALUE(J2MAX[0])) * 0x100 ;
      return newControl | 1;
    case 0x20000000:
      __asm__("" : : "r"((GameSetup_tControllerData *)
                           ((player << 2) + (int)&GameSetup_gData)));
      do { newControl = player << 0x1e |
                   0x2000000 |
                   (INGAME_CD_VALUE(J2MIN[0]) + value) * 0x10000 |
                   (INGAME_CD_VALUE(J2MAX[0]) + 0x80) * 0x100 ; } while (0);
      return newControl | 1;
    case 0x10000000:
      newControl = player << 0x1e |
                   0x3000000 |
                   (0x80 - INGAME_CD_VALUE(J2MIN[0])) * 0x10000 |
                   (0x80 - INGAME_CD_VALUE(J2MAX[0])) * 0x100 ;
      return newControl | 1;
    case 0x40000000:
      __asm__("" : : "r"((GameSetup_tControllerData *)
                           ((player << 2) + (int)&GameSetup_gData)));
      do { newControl = player << 0x1e |
                   0x3000000 |
                   (INGAME_CD_VALUE(J2MIN[0]) + value) * 0x10000 |
                   (INGAME_CD_VALUE(J2MAX[0]) + 0x80) * 0x100 ; } while (0);
      return newControl | 1;
    }
    break;
  case 0x23:
    switch (c) {
    case 0x800000:
      /* W74-A12: the w46-a8 DE-MERGE FENCE that lived here (`__asm__ volatile("" : :
         "r"(newControl));`, the unique fence optimum through five waves) is now
         SUPERSEDED and REMOVED.  W76's unnamed repeated-expression quantity preserves
         the same allocation and is exactly bit-neutral (97 @234), while avoiding the
         non-retail `acc` debug local. */
      return ((0x80 - INGAME_CD_VALUE(deadSpot[0])) * 0x10000 |
              (0x80 - INGAME_CD_VALUE(steeringRange[0])) * 0x100 |
              (player << 0x1e) ) | 1;
    case 0x200000:
      newControl = player << 0x1e |
                   (INGAME_CD_VALUE(deadSpot[0]) + 0x80) * 0x10000 ;
      return (newControl |=
              (INGAME_CD_VALUE(steeringRange[0]) + 0x80) * 0x100) | 1;
    case 0x4000:
      newControl = player << 0x1e |
                   0x1000000 |
                   INGAME_CD_VALUE(ImaxRange[0]) * 0x100 ;
      return newControl | 1;
    case 0x8000:
      newControl = player << 0x1e |
                   0x2000000 |
                   INGAME_CD_VALUE(IImaxRange[0]) * 0x100 ;
      return newControl | 1;
    case 0x400:
      newControl = player << 0x1e | 0x30aff01;
      return newControl;
    }
    break;
  }
  newControl = player << 0x1a | c << 8 | 2;
  return newControl;
}
#undef INGAME_CD_VALUE

/* ---- InGame_GetDevice__Fi  [PSXCONTROLLER.CPP:338-339] SLD-VERIFIED ---- */
int InGame_GetDevice(int control)

{
  return control & 0xff;
}

/* ---- InGame_SetRamp__Fv  [PSXCONTROLLER.CPP:349-365] SLD-VERIFIED ----
 * w39-a7: 25 -> 13 diffs (99/98).  The recon had MIS-ASSIGNED the SYM's local `h`.
 * SYM (fsize 48, mask $803F0000 = ra,s5..s0 -- SIX saved regs) declares exactly two
 * named locals: `h` = REG $0x14 = **$s4** (PTR INT) at FUNCTION scope, and `i` =
 * REG $0x13 = $s3 (SHORT) inside the line-8 block.  The oracle materializes $s4 =
 * &Input_gHandler BEFORE the `Replay_ReplayMode` test, i.e. `h` is Input_gHandler
 * (an unconditional function-scope initializer) -- NOT `hoff + i` as the old recon had
 * it.  Rewritten to the SYM shape: `h = Input_gHandler` at fn scope, `short i` in the
 * if-block, `h[K - hoff[i]]` at the three call sites.  Loop shape is the oracle's
 * zero-trip-guard + ROTATED do-while (`i=0; if(i<N){do{...}while(i<N);}`): a plain
 * `for`/`while` emits a top-tested loop with a `j` back-edge and no `blez` pre-guard
 * (41 diffs, and 5 insns SHORT).  Placing `hp = hoff + i;` FIRST in the loop body
 * (before the three ramp stores) is worth another 4.
 * RESIDUAL 13 = ONE loop-invariant too many: our loop.c hoists `&hoff`'s `lui/addiu`
 * into the preheader and parks it in a SEVENTH callee-saved register ($s6, frame 48
 * with `sw ra,44`), while retail REMATERIALIZES `lui %hi(D_8013DAC0); addiu %lo` inside
 * the loop every iteration and keeps six saved regs (`sw ra,40`).  Everything else is
 * byte-identical.  Falsified levers (do NOT re-try): single-use `int *hp = hoff + i`
 * (still hoisted), `*(volatile int *)&hoff[i]` (volatile does not defeat THIS hoist),
 * `*(int *)((char *)hoff + i*4)` and `*(int *)((i<<2) + (int)hoff)` byte-math forms,
 * sized `extern int hoff[2]`, `extern volatile int hoff[]` (regresses ResetPSXController
 * 334 -> 345), an `__asm__("hoff")` label view, making `hoff` a real file-scope
 * `static int hoff[2] = { 0x4d, 1 };` per its SYM `class STAT` (neutral under BOTH -G4
 * and -G8), and all four PER_TU flag keys (no_schedule_insns{,2}, no_strength_reduce,
 * g_value=8 -- all exactly neutral on this TU).  This is the gcc-2.8 loop.c
 * `threshold*savings*lifetime >= insn_count` cost model choosing to move a third
 * invariant that retail's cc1 left in place; -dL territory.
 * w41-a7 -dL RECEIPT (the w39/w40 notes called for it; now measured).  With `hp = hoff+i`
 * as the FIRST loop statement the dump prints, for the SetRamp loop:
 *     Loop from 38 to 234: 58 real insns.
 *     Insn 49: regno 96 (life 2), move-insn savings 2  moved      <- &hoff  %hi
 *     Insn 50: regno 95 (life 1), forces 49 savings 1  moved      <- &hoff  %lo
 *     Insn 55: regno 98 (life 2), move-insn savings 2  moved      <- &Cars_gHumanRaceCarList %hi
 *     Insn 56: regno 97 (life 1), forces 55 savings 1  moved      <- ... %lo
 *     Insn 71: regno 105 (life 50), savings 1          moved      <- the `1` stored to the 3 ramp fields
 *     Insn 92/134/176: (life 1) savings 1              not desirable
 * loop.c moves a movable iff `threshold*savings*lifetime >= insn_count`.  From the four
 * verdicts, insn_count = 58 and threshold is pinned to [15,57]: savings1*life1 is refused
 * (T < 58) while savings2*life2 is taken (4T >= 58 => T >= 15).  Retail hoisted the
 * Cars list pair and the constant but NOT the &hoff pair, which under this model needs
 * 4T < insn_count, i.e. retail's loop counted >= 61 real insns at loop.c time -- 3+ more
 * than ours.  Both movables are shape-identical (2-insn split-address pairs, life 2), so
 * no per-movable source lever can separate them; shortening a lui/addiu pair's life below
 * 2 is impossible.  Re-measured this wave: moving `hp = hoff + i;` AFTER the three ramp
 * stores makes the &hoff pair the SECOND movable (life 2 vs the Cars pair's life 5) but
 * BOTH are still moved -> 17 diffs, worse.  => genuine gcc-2.8 loop.c cost-model floor at
 * 13; re-opening it needs the loop to legitimately carry 3 more pre-optimization insns.
 * w40-a7 re-audit (unchanged at 13).  The residual is EXACTLY three instructions in
 * two places: our preheader carries `lui $v0,%hi(hoff); addiu $s6,$v0,%lo(hoff)` and the
 * body does `addu $s0,$v1,$s6`; the oracle carries nothing in the preheader and does
 * `lui $v0; addiu $v0,$v0; addu $s0,$v1,$v0` in the body, immediately BEFORE the first
 * `lw $v1,0($s0)` and AFTER the three `sw $s2,..` ramp stores.  Note both builds emit
 * gcc's OWN split lowering (not an `la` macro), so this is purely LICM placement, not
 * the §E address-materialization class.  Newly falsified this wave (add to the list
 * above): moving `hp = hoff + i;` to AFTER the three ramp stores (17), the same with a
 * block-scoped `hp` (17), dropping `hp` entirely and writing `hoff[i]` at all three use
 * sites (17), `hp = &hoff[i]` address-of spelling (13, neutral), and SIZING the extern
 * `hoff[2]` / `hoff[8]` (13 each, neutral -- and neutral on ResetPSXController too, so
 * the §E sized-view lever does not apply here).  `hoff` is SYM class STAT
 * (nfs4-f-v3.txt:454b75, ARY INT dims 1 2) and is referenced by no other TU, so the
 * declaration is free to change if a future lever needs it.
 * w45-a3 (still 13, 99/98).  The w41 -dL model above is sound, and its own arithmetic names
 * the ONLY reachable input: loop.c moves a movable iff threshold*savings*lifetime >=
 * insn_count; the &hoff pair is savings 2 / life 2 (a lui+addiu split pair -- life cannot go
 * below 2 and savings is fixed by its shape), so the single free variable is the loop's RTL
 * INSN COUNT at loop.c time: ours 58, retail needed >= 61.
 * NEW NAMED ANGLE (untried; replaces the "genuine cost-model floor" verdict, which treated
 * insn_count as fixed when it is precisely the input the source controls).  loop.c runs
 * EARLY -- after cse1 but before cse2 (-frerun-cse-after-loop, on at -O2), combine, and both
 * schedulers.  So the loop only has to carry 3 more insns AT LOOP.C TIME; anything a later
 * pass folds away costs nothing in the output.  That is a bounded search: source forms whose
 * extra RTL dies in combine.  Candidates, cheapest first -- (a) write the three ramp stores
 * through the SYM-typed control-block pointer instead of `*(int *)(ctrl + K)` byte math
 * (combine folds the address arithmetic back, but loop.c counts it first); (b) spell the
 * three `InGame_GetDevice(h[K - *hp]) == 1` guards against a named `int one = 1;` (the copy
 * is coalesced away later); (c) write the `short i` extension explicitly as `(i << 16) >> 16`
 * -- two RTL insns combine re-merges into the existing sll/sra pair.  MEASURE EACH ON THE
 * -dL LINE, NOT THE GATE: apply, re-dump, and check `Loop from N to M: K real insns` reaches
 * K >= 61 before looking at the diff count.
 * ---- w46-a8: THE insn_count TARGET WAS REACHED AND THE MODEL PREDICTION FAILED.  13 stays.
 * Measured on the -dL line exactly as instructed (scratch/probe_dl.py + p_ramp{,2}.py):
 *   spelling                                      real insns   savings-2 movables moved
 *   baseline                                          58                 2
 *   `hoff + ((i << 16) >> 16)`                        61                 2   (gate 20)
 *   ... + one `((0xK - *hp) << 16) >> 16` guard        63                 2   (gate 23)
 *   ... + two guards                                  65                 2   (gate 26)
 *   ... + three guards                                67                 2   (gate 29)
 *   ... + a shifted Cars list index                   66                 2   (gate 22)
 * BOTH savings-2 / life-2 pairs are STILL hoisted at 67 real insns.  ⇒ the w41 bracket
 * `threshold in [15,57]` is REFUTED: from `4T >= 67` the true bound is T >= 16.75, and the
 * savings-1/life-1 "not desirable" verdicts only give T < 67.  If T is the catalog's
 * `(loop_has_call?1:2)*(1+n_non_fixed_regs)` ~= 50, the loop would need > 200 real insns
 * for the &hoff pair to be declined -- unreachable for a 58-insn loop.  insn_count is
 * therefore NOT the free variable the w45 note claimed.
 * ALSO MEASURED (report-only; tools/build.py is off-limits this wave, the probe patched and
 * RESTORED it byte-for-byte via scratch/flagprobe.py): the PER_TU key `no_split_addresses`,
 * which the w39/w40 notes never listed for this TU.  In an isolated cc1try it produces
 * EXACTLY retail's frame shape for this fn (frame 40, six saved regs, `sw ra,36`, NO
 * preheader lui/addiu for either hoff or the Cars list -- the whole 13-diff residual), BUT
 * the whole-TU gate is decisively negative: SetRamp 41, ResetPSXController 324,
 * GetPSXPadValue 347, GetDevice PASS.  ⇒ the object is not a no-split-addresses object;
 * the lever is needed for ONE SYMBOL and gcc has no per-symbol switch (and the unsized
 * asm-label view cannot help, since a runtime-indexed array can never use the `lw $r,sym`
 * assembler-macro form the view relies on).
 * NEW NAMED ANGLE: attack `savings`/`lifetime`, not insn_count.  loop.c computes a movable's
 * savings from its own shape, so the only way to shrink savings*lifetime for the &hoff pair
 * is to stop it being ONE 2-insn pair: give `hoff`'s address a SECOND, differently-spelled
 * in-loop materialization (the w44 "distinct address rtx per site" cure for cross-loop CSE)
 * so neither copy is a life-2 movable on its own.  Alternatively confirm T empirically by
 * SHRINKING the loop (a scratch cc1try harness with the guards deleted) until the
 * savings-1/life-1 movables flip to "moved" -- that pins T from above and settles whether
 * any insn_count is reachable at all.
 * ---- w49-a6: 13 STAYS.  The w46 "give &hoff a SECOND, differently-spelled in-loop
 * materialization" angle is FALSIFIED: `hp = (int *)((char *)hoff + (i << 2))` for two
 * sites + `hoff[i]` for the third 17; `hp = hoff + i` kept but ONE site respelled
 * `hoff[i]` 13 (exactly neutral -- cse re-merges the two spellings into one movable, so
 * there never are two); `hp` moved after the three ramp stores 17 (the w41 measurement,
 * re-confirmed from this basin); a zero-insn USE fence on `hp` 20 @100.  Both address
 * spellings collapse to the same RTL movable, so "two movables" is not source-reachable;
 * the loop.c cost-model verdict stands.
 * ---- w50-a6: 13 STAYS, re-gated (99/98).  Time went to the cario/fe3dmenu conversions;
 * the remaining named angle for this fn is unchanged and is the ARM-DUPLICATION inflator
 * (a cross-jumped duplicate of the `hp = hoff + i;` materialization in two sibling blocks,
 * so cse1 cannot re-merge them into ONE life-2 movable the way it re-merged the two
 * SPELLINGS w49 tried).  The loop body has no natural if/else pair to host it, so it needs
 * the three `InGame_GetDevice(...)` guards restructured first -- a bigger edit than this
 * wave's budget, and it must be gated against the two sibling near-misses in this TU.
 * ---- W55-A16: 13 STAYS, re-gated (99/98).  NEW FALSIFICATION + a correction to the
 * picture above.  The W52-a7/a5 ANTI-LICM-ADDRESS-HOIST lever (replace the `do{}while`
 * with a label + `goto` back-edge so loop.c never recognises the loop) WAS tried here for
 * the first time: it DOES kill our `&hoff` hoist -- ours rematerialises
 * `lui/addiu %hi/%lo(hoff); addu s0,v1,v0` in-loop exactly like retail -- but it is
 * INDISCRIMINATE and also kills the TWO hoists retail KEEPS, so the frame loses a saved
 * reg and we land 19 diffs at 95/98 (3 insns SHORT).  Receipt on the oracle bytes
 * (InGame_SetRamp__Fv.s @800DCD3C): retail HOISTS `Input_gHandler`->$s4,
 * `Cars_gHumanRaceCarList`->$s5 and the constant 1->$s2 out of the loop, and
 * REMATERIALISES only `hoff` (D_8013DAC0) inside it -- i.e. this is not "retail does no
 * LICM", it is loop.c making a DIFFERENT per-movable cost decision for the one movable
 * that is used ONCE per iteration.  Any future lever must therefore be movable-SELECTIVE
 * (the arm-duplication inflator below, or a per-fn loop-flag splice), never a whole-loop
 * anti-LICM device.
 * ---- w60-a7 (2026-08-14): 13 STAYS (99 vs 98).  A NEW hypothesis was tested and
 * FALSIFIED: loop.c hoists movables in ORDER OF APPEARANCE and its threshold DECAYS 3
 * per accepted move (catalog w46-a4), so making the `&hoff` movable appear LATER in the
 * body -- after the three already-accepted movables retail keeps -- should push it past
 * the budget and get it declined.  It does not: `hp = hoff + i;` moved below the three
 * ramp stores 17, `hp` deleted entirely with `hoff[i]` spelled at all three
 * InGame_GetDevice sites (first appearance now at the first guard) 17, the same plus a
 * dummy block-local to shift the qty count 17, and the `int *hp` declaration removed
 * 17.  All four are the SAME 17 and all keep the hoist, so the movable's LIST POSITION
 * is not the dial here -- consistent with the w49 finding that every spelling collapses
 * to one RTL movable.  The two named angles (ARM-DUPLICATION of the materialization so
 * cse1 cannot re-merge it, and a per-fn loop-flag splice) are still the only ones left.
 * ---- w61-a15 (2026-08-15): 13 STAYS.  TWO deliverables, both measured.
 * (1) **PER_FN_NO_SPLIT_ADDRESSES IS PRICED AND NEGATIVE -- DO NOT WIRE IT.**  The
 *     mechanism now EXISTS in build.py (the w59-a7/w60-a4 CdRead adopter), so the
 *     w46-a8 "gcc has no per-symbol switch" note was re-tested for real: a probe copy
 *     of build.py with `"recon/game/psx/psxcontroller.cpp": {"InGame_SetRamp__Fv"}`
 *     in PER_FN_NO_SPLIT_ADDRESSES gives **SetRamp 41 @101** (vs 13 @99).  The splice
 *     is faithful and surgical -- the three TU-mates are byte-unchanged
 *     (ResetPSXController 3, GetPSXPadValue 257, GetDevice PASS) -- so this is a
 *     clean per-fn pricing, not a whole-TU artifact: the object simply is not a
 *     no-split-addresses object, exactly as w46 concluded for the whole TU.  Harness:
 *     scratchpad/w61a15/nosplit_probe.py.
 * (2) THE loop.c THRESHOLD ARITHMETIC, WORKED THROUGH ON THE REAL SOURCE
 *     (C:/Temp/gccsrc/gcc-2.8.1/loop.c).  `move_movables` moves iff
 *     `already_moved || (threshold * savings * lifetime) >= insn_count`, with
 *     `threshold = (loop_has_call ? 1 : 2) * (1 + n_non_fixed_regs)` (line 535) and
 *     `threshold -= 3` after EVERY accepted move (lines 1728 / 1913).  The `&hoff`
 *     HIGH movable's savings 2 / life 2 is NOT a coincidence: `force_movables`
 *     (lines 1226-1231) does `m1->lifetime += m->lifetime; m1->savings += m1->savings;`
 *     for a HIGH/LO_SUM pair -- i.e. the pair's 4 is STRUCTURAL and no source spelling
 *     can lower it (this is why every respelling collapses to the same movable).
 *     Calibrating T from our own -dL verdicts (savings1*life1 refused at insn_count 58
 *     => T < 58; savings2*life2 taken => 4T >= 58) and from the decay schedule, our
 *     loop has T0 ~= 28 (loop_has_call = 1); after the 3 movables retail also keeps
 *     T ~= 19, so declining the pair needs `4*19 < insn_count`, i.e. **insn_count >= 77
 *     with the &hoff movable ordered LAST**.  w46 reached only 67 (with the pair
 *     FIRST, where the bound is 4*28 = 112) and w60 moved it later WITHOUT inflating
 *     the count -- the two halves were never combined.  That combination is the one
 *     arithmetically-live source angle left, and it is expensive (each inflator w46
 *     measured survives to the output, +7 gate per 2 insns), so it is recorded as a
 *     PRICED angle, not a recommendation.  The cheap read: this residual is 3 insns
 *     and the whole remaining search space is a 19-insn RTL inflation.
 * ---- w63-a14 (13 STAYS, re-gated 99/98).  A NEW, ARITHMETICALLY-LIVE ANGLE that the
 * w61-a15 write-up derived but did not name, because it attacks the OTHER side of the
 * same inequality.  `threshold -= 3` after EVERY accepted move (loop.c:1728/1913), so
 * the decision for the &hoff pair is `4 * (T0 - 3*k) >= insn_count`, where k is the
 * number of movables ACCEPTED BEFORE it.  w45/w46 pushed insn_count (reached 67, never
 * enough); w60 pushed the ORDER alone (k unchanged, inert).  Nobody has pushed k.  With
 * T0 ~= 28 and insn_count 58, declining the pair needs `4*(28-3k) < 58`, i.e. k >= 5 --
 * two MORE accepted savings-2 movables than the three retail keeps, both ordered before
 * &hoff.  That is a bounded, priced search and it is the only free variable left that
 * is not already falsified: candidate inflators are extra loop-invariant ADDRESS pairs
 * (each is savings 2 / life 2 by force_movables, so each is accepted and each decays T
 * by 3) whose hoisted result later dies -- e.g. a second global read whose value combine
 * folds into an existing compare.  COST WARNING: an accepted movable that SURVIVES costs
 * 2 preheader insns + a callee-saved register (the w46 inflators measured +7 gate per 2
 * insns), so the angle only pays if the added movables are dead after combine/cse2.
 * NOT ATTEMPTED here (out of budget); recorded so the next belt does not re-run the
 * insn_count or ordering halves in isolation again. */
void InGame_SetRamp(void)

{
  int *h;

  h = Input_gHandler;
  if (Replay_ReplayMode < 2) {
    short i;

    i = 0;
    if (i < Cars_gNumHumanRaceCars) {
      do {
        Cars_gHumanRaceCarList[i]->carInfo->RampSteering =
            Cars_gHumanRaceCarList[i]->carInfo->RampBrake =
                Cars_gHumanRaceCarList[i]->carInfo->RampGas = 1;
        /* ===== w64-a14: SEAL 13 -> PASS 98/98.  FOUR ordered devices; the
         * w63-a14 "push k on loop.c's threshold" angle was never needed --
         * the &hoff hoist is killed at the MOVABLE-EXISTENCE layer instead.
         *  (1) MOVABLE-EXISTENCE KILL (catalog 15C): loop.c builds a movable
         *      only for n_times_set==1, so splitting `hp = hoff + i;` into
         *      `hp = hoff; hp = hp + i;` removes the invariant-address movable
         *      outright.  13 -> 10 (count 99 -> 96).
         *  (2) IDENTITY LAUNDER on the base (`"=r"/"0"`, zero insns): the %hi
         *      half was still hoisted; laundering the base pseudo blocks it.
         *      10 -> 9.
         *  (3) USE-ADJACENCY: retail computes &hoff[i] AFTER the three
         *      `ctrl->... = 1` stores (ours filled their two load-delay nops
         *      with the lui/addiu instead).  Moving the whole group down to
         *      its first use restores retail's two nops.  9 -> 8.
         *  (4) BLOCK-SCOPED base + INT-TYPED index-first sum: a BLOCK-local
         *      `hb` gives the §3.15 SEPARATE-scratch form (`lui v0; addiu v0;
         *      addu s0,..,v0`) where the fn-scope pseudo self-temped into $s0;
         *      and the sum must be INT-typed with the index FIRST -- a
         *      pointer sum canonicalises ptr-first and leaves the last diff
         *      `addu s0,v0,v1` vs retail `addu s0,v1,v0` (catalog 14D/12D).
         *      8 -> 2 -> PASS.  `i * 4`, `i << 2` and `(int)(i * 4)` all seal;
         *      `i + hb` (pointer sum) does NOT (2).
         * SYM NOTE: the 8c block lists only `h`($s4) and `i`($s3).  W76 removes
         * `ctrl` and `hp`; `hb` remains the one open reconstruction device.  The
         * SYM's mask $803f0000 (s0-s5+ra, NO s6) proves retail carried no hoisted
         * &hoff pseudo. */
#define INGAME_HOFF_PTR ((int *)(i * 4 + (int)hb))
        { int *hb = hoff; /* SYM-CODEGEN-CARRIER: hb -- blocks the non-retail &hoff loop hoist */
          __asm__("" : "=r"(hb) : "0"(hb));
          __asm__("" : : "r"(INGAME_HOFF_PTR));
        if (InGame_GetDevice(h[0x4f - *INGAME_HOFF_PTR]) == 1) {
          *(int *)(*(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288) + 0x18) = 0;
        }
        if (InGame_GetDevice(h[0x51 - *INGAME_HOFF_PTR]) == 1) {
          *(int *)(*(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288) + 0x1c) = 0;
        }
        if (InGame_GetDevice(h[0x52 - *INGAME_HOFF_PTR]) == 1) {
          *(int *)(*(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288) + 0x20) = 0;
        }
        }
#undef INGAME_HOFF_PTR
        /* W76 SYM correction (2026-08-23), byte-neutral PASS 98/98:
           `RampSteering = RampBrake = RampGas = 1` is the typed chained assignment
           whose unnamed base CSE replaces the non-retail `ctrl` local and preserves
           retail's +0x1c,+0x20,+0x18 store order.  Repeating the full index-first
           hoff address as an asm input removes function-scope `hp` while preserving
           the same $s0 quantity.  Full-debug now has only one remaining extra record,
           block-local `hb`; eliminating its load-bearing identity launder without
           re-hoisting &hoff is the open SYM task.  W78 re-priced that task: repeating
           the fully anonymous `i*4+(int)hoff` address (with `r`, `m`, or volatile view)
           re-hoists &hoff and costs 17 @99 plus a non-retail $s6; a sign-extension
           zero identity costs 34 @100; a raw absolute-address spelling reaches 8 @96
           but loses the required symbol relocation and two retail instructions.  The
           Parasite Eve 2 inline-identity idiom was also tested both as a base-only helper
           and with the complete index-first address inside the helper; both remove `hb`
           but rotate the loop's saved-register topology and cost 57 @107.  A full-body
           inline carrier and an anonymous-union carrier both stay 98/98, but full debug
           rejects them: the inline expansion adds nested `h`/`i`/`hb` records, while the
           union adds an anonymous type/member and still emits local `hb`.  GCC 2.8.1
           `sdbout.c` also proves ordinary locals are not suppressed by `DECL_IGNORED_P`
           or system-header provenance.  All were reverted; `hb` remains until a SYM-safe
           opaque-address source shape is found, because PASS preservation takes priority
           over deleting its record. */
        i = i + 1;
      } while (i < Cars_gNumHumanRaceCars);
    }
  }
  return;
}

/* end of psxcontroller.cpp */
