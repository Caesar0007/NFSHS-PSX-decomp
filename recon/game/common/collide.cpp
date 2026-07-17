/* game/common/collide.cpp -- RECONSTRUCTED (NFS4 collision detection; BO_tNewtonObj vs world/objects).
 *   13 fns: vertex/center-vertex direction checks, plane test, object-object + accurate point-radius
 *   collision, registry. SYM-v3 locals applied; owns 16 globals (registry/ranges/basis-dot scratch).
 *   NOT original source; self-contained, recompilable. Ghidra LAB_<addr> goto-labels = deferred-#148 cosmetic.
 */
#include "../../nfs4_types.h"
#include "collide_externs.h"


/* ---- collide.obj-owned globals (real NFS4.EXE bytes / .bss zero) ---- */
BO_tNewtonObj *Collide_gRegistry[16];   /* @0x80110c30  (bss(zero)) */
int          Collide_gRaiseUp = 1;   /* @0x8013c82c */
int          frictionLess;   /* @0x8013c830  (bss(zero)) */
int          Collide_gNumRegistered;   /* @0x8013c834  (bss(zero)) */
int          findClosestSideDave;   /* @0x8013c838  (bss(zero)) */
BO_tNewtonObj *obj0;   /* @0x8013c83c  (bss(zero)) */
BO_tNewtonObj *obj1;   /* @0x8013c840  (bss(zero)) */
coorddef     *pNormal;   /* @0x8013c844  (bss(zero)) */
coorddef     *pP;   /* @0x8013c848  (bss(zero)) */
int          xRange;   /* @0x8013dd98  (bss(zero)) */
int          yRange;   /* @0x8013dd9c  (bss(zero)) */
int          zRange;   /* @0x8013dda0  (bss(zero)) */
int          basisDots[9];   /* @0x8013e008  (bss?) */
int          scaledBasisDots[9];   /* @0x8013e038  (bss?) */
int          scaledBasisDotsOther[9];   /* @0x8013e068  (bss?) */
int          basisDotRelative[6];   /* @0x8013e098  (bss?) */


/* ---- intra-TU forward declarations ---- */
int CHECK_CENTER_VERTEX_WITH_DIRS(int X_DIR,int Y_DIR,int Z_DIR);
int CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(int X_DIR,int Y_DIR,int Z_DIR);
int CHECK_VERTEX_WITH_DIRS(int X_DIR,int Y_DIR,int Z_DIR);
int CHECK_VERTEX_WITH_DIRS_OTHER(int X_DIR,int Y_DIR,int Z_DIR);
void Collide_DoObjectFixedObjectCollision(BO_tNewtonObj *o,coorddef *p,coorddef *v,coorddef *n);
void Collide_LimitAngularVel(BO_tNewtonObj *o);
void Collide_TestWithPlane(BO_tNewtonObj *o,coorddef *normal,coorddef *samplePoint);
int Collide_DoObjectObjectCollision(BO_tNewtonObj *o0,BO_tNewtonObj *o1,coorddef *p,coorddef *normal);
int Collide_DoActualObjectCollisionCheck(BO_tNewtonObj *o0,BO_tNewtonObj *o1,coorddef *p,coorddef *normal);
int Collide_TestObjectVertices(BO_tNewtonObj *o0,BO_tNewtonObj *o1,coorddef *p,coorddef *normal);
int Collide_CheckForCollisionBetween(BO_tNewtonObj *o0,BO_tNewtonObj *o1);
void Collide_ClearCollisionRegistry(void);
int Collide_CheckAccuratePointRadiusCollision(BO_tNewtonObj *newObj,coorddef *point,int radius);
void Collide_CheckMeForCollisions(BO_tNewtonObj *newObj);


/* ---- CHECK_CENTER_VERTEX_WITH_DIRS__Fiii  [@0x8008ba70] ---- */
int CHECK_CENTER_VERTEX_WITH_DIRS(int X_DIR,int Y_DIR,int Z_DIR)
{
  /* MATCH: SYM shows ZERO locals (leaf, fsize=0 mask=0) - direct global derefs everywhere,
     flat early-return guards (oracle bnez -> shared return-0 tail), no pointer caches. */
  xRange = X_DIR * scaledBasisDots[0] + Y_DIR * scaledBasisDots[1] + Z_DIR * scaledBasisDots[2] +
           basisDotRelative[0];
  yRange = X_DIR * scaledBasisDots[3] + Y_DIR * scaledBasisDots[4] + Z_DIR * scaledBasisDots[5] +
           basisDotRelative[1];
  zRange = X_DIR * scaledBasisDots[6] + Y_DIR * scaledBasisDots[7] + Z_DIR * scaledBasisDots[8] +
           basisDotRelative[2];
  /* MATCH: goto shared return-0 tail (physically AFTER return 1) keeps all six guards bnez-forward */
  if ((obj0->dimension).z < zRange) goto ret0;
  if (zRange < -(obj0->dimension).z) goto ret0;
  if ((obj0->dimension).x < xRange) goto ret0;
  if (xRange < -(obj0->dimension).x) goto ret0;
  if ((obj0->dimension).y < yRange) goto ret0;
  if (yRange < -(obj0->dimension).y) goto ret0;
  pNormal->x = X_DIR * (obj1->orientMat).m[0] + Y_DIR * (obj1->orientMat).m[3] +
               Z_DIR * (obj1->orientMat).m[6];
  pNormal->y = X_DIR * (obj1->orientMat).m[1] + Y_DIR * (obj1->orientMat).m[4] +
               Z_DIR * (obj1->orientMat).m[7];
  pNormal->z = X_DIR * (obj1->orientMat).m[2] + Y_DIR * (obj1->orientMat).m[5] +
               Z_DIR * (obj1->orientMat).m[8];
  /* MATCH: signed /256 idiom; association is X_DIR*((m/256)*(dim/256)) - inner product first */
  pP->x = (obj1->position).x +
          X_DIR * (((obj1->orientMat).m[0] / 256) * ((obj1->dimension).x / 256)) +
          Y_DIR * (((obj1->orientMat).m[3] / 256) * ((obj1->dimension).y / 256)) +
          Z_DIR * (((obj1->orientMat).m[6] / 256) * ((obj1->dimension).z / 256));
  pP->y = (obj1->position).y +
          X_DIR * (((obj1->orientMat).m[1] / 256) * ((obj1->dimension).x / 256)) +
          Y_DIR * (((obj1->orientMat).m[4] / 256) * ((obj1->dimension).y / 256)) +
          Z_DIR * (((obj1->orientMat).m[7] / 256) * ((obj1->dimension).z / 256));
  pP->z = (obj1->position).z +
          X_DIR * (((obj1->orientMat).m[2] / 256) * ((obj1->dimension).x / 256)) +
          Y_DIR * (((obj1->orientMat).m[5] / 256) * ((obj1->dimension).y / 256)) +
          Z_DIR * (((obj1->orientMat).m[8] / 256) * ((obj1->dimension).z / 256));
  return 1;
ret0:
  return 0;
}


/* ---- CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii  [@0x8008bef0] ---- */
int CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(int X_DIR,int Y_DIR,int Z_DIR)
{
  /* MATCH: same template as CHECK_CENTER_VERTEX_WITH_DIRS - zero locals, flat goto-ret0
     guards, direct global derefs, X_DIR*((m/256)*(dim/256)) association */
  xRange = (X_DIR * scaledBasisDotsOther[0] + Y_DIR * scaledBasisDotsOther[3] +
            Z_DIR * scaledBasisDotsOther[6]) - basisDotRelative[3];
  yRange = (X_DIR * scaledBasisDotsOther[1] + Y_DIR * scaledBasisDotsOther[4] +
            Z_DIR * scaledBasisDotsOther[7]) - basisDotRelative[4];
  zRange = (X_DIR * scaledBasisDotsOther[2] + Y_DIR * scaledBasisDotsOther[5] +
            Z_DIR * scaledBasisDotsOther[8]) - basisDotRelative[5];
  if ((obj1->dimension).z < zRange) goto ret0;
  if (zRange < -(obj1->dimension).z) goto ret0;
  if ((obj1->dimension).x < xRange) goto ret0;
  if (xRange < -(obj1->dimension).x) goto ret0;
  if ((obj1->dimension).y < yRange) goto ret0;
  if (yRange < -(obj1->dimension).y) goto ret0;
  pNormal->x = -(X_DIR * (obj0->orientMat).m[0] + Y_DIR * (obj0->orientMat).m[3] +
                 Z_DIR * (obj0->orientMat).m[6]);
  pNormal->y = -(X_DIR * (obj0->orientMat).m[1] + Y_DIR * (obj0->orientMat).m[4] +
                 Z_DIR * (obj0->orientMat).m[7]);
  pNormal->z = -(X_DIR * (obj0->orientMat).m[2] + Y_DIR * (obj0->orientMat).m[5] +
                 Z_DIR * (obj0->orientMat).m[8]);
  pP->x = (obj0->position).x +
          X_DIR * (((obj0->orientMat).m[0] / 256) * ((obj0->dimension).x / 256)) +
          Y_DIR * (((obj0->orientMat).m[3] / 256) * ((obj0->dimension).y / 256)) +
          Z_DIR * (((obj0->orientMat).m[6] / 256) * ((obj0->dimension).z / 256));
  pP->y = (obj0->position).y +
          X_DIR * (((obj0->orientMat).m[1] / 256) * ((obj0->dimension).x / 256)) +
          Y_DIR * (((obj0->orientMat).m[4] / 256) * ((obj0->dimension).y / 256)) +
          Z_DIR * (((obj0->orientMat).m[7] / 256) * ((obj0->dimension).z / 256));
  pP->z = (obj0->position).z +
          X_DIR * (((obj0->orientMat).m[2] / 256) * ((obj0->dimension).x / 256)) +
          Y_DIR * (((obj0->orientMat).m[5] / 256) * ((obj0->dimension).y / 256)) +
          Z_DIR * (((obj0->orientMat).m[8] / 256) * ((obj0->dimension).z / 256));
  return 1;
ret0:
  return 0;
}


/* ---- CHECK_VERTEX_WITH_DIRS__Fiii  [@0x8008c37c] ---- */
int CHECK_VERTEX_WITH_DIRS(int X_DIR,int Y_DIR,int Z_DIR)
{
  /* MATCH: CHECK_CENTER_VERTEX_WITH_DIRS template minus the pNormal writes */
  xRange = X_DIR * scaledBasisDots[0] + Y_DIR * scaledBasisDots[1] + Z_DIR * scaledBasisDots[2] +
           basisDotRelative[0];
  yRange = X_DIR * scaledBasisDots[3] + Y_DIR * scaledBasisDots[4] + Z_DIR * scaledBasisDots[5] +
           basisDotRelative[1];
  zRange = X_DIR * scaledBasisDots[6] + Y_DIR * scaledBasisDots[7] + Z_DIR * scaledBasisDots[8] +
           basisDotRelative[2];
  if ((obj0->dimension).z < zRange) goto ret0;
  if (zRange < -(obj0->dimension).z) goto ret0;
  if ((obj0->dimension).x < xRange) goto ret0;
  if (xRange < -(obj0->dimension).x) goto ret0;
  if ((obj0->dimension).y < yRange) goto ret0;
  if (yRange < -(obj0->dimension).y) goto ret0;
  pP->x = (obj1->position).x +
          X_DIR * (((obj1->orientMat).m[0] / 256) * ((obj1->dimension).x / 256)) +
          Y_DIR * (((obj1->orientMat).m[3] / 256) * ((obj1->dimension).y / 256)) +
          Z_DIR * (((obj1->orientMat).m[6] / 256) * ((obj1->dimension).z / 256));
  pP->y = (obj1->position).y +
          X_DIR * (((obj1->orientMat).m[1] / 256) * ((obj1->dimension).x / 256)) +
          Y_DIR * (((obj1->orientMat).m[4] / 256) * ((obj1->dimension).y / 256)) +
          Z_DIR * (((obj1->orientMat).m[7] / 256) * ((obj1->dimension).z / 256));
  pP->z = (obj1->position).z +
          X_DIR * (((obj1->orientMat).m[2] / 256) * ((obj1->dimension).x / 256)) +
          Y_DIR * (((obj1->orientMat).m[5] / 256) * ((obj1->dimension).y / 256)) +
          Z_DIR * (((obj1->orientMat).m[8] / 256) * ((obj1->dimension).z / 256));
  return 1;
ret0:
  return 0;
}


/* ---- CHECK_VERTEX_WITH_DIRS_OTHER__Fiii  [@0x8008c744] ---- */
int CHECK_VERTEX_WITH_DIRS_OTHER(int X_DIR,int Y_DIR,int Z_DIR)
{
  /* MATCH: CHECK_CENTER_VERTEX_WITH_DIRS_OTHER template minus the pNormal writes */
  xRange = (X_DIR * scaledBasisDotsOther[0] + Y_DIR * scaledBasisDotsOther[3] +
            Z_DIR * scaledBasisDotsOther[6]) - basisDotRelative[3];
  yRange = (X_DIR * scaledBasisDotsOther[1] + Y_DIR * scaledBasisDotsOther[4] +
            Z_DIR * scaledBasisDotsOther[7]) - basisDotRelative[4];
  zRange = (X_DIR * scaledBasisDotsOther[2] + Y_DIR * scaledBasisDotsOther[5] +
            Z_DIR * scaledBasisDotsOther[8]) - basisDotRelative[5];
  if ((obj1->dimension).z < zRange) goto ret0;
  if (zRange < -(obj1->dimension).z) goto ret0;
  if ((obj1->dimension).x < xRange) goto ret0;
  if (xRange < -(obj1->dimension).x) goto ret0;
  if ((obj1->dimension).y < yRange) goto ret0;
  if (yRange < -(obj1->dimension).y) goto ret0;
  pP->x = (obj0->position).x +
          X_DIR * (((obj0->orientMat).m[0] / 256) * ((obj0->dimension).x / 256)) +
          Y_DIR * (((obj0->orientMat).m[3] / 256) * ((obj0->dimension).y / 256)) +
          Z_DIR * (((obj0->orientMat).m[6] / 256) * ((obj0->dimension).z / 256));
  pP->y = (obj0->position).y +
          X_DIR * (((obj0->orientMat).m[1] / 256) * ((obj0->dimension).x / 256)) +
          Y_DIR * (((obj0->orientMat).m[4] / 256) * ((obj0->dimension).y / 256)) +
          Z_DIR * (((obj0->orientMat).m[7] / 256) * ((obj0->dimension).z / 256));
  pP->z = (obj0->position).z +
          X_DIR * (((obj0->orientMat).m[2] / 256) * ((obj0->dimension).x / 256)) +
          Y_DIR * (((obj0->orientMat).m[5] / 256) * ((obj0->dimension).y / 256)) +
          Z_DIR * (((obj0->orientMat).m[8] / 256) * ((obj0->dimension).z / 256));
  return 1;
ret0:
  return 0;
}


/* ---- Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21  [@0x8008cb0c] ---- */
void Collide_DoObjectFixedObjectCollision(BO_tNewtonObj *o,coorddef *p,coorddef *v,coorddef *n)



{
  coorddef normal;
  int impulse;
  coorddef deltaV;
  coorddef impulseV;
  int temp0;
  int temp1;
  int temp2;
  int temp3;
  coorddef r;
  coorddef RCrossN;
  int velocityLength;
  coorddef velocity;
  int frictionalImpulse;
  coorddef deltaVFromFriction;
  coorddef temp;
  int frictionalImpulseOverMoment;
  int deltaSpeedInFrictionDirection;
  int scale;
  int lengthInverse;
  coorddef upVec;
  int dotx;
  int doty;
  int dotz;

  int iVar1;

  int iVar2;

  int iVar3;

  int iVar4;

  int iVar5;

  int iVar6;

  int iVar7;

  int iVar8;

  int iVar9;

  u_int uVar10;

  int iVar11;

  int iVar12;

  int iVar13;

  int iVar14;

  int iVar15;

  int iVar16;

  int iVar17;

  coorddef local_70;

  int local_60;

  int local_5c;

  int local_58;

  int local_50;

  int local_4c;

  int local_48;

  int local_40;

  int local_3c;

  int local_38;

  u_int local_30;

  u_int local_2c;

  u_int local_28;

  

  local_60 = v->x;

  local_5c = v->y;

  local_58 = v->z;

  iVar13 = n->x;

  iVar14 = n->y;

  iVar17 = n->z;

  iVar16 = 0;

  iVar6 = iVar13;

  if (iVar13 < 0) {

    iVar6 = iVar13 + 0xff;

  }

  iVar1 = (o->linearVel).x;

  if (iVar1 < 0) {

    iVar1 = iVar1 + 0xff;

  }

  iVar7 = iVar14;

  if (iVar14 < 0) {

    iVar7 = iVar14 + 0xff;

  }

  iVar2 = (o->linearVel).y;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar3 = iVar17;

  if (iVar17 < 0) {

    iVar3 = iVar17 + 0xff;

  }

  iVar8 = (o->linearVel).z;

  iVar3 = iVar3 >> 8;

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar12 = p->x - (o->position).x;

  iVar9 = p->y - (o->position).y;

  iVar11 = p->z - (o->position).z;

  iVar6 = (iVar6 >> 8) * (iVar1 >> 8) + (iVar7 >> 8) * (iVar2 >> 8) + iVar3 * (iVar8 >> 8);

  iVar1 = iVar9;

  if (iVar9 < 0) {

    iVar1 = iVar9 + 0xff;

  }

  iVar2 = iVar11;

  if (iVar11 < 0) {

    iVar2 = iVar11 + 0xff;

  }

  local_70.x = (iVar1 >> 8) * iVar3 - (iVar2 >> 8) * (iVar7 >> 8);

  iVar1 = iVar13;

  if (iVar13 < 0) {

    iVar1 = iVar13 + 0xff;

  }

  iVar7 = iVar12;

  if (iVar12 < 0) {

    iVar7 = iVar12 + 0xff;

  }

  local_70.y = (iVar2 >> 8) * (iVar1 >> 8) - (iVar7 >> 8) * iVar3;

  iVar2 = iVar14;

  if (iVar14 < 0) {

    iVar2 = iVar14 + 0xff;

  }

  iVar3 = iVar9;

  if (iVar9 < 0) {

    iVar3 = iVar9 + 0xff;

  }

  local_70.z = (iVar7 >> 8) * (iVar2 >> 8) - (iVar3 >> 8) * (iVar1 >> 8);

  iVar1 = (o->angularVel).x;

  if (iVar1 < 0) {

    iVar1 = iVar1 + 0xff;

  }

  iVar7 = local_70.x;

  if (local_70.x < 0) {

    iVar7 = local_70.x + 0xff;

  }

  iVar2 = (o->angularVel).y;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar3 = local_70.y;

  if (local_70.y < 0) {

    iVar3 = local_70.y + 0xff;

  }

  iVar8 = (o->angularVel).z;

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar4 = local_70.z;

  if (local_70.z < 0) {

    iVar4 = local_70.z + 0xff;

  }

  iVar15 = o->massInv;

  if (iVar15 < 0) {

    iVar15 = iVar15 + 3;

  }

  iVar5 = Math_VectorLength2(&local_70);

  iVar5 = fixedmult(iVar5,o->moInertiaInv << 1);

  iVar1 = fixeddiv(-(iVar6 + (iVar1 >> 8) * (iVar7 >> 8) + (iVar2 >> 8) * (iVar3 >> 8) +

                               (iVar8 >> 8) * (iVar4 >> 8)),(iVar15 >> 2) + iVar5 / 2);

  iVar1 = fixedmult(iVar1,0x6666);

  if (iVar6 < 0) {

    iVar6 = -iVar6;

  }

  (o->collision).impulse = iVar6 << 2;

  uVar10 = o->driveSurfaceType;

  (o->collision).otherObj = (BO_tNewtonObj *)0x0;

  (o->collision).sfxType = uVar10 | 0x30000;

  iVar6 = p->y;

  iVar7 = p->z;

  (o->collision).collisionPoint.x = p->x;

  (o->collision).collisionPoint.y = iVar6;

  (o->collision).collisionPoint.z = iVar7;

  if (((local_60 != 0) || (local_5c != 0)) || (local_58 != 0)) {

    iVar6 = local_60;

    if (local_60 < 0) {

      iVar6 = local_60 + 0xff;

    }

    iVar16 = iVar13;

    if (iVar13 < 0) {

      iVar16 = iVar13 + 0xff;

    }

    iVar7 = local_5c;

    if (local_5c < 0) {

      iVar7 = local_5c + 0xff;

    }

    iVar2 = iVar14;

    if (iVar14 < 0) {

      iVar2 = iVar14 + 0xff;

    }

    iVar3 = local_58;

    if (local_58 < 0) {

      iVar3 = local_58 + 0xff;

    }

    iVar8 = iVar17;

    if (iVar17 < 0) {

      iVar8 = iVar17 + 0xff;

    }

    iVar6 = (iVar6 >> 8) * (iVar16 >> 8) + (iVar7 >> 8) * (iVar2 >> 8) + (iVar3 >> 8) * (iVar8 >> 8)

    ;

    if (iVar6 < 0) {

      iVar6 = iVar6 + 0xff;

    }

    iVar6 = iVar6 >> 8;

    local_60 = local_60 - iVar6 * (iVar16 >> 8);

    local_5c = local_5c - iVar6 * (iVar2 >> 8);

    local_58 = local_58 - iVar6 * (iVar8 >> 8);

    iVar6 = local_60;

    if (local_60 < 0) {

      iVar6 = local_60 + 0xff;

    }

    iVar16 = local_5c;

    if (local_5c < 0) {

      iVar16 = local_5c + 0xff;

    }

    iVar7 = local_58;

    if (local_58 < 0) {

      iVar7 = local_58 + 0xff;

    }

    iVar16 = fixedsqrt((iVar6 >> 8) * (iVar6 >> 8) + (iVar16 >> 8) * (iVar16 >> 8) +

                        (iVar7 >> 8) * (iVar7 >> 8));

    if (iVar16 / 2 == 0) {

      local_60 = fixedmult(-0x10000,local_60);

      local_5c = fixedmult(-0x10000,local_5c);

      iVar6 = -0x10000;

    }

    else {

      iVar6 = fixeddiv(0x8000,iVar16 / 2);

      iVar6 = -iVar6;

      local_60 = fixedmult(iVar6,local_60);

      local_5c = fixedmult(iVar6,local_5c);

    }

    local_58 = fixedmult(iVar6,local_58);

  }

  iVar6 = o->speedXZ;

  if (iVar6 < 0) {

    iVar6 = -iVar6;

  }

  if (iVar6 < 0xa0000) {

    local_30 = 0;

    local_2c = 0x10000;

    local_28 = 0;

    iVar6 = (o->orientMat).m[1];

    if (iVar6 < 0) {

      iVar6 = iVar6 + 0xff;

    }

    iVar7 = (iVar6 >> 8) * 0x100;

    iVar2 = (o->orientMat).m[4];

    if (iVar2 < 0) {

      iVar2 = iVar2 + 0xff;

    }

    iVar3 = (o->orientMat).m[7];

    if (iVar3 < 0) {

      iVar3 = iVar3 + 0xff;

    }

    iVar8 = (iVar3 >> 8) * 0x100;

    if (iVar7 < 0) {

      iVar7 = (iVar6 >> 8) * -0x100;

    }

    if (iVar7 < 0xf5c3) {

      if (iVar8 < 0) {

        iVar8 = (iVar3 >> 8) * -0x100;

      }

      if ((iVar8 < 0xf5c3) && (-0xf5c3 < (iVar2 >> 8) * 0x100)) goto LAB_8008d204;

    }

    frictionLess = 1;

  }

LAB_8008d204:

  iVar6 = 0x8000;

  if (frictionLess == 1) {

    iVar6 = 0x28f;

  }

  iVar7 = fixedmult(iVar6,iVar1);

  iVar6 = fixedmult(iVar7,o->massInv / 2);

  local_50 = fixedmult(iVar6,local_60);

  iVar6 = fixedmult(iVar7,o->massInv / 2);

  local_4c = fixedmult(iVar6,local_5c);

  iVar6 = fixedmult(iVar7,o->massInv / 2);

  local_48 = fixedmult(iVar6,local_58);

  frictionLess = 0;

  iVar2 = fixedmult(iVar7,o->moInertiaInv << 1);

  iVar6 = iVar11;

  if (iVar11 < 0) {

    iVar6 = iVar11 + 0xff;

  }

  iVar3 = local_58;

  if (local_58 < 0) {

    iVar3 = local_58 + 0xff;

  }

  iVar8 = iVar9;

  if (iVar9 < 0) {

    iVar8 = iVar9 + 0xff;

  }

  iVar4 = iVar12;

  if (iVar12 < 0) {

    iVar4 = iVar12 + 0xff;

  }

  iVar15 = local_60;

  if (local_60 < 0) {

    iVar15 = local_60 + 0xff;

  }

  iVar3 = (iVar3 >> 8) * (iVar4 >> 8) - (iVar15 >> 8) * (iVar6 >> 8);

  iVar6 = local_5c;

  if (local_5c < 0) {

    iVar6 = local_5c + 0xff;

  }

  iVar6 = (iVar15 >> 8) * (iVar8 >> 8) - (iVar6 >> 8) * (iVar4 >> 8);

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar8 = iVar11;

  if (iVar11 < 0) {

    iVar8 = iVar11 + 0xff;

  }

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  iVar4 = iVar9;

  if (iVar9 < 0) {

    iVar4 = iVar9 + 0xff;

  }

  local_40 = (iVar3 >> 8) * (iVar8 >> 8) - (iVar6 >> 8) * (iVar4 >> 8);

  iVar3 = iVar12;

  if (iVar12 < 0) {

    iVar3 = iVar12 + 0xff;

  }

  iVar15 = local_40;

  if (local_40 < 0) {

    iVar15 = local_40 + 0xff;

  }

  local_3c = (iVar6 >> 8) * (iVar3 >> 8) - (iVar15 >> 8) * (iVar8 >> 8);

  iVar6 = local_3c;

  if (local_3c < 0) {

    iVar6 = local_3c + 0xff;

  }

  local_38 = (iVar15 >> 8) * (iVar4 >> 8) - (iVar6 >> 8) * (iVar3 >> 8);

  local_40 = fixedmult(iVar2,local_40);

  local_3c = fixedmult(iVar2,local_3c);

  local_38 = fixedmult(iVar2,local_38);

  local_50 = local_50 + local_40;

  local_48 = local_48 + local_38;

  local_4c = local_4c + local_3c;

  iVar6 = local_50;

  if (local_50 < 0) {

    iVar6 = local_50 + 0xff;

  }

  iVar2 = local_60;

  if (local_60 < 0) {

    iVar2 = local_60 + 0xff;

  }

  iVar3 = local_4c;

  if (local_4c < 0) {

    iVar3 = local_4c + 0xff;

  }

  iVar8 = local_5c;

  if (local_5c < 0) {

    iVar8 = local_5c + 0xff;

  }

  iVar4 = local_48;

  if (local_48 < 0) {

    iVar4 = local_48 + 0xff;

  }

  iVar15 = local_58;

  if (local_58 < 0) {

    iVar15 = local_58 + 0xff;

  }

  iVar6 = (iVar6 >> 8) * (iVar2 >> 8) + (iVar3 >> 8) * (iVar8 >> 8) + (iVar4 >> 8) * (iVar15 >> 8);

  if (iVar16 < iVar6) {

    iVar6 = fixeddiv(iVar16,iVar6);

    iVar7 = fixedmult(iVar7,iVar6);

  }

  local_60 = fixedmult(iVar7,local_60);

  local_5c = fixedmult(iVar7,local_5c);

  local_58 = fixedmult(iVar7,local_58);

  if (0 < iVar1) {

    iVar16 = fixedmult(iVar1,iVar13);

    iVar13 = fixedmult(iVar1,iVar14);

    iVar1 = fixedmult(iVar1,iVar17);

    iVar16 = iVar16 + local_60;

    iVar1 = iVar1 + local_58;

    iVar13 = iVar13 + local_5c;

    iVar6 = fixedmult(o->massInv / 2,iVar16);

    iVar14 = fixedmult(o->massInv / 2,iVar13);

    iVar17 = fixedmult(o->massInv / 2,iVar1);

    (o->linearVel).x = (o->linearVel).x + iVar6;

    (o->linearVel).y = (o->linearVel).y + iVar14;

    (o->linearVel).z = (o->linearVel).z + iVar17;

    iVar6 = iVar9;

    if (iVar9 < 0) {

      iVar6 = iVar9 + 0xff;

    }

    if (iVar1 < 0) {

      iVar1 = iVar1 + 0xff;

    }

    if (iVar11 < 0) {

      iVar11 = iVar11 + 0xff;

    }

    if (iVar13 < 0) {

      iVar13 = iVar13 + 0xff;

    }

    if (iVar16 < 0) {

      iVar16 = iVar16 + 0xff;

    }

    if (iVar12 < 0) {

      iVar12 = iVar12 + 0xff;

    }

    if (iVar9 < 0) {

      iVar9 = iVar9 + 0xff;

    }

    iVar6 = fixedmult(o->moInertiaInv << 1,

                       (iVar6 >> 8) * (iVar1 >> 8) - (iVar11 >> 8) * (iVar13 >> 8));

    iVar14 = fixedmult(o->moInertiaInv << 1,

                        (iVar11 >> 8) * (iVar16 >> 8) - (iVar12 >> 8) * (iVar1 >> 8));

    iVar16 = fixedmult(o->moInertiaInv << 1,

                        (iVar12 >> 8) * (iVar13 >> 8) - (iVar9 >> 8) * (iVar16 >> 8));

    (o->angularVel).x = (o->angularVel).x + iVar6;

    (o->angularVel).y = (o->angularVel).y + iVar14;

    (o->angularVel).z = (o->angularVel).z + iVar16;

  }

  return;

}

/* ---- Collide_LimitAngularVel__FP13BO_tNewtonObj  [@0x8008d8b4] ---- */
void Collide_LimitAngularVel(BO_tNewtonObj *o)



{

  int iVar1;

  int iVar2;

  

  iVar1 = (o->angularVel).x;

  if (iVar1 < 0) {

    if (iVar1 < -0x18000) {

      iVar1 = -0x18000;

    }

    (o->angularVel).x = iVar1;

  }

  else {

    iVar2 = (0x18000 < iVar1) ? 0x18000 : iVar1;

    (o->angularVel).x = iVar2;

  }

  iVar1 = (o->angularVel).y;

  if (iVar1 < 0) {

    if (iVar1 < -0x18000) {

      iVar1 = -0x18000;

    }

    (o->angularVel).y = iVar1;

  }

  else {

    iVar2 = (0x18000 < iVar1) ? 0x18000 : iVar1;

    (o->angularVel).y = iVar2;

  }

  iVar1 = (o->angularVel).z;

  if (iVar1 < 0) {

    if (iVar1 < -0x18000) {

      iVar1 = -0x18000;

    }

    (o->angularVel).z = iVar1;

    return;

  }

  iVar2 = (0x18000 < iVar1) ? 0x18000 : iVar1;

  (o->angularVel).z = iVar2;

  return;

}

/* ---- Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1  [@0x8008d9a8] ---- */
void Collide_TestWithPlane(BO_tNewtonObj *o,coorddef *normal,coorddef *samplePoint)
{
  int raiseUp;
  int basisDots[3];
  int relativeDot;
  coorddef relativePos;
  int xDir;
  int Y_DIR;
  int zDir;
  int relDotFull;

  /* MATCH: SYM rule-8 rebuild - names/blocks from the SYM 8c block; inline /256 idiom
     (no hoisted temps); X_DIR*((m/256)*(dim/256)) association.
     CORRECTNESS fix (oracle-evidenced): the Collide_gRaiseUp gp-rel GATE around both the
     raise-position block AND the bounce block was folded out by Ghidra (section 3.2c class)
     - restored at both sites. */
  (o->angularVel).x = fixedmult(0x6487e,(o->angularVel).x);
  (o->angularVel).y = fixedmult(0x6487e,(o->angularVel).y);
  (o->angularVel).z = fixedmult(0x6487e,(o->angularVel).z);
  raiseUp = 0;
  if (((normal->x == 0) && (normal->y == 0)) && (normal->z == 0)) {
    normal->y = 0x10000;
  }
  basisDots[0] = ((normal->x / 256) * ((o->orientMat).m[0] / 256) +
                  (normal->y / 256) * ((o->orientMat).m[1] / 256) +
                  (normal->z / 256) * ((o->orientMat).m[2] / 256)) / 256 *
                 ((o->dimension).x / 256);
  basisDots[1] = ((normal->x / 256) * ((o->orientMat).m[3] / 256) +
                  (normal->y / 256) * ((o->orientMat).m[4] / 256) +
                  (normal->z / 256) * ((o->orientMat).m[5] / 256)) / 256 *
                 ((o->dimension).y / 256);
  basisDots[2] = ((normal->x / 256) * ((o->orientMat).m[6] / 256) +
                  (normal->y / 256) * ((o->orientMat).m[7] / 256) +
                  (normal->z / 256) * ((o->orientMat).m[8] / 256)) / 256 *
                 ((o->dimension).z / 256);
  xDir = -1;
  if (basisDots[0] < 0) {
    xDir = 1;
  }
  Y_DIR = -1;
  if (basisDots[1] < 0) {
    Y_DIR = 1;
  }
  zDir = -1;
  if (basisDots[2] < 0) {
    zDir = 1;
  }
  relativePos.x = (o->position).x - samplePoint->x;
  relativePos.y = (o->position).y - samplePoint->y;
  relativePos.z = (o->position).z - samplePoint->z;
  /* MATCH: two statements - rel-group lands in relativeDot ($v1 per SYM) first */
  relativeDot = (normal->x / 256) * (relativePos.x / 256) +
                (normal->y / 256) * (relativePos.y / 256) +
                (normal->z / 256) * (relativePos.z / 256);
  /* MATCH: fresh (anonymous) result var - oracle keeps the full sum in a scratch ($a1),
     Asum as LEFT addu operand; accumulating into relativeDot itself flips the operands */
  relDotFull = (xDir * basisDots[0] + Y_DIR * basisDots[1] + zDir * basisDots[2]) + relativeDot;
  if (relDotFull < 0) {
    int height;
    coorddef Raise;
    coorddef vertexVelocity;
    coorddef r;
    coorddef spot;

    spot.x = (o->position).x +
             xDir * (((o->orientMat).m[0] / 256) * ((o->dimension).x / 256)) +
             Y_DIR * (((o->orientMat).m[3] / 256) * ((o->dimension).y / 256)) +
             zDir * (((o->orientMat).m[6] / 256) * ((o->dimension).z / 256));
    spot.y = (o->position).y +
             xDir * (((o->orientMat).m[1] / 256) * ((o->dimension).x / 256)) +
             Y_DIR * (((o->orientMat).m[4] / 256) * ((o->dimension).y / 256)) +
             zDir * (((o->orientMat).m[7] / 256) * ((o->dimension).z / 256));
    spot.z = (o->position).z +
             xDir * (((o->orientMat).m[2] / 256) * ((o->dimension).x / 256)) +
             Y_DIR * (((o->orientMat).m[5] / 256) * ((o->dimension).y / 256)) +
             zDir * (((o->orientMat).m[8] / 256) * ((o->dimension).z / 256));
    if (raiseUp < -relDotFull) {
      raiseUp = -relDotFull;
    }
    if (Collide_gRaiseUp != 0) {
      if (raiseUp != 0) {
        height = raiseUp / 2;
        Raise.x = fixedmult(height,normal->x);
        Raise.y = fixedmult(height,normal->y);
        Raise.z = fixedmult(height,normal->z);
        (o->position).x = (o->position).x + Raise.x;
        (o->position).y = (o->position).y + Raise.y;
        (o->position).z = (o->position).z + Raise.z;
      }
    }
    r.x = spot.x - (o->position).x;
    r.y = spot.y - (o->position).y;
    r.z = spot.z - (o->position).z;
    vertexVelocity.x = ((o->angularVel).y / 256) * (r.z / 256) -
                       ((o->angularVel).z / 256) * (r.y / 256);
    vertexVelocity.y = ((o->angularVel).z / 256) * (r.x / 256) -
                       ((o->angularVel).x / 256) * (r.z / 256);
    vertexVelocity.z = ((o->angularVel).x / 256) * (r.y / 256) -
                       ((o->angularVel).y / 256) * (r.x / 256);
    vertexVelocity.x = vertexVelocity.x + (o->linearVel).x;
    vertexVelocity.y = vertexVelocity.y + (o->linearVel).y;
    vertexVelocity.z = vertexVelocity.z + (o->linearVel).z;
    if ((normal->x / 256) * (vertexVelocity.x / 256) +
        (normal->y / 256) * (vertexVelocity.y / 256) +
        (normal->z / 256) * (vertexVelocity.z / 256) < 0) {
      Collide_DoObjectFixedObjectCollision(o,&spot,&vertexVelocity,normal);
    }
    if (Collide_gRaiseUp != 0) {
      if (raiseUp != 0) {
        if (0 < Raise.y) {
          int correction;
          int v2;

          correction = fixedmult(0x9cccc,Raise.y) * 2;
          v2 = fixedmult((o->linearVel).y,(o->linearVel).y);
          if (v2 < correction) {
            (o->linearVel).y = 0;
          }
          else if (0 < (o->linearVel).y) {
            (o->linearVel).y = fixedsqrt(v2 - correction);
          }
          else {
            (o->linearVel).y = -fixedsqrt(v2 - correction);
          }
        }
      }
    }
  }
  (o->angularVel).x = fixedmult(0x28be,(o->angularVel).x);
  (o->angularVel).y = fixedmult(0x28be,(o->angularVel).y);
  (o->angularVel).z = fixedmult(0x28be,(o->angularVel).z);
  Collide_LimitAngularVel(o);
  {
    int dot;
    int zone;
    int impulse;

    zone = 9;
    /* MATCH: anonymous dot-sum web (s0) separate from impulse (s6) - the <<2 lands in impulse */
    dot = fixedmult(normal->x,(o->linearVel).x) + fixedmult(normal->y,(o->linearVel).y) +
          fixedmult(normal->z,(o->linearVel).z);
    if (0 < dot) {
      dot = fixedmult(normal->x,(o->linearVel).x) + fixedmult(normal->y,(o->linearVel).y) +
            fixedmult(normal->z,(o->linearVel).z);
    }
    else {
      dot = -(fixedmult(normal->x,(o->linearVel).x) + fixedmult(normal->y,(o->linearVel).y) +
              fixedmult(normal->z,(o->linearVel).z));
    }
    impulse = dot << 2;
    if (0xA0000 < impulse) {
      int right;
      int top;
      int front;

      right = fixedmult(normal->x,(o->orientMat).m[0]) + fixedmult(normal->y,(o->orientMat).m[1]) +
              fixedmult(normal->z,(o->orientMat).m[2]);
      top = fixedmult(normal->x,(o->orientMat).m[3]) + fixedmult(normal->y,(o->orientMat).m[4]) +
            fixedmult(normal->z,(o->orientMat).m[5]);
      front = fixedmult(normal->x,(o->orientMat).m[6]) + fixedmult(normal->y,(o->orientMat).m[7]) +
              fixedmult(normal->z,(o->orientMat).m[8]);
      if (top < -0x8000) {
        zone = 8;
        Newton_AddDamageZone(o,impulse,zone,0);
      }
      if (front < -0x1999) {
        if (!(right < 0x199A)) {
          zone = 0;
        }
        else if (right < -0x1999) {
          zone = 2;
        }
      }
      if (!(front < 0x199A)) { /* MATCH: independent if - oracle re-tests front (no else-if) */
        if (!(right < 0x199A)) {
          zone = 4;
        }
        else if (right < -0x1999) {
          zone = 6;
        }
      }
      if (zone < 8) {
        Newton_AddDamageZone(o,impulse,zone,0);
      }
    }
  }
  return;
}


/* ---- Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2  [@0x8008e5d4] ---- */
int Collide_DoObjectObjectCollision(BO_tNewtonObj *o0,BO_tNewtonObj *o1,coorddef *p,coorddef *normal)



{
  int impulse;
  int impulseWST;
  coorddef impulseV;
  coorddef R0CrossN;
  coorddef R1CrossN;
  coorddef Rt0;
  coorddef Rt1;
  int numerator;
  coorddef deltaV;
  coorddef damageVector;
  int zone;
  int right;
  int top;
  int front;

  bool bVar1;

  int iVar2;

  int iVar3;

  int iVar4;

  int iVar5;

  int iVar6;

  int iVar7;

  int iVar8;

  int iVar9;

  int iVar10;

  int iVar11;

  int iVar12;

  int iVar13;

  int iVar14;

  int iVar15;

  int iVar16;

  int iVar17;

  int iVar18;

  int iVar19;

  int iVar20;

  int iVar21;

  int a;

  u_int uVar22;

  int local_58;

  int local_54;

  coorddef local_48;

  int local_38;

  int local_34;

  int local_30;

  

  iVar2 = p->x - (o0->position).x;

  a = p->y - (o0->position).y;

  iVar3 = p->z - (o0->position).z;

  iVar4 = p->x - (o1->position).x;

  iVar5 = p->y - (o1->position).y;

  iVar6 = p->z - (o1->position).z;

  iVar7 = fixedmult(a,normal->z);

  iVar8 = fixedmult(iVar3,normal->y);

  iVar7 = iVar7 - iVar8;

  iVar8 = fixedmult(iVar3,normal->x);

  iVar9 = fixedmult(iVar2,normal->z);

  iVar8 = iVar8 - iVar9;

  iVar9 = fixedmult(iVar2,normal->y);

  iVar10 = fixedmult(a,normal->x);

  iVar9 = iVar9 - iVar10;

  iVar10 = fixedmult(iVar5,normal->z);

  iVar11 = fixedmult(iVar6,normal->y);

  iVar10 = iVar10 - iVar11;

  iVar11 = fixedmult(iVar6,normal->x);

  iVar12 = fixedmult(iVar4,normal->z);

  iVar11 = iVar11 - iVar12;

  iVar12 = fixedmult(iVar4,normal->y);

  iVar13 = fixedmult(iVar5,normal->x);

  iVar12 = iVar12 - iVar13;

  iVar13 = fixedmult((o0->linearVel).x,normal->x);

  local_38 = fixedmult((o0->linearVel).y,normal->y);

  local_34 = fixedmult((o0->linearVel).z,normal->z);

  iVar14 = fixedmult((o1->linearVel).x,normal->x);

  local_30 = fixedmult((o1->linearVel).y,normal->y);

  iVar15 = fixedmult((o1->linearVel).z,normal->z);

  iVar16 = fixedmult((o0->angularVel).x,iVar7);

  iVar17 = fixedmult((o0->angularVel).y,iVar8);

  iVar18 = fixedmult((o0->angularVel).z,iVar9);

  iVar19 = fixedmult((o1->angularVel).x,iVar10);

  iVar20 = fixedmult((o1->angularVel).y,iVar11);

  iVar21 = fixedmult((o1->angularVel).z,iVar12);

  iVar13 = iVar13 + local_38 + local_34;

  iVar14 = iVar14 + local_30;

  iVar7 = fixedmult(iVar7,iVar7);

  iVar8 = fixedmult(iVar8,iVar8);

  iVar9 = fixedmult(iVar9,iVar9);

  iVar7 = fixedmult(iVar7 + iVar8 + iVar9,o0->moInertiaInv);

  iVar8 = fixedmult(iVar10,iVar10);

  iVar9 = fixedmult(iVar11,iVar11);

  iVar10 = fixedmult(iVar12,iVar12);

  iVar8 = fixedmult(iVar8 + iVar9 + iVar10,o1->moInertiaInv);

  iVar7 = fixeddiv((((iVar14 + iVar15) - iVar13) - (iVar16 + iVar17 + iVar18)) +

                     iVar19 + iVar20 + iVar21,

                     o0->massInv / 2 + o1->massInv / 2 + (iVar7 >> 1) + (iVar8 >> 1));

  if (iVar7 < 0) {

    return 0;

  }

  if (((o0[1].simRoadInfo.quadPts[1].y & 4U) != 0) && ((o0->collision).collided == 0)) {

    (o0->collision).collided = 2;

  }

  if (((o1[1].simRoadInfo.quadPts[1].y & 4U) != 0) && ((o1->collision).collided == 0)) {

    (o1->collision).collided = 2;

  }

  iVar8 = 0x3333;

  if (((o0[1].simRoadInfo.quadPts[1].y & 4U) != 0) && ((o1[1].simRoadInfo.quadPts[1].y & 4U) != 0))

  {

    iVar8 = 0x4000;

  }

  iVar7 = fixedmult(iVar8,iVar7);

  iVar8 = fixedmult(iVar7,normal->x);

  iVar9 = fixedmult(iVar7,normal->y);

  iVar10 = fixedmult(iVar7,normal->z);

  iVar11 = fixedmult((o0->linearVel).x,normal->x);

  iVar12 = fixedmult((o0->linearVel).y,normal->y);

  iVar13 = fixedmult((o0->linearVel).z,normal->z);

  iVar14 = fixedmult((o1->linearVel).x,normal->x);

  iVar15 = fixedmult((o1->linearVel).y,normal->y);

  iVar16 = fixedmult((o1->linearVel).z,normal->z);

  iVar11 = fixedmult((iVar11 + iVar12 + iVar13) - (iVar14 + iVar15 + iVar16),o0->mass + o1->mass);

  iVar12 = fixedmult(iVar11,o0->massInv);

  if (iVar12 < 1) {

    iVar12 = fixedmult(iVar11,o0->massInv);

    iVar12 = -iVar12;

  }

  else {

    iVar12 = fixedmult(iVar11,o0->massInv);

  }

  (o0->collision).impulse = iVar12;

  iVar12 = fixedmult(iVar11,o1->massInv);

  if (iVar12 < 1) {

    iVar11 = fixedmult(iVar11,o1->massInv);

    (o1->collision).impulse = -iVar11;

  }

  else {

    iVar11 = fixedmult(iVar11,o1->massInv);

    (o1->collision).impulse = iVar11;

  }

  if ((0x1ff < o0->objID) || (0x1ff < o1->objID)) {

    (o0->collision).impulse = (o0->collision).impulse / 3;

    (o1->collision).impulse = (o1->collision).impulse / 3;

  }

  iVar11 = fixedmult(o0->massInv,iVar8);

  iVar12 = fixedmult(o0->massInv,iVar9);

  iVar13 = fixedmult(o0->massInv,iVar10);

  (o0->linearVel).x = (o0->linearVel).x + iVar11;

  (o0->linearVel).y = (o0->linearVel).y + iVar12;

  iVar11 = (o0->linearVel).z;

  iVar12 = o0->objID;

  (o0->collision).sfxType = 0x50001;

  (o0->collision).otherObj = o1;

  (o0->linearVel).z = iVar11 + iVar13;

  if (iVar12 < 0x200) {

    iVar11 = (o0->collision).impulse;

    local_48.x = (o0->position).x - (o1->position).x;

    uVar22 = 9;

    local_48.y = (o0->position).y - (o1->position).y;

    local_48.z = (o0->position).z - (o1->position).z;

    Math_NormalizeShortVector(&local_48);

    if (0xa0000 < iVar11) {

      iVar12 = fixedmult(local_48.x,(o0->orientMat).m[0]);

      iVar13 = fixedmult(local_48.y,(o0->orientMat).m[1]);

      iVar14 = fixedmult(local_48.z,(o0->orientMat).m[2]);

      iVar14 = iVar12 + iVar13 + iVar14;

      iVar12 = fixedmult(local_48.x,(o0->orientMat).m[3]);

      iVar13 = fixedmult(local_48.y,(o0->orientMat).m[4]);

      iVar15 = fixedmult(local_48.z,(o0->orientMat).m[5]);

      iVar16 = fixedmult(local_48.x,(o0->orientMat).m[6]);

      iVar17 = fixedmult(local_48.y,(o0->orientMat).m[7]);

      iVar18 = fixedmult(local_48.z,(o0->orientMat).m[8]);

      iVar18 = iVar16 + iVar17 + iVar18;

      if (iVar12 + iVar13 + iVar15 < -0x8000) {

        uVar22 = 8;

        Newton_AddDamageZone(o0,iVar11,8,2);

      }

      iVar12 = iVar14;

      if (iVar14 < 0) {

        iVar12 = -iVar14;

      }

      if (iVar12 < 0x1999) {

        if (iVar18 < -0x1999) {

          uVar22 = 1;

        }

        else {

          if (iVar18 < 0x199a) goto LAB_8008ee48;

          uVar22 = 5;

        }

LAB_8008eed8:

        bVar1 = uVar22 < 8;

      }

      else {

LAB_8008ee48:

        iVar12 = iVar18;

        if (iVar18 < 0) {

          iVar12 = -iVar18;

        }

        if (iVar12 < 0x1999) {

          if (iVar14 < 0x199a) {

            if (-0x199a < iVar14) goto LAB_8008ee84;

            uVar22 = 3;

          }

          else {

            uVar22 = 7;

          }

          goto LAB_8008eed8;

        }

LAB_8008ee84:

        if (iVar18 < -0x1999) {

          if (iVar14 < 0x199a) {

            if (-0x199a < iVar14) goto LAB_8008eeb0;

            uVar22 = 2;

          }

          else {

            uVar22 = 0;

          }

          goto LAB_8008eed8;

        }

LAB_8008eeb0:

        bVar1 = uVar22 < 8;

        if (0x1999 < iVar18) {

          if (iVar14 < 0x199a) {

            bVar1 = uVar22 < 8;

            if (-0x199a < iVar14) goto LAB_8008eedc;

            uVar22 = 4;

          }

          else {

            uVar22 = 6;

          }

          goto LAB_8008eed8;

        }

      }

LAB_8008eedc:

      if (bVar1) {

        Newton_AddDamageZone(o0,iVar11,uVar22,2);

      }

    }

  }

  iVar11 = fixedmult(o1->massInv,iVar8);

  iVar12 = fixedmult(o1->massInv,iVar9);

  iVar13 = fixedmult(o1->massInv,iVar10);

  (o1->linearVel).x = (o1->linearVel).x - iVar11;

  (o1->linearVel).y = (o1->linearVel).y - iVar12;

  (o1->collision).sfxType = 0x50001;

  iVar11 = o1->objID;

  (o1->collision).otherObj = o0;

  (o1->linearVel).z = (o1->linearVel).z - iVar13;

  if (0x1ff < iVar11) goto LAB_8008f15c;

  iVar11 = (o1->collision).impulse;

  local_48.x = -local_48.x;

  local_48.z = -local_48.z;

  local_48.y = -local_48.y;

  uVar22 = 9;

  if (iVar11 < 0xa0001) goto LAB_8008f15c;

  iVar12 = fixedmult(local_48.x,(o1->orientMat).m[0]);

  iVar13 = fixedmult(local_48.y,(o1->orientMat).m[1]);

  iVar14 = fixedmult(local_48.z,(o1->orientMat).m[2]);

  iVar14 = iVar12 + iVar13 + iVar14;

  iVar12 = fixedmult(local_48.x,(o1->orientMat).m[3]);

  iVar13 = fixedmult(local_48.y,(o1->orientMat).m[4]);

  iVar15 = fixedmult(local_48.z,(o1->orientMat).m[5]);

  iVar16 = fixedmult(local_48.x,(o1->orientMat).m[6]);

  iVar17 = fixedmult(local_48.y,(o1->orientMat).m[7]);

  iVar18 = fixedmult(local_48.z,(o1->orientMat).m[8]);

  iVar18 = iVar16 + iVar17 + iVar18;

  if (iVar12 + iVar13 + iVar15 < -0x8000) {

    uVar22 = 8;

    Newton_AddDamageZone(o1,iVar11,8,2);

  }

  iVar12 = iVar14;

  if (iVar14 < 0) {

    iVar12 = -iVar14;

  }

  if (iVar12 < 0x1999) {

    if (iVar18 < -0x1999) {

      uVar22 = 1;

    }

    else {

      if (iVar18 < 0x199a) goto LAB_8008f0b0;

      uVar22 = 5;

    }

LAB_8008f140:

    bVar1 = uVar22 < 8;

  }

  else {

LAB_8008f0b0:

    iVar12 = iVar18;

    if (iVar18 < 0) {

      iVar12 = -iVar18;

    }

    if (iVar12 < 0x1999) {

      if (iVar14 < 0x199a) {

        if (-0x199a < iVar14) goto LAB_8008f0ec;

        uVar22 = 3;

      }

      else {

        uVar22 = 7;

      }

      goto LAB_8008f140;

    }

LAB_8008f0ec:

    if (iVar18 < -0x1999) {

      if (iVar14 < 0x199a) {

        if (-0x199a < iVar14) goto LAB_8008f118;

        uVar22 = 2;

      }

      else {

        uVar22 = 0;

      }

      goto LAB_8008f140;

    }

LAB_8008f118:

    bVar1 = uVar22 < 8;

    if (0x1999 < iVar18) {

      if (iVar14 < 0x199a) {

        bVar1 = uVar22 < 8;

        if (-0x199a < iVar14) goto LAB_8008f144;

        uVar22 = 4;

      }

      else {

        uVar22 = 6;

      }

      goto LAB_8008f140;

    }

  }

LAB_8008f144:

  if (bVar1) {

    Newton_AddDamageZone(o1,iVar11,uVar22,2);

  }

LAB_8008f15c:

  iVar11 = fixedmult(a,iVar10);

  iVar12 = fixedmult(iVar3,iVar9);

  iVar3 = fixedmult(iVar3,iVar8);

  iVar13 = fixedmult(iVar2,iVar10);

  iVar2 = fixedmult(iVar2,iVar9);

  iVar14 = fixedmult(a,iVar8);

  if (((o0[1].simRoadInfo.quadPts[1].y & 4U) == 0) || (0x3fffff < iVar7)) {

    local_58 = fixedmult(o0->moInertiaInv,iVar11 - iVar12);

    local_54 = fixedmult(o0->moInertiaInv,iVar3 - iVar13);

    iVar3 = o0->moInertiaInv;

  }

  else {

    iVar15 = o0->moInertiaInv * 3;

    if (iVar15 < 0) {

      iVar15 = iVar15 + 3;

    }

    local_58 = fixedmult(iVar15 >> 2,iVar11 - iVar12);

    iVar11 = o0->moInertiaInv * 3;

    if (iVar11 < 0) {

      iVar11 = iVar11 + 3;

    }

    local_54 = fixedmult(iVar11 >> 2,iVar3 - iVar13);

    iVar3 = o0->moInertiaInv * 3;

    if (iVar3 < 0) {

      iVar3 = iVar3 + 3;

    }

    iVar3 = iVar3 >> 2;

  }

  iVar2 = fixedmult(iVar3,iVar2 - iVar14);

  (o0->angularVel).x = (o0->angularVel).x + local_58;

  (o0->angularVel).y = (o0->angularVel).y + local_54;

  (o0->angularVel).z = (o0->angularVel).z + iVar2;

  iVar2 = fixedmult(iVar5,iVar10);

  iVar3 = fixedmult(iVar6,iVar9);

  iVar6 = fixedmult(iVar6,iVar8);

  iVar10 = fixedmult(iVar4,iVar10);

  iVar4 = fixedmult(iVar4,iVar9);

  iVar5 = fixedmult(iVar5,iVar8);

  if (((o1[1].simRoadInfo.quadPts[1].y & 4U) == 0) || (0x3fffff < iVar7)) {

    local_58 = fixedmult(o1->moInertiaInv,iVar2 - iVar3);

    local_54 = fixedmult(o1->moInertiaInv,iVar6 - iVar10);

    iVar2 = o1->moInertiaInv;

  }

  else {

    iVar7 = o1->moInertiaInv * 3;

    if (iVar7 < 0) {

      iVar7 = iVar7 + 3;

    }

    local_58 = fixedmult(iVar7 >> 2,iVar2 - iVar3);

    iVar2 = o1->moInertiaInv * 3;

    if (iVar2 < 0) {

      iVar2 = iVar2 + 3;

    }

    local_54 = fixedmult(iVar2 >> 2,iVar6 - iVar10);

    iVar2 = o1->moInertiaInv * 3;

    if (iVar2 < 0) {

      iVar2 = iVar2 + 3;

    }

    iVar2 = iVar2 >> 2;

  }

  iVar2 = fixedmult(iVar2,iVar4 - iVar5);

  (o1->angularVel).x = (o1->angularVel).x - local_58;

  (o1->angularVel).y = (o1->angularVel).y - local_54;

  (o1->angularVel).z = (o1->angularVel).z - iVar2;

  o0->flightTime = o0->flightTime + 1;

  iVar2 = (o1->position).x;

  o1->flightTime = o1->flightTime + 1;

  iVar2 = ((o0->position).x + iVar2) / 2;

  (o1->collision).collisionPoint.x = iVar2;

  (o0->collision).collisionPoint.x = iVar2;

  iVar2 = ((o0->position).y + (o1->position).y) / 2;

  (o1->collision).collisionPoint.y = iVar2;

  iVar3 = (o0->position).z;

  (o0->collision).collisionPoint.y = iVar2;

  iVar2 = (iVar3 + (o1->position).z) / 2;

  (o1->collision).collisionPoint.z = iVar2;

  (o0->collision).collisionPoint.z = iVar2;

  return 1;

}

/* ---- Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2  [@0x8008f550] ---- */
int Collide_DoActualObjectCollisionCheck(BO_tNewtonObj *o0,BO_tNewtonObj *o1,coorddef *p,coorddef *normal)



{
  int maxv;
  int vx;
  int vy;
  int vz;
  coorddef normalx;
  coorddef normaly;
  coorddef normalz;
  int dotx;
  int doty;
  int dotz;
  coorddef vel;
  int xDiff;
  int yDiff;
  int zDiff;

  int iVar1;

  int iVar2;

  int iVar3;

  int iVar4;

  int iVar5;

  int iVar6;

  int iVar7;

  int iVar8;

  int iVar9;

  int iVar10;

  int local_60;

  int local_5c;

  int local_58;

  int local_50;

  int local_4c;

  int local_48;

  int local_40;

  int local_3c;

  int local_38;

  

  obj0 = o0;

  obj1 = o1;

  pNormal = normal;

  pP = p;

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS(1,0,0);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS(0,1,0);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS(0,0,1);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS(-1,0,0);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS(0,-1,0);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS(0,0,-1);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(1,0,0);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(0,1,0);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(0,0,1);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(-1,0,0);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(0,-1,0);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(0,0,-1);

  if (iVar1 != 0) {

    return 1;

  }

  iVar1 = CHECK_VERTEX_WITH_DIRS(1,1,1);

  if (((((iVar1 == 0) && (iVar1 = CHECK_VERTEX_WITH_DIRS(1,1,-1), iVar1 == 0)) &&

       (iVar1 = CHECK_VERTEX_WITH_DIRS(1,-1,1), iVar1 == 0)) &&

      ((iVar1 = CHECK_VERTEX_WITH_DIRS(1,-1,-1), iVar1 == 0 &&

       (iVar1 = CHECK_VERTEX_WITH_DIRS(-1,1,1), iVar1 == 0)))) &&

     ((iVar1 = CHECK_VERTEX_WITH_DIRS(-1,1,-1), iVar1 == 0 &&

      ((iVar1 = CHECK_VERTEX_WITH_DIRS(-1,-1,1), iVar1 == 0 &&

       (iVar1 = CHECK_VERTEX_WITH_DIRS(-1,-1,-1), iVar1 == 0)))))) {

    iVar1 = CHECK_VERTEX_WITH_DIRS_OTHER(1,1,1);

    if ((((iVar1 == 0) && (iVar1 = CHECK_VERTEX_WITH_DIRS_OTHER(1,1,-1), iVar1 == 0)) &&

        (iVar1 = CHECK_VERTEX_WITH_DIRS_OTHER(1,-1,1), iVar1 == 0)) &&

       (((iVar1 = CHECK_VERTEX_WITH_DIRS_OTHER(1,-1,-1), iVar1 == 0 &&

         (iVar1 = CHECK_VERTEX_WITH_DIRS_OTHER(-1,1,1), iVar1 == 0)) &&

        ((iVar1 = CHECK_VERTEX_WITH_DIRS_OTHER(-1,1,-1), iVar1 == 0 &&

         ((iVar1 = CHECK_VERTEX_WITH_DIRS_OTHER(-1,-1,1), iVar1 == 0 &&

          (iVar1 = CHECK_VERTEX_WITH_DIRS_OTHER(-1,-1,-1), iVar1 == 0)))))))) {

      return 0;

    }

    iVar10 = zRange;

    iVar9 = yRange;

    iVar1 = xRange;

    iVar6 = (o1->linearVel).x;

    iVar3 = (o0->linearVel).x;

    iVar2 = iVar6 - iVar3;

    if (iVar2 < 1) {

      iVar2 = iVar3 - iVar6;

    }

    iVar6 = (o1->linearVel).y;

    iVar3 = (o0->linearVel).y;

    iVar7 = iVar6 - iVar3;

    if (iVar7 < 1) {

      iVar7 = iVar3 - iVar6;

    }

    iVar8 = (o1->linearVel).z;

    iVar3 = (o0->linearVel).z;

    iVar6 = iVar8 - iVar3;

    if (iVar6 < 1) {

      iVar6 = iVar3 - iVar8;

    }

    if (iVar2 < iVar7) {

      iVar2 = iVar7;

    }

    if (iVar2 < iVar6) {

      iVar2 = iVar6;

    }

    findClosestSideDave = (int)(0xf0000 < iVar2);

    if (findClosestSideDave != 0) {

      iVar1 = (o0->linearVel).x;

      iVar9 = (o0->linearVel).y;

      iVar10 = (o0->linearVel).z;

      local_60 = (o1->orientMat).m[0];

      local_5c = (o1->orientMat).m[1];

      local_58 = (o1->orientMat).m[2];

      local_50 = (o1->orientMat).m[3];

      local_4c = (o1->orientMat).m[4];

      local_48 = (o1->orientMat).m[5];

      local_40 = (o1->orientMat).m[6];

      local_3c = (o1->orientMat).m[7];

      local_38 = (o1->orientMat).m[8];

      if (xRange < 0) {

        local_60 = -local_60;

        local_58 = -local_58;

        local_5c = -local_5c;

      }

      if (yRange < 0) {

        local_50 = -local_50;

        local_48 = -local_48;

        local_4c = -local_4c;

      }

      if (zRange < 0) {

        local_40 = -local_40;

        local_38 = -local_38;

        local_3c = -local_3c;

      }

      iVar2 = local_60;

      if (local_60 < 0) {

        iVar2 = local_60 + 0xff;

      }

      iVar3 = iVar1;

      if (iVar1 < 0) {

        iVar3 = iVar1 + 0xff;

      }

      iVar6 = local_5c;

      if (local_5c < 0) {

        iVar6 = local_5c + 0xff;

      }

      iVar7 = iVar9;

      if (iVar9 < 0) {

        iVar7 = iVar9 + 0xff;

      }

      iVar8 = local_58;

      if (local_58 < 0) {

        iVar8 = local_58 + 0xff;

      }

      iVar4 = iVar10;

      if (iVar10 < 0) {

        iVar4 = iVar10 + 0xff;

      }

      iVar2 = (iVar2 >> 8) * (iVar3 >> 8) + (iVar6 >> 8) * (iVar7 >> 8) +

              (iVar8 >> 8) * (iVar4 >> 8);

      iVar6 = local_50;

      if (local_50 < 0) {

        iVar6 = local_50 + 0xff;

      }

      iVar8 = local_4c;

      if (local_4c < 0) {

        iVar8 = local_4c + 0xff;

      }

      iVar5 = local_48;

      if (local_48 < 0) {

        iVar5 = local_48 + 0xff;

      }

      iVar3 = (iVar6 >> 8) * (iVar3 >> 8) + (iVar8 >> 8) * (iVar7 >> 8) +

              (iVar5 >> 8) * (iVar4 >> 8);

      iVar6 = local_40;

      if (local_40 < 0) {

        iVar6 = local_40 + 0xff;

      }

      if (iVar1 < 0) {

        iVar1 = iVar1 + 0xff;

      }

      iVar7 = local_3c;

      if (local_3c < 0) {

        iVar7 = local_3c + 0xff;

      }

      if (iVar9 < 0) {

        iVar9 = iVar9 + 0xff;

      }

      iVar8 = local_38;

      if (local_38 < 0) {

        iVar8 = local_38 + 0xff;

      }

      if (iVar10 < 0) {

        iVar10 = iVar10 + 0xff;

      }

      if (iVar2 < 0) {

        iVar2 = -iVar2;

      }

      if (iVar3 < 0) {

        iVar3 = -iVar3;

      }

      iVar1 = (iVar6 >> 8) * (iVar1 >> 8) + (iVar7 >> 8) * (iVar9 >> 8) +

              (iVar8 >> 8) * (iVar10 >> 8);

      if (iVar1 < 0) {

        iVar1 = -iVar1;

      }

      if ((iVar3 < iVar2) && (iVar1 < iVar2)) {

LAB_8008ff94:

        normal->x = local_60;

        normal->y = local_5c;

        normal->z = local_58;

        return 1;

      }

      if (iVar3 <= iVar1) {

LAB_8008ffe0:

        normal->x = local_40;

        normal->y = local_3c;

        normal->z = local_38;

        return 1;

      }

LAB_8008ffc0:

      normal->x = local_50;

      normal->y = local_4c;

      normal->z = local_48;

      return 1;

    }

    if (xRange < 0) {

      iVar2 = (o1->dimension).x + xRange;

    }

    else {

      iVar2 = (o1->dimension).x - xRange;

    }

    if (yRange < 0) {

      iVar3 = (o1->dimension).y + yRange;

    }

    else {

      iVar3 = (o1->dimension).y - yRange;

    }

    if (zRange < 0) {

      iVar6 = (o1->dimension).z + zRange;

    }

    else {

      iVar6 = (o1->dimension).z - zRange;

    }

    if ((iVar2 < iVar3) && (iVar2 < iVar6)) {

      iVar9 = (o1->orientMat).m[1];

      iVar10 = (o1->orientMat).m[2];

      normal->x = (o1->orientMat).m[0];

      normal->y = iVar9;

      normal->z = iVar10;

      iVar10 = iVar1;

    }

    else if (iVar3 < iVar6) {

      iVar1 = (o1->orientMat).m[4];

      iVar10 = (o1->orientMat).m[5];

      normal->x = (o1->orientMat).m[3];

      normal->y = iVar1;

      normal->z = iVar10;

      iVar10 = iVar9;

    }

    else {

      iVar1 = (o1->orientMat).m[7];

      iVar9 = (o1->orientMat).m[8];

      normal->x = (o1->orientMat).m[6];

      normal->y = iVar1;

      normal->z = iVar9;

    }

    if (-1 < iVar10) {

      return 1;

    }

  }

  else {

    iVar10 = zRange;

    iVar9 = yRange;

    iVar1 = xRange;

    iVar6 = (o1->linearVel).x;

    iVar3 = (o0->linearVel).x;

    iVar2 = iVar6 - iVar3;

    if (iVar2 < 1) {

      iVar2 = iVar3 - iVar6;

    }

    iVar6 = (o1->linearVel).y;

    iVar3 = (o0->linearVel).y;

    iVar7 = iVar6 - iVar3;

    if (iVar7 < 1) {

      iVar7 = iVar3 - iVar6;

    }

    iVar8 = (o1->linearVel).z;

    iVar3 = (o0->linearVel).z;

    iVar6 = iVar8 - iVar3;

    if (iVar6 < 1) {

      iVar6 = iVar3 - iVar8;

    }

    if (iVar2 < iVar7) {

      iVar2 = iVar7;

    }

    if (iVar2 < iVar6) {

      iVar2 = iVar6;

    }

    findClosestSideDave = (int)(0xf0000 < iVar2);

    if (findClosestSideDave != 0) {

      iVar1 = (o1->linearVel).x;

      iVar9 = (o1->linearVel).y;

      iVar10 = (o1->linearVel).z;

      local_60 = (o0->orientMat).m[0];

      local_5c = (o0->orientMat).m[1];

      local_58 = (o0->orientMat).m[2];

      local_50 = (o0->orientMat).m[3];

      local_4c = (o0->orientMat).m[4];

      local_48 = (o0->orientMat).m[5];

      local_40 = (o0->orientMat).m[6];

      local_3c = (o0->orientMat).m[7];

      local_38 = (o0->orientMat).m[8];

      if (0 < xRange) {

        local_60 = -local_60;

        local_58 = -local_58;

        local_5c = -local_5c;

      }

      if (0 < yRange) {

        local_50 = -local_50;

        local_48 = -local_48;

        local_4c = -local_4c;

      }

      if (0 < zRange) {

        local_40 = -local_40;

        local_38 = -local_38;

        local_3c = -local_3c;

      }

      iVar2 = local_60;

      if (local_60 < 0) {

        iVar2 = local_60 + 0xff;

      }

      iVar3 = iVar1;

      if (iVar1 < 0) {

        iVar3 = iVar1 + 0xff;

      }

      iVar6 = local_5c;

      if (local_5c < 0) {

        iVar6 = local_5c + 0xff;

      }

      iVar7 = iVar9;

      if (iVar9 < 0) {

        iVar7 = iVar9 + 0xff;

      }

      iVar8 = local_58;

      if (local_58 < 0) {

        iVar8 = local_58 + 0xff;

      }

      iVar4 = iVar10;

      if (iVar10 < 0) {

        iVar4 = iVar10 + 0xff;

      }

      iVar2 = (iVar2 >> 8) * (iVar3 >> 8) + (iVar6 >> 8) * (iVar7 >> 8) +

              (iVar8 >> 8) * (iVar4 >> 8);

      iVar6 = local_50;

      if (local_50 < 0) {

        iVar6 = local_50 + 0xff;

      }

      iVar8 = local_4c;

      if (local_4c < 0) {

        iVar8 = local_4c + 0xff;

      }

      iVar5 = local_48;

      if (local_48 < 0) {

        iVar5 = local_48 + 0xff;

      }

      iVar3 = (iVar6 >> 8) * (iVar3 >> 8) + (iVar8 >> 8) * (iVar7 >> 8) +

              (iVar5 >> 8) * (iVar4 >> 8);

      iVar6 = local_40;

      if (local_40 < 0) {

        iVar6 = local_40 + 0xff;

      }

      if (iVar1 < 0) {

        iVar1 = iVar1 + 0xff;

      }

      iVar7 = local_3c;

      if (local_3c < 0) {

        iVar7 = local_3c + 0xff;

      }

      if (iVar9 < 0) {

        iVar9 = iVar9 + 0xff;

      }

      iVar8 = local_38;

      if (local_38 < 0) {

        iVar8 = local_38 + 0xff;

      }

      if (iVar10 < 0) {

        iVar10 = iVar10 + 0xff;

      }

      if (iVar2 < 0) {

        iVar2 = -iVar2;

      }

      if (iVar3 < 0) {

        iVar3 = -iVar3;

      }

      iVar1 = (iVar6 >> 8) * (iVar1 >> 8) + (iVar7 >> 8) * (iVar9 >> 8) +

              (iVar8 >> 8) * (iVar10 >> 8);

      if (iVar1 < 0) {

        iVar1 = -iVar1;

      }

      if ((iVar3 < iVar2) && (iVar1 < iVar2)) goto LAB_8008ff94;

      if (iVar3 <= iVar1) goto LAB_8008ffe0;

      goto LAB_8008ffc0;

    }

    if (xRange < 0) {

      iVar2 = (o0->dimension).x + xRange;

    }

    else {

      iVar2 = (o0->dimension).x - xRange;

    }

    if (yRange < 0) {

      iVar3 = (o0->dimension).y + yRange;

    }

    else {

      iVar3 = (o0->dimension).y - yRange;

    }

    if (zRange < 0) {

      iVar6 = (o0->dimension).z + zRange;

    }

    else {

      iVar6 = (o0->dimension).z - zRange;

    }

    if ((iVar2 < iVar3) && (iVar2 < iVar6)) {

      iVar9 = (o0->orientMat).m[1];

      iVar10 = (o0->orientMat).m[2];

      normal->x = (o0->orientMat).m[0];

      normal->y = iVar9;

      normal->z = iVar10;

      iVar10 = iVar1;

    }

    else if (iVar3 < iVar6) {

      iVar1 = (o0->orientMat).m[4];

      iVar10 = (o0->orientMat).m[5];

      normal->x = (o0->orientMat).m[3];

      normal->y = iVar1;

      normal->z = iVar10;

      iVar10 = iVar9;

    }

    else {

      iVar1 = (o0->orientMat).m[7];

      iVar9 = (o0->orientMat).m[8];

      normal->x = (o0->orientMat).m[6];

      normal->y = iVar1;

      normal->z = iVar9;

    }

    if (iVar10 < 1) {

      return 1;

    }

  }

  normal->x = -normal->x;

  normal->z = -normal->z;

  normal->y = -normal->y;

  return 1;

}

/* ---- Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2  [@0x80090144] ---- */
int Collide_TestObjectVertices(BO_tNewtonObj *o0,BO_tNewtonObj *o1,coorddef *p,coorddef *normal)



{
  int collisionHappened;
  int ctr;
  int numbackoffsteps;
  coorddef backoff0;
  coorddef backoff1;
  coorddef relativePosition;
  coorddef relativeVelocity;
  int useVelocity;
  coorddef relativeUnit;
  int maxrv;
  int maxrp;
  int inverseRelativeVelocityLength;
  int temp;
  int dot;
  coorddef velocityUnit;
  coorddef positionUnit;
  int totalMass;
  int r0;
  int r1;

  bool bVar1;

  int iVar2;

  int iVar3;

  int iVar4;

  int iVar5;

  int iVar6;

  int iVar7;

  int iVar8;

  int iVar9;

  int iVar10;

  int iVar11;

  int iVar12;

  int local_a0;

  int local_9c;

  int local_98;

  int local_90;

  int local_8c;

  int local_88;

  coorddef local_70;

  coorddef local_60;

  coorddef local_50;

  coorddef local_40;

  coorddef *local_30;

  

  iVar12 = 0;

  iVar6 = (o0->orientMat).m[0];

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  iVar2 = (o1->orientMat).m[0];

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar7 = (o0->orientMat).m[1];

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  iVar3 = (o1->orientMat).m[1];

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar8 = (o0->orientMat).m[2];

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar4 = (o1->orientMat).m[2];

  if (iVar4 < 0) {

    iVar4 = iVar4 + 0xff;

  }

  basisDots[0] = (iVar6 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8) +

                 (iVar8 >> 8) * (iVar4 >> 8);

  iVar6 = (o0->orientMat).m[0];

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  iVar2 = (o1->orientMat).m[3];

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar7 = (o0->orientMat).m[1];

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  iVar3 = (o1->orientMat).m[4];

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar8 = (o0->orientMat).m[2];

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar4 = (o1->orientMat).m[5];

  if (iVar4 < 0) {

    iVar4 = iVar4 + 0xff;

  }

  basisDots[1] = (iVar6 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8) +

                 (iVar8 >> 8) * (iVar4 >> 8);

  iVar6 = (o0->orientMat).m[0];

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  iVar2 = (o1->orientMat).m[6];

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar7 = (o0->orientMat).m[1];

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  iVar3 = (o1->orientMat).m[7];

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar8 = (o0->orientMat).m[2];

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar4 = (o1->orientMat).m[8];

  if (iVar4 < 0) {

    iVar4 = iVar4 + 0xff;

  }

  basisDots[2] = (iVar6 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8) +

                 (iVar8 >> 8) * (iVar4 >> 8);

  iVar6 = (o0->orientMat).m[3];

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  iVar2 = (o1->orientMat).m[0];

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar7 = (o0->orientMat).m[4];

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  iVar3 = (o1->orientMat).m[1];

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar8 = (o0->orientMat).m[5];

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar4 = (o1->orientMat).m[2];

  if (iVar4 < 0) {

    iVar4 = iVar4 + 0xff;

  }

  basisDots[3] = (iVar6 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8) +

                 (iVar8 >> 8) * (iVar4 >> 8);

  iVar6 = (o0->orientMat).m[3];

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  iVar2 = (o1->orientMat).m[3];

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar7 = (o0->orientMat).m[4];

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  iVar3 = (o1->orientMat).m[4];

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar8 = (o0->orientMat).m[5];

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar4 = (o1->orientMat).m[5];

  if (iVar4 < 0) {

    iVar4 = iVar4 + 0xff;

  }

  basisDots[4] = (iVar6 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8) +

                 (iVar8 >> 8) * (iVar4 >> 8);

  iVar6 = (o0->orientMat).m[3];

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  iVar2 = (o1->orientMat).m[6];

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar7 = (o0->orientMat).m[4];

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  iVar3 = (o1->orientMat).m[7];

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar8 = (o0->orientMat).m[5];

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar4 = (o1->orientMat).m[8];

  if (iVar4 < 0) {

    iVar4 = iVar4 + 0xff;

  }

  basisDots[5] = (iVar6 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8) +

                 (iVar8 >> 8) * (iVar4 >> 8);

  iVar6 = (o0->orientMat).m[6];

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  iVar2 = (o1->orientMat).m[0];

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar7 = (o0->orientMat).m[7];

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  iVar3 = (o1->orientMat).m[1];

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar8 = (o0->orientMat).m[8];

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar4 = (o1->orientMat).m[2];

  if (iVar4 < 0) {

    iVar4 = iVar4 + 0xff;

  }

  basisDots[6] = (iVar6 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8) +

                 (iVar8 >> 8) * (iVar4 >> 8);

  iVar6 = (o0->orientMat).m[6];

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  iVar2 = (o1->orientMat).m[3];

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar7 = (o0->orientMat).m[7];

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  iVar3 = (o1->orientMat).m[4];

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar8 = (o0->orientMat).m[8];

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar4 = (o1->orientMat).m[5];

  if (iVar4 < 0) {

    iVar4 = iVar4 + 0xff;

  }

  basisDots[7] = (iVar6 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8) +

                 (iVar8 >> 8) * (iVar4 >> 8);

  iVar6 = (o0->orientMat).m[6];

  if (iVar6 < 0) {

    iVar6 = iVar6 + 0xff;

  }

  iVar2 = (o1->orientMat).m[6];

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  iVar7 = (o0->orientMat).m[7];

  if (iVar7 < 0) {

    iVar7 = iVar7 + 0xff;

  }

  iVar3 = (o1->orientMat).m[7];

  if (iVar3 < 0) {

    iVar3 = iVar3 + 0xff;

  }

  iVar8 = (o0->orientMat).m[8];

  if (iVar8 < 0) {

    iVar8 = iVar8 + 0xff;

  }

  iVar4 = (o1->orientMat).m[8];

  if (iVar4 < 0) {

    iVar4 = iVar4 + 0xff;

  }

  basisDots[8] = (iVar6 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8) +

                 (iVar8 >> 8) * (iVar4 >> 8);

  iVar6 = basisDots[0];

  if (basisDots[0] < 0) {

    iVar6 = basisDots[0] + 0xff;

  }

  iVar2 = (o1->dimension).x;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDots[0] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[1];

  if (basisDots[1] < 0) {

    iVar6 = basisDots[1] + 0xff;

  }

  iVar2 = (o1->dimension).y;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDots[1] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[2];

  if (basisDots[2] < 0) {

    iVar6 = basisDots[2] + 0xff;

  }

  iVar2 = (o1->dimension).z;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDots[2] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[3];

  if (basisDots[3] < 0) {

    iVar6 = basisDots[3] + 0xff;

  }

  iVar2 = (o1->dimension).x;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDots[3] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[4];

  if (basisDots[4] < 0) {

    iVar6 = basisDots[4] + 0xff;

  }

  iVar2 = (o1->dimension).y;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDots[4] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[5];

  if (basisDots[5] < 0) {

    iVar6 = basisDots[5] + 0xff;

  }

  iVar2 = (o1->dimension).z;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDots[5] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[6];

  if (basisDots[6] < 0) {

    iVar6 = basisDots[6] + 0xff;

  }

  iVar2 = (o1->dimension).x;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDots[6] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[7];

  if (basisDots[7] < 0) {

    iVar6 = basisDots[7] + 0xff;

  }

  iVar2 = (o1->dimension).y;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDots[7] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[8];

  if (basisDots[8] < 0) {

    iVar6 = basisDots[8] + 0xff;

  }

  iVar2 = (o1->dimension).z;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDots[8] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[0];

  if (basisDots[0] < 0) {

    iVar6 = basisDots[0] + 0xff;

  }

  iVar2 = (o0->dimension).x;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDotsOther[0] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[1];

  if (basisDots[1] < 0) {

    iVar6 = basisDots[1] + 0xff;

  }

  iVar2 = (o0->dimension).x;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDotsOther[1] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[2];

  if (basisDots[2] < 0) {

    iVar6 = basisDots[2] + 0xff;

  }

  iVar2 = (o0->dimension).x;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDotsOther[2] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[3];

  if (basisDots[3] < 0) {

    iVar6 = basisDots[3] + 0xff;

  }

  iVar2 = (o0->dimension).y;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDotsOther[3] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[4];

  if (basisDots[4] < 0) {

    iVar6 = basisDots[4] + 0xff;

  }

  iVar2 = (o0->dimension).y;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDotsOther[4] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[5];

  if (basisDots[5] < 0) {

    iVar6 = basisDots[5] + 0xff;

  }

  iVar2 = (o0->dimension).y;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDotsOther[5] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[6];

  if (basisDots[6] < 0) {

    iVar6 = basisDots[6] + 0xff;

  }

  iVar2 = (o0->dimension).z;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDotsOther[6] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[7];

  if (basisDots[7] < 0) {

    iVar6 = basisDots[7] + 0xff;

  }

  iVar2 = (o0->dimension).z;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDotsOther[7] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = basisDots[8];

  if (basisDots[8] < 0) {

    iVar6 = basisDots[8] + 0xff;

  }

  iVar2 = (o0->dimension).z;

  if (iVar2 < 0) {

    iVar2 = iVar2 + 0xff;

  }

  scaledBasisDotsOther[8] = (iVar6 >> 8) * (iVar2 >> 8);

  iVar6 = 0;

  local_30 = &local_70;

  do {

    if (0x1f < iVar6) {

      return iVar12;

    }

    iVar3 = (o1->position).x - (o0->position).x;

    iVar8 = (o1->position).y - (o0->position).y;

    iVar2 = (o1->position).z - (o0->position).z;

    iVar7 = (o0->orientMat).m[0];

    if (iVar7 < 0) {

      iVar7 = iVar7 + 0xff;

    }

    iVar4 = iVar3;

    if (iVar3 < 0) {

      iVar4 = iVar3 + 0xff;

    }

    iVar9 = (o0->orientMat).m[1];

    if (iVar9 < 0) {

      iVar9 = iVar9 + 0xff;

    }

    iVar11 = iVar8;

    if (iVar8 < 0) {

      iVar11 = iVar8 + 0xff;

    }

    iVar10 = (o0->orientMat).m[2];

    if (iVar10 < 0) {

      iVar10 = iVar10 + 0xff;

    }

    iVar5 = iVar2;

    if (iVar2 < 0) {

      iVar5 = iVar2 + 0xff;

    }

    basisDotRelative[0] =

         (iVar7 >> 8) * (iVar4 >> 8) + (iVar9 >> 8) * (iVar11 >> 8) + (iVar10 >> 8) * (iVar5 >> 8);

    iVar7 = (o0->orientMat).m[3];

    if (iVar7 < 0) {

      iVar7 = iVar7 + 0xff;

    }

    iVar9 = (o0->orientMat).m[4];

    if (iVar9 < 0) {

      iVar9 = iVar9 + 0xff;

    }

    iVar10 = (o0->orientMat).m[5];

    if (iVar10 < 0) {

      iVar10 = iVar10 + 0xff;

    }

    iVar5 = iVar2;

    if (iVar2 < 0) {

      iVar5 = iVar2 + 0xff;

    }

    basisDotRelative[1] =

         (iVar7 >> 8) * (iVar4 >> 8) + (iVar9 >> 8) * (iVar11 >> 8) + (iVar10 >> 8) * (iVar5 >> 8);

    iVar7 = (o0->orientMat).m[6];

    if (iVar7 < 0) {

      iVar7 = iVar7 + 0xff;

    }

    iVar4 = iVar3;

    if (iVar3 < 0) {

      iVar4 = iVar3 + 0xff;

    }

    iVar9 = (o0->orientMat).m[7];

    if (iVar9 < 0) {

      iVar9 = iVar9 + 0xff;

    }

    iVar11 = iVar8;

    if (iVar8 < 0) {

      iVar11 = iVar8 + 0xff;

    }

    iVar10 = (o0->orientMat).m[8];

    if (iVar10 < 0) {

      iVar10 = iVar10 + 0xff;

    }

    iVar5 = iVar2;

    if (iVar2 < 0) {

      iVar5 = iVar2 + 0xff;

    }

    basisDotRelative[2] =

         (iVar7 >> 8) * (iVar4 >> 8) + (iVar9 >> 8) * (iVar11 >> 8) + (iVar10 >> 8) * (iVar5 >> 8);

    iVar7 = (o1->orientMat).m[0];

    if (iVar7 < 0) {

      iVar7 = iVar7 + 0xff;

    }

    iVar9 = (o1->orientMat).m[1];

    if (iVar9 < 0) {

      iVar9 = iVar9 + 0xff;

    }

    iVar10 = (o1->orientMat).m[2];

    if (iVar10 < 0) {

      iVar10 = iVar10 + 0xff;

    }

    iVar5 = iVar2;

    if (iVar2 < 0) {

      iVar5 = iVar2 + 0xff;

    }

    basisDotRelative[3] =

         (iVar7 >> 8) * (iVar4 >> 8) + (iVar9 >> 8) * (iVar11 >> 8) + (iVar10 >> 8) * (iVar5 >> 8);

    iVar7 = (o1->orientMat).m[3];

    if (iVar7 < 0) {

      iVar7 = iVar7 + 0xff;

    }

    iVar4 = iVar3;

    if (iVar3 < 0) {

      iVar4 = iVar3 + 0xff;

    }

    iVar9 = (o1->orientMat).m[4];

    if (iVar9 < 0) {

      iVar9 = iVar9 + 0xff;

    }

    iVar11 = iVar8;

    if (iVar8 < 0) {

      iVar11 = iVar8 + 0xff;

    }

    iVar10 = (o1->orientMat).m[5];

    if (iVar10 < 0) {

      iVar10 = iVar10 + 0xff;

    }

    iVar5 = iVar2;

    if (iVar2 < 0) {

      iVar5 = iVar2 + 0xff;

    }

    basisDotRelative[4] =

         (iVar7 >> 8) * (iVar4 >> 8) + (iVar9 >> 8) * (iVar11 >> 8) + (iVar10 >> 8) * (iVar5 >> 8);

    iVar7 = (o1->orientMat).m[6];

    if (iVar7 < 0) {

      iVar7 = iVar7 + 0xff;

    }

    iVar9 = (o1->orientMat).m[7];

    if (iVar9 < 0) {

      iVar9 = iVar9 + 0xff;

    }

    iVar10 = (o1->orientMat).m[8];

    if (iVar10 < 0) {

      iVar10 = iVar10 + 0xff;

    }

    iVar5 = iVar2;

    if (iVar2 < 0) {

      iVar5 = iVar2 + 0xff;

    }

    basisDotRelative[5] =

         (iVar7 >> 8) * (iVar4 >> 8) + (iVar9 >> 8) * (iVar11 >> 8) + (iVar10 >> 8) * (iVar5 >> 8);

    iVar7 = Collide_DoActualObjectCollisionCheck(o0,o1,p,normal);

    if (iVar7 == 0) {

      return iVar12;

    }

    if (iVar12 == 0) {

      bVar1 = false;

      local_70.x = (o0->linearVel).x - (o1->linearVel).x;

      iVar12 = 0;

      local_70.y = (o0->linearVel).y - (o1->linearVel).y;

      local_70.z = (o0->linearVel).z - (o1->linearVel).z;

      iVar7 = local_70.x;

      if (local_70.x < 0) {

        iVar7 = local_70.x + 0xff;

      }

      iVar4 = local_70.z;

      if (local_70.z < 0) {

        iVar4 = local_70.z + 0xff;

      }

      if (0xe100000 < (iVar7 >> 8) * (iVar7 >> 8) + (iVar4 >> 8) * (iVar4 >> 8)) {

        iVar7 = iVar3;

        if (iVar3 < 0) {

          iVar7 = iVar3 + 0xff;

        }

        iVar4 = iVar2;

        if (iVar2 < 0) {

          iVar4 = iVar2 + 0xff;

        }

        if ((iVar7 >> 8) * (iVar7 >> 8) + (iVar4 >> 8) * (iVar4 >> 8) < 0xccc) {

          iVar7 = Math_VectorLength(&local_70);

          iVar7 = iVar7 / 2;

          iVar12 = 0x10000;

          if (iVar7 == 0) {

            bVar1 = true;

          }

          else {

LAB_80091008:

            iVar12 = fixeddiv(0x8000,iVar7);

LAB_80091014:

            bVar1 = true;

          }

        }

        else {

          local_50.x = local_70.x;

          local_50.y = local_70.y;

          local_50.z = local_70.z;

          Math_NormalizeVector(&local_50);

          local_40.x = iVar3;

          local_40.y = iVar8;

          local_40.z = iVar2;

          Math_NormalizeShortVector(&local_40);

          iVar7 = local_50.x;

          if (local_50.x < 0) {

            iVar7 = local_50.x + 0xff;

          }

          iVar4 = local_40.x;

          if (local_40.x < 0) {

            iVar4 = local_40.x + 0xff;

          }

          iVar9 = local_50.y;

          if (local_50.y < 0) {

            iVar9 = local_50.y + 0xff;

          }

          iVar11 = local_40.y;

          if (local_40.y < 0) {

            iVar11 = local_40.y + 0xff;

          }

          iVar10 = local_50.z;

          if (local_50.z < 0) {

            iVar10 = local_50.z + 0xff;

          }

          iVar5 = local_40.z;

          if (local_40.z < 0) {

            iVar5 = local_40.z + 0xff;

          }

          if (0xd999 < (iVar7 >> 8) * (iVar4 >> 8) + (iVar9 >> 8) * (iVar11 >> 8) +

                       (iVar10 >> 8) * (iVar5 >> 8)) {

            iVar7 = Math_VectorLength(local_30);

            iVar7 = iVar7 / 2;

            iVar12 = 0x10000;

            if (iVar7 != 0) goto LAB_80091008;

            goto LAB_80091014;

          }

        }

      }

      if (bVar1) {

        iVar2 = -iVar12;

        if (o0->objID < 0x200) {

          iVar7 = fixedmult(iVar2,(o0->linearVel).x);

          iVar3 = fixedmult(iVar2,(o0->linearVel).y);

          iVar2 = fixedmult(iVar2,(o0->linearVel).z);

          local_98 = iVar2 >> 5;

          local_a0 = iVar7 >> 5;

          local_9c = iVar3 >> 5;

        }

        else {

          local_a0 = 0;

          local_9c = 0;

          local_98 = 0;

        }

        iVar12 = -iVar12;

        if (o1->objID < 0x200) {

          iVar2 = fixedmult(iVar12,(o1->linearVel).x);

          iVar7 = fixedmult(iVar12,(o1->linearVel).y);

          iVar12 = fixedmult(iVar12,(o1->linearVel).z);

          local_88 = iVar12 >> 5;

          local_90 = iVar2 >> 5;

          local_8c = iVar7 >> 5;

        }

        else {

          local_90 = 0;

          local_8c = 0;

          local_88 = 0;

        }

      }

      else {

        local_60.x = iVar3;

        local_60.y = iVar8;

        local_60.z = iVar2;

        Math_NormalizeShortVector(&local_60);

        iVar2 = o0->mass + o1->mass;

        iVar12 = fixeddiv(o0->mass,iVar2);

        iVar2 = fixeddiv(o1->mass,iVar2);

        if (iVar2 < 0) {

          iVar2 = iVar2 + 3;

        }

        iVar2 = iVar2 >> 2;

        iVar7 = local_60.x * iVar2;

        if (iVar7 < 0) {

          iVar7 = iVar7 + 0x3fff;

        }

        iVar3 = local_60.y * iVar2;

        local_a0 = -(iVar7 >> 0xe) >> 5;

        if (iVar3 < 0) {

          iVar3 = iVar3 + 0x3fff;

        }

        local_9c = -(iVar3 >> 0xe) >> 5;

        iVar2 = local_60.z * iVar2;

        if (iVar2 < 0) {

          iVar2 = iVar2 + 0x3fff;

        }

        local_98 = -(iVar2 >> 0xe) >> 5;

        if (iVar12 < 0) {

          iVar12 = iVar12 + 3;

        }

        iVar12 = iVar12 >> 2;

        iVar8 = local_60.x * iVar12;

        iVar4 = local_60.y * iVar12;

        if (iVar8 < 0) {

          iVar8 = iVar8 + 0x3fff;

        }

        local_90 = iVar8 >> 0x13;

        if (iVar4 < 0) {

          iVar4 = iVar4 + 0x3fff;

        }

        local_8c = iVar4 >> 0x13;

        iVar12 = local_60.z * iVar12;

        if (iVar12 < 0) {

          iVar12 = iVar12 + 0x3fff;

        }

        local_88 = iVar12 >> 0x13;

        if (0x1ff < o0->objID) {

          local_90 = local_90 - (iVar8 >> 0x1f) >> 1;

          local_8c = local_8c - (iVar4 >> 0x1f) >> 1;

          local_88 = local_88 - (iVar12 >> 0x1f) >> 1;

        }

        iVar12 = 1;

        if (o1->objID < 0x200) goto LAB_800912c8;

        local_a0 = local_a0 - (-(iVar7 >> 0xe) >> 0x1f) >> 1;

        local_9c = local_9c - (-(iVar3 >> 0xe) >> 0x1f) >> 1;

        local_98 = local_98 - (-(iVar2 >> 0xe) >> 0x1f) >> 1;

      }

      iVar12 = 1;

    }

LAB_800912c8:

    (o0->position).x = (o0->position).x + local_a0;

    (o0->position).y = (o0->position).y + local_9c;

    (o0->position).z = (o0->position).z + local_98;

    (o1->position).x = (o1->position).x + local_90;

    (o1->position).y = (o1->position).y + local_8c;

    iVar6 = iVar6 + 1;

    (o1->position).z = (o1->position).z + local_88;

  } while( true );

}

/* ---- Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0  [@0x80091374] ---- */
int Collide_CheckForCollisionBetween(BO_tNewtonObj *o0,BO_tNewtonObj *o1)



{
  coorddef *new_var;

  int speedThresh;

  int iVar2;

  int iVar3;

  int iVar4;

  coorddef cStack_38;

  coorddef cStack_28;



  (o0->collision).impulse = 0;

  (o1->collision).impulse = 0;

  iVar2 = Collide_TestObjectVertices(o0,o1,&cStack_38,&cStack_28);

  if (iVar2 == 0) {

    return 0;

  }

  Collide_DoObjectObjectCollision(o0,o1,&cStack_38,&cStack_28);

  iVar4 = 8;

  Physics_TestForBarrierCollision((Car_tObj *)o0);

  Physics_TestForBarrierCollision((Car_tObj *)o1);

  new_var = &cStack_28;

  speedThresh = 0xf0000;

  while( true ) {

    iVar3 = Collide_TestObjectVertices(o0,o1,&cStack_38,new_var);

    if (iVar3 == 0) {

      return 1;

    }

    if (iVar4 <= 0) {

      return 1;

    }

    iVar4 = iVar4 - 1;

    iVar2 = Collide_DoObjectObjectCollision(o0,o1,&cStack_38,new_var);

    if (iVar2 == 0) {

      return 1;

    }

    Physics_TestForBarrierCollision((Car_tObj *)o0);

    Physics_TestForBarrierCollision((Car_tObj *)o1);

    if (iVar4 == 0) {

      if ((o0[1].collision.lastCollision != 0) && (speedThresh < o0->speedXZ)) {

        Newton_AddDamageZone(o0,0x640000,8,2);

      }

      if ((o1[1].collision.lastCollision != 0) && (speedThresh < o1->speedXZ)) {

        Newton_AddDamageZone(o1,0x640000,8,2);

      }

    }

  }

}

/* ---- Collide_ClearCollisionRegistry__Fv  [@0x800914d4] ---- */
void Collide_ClearCollisionRegistry(void)
{
  int carLoop;
  coorddef relVec;
  coorddef rightVec;
  int i;
  int slice;

  /* MATCH: SYM rule-8 - locals are exactly {carLoop REG, relVec AUTO, rightVec AUTO, i REG,
     slice REG}; plain InfiniteMassNewton[i].field indexing lets gcc strength-reduce the
     walking s-reg givs itself (no hand pointer locals). relVec/rightVec are REAL stack
     structs (oracle spills all six words to 0x10-0x28(sp)). NOTE: all three relVec
     components subtract center[0] - faithful to retail (looks like an original bug). */
  Collide_gNumRegistered = 0;
  for (i = 0; i < Object_GetNumIMassObjects(); i = i + 1) {
    Object_GetIMassObjectMotion(i,&InfiniteMassNewton[i].position,&InfiniteMassNewton[i].orientMat,
                                 &InfiniteMassNewton[i].linearVel);
    InfiniteMassNewton[i].angularVel.x = 0;
    InfiniteMassNewton[i].angularVel.y = 0;
    InfiniteMassNewton[i].angularVel.z = 0;
    Collide_gRegistry[i] = &InfiniteMassNewton[i];
    Collide_gNumRegistered = Collide_gNumRegistered + 1;
    BWorldSm_FindClosestSlice(&InfiniteMassNewton[i].position,&InfiniteMassNewton[i].simRoadInfo);
    slice = InfiniteMassNewton[i].simRoadInfo.slice;
    relVec.x = InfiniteMassNewton[i].position.x - BWorldSm_slices[slice].center[0];
    relVec.y = InfiniteMassNewton[i].position.y - BWorldSm_slices[slice].center[0];
    relVec.z = InfiniteMassNewton[i].position.z - BWorldSm_slices[slice].center[0];
    rightVec.x = (signed char)BWorldSm_slices[slice].right[0] * 0x200;
    rightVec.y = (signed char)BWorldSm_slices[slice].right[1] * 0x200;
    rightVec.z = (signed char)BWorldSm_slices[slice].right[2] * 0x200;
    InfiniteMassNewton[i].xRelRoadCenter =
        (relVec.x / 256) * (rightVec.x / 256) + (relVec.y / 256) * (rightVec.y / 256) +
        (relVec.z / 256) * (rightVec.z / 256);
  }
  carLoop = 0;
  {
    int n = Cars_gNumCars;
carloop_top:
    if (carLoop < n) {
      carLoop = carLoop + 1;
      goto carloop_top;
    }
  }
  return;
}


/* ---- Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi  [@0x800916d4] ---- */
int Collide_CheckAccuratePointRadiusCollision(BO_tNewtonObj *newObj,coorddef *point,int radius)
{
  coorddef d;
  int temp;

  d.x = point->x - (newObj->position).x;
  d.z = point->z - (newObj->position).z;
  d.y = 0;
  /* MATCH: SYM rule-8 - single named 'temp' accumulator; one-expression sums let gcc
     capture each fixedmult result in the NEXT jal's delay slot (3-var form scheduled early) */
  temp = fixedmult(d.x,(newObj->orientMat).m[0]) + fixedmult(d.y,(newObj->orientMat).m[1]) +
         fixedmult(d.z,(newObj->orientMat).m[2]);
  if (temp > 0) {
    temp = fixedmult(d.x,(newObj->orientMat).m[0]) + fixedmult(d.y,(newObj->orientMat).m[1]) +
           fixedmult(d.z,(newObj->orientMat).m[2]);
  }
  else {
    temp = -(fixedmult(d.x,(newObj->orientMat).m[0]) + fixedmult(d.y,(newObj->orientMat).m[1]) +
             fixedmult(d.z,(newObj->orientMat).m[2]));
  }
  /* MATCH: direct returns stage 0 / xori result straight into $v0 (funnel var was v1+move) */
  if ((newObj->dimension).x + radius < temp) return 0;
  temp = fixedmult(d.x,(newObj->orientMat).m[6]) + fixedmult(d.y,(newObj->orientMat).m[7]) +
         fixedmult(d.z,(newObj->orientMat).m[8]);
  if (temp > 0) {
    temp = fixedmult(d.x,(newObj->orientMat).m[6]) + fixedmult(d.y,(newObj->orientMat).m[7]) +
           fixedmult(d.z,(newObj->orientMat).m[8]);
  }
  else {
    temp = -(fixedmult(d.x,(newObj->orientMat).m[6]) + fixedmult(d.y,(newObj->orientMat).m[7]) +
             fixedmult(d.z,(newObj->orientMat).m[8]));
  }
  return ((newObj->dimension).z + radius < temp) ^ 1;
}


/* ---- Collide_CheckMeForCollisions__FP13BO_tNewtonObj  [@0x800918cc] ---- */
void Collide_CheckMeForCollisions(BO_tNewtonObj *newObj)
{
  int i;
  BO_tNewtonObj *otherObj;

  /* MATCH: full SYM rule-8 rebuild - block scopes + names straight from the SYM 8c block
     (outer {i s1, otherObj s0}; collision-loop block {i s5, numObjs, fixedRadius, objList,
     pos, dist}; per-object block {pointList, closestDist s4, closestPoint s3, numPoints};
     {j s0}; {signCase s1}; {normal, samplePoint, impulse s0}).
     CORRECTNESS fixes vs old recon (both oracle-evidenced):
     (1) samplePoint: ALL THREE components = pos + normal*(fixedRadius/256)/256 - old code
         computed only .x (Ghidra-split auStack_58/velocityUnit stack aliasing);
     (2) Newton_DoPostBarrierCollisionHandling is passed NORMAL by value - old code passed
         the first 12 bytes of objList (wrong struct entirely). */
  if (newObj->active != 0) {
    if (newObj->simOptz != 0) {
      Physics_TestForBarrierCollision((Car_tObj *)newObj);
    }
    else {
      if (0 < (newObj->collision).disableCollisionTimer) {
        (newObj->collision).disableCollisionTimer = (newObj->collision).disableCollisionTimer - 1;
      }
      if (((newObj->collision).disableCollisionTimer == 0) &&
          ((newObj->groundSurfaceType & 0x40) != 0)) {
        int i;
        int numObjs;
        int fixedRadius;
        Object_tSimObjList objList;
        coorddef pos;
        int dist;

        Object_InitCollisionCheckLoop(&newObj->simRoadInfo,&objList,&numObjs);
        i = 0;
        while (i < numObjs) {
          coorddef pointList[3];
          int closestDist;
          int closestPoint;
          int numPoints;

          closestPoint = -1;
          closestDist = 0xA0000;
          /* MATCH: SYM opens the j block BEFORE the two Get*CollisionData calls (block note =
             scheduling barrier; keeps closestPoint=-1 at loop top, s2/s3 assignment correct) */
          {
            int j;
            numPoints = 1;
            Object_GetRadiusCollisionData(&objList,i,&pos,&fixedRadius);
            Object_GetPointsCollisionData(&objList,i,&numPoints,pointList);
            if (0 < numPoints) {
              j = 0;
              do {
                dist = Math_DistXZ(&pointList[j],&newObj->position);
                if ((dist < fixedRadius + newObj->dimensionRadius) && (dist < closestDist)) {
                  closestDist = dist;
                  closestPoint = j;
                }
                j = j + 1;
              } while (j < numPoints);
            }
          }
          if (closestPoint < 0) goto nextObj;
          if (Collide_CheckAccuratePointRadiusCollision(newObj,&pointList[closestPoint],fixedRadius) == 0)
            goto nextObj;
          {
            int signCase;
            signCase = Object_CheckCollisionResults(&objList,i,newObj);
            if (signCase == 0) goto nextObj;
            Object_GetRadiusCollisionData(&objList,i,&pos,&fixedRadius);
            if (signCase == 1) {
              coorddef normal;
              coorddef samplePoint;
              int impulse;

              normal.y = 0;
              normal.x = (newObj->position).x - pos.x;
              normal.z = (newObj->position).z - pos.z;
              Math_NormalizeShortVector(&normal);
              impulse = 0;
              samplePoint.x = ((fixedRadius / 256) * normal.x) / 256;
              samplePoint.y = ((fixedRadius / 256) * normal.y) / 256;
              samplePoint.z = ((fixedRadius / 256) * normal.z) / 256;
              samplePoint.x = samplePoint.x + pos.x;
              samplePoint.z = samplePoint.z + pos.z;
              samplePoint.y = samplePoint.y + pos.y;
              if (0x280000 < newObj->speedXZ) {
                /* MATCH: double-compute CSE keeps the sll in a temp + copy (oracle shape) */
                if (0x960000 < newObj->speedXZ << 1) {
                  impulse = 0x960000;
                }
                else {
                  impulse = newObj->speedXZ << 1;
                }
              }
              else if (0x190000 < newObj->speedXZ) {
                impulse = newObj->speedXZ;
                if (impulse < 0x1E0000) {
                  impulse = 0x1E0000;
                }
              }
              else {
                /* MATCH: oracle stores the signCase register (sw s1) - value is 1 on this path */
                frictionLess = signCase;
              }
              Collide_TestWithPlane(newObj,&normal,&samplePoint);
              frictionLess = 0;
              Newton_DoPostBarrierCollisionHandling(newObj,normal);
              (newObj->collision).impulse = impulse;
              (newObj->collision).collided = 1;
              (newObj->collision).otherObj = (BO_tNewtonObj *)0x0;
              if ((newObj->collision).impulse == 0) goto nextObj; /* MATCH: read-back CSEs to reg copy */
              (newObj->collision).sfxType = 0x50001;
              (newObj->collision).collisionPoint = newObj->position;
              i = i + 1;
              continue;
            }
            if (signCase == 2) {
              if (0x20000 < newObj->speedXZ) {
                (newObj->collision).impulse = 0xF0000;
                (newObj->collision).sfxType = 0x60006;
                (newObj->collision).otherObj = (BO_tNewtonObj *)0x0;
                (newObj->collision).collisionPoint = newObj->position;
                if (Force_IsForceOn((Car_tObj *)newObj) != 0) {
                  Force_HitSign((Car_tObj *)newObj);
                }
              }
            }
            else if (signCase == -1) {
              (newObj->collision).impulse = 0xF0000;
              (newObj->collision).sfxType = 0x60005;
              (newObj->collision).otherObj = (BO_tNewtonObj *)0x0;
              (newObj->collision).collisionPoint = newObj->position;
              if (Force_IsForceOn((Car_tObj *)newObj) != 0) {
                Force_HitSign((Car_tObj *)newObj);
              }
            }
          }
nextObj:
          i = i + 1;
        }
      }
      if ((newObj->groundSurfaceType & 0x80) != 0) {
        Newton_TestForUndrivableSurfaces(newObj);
      }
      if (newObj->flightTime != 0) {
        Physics_TestForBarrierCollision((Car_tObj *)newObj);
      }
      if ((newObj->collision).disableCollisionTimer == 0) {
        i = 0;
        Collide_gRegistry[Collide_gNumRegistered] = newObj;
        if (0 < Collide_gNumRegistered) {
          do {
            otherObj = Collide_gRegistry[i];
            /* MATCH: ABS-macro-in-compare (no diff local, per SYM): sum > ((d>0)?d:-d);
               fold turns -(a-b) into b-a giving the oracle's reversed subu */
            if (newObj->dimensionRadius + otherObj->dimensionRadius >
                (((newObj->position).z - (otherObj->position).z > 0) ?
                 (newObj->position).z - (otherObj->position).z :
                 -((newObj->position).z - (otherObj->position).z))) {
              if (newObj->dimensionRadius + otherObj->dimensionRadius >
                  (((newObj->position).x - (otherObj->position).x > 0) ?
                   (newObj->position).x - (otherObj->position).x :
                   -((newObj->position).x - (otherObj->position).x))) {
                if (newObj->dimensionRadius + otherObj->dimensionRadius >
                    (((newObj->position).y - (otherObj->position).y > 0) ?
                     (newObj->position).y - (otherObj->position).y :
                     -((newObj->position).y - (otherObj->position).y))) {
                  (newObj->angularVel).x = fixedmult(0x6487e,(newObj->angularVel).x);
                  (newObj->angularVel).y = fixedmult(0x6487e,(newObj->angularVel).y);
                  (newObj->angularVel).z = fixedmult(0x6487e,(newObj->angularVel).z);
                  (otherObj->angularVel).x = fixedmult(0x6487e,(otherObj->angularVel).x);
                  (otherObj->angularVel).y = fixedmult(0x6487e,(otherObj->angularVel).y);
                  (otherObj->angularVel).z = fixedmult(0x6487e,(otherObj->angularVel).z);
                  Collide_CheckForCollisionBetween(newObj,otherObj);
                  (newObj->angularVel).x = fixedmult(0x28be,(newObj->angularVel).x);
                  (newObj->angularVel).y = fixedmult(0x28be,(newObj->angularVel).y);
                  (newObj->angularVel).z = fixedmult(0x28be,(newObj->angularVel).z);
                  (otherObj->angularVel).x = fixedmult(0x28be,(otherObj->angularVel).x);
                  (otherObj->angularVel).y = fixedmult(0x28be,(otherObj->angularVel).y);
                  (otherObj->angularVel).z = fixedmult(0x28be,(otherObj->angularVel).z);
                  Collide_LimitAngularVel(newObj);
                  Collide_LimitAngularVel(otherObj);
                }
              }
            }
            i = i + 1;
          } while (i < Collide_gNumRegistered);
        }
        Collide_gNumRegistered = Collide_gNumRegistered + 1;
      }
    }
  }
  return;
}
