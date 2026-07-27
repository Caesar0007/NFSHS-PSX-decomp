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
  az = a->z;
  bz = b->z;
  x = ax - bx;
  if (x < 1) {
    x = bx - ax;
  }
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
  int z;
  int x;

  x = a->x - b->x;
  if (x < 1) {
    x = b->x - a->x;
  }
  y = a->y - b->y;
  if (y < 1) {
    y = b->y - a->y;
  }
  z = a->z - b->z;
  if (z < 1) {
    z = b->z - a->z;
  }
  if (y < x) {
    dist = x + (y >> 2);
  }
  else {
    dist = y + (x >> 2);
  }
  if (z < dist) {
    dist2 = dist + (z >> 2);
  }
  else {
    dist2 = z + (dist >> 2);
  }
  return dist2;
}

/* ---- Math_BetterDist__Fii  [MATHNFS.CPP:57-79] SLD-VERIFIED ---- */
int Math_BetterDist(int a,int b)

{
  int x;
  int y;

  if (b < a) {
    x = a;
    y = b;
  } else {
    x = b;
    y = a;
  }
  if (y < x >> 2) {
    return x + (y >> 4) + (y >> 6) + (y >> 7) + (y >> 9) +
           (y >> 14) + (y >> 15) + (y >> 16);
  }
  if (y < x >> 1) {
    return x + (y >> 3) + (y >> 5) + (y >> 6) + (y >> 7) +
           (y >> 8) + (y >> 9) + (y >> 12) + (y >> 13) +
           (y >> 14) + (y >> 16);
  }
  if (y < (x >> 1) + (x >> 2)) {
    return x + (y >> 2) + (y >> 5) + (y >> 8) + (y >> 10) +
           (y >> 11) + (y >> 12) + (y >> 13);
  }
  return x + (y >> 2) + (y >> 4) + (y >> 5) + (y >> 6) +
         (y >> 7) + (y >> 8) + (y >> 9) + (y >> 11) +
         (y >> 12) + (y >> 13) + (y >> 14) + (y >> 15);
}

/* ---- Math_ResolveRotatedVector__FiiiPiT3  [MATHNFS.CPP:96-103] SLD-VERIFIED ---- */
void Math_ResolveRotatedVector(int x,int y,int angle,int *newx,int *newy)

{
  int ds;
  int dc;
  int a;

  a = angle / 256;
  ds = fixedsin(a);
  dc = fixedcos(a);
  *newx = fixedmult(dc,x) - fixedmult(ds,y);
  *newy = fixedmult(ds,x) + fixedmult(dc,y);
  return;
}

/* ---- Math_VectorLength__FP8coorddef  [MATHNFS.CPP:132-199] SLD-VERIFIED ---- */
int Math_VectorLength(coorddef *v)

{
  u_int vx2s;
  int length;
  u_int vy2s;
  u_int vz2s;
  u_int vz2;
  int vz;
  int vy;
  int vx;
  int shifts;
  u_int vy2;
  u_int vx2;

  shifts = 0;
  vx = v->x;
  vy = v->y;
  vz = v->z;
  do {
    int absV = (vx < 0) ? -vx : vx;
    if (absV < 0x1000001) {
      absV = (vy < 0) ? -vy : vy;
      if (absV < 0x1000001) {
        absV = (vz < 0) ? -vz : vz;
        if (absV < 0x1000001) {
          vx2 = fixedmult(vx,vx);
          vy2 = fixedmult(vy,vy);
          vz2 = fixedmult(vz,vz);
          vx2s = vx2 >> 2;
          vy2s = vy2 >> 2;
          vz2s = vz2 >> 2;
          while (0x40000000 < vx2s + vy2s + vz2s) {
            vx = vx >> 1;
            vy = vy >> 1;
            vz = vz >> 1;
            shifts = shifts + 1;
            vx2 = fixedmult(vx,vx);
            vy2 = fixedmult(vy,vy);
            vz2 = fixedmult(vz,vz);
            vx2s = vx2 >> 2;
            vy2s = vy2 >> 2;
            vz2s = vz2 >> 2;
          }
          length = fixedsqrt(vx2 + vy2 + vz2);
          while (shifts != 0) {
            shifts = shifts - 1;
            length = length << 1;
          }
          return length;
        }
      }
    }
    vx = vx >> 1;
    vy = vy >> 1;
    vz = vz >> 1;
    shifts = shifts + 1;
  } while( true );
}

/* ---- Math_VectorLength2__FP8coorddef  [MATHNFS.CPP:207-273] SLD-VERIFIED ---- */
int Math_VectorLength2(coorddef *v)

{
  u_int vx2s;
  int length2;
  u_int vy2s;
  u_int vz2s;
  u_int vz2;
  int vz;
  int vy;
  int vx;
  int shifts;
  u_int vy2;
  u_int vx2;

  shifts = 0;
  vx = v->x;
  vy = v->y;
  vz = v->z;
  do {
    int absV = (vx < 0) ? -vx : vx;
    if (absV < 0x1000001) {
      absV = (vy < 0) ? -vy : vy;
      if (absV < 0x1000001) {
        absV = (vz < 0) ? -vz : vz;
        if (absV < 0x1000001) {
          vx2 = fixedmult(vx,vx);
          vy2 = fixedmult(vy,vy);
          vz2 = fixedmult(vz,vz);
          vx2s = vx2 >> 2;
          vy2s = vy2 >> 2;
          vz2s = vz2 >> 2;
          while (0x40000000 < vx2s + vy2s + vz2s) {
            vx = vx >> 1;
            vy = vy >> 1;
            vz = vz >> 1;
            shifts = shifts + 1;
            vx2 = fixedmult(vx,vx);
            vy2 = fixedmult(vy,vy);
            vz2 = fixedmult(vz,vz);
            vx2s = vx2 >> 2;
            vy2s = vy2 >> 2;
            vz2s = vz2 >> 2;
          }
          length2 = vx2 + vy2 + vz2;
          while (shifts != 0) {
            shifts = shifts - 1;
            length2 = length2 << 2;
          }
          return length2;
        }
      }
    }
    vx = vx >> 1;
    vy = vy >> 1;
    vz = vz >> 1;
    shifts = shifts + 1;
  } while( true );
}

/* ---- Math_NormalizeVector__FP8coorddef  [MATHNFS.CPP:298-362] SLD-VERIFIED ---- */
void Math_NormalizeVector(coorddef *v)

{
  u_int vx2s;
  u_int vy2s;
  u_int vz2s;
  u_int vz2;
  int vx;
  int vy;
  int vz;
  int length;
  u_int vy2;
  u_int vx2;

  vx = v->x;
  vy = v->y;
  vz = v->z;
  do {
    if (__builtin_abs(vx) < 0x1000001) {
      if (__builtin_abs(vy) < 0x1000001) {
        if (__builtin_abs(vz) < 0x1000001) {
          vx2 = fixedmult(vx,vx);
          vy2 = fixedmult(vy,vy);
          vz2 = fixedmult(vz,vz);
          vx2s = vx2 >> 2;
          vy2s = vy2 >> 2;
          vz2s = vz2 >> 2;
          while (0x40000000 < vx2s + vy2s + vz2s) {
            vx = vx >> 1;
            vy = vy >> 1;
            vz = vz >> 1;
            vx2 = fixedmult(vx,vx);
            vy2 = fixedmult(vy,vy);
            vz2 = fixedmult(vz,vz);
            vx2s = vx2 >> 2;
            vy2s = vy2 >> 2;
            vz2s = vz2 >> 2;
          }
          length = fixedsqrt(vx2 + vy2 + vz2);
          if (length != 0) {
            v->x = fixeddiv(vx,length);
            v->y = fixeddiv(vy,length);
            v->z = fixeddiv(vz,length);
          }
          return;
        }
      }
    }
    vx = vx >> 1;
    vy = vy >> 1;
    vz = vz >> 1;
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
  length = fixedsqrt(len_or_inv + tmp + z_sq);
  if (length != 0) {
    inverse = fixeddiv(0x10000,length);
    iVar2 = fixedmult(v->x,inverse);
    v->x = iVar2;
    iVar2 = fixedmult(v->y,inverse);
    v->y = iVar2;
    iVar1 = fixedmult(v->z,inverse);
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

  temp = *v;
  if (temp.x < 0) {
    temp.x = -temp.x;
  }
  if (temp.y < 0) {
    temp.y = -temp.y;
  }
  if (temp.z < 0) {
    temp.z = -temp.z;
  }
  length = Math_BetterDist(temp.x,temp.y);
  length = Math_BetterDist(length,temp.z);
  if (length != 0) {
    inverse = rinverse(length);
    v->x = (v->x / 256) * (inverse / 256);
    v->y = (v->y / 256) * (inverse / 256);
    v->z = (v->z / 256) * (inverse / 256);
  }
}

/* ---- Math_fasttransmult__FP10matrixtdefN20  [MATHNFS.CPP:533-584] SLD-VERIFIED ---- */
void Math_fasttransmult(matrixtdef *m1,matrixtdef *m2,matrixtdef *mr)

{
  int i;
  int j;
  int val;
  matrixtdef mtmp;
  int ta;
  int tb;
  int tc;
  int td;
  int te;
  int tf;

  for (i = 0; i < 9; i += 3) {
    for (j = 0; j < 3; j++) {
      ta = m1->m[i];
      tb = m2->m[j];
      tc = m1->m[i + 1];
      td = m2->m[j + 3];
      te = m1->m[i + 2];
      tf = m2->m[j + 6];
      val = ((ta >> 3) * (tb >> 3) >> 10) +
            ((tc >> 3) * (td >> 3) >> 10) +
            ((te >> 3) * (tf >> 3) >> 10);
      mtmp.m[i + j] = val;
    }
  }
  ta = mtmp.m[0];
  tb = mtmp.m[1];
  tc = mtmp.m[2];
  td = mtmp.m[3];
  te = mtmp.m[4];
  mr->m[0] = ta;
  mr->m[1] = tb;
  mr->m[2] = tc;
  mr->m[3] = td;
  mr->m[4] = te;
  ta = mtmp.m[5];
  tb = mtmp.m[6];
  tc = mtmp.m[7];
  td = mtmp.m[8];
  mr->m[5] = ta;
  mr->m[6] = tb;
  mr->m[7] = tc;
  mr->m[8] = td;
}

/* end of mathnfs.cpp */
