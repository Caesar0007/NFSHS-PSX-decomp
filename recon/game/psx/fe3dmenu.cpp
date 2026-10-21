/* game/psx/fe3dmenu.cpp -- RECONSTRUCTED (showroom geometry and car rendering)
 *   fe3dmenu.obj: Fe3D_InitShowroom, CameraLookAt, Draw_MenuRenderingView.
 *   Its code/data are linked into the frontend overlay despite the GAME/PSX path.
 */
#include "fe3dmenu_externs.h"

/* Retail fe3dmenu.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *, const char *, ...);

/* fe3dmenu.obj front.data 0x80051260..0x800514B8, owned here since 2026-09-19 (SYM: all five are EXT symbols of
   fe3dmenu.obj, in this order; was the retail dump front_data_r00).  Uninitialized C++ publics. */
/* cc1plus emits uninitialized publics at the end of the file in the order of their FIRST declaration, so they are
   first declared here (not in the externs header), in the retail order. */
bool     showRoomFlag;                            /* 0x80051260; SYM EXT BOOL, scalar */
int      gMenuRotate[2];                          /* 0x80051264 */
COORD16  Fe3D_spotVertex[33];                     /* 0x8005126c */
COORD16  Fe3D_lightsVertex[64];                   /* 0x80051334 */
int      gShowroomLights;                         /* 0x800514b4 */


/* ---- Fe3D_InitShowroom  [FE3DMENU.CPP:76-114] SLD-FLAG:NONMONO ----
 * PASS 107/107.  SYM records outer `INT i`/`LONG angle`, a line-15 `SHORT
 * iPlus`, and line-25 `LONG angle_sin`/`LONG angle_cos` locals.  The second
 * loop advances `iPlus` with the two `.z` subscripts.  Each post-increment
 * forces the old short index to survive the update, producing retail's copied
 * sign-extension and separately rematerialized first-vertex `.z` address.
 *
 * 2026-10-12 MATCH107/107 and native SYM CLEAN: direct `(csin(angle)<<4)*3`
 * and the corresponding ccos expression preserve retail's shift4/shift5/add
 * without trigValue or repeated calls. ccos is stored before advancing angle.
 * The lighting phase owns iPlus; its for loop reuses root i and owns the two
 * LONG angle locals. Direct fastintcos(angle)>>3 preserves the late physical
 * shift after restoring this source ownership, without cos_raw. Reusing
 * angle_cos for the raw return then shifting in place was54/107 and reverted.
 * All five named local tuples and all eight scope boundary tuples agree.
 * Retail groups the three closing spot stores before the lighting phase on
 * one source line. The comma sequence preserves x/y/z store order; chained
 * assignment was four differences at107 words and was reverted. This restores
 * grouping/order, not a uniquely proved original macro or literal spelling.
 * SOURCE-REVIEW: literal original expression/macro spelling and complete SLD
 * are not uniquely proved by this native contract and byte-match receipt. */

void Fe3D_InitShowroom(void)

{
  int i;
  long angle;
  
  angle = 0;
  i = 0;
  do {
    Fe3D_spotVertex[i].x = (short)(((csin(angle) << 4) * 3) >> 8);
    Fe3D_spotVertex[i].y = 0;
    Fe3D_spotVertex[i].z = (short)(((ccos(angle) << 4) * 3) >> 8);
    angle = angle + 0x80;
    i = i + 1;
  } while (i < 0x20);
  Fe3D_spotVertex[i].x = 0, Fe3D_spotVertex[i].y = 0, Fe3D_spotVertex[i].z = 0;
  {
    short iPlus;
    angle = 0;
    iPlus = 0;
    for (i = 0; ; i = i + 1) {
      if (0x20 <= i) break;
      long angle_sin;
      long angle_cos;
      angle_sin = fastintsin(angle) >> 3;
      angle_cos = fastintcos(angle) >> 3;
      Fe3D_lightsVertex[iPlus].x = (short)((u_int)(angle_sin * 3) >> 5);
      Fe3D_lightsVertex[iPlus].y = 0;
      Fe3D_lightsVertex[iPlus++].z = (short)((u_int)(angle_cos * 3) >> 5);
      Fe3D_lightsVertex[iPlus].x = (short)(angle_sin * 0x15 >> 8);
      Fe3D_lightsVertex[iPlus].y = 0;
      Fe3D_lightsVertex[iPlus++].z = (short)(angle_cos * 0x15 >> 8);
      angle = angle + 0x20;
    }
  }
  return;
}



/* ---- CameraLookAt  [FE3DMENU.CPP:120-143] ---- */

void CameraLookAt(matrixtdef *mat,coorddef *camPoint)

{
  coorddef fwdVec;
  coorddef rightVec;
  coorddef upVec = { 0, 0x10000, 0 };   /* local aggregate initializer: its constant is retail .rodata 0x8001002C */

  fwdVec.x = -camPoint->x;
  fwdVec.y = -camPoint->y;
  fwdVec.z = -camPoint->z;
  Math_NormalizeVector(&fwdVec);
  crossproduct(&upVec.x,&fwdVec.x,&rightVec.x);
  crossproduct(&fwdVec.x,&rightVec.x,&upVec.x);
  mat->m[0] = rightVec.x;
  mat->m[1] = rightVec.y;
  mat->m[2] = rightVec.z;
  mat->m[3] = upVec.x;
  mat->m[4] = upVec.y;
  mat->m[5] = upVec.z;
  mat->m[6] = fwdVec.x;
  mat->m[7] = fwdVec.y;
  mat->m[8] = fwdVec.z;
  return;
}



/* ---- Draw_MenuRenderingView  [FE3DMENU.CPP:150-329] ---- */
/* 2026-10-12 MATCH234/234: retail showRoomFlag is a scalar BOOL. Restoring
 * the real bool definition/declarations makes the direct second predicate
 * byte-exact without inShowroom or an asm-name array view. The old19/237
 * direct-retest failure applied to the int-array reconstruction, not this
 * source type. No replacement capture, fence, qualifier or output rewrite.
 * The camera phase after projection owns temp/temp1/temp2/pos; targetPos
 * belongs to its showroom branch and correct to its correction-matrix block.
 * All23 ordered parameters/locals, their types/homes/depths, the frame and
 * all14 scope boundary tuples match retail (run-sxey8682). Optimized debug
 * endpoints are not literal last-use positions: the enclosing region ends
 * at +380 in both builds despite later scheduled camera operations.
 * SOURCE-REVIEW: original statement/macro spelling and complete SLD remain
 * unresolved; native CLEAN alone is not a complete original-source seal. */

void Draw_MenuRenderingView(Car_tObj *carObj,DRender_tView *Vi,int posX,int posY,int player,u_long rotation,
               int camRot,float camY,float camZ,int light,int reflection)

{
  TrsProj_ResetTransPrecision();
  if (showRoomFlag != 0) {
    posY = 0x8c;
  }
  TrsProj_SetMenuProjection(posX + -0x100,posY + -0x80,0x200,0x100);
  {
    matrixtdef temp;
    matrixtdef temp1;
    matrixtdef temp2;
    coorddef pos;
    gMenuRotate[player] = gMenuRotate[player] + rotation;
    if (showRoomFlag != 0) {                                /* showroom camera */
      coorddef targetPos;
      camY = camY * 0.5f;
      targetPos.x = 0;
      targetPos.y = (int)(camY * 65536.0f);
      targetPos.z = (int)(camZ * 65536.0f);
      CameraLookAt(&temp1,&targetPos);
      fixedxformy(temp2.m,camRot << 6);
      Math_fasttransmult(&temp1,&temp2,&temp);
      camZ = camZ + camY / 2.5;
      camY = 0.0f;
    }
    else {
      fixedxformy(temp.m,camRot << 6);
    }
    {
      matrixtdef correct;
      /* w38-a9: the oracle stores 0x10000 at m[4] (sp+0xB8) with the other two diagonal
         entries and only THEN overwrites it with 0x8980 in the Math_fasttransmult jal's
         delay slot -- i.e. the source writes a full IDENTITY first, then tweaks m[4].
         The old recon dropped the identity m[4] store (1 insn short). */
      correct.m[0] = 0x10000;
      correct.m[1] = 0;
      correct.m[2] = 0;
      correct.m[3] = 0;
      correct.m[4] = 0x10000;
      correct.m[5] = 0;
      correct.m[6] = 0;
      correct.m[7] = 0;
      correct.m[8] = 0x10000;
      correct.m[4] = 0x8980;
      Math_fasttransmult(&correct,&temp,&(Vi->cview).mrotation);
    }
    transpose(&(Vi->cview).mrotation,&(Vi->cview).mrotationInv);
    pos.x = 0;
    pos.y = (int)(camY * 65536.0f);
    pos.z = (int)(camZ * 65536.0f);
    transform(&pos.x,(Vi->cview).mrotation.m,(int *)&Vi->cview);
    pos.x = -(Vi->cview).translation.x;
    pos.y = -(Vi->cview).translation.y;
    pos.z = -(Vi->cview).translation.z;
    transform(&pos.x,(Vi->cview).mrotationInv.m,&(Vi->cview).translationInv.x);
  }
  (carObj->N).orientMat.m[0] = 0x10000;
  (carObj->N).orientMat.m[4] = 0x10000;
  (carObj->N).orientMat.m[8] = 0x10000;
  (carObj->N).orientMat.m[1] = 0;
  (carObj->N).orientMat.m[2] = 0;
  (carObj->N).orientMat.m[3] = 0;
  (carObj->N).orientMat.m[5] = 0;
  (carObj->N).orientMat.m[6] = 0;
  (carObj->N).orientMat.m[7] = 0;
  (carObj->N).position.x = 0;
  (carObj->N).position.y = 0;
  (carObj->N).position.z = 0;
  if (player == 0) {
    if (generic128HzClock > R3DCar_ClockLast) {
      R3DCar_Clock = 1;
      R3DCar_ClockLast = generic128HzClock + 5;
    }
    else {
      R3DCar_Clock = 0;
    }
  }
  Vi->player = player;
  Texture_LoadMenuTexture();
  R3DCar_InsertCarFacetMenu(carObj,Vi);
  R3DCar_InsertCarFacetMenuII(carObj,light);
  R3DCar_Showroom(Vi);
  if (reflection != 0) {
    /* w38-a9: SYM block @0x80012ef0 declares `Draw_CarCache *sd` ($s2) HERE, and the
       oracle materializes it as the LITERAL scratchpad base (`lui $s2,0x1F80`) then
       reaches the menu-render mirror flag by DISPLACEMENT `0xC($s2)` -- i.e. what the
       tree calls `Render_gMenuRenderFlag` is really `sd->head.mirror` @0x1F80000C
       (methodology 3.6b scratchpad-resident global; same finding draw.cpp records for
       Draw_StartRenderingView).  Using the extern symbol emitted %hi/%lo(sym) pairs. */
    Draw_CarCache *sd = (Draw_CarCache *)0x1F800000;

    R3DCar_InMenu = R3DCar_InMenu | 0x80;
    sd->head.mirror = sd->head.mirror ^ 1;
    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    stackSpeedUpEnbabledFlag = 1;
    R3DCar_InsertCarFacetMenu(carObj,Vi);
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
    R3DCar_InsertCarFacetMenuII(carObj,light);
    R3DCar_InMenu = R3DCar_InMenu & 0x7f;
    sd->head.mirror = sd->head.mirror ^ 1;
  }
  return;
}



/* end of fe3dmenu.cpp */
