/* game/common/camera.cpp -- RECONSTRUCTED (NFS4 game clock: 128Hz EAC timer chain + master IRQ handler).
 *   3 fns: MasterInterruptHandler / SystemStartUp / SystemCleanUp. SYM-v3 locals; owns 4 globals.
 *   Verified vs disasm-v2.txt (addtimer/deltimer 1-arg = &Clock_MasterInterruptHandler). Self-contained.
 */
#include "../../nfs4_types.h"
#include "camera_externs.h"


/* ---- clock.obj-owned globals (.bss zero) ---- */
camera_info  Camera_gInfo[2];   /* @0x8010f2ac  (bss(zero)) */
int          gTunnelCamHeight[13] = { 373555, 321126, 340787, 242483, 321126, 373555, 255590, 176947, 288358, 268697, 268697, 0, 0 };   /* @0x8010f4cc */
int          gSplitCameras[3] = { 0, 2, 5 };   /* @0x8010f500 */
char         gAnimMode[13] = { 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0 };   /* @0x8010f50c */
char         gAnimCams[13][4] = { 2, 6, 0, 0, 1, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 1, 6, 0, 0, 1, 6, 0, 0 };   /* @0x8010f51c */
camera_flags Camera_gFlags[19] = { {0, 2, 2, 2, 2, 2, 2}, {0, 16, 16, 16, 16, 16, 16}, {0, 45, 45, 45, 45, 45, 45}, {0, 45, 45, 45, 45, 45, 45}, {0, 45, 45, 45, 45, 45, 45}, {0, 45, 45, 45, 45, 45, 45}, {0, 45, 45, 45, 45, 45, 45}, {0, 45, 45, 45, 45, 45, 45}, {-114688, 60, 60, 60, 60, 60, 60}, {0, 56, 56, 56, 56, 56, 56}, {0, 60, 60, 60, 60, 60, 60}, {0, 20, 20, 20, 20, 20, 20}, {0, 20, 20, 20, 20, 20, 20}, {0, 20, 20, 20, 20, 20, 20}, {0, 16, 16, 16, 16, 16, 16}, {0, 18, 18, 18, 18, 18, 18}, {0, 24, 24, 24, 24, 24, 24}, {0, 20, 20, 20, 20, 20, 20}, {0, 20, 20, 20, 20, 20, 20} };   /* @0x8010f550 */
coorddef     gDriverCam[28] = { {-23592, 26869, -17039}, {-23592, 26869, -17039}, {25559, 30801, 15728}, {23592, 26869, 11796}, {-23592, 26869, 0}, {-23592, 26869, 0}, {-23592, 26869, 0}, {-23592, 26869, 0}, {-23592, 26869, 15728}, {-19660, 26869, -4587}, {-23592, 22937, -8519}, {-19660, 26869, -8519}, {-23592, 22937, 11796}, {-23592, 26869, 28180}, {-19660, 22937, -3276}, {0, 19005, 32112}, {-19660, 26869, -8519}, {25559, 30801, 15728}, {-19660, 26869, -4587}, {-23592, 26869, 11796}, {-15728, 22937, 0}, {-15728, 22937, 0}, {-23592, 26869, 28180}, {25559, 30801, 15728}, {-23592, 26869, 15728}, {-19660, 26869, -4587}, {-19660, 26869, -8519}, {-23592, 26869, 28180} };   /* @0x8010f680 */
int          camSpeedTable[7] = { 64225, 60948, 56360, 52428, 47841, 43253, 39321 };   /* @0x8010f7d0 */
coorddef     feeler3[3] = { {0, 0, 137625}, {-117964, 0, -72089}, {117964, 0, -72089} };   /* @0x8010f7ec */
int          Camera_gCopDist[6];   /* @0x8010f810  (bss(zero)) */
long Camera_gGeomScreen = 190;  /* @0x8013c7dc scalar -- confirmed by oracle: every SetCameraZoom/UpdateBTCopCam/Init/SetMode/
   NextMode/ReplayUpdate site does exactly ONE %gp_rel word store, never a paired +4 store; every OTHER
   TU's extern decl (cars_externs.h, hrzsku_externs.h, trsproj_externs.h) already declares it `long`
   scalar, not an array. The stray "[2]"/"[1]=0" writes were a prior session's mis-guess from the SYM's
   size-0 + the next-symbol (frontLimit@+8) gap; frontLimit is link-layout-adjacent, not Camera_gGeomScreen[1]. */
coorddef     gCop1Target[2];   /* @0x8013dff0  (bss?) */


/* ---- intra-TU forward declarations ---- */
void EulerToMat(matrixtdef *m,int ax,int ay,int az);
void Camera_SetCamera(DRender_tView *cview);
void Camera_LookBack(matrixtdef *src,matrixtdef *tgt);
void Camera_TunnelLimit(int player,int *armheight);
void Camera_UpdateCollisionCam(int player);
void Camera_UpdateSimpleCam(int player);
void Camera_UpdateBumperCam(int player);
void Camera_UpdateTailCam(int player,int behavior);
void Camera_UpdateHeliCam(int player,int behavior);
void Camera_UpdateCircleCam(int player);
void SetCameraZoom(int player,int targetDist);
void Camera_UpdateTVCam(int player);
void Camera_UpdateAnimCam(int player);
void Camera_UpdateFinishCam(int player);
void Camera_UpdateBlimpCam(int player);
void Camera_SetSplineCam(int player);
void Camera_UpdateSplineCam(int player);
int Camera_IslandProfile(u_short before);
void Camera_UpdatePulloverCam(int player);
void Camera_UpdateCopCam1(int player);
void Camera_UpdateCopCam2(int player);
void Camera_UpdateBTCopCam(int player);
void Camera_Update(void);
void Camera_Init(void);
void Camera_Kill(void);
void Camera_PitchAndRoll(int player);
int Camera_TooSteep(int player,BWorldSm_Pos *slicePos);
void Camera_CheckWallCollisions(int player,coorddef *pos);
void Camera_SetAboveGround(int player,coorddef *pos);
void Camera_AcquireTarget(int player,coorddef *point,coorddef *pos,matrixtdef *rot,int hirez);
void Camera_OpponentLookBehind(int player,coorddef *pos,int reset);
void Camera_GetViewInfo(int cviewP,DRender_tCalcView *cview,int viewID);
void Camera_GetAudioViewInfo(int cviewP,DRender_tCalcView *cview,coorddef **cvel);
int Camera_GetMode(int cviewP);
void Camera_SetMode(int cviewP,int mode);
void Camera_NextMode(int cviewP);
void Camera_ReplayUpdate(int cviewP,Camera_tCamSlot *ptr);
void Camera_ResetRelPos(int bitMask);


/* ---- EulerToMat__FP10matrixtdefiii  [@0x8008060c] ---- */
void EulerToMat(matrixtdef *m,int ax,int ay,int az)
{
  matrixtdef mx;
  matrixtdef my;
  matrixtdef mz;
  matrixtdef mt;
  int iVar1;
  int iVar2;
  int iVar3;

  fixedxformx(&mx,ax);
  fixedxformy(&my,ay);
  fixedxformz(&mz,az);
  Math_fasttransmult(&mz,&my,&mt);
  Math_fasttransmult(&mt,&mx,m);
  iVar1 = m->m[3];
  iVar2 = m->m[4];
  iVar3 = m->m[5];
  m->m[3] = -m->m[6];
  m->m[5] = -m->m[8];
  m->m[4] = -m->m[7];
  m->m[6] = iVar1;
  m->m[7] = iVar2;
  m->m[8] = iVar3;
  return;
}

/* ---- Camera_SetCamera__FP13DRender_tView  [@0x80080704] ---- */
void Camera_SetCamera(DRender_tView *cview)
{
  Camera_GetViewInfo(cview->player,&cview->cview,cview->id);
  TrsProj_SetViewTrsProjEnviro(cview);
  return;
}

/* ---- Camera_LookBack__FP10matrixtdefT0  [@0x8008073c] ---- */
void Camera_LookBack(matrixtdef *src,matrixtdef *tgt)
{
  tgt->m[0] = -src->m[0];
  tgt->m[1] = -src->m[1];
  tgt->m[2] = -src->m[2];
  tgt->m[3] = src->m[3];
  tgt->m[4] = src->m[4];
  tgt->m[5] = src->m[5];
  tgt->m[6] = -src->m[6];
  tgt->m[7] = -src->m[7];
  tgt->m[8] = -src->m[8];
  return;
}

/* ---- Camera_TunnelLimit__FiPi  [@0x800807c4] ---- */
void Camera_TunnelLimit(int player,int *armheight)
{
  bool bVar1;
  void *pvVar2;
  BWorldSm_Pos *slicePos;   /* SYM: REG slicePos PTR BWorldSm_Pos */
  coorddef quadnormal;      /* SYM: AUTO */
  coorddef underCam;        /* SYM: AUTO */
  int roadheight;           /* SYM: REG */
  int track;                /* SYM: REG */
  int maxheight;            /* SYM: REG */

  bVar1 = false;
  pvVar2 = BWorldSm_TunnelFlagSm(&Camera_gInfo[player].slicePos);
  if ((pvVar2 != (void *)0x0) ||
     (pvVar2 = BWorldSm_TunnelFlagSm(&(Camera_gInfo[player].anchor)->simRoadInfo), pvVar2 != (void *)0x0)) {
    bVar1 = true;
  }
  if (bVar1) {
    /* MATCH: slicePos ptr local (s0) assigned inside the guard; other gInfo fields
     * rematerialize per access at negative displacements off &slicePos (no composite ptr) */
    slicePos = &Camera_gInfo[player].slicePos;
    quadnormal = *(coorddef *)BWorldSm_UNormal(slicePos);
    underCam = Camera_gInfo[player].position;
    roadheight = Newton_FindGroundElevationGeneral(&underCam,&quadnormal,slicePos->quadPts);
    track = GameSetup_gData.track;
    if (0xf < GameSetup_gData.track) {
      track = GameSetup_gData.track + -7;
    }
    maxheight = (gTunnelCamHeight[track] - ((Camera_gInfo[player].anchor)->position).y) + roadheight;
    if (maxheight < *armheight) {
      *armheight = maxheight;
    }
  }
  return;
}

/* ---- Camera_UpdateCollisionCam__Fi  [@0x8008090c] ---- */
void Camera_UpdateCollisionCam(int player)
{
  coorddef arm = {0, 0x30000, -0xa0000};   /* SYM: AUTO; braced init -> rodata template D_800558A4 copy */
  coorddef newarm;   /* SYM: AUTO */
  coorddef oldarm;   /* SYM: AUTO */
  BO_tNewtonObj *pBVar3;

  if (((simVar.quickPauseSim == 0) || (Replay_ReplayInterface.changeCamera != 0)) &&
     (InBetween == 0)) {
    if (Camera_gInfo[player].direction != 0) {
      arm.z = -arm.z;   /* MATCH: negate, not a 0xA0000 re-store */
    }
    transform(&arm,((Camera_gInfo[player].anchor)->roadMatrix).m,&newarm);
    Camera_TunnelLimit(player,&newarm.y);
    oldarm = Camera_gInfo[player].relpos;   /* MATCH: struct copy -> grouped t0-t2 load/store */
    Camera_gInfo[player].relpos.x = oldarm.x + fixedmult(newarm.x - oldarm.x,0x51e);
    Camera_gInfo[player].relpos.y = oldarm.y + fixedmult(newarm.y - oldarm.y,0x51e);
    Camera_gInfo[player].relpos.z = oldarm.z + fixedmult(newarm.z - oldarm.z,0x51e);
    /* here the oracle keeps ONE cached anchor for all three lines (no re-load) */
    pBVar3 = Camera_gInfo[player].anchor;
    Camera_gInfo[player].position.x = (pBVar3->position).x + Camera_gInfo[player].relpos.x;
    Camera_gInfo[player].position.y = (pBVar3->position).y + Camera_gInfo[player].relpos.y;
    Camera_gInfo[player].position.z = (pBVar3->position).z + Camera_gInfo[player].relpos.z;
    if (Camera_gInfo[player].tumbling == 0) {
      Camera_gInfo[player].intransition = 0x32;
    }
    /* MATCH: real bitfield assignments; pitch=1 FIRST (ori 2 precedes the and -5) */
    Camera_gInfo[player].pitch = 1;
    Camera_gInfo[player].jostling = 0;
    Camera_gInfo[player].tracking = 1;
    Camera_gInfo[player].checkwalls = 1;
    Camera_gInfo[player].noLookBack = 1;
    Camera_gInfo[player].checkcollisions = 1;
  }
  return;
}

/* ---- Camera_UpdateSimpleCam__Fi  [@0x80080ac8] ---- */
void Camera_UpdateSimpleCam(int player)
{
  coorddef arm;
  coorddef newarm;
  short sVar1;
  BO_tNewtonObj *pBVar2;

  sVar1 = Camera_gInfo[player].mode;
  arm = Camera_gFlags[sVar1].arm;
  transform((int *)&arm,Camera_gInfo[player].anchor->orientMat.m,(int *)&newarm);
  Camera_TunnelLimit(player,&newarm.y);
  Camera_gInfo[player].position.x = Camera_gInfo[player].anchor->position.x + newarm.x;
  /* MATCH: oracle re-loads anchor (lw a0,0(s0)) for the y/z pair - volatile re-deref blocks CSE */
  pBVar2 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
  Camera_gInfo[player].position.y = pBVar2->position.y + newarm.y;
  Camera_gInfo[player].position.z = pBVar2->position.z + newarm.z;
  Camera_LookBack(&pBVar2->orientMat,&Camera_gInfo[player].rotation);
  return;
}

/* ---- Camera_UpdateBumperCam__Fi  [@0x80080bac] ---- */
void Camera_UpdateBumperCam(int player)
{
  coorddef arm;        /* SYM: AUTO @0x10 */
  coorddef newarm;     /* SYM: AUTO @0x20 */
  int lookingBehind;   /* SYM: REG ($s1) */
  BO_tNewtonObj *pBVar4;

  lookingBehind = 0;
  arm = Camera_gFlags[Camera_gInfo[player].mode].arm;
  if (Camera_gInfo[player].noLookBack == 0) {
    lookingBehind = Input_gLookBehind[player] != 0;
  }
  if (lookingBehind) {
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_gInfo[player].audioPos.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    /* MATCH: oracle re-loads anchor for the y/z pair */
    pBVar4 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
    Camera_gInfo[player].audioPos.y = (pBVar4->position).y + newarm.y;
    Camera_gInfo[player].audioPos.z = (pBVar4->position).z + newarm.z;
    arm.z = -arm.z;
  }
  transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
  Camera_gInfo[player].position.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
  pBVar4 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
  Camera_gInfo[player].position.y = (pBVar4->position).y + newarm.y;
  Camera_gInfo[player].position.z = (pBVar4->position).z + newarm.z;
  if (lookingBehind) {
    Camera_LookBack(&pBVar4->orientMat,&Camera_gInfo[player].rotation);
  }
  else {
    /* MATCH: FRESH anchor re-load here (kills the anchor+240 CSE with the if-arm);
     * plain struct assignment -> gcc movstrsi unrolled copy (9 words) */
    Camera_gInfo[player].rotation =
         (*(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor)->orientMat;
  }
  return;
}

/* ---- Camera_UpdateTailCam__Fii  [@0x80080d84] ---- */
void Camera_UpdateTailCam(int player,int behavior)
{
  coorddef arm;      /* SYM: AUTO @0x10 */
  coorddef newarm;   /* SYM: AUTO @0x20 */
  coorddef oldarm;   /* SYM: AUTO @0x30 */
  Car_tObj *anchor;  /* SYM: REG */
  int maxrate;       /* SYM: REG ($a2) */
  int rate;          /* SYM: REG ($s2) */
  int rateY;         /* SYM: REG ($s5) */
  int vertigo;       /* SYM: REG */
  int slice;         /* SYM: REG */
  int lookahead;     /* SYM: REG ($s0) */
  int len;           /* SYM: REG ($v0) */
  BO_tNewtonObj *pBVar7;

  maxrate = 0x1999;
  rate = maxrate;
  {
    short mode = Camera_gInfo[player].mode;   /* MATCH: inner gInfo eval first (base lui v0) */
    arm = Camera_gFlags[mode].arm;
  }
  anchor = (Car_tObj *)Camera_gInfo[player].anchor;
  rateY = 0xCCC;
  {
    /* MATCH: reverseTrack read ONCE before the if (single lw, shared by both arms) */
    int rev = GameSetup_gData.reverseTrack;
    if (0 < anchor->wrongway) {
      if ((rev ^ 1) == 0) {
        lookahead = -3;
      } else {
        lookahead = 3;
      }
    }
    else {
      if (rev == 0) {
        lookahead = -3;
      } else {
        lookahead = 3;
      }
    }
  }
  if ((simVar.quickPauseSim != 0) && (Replay_ReplayInterface.changeCamera == 0)) {
    return;
  }
  if (InBetween != 0) {
    return;
  }
  /* MATCH: real switch (oracle binary-tree dispatch), not if-chain */
  switch (behavior) {
  case 0:
    rate = 0x1999;
    break;
  case 1:
    maxrate = 0x1999;
    break;
  case 2:
    maxrate = 0xCCC;
    break;
  }
  if (behavior != 0) {
    int x = anchor->linearVel_ch.x;
    int z = anchor->linearVel_ch.z;
    int ax = (x < 0) ? -x : x;   /* MATCH: ABS ternary - else-arm copy stolen into bgez slot */
    if (z < 0) {
      z = -z;
    }
    /* MATCH: speed sum accumulates IN rate (s2, dead here); vertigo = /900 result */
    if (z < ax) {
      rate = ax + (z >> 2);
    }
    else {
      rate = z + (ax >> 2);
    }
    rate = rate / 900;
    /* MATCH: MAX(0x51E, MIN(rate,maxrate)) funnels into vertigo (a1), then rate = vertigo (s2) */
    vertigo = ((maxrate < rate ? maxrate : rate) < 0x51E) ? 0x51E
            : (maxrate < rate ? maxrate : rate);
    rate = vertigo;
  }
  if (Input_gLookBehind[player] != 0) {
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&Camera_gInfo[player].relpos.x);
  }
  slice = (int)((Camera_gInfo[player].anchor)->simRoadInfo).slice;
  if (0 <= lookahead) {
    slice = slice + lookahead;
    if (gNumSlices <= slice) {
      slice = slice - gNumSlices;
    }
  }
  else {
    slice = slice + lookahead;
    if (slice < 0) {
      slice = slice + gNumSlices;
    }
  }
  {
    /* MATCH: BWorldSm_slices cached ONCE in a caller-saved reg (a2) across both wrap arms;
     * wrap-adjust goes through an unshifted index FUNNEL (v0) - slice itself is NOT re-mutated;
     * dbr duplicates the join's sll into both branch slots */
    char *slices = (char *)BWorldSm_slices;
    int idx;
    int tail = *(int *)((slice << 5) + slices + 4);   /* loaded BEFORE the wrap arms */
    if (lookahead < 1) {
      slice = slice - lookahead;
      if (gNumSlices <= slice) {
        idx = slice - gNumSlices;
      } else {
        idx = slice;
      }
    }
    else {
      slice = slice - lookahead;
      if (slice < 0) {
        idx = slice + gNumSlices;
      } else {
        idx = slice;
      }
    }
    len = (tail - *(int *)((idx << 5) + slices + 4)) / 3;
  }
  switch (behavior) {
  case 0:
    len = 0;
    break;
  case 1:
    /* MATCH: MAX(0x4000, MIN(len,0x10000)) nested macros */
    len = ((0x10000 < len ? 0x10000 : len) < 0x4000) ? 0x4000
        : (0x10000 < len ? 0x10000 : len);
    break;
  case 2:
    len = ((0x20000 < len ? 0x20000 : len) < -0x4000) ? -0x4000
        : (0x20000 < len ? 0x20000 : len);
    break;
  }
  arm.y = arm.y + len;
  if (Input_gLookBehind[player] != 0) {
    /* audio (look-behind) arm FIRST in VA order */
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_gInfo[player].audioPos.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    /* MATCH: oracle re-loads anchor for the y/z pair - volatile re-deref blocks CSE */
    pBVar7 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
    Camera_gInfo[player].audioPos.y = (pBVar7->position).y + newarm.y;
    Camera_gInfo[player].audioPos.z = (pBVar7->position).z + newarm.z;
    arm.z = -arm.z;
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_TunnelLimit(player,&newarm.y);
    Camera_gInfo[player].position.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    pBVar7 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
    Camera_gInfo[player].position.y = (pBVar7->position).y + newarm.y;
    Camera_gInfo[player].position.z = (pBVar7->position).z + newarm.z;
    return;
  }
  transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
  Camera_TunnelLimit(player,&newarm.y);
  oldarm = Camera_gInfo[player].relpos;   /* MATCH: struct copy -> grouped t0-t2 load/store */
  if (Camera_gInfo[player].intransition != 0) {
    Camera_gInfo[player].intransition = Camera_gInfo[player].intransition - 1;
    rateY = 0x1999;
    rate = 0x1999;
  }
  Camera_gInfo[player].relpos.x = oldarm.x + fixedmult(newarm.x - oldarm.x,rate);
  Camera_gInfo[player].relpos.y = oldarm.y + fixedmult(newarm.y - oldarm.y,rateY);
  Camera_gInfo[player].relpos.z = oldarm.z + fixedmult(newarm.z - oldarm.z,rate);
  if (Camera_gInfo[player].intransition == 0) {
    len = Math_VectorLength(&Camera_gInfo[player].relpos);
    if (len < 0x4f0a3) {
      int scale = fixeddiv(0x4f0a3,len);   /* SYM: REG scale in NESTED block scope ($s0) */
      Camera_gInfo[player].relpos.x = fixedmult(scale,Camera_gInfo[player].relpos.x);
      Camera_gInfo[player].relpos.y = fixedmult(scale,Camera_gInfo[player].relpos.y);
      Camera_gInfo[player].relpos.z = fixedmult(scale,Camera_gInfo[player].relpos.z);
    }
  }
  Camera_gInfo[player].position.x =
       ((Camera_gInfo[player].anchor)->position).x + Camera_gInfo[player].relpos.x;
  pBVar7 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
  Camera_gInfo[player].position.y = (pBVar7->position).y + Camera_gInfo[player].relpos.y;
  Camera_gInfo[player].position.z = (pBVar7->position).z + Camera_gInfo[player].relpos.z;
  return;
}

/* ---- Camera_UpdateHeliCam__Fii  [@0x800813cc] ---- */
void Camera_UpdateHeliCam(int player,int behavior)
{
  coorddef arm;      /* SYM: AUTO @0x10 */
  coorddef newarm;   /* SYM: AUTO @0x20 */
  coorddef oldarm;   /* SYM: AUTO @0x30 */
  Car_tObj *anchor;  /* SYM: REG ($s2 - live across calls) */
  int fallback;      /* SYM: REG ($a0) */
  int maxrate;       /* SYM: REG ($a2) */
  int rate;          /* SYM: REG ($s0) */
  int rateY;         /* SYM: REG ($s5) */
  int vertigo;       /* SYM: REG */
  int slice;         /* SYM: REG ($v1) */
  int lookahead;     /* SYM: REG ($s1) */
  int len;           /* SYM: REG ($v0) */
  BO_tNewtonObj *pBVar7;

  maxrate = 0x1999;
  rate = maxrate;
  {
    short mode = Camera_gInfo[player].mode;   /* MATCH: inner gInfo eval first (base lui v0) */
    arm = Camera_gFlags[mode].arm;
  }
  anchor = (Car_tObj *)Camera_gInfo[player].anchor;
  rateY = 0xCCC;
  {
    /* MATCH: reverseTrack read ONCE before the if (single lw, shared by both arms) */
    int rev = GameSetup_gData.reverseTrack;
    if (0 < anchor->wrongway) {
      if ((rev ^ 1) == 0) {
        lookahead = -3;
      } else {
        lookahead = 3;
      }
    }
    else {
      if (rev == 0) {
        lookahead = -3;
      } else {
        lookahead = 3;
      }
    }
  }
  if ((simVar.quickPauseSim != 0) && (Replay_ReplayInterface.changeCamera == 0)) {
    return;
  }
  if (InBetween != 0) {
    return;
  }
  /* MATCH: real switch (oracle binary-tree dispatch), not if-chain */
  switch (behavior) {
  case 0:
    rate = 0x1999;
    break;
  case 1:
    maxrate = 0x1999;
    break;
  case 2:
    maxrate = 0xCCC;
    break;
  }
  if (behavior != 0) {
    int x = anchor->linearVel_ch.x;
    int z = anchor->linearVel_ch.z;
    int ax = (x < 0) ? -x : x;   /* MATCH: ABS ternary - else-arm copy stolen into bgez slot */
    if (z < 0) {
      z = -z;
    }
    /* MATCH: speed sum accumulates IN rate (dead here); vertigo = /900 result */
    if (z < ax) {
      rate = ax + (z >> 2);
    }
    else {
      rate = z + (ax >> 2);
    }
    rate = rate / 900;
    /* MATCH: MAX(0x51E, MIN(rate,maxrate)) funnels into vertigo, then rate = vertigo */
    vertigo = ((maxrate < rate ? maxrate : rate) < 0x51E) ? 0x51E
            : (maxrate < rate ? maxrate : rate);
    rate = vertigo;
  }
  if (1 < Replay_ReplayMode) {
    rate = 0x28F;
  }
  if (Input_gLookBehind[player] != 0) {
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&Camera_gInfo[player].relpos.x);
  }
  {
    /* heli fallback: pull the camera back by |velocity|/20, clamped to 0x20000 */
    int x = anchor->linearVel_ch.x;
    int z = anchor->linearVel_ch.z;
    if (x < 0) {
      x = -x;
    }
    if (z < 0) {
      z = -z;
    }
    if (z < x) {
      fallback = x + (z >> 2);
    }
    else {
      fallback = z + (x >> 2);
    }
    fallback = fallback / 20;
    if (0x20000 < fallback) {
      fallback = 0x20000;
    }
    arm.z = arm.z - fallback;
  }
  slice = (int)((Camera_gInfo[player].anchor)->simRoadInfo).slice;
  if (0 <= lookahead) {
    slice = slice + lookahead;
    if (gNumSlices <= slice) {
      slice = slice - gNumSlices;
    }
  }
  else {
    slice = slice + lookahead;
    if (slice < 0) {
      slice = slice + gNumSlices;
    }
  }
  {
    /* MATCH: BWorldSm_slices cached ONCE in a caller-saved reg (a2) across both wrap arms;
     * wrap-adjust goes through an unshifted index FUNNEL (v0) - slice itself is NOT re-mutated;
     * dbr duplicates the join's sll into both branch slots */
    char *slices = (char *)BWorldSm_slices;
    int idx;
    int tail = *(int *)((slice << 5) + slices + 4);   /* loaded BEFORE the wrap arms */
    if (lookahead < 1) {
      slice = slice - lookahead;
      if (gNumSlices <= slice) {
        idx = slice - gNumSlices;
      } else {
        idx = slice;
      }
    }
    else {
      slice = slice - lookahead;
      if (slice < 0) {
        idx = slice + gNumSlices;
      } else {
        idx = slice;
      }
    }
    len = (tail - *(int *)((idx << 5) + slices + 4)) / 2;
  }
  switch (behavior) {
  case 0:
    len = 0;
    break;
  case 1:
    /* MATCH: MAX(0x4000, MIN(len,0x14000)) nested macros */
    len = ((0x14000 < len ? 0x14000 : len) < 0x4000) ? 0x4000
        : (0x14000 < len ? 0x14000 : len);
    break;
  case 2:
    len = ((0x30000 < len ? 0x30000 : len) < -0xc000) ? -0xc000
        : (0x30000 < len ? 0x30000 : len);
    break;
  }
  arm.y = arm.y + len;
  if (Input_gLookBehind[player] != 0) {
    /* audio (look-behind) arm FIRST in VA order */
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_gInfo[player].audioPos.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    /* MATCH: oracle re-loads anchor for the y/z pair - volatile re-deref blocks CSE */
    pBVar7 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
    Camera_gInfo[player].audioPos.y = (pBVar7->position).y + newarm.y;
    Camera_gInfo[player].audioPos.z = (pBVar7->position).z + newarm.z;
    arm.z = -arm.z;
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_TunnelLimit(player,&newarm.y);
    Camera_gInfo[player].position.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    pBVar7 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
    Camera_gInfo[player].position.y = (pBVar7->position).y + newarm.y;
    Camera_gInfo[player].position.z = (pBVar7->position).z + newarm.z;
    return;
  }
  transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
  Camera_TunnelLimit(player,&newarm.y);
  oldarm = Camera_gInfo[player].relpos;   /* MATCH: struct copy -> grouped t0-t2 load/store */
  if (Camera_gInfo[player].intransition != 0) {
    Camera_gInfo[player].intransition = Camera_gInfo[player].intransition - 1;
    rateY = 0x1999;
    rate = 0x1999;
  }
  Camera_gInfo[player].relpos.x = oldarm.x + fixedmult(newarm.x - oldarm.x,rate);
  Camera_gInfo[player].relpos.y = oldarm.y + fixedmult(newarm.y - oldarm.y,rateY);
  Camera_gInfo[player].relpos.z = oldarm.z + fixedmult(newarm.z - oldarm.z,rate);
  if (Camera_gInfo[player].intransition == 0) {
    len = Math_VectorLength(&Camera_gInfo[player].relpos);
    if (len < 0x651eb) {
      int scale = fixeddiv(0x651eb,len);   /* SYM: REG scale in NESTED block scope ($s0) */
      Camera_gInfo[player].relpos.x = fixedmult(scale,Camera_gInfo[player].relpos.x);
      Camera_gInfo[player].relpos.y = fixedmult(scale,Camera_gInfo[player].relpos.y);
      Camera_gInfo[player].relpos.z = fixedmult(scale,Camera_gInfo[player].relpos.z);
    }
  }
  Camera_gInfo[player].position.x =
       ((Camera_gInfo[player].anchor)->position).x + Camera_gInfo[player].relpos.x;
  pBVar7 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
  Camera_gInfo[player].position.y = (pBVar7->position).y + Camera_gInfo[player].relpos.y;
  Camera_gInfo[player].position.z = (pBVar7->position).z + Camera_gInfo[player].relpos.z;
  return;
}

/* ---- Camera_UpdateCircleCam__Fi  [@0x80081ab8] ---- */
void Camera_UpdateCircleCam(int player)
{
  coorddef src;
  coorddef des;
  int sin;
  int cos;
  int circle_height[3] = { 0x10000, 0x20000, 0x30000 };
  int h0;
  int h1;
  int ang;
  int hval;
  short sVar1;
  BO_tNewtonObj *pBVar2;
  int uVar3;
  Camera_tInfo *pCVar4;

  if ((((simVar.quickPauseSim == 0) || (Replay_ReplayInterface.changeCamera != 0)) &&
      (InBetween == 0)) && (simVar.pauseSim == 0)) {
    sVar1 = Camera_gInfo[player].circleAngle + 1;
    Camera_gInfo[player].circleAngle = sVar1;
    intsincos((int)sVar1,&sin,&cos);
    src.x = fixedmult(0x48000,cos);
    src.z = fixedmult(0x60000,sin);
    if (((int)Camera_gInfo[player].circleAngle + 0x100U & 0x1ff) == 0) {
      Camera_gInfo[player].circleCounter = Camera_gInfo[player].circleCounter + 1;
    }
    uVar3 = (int)Camera_gInfo[player].circleAngle - 0x80;
    if ((uVar3 & 0x1ff) < 0x80) {
      h0 = circle_height[Camera_gInfo[player].circleCounter % 3];
      h1 = circle_height[(Camera_gInfo[player].circleCounter + 1) % 3];
      ang = uVar3 & 0x7f;
      hval = ((h1 - h0) * ang >> 7) + h0;
    }
    else {
      h0 = circle_height[Camera_gInfo[player].circleCounter % 3];
      hval = h0;
    }
    src.y = hval;
    pCVar4 = Camera_gInfo + player;
    transform(&src,(pCVar4->anchor->orientMat).m,&des);
    Camera_TunnelLimit(player,&des.y);
    pBVar2 = pCVar4->anchor;
    Camera_gInfo[player].position.x = (pCVar4->anchor->position).x + des.x;
    Camera_gInfo[player].position.y = (pBVar2->position).y + des.y;
    Camera_gInfo[player].position.z = (pBVar2->position).z + des.z;
  }
  return;
}

/* ---- SetCameraZoom__Fii  [@0x80081d38] ---- */
void SetCameraZoom(int player,int targetDist)
{
  int gs;

  if (Camera_gInfo[player].splitscreen != 0) {
    Camera_gGeomScreen = 0xbe;
  }
  else if (0x3000 < targetDist) {
    if (Camera_gInfo[player].zooming == 1) {
      Camera_gGeomScreen = targetDist * 0xbe / 0x3000;
    }
    else if (Camera_gInfo[player].zooming == 2) {
      gs = targetDist * 0xbe / 0x3000;
      Camera_gGeomScreen = gs;
      if (0x4b0 < gs) {
        gs = (6000 - gs) >> 2;
        if (gs < 0x2ee) {
          gs = 0x2ee;
        }
        Camera_gGeomScreen = gs;
      }
    }
  }
  SetGeomScreen(Camera_gGeomScreen);
  return;
}

/* ---- Camera_UpdateTVCam__Fi  [@0x80081e48] ---- */
void Camera_UpdateTVCam(int player)
{
  static int lastX[2];
  static int lastY[2];
  int targetDist;
  int height;
  int iVar1;
  int iVar2;
  int dist4;

  iVar1 = Math_Dist3D(&(Camera_gInfo[player].target)->position,&Camera_gInfo[player].position);
  if (0 < iVar1) {
    iVar1 = Math_Dist3D(&(Camera_gInfo[player].target)->position,&Camera_gInfo[player].position);
    dist4 = iVar1 >> 4;
  }
  else {
    iVar1 = Math_Dist3D(&(Camera_gInfo[player].target)->position,&Camera_gInfo[player].position);
    iVar1 = -iVar1;
    dist4 = iVar1 >> 4;
  }
  /* @0x80081EC4-F14: TWO distinct fn-statics indexed by player*4 -- lastX[2]@0x8013DD88 and
   * lastY[2]@0x8013DD90 (8 bytes apart). The reconstruction routed every access through one
   * Ghidra-ism `*(int*)("" + iVar3)` placeholder, collapsing lastY into lastX (H43). */
  /* MATCH: compare lastX[player] (LHS first -> its address materializes before Camera_gInfo's)
   * against the field directly; the taken-branch store reuses the loaded position.x */
  if (lastX[player] != Camera_gInfo[player].position.x) {
    lastX[player] = Camera_gInfo[player].position.x;
    lastY[player] = Camera_gInfo[player].position.y;
  }
  targetDist = fixedmult(Camera_gInfo[player].TVHeight >> 2,dist4 + -0x4000);
  /* MATCH: if/else (dbr steals the else-arm copy into the beqz slot) + plain if, one CSE'd slt */
  if (Camera_gInfo[player].TVHeight < targetDist) {
    height = Camera_gInfo[player].TVHeight;
  } else {
    height = targetDist;
  }
  if (Camera_gInfo[player].TVHeight < targetDist) {
    targetDist = Camera_gInfo[player].TVHeight;
  }
  if (targetDist < 0) {
    height = 0;
  }
  Camera_gInfo[player].position.y = lastY[player] + height;   /* @0x80081F64 read lastY[player] */
  SetCameraZoom(player,dist4);
  return;
}

/* ---- Camera_UpdateAnimCam__Fi  [@0x80081f94] ---- */
void Camera_UpdateAnimCam(int player)
{
  coorddef animPos;    /* SYM: AUTO */
  coorddef newarm;     /* SYM: AUTO */
  matrixtdef animRot;  /* SYM: AUTO */
  signed char cVar1;   /* signed: decrement emits addiu -1 (not +255) */
  int iVar2;
  AnimScript *pAVar3;
  BO_tNewtonObj *pBVar6;

  /* BUGFIX (H-class): animHandle is plain char (unsigned on this build) - the == -1 compare
   * was provably-false and gcc DELETED the whole re-acquire branch; (signed char) restores it */
  if ((signed char)Camera_gInfo[player].animHandle == -1) {
    /* MATCH: post-decrement in the index expr (lbu clobbers the compare's -1 reg) */
    cVar1 = (signed char)Camera_gInfo[player].animNum;
    Camera_gInfo[player].animNum = cVar1 - 1;
    iVar2 = Anim_Handle((u_int)(u_char)gAnimCams[GameSetup_gData.track][cVar1]);
    Camera_gInfo[player].animHandle = (char)iVar2;
  }
  pAVar3 = Anim_GetAnim((int)(signed char)Camera_gInfo[player].animHandle);
  iVar2 = pAVar3->GetTimedAnimPosRot(&animPos,&animRot);
  if (iVar2 < 1) {
    /* MATCH: re-acquire arm FIRST in VA order (blez jumps away to the <1 arm) */
    if (0 < (signed char)Camera_gInfo[player].animNum) {
      Anim_FreeHandle((int)(signed char)Camera_gInfo[player].animHandle);
      iVar2 = Anim_Handle((u_int)(u_char)gAnimCams[GameSetup_gData.track]
                                                 [(signed char)Camera_gInfo[player].animNum--]);
      Camera_gInfo[player].animHandle = (char)iVar2;
      pAVar3 = Anim_GetAnim((int)(signed char)(char)iVar2);
      pAVar3->GetTimedAnimPosRot(&animPos,&animRot);
    }
    else {
      if (Replay_ReplayMode == 2) {
        if (numValidCams != 0) {
          Replay_ReplayFindClosestCamera(player,(int)((Camera_gInfo[player].anchor)->simRoadInfo).slice);
          return;
        }
        Camera_SetMode(player,0xb);
        Camera_gInfo[player].splineMode = '';
        return;
      }
      Camera_SetMode(player,GameSetup_gData.carInfo[player].Camera[0]);
      return;
    }
  }
  /* BUGFIX (H-class): Ghidra rendered gAnimMode[track] as the string "" (mis-render trap);
   * also dropped the Ghidra-ism & 0x1f shift-count mask */
  /* MATCH: direct-copy arm FIRST in VA order (beqz jumps to the transform arm) */
  if ((gAnimMode[GameSetup_gData.track] >> (signed char)Camera_gInfo[player].animNum & 1U) != 0) {
    Camera_gInfo[player].position = animPos;   /* struct copies -> grouped/movstrsi */
    Camera_gInfo[player].rotation = animRot;
  }
  else {
    transform(&animPos,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_gInfo[player].position.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    /* MATCH: oracle re-loads anchor for the y/z pair */
    pBVar6 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
    Camera_gInfo[player].position.y = (pBVar6->position).y + newarm.y;
    Camera_gInfo[player].position.z = (pBVar6->position).z + newarm.z;
    Math_fasttransmult(&animRot,&pBVar6->orientMat,&Camera_gInfo[player].rotation);
  }
  return;
}

/* ---- Camera_UpdateFinishCam__Fi  [@0x80082254] ---- */
void Camera_UpdateFinishCam(int player)
{
  coorddef finishPos;    /* SYM: AUTO @0x10 */
  coorddef newarm;       /* SYM: AUTO @0x20 */
  matrixtdef finishRot;  /* SYM: AUTO @0x30 */
  int iVar1;
  AnimScript *pThis;
  BO_tNewtonObj *pBVar2;

  if ((signed char)Camera_gInfo[player].animHandle == -1) {
    iVar1 = Anim_Handle(1);
    Camera_gInfo[player].animHandle = (char)iVar1;
  }
  pThis = Anim_GetAnim((int)(signed char)Camera_gInfo[player].animHandle);
  iVar1 = pThis->GetTimedAnimPosRot(&finishPos,&finishRot);
  if (iVar1 < 1) {
    Anim_GetLastAnimPosRot(1,6,&finishPos,&finishRot);
  }
  transform((int *)&finishPos,Camera_gInfo[player].anchor->orientMat.m,(int *)&newarm);
  Camera_gInfo[player].position.x = Camera_gInfo[player].anchor->position.x + newarm.x;
  /* MATCH: oracle re-loads anchor (lw a1,0(s0)) for the y/z pair - volatile re-deref blocks CSE */
  pBVar2 = *(BO_tNewtonObj *volatile *)&Camera_gInfo[player].anchor;
  Camera_gInfo[player].position.y = pBVar2->position.y + newarm.y;
  Camera_gInfo[player].position.z = pBVar2->position.z + newarm.z;
  Math_fasttransmult(&finishRot,&pBVar2->orientMat,&Camera_gInfo[player].rotation);
  /* MATCH: six real bitfield assignments - 3 clears stay separate ands (-3/-5/-9),
   * 3 sets combine-fold into one ori 0x70; single lw/sw RMW via CSE */
  Camera_gInfo[player].pitch = 0;
  Camera_gInfo[player].jostling = 0;
  Camera_gInfo[player].tracking = 0;
  Camera_gInfo[player].checkwalls = 1;
  Camera_gInfo[player].noLookBack = 1;
  Camera_gInfo[player].checkcollisions = 1;
  return;
}

/* ---- Camera_UpdateBlimpCam__Fi  [@0x8008237c] ---- */
void Camera_UpdateBlimpCam(int player)
{
  coorddef arm;
  coorddef delta;
  short sVar1;
  BO_tNewtonObj *pBVar2;
  int iVar3;

  sVar1 = Camera_gInfo[player].mode;
  arm = Camera_gFlags[sVar1].arm;
  Camera_TunnelLimit(player,&arm.y);
  delta.x = Camera_gInfo[player].position.x - Camera_gInfo[player].anchor->position.x;
  delta.y = Camera_gInfo[player].position.y - Camera_gInfo[player].anchor->position.y;
  delta.z = Camera_gInfo[player].position.z - Camera_gInfo[player].anchor->position.z;
  iVar3 = fixedmult(arm.x - delta.x,0x1999);
  delta.x = delta.x + iVar3;
  iVar3 = fixedmult(arm.y - delta.y,0x1999);
  delta.y = delta.y + iVar3;
  iVar3 = fixedmult(arm.z - delta.z,0x1999);
  delta.z = delta.z + iVar3;
  Camera_gInfo[player].position.x = Camera_gInfo[player].anchor->position.x + delta.x;
  pBVar2 = Camera_gInfo[player].anchor;
  Camera_gInfo[player].position.y = pBVar2->position.y + delta.y;
  Camera_gInfo[player].position.z = pBVar2->position.z + delta.z;
  return;
}

/* ---- Camera_SetSplineCam__Fi  [@0x800824c0] ---- */
void Camera_SetSplineCam(int player)
{
  Car_tObj*anchor;
  int numSlice;
  int direction;
  short sVar1;
  int iVar2;
  int iVar3;
  int *piVar4;
  int iVar5;
  short sVar6;
  int iVar7;
  BO_tNewtonObj *pBVar8;
  Camera_tInfo *pCVar9;
  
  pCVar9 = Camera_gInfo + player;
  pBVar8 = pCVar9->anchor;
  iVar5 = ((0x10000 - camSpeedTable[(u_char)Camera_gInfo[player].splineMode]) * 0xf >> 0x10) + 1;
  iVar7 = 8;
  if (iVar5 < 9) {
    iVar7 = iVar5;
  }
  if (Replay_ReplayCamera[player].defaultCamera == 0) {
    iVar5 = fixedmult(Camera_gInfo[player].rotation.m[6],(pBVar8->roadMatrix).m[6]);
    iVar2 = fixedmult(Camera_gInfo[player].rotation.m[7],(pCVar9->anchor->roadMatrix).m[7]);
    iVar3 = fixedmult(Camera_gInfo[player].rotation.m[8],(pCVar9->anchor->roadMatrix).m[8]);
    if (iVar5 + iVar2 + iVar3 < 0) {
      iVar7 = -iVar7;
    }
    if (pBVar8[1].shadowMat.m[7] < 0) {
      iVar7 = -iVar7;
    }
    if (iVar7 >= 0) {
      sVar1 = (pBVar8->simRoadInfo).slice;
      sVar6 = sVar1 + (short)iVar7;
      if (gNumSlices <= sVar1 + iVar7) {
        sVar6 = sVar6 - (short)gNumSlices;
      }
      Camera_gInfo[player].slicePos.slice = sVar6;
    }
    else {
      sVar1 = (pBVar8->simRoadInfo).slice;
      sVar6 = sVar1 + (short)iVar7;
      if (sVar1 + iVar7 < 0) {
        sVar6 = (short)gNumSlices + sVar6;
      }
      Camera_gInfo[player].slicePos.slice = sVar6;
    }
    Camera_gInfo[player].position =
         *(coorddef *)BWorldSm_slices[Camera_gInfo[player].slicePos.slice].center;
    BWorldSm_FindClosestQuadRez(&Camera_gInfo[player].position,&Camera_gInfo[player].slicePos,1);
  }
  return;
}

/* ---- Camera_UpdateSplineCam__Fi  [@0x800826c0] ---- */
void Camera_UpdateSplineCam(int player)
{
  Car_tObj*anchor;
  coorddef cameraVel;
  int change;
  int sliceDist;
  int numSlice;
  int direction;
  coorddef splineVel;
  coorddef nextVel;
  int relativeVel;
  short sVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  int *piVar5;
  int *piVar6;
  int iVar7;
  short sVar8;
  int iVar9;
  coorddef *b;
  Camera_tInfo *pCVar10;
  BO_tNewtonObj *pBVar11;

  pBVar11 = Camera_gInfo[player].anchor;
  bVar2 = false;
  if ((simVar.quickPauseSim != 0) && (Replay_ReplayInterface.changeCamera == 0)) {
    return;
  }
  if (InBetween != 0) {
    return;
  }
  iVar9 = (int)(pBVar11->simRoadInfo).slice;
  iVar7 = (int)Camera_gInfo[player].slicePos.slice;
  iVar3 = iVar9 - iVar7;
  if (iVar3 < 1) {
    iVar3 = iVar7 - iVar9;
  }
  if (gNumSlices / 2 < iVar3) {
    iVar9 = (int)(pBVar11->simRoadInfo).slice;
    iVar3 = (int)Camera_gInfo[player].slicePos.slice;
    iVar7 = iVar9 - iVar3;
    if (iVar7 < 1) {
      iVar7 = gNumSlices - (iVar3 - iVar9);
    }
    else {
      iVar7 = gNumSlices - iVar7;
    }
  }
  else {
    iVar9 = (int)(pBVar11->simRoadInfo).slice;
    iVar3 = (int)Camera_gInfo[player].slicePos.slice;
    iVar7 = iVar9 - iVar3;
    if (iVar7 < 1) {
      iVar7 = iVar3 - iVar9;
    }
  }
  iVar3 = (0x10000 - camSpeedTable[(u_char)Camera_gInfo[player].splineMode]) * 0xf >> 0x10;
  if ((iVar3 + 2 < iVar7) && (camSpeedTable[(u_char)Camera_gInfo[player].splineMode] < 0x10000)) {
    bVar2 = true;
  }
  if ((bVar2) && (Replay_ReplayCamera[player].defaultCamera == 0)) {
    iVar3 = iVar3 + 1;
    iVar7 = 8;
    if (iVar3 < 9) {
      iVar7 = iVar3;
    }
    pCVar10 = Camera_gInfo + player;
    iVar3 = fixedmult(Camera_gInfo[player].rotation.m[6],(pCVar10->anchor->roadMatrix).m[6]);
    iVar9 = fixedmult(Camera_gInfo[player].rotation.m[7],(pCVar10->anchor->roadMatrix).m[7]);
    iVar4 = fixedmult(Camera_gInfo[player].rotation.m[8],(pCVar10->anchor->roadMatrix).m[8]);
    if (iVar3 + iVar9 + iVar4 < 0) {
      iVar7 = -iVar7;
    }
    if (pBVar11[1].shadowMat.m[7] < 0) {
      iVar7 = -iVar7;
    }
    if (iVar7 >= 0) {
      sVar1 = (pBVar11->simRoadInfo).slice;
      sVar8 = sVar1 + (short)iVar7;
      if (gNumSlices <= sVar1 + iVar7) {
        sVar8 = sVar8 - (short)gNumSlices;
      }
      Camera_gInfo[player].slicePos.slice = sVar8;
    }
    else {
      sVar1 = (pBVar11->simRoadInfo).slice;
      sVar8 = sVar1 + (short)iVar7;
      if (sVar1 + iVar7 < 0) {
        sVar8 = (short)gNumSlices + sVar8;
      }
      Camera_gInfo[player].slicePos.slice = sVar8;
    }
    Camera_gInfo[player].position =
         *(coorddef *)BWorldSm_slices[Camera_gInfo[player].slicePos.slice].center;
  }
  BWorldSm_FindClosestQuadRez(&Camera_gInfo[player].position,&Camera_gInfo[player].slicePos,1);
  piVar6 = (int *)((char *)BWorldSm_slices + Camera_gInfo[player].slicePos.slice * 0x20);
  numSlice = Camera_gInfo[player].slicePos.slice + 1;
  piVar5 = (int *)BWorldSm_slices;
  if (numSlice < gNumSlices) {
    piVar5 = (int *)((char *)BWorldSm_slices + numSlice * 0x20);
  }
  nextVel.x = *piVar5;
  nextVel.y = piVar5[1];
  nextVel.z = piVar5[2];
  splineVel.x = nextVel.x - *piVar6;
  splineVel.y = nextVel.y - piVar6[1];
  splineVel.z = nextVel.z - piVar6[2];
  Math_NormalizeVector(&splineVel);
  iVar3 = fixedmult((pBVar11->linearVel).x,splineVel.x);
  iVar7 = fixedmult((pBVar11->linearVel).y,splineVel.y);
  iVar9 = fixedmult((pBVar11->linearVel).z,splineVel.z);
  relativeVel = iVar3 + iVar7 + iVar9;
  if ((GameSetup_gData.sgge & 4U) != 0) {
    relativeVel = fixedmult(relativeVel,0xcccc);
  }
  change = fixedmult(relativeVel,camSpeedTable[(u_char)Camera_gInfo[player].splineMode]);
  cameraVel.x = fixedmult(change,splineVel.x);
  cameraVel.y = fixedmult(change,splineVel.y);
  cameraVel.z = fixedmult(change,splineVel.z);
  b = &Camera_gInfo[player].position;
  pBVar11 = Camera_gInfo[player].target;
  Camera_gInfo[player].position.x = Camera_gInfo[player].position.x + (cameraVel.x >> 6);
  Camera_gInfo[player].position.y = Camera_gInfo[player].position.y + (cameraVel.y >> 6);
  Camera_gInfo[player].position.z = Camera_gInfo[player].position.z + (cameraVel.z >> 6);
  iVar3 = Math_Dist3D(&pBVar11->position,b);
  if (iVar3 < 1) {
    iVar3 = Math_Dist3D(&(Camera_gInfo[player].target)->position,b);
    iVar3 = -iVar3;
  }
  else {
    iVar3 = Math_Dist3D(&(Camera_gInfo[player].target)->position,b);
  }
  SetCameraZoom(player,iVar3 >> 4);
  return;
}

/* ---- Camera_IslandProfile__FUs  [@0x80082c3c] ---- */
int Camera_IslandProfile(u_short before)
{
  u_short after;   /* SYM: REG after USHORT */
  u_short diff;    /* SYM: REG diff USHORT */

  /* MATCH: u_short locals + mutated param; masks (andi 0xFFFF) appear lazily at the compares
   * only; plain while -> gcc duplicate_loop_exit_test gives the top+bottom test pair */
  after = before & (before - 1);
  diff = before - after;
  while (before != 0) {
    if (before - after != diff) {
      return 1;
    }
    before = after;
    after = before & (before - 1);
    diff = diff << 1;
  }
  return 0;
}

/* ---- Camera_UpdatePulloverCam__Fi  [@0x80082c94] ---- */
void Camera_UpdatePulloverCam(int player)
{
  coorddef sCenter;   /* SYM: AUTO @0x10 */
  coorddef sForward;  /* SYM: AUTO @0x20 */
  coorddef sRight;    /* SYM: AUTO @0x30 */
  coorddef sccVec;    /* SYM: AUTO @0x40 */
  coorddef newarm;    /* SYM: AUTO @0x50 */
  int ySign;          /* SYM: REG */
  int iVar3;

  if (((simVar.quickPauseSim == 0) || (Replay_ReplayInterface.changeCamera != 0)) &&
     (InBetween == 0)) {
    SetGeomScreen(0xbe);
    if (simGlobal.gameTicks < Camera_gInfo[player].POInhibitor) {
      Camera_UpdateCopCam2(player);
      return;
    }
    /* MATCH: full slice expression REMATERIALIZED per access (no cached slice ptr) */
    sCenter = *(coorddef *)BWorldSm_slices[(Camera_gInfo[player].anchor)->simRoadInfo.slice].center;
    sForward.x = (signed char)BWorldSm_slices[(Camera_gInfo[player].anchor)->simRoadInfo.slice].forward[0] << 9;
    sForward.y = (signed char)BWorldSm_slices[(Camera_gInfo[player].anchor)->simRoadInfo.slice].forward[1] << 9;
    sForward.z = (signed char)BWorldSm_slices[(Camera_gInfo[player].anchor)->simRoadInfo.slice].forward[2] << 9;
    sccVec.x = (Camera_gInfo[player].anchor)->position.x - sCenter.x;
    sccVec.y = (Camera_gInfo[player].anchor)->position.y - sCenter.y;
    sccVec.z = (Camera_gInfo[player].anchor)->position.z - sCenter.z;
    sRight.x = (signed char)BWorldSm_slices[(Camera_gInfo[player].anchor)->simRoadInfo.slice].right[0] << 0xb;
    sRight.y = (signed char)BWorldSm_slices[(Camera_gInfo[player].anchor)->simRoadInfo.slice].right[1] << 0xb;
    sRight.z = (signed char)BWorldSm_slices[(Camera_gInfo[player].anchor)->simRoadInfo.slice].right[2] << 0xb;
    iVar3 = fixedmult(sccVec.z,sForward.x) - fixedmult(sccVec.x,sForward.z);
    ySign = Camera_IslandProfile(BWorldSm_slices[(Camera_gInfo[player].anchor)->simRoadInfo.slice].pavedProfile);
    if (iVar3 < 0) {
      ySign = ySign != 1;   /* MATCH: != 1 canonicalizes to xori + sltu (0/1 renormalize) */
    }
    if (ySign != 0) {
      sRight.x = -sRight.x;
      sRight.y = -sRight.y;
      sRight.z = -sRight.z;
    }
    newarm.y = 0x60000;
    Camera_TunnelLimit(player,&newarm.y);
    newarm.x = sCenter.x + sRight.x;
    newarm.y = newarm.y + (sCenter.y + sRight.y);
    newarm.z = sCenter.z + sRight.z;
    Camera_gInfo[player].position.x =
         Camera_gInfo[player].position.x + fixedmult(newarm.x - Camera_gInfo[player].position.x,0x7ae);
    Camera_gInfo[player].position.y =
         Camera_gInfo[player].position.y + fixedmult(newarm.y - Camera_gInfo[player].position.y,0x7ae);
    Camera_gInfo[player].position.z =
         Camera_gInfo[player].position.z + fixedmult(newarm.z - Camera_gInfo[player].position.z,0x7ae);
    /* MATCH: real bitfield assignments (m2c: (x & ~2 & ~4) | 0x78) */
    Camera_gInfo[player].pitch = 0;
    Camera_gInfo[player].jostling = 0;
    Camera_gInfo[player].tracking = 1;
    Camera_gInfo[player].checkwalls = 1;
    Camera_gInfo[player].noLookBack = 1;
    Camera_gInfo[player].checkcollisions = 1;
  }
  return;
}

/* ---- Camera_UpdateCopCam1__Fi  [@0x80083010] ---- */
void Camera_UpdateCopCam1(int player)
{
  coorddef vec;
  int iVar1;
  BO_tNewtonObj *pBVar5;

  vec.x = Camera_gInfo[player].anchor->position.x + Camera_gInfo[player].target->position.x;
  vec.y = Camera_gInfo[player].anchor->position.y + Camera_gInfo[player].target->position.y;
  vec.z = Camera_gInfo[player].anchor->position.z + Camera_gInfo[player].target->position.z;
  gCop1Target[player].x = vec.x >> 1;
  gCop1Target[player].y = vec.y >> 1;
  gCop1Target[player].z = vec.z >> 1;
  vec.x = Camera_gInfo[player].anchor->position.x - Camera_gInfo[player].target->position.x;
  vec.y = Camera_gInfo[player].anchor->position.y - Camera_gInfo[player].target->position.y;
  vec.z = Camera_gInfo[player].anchor->position.z - Camera_gInfo[player].target->position.z;
  Math_NormalizeVector(&vec);
  vec.x = fixedmult(0x40000,vec.x);
  vec.y = fixedmult(0x40000,vec.y);
  vec.z = fixedmult(0x40000,vec.z);   /* MATCH: result lives in vec.z (sw/lw 24(sp)), not a reg temp */
  Camera_gInfo[player].position.x = Camera_gInfo[player].anchor->position.x + vec.x + vec.z;
  Camera_gInfo[player].position.y = Camera_gInfo[player].anchor->position.y + 0x18000;
  Camera_gInfo[player].position.z = Camera_gInfo[player].anchor->position.z - vec.x + vec.z;
  return;
}

/* ---- Camera_UpdateCopCam2__Fi  [@0x800831a8] ---- */
void Camera_UpdateCopCam2(int player)
{
  coorddef local_18;
  int tx, ty, tz;

  tx = Camera_gInfo[player].target->position.x - Camera_gInfo[player].anchor->position.x;
  if (tx < 0) {
    tx = tx + 3;
  }
  local_18.x = tx >> 2;
  ty = Camera_gInfo[player].target->position.y - Camera_gInfo[player].anchor->position.y;
  if (ty < 0) {
    ty = ty + 3;
  }
  local_18.y = ty >> 2;
  tz = Camera_gInfo[player].target->position.z - Camera_gInfo[player].anchor->position.z;
  if (tz < 0) {
    tz = tz + 3;
  }
  local_18.z = tz >> 2;
  Math_NormalizeVector(&local_18);
  Camera_gInfo[player].position.x = Camera_gInfo[player].anchor->position.x + local_18.x * -2;
  Camera_gInfo[player].position.y = Camera_gInfo[player].anchor->position.y + 0x13333;
  Camera_gInfo[player].position.z = Camera_gInfo[player].anchor->position.z + local_18.z * -2;
  return;
}

/* ---- Camera_UpdateBTCopCam__Fi  [@0x800832b0] ---- */
void Camera_UpdateBTCopCam(int player)
{
  /* MATCH: real switch (binary-tree dispatch); focusOnAICar RE-READ per line (lb x2, no cache) */
  switch (Camera_gInfo[player].forceFocus) {
  case 0:
    break;   /* MATCH: empty case 0 shapes the slti-2 binary dispatch tree */
  case 2:   /* MATCH: case 2 body FIRST in VA order (bne falls through into it) */
    Camera_gInfo[player].anchor = &Cars_gList[player]->N;
    Camera_gInfo[player].target = &Cars_gList[(signed char)Camera_gInfo[player].focusOnAICar]->N;
    Camera_UpdateCopCam2(player);
    break;
  case 1:
    Camera_gInfo[player].anchor = &Cars_gList[(signed char)Camera_gInfo[player].focusOnAICar]->N;
    Camera_gInfo[player].target = &Cars_gList[(signed char)Camera_gInfo[player].focusOnAICar]->N;
    Camera_UpdateCircleCam(player);
    break;
  }
  Camera_gGeomScreen = 0xbe;
  Camera_gInfo[player].POInhibitor = simGlobal.gameTicks + 0x140;
  /* MATCH: real bitfield assignments; checkcollisions=0 LAST (m2c: (x&~2&~4|0x38)&~0x40) */
  Camera_gInfo[player].pitch = 0;
  Camera_gInfo[player].jostling = 0;
  Camera_gInfo[player].tracking = 1;
  Camera_gInfo[player].checkwalls = 1;
  Camera_gInfo[player].noLookBack = 1;
  Camera_gInfo[player].checkcollisions = 0;
  return;
}

/* ---- Camera_Update__Fv  [@0x800833d8] ---- */
void Camera_Update(void)
{
  Car_tObj*anchor;
  int direction;
  camera_flags*flagMode;
  short sVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  u_int uVar6;
  u_int uVar7;
  u_int uVar8;
  u_int uVar9;
  u_int uVar10;
  u_int uVar11;
  u_int uVar12;
  Camera_tInfo *pCVar13;
  int player;
  BO_tNewtonObj *pBVar14;
  int *piVar15;
  Car_tObj **ppCVar16;
  int iVar17;
  
  player = 0;
  pCVar13 = Camera_gInfo;
  iVar17 = 0;
  ppCVar16 = Cars_gHumanRaceCarList;
  piVar15 = Camera_gInfo[0].rotation.m + 6;
  do {
    if ((int)(u_int)((u_char)((u_char *)&(Camera_gInfo[0]))[116] >> 7) < player) {
      return;
    }
    pBVar14 = pCVar13->anchor;
    if ((*(u_int *)((char *)(pCVar13) + 0x74) >> 6 & 1) == 0) {
LAB_80083500:
      if (((pBVar14[1].simRoadInfo.quadPts[1].y & 1U) != 0) && (pBVar14[1].roadMatrix.m[3] == 2)) {
        Camera_UpdateFinishCam(player);
        goto LAB_80083584;
      }
      if (0 < (int)pCVar13->forceFocus) {
        Camera_UpdateBTCopCam(player);
        goto LAB_80083584;
      }
      if (((*ppCVar16)->pullOver != 0) && (((*ppCVar16)->stats).finishType != 3)) {
        Camera_UpdatePulloverCam(player);
        goto LAB_80083584;
      }
      if ((((char *)(pCVar13))[0x74] & 1) != 0) {
        sVar1 = pCVar13->mode;
        uVar12 = *(u_int *)((char *)(pCVar13) + 0x74);
        uVar6 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 1) << 1;
        *(u_int *)((char *)(pCVar13) + 0x74) = uVar12 & 0xfffffffd | uVar6;
        uVar7 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 2) << 1;
        *(u_int *)((char *)(pCVar13) + 0x74) = uVar12 & 0xfffffff9 | uVar6 | uVar7;
        uVar8 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 4) << 1;
        *(u_int *)((char *)(pCVar13) + 0x74) = uVar12 & 0xfffffff1 | uVar6 | uVar7 | uVar8;
        uVar9 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 8) << 1;
        *(u_int *)((char *)(pCVar13) + 0x74) = uVar12 & 0xffffffe1 | uVar6 | uVar7 | uVar8 | uVar9;
        uVar10 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 0x10) << 1;
        *(u_int *)((char *)(pCVar13) + 0x74) = uVar12 & 0xffffffc1 | uVar6 | uVar7 | uVar8 | uVar9 | uVar10
        ;
        uVar11 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 0x20) << 1;
        *(u_int *)((char *)(pCVar13) + 0x74) =
             uVar12 & 0xffffff81 | uVar6 | uVar7 | uVar8 | uVar9 | uVar10 | uVar11;
        *(u_int *)((char *)(pCVar13) + 0x74) =
             uVar12 & 0xf7ffff80 | uVar6 | uVar7 | uVar8 | uVar9 | uVar10 | uVar11 |
             (u_int)(pCVar13->mode < 2) << 0x1b;
        pCVar13->anchor = &(*ppCVar16)->N;
        bVar2 = 1 < Replay_ReplayMode;
        pCVar13->target = &(*ppCVar16)->N;
        if ((bVar2) && (*(int *)((int)&Replay_ReplayCamera[0].cameraMode + iVar17) == 0x13)) {
          Replay_ReplayFindClosestCamera(player,(int)(pCVar13->anchor->simRoadInfo).slice);
        }
      }
      switch(pCVar13->mode) {
      case 0:
      case 1:
        Camera_UpdateBumperCam(player);
        break;
      case 2:
        Camera_UpdateTailCam(player,0);
        break;
      case 3:
        Camera_UpdateTailCam(player,1);
        break;
      case 4:
        Camera_UpdateTailCam(player,2);
        break;
      case 5:
        Camera_UpdateHeliCam(player,0);
        break;
      case 6:
        Camera_UpdateHeliCam(player,1);
        break;
      case 7:
        Camera_UpdateHeliCam(player,2);
        break;
      case 8:
      case 9:
      case 0xf:
        Camera_UpdateSimpleCam(player);
        break;
      case 10:
        Camera_UpdateCircleCam(player);
        break;
      case 0xb:
        Camera_UpdateSplineCam(player);
        break;
      case 0xc:
        Camera_UpdateTVCam(player);
        break;
      case 0xd:
        Camera_UpdateBlimpCam(player);
        break;
      case 0xe:
        Camera_UpdateAnimCam(player);
        break;
      case 0x10:
        Camera_UpdateCopCam1(player);
        break;
      case 0x11:
      case 0x12:
        Camera_UpdateCopCam2(player);
      }
    }
    else {
      if (pCVar13->tumbling == '\0') {
        if ((pBVar14->orientationToGround).y < 0x8000) {
          iVar3 = fixedmult(*piVar15,(pBVar14->roadMatrix).m[6]);
          iVar4 = fixedmult(piVar15[1],(pCVar13->anchor->roadMatrix).m[7])
          ;
          iVar5 = fixedmult(piVar15[2],(pCVar13->anchor->roadMatrix).m[8])
          ;
          *(u_int *)((char *)(pCVar13) + 0x74) =
               *(u_int *)((char *)(pCVar13) + 0x74) & 0xfeffffff |
               (u_int)(iVar3 + iVar4 + iVar5 < 0) << 0x18;
          pCVar13->tumbling = 'd';
        }
        goto LAB_80083500;
      }
      pCVar13->tumbling = pCVar13->tumbling + -1;
      Camera_UpdateCollisionCam(player);
LAB_80083584:
      *(u_int *)((char *)(pCVar13) + 0x74) = *(u_int *)((char *)(pCVar13) + 0x74) & 0xf7ffffff | 1;
    }
    pCVar13 = pCVar13 + 1;
    iVar17 = iVar17 + 0x10;
    ppCVar16 = ppCVar16 + 1;
    piVar15 = piVar15 + 0x44;
    player = player + 1;
  } while( true );
}

/* ---- Camera_Init__Fv  [@0x80083858] ---- */
void Camera_Init(void)
{
  int splitScreen;
  BWorldSm_Pos slicePos;
  int localCar;
  int i;
  int type;
  BO_tNewtonObj *pBVar1;
  matrixtdef *pmVar2;
  int *piVar3;
  matrixtdef *pmVar4;
  BWorldSm_Pos *pBVar5;
  Camera_tInfo *pCVar6;
  int iVar7;
  u_int uVar8;
  int iVar9;
  int iVar10;
  int iVar11;
  int iVar12;
  int local_a0 [34];
  
  uVar8 = (u_int)(GameSetup_gData.commMode == 1);
  memset((u_char *)local_a0,'\0',0x84);
  iVar7 = 0;
  pCVar6 = Camera_gInfo;
  do {
    iVar9 = iVar7;
    if (uVar8 == 0) {
      iVar9 = GameSetup_gData.localCar;
    }
    pCVar6->anchor = &Cars_gHumanRaceCarList[iVar9]->N;
    pBVar1 = pCVar6->anchor;
    pCVar6->target = &Cars_gHumanRaceCarList[iVar9]->N;
    iVar9 = (pBVar1->position).y;
    iVar10 = (pBVar1->position).z;
    (pCVar6->position).x = (pBVar1->position).x;
    (pCVar6->position).y = iVar9;
    (pCVar6->position).z = iVar10;
    pBVar1 = pCVar6->anchor;
    iVar9 = (pBVar1->position).y;
    iVar10 = (pBVar1->position).z;
    (pCVar6->audioPos).x = (pBVar1->position).x;
    (pCVar6->audioPos).y = iVar9;
    (pCVar6->audioPos).z = iVar10;
    pBVar1 = pCVar6->anchor;
    pmVar4 = &pCVar6->rotation;
    pCVar6->TVHeight = 0;
    pmVar2 = &pBVar1->orientMat;
    do {
      iVar9 = pmVar2->m[1];
      iVar10 = pmVar2->m[2];
      iVar11 = pmVar2->m[3];
      pmVar4->m[0] = pmVar2->m[0];
      pmVar4->m[1] = iVar9;
      pmVar4->m[2] = iVar10;
      pmVar4->m[3] = iVar11;
      pmVar2 = (matrixtdef *)(pmVar2->m + 4);
      pmVar4 = (matrixtdef *)(pmVar4->m + 4);
    } while (pmVar2 != (matrixtdef *)((pBVar1->orientMat).m + 8));
    pmVar4->m[0] = pmVar2->m[0];
    pBVar1 = pCVar6->anchor;
    pCVar6->twist = 0;
    iVar9 = (pBVar1->position).y;
    iVar10 = (pBVar1->position).z;
    (pCVar6->wallLeft).x = (pBVar1->position).x;
    (pCVar6->wallLeft).y = iVar9;
    (pCVar6->wallLeft).z = iVar10;
    pBVar1 = pCVar6->anchor;
    iVar9 = (pBVar1->position).y;
    iVar10 = (pBVar1->position).z;
    (pCVar6->wallRight).x = (pBVar1->position).x;
    (pCVar6->wallRight).y = iVar9;
    (pCVar6->wallRight).z = iVar10;
    pCVar6->camNum = 0;
    pCVar6->circleCounter = 0;
    pCVar6->circleAngle = 0;
    *(u_int *)((char *)(pCVar6) + 0x74) = *(u_int *)((char *)(pCVar6) + 0x74) & 0xffffff20 | 0x20 | uVar8 << 7;
    pCVar6->intransition = '\0';
    pCVar6->tumbling = '\0';
    pCVar6->mode = 0xe;
    *(u_int *)((char *)(pCVar6) + 0x74) = *(u_int *)((char *)(pCVar6) + 0x74) & 0xf0ffffff;
    pCVar6->animNum = gAnimCams[GameSetup_gData.track][0];
    if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
       ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
        ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
      pCVar6->animNum = '\x01';
    }
    pBVar5 = &pCVar6->slicePos;
    piVar3 = local_a0;
    pCVar6->animHandle = -1;
    pCVar6->splineMode = '\0';
    pCVar6->forceFocus = 0;
    pCVar6->focusOnAICar = -1;
    pCVar6->POInhibitor = 0x40;
    do {
      iVar9 = *piVar3;
      iVar10 = piVar3[1];
      iVar11 = piVar3[2];
      iVar12 = piVar3[3];
      pBVar5->slice = (short)iVar9;
      pBVar5->stripQuadInd = (short)((u_int)iVar9 >> 0x10);
      *(int *)&pBVar5->simRotFlag = iVar10;
      pBVar5->quadPts[0].x = iVar11;
      pBVar5->quadPts[0].y = iVar12;
      piVar3 = piVar3 + 4;
      pBVar5 = (BWorldSm_Pos *)&pBVar5->quadPts[0].z;
    } while (piVar3 != local_a0 + 0x20);
    *(int *)pBVar5 = *piVar3;
    iVar7 = iVar7 + 1;
    pCVar6 = pCVar6 + 1;
  } while (iVar7 <= (int)uVar8);
  Camera_ResetRelPos(3);
  iVar7 = *(*(int **)((char *)Cars_gHumanRaceCarList[0] + 0x288));
  Camera_gGeomScreen = 0xbe;
  if (((iVar7 < 0x1c) && ((GameSetup_gData.sgge & 0x100U) != 0)) && (uVar8 == 0)) {
    GameSetup_gData.carInfo[0].Camera[0] = 1;
    Camera_gFlags[1].arm.x = gDriverCam[iVar7].x;
    Camera_gFlags[1].arm.y = gDriverCam[iVar7].y;
    Camera_gFlags[1].arm.z = gDriverCam[iVar7].z;
                    
                    
                    
  }
  return;
}

/* ---- Camera_Kill__Fv  [@0x80083bec] ---- */
void Camera_Kill(void)
{
  int i;            /* SYM: REG i INT */
  int splitScreen;  /* SYM: REG splitScreen INT */
  signed char none; /* compiler pseudo: shared -1 for compare + sb (li s3,-1 in preheader) */

  splitScreen = GameSetup_gData.commMode == 1;
  /* MATCH: index form (SYM has NO pointer local) — gcc strength-reduces to the s0+=0x110 walk
   * keeping animHandle's 0x7D displacement; a hand pointer-walk folds base+125 into the biv */
  for (i = 0; i <= splitScreen; i = i + 1) {
    none = -1;   /* MATCH: invariant -> hoisted to preheader; shared -1 reg for compare + sb */
    if ((signed char)Camera_gInfo[i].animHandle != none) {
      Anim_FreeHandle((int)(signed char)Camera_gInfo[i].animHandle);
    }
    Camera_gInfo[i].animHandle = none;
  }
  return;
}

/* ---- Camera_PitchAndRoll__Fi  [@0x80083c74] ---- */
void Camera_PitchAndRoll(int player)
{
  int iVar1;
  matrixtdef mStack_90;
  matrixtdef mStack_68;
  matrixtdef mStack_40;
  
  iVar1 = Camera_gInfo[player].anchor[3].objAltitude;
  iVar1 = iVar1 << 1;   /* MATCH: separate stmt -> sll lands in fixedxformz's jal delay slot */
  fixedxformz((int)&mStack_90,(int *)Camera_gInfo[player].anchor[3].collision.collided);
  fixedxformx((int)&mStack_68,
             (int *)(iVar1 | Camera_gInfo[player].pitch));
  Math_fasttransmult(&mStack_90,&mStack_68,&mStack_40);
  Math_fasttransmult(&mStack_40,&Camera_gInfo[player].rotation,&Camera_gInfo[player].rotation);
  return;
}

/* ---- Camera_TooSteep__FiP12BWorldSm_Pos  [@0x80083d28] ---- */
int Camera_TooSteep(int player,BWorldSm_Pos *slicePos)
{
  coorddef normUnderCam;    /* SYM: AUTO */
  coorddef normUnderCar;    /* SYM: AUTO */
  coorddef camToCar;        /* SYM: AUTO */
  BWorldSm_Pos *slicePos2;  /* SYM: REG (anchor+8, addiu s0,s0,8 in the 1st jal slot) */
  int d0;
  int d1;
  int d2;

  slicePos2 = &(Camera_gInfo[player].anchor)->simRoadInfo;
  normUnderCam = *(coorddef *)BWorldSm_UNormal(slicePos);
  normUnderCar = *(coorddef *)BWorldSm_UNormal(slicePos2);
  d0 = fixedmult(normUnderCam.x,normUnderCar.x);
  d1 = fixedmult(normUnderCam.y,normUnderCar.y);
  d2 = fixedmult(normUnderCam.z,normUnderCar.z);
  /* MATCH: dot accumulates IN-PLACE into the FIRST temp (s0), two separate += stmts */
  d0 = d0 + d1;
  d0 = d0 + d2;
  if (0xb4fc < d0) {
    return 0;   /* MATCH: direct returns - v0=0/1 staged in branch delay slots, no result var */
  }
  camToCar.x = Camera_gInfo[player].anchor->position.x - Camera_gInfo[player].position.x;
  camToCar.y = Camera_gInfo[player].anchor->position.y - Camera_gInfo[player].position.y;
  camToCar.z = Camera_gInfo[player].anchor->position.z - Camera_gInfo[player].position.z;
  d0 = fixedmult(normUnderCam.x,camToCar.x);
  d1 = fixedmult(normUnderCam.y,camToCar.y);
  d2 = fixedmult(normUnderCam.z,camToCar.z);
  d0 = d0 + d1;
  d0 = d0 + d2;
  if (0 < d0) {
    if ((Camera_gInfo[player].anchor)->flightTime == 0) {
      return 1;
    }
  }
  return 0;
}

/* ---- Camera_CheckWallCollisions__FiP8coorddef  [@0x80083e98] ---- */
void Camera_CheckWallCollisions(int player,coorddef *pos)
{
  BWorldSm_Pos slicePos;    /* SYM: AUTO @-0x118 */
  coorddef edge;            /* SYM: AUTO @-0x90 */
  coorddef normal;          /* SYM: AUTO @-0x80 (3 ints) */
  coorddef step;            /* SYM: AUTO @-0x70 */
  coorddef temp;            /* SYM: AUTO @-0x60 */
  coorddef quadUnderCamera; /* SYM: AUTO @-0x50 */
  coorddef triPnt;          /* SYM: AUTO @-0x40 */
  coorddef triVec;          /* SYM: AUTO @-0x30 */
  int sin;                  /* SYM: AUTO @-0x20 */
  int cos;                  /* SYM: AUTO @-0x1c */
  int camAngle;             /* SYM: REG */
  int camDotNorm;
  int edgeDotNorm;
  int count;
  int i;
  BO_tNewtonObj *pBVar4;
  int *piVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  Camera_tInfo *pCVar12;
  int iVar13;
  int iVar14;
  coorddef *pThis;
  
  /* MATCH: plain struct assignment -> gcc movstrsi copy (Ghidra hand-expanded it as a loop) */
  slicePos = Camera_gInfo[player].slicePos;
  iVar13 = 0;
  pCVar12 = Camera_gInfo + player;   /* MATCH: gInfo sum materialized BEFORE feeler3 base */
  pThis = feeler3;
  do {
    transform(pThis,(pCVar12->anchor->orientMat).m,
               &triVec.x);
    triPnt.x = pos->x + triVec.x;
    triPnt.y = pos->y + triVec.y;
    triPnt.z = pos->z + triVec.z;
    BWorldSm_FindClosestQuadMaxIterations(&triPnt,&slicePos,3);
    /* MATCH: simQuad!=0 arm FIRST (struct copies), surface check as a SEPARATE re-test if */
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      quadUnderCamera = slicePos.quadPts[0];
    }
    else {
      quadUnderCamera = *(coorddef *)BWorldSm_slices[slicePos.slice].center;
    }
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      if (((slicePos.simQuad)->surface & 0xf) == 0) break;
    }
    if ((((signed char)slicePos.offEdge != 0) ||
        (iVar14 = Camera_TooSteep(player,&slicePos), iVar14 != 0)) ||
       ((slicePos.simQuad != (Trk_NewSimQuad *)0x0 &&
        ((((slicePos.simQuad)->surface & 0x80) != 0 &&
         (0x38000 < quadUnderCamera.y - (pCVar12->anchor->position).y)))))) break;
    iVar13 = iVar13 + 1;
    pThis = pThis + 1;
    if (2 < iVar13) break;
  } while( true );
  if (iVar13 == 3) {
    return;
  }
  iVar13 = 0;
  edge = pCVar12->anchor->position;   /* MATCH: struct copy */
  step.x = (pCVar12->anchor->position).x - triPnt.x >> 7;
  step.z = (pCVar12->anchor->position).z - triPnt.z >> 7;
  step.y = (pCVar12->anchor->position).y - triPnt.y >> 7;
  do {
    edge.x = edge.x - step.x;
    edge.y = edge.y - step.y;
    edge.z = edge.z - step.z;
    BWorldSm_FindClosestQuadMaxIterations(&edge,&slicePos,3);
    /* MATCH: simQuad!=0 arm FIRST (struct copies), surface check as a SEPARATE re-test if */
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      quadUnderCamera = slicePos.quadPts[0];
    }
    else {
      quadUnderCamera = *(coorddef *)BWorldSm_slices[slicePos.slice].center;
    }
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      if (((slicePos.simQuad)->surface & 0xf) == 0) break;
    }
    if ((((signed char)slicePos.offEdge != 0) ||
        (iVar14 = Camera_TooSteep(player,&slicePos), iVar14 != 0)) ||
       (((slicePos.simQuad != (Trk_NewSimQuad *)0x0 &&
         ((((slicePos.simQuad)->surface & 0x80) != 0 &&
          (0x38000 < quadUnderCamera.y - (pCVar12->anchor->position).y)))) ||
        (iVar13 = iVar13 + 1, 0x7f < iVar13)))) break;
  } while( true );
  pCVar12 = Camera_gInfo + player;
  camAngle = 1;
  step.x = (pCVar12->anchor->position).x - edge.x >> 1;
  step.y = (pCVar12->anchor->position).y - edge.y >> 1;
  step.z = (pCVar12->anchor->position).z - edge.z >> 1;
  do {
    intsincos(camAngle,&sin,&cos);
    iVar13 = fixedmult(cos,step.x);
    temp.x = fixedmult(sin,step.z);
    temp.x = iVar13 - temp.x;
    temp.y = step.y;
    iVar13 = fixedmult(sin,step.x);
    iVar14 = fixedmult(cos,step.z);
    temp.x = edge.x + temp.x;
    temp.y = edge.y + temp.y;
    temp.z = edge.z + iVar13 + iVar14;
    BWorldSm_FindClosestQuadMaxIterations(&temp,&slicePos,3);
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      quadUnderCamera = slicePos.quadPts[0];
    }
    else {
      quadUnderCamera = *(coorddef *)BWorldSm_slices[slicePos.slice].center;
    }
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      if (((slicePos.simQuad)->surface & 0xf) == 0) {
LAB_80084464:
        Camera_gInfo[player].wallLeft = temp;
        break;
      }
    }
    if ((((signed char)slicePos.offEdge != 0) ||
        (iVar13 = Camera_TooSteep(player,&slicePos), iVar13 != 0)) ||
       ((slicePos.simQuad != (Trk_NewSimQuad *)0x0 &&
        ((((slicePos.simQuad)->surface & 0x80) != 0 &&
         (0x38000 < quadUnderCamera.y - (pCVar12->anchor->position).y)))))) goto LAB_80084464;
    camAngle = camAngle + 4;
  } while ((int)camAngle < 0x400);
  camAngle = 0xffffffff;
  do {
    intsincos(camAngle,&sin,&cos);
    iVar13 = fixedmult(cos,step.x);
    temp.x = fixedmult(sin,step.z);
    temp.x = iVar13 - temp.x;
    temp.y = step.y;
    iVar13 = fixedmult(sin,step.x);
    iVar14 = fixedmult(cos,step.z);
    temp.x = edge.x + temp.x;
    temp.y = edge.y + temp.y;
    temp.z = edge.z + iVar13 + iVar14;
    BWorldSm_FindClosestQuadMaxIterations(&temp,&slicePos,3);
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      quadUnderCamera = slicePos.quadPts[0];
    }
    else {
      quadUnderCamera = *(coorddef *)BWorldSm_slices[slicePos.slice].center;
    }
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      if (((slicePos.simQuad)->surface & 0xf) == 0) {
LAB_80084634:
        Camera_gInfo[player].wallRight = temp;
        break;
      }
    }
    if ((((signed char)slicePos.offEdge != 0) ||
        (iVar13 = Camera_TooSteep(player,&slicePos), iVar13 != 0)) ||
       ((slicePos.simQuad != (Trk_NewSimQuad *)0x0 &&
        ((((slicePos.simQuad)->surface & 0x80) != 0 &&
         (0x38000 < quadUnderCamera.y - ((Camera_gInfo[player].anchor)->position).y)))))) goto LAB_80084634;
    camAngle = camAngle - 4;
  } while (-0x400 < (int)camAngle);
  temp.x = Camera_gInfo[player].wallRight.x - Camera_gInfo[player].wallLeft.x;
  temp.y = (Camera_gInfo[player].wallRight.y - Camera_gInfo[player].wallLeft.y) + 0x8000;
  temp.z = Camera_gInfo[player].wallRight.z - Camera_gInfo[player].wallLeft.z;
  Math_NormalizeVector(&temp);
  edge.x = edge.x - triPnt.x;
  normal.z = temp.x;
  normal.x = -temp.z;
  normal.y = temp.y;
  edge.z = edge.z - triPnt.z;
  edge.y = edge.y - triPnt.y;
  iVar13 = fixedmult(edge.x,normal.x);
  iVar14 = fixedmult(edge.y,normal.y);
  iVar6 = fixedmult(edge.z,normal.z);
  iVar7 = fixedmult(triVec.x,normal.x);
  iVar8 = fixedmult(triVec.y,normal.y);
  iVar9 = fixedmult(triVec.z,normal.z);
  iVar13 = iVar13 + iVar14 + iVar6 + iVar7 + iVar8 + iVar9 + 0x10000;
  if (0 < iVar13) {
    temp.x = fixedmult(iVar13,normal.x);
    temp.y = fixedmult(iVar13,normal.y);
    iVar13 = fixedmult(iVar13,normal.z);
    pos->x = pos->x + temp.x;
    pos->y = pos->y + temp.y;
    pos->z = pos->z + iVar13;
  }
  return;
}

/* ---- Camera_SetAboveGround__FiP8coorddef  [@0x8008480c] ---- */
void Camera_SetAboveGround(int player,coorddef *pos)
{
  coorddef *pcVar1;
  int iVar2;
  coorddef local_20;

  pcVar1 = BWorldSm_UNormal(&Camera_gInfo[player].slicePos);
  local_20 = *pcVar1;
  iVar2 = Newton_FindGroundElevationGeneral(pos,&local_20,Camera_gInfo[player].slicePos.quadPts);
  if (pos->y < iVar2 + 0x10000) {
    pos->y = iVar2 + 0x10000;
  }
  return;
}

/* ---- Camera_AcquireTarget__FiP8coorddefT1P10matrixtdefi  [@0x80084898] ---- */
void Camera_AcquireTarget(int player,coorddef *point,coorddef *pos,matrixtdef *rot,int hirez)
{
  coorddef upvector = {0, 0x10000, 0};
  coorddef tgtPos;
  coorddef*rotx;
  coorddef*roty;
  coorddef*rotz;
  BO_tNewtonObj *pBVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int adj;
  int pitchAdj;
  int dot;

  rotx = (coorddef *)rot;
  roty = (coorddef *)(rot->m + 3);
  rotz = (coorddef *)(rot->m + 6);
  if (point != (coorddef *)0x0) {
    tgtPos = *point;
  }
  else {
    pBVar1 = Camera_gInfo[player].target;
    tgtPos = pBVar1->position;
  }
  adj = tgtPos.x - pos->x;
  if (adj < 0) {
    adj = adj + 3;
  }
  rotz->x = adj >> 2;
  adj = tgtPos.y - pos->y;
  if (adj < 0) {
    adj = adj + 3;
  }
  rotz->y = adj >> 2;
  adj = tgtPos.z - pos->z;
  if (adj < 0) {
    adj = adj + 3;
  }
  rotz->z = adj >> 2;
  if (Camera_gInfo[player].pitch != 0) {
    pitchAdj = rotz->y + 0x5333;
    if (2 < (u_int)((u_short)Camera_gInfo[player].mode - 2)) {
      pitchAdj = rotz->y + 0x6666;
    }
    rotz->y = pitchAdj;
  }
  if (Replay_ReplayMode == 2) {
    upvector.x = Camera_gInfo[player].twist;
  }
  Math_NormalizeVector(rotz);
  iVar2 = fixedmult(upvector.x,rotz->x);
  iVar3 = fixedmult(upvector.y,rotz->y);
  iVar4 = fixedmult(upvector.z,rotz->z);
  if (1 <= iVar2 + iVar3 + iVar4) {
    iVar3 = fixedmult(upvector.x,rotz->x);
    iVar4 = fixedmult(upvector.y,rotz->y);
    iVar2 = fixedmult(upvector.z,rotz->z);
    dot = iVar3 + iVar4 + iVar2;
  }
  else {
    iVar2 = fixedmult(upvector.x,rotz->x);
    iVar3 = fixedmult(upvector.y,rotz->y);
    iVar4 = fixedmult(upvector.z,rotz->z);
    dot = -(iVar2 + iVar3 + iVar4);
  }
  if (0xfd70 < dot) {
    upvector = *roty;
  }
  iVar2 = fixedmult(upvector.y,rotz->z);
  iVar3 = fixedmult(upvector.z,rotz->y);
  rotx->x = iVar2 - iVar3;
  iVar2 = fixedmult(upvector.z,rotz->x);
  iVar3 = fixedmult(upvector.x,rotz->z);
  rotx->y = iVar2 - iVar3;
  iVar2 = fixedmult(upvector.x,rotz->y);
  iVar3 = fixedmult(upvector.y,rotz->x);
  rotx->z = iVar2 - iVar3;
  Math_NormalizeVector(rotx);
  iVar2 = fixedmult(rotz->y,rotx->z);
  iVar3 = fixedmult(rotz->z,rotx->y);
  roty->x = iVar2 - iVar3;
  iVar2 = fixedmult(rotz->z,rotx->x);
  iVar3 = fixedmult(rotz->x,rotx->z);
  roty->y = iVar2 - iVar3;
  iVar2 = fixedmult(rotz->x,rotx->y);
  iVar3 = fixedmult(rotz->y,rotx->x);
  roty->z = iVar2 - iVar3;
  Math_NormalizeVector(roty);
  return;
}

/* ---- Camera_OpponentLookBehind__FiP8coorddefi  [@0x80084c34] ---- */
void Camera_OpponentLookBehind(int player,coorddef *pos,int reset)
{
  coorddef oppVector;
  coorddef tempVector;
  int oppAngle;
  int i;
  int dist;
  int oppSlice;
  static coorddef lastOppVector[2];
  Car_tObj *pCVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  Car_tObj **ppCVar5;
  int iVar6;
  coorddef *pcVar7;
  int pThis;
  int iVar8;
  Car_tObj **ppCVar9;
  int iVar10;
  coorddef local_48;
  coorddef local_38;
  
  iVar10 = 0xb;
  if (reset != 0) {
    pCVar1 = Cars_gHumanRaceCarList[player];
    iVar10 = (pCVar1->N).orientMat.m[7];
    iVar6 = (pCVar1->N).orientMat.m[8];
    lastOppVector[player].x = (pCVar1->N).orientMat.m[6];
    lastOppVector[player].y = iVar10;
    lastOppVector[player].z = iVar6;
    return;
  }
  ppCVar5 = Cars_gHumanRaceCarList + player;
  pCVar1 = *ppCVar5;
  local_48.x = (pCVar1->N).orientMat.m[6];
  local_48.y = (pCVar1->N).orientMat.m[7];
  local_48.z = (pCVar1->N).orientMat.m[8];
  iVar6 = 0;
  if (0 < Cars_gNumCars) {
    ppCVar9 = Cars_gList;
    do {
      pCVar1 = *ppCVar9;
      if (pCVar1 != *ppCVar5) {
        iVar8 = (int)(pCVar1->N).simRoadInfo.slice - (int)((*ppCVar5)->N).simRoadInfo.slice;
        if (iVar8 < 0) {
          iVar8 = -iVar8;
        }
        if (gNumSlices / 2 < iVar8) {
          iVar8 = gNumSlices - iVar8;
        }
        if (iVar8 < 0xb) {
          local_38.x = pos->x - (pCVar1->N).position.x;
          local_38.y = pos->y - ((*ppCVar9)->N).position.y;
          local_38.z = pos->z - ((*ppCVar9)->N).position.z;
          Math_NormalizeVector(&local_38);
          iVar2 = fixedmult(((*ppCVar5)->N).orientMat.m[6],local_38.x);
          iVar3 = fixedmult(((*ppCVar5)->N).orientMat.m[7],local_38.y);
          iVar4 = fixedmult(((*ppCVar5)->N).orientMat.m[8],local_38.z);
          pThis = (iVar2 + iVar3 + iVar4);
          iVar4 = intarccos(pThis);
          if (iVar4 < 1) {
            iVar4 = intarccos(pThis);
            iVar4 = -iVar4;
          }
          else {
            iVar4 = intarccos(pThis);
          }
          if ((iVar4 < 0x80) && (iVar8 < iVar10)) {
            local_48.x = local_38.x;
            local_48.y = local_38.y;
            local_48.z = local_38.z;
            iVar10 = iVar8;
          }
        }
      }
      iVar6 = iVar6 + 1;
      ppCVar9 = ppCVar9 + 1;
    } while (iVar6 < Cars_gNumCars);
  }
  pcVar7 = lastOppVector + player;
  iVar10 = fixedmult(local_48.x - pcVar7->x,0x4ccc);
  iVar6 = lastOppVector[player].y;
  pcVar7->x = pcVar7->x + iVar10;
  iVar10 = fixedmult(local_48.y - iVar6,0x4ccc);
  iVar6 = lastOppVector[player].z;
  lastOppVector[player].y = lastOppVector[player].y + iVar10;
  iVar10 = fixedmult(local_48.z - iVar6,0x4ccc);
  lastOppVector[player].z = lastOppVector[player].z + iVar10;
  local_48.x = pos->x - pcVar7->x;
  local_48.y = pos->y - lastOppVector[player].y;
  local_48.z = pos->z - lastOppVector[player].z;
  switch((int)(((u_short)Camera_gInfo[player].mode - 2) * 0x10000) >> 0x10) {
  case 0:
  case 1:
  case 2:
    iVar10 = -0x14ccc;
    break;
  case 5:
    local_48.y = local_48.y + -0x6666;
  case 3:
  case 4:
    iVar10 = -0x19999;
    break;
  default:
    goto switchD_80084f6c_default;
  }
  local_48.y = local_48.y + iVar10;
switchD_80084f6c_default:
  Camera_AcquireTarget(player,&local_48,pos,&Camera_gInfo[player].rotation,1);
  return;
}

/* ---- Camera_GetViewInfo__FiP17DRender_tCalcViewi  [@0x80085008] ---- */
void Camera_GetViewInfo(int cviewP,DRender_tCalcView *cview,int viewID)
{
  int t1;
  int t2;
  int t3;
  int scale;
  coorddef tmp;
  matrixtdef *pmVar1;
  matrixtdef *pmVar2;
  int iVar3;
  int iVar4;
  int iVar5;

  if (Camera_gInfo[cviewP].jostling != 0) {
    Camera_PitchAndRoll(cviewP);
  }
  iVar3 = Camera_gInfo[cviewP].position.y;
  iVar4 = Camera_gInfo[cviewP].position.z;
  (cview->translation).x = Camera_gInfo[cviewP].position.x;
  (cview->translation).y = iVar3;
  (cview->translation).z = iVar4;
  if (Camera_gInfo[cviewP].checkwalls != 0) {
    Camera_CheckWallCollisions(cviewP,&cview->translation);
  }
  BWorldSm_FindClosestQuadRez(&cview->translation,&Camera_gInfo[cviewP].slicePos,1);
  if ((Camera_gInfo[cviewP].slicePos.offEdge == '\0') && (1 < Camera_gInfo[cviewP].mode)) {
    Camera_SetAboveGround(cviewP,&cview->translation);
  }
  if (Camera_gInfo[cviewP].tracking != 0) {
    Camera_AcquireTarget(cviewP,(coorddef *)0x0,&cview->translation,&Camera_gInfo[cviewP].rotation,1);
  }
  if (Camera_gInfo[cviewP].mode == 0x10) {
    Camera_AcquireTarget(cviewP,gCop1Target + cviewP,&cview->translation,&Camera_gInfo[cviewP].rotation,1);
  }
  if (Camera_gInfo[cviewP].noLookBack == 0) {
    Camera_OpponentLookBehind(cviewP,&cview->translation,(u_int)(Input_gLookBehind[cviewP] == 0));
  }
  pmVar2 = &cview->mrotation;
  pmVar1 = &Camera_gInfo[cviewP].rotation;
  do {
    iVar3 = pmVar1->m[1];
    iVar4 = pmVar1->m[2];
    iVar5 = pmVar1->m[3];
    pmVar2->m[0] = pmVar1->m[0];
    pmVar2->m[1] = iVar3;
    pmVar2->m[2] = iVar4;
    pmVar2->m[3] = iVar5;
    pmVar1 = (matrixtdef *)(pmVar1->m + 4);
    pmVar2 = (matrixtdef *)(pmVar2->m + 4);
  } while (pmVar1 != (matrixtdef *)(Camera_gInfo[cviewP].rotation.m + 8));
  pmVar2->m[0] = pmVar1->m[0];
  if (GameSetup_gData.mirrorTrack != 0) {
    iVar4 = (cview->mrotation).m[2];
    (cview->mrotation).m[0] = -(cview->mrotation).m[0];
    iVar3 = (cview->mrotation).m[1];
    (cview->mrotation).m[2] = -iVar4;
    (cview->mrotation).m[1] = -iVar3;
  }
  pmVar2 = &cview->mrotationInv;
  transpose(&cview->mrotation,pmVar2);
  pmVar1 = &cview->mrotationInvRaw;
  do {
    iVar3 = pmVar2->m[1];
    iVar4 = pmVar2->m[2];
    iVar5 = pmVar2->m[3];
    pmVar1->m[0] = pmVar2->m[0];
    pmVar1->m[1] = iVar3;
    pmVar1->m[2] = iVar4;
    pmVar1->m[3] = iVar5;
    pmVar2 = (matrixtdef *)(pmVar2->m + 4);
    pmVar1 = (matrixtdef *)(pmVar1->m + 4);
  } while (pmVar2 != (matrixtdef *)((cview->mrotationInv).m + 8));
  pmVar1->m[0] = pmVar2->m[0];
  iVar3 = fixedmult((cview->mrotation).m[3],0xdc00);
  iVar4 = fixedmult((cview->mrotation).m[4],0xdc00);
  iVar5 = fixedmult((cview->mrotation).m[5],0xdc00);
  (cview->mrotation).m[3] = iVar3;
  (cview->mrotation).m[4] = iVar4;
  (cview->mrotation).m[5] = iVar5;
  transpose(&cview->mrotation,&cview->mrotationInv);
  tmp.x = -(cview->translation).x;
  tmp.y = -(cview->translation).y;
  tmp.z = -(cview->translation).z;
  transform(&tmp,(cview->mrotationInv).m,&cview->translationInv);
  return;
}

/* ---- Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef  [@0x8008533c] ---- */
void Camera_GetAudioViewInfo(int cviewP,DRender_tCalcView *cview,coorddef **cvel)
{
  matrixtdef *pmVar1;
  matrixtdef *pmVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  
  if (Input_gLookBehind[cviewP] == 0) {
    iVar3 = Camera_gInfo[cviewP].position.y;
    iVar4 = Camera_gInfo[cviewP].position.z;
    (cview->translation).x = Camera_gInfo[cviewP].position.x;
    (cview->translation).y = iVar3;
    (cview->translation).z = iVar4;
    pmVar2 = &cview->mrotation;
    pmVar1 = &Camera_gInfo[cviewP].rotation;
    do {
      iVar3 = pmVar1->m[1];
      iVar4 = pmVar1->m[2];
      iVar5 = pmVar1->m[3];
      pmVar2->m[0] = pmVar1->m[0];
      pmVar2->m[1] = iVar3;
      pmVar2->m[2] = iVar4;
      pmVar2->m[3] = iVar5;
      pmVar1 = (matrixtdef *)(pmVar1->m + 4);
      pmVar2 = (matrixtdef *)(pmVar2->m + 4);
    } while (pmVar1 != (matrixtdef *)(Camera_gInfo[cviewP].rotation.m + 8));
    pmVar2->m[0] = pmVar1->m[0];
  }
  else {
    pmVar1 = &Camera_gInfo[cviewP].rotation;
    if (Camera_gInfo[cviewP].noLookBack == 0) {
      if (Camera_gInfo[cviewP].tracking == 0) {
        iVar3 = Camera_gInfo[cviewP].audioPos.y;
        iVar4 = Camera_gInfo[cviewP].audioPos.z;
        (cview->translation).x = Camera_gInfo[cviewP].audioPos.x;
        (cview->translation).y = iVar3;
        (cview->translation).z = iVar4;
        Camera_LookBack(&Camera_gInfo[cviewP].rotation,&cview->mrotation);
      }
      else {
        iVar3 = Camera_gInfo[cviewP].audioPos.y;
        iVar4 = Camera_gInfo[cviewP].audioPos.z;
        (cview->translation).x = Camera_gInfo[cviewP].audioPos.x;
        (cview->translation).y = iVar3;
        (cview->translation).z = iVar4;
        Camera_AcquireTarget(cviewP,(coorddef *)0x0,&cview->translation,&cview->mrotation,0);
      }
    }
    else {
      iVar3 = Camera_gInfo[cviewP].position.y;
      iVar4 = Camera_gInfo[cviewP].position.z;
      (cview->translation).x = Camera_gInfo[cviewP].position.x;
      (cview->translation).y = iVar3;
      (cview->translation).z = iVar4;
      pmVar2 = &cview->mrotation;
      do {
        iVar3 = pmVar1->m[1];
        iVar4 = pmVar1->m[2];
        iVar5 = pmVar1->m[3];
        pmVar2->m[0] = pmVar1->m[0];
        pmVar2->m[1] = iVar3;
        pmVar2->m[2] = iVar4;
        pmVar2->m[3] = iVar5;
        pmVar1 = (matrixtdef *)(pmVar1->m + 4);
        pmVar2 = (matrixtdef *)(pmVar2->m + 4);
      } while (pmVar1 != (matrixtdef *)(Camera_gInfo[cviewP].rotation.m + 8));
      pmVar2->m[0] = pmVar1->m[0];
    }
  }
  switch(Camera_gInfo[cviewP].mode) {
  default:
    *cvel = &(Camera_gInfo[cviewP].anchor)->linearVel;
    break;
  case 0xc:
  case 0xe:
    *cvel = (coorddef *)0x0;
  }
  return;
}

/* ---- Camera_GetMode__Fi  [@0x80085568] ---- */
int Camera_GetMode(int cviewP)
{
  if (((Cars_gHumanRaceCarList[cviewP]->carFlags & 1U) != 0) &&
      ((Cars_gHumanRaceCarList[cviewP]->stats).finishType == 2)) {
    return 0x14;
  }
  if ((Cars_gHumanRaceCarList[cviewP]->pullOver != 0) &&
      ((Cars_gHumanRaceCarList[cviewP]->stats).finishType != 3)) {
    return 0x14;
  }
  return (int)Camera_gInfo[cviewP].mode;
}

/* ---- Camera_SetMode__Fii  [@0x80085608] ---- */
void Camera_SetMode(int cviewP,int mode)
{
  camera_flags*flagMode;
  short sVar1;

  InBetween = 0;
  if (Camera_gInfo[cviewP].modechange == 0) {
    if ((u_int)((u_short)Camera_gInfo[cviewP].mode - 0xb) < 2) {
      Camera_gGeomScreen = 0xbe;
      TrsProj_SetProjection(0,0,0x140,0xf0);
    }
    if (5 < (u_int)((u_short)Camera_gInfo[cviewP].mode - 2)) {
      Camera_ResetRelPos(cviewP + 1);
    }
    if (-1 < (signed char)Camera_gInfo[cviewP].animHandle) {
      Anim_FreeHandle((signed char)Camera_gInfo[cviewP].animHandle);
      Camera_gInfo[cviewP].animHandle = -1;
    }
    Camera_gInfo[cviewP].mode = (short)mode;
    if (0x13 < (short)mode) {
      Camera_gInfo[cviewP].mode = (short)GameSetup_gData.carInfo[cviewP].Camera[0];
    }
    if (Camera_gInfo[cviewP].mode == 0xb) {
      Camera_SetSplineCam(cviewP);
    }
    Camera_gInfo[cviewP].intransition = '2';
    sVar1 = Camera_gInfo[cviewP].mode;
    flagMode = &Camera_gFlags[sVar1];
    Camera_gInfo[cviewP].pitch = flagMode->pitch;
    Camera_gInfo[cviewP].jostling = flagMode->jostling;
    Camera_gInfo[cviewP].tracking = flagMode->tracking;
    Camera_gInfo[cviewP].checkwalls = flagMode->checkwalls;
    Camera_gInfo[cviewP].noLookBack = flagMode->noLookBack;
    Camera_gInfo[cviewP].checkcollisions = flagMode->checkcollisions;
    sVar1 = Camera_gInfo[cviewP].mode;
    Camera_gInfo[cviewP].inCar = sVar1 < 2;
  }
  return;
}

/* ---- Camera_NextMode__Fi  [@0x8008581c] ---- */
void Camera_NextMode(int cviewP)
{
  camera_flags*flagMode;
  short sVar1;
  u_int uVar2;

  if ((Camera_gInfo[cviewP].mode != 0xe) && (Camera_gInfo[cviewP].modechange == 0)) {
    if ((u_int)((u_short)Camera_gInfo[cviewP].mode - 0xb) < 2) {
      Camera_gGeomScreen = 0xbe;
      TrsProj_SetProjection(0,0,0x140,0xf0);
    }
    if (5 < (u_int)((u_short)Camera_gInfo[cviewP].mode - 2)) {
      Camera_ResetRelPos(cviewP + 1);
    }
    if (-1 < (signed char)Camera_gInfo[cviewP].animHandle) {
      Anim_FreeHandle((signed char)Camera_gInfo[cviewP].animHandle);
      Camera_gInfo[cviewP].animHandle = -1;
    }
    if (Camera_gInfo[cviewP].splitscreen != 0) {
      sVar1 = Camera_gInfo[cviewP].camNum + 1;
      Camera_gInfo[cviewP].camNum = sVar1;
      Camera_gInfo[cviewP].mode =
           *(short *)((int)gSplitCameras + (((int)sVar1 % 3) * 0x10000 >> 0xe));
    }
    else if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
            ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
             ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
      uVar2 = (u_short)Camera_gInfo[cviewP].camNum + 1;
      Camera_gInfo[cviewP].camNum = (short)uVar2;
      Camera_gInfo[cviewP].mode = (short)GameSetup_gData.carInfo[cviewP].Camera[uVar2 & 3];
    }
    else {
      sVar1 = Camera_gInfo[cviewP].camNum + 1;
      Camera_gInfo[cviewP].camNum = sVar1;
      Camera_gInfo[cviewP].mode =
           *(short *)((int)GameSetup_gData.carInfo[cviewP].Camera +
                     (((int)sVar1 % 3) * 0x10000 >> 0xe));
    }
    if (0x13 < Camera_gInfo[cviewP].mode) {
      Camera_gInfo[cviewP].mode = (short)GameSetup_gData.carInfo[cviewP].Camera[0];
    }
    if (Camera_gInfo[cviewP].mode == 0xb) {
      Camera_SetSplineCam(cviewP);
    }
    Camera_gInfo[cviewP].intransition = '2';
    sVar1 = Camera_gInfo[cviewP].mode;
    flagMode = &Camera_gFlags[sVar1];
    Camera_gInfo[cviewP].pitch = flagMode->pitch;
    Camera_gInfo[cviewP].jostling = flagMode->jostling;
    Camera_gInfo[cviewP].tracking = flagMode->tracking;
    Camera_gInfo[cviewP].checkwalls = flagMode->checkwalls;
    Camera_gInfo[cviewP].noLookBack = flagMode->noLookBack;
    Camera_gInfo[cviewP].checkcollisions = flagMode->checkcollisions;
    sVar1 = Camera_gInfo[cviewP].mode;
    Camera_gInfo[cviewP].inCar = sVar1 < 2;
  }
  return;
}

/* ---- Camera_ReplayUpdate__FiP15Camera_tCamSlot  [@0x80085bd0] ---- */
void Camera_ReplayUpdate(int cviewP,Camera_tCamSlot *ptr)
{
  if (Camera_gInfo[cviewP].modechange == 0) {
    Camera_SetMode(cviewP,(u_int)(u_char)ptr->mode);
    Camera_gInfo[cviewP].tracking = ptr->track;
    Camera_gInfo[cviewP].zooming = ptr->zoom;
    Camera_gInfo[cviewP].splineMode = ptr->splineMode;
    Camera_gGeomScreen = ptr->fov /* @0x75CAC disasm-v2: signed `lh` short load; short->int sign-extends natively (Ghidra SEXT24 spurious) */;
    Camera_gInfo[cviewP].position = ptr->pos;
    Camera_gInfo[cviewP].TVHeight = ptr->height;
    EulerToMat(&Camera_gInfo[cviewP].rotation,(int)(ptr->euler).x,(int)(ptr->euler).y,
               (int)(ptr->euler).z);
  }
  return;
}

/* ---- Camera_ResetRelPos__Fi  [@0x80085cd4] ---- */
void Camera_ResetRelPos(int bitMask)
{
  if ((bitMask & 1U) != 0) {
    Camera_gInfo[0].relpos.x = ((Camera_gInfo[0].anchor)->orientMat).m[6] * -4;
    Camera_gInfo[0].relpos.y = ((Camera_gInfo[0].anchor)->orientMat).m[7] * -4;
    Camera_gInfo[0].relpos.z = ((Camera_gInfo[0].anchor)->orientMat).m[8] * -4;
  }
  if ((bitMask & 2U) != 0) {
    Camera_gInfo[1].relpos.x = ((Camera_gInfo[1].anchor)->orientMat).m[6] * -4;
    Camera_gInfo[1].relpos.y = ((Camera_gInfo[1].anchor)->orientMat).m[7] * -4;
    Camera_gInfo[1].relpos.z = ((Camera_gInfo[1].anchor)->orientMat).m[8] * -4;
  }
  return;
}
