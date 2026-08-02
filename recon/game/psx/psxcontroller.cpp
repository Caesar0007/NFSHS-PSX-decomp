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
  GameSetup_gData.controllerData.controllerConfig[player] = config;
  if (frontEnd.controlType[player] != (u_short)gPadinfo.buf[player * 4].ID) {
    frontEnd.controlType[player] = (u_short)gPadinfo.buf[player * 4].ID;
  }
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
  if (GameSetup_gData.Time != 0) {
    int m;

    h[0x73 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][9][type],player);
    m = 0;
    if (type == 1) {
      m = 6;
    }
    h[0x54 - hoff[player]] = InGame_GetPSXPadValue(m,player);
  }
  else {
    int m;

    h[0x73 - hoff[player]] = InGame_GetPSXPadValue(0,player);
    m = mappings[config][9][type];
    if (type == 1) {
      m = m | 6;
    }
    h[0x54 - hoff[player]] = InGame_GetPSXPadValue(m,player);
  }
  h[0x66 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][5][type],player);
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
 * (the local is referenced by the outer-switch fallthrough path). */
int InGame_GetPSXPadValue(int value,int player)

{
  int newControl;
  int c;
  int type;

  PAD_update();
  if (gPadinfo.buf[player * 4].nopad == '\0') {
    type = gPadinfo.buf[player * 4].ID;
  }
  else {
    type = 0;
  }
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
                   ((0x80 - GameSetup_gData.controllerData.J1MIN[player]) * 0x10000 | 0x1000000) |
                   (0x80 - GameSetup_gData.controllerData.J1MAX[player]) * 0x100 ;
      return newControl | 1;
    case 0x400000:
      newControl = player << 0x1e |
                   ((GameSetup_gData.controllerData.J1MIN[player] + 0x80) * 0x10000 | 0x1000000) |
                   (GameSetup_gData.controllerData.J1MAX[player] + 0x80) * 0x100 ;
      return newControl | 1;
    case -0x80000000:
      newControl = player << 0x1e |
                   ((0x80 - GameSetup_gData.controllerData.J2MIN[player]) * 0x10000 | 0x2000000) |
                   (0x80 - GameSetup_gData.controllerData.J2MAX[player]) * 0x100 ;
      return newControl | 1;
    case 0x20000000:
      newControl = player << 0x1e |
                   ((GameSetup_gData.controllerData.J2MIN[player] + 0x80) * 0x10000 | 0x2000000) |
                   (GameSetup_gData.controllerData.J2MAX[player] + 0x80) * 0x100 ;
      return newControl | 1;
    case 0x10000000:
      newControl = player << 0x1e |
                   ((0x80 - GameSetup_gData.controllerData.J2MIN[player]) * 0x10000 | 0x3000000) |
                   (0x80 - GameSetup_gData.controllerData.J2MAX[player]) * 0x100 ;
      return newControl | 1;
    case 0x40000000:
      newControl = player << 0x1e |
                   ((GameSetup_gData.controllerData.J2MIN[player] + 0x80) * 0x10000 | 0x3000000) |
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
      return newControl | 1;
    case 0x200000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.deadSpot[player] + 0x80) * 0x10000 |
                   (GameSetup_gData.controllerData.steeringRange[player] + 0x80) * 0x100 ;
      return newControl | 1;
    case 0x4000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.ImaxRange[player] * 0x100 | 0x1000000) ;
      return newControl | 1;
    case 0x8000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.IImaxRange[player] * 0x100 | 0x2000000) ;
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
 * K >= 61 before looking at the diff count. */
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
  
        hp = hoff + i;
        ctrl = *(int *)((char *)Cars_gHumanRaceCarList[i] + 0x288);
        *(int *)(ctrl + 0x1c) = 1;
        *(int *)(ctrl + 0x20) = 1;
        *(int *)(ctrl + 0x18) = 1;
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
