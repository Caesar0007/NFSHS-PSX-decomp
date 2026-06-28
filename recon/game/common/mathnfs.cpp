/* game/common/mathnfs.cpp -- RECONSTRUCTED (NFS4 PSX fixed-point/vector math library; C++ TU)
 *   10 free fns: Math_DistXZ/Dist3D/BetterDist/ResolveRotatedVector/VectorLength[2]/
 *   NormalizeVector/NormalizeShortVector/QDNormalizeVector/fasttransmult. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "mathnfs_externs.h"

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
int Math_DistXZ(coorddef *a,coorddef *b);
int Math_Dist3D(coorddef *a,coorddef *b);
int Math_BetterDist(int a,int b);
void Math_ResolveRotatedVector(int x,int y,int angle,int *newx,int *newy);
int Math_VectorLength(coorddef *v);
int Math_VectorLength2(coorddef *v);
void Math_NormalizeVector(coorddef *v);
void Math_NormalizeShortVector(coorddef *v);
void Math_QDNormalizeVector(coorddef *v);
void Math_fasttransmult(matrixtdef *m1,matrixtdef *m2,matrixtdef *mr);


/* ---- Math_DistXZ__FP8coorddefT0  [MATHNFS.CPP:26-38] SLD-VERIFIED ---- */
int Math_DistXZ(coorddef *a,coorddef *b)

{
  int dist;
  int ax;
  int bx;
  int az;
  int bz;
  int x;
  int z;

  ax = a->x;
  bx = b->x;
  x = ax - bx;
  if (x < 1) {
    x = bx - ax;
  }
  az = a->z;
  bz = b->z;
  z = az - bz;
  if (z < 1) {
    z = bz - az;
  }
  if (z < x) {
    dist = x + (z >> 2);
  }
  else {
    dist = z + (x >> 2);
  }
  return dist;
}

/* ---- Math_Dist3D__FP8coorddefT0  [MATHNFS.CPP:42-53] SLD-VERIFIED ---- */
int Math_Dist3D(coorddef *a,coorddef *b)

{
  int dist;
  int dist2;
  int y;
  int iVar1;
  int z;
  int iVar2;
  int iVar3;
  int x;
  
  y = a->x;
  iVar3 = y - b->x;
  if (iVar3 < 1) {
    iVar3 = b->x - y;
  }
  iVar1 = a->y - b->y;
  if (iVar1 < 1) {
    iVar1 = b->y - a->y;
  }
  iVar2 = a->z - b->z;
  if (iVar2 < 1) {
    iVar2 = b->z - a->z;
  }
  if (iVar1 < iVar3) {
    iVar3 = iVar3 + (iVar1 >> 2);
  }
  else {
    iVar3 = iVar1 + (iVar3 >> 2);
  }
  if (iVar2 < iVar3) {
    return iVar3 + (iVar2 >> 2);
  }
  return iVar2 + (iVar3 >> 2);
}

/* ---- Math_BetterDist__Fii  [MATHNFS.CPP:57-79] SLD-VERIFIED ---- */
int Math_BetterDist(int a,int b)

{
  int x;
  int y;
  int iVar1;
  int iVar2;
  int iVar5;
  int iVar6;
  int iVar9;
  int iVar3;
  int iVar4;
  int iVar7;
  int iVar8;
  
  iVar9 = a;
  if (b < a) {
    iVar9 = b;
    b = a;
  }
  iVar2 = iVar9 >> 6;
  iVar3 = iVar9 >> 7;
  iVar4 = iVar9 >> 9;
  iVar5 = iVar9 >> 0xe;
  if (iVar9 < b >> 2) {
    iVar1 = b + (iVar9 >> 4) + iVar2 + iVar3 + iVar4 + iVar5;
    iVar5 = iVar9 >> 0xf;
  }
  else {
    iVar6 = iVar9 >> 5;
    iVar7 = iVar9 >> 8;
    iVar8 = iVar9 >> 0xc;
    iVar1 = iVar9 >> 0xd;
    if (b >> 1 <= iVar9) {
      if (iVar9 < (b >> 1) + (b >> 2)) {
        return b + (iVar9 >> 2) + iVar6 + iVar7 + (iVar9 >> 10) + (iVar9 >> 0xb) + iVar8 +
               iVar1;
      }
      return b + (iVar9 >> 2) + (iVar9 >> 4) + iVar6 + iVar2 + iVar3 + iVar7 + iVar4 +
             (iVar9 >> 0xb) + iVar8 + iVar1 + iVar5 + (iVar9 >> 0xf);
    }
    iVar1 = b + (iVar9 >> 3) + iVar6 + iVar2 + iVar3 + iVar7 + iVar4 + iVar8 + iVar1;
  }
  return iVar1 + iVar5 + (iVar9 >> 0x10);
}

/* ---- Math_ResolveRotatedVector__FiiiPiT3  [MATHNFS.CPP:96-103] SLD-VERIFIED ---- */
void Math_ResolveRotatedVector(int x,int y,int angle,int *newx,int *newy)

{
  int ds;
  int dc;
  int a;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  
  if (angle < 0) {
    angle = angle + 0xff;
  }
  iVar1 = fixedsin(angle >> 8);
  iVar2 = fixedcos(angle >> 8);
  iVar3 = fixedmult(iVar2,x);
  iVar4 = fixedmult(iVar1,y);
  *newx = iVar3 - iVar4;
  iVar1 = fixedmult(iVar1,x);
  iVar2 = fixedmult(iVar2,y);
  *newy = iVar1 + iVar2;
  return;
}

/* ---- Math_VectorLength__FP8coorddef  [MATHNFS.CPP:132-199] SLD-VERIFIED ---- */
int Math_VectorLength(coorddef *v)

{
  u_int vx2s;
  int length;
  u_int uVar1;
  u_int uVar2;
  u_int uVar3;
  u_int vy2s;
  int iVar4;
  u_int vz2s;
  u_int vz2;
  int vz;
  int a;
  int vy;
  int a_00;
  int vx;
  int a_01;
  int shifts;
  int iVar5;
  u_int vy2;
  u_int vx2;
  
  iVar5 = 0;
  a_01 = v->x;
  a_00 = v->y;
  a = v->z;
  iVar4 = a_01;
  if (a_01 < 0) {
    iVar4 = -a_01;
  }
  do {
    if (iVar4 < 0x1000001) {
      iVar4 = a_00;
      if (a_00 < 0) {
        iVar4 = -a_00;
      }
      if (iVar4 < 0x1000001) {
        iVar4 = a;
        if (a < 0) {
          iVar4 = -a;
        }
        if (iVar4 < 0x1000001) {
          uVar1 = fixedmult(a_01,a_01);
          uVar2 = fixedmult(a_00,a_00);
          uVar3 = fixedmult(a,a);
          iVar4 = uVar1 + uVar2;
          for (uVar1 = (uVar1 >> 2) + (uVar2 >> 2) + (uVar3 >> 2); 0x40000000 < uVar1;
              uVar1 = (uVar1 >> 2) + (uVar2 >> 2) + (uVar3 >> 2)) {
            a_01 = a_01 >> 1;
            a_00 = a_00 >> 1;
            a = a >> 1;
            iVar5 = iVar5 + 1;
            uVar1 = fixedmult(a_01,a_01);
            uVar2 = fixedmult(a_00,a_00);
            uVar3 = fixedmult(a,a);
            iVar4 = uVar1 + uVar2;
          }
          iVar4 = fixedsqrt(iVar4 + uVar3);
          for (; iVar5 != 0; iVar5 = iVar5 + -1) {
            iVar4 = iVar4 << 1;
          }
          return iVar4;
        }
      }
    }
    a_01 = a_01 >> 1;
    a_00 = a_00 >> 1;
    a = a >> 1;
    iVar5 = iVar5 + 1;
    iVar4 = a_01;
    if (a_01 < 0) {
      iVar4 = -a_01;
    }
  } while( true );
}

/* ---- Math_VectorLength2__FP8coorddef  [MATHNFS.CPP:207-273] SLD-VERIFIED ---- */
int Math_VectorLength2(coorddef *v)

{
  u_int vx2s;
  int length2;
  u_int uVar1;
  u_int uVar2;
  u_int uVar3;
  int iVar4;
  u_int vy2s;
  u_int vz2s;
  u_int vz2;
  int vz;
  int a;
  int vy;
  int a_00;
  int vx;
  int a_01;
  int shifts;
  int iVar5;
  u_int vy2;
  u_int vx2;
  
  iVar5 = 0;
  a_01 = v->x;
  a_00 = v->y;
  a = v->z;
  iVar4 = a_01;
  if (a_01 < 0) {
    iVar4 = -a_01;
  }
  do {
    if (iVar4 < 0x1000001) {
      iVar4 = a_00;
      if (a_00 < 0) {
        iVar4 = -a_00;
      }
      if (iVar4 < 0x1000001) {
        iVar4 = a;
        if (a < 0) {
          iVar4 = -a;
        }
        if (iVar4 < 0x1000001) {
          uVar1 = fixedmult(a_01,a_01);
          uVar2 = fixedmult(a_00,a_00);
          uVar3 = fixedmult(a,a);
          iVar4 = uVar1 + uVar2;
          for (uVar1 = (uVar1 >> 2) + (uVar2 >> 2) + (uVar3 >> 2); 0x40000000 < uVar1;
              uVar1 = (uVar1 >> 2) + (uVar2 >> 2) + (uVar3 >> 2)) {
            a_01 = a_01 >> 1;
            a_00 = a_00 >> 1;
            a = a >> 1;
            iVar5 = iVar5 + 1;
            uVar1 = fixedmult(a_01,a_01);
            uVar2 = fixedmult(a_00,a_00);
            uVar3 = fixedmult(a,a);
            iVar4 = uVar1 + uVar2;
          }
          iVar4 = iVar4 + uVar3;
          for (; iVar5 != 0; iVar5 = iVar5 + -1) {
            iVar4 = iVar4 << 2;
          }
          return iVar4;
        }
      }
    }
    a_01 = a_01 >> 1;
    a_00 = a_00 >> 1;
    a = a >> 1;
    iVar5 = iVar5 + 1;
    iVar4 = a_01;
    if (a_01 < 0) {
      iVar4 = -a_01;
    }
  } while( true );
}

/* ---- Math_NormalizeVector__FP8coorddef  [MATHNFS.CPP:298-362] SLD-VERIFIED ---- */
void Math_NormalizeVector(coorddef *v)

{
  u_int vy2;
  u_int vx2s;
  u_int uVar1;
  u_int uVar2;
  u_int uVar3;
  int iVar4;
  u_int uVar5;
  u_int vy2s;
  u_int vz2s;
  u_int vz2;
  int vx;
  int iVar6;
  int vy;
  int a;
  int vz;
  int a_00;
  int length;
  u_int vx2;
  
  iVar6 = v->x;
  a = v->y;
  a_00 = v->z;
  iVar4 = iVar6;
  if (iVar6 < 0) {
    iVar4 = -iVar6;
  }
  do {
    if (iVar4 < 0x1000001) {
      iVar4 = a;
      if (a < 0) {
        iVar4 = -a;
      }
      if (iVar4 < 0x1000001) {
        iVar4 = a_00;
        if (a_00 < 0) {
          iVar4 = -a_00;
        }
        if (iVar4 < 0x1000001) {
          uVar1 = fixedmult(iVar6,iVar6);
          uVar2 = fixedmult(a,a);
          uVar3 = fixedmult(a_00,a_00);
          uVar5 = (uVar1 >> 2) + (uVar2 >> 2) + (uVar3 >> 2);
          while (0x40000000 < uVar5) {
            iVar6 = iVar6 >> 1;
            a = a >> 1;
            a_00 = a_00 >> 1;
            uVar1 = fixedmult(iVar6,iVar6);
            uVar2 = fixedmult(a,a);
            uVar3 = fixedmult(a_00,a_00);
            uVar5 = (uVar1 >> 2) + (uVar2 >> 2) + (uVar3 >> 2);
          }
          iVar4 = fixedsqrt(uVar1 + uVar2 + uVar3);
          if (iVar4 != 0) {
            iVar6 = fixeddiv(iVar6,iVar4);
            v->x = iVar6;
            iVar6 = fixeddiv(a,iVar4);
            v->y = iVar6;
            iVar4 = fixeddiv(a_00,iVar4);
            v->z = iVar4;
          }
          return;
        }
      }
    }
    iVar6 = iVar6 >> 1;
    a = a >> 1;
    a_00 = a_00 >> 1;
    iVar4 = iVar6;
    if (iVar6 < 0) {
      iVar4 = -iVar6;
    }
  } while( true );
}

/* ---- Math_NormalizeShortVector__FP8coorddef  [MATHNFS.CPP:371-386] SLD-VERIFIED ---- */
void Math_NormalizeShortVector(coorddef *v)

{
  int length;
  int len_or_inv;
  int tmp;
  int z_sq;
  int iVar1;
  int iVar2;
  int inverse;

  len_or_inv = fixedmult(v->x,v->x);
  tmp = fixedmult(v->y,v->y);
  z_sq = fixedmult(v->z,v->z);
  iVar1 = fixedsqrt(len_or_inv + tmp + z_sq);
  if (iVar1 != 0) {
    iVar1 = fixeddiv(0x10000,iVar1);
    iVar2 = fixedmult(v->x,iVar1);
    v->x = iVar2;
    iVar2 = fixedmult(v->y,iVar1);
    v->y = iVar2;
    iVar1 = fixedmult(v->z,iVar1);
    v->z = iVar1;
  }
  return;
}

/* ---- Math_QDNormalizeVector__FP8coorddef  [MATHNFS.CPP:396-417] SLD-VERIFIED ---- */
void Math_QDNormalizeVector(coorddef *v)

{
  coorddef temp;
  int length;
  int inverse;
  u_int uVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int local_18;
  int local_14;
  int local_10;
  
  local_18 = v->x;
  local_14 = v->y;
  local_10 = v->z;
  if (local_18 < 0) {
    local_18 = -local_18;
  }
  if (local_14 < 0) {
    local_14 = -local_14;
  }
  if (local_10 < 0) {
    local_10 = -local_10;
  }
  uVar1 = Math_BetterDist(local_18,local_14);
  iVar2 = Math_BetterDist(uVar1,local_10);
  if (iVar2 != 0) {
    iVar2 = rinverse(iVar2);
    iVar4 = v->x;
    if (iVar4 < 0) {
      iVar4 = iVar4 + 0xff;
    }
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar2 = iVar2 >> 8;
    iVar3 = v->y;
    v->x = (iVar4 >> 8) * iVar2;
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    iVar4 = v->z;
    v->y = (iVar3 >> 8) * iVar2;
    if (iVar4 < 0) {
      iVar4 = iVar4 + 0xff;
    }
    v->z = (iVar4 >> 8) * iVar2;
  }
  return;
}

/* ---- Math_fasttransmult__FP10matrixtdefN20  [MATHNFS.CPP:533-584] SLD-VERIFIED ---- */
void Math_fasttransmult(matrixtdef *m1,matrixtdef *m2,matrixtdef *mr)

{
  int val;
  int tb;
  int tf;
  int iVar1;
  int *piVar2;
  int te;
  int ta;
  int iVar3;
  int td;
  int tc;
  int j;
  int iVar4;
  int *piVar5;
  int iVar6;
  int iVar7;
  int i;
  int iVar8;
  int *piVar9;
  int inverse;
  int shifts;
  u_int vy2;
  u_int vx2;
  int iVar10;
  int iVar11;
  matrixtdef mtmp;
  
  iVar8 = 0;
  iVar11 = 8;
  iVar10 = 4;
  piVar9 = m1->m;
  do {
    iVar4 = 0;
    iVar7 = 0x18;
    iVar6 = 0xc;
    piVar5 = m2->m;
    do {
      ta = *piVar9;
      iVar1 = *piVar5;
      piVar2 = (int *)((int)m2->m + iVar6);
      piVar5 = piVar5 + 1;
      iVar6 = iVar6 + 4;
      iVar3 = iVar8 + iVar4;
      iVar4 = iVar4 + 1;
      mtmp.m[iVar3] =
           ((ta >> 3) * (iVar1 >> 3) >> 10) +
           ((*(int *)((int)m1->m + iVar10) >> 3) * (*piVar2 >> 3) >> 10) +
           ((*(int *)((int)m1->m + iVar11) >> 3) * (*(int *)((int)m2->m + iVar7) >> 3) >> 10);
      iVar7 = iVar7 + 4;
    } while (iVar4 < 3);
    iVar11 = iVar11 + 0xc;
    iVar10 = iVar10 + 0xc;
    iVar8 = iVar8 + 3;
    piVar9 = piVar9 + 3;
  } while (iVar8 < 9);
  mr->m[0] = mtmp.m[0];
  mr->m[1] = mtmp.m[1];
  mr->m[2] = mtmp.m[2];
  mr->m[3] = mtmp.m[3];
  mr->m[4] = mtmp.m[4];
  mr->m[5] = mtmp.m[5];
  mr->m[6] = mtmp.m[6];
  mr->m[7] = mtmp.m[7];
  mr->m[8] = mtmp.m[8];
  return;
}

/* end of mathnfs.cpp */
