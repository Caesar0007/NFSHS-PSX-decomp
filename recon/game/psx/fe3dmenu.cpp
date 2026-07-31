/* frontend/common/fecars.cpp -- RECONSTRUCTED (NFS4 car manager + list iterators; C++ TU)
 *   46 fns across 3 classes: tCarManager (32; garage/stock/pinkslip car economy + save/load),
 *   tListIteratorCar (8; :tListIterator), tListIteratorCarColor (6; :tListIterator).
 *   Member defs; base ctors via init-lists; manual _vf vtable for the iterator virtuals.
 */
#include "../../nfs4_types.h"
#include "fe3dmenu_externs.h"


/* ---- Fe3D_InitShowroom  [FE3DMENU.CPP:76-114] SLD-FLAG:NONMONO ---- */

void Fe3D_InitShowroom(void)

{
  int iVar1;
  int angle_sin;
  int angle_cos;
  short sVar4;
  int iPlus;
  COORD16 *pCVar6;
  int angle;
  int i;
  
  angle = 0;
  i = 0;
  pCVar6 = Fe3D_spotVertex;
  do {
    iVar1 = csin(angle);
    pCVar6->x = (short)((u_int)(iVar1 * 0x30) >> 8);
    pCVar6->y = 0;
    iVar1 = ccos(angle);
    angle = angle + 0x80;
    pCVar6->z = (short)((u_int)(iVar1 * 0x30) >> 8);
    i = i + 1;
    pCVar6 = pCVar6 + 1;
  } while (i < 0x20);
  angle = 0;
  iVar1 = 0;
  Fe3D_spotVertex[i].x = 0;
  Fe3D_spotVertex[i].y = 0;
  Fe3D_spotVertex[i].z = 0;
  for (i = 0; i < 0x20; i = i + 1) {
    angle_sin = fastintsin(angle);
    angle_cos = fastintcos(angle);
    sVar4 = (short)iVar1;
    iPlus = iVar1 + 1;
    iVar1 = iVar1 + 2;
    angle = angle + 0x20;
    Fe3D_lightsVertex[sVar4].x = (short)((u_int)((angle_sin >> 3) * 3) >> 5);
    Fe3D_lightsVertex[sVar4].y = 0;
    iPlus = iPlus * 0x10000 >> 0x10;
    Fe3D_lightsVertex[sVar4].z = (short)((u_int)((angle_cos >> 3) * 3) >> 5);
    Fe3D_lightsVertex[iPlus].x = (short)((u_int)((angle_sin >> 3) * 0x15) >> 8);
    Fe3D_lightsVertex[iPlus].y = 0;
    Fe3D_lightsVertex[iPlus].z = (short)((u_int)((angle_cos >> 3) * 0x15) >> 8);
  }
  return;
}



/* ---- CameraLookAt  [FE3DMENU.CPP:120-143] SLD-VERIFIED ---- */

void CameraLookAt(matrixtdef *mat,coorddef *camPoint)

{
  coorddef fwdVec;
  coorddef rightVec;
  coorddef upVec;
  
  upVec = *(coorddef*)((char*)bigBuf + 44);
  fwdVec.x = -camPoint->x;
  fwdVec.y = -camPoint->y;
  fwdVec.z = -camPoint->z;
  Math_NormalizeVector(&fwdVec);
  crossproduct(&upVec,&fwdVec,&rightVec);
  crossproduct(&fwdVec,&rightVec,&upVec);
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



/* ---- Draw_MenuRenderingView  [FE3DMENU.CPP:150-329] SLD-VERIFIED ---- */

void Draw_MenuRenderingView(Car_tObj *carObj,DRender_tView *Vi,int posX,int posY,int player,u_long rotation,
               int camRot,float camY,float camZ,int light,int reflection)

{
  bool bVar1;
  matrixtdef *mr;
  matrixtdef *m;
  matrixtdef temp;
  matrixtdef temp1;
  matrixtdef temp2;
  coorddef pos;
  coorddef targetPos;
  matrixtdef correct;
  
  TrsProj_ResetTransPrecision();
  if (showRoomFlag != 0) {
    posY = 0x8c;
  }
  TrsProj_SetMenuProjection(posX + -0x100,posY + -0x80,0x200,0x100);
  bVar1 = showRoomFlag != 0;
  gMenuRotate[player] = gMenuRotate[player] + rotation;
  if (bVar1) {                                            /* showroom camera (showRoomFlag != 0) */
    camY = camY * 0.5f;
    targetPos.x = 0;
    targetPos.y = (int)(camY * 65536.0f);
    targetPos.z = (int)(camZ * 65536.0f);
    CameraLookAt(&temp1,&targetPos);
    fixedxformy(&temp2,camRot << 6);
    Math_fasttransmult(&temp1,&temp2,&temp);
    camZ = camZ + camY / 2.5;
    camY = 0.0f;
  }
  else {
    fixedxformy(&temp,camRot << 6);
  }
  mr = &(Vi->cview).mrotation;
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
  Math_fasttransmult(&correct,&temp,mr);
  m = &(Vi->cview).mrotationInv;
  transpose(mr,m);
  pos.x = 0;
  pos.y = (int)(camY * 65536.0f);
  pos.z = (int)(camZ * 65536.0f);
  transform(&pos.x,mr->m,(int *)&Vi->cview);
  pos.x = -(Vi->cview).translation.x;
  pos.y = -(Vi->cview).translation.y;
  pos.z = -(Vi->cview).translation.z;
  transform(&pos.x,m->m,&(Vi->cview).translationInv.x);
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
