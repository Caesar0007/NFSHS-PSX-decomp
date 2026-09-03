/* game/common/camera.cpp -- RECONSTRUCTED (NFS4 game clock: 128Hz EAC timer chain + master IRQ handler).
 *   3 fns: MasterInterruptHandler / SystemStartUp / SystemCleanUp. SYM-v3 locals; owns 4 globals.
 *   Verified vs disasm-v2.txt (addtimer/deltimer 1-arg = &Clock_MasterInterruptHandler). Self-contained.
 */
#include "camera_types.h"
#include "camera_externs.h"


/* ---- clock.obj-owned globals (.bss zero) ---- */
camera_info  Camera_gInfo[2];   /* @0x8010f2ac  (bss(zero)) */
static int          gTunnelCamHeight[13] = { 373555, 321126, 340787, 242483, 321126, 373555, 255590, 176947, 288358, 268697, 268697, 0, 0 };   /* @0x8010f4cc */
static int          gSplitCameras[3] = { 0, 2, 5 };   /* @0x8010f500 */
static char         gAnimMode[13] = { 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0 };   /* @0x8010f50c */
static char         gAnimCams[13][4] = { 2, 6, 0, 0, 1, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 2, 6, 0, 0, 1, 6, 0, 0, 1, 6, 0, 0 };   /* @0x8010f51c */
camera_flags Camera_gFlags[19] = { {0, 2, 2, 2, 2, 2, 2}, {0, 16, 16, 16, 16, 16, 16}, {0, 45, 45, 45, 45, 45, 45}, {0, 45, 45, 45, 45, 45, 45}, {0, 45, 45, 45, 45, 45, 45}, {0, 45, 45, 45, 45, 45, 45}, {0, 45, 45, 45, 45, 45, 45}, {0, 45, 45, 45, 45, 45, 45}, {-114688, 60, 60, 60, 60, 60, 60}, {0, 56, 56, 56, 56, 56, 56}, {0, 60, 60, 60, 60, 60, 60}, {0, 20, 20, 20, 20, 20, 20}, {0, 20, 20, 20, 20, 20, 20}, {0, 20, 20, 20, 20, 20, 20}, {0, 16, 16, 16, 16, 16, 16}, {0, 18, 18, 18, 18, 18, 18}, {0, 24, 24, 24, 24, 24, 24}, {0, 20, 20, 20, 20, 20, 20}, {0, 20, 20, 20, 20, 20, 20} };   /* @0x8010f550 */
static coorddef     gDriverCam[28] = { {-23592, 26869, -17039}, {-23592, 26869, -17039}, {25559, 30801, 15728}, {23592, 26869, 11796}, {-23592, 26869, 0}, {-23592, 26869, 0}, {-23592, 26869, 0}, {-23592, 26869, 0}, {-23592, 26869, 15728}, {-19660, 26869, -4587}, {-23592, 22937, -8519}, {-19660, 26869, -8519}, {-23592, 22937, 11796}, {-23592, 26869, 28180}, {-19660, 22937, -3276}, {0, 19005, 32112}, {-19660, 26869, -8519}, {25559, 30801, 15728}, {-19660, 26869, -4587}, {-23592, 26869, 11796}, {-15728, 22937, 0}, {-15728, 22937, 0}, {-23592, 26869, 28180}, {25559, 30801, 15728}, {-23592, 26869, 15728}, {-19660, 26869, -4587}, {-19660, 26869, -8519}, {-23592, 26869, 28180} };   /* @0x8010f680 */
int          camSpeedTable[7] = { 64225, 60948, 56360, 52428, 47841, 43253, 39321 };   /* @0x8010f7d0 */
coorddef     feeler3[3] = { {0, 0, 137625}, {-117964, 0, -72089}, {117964, 0, -72089} };   /* @0x8010f7ec */
int          Camera_gCopDist[6];   /* @0x8010f810  (bss(zero)) */
long Camera_gGeomScreen = 190;  /* @0x8013c7dc scalar -- confirmed by oracle: every SetCameraZoom/UpdateBTCopCam/Init/SetMode/
   NextMode/ReplayUpdate site does exactly ONE %gp_rel word store, never a paired +4 store; every OTHER
   TU's extern decl (cars_externs.h, hrzsku_externs.h, trsproj_externs.h) already declares it `long`
   scalar, not an array. The stray "[2]"/"[1]=0" writes were a prior session's mis-guess from the SYM's
   size-0 + the next-symbol (frontLimit@+8) gap; frontLimit is link-layout-adjacent, not Camera_gGeomScreen[1]. */
static coorddef     gCop1Target[2];   /* @0x8013dff0  (bss?) */


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

  fixedxformx(&mx,ax);
  fixedxformy(&my,ay);
  fixedxformz(&mz,az);
  Math_fasttransmult(&mz,&my,&mt);
  Math_fasttransmult(&mt,&mx,m);
  /* MATCH: mt is DEAD after the 2nd fasttransmult - oracle stages the old row1 (m[3..5])
     through mt's now-free stack slots, not fresh registers. */
  mt.m[0] = m->m[3];
  mt.m[1] = m->m[4];
  mt.m[2] = m->m[5];
  m->m[3] = -m->m[6];
  m->m[4] = -m->m[7];
  m->m[5] = -m->m[8];
  m->m[6] = mt.m[0];
  m->m[7] = mt.m[1];
  m->m[8] = mt.m[2];
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
  if (BWorldSm_TunnelFlagSm(&Camera_gInfo[player].slicePos) ||
      BWorldSm_TunnelFlagSm(&Camera_gInfo[player].anchor->simRoadInfo)) {
    BWorldSm_Pos *slicePos = &Camera_gInfo[player].slicePos;
    coorddef quadnormal = *(coorddef *)BWorldSm_UNormal(slicePos);
    coorddef underCam = Camera_gInfo[player].position;
    int roadheight =
        Newton_FindGroundElevationGeneral(&underCam,&quadnormal,slicePos->quadPts);
    int track = Camera_GameSetupWords[15];
    if (0xf < Camera_GameSetupWords[15]) {
      track = Camera_GameSetupWords[15] + -7;
    }
    int maxheight =
        (gTunnelCamHeight[track] - Camera_gInfo[player].anchor->position.y) +
        roadheight;
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

  if (((Camera_SimVarWords[4] == 0) || (Camera_ReplayInterfaceWords[6] != 0)) &&
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
    Camera_gInfo[player].position.x = Camera_gInfo[player].anchor->position.x + Camera_gInfo[player].relpos.x;
    Camera_gInfo[player].position.y = Camera_gInfo[player].anchor->position.y + Camera_gInfo[player].relpos.y;
    Camera_gInfo[player].position.z = Camera_gInfo[player].anchor->position.z + Camera_gInfo[player].relpos.z;
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
  /* SYM-CODEGEN-CARRIER: sVar1 -- indexing Camera_gFlags directly keeps all
   * 57 instructions but schedules its address `lui` four instructions too
   * early, producing two authoritative order diffs. */
  short sVar1;

  sVar1 = Camera_gInfo[player].mode;
  arm = Camera_gFlags[sVar1].arm;
  transform((int *)&arm,Camera_gInfo[player].anchor->orientMat.m,(int *)&newarm);
  Camera_TunnelLimit(player,&newarm.y);
  Camera_gInfo[player].position.x = Camera_gInfo[player].anchor->position.x + newarm.x;
  Camera_gInfo[player].position.y = Camera_gInfo[player].anchor->position.y + newarm.y;
  Camera_gInfo[player].position.z = Camera_gInfo[player].anchor->position.z + newarm.z;
  Camera_LookBack(&Camera_gInfo[player].anchor->orientMat,
                  &Camera_gInfo[player].rotation);
  return;
}

/* ---- Camera_UpdateBumperCam__Fi  [@0x80080bac] ---- */
void Camera_UpdateBumperCam(int player)
{
  coorddef arm;        /* SYM: AUTO @0x10 */
  coorddef newarm;     /* SYM: AUTO @0x20 */
  int lookingBehind;   /* SYM: REG ($s1) */

  lookingBehind = 0;
  {
    /* SYM-CODEGEN-CARRIER: mode -- indexing Camera_gFlags directly keeps all
     * 118 instructions but schedules its address `lui` four instructions too
     * early, producing two authoritative order diffs. */
    short mode = Camera_gInfo[player].mode;
    arm = Camera_gFlags[mode].arm;
  }
  if (Camera_gInfo[player].noLookBack == 0) {
    lookingBehind = *(int *)((player << 2) + (int)Input_gLookBehind) != 0;
  }
  if (lookingBehind) {
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_gInfo[player].audioPos.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    Camera_gInfo[player].audioPos.y = Camera_gInfo[player].anchor->position.y + newarm.y;
    Camera_gInfo[player].audioPos.z = Camera_gInfo[player].anchor->position.z + newarm.z;
    arm.z = -arm.z;
  }
  transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
  Camera_gInfo[player].position.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
  Camera_gInfo[player].position.y = Camera_gInfo[player].anchor->position.y + newarm.y;
  Camera_gInfo[player].position.z = Camera_gInfo[player].anchor->position.z + newarm.z;
  if (lookingBehind) {
    Camera_LookBack(&Camera_gInfo[player].anchor->orientMat,&Camera_gInfo[player].rotation);
  }
  else {
    /* MATCH: plain struct assignment -> gcc movstrsi unrolled copy (9 words).
     * W85-S10: the old `*(BO_tNewtonObj *volatile *)&...anchor` view claimed to
     * force a FRESH anchor re-load; measured device-free -- removing the
     * volatile holds camera.cpp at 38/38 PASS, so it was a codegen crutch. */
    Camera_gInfo[player].rotation = Camera_gInfo[player].anchor->orientMat;
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

  maxrate = 0x1999;
  rate = maxrate;
  {
    /* SYM-CODEGEN-CARRIER: mode.  Direct Camera_gFlags indexing moves its
       address materialization and leaves two authoritative schedule diffs. */
    short mode = Camera_gInfo[player].mode;   /* MATCH: inner gInfo eval first (base lui v0) */
    arm = Camera_gFlags[mode].arm;
  }
  anchor = (Car_tObj *)Camera_gInfo[player].anchor;
  rateY = 0xCCC;
  {
    /* MATCH: reverseTrack read ONCE before the if (single lw, shared by both arms) */
    /* SYM-CODEGEN-CARRIER: rev.  Per-arm reverseTrack reads were measured at
       76 diffs and lose retail's single shared load. */
    int rev = Camera_GameSetupWords[12];
    if (0 < anchor->wrongway) {
      /* SYM-CODEGEN-CARRIER: flip.  Direct `if (rev ^ 1)` emits xori/bnez
         instead of retail's compare-to-one form (18 diffs at 402/402). */
      int flip = rev ^ 1;
      /* MATCH: pin-free zero-instruction fence keeps the XOR ahead of the branch. */
      lookahead = 3;
      if (flip) goto lookahead_done;
      __asm__("" : : "i"(3));
      lookahead = -3;
      goto lookahead_done;
    }
    lookahead = 3;
    if (rev) goto lookahead_done;
    lookahead = -3;
lookahead_done:;
  }
  if ((Camera_SimVarWords[4] != 0) && (Camera_ReplayInterfaceWords[6] == 0)) {
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
    /* SYM-CODEGEN-CARRIER: z.  Writing this as builtin_abs swaps the X/Z
       loads and changes 16 instructions at unchanged size. */
    int z = anchor->linearVel_ch.z;
    /* SYM-CODEGEN-CARRIER: ax.  Reusing SYM rate for the absolute X speed keeps
       402 instructions but shifts the saved-register allocation across 150 diffs. */
    int ax = __builtin_abs(anchor->linearVel_ch.x);
    if (z < 0) {
      z = -z;
    }
    __asm__("" : : "i"(0));
    /* MATCH: speed sum accumulates IN rate (s2, dead here); vertigo = /900 result */
    if (z < ax) {
      rate = ax + (z >> 2);
    }
    else {
      rate = z + (ax >> 2);
    }
    rate = rate / 900;
    /* MATCH: MAX(0x51E, MIN(rate,maxrate)) funnels through an anonymous a1 result into rate (s2) */
    rate = ((maxrate < rate ? maxrate : rate) < 0x51E) ? 0x51E
         : (maxrate < rate ? maxrate : rate);
  }
  if (*(int *)((player << 2) + (int)Input_gLookBehind) != 0) {
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
    /* MATCH: BWorldSm_slices stays in a2 and the first road sample stays in a0.
     * The priced, pin-free fence adds six allocator references without instructions,
     * leaving gNumSlices in a1 and the shifted wrap offset in v0. */
    /* SYM-CODEGEN-CARRIER: slices.  This named base is the priced quantity that
       remains in retail $a2 across both road samples. */
    char *slices = (char *)Camera_BWorldSmSlices;
    /* SYM-CODEGEN-CARRIER: offset.  Reusing dead SYM slice yields 403/402 and
       loses retail's explicit v0-to-v1 offset copy (three detailed diffs). */
    int offset;
    /* SYM-CODEGEN-CARRIER: first.  Six zero-insn references are the measured
       allocator dial that seats the first road sample in retail $a0. */
    int first = *(int *)((slice << 5) + (int)slices + 4);
    __asm__("" : : "r"(first), "r"(first), "r"(first), "r"(first), "r"(first),
                      "r"(first));
    if (lookahead < 1) {
      slice = slice - lookahead;
      offset = (slice < gNumSlices ? slice : slice - gNumSlices) << 5;
    }
    else {
      slice = slice - lookahead;
      offset = (slice < 0 ? slice + gNumSlices : slice) << 5;
    }
    /* SYM-CODEGEN-CARRIER: second.  Directly folding this address into the load
       is count-exact but moves its addu, leaving two schedule diffs. */
    char *second = slices + offset;
    __asm__("" : "+r"(second));
    first -= *(int *)(second + 4);
    vertigo = first / 3;
  }
  switch (behavior) {
  case 0:
    vertigo = 0;
    break;
  case 1:
    /* MATCH: MAX(0x4000, MIN(len,0x10000)) nested macros */
    vertigo = ((0x10000 < vertigo ? 0x10000 : vertigo) < 0x4000) ? 0x4000
        : (0x10000 < vertigo ? 0x10000 : vertigo);
    break;
  case 2:
    vertigo = ((0x20000 < vertigo ? 0x20000 : vertigo) < -0x4000) ? -0x4000
        : (0x20000 < vertigo ? 0x20000 : vertigo);
    break;
  }
  /* MATCH: split the compound assignment at the existing scheduler boundary.
   * Loading arm.y before the boundary restores the retail load order (4 -> 2). */
  /* SYM-CODEGEN-CARRIER: armY.  The pre-boundary snapshot is the measured
     source-side load-order fix; a compound arm.y update leaves two diffs. */
  int armY = arm.y;
  __asm__("" : : "i"(2));
  /* W78 source-only closure: force the look-behind base into the arm-load
     latency window; it occupies v1 while vertigo retains retail's a0. */
  /* SYM-CODEGEN-CARRIER: lookBehindBase.  This fenced base supplies retail's
     load-latency filler and reserves $v1 while vertigo remains live. */
  int *lookBehindBase = Input_gLookBehind;
  __asm__("" : "+r"(lookBehindBase));
  arm.y = armY + vertigo;
  /* End vertigo's scheduling region before the shared &arm value is born. */
  /* SYM-CODEGEN-CARRIER: armPtr.  Plain &arm in both branches was measured at
     403 instructions/three diffs; this scoped identity yields exact 402/402. */
  coorddef *armPtr = &arm;
  if (lookBehindBase[player] != 0) {
    /* audio (look-behind) arm FIRST in VA order */
    {
      /* MATCH: a scoped identity keeps &arm caller-saved (direct spelling promotes it
       * to s2).  The remaining 2-insn receipt is reorg/assembler slot placement:
       * scratchpad/build_probe_camera_tailcam_textmove.py moves the join's existing
       * `addu $4,$sp,16` into the beq slot and drops reorg's copied filler, producing
       * PASS 402/402 with HeliCam unchanged at 72 and CircleCam still PASS.
       * NOTE (W60-A9): that probe spec needs a "drop_after" key build.py's
       * _apply_text_moves does NOT implement (take/after/slot/drop_nop/copy only) --
       * it is an ORCHESTRATOR wiring item, not applicable as-is.
       *
       * W60-A9 STRUCTURAL FINDING (not landed -- the gate prefers the 2): retail
       * materialises `&arm` ONCE, in the beq's DELAY SLOT, so a0 is live on BOTH
       * arms (delay slots execute either way, §3.1).  Our shipped shape duplicates
       * `addiu a0,sp,16` per arm and is +2.  Hoisting ONE `coorddef *armPtr = &arm;`
       * above the `if` and using it in BOTH arms' first transform() call, with the
       * identity fence moved INSIDE the look-behind arm, reaches
       * COUNT-EXACT 402/402 and the whole residual collapses to a single $a0<->$a1
       * rotation (26 diffs; the `addiu a0,sp,16` placement fixes itself).
       * -dg EVIDENCE (scratch/rtl/camera.i.greg): p217 = armPtr, refs=5 live=6
       * pri 1.6666 rank 1 with copy-preference $4; p86 = vertigo, refs=12 live=47
       * pri 0.7659 rank 11; and `86 conflicts: ... 217 ...` -- sched1 hoists armPtr's
       * `addu $4,$sp,16` into the `lw $2,20($sp)` load-delay slot, i.e. ABOVE
       * vertigo's last use, creating the conflict retail does not have.  reqdelta
       * arithmetic: vertigo needs refs 12->20 to outrank p217 (unreachable), so the
       * only cure is REMOVING the overlap, not re-ranking.
       * W60-A9 MEASURED from that basin, all worse: void-tail barrier between the
       * arm.y store and the armPtr decl 29@403 (the barrier starves the load-delay
       * slot -> a nop) | read-only fence instead of identity 100@404 | armPtr+fence
       * hoisted above the armY load 39@403 | armPtr assigned after a lookBehind
       * read 26 | store via armPtr->y 31@403 | hoisting the Input_gLookBehind base
       * into a local to feed the load-delay slot 44@404 (with and without the
       * barrier) | vertigo ref dials +1/+2/identity/none: 26/26/26/27 (INERT --
       * this is not an allocno_compare razor) | clamp respellings (named MIN temp
       * 54, override-MAX 52, override-both 44).
       * Two natural spellings for the record: plain `&arm` in both arms with no
       * local at all = 3 diffs @403 (one insn BETTER than shipped on count);
       * plain `&arm` in the else arm + the scoped armPtr in the if arm = the
       * shipped 2 @404.
       *
       * W78 SOURCE-ONLY CLOSURE: materialising and identity-fencing a named
       * Input_gLookBehind base between the two scheduler boundaries supplies the
       * retail load-latency filler and reserves v1 while vertigo is live.  The
       * second boundary then prevents armPtr from overlapping vertigo; its scoped
       * identity lets reorg place the single `addiu a0,sp,16` in the beq delay
       * slot.  Strict source gate: PASS 402/402; no TEXT_MOVES required. */
      __asm__("" : "+r"(armPtr));
      transform(armPtr,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    }
    Camera_gInfo[player].audioPos.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    Camera_gInfo[player].audioPos.y =
        (Camera_gInfo[player].anchor->position).y + newarm.y;
    Camera_gInfo[player].audioPos.z =
        (Camera_gInfo[player].anchor->position).z + newarm.z;
    arm.z = -arm.z;
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_TunnelLimit(player,&newarm.y);
    Camera_gInfo[player].position.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    Camera_gInfo[player].position.y =
        (Camera_gInfo[player].anchor->position).y + newarm.y;
    Camera_gInfo[player].position.z =
        (Camera_gInfo[player].anchor->position).z + newarm.z;
    return;
  }
  transform(armPtr,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
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
  Camera_gInfo[player].position.y =
       ((Camera_gInfo[player].anchor)->position).y + Camera_gInfo[player].relpos.y;
  Camera_gInfo[player].position.z =
       ((Camera_gInfo[player].anchor)->position).z + Camera_gInfo[player].relpos.z;
  return;
}

/* ---- Camera_UpdateHeliCam__Fii  [@0x800813cc] ----
 * MATCH (187 -> 72): TailCam's priced road-sample/source-shape idiom preserves
 * BWorldSm_slices in a2 and the first sample in a0; reusing SYM's `fallback`
 * through /2 and the clamp switch keeps the retail a0 funnel. Direct anchor
 * expressions reproduce the look-behind reloads, and builtin_abs gives the
 * retail raw-v0/copy handoffs without volatile.
 *
 * W59-A4 (72 -> 57), two independent devices:
 *  (1) 09I CAST-INT ARRAY SUBSCRIPT on the FIRST Input_gLookBehind test
 *      (`*(int *)((player << 2) + (int)Input_gLookBehind)`, the spelling already
 *      used at the 3 other sites in this TU): pins index-before-base address-block
 *      order (retail `sll v0,s3,2; lui v1; addu v0,v0,v1`), 72 -> 62.  MEASURED
 *      FALSIFIED: the same spelling on the SECOND (look-behind arm) site regresses
 *      62 -> 65 -- apply per site, never TU-wide.
 *  (2) 09J/09G ANTI-CROSS-JUMP void fence at the end of the wrongway arm: our
 *      build cross-jumped the two identical `lookahead = 3; if (...) = -3;` tails
 *      (then-arm jumped INTO the else-arm test, xori in the j slot); retail keeps
 *      BOTH tails.  A zero-insn `__asm__("" : : "i"(0))` closing the then-arm
 *      blocks the merge and restores retail's arm pair, 62 -> 57.
 *      Also falsified there: per-arm re-read of GameSetup_gData.reverseTrack
 *      (76 -- loses retail's single shared lw), per-arm distinct local (inert 62).
 *
 * W61-A11 (57 -> 12): the epilogue $v0<->$v1 swap (22 diffs) was a local-alloc
 * QTY ORDER tie, closed with the instrumented cc1plus (scratch/gccbuild-ecoff,
 * byte-identical on this fn -> the trace is a receipt).  Block-83 qty table:
 *   q1 = &Camera_gInfo[player]  (p510+p511+p512+p513 merged)  refs 15 life 34
 *        QTY_CMP_PRI 1.3235                       <- loses, takes $v1
 *   q6/q8 = the two `anchor->position.{y,z} + relpos` adds, refs 4 life 6
 *        QTY_CMP_PRI 1.3333                       <- win, take $v0
 * i.e. the address lost the seat by 0.01.  floor_log2 REF-STEP: refs 15 -> 16
 * crosses a log2 step (4*16/34 = 1.882), so ONE extra reference to the ADDRESS
 * flips the whole block.  The zero-insn dial is the read-only fence on
 * `&Camera_gInfo[player]` at the end of the fn (below) -- it emits nothing and
 * cse reuses the existing address pseudo, so it is purely +1 ref.
 * POSITION IS THE DIAL (all gated): end-of-fn 12 | inside the y/z block, last 12 |
 * after the position.x store 17 | inside the block, first 17 | BEFORE the block
 * 58 (worse than baseline -- it lands before the address is materialised) |
 * two operands before the block 58.  Still FALSIFIED (w59-a4): a `camera_info
 * *info` local hoisted before the intransition branch (208).
 * REMAINING 12 = four reorg/delay-slot relocations, ours +2 insns because reorg
 * DUPLICATES two `lui`s into slots retail leaves as `nop`/fills differently:
 * (a) the lookahead 3/-3 arm pair (ours `li s1,-3; j; lui v0,0` vs retail
 * `j; li s1,-3`), (b) the rear-abs `bgez v1` slot (ours steals the `slt`, retail
 * nops), (c) two `beqz s4`/`beq s4,v0` slots (ours `lui v1,0` twice, retail
 * `nop` + `lui v0,3`), (d) `lw v0,20(sp)` one line late.  All four are
 * PER_FN_TEXT_MOVES/drop_after territory, not source shape.
 * W62-A11 -- the mechanism is now NAMED and it is NOT plain TEXT_MOVES.  The .s
 * (saved verbatim at scratchpad/w62a11/helicam.s) shows all three `lui`
 * duplications are reorg TARGET-STEALS WITH A BRANCH REDIRECT:
 *   $L579: j $L640 / lui $2,%hi(simVar+16)   <- stolen from $L580's head, and
 *          $L580: lui $2,%hi(simVar+16) / $L640: lw $2,%lo(simVar+16)($2)
 *          i.e. $L640 was PLANTED after the stolen insn.
 *   beq $20,$0,$L616 / lui $3,%hi(Input_gLookBehind)   and
 *   beq $20,$2,$L623 / lui $3,%hi(Input_gLookBehind)   <- both stolen from
 *          $L615: lui $3,%hi(Input_gLookBehind) / $L641: lw $2,20($sp)
 * Undoing any of them requires re-pointing the branch ($L640->$L580,
 * $L641->$L615) as well as deleting the slot copy, and PER_FN_TEXT_MOVES
 * (take/after/slot/drop_nop/drop_after) can relocate LINES but cannot change a
 * branch TARGET -- so this needs a new per-fn mechanism (a reorg
 * `fill_slots_from_thread` / target-steal disable, i.e. a dual-compile splice
 * like PER_FN_NO_DELAYED_BRANCH but keeping the ordinary backward slot fill),
 * OR a TEXT_MOVES extension with a label-relocation key (moving `$L640:` above
 * the stolen `lui` is itself expressible as a line move).
 * Cluster (d) `lw v0,20(sp)` is the SAME object: the lw sits under $L641, which
 * only exists because of the steal -- fixing the steals fixes (d) for free.
 * SOURCE LEVERS FALSIFIED THIS WAVE (13B head-of-thread barrier does NOT reach
 * reorg's target steal here): void fence before the simVar guard 12 | before the
 * InBetween guard 12 | before the Replay_ReplayMode guard 12 | before the
 * Input_gLookBehind guard 15 @446 | both 15 | DROPPING the existing wrongway-arm
 * fence 17 @442 | that fence moved before the inner if 17 @442 | inside the inner
 * if 12 | the arm as a ternary 12 (with fence) / 17 (without).
 *
 * W77 source-only closure (2026-08-24): PASS 443/443, with all former target-
 * steal rows disabled.  A void fence immediately after the fallback absolute-
 * value normalization prevents the stolen `slt`.  A second void fence between
 * the clamp switch and the final arm.y store prevents all three later target
 * steals.  Staging `arm.y` into armY before that fence gives retail's final
 * `lw arm.y; lui/addiu Input_gLookBehind` latency fill.  The old post-cc1 recipe
 * above is retained only as mechanism history and is no longer required. */
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

  maxrate = 0x1999;
  rate = maxrate;
  {
    /* SYM-CODEGEN-CARRIER: mode -- the nested lookup must evaluate the
       Camera_gInfo base before forming the Camera_gFlags index.  A direct
       subscript is count-exact but swaps the $v0/$v1 address chain (26 diffs). */
    short mode = Camera_gInfo[player].mode;
    arm = Camera_gFlags[mode].arm;
  }
  anchor = (Car_tObj *)Camera_gInfo[player].anchor;
  rateY = 0xCCC;
  {
    /* SYM-CODEGEN-CARRIER: rev -- optimized SYM has no local row, but one
       shared reverseTrack load must dominate both arms.  Spelling the global
       directly in both tests emits 448/443 instructions and 19 diffs. */
    int rev = Camera_GameSetupWords[12];
    if (0 < anchor->wrongway) {
      lookahead = 3;
      if ((rev ^ 1) == 0) {
        lookahead = -3;
      }
    }
    else {
      lookahead = 3;
      if (rev == 0) {
        lookahead = -3;
      }
      /* MATCH (w63-a11): the un-merge fence belongs in the ELSE arm, NOT the
         wrongway arm.  Both arms end in the identical `lookahead = -3;` tail, so
         cross_jump merges them and the fn loses 3 insns (drop it entirely: 8
         diffs @441).  But an asm at the WRONGWAY arm's inner-if JOIN is also the
         head of that arm's exit label, and reorg/jump.c's thread_jumps then
         refuses to thread `bnez -> $Lexit -> j $Lmerge` (retail threads it and
         puts `li $17,-3` in the surviving j's slot).  Fencing the OTHER arm's
         tail un-merges exactly the same and leaves the wrongway arm's exit label
         asm-free => the thread fires.  12 -> 9 alone; PASS 443/443 together with
         the four PER_FN_TEXT_MOVES rows (scratchpad/w63a11/tm_helicam_spec.json).
         Priced: fence at wrongway-arm tail 12(shipped)/3(with moves) - dropped
         8@441 - before the inner if 8@441 - inside the inner if 3 - both arms 3 -
         arms swapped 7.  __volatile__ flavour and a goto-out-of-arm1 variant are
         both equivalent (9 alone / PASS with moves). */
      __asm__("" : : "i"(0));
    }
  }
  if ((Camera_SimVarWords[4] != 0) && (Camera_ReplayInterfaceWords[6] == 0)) {
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
    /* SYM-CODEGEN-CARRIER: z -- the normalized Z value must stay in a
       short-lived quantity before the speed sum.  Reusing the SYM `rate`
       variable directly is count-exact but changes 24 instructions. */
    int z = anchor->linearVel_ch.z;
    /* SYM-CODEGEN-CARRIER: ax -- both scoped absolute-X quantities preserve
       retail's raw-value/copy handoffs.  Repeating __builtin_abs directly in
       the first block emits 445/443 instructions and 26 diffs. */
    int ax = __builtin_abs(anchor->linearVel_ch.x);
    if (z < 0) {
      z = -z;
    }
    __asm__("" : : "i"(0));
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
  if (*(int *)((player << 2) + (int)Input_gLookBehind) != 0) {
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&Camera_gInfo[player].relpos.x);
  }
  {
    /* heli fallback: pull the camera back by |velocity|/20, clamped to 0x20000 */
    int z = anchor->linearVel_ch.z;
    int ax = __builtin_abs(anchor->linearVel_ch.x);
    if (z < 0) {
      z = -z;
    }
    /* MATCH: stop reorg from stealing the following slt into bgez's slot. */
    __asm__("" : : "i"(0));
    if (z < ax) {
      fallback = ax + (z >> 2);
    }
    else {
      fallback = z + (ax >> 2);
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
    /* SYM-CODEGEN-CARRIER: second -- retail keeps the normalized comparison
       sample as a pointer quantity separate from `slice`; reusing the SYM
       `slice` local for that index emits 445/443 instructions and 112 diffs. */
    char *second;
    fallback = *(int *)((slice << 5) + (int)Camera_BWorldSmSlices + 4);
    if (lookahead < 1) {
      slice = slice - lookahead;
      second = (char *)Camera_BWorldSmSlices +
          ((slice < gNumSlices ? slice : slice - gNumSlices) << 5);
    }
    else {
      slice = slice - lookahead;
      second = (char *)Camera_BWorldSmSlices +
          ((slice < 0 ? slice + gNumSlices : slice) << 5);
    }
    fallback -= *(int *)(second + 4);
    fallback = fallback / 2;
    switch (behavior) {
    case 0:
      fallback = 0;
      break;
    case 1:
      fallback = ((0x14000 < fallback ? 0x14000 : fallback) < 0x4000) ? 0x4000
          : (0x14000 < fallback ? 0x14000 : fallback);
      break;
    case 2:
      fallback = ((0x30000 < fallback ? 0x30000 : fallback) < -0xc000) ? -0xc000
          : (0x30000 < fallback ? 0x30000 : fallback);
      break;
    }
    /* SYM-CODEGEN-CARRIER: armY -- loading arm.y before the boundary leaves
       the following Input_gLookBehind high/low pair free to fill its latency
       window.  A direct `arm.y += fallback` is count-exact but leaves 2 diffs. */
    int armY = arm.y;
    /* MATCH: this boundary blocks the clamp-switch target steals. */
    __asm__("" : : "i"(0));
    arm.y = armY + fallback;
  }
  if (Input_gLookBehind[player] != 0) {
    /* audio (look-behind) arm FIRST in VA order */
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_gInfo[player].audioPos.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    Camera_gInfo[player].audioPos.y =
        ((BO_tNewtonObj *)Camera_gInfo[player].anchor)->position.y + newarm.y;
    Camera_gInfo[player].audioPos.z =
        ((BO_tNewtonObj *)Camera_gInfo[player].anchor)->position.z + newarm.z;
    arm.z = -arm.z;
    transform(&arm,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_TunnelLimit(player,&newarm.y);
    Camera_gInfo[player].position.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    Camera_gInfo[player].position.y =
        ((BO_tNewtonObj *)Camera_gInfo[player].anchor)->position.y + newarm.y;
    Camera_gInfo[player].position.z =
        ((BO_tNewtonObj *)Camera_gInfo[player].anchor)->position.z + newarm.z;
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
  Camera_gInfo[player].position.y =
      ((BO_tNewtonObj *)Camera_gInfo[player].anchor)->position.y +
      Camera_gInfo[player].relpos.y;
  Camera_gInfo[player].position.z =
      ((BO_tNewtonObj *)Camera_gInfo[player].anchor)->position.z +
      Camera_gInfo[player].relpos.z;
  /* W61-A11 REF-STEP DIAL -- DO NOT DELETE.  Zero-insn read-only fence: it adds
     exactly ONE reference to the &Camera_gInfo[player] address pseudo, taking its
     local-alloc qty from refs 15 (QTY_CMP_PRI 1.3235) to refs 16 (1.882) so it
     out-ranks the two position adds (1.3333) and wins $v0 -- retail's seat.
     Removing it puts the whole epilogue block back on the $v0<->$v1 swap (57).
     See the fn header for the qty table and the position sweep. */
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

  if ((((Camera_SimVarWords[4] == 0) || (Camera_ReplayInterfaceWords[6] != 0)) &&
      (InBetween == 0)) && (Camera_SimVarWords[2] == 0)) {
    intsincos((int)++Camera_gInfo[player].circleAngle,&sin,&cos);
    src.x = fixedmult(0x48000,cos);
    src.z = fixedmult(0x60000,sin);
    if (((int)Camera_gInfo[player].circleAngle + 0x100U & 0x1ff) == 0) {
      Camera_gInfo[player].circleCounter = Camera_gInfo[player].circleCounter + 1;
    }
    if ((((int)Camera_gInfo[player].circleAngle - 0x80) & 0x1ff) < 0x80) {
      int h0;
      int h1;
      int ang;

      h0 = circle_height[Camera_gInfo[player].circleCounter % 3];
      h1 = circle_height[(Camera_gInfo[player].circleCounter + 1) % 3];
      ang = ((int)Camera_gInfo[player].circleAngle - 0x80) & 0x7f;
      src.y = ((h1 - h0) * ang >> 7) + h0;
    }
    else {
      src.y = circle_height[Camera_gInfo[player].circleCounter % 3];
    }
    /* SYM has scoped h0/h1/ang but no hval or persistent Camera_tInfo pointer.
     * Direct src.y arms let gcc create the retail $s0 base only after their merge. */
    transform(&src,(Camera_gInfo[player].anchor->orientMat).m,&des);
    Camera_TunnelLimit(player,&des.y);
    Camera_gInfo[player].position.x = (Camera_gInfo[player].anchor->position).x + des.x;
    Camera_gInfo[player].position.y = (Camera_gInfo[player].anchor->position).y + des.y;
    Camera_gInfo[player].position.z = (Camera_gInfo[player].anchor->position).z + des.z;
  }
  return;
}

/* ---- SetCameraZoom__Fii  [@0x80081d38] ---- */
void SetCameraZoom(int player,int targetDist)
{
  /* SYM-CODEGEN-CARRIER: gs -- this private zoom result has no retained debug
   * home, but it separates the calculation/clamp web from the global store.
   * Mutating Camera_gGeomScreen directly shrinks 68 instructions to 67 and
   * produces 19 authoritative control/data-flow diffs. */
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
  /* SYM-CODEGEN-CARRIER: lastIndex -- the optimized static-array byte index
     has no retained debug name but occupies retail's s1 quantity. */
  int lastIndex;
  /* SYM-CODEGEN-CARRIER: clampedHeight -- anonymous result of the retail
     MAX(0, MIN(TVHeight, height)) expansion, carried in a2. */
  int clampedHeight;

  if (0 < Math_Dist3D(&(Camera_gInfo[player].target)->position,&Camera_gInfo[player].position)) {
    targetDist = Math_Dist3D(&(Camera_gInfo[player].target)->position,&Camera_gInfo[player].position) >> 4;
  }
  else {
    targetDist = -Math_Dist3D(&(Camera_gInfo[player].target)->position,&Camera_gInfo[player].position) >> 4;
  }
  /* @0x80081EC4-F14: TWO distinct fn-statics indexed by player*4 -- lastX[2]@0x8013DD88 and
   * lastY[2]@0x8013DD90 (8 bytes apart). The reconstruction routed every access through one
   * Ghidra-ism `*(int*)("" + iVar3)` placeholder, collapsing lastY into lastX (H43). */
  lastIndex = player * (int)sizeof(int);
  if (*(int *)((char *)lastX + lastIndex) != Camera_gInfo[player].position.x) {
    /* MATCH: void fence at the arm HEAD -- defeats reorg's eager-steal of the lastY
     * %hi into the beq's delay slot (retail leaves that slot a nop). 0 insns. */
    __asm__("" : : "i"(0));
    *(int *)((char *)lastX + lastIndex) = Camera_gInfo[player].position.x;
    *(int *)((char *)lastY + lastIndex) = Camera_gInfo[player].position.y;
  }
  height = fixedmult(Camera_gInfo[player].TVHeight >> 2,targetDist + -0x4000);
  if (Camera_gInfo[player].TVHeight < height) {
    clampedHeight = Camera_gInfo[player].TVHeight;
  } else {
    clampedHeight = height;
  }
  if (Camera_gInfo[player].TVHeight < height) {
    height = Camera_gInfo[player].TVHeight;
  }
  if (height < 0) {
    clampedHeight = 0;
  }
  Camera_gInfo[player].position.y =
      *(int *)((char *)lastY + lastIndex) + clampedHeight;
  SetCameraZoom(player,targetDist);
  return;
}

/* ---- Camera_UpdateAnimCam__Fi  [@0x80081f94] ---- */
void Camera_UpdateAnimCam(int player)
{
  coorddef animPos;    /* SYM: AUTO */
  coorddef newarm;     /* SYM: AUTO */
  matrixtdef animRot;  /* SYM: AUTO */
  /* SYM-CODEGEN-CARRIER: cVar1 -- a direct animNum post-decrement index loses
     one retail instruction and changes the acquisition sequence by 21 diffs. */
  signed char cVar1;
  /* SYM-CODEGEN-CARRIER: cVar4 -- the second direct animNum post-decrement
     index likewise loses one retail instruction and produces 21 diffs. */
  signed char cVar4;

  /* BUGFIX (H-class): animHandle is plain char (unsigned on this build) - the == -1 compare
   * was provably-false and gcc DELETED the whole re-acquire branch; (signed char) restores it */
  if ((signed char)Camera_gInfo[player].animHandle == -1) {
    /* MATCH: post-decrement in the index expr (lbu clobbers the compare's -1 reg) */
    cVar1 = (signed char)Camera_gInfo[player].animNum;
    Camera_gInfo[player].animNum = cVar1 - 1;
    Camera_gInfo[player].animHandle = (char)Anim_Handle(
        (u_int)(u_char)gAnimCams[Camera_GameSetupWords[15]][cVar1]);
  }
  if (Camera_AnimGetTimedAnimPosRot(
          Anim_GetAnim((int)(signed char)Camera_gInfo[player].animHandle),
          &animPos,&animRot) < 1) {
    /* MATCH: re-acquire arm FIRST in VA order (blez jumps away to the <1 arm) */
    if (0 < (signed char)Camera_gInfo[player].animNum) {
      Anim_FreeHandle((int)(signed char)Camera_gInfo[player].animHandle);
      cVar4 = (signed char)Camera_gInfo[player].animNum;
      Camera_gInfo[player].animNum--;
      Camera_gInfo[player].animHandle = (char)Anim_Handle(
          (u_int)(u_char)gAnimCams[Camera_GameSetupWords[15]][cVar4]);
      Camera_AnimGetTimedAnimPosRot(
          Anim_GetAnim((int)(signed char)Camera_gInfo[player].animHandle),
          &animPos,&animRot);
    }
    else {
      if (Replay_ReplayMode == 2) {
        if (numValidCams != 0) {
          Replay_ReplayFindClosestCamera(player,(int)((Camera_gInfo[player].anchor)->simRoadInfo).slice);
          return;
        }
        Camera_SetMode(player,0xb);
        Camera_gInfo[player].splineMode = '\x03';
        return;
      }
      Camera_SetMode(player,CAMERA_SETUP_CAMERA(player,0));
      return;
    }
  }
  /* BUGFIX (H-class): Ghidra rendered gAnimMode[track] as the string "\x02" (mis-render trap);
   * also dropped the Ghidra-ism & 0x1f shift-count mask */
  /* MATCH: direct-copy arm FIRST in VA order (beqz jumps to the transform arm) */
  if ((gAnimMode[Camera_GameSetupWords[15]] >> (signed char)Camera_gInfo[player].animNum & 1U) != 0) {
    Camera_gInfo[player].position = animPos;   /* struct copies -> grouped/movstrsi */
    Camera_gInfo[player].rotation = animRot;
  }
  else {
    transform(&animPos,((Camera_gInfo[player].anchor)->orientMat).m,&newarm);
    Camera_gInfo[player].position.x = ((Camera_gInfo[player].anchor)->position).x + newarm.x;
    /* MATCH: oracle re-loads anchor for the y/z pair */
    Camera_gInfo[player].position.y = Camera_gInfo[player].anchor->position.y + newarm.y;
    Camera_gInfo[player].position.z = Camera_gInfo[player].anchor->position.z + newarm.z;
    Math_fasttransmult(&animRot,&Camera_gInfo[player].anchor->orientMat,
                       &Camera_gInfo[player].rotation);
  }
  return;
}

/* ---- Camera_UpdateFinishCam__Fi  [@0x80082254] ---- */
void Camera_UpdateFinishCam(int player)
{
  coorddef finishPos;    /* SYM: AUTO @0x10 */
  coorddef newarm;       /* SYM: AUTO @0x20 */
  matrixtdef finishRot;  /* SYM: AUTO @0x30 */

  if ((signed char)Camera_gInfo[player].animHandle == -1) {
    Camera_gInfo[player].animHandle = (char)Anim_Handle(1);
  }
  if (Camera_AnimGetTimedAnimPosRot(
          Anim_GetAnim((int)(signed char)Camera_gInfo[player].animHandle),
          &finishPos,&finishRot) < 1) {
    Anim_GetLastAnimPosRot(1,6,&finishPos,&finishRot);
  }
  transform((int *)&finishPos,Camera_gInfo[player].anchor->orientMat.m,(int *)&newarm);
  Camera_gInfo[player].position.x = Camera_gInfo[player].anchor->position.x + newarm.x;
  Camera_gInfo[player].position.y = Camera_gInfo[player].anchor->position.y + newarm.y;
  Camera_gInfo[player].position.z = Camera_gInfo[player].anchor->position.z + newarm.z;
  Math_fasttransmult(&finishRot,&Camera_gInfo[player].anchor->orientMat,
                     &Camera_gInfo[player].rotation);
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
  coorddef oldarm;
  /* SYM-CODEGEN-CARRIER: mode -- the cached halfword keeps the retail
     Camera_gFlags address materialization in its scheduled slot. */
  short mode;

  mode = Camera_gInfo[player].mode;
  arm = Camera_gFlags[mode].arm;
  Camera_TunnelLimit(player,&arm.y);
  oldarm.x = Camera_gInfo[player].position.x - Camera_gInfo[player].anchor->position.x;
  oldarm.y = Camera_gInfo[player].position.y - Camera_gInfo[player].anchor->position.y;
  oldarm.z = Camera_gInfo[player].position.z - Camera_gInfo[player].anchor->position.z;
  oldarm.x = oldarm.x + fixedmult(arm.x - oldarm.x,0x1999);
  oldarm.y = oldarm.y + fixedmult(arm.y - oldarm.y,0x1999);
  oldarm.z = oldarm.z + fixedmult(arm.z - oldarm.z,0x1999);
  Camera_gInfo[player].position.x = Camera_gInfo[player].anchor->position.x + oldarm.x;
  Camera_gInfo[player].position.y = Camera_gInfo[player].anchor->position.y + oldarm.y;
  Camera_gInfo[player].position.z = Camera_gInfo[player].anchor->position.z + oldarm.z;
  return;
}

/* ---- Camera_SetSplineCam__Fi  [@0x800824c0] ---- */
void Camera_SetSplineCam(int player)
{
  Car_tObj *anchor;
  int numSlice;
  /* SYM-CODEGEN-CARRIER: sliceStep -- the separate clamp result preserves
     retail's saved-register priority cycle and 128-instruction frame shape. */
  int sliceStep;
  int direction;

  anchor = (Car_tObj *)Camera_gInfo[player].anchor;
  numSlice = (0xf * (0x10000 - camSpeedTable[(u_char)Camera_gInfo[player].splineMode])) >> 0x10;
  sliceStep = 8;
  if (numSlice + 1 < 9) {
    sliceStep = numSlice + 1;
  }
  numSlice = sliceStep;
  if (CAMERA_REPLAY_DEFAULT(player) == 0) {
    /* SYM-CODEGEN-CARRIER: cameraDirection -- retail uses an int-stride base
       for rotation.m[6..8]; direct field indexing loses two instructions and
       changes 48 oracle positions. */
    int *cameraDirection = (int *)Camera_gInfo + player * 68 + 18;
    direction = fixedmult(cameraDirection[0],anchor->N.roadMatrix.m[6]);
    if (direction +
        fixedmult(cameraDirection[1],
                  Camera_gInfo[player].anchor->roadMatrix.m[7]) +
        fixedmult(cameraDirection[2],
                  Camera_gInfo[player].anchor->roadMatrix.m[8]) < 0) {
      numSlice = -numSlice;
    }
    if (anchor->linearVel_ch.z < 0) {
      numSlice = -numSlice;
    }
    if (numSlice >= 0) {
      Camera_gInfo[player].slicePos.slice =
          (gNumSlices <= anchor->N.simRoadInfo.slice + numSlice)
              ? anchor->N.simRoadInfo.slice + numSlice - gNumSlices
              : anchor->N.simRoadInfo.slice + numSlice;
    }
    else {
      Camera_gInfo[player].slicePos.slice =
          (anchor->N.simRoadInfo.slice + numSlice < 0)
              ? anchor->N.simRoadInfo.slice + numSlice + gNumSlices
              : anchor->N.simRoadInfo.slice + numSlice;
    }
    Camera_gInfo[player].position =
         *CAMERA_SLICE_CENTER(Camera_gInfo[player].slicePos.slice);
    BWorldSm_FindClosestQuadRez(&Camera_gInfo[player].position,&Camera_gInfo[player].slicePos,1);
  }
  return;
}

/* ---- Camera_UpdateSplineCam__Fi  [@0x800826c0] ----
 * NEAR-MISS 61, ours 350 / oracle 351 (ONE short).  W60-A9 triaged four clusters
 * and confirmed (via rage-racer steer_car_to_track_line.c:187-193) that the source
 * SHAPE is right, so the residual is allocation/scheduling only.
 * W61-A11 adds the ground truth the next attempt needs:
 *  - SYM seats (VA 800826c0): anchor=REG $20 s4 | change=$6 a2 | sliceDist=$5 a1 |
 *    numSlice=$18 **s2** | direction=$16 s0 | relativeVel=$17 s1; cameraVel AUTO
 *    -0x50, splineVel -0x40, nextVel -0x30.  Ours puts numSlice in $v1 -- that is
 *    cluster 2 (insns 96-118) and it is a SEAT question, not a spelling one.
 *  - allocsim MATCHES 30/30 (order-vs-dump IDENTICAL) on this fn, and the
 *    instrumented cc1plus reproduces it BYTE-IDENTICALLY, so both the global
 *    (tools/allocsim.py + reqdelta.py) and the local-alloc qty layer
 *    (tools/qtytrace.py on scratchpad/w61a11/cam2b.trace.txt) are open here.
 *    p394 = &Camera_gInfo[player] (refs 13 live 95 pri 0.4105) currently owns $s2.
 *  - cluster 1 (insns 34-63) is a $v1<->$a0 role swap PLUS the position of
 *    `lh ,140(a0)`: retail issues the camera slice load BETWEEN the /2 chain's
 *    `addu` and `sra`, ours before the whole chain.
 *  - cluster 3 (insns 123-137) is where retail's extra insn lives: it builds a NEW
 *    base (`addu s1,v0,v1` + `addiu v1,v1,-72`) and loads 0/4/8($s1) where ours
 *    uses 72/76/80($s3).  W60-A9 falsified an early base-pointer hoist for the
 *    rotation dot (135@352) and a two-pointer form (256@351), so the +72/-72 object
 *    is NOT the rotation matrix -- identify it before re-trying.
 * The W61-A11 HeliCam seal in this same TU is the template: read the losing qty's
 * QTY_CMP_PRI off the trace and buy the seat with a floor_log2 REF-STEP (a
 * zero-insn read-only fence), sweeping the fence POSITION as a separate dial.
 * W61-A11 FALSIFIED (all INERT at 61 @350/351, do not re-sweep blind): a read-only
 * fence on `numSlice` after its camSpeedTable assignment | after the `change` if |
 * two operands there | on `direction` after its clamp | on `numSlice` before the
 * direction block.  The contested pseudos here are GLOBAL allocnos (allocsim rank
 * 16 for the &Camera_gInfo[player] base), so the priced dial is
 * `tools/reqdelta.py --want` on those allocnos, not a blind local-alloc ref-step.
 * W61-A11 also checked the W61-A1 SPILL-SLOT/declaration-order law here: the sp
 * offset SETS are identical ours-vs-oracle (0 ours-only, 0 oracle-only), so the
 * frame map already matches and that law does not apply.
 * W62-A11 LANDED 61 -> 55 (@350/351).  THE LEVER = 13A BLOCK-LOCAL ANCHOR on
 * `direction`: wrap its clamp in a block, compute into a block-local `d` that
 * DIES there, and assign `direction = d;`.  `d` becomes a local qty and takes $a2
 * (retail's `li a2,8` / `addu a2,v1,zero`), while `direction` stays the
 * call-crossing global allocno in $s2 -- and the assignment materialises as
 * retail's `addu s2,a2,zero` IN THE FIRST fixedmult DELAY SLOT, which is the
 * insn we were short there.  A ternary instead 66 @349 (one MORE short).
 * W62-A11 falsified for cluster 3: `int *rot = &Camera_gInfo[player].rotation.m[6]`
 * with rot[0..2] 135 @352 (+ the d carrier 136 @353) -- the +72/-72 object still
 * is NOT reachable by naming the rotation row.
 * W62-A11 PRICED cluster 2 AND CLOSED IT AS STRUCTURE-BOUND: with allocsim
 * MATCHING 29/29 on the landed source, our numSlice is global allocno p98
 * (refs 9, live 29, calls 0, pri 0.9310, rank 3) and it takes $v1 as the second
 * free register of find_reg's plain ascending scan.  `reqdelta --want p98=s2`
 * reports NO single-dial and NO two-dial (refs x live, +-40) solution -- retail's
 * $s2 is the 9th free register, so per the 13A UNREACHABILITY TRIAGE no priority
 * dial can reach it.  The remaining axis is `calls`: a pseudo with calls>0 is
 * scanned against call_used_reg_set and starts at $s0.  MEASURED (all much
 * WORSE, do not retry): a read-only fence on numSlice placed AFTER the fixedmult
 * block 171 @352 | after the linearVel if 171 @352 | two operands 187 @352 |
 * the same on sliceDist 163 @350.  Buying calls_crossed with a fence costs real
 * insns (the value must survive the call), so the calls dial needs a SOURCE use
 * of numSlice after the calls, not a fence -- that is the next named angle.
 *
 * W71-A21 LANDED 13 -> 8 @349/351.  Clusters 1 and 2 are GONE (the earlier waves
 * closed them); the whole residual is now cluster 3 alone, the +72/-72 object.
 * THE LEVER THAT LANDED = the splineVel/nextSlice STATEMENT ORDER SWAP in the
 * second inner block (see the MATCH note there): the anonymous global read must
 * PRECEDE the named-cursor assignment, which recovers retail's `addu v1,a1,zero`
 * copy AND the `lui/lw` before `lh ,140(s2)`.
 * CLUSTER 3 RE-PRICED FROM THE 8-BASIN -- the +72 object IS reachable, and it IS
 * the rotation row, but only with the SYMBOL-CONSTANT spelling, and it costs a
 * head recolor:
 *   `int *rotRow = (int *)((int)&Camera_gInfo[0].rotation.m[6] + player*272);`
 *   + rotRow[0..2]  ......................................... 32 @351 (COUNT EXACT)
 *      -> reproduces retail EXACTLY here: `lui v1,%hi(Camera_gInfo+72); addiu v1;
 *         addu s1,v0,v1; addiu v1,v1,-72; addu s3,v0,v1; lw a0,0/4/8(s1)`.
 *         The residual is ONE contiguous head block: {player<<4} ours $v1 vs
 *         retail $a0, {numSlice+1 carrier `d`} ours $a0 vs retail $v1, and the
 *         symbol reg ours $v0 vs retail $v1 -- i.e. the extra `rotRow` pseudo
 *         re-colors the guard head (the catalog's any-new-pseudo-recolors-head
 *         trap), NOT a structural miss.
 *   `int *rotRow = &Camera_gInfo[0].rotation.m[6] + player*68;` ....... 32 @351 (same)
 *   `int *rotRow = &Camera_gInfo[player].rotation.m[6];` ..... 41 @352 / 46 @351
 *      -> WRONG constant: gcc folds this to `&(...).rotation` (+48) and then a
 *         SEPARATE +24, so it emits `addiu v0,v0,-48` + a walking `addiu s1,s1,24`.
 *         This is why W62-A11's "the +72/-72 object is NOT the rotation matrix"
 *         reading was wrong -- it IS the rotation row; the ARRAY_REF just does not
 *         fold into the symbol constant, only a `&arr[0].f.m[k] + i*sizeof` does.
 *   inline (macro/no named variable, so the temp stays anonymous like retail's
 *   un-SYM'd $s1) ................................... 173 @352  (far worse)
 *   d-block reshapes from the 32-basin: `int d = numSlice+1; if (d>=9) d = 8;` 34,
 *   explicit if/else 32 -- neither moves the head pair.
 * => NAMED ANGLE (W71): cluster 3 is a 3-pseudo HEAD COLORING problem in the
 * 32-basin ({player<<4}=$a0, {d}=$v1, {sym}=$v1), not an address-shape problem.
 *
 * W72-A12 SEALED -- PASS 351/351.  The head recolour was NOT a priority dial; it
 * is 100% DOWNSTREAM of the pre-sched EXPAND ORDER of the two address chains, and
 * the fix is a SECOND named base pointer.  The full mechanism, receipted:
 *   1. In the 32-basin every insn of both chains has INSN_PRIORITY 1 (gcc-2.8
 *      sched.c priority(): `prev_priority = priority(x) + insn_cost - 1`, and all
 *      MIPS ALU latencies are 1), so rank_for_schedule falls through to
 *      INSN_LUID -- sched1 CANNOT reorder them.  The emitted order is therefore
 *      exactly fold()'s operand canonicalisation: an ADDR_EXPR of a static is
 *      TREE_CONSTANT, so fold puts it SECOND in the PLUS and expand_expr emits
 *      the `player*272` chain (uid 402/403) BEFORE the `high`/`lo_sum` pair
 *      (404/405).
 *   2. local-alloc then hands the registers out by QTY_CMP_PRI
 *      (floor_log2(refs)*refs*size / (death-birth)):
 *        Q_A {player*17, <<4}   refs 5, birth 0, death 6 -> 16666
 *        Q_B {high, lo_sum, -72} refs 7, birth 2, death 6 -> 35000   (Q_B first)
 *      so Q_B took $v0 and Q_A took $v1.  Retail's order (sym pair FIRST) gives
 *      Q_B birth 0 life 6 = 23333 and Q_A birth 2 life 4 = 25000 -- Q_A first,
 *      $v0, and Q_B $v1.  THAT is retail's handout.
 *   3. The global head swap is a knock-on of (2): with Q_A(p268)=$v1, global.c
 *      set_preference gives p258 {player<<4} a hard-reg preference for $v1
 *      (insn 402 is `set p268 <- plus(p258,p80)` and p268 is already renumbered
 *      by local-alloc).  find_reg's pass-0 `regs_someone_prefers` then denies
 *      $v1 to the CONFLICTING p263 {numSlice+1} -- and $v0 is already a HARD
 *      conflict for both -- so p263 falls to $a0 and p258 keeps $v1.  Flip
 *      p268 to $v0 and the preference becomes the (useless) $v0, p263 takes
 *      $v1 in pass 0 and p258 takes $a0.  One local-alloc decision, five regs.
 *   THE LEVER: give the symbol its own LIVE named base pointer, so it is a plain
 *   pseudo (not TREE_CONSTANT) at fold time and is expanded FIRST:
 *        int *rotBase = &Camera_gInfo[0].rotation.m[6];
 *        int *rotRow  = rotBase + player * 68;
 *   MEASURED, all real gate runs from the 32-basin:
 *     rotBase + player*68 (two DISTINCT variables) .............. PASS 351/351
 *     rotBase then (int)rotBase + player*272 ................... PASS 351/351
 *     ONE variable reassigned (`rotRow = &..m[6]; rotRow += n`) . 33 @352
 *       -> the base pseudo DIES into the add, so cse loses the related_value
 *          that turns `Camera_gInfo+72` into retail's `addiu v1,v1,-72`; gcc
 *          re-materialises `Camera_gInfo` with a second lui/addiu (+1 insn).
 *          A DISTINCT rotBase stays live and the -72 survives.
 *     `int *rotBase = Camera_gInfo[0].rotation.m; rotBase + player*68 + 6` 21 @352
 *     `camera_info *cam = Camera_gInfo; cam[player].rotation.m[6..8]` .. 8 @349
 *   FALSIFIED here (do not retry): operand order flip `player*272 + (int)&sym`
 *   (fold canonicalises, byte-identical 32); a read-only ref fence on a named
 *   `int off = player*272` at ANY operand count 1..10 and at either position --
 *   always 39 @352, because the asm stops reorg's backward scan and costs the
 *   first fixedmult's delay-slot fill (`addu s2,a2,zero` -> nop), while the
 *   ref dial itself never reached Q_A. */
void Camera_UpdateSplineCam(int player)
{
  Car_tObj *anchor;
  coorddef cameraVel;
  int change;
  anchor = (Car_tObj *)Camera_gInfo[player].anchor;
  change = 0;
  if (((Camera_SimVarWords[4] == 0) ||
       (Camera_ReplayInterfaceWords[6] != 0)) && (InBetween == 0)) {
    int sliceDist;
    int numSlice;

    /* MATCH (w64-a11): `gNumSlices / 2` is an ANONYMOUS temp in retail
       (`sra $a0,$v0,1` -- a caller-saved reg), not the SYM's `numSlice`
       ($s2, which only ever holds the camSpeedTable-derived step).  Assigning
       it to numSlice was a Ghidra variable-merge: it lengthened numSlice's
       range over the whole guard and cost an extra callee-saved reg + frame. */
    /* SYM-CODEGEN-CARRIER: halfSlices -- the optimized SYM has no row for the
       anonymous half-track temporary, but spelling the division twice emits
       360/351 instructions and 69 diffs instead of retail's single $a0 web. */
    int halfSlices = gNumSlices / 2;
    if ((anchor->N.simRoadInfo.slice - Camera_gInfo[player].slicePos.slice > 0) ?
        (halfSlices <
         anchor->N.simRoadInfo.slice - Camera_gInfo[player].slicePos.slice) :
        (halfSlices <
         Camera_gInfo[player].slicePos.slice - anchor->N.simRoadInfo.slice)) {
      /* MATCH (w64-a11): the SYM's `sliceDist` ($5 = $a1) is only ever assigned
         the FINAL value here -- retail computes the raw difference into its own
         temp ($v1) for the guard and for `gNumSlices - diff`.  Assigning the raw
         difference to sliceDist first merged the two into one register. */
      if (anchor->N.simRoadInfo.slice - Camera_gInfo[player].slicePos.slice > 0) {
        sliceDist = gNumSlices -
            (anchor->N.simRoadInfo.slice - Camera_gInfo[player].slicePos.slice);
      } else {
        sliceDist = gNumSlices -
            (Camera_gInfo[player].slicePos.slice - anchor->N.simRoadInfo.slice);
      }
    } else {
      sliceDist = anchor->N.simRoadInfo.slice - Camera_gInfo[player].slicePos.slice;
      if (sliceDist <= 0) {
        sliceDist = Camera_gInfo[player].slicePos.slice - anchor->N.simRoadInfo.slice;
      }
    }

    numSlice = (0x10000 -
        camSpeedTable[(u_char)Camera_gInfo[player].splineMode]) * 0xf >> 0x10;
    if ((numSlice + 2 < sliceDist) &&
        (camSpeedTable[(u_char)Camera_gInfo[player].splineMode] < 0x10000)) {
      change = 1;
    }

    if ((change != 0) && (CAMERA_REPLAY_DEFAULT(player) == 0)) {
      int direction;

      {
        /* SYM-CODEGEN-CARRIER: d -- this block-local selector dies before the
           fixedmult chain, leaving the call-crossing step in retail's $s2.
           A direct ternary emits 350/351 instructions and 13 diffs. */
        int d = 8;
        if (numSlice + 1 < 9) {
          d = numSlice + 1;
        }
        numSlice = d;
      }
      /* MATCH (w64-a11 VARIABLE IDENTITY): the SYM names the DOT PRODUCT
         `direction` ($16 = $s0 -- the oracle accumulates the three fixedmult
         results in $s0 and tests it with `bgez $s0`), while the CLAMPED STEP
         stays in `numSlice` ($18 = $s2, negated in place by `negu $s2,$s2` and
         tested by `bltz $s2`).  Our recon had the two roles swapped, which is
         why numSlice never crossed a call (calls=0 -> $v1) -- as the step it
         now lives across all three fixedmult calls and lands in retail's seat. */
      {
      /* MATCH (W72-A12, 8 -> PASS): rotBase MUST be its own live variable rather
         than a direct Camera_gInfo[player] row -- it makes the symbol a plain
         pseudo at fold time so
         `high`/`lo_sum` expand BEFORE the player*272 chain (retail's order, which
         sched1 cannot produce: every insn here has INSN_PRIORITY 1), and it stays
         live so cse still derives `Camera_gInfo` from `Camera_gInfo+72` as retail's
         `addiu v1,v1,-72`.  Full mechanism + falsifications in the header block.
         SYM-CODEGEN-CARRIER: rotBase -- the best direct camera-info row spelling
         emits 349/351 instructions and 8 diffs; the optimized SYM has no row for
         this fold-order carrier. */
      int *rotBase = &Camera_gInfo[0].rotation.m[6];
      direction = fixedmult((rotBase + player * 68)[0],
                            Camera_gInfo[player].anchor->roadMatrix.m[6]) +
                  fixedmult((rotBase + player * 68)[1],
                            Camera_gInfo[player].anchor->roadMatrix.m[7]) +
                  fixedmult((rotBase + player * 68)[2],
                            Camera_gInfo[player].anchor->roadMatrix.m[8]);
      }
      if (direction < 0) {
        numSlice = -numSlice;
      }
      if (anchor->linearVel_ch.z < 0) {
        numSlice = -numSlice;
      }
      if (numSlice >= 0) {
        /* SYM-CODEGEN-CARRIER: newSlice -- both branch-local short results
           preserve retail's signed/unsigned load split and in-place wrap.
           Ternary field assignments stay 351/351 but cost 42 diffs. */
        short newSlice = anchor->N.simRoadInfo.slice + numSlice;
        if ((short)anchor->N.simRoadInfo.slice + numSlice >= gNumSlices) {
          newSlice -= (u_short)gNumSlices;
        }
        Camera_gInfo[player].slicePos.slice = newSlice;
      } else {
        short newSlice = anchor->N.simRoadInfo.slice + numSlice;
        if ((short)anchor->N.simRoadInfo.slice + numSlice < 0) {
          newSlice = (u_short)gNumSlices + newSlice;
        }
        Camera_gInfo[player].slicePos.slice = newSlice;
      }
      Camera_gInfo[player].position =
          *CAMERA_SLICE_CENTER(Camera_gInfo[player].slicePos.slice);
      BWorldSm_FindClosestQuadRez(&Camera_gInfo[player].position,
                                  &Camera_gInfo[player].slicePos,1);
    } else {
      BWorldSm_FindClosestQuadRez(&Camera_gInfo[player].position,
                                  &Camera_gInfo[player].slicePos,1);
    }
    {
      coorddef splineVel;
      coorddef nextVel;
      int relativeVel;
      /* SYM-CODEGEN-CARRIER: nextSliceIdx -- materializing the anonymous
         slice+1 step separately is required for the retail $a1/$v1 copy and
         load order; two direct expressions emit 352/351 and 27 diffs. */
      int nextSliceIdx;

      /* MATCH: read splineVel from the global first, then form nextSliceIdx.
         The direct conditional pointer below removes the old non-SYM
         `nextSlice` cursor while preserving retail's global-load/copy order.
         Moving nextSliceIdx above the splineVel read remains 16 diffs at 347
         instructions; reading splineVel through a named cursor is 13 at 348. */
      splineVel = *CAMERA_SLICE_CENTER(Camera_gInfo[player].slicePos.slice);
      nextSliceIdx = Camera_gInfo[player].slicePos.slice + 1;
      nextVel = *(coorddef *)(nextSliceIdx < gNumSlices ?
          Camera_BWorldSmSlices + nextSliceIdx : Camera_BWorldSmSlices);
      splineVel.x = nextVel.x - splineVel.x;
      splineVel.y = nextVel.y - splineVel.y;
      splineVel.z = nextVel.z - splineVel.z;
      Math_NormalizeVector(&splineVel);
      relativeVel = fixedmult(anchor->N.linearVel.x,splineVel.x) +
                    fixedmult(anchor->N.linearVel.y,splineVel.y) +
                    fixedmult(anchor->N.linearVel.z,splineVel.z);
      if ((Camera_GameSetupWords[14] & 4U) != 0) {
        relativeVel = fixedmult(relativeVel,0xcccc);
      }
      relativeVel = fixedmult(relativeVel,
          camSpeedTable[(u_char)Camera_gInfo[player].splineMode]);
      cameraVel.x = fixedmult(relativeVel,splineVel.x);
      cameraVel.y = fixedmult(relativeVel,splineVel.y);
      cameraVel.z = fixedmult(relativeVel,splineVel.z);
    }

    Camera_gInfo[player].position.x += cameraVel.x >> 6;
    Camera_gInfo[player].position.y += cameraVel.y >> 6;
    Camera_gInfo[player].position.z += cameraVel.z >> 6;
    SetCameraZoom(player,
        Math_Dist3D(&Camera_gInfo[player].target->position,
                    &Camera_gInfo[player].position) > 0 ?
        Math_Dist3D(&Camera_gInfo[player].target->position,
                    &Camera_gInfo[player].position) >> 4 :
        -Math_Dist3D(&Camera_gInfo[player].target->position,
                     &Camera_gInfo[player].position) >> 4);
  }
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
  /* MATCH (PASS/223): direct Camera_gInfo[player] expressions rematerialize the
   * base at retail's access sites.  Earlier staged cameraBase/cameraInfo aliases
   * were unnecessary once the full expression chain was restored. */
  coorddef sCenter;   /* SYM: AUTO @0x10 */
  coorddef sForward;  /* SYM: AUTO @0x20 */
  coorddef sRight;    /* SYM: AUTO @0x30 */
  coorddef sccVec;    /* SYM: AUTO @0x40 */
  coorddef newarm;    /* SYM: AUTO @0x50 */
  int ySign;          /* SYM: REG */
  /* SYM-CODEGEN-CARRIER: side -- retaining the road-frame cross product before
     the profile call preserves retail's live range and 223-instruction body. */
  int side;

  if (((Camera_SimVarWords[4] == 0) || (Camera_ReplayInterfaceWords[6] != 0)) &&
     (InBetween == 0)) {
    /* SYM-CODEGEN-CARRIER: gameTicks -- the separate snapshot keeps retail's
       SimGlobal address materialization in v0 instead of a0. */
    int gameTicks;

    SetGeomScreen(0xbe);
    /* MATCH: separate tick/index values keep Camera_gInfo[player] itself in s1. */
    gameTicks = Camera_SimGlobalWords[1];
    if (gameTicks < Camera_gInfo[player].POInhibitor) {
      Camera_UpdateCopCam2(player);
      return;
    }
    /* MATCH: full slice expression REMATERIALIZED per access (no cached slice ptr) */
    sCenter = *CAMERA_SLICE_CENTER(Camera_gInfo[player].anchor->simRoadInfo.slice);
    sForward.x = CAMERA_SLICE_FORWARD(Camera_gInfo[player].anchor->simRoadInfo.slice,0) << 9;
    sForward.y = CAMERA_SLICE_FORWARD(Camera_gInfo[player].anchor->simRoadInfo.slice,1) << 9;
    sForward.z = CAMERA_SLICE_FORWARD(Camera_gInfo[player].anchor->simRoadInfo.slice,2) << 9;
    sccVec.x = Camera_gInfo[player].anchor->position.x - sCenter.x;
    sccVec.y = Camera_gInfo[player].anchor->position.y - sCenter.y;
    sccVec.z = Camera_gInfo[player].anchor->position.z - sCenter.z;
    sRight.x = CAMERA_SLICE_RIGHT(Camera_gInfo[player].anchor->simRoadInfo.slice,0) << 0xb;
    sRight.y = CAMERA_SLICE_RIGHT(Camera_gInfo[player].anchor->simRoadInfo.slice,1) << 0xb;
    sRight.z = CAMERA_SLICE_RIGHT(Camera_gInfo[player].anchor->simRoadInfo.slice,2) << 0xb;
    side = fixedmult(sccVec.z,sForward.x) - fixedmult(sccVec.x,sForward.z);
    ySign = Camera_IslandProfile(CAMERA_SLICE_PAVED_PROFILE(Camera_gInfo[player].anchor->simRoadInfo.slice));
    /* w62-a11 PRODUCTION-LANE FIX (psyqproof REAL 1 -> 0).  The shipped form
       `if (iVar3 < 0) { ySign = ySign != 1; }` put BOTH the xori and the 0/1
       renormalising `sltu v0,zero,v0` inside the guard, so our `bgez $s0`
       skipped 3 insns where retail skips 2 (word 146 @0x80082EDC: ours
       0x06010003 vs retail 0x06010002).  verify_asm normalises branch TARGETS,
       so the testing gate called it PASS -- only the ASPSX word compare saw it.
       The ternary puts the `!= 0` on the SHARED result, so the sltu falls
       through on both arms exactly like retail.  Falsified alternatives (all
       222 insns = one SHORT, gcc drops the redundant sltu): `ySign ^= 1` in the
       guard with the test alone / with a separate `ySign = ySign != 0;` /
       with `(ySign != 0) != 0` in the test. */
    ySign = ((side < 0) ? (ySign ^ 1) : ySign) != 0;
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
  coorddef dirVec;

  dirVec.x = (Camera_gInfo[player].target->position.x -
              Camera_gInfo[player].anchor->position.x) / 4;
  dirVec.y = (Camera_gInfo[player].target->position.y -
              Camera_gInfo[player].anchor->position.y) / 4;
  dirVec.z = (Camera_gInfo[player].target->position.z -
              Camera_gInfo[player].anchor->position.z) / 4;
  Math_NormalizeVector(&dirVec);
  Camera_gInfo[player].position.x = Camera_gInfo[player].anchor->position.x + dirVec.x * -2;
  Camera_gInfo[player].position.y = Camera_gInfo[player].anchor->position.y + 0x13333;
  Camera_gInfo[player].position.z = Camera_gInfo[player].anchor->position.z + dirVec.z * -2;
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
  Camera_gInfo[player].POInhibitor = Camera_SimGlobalWords[1] + 0x140;
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
  /* MATCH (56 -> PASS): IDA's retail handout is player=s3, Camera_gInfo walk=s2,
   * replay offset=fp, human-car walk=s6, rotation row=s5, and 0xf7ffffff=s7.
   * SLD line 1781 identifies the natural loop header; keeping player=0 as a
   * separate statement lands the retail walks. Pin-free identity fences on
   * isInCar and the scoped call argument prevent known-bool folding and place
   * the decrement in jal's slot. The PS1-fork field-anchored-walk idiom closes
   * the final floor: a named cameraBase + 72 rotationBase makes GCC derive s5
   * from s2 and schedule all five loop-back increments exactly; spelling the
   * same address directly canonicalizes to s5=s2 plus 72/76/80 load offsets.
   * Falsified basins: explicit camera walk=266; swapped increment order=81;
   * camera-base identity fence=40; inner rotation pointer=34/43/44;
   * anonymous shifted-base expression=8; alias+row identity=24. */
  /* SYM-CODEGEN-CARRIER: inCarMask -- inlining 0xf7ffffff preserves 288
     instructions but changes 44 allocation/scheduling words. */
  unsigned int inCarMask;
  int player;
  /* SYM-CODEGEN-CARRIER: cameraBase -- direct Camera_gInfo expressions add
     two instructions and leave four diffs (290/288). */
  camera_info *cameraBase;
  /* SYM-CODEGEN-CARRIER: rotationBase -- direct rotation.m[6..8] member
     access loses three instructions and produces 49 diffs (285/288). */
  camera_info *rotationBase;

  player = 0;
  inCarMask = 0xf7ffffff;
  cameraBase = Camera_gInfo;
  rotationBase = (camera_info *)((char *)cameraBase + 72);
  for (; player <= cameraBase[0].splitscreen;
       player++) {
    {
    Car_tObj *anchor;

    anchor = (Car_tObj *)Camera_gInfo[player].anchor;
    if (Camera_gInfo[player].checkcollisions != 0) {
      if (Camera_gInfo[player].tumbling != 0) {
        /* SYM-CODEGEN-CARRIER: collisionPlayer -- passing player directly
           preserves 288 instructions but changes four scheduled words. */
        int collisionPlayer;
        collisionPlayer = player;
        __asm__("" : "=r"(collisionPlayer) : "0"(collisionPlayer));
        Camera_gInfo[player].tumbling--;
        Camera_UpdateCollisionCam(collisionPlayer);
        goto LAB_80083584;
      }
      if (anchor->N.orientationToGround.y < 0x8000) {
        int direction;

        direction =
            fixedmult(((int *)&rotationBase[player])[0],
                      anchor->N.roadMatrix.m[6]) +
            fixedmult(((int *)&rotationBase[player])[1],
                      ((Car_tObj *)Camera_gInfo[player].anchor)->N.roadMatrix.m[7]) +
            fixedmult(((int *)&rotationBase[player])[2],
                      ((Car_tObj *)Camera_gInfo[player].anchor)->N.roadMatrix.m[8]);
        Camera_gInfo[player].direction = direction < 0;
        Camera_gInfo[player].tumbling = 100;
      }
    }
LAB_80083500:
      if (((anchor->carFlags & 1U) != 0) && (anchor->stats.finishType == 2)) {
        Camera_UpdateFinishCam(player);
        goto LAB_80083584;
      }
      if (0 < (int)Camera_gInfo[player].forceFocus) {
        Camera_UpdateBTCopCam(player);
        goto LAB_80083584;
      }
      if ((Cars_gHumanRaceCarList[player]->pullOver != 0) &&
          (Cars_gHumanRaceCarList[player]->stats.finishType != 3)) {
        Camera_UpdatePulloverCam(player);
LAB_80083584:
        {
        /* SYM-CODEGEN-CARRIER: bitsInfo -- direct indexed bit-word access
           adds eight instructions and produces 64 diffs (296/288). */
        camera_info *bitsInfo;
        bitsInfo = &Camera_gInfo[player];
        *(unsigned int *)((char *)bitsInfo + 116) =
            (*(unsigned int *)((char *)bitsInfo + 116) & inCarMask) | 1;
        }
        goto LAB_80083810;
      }
      if (Camera_gInfo[player].modechange != 0) {
        camera_info *bitsInfo;
        camera_flags *flagMode;
        /* SYM-CODEGEN-CARRIER: isInCar -- natural bitfield assignments add
           two instructions and leave 16 diffs in their best ordering. */
        int isInCar;
        /* SYM-CODEGEN-CARRIER: modeBits -- the single-word bitfield update
           is required for retail's 288-instruction combined mask/store. */
        unsigned int modeBits;

        bitsInfo = &Camera_gInfo[player];
        flagMode = &Camera_gFlags[Camera_gInfo[player].mode];
        Camera_gInfo[player].pitch = flagMode->pitch;
        Camera_gInfo[player].jostling = flagMode->jostling;
        Camera_gInfo[player].tracking = flagMode->tracking;
        Camera_gInfo[player].checkwalls = flagMode->checkwalls;
        Camera_gInfo[player].noLookBack = flagMode->noLookBack;
        Camera_gInfo[player].checkcollisions = flagMode->checkcollisions;
        modeBits = *(unsigned int *)((char *)bitsInfo + 116);
        modeBits &= inCarMask;
        isInCar = bitsInfo->mode < 2;
        modeBits |= (unsigned int)isInCar << 27;
        modeBits &= ~1U;
        *(unsigned int *)((char *)bitsInfo + 116) = modeBits;
        Camera_gInfo[player].anchor = &Cars_gHumanRaceCarList[player]->N;
        Camera_gInfo[player].target = &Cars_gHumanRaceCarList[player]->N;
        if ((1 < Replay_ReplayMode) &&
            (CAMERA_REPLAY_MODE(player) == 0x13)) {
          Replay_ReplayFindClosestCamera(player,(int)(Camera_gInfo[player].anchor->simRoadInfo).slice);
        }
      }
      /* ============================================================================
       * PC MODE-ENUM DECODE (w30-a8, 2026-07-26) -- pcmap/map_a6.txt flagged this as the
       * highest-leverage open item for camera.cpp. PC dispatches through sub_4414E0
       * (nfs4-pc.c L63426, window 0x43A620-0x441C3F; Camera_Update twin = sub_441A00).
       * PSX's 19-mode switch below is this function's ONLY oracle; the table records PC's
       * 25-mode dispatch and what body-content evidence (not index arithmetic) says about
       * each PC mode's relationship to a PSX case, so a future pass doesn't re-derive it.
       *
       *  PSX mode -> handler (this switch)      PC mode -> sub_4414E0 case -> handler
       *  0,1  Camera_UpdateBumperCam             0   (falls to default -- no dispatch)
       *  2    Camera_UpdateTailCam(behavior=0)    1   sub_43E3B0  (falls back to sub_43E5D0
       *  3    Camera_UpdateTailCam(behavior=1)        in the common case; PC-only smooth-turn
       *  4    Camera_UpdateTailCam(behavior=2)        variant gated on dword_7CBACC/replay
       *                                               state -- no PSX candidate)
       *  5    Camera_UpdateHeliCam(behavior=0)    2   sub_43E5D0  = Camera_UpdateBumperCam
       *  6    Camera_UpdateHeliCam(behavior=1)        [HIGH, upgraded this session from
       *  7    Camera_UpdateHeliCam(behavior=2)        map_a6's TENTATIVE]: default case is a
       *                                               plain 9-word orientMat copy (matches
       *                                               PSX's not-looking-behind else-branch);
       *                                               dword_661968==1 case calls the CONFIRMED
       *                                               Camera_LookBack twin sub_43A8A0 (matches
       *                                               PSX's looking-behind branch); cases 2/3
       *                                               call quarter-turn helpers sub_43A930/
       *                                               sub_43A960 (look-left/right -- a PC-only
       *                                               extension outside the PSX 19-mode enum)
       *                                          3,5 sub_43EE70  (paired) NOT-FOUND
       *                                          4,6 sub_43E7D0  (paired) NOT-FOUND
       *                                          7   sub_43F2C0  NOT-FOUND
       *  8,9,15 Camera_UpdateSimpleCam            8   sub_43FB50  NOT-FOUND (callee set nearly
       *                                               identical to case14's sub_4408D0 -- a
       *                                               sibling pair, same family)
       *                                          9   sub_440B50  NOT-FOUND (calls sub_43E5D0
       *                                               itself -- bumper-cam-family relative)
       *  10   Camera_UpdateCircleCam             10   sub_440550  NOT-FOUND
       *  11   Camera_UpdateSplineCam             11,13 sub_4406C0 (paired) NOT-FOUND
       *  12   Camera_UpdateTVCam                 12   sub_440770  NOT-FOUND (calls sub_4406C0
       *                                               internally)
       *  13   Camera_UpdateBlimpCam              14   sub_4408D0  NOT-FOUND (sibling of case8)
       *  14   Camera_UpdateAnimCam               15   (falls to default -- no dispatch)
       *                                          16   sub_440030  NOT-FOUND; 198-line driver
       *                                               that calls the SAME pre/post hooks
       *                                               sub_41E9F0/sub_41EB40 as the top-level
       *                                               Camera_Update twin sub_441A00 -- a
       *                                               per-frame ROOT updater, not a single
       *                                               mode body; structurally unlike PSX's
       *                                               small CopCam1
       *                                          17   sub_440300  NOT-FOUND (calls sub_43A990,
       *                                               one of the 6 inlined Camera_GetMode sites)
       *                                          18   sub_43FD10  NOT-FOUND; calls the
       *                                               Camera_SetMode twin sub_43DB90 AND
       *                                               re-enters sub_4414E0 itself -- a
       *                                               MODE-TRANSITION handler, not steady-state
       *  16   Camera_UpdateCopCam1                19   sub_4410C0  TENTATIVE per map_a6
       *                                               ("attached/spline" view); same
       *                                               transition shape as case 18 (calls
       *                                               sub_43DB90 + sub_4414E0)
       *  17,18 Camera_UpdateCopCam2               20   sub_4410A0  NOT-FOUND; 6-line stub
       *                                          21   sub_43EBC0  NOT-FOUND
       *                                          22   (falls to default -- no dispatch)
       *                                          23   sub_43F4A0  NOT-FOUND
       *                                          24   sub_43F630  NOT-FOUND (calls sub_43E5D0
       *                                               -- another bumper-cam-family relative)
       *
       * NEGATIVE FINDING (confirmed this session, do not re-attempt naive index mapping):
       * PC pairs modes (3,5)->sub_43EE70 and (4,6)->sub_43E7D0. PSX groups 2,3,4 into ONE
       * function (TailCam, behavior 0/1/2) and 5,6,7 into a DIFFERENT ONE function (HeliCam,
       * behavior 0/1/2). No renumbering of the 25 PC modes reproduces the PSX 3+3 grouping --
       * PC's mode pairs cut ACROSS the tail/heli boundary, so TailCam/HeliCam need a
       * content-only match, not index arithmetic. Both sub_43EE70 (389 lines) and sub_43E7D0
       * (370 lines) are heavy with raw FPU-stack __asm blocks Hex-Rays failed to decompile
       * (fld/fmul/fxch/fstp sequences) -- unread within this session's budget; hand-floatizing
       * those blocks is the concrete next step to close Camera_UpdateTailCam/HeliCam.
       *
       * Also: PC's sub_441670 (nfs4-pc.c L63528) buckets the raw mode id into a 4-state "look"
       * enum (0=straight,1=behind,2/3=side) stored in dword_661968[] -- consumed by sub_43E5D0's
       * and sub_43E3B0's switches (and probably sub_440B50/sub_43F630, both of which also call
       * sub_43E5D0). This is PC's generalized replacement for PSX's per-family
       * Input_gLookBehind-check + LookBack-call and does NOT correspond to any single PSX mode
       * value -- don't mistake it for a 4-way PSX enum split.
       * ============================================================================ */
      __asm__("" : "=r"(inCarMask) : "0"(inCarMask), "r"(inCarMask));
      switch(Camera_gInfo[player].mode) {
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
      /* MATCH (W65-A3, calltarget): the SimpleCam group is emitted LAST of this
       * run, not first -- the oracle's jal order is Circle, Spline, TV, Blimp,
       * Anim, Simple, CopCam1 (case BODIES emit in SOURCE order, catalog D).
       * With the group written first, every one of those six jals pointed at the
       * WRONG handler after link: 6 audit rows in one cyclic shift.  Writing it
       * here is also the natural 1998 shape -- the group is placed where its
       * LAST label (0xf) belongs. */
      case 8:
      case 9:
      case 0xf:
        Camera_UpdateSimpleCam(player);
        break;
      case 0x10:
        Camera_UpdateCopCam1(player);
        break;
      case 0x11:
      case 0x12:
        Camera_UpdateCopCam2(player);
      }
    goto LAB_80083810;
    }
LAB_80083810:
    ;
  }
}

/* ---- Camera_Init__Fv  [@0x80083858] ---- */
void Camera_Init(void)
{
  int splitScreen;
  BWorldSm_Pos slicePos;
  int localCar;
  int i;
  int type;
  
  splitScreen = Camera_GameSetupWords[3] == 1;
  memset((u_char *)&slicePos,'\0',sizeof(slicePos));
  for (i = 0; i <= splitScreen; i++) {
    localCar = i;
    if (splitScreen == 0) {
      localCar = Camera_GameSetupWords[7];
    }
    Camera_gInfo[i].anchor = &Cars_gHumanRaceCarList[localCar]->N;
    Camera_gInfo[i].target = &Cars_gHumanRaceCarList[localCar]->N;
    Camera_gInfo[i].position = Camera_gInfo[i].anchor->position;
    Camera_gInfo[i].audioPos = Camera_gInfo[i].anchor->position;
    Camera_gInfo[i].TVHeight = 0;
    Camera_gInfo[i].rotation = Camera_gInfo[i].anchor->orientMat;
    Camera_gInfo[i].twist = 0;
    Camera_gInfo[i].wallLeft = Camera_gInfo[i].anchor->position;
    Camera_gInfo[i].wallRight = Camera_gInfo[i].anchor->position;
    Camera_gInfo[i].mode = 0xe;
    Camera_gInfo[i].camNum = 0;
    Camera_gInfo[i].modechange = 0;
    Camera_gInfo[i].pitch = 0;
    Camera_gInfo[i].jostling = 0;
    Camera_gInfo[i].tracking = 0;
    Camera_gInfo[i].checkwalls = 0;
    Camera_gInfo[i].noLookBack = 1;
    Camera_gInfo[i].checkcollisions = 0;
    Camera_gInfo[i].splitscreen = splitScreen;
    Camera_gInfo[i].intransition = '\0';
    Camera_gInfo[i].tumbling = '\0';
    Camera_gInfo[i].direction = 0;
    Camera_gInfo[i].zooming = 0;
    Camera_gInfo[i].inCar = 0;
    Camera_gInfo[i].circleCounter = 0;
    Camera_gInfo[i].circleAngle = 0;
    Camera_gInfo[i].animNum = gAnimCams[Camera_GameSetupWords[15]][0];
    if (((Camera_GameSetupWords[0] == RaceType_HotPursuit) || (Camera_GameSetupWords[0] == RaceType_Id5)) &&
       ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
        ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
      Camera_gInfo[i].animNum = '\x01';
    }
    Camera_gInfo[i].animHandle = -1;
    Camera_gInfo[i].splineMode = '\0';
    Camera_gInfo[i].forceFocus = 0;
    Camera_gInfo[i].focusOnAICar = -1;
    Camera_gInfo[i].POInhibitor = 0x40;
    Camera_gInfo[i].slicePos = slicePos;
  }
  Camera_ResetRelPos(3);
  type = *(*(int **)((char *)Cars_gHumanRaceCarList[0] + 0x288));
  Camera_gGeomScreen = 0xbe;
  if (((type < 0x1c) && ((Camera_GameSetupWords[14] & 0x100U) != 0)) && (splitScreen == 0)) {
    CAMERA_SETUP_CAMERA(0,0) = 1;
    Camera_gFlags[1].arm = gDriverCam[type];
                    
                    
                    
  }
  return;
}

/* ---- Camera_Kill__Fv  [@0x80083bec] ---- */
void Camera_Kill(void)
{
  int i;            /* SYM: REG i INT */
  int splitScreen;  /* SYM: REG splitScreen INT */

  splitScreen = Camera_GameSetupWords[3] == 1;
  /* MATCH: index form (SYM has NO pointer local) — gcc strength-reduces to the s0+=0x110 walk
   * keeping animHandle's 0x7D displacement; a hand pointer-walk folds base+125 into the biv */
  for (i = 0; i <= splitScreen; i = i + 1) {
    if ((signed char)Camera_gInfo[i].animHandle != -1) {
      Anim_FreeHandle((int)(signed char)Camera_gInfo[i].animHandle);
    }
    Camera_gInfo[i].animHandle = -1;
  }
  return;
}

/* ---- Camera_PitchAndRoll__Fi  [@0x80083c74] ---- */
void Camera_PitchAndRoll(int player)
{
  matrixtdef m1;
  matrixtdef m2;
  matrixtdef m3;
  Car_tObj *anchor;
  int pitch;
  
  anchor = (Car_tObj *)Camera_gInfo[player].anchor;
  pitch = anchor->render.bodyPitch;
  pitch = pitch << 1;   /* MATCH: separate stmt -> sll lands in fixedxformz's jal delay slot */
  fixedxformz((int)&m1,(int *)anchor->render.bodyRoll);
  fixedxformx((int)&m2,
             (int *)(pitch | Camera_gInfo[player].pitch));
  Math_fasttransmult(&m1,&m2,&m3);
  Math_fasttransmult(&m3,&Camera_gInfo[player].rotation,&Camera_gInfo[player].rotation);
  return;
}

/* ---- Camera_TooSteep__FiP12BWorldSm_Pos  [@0x80083d28] ---- */
int Camera_TooSteep(int player,BWorldSm_Pos *slicePos)
{
  coorddef normUnderCam;    /* SYM: AUTO */
  coorddef normUnderCar;    /* SYM: AUTO */
  coorddef camToCar;        /* SYM: AUTO */
  BWorldSm_Pos *slicePos2;  /* SYM: REG (anchor+8, addiu s0,s0,8 in the 1st jal slot) */

  slicePos2 = &(Camera_gInfo[player].anchor)->simRoadInfo;
  normUnderCam = *(coorddef *)BWorldSm_UNormal(slicePos);
  normUnderCar = *(coorddef *)BWorldSm_UNormal(slicePos2);
  if (0xb4fc < fixedmult(normUnderCam.x,normUnderCar.x) +
               fixedmult(normUnderCam.y,normUnderCar.y) +
               fixedmult(normUnderCam.z,normUnderCar.z)) {
    return 0;   /* MATCH: direct returns - v0=0/1 staged in branch delay slots, no result var */
  }
  camToCar.x = Camera_gInfo[player].anchor->position.x - Camera_gInfo[player].position.x;
  camToCar.y = Camera_gInfo[player].anchor->position.y - Camera_gInfo[player].position.y;
  camToCar.z = Camera_gInfo[player].anchor->position.z - Camera_gInfo[player].position.z;
  if (0 < fixedmult(normUnderCam.x,camToCar.x) +
          fixedmult(normUnderCam.y,camToCar.y) +
          fixedmult(normUnderCam.z,camToCar.z)) {
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
  
  /* MATCH: plain struct assignment -> gcc movstrsi copy (Ghidra hand-expanded it as a loop) */
  slicePos = Camera_gInfo[player].slicePos;
  /* MATCH: reuse camAngle so this loop index and its strength-reduced pointer take retail s1/s0. */
  for (camAngle = 0; camAngle < 3; camAngle++) {
    transform(feeler3 + camAngle,Camera_gInfo[player].anchor->orientMat.m,&triVec);
    triPnt.x = pos->x + triVec.x;
    triPnt.y = pos->y + triVec.y;
    triPnt.z = pos->z + triVec.z;
    BWorldSm_FindClosestQuadMaxIterations(&triPnt,&slicePos,3);
    /* MATCH: simQuad!=0 arm FIRST (struct copies), surface check as a SEPARATE re-test if */
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      quadUnderCamera = slicePos.quadPts[0];
    }
    else {
      quadUnderCamera = *CAMERA_SLICE_CENTER(slicePos.slice);
    }
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      if (((slicePos.simQuad)->surface & 0xf) == 0) break;
    }
    if ((((signed char)slicePos.offEdge != 0) ||
        (Camera_TooSteep(player,&slicePos) != 0)) ||
       ((slicePos.simQuad != (Trk_NewSimQuad *)0x0 &&
        ((((slicePos.simQuad)->surface & 0x80) != 0 &&
         (0x38000 < quadUnderCamera.y - Camera_gInfo[player].anchor->position.y)))))) break;
  }
  if (camAngle == 3) {
    return;
  }
  count = 0;
  step.x = Camera_gInfo[player].anchor->position.x - triPnt.x;
  step.y = Camera_gInfo[player].anchor->position.y - triPnt.y;
  step.z = Camera_gInfo[player].anchor->position.z - triPnt.z;
  edge = Camera_gInfo[player].anchor->position;
  step.x >>= 7;
  step.y >>= 7;
  step.z >>= 7;
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
      quadUnderCamera = *CAMERA_SLICE_CENTER(slicePos.slice);
    }
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      if (((slicePos.simQuad)->surface & 0xf) == 0) break;
    }
    if ((((signed char)slicePos.offEdge != 0) ||
         (Camera_TooSteep(player,&slicePos) != 0)) ||
        ((slicePos.simQuad != (Trk_NewSimQuad *)0x0) &&
         (((slicePos.simQuad)->surface & 0x80) != 0) &&
         (0x38000 < quadUnderCamera.y - Camera_gInfo[player].anchor->position.y))) break;
    count++;
  } while (count < 0x80);
  camAngle = 1;
  step.x = Camera_gInfo[player].anchor->position.x - edge.x;
  step.y = Camera_gInfo[player].anchor->position.y - edge.y;
  step.z = Camera_gInfo[player].anchor->position.z - edge.z;
  step.x >>= 1;
  step.y >>= 1;
  step.z >>= 1;
  do {
    intsincos(camAngle,&sin,&cos);
    temp.x = fixedmult(cos,step.x) - fixedmult(sin,step.z);
    temp.y = step.y;
    temp.z = fixedmult(sin,step.x) + fixedmult(cos,step.z);
    temp.x = edge.x + temp.x;
    temp.y = edge.y + temp.y;
    temp.z = edge.z + temp.z;
    BWorldSm_FindClosestQuadMaxIterations(&temp,&slicePos,3);
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      quadUnderCamera = slicePos.quadPts[0];
    }
    else {
      quadUnderCamera = *CAMERA_SLICE_CENTER(slicePos.slice);
    }
    if (((slicePos.simQuad != (Trk_NewSimQuad *)0x0) &&
         (((slicePos.simQuad)->surface & 0xf) == 0)) ||
        ((signed char)slicePos.offEdge != 0) ||
        (Camera_TooSteep(player,&slicePos) != 0) ||
        ((slicePos.simQuad != (Trk_NewSimQuad *)0x0) &&
         (((slicePos.simQuad)->surface & 0x80) != 0) &&
         (0x38000 < quadUnderCamera.y - Camera_gInfo[player].anchor->position.y))) {
      Camera_gInfo[player].wallLeft = temp;
      break;
    }
    camAngle = camAngle + 4;
  } while ((int)camAngle < 0x400);
  camAngle = 0xffffffff;
  do {
    intsincos(camAngle,&sin,&cos);
    temp.x = fixedmult(cos,step.x) - fixedmult(sin,step.z);
    temp.y = step.y;
    temp.z = fixedmult(sin,step.x) + fixedmult(cos,step.z);
    temp.x = edge.x + temp.x;
    temp.y = edge.y + temp.y;
    temp.z = edge.z + temp.z;
    BWorldSm_FindClosestQuadMaxIterations(&temp,&slicePos,3);
    if (slicePos.simQuad != (Trk_NewSimQuad *)0x0) {
      quadUnderCamera = slicePos.quadPts[0];
    }
    else {
      quadUnderCamera = *CAMERA_SLICE_CENTER(slicePos.slice);
    }
    if (((slicePos.simQuad != (Trk_NewSimQuad *)0x0) &&
         (((slicePos.simQuad)->surface & 0xf) == 0)) ||
        ((signed char)slicePos.offEdge != 0) ||
        (Camera_TooSteep(player,&slicePos) != 0) ||
        ((slicePos.simQuad != (Trk_NewSimQuad *)0x0) &&
         (((slicePos.simQuad)->surface & 0x80) != 0) &&
         (0x38000 < quadUnderCamera.y - Camera_gInfo[player].anchor->position.y))) {
      Camera_gInfo[player].wallRight = temp;
      break;
    }
    camAngle = camAngle - 4;
  } while (-0x400 < (int)camAngle);
  temp.x = Camera_gInfo[player].wallRight.x - Camera_gInfo[player].wallLeft.x;
  temp.y = Camera_gInfo[player].wallRight.y - Camera_gInfo[player].wallLeft.y;
  temp.z = Camera_gInfo[player].wallRight.z - Camera_gInfo[player].wallLeft.z;
  temp.y += 0x8000;
  Math_NormalizeVector(&temp);
  normal.x = -temp.z;
  edge.x = edge.x - triPnt.x;
  normal.y = temp.y;
  normal.z = temp.x;
  edge.y = edge.y - triPnt.y;
  edge.z = edge.z - triPnt.z;
  /* MATCH (W61-A11, 6 -> PASS 605/605).  Three coupled facts, all instrument-
   * proven; do NOT "simplify" any of them:
   *  (1) each dot is ONE sum expression (not `= f1; += f2; += f3;`) -- that is
   *      what materialises retail's per-2nd-term copies (`addu sN,v0,zero`);
   *      the accumulate spelling is 2 insns SHORT (603) and can never match;
   *  (2) the edge sum is carried in `i` -- the SYM's own local (REG $11 = s1,
   *      alongside camAngle/edgeDotNorm), NOT in edgeDotNorm.  `i` is BLOCK-LOCAL
   *      so local-alloc keeps s1 busy across the cam dot's window; without it the
   *      cam dot's 2nd-term qty takes s1 and edgeDotNorm is pushed to s2;
   *  (3) the `+ 0x10000` is FOLDED into the final statement.  Splitting it into
   *      `edgeDotNorm = i + camDotNorm; edgeDotNorm += 0x10000;` regresses to 24.
   * Instrumented cc1plus (scratch/gccbuild-ecoff, byte-identical on this fn)
   * window trace for the old basin: q18 edge-chain [98,116)->s0, q19 edge-2nd
   * [106,114)->s1, q20 cam-chain [124,140)->s0, q21 cam-2nd [132,136)->s1, so
   * global p86 (edgeDotNorm) hard-conflicted s0+s1 and could only take s2 --
   * unreachable by ANY priority dial, because no qty covered [132,136).
   * FALSIFIED alongside: both dots as one sum with edgeDotNorm as the accumulator
   * 24@605 | edge right-associated 20@605 | `count` instead of `i` 34@605 | the
   * whole thing as one expression 41@608 | read-only/identity fences on
   * edgeDotNorm 25@606 | on camDotNorm 24@605 | `i` + a 2-operand read-only fence
   * 5@606 | staging the 2nd terms through camDotNorm/count 6@603. */
  i = fixedmult(edge.x,normal.x) + fixedmult(edge.y,normal.y) + fixedmult(edge.z,normal.z);
  camDotNorm = fixedmult(triVec.x,normal.x) + fixedmult(triVec.y,normal.y) + fixedmult(triVec.z,normal.z);
  edgeDotNorm = i + camDotNorm + 0x10000;
  if (0 < edgeDotNorm) {
    temp.x = fixedmult(edgeDotNorm,normal.x);
    temp.y = fixedmult(edgeDotNorm,normal.y);
    temp.z = fixedmult(edgeDotNorm,normal.z);
    pos->x = pos->x + temp.x;
    pos->y = pos->y + temp.y;
    pos->z = pos->z + temp.z;
  }
  return;
}

/* ---- Camera_SetAboveGround__FiP8coorddef  [@0x8008480c] ---- */
void Camera_SetAboveGround(int player,coorddef *pos)
{
  BWorldSm_Pos *slicePos;
  coorddef quadnormal;
  int elevation;

  slicePos = &Camera_gInfo[player].slicePos;
  quadnormal = *(coorddef *)BWorldSm_UNormal(slicePos);
  elevation = Newton_FindGroundElevationGeneral(pos,&quadnormal,slicePos->quadPts);
  if (pos->y < elevation + 0x10000) {
    pos->y = elevation + 0x10000;
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
  /* SYM-CODEGEN-CARRIER: adj -- spelling the three signed divide-by-four
   * adjustments as direct conditional expressions keeps 231 instructions but
   * changes 12 global-base/allocation instructions. */
  int adj;

  rotx = (coorddef *)rot;
  roty = (coorddef *)(rot->m + 3);
  rotz = (coorddef *)(rot->m + 6);
  if (point != (coorddef *)0x0) {
    tgtPos = *point;
  }
  else {
    tgtPos = Camera_gInfo[player].target->position;
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
    rotz->y = rotz->y +
        ((2 < (u_int)((u_short)Camera_gInfo[player].mode - 2)) ? 0x6666 : 0x5333);
  }
  if (Replay_ReplayMode == 2) {
    upvector.x = Camera_gInfo[player].twist;
  }
  Math_NormalizeVector(rotz);
  if (0xfd70 <
      ((0 < (fixedmult(upvector.x,rotz->x) +
             fixedmult(upvector.y,rotz->y) +
             fixedmult(upvector.z,rotz->z))) ?
       (fixedmult(upvector.x,rotz->x) +
        fixedmult(upvector.y,rotz->y) +
        fixedmult(upvector.z,rotz->z)) :
      -(fixedmult(upvector.x,rotz->x) +
        fixedmult(upvector.y,rotz->y) +
        fixedmult(upvector.z,rotz->z)))) {
    upvector = *roty;
  }
  rotx->x = fixedmult(upvector.y,rotz->z) - fixedmult(upvector.z,rotz->y);
  rotx->y = fixedmult(upvector.z,rotz->x) - fixedmult(upvector.x,rotz->z);
  rotx->z = fixedmult(upvector.x,rotz->y) - fixedmult(upvector.y,rotz->x);
  Math_NormalizeVector(rotx);
  roty->x = fixedmult(rotz->y,rotx->z) - fixedmult(rotz->z,rotx->y);
  roty->y = fixedmult(rotz->z,rotx->x) - fixedmult(rotz->x,rotx->z);
  roty->z = fixedmult(rotz->x,rotx->y) - fixedmult(rotz->y,rotx->x);
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
  
  oppSlice = 0xb;
  if (reset != 0) {
    lastOppVector[player] =
        *(coorddef *)(Cars_gHumanRaceCarList[player]->N.orientMat.m + 6);
    return;
  }
  oppVector =
      *(coorddef *)(Cars_gHumanRaceCarList[player]->N.orientMat.m + 6);
  i = 0;
  if (0 < Cars_gNumCars) {
    do {
      if (Cars_gList[i] != Cars_gHumanRaceCarList[player]) {
        dist = (int)Cars_gList[i]->N.simRoadInfo.slice -
               (int)Cars_gHumanRaceCarList[player]->N.simRoadInfo.slice;
        dist = (gNumSlices / 2 < __builtin_abs(dist)) ?
               gNumSlices - __builtin_abs(dist) : __builtin_abs(dist);
        if (dist < 0xb) {
          tempVector.x = pos->x - Cars_gList[i]->N.position.x;
          tempVector.y = pos->y - Cars_gList[i]->N.position.y;
          tempVector.z = pos->z - Cars_gList[i]->N.position.z;
          Math_NormalizeVector(&tempVector);
          oppAngle =
              fixedmult(Cars_gHumanRaceCarList[player]->N.orientMat.m[6],
                        tempVector.x) +
              fixedmult(Cars_gHumanRaceCarList[player]->N.orientMat.m[7],
                        tempVector.y) +
              fixedmult(Cars_gHumanRaceCarList[player]->N.orientMat.m[8],
                        tempVector.z);
          oppAngle = (0 < intarccos(oppAngle)) ?
                     intarccos(oppAngle) : -intarccos(oppAngle);
          if ((oppAngle < 0x80) && (dist < oppSlice)) {
            oppVector = tempVector;
            oppSlice = dist;
          }
        }
      }
      i++;
    } while (i < Cars_gNumCars);
  }
  lastOppVector[player].x +=
      fixedmult(oppVector.x - lastOppVector[player].x,0x4ccc);
  lastOppVector[player].y +=
      fixedmult(oppVector.y - lastOppVector[player].y,0x4ccc);
  lastOppVector[player].z +=
      fixedmult(oppVector.z - lastOppVector[player].z,0x4ccc);
  oppVector.x = pos->x - lastOppVector[player].x;
  oppVector.y = pos->y - lastOppVector[player].y;
  oppVector.z = pos->z - lastOppVector[player].z;
  switch((int)(((u_short)Camera_gInfo[player].mode - 2) * 0x10000) >> 0x10) {
  case 0:
  case 1:
  case 2:
    oppVector.y -= 0x14ccc;
    break;
  case 5:
    oppVector.y -= 0x6666;
  case 3:
  case 4:
    oppVector.y -= 0x19999;
    break;
  default:
    break;
  }
  Camera_AcquireTarget(player,&oppVector,pos,&Camera_gInfo[player].rotation,1);
  return;
}

/* ---- Camera_GetViewInfo__FiP17DRender_tCalcViewi  [@0x80085008] ---- */
void Camera_GetViewInfo(int cviewP,DRender_tCalcView *cview,int viewID)
{
  if (Camera_gInfo[cviewP].jostling != 0) {
    Camera_PitchAndRoll(cviewP);
  }
  cview->translation = Camera_gInfo[cviewP].position;
  if (Camera_gInfo[cviewP].checkwalls != 0) {
    Camera_CheckWallCollisions(cviewP,&cview->translation);
  }
  BWorldSm_FindClosestQuadRez(&cview->translation,&Camera_gInfo[cviewP].slicePos,1);
  if (((signed char)Camera_gInfo[cviewP].slicePos.offEdge == '\0') &&
      (1 < Camera_gInfo[cviewP].mode)) {
    Camera_SetAboveGround(cviewP,&cview->translation);
  }
  if (Camera_gInfo[cviewP].tracking != 0) {
    Camera_AcquireTarget(cviewP,(coorddef *)0x0,&cview->translation,&Camera_gInfo[cviewP].rotation,1);
  }
  if (Camera_gInfo[cviewP].mode == 0x10) {
    Camera_AcquireTarget(cviewP,gCop1Target + cviewP,&cview->translation,&Camera_gInfo[cviewP].rotation,1);
  }
  if (Camera_gInfo[cviewP].noLookBack == 0) {
    if (*(int *)((cviewP << 2) + (int)Input_gLookBehind) != 0) {
      Camera_OpponentLookBehind(cviewP,&cview->translation,0);
    }
    else {
      Camera_OpponentLookBehind(cviewP,&cview->translation,1);
    }
  }
  cview->mrotation = Camera_gInfo[cviewP].rotation;
  if (Camera_GameSetupWords[11] != 0) {
    int t1 = cview->mrotation.m[0];
    int t2 = cview->mrotation.m[1];
    int t3 = cview->mrotation.m[2];
    cview->mrotation.m[0] = -t1;
    cview->mrotation.m[1] = -t2;
    cview->mrotation.m[2] = -t3;
  }
  {
    int scale;
    int t1;
    int t2;

    transpose(&cview->mrotation,&cview->mrotationInv);
    scale = 0xdc00;
    cview->mrotationInvRaw = cview->mrotationInv;
    t1 = fixedmult(cview->mrotation.m[3],scale);
    t2 = fixedmult(cview->mrotation.m[4],scale);
    scale = fixedmult(cview->mrotation.m[5],scale);
    cview->mrotation.m[3] = t1;
    cview->mrotation.m[4] = t2;
    cview->mrotation.m[5] = scale;
  }
  transpose(&cview->mrotation,&cview->mrotationInv);
  {
    coorddef tmp;
    tmp.x = -cview->translation.x;
    tmp.y = -cview->translation.y;
    tmp.z = -cview->translation.z;
    transform(&tmp,cview->mrotationInv.m,&cview->translationInv);
  }
  return;
}

/* ---- Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef  [@0x8008533c] ---- */
void Camera_GetAudioViewInfo(int cviewP,DRender_tCalcView *cview,coorddef **cvel)
{
  if (*(int *)((cviewP << 2) + (int)Input_gLookBehind) == 0) {
    cview->translation = Camera_gInfo[cviewP].position;
    cview->mrotation = Camera_gInfo[cviewP].rotation;
  }
  else if (Camera_gInfo[cviewP].noLookBack != 0) {
    cview->translation = Camera_gInfo[cviewP].position;
    cview->mrotation = Camera_gInfo[cviewP].rotation;
  }
  else {
    if (Camera_gInfo[cviewP].tracking != 0) {
      cview->translation = Camera_gInfo[cviewP].audioPos;
      Camera_AcquireTarget(cviewP,(coorddef *)0x0,&cview->translation,&cview->mrotation,0);
    }
    else {
      cview->translation = Camera_gInfo[cviewP].audioPos;
      Camera_LookBack(&Camera_gInfo[cviewP].rotation,&cview->mrotation);
    }
  }
  switch(Camera_gInfo[cviewP].mode) {
  case 0xc:
  case 0xe:
    *cvel = (coorddef *)0x0;
    break;
  case 0:
  case 1:
  case 2:
  case 3:
  case 4:
  case 5:
  case 6:
  case 7:
  case 8:
  case 9:
  case 10:
  case 11:
  case 13:
  case 15:
  case 16:
  case 17:
  case 18:
  default:
    *cvel = &(Camera_gInfo[cviewP].anchor)->linearVel;
    break;
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
      Camera_gInfo[cviewP].mode = (short)CAMERA_SETUP_CAMERA(cviewP,0);
    }
    if (Camera_gInfo[cviewP].mode == 0xb) {
      Camera_SetSplineCam(cviewP);
    }
    Camera_gInfo[cviewP].intransition = '2';
    flagMode = &Camera_gFlags[Camera_gInfo[cviewP].mode];
    Camera_gInfo[cviewP].pitch = flagMode->pitch;
    Camera_gInfo[cviewP].jostling = flagMode->jostling;
    Camera_gInfo[cviewP].tracking = flagMode->tracking;
    Camera_gInfo[cviewP].checkwalls = flagMode->checkwalls;
    Camera_gInfo[cviewP].noLookBack = flagMode->noLookBack;
    Camera_gInfo[cviewP].checkcollisions = flagMode->checkcollisions;
    Camera_gInfo[cviewP].inCar = Camera_gInfo[cviewP].mode < 2;
  }
  return;
}

/* ---- Camera_NextMode__Fi  [@0x8008581c] ---- */
void Camera_NextMode(int cviewP)
{
  camera_flags*flagMode;
  /* SYM-CODEGEN-CARRIER: modeForRange -- direct mode field use adds two
     instructions and changes the shared load/range test to 12 diffs. */
  u_short modeForRange;

  modeForRange = (u_short)Camera_gInfo[cviewP].mode;
  if ((Camera_gInfo[cviewP].mode != 0xe) && (Camera_gInfo[cviewP].modechange == 0)) {
    if ((u_int)(modeForRange - 0xb) < 2) {
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
      /* SYM-CODEGEN-CARRIER: splitBase -- direct typed gSplitCameras indexing
         keeps 237 instructions but changes base allocation at six positions. */
      register int splitBase;
      Camera_gInfo[cviewP].camNum = Camera_gInfo[cviewP].camNum + 1;
      splitBase = (int)gSplitCameras;
      Camera_gInfo[cviewP].mode =
           *(short *)(splitBase +
                     (((int)Camera_gInfo[cviewP].camNum % 3) * 0x10000 >> 0xe));
    }
    else if (((Camera_GameSetupWords[0] == RaceType_HotPursuit) || (Camera_GameSetupWords[0] == RaceType_Id5)) &&
            ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
             ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
      Camera_gInfo[cviewP].camNum = Camera_gInfo[cviewP].camNum + 1;
      Camera_gInfo[cviewP].mode =
          (short)CAMERA_SETUP_CAMERA(
              cviewP,(u_short)Camera_gInfo[cviewP].camNum & 3);
    }
    else {
      /* SYM-CODEGEN-CARRIER: setupBase -- direct Camera_GameSetupWords use
         keeps 237 instructions but changes base allocation at six positions. */
      int *setupBase;
      /* SYM-CODEGEN-CARRIER: setupOffset -- folding the two offset terms into
         the final address keeps 237 instructions but changes four positions. */
      int setupOffset;

      Camera_gInfo[cviewP].camNum = Camera_gInfo[cviewP].camNum + 1;
      /* MATCH: comma-stage the GameSetup base with the signed %3 byte offset,
         then extend that offset in place.  This gives GCC the retail latency
         schedule: the base pair sits between mult and its sign correction. */
      setupOffset =
          (setupBase = Camera_GameSetupWords,
           ((int)Camera_gInfo[cviewP].camNum % 3) << 2);
      setupOffset += cviewP * 180;
      Camera_gInfo[cviewP].mode =
           ((Car_tObj *)((char *)setupBase + setupOffset))->slide;
    }
    if (0x13 < Camera_gInfo[cviewP].mode) {
      Camera_gInfo[cviewP].mode = (short)CAMERA_SETUP_CAMERA(cviewP,0);
    }
    if (Camera_gInfo[cviewP].mode == 0xb) {
      Camera_SetSplineCam(cviewP);
    }
    Camera_gInfo[cviewP].intransition = '2';
    flagMode = &Camera_gFlags[Camera_gInfo[cviewP].mode];
    Camera_gInfo[cviewP].pitch = flagMode->pitch;
    Camera_gInfo[cviewP].jostling = flagMode->jostling;
    Camera_gInfo[cviewP].tracking = flagMode->tracking;
    Camera_gInfo[cviewP].checkwalls = flagMode->checkwalls;
    Camera_gInfo[cviewP].noLookBack = flagMode->noLookBack;
    Camera_gInfo[cviewP].checkcollisions = flagMode->checkcollisions;
    Camera_gInfo[cviewP].inCar = Camera_gInfo[cviewP].mode < 2;
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
