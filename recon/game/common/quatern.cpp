/* game/common/quatern.cpp -- RECONSTRUCTED (NFS4 PSX quaternion math; C++ TU)
 *   4 fns: Quatern_VecInterpolate/Interpolate (replay keyframe SLERP) + QuatToMat/MatToQuat.
 *   GTE-free (plain fixed-point + fixedsqrt). Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "quatern_externs.h"

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Quatern_VecInterpolate(coorddef *cp0,coorddef *cp1,int weight,coorddef *cp);
void Quatern_Interpolate(tQuat *q0,tQuat *q1,coorddef *cp0,coorddef *cp1,int weight,tQuat *q,coorddef *cp);
void Quatern_QuatToMat(tQuat *q,matrixtdef *matrix);
void Quatern_MatToQuat(matrixtdef *matrix,tQuat *q);


/* ---- Quatern_VecInterpolate__FP8coorddefT0iT0  [QUATERN.CPP:59-63] SLD-VERIFIED ---- */
void Quatern_VecInterpolate(coorddef *cp0,coorddef *cp1,int weight,coorddef *cp)

{
  int iVar1;
  
  iVar1 = fixedmult(cp1->x - cp0->x,weight);
  cp->x = cp0->x + iVar1;
  iVar1 = fixedmult(cp1->y - cp0->y,weight);
  cp->y = cp0->y + iVar1;
  iVar1 = fixedmult(cp1->z - cp0->z,weight);
  cp->z = cp0->z + iVar1;
  return;
}

/* ---- Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2  [QUATERN.CPP:67-75] SLD-VERIFIED ---- */
void Quatern_Interpolate(tQuat *q0,tQuat *q1,coorddef *cp0,coorddef *cp1,int weight,tQuat *q,coorddef *cp)

{
  int iVar1;
  
  iVar1 = fixedmult((int)q1->x - (int)q0->x,weight);
  q->x = q0->x + (short)iVar1;
  iVar1 = fixedmult((int)q1->y - (int)q0->y,weight);
  q->y = q0->y + (short)iVar1;
  iVar1 = fixedmult((int)q1->z - (int)q0->z,weight);
  q->z = q0->z + (short)iVar1;
  iVar1 = fixedmult((int)q1->w - (int)q0->w,weight);
  q->w = q0->w + (short)iVar1;
  Quatern_VecInterpolate(cp0,cp1,weight,cp);
  return;
}

/* ---- Quatern_QuatToMat__FP5tQuatP10matrixtdef  [QUATERN.CPP:158-189] SLD-VERIFIED ---- */
void Quatern_QuatToMat(tQuat *q,matrixtdef *matrix)

{
  int iVar1;
  int iVar2;
  int x;
  int y;
  int zz;
  int one;
  int iVar3;
  int iVar4;
  int xz;
  int iVar5;
  int yz;
  int xy;
  int z;
  int iVar6;
  int wz;
  int iVar7;
  int yy;
  int iVar8;
  int wy;
  int wx;
  int xx;
  
  iVar4 = (int)q->x;
  iVar7 = (int)q->w;
  iVar1 = iVar7 * iVar4 * 2;
  iVar5 = (int)q->y;
  iVar8 = iVar5 * 2;
  iVar6 = q->z * 2;
  iVar2 = q->z * iVar6;
  iVar3 = 0x10000000 - iVar4 * iVar4 * 2;
  matrix->m[0] = (0x10000000 - iVar5 * iVar8) - iVar2 >> 0xc;
  matrix->m[1] = iVar4 * iVar8 + iVar7 * iVar6 >> 0xc;
  matrix->m[3] = iVar4 * iVar8 - iVar7 * iVar6 >> 0xc;
  matrix->m[4] = iVar3 - iVar2 >> 0xc;
  matrix->m[8] = iVar3 - iVar5 * iVar8 >> 0xc;
  matrix->m[2] = iVar4 * iVar6 - iVar7 * iVar8 >> 0xc;
  matrix->m[6] = iVar4 * iVar6 + iVar7 * iVar8 >> 0xc;
  matrix->m[5] = iVar5 * iVar6 + iVar1 >> 0xc;
  matrix->m[7] = iVar5 * iVar6 - iVar1 >> 0xc;
  return;
}

/* ---- Quatern_MatToQuat__FP10matrixtdefP5tQuat  [QUATERN.CPP:206-278] SLD-VERIFIED ---- */
void Quatern_MatToQuat(matrixtdef *matrix,tQuat *q)

{
  int tr;
  int iVar1;
  int i;
  u_int uVar2;
  int iVar3;
  int xz;
  int yz;
  int xy;
  int z;
  int wz;
  int yy;
  int wy;
  int wx;
  int xx;
  int s;
  
  if ((((((matrix->m[0] == 0x10000) && (matrix->m[1] == 0)) && (matrix->m[2] == 0)) &&
       ((matrix->m[3] == 0 && (matrix->m[4] == 0x10000)))) &&
      ((matrix->m[5] == 0 && ((matrix->m[6] == 0 && (matrix->m[7] == 0)))))) &&
     (matrix->m[8] == 0x10000)) {
    q->w = 0x4000;
    q->x = 0;
    q->y = 0;
    q->z = 0;
    return;
  }
  iVar3 = matrix->m[4];
  iVar1 = matrix->m[0] + iVar3 + matrix->m[8];
  if (iVar1 < 1) {
    uVar2 = 0;
    if ((matrix->m[0] < iVar3) && (uVar2 = 1, iVar3 < matrix->m[8])) {
      uVar2 = 2;
    }
    iVar3 = matrix->m[8];
    iVar1 = matrix->m[0];
    if (iVar1 < iVar3) {
      uVar2 = 2;
    }
    if (uVar2 == 1) {
      iVar3 = fixedsqrt((matrix->m[4] - (iVar3 + iVar1)) + 0x10000);
      q->y = (short)(iVar3 - (iVar3 >> 0x1f) >> 3);
      iVar1 = 0;
      if (iVar3 != 0) {
        iVar1 = fixeddiv(0x8000,iVar3);
      }
      iVar3 = fixedmult(matrix->m[2] - matrix->m[6],iVar1);
      q->w = (short)(iVar3 >> 2);
      iVar3 = fixedmult(matrix->m[7] + matrix->m[5],iVar1);
      q->z = (short)(iVar3 >> 2);
      iVar1 = fixedmult(matrix->m[3] + matrix->m[1],iVar1);
      q->x = (short)(iVar1 >> 2);
      return;
    }
    if (1 < uVar2) {
      if (uVar2 != 2) {
        return;
      }
      iVar3 = fixedsqrt((iVar3 - (iVar1 + matrix->m[4])) + 0x10000);
      q->z = (short)(iVar3 - (iVar3 >> 0x1f) >> 3);
      iVar1 = 0;
      if (iVar3 != 0) {
        iVar1 = fixeddiv(0x8000,iVar3);
      }
      iVar3 = fixedmult(matrix->m[3] - matrix->m[1],iVar1);
      q->w = (short)(iVar3 >> 2);
      iVar3 = fixedmult(matrix->m[2] + matrix->m[6],iVar1);
      q->x = (short)(iVar3 >> 2);
      iVar1 = fixedmult(matrix->m[5] + matrix->m[7],iVar1);
      q->y = (short)(iVar1 >> 2);
      return;
    }
    if (uVar2 != 0) {
      return;
    }
    iVar3 = fixedsqrt((iVar1 - (matrix->m[4] + iVar3)) + 0x10000);
    q->x = (short)(iVar3 - (iVar3 >> 0x1f) >> 3);
    iVar1 = 0;
    if (iVar3 != 0) {
      iVar1 = fixeddiv(0x8000,iVar3);
    }
    iVar3 = fixedmult(matrix->m[7] - matrix->m[5],iVar1);
    q->w = (short)(iVar3 >> 2);
    iVar3 = fixedmult(matrix->m[3] + matrix->m[1],iVar1);
    q->y = (short)(iVar3 >> 2);
    iVar3 = matrix->m[2] + matrix->m[6];
  }
  else {
    iVar1 = fixedsqrt(iVar1 + 0x10000);
    q->w = (short)(iVar1 - (iVar1 >> 0x1f) >> 3);
    iVar1 = fixeddiv(0x8000,iVar1);
    iVar3 = fixedmult(matrix->m[7] - matrix->m[5],iVar1);
    q->x = (short)(iVar3 >> 2);
    iVar3 = fixedmult(matrix->m[2] - matrix->m[6],iVar1);
    q->y = (short)(iVar3 >> 2);
    iVar3 = matrix->m[3] - matrix->m[1];
  }
  iVar1 = fixedmult(iVar3,iVar1);
  q->z = (short)(iVar1 >> 2);
  return;
}

/* end of quatern.cpp */
