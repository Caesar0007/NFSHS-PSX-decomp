/* game/common/collide.cpp -- RECONSTRUCTED (NFS4 collision detection; BO_tNewtonObj vs world/objects).
 *   13 fns: vertex/center-vertex direction checks, plane test, object-object + accurate point-radius
 *   collision, registry. SYM-v3 locals applied; owns 16 globals (registry/ranges/basis-dot scratch).
 *   NOT original source; self-contained, recompilable. Ghidra LAB_<addr> goto-labels = deferred-#148 cosmetic.
 */
#include "collide_types.h"
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
static int   xRange;   /* SYM STAT @0x8013dd98 */
static int   yRange;   /* SYM STAT @0x8013dd9c */
static int   zRange;   /* SYM STAT @0x8013dda0 */
static int   basisDots[9];   /* SYM STAT @0x8013e008 */
static int   scaledBasisDots[9];   /* SYM STAT @0x8013e038 */
static int   scaledBasisDotsOther[9];   /* SYM STAT @0x8013e068 */
static int   basisDotRelative[6];   /* SYM STAT @0x8013e098 */


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
  /* RULE-8 rewrite from SYM 8c block @0x8008cb0c (fsize=192 mask=$803f0000 = ra+s0..s5) + m2c
     pregen + raw oracle, blocks in oracle VA order.  SYM nesting reproduced exactly:
       fn block { normal,impulse,deltaV,impulseV,temp0-3,r,RCrossN,velocityLength,velocity }
         block2 @cd84 { frictionalImpulse,deltaVFromFriction,temp,frictionalImpulseOverMoment,
                        deltaSpeedInFrictionDirection }
           block3 @cd84 { impulse calc + collision writes + block4 @ce38 {scale,lengthInverse} }
           block5 @cfe8 { block6 @d00c {upVec,dotx,doty,dotz} }
           friction body to d558
         impulse>0 tail (deltaV/impulseV are fn-scope per SYM)
     MATCH: inline signed /256 idiom throughout; upVec is a REAL rodata coorddef @0x80055A00
     {0,0x10000,0} struct-copied then dotted against orientMat cols (Ghidra const-folded the load
     and collapsed the dots); the r x impulseV cross in the impulse>0 tail is written TWICE -
     retail source computed it twice and the oracle keeps both (Ghidra DSE'd the first copy). */
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

  velocity = *v;
  normal = *n;
  velocityLength = 0;
  temp0 = (normal.x / 256) * ((o->linearVel).x / 256) +
          (normal.y / 256) * ((o->linearVel).y / 256) +
          (normal.z / 256) * ((o->linearVel).z / 256);
  r.x = p->x - (o->position).x;
  r.y = p->y - (o->position).y;
  r.z = p->z - (o->position).z;
  RCrossN.x = (r.y / 256) * (normal.z / 256) - (r.z / 256) * (normal.y / 256);
  RCrossN.y = (r.z / 256) * (normal.x / 256) - (r.x / 256) * (normal.z / 256);
  RCrossN.z = (r.x / 256) * (normal.y / 256) - (r.y / 256) * (normal.x / 256);
  temp1 = ((o->angularVel).x / 256) * (RCrossN.x / 256) +
          ((o->angularVel).y / 256) * (RCrossN.y / 256) +
          ((o->angularVel).z / 256) * (RCrossN.z / 256);
  temp2 = o->massInv / 4;
  {
    int frictionalImpulse;
    coorddef deltaVFromFriction;
    coorddef temp;
    int frictionalImpulseOverMoment;
    int deltaSpeedInFrictionDirection;

    {
      temp3 = temp2 + fixedmult(Math_VectorLength2(&RCrossN), o->moInertiaInv * 2) / 2;
      impulse = fixedmult(rdiv(-(temp0 + temp1), temp3), 0x6666);
      (o->collision).impulse = __builtin_abs(temp0) * 4;
      (o->collision).otherObj = (BO_tNewtonObj *)0;
      (o->collision).sfxType = o->driveSurfaceType | 0x30000;
      (o->collision).collisionPoint = *p;
      if (velocity.x != 0 || velocity.y != 0 || velocity.z != 0) {
        int scale;
        int lengthInverse;

        scale = (velocity.x / 256) * (normal.x / 256) +
                (velocity.y / 256) * (normal.y / 256) +
                (velocity.z / 256) * (normal.z / 256);
        velocity.x = velocity.x - (scale / 256) * (normal.x / 256);
        velocity.y = velocity.y - (scale / 256) * (normal.y / 256);
        velocity.z = velocity.z - (scale / 256) * (normal.z / 256);
        velocityLength = fixedsqrt((velocity.x / 256) * (velocity.x / 256) +
                                   (velocity.y / 256) * (velocity.y / 256) +
                                   (velocity.z / 256) * (velocity.z / 256));
        /* MATCH: fixedmult calls duplicated per-arm in retail source; gcc cross-jump-merges
           only the trailing .z call (oracle j to shared tail) */
        if (velocityLength / 2 != 0) {
          lengthInverse = -rdiv(0x8000, velocityLength / 2);
          velocity.x = fixedmult(lengthInverse, velocity.x);
          velocity.y = fixedmult(lengthInverse, velocity.y);
          velocity.z = fixedmult(lengthInverse, velocity.z);
        } else {
          velocity.x = fixedmult(-0x10000, velocity.x);
          velocity.y = fixedmult(-0x10000, velocity.y);
          velocity.z = fixedmult(-0x10000, velocity.z);
        }
      }
    }
    {
      if (__builtin_abs(o->speedXZ) <= 0x9FFFF) {
        coorddef upVec;
        int dotx;
        int doty;
        int dotz;

        upVec = D_80055A00;   /* {0, 0x10000, 0} */
        dotx = (upVec.x / 256) * ((o->orientMat).m[0] / 256) +
               (upVec.y / 256) * ((o->orientMat).m[1] / 256) +
               (upVec.z / 256) * ((o->orientMat).m[2] / 256);
        doty = (upVec.x / 256) * ((o->orientMat).m[3] / 256) +
               (upVec.y / 256) * ((o->orientMat).m[4] / 256) +
               (upVec.z / 256) * ((o->orientMat).m[5] / 256);
        dotz = (upVec.x / 256) * ((o->orientMat).m[6] / 256) +
               (upVec.y / 256) * ((o->orientMat).m[7] / 256) +
               (upVec.z / 256) * ((o->orientMat).m[8] / 256);
        if (0xF5C2 < __builtin_abs(dotx) || 0xF5C2 < __builtin_abs(dotz) || doty < -0xF5C2) {
          frictionLess = 1;
        }
      }
    }
    frictionalImpulse = fixedmult(frictionLess == 1 ? 0x28F : 0x8000, impulse);
    deltaVFromFriction.x = fixedmult(fixedmult(frictionalImpulse, o->massInv / 2), velocity.x);
    deltaVFromFriction.y = fixedmult(fixedmult(frictionalImpulse, o->massInv / 2), velocity.y);
    deltaVFromFriction.z = fixedmult(fixedmult(frictionalImpulse, o->massInv / 2), velocity.z);
    frictionLess = 0;
    frictionalImpulseOverMoment = fixedmult(frictionalImpulse, o->moInertiaInv * 2);
    /* temp = velocity x r, then temp = temp x r IN PLACE (sequential component update -
       temp.y reads the NEW temp.x, temp.z reads the NEW x,y; faithful to retail) */
    temp.x = (velocity.y / 256) * (r.z / 256) - (velocity.z / 256) * (r.y / 256);
    temp.y = (velocity.z / 256) * (r.x / 256) - (velocity.x / 256) * (r.z / 256);
    temp.z = (velocity.x / 256) * (r.y / 256) - (velocity.y / 256) * (r.x / 256);
    temp.x = (temp.y / 256) * (r.z / 256) - (temp.z / 256) * (r.y / 256);
    temp.y = (temp.z / 256) * (r.x / 256) - (temp.x / 256) * (r.z / 256);
    temp.z = (temp.x / 256) * (r.y / 256) - (temp.y / 256) * (r.x / 256);
    temp.x = fixedmult(frictionalImpulseOverMoment, temp.x);
    temp.y = fixedmult(frictionalImpulseOverMoment, temp.y);
    temp.z = fixedmult(frictionalImpulseOverMoment, temp.z);
    deltaVFromFriction.x += temp.x;
    deltaVFromFriction.y += temp.y;
    deltaVFromFriction.z += temp.z;
    deltaSpeedInFrictionDirection = (deltaVFromFriction.x / 256) * (velocity.x / 256) +
                                    (deltaVFromFriction.y / 256) * (velocity.y / 256) +
                                    (deltaVFromFriction.z / 256) * (velocity.z / 256);
    if (velocityLength < deltaSpeedInFrictionDirection) {
      frictionalImpulse = fixedmult(frictionalImpulse, rdiv(velocityLength, deltaSpeedInFrictionDirection));
    }
    velocity.x = fixedmult(frictionalImpulse, velocity.x);
    velocity.y = fixedmult(frictionalImpulse, velocity.y);
    velocity.z = fixedmult(frictionalImpulse, velocity.z);
  }
  if (0 < impulse) {
    impulseV.x = fixedmult(impulse, normal.x);
    impulseV.y = fixedmult(impulse, normal.y);
    impulseV.z = fixedmult(impulse, normal.z);
    impulseV.x += velocity.x;
    impulseV.y += velocity.y;
    impulseV.z += velocity.z;
    deltaV.x = fixedmult(o->massInv / 2, impulseV.x);
    deltaV.y = fixedmult(o->massInv / 2, impulseV.y);
    deltaV.z = fixedmult(o->massInv / 2, impulseV.z);
    (o->linearVel).x = (o->linearVel).x + deltaV.x;
    (o->linearVel).y = (o->linearVel).y + deltaV.y;
    (o->linearVel).z = (o->linearVel).z + deltaV.z;
    /* MATCH: deltaV = r x impulseV computed TWICE (duplicate statements in retail source;
       oracle carries both rounds ~30 insns - do NOT "simplify" the repeat away) */
    deltaV.x = (r.y / 256) * (impulseV.z / 256) - (r.z / 256) * (impulseV.y / 256);
    deltaV.y = (r.z / 256) * (impulseV.x / 256) - (r.x / 256) * (impulseV.z / 256);
    deltaV.z = (r.x / 256) * (impulseV.y / 256) - (r.y / 256) * (impulseV.x / 256);
    deltaV.x = (r.y / 256) * (impulseV.z / 256) - (r.z / 256) * (impulseV.y / 256);
    deltaV.y = (r.z / 256) * (impulseV.x / 256) - (r.x / 256) * (impulseV.z / 256);
    deltaV.z = (r.x / 256) * (impulseV.y / 256) - (r.y / 256) * (impulseV.x / 256);
    deltaV.x = fixedmult(o->moInertiaInv * 2, deltaV.x);
    deltaV.y = fixedmult(o->moInertiaInv * 2, deltaV.y);
    deltaV.z = fixedmult(o->moInertiaInv * 2, deltaV.z);
    (o->angularVel).x = (o->angularVel).x + deltaV.x;
    (o->angularVel).y = (o->angularVel).y + deltaV.y;
    (o->angularVel).z = (o->angularVel).z + deltaV.z;
  }
}

/* ---- Collide_LimitAngularVel__FP13BO_tNewtonObj  [@0x8008d8b4] ---- */
void Collide_LimitAngularVel(BO_tNewtonObj *o)



{
  if ((o->angularVel).x < 0)
    (o->angularVel).x =
        (o->angularVel).x > -0x18000 ? (o->angularVel).x : -0x18000;
  else
    (o->angularVel).x =
        (o->angularVel).x > 0x18000 ? 0x18000 : (o->angularVel).x;

  if ((o->angularVel).y < 0)
    (o->angularVel).y =
        (o->angularVel).y > -0x18000 ? (o->angularVel).y : -0x18000;
  else
    (o->angularVel).y =
        (o->angularVel).y > 0x18000 ? 0x18000 : (o->angularVel).y;

  if ((o->angularVel).z < 0)
    (o->angularVel).z =
        (o->angularVel).z > -0x18000 ? (o->angularVel).z : -0x18000;
  else
    (o->angularVel).z =
        (o->angularVel).z > 0x18000 ? 0x18000 : (o->angularVel).z;
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
  /* SYM-CODEGEN-CARRIER: relDotFull -- the retail SYM retains relativeDot in $v1
     but not this final sum. Reusing relativeDot keeps the instruction count at
     779 yet changes 250 allocated instructions; this separate result restores
     the byte-exact $a1 scratch web without inventing observable storage. */
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
    int zone;
    int impulse;

    zone = 9;
    /* MATCH: anonymous dot-sum web (s0) separate from impulse (s6) - the <<2 lands in impulse */
    impulse =
        ((0 < (fixedmult(normal->x,(o->linearVel).x) +
               fixedmult(normal->y,(o->linearVel).y) +
               fixedmult(normal->z,(o->linearVel).z)))
             ? (fixedmult(normal->x,(o->linearVel).x) +
                fixedmult(normal->y,(o->linearVel).y) +
                fixedmult(normal->z,(o->linearVel).z))
             : -(fixedmult(normal->x,(o->linearVel).x) +
                 fixedmult(normal->y,(o->linearVel).y) +
                 fixedmult(normal->z,(o->linearVel).z)))
        << 2;
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
          goto LAB_DAMAGE_ZONE;
        }
        else if (right < -0x1999) {
          zone = 2;
          goto LAB_DAMAGE_ZONE;
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
LAB_DAMAGE_ZONE:
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
  /* RULE-8 rewrite from SYM 8c block @0x8008e5d4 (fsize=184 mask=$c0ff0000 = ra+s2..s7) + m2c
     pregen + raw oracle, blocks in oracle VA order.  Note SYM: o0/normal are class ARG (stack-
     spilled params, §3.15), o1/p are REGPARM (kept live).  SYM fn-scope names applied verbatim:
       impulse,impulseWST,impulseV,R0CrossN,R1CrossN,Rt0,Rt1,numerator,deltaV,damageVector
     Block layout: @ec40 (o0 damage-zone check) nests {zone,impulse}@ecdc, same-VA-nested (no
     locals of its own) wraps {right,top,front}@ed2c inside the impulse>0xA0000 guard; mirrored
     @eef4..f15c for o1.  The source-order x,y,z negation schedules to retail's x,z,y instruction
     order.  The right/top/front 9-way damage-zone dispatch uses the structured IDA conditions;
     keeping the common zone<8 test after the dispatch reproduces the retail branch-delay layout.
     MATCH: R0/R1 moment-of-inertia terms use raw >>1 (NOT /2 — no div-guard, non-negative operands);
     massInv terms use plain /2 (real division, guard regenerates).  moInertiaInv*3/4 angular-scale
     branch is the plain-/256-idiom family at divisor 4 (if(x<0)x+=3;x>>=2 == x/4); write plain
     division duplicated per axis (x,y,z) so it recomputes across the fixedmult() call boundary
     instead of CSE'ing, matching the oracle's 3x recompute — do NOT hoist into a shared temp. */
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
  /* MATCH: zero-insn PARM-SPILL PIN.  It must sit BEFORE the first source
     statement (i.e. ahead of the object1 initializer): assign_parms' arg
     stores are emitted ahead of it, so `sw a3,196(sp)` (normal's ARG home)
     stays in the prologue group instead of being sunk 27 insns by sched2,
     and the un-coalesced parm copy `addu t0,a3,zero` reappears.  One
     statement LATER it also pins `addu fp,a1,zero`, which retail schedules
     into a load-delay slot (5 diffs).  2nd operand => 203 diffs (05C). */
  __asm__("" : : "i"(0));
  /* SYM-CODEGEN-CARRIER: object1 -- this alias is the measured source-level
     spelling that keeps retail's long-lived `o1` allocation in $fp. */
  BO_tNewtonObj *object1 = o1;
#define o1 object1


  Rt0.x = p->x - (o0->position).x;
  Rt0.y = p->y - (o0->position).y;
  Rt0.z = p->z - (o0->position).z;
  Rt1.x = p->x - (o1->position).x;
  Rt1.y = p->y - (o1->position).y;
  Rt1.z = p->z - (o1->position).z;
  R0CrossN.x = fixedmult(Rt0.y,normal->z) - fixedmult(Rt0.z,normal->y);
  R0CrossN.y = fixedmult(Rt0.z,normal->x) - fixedmult(Rt0.x,normal->z);
  R0CrossN.z = fixedmult(Rt0.x,normal->y) - fixedmult(Rt0.y,normal->x);
  R1CrossN.x = fixedmult(Rt1.y,normal->z) - fixedmult(Rt1.z,normal->y);
  R1CrossN.y = fixedmult(Rt1.z,normal->x) - fixedmult(Rt1.x,normal->z);
  R1CrossN.z = fixedmult(Rt1.x,normal->y) - fixedmult(Rt1.y,normal->x);
  numerator = -(fixedmult((o0->linearVel).x,normal->x) + fixedmult((o0->linearVel).y,normal->y) +
                fixedmult((o0->linearVel).z,normal->z)) +
              (fixedmult((o1->linearVel).x,normal->x) + fixedmult((o1->linearVel).y,normal->y) +
               fixedmult((o1->linearVel).z,normal->z)) -
              (fixedmult((o0->angularVel).x,R0CrossN.x) + fixedmult((o0->angularVel).y,R0CrossN.y) +
               fixedmult((o0->angularVel).z,R0CrossN.z)) +
              (fixedmult((o1->angularVel).x,R1CrossN.x) + fixedmult((o1->angularVel).y,R1CrossN.y) +
               fixedmult((o1->angularVel).z,R1CrossN.z));
  impulse = rdiv(numerator,
                  o0->massInv / 2 + o1->massInv / 2 +
                  (fixedmult(fixedmult(R0CrossN.x,R0CrossN.x) + fixedmult(R0CrossN.y,R0CrossN.y) +
                             fixedmult(R0CrossN.z,R0CrossN.z), o0->moInertiaInv) >> 1) +
                  (fixedmult(fixedmult(R1CrossN.x,R1CrossN.x) + fixedmult(R1CrossN.y,R1CrossN.y) +
                             fixedmult(R1CrossN.z,R1CrossN.z), o1->moInertiaInv) >> 1));
  if (impulse < 0) {
    return 0;
  }
  if (((o0[1].simRoadInfo.quadPts[1].y & 4) != 0) && ((o0->collision).collided == 0)) {
    (o0->collision).collided = 2;
  }
  if (((o1[1].simRoadInfo.quadPts[1].y & 4) != 0) && ((o1->collision).collided == 0)) {
    (o1->collision).collided = 2;
  }
  impulse = fixedmult(
      ((o0[1].simRoadInfo.quadPts[1].y & 4) != 0) &&
              ((o1[1].simRoadInfo.quadPts[1].y & 4) != 0)
          ? 0x4000
          : 0x3333,
      impulse);
  /* MATCH: zero-insn USE FENCE (sched-issue-position fixpoint).  Without it the
     `addu s6,v0,zero` that lands the scaled impulse sinks into the load-delay
     slot of the following `lw t0,196(sp)`; retail issues it straight after the
     jal's delay slot and nops the load shadow. */
  __asm__("" : : "i"(0));
  impulseV.x = fixedmult(impulse,normal->x);
  impulseV.y = fixedmult(impulse,normal->y);
  impulseV.z = fixedmult(impulse,normal->z);
  impulseWST = fixedmult((fixedmult((o0->linearVel).x,normal->x) + fixedmult((o0->linearVel).y,normal->y) +
                           fixedmult((o0->linearVel).z,normal->z)) -
                          (fixedmult((o1->linearVel).x,normal->x) + fixedmult((o1->linearVel).y,normal->y) +
                           fixedmult((o1->linearVel).z,normal->z)),
                          o0->mass + o1->mass);
  (o0->collision).impulse =
    0 < fixedmult(impulseWST,o0->massInv) ?
      fixedmult(impulseWST,o0->massInv) : -fixedmult(impulseWST,o0->massInv);
  (o1->collision).impulse =
    0 < fixedmult(impulseWST,o1->massInv) ?
      fixedmult(impulseWST,o1->massInv) : -fixedmult(impulseWST,o1->massInv);
  if (0x1ff < o0->objID || 0x1ff < o1->objID) {
    (o0->collision).impulse = (o0->collision).impulse / 3;
    (o1->collision).impulse = (o1->collision).impulse / 3;
  }
  deltaV.x = fixedmult(o0->massInv,impulseV.x);
  deltaV.y = fixedmult(o0->massInv,impulseV.y);
  deltaV.z = fixedmult(o0->massInv,impulseV.z);
  (o0->linearVel).x = (o0->linearVel).x + deltaV.x;
  (o0->linearVel).y = (o0->linearVel).y + deltaV.y;
  (o0->linearVel).z = (o0->linearVel).z + deltaV.z;
  (o0->collision).sfxType = 0x50001;
  (o0->collision).otherObj = o1;
  if (o0->objID < 0x200) {
    {
      int zone;
      int impulse;

      impulse = (o0->collision).impulse;
      damageVector.x = (o0->position).x - (o1->position).x;
      zone = 9;
      damageVector.y = (o0->position).y - (o1->position).y;
      damageVector.z = (o0->position).z - (o1->position).z;
      Math_NormalizeShortVector(&damageVector);
      if (0xA0000 < impulse) {
        int right;
        int top;
        int front;

        right = fixedmult(damageVector.x,(o0->orientMat).m[0]) + fixedmult(damageVector.y,(o0->orientMat).m[1]) +
                fixedmult(damageVector.z,(o0->orientMat).m[2]);
        top = fixedmult(damageVector.x,(o0->orientMat).m[3]) + fixedmult(damageVector.y,(o0->orientMat).m[4]) +
              fixedmult(damageVector.z,(o0->orientMat).m[5]);
        front = fixedmult(damageVector.x,(o0->orientMat).m[6]) + fixedmult(damageVector.y,(o0->orientMat).m[7]) +
                fixedmult(damageVector.z,(o0->orientMat).m[8]);
        if (top < -0x8000) {
          zone = 8;
          Newton_AddDamageZone(o0,impulse,8,2);
        }
        if (__builtin_abs(right) < 0x1999) {
          if (front < -0x1999) { zone = 1; goto o0_zdisp; }
          if (front >= 0x199A) { zone = 5; goto o0_zdisp; }
        }
        if (__builtin_abs(front) < 0x1999) {
          if (right >= 0x199A) { zone = 7; goto o0_zdisp; }
          if (right < -0x1999) { zone = 3; goto o0_zdisp; }
        }
        if (front < -0x1999) {
          if (right >= 0x199A) { zone = 0; goto o0_zdisp; }
          if (right < -0x1999) { zone = 2; goto o0_zdisp; }
        }
        if (front >= 0x199A) {
          if (right >= 0x199A) { zone = 6; goto o0_zdisp; }
          if (right < -0x1999) {
            zone = 4;
          }
        }
o0_zdisp:
        if (zone < 8) {
          Newton_AddDamageZone(o0,impulse,zone,2);
        }
      }
    }
  }
  deltaV.x = fixedmult(o1->massInv,impulseV.x);
  deltaV.y = fixedmult(o1->massInv,impulseV.y);
  deltaV.z = fixedmult(o1->massInv,impulseV.z);
  (o1->linearVel).x = (o1->linearVel).x - deltaV.x;
  (o1->linearVel).y = (o1->linearVel).y - deltaV.y;
  (o1->linearVel).z = (o1->linearVel).z - deltaV.z;
  (o1->collision).sfxType = 0x50001;
  (o1->collision).otherObj = o0;
  if (o1->objID < 0x200) {
    {
      int zone;
      int impulse;

      impulse = (o1->collision).impulse;
      damageVector.x = -damageVector.x;
      damageVector.y = -damageVector.y;
      damageVector.z = -damageVector.z;
      zone = 9;
      if (0xA0000 < impulse) {
        int right;
        int top;
        int front;

        right = fixedmult(damageVector.x,(o1->orientMat).m[0]) + fixedmult(damageVector.y,(o1->orientMat).m[1]) +
                fixedmult(damageVector.z,(o1->orientMat).m[2]);
        top = fixedmult(damageVector.x,(o1->orientMat).m[3]) + fixedmult(damageVector.y,(o1->orientMat).m[4]) +
              fixedmult(damageVector.z,(o1->orientMat).m[5]);
        front = fixedmult(damageVector.x,(o1->orientMat).m[6]) + fixedmult(damageVector.y,(o1->orientMat).m[7]) +
                fixedmult(damageVector.z,(o1->orientMat).m[8]);
        if (top < -0x8000) {
          zone = 8;
          Newton_AddDamageZone(o1,impulse,8,2);
        }
        if (__builtin_abs(right) < 0x1999) {
          if (front < -0x1999) { zone = 1; goto o1_zdisp; }
          if (front >= 0x199A) { zone = 5; goto o1_zdisp; }
        }
        if (__builtin_abs(front) < 0x1999) {
          if (right >= 0x199A) { zone = 7; goto o1_zdisp; }
          if (right < -0x1999) { zone = 3; goto o1_zdisp; }
        }
        if (front < -0x1999) {
          if (right >= 0x199A) { zone = 0; goto o1_zdisp; }
          if (right < -0x1999) { zone = 2; goto o1_zdisp; }
        }
        if (front >= 0x199A) {
          if (right >= 0x199A) { zone = 6; goto o1_zdisp; }
          if (right < -0x1999) {
            zone = 4;
          }
        }
o1_zdisp:
        if (zone < 8) {
          Newton_AddDamageZone(o1,impulse,zone,2);
        }
      }
    }
  }
  deltaV.x = fixedmult(Rt0.y,impulseV.z) - fixedmult(Rt0.z,impulseV.y);
  deltaV.y = fixedmult(Rt0.z,impulseV.x) - fixedmult(Rt0.x,impulseV.z);
  deltaV.z = fixedmult(Rt0.x,impulseV.y) - fixedmult(Rt0.y,impulseV.x);
  if (((o0[1].simRoadInfo.quadPts[1].y & 4) != 0) && (impulse <= 0x3FFFFF)) {
    deltaV.x = fixedmult((o0->moInertiaInv * 3) / 4,deltaV.x);
    deltaV.y = fixedmult((o0->moInertiaInv * 3) / 4,deltaV.y);
    deltaV.z = fixedmult((o0->moInertiaInv * 3) / 4,deltaV.z);
  } else {
    deltaV.x = fixedmult(o0->moInertiaInv,deltaV.x);
    deltaV.y = fixedmult(o0->moInertiaInv,deltaV.y);
    deltaV.z = fixedmult(o0->moInertiaInv,deltaV.z);
  }
  (o0->angularVel).x = (o0->angularVel).x + deltaV.x;
  (o0->angularVel).y = (o0->angularVel).y + deltaV.y;
  (o0->angularVel).z = (o0->angularVel).z + deltaV.z;
  deltaV.x = fixedmult(Rt1.y,impulseV.z) - fixedmult(Rt1.z,impulseV.y);
  deltaV.y = fixedmult(Rt1.z,impulseV.x) - fixedmult(Rt1.x,impulseV.z);
  deltaV.z = fixedmult(Rt1.x,impulseV.y) - fixedmult(Rt1.y,impulseV.x);
  if (((o1[1].simRoadInfo.quadPts[1].y & 4) != 0) && (impulse <= 0x3FFFFF)) {
    deltaV.x = fixedmult((o1->moInertiaInv * 3) / 4,deltaV.x);
    deltaV.y = fixedmult((o1->moInertiaInv * 3) / 4,deltaV.y);
    deltaV.z = fixedmult((o1->moInertiaInv * 3) / 4,deltaV.z);
  } else {
    deltaV.x = fixedmult(o1->moInertiaInv,deltaV.x);
    deltaV.y = fixedmult(o1->moInertiaInv,deltaV.y);
    deltaV.z = fixedmult(o1->moInertiaInv,deltaV.z);
  }
  (o1->angularVel).x = (o1->angularVel).x - deltaV.x;
  (o1->angularVel).y = (o1->angularVel).y - deltaV.y;
  (o1->angularVel).z = (o1->angularVel).z - deltaV.z;
  o0->flightTime = o0->flightTime + 1;
  o1->flightTime = o1->flightTime + 1;
  (o0->collision).collisionPoint.x = (o1->collision).collisionPoint.x = ((o0->position).x + (o1->position).x) / 2;
  (o0->collision).collisionPoint.y = (o1->collision).collisionPoint.y = ((o0->position).y + (o1->position).y) / 2;
  (o0->collision).collisionPoint.z = (o1->collision).collisionPoint.z = ((o0->position).z + (o1->position).z) / 2;
#undef o1
  return 1;
}

/* ---- Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2  [@0x8008f550] ---- */
int Collide_DoActualObjectCollisionCheck(BO_tNewtonObj *o0,BO_tNewtonObj *o1,coorddef *p,coorddef *normal)



{
  /* MATCH (2026-08-13): SYM/SLD + raw 0x8008F550..0x80090140 require two symmetric
     halves and three physical shared tails: high-velocity normal X/Y/Z, low-velocity
     negation, and return-one.  SYM-CODEGEN-CARRIER: selectedRange; reconstructing those
     funnels plus this shared-tail carrier removed
     the duplicated arm tests (101 -> 88 -> 20 -> 16 authoritative diffs).  The empty
     normal fences price p83 refs to 38, yielding retail o0/o1/normal = s1/s2/s0.
     A zero-insn boundary after each dotz expression preserves the two retail branch-delay
     nops (16 -> 14, 763/765).  The remaining source build is exactly two symmetric sched1
     clusters; moving the existing dotx/doty normalization blocks and comparison ahead of
     mflo, plus restoring dotz's nop slot, produces PASS 765/765 in the isolated scratch
     build without changing source instructions or registers. CheckMe/CheckAccurate/Clear
     retain their prior results. */
  obj0 = o0;
  obj1 = o1;
  pP = p;
  pNormal = normal;
  if (CHECK_CENTER_VERTEX_WITH_DIRS(1,0,0) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS(0,1,0) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS(0,0,1) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS(-1,0,0) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS(0,-1,0) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS(0,0,-1) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(1,0,0) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(0,1,0) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(0,0,1) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(-1,0,0) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(0,-1,0) != 0) {
    return 1;
  }
  if (CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(0,0,-1) != 0) {
    return 1;
  }
  /* Oracle dispatch in VA ORDER: each VERTEX!=0 -> vhalf (o0 matrix, .L8008F7EC,
     physically FIRST); each OTHER!=0 -> ohalf (o1 matrix, .L8008FC50); both all-zero
     -> return 0. goto = the genuine per-operand bnez-to-forward-block dispatch. */
  if (CHECK_VERTEX_WITH_DIRS(1,1,1) != 0) goto vhalf;
  if (CHECK_VERTEX_WITH_DIRS(1,1,-1) != 0) goto vhalf;
  if (CHECK_VERTEX_WITH_DIRS(1,-1,1) != 0) goto vhalf;
  if (CHECK_VERTEX_WITH_DIRS(1,-1,-1) != 0) goto vhalf;
  if (CHECK_VERTEX_WITH_DIRS(-1,1,1) != 0) goto vhalf;
  if (CHECK_VERTEX_WITH_DIRS(-1,1,-1) != 0) goto vhalf;
  if (CHECK_VERTEX_WITH_DIRS(-1,-1,1) != 0) goto vhalf;
  if (CHECK_VERTEX_WITH_DIRS(-1,-1,-1) != 0) goto vhalf;
  if (CHECK_VERTEX_WITH_DIRS_OTHER(1,1,1) != 0) goto ohalf;
  if (CHECK_VERTEX_WITH_DIRS_OTHER(1,1,-1) != 0) goto ohalf;
  if (CHECK_VERTEX_WITH_DIRS_OTHER(1,-1,1) != 0) goto ohalf;
  if (CHECK_VERTEX_WITH_DIRS_OTHER(1,-1,-1) != 0) goto ohalf;
  if (CHECK_VERTEX_WITH_DIRS_OTHER(-1,1,1) != 0) goto ohalf;
  if (CHECK_VERTEX_WITH_DIRS_OTHER(-1,1,-1) != 0) goto ohalf;
  if (CHECK_VERTEX_WITH_DIRS_OTHER(-1,-1,1) != 0) goto ohalf;
  if (CHECK_VERTEX_WITH_DIRS_OTHER(-1,-1,-1) != 0) goto ohalf;
  return 0;
vhalf:   /* VERTEX!=0 : o0 orientMat, if(0<xRange) negation */
  {
    {
      int maxv;
      int vx;
      int vy;
      int vz;

      findClosestSideDave = 0;
      vx = (o1->linearVel).x - (o0->linearVel).x;
      if (vx <= 0) {
        vx = (o0->linearVel).x - (o1->linearVel).x;
      }
      vy = (o1->linearVel).y - (o0->linearVel).y;
      if (vy <= 0) {
        vy = (o0->linearVel).y - (o1->linearVel).y;
      }
      vz = (o1->linearVel).z - (o0->linearVel).z;
      if (vz <= 0) {
        vz = (o0->linearVel).z - (o1->linearVel).z;
      }
      maxv = vx;
      if (maxv < vy) {
        maxv = vy;
      }
      if (maxv < vz) {
        maxv = vz;
      }
      if (0xF0000 < maxv) {
        findClosestSideDave = 1;
      }
    }
    {
      if (findClosestSideDave != 0) {
        coorddef normalx;
        coorddef normaly;
        coorddef normalz;
        int dotx;
        int doty;
        int dotz;
        coorddef vel;

        vel = o1->linearVel;
        normalx = *(coorddef *)&(o0->orientMat).m[0];
        normaly = *(coorddef *)&(o0->orientMat).m[3];
        normalz = *(coorddef *)&(o0->orientMat).m[6];
        if (0 < xRange) {
          normalx.x = -normalx.x;
          normalx.y = -normalx.y;
          normalx.z = -normalx.z;
        }
        if (0 < yRange) {
          normaly.x = -normaly.x;
          normaly.y = -normaly.y;
          normaly.z = -normaly.z;
        }
        if (0 < zRange) {
          normalz.x = -normalz.x;
          normalz.y = -normalz.y;
          normalz.z = -normalz.z;
        }
        dotx = normalx.x / 256 * (vel.x / 256) + normalx.y / 256 * (vel.y / 256) +
               normalx.z / 256 * (vel.z / 256);
        doty = normaly.x / 256 * (vel.x / 256) + normaly.y / 256 * (vel.y / 256) +
               normaly.z / 256 * (vel.z / 256);
        dotz = normalz.x / 256 * (vel.x / 256) + normalz.y / 256 * (vel.y / 256) +
               normalz.z / 256 * (vel.z / 256);
        /* SEALED W72-A10 (2026-08-22): 14 diffs @763/765 -> PASS 765/765.  TWO edits,
           both applied at BOTH sites (this one and the `zRange < 0` twin below):
             (1) `x = __builtin_abs(x)` for the dotx/doty/dotz triple instead of
                 `if (x < 0) x = -x;`   ** THE LAW **
             (2) delete the bare `__asm__("")` that used to sit after the dotz
                 statement.
           WHY (mips.md `abssi2`, gcc-2.8.1 config/mips/mips.md:1800-1822): abssi2 is a
           SINGLE define_insn whose template emits the whole `bgez %1,1f%#\n\tsubu
           %0,$0,%0\n1:` sequence (dst==src arm; `%#` = the delay-slot nop, and the
           pattern bumps dslots_jump_total/filled itself, length 3).  So the retail abs
           chain is NOT three basic blocks -- it is three ordinary insns.  The whole
           region `mult / abs / abs / slt / mflo / addu / abs` therefore lives in ONE
           basic block, and gcc's per-BB scheduler is free to sink dotz's `mflo`+`addu`
           past the two abs insns and hoist the `slt $v0,$a1,$a3` above them -- exactly
           retail's order -- and the two "missing" nops are the abssi2 templates' own
           `%#`, not reorg slots.  Written as `if (x<0) x=-x;` the abs is a real branch
           + BB, sched2 cannot cross it, the mflo stays welded to its mult, and reorg
           then steals the `slt` into the abs(dotz) branch's slot (= the old 2-insn
           deficit + the 14-diff residual).  The bare `__asm__("")` was a volatile
           scheduling BARRIER pinning `mflo` next to `mult`; with the abs insns in place
           it was the last thing blocking the sink.  (SLD confirms retail's statement
           order is ours: 863 = dotz, 864/865/866 = the three abs, 868 = the compare;
           insns 366-368 carry lines 868/863/863 out of order = pure scheduling.)
           MEASURED ON THE WAY (real gate runs, both sites unless noted):
             baseline (if-form abs + bare fence) ................ 14 @763/765
             + head-of-thread void fence `("" : : "i"(0))` before
               the `doty<dotx` compare ......................... 20 @765/765
               (zero-insn, restores BOTH nops by blocking reorg's
                eager steal -- proves the deficit was slot theft)
             + zprod split (3rd term in its own local) ......... 220 @765/765
             + third term recomputed after the abs blocks ....... 88 @769/765
             __builtin_abs, bare fence KEPT .................... 20 @765/765
             __builtin_abs, bare fence REMOVED ................. PASS 765/765
           W64-A15's "absfirst" basin (44 @765) was the same insight seen from the
           wrong side: hoisting the abs STATEMENTS restored the length by accident;
           making the abs an INSN restores it by construction. */
        dotx = __builtin_abs(dotx);
        doty = __builtin_abs(doty);
        dotz = __builtin_abs(dotz);
        if (doty < dotx && dotz < dotx) {
          goto useNormalX;
        }
        if (dotz < doty) {
          goto useNormalY;
        }
        goto useNormalZ;
      }
      {
        int xDiff;
        int yDiff;
        int zDiff;
        int selectedRange;

        if (xRange < 0) {
          xDiff = (o0->dimension).x + xRange;
        }
        else {
          xDiff = (o0->dimension).x - xRange;
        }
        if (yRange < 0) {
          yDiff = (o0->dimension).y + yRange;
        }
        else {
          yDiff = (o0->dimension).y - yRange;
        }
        if (zRange < 0) {
          zDiff = (o0->dimension).z + zRange;
        }
        else {
          zDiff = (o0->dimension).z - zRange;
        }
        if (xDiff < yDiff && xDiff < zDiff) {
          *normal = *(coorddef *)&(o0->orientMat).m[0];
          selectedRange = xRange;
        }
        else if (yDiff < zDiff) {
          *normal = *(coorddef *)&(o0->orientMat).m[3];
          selectedRange = yRange;
        }
        else {
          *normal = *(coorddef *)&(o0->orientMat).m[6];
          selectedRange = zRange;
        }
        if (selectedRange <= 0) {
          goto returnOne;
        }
        goto negateNormal;
ohalf:   /* OTHER!=0 : o1 orientMat, if(xRange<0) negation */
  {
    {
      int maxv;
      int vx;
      int vy;
      int vz;

      findClosestSideDave = 0;
      vx = (o1->linearVel).x - (o0->linearVel).x;
      if (vx <= 0) {
        vx = (o0->linearVel).x - (o1->linearVel).x;
      }
      vy = (o1->linearVel).y - (o0->linearVel).y;
      if (vy <= 0) {
        vy = (o0->linearVel).y - (o1->linearVel).y;
      }
      vz = (o1->linearVel).z - (o0->linearVel).z;
      if (vz <= 0) {
        vz = (o0->linearVel).z - (o1->linearVel).z;
      }
      maxv = vx;
      if (maxv < vy) {
        maxv = vy;
      }
      if (maxv < vz) {
        maxv = vz;
      }
      if (0xF0000 < maxv) {
        findClosestSideDave = 1;
      }
    }
    {
      if (findClosestSideDave != 0) {
        coorddef normalx;
        coorddef normaly;
        coorddef normalz;
        int dotx;
        int doty;
        int dotz;
        coorddef vel;

        vel = o0->linearVel;
        normalx = *(coorddef *)&(o1->orientMat).m[0];
        normaly = *(coorddef *)&(o1->orientMat).m[3];
        normalz = *(coorddef *)&(o1->orientMat).m[6];
        if (xRange < 0) {
          normalx.x = -normalx.x;
          normalx.y = -normalx.y;
          normalx.z = -normalx.z;
        }
        if (yRange < 0) {
          normaly.x = -normaly.x;
          normaly.y = -normaly.y;
          normaly.z = -normaly.z;
        }
        if (zRange < 0) {
          normalz.x = -normalz.x;
          normalz.y = -normalz.y;
          normalz.z = -normalz.z;
        }
        dotx = normalx.x / 256 * (vel.x / 256) + normalx.y / 256 * (vel.y / 256) +
               normalx.z / 256 * (vel.z / 256);
        doty = normaly.x / 256 * (vel.x / 256) + normaly.y / 256 * (vel.y / 256) +
               normaly.z / 256 * (vel.z / 256);
        dotz = normalz.x / 256 * (vel.x / 256) + normalz.y / 256 * (vel.y / 256) +
               normalz.z / 256 * (vel.z / 256);
        dotx = __builtin_abs(dotx);
        doty = __builtin_abs(doty);
        dotz = __builtin_abs(dotz);
        if (doty < dotx && dotz < dotx) {
useNormalX:
          *normal = normalx;
          return 1;
        }
        if (dotz < doty) {
useNormalY:
          *normal = normaly;
          return 1;
        }
useNormalZ:
        *normal = normalz;
        return 1;
      }
      {
        int xDiff;
        int yDiff;
        int zDiff;
        int selectedRange;

        if (xRange < 0) {
          xDiff = (o1->dimension).x + xRange;
        }
        else {
          xDiff = (o1->dimension).x - xRange;
        }
        if (yRange < 0) {
          yDiff = (o1->dimension).y + yRange;
        }
        else {
          yDiff = (o1->dimension).y - yRange;
        }
        if (zRange < 0) {
          zDiff = (o1->dimension).z + zRange;
        }
        else {
          zDiff = (o1->dimension).z - zRange;
        }
        if (xDiff < yDiff && xDiff < zDiff) {
          *normal = *(coorddef *)&(o1->orientMat).m[0];
          selectedRange = xRange;
        }
        else if (yDiff < zDiff) {
          *normal = *(coorddef *)&(o1->orientMat).m[3];
          selectedRange = yRange;
        }
        else {
          *normal = *(coorddef *)&(o1->orientMat).m[6];
          selectedRange = zRange;
        }
        if (0 <= selectedRange) {
          goto returnOne;
        }
negateNormal:
        normal->x = -normal->x;
        normal->y = -normal->y;
        normal->z = -normal->z;
        __asm__("" : : "r"(normal), "r"(normal), "r"(normal), "r"(normal), "r"(normal),
                     "r"(normal), "r"(normal), "r"(normal), "r"(normal), "r"(normal));
        __asm__("" : : "r"(normal), "r"(normal), "r"(normal), "r"(normal), "r"(normal),
                     "r"(normal), "r"(normal), "r"(normal), "r"(normal), "r"(normal));
        __asm__("" : : "r"(normal));
returnOne:
        return 1;
      }
    }
  }
        return 1;
      }
    }
  }
}

/* ---- Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2  [@0x80090144] ---- */
int Collide_TestObjectVertices(BO_tNewtonObj *o0,BO_tNewtonObj *o1,coorddef *p,coorddef *normal)
{
  /* RULE-8 rewrite from SYM 8c block @0x80090144 (fsize=176 mask=$c0ff0000 = ra+fp+s0..s7) +
     m2c pregen + raw oracle.  SYM facts wired in: numbackoffsteps is a REAL REG local ($fp)
     holding 0x20 (Ghidra folded it to a literal); collisionHappened and useVelocity share $16
     (useVelocity=1 doubles as the collision flag path); `temp` redeclared in TWO sibling blocks
     (fresh pseudo each); relativeUnit/maxrv/maxrp/inverseRelativeVelocityLength live in the
     line-94 block.  Loop = top-test label-goto (TEST: if(cond){...goto TEST;}), exit both by
     count and by DoActual()==0 (return staged in the beqz delay).  Inline signed /256 idiom
     house style throughout. */
  int collisionHappened;
  int ctr;
  int numbackoffsteps;
  coorddef backoff0;
  coorddef backoff1;

  collisionHappened = 0;
  basisDots[0] = ((o0->orientMat).m[0] / 256) * ((o1->orientMat).m[0] / 256) +
                 ((o0->orientMat).m[1] / 256) * ((o1->orientMat).m[1] / 256) +
                 ((o0->orientMat).m[2] / 256) * ((o1->orientMat).m[2] / 256);
  basisDots[1] = ((o0->orientMat).m[0] / 256) * ((o1->orientMat).m[3] / 256) +
                 ((o0->orientMat).m[1] / 256) * ((o1->orientMat).m[4] / 256) +
                 ((o0->orientMat).m[2] / 256) * ((o1->orientMat).m[5] / 256);
  basisDots[2] = ((o0->orientMat).m[0] / 256) * ((o1->orientMat).m[6] / 256) +
                 ((o0->orientMat).m[1] / 256) * ((o1->orientMat).m[7] / 256) +
                 ((o0->orientMat).m[2] / 256) * ((o1->orientMat).m[8] / 256);
  basisDots[3] = ((o0->orientMat).m[3] / 256) * ((o1->orientMat).m[0] / 256) +
                 ((o0->orientMat).m[4] / 256) * ((o1->orientMat).m[1] / 256) +
                 ((o0->orientMat).m[5] / 256) * ((o1->orientMat).m[2] / 256);
  basisDots[4] = ((o0->orientMat).m[3] / 256) * ((o1->orientMat).m[3] / 256) +
                 ((o0->orientMat).m[4] / 256) * ((o1->orientMat).m[4] / 256) +
                 ((o0->orientMat).m[5] / 256) * ((o1->orientMat).m[5] / 256);
  basisDots[5] = ((o0->orientMat).m[3] / 256) * ((o1->orientMat).m[6] / 256) +
                 ((o0->orientMat).m[4] / 256) * ((o1->orientMat).m[7] / 256) +
                 ((o0->orientMat).m[5] / 256) * ((o1->orientMat).m[8] / 256);
  basisDots[6] = ((o0->orientMat).m[6] / 256) * ((o1->orientMat).m[0] / 256) +
                 ((o0->orientMat).m[7] / 256) * ((o1->orientMat).m[1] / 256) +
                 ((o0->orientMat).m[8] / 256) * ((o1->orientMat).m[2] / 256);
  basisDots[7] = ((o0->orientMat).m[6] / 256) * ((o1->orientMat).m[3] / 256) +
                 ((o0->orientMat).m[7] / 256) * ((o1->orientMat).m[4] / 256) +
                 ((o0->orientMat).m[8] / 256) * ((o1->orientMat).m[5] / 256);
  basisDots[8] = ((o0->orientMat).m[6] / 256) * ((o1->orientMat).m[6] / 256) +
                 ((o0->orientMat).m[7] / 256) * ((o1->orientMat).m[7] / 256) +
                 ((o0->orientMat).m[8] / 256) * ((o1->orientMat).m[8] / 256);
  scaledBasisDots[0] = (basisDots[0] / 256) * ((o1->dimension).x / 256);
  scaledBasisDots[1] = (basisDots[1] / 256) * ((o1->dimension).y / 256);
  scaledBasisDots[2] = (basisDots[2] / 256) * ((o1->dimension).z / 256);
  scaledBasisDots[3] = (basisDots[3] / 256) * ((o1->dimension).x / 256);
  scaledBasisDots[4] = (basisDots[4] / 256) * ((o1->dimension).y / 256);
  scaledBasisDots[5] = (basisDots[5] / 256) * ((o1->dimension).z / 256);
  scaledBasisDots[6] = (basisDots[6] / 256) * ((o1->dimension).x / 256);
  scaledBasisDots[7] = (basisDots[7] / 256) * ((o1->dimension).y / 256);
  scaledBasisDots[8] = (basisDots[8] / 256) * ((o1->dimension).z / 256);
  scaledBasisDotsOther[0] = (basisDots[0] / 256) * ((o0->dimension).x / 256);
  scaledBasisDotsOther[1] = (basisDots[1] / 256) * ((o0->dimension).x / 256);
  scaledBasisDotsOther[2] = (basisDots[2] / 256) * ((o0->dimension).x / 256);
  scaledBasisDotsOther[3] = (basisDots[3] / 256) * ((o0->dimension).y / 256);
  scaledBasisDotsOther[4] = (basisDots[4] / 256) * ((o0->dimension).y / 256);
  scaledBasisDotsOther[5] = (basisDots[5] / 256) * ((o0->dimension).y / 256);
  scaledBasisDotsOther[6] = (basisDots[6] / 256) * ((o0->dimension).z / 256);
  scaledBasisDotsOther[7] = (basisDots[7] / 256) * ((o0->dimension).z / 256);
  scaledBasisDotsOther[8] = (basisDots[8] / 256) * ((o0->dimension).z / 256);
  numbackoffsteps = 0x20;
  ctr = 0;
  /* MATCH: real while + exit-in-the-middle (NOT a goto-TEST loop) - gcc loop notes enable the
     LIM hoists the oracle has (&basisDotRelative -> s4/s6, &relativeVelocity spill to sp+0x80);
     a goto-formed loop skips loop.c entirely and re-materializes per-iteration */
  while (true) {
    if (numbackoffsteps <= ctr) break;
    {
      coorddef relativePosition;

      relativePosition.x = (o1->position).x - (o0->position).x;
      relativePosition.y = (o1->position).y - (o0->position).y;
      relativePosition.z = (o1->position).z - (o0->position).z;
      basisDotRelative[0] = ((o0->orientMat).m[0] / 256) * (relativePosition.x / 256) +
                            ((o0->orientMat).m[1] / 256) * (relativePosition.y / 256) +
                            ((o0->orientMat).m[2] / 256) * (relativePosition.z / 256);
      basisDotRelative[1] = ((o0->orientMat).m[3] / 256) * (relativePosition.x / 256) +
                            ((o0->orientMat).m[4] / 256) * (relativePosition.y / 256) +
                            ((o0->orientMat).m[5] / 256) * (relativePosition.z / 256);
      basisDotRelative[2] = ((o0->orientMat).m[6] / 256) * (relativePosition.x / 256) +
                            ((o0->orientMat).m[7] / 256) * (relativePosition.y / 256) +
                            ((o0->orientMat).m[8] / 256) * (relativePosition.z / 256);
      basisDotRelative[3] = ((o1->orientMat).m[0] / 256) * (relativePosition.x / 256) +
                            ((o1->orientMat).m[1] / 256) * (relativePosition.y / 256) +
                            ((o1->orientMat).m[2] / 256) * (relativePosition.z / 256);
      basisDotRelative[4] = ((o1->orientMat).m[3] / 256) * (relativePosition.x / 256) +
                            ((o1->orientMat).m[4] / 256) * (relativePosition.y / 256) +
                            ((o1->orientMat).m[5] / 256) * (relativePosition.z / 256);
      basisDotRelative[5] = ((o1->orientMat).m[6] / 256) * (relativePosition.x / 256) +
                            ((o1->orientMat).m[7] / 256) * (relativePosition.y / 256) +
                            ((o1->orientMat).m[8] / 256) * (relativePosition.z / 256);
      if (Collide_DoActualObjectCollisionCheck(o0,o1,p,normal) == 0) break;
      if (collisionHappened == 0) {
          coorddef relativeVelocity;
          int useVelocity;
          coorddef relativeUnit;
          int maxrv;
          int maxrp;
          int inverseRelativeVelocityLength;

          useVelocity = 0;
          relativeVelocity.x = (o0->linearVel).x - (o1->linearVel).x;
          inverseRelativeVelocityLength = 0;
          relativeVelocity.y = (o0->linearVel).y - (o1->linearVel).y;
          relativeVelocity.z = (o0->linearVel).z - (o1->linearVel).z;
          maxrv = (relativeVelocity.x / 256) * (relativeVelocity.x / 256) +
                  (relativeVelocity.z / 256) * (relativeVelocity.z / 256);
          if (0x0E100000 < maxrv) {
            /* MATCH INVESTIGATION (2026-08-13): SLD puts both component loads on
               line 1149 and the divide/square copies on 1151.  Keeping rp.x alive
               after its divide reaches the exact 1164-instruction basin (15 -> 8).
               The residual is retail's `lw a0,48; lw a2,56; addu v0,a0` versus our
               `lw v0,48; ... lw s7,48; lw v1,56`.  Reusing dead maxrv as the Z
               accumulator explains the retail v0/v1 names but gates 28/49 depending
               accumulation order; inline identity and early-clobber variants also
               regress.  The remaining angle is the line-1149 load-temporary graph.
               W61-A13 (2026-08-15) SHARPENED + 10 MORE FALSIFICATIONS.  Retail's
               shape is exactly 2 LOADS + 2 COPIES (rp.x -> $a0, rp.z -> $a2 loaded
               ADJACENTLY so the second fills the first's load-delay slot, then
               `addu $v0,$a0` / `addu $v1,$a2` feed the two /256 idioms).  Ours is
               3 LOADS + 1 nop + 0 copies (same count, hence 1164/1164 both ways).
               So the missing device is "hold BOTH components live in their own
               pseudos across the divides", not a spelling of the accumulation.
               FALSIFIED, each a real gate run:
                 plain symmetric expression (no split, no fence) ......... 15 @1163
                 two block-local temps rpx/rpz (decl-init) ............... 22 @1162
                 same, comma decl + separate assignment .................. 22 @1162
                 rpz temp only .......................................... 22 @1162
                 rpx temp only .......................................... 15 @1163
                 plain + read-only fence on rp.z before the statement .... 16 @1164
                 split + fence on rp.z instead of rp.x ................... 8 @1164 (ties base)
                 split + fence on rp.z placed before the whole block ..... 16 @1164
                 split + 2-operand fence "r"(rp.x),"r"(rp.z) ............. 9 @1165
                 split + fence moved between the load and the /256 ....... 15 @1163
               Every named-temp form is 2 insns SHORT: cse merges the temp with the
               divide's working pseudo, deleting BOTH copies.  The copies survive in
               retail because each source pseudo is still live at the copy point.
               NEXT ANGLE (instrument, not spelling): -dl on this TU to see whether
               our RTL even contains the two copies before local-alloc (the W59-11A
               CalcWheelLockAcc lesson -- if cse folds them at expand, no source
               spelling downstream can matter and the cure is an opacity fence on the
               SOURCE, hoisted above every load it must not block).

               W71-A20 (2026-08-21) -- THE NEXT ANGLE WAS RIGHT AND IT WORKS: the
               PAIR read-only fence placed BEFORE the whole statement,
                   asm volatile("" : : "r"(relativePosition.x), "r"(relativePosition.z));
                   maxrp = relativePosition.x;  maxrp /= 256;
                   maxrp = maxrp*maxrp + (relativePosition.z/256)*(relativePosition.z/256);
               reproduces retail's EXACT 10-instruction shape for the first time --
               `lw ?,48; lw ?,56; addu v0,?,zero; bgez v0; addu ?,v0,zero;
                addiu ?,v0,255; sra v0,?,8; mult v0,v0; <z>; mflo a1` -- the two
               ADJACENT loads (no load-delay nop), the x copy, and the divide-in-place
               all land.  The anonymous asm read IS the missing first evaluation: cse
               then turns `maxrp = relativePosition.x` into retail's `addu v0,a0,zero`
               instead of a second load.  It gates 16 @1164 (NOT landed -- honest-count
               rule, control is 8), and the whole residual is now only SEATS plus one
               z re-load:
                   ours  lw s7,48 / lw t8,56 / addu v0,s7 / addu a0,v0 / sra v0,a0
                                                                 / lw v1,56(sp)
                   retail lw a0,48 / lw a2,56 / addu v0,a0 / addu v1,v0 / sra v0,v1
                                                                 / addu v1,a2,zero
               i.e. our two fenced pseudos are seated in CALLEE-SAVED s7/t8 where
               retail uses caller-saved a0/a2, the divide temp is a0-vs-v1, and the
               z value is RE-LOADED because the z use sits in a different extended BB
               (past the bgez) so cse has lost the mem<->pseudo equivalence -- retail's
               `addu v1,a2,zero` is a live-pseudo copy, not a cse substitution.
               FALSIFIED from that basin (all real gate runs): reusing dead `maxrv`
               as the z carrier -- before the x read 51 @1165 | after the x divide
               51 @1165 | with the square split out 18 @1164 | inline `maxrv =
               relativePosition.z / 256` 55 @1165; the same maxrv-carrier forms with
               NO fence 49/50/28; identity-launder (`"=r"(x) : "0"(x)`) on named
               rpx/rpz copies 22-23 @1162-1163 (the copies fold, 2 SHORT); a single
               2-operand identity launder 22 @1162; block-local rpx/rpz + the
               divide-in-place split 45-49; plain symmetric expression 15 @1163;
               plain + void fence either side 15 @1163; the pair fence AFTER the
               divide 9 @1165.
               NEXT: from the PAIR-FENCE basin the problem is now purely
               find_free_reg availability (catalog 16B) -- price the s7/t8-vs-a0/a2
               seats with -dl/allocsim and try the 20B preference-killer
               (`__asm__("" : "=r"(x) : "0"(x) : "$N")`) on each fenced pseudo, which
               is exactly the device that sealed Physics_Real this wave.  The z
               re-load needs a live pseudo across the bgez, i.e. the SAME launder in
               its output-bearing (non-volatile) form so the value survives the BB
               boundary.  NOT a floor.

               W72-A10 (2026-08-22) -- THE MECHANISM IS NAMED AND THE Z HALF LANDS.
               gcc-2.8.1 `local-alloc.c` combine_regs (:1866 header comment, verbatim):
               "If UREG is a pseudo-register that hasn't already been assigned a
                quantity number, it means that it is NOT LOCAL TO THIS BLOCK or dies
                more than once.  In either event, we can't do anything with it."
               => a reg-reg copy whose SOURCE pseudo crosses a basic-block boundary is
               NOT coalescible, so it SURVIVES.  Retail's two copies (`addu $v0,$a0`
               and `addu $v1,$a2`) are exactly that: two carriers loaded at SLD line
               1149 and copied into their consumers at 1151, uncoalescible because they
               cross the /256 branches.  Our carriers die inside one block => the copies
               fold => the chronic "2 SHORT" (1162).
               BEST BASIN FOUND (not landed, honest-count 8 stands):
                 K1  int rpx = relativePosition.x, rpz = relativePosition.z;
                     maxrp = rpx;  maxrp /= 256;
                     maxrv = rpz;                      <- DEAD maxrv as the z carrier
                     maxrp = maxrp*maxrp + (maxrv/256)*(maxrv/256);
                 => 9 diffs @1163.  The Z COPY MINTS (`addu $v1,$a0,$zero`, retail
                 `addu $v1,$a2,$zero`) and the whole z divide matches, because `maxrv`
                 is a GLOBAL allocno (live since SLD 1145) whose assignment sits in a
                 different block from rpz's load.  SYM agrees: maxrv = REG $3 = $v1 IS
                 retail's z-copy destination.  The single remaining insn is the X copy
                 `addu $v0,$a0,$zero`: `maxrp = rpx` has def and use in the SAME block,
                 so combine_regs ties them and the load lands straight in $v0.
               PROOF OF THE MECHANISM (probe, not a candidate): hoisting the rpx/rpz
               declaration ABOVE `if (0x0E100000 < maxrv)` makes both carriers cross the
               guard branch -- BOTH copies mint (`addu $v0,$v1,$zero` appears) -- but the
               loads then emit before the beqz: 15 @1163.
               MEASURED THIS WAVE (all real gate runs, all at both-copy granularity):
                 S1 two block-local temps + maxrp=rpx ........... 14 @1162
                 S2 temps assigned on one line .................. 14 @1162
                 S3 temps + plain symmetric expression .......... 22 @1162
                 S4 temps + anonymous re-reads of BOTH .......... 15 @1163 (temps DCE'd)
                 E1 identity launder on rpx ..................... 15 @1163
                 E4 read-only fences on BOTH after the statement . 15 @1163
                    (x copy MINTS; load seats swap a2/a0; z copy lost)
                 G1-G3 `*(volatile int*)&relativePosition.[xz]` .. 14 @1162
                    => the fold is NOT combine merging the load into the copy
                 F1-F6 launder-mid / split sum / z-divide-in-place  14-50
                 H1-H6 decl order, separate decl lines, 3rd temp,
                       read-only fence placements ............... 14-45
                 K3 maxrv assigned before maxrp ................. 14 @1162
                 K5/K6 separate z temp divided in place ......... 44-45
                 L1-L6 x-side devices on top of K1 .............. 9-11
               ROUTE (sharp): a shape in which the X carrier's single use lies in a
               DIFFERENT basic block from its load, without moving the loads out of the
               `if`.  No asm device can do it -- an asm does not split a basic block.

               W74-A10 (2026-08-22) -- SEALED, 0 @1164.  The W72 route was right and its
               closing premise was the only thing wrong: an asm indeed cannot split a
               basic block, but it does not have to -- THE /256 IDIOM ALREADY DID.
               `maxrp /= 256` expands to `bgez; addiu; L: sra`, so every statement after
               the divide already lives in a different basic block from the carrier's
               load.  A zero-insn read-only fence placed there,
                   asm volatile("" : : "r"(rpx));
               gives the X carrier a second reference in a second block => flow marks it
               non-local => local-alloc.c:472 leaves reg_qty[rpx] = -1 => combine_regs
               (:1866 "not local to this block or dies more than once") REFUSES the tie
               => retail's X copy `addu $v0,$a0,$zero` MINTS, with the load still inside
               the `if` (no +15 hoist shape).  Combined with the K1 dead-`maxrv` Z carrier
               (uncoalescible through the other clause of the same test, being a global
               allocno) BOTH copies mint and the two loads sit adjacent: 8 -> 4 @1164,
               residual = exactly ONE SEAT (our z carrier $a1 vs retail $a2).
               The seat fell to a 20B-family clobber on that SAME zero-insn fence:
               `: "a1"` denies $5 to every allocno LIVE AT THAT INSN (22B-1) -- rpz is
               live there -- so find_free_reg walks on to $6 = $a2 = retail's seat.
               MEASURED THIS WAVE (every line a real gate run):
                 K1 alone .......................................... 9 @1163
                 K1 + read-only fence on rpx AFTER the divide ...... 4 @1164
                 same + clobber "a1" ............................... 0 PASS
                 same + clobber "$5" ............................... 0 PASS (identical)
                 fence after the `maxrv = rpz` carrier ............. 10 @1164
                 fence at the end of the statement ................. 10 @1164
                 pair fence "r"(rpx),"r"(rpz) after the divide ..... 10 @1164
                 declaration order z-first ......................... 12 @1164
                 fence on rpx + 20B launder on rpz w/ clobber ...... 15 @1163
                 fence on rpx + separate clobbering fence on rpz ... 10 @1164
               LAW: a pseudo whose ONLY problem is "def and use in the same block" can be
               de-coalesced by ONE zero-insn read-only fence placed past ANY branch the
               source already emits -- a /256, a clamp, a guard.  Look for an existing
               block boundary before concluding a copy is unreachable. */
            /* SYM-CODEGEN-CARRIER: rpx -- allocator proof and alternatives are
               recorded immediately above. */
            /* SYM-CODEGEN-CARRIER: rpz -- paired retail load/copy carrier. */
            int rpx = relativePosition.x, rpz = relativePosition.z;

            maxrp = rpx;
            maxrp /= 256;
            /* MATCH: zero-insn fence in the POST-divide basic block.  It makes rpx
               multi-block so combine_regs cannot fold retail's X copy, and the "a1"
               clobber pushes the live z carrier off $5 onto retail's $a2.  Deleting
               either half costs 4 and 4 diffs respectively. */
            asm volatile("" : : "r"(rpx) : "a1");
            maxrv = rpz;   /* dead maxrv IS retail's z carrier (SYM: maxrv = REG $3) */
            maxrp = maxrp * maxrp + (maxrv / 256) * (maxrv / 256);
            if (maxrp < 0xCCC) {
              int temp;

              temp = Math_VectorLength(&relativeVelocity) / 2;
              inverseRelativeVelocityLength = 0x10000;
              /* MATCH: rdiv arm duplicated inline (cross-jump merges it into the sibling copy,
                 stopping at the inverted branch sense = oracle bnez->1008); m2c's goto block_270
                 is that merge artifact */
              if (temp != 0) {
                inverseRelativeVelocityLength = rdiv(0x8000, temp);
                useVelocity = 1;
              } else {
                useVelocity = 1;
              }
            } else {
              int dot;
              coorddef velocityUnit;
              coorddef positionUnit;

              velocityUnit = relativeVelocity;
              Math_NormalizeVector(&velocityUnit);
              positionUnit = relativePosition;
              Math_NormalizeShortVector(&positionUnit);
              dot = (velocityUnit.x / 256) * (positionUnit.x / 256) +
                    (velocityUnit.y / 256) * (positionUnit.y / 256) +
                    (velocityUnit.z / 256) * (positionUnit.z / 256);
              if (0xD999 < dot) {
                int temp;

                temp = Math_VectorLength(&relativeVelocity) / 2;
                /* MATCH: 0x10000 as the ELSE arm - dbr steals the lui into the beqz delay
                   slot (safe both paths); a pre-set form lets sched hoist it into the CALL
                   slot instead (oracle jal slot = nop) */
                if (temp != 0) {
                  inverseRelativeVelocityLength = rdiv(0x8000, temp);
                } else {
                  inverseRelativeVelocityLength = 0x10000;
                }
                useVelocity = 1;
              }
            }
          }
          if (useVelocity != 0) {
            if (o0->objID >= 0x200) {
              backoff0.x = 0;
              backoff0.y = 0;
              backoff0.z = 0;
            } else {
              backoff0.x = fixedmult(-inverseRelativeVelocityLength,(o0->linearVel).x);
              backoff0.y = fixedmult(-inverseRelativeVelocityLength,(o0->linearVel).y);
              backoff0.z = fixedmult(-inverseRelativeVelocityLength,(o0->linearVel).z);
              backoff0.x = backoff0.x >> 5;
              backoff0.y = backoff0.y >> 5;
              backoff0.z = backoff0.z >> 5;
            }
            if (o1->objID >= 0x200) {
              backoff1.x = 0;
              backoff1.y = 0;
              backoff1.z = 0;
            } else {
              backoff1.x = fixedmult(-inverseRelativeVelocityLength,(o1->linearVel).x);
              backoff1.y = fixedmult(-inverseRelativeVelocityLength,(o1->linearVel).y);
              backoff1.z = fixedmult(-inverseRelativeVelocityLength,(o1->linearVel).z);
              backoff1.x = backoff1.x >> 5;
              backoff1.y = backoff1.y >> 5;
              backoff1.z = backoff1.z >> 5;
            }
          } else {
            int totalMass;
            int r0;
            int r1;

            relativeUnit = relativePosition;
            Math_NormalizeShortVector(&relativeUnit);
            totalMass = o0->mass + o1->mass;
            r1 = rdiv(o0->mass, totalMass);
            r0 = rdiv(o1->mass, totalMass);
            backoff0.x = (-((relativeUnit.x * (r0 / 4)) / 16384)) >> 5;
            backoff0.y = (-((relativeUnit.y * (r0 / 4)) / 16384)) >> 5;
            backoff0.z = (-((relativeUnit.z * (r0 / 4)) / 16384)) >> 5;
            backoff1.x = ((relativeUnit.x * (r1 / 4)) / 16384) >> 5;
            backoff1.y = ((relativeUnit.y * (r1 / 4)) / 16384) >> 5;
            backoff1.z = ((relativeUnit.z * (r1 / 4)) / 16384) >> 5;
            if (o0->objID >= 0x200) {
              backoff1.x = backoff1.x / 2;
              backoff1.y = backoff1.y / 2;
              backoff1.z = backoff1.z / 2;
            }
            if (o1->objID >= 0x200) {
              backoff0.x = backoff0.x / 2;
              backoff0.y = backoff0.y / 2;
              backoff0.z = backoff0.z / 2;
            }
          }
          collisionHappened = 1;
        }
      (o0->position).x = (o0->position).x + backoff0.x;
      (o0->position).y = (o0->position).y + backoff0.y;
      (o0->position).z = (o0->position).z + backoff0.z;
      (o1->position).x = (o1->position).x + backoff1.x;
      (o1->position).y = (o1->position).y + backoff1.y;
      (o1->position).z = (o1->position).z + backoff1.z;
      ctr = ctr + 1;
    }
  }
  return collisionHappened;
}

/* ---- Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0  [@0x80091374] ---- */
int Collide_CheckForCollisionBetween(BO_tNewtonObj *o0,BO_tNewtonObj *o1)



{
  coorddef *new_var;

  int speedThresh;

  int iVar2;

  int iVar3;

  int count;

  coorddef p;

  coorddef normal;



  (o0->collision).impulse = 0;

  (o1->collision).impulse = 0;

  iVar2 = Collide_TestObjectVertices(o0,o1,&p,&normal);

  if (iVar2 == 0) {

    return 0;

  }

  Collide_DoObjectObjectCollision(o0,o1,&p,&normal);

  count = 8;

  Physics_TestForBarrierCollision((Car_tObj *)o0);

  Physics_TestForBarrierCollision((Car_tObj *)o1);

  new_var = &normal;

  speedThresh = 0xf0000;

  while( true ) {

    iVar3 = Collide_TestObjectVertices(o0,o1,&p,new_var);

    if (iVar3 == 0) {

      return 1;

    }

    if (count <= 0) {

      return 1;

    }

    count = count - 1;

    iVar2 = Collide_DoObjectObjectCollision(o0,o1,&p,new_var);

    if (iVar2 == 0) {

      return 1;

    }

    Physics_TestForBarrierCollision((Car_tObj *)o0);

    Physics_TestForBarrierCollision((Car_tObj *)o1);

    if (count == 0) {

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
    relVec.x = InfiniteMassNewton[i].position.x - COLLIDE_SLICE_CENTER0(slice);
    relVec.y = InfiniteMassNewton[i].position.y - COLLIDE_SLICE_CENTER0(slice);
    relVec.z = InfiniteMassNewton[i].position.z - COLLIDE_SLICE_CENTER0(slice);
    rightVec.x = COLLIDE_SLICE_RIGHT(slice,0) * 0x200;
    rightVec.y = COLLIDE_SLICE_RIGHT(slice,1) * 0x200;
    rightVec.z = COLLIDE_SLICE_RIGHT(slice,2) * 0x200;
    InfiniteMassNewton[i].xRelRoadCenter =
        (relVec.x / 256) * (rightVec.x / 256) + (relVec.y / 256) * (rightVec.y / 256) +
        (relVec.z / 256) * (rightVec.z / 256);
  }
  carLoop = 0;
  {
    /* SYM-CODEGEN-CARRIER: n -- the optimized retail bound has no surviving
       debug record. A direct global bound is count-exact but has six register
       diffs; structured while/do/for spellings add 1-4 instructions. Keeping
       this eliminated source snapshot reproduces the exact $a0 bound web. */
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
         the first 12 bytes of objList (wrong struct entirely).
     MATCH (2026-08-13): the retail/SYM statement order initializes closestDist before
     closestPoint.  That deliberately moved the function 39 -> 225 while entering the right
     allocation basin.  allocsim then proved newObj needed +9 refs and the registry index +1;
     the two tail read-only fences implement those exact zero-insn dials, fixing both saved-reg
     webs.  The minImpulse identity fence preserves retail's direct `slt impulse,min` clamp
     (removes the 0x1dffff compare and one instruction).  Result is count-exact 381 and 2 diffs;
     MATCH (W61-A13, 2026-08-15): SEALED 2 -> PASS 381/381 by a PURE SOURCE lever; the
     previously-specified PER_FN_TEXT_MOVES wiring is WITHDRAWN (no longer needed).
     The 2-diff residual was a delay-slot COMPETITION, not a text relocation: `j = 0;` sat
     INSIDE `if (0 < numPoints)`, so the `blez numPoints` slot had no nearby eligible insn and
     reorg's backward scan reached back past both Object_Get*CollisionData calls and stole
     `li $s3,-1` (closestPoint = -1) into the slot -- which simultaneously emptied the oracle's
     slot content AND sank the -1 out of the loop-top group.
     FIX = hoist `j = 0;` ABOVE the guard (`j = 0; if (0 < numPoints) { do {...} while ... }`),
     the natural rotated-for shape.  j=0 is then the NEAREST eligible insn, reorg fills the blez
     slot with it (= oracle), and `li $s3,-1` stays directly after closestDist's `lui $s4,10`.
     FALSIFIED en route: a void-tail scheduling fence __asm__ __volatile__("" : : "i"(0)) after
     the two initializers DOES pin `li $s3,-1` to the oracle position (2 -> 1) but leaves the
     blez slot a bare nop (382/381) -- it blocks the backward scan without supplying the
     oracle's slot insn.  Not retained; the j=0 hoist subsumes it (PASS with the fence removed). */
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
          int closestDist = 0xA0000;
          int closestPoint = -1;
          int numPoints;

          /* MATCH: SYM opens the j block BEFORE the two Get*CollisionData calls (block note =
             scheduling barrier; keeps closestPoint=-1 at loop top, s2/s3 assignment correct) */
          {
            int j;
            numPoints = 1;
            Object_GetRadiusCollisionData(&objList,i,&pos,&fixedRadius);
            Object_GetPointsCollisionData(&objList,i,&numPoints,pointList);
            j = 0;
            if (0 < numPoints) {
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
                /* SYM-CODEGEN-CARRIER: minImpulse -- a literal comparison is
                   canonicalized to 0x1dffff and adds one instruction (7 diffs,
                   382/381); the ternary is count-exact but has 12 diffs. This
                   eliminated threshold quantity preserves retail's direct slt. */
                int minImpulse;

                impulse = newObj->speedXZ;
                minImpulse = 0x1E0000;
                if (impulse < minImpulse) {
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
        __asm__("" : : "r"(i));
        Collide_gNumRegistered = Collide_gNumRegistered + 1;
      }
    }
  }
  __asm__("" : : "r"(newObj), "r"(newObj), "r"(newObj),
                 "r"(newObj), "r"(newObj), "r"(newObj),
                 "r"(newObj), "r"(newObj), "r"(newObj));
  return;
}
