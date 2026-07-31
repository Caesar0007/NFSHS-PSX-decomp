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
  int one;
  int x;
  int y;
  int z;
  int wx;
  int wy;
  int wz;
  int xx;
  int xy;
  int xz;
  int yy;
  int yz;
  int zz;

  one = 0x10000000;
  x = q->x * 2;
  y = q->y * 2;
  z = q->z * 2;
  wx = q->w * x;
  wy = q->w * y;
  wz = q->w * z;
  xx = q->x * x;
  xy = q->x * y;
  xz = q->x * z;
  yy = q->y * y;
  yz = q->y * z;
  zz = q->z * z;
  matrix->m[0] = one - yy - zz >> 0xc;
  matrix->m[1] = xy + wz >> 0xc;
  matrix->m[2] = xz - wy >> 0xc;
  matrix->m[3] = xy - wz >> 0xc;
  matrix->m[4] = one - xx - zz >> 0xc;
  matrix->m[5] = yz + wx >> 0xc;
  matrix->m[6] = xz + wy >> 0xc;
  matrix->m[7] = yz - wx >> 0xc;
  matrix->m[8] = one - xx - yy >> 0xc;
  return;
}

/* ---- Quatern_MatToQuat__FP10matrixtdefP5tQuat  [QUATERN.CPP:206-278] SLD-VERIFIED ---- */
void Quatern_MatToQuat(matrixtdef *matrix,tQuat *q)

{
  int tr;
  int s;
  int i;
  
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
  tr = matrix->m[0] + matrix->m[4] + matrix->m[8];
  if (tr > 0) {
    s = fixedsqrt(tr + 0x10000);
    q->w = (short)((int)(s + ((u_int)s >> 0x1f)) >> 3);
    s = fixeddiv(0x8000,s);
    q->x = (short)(fixedmult(matrix->m[7] - matrix->m[5],s) >> 2);
    q->y = (short)(fixedmult(matrix->m[2] - matrix->m[6],s) >> 2);
    q->z = (short)(fixedmult(matrix->m[3] - matrix->m[1],s) >> 2);
    return;
  }

  i = 0;
  if (matrix->m[0] < matrix->m[4]) {
    i = 1;
    if (matrix->m[4] < matrix->m[8]) {
      i = 2;
    }
  }
  if (matrix->m[8] > matrix->m[0]) {
    i = 2;
  }

  switch (i) {
  case 0:
    s = fixedsqrt(matrix->m[0] - (matrix->m[4] + matrix->m[8]) + 0x10000);
    q->x = (short)((int)(s + ((u_int)s >> 0x1f)) >> 3);
    if (s != 0) {
      s = fixeddiv(0x8000,s);
    }
    q->w = (short)(fixedmult(matrix->m[7] - matrix->m[5],s) >> 2);
    q->y = (short)(fixedmult(matrix->m[3] + matrix->m[1],s) >> 2);
    q->z = (short)(fixedmult(matrix->m[2] + matrix->m[6],s) >> 2);
    return;

  case 1:
    s = fixedsqrt(matrix->m[4] - (matrix->m[8] + matrix->m[0]) + 0x10000);
    q->y = (short)((int)(s + ((u_int)s >> 0x1f)) >> 3);
    if (s != 0) {
      s = fixeddiv(0x8000,s);
    }
    q->w = (short)(fixedmult(matrix->m[2] - matrix->m[6],s) >> 2);
    q->z = (short)(fixedmult(matrix->m[7] + matrix->m[5],s) >> 2);
    q->x = (short)(fixedmult(matrix->m[3] + matrix->m[1],s) >> 2);
    return;

  case 2:
    s = fixedsqrt(matrix->m[8] - (matrix->m[0] + matrix->m[4]) + 0x10000);
    q->z = (short)((int)(s + ((u_int)s >> 0x1f)) >> 3);
    if (s != 0) {
      s = fixeddiv(0x8000,s);
    }
    q->w = (short)(fixedmult(matrix->m[3] - matrix->m[1],s) >> 2);
    q->x = (short)(fixedmult(matrix->m[2] + matrix->m[6],s) >> 2);
    q->y = (short)(fixedmult(matrix->m[5] + matrix->m[7],s) >> 2);
    return;

  default:
    return;
  }
}

/* end of quatern.cpp */
