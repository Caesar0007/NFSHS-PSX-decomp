/* game/psx/psxcontroller.cpp -- RECONSTRUCTED (NFS4 in-game PSX controller mapping; C++ TU)
 *   4 fns: InGame_ResetPSXController (map pad+config -> Input_gHandler[]), InGame_GetPSXPadValue
 *   (axis selector -> packed control word, per controller type + per-player range cal),
 *   InGame_GetDevice (control & 0xff), InGame_SetRamp (digital-input -> disable analog ramp). No GTE.
 */
#include "../../nfs4_types.h"
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
 *      (`nop; ori a0,a0,6`).  Giving each independent site its own block-scoped
 *      `int m` collapses them and makes the count exact.  (-50, 307->305 insns)
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

  type = gPadinfo.buf[player * 4].ID;
  h = Input_gHandler;
  type = (type == 0x23) ? 0 : (((type == 0x53) || (type == 0x73)) ? 1 : 2);
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
   ---- w61-a15 (2026-08-15): 3 -> **PASS 305/305** via PER_FN_TEXT_MOVES; the source
   axis is now CLOSED WITH A CITED MECHANISM, not a guess.
   🔑 WHY NO SOURCE DEVICE CAN EVER WORK (gcc-2.8.1 reorg.c `stop_search_p`, lines
   685-712): the backward delay-slot scan in `fill_simple_delay_slots` terminates
   unconditionally at ANY asm insn --
       case INSN: return (GET_CODE (PATTERN (insn)) == SEQUENCE
                          || GET_CODE (PATTERN (insn)) == ASM_INPUT
                          || asm_noperands (PATTERN (insn)) >= 0);
   So a read-only fence ANYWHERE in the pre-branch block hides EVERY insn before it
   from the scan -- including the `sll $21,$18,2` the fence itself exists to pin
   there.  And the fence must be pre-branch (a late def/use pair does not make the
   pseudo global; no fence = 254).  The two requirements are therefore mutually
   exclusive BY THE COMPILER'S OWN CODE: fence pre-branch => scan blocked => reorg
   falls through to the target steal and duplicates `lui $2,%hi(GameSetup_gData)`
   (306); no fence => the giv is block-local, local-alloc grabs $s0 and the whole
   6-way saved-reg rotation returns (254).  This retires the w60-a7 "open angle".
   NEWLY FALSIFIED THIS WAVE (all from the 3 basin, all reconfirming the above):
   hoisting the compare's two OPERANDS into locals so the fence is emitted LAST
   pre-branch -- `int ct`/`int id` + fence + `if (ct != id)` 3 (bit-identical,
   i.e. the operand hoist is inert); the same non-volatile 3; the same with the
   ORIGINAL top-of-block fence kept as well 3; `u_short ct`/`u_short id` 22 @303;
   the fence carrying `"r"(ct)` as a second operand 9 @306.
   ⇒ ORCHESTRATOR ACTION -- wire this PER_FN_TEXT_MOVES row (probe-verified PASS
   twice, TU-mates byte-unchanged: SetRamp 13, GetPSXPadValue 257, GetDevice PASS):
       "recon/game/psx/psxcontroller.cpp": {
           "InGame_ResetPSXController__Fii": [
               {"take": r"\tsll\t\$21,\$18,2\n(?= \#APP\n)",
                "after": r"\tbeq\t\$3,\$2,\$L\d+\n",
                "drop_after": r"\tlui\t\$2,%hi\(GameSetup_gData\) \# high\n"},
               {"take": r"\tlui\t\$2,%hi\(GameSetup_gData\) \# high\n"
                        r"(?=\$L\d+:\n\taddiu\t\$2,\$2,%lo\(GameSetup_gData\))",
                "after": r"\$L\d+:\n"
                         r"(?=\taddiu\t\$2,\$2,%lo\(GameSetup_gData\) \# low\n"
                         r"\taddu\t\$2,\$21,\$2\n)"},
           ],
       },
   Move 1 puts the giv `sll $s5,$s2,2` in the controlType `beq`'s delay slot and
   DELETES the eager-stolen `lui` duplicate (this is exactly retail's simple fill).
   Move 2 slides the `$L` merge label ABOVE the surviving `lui %hi(GameSetup_gData)`
   so both paths reach it once -- semantically identical to what we emit today and
   byte-identical to retail.  All anchors are label-agnostic and verified unique in
   the region (1 match each; the `lui %hi(GameSetup_gData)` pair is disambiguated by
   lookahead).  Probe harness: scratchpad/w61a15/textmove_probe.py. */
  __asm__ volatile("" : : "r"(player * 4));
  if (frontEnd.controlType[player] != (u_short)gPadinfo.buf[player * 4].ID) {
    frontEnd.controlType[player] = (u_short)gPadinfo.buf[player * 4].ID;
  }
  GameSetup_gData.controllerData.controllerConfig[player] = config;
  h[0x4f - hoff[player]] = InGame_GetPSXPadValue(mappings[config][0][type],player);
  h[0x50 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][1][type],player);
  h[0x51 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][2][type],player);
  h[0x52 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][3][type],player);
  h[player + 0xae] = InGame_GetPSXPadValue(mappings[config][8][type],player);
  h[0x75 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][7][type],player);
  h[0x65 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][7][type],player);
  h[0x53 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][4][type],player);
  if ((Cars_gHumanRaceCarList[player]->carFlags & 0x200U) != 0) {
    int m = mappings[config][10][type];

    if (type == 1) {
      m = m | 6;
    }
    h[0x81 - hoff[player]] = InGame_GetPSXPadValue(m,player);
  }
  else {
    int m;

    h[0x7d - hoff[player]] = InGame_GetPSXPadValue(mappings[config][0][type],0);
    h[0x7e - hoff[player]] = InGame_GetPSXPadValue(mappings[config][1][type],0);
    m = mappings[config][10][type];
    if (type == 1) {
      m = m | 6;
    }
    h[0x82 - hoff[player]] = InGame_GetPSXPadValue(m,player);
  }
  /* w59-a6: the three `hoff[player]` reads below are spelled as the byte-base form
     `*(int *)((player << 2) + (int)hoff)` ON PURPOSE (catalog 09I) -- they are the first
     statement of a post-`jal` block and the plain subscript issues the `lui/addiu` pair
     ahead of the `sll`, which retail does not.  Do NOT "simplify" them back to
     `hoff[player]`: that costs 12 diffs.  Every other site in this fn stays natural. */
  if (GameSetup_gData.Time != 0) {
    int m;

    h[0x73 - *(int *)((player << 2) + (int)hoff)] = InGame_GetPSXPadValue(mappings[config][9][type],player);
    m = 0;
    if (type == 1) {
      m = 6;
    }
    h[0x54 - hoff[player]] = InGame_GetPSXPadValue(m,player);
  }
  else {
    int m;

    h[0x73 - *(int *)((player << 2) + (int)hoff)] = InGame_GetPSXPadValue(0,player);
    m = mappings[config][9][type];
    if (type == 1) {
      m = m | 6;
    }
    h[0x54 - hoff[player]] = InGame_GetPSXPadValue(m,player);
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
int InGame_GetPSXPadValue(int value,int player)

{
  int newControl;
  int c;
  int type;

  PAD_update();
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
     198 @243 (the twin's tag-second rule does NOT extend to the player term). */
  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto InGame_GetPSXPadValue_noPad;
  }
  type = gPadinfo.buf[player * 4].ID;
  __asm__("");
  goto InGame_GetPSXPadValue_gotType;
InGame_GetPSXPadValue_noPad:
  type = 0;
  goto InGame_GetPSXPadValue_gotType;
InGame_GetPSXPadValue_gotType:
  switch (type) {
  case 0x53:
  case 0x73:
    switch (value) {
    case 0x800000:
      newControl = player << 0x1e |
                   (0x80 - GameSetup_gData.controllerData.J1MIN[player]) * 0x10000 |
                   (0x80 - GameSetup_gData.controllerData.J1MAX[player]) * 0x100 ;
      return newControl | 1;
    case 0x200000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.J1MIN[player] + 0x80) * 0x10000 |
                   (GameSetup_gData.controllerData.J1MAX[player] + 0x80) * 0x100 ;
      return newControl | 1;
    case 0x100000:
      newControl = player << 0x1e |
                   0x1000000 |
                   (0x80 - GameSetup_gData.controllerData.J1MIN[player]) * 0x10000 |
                   (0x80 - GameSetup_gData.controllerData.J1MAX[player]) * 0x100 ;
      return newControl | 1;
    case 0x400000:
      newControl = player << 0x1e |
                   0x1000000 |
                   (GameSetup_gData.controllerData.J1MIN[player] + 0x80) * 0x10000 |
                   (GameSetup_gData.controllerData.J1MAX[player] + 0x80) * 0x100 ;
      return newControl | 1;
    case -0x80000000:
      newControl = player << 0x1e |
                   0x2000000 |
                   (0x80 - GameSetup_gData.controllerData.J2MIN[player]) * 0x10000 |
                   (0x80 - GameSetup_gData.controllerData.J2MAX[player]) * 0x100 ;
      return newControl | 1;
    case 0x20000000:
      newControl = player << 0x1e |
                   0x2000000 |
                   (GameSetup_gData.controllerData.J2MIN[player] + 0x80) * 0x10000 |
                   (GameSetup_gData.controllerData.J2MAX[player] + 0x80) * 0x100 ;
      return newControl | 1;
    case 0x10000000:
      newControl = player << 0x1e |
                   0x3000000 |
                   (0x80 - GameSetup_gData.controllerData.J2MIN[player]) * 0x10000 |
                   (0x80 - GameSetup_gData.controllerData.J2MAX[player]) * 0x100 ;
      return newControl | 1;
    case 0x40000000:
      newControl = player << 0x1e |
                   0x3000000 |
                   (GameSetup_gData.controllerData.J2MIN[player] + 0x80) * 0x10000 |
                   (GameSetup_gData.controllerData.J2MAX[player] + 0x80) * 0x100 ;
      return newControl | 1;
    }
    break;
  case 0x23:
    switch (value) {
    case 0x800000:
      newControl = player << 0x1e |
                   (0x80 - GameSetup_gData.controllerData.deadSpot[player]) * 0x10000 |
                   (0x80 - GameSetup_gData.controllerData.steeringRange[player]) * 0x100 ;
      __asm__ volatile("" : : "r"(newControl));
      /* w46-a8 DE-MERGE FENCE (zero insns, §2b.5 -- NOT a register pin).  The w45 `| 1`-
         on-the-return lever made gcc's jump2 cross-jump the case tails like retail, but it
         OVER-merges: these two 0x23 arms had their range-cal loads and `sll s1,2` folded
         into the shared tail as well, where retail merges only the final `ori v0,a0,1`.
         An empty asm at the end of exactly these two arms makes their tails differ so
         jump2 declines them while every other group stays merged.  MEASURED (each set is
         the whole fence configuration, k1 nopad spelling): {8,9} 264 (kept), {9} 266,
         {8} 268, {8,9,10} / {8,9,11} / all-four-0x23 268, {9,10} 270, none 272, {8,10} 272,
         adding ANY 0x53/0x73 arm 267-280, all eight 0x53/0x73 arms 331. */
      return newControl | 1;
    case 0x200000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.deadSpot[player] + 0x80) * 0x10000 ;
      return (newControl |=
              (GameSetup_gData.controllerData.steeringRange[player] + 0x80) * 0x100) | 1;
    case 0x4000:
      newControl = player << 0x1e |
                   0x1000000 |
                   GameSetup_gData.controllerData.ImaxRange[player] * 0x100 ;
      return newControl | 1;
    case 0x8000:
      newControl = player << 0x1e |
                   0x2000000 |
                   GameSetup_gData.controllerData.IImaxRange[player] * 0x100 ;
      return newControl | 1;
    case 0x400:
      newControl = player << 0x1e | 0x30aff01;
      return newControl;
    }
    break;
  }
  newControl = player << 0x1a | value << 8 | 2;
  return newControl;
}

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
  int *hp;

  h = Input_gHandler;
  if (Replay_ReplayMode < 2) {
    short i;

    i = 0;
    if (i < Cars_gNumHumanRaceCars) {
      do {
      int ctrl;

        ctrl = *(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288);
        *(int *)(ctrl + 0x1c) = 1;
        *(int *)(ctrl + 0x20) = 1;
        *(int *)(ctrl + 0x18) = 1;
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
         * SYM NOTE: the 8c block lists only `h`($s4) and `i`($s3) -- `hp`/`hb`
         * are reconstruction devices, and the SYM's mask $803f0000 (s0-s5+ra,
         * NO s6) is the receipt that retail carried NO hoisted &hoff pseudo. */
        { int *hb = hoff;
          __asm__("" : "=r"(hb) : "0"(hb));
          hp = (int *)(i * 4 + (int)hb); }
        if (InGame_GetDevice(h[0x4f - *hp]) == 1) {
          *(int *)(*(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288) + 0x18) = 0;
        }
        if (InGame_GetDevice(h[0x51 - *hp]) == 1) {
          *(int *)(*(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288) + 0x1c) = 0;
        }
        if (InGame_GetDevice(h[0x52 - *hp]) == 1) {
          *(int *)(*(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288) + 0x20) = 0;
        }
        i = i + 1;
      } while (i < Cars_gNumHumanRaceCars);
    }
  }
  return;
}

/* end of psxcontroller.cpp */
