/* game/psx/force.cpp -- RECONSTRUCTED (NFS4 PSX force-feedback / rumble; C++ TU)
 *   9 fns: Force_Vbl (per-frame pump), Force_Update (per-car effect dispatch), Force_StartUp,
 *   Force_Disable, Force_IsForceOn, Force_Pause, Force_UnPause, Force_HitSign, Force_HitWall.
 *   Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "force_externs.h"

/* ---- Force.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
u_char       Force_rand_256[256] = { 0, 128u, 64u, 192u, 32u, 160u, 96u, 224u, 16u, 144u, 80u, 208u, 48u, 176u, 112u, 240u, 8u, 136u, 72u, 200u, 40u, 168u, 104u, 232u, 24u, 152u, 88u, 216u, 56u, 184u, 120u, 248u, 4u, 132u, 68u, 196u, 36u, 164u, 100u, 228u, 20u, 148u, 84u, 212u, 52u, 180u, 116u, 244u, 12u, 140u, 76u, 204u, 44u, 172u, 108u, 236u, 28u, 156u, 92u, 220u, 60u, 188u, 124u, 252u, 2u, 130u, 66u, 194u, 34u, 162u, 98u, 226u, 18u, 146u, 82u, 210u, 50u, 178u, 114u, 242u, 10u, 138u, 74u, 202u, 42u, 170u, 106u, 234u, 26u, 154u, 90u, 218u, 58u, 186u, 122u, 250u, 6u, 134u, 70u, 198u, 38u, 166u, 102u, 230u, 22u, 150u, 86u, 214u, 54u, 182u, 118u, 246u, 14u, 142u, 78u, 206u, 46u, 174u, 110u, 238u, 30u, 158u, 94u, 222u, 62u, 190u, 126u, 254u, 1u, 129u, 65u, 193u, 33u, 161u, 97u, 225u, 17u, 145u, 81u, 209u, 49u, 177u, 113u, 241u, 9u, 137u, 73u, 201u, 41u, 169u, 105u, 233u, 25u, 153u, 89u, 217u, 57u, 185u, 121u, 249u, 5u, 133u, 69u, 197u, 37u, 165u, 101u, 229u, 21u, 149u, 85u, 213u, 53u, 181u, 117u, 245u, 13u, 141u, 77u, 205u, 45u, 173u, 109u, 237u, 29u, 157u, 93u, 221u, 61u, 189u, 125u, 253u, 3u, 131u, 67u, 195u, 35u, 163u, 99u, 227u, 19u, 147u, 83u, 211u, 51u, 179u, 115u, 243u, 11u, 139u, 75u, 203u, 43u, 171u, 107u, 235u, 27u, 155u, 91u, 219u, 59u, 187u, 123u, 251u, 7u, 135u, 71u, 199u, 39u, 167u, 103u, 231u, 23u, 151u, 87u, 215u, 55u, 183u, 119u, 247u, 15u, 143u, 79u, 207u, 47u, 175u, 111u, 239u, 31u, 159u, 95u, 223u, 63u, 191u, 127u, 254u };   /* @0x8011fc60 */
Force_tGlobal Force_g[2];   /* @0x8011fd60  (bss(zero)) */
u_char       Force_gActAlign[6] = { 0, 1u, 255u, 255u, 255u, 255u };   /* @0x8013d840 */
u_char       Force_gOffAlign[6] = { 255u, 255u, 255u, 255u, 255u, 255u };   /* @0x8013d848 */
u_short      Force_gTick;   /* @0x8013d84e  (bss(zero)) */
long         Force_gVblHandle;   /* @0x8013d850  (bss(zero)) */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Force_Vbl(void);
void Force_Update(Car_tObj *car);
void Force_StartUp(void);
void Force_Disable(void);
int Force_IsForceOn(Car_tObj *car);
void Force_Pause(void);
void Force_UnPause(void);
void Force_HitSign(Car_tObj *car);
void Force_HitWall(int impulse);


/* ---- Force_Vbl__Fv  [FORCE.CPP:61-98] SLD-VERIFIED ---- */
void Force_Vbl(void)

{
  u_char uVar1;
  u_char bVar2;
  u_int uVar3;
  int iVar4;
  int padstate;
  u_int uVar5;
  u_int uVar6;
  u_int uVar7;
  Force_tGlobal *pFVar8;
  int padnum;
  int port;
  int i;
  int iVar9;
  
  iVar9 = 0;
  pFVar8 = Force_g;
  do {
    port = iVar9 << 4;
    if (1 < iVar9) {
      Force_gTick = Force_gTick + 1;
      return;
    }
    iVar4 = PadGetState(port);
    if (iVar4 == 6) {
      if (pFVar8->active == '\0') {
        PadSetAct(port,pFVar8->actuator,2);
        PadSetActAlign(port,Force_gActAlign);
        pFVar8->active = '\x01';
      }
    }
    else if (iVar4 < 4) {
      pFVar8->active = '\0';
    }
    if (pFVar8->fade < pFVar8->time) {
      uVar6 = (u_int)pFVar8->low + (u_int)pFVar8->jolt;
      pFVar8->actuator[0] =
           (u_int)Force_rand_256[Force_gTick >> 1 & 0xff] < (u_int)pFVar8->high + (u_int)pFVar8->jolt;
MCCmd_cb_clampValue:
      uVar5 = 0xff;
      if (uVar6 < 0x100) {
        uVar5 = uVar6;
      }
      uVar1 = pFVar8->time;
      pFVar8->actuator[1] = (u_char)uVar5;
      pFVar8->time = uVar1 + 0xff;
    }
    else {
      if (pFVar8->time != 0) {
        uVar6 = (u_int)pFVar8->jolt * (u_int)pFVar8->time;
        uVar5 = (u_int)pFVar8->fade;
        uVar3 = (u_int)pFVar8->jolt * (u_int)pFVar8->time;
        uVar7 = (u_int)pFVar8->fade;
        pFVar8->actuator[0] = (u_int)Force_rand_256[Force_gTick >> 1 & 0xff] < uVar6 / uVar5 + (u_int)pFVar8->high
        ;
        uVar6 = uVar3 / uVar7 + (u_int)pFVar8->low;
        goto MCCmd_cb_clampValue;
      }
      pFVar8->jolt = '\0';
      bVar2 = Force_rand_256[Force_gTick >> 1 & 0xff];
      pFVar8->actuator[1] = pFVar8->low;
      pFVar8->actuator[0] = bVar2 < pFVar8->high;
    }
    pFVar8 = pFVar8 + 1;
    iVar9 = iVar9 + 1;
  } while( true );
}

/* ---- Force_Update__FP8Car_tObj  [FORCE.CPP:105-223] SLD-VERIFIED ---- */
void Force_Update(Car_tObj *car)

{
  int iVar1;
  int shock;
  int iVar2;
  int skids;
  u_int uVar3;
  int iVar4;
  int impacts;
  int iVar5;
  int time;
  int *piVar6;
  int force;
  u_char uVar7;
  int v1;
  int iVar8;
  u_char uVar9;
  int v0;
  int iVar10;
  int iVar11;
  int c;
  Force_tGlobal *f;
  int impactmultiplier;
  int frontmultiplier;
  int rearmultiplier;
  
  uVar3 = car->carIndex;
  if (1 < uVar3) {
    return;
  }
  if (1 < Replay_ReplayMode) {
    Force_g[uVar3].high = '\0';
    Force_g[uVar3].low = '\0';
    Force_g[uVar3].time = '\0';
    return;
  }
  iVar4 = GameSetup_gData.controllerData.shockMode[uVar3];
  iVar5 = GameSetup_gData.controllerData.shockImpact[uVar3];
  if (iVar4 == 0) {
    frontmultiplier = 0;
    rearmultiplier = 0;
  }
  else {
    frontmultiplier = (iVar4 + 0x10) * 0x2da6;
    rearmultiplier = (iVar4 + 0x10) * 0x1e6e;
  }
  if (iVar5 == 0) {
    iVar4 = 0;
  }
  else {
    iVar4 = (iVar5 + 0x10) * 0xb699;
  }
  iVar10 = 0;
  iVar5 = 0;
  if ((car->N).flightTime == 0) {
    switch((car->N).driveSurfaceType) {
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
      iVar10 = 0;
      iVar1 = (car->linearVel_ch).z;
      if (iVar1 < 0) {
        iVar1 = -iVar1;
      }
      iVar5 = 0x78000;
      if (iVar1 >> 2 < 0x78001) {
        iVar5 = iVar1 >> 2;
      }
      goto ForceUpd_audioRevLoop;
    case 10:
    case 0xb:
    case 0xc:
    case 0xd:
    case 0xf:
      iVar5 = (car->linearVel_ch).z;
      if (iVar5 < 0) {
        iVar5 = -iVar5;
      }
      iVar10 = 0x58000;
      if (iVar5 >> 1 < 0x58001) {
        iVar10 = iVar5 >> 1;
      }
      break;
    case 0xe:
      iVar10 = 0;
    }
    iVar5 = 0;
  }
ForceUpd_audioRevLoop:
  iVar1 = car->audioCount;
  if (iVar1 != 0) {
    piVar6 = &(car->N).simRoadInfo.quadPts[iVar1 * 2 + -4].z;
    while (iVar1 = iVar1 + -1, -1 < iVar1) {
      iVar2 = piVar6[0x1e7];
      iVar8 = iVar5;
      iVar11 = iVar10;
      if (iVar2 == 0x12) {
        iVar11 = piVar6[0x1ea] << 1;
        if (piVar6[0x1ea] << 1 < iVar10) {
          iVar11 = iVar10;
        }
      }
      else if (iVar2 == 0x14) {
        iVar8 = piVar6[0x1ea] << 1;
        if (piVar6[0x1ea] << 1 < iVar5) {
          iVar8 = iVar5;
        }
      }
      else if ((((iVar2 < 0) && (iVar4 != 0)) && (piVar6[0x1e8] != 10)) && (piVar6[0x1e8] != 8)) {
        iVar5 = piVar6[0x1ea];
        if (iVar5 < 0x28001) {
          iVar10 = 0x20;
        }
        else {
          iVar2 = 0x28000;
          iVar10 = fixeddiv(iVar5,0x28000);
          iVar10 = iVar10 * 0x20;
          if (iVar10 < 0) {
            iVar10 = iVar10 + 0xffff;
          }
          iVar5 = iVar2;
          if (iVar10 >> 0x10 < 0x61) {
            iVar2 = fixeddiv(piVar6[0x1ea],0x28000);
            iVar2 = iVar2 * 0x20;
            iVar10 = iVar2 >> 0x10;
            if (iVar2 < 0) {
              iVar10 = iVar2 + 0xffff >> 0x10;
            }
          }
          else {
            iVar10 = 0x60;
          }
        }
        iVar5 = fixedmult(iVar5,iVar4);
        if (iVar5 < 0) {
          iVar5 = iVar5 + 0xffff;
        }
        if (((int)(u_int)Force_g[uVar3].jolt < iVar5 >> 0x10) ||
           ((int)(u_int)Force_g[uVar3].time < iVar10)) {
          Force_g[uVar3].fade = (u_char)(iVar10 >> 1);
          Force_g[uVar3].time = (u_char)iVar10;
          Force_g[uVar3].jolt = (u_char)((u_int)iVar5 >> 0x10);
        }
      }
      piVar6 = piVar6 + -6;
      iVar5 = iVar8;
      iVar10 = iVar11;
    }
  }
  if (frontmultiplier == 0) {
    uVar9 = '\0';
  }
  else {
    if (0xa0000 < iVar10) {
      iVar10 = 0xa0000;
    }
    iVar4 = fixedmult(iVar10,frontmultiplier);
    uVar9 = (u_char)((u_int)iVar4 >> 0x10);
    if (iVar4 < 0) {
      uVar9 = (u_char)((u_int)(iVar4 + 0xffff) >> 0x10);
    }
  }
  if (rearmultiplier == 0) {
    uVar7 = '\0';
  }
  else {
    if (0xf0000 < iVar5) {
      iVar5 = 0xf0000;
    }
    iVar4 = fixedmult(iVar5,rearmultiplier);
    uVar7 = (u_char)((u_int)iVar4 >> 0x10);
    if (iVar4 < 0) {
      uVar7 = (u_char)((u_int)(iVar4 + 0xffff) >> 0x10);
    }
  }
  Force_g[uVar3].high = uVar9;
  Force_g[uVar3].low = uVar7;
  return;
}

/* ---- Force_StartUp__Fv  [FORCE.CPP:230-244] SLD-VERIFIED ---- */
void Force_StartUp(void)

{
  Force_tGlobal *force_walk;

  force_walk = Force_g;
  if (force_walk < Force_g + 2) {
    do {
      force_walk->active = '\0';
      force_walk->high = '\0';
      force_walk->low = '\0';
      force_walk->time = '\0';
      force_walk->actuator[0] = '\0';
      force_walk->actuator[1] = '\0';
      force_walk = force_walk + 1;
    } while (force_walk < Force_g + 2);
  }
  VSyncCallback(Force_Vbl);
  Sched_AddFunction(simGlobal.schedule32Hz,Force_Update,Cars_gHumanRaceCarList[0],0x32);
  if (GameSetup_gData.commMode == 1) {
    Sched_AddFunction(simGlobal.schedule32Hz,Force_Update,Cars_gHumanRaceCarList[1],0x32);
  }
  return;
}

/* ---- Force_Disable__Fv  [FORCE.CPP:250-258] SLD-VERIFIED ---- */
/* NEAR-MISS 17 diffs (30/29, improved from 25 baseline): FIXED the loop -- guarded
 * do-while (`if(pFVar2<Force_g+2){do{...}while(...)}`, entry-tested like a real `while`)
 * + direct struct-member stores (`pFVar2->actuator[0/1]=0`) instead of a raw negative-
 * offset byte pointer + `colourRGB` sentinel -- the loop body/guard now byte-matches
 * EXACTLY (indices 0-14 identical). Residual is entirely in the POST-loop tail: the two
 * `PadSetActAlign(N,Force_gOffAlign)` calls -- oracle REMATERIALIZES `Force_gOffAlign`'s
 * address at each call site (2x `lui a1;addiu a1`, no saved reg, smaller frame, no `sw
 * s0`); our build's GCSE hoists the (identical) address computation into a callee-saved
 * `s0` across the intervening `jal`. Tried: block-scoping each call in `{ }` (no change).
 * A compiler-internal GCSE-across-calls profitability decision, not source-reachable via
 * the standard levers; accepted near-miss. */
void Force_Disable(void)

{
  Force_tGlobal *pFVar2;

  pFVar2 = Force_g;
  if (pFVar2 < Force_g + 2) {
    do {
      pFVar2->actuator[0] = '\0';
      pFVar2->actuator[1] = '\0';
      pFVar2 = pFVar2 + 1;
    } while (pFVar2 < Force_g + 2);
  }
  PadSetActAlign(0,Force_gOffAlign);
  PadSetActAlign(4,Force_gOffAlign);
  VSyncCallback((void *)0x0);
  return;
}

/* ---- Force_IsForceOn__FP8Car_tObj  [FORCE.CPP:264-273] SLD-VERIFIED ---- */
/* NEAR-MISS 14 diffs (23/23, count exact -- improved from 24 baseline): FIXED branch
 * polarity -- rewrote the carIndex-range guard as an early-return `if(>=2) return 0;`
 * (matches the oracle's fallthrough-is-the-real-body layout) instead of the inline-body
 * `if(<2){...}return 0;` form, which had produced 3 EXTRA insns (dead early-guard delay
 * slot + inverted bnez + a spurious `lui v0,0` return-0 dup). Residual = oracle reuses the
 * dead `car` param register (a0, dead after reading carIndex) directly for BOTH the guard
 * test AND the later `sll a0,3` array-index shift; ours always allocates a fresh v0/v1.
 * Tried: hoisting carIndex into a local `int carIndex;` (no change -- same v1), inlining
 * `car->carIndex` twice (no change). Genuine allocator coloring tie-break for a dead-param
 * register reuse; accepted near-miss. */
int Force_IsForceOn(Car_tObj *car)

{
  if (1 < Replay_ReplayMode) {
    return 0;
  }
  if ((u_int)car->carIndex >= 2) {
    return 0;
  }
  return (u_int)(Force_g[car->carIndex].active == '\x01');
}

/* ---- Force_Pause__Fv  [FORCE.CPP:279-285] SLD-VERIFIED ---- */
void Force_Pause(void)

{
  Force_tGlobal *pFVar2;

  pFVar2 = Force_g;
  if (pFVar2 < Force_g + 2) {
    do {
      pFVar2->high = '\0';
      pFVar2->low = '\0';
      pFVar2->time = '\0';
      pFVar2 = pFVar2 + 1;
    } while (pFVar2 < Force_g + 2);
  }
  return;
}

/* ---- Force_UnPause__Fv  [FORCE.CPP:291-292] SLD-VERIFIED ---- */
void Force_UnPause(void)

{
  return;
}

/* ---- Force_HitSign__FP8Car_tObj  [FORCE.CPP:298-299] SLD-VERIFIED ---- */
void Force_HitSign(Car_tObj *car)

{
  return;
}

/* ---- Force_HitWall__Fi  [FORCE.CPP:301-302] SLD-VERIFIED ---- */
void Force_HitWall(int impulse)

{
  int shock;
  int skids;
  int impacts;
  int time;
  int padnum;
  int force;
  int v1;
  int v0;
  int c;
  int impactmultiplier;
  int frontmultiplier;
  int rearmultiplier;
  
  return;
}

/* end of force.cpp */
