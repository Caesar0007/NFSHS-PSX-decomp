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
 * RESIDUAL 254 = a 5-way CALLEE-SAVED ROTATION, count-exact and otherwise
 * instruction-for-instruction identical.  ours {s0=player*4, s1=&mappings-row,
 * s2=&hoff[player], s3=type, s4=player, s5=h, s6=config} vs retail {s0=&mappings-row,
 * s1=&hoff[player], s2=player, s3=type, s4=h, s5=player*4, s6=config} -- i.e. our
 * allocno priority puts the `player*4` giv FIRST where retail ranks it LAST, which
 * pushes `player` and `h` one saved register up each.  Plus the type-select funnel
 * (retail computes the 0/1/2 into $v0 then `addu $s3,$v0,$zero`; ours writes $s3
 * directly).  Both are gcc-2.8 allocno-priority items (-dl/-dg territory), not
 * reachable by the statement-shape levers enumerated above. */
void InGame_ResetPSXController(int player,int config)

{
  int type;
  int *h;
  u_int v;

  type = gPadinfo.buf[player * 4].ID;
  h = Input_gHandler;
  if (type != 0x23) {
    if ((type == 0x53) || (type == 0x73)) {
      type = 1;
    }
    else {
      type = 2;
    }
  }
  else {
    type = 0;
  }
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
  if (GameSetup_gData.Time != 0) {
    h[0x73 - hoff[player]] = InGame_GetPSXPadValue(mappings[config][9][type],player);
    v = (type == 1) ? 6 : 0;
  }
  else {
    h[0x73 - hoff[player]] = InGame_GetPSXPadValue(0,player);
    v = mappings[config][9][type];
    if (type == 1) {
      v = v | 6;
    }
  }
  h[0x54 - hoff[player]] = InGame_GetPSXPadValue(v,player);
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
 * u_char local emitted both). */
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
                   (0x80 - GameSetup_gData.controllerData.J1MAX[player]) * 0x100 | 1;
      return newControl;
    case 0x200000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.J1MIN[player] + 0x80) * 0x10000 |
                   (GameSetup_gData.controllerData.J1MAX[player] + 0x80) * 0x100 | 1;
      return newControl;
    case 0x100000:
      newControl = player << 0x1e |
                   ((0x80 - GameSetup_gData.controllerData.J1MIN[player]) * 0x10000 | 0x1000000) |
                   (0x80 - GameSetup_gData.controllerData.J1MAX[player]) * 0x100 | 1;
      return newControl;
    case 0x400000:
      newControl = player << 0x1e |
                   ((GameSetup_gData.controllerData.J1MIN[player] + 0x80) * 0x10000 | 0x1000000) |
                   (GameSetup_gData.controllerData.J1MAX[player] + 0x80) * 0x100 | 1;
      return newControl;
    case -0x80000000:
      newControl = player << 0x1e |
                   ((0x80 - GameSetup_gData.controllerData.J2MIN[player]) * 0x10000 | 0x2000000) |
                   (0x80 - GameSetup_gData.controllerData.J2MAX[player]) * 0x100 | 1;
      return newControl;
    case 0x20000000:
      newControl = player << 0x1e |
                   ((GameSetup_gData.controllerData.J2MIN[player] + 0x80) * 0x10000 | 0x2000000) |
                   (GameSetup_gData.controllerData.J2MAX[player] + 0x80) * 0x100 | 1;
      return newControl;
    case 0x10000000:
      newControl = player << 0x1e |
                   ((0x80 - GameSetup_gData.controllerData.J2MIN[player]) * 0x10000 | 0x3000000) |
                   (0x80 - GameSetup_gData.controllerData.J2MAX[player]) * 0x100 | 1;
      return newControl;
    case 0x40000000:
      newControl = player << 0x1e |
                   ((GameSetup_gData.controllerData.J2MIN[player] + 0x80) * 0x10000 | 0x3000000) |
                   (GameSetup_gData.controllerData.J2MAX[player] + 0x80) * 0x100 | 1;
      return newControl;
    }
    break;
  case 0x23:
    switch (value) {
    case 0x800000:
      newControl = player << 0x1e |
                   (0x80 - GameSetup_gData.controllerData.deadSpot[player]) * 0x10000 |
                   (0x80 - GameSetup_gData.controllerData.steeringRange[player]) * 0x100 | 1;
      return newControl;
    case 0x200000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.deadSpot[player] + 0x80) * 0x10000 |
                   (GameSetup_gData.controllerData.steeringRange[player] + 0x80) * 0x100 | 1;
      return newControl;
    case 0x4000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.ImaxRange[player] * 0x100 | 0x1000000) | 1;
      return newControl;
    case 0x8000:
      newControl = player << 0x1e |
                   (GameSetup_gData.controllerData.IImaxRange[player] * 0x100 | 0x2000000) | 1;
      return newControl;
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
 * invariant that retail's cc1 left in place; -dL territory. */
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
