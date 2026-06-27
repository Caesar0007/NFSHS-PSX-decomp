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
long Camera_gGeomScreen[2] = {190, 0};  /* @0x8013c7dc SYM size0 degraded; [2] per next-sym frontLimit@+8 */   /* @0x8013c7dc */
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
  matrixtdef mStack_b8;
  matrixtdef mStack_90;
  matrixtdef mStack_68;
  matrixtdef local_40;
  
  fixedxformx((int)&mStack_b8,(int *)ax);
  fixedxformy((int)&mStack_90,(int *)ay);
  fixedxformz((int)&mStack_68,(int *)az);
  Math_fasttransmult(&mStack_68,&mStack_90,&local_40);
  Math_fasttransmult(&local_40,&mStack_b8,m);
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
  BWorldSm_Pos*slicePos;
  coorddef quadnormal;
  coorddef underCam;
  int roadheight;
  int track;
  int maxheight;
  bool bVar1;
  void *pvVar2;
  coorddef *pcVar3;
  int iVar4;
  int iVar5;
  coorddef local_38;
  coorddef local_28;
  
  bVar1 = false;
  pvVar2 = BWorldSm_TunnelFlagSm(&Camera_gInfo[player].slicePos);
  if ((pvVar2 != (void *)0x0) ||
     (pvVar2 = BWorldSm_TunnelFlagSm(&(Camera_gInfo[player].anchor)->simRoadInfo), pvVar2 != (void *)0x0)) {
    bVar1 = true;
  }
  if (bVar1) {
    pcVar3 = BWorldSm_UNormal(&Camera_gInfo[player].slicePos);
    local_38.x = pcVar3->x;
    local_38.y = pcVar3->y;
    local_38.z = pcVar3->z;
    local_28.x = Camera_gInfo[player].position.x;
    local_28.y = Camera_gInfo[player].position.y;
    local_28.z = Camera_gInfo[player].position.z;
    iVar4 = Newton_FindGroundElevationGeneral(&local_28,&local_38,Camera_gInfo[player].slicePos.quadPts);
    iVar5 = GameSetup_gData.track;
    if (0xf < GameSetup_gData.track) {
      iVar5 = GameSetup_gData.track + -7;
    }
    iVar4 = (gTunnelCamHeight[iVar5] - ((Camera_gInfo[player].anchor)->position).y) + iVar4;
    if (iVar4 < *armheight) {
      *armheight = iVar4;
    }
  }
  return;
}

/* ---- Camera_UpdateCollisionCam__Fi  [@0x8008090c] ---- */
void Camera_UpdateCollisionCam(int player)
{
  coorddef arm;
  coorddef newarm;
  coorddef oldarm;
  char cVar1;
  int iVar2;
  BO_tNewtonObj *pBVar3;
  u_int local_40;
  u_int local_3c;
  u_int local_38;
  int local_30;
  int local_2c;
  int local_28;
  int local_20;
  int local_1c;
  int local_18;
  
  local_40 = 0;
  local_3c = 0x30000;
  local_38 = 0xfff60000;
  if (((simVar.quickPauseSim == 0) || (Replay_ReplayInterface.changeCamera != 0)) &&
     (InBetween == 0)) {
    if ((((char *)&(Camera_gInfo[player]))[0x77] & 1) != 0) {
      local_38 = 0xa0000;
    }
    transform(&local_40,((Camera_gInfo[player].anchor)->roadMatrix).m,
               &local_30);
    Camera_TunnelLimit(player,&local_2c);
    local_20 = Camera_gInfo[player].relpos.x;
    local_1c = Camera_gInfo[player].relpos.y;
    local_18 = Camera_gInfo[player].relpos.z;
    iVar2 = fixedmult(local_30 - local_20,0x51e);
    Camera_gInfo[player].relpos.x = local_20 + iVar2;
    iVar2 = fixedmult(local_2c - local_1c,0x51e);
    Camera_gInfo[player].relpos.y = local_1c + iVar2;
    iVar2 = fixedmult(local_28 - local_18,0x51e);
    pBVar3 = Camera_gInfo[player].anchor;
    Camera_gInfo[player].relpos.z = local_18 + iVar2;
    Camera_gInfo[player].position.x = (pBVar3->position).x + Camera_gInfo[player].relpos.x;
    Camera_gInfo[player].position.y = (pBVar3->position).y + Camera_gInfo[player].relpos.y;
    cVar1 = Camera_gInfo[player].tumbling;
    Camera_gInfo[player].position.z = (pBVar3->position).z + Camera_gInfo[player].relpos.z;
    if (cVar1 == '\0') {
      Camera_gInfo[player].intransition = '2';
    }
    *(u_int *)((char *)&(Camera_gInfo[player]) + 0x74) =
         *(u_int *)((char *)&(Camera_gInfo[player]) + 0x74) & 0xfffffffb | 0x7a;
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
  Camera_tInfo *pCVar3;
  int local_38;
  int local_34;
  int local_30;
  int local_28;
  int local_24;
  int local_20;
  
  pCVar3 = Camera_gInfo + player;
  sVar1 = Camera_gInfo[player].mode;
  local_38 = Camera_gFlags[sVar1].arm.x;
  local_34 = Camera_gFlags[sVar1].arm.y;
  local_30 = Camera_gFlags[sVar1].arm.z;
  transform(&local_38,(pCVar3->anchor->orientMat).m,&local_28);
  Camera_TunnelLimit(player,&local_24);
  pBVar2 = pCVar3->anchor;
  Camera_gInfo[player].position.x = (pCVar3->anchor->position).x + local_28;
  Camera_gInfo[player].position.y = (pBVar2->position).y + local_24;
  Camera_gInfo[player].position.z = (pBVar2->position).z + local_20;
  Camera_LookBack(&pBVar2->orientMat,&Camera_gInfo[player].rotation);
  return;
}

/* ---- Camera_UpdateBumperCam__Fi  [@0x80080bac] ---- */
void Camera_UpdateBumperCam(int player)
{
  coorddef arm;
  coorddef newarm;
  int lookingBehind;
  short sVar1;
  bool bVar2;
  matrixtdef *pmVar3;
  BO_tNewtonObj *pBVar4;
  matrixtdef *pmVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  Camera_tInfo *pCVar9;
  int local_38;
  int local_34;
  int local_30;
  int local_28;
  int local_24;
  int local_20;
  
  bVar2 = false;
  pCVar9 = Camera_gInfo + player;
  sVar1 = Camera_gInfo[player].mode;
  local_38 = Camera_gFlags[sVar1].arm.x;
  local_34 = Camera_gFlags[sVar1].arm.y;
  local_30 = Camera_gFlags[sVar1].arm.z;
  if (Camera_gInfo[player].noLookBack == 0) {
    bVar2 = Input_gLookBehind[player] != 0;
  }
  if (bVar2) {
    transform(&local_38,(pCVar9->anchor->orientMat).m,&local_28);
    pBVar4 = pCVar9->anchor;
    Camera_gInfo[player].audioPos.x = (pCVar9->anchor->position).x + local_28;
    Camera_gInfo[player].audioPos.y = (pBVar4->position).y + local_24;
    Camera_gInfo[player].audioPos.z = (pBVar4->position).z + local_20;
    local_30 = -local_30;
  }
  transform(&local_38,(pCVar9->anchor->orientMat).m,&local_28);
  pBVar4 = pCVar9->anchor;
  Camera_gInfo[player].position.x = (pCVar9->anchor->position).x + local_28;
  Camera_gInfo[player].position.y = (pBVar4->position).y + local_24;
  Camera_gInfo[player].position.z = (pBVar4->position).z + local_20;
  if (bVar2) {
    Camera_LookBack(&pBVar4->orientMat,&Camera_gInfo[player].rotation);
  }
  else {
    pBVar4 = pCVar9->anchor;
    pmVar5 = &Camera_gInfo[player].rotation;
    pmVar3 = &pBVar4->orientMat;
    do {
      iVar6 = pmVar3->m[1];
      iVar7 = pmVar3->m[2];
      iVar8 = pmVar3->m[3];
      pmVar5->m[0] = pmVar3->m[0];
      pmVar5->m[1] = iVar6;
      pmVar5->m[2] = iVar7;
      pmVar5->m[3] = iVar8;
      pmVar3 = (matrixtdef *)(pmVar3->m + 4);
      pmVar5 = (matrixtdef *)(pmVar5->m + 4);
    } while (pmVar3 != (matrixtdef *)((pBVar4->orientMat).m + 8));
    pmVar5->m[0] = pmVar3->m[0];
  }
  return;
}

/* ---- Camera_UpdateTailCam__Fii  [@0x80080d84] ---- */
void Camera_UpdateTailCam(int player,int behavior)
{
  coorddef arm;
  coorddef newarm;
  coorddef oldarm;
  Car_tObj*anchor;
  int maxrate;
  int rate;
  int rateY;
  int vertigo;
  int slice;
  int lookahead;
  int len;
  int scale;
  char cVar1;
  short sVar2;
  bool bVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  BO_tNewtonObj *pBVar7;
  int iVar8;
  int iVar9;
  Camera_tInfo *pCVar10;
  int iVar11;
  int local_50;
  int local_4c;
  int local_48;
  int local_40;
  int local_3c;
  int local_38;
  int local_30;
  int local_2c;
  int local_28;
  
  iVar8 = 0x1999;
  sVar2 = Camera_gInfo[player].mode;
  local_50 = Camera_gFlags[sVar2].arm.x;
  local_4c = Camera_gFlags[sVar2].arm.y;
  local_48 = Camera_gFlags[sVar2].arm.z;
  pBVar7 = Camera_gInfo[player].anchor;
  iVar11 = 0xccc;
  if ((int)pBVar7[1].collision.lastOtherObj < 1) {
    iVar9 = 3;
    if (GameSetup_gData.reverseTrack == 0) {
      iVar9 = -3;
    }
  }
  else {
    iVar9 = 3;
    if (GameSetup_gData.reverseTrack == 1) {
      iVar9 = -3;
    }
  }
  if ((simVar.quickPauseSim != 0) && (Replay_ReplayInterface.changeCamera == 0)) {
    return;
  }
  if (InBetween != 0) {
    return;
  }
  if (behavior == 1) {
    iVar8 = 0x1999;
  }
  else if ((1 < behavior) && (behavior == 2)) {
    iVar8 = 0xccc;
  }
  iVar6 = 0x1999;
  if (behavior != 0) {
    iVar4 = pBVar7[1].shadowMat.m[5];
    iVar6 = pBVar7[1].shadowMat.m[7];
    if (iVar4 < 0) {
      iVar4 = -iVar4;
    }
    if (iVar6 < 0) {
      iVar6 = -iVar6;
    }
    if (iVar6 < iVar4) {
      iVar4 = iVar4 + (iVar6 >> 2);
    }
    else {
      iVar4 = iVar6 + (iVar4 >> 2);
    }
    iVar4 = iVar4 / 900;
    iVar5 = iVar4;
    if (iVar8 < iVar4) {
      iVar5 = iVar8;
    }
    iVar6 = 0x51e;
    if ((0x51d < iVar5) && (iVar6 = iVar4, iVar8 < iVar4)) {
      iVar6 = iVar8;
    }
  }
  if (Input_gLookBehind[player] != 0) {
    transform(&local_50,((Camera_gInfo[player].anchor)->orientMat).m,
               &Camera_gInfo[player].relpos.x);
  }
  iVar8 = (int)((Camera_gInfo[player].anchor)->simRoadInfo).slice;
  if (iVar9 < 0) {
    iVar8 = iVar8 + iVar9;
    if (iVar8 < 0) {
      iVar8 = iVar8 + gNumSlices;
    }
  }
  else {
    iVar8 = iVar8 + iVar9;
    if (gNumSlices <= iVar8) {
      iVar8 = iVar8 - gNumSlices;
    }
  }
  if (iVar9 < 1) {
    iVar9 = iVar8 - iVar9;
    iVar4 = iVar9 * 0x20;
    if (gNumSlices <= iVar9) {
      iVar9 = iVar9 - gNumSlices;
LAB_80081050:
      iVar4 = iVar9 << 5;
    }
  }
  else {
    iVar9 = iVar8 - iVar9;
    iVar4 = iVar9 * 0x20;
    if (iVar9 < 0) {
      iVar9 = iVar9 + gNumSlices;
      goto LAB_80081050;
    }
  }
  iVar8 = (*(int *)(iVar8 * 0x20 + BWorldSm_slices + 4) - *(int *)(BWorldSm_slices + iVar4 + 4)) / 3
  ;
  iVar9 = iVar8;
  if (behavior == 1) {
    bVar3 = 0x10000 < iVar8;
    iVar4 = iVar8;
    if (bVar3) {
      iVar4 = 0x10000;
    }
    iVar9 = 0x4000;
    if (iVar4 < 0x4000) goto LAB_8008110c;
    iVar9 = 0x10000;
  }
  else {
    if (behavior < 2) {
      if (behavior == 0) {
        iVar9 = 0;
      }
      goto LAB_8008110c;
    }
    if (behavior != 2) goto LAB_8008110c;
    bVar3 = 0x20000 < iVar8;
    iVar4 = iVar8;
    if (bVar3) {
      iVar4 = 0x20000;
    }
    iVar9 = -0x4000;
    if (iVar4 < -0x4000) goto LAB_8008110c;
    iVar9 = 0x20000;
  }
  if (!bVar3) {
    iVar9 = iVar8;
  }
LAB_8008110c:
  local_4c = local_4c + iVar9;
  if (Input_gLookBehind[player] == 0) {
    transform(&local_50,((Camera_gInfo[player].anchor)->orientMat).m,
               &local_40);
    Camera_TunnelLimit(player,&local_3c);
    local_30 = Camera_gInfo[player].relpos.x;
    local_2c = Camera_gInfo[player].relpos.y;
    local_28 = Camera_gInfo[player].relpos.z;
    if (Camera_gInfo[player].intransition != '\0') {
      Camera_gInfo[player].intransition = Camera_gInfo[player].intransition + -1;
      iVar11 = 0x1999;
      iVar6 = 0x1999;
    }
    iVar8 = fixedmult(local_40 - local_30,iVar6);
    Camera_gInfo[player].relpos.x = local_30 + iVar8;
    iVar8 = fixedmult(local_3c - local_2c,iVar11);
    Camera_gInfo[player].relpos.y = local_2c + iVar8;
    iVar8 = fixedmult(local_38 - local_28,iVar6);
    cVar1 = Camera_gInfo[player].intransition;
    Camera_gInfo[player].relpos.z = local_28 + iVar8;
    if ((cVar1 == '\0') &&
       (iVar8 = Math_VectorLength(&Camera_gInfo[player].relpos), iVar8 < 0x4f0a3)) {
      iVar8 = fixeddiv(0x4f0a3,iVar8);
      iVar11 = fixedmult(iVar8,Camera_gInfo[player].relpos.x);
      iVar9 = Camera_gInfo[player].relpos.y;
      Camera_gInfo[player].relpos.x = iVar11;
      iVar11 = fixedmult(iVar8,iVar9);
      iVar9 = Camera_gInfo[player].relpos.z;
      Camera_gInfo[player].relpos.y = iVar11;
      iVar8 = fixedmult(iVar8,iVar9);
      Camera_gInfo[player].relpos.z = iVar8;
    }
    pBVar7 = Camera_gInfo[player].anchor;
    Camera_gInfo[player].position.x =
         ((Camera_gInfo[player].anchor)->position).x + Camera_gInfo[player].relpos.x;
    Camera_gInfo[player].position.y = (pBVar7->position).y + Camera_gInfo[player].relpos.y;
    Camera_gInfo[player].position.z = (pBVar7->position).z + Camera_gInfo[player].relpos.z;
  }
  else {
    pCVar10 = Camera_gInfo + player;
    transform(&local_50,(pCVar10->anchor->orientMat).m,&local_40);
    pBVar7 = pCVar10->anchor;
    Camera_gInfo[player].audioPos.x = (pCVar10->anchor->position).x + local_40;
    Camera_gInfo[player].audioPos.y = (pBVar7->position).y + local_3c;
    Camera_gInfo[player].audioPos.z = (pBVar7->position).z + local_38;
    local_48 = -local_48;
    transform(&local_50,(pCVar10->anchor->orientMat).m,&local_40);
    Camera_TunnelLimit(player,&local_3c);
    pBVar7 = pCVar10->anchor;
    Camera_gInfo[player].position.x = (pCVar10->anchor->position).x + local_40;
    Camera_gInfo[player].position.y = (pBVar7->position).y + local_3c;
    Camera_gInfo[player].position.z = (pBVar7->position).z + local_38;
  }
  return;
}

/* ---- Camera_UpdateHeliCam__Fii  [@0x800813cc] ---- */
void Camera_UpdateHeliCam(int player,int behavior)
{
  coorddef arm;
  coorddef newarm;
  coorddef oldarm;
  Car_tObj*anchor;
  int fallback;
  int maxrate;
  int rate;
  int rateY;
  int vertigo;
  int slice;
  int lookahead;
  int len;
  int scale;
  char cVar1;
  short sVar2;
  bool bVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  Camera_tInfo *pCVar8;
  int iVar9;
  BO_tNewtonObj *pBVar10;
  int iVar11;
  int local_50;
  int local_4c;
  int local_48;
  int local_40;
  int local_3c;
  int local_38;
  int local_30;
  int local_2c;
  int local_28;
  
  iVar7 = 0x1999;
  sVar2 = Camera_gInfo[player].mode;
  local_50 = Camera_gFlags[sVar2].arm.x;
  local_4c = Camera_gFlags[sVar2].arm.y;
  local_48 = Camera_gFlags[sVar2].arm.z;
  pBVar10 = Camera_gInfo[player].anchor;
  iVar11 = 0xccc;
  if ((int)pBVar10[1].collision.lastOtherObj < 1) {
    iVar9 = 3;
    if (GameSetup_gData.reverseTrack == 0) {
      iVar9 = -3;
    }
  }
  else {
    iVar9 = 3;
    if (GameSetup_gData.reverseTrack == 1) {
      iVar9 = -3;
    }
  }
  if ((simVar.quickPauseSim != 0) && (Replay_ReplayInterface.changeCamera == 0)) {
    return;
  }
  if (InBetween != 0) {
    return;
  }
  if (behavior == 1) {
    iVar7 = 0x1999;
  }
  else if ((1 < behavior) && (behavior == 2)) {
    iVar7 = 0xccc;
  }
  iVar6 = 0x1999;
  if (behavior != 0) {
    iVar4 = pBVar10[1].shadowMat.m[5];
    iVar6 = pBVar10[1].shadowMat.m[7];
    if (iVar4 < 0) {
      iVar4 = -iVar4;
    }
    if (iVar6 < 0) {
      iVar6 = -iVar6;
    }
    if (iVar6 < iVar4) {
      iVar4 = iVar4 + (iVar6 >> 2);
    }
    else {
      iVar4 = iVar6 + (iVar4 >> 2);
    }
    iVar4 = iVar4 / 900;
    iVar5 = iVar4;
    if (iVar7 < iVar4) {
      iVar5 = iVar7;
    }
    iVar6 = 0x51e;
    if ((0x51d < iVar5) && (iVar6 = iVar4, iVar7 < iVar4)) {
      iVar6 = iVar7;
    }
  }
  if (1 < Replay_ReplayMode) {
    iVar6 = 0x28f;
  }
  if (Input_gLookBehind[player] != 0) {
    transform(&local_50,((Camera_gInfo[player].anchor)->orientMat).m,
               &Camera_gInfo[player].relpos.x);
  }
  iVar7 = pBVar10[1].shadowMat.m[5];
  iVar4 = pBVar10[1].shadowMat.m[7];
  if (iVar7 < 0) {
    iVar7 = -iVar7;
  }
  if (iVar4 < 0) {
    iVar4 = -iVar4;
  }
  if (iVar4 < iVar7) {
    iVar7 = iVar7 + (iVar4 >> 2);
  }
  else {
    iVar7 = iVar4 + (iVar7 >> 2);
  }
  iVar7 = iVar7 / 0x14;
  if (0x20000 < iVar7) {
    iVar7 = 0x20000;
  }
  local_48 = local_48 - iVar7;
  iVar7 = (int)((Camera_gInfo[player].anchor)->simRoadInfo).slice;
  if (iVar9 < 0) {
    iVar7 = iVar7 + iVar9;
    if (iVar7 < 0) {
      iVar7 = iVar7 + gNumSlices;
    }
  }
  else {
    iVar7 = iVar7 + iVar9;
    if (gNumSlices <= iVar7) {
      iVar7 = iVar7 - gNumSlices;
    }
  }
  if (iVar9 < 1) {
    iVar9 = iVar7 - iVar9;
    iVar4 = iVar9 * 0x20;
    if (gNumSlices <= iVar9) {
      iVar9 = iVar9 - gNumSlices;
LAB_80081724:
      iVar4 = iVar9 << 5;
    }
  }
  else {
    iVar9 = iVar7 - iVar9;
    iVar4 = iVar9 * 0x20;
    if (iVar9 < 0) {
      iVar9 = iVar9 + gNumSlices;
      goto LAB_80081724;
    }
  }
  iVar9 = (*(int *)(iVar7 * 0x20 + BWorldSm_slices + 4) - *(int *)(BWorldSm_slices + iVar4 + 4)) / 2
  ;
  iVar7 = iVar9;
  if (behavior == 1) {
    bVar3 = 0x14000 < iVar9;
    if (bVar3) {
      iVar7 = 0x14000;
    }
    if (iVar7 < 0x4000) {
      iVar7 = 0x4000;
      goto LAB_800817f8;
    }
    iVar7 = 0x14000;
  }
  else {
    if (behavior < 2) {
      if (behavior == 0) {
        iVar7 = 0;
      }
      goto LAB_800817f8;
    }
    if (behavior != 2) goto LAB_800817f8;
    bVar3 = 0x30000 < iVar9;
    if (bVar3) {
      iVar7 = 0x30000;
    }
    if (iVar7 < -0xc000) {
      iVar7 = -0xc000;
      goto LAB_800817f8;
    }
    iVar7 = 0x30000;
  }
  if (!bVar3) {
    iVar7 = iVar9;
  }
LAB_800817f8:
  local_4c = local_4c + iVar7;
  if (Input_gLookBehind[player] == 0) {
    transform(&local_50,((Camera_gInfo[player].anchor)->orientMat).m,
               &local_40);
    Camera_TunnelLimit(player,&local_3c);
    local_30 = Camera_gInfo[player].relpos.x;
    local_2c = Camera_gInfo[player].relpos.y;
    local_28 = Camera_gInfo[player].relpos.z;
    if (Camera_gInfo[player].intransition != '\0') {
      Camera_gInfo[player].intransition = Camera_gInfo[player].intransition + -1;
      iVar11 = 0x1999;
      iVar6 = 0x1999;
    }
    iVar7 = fixedmult(local_40 - local_30,iVar6);
    Camera_gInfo[player].relpos.x = local_30 + iVar7;
    iVar7 = fixedmult(local_3c - local_2c,iVar11);
    Camera_gInfo[player].relpos.y = local_2c + iVar7;
    iVar7 = fixedmult(local_38 - local_28,iVar6);
    cVar1 = Camera_gInfo[player].intransition;
    Camera_gInfo[player].relpos.z = local_28 + iVar7;
    if ((cVar1 == '\0') &&
       (iVar7 = Math_VectorLength(&Camera_gInfo[player].relpos), iVar7 < 0x651eb)) {
      iVar7 = fixeddiv(0x651eb,iVar7);
      iVar11 = fixedmult(iVar7,Camera_gInfo[player].relpos.x);
      iVar9 = Camera_gInfo[player].relpos.y;
      Camera_gInfo[player].relpos.x = iVar11;
      iVar11 = fixedmult(iVar7,iVar9);
      iVar9 = Camera_gInfo[player].relpos.z;
      Camera_gInfo[player].relpos.y = iVar11;
      iVar7 = fixedmult(iVar7,iVar9);
      Camera_gInfo[player].relpos.z = iVar7;
    }
    pBVar10 = Camera_gInfo[player].anchor;
    Camera_gInfo[player].position.x =
         ((Camera_gInfo[player].anchor)->position).x + Camera_gInfo[player].relpos.x;
    Camera_gInfo[player].position.y = (pBVar10->position).y + Camera_gInfo[player].relpos.y;
    Camera_gInfo[player].position.z = (pBVar10->position).z + Camera_gInfo[player].relpos.z;
  }
  else {
    pCVar8 = Camera_gInfo + player;
    transform(&local_50,(pCVar8->anchor->orientMat).m,&local_40);
    pBVar10 = pCVar8->anchor;
    Camera_gInfo[player].audioPos.x = (pCVar8->anchor->position).x + local_40;
    Camera_gInfo[player].audioPos.y = (pBVar10->position).y + local_3c;
    Camera_gInfo[player].audioPos.z = (pBVar10->position).z + local_38;
    local_48 = -local_48;
    transform(&local_50,(pCVar8->anchor->orientMat).m,&local_40);
    Camera_TunnelLimit(player,&local_3c);
    pBVar10 = pCVar8->anchor;
    Camera_gInfo[player].position.x = (pCVar8->anchor->position).x + local_40;
    Camera_gInfo[player].position.y = (pBVar10->position).y + local_3c;
    Camera_gInfo[player].position.z = (pBVar10->position).z + local_38;
  }
  return;
}

/* ---- Camera_UpdateCircleCam__Fi  [@0x80081ab8] ---- */
void Camera_UpdateCircleCam(int player)
{
  coorddef src;
  coorddef des;
  int sin;
  int cos;
  int circle_height[3];
  int h0;
  int h1;
  int ang;
  short sVar1;
  BO_tNewtonObj *pBVar2;
  u_int uVar3;
  Camera_tInfo *pCVar4;
  int local_48;
  int local_44;
  int local_40;
  int local_38;
  int local_34;
  int local_30;
  int local_28 [4];
  int local_18;
  int local_14;
  
  local_28[0] = 0x10000;
  local_28[1] = 0x20000;
  local_28[2] = 0x30000;
  if ((((simVar.quickPauseSim == 0) || (Replay_ReplayInterface.changeCamera != 0)) &&
      (InBetween == 0)) && (simVar.pauseSim == 0)) {
    sVar1 = Camera_gInfo[player].circleAngle + 1;
    Camera_gInfo[player].circleAngle = sVar1;
    intsincos((int)sVar1,&local_18,&local_14);
    local_48 = fixedmult(0x48000,local_14);
    local_40 = fixedmult(0x60000,local_18);
    if (((int)Camera_gInfo[player].circleAngle + 0x100U & 0x1ff) == 0) {
      Camera_gInfo[player].circleCounter = Camera_gInfo[player].circleCounter + 1;
    }
    uVar3 = (int)Camera_gInfo[player].circleAngle - 0x80;
    if ((uVar3 & 0x1ff) < 0x80) {
      local_44 = *(int *)((int)local_28 +
                         (((int)Camera_gInfo[player].circleCounter % 3) * 0x10000 >> 0xe));
      local_44 = ((int)((local_28[(Camera_gInfo[player].circleCounter + 1) % 3] - local_44) *
                       (uVar3 & 0x7f)) >> 7) + local_44;
    }
    else {
      local_44 = *(int *)((int)local_28 +
                         (((int)Camera_gInfo[player].circleCounter % 3) * 0x10000 >> 0xe));
    }
    pCVar4 = Camera_gInfo + player;
    transform(&local_48,(pCVar4->anchor->orientMat).m,&local_38);
    Camera_TunnelLimit(player,&local_34);
    pBVar2 = pCVar4->anchor;
    Camera_gInfo[player].position.x = (pCVar4->anchor->position).x + local_38;
    Camera_gInfo[player].position.y = (pBVar2->position).y + local_34;
    Camera_gInfo[player].position.z = (pBVar2->position).z + local_30;
  }
  return;
}

/* ---- SetCameraZoom__Fii  [@0x80081d38] ---- */
void SetCameraZoom(int player,int targetDist)
{
  u_int uVar1;
  
  if (Camera_gInfo[player].splitscreen == 0) {
    if (0x3000 < targetDist) {
      uVar1 = Camera_gInfo[player].zooming;
      if (uVar1 == 1) {
        (*(int *)&(Camera_gGeomScreen)) = (targetDist * 0xbe) / 0x3000;
      }
      else if (((uVar1 == 2) &&
               ((*(int *)&(Camera_gGeomScreen)) = (targetDist * 0xbe) / 0x3000,
               0x4b0 < (int)(*(int *)&(Camera_gGeomScreen)))) &&
              ((*(int *)&(Camera_gGeomScreen)) = 6000 - (*(int *)&(Camera_gGeomScreen)) >> 2,
              (int)(*(int *)&(Camera_gGeomScreen)) < 0x2ee)) {
        Camera_gGeomScreen[0] = 0x2ee;
        Camera_gGeomScreen[1] = 0;
      }
    }
  }
  else {
    Camera_gGeomScreen[0] = 0xbe;
    Camera_gGeomScreen[1] = 0;
  }
  SetGeomScreen((*(int *)&(Camera_gGeomScreen)));
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
  coorddef *b;

  b = &Camera_gInfo[player].position;
  iVar1 = Math_Dist3D(&(Camera_gInfo[player].target)->position,b);
  if (iVar1 < 1) {
    iVar1 = Math_Dist3D(&(Camera_gInfo[player].target)->position,b);
    iVar1 = -iVar1;
  }
  else {
    iVar1 = Math_Dist3D(&(Camera_gInfo[player].target)->position,b);
  }
  iVar2 = Camera_gInfo[player].position.x;
  /* @0x80081EC4-F14: TWO distinct fn-statics indexed by player*4 -- lastX[2]@0x8013DD88 and
   * lastY[2]@0x8013DD90 (8 bytes apart). The reconstruction routed every access through one
   * Ghidra-ism `*(int*)("" + iVar3)` placeholder, collapsing lastY into lastX (H43). */
  if (lastX[player] != iVar2) {
    lastX[player] = iVar2;
    lastY[player] = Camera_gInfo[player].position.y;
  }
  iVar2 = fixedmult(Camera_gInfo[player].TVHeight >> 2,(iVar1 >> 4) + -0x4000);
  if (Camera_gInfo[player].TVHeight < iVar2) {
    iVar2 = Camera_gInfo[player].TVHeight;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  Camera_gInfo[player].position.y = lastY[player] + iVar2;   /* @0x80081F64 read lastY[player] */
  SetCameraZoom(player,iVar1 >> 4);
  return;
}

/* ---- Camera_UpdateAnimCam__Fi  [@0x80081f94] ---- */
void Camera_UpdateAnimCam(int player)
{
  coorddef animPos;
  coorddef newarm;
  matrixtdef animRot;
  char cVar1;
  int iVar2;
  AnimScript *pAVar3;
  matrixtdef *pmVar4;
  int *piVar5;
  BO_tNewtonObj *pBVar6;
  int iVar7;
  int iVar8;
  Camera_tInfo *pCVar9;
  coorddef local_58;
  int local_48;
  int local_44;
  int local_40;
  matrixtdef local_38;
  
  if (Camera_gInfo[player].animHandle == -1) {
    cVar1 = Camera_gInfo[player].animNum;
    Camera_gInfo[player].animNum = cVar1 + -1;
    iVar2 = Anim_Handle((u_int)(u_char)gAnimCams[GameSetup_gData.track][cVar1]);
    Camera_gInfo[player].animHandle = (char)iVar2;
  }
  pAVar3 = Anim_GetAnim((int)Camera_gInfo[player].animHandle);
  iVar2 = pAVar3->GetTimedAnimPosRot(&local_58,&local_38);
  if (iVar2 < 1) {
    if (Camera_gInfo[player].animNum < '\x01') {
      if (Replay_ReplayMode != 2) {
        Camera_SetMode(player,GameSetup_gData.carInfo[player].Camera[0]);
        return;
      }
      if (numValidCams != 0) {
        Replay_ReplayFindClosestCamera(player,(int)((Camera_gInfo[player].anchor)->simRoadInfo).slice);
        return;
      }
      Camera_SetMode(player,0xb);
      Camera_gInfo[player].splineMode = '\x03';
      return;
    }
    Anim_FreeHandle((int)Camera_gInfo[player].animHandle);
    cVar1 = Camera_gInfo[player].animNum;
    Camera_gInfo[player].animNum = cVar1 + -1;
    iVar2 = Anim_Handle((u_int)(u_char)gAnimCams[GameSetup_gData.track][cVar1]);
    Camera_gInfo[player].animHandle = (char)iVar2;
    pAVar3 = Anim_GetAnim((int)(char)iVar2);
    pAVar3->GetTimedAnimPosRot(&local_58,&local_38);
  }
  pCVar9 = Camera_gInfo + player;
  pmVar4 = &Camera_gInfo[player].rotation;
  if (((int)(u_int)(u_char)"\x02"[GameSetup_gData.track] >> ((int)Camera_gInfo[player].animNum & 0x1fU)
      & 1U) == 0) {
    transform(&local_58,(pCVar9->anchor->orientMat).m,&local_48);
    pBVar6 = pCVar9->anchor;
    Camera_gInfo[player].position.x = (pCVar9->anchor->position).x + local_48;
    Camera_gInfo[player].position.y = (pBVar6->position).y + local_44;
    Camera_gInfo[player].position.z = (pBVar6->position).z + local_40;
    Math_fasttransmult(&local_38,&pBVar6->orientMat,&Camera_gInfo[player].rotation);
  }
  else {
    Camera_gInfo[player].position.x = local_58.x;
    Camera_gInfo[player].position.y = local_58.y;
    Camera_gInfo[player].position.z = local_58.z;
    piVar5 = local_38.m;
    do {
      iVar2 = piVar5[1];
      iVar7 = piVar5[2];
      iVar8 = piVar5[3];
      pmVar4->m[0] = *piVar5;
      pmVar4->m[1] = iVar2;
      pmVar4->m[2] = iVar7;
      pmVar4->m[3] = iVar8;
      piVar5 = piVar5 + 4;
      pmVar4 = (matrixtdef *)(pmVar4->m + 4);
    } while (piVar5 != local_38.m + 8);
    pmVar4->m[0] = *piVar5;
  }
  return;
}

/* ---- Camera_UpdateFinishCam__Fi  [@0x80082254] ---- */
void Camera_UpdateFinishCam(int player)
{
  coorddef finishPos;
  coorddef newarm;
  matrixtdef finishRot;
  int iVar1;
  AnimScript *pThis;
  BO_tNewtonObj *pBVar2;
  Camera_tInfo *pCVar3;
  coorddef cStack_60;
  int local_50;
  int local_4c;
  int local_48;
  matrixtdef mStack_40;
  
  pCVar3 = Camera_gInfo + player;
  if (Camera_gInfo[player].animHandle == -1) {
    iVar1 = Anim_Handle(1);
    Camera_gInfo[player].animHandle = (char)iVar1;
  }
  pThis = Anim_GetAnim((int)Camera_gInfo[player].animHandle);
  iVar1 = pThis->GetTimedAnimPosRot(&cStack_60,&mStack_40);
  if (iVar1 < 1) {
    Anim_GetLastAnimPosRot(1,6,&cStack_60,&mStack_40);
  }
  transform(&cStack_60,(pCVar3->anchor->orientMat).m,&local_50);
  pBVar2 = pCVar3->anchor;
  Camera_gInfo[player].position.x = (pCVar3->anchor->position).x + local_50;
  Camera_gInfo[player].position.y = (pBVar2->position).y + local_4c;
  Camera_gInfo[player].position.z = (pBVar2->position).z + local_48;
  Math_fasttransmult(&mStack_40,&pBVar2->orientMat,&Camera_gInfo[player].rotation);
  *(u_int *)((char *)&(Camera_gInfo[player]) + 0x74) =
       *(u_int *)((char *)&(Camera_gInfo[player]) + 0x74) & 0xfffffff1 | 0x70;
  return;
}

/* ---- Camera_UpdateBlimpCam__Fi  [@0x8008237c] ---- */
void Camera_UpdateBlimpCam(int player)
{
  coorddef arm;
  coorddef oldarm;
  short sVar1;
  BO_tNewtonObj *pBVar2;
  int iVar3;
  Camera_tInfo *pCVar4;
  int local_24;
  int local_20;
  int local_18;
  int local_14;
  int local_10;
  
  pCVar4 = Camera_gInfo + player;
  sVar1 = Camera_gInfo[player].mode;
  iVar3 = Camera_gFlags[sVar1].arm.x;
  local_24 = Camera_gFlags[sVar1].arm.y;
  local_20 = Camera_gFlags[sVar1].arm.z;
  Camera_TunnelLimit(player,&local_24);
  local_18 = Camera_gInfo[player].position.x - (pCVar4->anchor->position).x;
  local_14 = Camera_gInfo[player].position.y - (pCVar4->anchor->position).y;
  local_10 = Camera_gInfo[player].position.z - (pCVar4->anchor->position).z;
  iVar3 = fixedmult(iVar3 - local_18,0x1999);
  local_18 = local_18 + iVar3;
  iVar3 = fixedmult(local_24 - local_14,0x1999);
  local_14 = local_14 + iVar3;
  iVar3 = fixedmult(local_20 - local_10,0x1999);
  pBVar2 = pCVar4->anchor;
  Camera_gInfo[player].position.x = (pCVar4->anchor->position).x + local_18;
  Camera_gInfo[player].position.y = (pBVar2->position).y + local_14;
  Camera_gInfo[player].position.z = (pBVar2->position).z + local_10 + iVar3;
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
    if (iVar7 < 0) {
      sVar1 = (pBVar8->simRoadInfo).slice;
      sVar6 = sVar1 + (short)iVar7;
      if (sVar1 + iVar7 < 0) {
        sVar6 = (short)gNumSlices + sVar6;
      }
      Camera_gInfo[player].slicePos.slice = sVar6;
    }
    else {
      sVar1 = (pBVar8->simRoadInfo).slice;
      sVar6 = sVar1 + (short)iVar7;
      if (gNumSlices <= sVar1 + iVar7) {
        sVar6 = sVar6 - (short)gNumSlices;
      }
      Camera_gInfo[player].slicePos.slice = sVar6;
    }
    piVar4 = (int *)(Camera_gInfo[player].slicePos.slice * 0x20 + BWorldSm_slices);
    iVar7 = piVar4[1];
    iVar5 = piVar4[2];
    Camera_gInfo[player].position.x = *piVar4;
    Camera_gInfo[player].position.y = iVar7;
    Camera_gInfo[player].position.z = iVar5;
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
  coorddef local_40;
  int local_30;
  int local_2c;
  int local_28;
  
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
    if (iVar7 < 0) {
      sVar1 = (pBVar11->simRoadInfo).slice;
      sVar8 = sVar1 + (short)iVar7;
      if (sVar1 + iVar7 < 0) {
        sVar8 = (short)gNumSlices + sVar8;
      }
      Camera_gInfo[player].slicePos.slice = sVar8;
    }
    else {
      sVar1 = (pBVar11->simRoadInfo).slice;
      sVar8 = sVar1 + (short)iVar7;
      if (gNumSlices <= sVar1 + iVar7) {
        sVar8 = sVar8 - (short)gNumSlices;
      }
      Camera_gInfo[player].slicePos.slice = sVar8;
    }
    piVar5 = (int *)(Camera_gInfo[player].slicePos.slice * 0x20 + BWorldSm_slices);
    iVar3 = piVar5[1];
    iVar7 = piVar5[2];
    Camera_gInfo[player].position.x = *piVar5;
    Camera_gInfo[player].position.y = iVar3;
    Camera_gInfo[player].position.z = iVar7;
  }
  BWorldSm_FindClosestQuadRez(&Camera_gInfo[player].position,&Camera_gInfo[player].slicePos,1);
  piVar6 = (int *)(Camera_gInfo[player].slicePos.slice * 0x20 + BWorldSm_slices);
  iVar3 = Camera_gInfo[player].slicePos.slice + 1;
  piVar5 = (int *)BWorldSm_slices;
  if (iVar3 < gNumSlices) {
    piVar5 = (int *)(BWorldSm_slices + iVar3 * 0x20);
  }
  local_30 = *piVar5;
  local_2c = piVar5[1];
  local_28 = piVar5[2];
  local_40.x = local_30 - *piVar6;
  local_40.y = local_2c - piVar6[1];
  local_40.z = local_28 - piVar6[2];
  Math_NormalizeVector(&local_40);
  iVar3 = fixedmult((pBVar11->linearVel).x,local_40.x);
  iVar7 = fixedmult((pBVar11->linearVel).y,local_40.y);
  iVar9 = fixedmult((pBVar11->linearVel).z,local_40.z);
  iVar9 = iVar3 + iVar7 + iVar9;
  if ((GameSetup_gData.sgge & 4U) != 0) {
    iVar9 = fixedmult(iVar9,0xcccc);
  }
  iVar3 = fixedmult(iVar9,camSpeedTable[(u_char)Camera_gInfo[player].splineMode]);
  iVar7 = fixedmult(iVar3,local_40.x);
  iVar9 = fixedmult(iVar3,local_40.y);
  iVar3 = fixedmult(iVar3,local_40.z);
  b = &Camera_gInfo[player].position;
  pBVar11 = Camera_gInfo[player].target;
  Camera_gInfo[player].position.x = Camera_gInfo[player].position.x + (iVar7 >> 6);
  Camera_gInfo[player].position.y = Camera_gInfo[player].position.y + (iVar9 >> 6);
  Camera_gInfo[player].position.z = Camera_gInfo[player].position.z + (iVar3 >> 6);
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
  u_short after;
  u_short diff;
  bool bVar1;
  u_int uVar2;
  u_int uVar3;
  u_int uVar4;
  
  uVar4 = (u_int)before;
  uVar2 = uVar4 & uVar4 - 1;
  uVar4 = uVar4 - uVar2;
  uVar3 = (u_int)before;
  if (before != 0) {
    do {
      if (uVar3 - uVar2 != (uVar4 & 0xffff)) {
        return 1;
      }
      bVar1 = uVar2 != 0;
      uVar4 = uVar4 << 1;
      uVar3 = uVar2;
      uVar2 = uVar2 & uVar2 - 1;
    } while (bVar1);
  }
  return 0;
}

/* ---- Camera_UpdatePulloverCam__Fi  [@0x80082c94] ---- */
void Camera_UpdatePulloverCam(int player)
{
  coorddef sCenter;
  coorddef sForward;
  coorddef sRight;
  coorddef sccVec;
  coorddef newarm;
  int ySign;
  char cVar1;
  int *piVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  u_int uVar8;
  int iVar9;
  int iVar10;
  int iVar11;
  Camera_tInfo *pCVar12;
  int local_40;
  int local_3c;
  int local_38;
  int local_1c;
  int local_18;
  
  if (((simVar.quickPauseSim == 0) || (Replay_ReplayInterface.changeCamera != 0)) &&
     (InBetween == 0)) {
    SetGeomScreen(0xbe);
    pCVar12 = Camera_gInfo + player;
    if (simGlobal.gameTicks < Camera_gInfo[player].POInhibitor) {
      Camera_UpdateCopCam2(player);
    }
    else {
      piVar2 = (int *)((pCVar12->anchor->simRoadInfo).slice * 0x20 + BWorldSm_slices);
      iVar9 = *piVar2;
      iVar10 = piVar2[1];
      iVar11 = piVar2[2];
      cVar1 = *(char *)((pCVar12->anchor->simRoadInfo).slice * 0x20 + BWorldSm_slices + 0x11);
      iVar3 = (pCVar12->anchor->position).x;
      iVar4 = (int)*(char *)((pCVar12->anchor->simRoadInfo).slice * 0x20 + BWorldSm_slices + 0x12);
      local_40 = iVar4 * 0x800;
      iVar5 = (int)*(char *)((pCVar12->anchor->simRoadInfo).slice * 0x20 + BWorldSm_slices + 0x13);
      local_3c = iVar5 * 0x800;
      iVar6 = (int)*(char *)((pCVar12->anchor->simRoadInfo).slice * 0x20 + BWorldSm_slices + 0x14);
      local_38 = iVar6 * 0x800;
      iVar7 = fixedmult((pCVar12->anchor->position).z - iVar11,
                         (int)*(char *)((pCVar12->anchor->simRoadInfo).slice * 0x20 +
                                        BWorldSm_slices + 0xf) << 9);
      iVar3 = fixedmult(iVar3 - iVar9,(int)cVar1 << 9);
      uVar8 = Camera_IslandProfile(*(u_short *)
                          ((pCVar12->anchor->simRoadInfo).slice * 0x20 + BWorldSm_slices + 0x16));
      if (iVar7 - iVar3 < 0) {
        uVar8 = uVar8 ^ 1;
      }
      if (uVar8 != 0) {
        local_40 = iVar4 * -0x800;
        local_38 = iVar6 * -0x800;
        local_3c = iVar5 * -0x800;
      }
      local_1c = 0x60000;
      Camera_TunnelLimit(player,&local_1c);
      local_1c = local_1c + iVar10 + local_3c;
      local_18 = iVar11 + local_38;
      iVar3 = fixedmult((iVar9 + local_40) - Camera_gInfo[player].position.x,0x7ae);
      iVar4 = Camera_gInfo[player].position.y;
      Camera_gInfo[player].position.x = Camera_gInfo[player].position.x + iVar3;
      iVar3 = fixedmult(local_1c - iVar4,0x7ae);
      iVar4 = Camera_gInfo[player].position.z;
      Camera_gInfo[player].position.y = Camera_gInfo[player].position.y + iVar3;
      iVar3 = fixedmult(local_18 - iVar4,0x7ae);
      uVar8 = *(u_int *)((char *)&(Camera_gInfo[player]) + 0x74);
      Camera_gInfo[player].position.z = Camera_gInfo[player].position.z + iVar3;
      *(u_int *)((char *)&(Camera_gInfo[player]) + 0x74) = uVar8 & 0xfffffff9 | 0x78;
    }
  }
  return;
}

/* ---- Camera_UpdateCopCam1__Fi  [@0x80083010] ---- */
void Camera_UpdateCopCam1(int player)
{
  coorddef vec;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  BO_tNewtonObj *pBVar5;
  Camera_tInfo *pCVar6;
  coorddef local_18;
  
  pCVar6 = Camera_gInfo + player;
  iVar1 = (pCVar6->anchor->position).y;
  iVar3 = ((Camera_gInfo[player].target)->position).y;
  iVar2 = (pCVar6->anchor->position).z;
  iVar4 = ((Camera_gInfo[player].target)->position).z;
  gCop1Target[player].x =
       (pCVar6->anchor->position).x + ((Camera_gInfo[player].target)->position).x >> 1;
  gCop1Target[player].y = iVar1 + iVar3 >> 1;
  gCop1Target[player].z = iVar2 + iVar4 >> 1;
  local_18.x = (pCVar6->anchor->position).x - ((Camera_gInfo[player].target)->position).x;
  local_18.y = (pCVar6->anchor->position).y - ((Camera_gInfo[player].target)->position).y;
  local_18.z = (pCVar6->anchor->position).z - ((Camera_gInfo[player].target)->position).z;
  Math_NormalizeVector(&local_18);
  local_18.x = fixedmult(0x40000,local_18.x);
  local_18.y = fixedmult(0x40000,local_18.y);
  iVar1 = fixedmult(0x40000,local_18.z);
  pBVar5 = pCVar6->anchor;
  Camera_gInfo[player].position.x = (pCVar6->anchor->position).x + local_18.x + iVar1;
  Camera_gInfo[player].position.y = (pBVar5->position).y + 0x18000;
  Camera_gInfo[player].position.z = ((pBVar5->position).z - local_18.x) + iVar1;
  return;
}

/* ---- Camera_UpdateCopCam2__Fi  [@0x800831a8] ---- */
void Camera_UpdateCopCam2(int player)
{
  coorddef dirVec;
  BO_tNewtonObj *pBVar1;
  Camera_tInfo *pCVar2;
  coorddef local_18;
  
  pCVar2 = Camera_gInfo + player;
  local_18.x = ((Camera_gInfo[player].target)->position).x - (pCVar2->anchor->position).x;
  if (local_18.x < 0) {
    local_18.x = local_18.x + 3;
  }
  local_18.x = local_18.x >> 2;
  local_18.y = ((Camera_gInfo[player].target)->position).y - (pCVar2->anchor->position).y;
  if (local_18.y < 0) {
    local_18.y = local_18.y + 3;
  }
  local_18.y = local_18.y >> 2;
  local_18.z = ((Camera_gInfo[player].target)->position).z - (pCVar2->anchor->position).z;
  if (local_18.z < 0) {
    local_18.z = local_18.z + 3;
  }
  local_18.z = local_18.z >> 2;
  Math_NormalizeVector(&local_18);
  pBVar1 = pCVar2->anchor;
  Camera_gInfo[player].position.x = (pCVar2->anchor->position).x + local_18.x * -2;
  Camera_gInfo[player].position.y = (pBVar1->position).y + 0x13333;
  Camera_gInfo[player].position.z = (pBVar1->position).z + local_18.z * -2;
  return;
}

/* ---- Camera_UpdateBTCopCam__Fi  [@0x800832b0] ---- */
void Camera_UpdateBTCopCam(int player)
{
  char cVar1;
  forceFocus_t fVar2;
  
  fVar2 = Camera_gInfo[player].forceFocus;
  if (fVar2 == 1) {
    cVar1 = Camera_gInfo[player].focusOnAICar;
    Camera_gInfo[player].anchor = &Cars_gList[Camera_gInfo[player].focusOnAICar]->N;
    Camera_gInfo[player].target = &Cars_gList[cVar1]->N;
    Camera_UpdateCircleCam(player);
  }
  else if ((1 < (int)fVar2) && (fVar2 == 2)) {
    cVar1 = Camera_gInfo[player].focusOnAICar;
    Camera_gInfo[player].anchor = &Cars_gList[player]->N;
    Camera_gInfo[player].target = &Cars_gList[cVar1]->N;
    Camera_UpdateCopCam2(player);
  }
  Camera_gGeomScreen[0] = 0xbe;
  Camera_gGeomScreen[1] = 0;
  Camera_gInfo[player].POInhibitor = simGlobal.gameTicks + 0x140;
  *(u_int *)((char *)&(Camera_gInfo[player]) + 0x74) =
       *(u_int *)((char *)&(Camera_gInfo[player]) + 0x74) & 0xffffffb9 | 0x38;
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
  Camera_gGeomScreen[0] = 0xbe;
  Camera_gGeomScreen[1] = 0;
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
  int i;
  int splitScreen;
  bool bVar1;
  Camera_tInfo *pCVar2;
  int iVar3;
  
  iVar3 = 0;
  bVar1 = GameSetup_gData.commMode == 1;
  pCVar2 = Camera_gInfo;
  do {
    if (pCVar2->animHandle != -1) {
      Anim_FreeHandle((int)pCVar2->animHandle);
    }
    pCVar2->animHandle = -1;
    iVar3 = iVar3 + 1;
    pCVar2 = pCVar2 + 1;
  } while (iVar3 <= (int)(u_int)bVar1);
  return;
}

/* ---- Camera_PitchAndRoll__Fi  [@0x80083c74] ---- */
void Camera_PitchAndRoll(int player)
{
  matrixtdef m1;
  matrixtdef m2;
  matrixtdef m3;
  Car_tObj*anchor;
  int pitch;
  int iVar1;
  matrixtdef mStack_90;
  matrixtdef mStack_68;
  matrixtdef mStack_40;
  
  iVar1 = Camera_gInfo[player].anchor[3].objAltitude;
  fixedxformz((int)&mStack_90,(int *)Camera_gInfo[player].anchor[3].collision.collided);
  fixedxformx((int)&mStack_68,
             (int *)(iVar1 << 1 | Camera_gInfo[player].pitch));
  Math_fasttransmult(&mStack_90,&mStack_68,&mStack_40);
  Math_fasttransmult(&mStack_40,&Camera_gInfo[player].rotation,&Camera_gInfo[player].rotation);
  return;
}

/* ---- Camera_TooSteep__FiP12BWorldSm_Pos  [@0x80083d28] ---- */
int Camera_TooSteep(int player,BWorldSm_Pos *slicePos)
{
  BWorldSm_Pos*slicePos2;
  coorddef normUnderCam;
  coorddef normUnderCar;
  coorddef camToCar;
  coorddef *pcVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int a;
  int a_00;
  int iVar5;
  int a_01;
  int iVar6;
  BO_tNewtonObj *pBVar7;
  Camera_tInfo *pCVar8;
  
  pCVar8 = Camera_gInfo + player;
  pBVar7 = pCVar8->anchor;
  pcVar1 = BWorldSm_UNormal(slicePos);
  a = pcVar1->x;
  a_00 = pcVar1->y;
  a_01 = pcVar1->z;
  pcVar1 = BWorldSm_UNormal(&pBVar7->simRoadInfo);
  iVar5 = pcVar1->y;
  iVar6 = pcVar1->z;
  iVar2 = fixedmult(a,pcVar1->x);
  iVar5 = fixedmult(a_00,iVar5);
  iVar6 = fixedmult(a_01,iVar6);
  iVar3 = 0;
  if (iVar2 + iVar5 + iVar6 < 0xb4fd) {
    iVar3 = Camera_gInfo[player].position.y;
    iVar2 = (pCVar8->anchor->position).y;
    iVar4 = Camera_gInfo[player].position.z;
    iVar5 = (pCVar8->anchor->position).z;
    iVar6 = fixedmult(a,(pCVar8->anchor->position).x - Camera_gInfo[player].position.x);
    iVar2 = fixedmult(a_00,iVar2 - iVar3);
    iVar5 = fixedmult(a_01,iVar5 - iVar4);
    if ((iVar6 + iVar2 + iVar5 < 1) || (iVar3 = 1, pCVar8->anchor->flightTime != 0)) {
      iVar3 = 0;
    }
  }
  return iVar3;
}

/* ---- Camera_CheckWallCollisions__FiP8coorddef  [@0x80083e98] ---- */
void Camera_CheckWallCollisions(int player,coorddef *pos)
{
  BWorldSm_Pos slicePos;
  coorddef edge;
  coorddef normal;
  coorddef step;
  coorddef temp;
  coorddef quadUnderCamera;
  coorddef triPnt;
  coorddef triVec;
  int camAngle;
  int sin;
  int cos;
  int camDotNorm;
  int edgeDotNorm;
  int count;
  int i;
  short sVar1;
  short sVar2;
  u_short uVar3;
  BO_tNewtonObj *pBVar4;
  int *piVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  BWorldSm_Pos *pBVar10;
  BWorldSm_Pos *pBVar11;
  Camera_tInfo *pCVar12;
  int iVar13;
  int iVar14;
  coorddef *pThis;
  u_int uVar15;
  BWorldSm_Pos local_118;
  coorddef local_90;
  int local_80;
  int local_7c;
  int local_78;
  int local_70;
  int local_6c;
  int local_68;
  coorddef local_60;
  int local_50;
  int local_4c;
  int local_48;
  coorddef local_40;
  int local_30;
  int local_2c;
  int local_28;
  int local_20;
  int local_1c;
  
  pBVar11 = &local_118;
  pBVar10 = &Camera_gInfo[player].slicePos;
  do {
    sVar1 = pBVar10->stripQuadInd;
    sVar2 = pBVar10->simRotFlag;
    uVar3 = *(u_short *)((char *)(pBVar10) + 0x6);
    iVar13 = pBVar10->quadPts[0].x;
    iVar14 = pBVar10->quadPts[0].y;
    pBVar11->slice = pBVar10->slice;
    pBVar11->stripQuadInd = sVar1;
    pBVar11->simRotFlag = sVar2;
    *(u_short *)((char *)(pBVar11) + 0x6) = uVar3;
    pBVar11->quadPts[0].x = iVar13;
    pBVar11->quadPts[0].y = iVar14;
    pBVar10 = (BWorldSm_Pos *)&pBVar10->quadPts[0].z;
    pBVar11 = (BWorldSm_Pos *)&pBVar11->quadPts[0].z;
  } while (pBVar10 != (BWorldSm_Pos *)&Camera_gInfo[player].slicePos.simSlice);
  *(int *)pBVar11 = *(int *)pBVar10;
  iVar13 = 0;
  pThis = feeler3;
  do {
    transform(pThis,((Camera_gInfo[player].anchor)->orientMat).m,
               &local_30);
    local_40.x = pos->x + local_30;
    local_40.y = pos->y + local_2c;
    local_40.z = pos->z + local_28;
    BWorldSm_FindClosestQuadMaxIterations(&local_40,&local_118,3);
    if (local_118.simQuad == (Trk_NewSimQuad *)0x0) {
      piVar5 = (int *)(local_118.slice * 0x20 + BWorldSm_slices);
      local_50 = *piVar5;
      local_4c = piVar5[1];
      local_48 = piVar5[2];
    }
    else {
      local_50 = local_118.quadPts[0].x;
      local_4c = local_118.quadPts[0].y;
      local_48 = local_118.quadPts[0].z;
      if (((local_118.simQuad)->surface & 0xf) == 0) break;
    }
    if (((local_118.offEdge != '\0') ||
        (iVar14 = Camera_TooSteep(player,&local_118), iVar14 != 0)) ||
       ((local_118.simQuad != (Trk_NewSimQuad *)0x0 &&
        ((((local_118.simQuad)->surface & 0x80) != 0 &&
         (0x38000 < local_4c - ((Camera_gInfo[player].anchor)->position).y)))))) break;
    iVar13 = iVar13 + 1;
    pThis = pThis + 1;
    if (2 < iVar13) break;
  } while( true );
  if (iVar13 == 3) {
    return;
  }
  pCVar12 = Camera_gInfo + player;
  iVar13 = 0;
  pBVar4 = pCVar12->anchor;
  local_90.x = (pBVar4->position).x;
  local_90.y = (pBVar4->position).y;
  local_90.z = (pBVar4->position).z;
  local_70 = (pCVar12->anchor->position).x - local_40.x >> 7;
  local_68 = (pCVar12->anchor->position).z - local_40.z >> 7;
  local_6c = (pCVar12->anchor->position).y - local_40.y >> 7;
  do {
    local_90.x = local_90.x - local_70;
    local_90.y = local_90.y - local_6c;
    local_90.z = local_90.z - local_68;
    BWorldSm_FindClosestQuadMaxIterations(&local_90,&local_118,3);
    if (local_118.simQuad == (Trk_NewSimQuad *)0x0) {
      piVar5 = (int *)(local_118.slice * 0x20 + BWorldSm_slices);
      local_50 = *piVar5;
      local_4c = piVar5[1];
      local_48 = piVar5[2];
    }
    else {
      local_50 = local_118.quadPts[0].x;
      local_4c = local_118.quadPts[0].y;
      local_48 = local_118.quadPts[0].z;
      if (((local_118.simQuad)->surface & 0xf) == 0) break;
    }
    if (((local_118.offEdge != '\0') ||
        (iVar14 = Camera_TooSteep(player,&local_118), iVar14 != 0)) ||
       (((local_118.simQuad != (Trk_NewSimQuad *)0x0 &&
         ((((local_118.simQuad)->surface & 0x80) != 0 &&
          (0x38000 < local_4c - (pCVar12->anchor->position).y)))) ||
        (iVar13 = iVar13 + 1, 0x7f < iVar13)))) break;
  } while( true );
  pCVar12 = Camera_gInfo + player;
  uVar15 = 1;
  local_70 = (pCVar12->anchor->position).x - local_90.x >> 1;
  local_6c = (pCVar12->anchor->position).y - local_90.y >> 1;
  local_68 = (pCVar12->anchor->position).z - local_90.z >> 1;
  do {
    intsincos(uVar15,&local_20,&local_1c);
    iVar13 = fixedmult(local_1c,local_70);
    local_60.x = fixedmult(local_20,local_68);
    local_60.x = iVar13 - local_60.x;
    local_60.y = local_6c;
    iVar13 = fixedmult(local_20,local_70);
    iVar14 = fixedmult(local_1c,local_68);
    local_60.x = local_90.x + local_60.x;
    local_60.y = local_90.y + local_60.y;
    local_60.z = local_90.z + iVar13 + iVar14;
    BWorldSm_FindClosestQuadMaxIterations(&local_60,&local_118,3);
    if (local_118.simQuad != (Trk_NewSimQuad *)0x0) {
      local_50 = local_118.quadPts[0].x;
      local_4c = local_118.quadPts[0].y;
      local_48 = local_118.quadPts[0].z;
      if (((local_118.simQuad)->surface & 0xf) != 0) goto LAB_80084400;
LAB_80084464:
      Camera_gInfo[player].wallLeft.x = local_60.x;
      Camera_gInfo[player].wallLeft.y = local_60.y;
      Camera_gInfo[player].wallLeft.z = local_60.z;
      break;
    }
    piVar5 = (int *)(local_118.slice * 0x20 + BWorldSm_slices);
    local_50 = *piVar5;
    local_4c = piVar5[1];
    local_48 = piVar5[2];
LAB_80084400:
    if (((local_118.offEdge != '\0') ||
        (iVar13 = Camera_TooSteep(player,&local_118), iVar13 != 0)) ||
       ((local_118.simQuad != (Trk_NewSimQuad *)0x0 &&
        ((((local_118.simQuad)->surface & 0x80) != 0 &&
         (0x38000 < local_4c - (pCVar12->anchor->position).y)))))) goto LAB_80084464;
    uVar15 = uVar15 + 4;
  } while ((int)uVar15 < 0x400);
  uVar15 = 0xffffffff;
  do {
    intsincos(uVar15,&local_20,&local_1c);
    iVar13 = fixedmult(local_1c,local_70);
    local_60.x = fixedmult(local_20,local_68);
    local_60.x = iVar13 - local_60.x;
    local_60.y = local_6c;
    iVar13 = fixedmult(local_20,local_70);
    iVar14 = fixedmult(local_1c,local_68);
    local_60.x = local_90.x + local_60.x;
    local_60.y = local_90.y + local_60.y;
    local_60.z = local_90.z + iVar13 + iVar14;
    BWorldSm_FindClosestQuadMaxIterations(&local_60,&local_118,3);
    if (local_118.simQuad != (Trk_NewSimQuad *)0x0) {
      local_50 = local_118.quadPts[0].x;
      local_4c = local_118.quadPts[0].y;
      local_48 = local_118.quadPts[0].z;
      if (((local_118.simQuad)->surface & 0xf) != 0) goto LAB_800845d0;
LAB_80084634:
      Camera_gInfo[player].wallRight.x = local_60.x;
      Camera_gInfo[player].wallRight.y = local_60.y;
      Camera_gInfo[player].wallRight.z = local_60.z;
      break;
    }
    piVar5 = (int *)(local_118.slice * 0x20 + BWorldSm_slices);
    local_50 = *piVar5;
    local_4c = piVar5[1];
    local_48 = piVar5[2];
LAB_800845d0:
    if (((local_118.offEdge != '\0') ||
        (iVar13 = Camera_TooSteep(player,&local_118), iVar13 != 0)) ||
       ((local_118.simQuad != (Trk_NewSimQuad *)0x0 &&
        ((((local_118.simQuad)->surface & 0x80) != 0 &&
         (0x38000 < local_4c - ((Camera_gInfo[player].anchor)->position).y)))))) goto LAB_80084634;
    uVar15 = uVar15 - 4;
  } while (-0x400 < (int)uVar15);
  local_60.x = Camera_gInfo[player].wallRight.x - Camera_gInfo[player].wallLeft.x;
  local_60.y = (Camera_gInfo[player].wallRight.y - Camera_gInfo[player].wallLeft.y) + 0x8000;
  local_60.z = Camera_gInfo[player].wallRight.z - Camera_gInfo[player].wallLeft.z;
  Math_NormalizeVector(&local_60);
  local_90.x = local_90.x - local_40.x;
  local_78 = local_60.x;
  local_80 = -local_60.z;
  local_7c = local_60.y;
  local_90.z = local_90.z - local_40.z;
  local_90.y = local_90.y - local_40.y;
  iVar13 = fixedmult(local_90.x,local_80);
  iVar14 = fixedmult(local_90.y,local_7c);
  iVar6 = fixedmult(local_90.z,local_78);
  iVar7 = fixedmult(local_30,local_80);
  iVar8 = fixedmult(local_2c,local_7c);
  iVar9 = fixedmult(local_28,local_78);
  iVar13 = iVar13 + iVar14 + iVar6 + iVar7 + iVar8 + iVar9 + 0x10000;
  if (0 < iVar13) {
    local_60.x = fixedmult(iVar13,local_80);
    local_60.y = fixedmult(iVar13,local_7c);
    iVar13 = fixedmult(iVar13,local_78);
    pos->x = pos->x + local_60.x;
    pos->y = pos->y + local_60.y;
    pos->z = pos->z + iVar13;
  }
  return;
}

/* ---- Camera_SetAboveGround__FiP8coorddef  [@0x8008480c] ---- */
void Camera_SetAboveGround(int player,coorddef *pos)
{
  BWorldSm_Pos*slicePos;
  coorddef quadnormal;
  int elevation;
  coorddef *pcVar1;
  int iVar2;
  coorddef local_20;
  
  pcVar1 = BWorldSm_UNormal(&Camera_gInfo[player].slicePos);
  local_20.x = pcVar1->x;
  local_20.y = pcVar1->y;
  local_20.z = pcVar1->z;
  iVar2 = Newton_FindGroundElevationGeneral(pos,&local_20,Camera_gInfo[player].slicePos.quadPts);
  if (pos->y < iVar2 + 0x10000) {
    pos->y = iVar2 + 0x10000;
  }
  return;
}

/* ---- Camera_AcquireTarget__FiP8coorddefT1P10matrixtdefi  [@0x80084898] ---- */
void Camera_AcquireTarget(int player,coorddef *point,coorddef *pos,matrixtdef *rot,int hirez)
{
  coorddef upvector;
  coorddef tgtPos;
  coorddef*rotx;
  coorddef*roty;
  coorddef*rotz;
  BO_tNewtonObj *pBVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  coorddef *v;
  coorddef *v_00;
  int local_38;
  int local_34;
  int local_30;
  int local_28;
  int local_24;
  int local_20;
  
  v_00 = (coorddef *)(rot->m + 3);
  local_38 = 0;
  local_34 = 0x10000;
  local_30 = 0;
  v = (coorddef *)(rot->m + 6);
  if (point == (coorddef *)0x0) {
    pBVar1 = Camera_gInfo[player].target;
    local_28 = (pBVar1->position).x;
    local_24 = (pBVar1->position).y;
    local_20 = (pBVar1->position).z;
  }
  else {
    local_28 = point->x;
    local_24 = point->y;
    local_20 = point->z;
  }
  local_28 = local_28 - pos->x;
  if (local_28 < 0) {
    local_28 = local_28 + 3;
  }
  v->x = local_28 >> 2;
  local_24 = local_24 - pos->y;
  if (local_24 < 0) {
    local_24 = local_24 + 3;
  }
  rot->m[7] = local_24 >> 2;
  local_20 = local_20 - pos->z;
  if (local_20 < 0) {
    local_20 = local_20 + 3;
  }
  rot->m[8] = local_20 >> 2;
  if (Camera_gInfo[player].pitch != 0) {
    iVar2 = rot->m[7] + 0x5333;
    if (2 < (u_short)Camera_gInfo[player].mode - 2) {
      iVar2 = rot->m[7] + 0x6666;
    }
    rot->m[7] = iVar2;
  }
  if (Replay_ReplayMode == 2) {
    local_38 = Camera_gInfo[player].twist;
  }
  Math_NormalizeVector(v);
  iVar2 = fixedmult(local_38,v->x);
  iVar3 = fixedmult(0x10000,rot->m[7]);
  iVar4 = fixedmult(0,rot->m[8]);
  if (iVar2 + iVar3 + iVar4 < 1) {
    iVar2 = fixedmult(local_38,v->x);
    iVar3 = fixedmult(0x10000,rot->m[7]);
    iVar4 = fixedmult(0,rot->m[8]);
    iVar2 = -(iVar2 + iVar3 + iVar4);
  }
  else {
    iVar3 = fixedmult(local_38,v->x);
    iVar4 = fixedmult(0x10000,rot->m[7]);
    iVar2 = fixedmult(0,rot->m[8]);
    iVar2 = iVar3 + iVar4 + iVar2;
  }
  if (0xfd70 < iVar2) {
    local_38 = v_00->x;
    local_34 = rot->m[4];
    local_30 = rot->m[5];
  }
  iVar2 = fixedmult(local_34,rot->m[8]);
  iVar3 = fixedmult(local_30,rot->m[7]);
  rot->m[0] = iVar2 - iVar3;
  iVar2 = fixedmult(local_30,v->x);
  iVar3 = fixedmult(local_38,rot->m[8]);
  rot->m[1] = iVar2 - iVar3;
  iVar2 = fixedmult(local_38,rot->m[7]);
  iVar3 = fixedmult(local_34,v->x);
  rot->m[2] = iVar2 - iVar3;
  Math_NormalizeVector((coorddef *)rot);
  iVar2 = fixedmult(rot->m[7],rot->m[2]);
  iVar3 = fixedmult(rot->m[8],rot->m[1]);
  v_00->x = iVar2 - iVar3;
  iVar2 = fixedmult(rot->m[8],rot->m[0]);
  iVar3 = fixedmult(v->x,rot->m[2]);
  rot->m[4] = iVar2 - iVar3;
  iVar2 = fixedmult(v->x,rot->m[1]);
  iVar3 = fixedmult(rot->m[7],rot->m[0]);
  rot->m[5] = iVar2 - iVar3;
  Math_NormalizeVector(v_00);
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
  int local_28;
  int local_24;
  int local_20;
  
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
  local_28 = -(cview->translation).x;
  local_24 = -(cview->translation).y;
  local_20 = -(cview->translation).z;
  transform(&local_28,(cview->mrotationInv).m,&(cview->translationInv).x
            );
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
  if ((((Cars_gHumanRaceCarList[cviewP]->carFlags & 1U) == 0) ||
      ((Cars_gHumanRaceCarList[cviewP]->stats).finishType != 2)) &&
     ((Cars_gHumanRaceCarList[cviewP]->pullOver == 0 ||
      ((Cars_gHumanRaceCarList[cviewP]->stats).finishType == 3)))) {
    return (int)Camera_gInfo[cviewP].mode;
  }
  return 0x14;
}

/* ---- Camera_SetMode__Fii  [@0x80085608] ---- */
void Camera_SetMode(int cviewP,int mode)
{
  camera_flags*flagMode;
  short sVar1;
  u_int uVar2;
  u_int uVar3;
  u_int uVar4;
  u_int uVar5;
  u_int uVar6;
  u_int uVar7;
  u_int uVar8;
  
  InBetween = 0;
  if ((((char *)&(Camera_gInfo[cviewP]))[0x74] & 1) == 0) {
    if ((u_short)Camera_gInfo[cviewP].mode - 0xb < 2) {
      Camera_gGeomScreen[0] = 0xbe;
      Camera_gGeomScreen[1] = 0;
      TrsProj_SetProjection(0,0,0x140,0xf0);
    }
    if (5 < (u_short)Camera_gInfo[cviewP].mode - 2) {
      Camera_ResetRelPos(cviewP + 1);
    }
    if (-1 < Camera_gInfo[cviewP].animHandle) {
      Anim_FreeHandle((int)Camera_gInfo[cviewP].animHandle);
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
    uVar2 = *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74);
    uVar3 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 1) << 1;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) = uVar2 & 0xfffffffd | uVar3;
    uVar4 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 2) << 1;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) = uVar2 & 0xfffffff9 | uVar3 | uVar4;
    uVar5 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 4) << 1;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) = uVar2 & 0xfffffff1 | uVar3 | uVar4 | uVar5;
    uVar6 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 8) << 1;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) = uVar2 & 0xffffffe1 | uVar3 | uVar4 | uVar5 | uVar6;
    uVar7 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 0x10) << 1;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) =
         uVar2 & 0xffffffc1 | uVar3 | uVar4 | uVar5 | uVar6 | uVar7;
    uVar8 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 0x20) << 1;
    sVar1 = Camera_gInfo[cviewP].mode;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) =
         uVar2 & 0xffffff81 | uVar3 | uVar4 | uVar5 | uVar6 | uVar7 | uVar8;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) =
         uVar2 & 0xf7ffff81 | uVar3 | uVar4 | uVar5 | uVar6 | uVar7 | uVar8 |
         (u_int)(sVar1 < 2) << 0x1b;
  }
  return;
}

/* ---- Camera_NextMode__Fi  [@0x8008581c] ---- */
void Camera_NextMode(int cviewP)
{
  camera_flags*flagMode;
  short sVar1;
  u_int uVar2;
  u_int uVar3;
  u_int uVar4;
  u_int uVar5;
  u_int uVar6;
  u_int uVar7;
  u_int uVar8;
  
  if ((Camera_gInfo[cviewP].mode != 0xe) && ((((char *)&(Camera_gInfo[cviewP]))[0x74] & 1) == 0)) {
    if ((u_short)Camera_gInfo[cviewP].mode - 0xb < 2) {
      Camera_gGeomScreen[0] = 0xbe;
      Camera_gGeomScreen[1] = 0;
      TrsProj_SetProjection(0,0,0x140,0xf0);
    }
    if (5 < (u_short)Camera_gInfo[cviewP].mode - 2) {
      Camera_ResetRelPos(cviewP + 1);
    }
    if (-1 < Camera_gInfo[cviewP].animHandle) {
      Anim_FreeHandle((int)Camera_gInfo[cviewP].animHandle);
      Camera_gInfo[cviewP].animHandle = -1;
    }
    if ((char)((char *)&(Camera_gInfo[cviewP]))[0x74] < '\0') {
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
    uVar2 = *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74);
    uVar3 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 1) << 1;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) = uVar2 & 0xfffffffd | uVar3;
    uVar4 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 2) << 1;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) = uVar2 & 0xfffffff9 | uVar3 | uVar4;
    uVar5 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 4) << 1;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) = uVar2 & 0xfffffff1 | uVar3 | uVar4 | uVar5;
    uVar6 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 8) << 1;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) = uVar2 & 0xffffffe1 | uVar3 | uVar4 | uVar5 | uVar6;
    uVar7 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 0x10) << 1;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) =
         uVar2 & 0xffffffc1 | uVar3 | uVar4 | uVar5 | uVar6 | uVar7;
    uVar8 = (*(u_int *)((char *)&(Camera_gFlags[sVar1]) + 0xc) & 0x20) << 1;
    sVar1 = Camera_gInfo[cviewP].mode;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) =
         uVar2 & 0xffffff81 | uVar3 | uVar4 | uVar5 | uVar6 | uVar7 | uVar8;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) =
         uVar2 & 0xf7ffff81 | uVar3 | uVar4 | uVar5 | uVar6 | uVar7 | uVar8 |
         (u_int)(sVar1 < 2) << 0x1b;
  }
  return;
}

/* ---- Camera_ReplayUpdate__FiP15Camera_tCamSlot  [@0x80085bd0] ---- */
void Camera_ReplayUpdate(int cviewP,Camera_tCamSlot *ptr)
{
  u_int uVar1;
  u_int uVar2;
  u_int uVar3;
  int iVar4;
  int iVar5;
  
  if ((((char *)&(Camera_gInfo[cviewP]))[0x74] & 1) == 0) {
    Camera_SetMode(cviewP,(u_int)(u_char)ptr->mode);
    uVar3 = *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74);
    ((u_char *)&(uVar1))[0] = ptr->mode;
    ((u_char *)&(uVar1))[1] = ((char *)(ptr))[0x1];
    (*(u_short *)((u_char *)&(uVar1) + 2)) = ptr->fov;
    uVar1 = uVar1 >> 5 & 8;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) = uVar3 & 0xfffffff7 | uVar1;
    ((u_char *)&(uVar2))[0] = ptr->mode;
    ((u_char *)&(uVar2))[1] = ((char *)(ptr))[0x1];
    (*(u_short *)((u_char *)&(uVar2) + 2)) = ptr->fov;
    *(u_int *)((char *)&(Camera_gInfo[cviewP]) + 0x74) =
         uVar3 & 0xf9fffff7 | uVar1 | (uVar2 >> 9 & 3) << 0x19;
    ((u_char *)&(uVar3))[0] = ptr->mode;
    ((u_char *)&(uVar3))[1] = ((char *)(ptr))[0x1];
    (*(u_short *)((u_char *)&(uVar3) + 2)) = ptr->fov;
    Camera_gInfo[cviewP].splineMode = (u_char)(uVar3 >> 0xb) & 7;
    (*(int *)&(Camera_gGeomScreen)) = ptr->fov /* @0x75CAC disasm-v2: signed `lh` short load; short->int sign-extends natively (Ghidra SEXT24 spurious) */;
    iVar4 = (ptr->pos).y;
    iVar5 = (ptr->pos).z;
    Camera_gInfo[cviewP].position.x = (ptr->pos).x;
    Camera_gInfo[cviewP].position.y = iVar4;
    Camera_gInfo[cviewP].position.z = iVar5;
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
