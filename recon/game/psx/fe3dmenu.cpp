/* frontend/common/fecars.cpp -- RECONSTRUCTED (NFS4 car manager + list iterators; C++ TU)
 *   46 fns across 3 classes: tCarManager (32; garage/stock/pinkslip car economy + save/load),
 *   tListIteratorCar (8; :tListIterator), tListIteratorCarColor (6; :tListIterator).
 *   Member defs; base ctors via init-lists; manual _vf vtable for the iterator virtuals.
 */
#include "../../nfs4_types.h"
#include "fe3dmenu_externs.h"


/* ---- Fe3D_InitShowroom  [FE3DMENU.CPP:76-114] SLD-FLAG:NONMONO ----
 * w38-a9: 104 -> 24 diffs.  Four oracle-driven corrections:
 *  (1) loop 1 walks `Fe3D_spotVertex[i]` by INDEX (gcc strength-reduces it to the
 *      oracle's single `addiu $s0,$s0,6` giv); the old explicit `pCVar6` pointer walk
 *      made gcc build a SECOND base pointer and address .z off `-2($s0)`.
 *  (2) the scale is written UN-SIMPLIFIED as `(x<<5)+(x<<4)`: `x * 0x30 >> 8` is
 *      folded by combine to `(x*3)>>4` (2 insns), but the oracle keeps the full
 *      `sll 4 / sll 5 / addu / sra 8` (methodology 3.14 "keep arithmetic
 *      un-simplified"); the >>8 must stay ARITHMETIC (sra).
 *  (3) `angle_sin`/`angle_cos` hold the ALREADY-shifted (`>>3`) value, so the sin
 *      shift lands in the intcos jal's delay slot like the oracle.
 *  (4) loop 2 is a top-tested `while(1){ if(0x20<=i) break; ... }` (oracle: `slti /
 *      beqz OUT / ... / j TOP`, i.e. NOT rotated) and its vertex index is a real
 *      `short` incremented TWICE per iteration -- that is what produces the oracle's
 *      untruncated `addiu a1,s3,1 / addiu s3,a1,1` pair plus a `sll 16 / sra 16`
 *      sign-extend at every use.
 * RESIDUAL (24, ours 103 / oracle 107): the oracle keeps a SECOND copy of the
 * sign-extended index ($a2) and re-materializes `&Fe3D_lightsVertex[idx]` for the .z
 * store, where our build CSEs the address across .x/.y/.z (7 insns); plus one
 * `addu v1,v0,zero` copy of the csin/ccos result.  Both are cse/coloring, not shape.
 * w46-a9 (24 -> 14): the `addu v1,v0,zero` half is SOURCE-REACHABLE and it is a
 * SHIFT-ISSUE-ORDER problem, not a cse one.  `(x<<5)+(x<<4)` makes gcc evaluate the
 * <<5 FIRST into $v0 -- which is where the call result already lives -- so it has to
 * save a copy in $v1 before clobbering it; retail issues `sll $v1,$v0,4` first and only
 * then `sll $v0,$v0,5` (the last use, safe to clobber).  Simply reversing the addends
 * does NOT work (cc1 canonicalizes commutative operands, measured identical at 24);
 * what works is NESTING the larger shift on the smaller one -- `((x<<4)<<1)+(x<<4)` --
 * which forces the <<4 to be a real subexpression evaluated first and cse'd for both
 * terms.  (Named `lo4` temp variants: 20 and 16; `(x+(x<<1))<<4` and `x*48`: 32 each,
 * both fold to a mult chain.)  Algebraically identical: x*32 + x*16 == x*48.
 * RESIDUAL 14 (ours 105 / oracle 107) is now entirely the SECOND item: retail keeps
 * `sll $v1,$s3,16` and COPIES it (`addu $a2,$v1,$zero`) so the two consumers each get
 * their own `sra ,16`, while ours emits one sign-extend and CSEs it.  Falsified from
 * this basin (all 14, counts 101-105): a two-local copy chain (`sx = sVar4; iPlus =
 * sx;` and the reverse), a `(short)(short)` double cast, an explicit `sh = sVar4<<16;
 * iPlus = sh;` pair with `sh>>16` / `iPlus>>16` consumers in either role assignment,
 * and swapping which index variable feeds .x/.y vs .z (30, worse).  Every spelling of
 * "make a second copy" is copy-propagated away.
 * 🔑 NEW NAMED ANGLE: per the w40 make_regs_eqv rule the surviving copy must OUTLIVE
 * its source, and here BOTH consumers are inside one loop iteration, so the copy never
 * outlives.  The reachable shape is to make the .z consumer live ACROSS the second
 * `sVar4 = sVar4 + 1;` (i.e. sink the .z store below the increment, so the old index
 * genuinely survives a redefinition of its source) -- untried, and it also explains
 * retail's rematerialized `&Fe3D_lightsVertex[idx]` for the .z store. */

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
    Fe3D_spotVertex[i].x = (short)((((iVar1 << 4) << 1) + (iVar1 << 4)) >> 8);
    Fe3D_spotVertex[i].y = 0;
    iVar1 = ccos(angle);
    angle = angle + 0x80;
    Fe3D_spotVertex[i].z = (short)((((iVar1 << 4) << 1) + (iVar1 << 4)) >> 8);
    i = i + 1;
  } while (i < 0x20);
  angle = 0;
  sVar4 = 0;
  Fe3D_spotVertex[i].x = 0;
  Fe3D_spotVertex[i].y = 0;
  Fe3D_spotVertex[i].z = 0;
  i = 0;
  while (1) {
    if (0x20 <= i) break;
    angle_sin = fastintsin(angle) >> 3;
    int cos_raw = fastintcos(angle);
    /* MATCH (w50-a6, 6 -> PASS 107/107): the w49 residual was THREE insns issued in the
     * wrong sched2 slots, and all three are STATEMENT-POSITION dials (the fence itself is
     * already at its optimum -- re-swept in the new basin, every other fence position is
     * 4/20/28):
     *  (a) retail issues the cos `sra v0,v0,3` FOURTEEN slots later, right after the .x
     *      value's `srl v1,v1,5`.  Splitting the call from its shift (`cos_raw` + a later
     *      `angle_cos = cos_raw >> 3;`) puts the shift where retail issues it (6 -> 4);
     *      any of the three store-anchored positions measures the same.
     *  (b) `angle`/`i` are bumped at the BOTTOM of the loop body, not the top -- that is
     *      what lets the two index increments float above them (4 -> 2).
     *  (c) the first `sVar4 = sVar4 + 1;` is hoisted ABOVE `iPlus = sh;` so retail's
     *      `addiu a1,s3,1` issues between the shared `sll` and the `addu a2,v1,zero`
     *      copy (2 -> 0).  Semantically free: the .x/.y/.z stores of the first vertex
     *      index off `sh`/`iPlus` (already captured), never off `sVar4`.
     * FALSIFIED in this basin: explicit `idx2` temps carrying both increments (10-20),
     * hoisting inc1 above `int sh` (22), sinking `iPlus`+fence to the .z store (20),
     * an extra void-tail fence at the .y/.z stores (10).
     *
     * MATCH (w49-a6, 14 -> 6, count now EXACT 107/107): retail computes the index
     * sign-extend as ONE shared `sll v1,s3,16`, COPIES it (`addu a2,v1,zero`) and gives
     * each consumer its own `sra ,16`; our build CSE'd the whole sll+sra pair into one
     * value (2 insns short).  Every "make a second copy" spelling the w46 receipt tried
     * was copy-propagated away.  The w47 IDENTITY FENCE (`"=r"(x) : "0"(x)`) is the
     * value-numbering barrier that survives: it emits ZERO bytes but cse can no longer
     * prove `iPlus == sh`, so the second consumer keeps its own `sra` off a copy of the
     * shared `sll`.  POSITION is the dial -- the fence must sit at iPlus's DEF (right
     * after `iPlus = sh`), not before the .z store (16) or on both (8); a plain recompute
     * (identity fence on the (short) cast form) is 28.  The explicit `sh = sVar4 << 16`
     * split is what shares the `sll`; without it the fence has nothing to split. */
    int sh = sVar4 << 16;
    sVar4 = sVar4 + 1;
    iPlus = sh;
    __asm__("" : "=r"(iPlus) : "0"(iPlus));
    angle_cos = cos_raw >> 3;
    Fe3D_lightsVertex[sh >> 16].x = (short)((u_int)(angle_sin * 3) >> 5);
    Fe3D_lightsVertex[sh >> 16].y = 0;
    Fe3D_lightsVertex[iPlus >> 16].z = (short)((u_int)(angle_cos * 3) >> 5);
    Fe3D_lightsVertex[sVar4].x = (short)(angle_sin * 0x15 >> 8);
    Fe3D_lightsVertex[sVar4].y = 0;
    Fe3D_lightsVertex[sVar4].z = (short)(angle_cos * 0x15 >> 8);
    sVar4 = sVar4 + 1;
    angle = angle + 0x20;
    i = i + 1;
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
