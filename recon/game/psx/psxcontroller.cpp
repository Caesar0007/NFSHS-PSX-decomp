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

#define INGAME_CONTROLLER_WORD(offset) \
  (((GameSetup_tControllerData *)((player << 2) + \
     (int)&GameSetup_gData))->controllerConfig[(offset) >> 2])
#define INGAME_INDEX_WORD(index, offset) \
  (((GameSetup_tControllerData *)((index) + \
     (int)&GameSetup_gData))->controllerConfig[(offset) >> 2])

int InGame_GetPSXPadValue(int value, int player)
{
  int c;
  int newControl;
  int type;

  c = value;
  PAD_update();

  /* w83-b1: the pad base goes through the SYM's OWN `newControl` -- whose SYM
     home is $v0, exactly the register retail's `addiu $v0,$v0,%lo` uses here --
     and the row offset accumulates INTO `type` ($v1).  THREE statements, not
     two: the `+=` split is what makes `sll $v1,$s1,5` land AFTER the lui/addiu
     pair (every 2-statement form measures 96 @241).  Declares NO local the
     SYM's single `90 Block start` block does not list.
     RESERVED byte-identical alternative (the Codex seal's head, 6ba78056) --
     same .text, but its nested scope + `pad` local emit two -g2 debug records
     the SYM does not have:
       {
         u_char *pad = (u_char *)PSXController_gPadBytes;
         type = (int)pad + (player << 5);
       }
  */
  newControl = (int)PSXController_gPadBytes;
  type = player << 5;
  type += newControl;
  if (*(u_char *)(type + 4) != 0)
    goto no_pad;
  type = *(u_char *)(type + 5);
  goto have_pad_type;
no_pad:
  type = 0;
have_pad_type:

  switch (type) {
  case 0x53:
  case 0x73:
    switch (c) {
    case 0x00800000: {
      int index = player << 2;
      newControl = ((player << 30) |
                    (128 - INGAME_INDEX_WORD(index, 0x88)) * 0x10000 |
                    (128 - INGAME_INDEX_WORD(index, 0x90)) * 0x100) | 1;
      break;
    }
    case 0x00200000:
      newControl = (player << 30) |
                   (INGAME_CONTROLLER_WORD(0x88) + 128) * 0x10000 |
                   (INGAME_CONTROLLER_WORD(0x90) + 128) * 0x100 | 1;
      break;
    case 0x00100000:
      newControl = (player << 30) | 0x01000000 |
                   (128 - INGAME_CONTROLLER_WORD(0x88)) * 0x10000 |
                   (128 - INGAME_CONTROLLER_WORD(0x90)) * 0x100 | 1;
      break;
    case 0x00400000:
      newControl = (player << 30) | 0x01000000 |
                   (INGAME_CONTROLLER_WORD(0x88) + 128) * 0x10000 |
                   (INGAME_CONTROLLER_WORD(0x90) + 128) * 0x100 | 1;
      break;
    case (int)0x80000000:
      newControl = (player << 30) | 0x02000000 |
                   (128 - INGAME_CONTROLLER_WORD(0x98)) * 0x10000 |
                   (128 - INGAME_CONTROLLER_WORD(0xA0)) * 0x100 | 1;
      break;
    case 0x20000000:
      newControl = (player << 30) | 0x02000000 |
                   (INGAME_CONTROLLER_WORD(0x98) + 128) * 0x10000 |
                   (INGAME_CONTROLLER_WORD(0xA0) + 128) * 0x100 | 1;
      break;
    case 0x10000000: {
      int index = player << 2;
      newControl = (player << 30) | 0x03000000 |
                   (128 - INGAME_INDEX_WORD(index, 0x98)) * 0x10000 |
                   (128 - INGAME_INDEX_WORD(index, 0xA0)) * 0x100 | 1;
      break;
    }
    case 0x40000000:
      newControl = (player << 30) | 0x03000000 |
                   (INGAME_CONTROLLER_WORD(0x98) + 128) * 0x10000 |
                   (INGAME_CONTROLLER_WORD(0xA0) + 128) * 0x100 | 1;
      break;
    default:
      goto generic_control;
    }
    break;

  case 0x23:
    switch (c) {
    case 0x00800000: {
      int index = player << 2;
      newControl = ((player << 30) |
                    (128 - INGAME_INDEX_WORD(index, 0x68)) * 0x10000 |
                    (128 - INGAME_INDEX_WORD(index, 0x70)) * 0x100) | 1;
      break;
    }
    case 0x00200000:
      newControl = (player << 30) |
                   (INGAME_CONTROLLER_WORD(0x68) + 128) * 0x10000 |
                   (INGAME_CONTROLLER_WORD(0x70) + 128) * 0x100 | 1;
      break;
    case 0x00004000:
      newControl = (player << 30) | 0x01000000 |
                   INGAME_CONTROLLER_WORD(0x80) * 0x100 | 1;
      break;
    case 0x00008000:
      newControl = (player << 30) | 0x02000000 |
                   INGAME_CONTROLLER_WORD(0x78) * 0x100 | 1;
      break;
    case 0x00000400:
      newControl = (player << 30) | 0x030AFF01;
      break;
    default:
      goto generic_control;
    }
    break;

  default:
generic_control:
    newControl = (player << 26) | (c << 8) | 2;
    break;
  }
  return newControl;
}

#undef INGAME_CONTROLLER_WORD
#undef INGAME_INDEX_WORD

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
